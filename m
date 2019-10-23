Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10BE6E0F09
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Oct 2019 02:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732384AbfJWAS0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Oct 2019 20:18:26 -0400
Received: from linux.microsoft.com ([13.77.154.182]:45286 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732229AbfJWASZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Oct 2019 20:18:25 -0400
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id C1AEE2010AC6;
        Tue, 22 Oct 2019 17:18:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C1AEE2010AC6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1571789904;
        bh=3EEDwTWXlit7lCdzWaSZuvopxoV1OJ3w7wj1bKW7mGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fCvq9SD+Gw3CmY/a9mWTsF8csnkUdjg9+cJSNEbSLuHnfd2f0J+x1CSzcSQtQchdX
         LvwX4jJDS8W19f6E0yq8crBIim2Jo27zlfzJaGloQGtvBjP3Bm2an1wOHpWfnO5xdB
         ymFlHTDtuCS56mtCOSoQDpwqGxr7EGonKHTXvPJk=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, dhowells@redhat.com, casey@schaufler-ca.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Cc:     nramas@linux.microsoft.com
Subject: [PATCH v1 4/6] KEYS: ima functions to queue and dequeue keys to measure
Date:   Tue, 22 Oct 2019 17:18:16 -0700
Message-Id: <20191023001818.3684-5-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191023001818.3684-1-nramas@linux.microsoft.com>
References: <20191023001818.3684-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Implement functions to queue a key for measurement if ima is not yet
initialized. And, when ima initialization is complete, process
any queued key measurement requests.

This change set implements the functions to queue and de-queue requests.
The change to actually measure the keys is in another patch.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima.h       |  15 ++++
 security/integrity/ima/ima_init.c  |  11 ++-
 security/integrity/ima/ima_queue.c | 128 +++++++++++++++++++++++++++++
 3 files changed, 153 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 0d2908036882..7e4d4169798d 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -21,6 +21,7 @@
 #include <linux/tpm.h>
 #include <linux/audit.h>
 #include <crypto/hash_info.h>
+#include <keys/asymmetric-type.h>
 
 #include "../integrity.h"
 
@@ -52,6 +53,7 @@ extern int ima_policy_flag;
 extern int ima_hash_algo;
 extern int ima_appraise;
 extern struct tpm_chip *ima_tpm_chip;
+extern bool ima_initialized;
 
 /* IMA event related data */
 struct ima_event_data {
@@ -158,6 +160,8 @@ void ima_init_template_list(void);
 int __init ima_init_digests(void);
 int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
 			  void *lsm_data);
+int ima_measure_key(struct key *keyring, struct key *key);
+void ima_measure_queued_trusted_keys(void);
 
 /*
  * used to protect h_table and sha_table
@@ -197,6 +201,17 @@ enum ima_hooks {
 	__ima_hooks(__ima_hook_enumify)
 };
 
+/*
+ * To track trusted keys that need to be measured when IMA is initialized.
+ */
+struct ima_trusted_key_entry {
+	struct list_head list;
+	void *public_key;
+	u32  public_key_len;
+	char *key_description;
+	enum ima_hooks func;
+};
+
 /* LIM API function definitions */
 int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
 		   int mask, enum ima_hooks func, int *pcr,
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 5d55ade5f3b9..32b9147fe410 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -23,6 +23,7 @@
 /* name for boot aggregate entry */
 static const char boot_aggregate_name[] = "boot_aggregate";
 struct tpm_chip *ima_tpm_chip;
+bool ima_initialized;
 
 /* Add the boot aggregate to the IMA measurement list and extend
  * the PCR register.
@@ -131,5 +132,13 @@ int __init ima_init(void)
 
 	ima_init_policy();
 
-	return ima_fs_init();
+	rc = ima_fs_init();
+	if (rc != 0)
+		return rc;
+
+	ima_initialized = true;
+
+	ima_measure_queued_trusted_keys();
+
+	return 0;
 }
diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
index 1ce8b1701566..a262e289615b 100644
--- a/security/integrity/ima/ima_queue.c
+++ b/security/integrity/ima/ima_queue.c
@@ -19,6 +19,8 @@
 
 #include <linux/rculist.h>
 #include <linux/slab.h>
+#include <crypto/public_key.h>
+#include <keys/system_keyring.h>
 #include "ima.h"
 
 #define AUDIT_CAUSE_LEN_MAX 32
@@ -46,6 +48,13 @@ struct ima_h_table ima_htable = {
  */
 static DEFINE_MUTEX(ima_extend_list_mutex);
 
+/*
+ * Used to synchronize access to the list of trusted keys (ima_trusted_keys)
+ * that need to be measured when IMA is initialized.
+ */
+static DEFINE_MUTEX(ima_trusted_keys_mutex);
+static LIST_HEAD(ima_trusted_keys);
+
 /* lookup up the digest value in the hash table, and return the entry */
 static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
 						       int pcr)
