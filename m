Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9F42489C1
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 17:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgHRP0Y (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Aug 2020 11:26:24 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2629 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728072AbgHRP0V (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 11:26:21 -0400
Received: from lhreml722-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id D6365A8F61BFE861120E;
        Tue, 18 Aug 2020 16:26:19 +0100 (IST)
Received: from kstruczy-linux-box (10.204.65.138) by
 lhreml722-chm.china.huawei.com (10.201.108.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 18 Aug 2020 16:26:18 +0100
Received: by kstruczy-linux-box (sSMTP sendmail emulation); Tue, 18 Aug 2020 17:26:20 +0200
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
Subject: [RFC PATCH 06/30] ima: Add ima namespace to the ima subsystem APIs
Date:   Tue, 18 Aug 2020 17:20:13 +0200
Message-ID: <20200818152037.11869-7-krzysztof.struczynski@huawei.com>
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

Add ima namespace pointer to the input parameters of the relevant
functions. This is a preparation for the policy namespacing, more
functions may be modified later, when other aspects of the ima are
namespaced.

Signed-off-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
---
 include/linux/ima.h                          |  4 +--
 security/integrity/ima/ima.h                 | 25 ++++++++-----
 security/integrity/ima/ima_api.c             |  6 ++--
 security/integrity/ima/ima_appraise.c        | 16 +++++----
 security/integrity/ima/ima_asymmetric_keys.c |  3 +-
 security/integrity/ima/ima_fs.c              |  2 +-
 security/integrity/ima/ima_main.c            | 38 +++++++++++---------
 security/integrity/ima/ima_policy.c          | 36 +++++++++++--------
 security/integrity/ima/ima_queue_keys.c      |  3 +-
 9 files changed, 80 insertions(+), 53 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index d61c9c21ffb9..3fd3746a0dee 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -140,13 +140,13 @@ static inline void ima_post_key_create_or_update(struct key *keyring,
 #endif  /* CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS */
 
 #ifdef CONFIG_IMA_APPRAISE
-extern bool is_ima_appraise_enabled(void);
+extern bool is_ima_appraise_enabled(const struct ima_namespace *ima_ns);
 extern void ima_inode_post_setattr(struct dentry *dentry);
 extern int ima_inode_setxattr(struct dentry *dentry, const char *xattr_name,
 		       const void *xattr_value, size_t xattr_value_len);
 extern int ima_inode_removexattr(struct dentry *dentry, const char *xattr_name);
 #else
-static inline bool is_ima_appraise_enabled(void)
+static inline bool is_ima_appraise_enabled(const struct ima_namespace *ima_ns)
 {
 	return 0;
 }
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 4872f193f7a3..7d522fdab0d8 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -264,7 +264,8 @@ static inline void ima_process_queued_keys(void) {}
 int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
 		   int mask, enum ima_hooks func, int *pcr,
 		   struct ima_template_desc **template_desc,
-		   const char *keyring);
+		   const char *keyring,
+		   const struct ima_namespace *ima_ns);
 int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
 int ima_collect_measurement(struct integrity_iint_cache *iint,
 			    struct file *file, void *buf, loff_t size,
@@ -276,7 +277,8 @@ void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
 			   struct ima_template_desc *template_desc);
 void process_buffer_measurement(struct inode *inode, const void *buf, int size,
 				const char *eventname, enum ima_hooks func,
-				int pcr, const char *keyring);
+				int pcr, const char *keyring,
+				struct ima_namespace *ima_ns);
 void ima_audit_measurement(struct integrity_iint_cache *iint,
 			   const unsigned char *filename);
 int ima_alloc_init_template(struct ima_event_data *event_data,
@@ -292,15 +294,16 @@ const char *ima_d_path(const struct path *path, char **pathbuf, char *filename);
 int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 		     enum ima_hooks func, int mask, int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
-		     const char *keyring);
+		     const char *keyring,
+		     const struct ima_namespace *ima_ns);
 void ima_init_policy(void);
 void ima_init_ns_policy(struct ima_namespace *ima_ns,
 			const struct ima_policy_setup_data *policy_setup_data);
 void ima_update_policy(void);
-void ima_update_policy_flag(void);
+void ima_update_policy_flag(struct ima_namespace *ima_ns);
 ssize_t ima_parse_add_rule(char *);
 void ima_delete_rules(void);
-int ima_check_policy(void);
+int ima_check_policy(const struct ima_namespace *ima_ns);
 void *ima_policy_start(struct seq_file *m, loff_t *pos);
 void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos);
 void ima_policy_stop(struct seq_file *m, void *v);
