Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194D968BF8E
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Feb 2023 15:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjBFOGp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Feb 2023 09:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbjBFOFG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Feb 2023 09:05:06 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2873B28D2B;
        Mon,  6 Feb 2023 06:04:15 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316E33RE017786;
        Mon, 6 Feb 2023 14:03:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=cd/igTPi5uPFfv8TskkQ15dHgwLUjQ2O1jppSnDUtEE=;
 b=Q0vGPHmyMh17XySm1WfOQjlXlaNU8Z1pD7CFFAHnwf96fXyzCkNiPUimXoKkdHRQJi79
 QL1xStfHf0EDvOpAn/QZgq6ldSNYGEKT6rLH88V7smOuxHpJeMxt1fLr8xlP5enPdESW
 1pKyBL9k94spWviSSuSCVVfmwU98ZVF1RdnoX1pAkOBBZzGpBRmJva6Tyf7aFKEH6abu
 Qj8Q3bKkSOVLZiGFajm26U/YJgUKekUMdSvpriV/lYlckUl63tpWMHHTmAvqFH9jUeMp
 WOsGOOxba32Rp8i33z+YFoWo6vOz5ZtMnPzuZXenSUmEfPF3wLnp533g7wLkl/1fra0t Kw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk2ygr0vs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:58 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 316E3vUH023248;
        Mon, 6 Feb 2023 14:03:57 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nk2ygr0v5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:57 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 316CQ4QY003472;
        Mon, 6 Feb 2023 14:03:56 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3nhf07301n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Feb 2023 14:03:55 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 316E3sCs34800370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Feb 2023 14:03:54 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C5305805B;
        Mon,  6 Feb 2023 14:03:54 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47D205805E;
        Mon,  6 Feb 2023 14:03:52 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Feb 2023 14:03:52 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, serge@hallyn.com, brauner@kernel.org,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        jpenumak@redhat.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v15 26/26] ima: Enable IMA namespaces
Date:   Mon,  6 Feb 2023 09:02:53 -0500
Message-Id: <20230206140253.3755945-27-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230206140253.3755945-1-stefanb@linux.ibm.com>
References: <20230206140253.3755945-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YGNBXVgvMHwAYVCXBPO5uz6LeOxvUk2z
X-Proofpoint-ORIG-GUID: nGAHglEzmTACD_jeyGOwJkcrsVjspPIu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_06,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 bulkscore=0 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302060121
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

Gate setting of AUDIT rules to only allow host root with CAP_WRITE_AUDIT
inside a namespace or host root with CAP_WRITE_AUDIT entering a namespace
to set them. This prevents normal users, who created an IMA namespace and
have CAP_WRITE_AUDIT in their user namespace, from setting these rules
and flooding the host's audit log.

Automatically select IMA_CONFIG_READ when selecting IMA_NS.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

---
v15:
 - Require CAP_AUDIT_WRITE instead of CAP_SYS_ADMIN for host root to
   set IMA audit rules in an IMA namespace

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
 security/integrity/ima/ima_policy.c          | 63 +++++++++-----
 12 files changed, 234 insertions(+), 65 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 5f5f190626d5..541205b5a25f 100644
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
index 44e90b28a30f..eadd44bc5e60 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1269,6 +1269,20 @@ config NET_NS
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
index 54211dbd516c..e1141f7b3a60 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -21,6 +21,7 @@
 #include <linux/fs_struct.h>
 #include <linux/bsearch.h>
 #include <linux/sort.h>
+#include <linux/ima.h>
 
 static struct kmem_cache *user_ns_cachep __read_mostly;
 static DEFINE_MUTEX(userns_state_mutex);
@@ -213,6 +214,7 @@ static void free_user_ns(struct work_struct *work)
 			kfree(ns->projid_map.forward);
 			kfree(ns->projid_map.reverse);
 		}
