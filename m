Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470B2508A2D
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Apr 2022 16:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379444AbiDTOLV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 Apr 2022 10:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbiDTOKM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Apr 2022 10:10:12 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEFC43AFC;
        Wed, 20 Apr 2022 07:07:16 -0700 (PDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23KE4mlL005532;
        Wed, 20 Apr 2022 14:06:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=87UZQdaexDi+ChO1eiHbi8Y3BW2uoNPtkoFUhmnNLzA=;
 b=TOOwzGzxFjSUpbWpccpqsonj7MRt2N3AY4DuUik7wury0lYQs8k/xbE5HvNgLw4quak0
 ikjUj21gq8euThrpfk5DfhjNEEm45BzzdBUhTC2oUtodaub89cKkXNmTf6GvvCzzPnxq
 BZd+PU0fg0RR9KzEdhUnLHB6yUkJExrTfp6ajaih79b6S/b2lkWh0IjkPvbF5qOmEuMo
 lWeqfe7fEY2qcwXblBObfOx1zGu9Cb95o3JGJ1Gre9S8ccdHDEjbiYzc91RDk2kfIY65
 TmuYPj30nR9H0QXVDXycRpEdyiqLChXnokdaOAX1Nzv5VXQEFESOsCIYxikQjCMb/c3b jQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fjf51xaca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 14:06:48 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23KE00iZ012359;
        Wed, 20 Apr 2022 14:06:47 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fjf51xab3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 14:06:47 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23KE3Cq2015554;
        Wed, 20 Apr 2022 14:06:45 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma04dal.us.ibm.com with ESMTP id 3ffnea3tvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 14:06:45 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23KE6iiV23920912
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 14:06:44 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0E8FAE063;
        Wed, 20 Apr 2022 14:06:44 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B32DAE05C;
        Wed, 20 Apr 2022 14:06:44 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 20 Apr 2022 14:06:44 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        jpenumak@redhat.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v12 26/26] ima: Enable IMA namespaces
Date:   Wed, 20 Apr 2022 10:06:33 -0400
Message-Id: <20220420140633.753772-27-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420140633.753772-1-stefanb@linux.ibm.com>
References: <20220420140633.753772-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Hd8cBFve1XprTelDtAMx2_mBVIwagkte
X-Proofpoint-ORIG-GUID: PUT2qa48rEkd9rqg8lRFU0g8c_JHF6B2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_04,2022-04-20_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204200084
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Introduce the IMA_NS in Kconfig for IMA namespace enablement.

Enable the lazy initialization of an IMA namespace when a user mounts
SecurityFS and writes '1' into IMA's 'active' securityfs file. A
user_namespace will now get a pointer to an ima_namespace and therefore
implement get_current_ns() for the namespacing case that returns this
pointer. Use get_current_ns() in those places that require access to the
current IMA namespace. In some places, primarily those related to
IMA-appraisal and changes to file attributes, keep the pointer to
init_ima_ns, since there flags related to file measurements may be
affected, which are not supported in IMA namespaces, yet.

Before using the ima_namespace pointer test it with ns_is_active()
to check whether it is NULL and whether the ima_namespace is active.
If it's not active, it cannot be used, yet. Therefore, return early
from those functions that may now get either get a NULL pointer from
this call or where ns->active is still 0. The init_ima_ns is always
set to be active, thus passing the check.

Implement ima_ns_from_file() for SecurityFS-related files where we can
now get the IMA namespace via the user namespace pointer associated
with the superblock of the SecurityFS filesystem instance.

Return -EACCES to IMA's securityfs files, except for the 'active' file,
until the IMA namespace has been set to active.

Switch access to userns->ima_ns to use acquire/release semantics to ensure
that a newly created ima_namespace structure is fully visible upon access.

Only emit the kernel log message 'policy update completed' for the
init_ima_ns.

When parsing an IMA policy rule use the user namespace of the opener
to translate uid and gid values to kernel values rather than the user
namespace of the writer.

Gate access to ima_appraise variable to init_ima_ns in ima_load_data()
and ima_write_policy().

Gate access to temp_ima_appraise variable to init_ima_ns in
ima_delete_rules().

In ima_file_free remove the check on the ima_policy_flag so that
ima_check_last_writer() is called if there's an iint and therefore a
namespace is interested in the file.

Only update the xattr hash if a namespace has a hash policy.

Gate the setting of AUDIT rules to only allow host root with CAP_SYS_ADMIN
inside a namespace or host root with CAP_SYS_AMDIN entering a namespace to
set them. This prevents normal users, who created an IMA namespace and
have CAP_SYS_ADMIN in their user namespace, from setting these rules and
flooding the host's audit log.