@@ -327,13 +330,15 @@ int ima_default_appraise_setup(const char *str,
 
 #ifdef CONFIG_IMA_APPRAISE
 int ima_check_blacklist(struct integrity_iint_cache *iint,
-			const struct modsig *modsig, int pcr);
+			const struct modsig *modsig, int pcr,
+			struct ima_namespace *ima_ns);
 int ima_appraise_measurement(enum ima_hooks func,
 			     struct integrity_iint_cache *iint,
 			     struct file *file, const unsigned char *filename,
 			     struct evm_ima_xattr_data *xattr_value,
 			     int xattr_len, const struct modsig *modsig);
-int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func);
+int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func,
+		      struct ima_namespace *ima_ns);
 void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file);
 enum integrity_status ima_get_cache_status(struct integrity_iint_cache *iint,
 					   enum ima_hooks func);
@@ -344,7 +349,8 @@ int ima_read_xattr(struct dentry *dentry,
 
 #else
 static inline int ima_check_blacklist(struct integrity_iint_cache *iint,
-				      const struct modsig *modsig, int pcr)
+				      const struct modsig *modsig, int pcr,
+				      struct ima_namespace *ima_ns)
 {
 	return 0;
 }
@@ -361,7 +367,8 @@ static inline int ima_appraise_measurement(enum ima_hooks func,
 }
 
 static inline int ima_must_appraise(struct inode *inode, int mask,
-				    enum ima_hooks func)
+				    enum ima_hooks func,
+				    struct ima_namespace *ima_ns)
 {
 	return 0;
 }
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index 4f39fb93f278..8b41183200e8 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -171,6 +171,7 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
  * @pcr: pointer filled in if matched measure policy sets pcr=
  * @template_desc: pointer filled in if matched measure policy sets template=
  * @keyring: keyring name used to determine the action
+ * @ima_ns: ima namespace whose policy data will be used
  *
  * The policy is defined in terms of keypairs:
  *		subj=, obj=, type=, func=, mask=, fsmagic=
@@ -186,14 +187,15 @@ void ima_add_violation(struct file *file, const unsigned char *filename,
 int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
 		   int mask, enum ima_hooks func, int *pcr,
 		   struct ima_template_desc **template_desc,
-		   const char *keyring)
+		   const char *keyring,
+		   const struct ima_namespace *ima_ns)
 {
 	int flags = IMA_MEASURE | IMA_AUDIT | IMA_APPRAISE | IMA_HASH;
 
 	flags &= ima_policy_flag;
 
 	return ima_match_policy(inode, cred, secid, func, mask, flags, pcr,
-				template_desc, keyring);
+				template_desc, keyring, ima_ns);
 }
 
 /*
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 0632d3881611..9388ff88ca4d 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -48,10 +48,11 @@ __setup("ima_appraise=", default_appraise_setup);
 
 /*
  * is_ima_appraise_enabled - return appraise status
+ * @ima_ns: pointer to the ima namespace being checked
  *
  * Only return enabled, if not in ima_appraise="fix" or "log" modes.
  */
-bool is_ima_appraise_enabled(void)
+bool is_ima_appraise_enabled(const struct ima_namespace *ima_ns)
 {
 	return ima_appraise & IMA_APPRAISE_ENFORCE;
 }
@@ -61,7 +62,8 @@ bool is_ima_appraise_enabled(void)
  *
  * Return 1 to appraise or hash
  */
-int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func)
+int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func,
+		      struct ima_namespace *ima_ns)
 {
 	u32 secid;
 
@@ -70,7 +72,8 @@ int ima_must_appraise(struct inode *inode, int mask, enum ima_hooks func)
 
 	security_task_getsecid(current, &secid);
 	return ima_match_policy(inode, current_cred(), secid, func, mask,
-				IMA_APPRAISE | IMA_HASH, NULL, NULL, NULL);
+				IMA_APPRAISE | IMA_HASH, NULL, NULL, NULL,
+				NULL);
 }
 
 static int ima_fix_xattr(struct dentry *dentry,
@@ -328,7 +331,8 @@ static int modsig_verify(enum ima_hooks func, const struct modsig *modsig,
  * Returns -EPERM if the hash is blacklisted.
  */
 int ima_check_blacklist(struct integrity_iint_cache *iint,
-			const struct modsig *modsig, int pcr)
+			const struct modsig *modsig, int pcr,
+			struct ima_namespace *ima_ns)
 {
 	enum hash_algo hash_algo;
 	const u8 *digest = NULL;
@@ -345,7 +349,7 @@ int ima_check_blacklist(struct integrity_iint_cache *iint,
 		if ((rc == -EPERM) && (iint->flags & IMA_MEASURE))
 			process_buffer_measurement(NULL, digest, digestsize,
 						   "blacklisted-hash", NONE,
-						   pcr, NULL);
+						   pcr, NULL, NULL);
 	}
 
 	return rc;
@@ -511,7 +515,7 @@ void ima_inode_post_setattr(struct dentry *dentry)
 	    || !(inode->i_opflags & IOP_XATTR))
 		return;
 
