Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07CDF48467A
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Jan 2022 18:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235713AbiADRFL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Jan 2022 12:05:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29188 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235673AbiADRFB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Jan 2022 12:05:01 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 204Enfm4004395;
        Tue, 4 Jan 2022 17:04:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=29DoXfIyP8xt897nTk0juf69RV20kB7+olSryz9Ebx8=;
 b=dzfzN6164cwFfYQ2dOhrIxyJxidw3Loqom3XqbrENHgsM+wwITEzPZqQdAQg4ORPBLp/
 imqwx+FeZ0CVotFXkIaH266trHAlh6t6Bxfasblyw0RoUUOGNPolyarfjaa7HgiV7+Wp
 9nCmxkzNbeUoha+nVXA1Msnr9ebhX7xFm2OnrLFBYGNhsy+l9UPrvUTHCsPE5iZACnnn
 C4C4kd2+IYesEeb5K38RNPoC07gJkJ1Wis2cBLrzmkQ0LitXxdjXXyBEpUwY4JkZ8QZe
 fEnDM08useIFzHmum9xU9KjbBqzxT638yLPK3nImSGE9evy8KlYWkprHanoaxrkrZVlS IQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dcrb6jkau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 17:04:34 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 204GjxQe032684;
        Tue, 4 Jan 2022 17:04:34 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dcrb6jkag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 17:04:34 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 204H2jhK030187;
        Tue, 4 Jan 2022 17:04:33 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma01dal.us.ibm.com with ESMTP id 3daekatdpt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Jan 2022 17:04:33 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 204H4V8k27263312
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Jan 2022 17:04:31 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 79B7BAC05B;
        Tue,  4 Jan 2022 17:04:31 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52F5BAC06A;
        Tue,  4 Jan 2022 17:04:31 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  4 Jan 2022 17:04:31 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v8 19/19] ima: Enable IMA namespaces
Date:   Tue,  4 Jan 2022 12:04:16 -0500
Message-Id: <20220104170416.1923685-20-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220104170416.1923685-1-stefanb@linux.vnet.ibm.com>
References: <20220104170416.1923685-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Zku6R3aE21TDAQnK5L9Gm_Whg0oy4SY9
X-Proofpoint-GUID: qVDzUp-w36UfOEkZNbNn_OIPZMbZfynp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-04_08,2022-01-04_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201040114
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Introduce the IMA_NS in Kconfig for IMA namespace enablement.

Enable the lazy initialization of an IMA namespace when a user mounts
SecurityFS. Now a user_namespace will get a pointer to an ima_namespace
and therefore add an implementation of get_current_ns() that returns this
pointer.

get_current_ns() may now return a NULL pointer for as long as the IMA
namespace hasn't been created, yet. Therefore, return early from those
functions that may now get a NULL pointer from this call. The NULL
pointer can typically be treated similar to not having an IMA policy set
and simply return early from a function.

Implement ima_ns_from_file() for SecurityFS-related files where we can
now get the IMA namespace via the user namespace pointer associated
with the superblock of the SecurityFS filesystem instance. Since
the functions using ima_ns_from_file() will only be called after an
ima_namesapce has been allocated they will never get a NULL pointer
for the ima_namespace.

Switch access to userns->ima_ns to use acquire/release semantics to ensure
that a newly created ima_namespace structure is fully visible upon access.

Replace usage of current_user_ns() with ima_ns_from_user_ns() that
implements a method to derive the user_namespace from the given
ima_namespace. It leads to the same result.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/linux/ima.h                 |  9 ++++++-
 init/Kconfig                        | 13 ++++++++++
 kernel/user_namespace.c             |  2 ++
 security/integrity/ima/ima.h        | 35 ++++++++++++++++++++++-----
 security/integrity/ima/ima_fs.c     | 37 ++++++++++++++++++++++-------
 security/integrity/ima/ima_main.c   | 29 ++++++++++++++++------
 security/integrity/ima/ima_ns.c     |  3 ++-
 security/integrity/ima/ima_policy.c | 13 +++++-----
 8 files changed, 112 insertions(+), 29 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 5354e83d1694..7b9713b290ae 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -11,6 +11,7 @@
 #include <linux/fs.h>
 #include <linux/security.h>
 #include <linux/kexec.h>
