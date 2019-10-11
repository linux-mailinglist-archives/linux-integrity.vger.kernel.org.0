Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F519D46B8
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Oct 2019 19:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbfJKRfy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Oct 2019 13:35:54 -0400
Received: from linux.microsoft.com ([13.77.154.182]:53904 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728707AbfJKRfy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Oct 2019 13:35:54 -0400
Received: from nramas-ThinkStation-P520.corp.microsoft.com (unknown [131.107.147.154])
        by linux.microsoft.com (Postfix) with ESMTPSA id 256D320B7116;
        Fri, 11 Oct 2019 10:35:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 256D320B7116
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1570815352;
        bh=kmx2GF0QcO6nLD4ICAjBZ6ex4bB+NyDztRHzFzqLM18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IJT+bIAD5R+90xwpH4aMZBz6P2dPwfE1T32yKlQ+UXynOqUwWWnOHSwNAuaF2sFdQ
         adxUfFhuumZNS76AvvlOTjqNeIU8JljaiOF2qBfd+FhNgvgdoK+pVCqm4fInyJa9Ib
         qhhUCfI4fLNdK/586goymmTYwwOBefIbci3tzLcM=
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        kgoldman@us.ibm.com, mjg59@google.com, dhowells@redhat.com
Cc:     balajib@linux.microsoft.com, prsriva@linux.microsoft.com,
        jorhand@linux.microsoft.com, patatash@linux.microsoft.com
Subject: [PATCH v0 1/2] KEYS: Measure keys added to builtin or secondary trusted keys keyring
Date:   Fri, 11 Oct 2019 10:35:46 -0700
Message-Id: <20191011173547.3200-2-nramas@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011173547.3200-1-nramas@linux.microsoft.com>
References: <20191011173547.3200-1-nramas@linux.microsoft.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

IMA hook TRUSTED_KEYS to measure keys added to builtin or secondary
trusted keys keyring. This can be enabled through IMA policy.

The key data is queued up if IMA is not yet initialized and measured
when IMA is initialized. If IMA is initialized then the key is
measured immediately.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 Documentation/ABI/testing/ima_policy |   1 +
 include/linux/ima.h                  |  10 ++
 security/integrity/ima/ima.h         |  14 ++
 security/integrity/ima/ima_api.c     |   2 +-
 security/integrity/ima/ima_init.c    |  11 +-
 security/integrity/ima/ima_main.c    | 230 ++++++++++++++++++++++-----
 security/integrity/ima/ima_policy.c  |   4 +-
 7 files changed, 226 insertions(+), 46 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index fc376a323908..cc25c0f41d6e 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -29,6 +29,7 @@ Description:
 				[FIRMWARE_CHECK]
 				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
 				[KEXEC_CMDLINE]
+				[TRUSTED_KEYS]
 			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
 			       [[^]MAY_EXEC]
 			fsmagic:= hex value
diff --git a/include/linux/ima.h b/include/linux/ima.h
index a20ad398d260..eb95743ada7d 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -25,6 +25,9 @@ extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 extern void ima_post_path_mknod(struct dentry *dentry);
 extern void ima_kexec_cmdline(const void *buf, int size);
 
+extern int ima_post_key_create_or_update(struct key *keyring,
+					 struct key *key,
+					 bool builtin_or_secondary);
 #ifdef CONFIG_IMA_KEXEC
 extern void ima_add_kexec_buffer(struct kimage *image);
 #endif
@@ -91,6 +94,13 @@ static inline void ima_post_path_mknod(struct dentry *dentry)
 }
 
 static inline void ima_kexec_cmdline(const void *buf, int size) {}
+
+static inline int ima_post_key_create_or_update(struct key *keyring,
+						struct key *key,
+						bool builtin_or_secondary)
+{
+	return 0;
+}
 #endif /* CONFIG_IMA */
 
 #ifndef CONFIG_IMA_KEXEC
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 011b91c79351..f0c1801da890 100644
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
@@ -104,6 +106,16 @@ struct ima_queue_entry {
 };
 extern struct list_head ima_measurements;	/* list of all measurements */
 
+/*
+ * To track trusted keys that need to be measured when IMA is initialized.
+ */
+struct ima_trusted_key_entry {
+	struct list_head list;
+	void *public_key;
+	u32  public_key_len;
+	char *key_description;
+};
+
 /* Some details preceding the binary serialized measurement list */
 struct ima_kexec_hdr {
 	u16 version;
@@ -158,6 +170,7 @@ void ima_init_template_list(void);
 int __init ima_init_digests(void);
 int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
 			  void *lsm_data);
