Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA330F800C
	for <lists+linux-integrity@lfdr.de>; Mon, 11 Nov 2019 20:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727698AbfKKTdT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 11 Nov 2019 14:33:19 -0500
Received: from linux.microsoft.com ([13.77.154.182]:44856 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbfKKTdK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 11 Nov 2019 14:33:10 -0500
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2DB7320B4909;
        Mon, 11 Nov 2019 11:33:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2DB7320B4909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1573500790;
        bh=DrDNi/lUCQTgJ3ahGkI5xQC9Mps1amlA8oHCnN6jL4c=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=DhiRu1EFXcbtaM5EqwGDJVV8kVVERME2HVbAdekvBatn6AIhP0S1jT4BDmhCB2+kD
         9XuH7tomPBvGqsHRdK9iSuVL4lSswytmHH5zP4zcOawiIJ3aAZQcNHTGyFVPtOxVfT
         mNRnIsXC/Pw97V8MgcVXQ7eeJ3TLXCsIFZL+h+t0=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com,
        matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 09/10] IMA: Defined functions to queue and dequeue keys for measurement
Date:   Mon, 11 Nov 2019 11:33:02 -0800
Message-Id: <20191111193303.12781-10-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191111193303.12781-1-nramas@linux.microsoft.com>
References: <20191111193303.12781-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

A key can be measured right away only if custom IMA policies
have been applied. Otherwise, the key should be queued up and
processed when custom IMA policies have been applied.

This patch defines functions to queue and dequeue keys for
measurement.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima.h                 |  23 ++++
 security/integrity/ima/ima_asymmetric_keys.c | 128 +++++++++++++++++++
 2 files changed, 151 insertions(+)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index f15199f7ff2a..4e7fed8d224e 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -205,6 +205,29 @@ extern const char *const func_tokens[];
 
 struct modsig;
 
+#ifdef CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS
+/*
+ * To track keys that need to be measured.
+ */
+struct ima_measure_key_entry {
+	struct list_head list;
+	void *public_key;
+	u32  public_key_len;
+	char *keyring_name;
+};
+
+bool ima_queue_key_for_measurement(struct key *keyring,
+				   struct key *key);
+void ima_process_queued_keys_for_measurement(void);
+#else
+static inline bool ima_queue_key_for_measurement(struct key *keyring,
+						 struct key *key)
+{
+	return false;
+}
+static inline void ima_process_queued_keys_for_measurement(void) {}
+#endif /* CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS */
+
 /* LIM API function definitions */
 int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
 		   int mask, enum ima_hooks func, int *pcr,
diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index 61c42d06a636..4a38b4957b8c 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -7,6 +7,7 @@
  * File: ima_asymmetric_keys.c
  *       Defines an IMA hook to measure asymmetric keys on key
  *       create or update.
+ *       Queue and de-queue functions for measuring asymmetric keys.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
@@ -17,6 +18,133 @@
 
 bool ima_process_keys_for_measurement;
 
+/*
+ * To synchronize access to the list of keys that need to be measured
+ */
+static DEFINE_MUTEX(ima_measure_keys_mutex);
+static LIST_HEAD(ima_measure_keys);
+
+static void ima_free_measure_key_entry(struct ima_measure_key_entry *entry)
+{
+	if (entry != NULL) {
+		if (entry->public_key != NULL)
+			kzfree(entry->public_key);
+		if (entry->keyring_name != NULL)
+			kzfree(entry->keyring_name);
+		kzfree(entry);
+	}
+}
+
+static struct ima_measure_key_entry *ima_alloc_measure_key_entry(
+	struct key *keyring,
+	struct key *key)
+{
+	int rc = 0;
+	const struct public_key *pk;
+	size_t keyring_name_len;
+	struct ima_measure_key_entry *entry = NULL;
+
+	pk = key->payload.data[asym_crypto];
+	keyring_name_len = strlen(keyring->description) + 1;
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (entry != NULL) {
+		entry->public_key = kzalloc(pk->keylen, GFP_KERNEL);
+		entry->keyring_name =
+			kzalloc(keyring_name_len, GFP_KERNEL);
+	}
+
+	if ((entry == NULL) || (entry->public_key == NULL) ||
+	    (entry->keyring_name == NULL)) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	strcpy(entry->keyring_name, keyring->description);
+	memcpy(entry->public_key, pk->key, pk->keylen);
+	entry->public_key_len = pk->keylen;
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
+				   struct key *key)
+{
+	bool queued = false;
+	struct ima_measure_key_entry *entry = NULL;
+
+	/*
+	 * ima_measure_keys_mutex should be taken before checking
+	 * ima_process_keys_for_measurement flag to avoid the race
+	 * condition between the IMA hook checking this flag and
+	 * calling ima_queue_key_for_measurement() to queue the key and
+	 * ima_process_queued_keys_for_measurement() setting this flag.
+	 */
+	mutex_lock(&ima_measure_keys_mutex);
+
+	if (!ima_process_keys_for_measurement) {
+		entry = ima_alloc_measure_key_entry(keyring, key);
+		if (entry != NULL) {
+			INIT_LIST_HEAD(&entry->list);
+			list_add_tail(&entry->list, &ima_measure_keys);
+			queued = true;
+		}
+	}
+
+	mutex_unlock(&ima_measure_keys_mutex);
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
+		list_del(&entry->list);
+		list_add_tail(&entry->list, &temp_ima_measure_keys);
+	}
+	mutex_unlock(&ima_measure_keys_mutex);
+
+	list_for_each_entry_safe(entry, tmp,
+				 &temp_ima_measure_keys, list) {
+		process_buffer_measurement(entry->public_key,
+					   entry->public_key_len,
+					   entry->keyring_name,
+					   KEYRING_CHECK, 0,
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