+#include <linux/user_namespace.h>
 #include <crypto/hash_info.h>
 struct linux_binprm;
 
@@ -71,7 +72,13 @@ static inline const char * const *arch_get_ima_policy(void)
 static inline struct user_namespace
 *ima_ns_to_user_ns(struct ima_namespace *ns)
 {
-	return current_user_ns();
+	struct user_namespace *user_ns;
+
+	user_ns = current_user_ns();
+#ifdef CONFIG_IMA_NS
+	WARN_ON(user_ns->ima_ns != ns);
+#endif
+	return user_ns;
 }
 
 #else
diff --git a/init/Kconfig b/init/Kconfig
index 4b7bac10c72d..e27155e0ddba 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1247,6 +1247,19 @@ config NET_NS
 	  Allow user space to create what appear to be multiple instances
 	  of the network stack.
 
+config IMA_NS
+	bool "IMA namespace"
+	depends on USER_NS
+	depends on IMA
+	default n
+	help
+	  Allow the creation of an IMA namespace for each user namespace.
+	  Namespaced IMA enables having IMA features work separately
+	  in each IMA namespace.
+	  Currently, only the audit status flags are stored in the namespace,
+	  which allows the same file to be audited each time it is accessed
+	  in a new namespace.
+
 endif # NAMESPACES
 
 config CHECKPOINT_RESTORE
diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 6b2e3ca7ee99..653f8fa83b69 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -20,6 +20,7 @@
 #include <linux/fs_struct.h>
 #include <linux/bsearch.h>
 #include <linux/sort.h>
+#include <linux/ima.h>
 
 static struct kmem_cache *user_ns_cachep __read_mostly;
 static DEFINE_MUTEX(userns_state_mutex);
@@ -196,6 +197,7 @@ static void free_user_ns(struct work_struct *work)
 			kfree(ns->projid_map.forward);
 			kfree(ns->projid_map.reverse);
 		}
+		free_ima_ns(ns);
 		retire_userns_sysctls(ns);
 		key_free_user_ns(ns);
 		ns_free_inum(&ns->ns);
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 344c8c4bd030..d993655ec796 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -509,21 +509,20 @@ struct user_namespace *ima_user_ns_from_file(const struct file *filp)
 	return file_inode(filp)->i_sb->s_user_ns;
 }
 
+#ifdef CONFIG_IMA_NS
+
 static inline struct ima_namespace
 *ima_ns_from_user_ns(struct user_namespace *user_ns)
 {
-	if (user_ns == &init_user_ns)
-		return &init_ima_ns;
-	return NULL;
+	/* Pairs with smp_store_releases() in create_ima_ns(). */
+	return smp_load_acquire(&user_ns->ima_ns);
 }
 
 static inline struct ima_namespace *get_current_ns(void)
 {
-	return &init_ima_ns;
+	return ima_ns_from_user_ns(current_user_ns());
 }
 