Automatically select IMA_CONFIG_READ when selecting IMA_NS.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

---
v12:
 - replace set_bit() by clear_bit() to clear IMA_NS_ACTIVE

v11:
 - Remove check on ima_policy_flag so that any namespace modifying a
   file will cause re-auditing of a file if there's an existing iint
 - Only update the hash on a file if a namespace has a hash policy
 - Use ima_ns_from_user_ns() in ima_ns_from_file()
 - Kconfig: Select IMA_READ_POLICY when IMA_NS is selected

v10:
 - dropped ima_ns_to_user_ns(); using current_user_ns() instead
 - Pass user_namespace of file opener into ima_parse_rule and propagate
   this parameter back all the way to the initial caller in the chain
 - Gate access to ima_appraise to init_ima_ns in ima_write_policy()

v9:
 - ima_post_key_create_or_update: Only handle key if in init_ima_ns
 - Removed ns == NULL checks where user_namespace is now passed
 - Defer setting of user_ns->ima_ns until end of ima_fs_ns_init();
   required new ima_free_imans() and new user_ns_set_ima_ns()
 - Only emit log message 'policy update completed' for init_ima_ns
 - Introduce get_current_ns() only in this patch
 - Check for ns == &init_ima_ns in ima_load_data()
---
 include/linux/ima.h                          |  1 +
 init/Kconfig                                 | 14 +++
 kernel/user_namespace.c                      |  2 +
 security/integrity/ima/ima.h                 | 57 +++++++++++--
 security/integrity/ima/ima_appraise.c        |  8 ++
 security/integrity/ima/ima_asymmetric_keys.c |  6 +-
 security/integrity/ima/ima_fs.c              | 89 +++++++++++++++-----
 security/integrity/ima/ima_init.c            |  2 +-
 security/integrity/ima/ima_init_ima_ns.c     |  2 +
 security/integrity/ima/ima_main.c            | 40 +++++----
 security/integrity/ima/ima_ns.c              | 15 +++-
 security/integrity/ima/ima_policy.c          | 62 +++++++++-----
 12 files changed, 233 insertions(+), 65 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 0cbf0434bc93..c6dc02b09850 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -11,6 +11,7 @@
 #include <linux/fs.h>
 #include <linux/security.h>
 #include <linux/kexec.h>
+#include <linux/user_namespace.h>
 #include <crypto/hash_info.h>
 struct linux_binprm;
 
diff --git a/init/Kconfig b/init/Kconfig
index ddcbefe535e9..f47b89994ddd 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1251,6 +1251,20 @@ config NET_NS
 	  Allow user space to create what appear to be multiple instances
 	  of the network stack.
 
+config IMA_NS
+	bool "IMA namespace"
+	depends on USER_NS
+	depends on IMA
+	select IMA_READ_POLICY
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
index 5481ba44a8d6..d2f2eb790d95 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -20,6 +20,7 @@
 #include <linux/fs_struct.h>
 #include <linux/bsearch.h>
 #include <linux/sort.h>
+#include <linux/ima.h>
 
 static struct kmem_cache *user_ns_cachep __read_mostly;
 static DEFINE_MUTEX(userns_state_mutex);
@@ -208,6 +209,7 @@ static void free_user_ns(struct work_struct *work)
 			kfree(ns->projid_map.forward);
 			kfree(ns->projid_map.reverse);
 		}
+		free_ima_ns(ns);
 		retire_userns_sysctls(ns);
 		key_free_user_ns(ns);
 		ns_free_inum(&ns->ns);
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 78af02e4814e..c3f4ab1e20de 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -341,10 +341,10 @@ int ima_match_policy(struct ima_namespace *ns,
 		     int mask, int flags, int *pcr,
 		     struct ima_template_desc **template_desc,
 		     const char *func_data, unsigned int *allowed_algos);
-void ima_init_policy(struct ima_namespace *ns);
+void ima_init_policy(struct user_namespace *user_ns);
 void ima_update_policy(struct ima_namespace *ns);
 void ima_update_policy_flags(struct ima_namespace *ns);
-ssize_t ima_parse_add_rule(struct ima_namespace *ns, char *rule);
+ssize_t ima_parse_add_rule(struct user_namespace *user_ns, char *rule);
 void ima_delete_rules(struct ima_namespace *ns);
 int ima_check_policy(struct ima_namespace *ns);
 void ima_free_policy_rules(struct ima_namespace *ns);
