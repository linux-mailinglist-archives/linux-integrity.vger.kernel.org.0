Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7881D3B84E4
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Jun 2021 16:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbhF3OTY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Jun 2021 10:19:24 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3334 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234996AbhF3OTW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Jun 2021 10:19:22 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GFNW52ZFXz6H6ml;
        Wed, 30 Jun 2021 22:09:05 +0800 (CST)
Received: from roberto-ThinkStation-P620.huawei.com (10.204.63.22) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 30 Jun 2021 16:16:50 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     <zohar@linux.ibm.com>, <paul@paul-moore.com>
CC:     <stephen.smalley.work@gmail.com>, <prsriva02@gmail.com>,
        <tusharsu@linux.microsoft.com>, <nramas@linux.microsoft.com>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <selinux@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH 2/3] ima: Return int in the functions to measure a buffer
Date:   Wed, 30 Jun 2021 16:16:34 +0200
Message-ID: <20210630141635.2862222-3-roberto.sassu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210630141635.2862222-1-roberto.sassu@huawei.com>
References: <20210630141635.2862222-1-roberto.sassu@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.63.22]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 fraeml714-chm.china.huawei.com (10.206.15.33)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

ima_measure_critical_data() and process_buffer_measurement() currently
don't return a result. A caller wouldn't be able to know whether those
functions were executed successfully.

This patch modifies the return type from void to int, and returns 0 if the
buffer has been successfully measured, a negative value otherwise.

