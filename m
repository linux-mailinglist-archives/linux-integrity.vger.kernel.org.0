Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41552489C8
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 17:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgHRP0m (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Aug 2020 11:26:42 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2632 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728107AbgHRP03 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 11:26:29 -0400
Received: from lhreml722-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 27F259934E2334B329CF;
        Tue, 18 Aug 2020 16:26:27 +0100 (IST)
Received: from kstruczy-linux-box (10.204.65.138) by
 lhreml722-chm.china.huawei.com (10.201.108.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 18 Aug 2020 16:26:25 +0100
Received: by kstruczy-linux-box (sSMTP sendmail emulation); Tue, 18 Aug 2020 17:26:28 +0200
From:   <krzysztof.struczynski@huawei.com>
To:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <containers@lists.linux-foundation.org>,
        <linux-security-module@vger.kernel.org>
CC:     Krzysztof Struczynski <krzysztof.struczynski@huawei.com>,
        <zohar@linux.ibm.com>, <stefanb@linux.vnet.ibm.com>,
        <sunyuqiong1988@gmail.com>, <mkayaalp@cs.binghamton.edu>,
        <dmitry.kasatkin@gmail.com>, <serge@hallyn.com>,
        <jmorris@namei.org>, <christian@brauner.io>,
        <silviu.vlasceanu@huawei.com>, <roberto.sassu@huawei.com>
Subject: [RFC PATCH 09/30] ima: Enable per ima namespace policy settings
Date:   Tue, 18 Aug 2020 17:20:16 +0200
Message-ID: <20200818152037.11869-10-krzysztof.struczynski@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200818152037.11869-1-krzysztof.struczynski@huawei.com>
References: <N>
 <20200818152037.11869-1-krzysztof.struczynski@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.204.65.138]
X-ClientProxiedBy: fraeml707-chm.china.huawei.com (10.206.15.35) To
 lhreml722-chm.china.huawei.com (10.201.108.73)
X-CFilter-Loop: Reflected
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>

Set ima policy per namespace and remove the global settings. Operations
on the objects may now have impact in more than one ima namespace and
therefore iterate all active ima namespaces when necessary.

Read-write violations can now happen across namespaces and should be
checked in all namespaces for each relevant ima hook.

Inform all concerned ima namespaces about the actions on the objects
when the object is freed. E.g. if an object had been appraised in the
ima_ns_1 and then modified in the ima_ns_2, appraised flag in the
ima_ns_1 is cleared and the object will be re-appraised in the ima_ns_1
namespace.

Signed-off-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
---
 include/linux/ima.h                          |  11 +
 kernel/kexec_file.c                          |   7 +
 security/integrity/ima/ima.h                 |  10 +-
 security/integrity/ima/ima_api.c             |   2 +-
 security/integrity/ima/ima_appraise.c        |  99 ++++---
 security/integrity/ima/ima_asymmetric_keys.c |  13 +-
 security/integrity/ima/ima_fs.c              |   6 +-
 security/integrity/ima/ima_init.c            |   7 +-
 security/integrity/ima/ima_main.c            | 235 ++++++++++++----
 security/integrity/ima/ima_ns.c              |   3 +
 security/integrity/ima/ima_policy.c          | 278 +++++++++++--------
 security/integrity/ima/ima_queue_keys.c      |  10 +-
 security/security.c                          |   2 +-
 13 files changed, 462 insertions(+), 221 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 9069aafd905f..1d0439d86ade 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -33,6 +33,8 @@ extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
 extern void ima_post_path_mknod(struct dentry *dentry);
 extern int ima_file_hash(struct file *file, char *buf, size_t buf_size);
 extern void ima_kexec_cmdline(int kernel_fd, const void *buf, int size);
+extern void ima_inode_free(struct inode *inode);
+extern bool ima_is_root_namespace(void);
 
 #ifdef CONFIG_IMA_KEXEC
 extern void ima_add_kexec_buffer(struct kimage *image);
@@ -116,6 +118,15 @@ static inline int ima_file_hash(struct file *file, char *buf, size_t buf_size)
 }
 
 static inline void ima_kexec_cmdline(int kernel_fd, const void *buf, int size) {}
+
+static inline void ima_inode_free(struct inode *inode)
+{
+}
+
+static inline bool ima_is_root_namespace(void)
+{
+	return true;
+}
 #endif /* CONFIG_IMA */
 
 #ifndef CONFIG_IMA_KEXEC
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 78c0837bfd7b..e17542057dfb 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -356,6 +356,13 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
 	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
 		return -EPERM;
 
+	/* Allow only from the initial IMA namespace, so that the user can't
+	 * spawn a new IMA namespace with the empty policy and circumvent the
+	 * appraisal protection.
+	 */
+	if (!ima_is_root_namespace())
+		return -EPERM;
+
 	/* Make sure we have a legal set of flags */
 	if (flags != (flags & KEXEC_FILE_FLAGS))
 		return -EINVAL;
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 7d522fdab0d8..33b4a8295c41 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -48,15 +48,11 @@ enum tpm_pcrs { TPM_PCR0 = 0, TPM_PCR8 = 8, TPM_PCR10 = 10 };
 
 #define NR_BANKS(chip) ((chip != NULL) ? chip->nr_allocated_banks : 0)
 
-/* current content of the policy */
-extern int ima_policy_flag;
-
 /* set during initialization */
 extern int ima_hash_algo;
 extern int ima_sha1_idx __ro_after_init;
 extern int ima_hash_algo_idx __ro_after_init;
 extern int ima_extra_slots __ro_after_init;
-extern int ima_appraise;
 extern struct tpm_chip *ima_tpm_chip;
 extern const char boot_aggregate_name[];
 
@@ -410,6 +406,9 @@ struct ima_policy_data {
 	int temp_ima_appraise;
 };
 
+extern struct list_head ima_ns_list;
+extern struct rw_semaphore ima_ns_list_lock;
+
 extern struct ima_policy_data init_policy_data;
 extern struct ima_policy_setup_data init_policy_setup_data;
 
@@ -423,6 +422,9 @@ static inline struct ima_namespace *get_current_ns(void)
 {
 	return current->nsproxy->ima_ns;
 }