+void ima_measure_queued_trusted_keys(void);
 
 /*
  * used to protect h_table and sha_table
@@ -189,6 +202,7 @@ static inline unsigned long ima_hash_key(u8 *digest)
 	hook(KEXEC_INITRAMFS_CHECK)	\
 	hook(POLICY_CHECK)		\
 	hook(KEXEC_CMDLINE)		\
+	hook(TRUSTED_KEYS)		\
 	hook(MAX_CHECK)
 #define __ima_hook_enumify(ENUM)	ENUM,
 
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index f614e22bf39f..704a048ff925 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -174,7 +174,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  *		subj=, obj=, type=, func=, mask=, fsmagic=
  *	subj,obj, and type: are LSM specific.
  *	func: FILE_CHECK | BPRM_CHECK | CREDS_CHECK | MMAP_CHECK | MODULE_CHECK
- *	| KEXEC_CMDLINE
+ *	| KEXEC_CMDLINE | TRUSTED_KEYS
  *	mask: contains the permission mask
  *	fsmagic: hex value
  *
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
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 584019728660..b0ee5c82207a 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -27,6 +27,7 @@
 #include <linux/ima.h>
 #include <linux/iversion.h>
 #include <linux/fs.h>
+#include <crypto/public_key.h>
 
 #include "ima.h"
 
@@ -43,6 +44,13 @@ static struct notifier_block ima_lsm_policy_notifier = {
 	.notifier_call = ima_lsm_policy_change,
 };
 
+/*
+ * Used to synchronize access to the list of trusted keys (ima_trusted_keys)
+ * that need to be measured when IMA is initialized.
+ */
+static DEFINE_MUTEX(ima_trusted_keys_mutex);
+static LIST_HEAD(ima_trusted_keys);
+
 static int __init hash_setup(char *str)
 {
 	struct ima_template_desc *template_desc = ima_template_desc_current();
@@ -351,6 +359,65 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	return 0;
 }
 
+
+/*
+ * process_buffer_measurement - Measure the buffer to ima log.
+ * @buf: pointer to the buffer that needs to be added to the log.
+ * @size: size of buffer(in bytes).
+ * @eventname: event name to be used for the buffer entry.
+ * @func: IMA Hook function
+ * @cred: a pointer to a credentials structure for user validation.
+ * @secid: the secid of the task to be validated.
+ *
+ * Based on policy, the buffer is measured into the ima log.
+ */
+static void process_buffer_measurement(const void *buf, u32 size,
+				       const char *eventname,
+				       enum ima_hooks func,
+				       const struct cred *cred, u32 secid)
+{
+	int ret = 0;
+	struct ima_template_entry *entry = NULL;
+	struct integrity_iint_cache iint = {};
+	struct ima_event_data event_data = {.iint = &iint,
+					    .filename = eventname,
+					    .buf = buf,
+					    .buf_len = size};
+	struct ima_template_desc *template_desc = ima_template_desc_current();
+	struct {
+		struct ima_digest_data hdr;
+		char digest[IMA_MAX_DIGEST_SIZE];
+	} hash = {};
+	int violation = 0;
+	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
+	int action = 0;
+
+	action = ima_get_action(NULL, cred, secid, 0, func, &pcr,
+				&template_desc);
+	if (!(action & IMA_MEASURE))
+		return;
+
+	iint.ima_hash = &hash.hdr;
+	iint.ima_hash->algo = ima_hash_algo;
+	iint.ima_hash->length = hash_digest_size[ima_hash_algo];
+
+	ret = ima_calc_buffer_hash(buf, size, iint.ima_hash);
+	if (ret < 0)
+		goto out;
+
+	ret = ima_alloc_init_template(&event_data, &entry, template_desc);
+	if (ret < 0)
+		goto out;
+
+	ret = ima_store_template(entry, violation, NULL, buf, pcr);
+
+	if (ret < 0)
+		ima_free_template_entry(entry);
+
+out:
+	return;
+}
+
 /**
  * ima_file_mmap - based on policy, collect/store measurement.
  * @file: pointer to the file to be measured (May be NULL)
@@ -605,60 +672,136 @@ int ima_load_data(enum kernel_load_data_id id)
 	return 0;
 }
 
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
+	struct key *key)
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
 /*
- * process_buffer_measurement - Measure the buffer to ima log.
- * @buf: pointer to the buffer that needs to be added to the log.
- * @size: size of buffer(in bytes).
- * @eventname: event name to be used for the buffer entry.
- * @cred: a pointer to a credentials structure for user validation.
- * @secid: the secid of the task to be validated.
+ * ima_post_key_create_or_update
+ *     @keyring points to the keyring to which the key belongs
+ *     @key points to the key being created or updated
+ *     @builtin_or_secondary flag indicating whether
+ *     the keyring to which the key belongs is the builtin
+ *     or secondary trusted keys keyring
+ * Measure keys added to the builtin or secondary trusted keyring
  *
- * Based on policy, the buffer is measured into the ima log.
+ * On success return 0.
+ * Return appropriate error code on error
  */