-	action = ima_must_appraise(inode, MAY_ACCESS, POST_SETATTR);
+	action = ima_must_appraise(inode, MAY_ACCESS, POST_SETATTR, NULL);
 	if (!action)
 		__vfs_removexattr(dentry, XATTR_NAME_IMA);
 	iint = integrity_iint_find(inode);
diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index 1c68c500c26f..58aa56b0422d 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -60,5 +60,6 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 	 */
 	process_buffer_measurement(NULL, payload, payload_len,
 				   keyring->description, KEY_CHECK, 0,
-				   keyring->description);
+				   keyring->description,
+				   NULL);
 }
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index e3fcad871861..97aadee7e68e 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -410,7 +410,7 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 	if ((file->f_flags & O_ACCMODE) == O_RDONLY)
 		return seq_release(inode, file);
 
-	if (valid_policy && ima_check_policy() < 0) {
+	if (valid_policy && ima_check_policy(NULL) < 0) {
 		cause = "failed";
 		valid_policy = 0;
 	}
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index c7e29277b953..196fa2bd490d 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -109,7 +109,8 @@ static void ima_rdwr_violation_check(struct file *file,
 				     int must_measure,
 				     char **pathbuf,
 				     const char **pathname,
-				     char *filename)
+				     char *filename,
+				     struct ima_namespace *ima_ns)
 {
 	struct inode *inode = file_inode(file);
 	fmode_t mode = file->f_mode;
@@ -215,7 +216,8 @@ void ima_file_free(struct file *file)
 
 static int process_measurement(struct file *file, const struct cred *cred,
 			       u32 secid, char *buf, loff_t size, int mask,
-			       enum ima_hooks func)
+			       enum ima_hooks func,
+			       struct ima_namespace *ima_ns)
 {
 	struct inode *inode = file_inode(file);
 	struct integrity_iint_cache *iint = NULL;
@@ -239,7 +241,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	 * Included is the appraise submask.
 	 */
 	action = ima_get_action(inode, cred, secid, mask, func, &pcr,
-				&template_desc, NULL);
+				&template_desc, NULL, ima_ns);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
 			   (ima_policy_flag & IMA_MEASURE));
 	if (!action && !violation_check)
@@ -261,7 +263,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 
 	if (!rc && violation_check)
 		ima_rdwr_violation_check(file, iint, action & IMA_MEASURE,
-					 &pathbuf, &pathname, filename);
+					 &pathbuf, &pathname, filename, ima_ns);
 
 	inode_unlock(inode);
 