@@ -544,32 +544,72 @@ struct user_namespace *ima_user_ns_from_file(const struct file *filp)
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
+	/* Pairs with smp_store_releases() in user_ns_set_ima_ns(). */
+	return smp_load_acquire(&user_ns->ima_ns);
 }
 
-#ifdef CONFIG_IMA_NS
+static inline void user_ns_set_ima_ns(struct user_namespace *user_ns,
+				      struct ima_namespace *ns)
+{
+	/* Pairs with smp_load_acquire() in ima_ns_from_user_ns() */
+	smp_store_release(&user_ns->ima_ns, ns);
+}
+
+static inline struct ima_namespace *get_current_ns(void)
+{
+	return ima_ns_from_user_ns(current_user_ns());
+}
 
 struct ima_namespace *create_ima_ns(void);
 
+void ima_free_ima_ns(struct ima_namespace *ns);
+
 struct ns_status *ima_get_ns_status(struct ima_namespace *ns,
 				    struct inode *inode,
 				    struct integrity_iint_cache *iint);
 
 void ima_free_ns_status_tree(struct ima_namespace *ns);
 
+static inline struct ima_namespace *ima_ns_from_file(const struct file *filp)
+{
+	struct user_namespace *user_ns = ima_user_ns_from_file(filp);
+
+	return ima_ns_from_user_ns(user_ns);
+}
+
 #else
 
+static inline struct ima_namespace
+*ima_ns_from_user_ns(struct user_namespace *user_ns)
+{
+	if (user_ns == &init_user_ns)
+		return &init_ima_ns;
+	return NULL;
+}
+
+static inline void user_ns_set_ima_ns(struct user_namespace *user_ns,
+				      struct ima_namespace *ns)
+{
+}
+
+static inline struct ima_namespace *get_current_ns(void)
+{
+	return &init_ima_ns;
+}
+
 static inline struct ima_namespace *create_ima_ns(void)
 {
 	WARN(1, "Cannot create an IMA namespace\n");
 	return ERR_PTR(-EFAULT);
 }
 
+static inline void ima_free_ima_ns(struct ima_namespace *ns) {}
+
 static inline struct ns_status *ima_get_ns_status
 					(struct ima_namespace *ns,
 					 struct inode *inode,
@@ -585,6 +625,11 @@ static inline struct ns_status *ima_get_ns_status
 	return ns_status;
 }
 