+
+void ima_delete_ns_rules(struct ima_policy_data *policy_data,
+			 bool is_root_ns);
 #else
 static inline int __init ima_init_namespace(void)
 {
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 8b41183200e8..8d7b0d4635fc 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -192,7 +192,7 @@ int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
 {
 	int flags = IMA_MEASURE | IMA_AUDIT | IMA_APPRAISE | IMA_HASH;
 
-	flags &= ima_policy_flag;
+	flags &= ima_ns->policy_data->ima_policy_flag;
 
 	return ima_match_policy(inode, cred, secid, func, mask, flags, pcr,
 				template_desc, keyring, ima_ns);
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 9388ff88ca4d..a5e775182fb0 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -18,14 +18,6 @@
 
 int ima_default_appraise_setup(const char *str,
 			       struct ima_policy_setup_data *setup_data)
-{
-	/* Currently unused. It will be implemented after namespacing ima
-	 * policy, when global variables are removed.
-	 */
-	return 1;
-}
-
-static int __init default_appraise_setup(char *str)
 {
 #ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
 	if (arch_ima_get_secureboot()) {
@@ -35,15 +27,20 @@ static int __init default_appraise_setup(char *str)
 	}
 
 	if (strncmp(str, "off", 3) == 0)
-		ima_appraise = 0;
+		setup_data->ima_appraise = 0;
 	else if (strncmp(str, "log", 3) == 0)
-		ima_appraise = IMA_APPRAISE_LOG;
+		setup_data->ima_appraise = IMA_APPRAISE_LOG;
 	else if (strncmp(str, "fix", 3) == 0)
-		ima_appraise = IMA_APPRAISE_FIX;
+		setup_data->ima_appraise = IMA_APPRAISE_FIX;
 #endif
 	return 1;
 }
 
+static int __init default_appraise_setup(char *str)
+{
+	return ima_default_appraise_setup(str, &init_policy_setup_data);
+}
+
 __setup("ima_appraise=", default_appraise_setup);
 
 /*
@@ -54,7 +51,10 @@ __setup("ima_appraise=", default_appraise_setup);
  */
 bool is_ima_appraise_enabled(const struct ima_namespace *ima_ns)
 {
-	return ima_appraise & IMA_APPRAISE_ENFORCE;
+	if (!ima_ns)
+		return false;
+
+	return ima_ns->policy_data->ima_appraise & IMA_APPRAISE_ENFORCE;
 }
 
 /*
@@ -62,18 +62,18 @@ bool is_ima_appraise_enabled(const struct ima_namespace *ima_ns)
  *
  * Return 1 to appraise or hash
  */
-int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func,
-		      struct ima_namespace *ima_ns)
+int ima_must_appraise(struct inode *inode, int mask,
+		      enum ima_hooks func, struct ima_namespace *ima_ns)
 {
 	u32 secid;
 
-	if (!ima_appraise)
+	if (!ima_ns->policy_data->ima_appraise)
 		return 0;
 
 	security_task_getsecid(current, &secid);
 	return ima_match_policy(inode, current_cred(), secid, func, mask,
 				IMA_APPRAISE | IMA_HASH, NULL, NULL, NULL,
-				NULL);
+				ima_ns);
 }
 
 static int ima_fix_xattr(struct dentry *dentry,
@@ -349,7 +349,7 @@ int ima_check_blacklist(struct integrity_iint_cache *iint,
 		if ((rc == -EPERM) && (iint->flags & IMA_MEASURE))
 			process_buffer_measurement(NULL, digest, digestsize,
 						   "blacklisted-hash", NONE,
-						   pcr, NULL, NULL);
+						   pcr, NULL, ima_ns);
 	}
 
 	return rc;