@@ -359,7 +361,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 				      xattr_value, xattr_len, modsig, pcr,
 				      template_desc);
 	if (rc == 0 && (action & IMA_APPRAISE_SUBMASK)) {
-		rc = ima_check_blacklist(iint, modsig, pcr);
+		rc = ima_check_blacklist(iint, modsig, pcr, ima_ns);
 		if (rc != -EPERM) {
 			inode_lock(inode);
 			rc = ima_appraise_measurement(func, iint, file,
@@ -413,7 +415,7 @@ int ima_file_mmap(struct file *file, unsigned long prot)
 	if (file && (prot & PROT_EXEC)) {
 		security_task_getsecid(current, &secid);
 		return process_measurement(file, current_cred(), secid, NULL,
-					   0, MAY_EXEC, MMAP_CHECK);
+					   0, MAY_EXEC, MMAP_CHECK, NULL);
 	}
 
 	return 0;
@@ -452,7 +454,7 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 	security_task_getsecid(current, &secid);
 	inode = file_inode(vma->vm_file);
 	action = ima_get_action(inode, current_cred(), secid, MAY_EXEC,
-				MMAP_CHECK, &pcr, &template, 0);
+				MMAP_CHECK, &pcr, &template, 0, NULL);
 
 	/* Is the mmap'ed file in policy? */
 	if (!(action & (IMA_MEASURE | IMA_APPRAISE_SUBMASK)))
@@ -491,13 +493,13 @@ int ima_bprm_check(struct linux_binprm *bprm)
 
 	security_task_getsecid(current, &secid);
 	ret = process_measurement(bprm->file, current_cred(), secid, NULL, 0,
-				  MAY_EXEC, BPRM_CHECK);
+				  MAY_EXEC, BPRM_CHECK, NULL);
 	if (ret)
 		return ret;
 
 	security_cred_getsecid(bprm->cred, &secid);
 	return process_measurement(bprm->file, bprm->cred, secid, NULL, 0,
-				   MAY_EXEC, CREDS_CHECK);
+				   MAY_EXEC, CREDS_CHECK, NULL);
 }
 
 /**
@@ -517,7 +519,7 @@ int ima_file_check(struct file *file, int mask)
 	security_task_getsecid(current, &secid);
 	return process_measurement(file, current_cred(), secid, NULL, 0,
 				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
-					   MAY_APPEND), FILE_CHECK);
+					   MAY_APPEND), FILE_CHECK, NULL);
 }
 EXPORT_SYMBOL_GPL(ima_file_check);
 
@@ -583,7 +585,7 @@ void ima_post_create_tmpfile(struct inode *inode)
 	struct integrity_iint_cache *iint;
 	int must_appraise;
 
-	must_appraise = ima_must_appraise(inode, MAY_ACCESS, FILE_CHECK);
+	must_appraise = ima_must_appraise(inode, MAY_ACCESS, FILE_CHECK, NULL);
 	if (!must_appraise)
 		return;
 
@@ -610,7 +612,7 @@ void ima_post_path_mknod(struct dentry *dentry)
 	struct inode *inode = dentry->d_inode;
 	int must_appraise;
 
-	must_appraise = ima_must_appraise(inode, MAY_ACCESS, FILE_CHECK);
+	must_appraise = ima_must_appraise(inode, MAY_ACCESS, FILE_CHECK, NULL);
 	if (!must_appraise)
 		return;
 
@@ -697,7 +699,7 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 	func = read_idmap[read_id] ?: FILE_CHECK;
 	security_task_getsecid(current, &secid);
 	return process_measurement(file, current_cred(), secid, buf, size,
-				   MAY_READ, func);
+				   MAY_READ, func, NULL);
 }
 
 /**
@@ -764,7 +766,8 @@ int ima_load_data(enum kernel_load_data_id id)
  */
 void process_buffer_measurement(struct inode *inode, const void *buf, int size,
 				const char *eventname, enum ima_hooks func,
-				int pcr, const char *keyring)
+				int pcr, const char *keyring,
+				struct ima_namespace *ima_ns)
 {
 	int ret = 0;
 	const char *audit_cause = "ENOMEM";
@@ -796,7 +799,7 @@ void process_buffer_measurement(struct inode *inode, const void *buf, int size,
 	if (func) {
 		security_task_getsecid(current, &secid);
 		action = ima_get_action(inode, current_cred(), secid, 0, func,
-					&pcr, &template, keyring);
+					&pcr, &template, keyring, NULL);
 		if (!(action & IMA_MEASURE))
 			return;
 	}
@@ -868,7 +871,8 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
 		return;
 
 	process_buffer_measurement(file_inode(f.file), buf, size,
-				   "kexec-cmdline", KEXEC_CMDLINE, 0, NULL);
+				   "kexec-cmdline", KEXEC_CMDLINE, 0, NULL,
+				   NULL);
 	fdput(f);
 }
 
@@ -897,7 +901,7 @@ static int __init init_ima(void)
 		pr_warn("Couldn't register LSM notifier, error %d\n", error);
 
 	if (!error)
-		ima_update_policy_flag();
+		ima_update_policy_flag(&init_ima_ns);
 
 	return error;
 }
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 403854b18ef2..12f9dcf73c83 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -598,6 +598,7 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
  * @template_desc: the template that should be used for this rule
  * @keyring: the keyring name, if given, to be used to check in the policy.
  *           keyring can be NULL if func is anything other than KEY_CHECK.
+ * @ima_ns: IMA namespace whose policies are being checked
  *
  * Measure decision based on func/mask/fsmagic and LSM(subj/obj/type)
  * conditions.
@@ -609,7 +610,8 @@ static int get_subaction(struct ima_rule_entry *rule, enum ima_hooks func)
 int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
 		     enum ima_hooks func, int mask, int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
