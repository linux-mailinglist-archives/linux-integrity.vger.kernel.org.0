Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5973C114A7B
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Dec 2019 02:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbfLFB3q (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 Dec 2019 20:29:46 -0500
Received: from linux.microsoft.com ([13.77.154.182]:47354 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfLFB3o (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Dec 2019 20:29:44 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2542520B4760;
        Thu,  5 Dec 2019 17:29:42 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2542520B4760
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1575595782;
        bh=zavtAVUb8jhlEWuhuT292HazV3lrluxzOQcYA1RMySg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AWm/FWPM0fIdISo3LCJ5KAUtRE4hzGPpGIWZePMVPi5x43RfcZGnBdM8qInoL52VQ
         6W0oGVzdP9vlwhqUWxzG1yzBf45lX0dynUAEkWKuYwn1LSfcm27XJlLN0W/YStJga/
         s8sVhoZARbnpd/C9TzuEuojdIdaMiyRBOLz5hGOA=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Subject: [PATCH v1 1/2] IMA: Define workqueue for early boot "key" measurements
Date:   Thu,  5 Dec 2019 17:29:35 -0800
Message-Id: <20191206012936.2814-2-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191206012936.2814-1-nramas@linux.microsoft.com>
References: <20191206012936.2814-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Measuring keys requires a custom IMA policy to be loaded.
Keys created or updated before a custom IMA policy is loaded should
be queued and the keys should be processed after a custom policy
is loaded.

This patch defines workqueue for queuing keys when a custom IMA policy
has not yet been loaded.

A flag namely ima_process_keys_for_measurement is used to check
if the key should be queued or should be processed immediately.
This flag is set to true when queued keys are processed.
If this flag is set to true, keys created or updated
will be measured immediately (not queued).

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima.h                 |  15 +++
 security/integrity/ima/ima_asymmetric_keys.c | 125 +++++++++++++++++++
 2 files changed, 140 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index f06238e41a7c..f86371647707 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -205,6 +205,21 @@ extern const char *const func_tokens[];
 
 struct modsig;
 
+#ifdef CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE
+/*
+ * To track keys that need to be measured.
+ */
+struct ima_measure_key_entry {
+	struct list_head list;
+	void *payload;
+	size_t payload_len;
+	char *keyring_name;
+};
+void ima_process_queued_keys_for_measurement(void);
+#else
+static inline void ima_process_queued_keys_for_measurement(void) {}
+#endif /* CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE */
+
 /* LIM API function definitions */
 int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
 		   int mask, enum ima_hooks func, int *pcr,
diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index fea2e7dd3b09..fbdbe9c261cb 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -14,6 +14,131 @@
 #include <keys/asymmetric-type.h>
 #include "ima.h"
 
+/*
+ * Flag to indicate whether a key can be processed
+ * right away or should be queued for processing later.
+ */
+bool ima_process_keys_for_measurement;
+
+/*
+ * To synchronize access to the list of keys that need to be measured
+ */
+static DEFINE_MUTEX(ima_measure_keys_mutex);
+static LIST_HEAD(ima_measure_keys);
+
+static void ima_free_measure_key_entry(struct ima_measure_key_entry *entry)
+{
+	if (entry) {
+		kfree(entry->payload);
+		kfree(entry->keyring_name);
+		kfree(entry);
+	}
+}
+
+static struct ima_measure_key_entry *ima_alloc_measure_key_entry(
+	struct key *keyring,
+	const void *payload, size_t payload_len)
+{
+	int rc = 0;
+	struct ima_measure_key_entry *entry;
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (entry) {
+		entry->payload = kmemdup(payload, payload_len, GFP_KERNEL);
+		entry->keyring_name = kstrdup(keyring->description,
+					      GFP_KERNEL);
+		entry->payload_len = payload_len;
+	}
+
+	if ((entry == NULL) || (entry->payload == NULL) ||
+	    (entry->keyring_name == NULL)) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	INIT_LIST_HEAD(&entry->list);
+
+out:
+	if (rc) {
+		ima_free_measure_key_entry(entry);
+		entry = NULL;
+	}
+
+	return entry;
+}
+
+bool ima_queue_key_for_measurement(struct key *keyring,
+				   const void *payload, size_t payload_len)
+{
+	bool queued = false;
+	struct ima_measure_key_entry *entry;
+
+	entry = ima_alloc_measure_key_entry(keyring, payload, payload_len);
+	if (!entry)
+		return false;
+
+	/*
+	 * ima_measure_keys_mutex should be taken before checking
+	 * ima_process_keys_for_measurement flag to avoid the race
+	 * condition between the IMA hook checking this flag and
+	 * calling ima_queue_key_for_measurement() to queue
+	 * the key and ima_process_queued_keys_for_measurement()
+	 * setting this flag.
+	 */
+	mutex_lock(&ima_measure_keys_mutex);
+	if (!ima_process_keys_for_measurement) {
+		list_add_tail(&entry->list, &ima_measure_keys);
+		queued = true;
+	}
+	mutex_unlock(&ima_measure_keys_mutex);
+
+	if (!queued)
+		ima_free_measure_key_entry(entry);
+
+	return queued;
+}
+
+void ima_process_queued_keys_for_measurement(void)
+{
+	struct ima_measure_key_entry *entry, *tmp;
+	LIST_HEAD(temp_ima_measure_keys);
+
+	if (ima_process_keys_for_measurement)
+		return;
+
+	/*
+	 * Any queued keys will be processed now. From here on
+	 * keys should be processed right away.
+	 */
+	ima_process_keys_for_measurement = true;
+
+	/*
+	 * To avoid holding the mutex when processing queued keys,
+	 * transfer the queued keys with the mutex held to a temp list,
+	 * release the mutex, and then process the queued keys from
+	 * the temp list.
+	 *
+	 * Since ima_process_keys_for_measurement is set to true above,
+	 * any new key will be processed immediately and not be queued.
+	 */
+	INIT_LIST_HEAD(&temp_ima_measure_keys);
+
+	mutex_lock(&ima_measure_keys_mutex);
+
+	list_for_each_entry_safe(entry, tmp, &ima_measure_keys, list)
+		list_move_tail(&entry->list, &temp_ima_measure_keys);
+
+	mutex_unlock(&ima_measure_keys_mutex);
+
+	list_for_each_entry_safe(entry, tmp, &temp_ima_measure_keys, list) {
+		process_buffer_measurement(entry->payload, entry->payload_len,
+					   entry->keyring_name, KEY_CHECK, 0,
+					   entry->keyring_name);
+		list_del(&entry->list);
+		ima_free_measure_key_entry(entry);
+	}
+}
+
 /**
  * ima_post_key_create_or_update - measure asymmetric keys
  * @keyring: keyring to which the key is linked to
-- 
2.17.1