-#ifdef CONFIG_IMA_NS
-
 struct ima_namespace *create_ima_ns(struct user_namespace *user_ns);
 
 struct ns_status *ima_get_ns_status(struct ima_namespace *ns,
@@ -532,6 +531,11 @@ struct ns_status *ima_get_ns_status(struct ima_namespace *ns,
 
 void ima_free_ns_status_tree(struct ima_namespace *ns);
 
+static inline struct ima_namespace *ima_ns_from_file(const struct file *filp)
+{
+	return ima_user_ns_from_file(filp)->ima_ns;
+}
+
 #define IMA_NS_STATUS_ACTIONS   IMA_AUDIT
 #define IMA_NS_STATUS_FLAGS     IMA_AUDITED
 
@@ -542,6 +546,20 @@ unsigned long set_iint_flags(struct integrity_iint_cache *iint,
 
 #else
 
+static inline struct ima_namespace
+*ima_ns_from_user_ns(struct user_namespace *user_ns)
+{
+	if (user_ns == &init_user_ns)
+		return &init_ima_ns;
+	return NULL;
+}
+
+
+static inline struct ima_namespace *get_current_ns(void)
+{
+	return &init_ima_ns;
+}
+
 static inline struct ima_namespace *
 create_ima_ns(struct user_namespace *user_ns)
 {
@@ -572,6 +590,11 @@ static inline unsigned long set_iint_flags(struct integrity_iint_cache *iint,
 	return flags;
 }
 
+static inline struct ima_namespace *ima_ns_from_file(const struct file *filp)
+{
+	return &init_ima_ns;
+}
+
 #endif /* CONFIG_IMA_NS */
 
 #endif /* __LINUX_IMA_H */
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 468508f6a7e8..ee3af81d1c3e 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -49,7 +49,7 @@ static ssize_t ima_show_htable_violations(struct file *filp,
 					  char __user *buf,
 					  size_t count, loff_t *ppos)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = ima_ns_from_file(filp);
 
 	return ima_show_htable_value(buf, count, ppos,
 				     &ns->ima_htable.violations);
@@ -64,7 +64,7 @@ static ssize_t ima_show_measurements_count(struct file *filp,
 					   char __user *buf,
 					   size_t count, loff_t *ppos)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = ima_ns_from_file(filp);
 
 	return ima_show_htable_value(buf, count, ppos, &ns->ima_htable.len);
 }
@@ -77,7 +77,7 @@ static const struct file_operations ima_measurements_count_ops = {
 /* returns pointer to hlist_node */
 static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = ima_ns_from_file(m->file);
 	loff_t l = *pos;
 	struct ima_queue_entry *qe;
 
@@ -95,7 +95,7 @@ static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
 
 static void *ima_measurements_next(struct seq_file *m, void *v, loff_t *pos)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = ima_ns_from_file(m->file);
 	struct ima_queue_entry *qe = v;
 
 	/* lock protects when reading beyond last element
@@ -317,7 +317,7 @@ static ssize_t ima_read_policy(struct ima_namespace *ns, char *path)
 static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 				size_t datalen, loff_t *ppos)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = ima_ns_from_file(file);
 	char *data;
 	ssize_t result;
 
@@ -379,7 +379,7 @@ static const struct seq_operations ima_policy_seqops = {
 static int ima_open_policy(struct inode *inode, struct file *filp)
 {
 	struct user_namespace *user_ns = ima_user_ns_from_file(filp);
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = ima_ns_from_file(filp);
 
 	if (!(filp->f_flags & O_WRONLY)) {
 #ifndef	CONFIG_IMA_READ_POLICY
@@ -406,7 +406,7 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
  */
 static int ima_release_policy(struct inode *inode, struct file *file)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = ima_ns_from_file(file);
 	const char *cause = ns->valid_policy ? "completed" : "failed";
 
 	if ((file->f_flags & O_ACCMODE) == O_RDONLY)
@@ -459,12 +459,29 @@ int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
 	struct dentry *ascii_runtime_measurements = NULL;
 	struct dentry *runtime_measurements_count = NULL;
 	struct dentry *violations = NULL;
+	bool created_ns = false;
+
+	/*
+	 * While multiple superblocks can exist they are keyed by userns in
+	 * s_fs_info for securityfs. The first time a userns mounts a
+	 * securityfs instance we lazily allocate the ima_namespace for the
+	 * userns since that's the only way a userns can meaningfully use ima.
+	 * The vfs ensures we're the only one to call fill_super() and hence
+	 * ima_fs_ns_init(), so we don't need any memory barriers here, i.e.
+	 * user_ns->ima_ns can't change while we're in here.
+	 */
+	if (!ns) {
+		ns = create_ima_ns(user_ns);
+		if (IS_ERR(ns))
+			return PTR_ERR(ns);
+		created_ns = true;
+	}
 
 	/* FIXME: update when evm and integrity are namespaced */
 	if (user_ns != &init_user_ns) {
 		int_dir = securityfs_create_dir("integrity", root);
 		if (IS_ERR(int_dir))
-			return PTR_ERR(int_dir);
+			goto free_ns;
 	} else
 		int_dir = integrity_dir;
 
@@ -526,6 +543,10 @@ int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
 	if (user_ns != &init_user_ns)
 		securityfs_remove(int_dir);
 
+free_ns:
+	if (created_ns)
+		free_ima_ns(user_ns);
+
 	return -1;
 }
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index bc3ab08f39c6..fc878577cdd7 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -483,7 +483,7 @@ int ima_file_mmap(struct file *file, unsigned long prot)
 	struct ima_namespace *ns = get_current_ns();
 	u32 secid;
 
-	if (file && (prot & PROT_EXEC)) {
+	if (ns && file && (prot & PROT_EXEC)) {
 		security_task_getsecid_subj(current, &secid);
 		return process_measurement(ns, file, current_cred(), secid,
 					   NULL, 0, MAY_EXEC, MMAP_CHECK);
@@ -519,7 +519,7 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 	int pcr;
 
 	/* Is mprotect making an mmap'ed file executable? */
-	if (!(ns->ima_policy_flag & IMA_APPRAISE) || !vma->vm_file ||
+	if (!ns || !(ns->ima_policy_flag & IMA_APPRAISE) || !vma->vm_file ||
 	    !(prot & PROT_EXEC) || (vma->vm_flags & VM_EXEC))
 		return 0;
 
@@ -565,6 +565,9 @@ int ima_bprm_check(struct linux_binprm *bprm)
 	int ret;
 	u32 secid;
 
+	if (!ns)
+		return 0;
+
 	security_task_getsecid_subj(current, &secid);
 	ret = process_measurement(ns, bprm->file, current_cred(), secid, NULL,
 				  0, MAY_EXEC, BPRM_CHECK);
@@ -591,6 +594,9 @@ int ima_file_check(struct file *file, int mask)
 	struct ima_namespace *ns = get_current_ns();
 	u32 secid;
 
+	if (!ns)
+		return 0;
+
 	security_task_getsecid_subj(current, &secid);
 	return process_measurement(ns, file, current_cred(), secid, NULL, 0,
 				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
@@ -656,7 +662,7 @@ int ima_file_hash(struct file *file, char *buf, size_t buf_size)
 {
 	struct ima_namespace *ns = get_current_ns();
 
-	if (!file)
+	if (!ns || !file)
 		return -EINVAL;
 
 	return __ima_inode_hash(ns, file_inode(file), buf, buf_size);
@@ -685,7 +691,7 @@ int ima_inode_hash(struct inode *inode, char *buf, size_t buf_size)
 {
 	struct ima_namespace *ns = get_current_ns();
 
-	if (!inode)
+	if (!ns || !inode)
 		return -EINVAL;
 
 	return __ima_inode_hash(ns, inode, buf, buf_size);
@@ -708,7 +714,7 @@ void ima_post_create_tmpfile(struct user_namespace *mnt_userns,
 	struct integrity_iint_cache *iint;
 	int must_appraise;
 
-	if (!ns->ima_policy_flag || !S_ISREG(inode->i_mode))
+	if (!ns || !ns->ima_policy_flag || !S_ISREG(inode->i_mode))
 		return;
 
 	must_appraise = ima_must_appraise(ns, mnt_userns, inode, MAY_ACCESS,
@@ -742,7 +748,7 @@ void ima_post_path_mknod(struct user_namespace *mnt_userns,
 	struct inode *inode = dentry->d_inode;
 	int must_appraise;
 
-	if (!ns->ima_policy_flag || !S_ISREG(inode->i_mode))
+	if (!ns || !ns->ima_policy_flag || !S_ISREG(inode->i_mode))
 		return;
 
 	must_appraise = ima_must_appraise(ns, mnt_userns, inode, MAY_ACCESS,
@@ -778,6 +784,9 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
 	enum ima_hooks func;
 	u32 secid;
 
+	if (!ns)
+		return 0;
+
 	/*
 	 * Do devices using pre-allocated memory run the risk of the
 	 * firmware being accessible to the device prior to the completion
@@ -829,6 +838,9 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 	enum ima_hooks func;
 	u32 secid;
 
+	if (!ns)
+		return 0;
+
 	/* permit signed certs */
 	if (!file && read_id == READING_X509_CERTIFICATE)
 		return 0;
@@ -1071,7 +1083,7 @@ void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
 	struct ima_namespace *ns = get_current_ns();
 	struct fd f;
 
-	if (!buf || !size)
+	if (!ns || !buf || !size)
 		return;
 
 	f = fdget(kernel_fd);
@@ -1111,6 +1123,9 @@ int ima_measure_critical_data(const char *event_label,
 {
 	struct ima_namespace *ns = get_current_ns();
 
+	if (!ns)
+		return -EINVAL;
+
 	if (!event_name || !event_label || !buf || !buf_len)
 		return -ENOPARAM;
 
diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
index 205dd06ac41e..9a5105d0ea89 100644
--- a/security/integrity/ima/ima_ns.c
+++ b/security/integrity/ima/ima_ns.c
@@ -26,7 +26,8 @@ struct ima_namespace *create_ima_ns(struct user_namespace *user_ns)
 	if (err)
 		goto fail_free;
 
-	user_ns->ima_ns = ns;
+	/* Pairs with smp_load_acquire() in ima_ns_from_user_ns(). */
+	smp_store_release(&user_ns->ima_ns, ns);
 
 	return ns;
 
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index b7dbc687b6ff..5a9b511ebbae 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1333,6 +1333,7 @@ static unsigned int ima_parse_appraise_algos(char *arg)
 static int ima_parse_rule(struct ima_namespace *ns,
 			  char *rule, struct ima_rule_entry *entry)
 {
+	struct user_namespace *user_ns = ima_ns_to_user_ns(ns);
 	struct audit_buffer *ab;
 	char *from;
 	char *p;
@@ -1582,7 +1583,7 @@ static int ima_parse_rule(struct ima_namespace *ns,
 
 			result = kstrtoul(args[0].from, 10, &lnum);
 			if (!result) {
-				entry->uid = make_kuid(current_user_ns(),
+				entry->uid = make_kuid(user_ns,
 						       (uid_t) lnum);
 				if (!uid_valid(entry->uid) ||
 				    (uid_t)lnum != lnum)
@@ -1617,7 +1618,7 @@ static int ima_parse_rule(struct ima_namespace *ns,
 
 			result = kstrtoul(args[0].from, 10, &lnum);
 			if (!result) {
-				entry->gid = make_kgid(current_user_ns(),
+				entry->gid = make_kgid(user_ns,
 						       (gid_t)lnum);
 				if (!gid_valid(entry->gid) ||
 				    (((gid_t)lnum) != lnum))
@@ -1644,7 +1645,7 @@ static int ima_parse_rule(struct ima_namespace *ns,
 
 			result = kstrtoul(args[0].from, 10, &lnum);
 			if (!result) {
-				entry->fowner = make_kuid(current_user_ns(),
+				entry->fowner = make_kuid(user_ns,
 							  (uid_t)lnum);
 				if (!uid_valid(entry->fowner) ||
 				    (((uid_t)lnum) != lnum))
@@ -1670,7 +1671,7 @@ static int ima_parse_rule(struct ima_namespace *ns,
 
 			result = kstrtoul(args[0].from, 10, &lnum);
 			if (!result) {
-				entry->fgroup = make_kgid(current_user_ns(),
+				entry->fgroup = make_kgid(user_ns,
 							  (gid_t)lnum);
 				if (!gid_valid(entry->fgroup) ||
 				    (((gid_t)lnum) != lnum))
@@ -1920,7 +1921,7 @@ static const char *const mask_tokens[] = {
 
 void *ima_policy_start(struct seq_file *m, loff_t *pos)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = ima_ns_from_file(m->file);
 	loff_t l = *pos;
 	struct ima_rule_entry *entry;
 	struct list_head *ima_rules_tmp;
@@ -1939,7 +1940,7 @@ void *ima_policy_start(struct seq_file *m, loff_t *pos)
 
 void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = ima_ns_from_file(m->file);
 	struct ima_rule_entry *entry = v;
 
 	rcu_read_lock();
-- 
2.31.1