+static inline struct ima_namespace *ima_ns_from_file(const struct file *filp)
+{
+	return &init_ima_ns;
+}
+
 #endif /* CONFIG_IMA_NS */
 
 #endif /* __LINUX_IMA_H */
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 666cf0e77e1f..376aa08525ad 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -74,6 +74,9 @@ int ima_must_appraise(struct ima_namespace *ns,
 {
 	u32 secid;
 
+	if (ns != &init_ima_ns)
+		return 0;
+
 	if (!ima_appraise)
 		return 0;
 
@@ -493,6 +496,8 @@ int ima_appraise_measurement(enum ima_hooks func,
 
 /*
  * ima_update_xattr - update 'security.ima' hash value
+ *
+ * Only a namespace with a hash policy would ever update the file.
  */
 void ima_update_xattr(struct ima_namespace *ns,
 		      struct integrity_iint_cache *iint, struct file *file)
@@ -500,6 +505,9 @@ void ima_update_xattr(struct ima_namespace *ns,
 	struct dentry *dentry = file_dentry(file);
 	int rc = 0;
 
+	if (!ns_is_active(ns) || !(ns->ima_policy_flag & IMA_HASH))
+		return;
+
 	/* do not collect and update hash for digital signatures */
 	if (test_bit(IMA_DIGSIG, &iint->atomic_flags))
 		return;
diff --git a/security/integrity/ima/ima_asymmetric_keys.c b/security/integrity/ima/ima_asymmetric_keys.c
index 70d87df26068..0d2cc1e23cde 100644
--- a/security/integrity/ima/ima_asymmetric_keys.c
+++ b/security/integrity/ima/ima_asymmetric_keys.c
@@ -30,9 +30,13 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
 				   const void *payload, size_t payload_len,
 				   unsigned long flags, bool create)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = get_current_ns();
 	bool queued = false;
 
+	/* only handle key if related to init_ima_ns */
+	if (ns != &init_ima_ns)
+		return;
+
 	/* Only asymmetric keys are handled by this hook. */
 	if (key->type != &key_type_asymmetric)
 		return;
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 14dffeee727d..ab4d2b63ab57 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -49,7 +49,10 @@ static ssize_t ima_show_htable_violations(struct file *filp,
 					  char __user *buf,
 					  size_t count, loff_t *ppos)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = ima_ns_from_file(filp);
+
+	if (!ns_is_active(ns))
+		return -EACCES;
 
 	return ima_show_htable_value(buf, count, ppos,
 				     &ns->ima_htable.violations);
@@ -64,7 +67,10 @@ static ssize_t ima_show_measurements_count(struct file *filp,
 					   char __user *buf,
 					   size_t count, loff_t *ppos)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = ima_ns_from_file(filp);
+
+	if (!ns_is_active(ns))
+		return -EACCES;
 
 	return ima_show_htable_value(buf, count, ppos, &ns->ima_htable.len);
 }
@@ -77,7 +83,7 @@ static const struct file_operations ima_measurements_count_ops = {
 /* returns pointer to hlist_node */
 static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = ima_ns_from_file(m->file);
 	loff_t l = *pos;
 	struct ima_queue_entry *qe;
 
@@ -95,7 +101,7 @@ static void *ima_measurements_start(struct seq_file *m, loff_t *pos)
 
 static void *ima_measurements_next(struct seq_file *m, void *v, loff_t *pos)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = ima_ns_from_file(m->file);
 	struct ima_queue_entry *qe = v;
 
 	/* lock protects when reading beyond last element
@@ -198,6 +204,11 @@ static const struct seq_operations ima_measurments_seqops = {
 
 static int ima_measurements_open(struct inode *inode, struct file *file)
 {
+	struct ima_namespace *ns = ima_ns_from_file(file);
+
+	if (!ns_is_active(ns))
+		return -EACCES;
+
 	return seq_open(file, &ima_measurments_seqops);
 }
 
@@ -264,6 +275,11 @@ static const struct seq_operations ima_ascii_measurements_seqops = {
 
 static int ima_ascii_measurements_open(struct inode *inode, struct file *file)
 {
+	struct ima_namespace *ns = ima_ns_from_file(file);
+
+	if (!ns_is_active(ns))
+		return -EACCES;
+
 	return seq_open(file, &ima_ascii_measurements_seqops);
 }
 
@@ -274,7 +290,7 @@ static const struct file_operations ima_ascii_measurements_ops = {
 	.release = seq_release,
 };
 
-static ssize_t ima_read_policy(struct ima_namespace *ns, char *path)
+static ssize_t ima_read_policy(struct user_namespace *user_ns, char *path)
 {
 	void *data = NULL;
 	char *datap;
@@ -299,7 +315,7 @@ static ssize_t ima_read_policy(struct ima_namespace *ns, char *path)
 	datap = data;
 	while (size > 0 && (p = strsep(&datap, "\n"))) {
 		pr_debug("rule: %s\n", p);
-		rc = ima_parse_add_rule(ns, p);
+		rc = ima_parse_add_rule(user_ns, p);
 		if (rc < 0)
 			break;
 		size -= rc;
@@ -317,10 +333,14 @@ static ssize_t ima_read_policy(struct ima_namespace *ns, char *path)
 static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 				size_t datalen, loff_t *ppos)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct user_namespace *user_ns = ima_user_ns_from_file(file);
+	struct ima_namespace *ns = ima_ns_from_user_ns(user_ns);
 	char *data;
 	ssize_t result;
 
+	if (!ns_is_active(ns))
+		return -EACCES;
+
 	if (datalen >= PAGE_SIZE)
 		datalen = PAGE_SIZE - 1;
 
@@ -340,15 +360,16 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 		goto out_free;
 
 	if (data[0] == '/') {
-		result = ima_read_policy(ns, data);
-	} else if (ima_appraise & IMA_APPRAISE_POLICY) {
+		result = ima_read_policy(user_ns, data);
+	} else if (ns == &init_ima_ns &&
+		   (ima_appraise & IMA_APPRAISE_POLICY)) {
 		pr_err("signed policy file (specified as an absolute pathname) required\n");
 		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
 				    "policy_update", "signed policy required",
 				    1, 0);
 		result = -EACCES;
 	} else {
-		result = ima_parse_add_rule(ns, data);
+		result = ima_parse_add_rule(user_ns, data);
 	}
 	mutex_unlock(&ns->ima_write_mutex);
 out_free:
@@ -381,7 +402,10 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
 #ifdef CONFIG_IMA_READ_POLICY
 	struct user_namespace *user_ns = ima_user_ns_from_file(filp);
 #endif
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = ima_ns_from_file(filp);
+
+	if (!ns_is_active(ns))
+		return -EACCES;
 
 	if (!(filp->f_flags & O_WRONLY)) {
 #ifndef	CONFIG_IMA_READ_POLICY
@@ -408,7 +432,7 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
  */
 static int ima_release_policy(struct inode *inode, struct file *file)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = ima_ns_from_file(file);
 	const char *cause = ns->valid_policy ? "completed" : "failed";
 
 	if ((file->f_flags & O_ACCMODE) == O_RDONLY)
@@ -419,11 +443,12 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 		ns->valid_policy = 0;
 	}
 
-	pr_info("policy update %s\n", cause);
-	if (ns == &init_ima_ns)
+	if (ns == &init_ima_ns) {
+		pr_info("policy update %s\n", cause);
 		integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
 				    "policy_update", cause, !ns->valid_policy,
 				    0);
+	}
 
 	if (!ns->valid_policy) {
 		ima_delete_rules(ns);
@@ -457,7 +482,7 @@ static ssize_t ima_show_active(struct file *filp,
 			       char __user *buf,
 			       size_t count, loff_t *ppos)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = ima_ns_from_file(filp);
 	char tmpbuf[2];
 	ssize_t len;
 
@@ -470,7 +495,7 @@ static ssize_t ima_write_active(struct file *filp,
 				const char __user *buf,
 				size_t count, loff_t *ppos)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = ima_ns_from_file(filp);
 	unsigned int active;
 	char *kbuf;
 	int err;
@@ -494,7 +519,9 @@ static ssize_t ima_write_active(struct file *filp,
 	if (active != 1)
 		return -EINVAL;
 
-	set_bit(IMA_NS_ACTIVE, &ns->ima_ns_flags);
+	err = ima_init_namespace(ns);
+	if (err)
+		return -EINVAL;
 
 	return count;
 }
@@ -517,11 +544,28 @@ int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
 	struct dentry *active = NULL;
 	int ret;
 
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
+		ns = create_ima_ns();
+		if (IS_ERR(ns))
+			return PTR_ERR(ns);
+	}
+
 	/* FIXME: update when evm and integrity are namespaced */
 	if (user_ns != &init_user_ns) {
 		int_dir = securityfs_create_dir("integrity", root);
-		if (IS_ERR(int_dir))
-			return PTR_ERR(int_dir);
+		if (IS_ERR(int_dir)) {
+			ret = PTR_ERR(int_dir);
+			goto free_ns;
+		}
 	} else {
 		int_dir = integrity_dir;
 	}
@@ -596,6 +640,9 @@ int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
 		}
 	}
 