Also, this patch does not modify the behavior of existing callers by
processing the returned value. Instead, the value is stored in a variable
marked as __maybe_unused.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 include/linux/ima.h                          | 15 ++++---
 security/integrity/ima/ima.h                 | 10 ++---
 security/integrity/ima/ima_appraise.c        |  4 +-
 security/integrity/ima/ima_asymmetric_keys.c |  4 +-
 security/integrity/ima/ima_init.c            |  6 ++-
 security/integrity/ima/ima_main.c            | 46 ++++++++++++--------
 security/integrity/ima/ima_queue_keys.c      | 15 ++++---
 security/selinux/ima.c                       | 10 +++--
 8 files changed, 65 insertions(+), 45 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 81e830d01ced..60492263aa64 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -35,10 +35,10 @@ extern void ima_post_path_mknod(struct user_namespace *mnt_userns,
 extern int ima_file_hash(struct file *file, char *buf, size_t buf_size);
 extern int ima_inode_hash(struct inode *inode, char *buf, size_t buf_size);
 extern void ima_kexec_cmdline(int kernel_fd, const void *buf, int size);
-extern void ima_measure_critical_data(const char *event_label,
-				      const char *event_name,
-				      const void *buf, size_t buf_len,
-				      bool hash);
+extern int ima_measure_critical_data(const char *event_label,
+				     const char *event_name,
+				     const void *buf, size_t buf_len,
+				     bool hash);
 
 #ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
 extern void ima_appraise_parse_cmdline(void);
@@ -144,10 +144,13 @@ static inline int ima_inode_hash(struct inode *inode, char *buf, size_t buf_size
 
 static inline void ima_kexec_cmdline(int kernel_fd, const void *buf, int size) {}
 
-static inline void ima_measure_critical_data(const char *event_label,
+static inline int ima_measure_critical_data(const char *event_label,
 					     const char *event_name,
 					     const void *buf, size_t buf_len,
-					     bool hash) {}
+					     bool hash)
+{
+	return -ENOENT;
+}
 
 #endif /* CONFIG_IMA */
 
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index f0e448ed1f9f..03db221324c3 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -264,11 +264,11 @@ void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
 			   struct evm_ima_xattr_data *xattr_value,
 			   int xattr_len, const struct modsig *modsig, int pcr,
 			   struct ima_template_desc *template_desc);
-void process_buffer_measurement(struct user_namespace *mnt_userns,
-				struct inode *inode, const void *buf, int size,
-				const char *eventname, enum ima_hooks func,
-				int pcr, const char *func_data,
-				bool buf_hash);
+int process_buffer_measurement(struct user_namespace *mnt_userns,
+			       struct inode *inode, const void *buf, int size,
+			       const char *eventname, enum ima_hooks func,
+			       int pcr, const char *func_data,
+			       bool buf_hash);
 void ima_audit_measurement(struct integrity_iint_cache *iint,
 			   const unsigned char *filename);
 int ima_alloc_init_template(struct ima_event_data *event_data,
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index ef9dcfce45d4..275a2377743f 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -345,6 +345,7 @@ int ima_check_blacklist(struct integrity_iint_cache *iint,
 	enum hash_algo hash_algo;
 	const u8 *digest = NULL;
 	u32 digestsize = 0;
+	int process_rc __maybe_unused;
 	int rc = 0;
 
 	if (!(iint->flags & IMA_CHECK_BLACKLIST))
@@ -355,7 +356,8 @@ int ima_check_blacklist(struct integrity_iint_cache *iint,
 
 		rc = is_binary_blacklisted(digest, digestsize);
 		if ((rc == -EPERM) && (iint->flags & IMA_MEASURE))
-			process_buffer_measurement(&init_user_ns, NULL, digest, digestsize,
+			process_rc = process_buffer_measurement(&init_user_ns,
+						   NULL, digest, digestsize,
 						   "blacklisted-hash", NONE,
 						   pcr, NULL, false);
 	}
diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index c985418698a4..910367cdd920 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -31,6 +31,7 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 				   unsigned long flags, bool create)
 {
 	bool queued = false;
+	int ret __maybe_unused;
 
 	/* Only asymmetric keys are handled by this hook. */
 	if (key->type != &key_type_asymmetric)
@@ -60,7 +61,8 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 	 * if the IMA policy is configured to measure a key linked
 	 * to the given keyring.
 	 */
-	process_buffer_measurement(&init_user_ns, NULL, payload, payload_len,
+	ret = process_buffer_measurement(&init_user_ns, NULL,
+				   payload, payload_len,
 				   keyring->description, KEY_CHECK, 0,
 				   keyring->description, false);
 }
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 5076a7d9d23e..6790eea88db8 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -118,6 +118,7 @@ void __init ima_load_x509(void)
 
 int __init ima_init(void)
 {
+	int measure_rc __maybe_unused;
 	int rc;
 
 	ima_tpm_chip = tpm_default_chip();
@@ -153,8 +154,9 @@ int __init ima_init(void)
 
 	ima_init_key_queue();
 
-	ima_measure_critical_data("kernel_info", "kernel_version",
-				  UTS_RELEASE, strlen(UTS_RELEASE), false);
+	measure_rc = ima_measure_critical_data("kernel_info", "kernel_version",
+					       UTS_RELEASE, strlen(UTS_RELEASE),
+					       false);
 
 	return rc;
 }
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 8ef1fa357e0c..45e048899b2f 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -840,12 +840,15 @@ int ima_post_load_data(char *buf, loff_t size,
  * @buf_hash: measure buffer data hash
  *
  * Based on policy, either the buffer data or buffer data hash is measured
+ *
+ * Returns 0 if the buffer has been successfully measured, a negative value
+ * otherwise.
  */
-void process_buffer_measurement(struct user_namespace *mnt_userns,
-				struct inode *inode, const void *buf, int size,
-				const char *eventname, enum ima_hooks func,
-				int pcr, const char *func_data,
-				bool buf_hash)
+int process_buffer_measurement(struct user_namespace *mnt_userns,
+			       struct inode *inode, const void *buf, int size,
+			       const char *eventname, enum ima_hooks func,
+			       int pcr, const char *func_data,
+			       bool buf_hash)
 {
 	int ret = 0;
 	const char *audit_cause = "ENOMEM";
@@ -867,7 +870,7 @@ void process_buffer_measurement(struct user_namespace *mnt_userns,
 	u32 secid;
 
 	if (!ima_policy_flag)
-		return;
+		return -ENOENT;
 
 	template = ima_template_desc_buf();
 	if (!template) {
@@ -889,7 +892,7 @@ void process_buffer_measurement(struct user_namespace *mnt_userns,
 					secid, 0, func, &pcr, &template,
 					func_data);
 		if (!(action & IMA_MEASURE))
-			return;
+			return -ENOENT;
 	}
 
 	if (!pcr)
@@ -937,7 +940,7 @@ void process_buffer_measurement(struct user_namespace *mnt_userns,
 					func_measure_str(func),
 					audit_cause, ret, 0, ret);
 
-	return;
+	return ret;
 }
 
 /**
@@ -951,6 +954,7 @@ void process_buffer_measurement(struct user_namespace *mnt_userns,
 void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
 {
 	struct fd f;
+	int ret __maybe_unused;
 
 	if (!buf || !size)
 		return;
@@ -959,9 +963,10 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
 	if (!f.file)
 		return;
 
-	process_buffer_measurement(file_mnt_user_ns(f.file), file_inode(f.file),
-				   buf, size, "kexec-cmdline", KEXEC_CMDLINE, 0,
-				   NULL, false);
+	ret = process_buffer_measurement(file_mnt_user_ns(f.file),
+					 file_inode(f.file), buf, size,
+					 "kexec-cmdline", KEXEC_CMDLINE, 0,
+					 NULL, false);
 	fdput(f);
 }
 
@@ -977,18 +982,21 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
  * and extend the pcr.  Examples of critical data could be various data
  * structures, policies, and states stored in kernel memory that can
  * impact the integrity of the system.
+ *
+ * Returns 0 if the buffer has been successfully measured, a negative value
+ * otherwise.
  */
-void ima_measure_critical_data(const char *event_label,
-			       const char *event_name,
-			       const void *buf, size_t buf_len,
-			       bool hash)
+int ima_measure_critical_data(const char *event_label,
+			      const char *event_name,
+			      const void *buf, size_t buf_len,
+			      bool hash)
 {
 	if (!event_name || !event_label || !buf || !buf_len)
-		return;
+		return -ENOPARAM;
 
-	process_buffer_measurement(&init_user_ns, NULL, buf, buf_len, event_name,
-				   CRITICAL_DATA, 0, event_label,
-				   hash);
+	return process_buffer_measurement(&init_user_ns, NULL, buf, buf_len,
+					  event_name, CRITICAL_DATA, 0,
+					  event_label, hash);
 }
 
 static int __init init_ima(void)
diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
index 979ef6c71f3d..e3047ce64f39 100644
--- a/security/integrity/ima/ima_queue_keys.c
+++ b/security/integrity/ima/ima_queue_keys.c
@@ -134,6 +134,7 @@ void ima_process_queued_keys(void)
 {
 	struct ima_key_entry *entry, *tmp;
 	bool process = false;
+	int ret __maybe_unused;
 
 	if (ima_process_keys)
 		return;
@@ -159,13 +160,13 @@ void ima_process_queued_keys(void)
 
 	list_for_each_entry_safe(entry, tmp, &ima_keys, list) {
 		if (!timer_expired)
-			process_buffer_measurement(&init_user_ns, NULL,
-						   entry->payload,
-						   entry->payload_len,
-						   entry->keyring_name,
-						   KEY_CHECK, 0,
-						   entry->keyring_name,
-						   false);
+			ret = process_buffer_measurement(&init_user_ns, NULL,
+							 entry->payload,
+							 entry->payload_len,
+							 entry->keyring_name,
+							 KEY_CHECK, 0,
+							 entry->keyring_name,
+							 false);
 		list_del(&entry->list);
 		ima_free_key_entry(entry);
 	}
diff --git a/security/selinux/ima.c b/security/selinux/ima.c
index 34d421861bfc..4db9fa211638 100644
--- a/security/selinux/ima.c
+++ b/security/selinux/ima.c
@@ -75,6 +75,7 @@ void selinux_ima_measure_state_locked(struct selinux_state *state)
 	char *state_str = NULL;
 	void *policy = NULL;
 	size_t policy_len;
+	int measure_rc __maybe_unused;
 	int rc = 0;
 
 	WARN_ON(!mutex_is_locked(&state->policy_mutex));
@@ -85,8 +86,9 @@ void selinux_ima_measure_state_locked(struct selinux_state *state)
 		return;
 	}
 
-	ima_measure_critical_data("selinux", "selinux-state",
-				  state_str, strlen(state_str), false);
+	measure_rc = ima_measure_critical_data("selinux", "selinux-state",
+					       state_str, strlen(state_str),
+					       false);
 
 	kfree(state_str);
 
@@ -102,8 +104,8 @@ void selinux_ima_measure_state_locked(struct selinux_state *state)
 		return;
 	}
 
-	ima_measure_critical_data("selinux", "selinux-policy-hash",
-				  policy, policy_len, true);
+	measure_rc = ima_measure_critical_data("selinux", "selinux-policy-hash",
+					       policy, policy_len, true);
 
 	vfree(policy);
 }
-- 
2.25.1