@@ -232,3 +241,122 @@ int __init ima_init_digests(void)
 
 	return 0;
 }
+
+/*
+ * Maps the given keyring to a IMA Hook.
+ * @keyring: A keyring to which a key maybe linked to.
+ *
+ * This function currently handles only builtin_trusted_keys.
+ * To handle more keyrings, this function, ima hook and
+ * ima policy handler need to be updated.
+ */
+static enum ima_hooks keyring_policy_map(struct key *keyring)
+{
+	enum ima_hooks func = NONE;
+
+	if (is_builtin_trusted_keyring(keyring))
+		func = BUILTIN_TRUSTED_KEYS;
+
+	return func;
+}
+
+static void ima_free_trusted_key_entry(struct ima_trusted_key_entry *entry)
+{
+	if (entry != NULL) {
+		if (entry->public_key != NULL)
+			kzfree(entry->public_key);
+		if (entry->key_description != NULL)
+			kzfree(entry->key_description);
+		kzfree(entry);
+	}
+}
+
+static struct ima_trusted_key_entry *ima_alloc_trusted_queue_entry(
+	struct key *key,
+	enum ima_hooks func)
+{
+	int rc = 0;
+	const struct public_key *pk;
+	size_t key_description_len;
+	struct ima_trusted_key_entry *entry = NULL;
+
+	pk = key->payload.data[asym_crypto];
+	key_description_len = strlen(key->description) + 1;
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (entry != NULL) {
+		entry->public_key = kzalloc(pk->keylen, GFP_KERNEL);
+		entry->key_description =
+			kzalloc(key_description_len, GFP_KERNEL);
+	}
+
+	if ((entry == NULL) || (entry->public_key == NULL) ||
+	    (entry->key_description == NULL)) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	strcpy(entry->key_description, key->description);
+	memcpy(entry->public_key, pk->key, pk->keylen);
+	entry->public_key_len = pk->keylen;
+	entry->func = func;
+	rc = 0;
+
+out:
+	if (rc) {
+		ima_free_trusted_key_entry(entry);
+		entry = NULL;
+	}
+
+	return entry;
+}
+
+/*
+ * ima_measure_key
+ *     @keyring the keyring to which the key is linked to.
+ *     @key the key being created or updated
+ * Measure keys created or updated in the system
+ *
+ * On success return 0.
+ * Return appropriate error code on error
+ */
+int ima_measure_key(struct key *keyring, struct key *key)
+{
+	int rc = 0;
+	struct ima_trusted_key_entry *entry = NULL;
+	enum ima_hooks func;
+	bool queued = false;
+
+	func = keyring_policy_map(keyring);
+	if (func == NONE)
+		return 0;
+
+	mutex_lock(&ima_trusted_keys_mutex);
+
+	if (!ima_initialized) {
+		entry = ima_alloc_trusted_queue_entry(key, func);
+		if (entry != NULL) {
+			INIT_LIST_HEAD(&entry->list);
+			list_add_tail(&entry->list, &ima_trusted_keys);
+			queued = true;
+		} else
+			rc = -ENOMEM;
+	}
+
+	mutex_unlock(&ima_trusted_keys_mutex);
+
+	return rc;
+}
+
+void ima_measure_queued_trusted_keys(void)
+{
+	struct ima_trusted_key_entry *entry, *tmp;
+
+	mutex_lock(&ima_trusted_keys_mutex);
+
+	list_for_each_entry_safe(entry, tmp, &ima_trusted_keys, list) {
+		list_del(&entry->list);
+		ima_free_trusted_key_entry(entry);
+	}
+
+	mutex_unlock(&ima_trusted_keys_mutex);
+}
-- 
2.17.1