-		     const char *keyring)
+		     const char *keyring,
+		     const struct ima_namespace *ima_ns)
 {
 	struct ima_rule_entry *entry;
 	int action = 0, actmask = flags | (flags << 1);
@@ -662,8 +664,9 @@ int ima_match_policy(struct inode *inode, const struct cred *cred, u32 secid,
  * loaded policy.  Based on this flag, the decision to short circuit
  * out of a function or not call the function in the first place
  * can be made earlier.
+ * @ima_ns: pointer to the ima namespace whose policy flag is updated
  */
-void ima_update_policy_flag(void)
+void ima_update_policy_flag(struct ima_namespace *ima_ns)
 {
 	struct ima_rule_entry *entry;
 
@@ -690,7 +693,8 @@ static int ima_appraise_flag(enum ima_hooks func)
 	return 0;
 }
 
-static void add_rules(struct ima_rule_entry *entries, int count,
+static void add_rules(struct ima_policy_data *policy_data,
+		      struct ima_rule_entry *entries, int count,
 		      enum policy_rule_list policy_rule)
 {
 	int i = 0;
@@ -790,17 +794,18 @@ void __init ima_init_policy(void)
 
 	/* if !ima_policy, we load NO default rules */
 	if (ima_policy)
-		add_rules(dont_measure_rules, ARRAY_SIZE(dont_measure_rules),
+		add_rules(NULL,
+			  dont_measure_rules, ARRAY_SIZE(dont_measure_rules),
 			  IMA_DEFAULT_POLICY);
 
 	switch (ima_policy) {
 	case ORIGINAL_TCB:
-		add_rules(original_measurement_rules,
+		add_rules(NULL, original_measurement_rules,
 			  ARRAY_SIZE(original_measurement_rules),
 			  IMA_DEFAULT_POLICY);
 		break;
 	case DEFAULT_TCB:
-		add_rules(default_measurement_rules,
+		add_rules(NULL, default_measurement_rules,
 			  ARRAY_SIZE(default_measurement_rules),
 			  IMA_DEFAULT_POLICY);
 	default:
@@ -817,7 +822,7 @@ void __init ima_init_policy(void)
 	if (!arch_entries)
 		pr_info("No architecture policies found\n");
 	else
-		add_rules(arch_policy_entry, arch_entries,
+		add_rules(NULL, arch_policy_entry, arch_entries,
 			  IMA_DEFAULT_POLICY | IMA_CUSTOM_POLICY);
 
 	/*
@@ -825,7 +830,8 @@ void __init ima_init_policy(void)
 	 * signatures, prior to other appraise rules.
 	 */
 	if (ima_use_secure_boot)
-		add_rules(secure_boot_rules, ARRAY_SIZE(secure_boot_rules),
+		add_rules(NULL,
+			  secure_boot_rules, ARRAY_SIZE(secure_boot_rules),
 			  IMA_DEFAULT_POLICY);
 
 	/*
@@ -837,23 +843,25 @@ void __init ima_init_policy(void)
 	build_appraise_entries = ARRAY_SIZE(build_appraise_rules);
 	if (build_appraise_entries) {
 		if (ima_use_secure_boot)
-			add_rules(build_appraise_rules, build_appraise_entries,
+			add_rules(NULL,
+				  build_appraise_rules, build_appraise_entries,
 				  IMA_CUSTOM_POLICY);
 		else
-			add_rules(build_appraise_rules, build_appraise_entries,
+			add_rules(NULL,
+				  build_appraise_rules, build_appraise_entries,
 				  IMA_DEFAULT_POLICY | IMA_CUSTOM_POLICY);
 	}
 
 	if (ima_use_appraise_tcb)
-		add_rules(default_appraise_rules,
+		add_rules(NULL, default_appraise_rules,
 			  ARRAY_SIZE(default_appraise_rules),
 			  IMA_DEFAULT_POLICY);
 
-	ima_update_policy_flag();
+	ima_update_policy_flag(NULL);
 }
 
 /* Make sure we have a valid policy, at least containing some rules. */
-int ima_check_policy(void)
+int ima_check_policy(const struct ima_namespace *ima_ns)
 {
 	if (list_empty(&ima_temp_rules))
 		return -EINVAL;
@@ -889,7 +897,7 @@ void ima_update_policy(void)
 		 */
 		kfree(arch_policy_entry);
 	}
-	ima_update_policy_flag();
+	ima_update_policy_flag(NULL);
 
 	/* Custom IMA policy has been loaded */
 	ima_process_queued_keys();
diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
index 69a8626a35c0..34ca54ba52b7 100644
--- a/security/integrity/ima/ima_queue_keys.c
+++ b/security/integrity/ima/ima_queue_keys.c
@@ -162,7 +162,8 @@ void ima_process_queued_keys(void)
 						   entry->payload_len,
 						   entry->keyring_name,
 						   KEY_CHECK, 0,
-						   entry->keyring_name);
+						   entry->keyring_name,
+						   NULL);
 		list_del(&entry->list);
 		ima_free_key_entry(entry);
 	}
-- 
2.20.1