@@ -376,6 +376,7 @@ int ima_appraise_measurement(enum ima_hooks func,
 	enum integrity_status status = INTEGRITY_UNKNOWN;
 	int rc = xattr_len;
 	bool try_modsig = iint->flags & IMA_MODSIG_ALLOWED && modsig;
+	struct ima_namespace *ima_ns = get_current_ns();
 
 	/* If not appraising a modsig, we need an xattr. */
 	if (!(inode->i_opflags & IOP_XATTR) && !try_modsig)
@@ -448,7 +449,8 @@ int ima_appraise_measurement(enum ima_hooks func,
 				    op, cause, rc, 0);
 	} else if (status != INTEGRITY_PASS) {
 		/* Fix mode, but don't replace file signatures. */
-		if ((ima_appraise & IMA_APPRAISE_FIX) && !try_modsig &&
+		if ((ima_ns->policy_data->ima_appraise & IMA_APPRAISE_FIX) &&
+		    !try_modsig &&
 		    (!xattr_value ||
 		     xattr_value->type != EVM_IMA_XATTR_DIGSIG)) {
 			if (!ima_fix_xattr(dentry, iint))
@@ -510,20 +512,32 @@ void ima_inode_post_setattr(struct dentry *dentry)
 	struct inode *inode = d_backing_inode(dentry);
 	struct integrity_iint_cache *iint;
 	int action;
+	struct ima_namespace *ima_ns;
 
-	if (!(ima_policy_flag & IMA_APPRAISE) || !S_ISREG(inode->i_mode)
-	    || !(inode->i_opflags & IOP_XATTR))
+	if (!S_ISREG(inode->i_mode) ||
+	    !(inode->i_opflags & IOP_XATTR))
 		return;
 
-	action = ima_must_appraise(inode, MAY_ACCESS, POST_SETATTR, NULL);
-	if (!action)
-		__vfs_removexattr(dentry, XATTR_NAME_IMA);
-	iint = integrity_iint_find(inode);
-	if (iint) {
-		set_bit(IMA_CHANGE_ATTR, &iint->atomic_flags);
+	down_read(&ima_ns_list_lock);
+	list_for_each_entry(ima_ns, &ima_ns_list, list) {
+		if (atomic_read(&ima_ns->inactive))
+			continue;
+		if (!(ima_ns->policy_data->ima_policy_flag & IMA_APPRAISE))
+			continue;
+
+		action = ima_must_appraise(inode, MAY_ACCESS, POST_SETATTR,
+					   ima_ns);
 		if (!action)
-			clear_bit(IMA_UPDATE_XATTR, &iint->atomic_flags);
+			__vfs_removexattr(dentry, XATTR_NAME_IMA);
+		iint = integrity_iint_rb_find(ima_ns->iint_tree, inode);
+		if (iint) {
+			set_bit(IMA_CHANGE_ATTR, &iint->atomic_flags);
+			if (!action)
+				clear_bit(IMA_UPDATE_XATTR,
+					  &iint->atomic_flags);
+		}
 	}
+	up_read(&ima_ns_list_lock);
 }
 
 /*
@@ -545,19 +559,30 @@ static int ima_protect_xattr(struct dentry *dentry, const char *xattr_name,
 static void ima_reset_appraise_flags(struct inode *inode, int digsig)
 {
 	struct integrity_iint_cache *iint;
+	struct ima_namespace *ima_ns;
 
-	if (!(ima_policy_flag & IMA_APPRAISE) || !S_ISREG(inode->i_mode))
+	if (!S_ISREG(inode->i_mode))
 		return;
 
-	iint = integrity_iint_find(inode);
-	if (!iint)
-		return;
-	iint->measured_pcrs = 0;
-	set_bit(IMA_CHANGE_XATTR, &iint->atomic_flags);
-	if (digsig)
-		set_bit(IMA_DIGSIG, &iint->atomic_flags);
-	else
-		clear_bit(IMA_DIGSIG, &iint->atomic_flags);
+	down_read(&ima_ns_list_lock);
+	list_for_each_entry(ima_ns, &ima_ns_list, list) {
+		if (atomic_read(&ima_ns->inactive))
+			continue;
+		if (!(ima_ns->policy_data->ima_policy_flag & IMA_APPRAISE))
+			continue;
+
+		iint = integrity_iint_find(inode);
+		if (!iint)
+			continue;
+
+		iint->measured_pcrs = 0;
+		set_bit(IMA_CHANGE_XATTR, &iint->atomic_flags);
+		if (digsig)
+			set_bit(IMA_DIGSIG, &iint->atomic_flags);
+		else
+			clear_bit(IMA_DIGSIG, &iint->atomic_flags);
+	}
+	up_read(&ima_ns_list_lock);
 }
 
 int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index 58aa56b0422d..b3330a0a1481 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -29,6 +29,16 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 				   unsigned long flags, bool create)
 {
 	bool queued = false;
+	/* Measure the keys according to the current ima namespace's policy
+	 * rules. If the new ima namespace with empty policy is created to hide
+	 * the log, parent can join it to inspect the log until the child
+	 * namespace exists. After its destruction, log can be accessed only
+	 * by the processes from the initial ima namespace that see all
+	 * measurement list entries. If this is a problem, maybe the solution
+	 * is to track in which namespaces the key was measured and re-measure
+	 * it when necessary.
+	 */
+	struct ima_namespace *ima_ns = get_current_ns();
 
 	/* Only asymmetric keys are handled by this hook. */
 	if (key->type != &key_type_asymmetric)
@@ -60,6 +70,5 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 	 */
 	process_buffer_measurement(NULL, payload, payload_len,
 				   keyring->description, KEY_CHECK, 0,
-				   keyring->description,
-				   NULL);
+				   keyring->description, ima_ns);
 }
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 97aadee7e68e..3839b9eaecab 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -312,6 +312,7 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 {
 	char *data;
 	ssize_t result;
+	struct ima_namespace *ima_ns = get_current_ns();
 
 	if (datalen >= PAGE_SIZE)
 		datalen = PAGE_SIZE - 1;
@@ -333,7 +334,7 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 
 	if (data[0] == '/') {
 		result = ima_read_policy(data);
-	} else if (ima_appraise & IMA_APPRAISE_POLICY) {
+	} else if (ima_ns->policy_data->ima_appraise & IMA_APPRAISE_POLICY) {
 		pr_err("signed policy file (specified as an absolute pathname) required\n");
 		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
 				    "policy_update", "signed policy required",
@@ -406,11 +407,12 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
 static int ima_release_policy(struct inode *inode, struct file *file)
 {
 	const char *cause = valid_policy ? "completed" : "failed";
+	struct ima_namespace *ima_ns = get_current_ns();
 
 	if ((file->f_flags & O_ACCMODE) == O_RDONLY)
 		return seq_release(inode, file);
 
-	if (valid_policy && ima_check_policy(NULL) < 0) {
+	if (valid_policy && ima_check_policy(ima_ns) < 0) {
 		cause = "failed";
 		valid_policy = 0;
 	}
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index be1afc42fdf5..d042b08cc4d7 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -118,11 +118,12 @@ static int __init ima_add_boot_aggregate(void)
 #ifdef CONFIG_IMA_LOAD_X509
 void __init ima_load_x509(void)
 {
-	int unset_flags = ima_policy_flag & IMA_APPRAISE;
+	int unset_flags =
+		init_ima_ns.policy_data->ima_policy_flag & IMA_APPRAISE;
 
-	ima_policy_flag &= ~unset_flags;
+	init_ima_ns.policy_data->ima_policy_flag &= ~unset_flags;
 	integrity_load_x509(INTEGRITY_KEYRING_IMA, CONFIG_IMA_X509_PATH);
-	ima_policy_flag |= unset_flags;
+	init_ima_ns.policy_data->ima_policy_flag |= unset_flags;
 }
 #endif
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 196fa2bd490d..80b1737a3369 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -28,12 +28,6 @@
 
 #include "ima.h"
 
-#ifdef CONFIG_IMA_APPRAISE
-int ima_appraise = IMA_APPRAISE_ENFORCE;
-#else
-int ima_appraise;
-#endif
-
 int ima_hash_algo = HASH_ALGO_SHA1;
 static int hash_setup_done;
 
@@ -119,7 +113,8 @@ static void ima_rdwr_violation_check(struct file *file,
 	if (mode & FMODE_WRITE) {
 		if (atomic_read(&inode->i_readcount) && IS_IMA(inode)) {
 			if (!iint)
-				iint = integrity_iint_find(inode);
+				iint = integrity_iint_rb_find(ima_ns->iint_tree,
+							      inode);
 			/* IMA_MEASURE is set from reader side */
 			if (iint && test_bit(IMA_MUST_MEASURE,
 						&iint->atomic_flags))
@@ -145,11 +140,38 @@ static void ima_rdwr_violation_check(struct file *file,
 				  "invalid_pcr", "open_writers");
 }
 
+static void ima_check_active_ns(struct ima_namespace *current_ima_ns,
+				struct inode *inode)
+{
+	struct ima_namespace *ima_ns;
+	struct integrity_iint_cache *iint;
+
+	down_read(&ima_ns_list_lock);
+	list_for_each_entry(ima_ns, &ima_ns_list, list) {
+		if (atomic_read(&ima_ns->inactive))
+			continue;
+		if ((ima_ns == current_ima_ns) ||
+		    !ima_ns->policy_data->ima_policy_flag)
+			continue;
+
+		iint = integrity_iint_rb_find(ima_ns->iint_tree, inode);
+		if (!iint)
+			continue;
+
+		mutex_lock(&iint->mutex);
+		iint->flags &= ~IMA_DONE_MASK;
+		iint->measured_pcrs = 0;
+		mutex_unlock(&iint->mutex);
+	}
+	up_read(&ima_ns_list_lock);
+}
+
 static void ima_check_last_writer(struct integrity_iint_cache *iint,
 				  struct inode *inode, struct file *file)
 {
 	fmode_t mode = file->f_mode;
 	bool update;
+	struct ima_namespace *ima_ns = (struct ima_namespace *)file->f_ima;
 
 	if (!(mode & FMODE_WRITE))
 		return;
@@ -163,6 +185,9 @@ static void ima_check_last_writer(struct integrity_iint_cache *iint,
 		    (iint->flags & IMA_NEW_FILE)) {
 			iint->flags &= ~(IMA_DONE_MASK | IMA_NEW_FILE);
 			iint->measured_pcrs = 0;
+
+			ima_check_active_ns(ima_ns, inode);
+
 			if (update)
 				ima_update_xattr(iint, file);
 		}
@@ -202,10 +227,10 @@ void ima_file_free(struct file *file)
 	if (unlikely(!(file->f_mode & FMODE_OPENED)))
 		goto out;
 
-	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
+	if (!ima_ns->policy_data->ima_policy_flag || !S_ISREG(inode->i_mode))
 		goto out;
 
-	iint = integrity_iint_find(inode);
+	iint = integrity_iint_rb_find(ima_ns->iint_tree, inode);
 	if (!iint)
 		goto out;
 
@@ -214,10 +239,10 @@ void ima_file_free(struct file *file)
 	put_ima_ns(ima_ns);
 }
 
-static int process_measurement(struct file *file, const struct cred *cred,
-			       u32 secid, char *buf, loff_t size, int mask,
-			       enum ima_hooks func,
-			       struct ima_namespace *ima_ns)
+static int process_ns_measurement(struct file *file, const struct cred *cred,
+				  u32 secid, char *buf, loff_t size, int mask,
+				  enum ima_hooks func,
+				  struct ima_namespace *ima_ns)
 {
 	struct inode *inode = file_inode(file);
 	struct integrity_iint_cache *iint = NULL;
@@ -232,8 +257,9 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	int xattr_len = 0;
 	bool violation_check;
 	enum hash_algo hash_algo;
+	struct ima_namespace *current_ima_ns = get_current_ns();
 
-	if (!ima_policy_flag || !S_ISREG(inode->i_mode))
+	if (!ima_ns->policy_data->ima_policy_flag)
 		return 0;
 
 	/* Return an IMA_MEASURE, IMA_APPRAISE, IMA_AUDIT action
@@ -243,7 +269,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	action = ima_get_action(inode, cred, secid, mask, func, &pcr,
 				&template_desc, NULL, ima_ns);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
-			   (ima_policy_flag & IMA_MEASURE));
+			   (ima_ns->policy_data->ima_policy_flag &
+			    IMA_MEASURE));
 	if (!action && !violation_check)
 		return 0;
 
@@ -256,7 +283,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	inode_lock(inode);
 
 	if (action) {
-		iint = integrity_inode_get(inode);
+		iint = integrity_inode_rb_get(ima_ns->iint_tree, inode);
 		if (!iint)
 			rc = -ENOMEM;
 	}
@@ -271,6 +298,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
 		goto out;
 	if (!action)
 		goto out;
+	if (ima_ns != current_ima_ns)
+		goto out;
 
 	mutex_lock(&iint->mutex);
 
@@ -389,7 +418,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	if (pathbuf)
 		__putname(pathbuf);
 	if (must_appraise) {
-		if (rc && (ima_appraise & IMA_APPRAISE_ENFORCE))
+		if (rc &&
+		    (ima_ns->policy_data->ima_appraise & IMA_APPRAISE_ENFORCE))
 			return -EACCES;
 		if (file->f_mode & FMODE_WRITE)
 			set_bit(IMA_UPDATE_XATTR, &iint->atomic_flags);
@@ -397,6 +427,32 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	return 0;
 }
 
+static int process_measurement(struct file *file, const struct cred *cred,
+			       u32 secid, char *buf, loff_t size, int mask,
+			       enum ima_hooks func)
+{
+	int ret;
+	struct ima_namespace *ima_ns;
+	struct inode *inode = file_inode(file);
+
+	if (!S_ISREG(inode->i_mode))
+		return 0;
+
+	down_read(&ima_ns_list_lock);
+	list_for_each_entry(ima_ns, &ima_ns_list, list) {
+		if (atomic_read(&ima_ns->inactive))
+			continue;
+
+		ret = process_ns_measurement(file, cred, secid, buf, size, mask,
+					     func, ima_ns);
+		if (ret != 0)
+			break;
+	}
+	up_read(&ima_ns_list_lock);
+
+	return ret;
+}
+
 /**
  * ima_file_mmap - based on policy, collect/store measurement.
  * @file: pointer to the file to be measured (May be NULL)
@@ -415,7 +471,7 @@ int ima_file_mmap(struct file *file, unsigned long prot)
 	if (file && (prot & PROT_EXEC)) {
 		security_task_getsecid(current, &secid);
 		return process_measurement(file, current_cred(), secid, NULL,
-					   0, MAY_EXEC, MMAP_CHECK, NULL);
+					   0, MAY_EXEC, MMAP_CHECK);
 	}
 
 	return 0;
@@ -435,6 +491,7 @@ int ima_file_mmap(struct file *file, unsigned long prot)
  */
 int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 {
+	struct ima_namespace *ima_ns = get_current_ns();
 	struct ima_template_desc *template;
 	struct file *file = vma->vm_file;
 	char filename[NAME_MAX];
@@ -447,14 +504,15 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 	int pcr;
 
 	/* Is mprotect making an mmap'ed file executable? */
-	if (!(ima_policy_flag & IMA_APPRAISE) || !vma->vm_file ||
-	    !(prot & PROT_EXEC) || (vma->vm_flags & VM_EXEC))
+	if (!(ima_ns->policy_data->ima_policy_flag & IMA_APPRAISE) ||
+	    !vma->vm_file || !(prot & PROT_EXEC) ||
+	    (vma->vm_flags & VM_EXEC))
 		return 0;
 
 	security_task_getsecid(current, &secid);
 	inode = file_inode(vma->vm_file);
 	action = ima_get_action(inode, current_cred(), secid, MAY_EXEC,
-				MMAP_CHECK, &pcr, &template, 0, NULL);
+				MMAP_CHECK, &pcr, &template, 0, ima_ns);
 
 	/* Is the mmap'ed file in policy? */
 	if (!(action & (IMA_MEASURE | IMA_APPRAISE_SUBMASK)))
@@ -493,13 +551,13 @@ int ima_bprm_check(struct linux_binprm *bprm)
 
 	security_task_getsecid(current, &secid);
 	ret = process_measurement(bprm->file, current_cred(), secid, NULL, 0,
-				  MAY_EXEC, BPRM_CHECK, NULL);
+				  MAY_EXEC, BPRM_CHECK);
 	if (ret)
 		return ret;
 
 	security_cred_getsecid(bprm->cred, &secid);
 	return process_measurement(bprm->file, bprm->cred, secid, NULL, 0,
-				   MAY_EXEC, CREDS_CHECK, NULL);
+				   MAY_EXEC, CREDS_CHECK);
 }
 
 /**
@@ -519,13 +577,13 @@ int ima_file_check(struct file *file, int mask)
 	security_task_getsecid(current, &secid);
 	return process_measurement(file, current_cred(), secid, NULL, 0,
 				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
-					   MAY_APPEND), FILE_CHECK, NULL);
+					   MAY_APPEND), FILE_CHECK);
 }
 EXPORT_SYMBOL_GPL(ima_file_check);
 
 /**
  * ima_file_hash - return the stored measurement if a file has been hashed and
- * is in the iint cache.
+ * is in the iint cache of the current IMA namespace.
  * @file: pointer to the file
  * @buf: buffer in which to store the hash
  * @buf_size: length of the buffer
@@ -543,6 +601,7 @@ EXPORT_SYMBOL_GPL(ima_file_check);
  */
 int ima_file_hash(struct file *file, char *buf, size_t buf_size)
 {
+	struct ima_namespace *ima_ns = get_current_ns();
 	struct inode *inode;
 	struct integrity_iint_cache *iint;
 	int hash_algo;
@@ -550,11 +609,11 @@ int ima_file_hash(struct file *file, char *buf, size_t buf_size)
 	if (!file)
 		return -EINVAL;
 
-	if (!ima_policy_flag)
+	if (!ima_ns->policy_data->ima_policy_flag)
 		return -EOPNOTSUPP;
 
 	inode = file_inode(file);
-	iint = integrity_iint_find(inode);
+	iint = integrity_iint_rb_find(ima_ns->iint_tree, inode);
 	if (!iint)
 		return -EOPNOTSUPP;
 
@@ -582,21 +641,30 @@ EXPORT_SYMBOL_GPL(ima_file_hash);
  */
 void ima_post_create_tmpfile(struct inode *inode)
 {
+	struct ima_namespace *ima_ns;
 	struct integrity_iint_cache *iint;
 	int must_appraise;
 
-	must_appraise = ima_must_appraise(inode, MAY_ACCESS, FILE_CHECK, NULL);
-	if (!must_appraise)
-		return;
+	down_read(&ima_ns_list_lock);
+	list_for_each_entry(ima_ns, &ima_ns_list, list) {
+		if (atomic_read(&ima_ns->inactive))
+			continue;
 
-	/* Nothing to do if we can't allocate memory */
-	iint = integrity_inode_get(inode);
-	if (!iint)
-		return;
+		must_appraise = ima_must_appraise(inode, MAY_ACCESS,
+						  FILE_CHECK, ima_ns);
+		if (!must_appraise)
+			continue;
+
+		/* Nothing to do if we can't allocate memory */
+		iint = integrity_inode_rb_get(ima_ns->iint_tree, inode);
+		if (!iint)
+			continue;
 
-	/* needed for writing the security xattrs */
-	set_bit(IMA_UPDATE_XATTR, &iint->atomic_flags);
-	iint->ima_file_status = INTEGRITY_PASS;
+		/* needed for writing the security xattrs */
+		set_bit(IMA_UPDATE_XATTR, &iint->atomic_flags);
+		iint->ima_file_status = INTEGRITY_PASS;
+	}
+	up_read(&ima_ns_list_lock);
 }
 
 /**
@@ -608,21 +676,30 @@ void ima_post_create_tmpfile(struct inode *inode)
  */
 void ima_post_path_mknod(struct dentry *dentry)
 {
+	struct ima_namespace *ima_ns;
 	struct integrity_iint_cache *iint;
 	struct inode *inode = dentry->d_inode;
 	int must_appraise;
 
-	must_appraise = ima_must_appraise(inode, MAY_ACCESS, FILE_CHECK, NULL);
-	if (!must_appraise)
-		return;
+	down_read(&ima_ns_list_lock);
+	list_for_each_entry(ima_ns, &ima_ns_list, list) {
+		if (atomic_read(&ima_ns->inactive))
+			continue;
 
-	/* Nothing to do if we can't allocate memory */
-	iint = integrity_inode_get(inode);
-	if (!iint)
-		return;
+		must_appraise = ima_must_appraise(inode, MAY_ACCESS,
+						  FILE_CHECK, ima_ns);
+		if (!must_appraise)
+			continue;
 
-	/* needed for re-opening empty files */
-	iint->flags |= IMA_NEW_FILE;
+		/* Nothing to do if we can't allocate memory */
+		iint = integrity_inode_rb_get(ima_ns->iint_tree, inode);
+		if (!iint)
+			continue;
+
+		/* needed for re-opening empty files */
+		iint->flags |= IMA_NEW_FILE;
+	}
+	up_read(&ima_ns_list_lock);
 }
 
 /**
@@ -676,10 +753,13 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 {
 	enum ima_hooks func;
 	u32 secid;
+	struct ima_namespace *ima_ns = get_current_ns();
 
 	if (!file && read_id == READING_FIRMWARE) {
-		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
-		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
+		if ((ima_ns->policy_data->ima_appraise &
+		     IMA_APPRAISE_FIRMWARE) &&
+		    (ima_ns->policy_data->ima_appraise &
+		     IMA_APPRAISE_ENFORCE)) {
 			pr_err("Prevent firmware loading_store.\n");
 			return -EACCES;	/* INTEGRITY_UNKNOWN */
 		}
@@ -691,7 +771,7 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 		return 0;
 
 	if (!file || !buf || size == 0) { /* should never happen */
-		if (ima_appraise & IMA_APPRAISE_ENFORCE)
+		if (ima_ns->policy_data->ima_appraise & IMA_APPRAISE_ENFORCE)
 			return -EACCES;
 		return 0;
 	}
@@ -699,7 +779,7 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_task_getsecid(current, &secid);
 	return process_measurement(file, current_cred(), secid, buf, size,
-				   MAY_READ, func, NULL);
+				   MAY_READ, func);
 }
 
 /**
@@ -715,9 +795,16 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 int ima_load_data(enum kernel_load_data_id id)
 {
 	bool ima_enforce, sig_enforce;
+	struct ima_namespace *ima_ns = get_current_ns();
+
+	if (ima_ns != &init_ima_ns) {
+		pr_err("Prevent data loading in IMA namespaces other than the root\n");
+		return -EACCES;
+	}
 
 	ima_enforce =
-		(ima_appraise & IMA_APPRAISE_ENFORCE) == IMA_APPRAISE_ENFORCE;
+		(ima_ns->policy_data->ima_appraise & IMA_APPRAISE_ENFORCE) ==
+		IMA_APPRAISE_ENFORCE;
 
 	switch (id) {
 	case LOADING_KEXEC_IMAGE:
@@ -727,13 +814,16 @@ int ima_load_data(enum kernel_load_data_id id)
 			return -EACCES;
 		}
 
-		if (ima_enforce && (ima_appraise & IMA_APPRAISE_KEXEC)) {
+		if (ima_enforce &&
+		    (ima_ns->policy_data->ima_appraise & IMA_APPRAISE_KEXEC)) {
 			pr_err("impossible to appraise a kernel image without a file descriptor; try using kexec_file_load syscall.\n");
 			return -EACCES;	/* INTEGRITY_UNKNOWN */
 		}
 		break;
 	case LOADING_FIRMWARE:
-		if (ima_enforce && (ima_appraise & IMA_APPRAISE_FIRMWARE)) {
+		if (ima_enforce &&
+		    (ima_ns->policy_data->ima_appraise &
+		     IMA_APPRAISE_FIRMWARE)) {
 			pr_err("Prevent firmware sysfs fallback loading.\n");
 			return -EACCES;	/* INTEGRITY_UNKNOWN */
 		}
@@ -741,8 +831,10 @@ int ima_load_data(enum kernel_load_data_id id)
 	case LOADING_MODULE:
 		sig_enforce = is_module_sig_enforced();
 
-		if (ima_enforce && (!sig_enforce
-				    && (ima_appraise & IMA_APPRAISE_MODULES))) {
+		if (ima_enforce &&
+		    (!sig_enforce &&
+		     (ima_ns->policy_data->ima_appraise &
+		      IMA_APPRAISE_MODULES))) {
 			pr_err("impossible to appraise a module without a file descriptor. sig_enforce kernel parameter might help\n");
 			return -EACCES;	/* INTEGRITY_UNKNOWN */
 		}
@@ -761,6 +853,7 @@ int ima_load_data(enum kernel_load_data_id id)
  * @func: IMA hook
  * @pcr: pcr to extend the measurement
  * @keyring: keyring name to determine the action to be performed
+ * @ima_ns: pointer to the IMA namespace in consideration
  *
  * Based on policy, the buffer is measured into the ima log.
  */
@@ -786,7 +879,7 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
 	int action = 0;
 	u32 secid;
 
-	if (!ima_policy_flag)
+	if (!ima_ns->policy_data->ima_policy_flag)
 		return;
 
 	/*
@@ -799,7 +892,7 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
 	if (func) {
 		security_task_getsecid(current, &secid);
 		action = ima_get_action(inode, current_cred(), secid, 0, func,
-					&pcr, &template, keyring, NULL);
+					&pcr, &template, keyring, ima_ns);
 		if (!(action & IMA_MEASURE))
 			return;
 	}
@@ -862,6 +955,11 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
 void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
 {
 	struct fd f;
+	struct ima_namespace *ima_ns = get_current_ns();
+
+	/* Currently allowed only from the root IMA namespace */
+	if (WARN_ON(ima_ns != &init_ima_ns))
+		return;
 
 	if (!buf || !size)
 		return;
@@ -872,10 +970,31 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
 
 	process_buffer_measurement(file_inode(f.file), buf, size,
 				   "kexec-cmdline", KEXEC_CMDLINE, 0, NULL,
-				   NULL);
+				   ima_ns);
 	fdput(f);
 }
 
+void ima_inode_free(struct inode *inode)
+{
+	struct ima_namespace *ima_ns;
+
+	if (!IS_IMA(inode))
+		return;
+
+	down_read(&ima_ns_list_lock);
+	list_for_each_entry(ima_ns, &ima_ns_list, list) {
+		if (atomic_read(&ima_ns->inactive))
+			continue;
+		integrity_inode_rb_free(ima_ns->iint_tree, inode);
+	}
+	up_read(&ima_ns_list_lock);
+}
+
+bool ima_is_root_namespace(void)
+{
+	return get_current_ns() == &init_ima_ns;
+}
+
 static int __init init_ima(void)
 {
 	int error;
diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
index 226a53279f71..04aa50473971 100644
--- a/security/integrity/ima/ima_ns.c
+++ b/security/integrity/ima/ima_ns.c
@@ -181,11 +181,14 @@ int __init ima_init_namespace(void)
 
 static void destroy_ima_ns(struct ima_namespace *ns)
 {
+	bool is_init_ns = (ns == &init_ima_ns);
+
 	dec_ima_namespaces(ns->ucounts);
 	put_user_ns(ns->user_ns);
 	ns_free_inum(&ns->ns);
 	integrity_iint_tree_free(ns->iint_tree);
 	kfree(ns->iint_tree);
+	ima_delete_ns_rules(ns->policy_data, is_init_ns);
 	kfree(ns->policy_data);
 	kfree(ns);
 }
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 12f9dcf73c83..1f60ce9b2ffa 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -46,8 +46,6 @@
 #define INVALID_PCR(a) (((a) < 0) || \
 	(a) >= (sizeof_field(struct integrity_iint_cache, measured_pcrs) * 8))
 
-int ima_policy_flag;
-static int temp_ima_appraise;
 static int build_ima_appraise __ro_after_init;
 
 #define MAX_LSM_RULES 6
@@ -198,20 +196,15 @@ static struct ima_rule_entry secure_boot_rules[] __ro_after_init = {
 	 .flags = IMA_FUNC | IMA_DIGSIG_REQUIRED},
 };
 
+/* Number of architecture specific rules found */
+static int arch_entries_size __ro_after_init;
 /* An array of architecture specific rules */
 static struct ima_rule_entry *arch_policy_entry __ro_after_init;
 
-static LIST_HEAD(ima_default_rules);
-static LIST_HEAD(ima_policy_rules);
-static LIST_HEAD(ima_temp_rules);
-static struct list_head *ima_rules = &ima_default_rules;
-
 /* Pre-allocated buffer used for matching keyrings. */
 static char *ima_keyrings;
 static size_t ima_keyrings_len;
 
-static int ima_policy __initdata;
-
 struct ima_policy_setup_data init_policy_setup_data = {
 #ifdef CONFIG_IMA_APPRAISE
 	.ima_appraise = IMA_APPRAISE_ENFORCE,
@@ -221,29 +214,25 @@ struct ima_policy_data init_policy_data = {
 	.ima_default_rules = LIST_HEAD_INIT(init_policy_data.ima_default_rules),
 	.ima_policy_rules = LIST_HEAD_INIT(init_policy_data.ima_policy_rules),
 	.ima_temp_rules = LIST_HEAD_INIT(init_policy_data.ima_temp_rules),
+	.ima_rules = &init_policy_data.ima_default_rules,
 };
 
 int ima_default_measure_policy_setup(const char *str,
 				     struct ima_policy_setup_data *setup_data)
 {
-	/* Currently unused. It will be implemented after namespacing ima
-	 * policy, when global variables are removed.
-	 */
+	if (setup_data->ima_policy)
+		return 1;
+
+	setup_data->ima_policy = ORIGINAL_TCB;
 	return 1;
 }
 
 static int __init default_measure_policy_setup(char *str)
 {
-	if (ima_policy)
-		return 1;
-
-	ima_policy = ORIGINAL_TCB;
-	return 1;
+	return ima_default_measure_policy_setup(str, &init_policy_setup_data);
 }
 __setup("ima_tcb", default_measure_policy_setup);
 
-static bool ima_use_appraise_tcb __initdata;
-static bool ima_use_secure_boot __initdata;
 static bool ima_fail_unverifiable_sigs __ro_after_init;
 
 /**
@@ -251,53 +240,47 @@ static bool ima_fail_unverifiable_sigs __ro_after_init;
  * @str: string to be parsed
  * @setup_data: pointer to a structure where parsed data is stored
  * @fail_unverifiable_sigs: boolean flag treated separately to preserve
- * __ro_after_init
+ *                          __ro_after_init
  */
 int ima_policy_setup(char *str,
 		     struct ima_policy_setup_data *setup_data,
 		     bool *fail_unverifiable_sigs)
-{
-
-	/* Currently unused. It will be implemented after namespacing ima
-	 * policy, when global variables are removed.
-	 */
-	return 1;
-}
-
-static int __init policy_setup(char *str)
 {
 	char *p;
 
 	while ((p = strsep(&str, " |\n")) != NULL) {
 		if (*p == ' ')
 			continue;
-		if ((strcmp(p, "tcb") == 0) && !ima_policy)
-			ima_policy = DEFAULT_TCB;
+		if ((strcmp(p, "tcb") == 0) && !setup_data->ima_policy)
+			setup_data->ima_policy = DEFAULT_TCB;
 		else if (strcmp(p, "appraise_tcb") == 0)
-			ima_use_appraise_tcb = true;
+			setup_data->ima_use_appraise_tcb = true;
 		else if (strcmp(p, "secure_boot") == 0)
-			ima_use_secure_boot = true;
+			setup_data->ima_use_secure_boot = true;
 		else if (strcmp(p, "fail_securely") == 0)
-			ima_fail_unverifiable_sigs = true;
+			*fail_unverifiable_sigs = true;
 	}
 
 	return 1;
 }
+
+static int __init policy_setup(char *str)
+{
+	return ima_policy_setup(str, &init_policy_setup_data,
+				&ima_fail_unverifiable_sigs);
+}
 __setup("ima_policy=", policy_setup);
 
 int ima_default_appraise_policy_setup(const char *str,
 				      struct ima_policy_setup_data *setup_data)
 {
-	/* Currently unused. It will be implemented after namespacing ima
-	 * policy, when global variables are removed.
-	 */
+	setup_data->ima_use_appraise_tcb = true;
 	return 1;
 }
 
 static int __init default_appraise_policy_setup(char *str)
 {
-	ima_use_appraise_tcb = true;
-	return 1;
+	return ima_default_appraise_policy_setup(str, &init_policy_setup_data);
 }
 __setup("ima_appraise_tcb", default_appraise_policy_setup);
 
@@ -407,9 +390,11 @@ static bool ima_rule_contains_lsm_cond(struct ima_rule_entry *entry)
 static void ima_lsm_update_rules(void)
 {
 	struct ima_rule_entry *entry, *e;
+	struct ima_namespace *ima_ns = get_current_ns();
 	int result;
 
-	list_for_each_entry_safe(entry, e, &ima_policy_rules, list) {
+	list_for_each_entry_safe(entry, e,
+				 &ima_ns->policy_data->ima_policy_rules, list) {
 		if (!ima_rule_contains_lsm_cond(entry))
 			continue;
 
@@ -615,12 +600,13 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 {
 	struct ima_rule_entry *entry;
 	int action = 0, actmask = flags | (flags << 1);
+	bool fail_unverifiable_sigs;
 
 	if (template_desc)
 		*template_desc = ima_template_desc_current();
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(entry, ima_rules, list) {
+	list_for_each_entry_rcu(entry, ima_ns->policy_data->ima_rules, list) {
 
 		if (!(entry->action & actmask))
 			continue;
@@ -635,7 +621,10 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 		if (entry->action & IMA_APPRAISE) {
 			action |= get_subaction(entry, func);
 			action &= ~IMA_HASH;
-			if (ima_fail_unverifiable_sigs)
+			fail_unverifiable_sigs = (ima_ns == &init_ima_ns) ?
+				ima_fail_unverifiable_sigs :
+				ima_ns->policy_data->ima_fail_unverifiable_sigs;
+			if (fail_unverifiable_sigs)
 				action |= IMA_FAIL_UNVERIFIABLE_SIGS;
 		}
 
@@ -670,14 +659,15 @@ void ima_update_policy_flag(struct ima_namespace *ima_ns)
 {
 	struct ima_rule_entry *entry;
 
-	list_for_each_entry(entry, ima_rules, list) {
+	list_for_each_entry(entry, ima_ns->policy_data->ima_rules, list) {
 		if (entry->action & IMA_DO_MASK)
-			ima_policy_flag |= entry->action;
+			ima_ns->policy_data->ima_policy_flag |= entry->action;
 	}
 
-	ima_appraise |= (build_ima_appraise | temp_ima_appraise);
-	if (!ima_appraise)
-		ima_policy_flag &= ~IMA_APPRAISE;
+	ima_ns->policy_data->ima_appraise |=
+		(build_ima_appraise | ima_ns->policy_data->temp_ima_appraise);
+	if (!ima_ns->policy_data->ima_appraise)
+		ima_ns->policy_data->ima_policy_flag &= ~IMA_APPRAISE;
 }
 
 static int ima_appraise_flag(enum ima_hooks func)
@@ -693,7 +683,7 @@ static int ima_appraise_flag(enum ima_hooks func)
 	return 0;
 }
 
-static void add_rules(struct ima_policy_data *policy_data,
+static void add_rules(struct ima_namespace *ima_ns,
 		      struct ima_rule_entry *entries, int count,
 		      enum policy_rule_list policy_rule)
 {
@@ -702,8 +692,18 @@ static void add_rules(struct ima_policy_data *policy_data,
 	for (i = 0; i < count; i++) {
 		struct ima_rule_entry *entry;
 
-		if (policy_rule & IMA_DEFAULT_POLICY)
-			list_add_tail(&entries[i].list, &ima_default_rules);
+		if (policy_rule & IMA_DEFAULT_POLICY) {
+			entry = &entries[i];
+			if (ima_ns != &init_ima_ns) {
+				entry = kmemdup(&entries[i], sizeof(*entry),
+						GFP_KERNEL);
+				if (!entry)
+					continue;
+			}
+
+			list_add_tail(&entry->list,
+				      &ima_ns->policy_data->ima_default_rules);
+		}
 
 		if (policy_rule & IMA_CUSTOM_POLICY) {
 			entry = kmemdup(&entries[i], sizeof(*entry),
@@ -711,11 +711,12 @@ static void add_rules(struct ima_policy_data *policy_data,
 			if (!entry)
 				continue;
 
-			list_add_tail(&entry->list, &ima_policy_rules);
+			list_add_tail(&entry->list,
+				      &ima_ns->policy_data->ima_policy_rules);
 		}
 		if (entries[i].action == APPRAISE) {
 			if (entries != build_appraise_rules)
-				temp_ima_appraise |=
+				ima_ns->policy_data->temp_ima_appraise |=
 					ima_appraise_flag(entries[i].func);
 			else
 				build_ima_appraise |=
@@ -775,63 +776,58 @@ static int __init ima_init_arch_policy(void)
 void ima_init_ns_policy(struct ima_namespace *ima_ns,
 			const struct ima_policy_setup_data *setup_data)
 {
-	/* Set policy rules to the empty set of default rules. The rest will be
-	 * implemented after namespacing policy.
-	 */
-	ima_ns->policy_data->ima_rules =
-		&ima_ns->policy_data->ima_default_rules;
-}
+	int build_appraise_entries;
 
-/**
- * ima_init_policy - initialize the default measure rules.
- *
- * ima_rules points to either the ima_default_rules or the
- * the new ima_policy_rules.
- */
-void __init ima_init_policy(void)
-{
-	int build_appraise_entries, arch_entries;
+	ima_ns->policy_data->ima_appraise = setup_data->ima_appraise;
+
+	if (ima_ns == &init_ima_ns) {
+		/*
+		 * Based on runtime secure boot flags, insert arch specific
+		 * measurement and appraise rules requiring file signatures for
+		 * both the initial and custom policies, prior to other
+		 * appraise rules. (Highest priority)
+		 */
+		arch_entries_size = ima_init_arch_policy();
+		if (!arch_entries_size)
+			pr_info("No architecture policies found\n");
+
+		ima_ns->policy_data->ima_fail_unverifiable_sigs =
+			ima_fail_unverifiable_sigs;
+	}
 
 	/* if !ima_policy, we load NO default rules */
-	if (ima_policy)
-		add_rules(NULL,
-			  dont_measure_rules, ARRAY_SIZE(dont_measure_rules),
+	if (setup_data->ima_policy)
+		add_rules(ima_ns, dont_measure_rules,
+			  ARRAY_SIZE(dont_measure_rules),
 			  IMA_DEFAULT_POLICY);
 
-	switch (ima_policy) {
+	switch (setup_data->ima_policy) {
 	case ORIGINAL_TCB:
-		add_rules(NULL, original_measurement_rules,
+		add_rules(ima_ns, original_measurement_rules,
 			  ARRAY_SIZE(original_measurement_rules),
 			  IMA_DEFAULT_POLICY);
 		break;
 	case DEFAULT_TCB:
-		add_rules(NULL, default_measurement_rules,
+		add_rules(ima_ns, default_measurement_rules,
 			  ARRAY_SIZE(default_measurement_rules),
 			  IMA_DEFAULT_POLICY);
 	default:
 		break;
 	}
 
-	/*
-	 * Based on runtime secure boot flags, insert arch specific measurement
-	 * and appraise rules requiring file signatures for both the initial
-	 * and custom policies, prior to other appraise rules.
-	 * (Highest priority)
-	 */
-	arch_entries = ima_init_arch_policy();
-	if (!arch_entries)
-		pr_info("No architecture policies found\n");
-	else
-		add_rules(NULL, arch_policy_entry, arch_entries,
+	if (arch_entries_size)
+		add_rules(ima_ns,
+			  arch_policy_entry,
+			  arch_entries_size,
 			  IMA_DEFAULT_POLICY | IMA_CUSTOM_POLICY);
 
 	/*
 	 * Insert the builtin "secure_boot" policy rules requiring file
 	 * signatures, prior to other appraise rules.
 	 */
-	if (ima_use_secure_boot)
-		add_rules(NULL,
-			  secure_boot_rules, ARRAY_SIZE(secure_boot_rules),
+	if (setup_data->ima_use_secure_boot)
+		add_rules(ima_ns, secure_boot_rules,
+			  ARRAY_SIZE(secure_boot_rules),
 			  IMA_DEFAULT_POLICY);
 
 	/*
@@ -841,29 +837,39 @@ void __init ima_init_policy(void)
 	 * rules, include either one or the other set of rules, but not both.
 	 */
 	build_appraise_entries = ARRAY_SIZE(build_appraise_rules);
-	if (build_appraise_entries) {
-		if (ima_use_secure_boot)
-			add_rules(NULL,
-				  build_appraise_rules, build_appraise_entries,
+	if (build_appraise_entries && (ima_ns == &init_ima_ns)) {
+		if (setup_data->ima_use_secure_boot)
+			add_rules(ima_ns, build_appraise_rules,
+				  build_appraise_entries,
 				  IMA_CUSTOM_POLICY);
 		else
-			add_rules(NULL,
-				  build_appraise_rules, build_appraise_entries,
+			add_rules(ima_ns, build_appraise_rules,
+				  build_appraise_entries,
 				  IMA_DEFAULT_POLICY | IMA_CUSTOM_POLICY);
 	}
 
-	if (ima_use_appraise_tcb)
-		add_rules(NULL, default_appraise_rules,
+	if (setup_data->ima_use_appraise_tcb)
+		add_rules(ima_ns, default_appraise_rules,
 			  ARRAY_SIZE(default_appraise_rules),
 			  IMA_DEFAULT_POLICY);
 
-	ima_update_policy_flag(NULL);
+	ima_ns->policy_data->ima_rules =
+		&ima_ns->policy_data->ima_default_rules;
+	ima_update_policy_flag(ima_ns);
+}
+
+/**
+ * ima_init_policy - initialize the default measure rules for the initial ima ns
+ */
+void __init ima_init_policy(void)
+{
+	ima_init_ns_policy(&init_ima_ns, &init_policy_setup_data);
 }
 
 /* Make sure we have a valid policy, at least containing some rules. */
 int ima_check_policy(const struct ima_namespace *ima_ns)
 {
-	if (list_empty(&ima_temp_rules))
+	if (list_empty(&ima_ns->policy_data->ima_temp_rules))
 		return -EINVAL;
 	return 0;
 }
@@ -881,14 +887,18 @@ int ima_check_policy(const struct ima_namespace *ima_ns)
  */
 void ima_update_policy(void)
 {
-	struct list_head *policy = &ima_policy_rules;
+	/* Update only the current ima namespace */
+	struct ima_namespace *ima_ns = get_current_ns();
+	struct list_head *policy = &ima_ns->policy_data->ima_policy_rules;
 
-	list_splice_tail_init_rcu(&ima_temp_rules, policy, synchronize_rcu);
+	list_splice_tail_init_rcu(&ima_ns->policy_data->ima_temp_rules,
+				  policy, synchronize_rcu);
 
-	if (ima_rules != policy) {
-		ima_policy_flag = 0;
-		ima_rules = policy;
+	if (ima_ns->policy_data->ima_rules != policy) {
+		ima_ns->policy_data->ima_policy_flag = 0;
+		ima_ns->policy_data->ima_rules = policy;
 
+#ifndef CONFIG_IMA_NS
 		/*
 		 * IMA architecture specific policy rules are specified
 		 * as strings and converted to an array of ima_entry_rules
@@ -896,8 +906,9 @@ void ima_update_policy(void)
 		 * architecture specific rules stored as an array.
 		 */
 		kfree(arch_policy_entry);
+#endif
 	}
-	ima_update_policy_flag(NULL);
+	ima_update_policy_flag(ima_ns);
 
 	/* Custom IMA policy has been loaded */
 	ima_process_queued_keys();
@@ -960,6 +971,7 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 			     substring_t *args, int lsm_rule, int audit_type)
 {
 	int result;
+	struct ima_namespace *ima_ns = get_current_ns();
 
 	if (entry->lsm[lsm_rule].rule)
 		return -EINVAL;
@@ -976,7 +988,8 @@ static int ima_lsm_rule_init(struct ima_rule_entry *entry,
 		pr_warn("rule for LSM \'%s\' is undefined\n",
 			entry->lsm[lsm_rule].args_p);
 
-		if (ima_rules == &ima_default_rules) {
+		if (ima_ns->policy_data->ima_rules ==
+		    &ima_ns->policy_data->ima_default_rules) {
 			kfree(entry->lsm[lsm_rule].args_p);
 			entry->lsm[lsm_rule].args_p = NULL;
 			result = -EINVAL;
@@ -1137,6 +1150,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 	struct ima_template_desc *template_desc;
 	int result = 0;
 	size_t keyrings_len;
+	struct ima_namespace *ima_ns = get_current_ns();
 
 	ab = integrity_audit_log_start(audit_context(), GFP_KERNEL,
 				       AUDIT_INTEGRITY_POLICY_RULE);
@@ -1506,7 +1520,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 	if (!result && !ima_validate_rule(entry))
 		result = -EINVAL;
 	else if (entry->action == APPRAISE)
-		temp_ima_appraise |= ima_appraise_flag(entry->func);
+		ima_ns->policy_data->temp_ima_appraise |=
+			ima_appraise_flag(entry->func);
 
 	if (!result && entry->flags & IMA_MODSIG_ALLOWED) {
 		template_desc = entry->template ? entry->template :
@@ -1533,6 +1548,8 @@ ssize_t ima_parse_add_rule(char *rule)
 	struct ima_rule_entry *entry;
 	ssize_t result, len;
 	int audit_info = 0;
+	/* Add rules only to the current ima namespace */
+	struct ima_namespace *ima_ns = get_current_ns();
 
 	p = strsep(&rule, "\n");
 	len = strlen(p) + 1;
@@ -1559,7 +1576,7 @@ ssize_t ima_parse_add_rule(char *rule)
 		return result;
 	}
 
-	list_add_tail(&entry->list, &ima_temp_rules);
+	list_add_tail(&entry->list, &ima_ns->policy_data->ima_temp_rules);
 
 	return len;
 }
@@ -1571,15 +1588,51 @@ ssize_t ima_parse_add_rule(char *rule)
  * ima_delete_rules() at a time.
  */
 void ima_delete_rules(void)
+{
+	/* Delete rules only from the current ima namespace */
+	struct ima_namespace *ima_ns = get_current_ns();
+	struct ima_rule_entry *entry, *tmp;
+
+	ima_ns->policy_data->temp_ima_appraise = 0;
+	list_for_each_entry_safe(entry, tmp,
+				 &ima_ns->policy_data->ima_temp_rules, list) {
+		list_del(&entry->list);
+		ima_free_rule(entry);
+	}
+}
+
+#ifdef CONFIG_IMA_NS
+/**
+ * ima_delete_ns_rules - delete policy rules and free the memory
+ * @policy_data: a pointer to the policy data of the given namespace
+ * @is_root_ns: indicates if the namespace being cleaned up is the root
+ * namespace
+ *
+ * This function should be called only for the inactive namespace, when it is
+ * being destroyed.
+ */
+void ima_delete_ns_rules(struct ima_policy_data *policy_data,
+			 bool is_root_ns)
 {
 	struct ima_rule_entry *entry, *tmp;
 
-	temp_ima_appraise = 0;
-	list_for_each_entry_safe(entry, tmp, &ima_temp_rules, list) {
+	/* no locks necessary, namespace is inactive */
+	list_for_each_entry_safe(entry, tmp,
+				 &policy_data->ima_policy_rules, list) {
 		list_del(&entry->list);
 		ima_free_rule(entry);
 	}
+
+	if (!is_root_ns) {
+		list_for_each_entry_safe(entry, tmp,
+					 &policy_data->ima_default_rules,
+					 list) {
+			list_del(&entry->list);
+			ima_free_rule(entry);
+		}
+	}
 }
+#endif
 
 #define __ima_hook_stringify(func, str)	(#func),
 
@@ -1603,9 +1656,10 @@ void *ima_policy_start(struct seq_file *m, loff_t *pos)
 {
 	loff_t l = *pos;
 	struct ima_rule_entry *entry;
+	struct ima_namespace *ima_ns = get_current_ns();
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(entry, ima_rules, list) {
+	list_for_each_entry_rcu(entry, ima_ns->policy_data->ima_rules, list) {
 		if (!l--) {
 			rcu_read_unlock();
 			return entry;
@@ -1617,6 +1671,7 @@ void *ima_policy_start(struct seq_file *m, loff_t *pos)
 
 void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos)
 {
+	struct ima_namespace *ima_ns = get_current_ns();
 	struct ima_rule_entry *entry = v;
 
 	rcu_read_lock();
@@ -1624,7 +1679,7 @@ void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos)
 	rcu_read_unlock();
 	(*pos)++;
 
-	return (&entry->list == ima_rules) ? NULL : entry;
+	return (&entry->list == ima_ns->policy_data->ima_rules) ? NULL : entry;
 }
 
 void ima_policy_stop(struct seq_file *m, void *v)
@@ -1809,6 +1864,7 @@ int ima_policy_show(struct seq_file *m, void *v)
  */
 bool ima_appraise_signature(enum kernel_read_file_id id)
 {
+	struct ima_namespace *ima_ns = get_current_ns();
 	struct ima_rule_entry *entry;
 	bool found = false;
 	enum ima_hooks func;
@@ -1819,7 +1875,7 @@ bool ima_appraise_signature(enum kernel_read_file_id id)
 	func = read_idmap[id] ?: FILE_CHECK;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(entry, ima_rules, list) {
+	list_for_each_entry_rcu(entry, ima_ns->policy_data->ima_rules, list) {
 		if (entry->action != APPRAISE)
 			continue;
 
diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
index 34ca54ba52b7..542cbe894a99 100644
--- a/security/integrity/ima/ima_queue_keys.c
+++ b/security/integrity/ima/ima_queue_keys.c
@@ -110,8 +110,11 @@ bool ima_queue_key(struct key *keyring, const void *payload,
 	if (!entry)
 		return false;
 
+	/* Queued keys will be processed according to the root IMA namespace
+	 * policy, therefore allow queueing only for the root namespace.
+	 */
 	mutex_lock(&ima_keys_lock);
-	if (!ima_process_keys) {
+	if (!ima_process_keys && (get_current_ns() == &init_ima_ns)) {
 		list_add_tail(&entry->list, &ima_keys);
 		queued = true;
 	}
@@ -158,12 +161,15 @@ void ima_process_queued_keys(void)
 
 	list_for_each_entry_safe(entry, tmp, &ima_keys, list) {
 		if (!timer_expired)
+			/* Queued keys are always measured according to the
+			 * initial namespace policy.
+			 */
 			process_buffer_measurement(NULL, entry->payload,
 						   entry->payload_len,
 						   entry->keyring_name,
 						   KEY_CHECK, 0,
 						   entry->keyring_name,
-						   NULL);
+						   &init_ima_ns);
 		list_del(&entry->list);
 		ima_free_key_entry(entry);
 	}
diff --git a/security/security.c b/security/security.c
index 70a7ad357bc6..9eb78909cc03 100644
--- a/security/security.c
+++ b/security/security.c
@@ -988,7 +988,7 @@ static void inode_free_by_rcu(struct rcu_head *head)
 
 void security_inode_free(struct inode *inode)
 {
-	integrity_inode_free(inode);
+	ima_inode_free(inode);
 	call_void_hook(inode_free_security, inode);
 	/*
 	 * The inode may still be referenced in a path walk and
-- 
2.20.1