-static void process_buffer_measurement(const void *buf, int size,
-				       const char *eventname,
-				       const struct cred *cred, u32 secid)
+int ima_post_key_create_or_update(struct key *keyring,
+				  struct key *key,
+				  bool builtin_or_secondary)
 {
-	int ret = 0;
-	struct ima_template_entry *entry = NULL;
-	struct integrity_iint_cache iint = {};
-	struct ima_event_data event_data = {.iint = &iint,
-					    .filename = eventname,
-					    .buf = buf,
-					    .buf_len = size};
-	struct ima_template_desc *template_desc = NULL;
-	struct {
-		struct ima_digest_data hdr;
-		char digest[IMA_MAX_DIGEST_SIZE];
-	} hash = {};
-	int violation = 0;
-	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
-	int action = 0;
+	int rc = 0;
+	struct ima_trusted_key_entry *entry = NULL;
+	const struct public_key *pk;
+	u32 secid;
+	bool queued = false;
 
-	action = ima_get_action(NULL, cred, secid, 0, KEXEC_CMDLINE, &pcr,
-				&template_desc);
-	if (!(action & IMA_MEASURE))
-		return;
+	/*
+	 * We only measure asymmetric keys added to either
+	 * the builtin or the secondary trusted keys keyring.
+	 */
+	if (!builtin_or_secondary ||
+	    (key->type != &key_type_asymmetric))
+		return 0;
 
-	iint.ima_hash = &hash.hdr;
-	iint.ima_hash->algo = ima_hash_algo;
-	iint.ima_hash->length = hash_digest_size[ima_hash_algo];
+	mutex_lock(&ima_trusted_keys_mutex);
 
-	ret = ima_calc_buffer_hash(buf, size, iint.ima_hash);
-	if (ret < 0)
-		goto out;
+	if (!ima_initialized) {
+		entry = ima_alloc_trusted_queue_entry(key);
+		if (entry != NULL) {
+			INIT_LIST_HEAD(&entry->list);
+			list_add_tail(&entry->list, &ima_trusted_keys);
+			queued = true;
+		} else
+			rc = -ENOMEM;
+	}
 
-	ret = ima_alloc_init_template(&event_data, &entry, template_desc);
-	if (ret < 0)
-		goto out;
+	mutex_unlock(&ima_trusted_keys_mutex);
 
-	ret = ima_store_template(entry, violation, NULL, buf, pcr);
+	if ((rc == 0) && !queued) {
+		security_task_getsecid(current, &secid);
+		pk = key->payload.data[asym_crypto];
+		process_buffer_measurement(pk->key, pk->keylen,
+					   key->description,
+					   TRUSTED_KEYS,
+					   current_cred(), secid);
+	}
 
-	if (ret < 0)
-		ima_free_template_entry(entry);
+	return rc;
+}
 
-out:
-	return;
+void ima_measure_queued_trusted_keys(void)
+{
+	struct ima_trusted_key_entry *entry, *tmp;
+	u32 secid;
+
+	mutex_lock(&ima_trusted_keys_mutex);
+
+	security_task_getsecid(current, &secid);
+	list_for_each_entry_safe(entry, tmp, &ima_trusted_keys, list) {
+		if ((entry != NULL) &&
+		    (entry->public_key != NULL) &&
+		    (entry->key_description != NULL)) {
+
+			process_buffer_measurement(entry->public_key,
+						   entry->public_key_len,
+						   entry->key_description,
+						   TRUSTED_KEYS,
+						   current_cred(),
+						   secid);
+		}
+
+		list_del(&entry->list);
+		ima_free_trusted_key_entry(entry);
+	}
+
+	mutex_unlock(&ima_trusted_keys_mutex);
 }
 
 /**
@@ -675,6 +818,7 @@ void ima_kexec_cmdline(const void *buf, int size)
 	if (buf && size != 0) {
 		security_task_getsecid(current, &secid);
 		process_buffer_measurement(buf, size, "kexec-cmdline",
+					   KEXEC_CMDLINE,
 					   current_cred(), secid);
 	}
 }
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 6df7f641ff66..1752f7bd1717 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -370,7 +370,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule, struct inode *inode,
 {
 	int i;
 
-	if (func == KEXEC_CMDLINE) {
+	if ((func == KEXEC_CMDLINE) || (func == TRUSTED_KEYS)) {
 		if ((rule->flags & IMA_FUNC) && (rule->func == func))
 			return true;
 		return false;
@@ -959,6 +959,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 				entry->func = POLICY_CHECK;
 			else if (strcmp(args[0].from, "KEXEC_CMDLINE") == 0)
 				entry->func = KEXEC_CMDLINE;
+			else if (strcmp(args[0].from, "TRUSTED_KEYS") == 0)
+				entry->func = TRUSTED_KEYS;
 			else
 				result = -EINVAL;
 			if (!result)
-- 
2.17.1

