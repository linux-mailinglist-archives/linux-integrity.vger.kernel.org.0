Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A43D410A8E5
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Nov 2019 03:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfK0CwU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 Nov 2019 21:52:20 -0500
Received: from linux.microsoft.com ([13.77.154.182]:46232 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfK0CwU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Nov 2019 21:52:20 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 41D1E2010BBA;
        Tue, 26 Nov 2019 18:52:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 41D1E2010BBA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1574823138;
        bh=Njlyom8dEHkAq5p6o4D0l9jqkVQlZiCeeiCZX15aK4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A5OruT2hwpKoJaqv8JlQ2/+iATpoIxKkMW0Mpz5fAAS7TzbxAfUhOR/u84Jq3g8LH
         zY1+5uS3VnasJpIW0IrF+N/y3FKgjiC0Lam1ymjA+r6QDI2ad67/3en+16xkdTMY1W
         3/9Csv2dhBAQNc4DXzcTKIRjoQ6P3BfAuDvuGIGk=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Subject: [PATCH v0 1/2] IMA: Defined queue functions
Date:   Tue, 26 Nov 2019 18:52:11 -0800
Message-Id: <20191127025212.3077-2-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191127025212.3077-1-nramas@linux.microsoft.com>
References: <20191127025212.3077-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Keys created or updated in the system before IMA is initialized
should be queued up. And, keys (including any queued ones)
should be processed when IMA initialization is completed.

This patch defines functions to queue and dequeue keys for
measurement. A flag namely ima_process_keys_for_measurement
is used to check if the key should be queued or should be
processed immediately.

ima_policy_flag cannot be relied upon to make queuing decision
because ima_policy_flag will be set to 0 when either IMA is
not initialized or when the IMA policy itself is empty.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima.h                 |  15 +++
 security/integrity/ima/ima_asymmetric_keys.c | 135 ++++++++++++++++++-
 2 files changed, 146 insertions(+), 4 deletions(-)

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
index ca895f9a6504..10deb77b22a0 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -14,12 +14,139 @@
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
+	struct ima_measure_key_entry *entry = NULL;
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (entry) {
+		entry->payload =
+			kmemdup(payload, payload_len, GFP_KERNEL);
+		entry->keyring_name =
+			kstrdup(keyring->description, GFP_KERNEL);
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
+	rc = 0;
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
+	struct ima_measure_key_entry *entry = NULL;
+
+	entry = ima_alloc_measure_key_entry(keyring, payload, payload_len);
+	if (entry) {
+		/*
+		 * ima_measure_keys_mutex should be taken before checking
+		 * ima_process_keys_for_measurement flag to avoid the race
+		 * condition between the IMA hook checking this flag and
+		 * calling ima_queue_key_for_measurement() to queue
+		 * the key and ima_process_queued_keys_for_measurement()
+		 * setting this flag.
+		 */
+		mutex_lock(&ima_measure_keys_mutex);
+		if (!ima_process_keys_for_measurement) {
+			list_add_tail(&entry->list, &ima_measure_keys);
+			queued = true;
+		}
+		mutex_unlock(&ima_measure_keys_mutex);
+
+		if (!queued)
+			ima_free_measure_key_entry(entry);
+	}
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
+	mutex_lock(&ima_measure_keys_mutex);
+	list_for_each_entry_safe(entry, tmp, &ima_measure_keys, list) {
+		list_move_tail(&entry->list, &temp_ima_measure_keys);
+	}
+	mutex_unlock(&ima_measure_keys_mutex);
+
+	list_for_each_entry_safe(entry, tmp,
+				 &temp_ima_measure_keys, list) {
+		process_buffer_measurement(entry->payload,
+					   entry->payload_len,
+					   entry->keyring_name,
+					   KEY_CHECK, 0,
+					   entry->keyring_name);
+		list_del(&entry->list);
+		ima_free_measure_key_entry(entry);
+	}
+}
+
 /**
  * ima_post_key_create_or_update - measure asymmetric keys
  * @keyring: keyring to which the key is linked to
  * @key: created or updated key
  * @payload: The data used to instantiate or update the key.
- * @plen: The length of @payload.
+ * @payload_len: The length of @payload.
  * @flags: key flags
  * @create: flag indicating whether the key was created or updated
  *
@@ -27,14 +154,14 @@
  * The payload data used to instantiate or update the key is measured.
  */
 void ima_post_key_create_or_update(struct key *keyring, struct key *key,
-				   const void *payload, size_t plen,
+				   const void *payload, size_t payload_len,
 				   unsigned long flags, bool create)
 {
 	/* Only asymmetric keys are handled by this hook. */
 	if (key->type != &key_type_asymmetric)
 		return;
 
-	if (!payload || (plen == 0))
+	if (!payload || (payload_len == 0))
 		return;
 
 	/*
@@ -52,7 +179,7 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 	 * if the IMA policy is configured to measure a key linked
 	 * to the given keyring.
 	 */
-	process_buffer_measurement(payload, plen,
+	process_buffer_measurement(payload, payload_len,
 				   keyring->description, KEY_CHECK, 0,
 				   keyring->description);
 }
-- 
2.17.1