+	if (!ima_ns_from_user_ns(user_ns))
+		user_ns_set_ima_ns(user_ns, ns);
+
 	return 0;
 out:
 	securityfs_remove(active);
@@ -609,6 +656,10 @@ int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
 	if (user_ns != &init_user_ns)
 		securityfs_remove(int_dir);
 
+free_ns:
+	if (!ima_ns_from_user_ns(user_ns))
+		ima_free_ima_ns(ns);
+
 	return ret;
 }
 
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 47c9d561532e..da2a37ff431d 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -147,7 +147,7 @@ int __init ima_init(void)
 	if (rc != 0)
 		return rc;
 
-	ima_init_policy(&init_ima_ns);
+	ima_init_policy(&init_user_ns);
 
 	rc = ima_fs_init();
 	if (rc != 0)
diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
index 5c57abfc70ea..1eaa6ceee2ee 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -46,6 +46,8 @@ int ima_init_namespace(struct ima_namespace *ns)
 			return ret;
 	}
 
+	set_bit(IMA_NS_ACTIVE, &ns->ima_ns_flags);
+
 	return 0;
 }
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index fc05f0088f79..2024950a5a7d 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -211,11 +211,11 @@ static void ima_check_last_writer(struct ima_namespace *ns,
  */
 void ima_file_free(struct file *file)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = get_current_ns();
 	struct inode *inode = file_inode(file);
 	struct integrity_iint_cache *iint;
 
-	if (!ns->ima_policy_flag || !S_ISREG(inode->i_mode))
+	if (!S_ISREG(inode->i_mode))
 		return;
 
 	iint = integrity_iint_find(inode);
@@ -509,7 +509,7 @@ int ima_file_mmap(struct file *file, unsigned long prot)
  */
 int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = get_current_ns();
 	struct ima_template_desc *template = NULL;
 	struct file *file = vma->vm_file;
 	char filename[NAME_MAX];
@@ -522,7 +522,8 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 	int pcr;
 
 	/* Is mprotect making an mmap'ed file executable? */
-	if (!(ns->ima_policy_flag & IMA_APPRAISE) || !vma->vm_file ||
+	if (!ns_is_active(ns) ||
+	    !(ns->ima_policy_flag & IMA_APPRAISE) || !vma->vm_file ||
 	    !(prot & PROT_EXEC) || (vma->vm_flags & VM_EXEC))
 		return 0;
 
@@ -677,9 +678,9 @@ static int __ima_inode_hash(struct ima_namespace *ns, struct inode *inode,
  */
 int ima_file_hash(struct file *file, char *buf, size_t buf_size)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = get_current_ns();
 
-	if (!file)
+	if (!ns_is_active(ns) || !file)
 		return -EINVAL;
 
 	return __ima_inode_hash(ns, file_inode(file), file, buf, buf_size);
@@ -706,9 +707,9 @@ EXPORT_SYMBOL_GPL(ima_file_hash);
  */
 int ima_inode_hash(struct inode *inode, char *buf, size_t buf_size)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = get_current_ns();
 
-	if (!inode)
+	if (!ns_is_active(ns) || !inode)
 		return -EINVAL;
 
 	return __ima_inode_hash(ns, inode, NULL, buf, buf_size);
@@ -727,11 +728,12 @@ EXPORT_SYMBOL_GPL(ima_inode_hash);
 void ima_post_create_tmpfile(struct user_namespace *mnt_userns,
 			     struct inode *inode)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = get_current_ns();
 	struct integrity_iint_cache *iint;
 	int must_appraise;
 
-	if (!ns->ima_policy_flag || !S_ISREG(inode->i_mode))
+	if (!ns_is_active(ns) || !ns->ima_policy_flag ||
+	    !S_ISREG(inode->i_mode))
 		return;
 
 	must_appraise = ima_must_appraise(ns, mnt_userns, inode, MAY_ACCESS,
@@ -760,12 +762,13 @@ void ima_post_create_tmpfile(struct user_namespace *mnt_userns,
 void ima_post_path_mknod(struct user_namespace *mnt_userns,
 			 struct dentry *dentry)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = get_current_ns();
 	struct integrity_iint_cache *iint;
 	struct inode *inode = dentry->d_inode;
 	int must_appraise;
 
-	if (!ns->ima_policy_flag || !S_ISREG(inode->i_mode))
+	if (!ns_is_active(ns) || !ns->ima_policy_flag ||
+	    !S_ISREG(inode->i_mode))
 		return;
 
 	must_appraise = ima_must_appraise(ns, mnt_userns, inode, MAY_ACCESS,
@@ -884,8 +887,12 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
  */
 int ima_load_data(enum kernel_load_data_id id, bool contents)
 {
+	struct ima_namespace *ns = get_current_ns();
 	bool ima_enforce, sig_enforce;
 
+	if (ns != &init_ima_ns)
+		return 0;
+
 	ima_enforce =
 		(ima_appraise & IMA_APPRAISE_ENFORCE) == IMA_APPRAISE_ENFORCE;
 
@@ -1090,10 +1097,10 @@ int process_buffer_measurement(struct ima_namespace *ns,
  */
 void ima_kexec_cmdline(int kernel_fd, const void *buf, int size)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = get_current_ns();
 	struct fd f;
 
-	if (!buf || !size)
+	if (!ns_is_active(ns) || !buf || !size)
 		return;
 
 	f = fdget(kernel_fd);
@@ -1131,7 +1138,10 @@ int ima_measure_critical_data(const char *event_label,
 			      const void *buf, size_t buf_len,
 			      bool hash, u8 *digest, size_t digest_len)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = get_current_ns();
+
+	if (!ns_is_active(ns))
+		return -EINVAL;
 
 	if (!event_name || !event_label || !buf || !buf_len)
 		return -ENOPARAM;
diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
index 29af6fea2d74..be7f50b1def8 100644
--- a/security/integrity/ima/ima_ns.c
+++ b/security/integrity/ima/ima_ns.c
@@ -26,22 +26,29 @@ struct ima_namespace *create_ima_ns(void)
 /* destroy_ima_ns() must only be called after ima_init_namespace() was called */
 static void destroy_ima_ns(struct ima_namespace *ns)
 {
+	clear_bit(IMA_NS_ACTIVE, &ns->ima_ns_flags);
 	unregister_blocking_lsm_notifier(&ns->ima_lsm_policy_notifier);
 	kfree(ns->arch_policy_entry);
 	ima_free_policy_rules(ns);
 	ima_free_ns_status_tree(ns);
 }
 
-void free_ima_ns(struct user_namespace *user_ns)
+void ima_free_ima_ns(struct ima_namespace *ns)
 {
-	struct ima_namespace *ns = user_ns->ima_ns;
-
 	if (!ns || WARN_ON(ns == &init_ima_ns))
 		return;
 
-	destroy_ima_ns(ns);
+	if (ns_is_active(ns))
+		destroy_ima_ns(ns);
 
 	kmem_cache_free(imans_cachep, ns);
+}
+
+void free_ima_ns(struct user_namespace *user_ns)
+{
+	struct ima_namespace *ns = ima_ns_from_user_ns(user_ns);
+
+	ima_free_ima_ns(ns);
 
 	user_ns->ima_ns = NULL;
 }
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 2a4e37a5a64d..a265c9751370 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -487,8 +487,8 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
 		return NOTIFY_DONE;
 
 	ns = container_of(nb, struct ima_namespace, ima_lsm_policy_notifier);
-
-	set_bit(IMA_NS_LSM_UPDATE_RULES, &ns->ima_ns_flags);
+	if (ns_is_active(ns))
+		set_bit(IMA_NS_LSM_UPDATE_RULES, &ns->ima_ns_flags);
 
 	return NOTIFY_OK;
 }
@@ -860,11 +860,12 @@ static void add_rules(struct ima_namespace *ns,
 	}
 }
 
-static int ima_parse_rule(struct ima_namespace *ns,
+static int ima_parse_rule(struct user_namespace *user_ns,
 			  char *rule, struct ima_rule_entry *entry);
 
-static int __init ima_init_arch_policy(struct ima_namespace *ns)
+static int __init ima_init_arch_policy(struct user_namespace *user_ns)
 {
+	struct ima_namespace *ns = ima_ns_from_user_ns(user_ns);
 	const char * const *arch_rules;
 	const char * const *rules;
 	int arch_entries = 0;
@@ -892,7 +893,8 @@ static int __init ima_init_arch_policy(struct ima_namespace *ns)
 		result = strscpy(rule, *rules, sizeof(rule));
 
 		INIT_LIST_HEAD(&ns->arch_policy_entry[i].list);
-		result = ima_parse_rule(ns, rule, &ns->arch_policy_entry[i]);
+		result = ima_parse_rule(user_ns, rule,
+					&ns->arch_policy_entry[i]);
 		if (result) {
 			pr_warn("Skipping unknown architecture policy rule: %s\n",
 				rule);
@@ -907,11 +909,12 @@ static int __init ima_init_arch_policy(struct ima_namespace *ns)
 
 /**
  * ima_init_policy - initialize the default measure rules.
- * @ns: IMA namespace to which the policy belongs to
+ * @user_ns: User namespace pointig to IMA namespace to which the policy belongs
  * ima_rules points to either the ima_default_rules or the new ima_policy_rules.
  */
-void __init ima_init_policy(struct ima_namespace *ns)
+void __init ima_init_policy(struct user_namespace *user_ns)
 {
+	struct ima_namespace *ns = ima_ns_from_user_ns(user_ns);
 	int build_appraise_entries, arch_entries;
 
 	/* if !ima_policy, we load NO default rules */
@@ -941,7 +944,7 @@ void __init ima_init_policy(struct ima_namespace *ns)
 	 * and custom policies, prior to other appraise rules.
 	 * (Highest priority)
 	 */
-	arch_entries = ima_init_arch_policy(ns);
+	arch_entries = ima_init_arch_policy(user_ns);
 	if (!arch_entries)
 		pr_info("No architecture policies found\n");
 	else
@@ -1362,9 +1365,21 @@ static unsigned int ima_parse_appraise_algos(char *arg)
 	return res;
 }
 
-static int ima_parse_rule(struct ima_namespace *ns,
+/*
+ * Either host root with CAP_SYS_ADMIN in current user namespace or
+ * root with CAP_SYS_ADMIN on the host entering a namespace may set
+ * audit rules inside a namespace.
+ */
+static bool may_set_audit_rule_in_ns(kuid_t uid, struct user_namespace *user_ns)
+{
+	return (uid_eq(uid, GLOBAL_ROOT_UID) &&
+		ns_capable(user_ns, CAP_SYS_ADMIN))
+		|| capable(CAP_SYS_ADMIN);
+}
+static int ima_parse_rule(struct user_namespace *user_ns,
 			  char *rule, struct ima_rule_entry *entry)
 {
+	struct ima_namespace *ns = ima_ns_from_user_ns(user_ns);
 	struct audit_buffer *ab = NULL;
 	char *from;
 	char *p;
@@ -1615,7 +1630,7 @@ static int ima_parse_rule(struct ima_namespace *ns,
 
 			result = kstrtoul(args[0].from, 10, &lnum);
 			if (!result) {
-				entry->uid = make_kuid(current_user_ns(),
+				entry->uid = make_kuid(user_ns,
 						       (uid_t) lnum);
 				if (!uid_valid(entry->uid) ||
 				    (uid_t)lnum != lnum)
@@ -1650,7 +1665,7 @@ static int ima_parse_rule(struct ima_namespace *ns,
 
 			result = kstrtoul(args[0].from, 10, &lnum);
 			if (!result) {
-				entry->gid = make_kgid(current_user_ns(),
+				entry->gid = make_kgid(user_ns,
 						       (gid_t)lnum);
 				if (!gid_valid(entry->gid) ||
 				    (((gid_t)lnum) != lnum))
@@ -1677,7 +1692,7 @@ static int ima_parse_rule(struct ima_namespace *ns,
 
 			result = kstrtoul(args[0].from, 10, &lnum);
 			if (!result) {
-				entry->fowner = make_kuid(current_user_ns(),
+				entry->fowner = make_kuid(user_ns,
 							  (uid_t)lnum);
 				if (!uid_valid(entry->fowner) ||
 				    (((uid_t)lnum) != lnum))
@@ -1703,7 +1718,7 @@ static int ima_parse_rule(struct ima_namespace *ns,
 
 			result = kstrtoul(args[0].from, 10, &lnum);
 			if (!result) {
-				entry->fgroup = make_kgid(current_user_ns(),
+				entry->fgroup = make_kgid(user_ns,
 							  (gid_t)lnum);
 				if (!gid_valid(entry->fgroup) ||
 				    (((gid_t)lnum) != lnum))
@@ -1835,6 +1850,12 @@ static int ima_parse_rule(struct ima_namespace *ns,
 			case HASH:
 				result = -EINVAL;
 				goto err_audit;
+			case AUDIT:
+				if (!may_set_audit_rule_in_ns(current_uid(),
+							      user_ns)) {
+					result = -EPERM;
+					goto err_audit;
+				}
 			}
 		}
 	}
@@ -1857,14 +1878,15 @@ static int ima_parse_rule(struct ima_namespace *ns,
 
 /**
  * ima_parse_add_rule - add a rule to ima_policy_rules
- * @ns: IMA namespace that has the policy
+ * @user_ns: User namespace referencing the IMA namespace that has the policy
  * @rule - ima measurement policy rule
  *
  * Avoid locking by allowing just one writer at a time in ima_write_policy()
  * Returns the length of the rule parsed, an error code on failure
  */
-ssize_t ima_parse_add_rule(struct ima_namespace *ns, char *rule)
+ssize_t ima_parse_add_rule(struct user_namespace *user_ns, char *rule)
 {
+	struct ima_namespace *ns = ima_ns_from_user_ns(user_ns);
 	static const char op[] = "update_policy";
 	char *p;
 	struct ima_rule_entry *entry;
@@ -1889,7 +1911,7 @@ ssize_t ima_parse_add_rule(struct ima_namespace *ns, char *rule)
 
 	INIT_LIST_HEAD(&entry->list);
 
-	result = ima_parse_rule(ns, p, entry);
+	result = ima_parse_rule(user_ns, p, entry);
 	if (result) {
 		ima_free_rule(entry);
 		if (ns == &init_ima_ns)
@@ -1915,7 +1937,9 @@ void ima_delete_rules(struct ima_namespace *ns)
 {
 	struct ima_rule_entry *entry, *tmp;
 
-	temp_ima_appraise = 0;
+	if (ns == &init_ima_ns)
+		temp_ima_appraise = 0;
+
 	list_for_each_entry_safe(entry, tmp, &ns->ima_temp_rules, list) {
 		list_del(&entry->list);
 		ima_free_rule(entry);
@@ -1956,7 +1980,7 @@ static const char *const mask_tokens[] = {
 
 void *ima_policy_start(struct seq_file *m, loff_t *pos)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = ima_ns_from_file(m->file);
 	loff_t l = *pos;
 	struct ima_rule_entry *entry;
 	struct list_head *ima_rules_tmp;
@@ -1977,7 +2001,7 @@ void *ima_policy_start(struct seq_file *m, loff_t *pos)
 
 void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = ima_ns_from_file(m->file);
 	struct ima_rule_entry *entry = v;
 
 	rcu_read_lock();
-- 
2.34.1