+		free_ima_ns(ns);
 		retire_userns_sysctls(ns);
 		key_free_user_ns(ns);
 		ns_free_inum(&ns->ns);
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index a2bb7cbd41be..fa2b96957a68 100644
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
@@ -545,32 +545,72 @@ struct user_namespace *ima_user_ns_from_file(const struct file *filp)
 	return file_sb_user_ns(filp);
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
@@ -586,6 +626,11 @@ static inline struct ns_status *ima_get_ns_status
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
index 950f1353c6a1..d1ac48c972df 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -76,6 +76,9 @@ int ima_must_appraise(struct ima_namespace *ns,
 {
 	u32 secid;
 
+	if (ns != &init_ima_ns)
+		return 0;
+
 	if (!ima_appraise)
 		return 0;
 
@@ -600,6 +603,8 @@ int ima_appraise_measurement(enum ima_hooks func,
 
 /*
  * ima_update_xattr - update 'security.ima' hash value
+ *
+ * Only a namespace with a hash policy would ever update the file.
  */
 void ima_update_xattr(struct ima_namespace *ns,
 		      struct integrity_iint_cache *iint, struct file *file)
@@ -607,6 +612,9 @@ void ima_update_xattr(struct ima_namespace *ns,
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
index 03d326cf82d4..fc339051c3c5 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -46,6 +46,8 @@ int ima_init_namespace(struct ima_namespace *ns)
 			goto err_destroy_cache;
 	}
 
+	set_bit(IMA_NS_ACTIVE, &ns->ima_ns_flags);
+
 	return 0;
 
 err_destroy_cache:
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 61442eb8339c..3f5b88a23185 100644
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
@@ -511,7 +511,7 @@ int ima_file_mmap(struct file *file, unsigned long prot)
  */
 int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = get_current_ns();
 	struct ima_template_desc *template = NULL;
 	struct file *file;
 	char filename[NAME_MAX];
@@ -524,7 +524,8 @@ int ima_file_mprotect(struct vm_area_struct *vma, unsigned long prot)
 	int pcr;
 
 	/* Is mprotect making an mmap'ed file executable? */
-	if (!(ns->ima_policy_flag & IMA_APPRAISE) || !vma->vm_file ||
+	if (!ns_is_active(ns) ||
+	    !(ns->ima_policy_flag & IMA_APPRAISE) || !vma->vm_file ||
 	    !(prot & PROT_EXEC) || (vma->vm_flags & VM_EXEC))
 		return 0;
 
@@ -684,9 +685,9 @@ static int __ima_inode_hash(struct ima_namespace *ns, struct inode *inode,
  */
 int ima_file_hash(struct file *file, char *buf, size_t buf_size)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = get_current_ns();
 
-	if (!file)
+	if (!ns_is_active(ns) || !file)
 		return -EINVAL;
 
 	return __ima_inode_hash(ns, file_inode(file), file, buf, buf_size);
@@ -713,9 +714,9 @@ EXPORT_SYMBOL_GPL(ima_file_hash);
  */
 int ima_inode_hash(struct inode *inode, char *buf, size_t buf_size)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = get_current_ns();
 
-	if (!inode)
+	if (!ns_is_active(ns) || !inode)
 		return -EINVAL;
 
 	return __ima_inode_hash(ns, inode, NULL, buf, buf_size);
@@ -734,11 +735,12 @@ EXPORT_SYMBOL_GPL(ima_inode_hash);
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
@@ -767,12 +769,13 @@ void ima_post_create_tmpfile(struct user_namespace *mnt_userns,
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
@@ -891,8 +894,12 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
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
 
@@ -1097,10 +1104,10 @@ int process_buffer_measurement(struct ima_namespace *ns,
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
@@ -1138,7 +1145,10 @@ int ima_measure_critical_data(const char *event_label,
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
index 05ffd7b03ee3..1be322e84ab6 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -507,8 +507,8 @@ int ima_lsm_policy_change(struct notifier_block *nb, unsigned long event,
 		return NOTIFY_DONE;
 
 	ns = container_of(nb, struct ima_namespace, ima_lsm_policy_notifier);
-
-	set_bit(IMA_NS_LSM_UPDATE_RULES, &ns->ima_ns_flags);
+	if (ns_is_active(ns))
+		set_bit(IMA_NS_LSM_UPDATE_RULES, &ns->ima_ns_flags);
 
 	return NOTIFY_OK;
 }
@@ -907,11 +907,12 @@ static void add_rules(struct ima_namespace *ns,
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
@@ -939,7 +940,8 @@ static int __init ima_init_arch_policy(struct ima_namespace *ns)
 		result = strscpy(rule, *rules, sizeof(rule));
 
 		INIT_LIST_HEAD(&ns->arch_policy_entry[i].list);
-		result = ima_parse_rule(ns, rule, &ns->arch_policy_entry[i]);
+		result = ima_parse_rule(user_ns, rule,
+					&ns->arch_policy_entry[i]);
 		if (result) {
 			pr_warn("Skipping unknown architecture policy rule: %s\n",
 				rule);
@@ -954,11 +956,12 @@ static int __init ima_init_arch_policy(struct ima_namespace *ns)
 
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
@@ -988,7 +991,7 @@ void __init ima_init_policy(struct ima_namespace *ns)
 	 * and custom policies, prior to other appraise rules.
 	 * (Highest priority)
 	 */
-	arch_entries = ima_init_arch_policy(ns);
+	arch_entries = ima_init_arch_policy(user_ns);
 	if (!arch_entries)
 		pr_info("No architecture policies found\n");
 	else
@@ -1439,9 +1442,22 @@ static unsigned int ima_parse_appraise_algos(char *arg)
 	return res;
 }
 
-static int ima_parse_rule(struct ima_namespace *ns,
+/*
+ * Either host root with CAP_AUDIT_WRITE in current user namespace or
+ * root with CAP_AUDIT_WRITE on the host entering a namespace may set
+ * audit rules inside a namespace.
+ */
+static bool may_set_audit_rule_in_ns(kuid_t uid, struct user_namespace *user_ns)
+{
+	return (uid_eq(uid, GLOBAL_ROOT_UID) &&
+		ns_capable(user_ns, CAP_AUDIT_WRITE)) ||
+		capable(CAP_AUDIT_WRITE);
+}
+
+static int ima_parse_rule(struct user_namespace *user_ns,
 			  char *rule, struct ima_rule_entry *entry)
 {
+	struct ima_namespace *ns = ima_ns_from_user_ns(user_ns);
 	struct audit_buffer *ab = NULL;
 	char *from;
 	char *p;
@@ -1692,7 +1708,7 @@ static int ima_parse_rule(struct ima_namespace *ns,
 
 			result = kstrtoul(args[0].from, 10, &lnum);
 			if (!result) {
-				entry->uid = make_kuid(current_user_ns(),
+				entry->uid = make_kuid(user_ns,
 						       (uid_t) lnum);
 				if (!uid_valid(entry->uid) ||
 				    (uid_t)lnum != lnum)
@@ -1727,7 +1743,7 @@ static int ima_parse_rule(struct ima_namespace *ns,
 
 			result = kstrtoul(args[0].from, 10, &lnum);
 			if (!result) {
-				entry->gid = make_kgid(current_user_ns(),
+				entry->gid = make_kgid(user_ns,
 						       (gid_t)lnum);
 				if (!gid_valid(entry->gid) ||
 				    (((gid_t)lnum) != lnum))
@@ -1754,7 +1770,7 @@ static int ima_parse_rule(struct ima_namespace *ns,
 
 			result = kstrtoul(args[0].from, 10, &lnum);
 			if (!result) {
-				entry->fowner = make_kuid(current_user_ns(),
+				entry->fowner = make_kuid(user_ns,
 							  (uid_t)lnum);
 				if (!uid_valid(entry->fowner) ||
 				    (((uid_t)lnum) != lnum))
@@ -1780,7 +1796,7 @@ static int ima_parse_rule(struct ima_namespace *ns,
 
 			result = kstrtoul(args[0].from, 10, &lnum);
 			if (!result) {
-				entry->fgroup = make_kgid(current_user_ns(),
+				entry->fgroup = make_kgid(user_ns,
 							  (gid_t)lnum);
 				if (!gid_valid(entry->fgroup) ||
 				    (((gid_t)lnum) != lnum))
@@ -1935,6 +1951,12 @@ static int ima_parse_rule(struct ima_namespace *ns,
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
@@ -1966,14 +1988,15 @@ static int ima_parse_rule(struct ima_namespace *ns,
 
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
@@ -1998,7 +2021,7 @@ ssize_t ima_parse_add_rule(struct ima_namespace *ns, char *rule)
 
 	INIT_LIST_HEAD(&entry->list);
 
-	result = ima_parse_rule(ns, p, entry);
+	result = ima_parse_rule(user_ns, p, entry);
 	if (result) {
 		ima_free_rule(entry);
 		if (ns == &init_ima_ns)
@@ -2024,7 +2047,9 @@ void ima_delete_rules(struct ima_namespace *ns)
 {
 	struct ima_rule_entry *entry, *tmp;
 
-	temp_ima_appraise = 0;
+	if (ns == &init_ima_ns)
+		temp_ima_appraise = 0;
+
 	list_for_each_entry_safe(entry, tmp, &ns->ima_temp_rules, list) {
 		list_del(&entry->list);
 		ima_free_rule(entry);
@@ -2065,7 +2090,7 @@ static const char *const mask_tokens[] = {
 
 void *ima_policy_start(struct seq_file *m, loff_t *pos)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = ima_ns_from_file(m->file);
 	loff_t l = *pos;
 	struct ima_rule_entry *entry;
 	struct list_head *ima_rules_tmp;
@@ -2086,7 +2111,7 @@ void *ima_policy_start(struct seq_file *m, loff_t *pos)
 
 void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos)
 {
-	struct ima_namespace *ns = &init_ima_ns;
+	struct ima_namespace *ns = ima_ns_from_file(m->file);
 	struct ima_rule_entry *entry = v;
 
 	rcu_read_lock();
-- 
2.37.3

