Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7443B248A51
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 17:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgHRPpx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Aug 2020 11:45:53 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2642 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727776AbgHRPpq (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 11:45:46 -0400
Received: from lhreml722-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id E2095DBC14B5030596FB;
        Tue, 18 Aug 2020 16:45:44 +0100 (IST)
Received: from kstruczy-linux-box (10.204.65.138) by
 lhreml722-chm.china.huawei.com (10.201.108.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 18 Aug 2020 16:45:43 +0100
Received: by kstruczy-linux-box (sSMTP sendmail emulation); Tue, 18 Aug 2020 17:45:45 +0200
From:   <krzysztof.struczynski@huawei.com>
To:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <containers@lists.linux-foundation.org>,
        <linux-security-module@vger.kernel.org>
CC:     <zohar@linux.ibm.com>, <stefanb@linux.vnet.ibm.com>,
        <sunyuqiong1988@gmail.com>, <mkayaalp@cs.binghamton.edu>,
        <dmitry.kasatkin@gmail.com>, <serge@hallyn.com>,
        <jmorris@namei.org>, <christian@brauner.io>,
        <silviu.vlasceanu@huawei.com>, <roberto.sassu@huawei.com>,
        Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
Subject: [RFC PATCH 19/30] ima: Configure the new ima namespace from securityfs
Date:   Tue, 18 Aug 2020 17:42:19 +0200
Message-ID: <20200818154230.14016-10-krzysztof.struczynski@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200818154230.14016-1-krzysztof.struczynski@huawei.com>
References: <20200818154230.14016-1-krzysztof.struczynski@huawei.com>
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

Add ima securityfs entries to configure per ima namespace:
- path to the policy file
- path to the x509 certificate
- ima kernel boot parameters

Policy file and x509 certificate will be parsed and loaded when the
first process is born into the new ima namespace, paths are not
validated when written. Kernel boot parameters are pre-parsed and the
same as above, the respective settings are applied when the first
process is born into the new namespace.

Signed-off-by: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
---
 include/linux/ima.h                   |   3 +
 security/integrity/ima/ima.h          |  21 ++--
 security/integrity/ima/ima_appraise.c |  11 +-
 security/integrity/ima/ima_fs.c       | 172 +++++++++++++++++++++----
 security/integrity/ima/ima_init.c     |   3 +
 security/integrity/ima/ima_ns.c       | 173 +++++++++++++++++++++++---
 security/integrity/ima/ima_policy.c   |  40 +++---
 7 files changed, 358 insertions(+), 65 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 4b5b832417b0..158028834747 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -205,6 +205,9 @@ struct ima_namespace {
 	struct list_head *measurements;
 	atomic_long_t ml_len; /* number of stored measurements in the list */
 	atomic_long_t violations;
+	char *policy_path_for_children;
+	char *x509_path_for_children;
+	struct ima_policy_setup_data *policy_setup_for_children;
 } __randomize_layout;
 
 extern struct ima_namespace init_ima_ns;
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index ef95522cc710..48d09efaffbe 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -62,6 +62,7 @@ struct ima_policy_setup_data {
 	int ima_appraise;
 	bool ima_use_secure_boot;
 	bool ima_use_appraise_tcb;
+	bool fail_unverifiable_sigs;
 };
 
 /* IMA event related data */
@@ -318,15 +319,10 @@ void *ima_policy_next(struct seq_file *m, void *v, loff_t *pos);
 void ima_policy_stop(struct seq_file *m, void *v);
 int ima_policy_show(struct seq_file *m, void *v);
 
-int ima_policy_setup(char *str,
-		     struct ima_policy_setup_data *policy_setup_data,
-		     bool *fail_unverifiable_sigs);
-int ima_default_measure_policy_setup(const char *str,
-				     struct ima_policy_setup_data *setup_data);
-int ima_default_appraise_policy_setup(const char *str,
-				      struct ima_policy_setup_data *setup_data);
-int ima_default_appraise_setup(const char *str,
-			       struct ima_policy_setup_data *setup_data);
+int ima_policy_setup(char *str, struct ima_namespace *ima_ns);
+int ima_default_measure_policy_setup(char *str, struct ima_namespace *ima_ns);
+int ima_default_appraise_policy_setup(char *str, struct ima_namespace *ima_ns);
+int ima_default_appraise_setup(char *str, struct ima_namespace *ima_ns);
 
 /* Appraise integrity measurements */
 #define IMA_APPRAISE_ENFORCE	0x01
@@ -443,6 +439,13 @@ static inline struct ima_namespace *get_current_ns(void)
 
 void ima_delete_ns_rules(struct ima_policy_data *policy_data,
 			 bool is_root_ns);
+
+ssize_t ima_ns_write_policy_for_children(struct ima_namespace *ima_ns,
+					 char *policy_path);
+ssize_t ima_ns_write_x509_for_children(struct ima_namespace *ima_ns,
+				       char *x509_path);
+ssize_t ima_ns_write_kcmd_for_children(struct ima_namespace *ima_ns,
+				       char *kcmd);
 #else
 static inline int __init ima_init_namespace(void)
 {
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index a5e775182fb0..72fb4caeda96 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -16,9 +16,14 @@
 
 #include "ima.h"
 
-int ima_default_appraise_setup(const char *str,
-			       struct ima_policy_setup_data *setup_data)
+int ima_default_appraise_setup(char *str,
+			       struct ima_namespace *ima_ns)
 {
+	struct ima_policy_setup_data *setup_data;
+
+	setup_data = (ima_ns == &init_ima_ns) ?
+		&init_policy_setup_data : ima_ns->policy_setup_for_children;
+
 #ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
 	if (arch_ima_get_secureboot()) {
 		pr_info("Secure boot enabled: ignoring ima_appraise=%s boot parameter option",
@@ -38,7 +43,7 @@ int ima_default_appraise_setup(const char *str,
 
 static int __init default_appraise_setup(char *str)
 {
-	return ima_default_appraise_setup(str, &init_policy_setup_data);
+	return ima_default_appraise_setup(str, &init_ima_ns);
 }
 
 __setup("ima_appraise=", default_appraise_setup);
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index b71c2552ac15..6c033857f521 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -20,6 +20,8 @@
 #include <linux/rcupdate.h>
 #include <linux/parser.h>
 #include <linux/vmalloc.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
 
 #include "ima.h"
 
@@ -37,6 +39,16 @@ __setup("ima_canonical_fmt", default_canonical_fmt_setup);
 
 static int valid_policy = 1;
 
+static int ima_open_simple(struct inode *inode, struct file *file)
+{
+	struct ima_namespace *ima_ns = get_current_ns();
+
+	if (!ns_capable(ima_ns->user_ns, CAP_SYS_ADMIN))
+		return -EPERM;
+
+	return 0;
+}
+
 static ssize_t ima_show_htable_value(char __user *buf, size_t count,
 				     loff_t *ppos, atomic_long_t *val)
 {
@@ -56,32 +68,12 @@ static ssize_t ima_show_htable_violations(struct file *filp,
 	return ima_show_htable_value(buf, count, ppos, &ima_ns->violations);
 }
 
-static int ima_open_htable_violations(struct inode *inode, struct file *file)
-{
-	struct ima_namespace *ima_ns = get_current_ns();
-
-	if (!ns_capable(ima_ns->user_ns, CAP_SYS_ADMIN))
-		return -EPERM;
-
-	return 0;
-}
-
 static const struct file_operations ima_htable_violations_ops = {
-	.open = ima_open_htable_violations,
+	.open = ima_open_simple,
 	.read = ima_show_htable_violations,
 	.llseek = generic_file_llseek,
 };
 
-static int ima_open_measurements_count(struct inode *inode, struct file *file)
-{
-	struct ima_namespace *ima_ns = get_current_ns();
-
-	if (!ns_capable(ima_ns->user_ns, CAP_SYS_ADMIN))
-		return -EPERM;
-
-	return 0;
-}
-
 static ssize_t ima_show_measurements_count(struct file *filp,
 					   char __user *buf,
 					   size_t count, loff_t *ppos)
@@ -92,7 +84,7 @@ static ssize_t ima_show_measurements_count(struct file *filp,
 }
 
 static const struct file_operations ima_measurements_count_ops = {
-	.open = ima_open_measurements_count,
+	.open = ima_open_simple,
 	.read = ima_show_measurements_count,
 	.llseek = generic_file_llseek,
 };
@@ -441,6 +433,11 @@ static struct dentry *ascii_runtime_measurements;
 static struct dentry *runtime_measurements_count;
 static struct dentry *violations;
 static struct dentry *ima_policy;
+#ifdef CONFIG_IMA_NS
+static struct dentry *policy_for_children;
+static struct dentry *x509_for_children;
+static struct dentry *kcmd_for_children;
+#endif /* CONFIG_IMA_NS */
 
 enum ima_fs_flags {
 	IMA_FS_BUSY,
@@ -531,6 +528,109 @@ static const struct file_operations ima_measure_policy_ops = {
 	.llseek = generic_file_llseek,
 };
 
+#ifdef CONFIG_IMA_NS
+static int ima_open_for_children(struct inode *inode, struct file *file)
+{
+	struct ima_namespace *ima_ns = get_current_ns();
+
+	/* Allow to set children configuration only after unshare() */
+	if (ima_ns == current->nsproxy->ima_ns_for_children)
+		return -EPERM;
+
+	return ima_open_simple(inode, file);
+}
+
+static ssize_t ima_write_policy_for_children(struct file *file,
+					     const char __user *buf,
+					     size_t count, loff_t *ppos)
+{
+	ssize_t res;
+	char *policy_path;
+	struct ima_namespace *ima_ns = current->nsproxy->ima_ns_for_children;
+
+	/* Only allow < page size writes at the beginning of the file */
+	if ((*ppos != 0) || (count >= PAGE_SIZE))
+		return -EINVAL;
+
+	policy_path = memdup_user_nul(buf, count);
+	if (IS_ERR(policy_path))
+		return PTR_ERR(policy_path);
+
+	res = ima_ns_write_policy_for_children(ima_ns, policy_path);
+	if (res) {
+		kfree(policy_path);
+		count = res;
+	}
+
+	return count;
+}
+
+static const struct file_operations ima_policy_for_children_ops = {
+	.open = ima_open_for_children,
+	.write = ima_write_policy_for_children,
+};
+
+static ssize_t ima_write_x509_for_children(struct file *file,
+					   const char __user *buf,
+					   size_t count, loff_t *ppos)
+{
+	ssize_t res;
+	char *x509_path;
+	struct ima_namespace *ima_ns = current->nsproxy->ima_ns_for_children;
+
+	/* Only allow < page size writes at the beginning of the file */
+	if ((*ppos != 0) || (count >= PAGE_SIZE))
+		return -EINVAL;
+
+	x509_path = memdup_user_nul(buf, count);
+	if (IS_ERR(x509_path))
+		return PTR_ERR(x509_path);
+
+	res = ima_ns_write_x509_for_children(ima_ns, x509_path);
+	if (res) {
+		kfree(x509_path);
+		count = res;
+	}
+
+	return count;
+}
+
+static const struct file_operations ima_x509_for_children_ops = {
+	.open = ima_open_for_children,
+	.write = ima_write_x509_for_children,
+};
+
+static ssize_t ima_write_kcmd_for_children(struct file *file,
+					   const char __user *buf,
+					   size_t count, loff_t *ppos)
+{
+	ssize_t res;
+	char *kcmd;
+	struct ima_namespace *ima_ns = current->nsproxy->ima_ns_for_children;
+
+	/* Only allow < page size writes at the beginning of the file */
+	if ((*ppos != 0) || (count >= PAGE_SIZE))
+		return -EINVAL;
+
+	kcmd = memdup_user_nul(buf, count);
+	if (IS_ERR(kcmd))
+		return PTR_ERR(kcmd);
+
+	res = ima_ns_write_kcmd_for_children(ima_ns, kcmd);
+	if (res)
+		count = res;
+
+	kfree(kcmd);
+
+	return count;
+}
+
+static const struct file_operations ima_kcmd_for_children_ops = {
+	.open = ima_open_for_children,
+	.write = ima_write_kcmd_for_children,
+};
+#endif /* CONFIG_IMA_NS */
+
 int __init ima_fs_init(void)
 {
 	ima_dir = securityfs_create_dir("ima", integrity_dir);
@@ -575,6 +675,29 @@ int __init ima_fs_init(void)
 	if (IS_ERR(ima_policy))
 		goto out;
 
+#ifdef CONFIG_IMA_NS
+	policy_for_children = securityfs_create_file("policy_for_children",
+						0202,
+						ima_dir, NULL,
+						&ima_policy_for_children_ops);
+	if (IS_ERR(policy_for_children))
+		goto out;
+
+	x509_for_children = securityfs_create_file("x509_for_children",
+						  0202,
+						  ima_dir, NULL,
+						  &ima_x509_for_children_ops);
+	if (IS_ERR(x509_for_children))
+		goto out;
+
+	kcmd_for_children = securityfs_create_file("kcmd_for_children",
+						   0202,
+						   ima_dir, NULL,
+						   &ima_kcmd_for_children_ops);
+	if (IS_ERR(kcmd_for_children))
+		goto out;
+#endif /* CONFIG_IMA_NS */
+
 	return 0;
 out:
 	securityfs_remove(violations);
@@ -584,5 +707,10 @@ int __init ima_fs_init(void)
 	securityfs_remove(ima_symlink);
 	securityfs_remove(ima_dir);
 	securityfs_remove(ima_policy);
+#ifdef CONFIG_IMA_NS
+	securityfs_remove(policy_for_children);
+	securityfs_remove(x509_for_children);
+	securityfs_remove(kcmd_for_children);
+#endif /* CONFIG_IMA_NS */
 	return -1;
 }
diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index f7b25b3f95de..d14c6689f422 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -31,6 +31,9 @@ struct ima_namespace init_ima_ns = {
 	.ns.inum = PROC_IMA_INIT_INO,
 #ifdef CONFIG_IMA_NS
 	.ns.ops = &imans_operations,
+	.policy_path_for_children = NULL,
+	.x509_path_for_children = NULL,
+	.policy_setup_for_children = NULL,
 #endif
 	.frozen = true,
 	.policy_data = &init_policy_data,
diff --git a/security/integrity/ima/ima_ns.c b/security/integrity/ima/ima_ns.c
index b8bfab39b55b..dd0328ee715f 100644
--- a/security/integrity/ima/ima_ns.c
+++ b/security/integrity/ima/ima_ns.c
@@ -26,6 +26,8 @@
 #include <linux/rwsem.h>
 #include <linux/workqueue.h>
 #include <linux/mutex.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
 
 #include "ima.h"
 
@@ -73,23 +75,28 @@ static struct ima_namespace *ima_ns_alloc(void)
 	return NULL;
 }
 
-static void ima_set_ns_policy(struct ima_namespace *ima_ns,
-			      char *policy_setup_str)
+static int ima_set_ns_policy(struct ima_namespace *ima_ns)
 {
-	struct ima_policy_setup_data setup_data;
+	int result = 0;
+	struct ima_policy_setup_data setup_data = {0};
 
+	/* If namespace activation failed after policy initialization and
+	 * another process tries to join/activate the same namespace again,
+	 * old rules have to be removed.
+	 */
+	ima_delete_ns_rules(ima_ns->policy_data, false);
+
+	if (!ima_ns->policy_setup_for_children) {
 #ifdef CONFIG_IMA_APPRAISE
-	setup_data.ima_appraise = IMA_APPRAISE_ENFORCE;
+		setup_data.ima_appraise = IMA_APPRAISE_ENFORCE;
 #endif
-	/* Configuring IMA namespace will be implemented in the following
-	 * patches. When it is done, parse configuration string and store result
-	 * in setup_data. Temporarily use init_policy_setup_data.
-	 */
-	setup_data = init_policy_setup_data;
-	ima_ns->policy_data->ima_fail_unverifiable_sigs =
-		init_ima_ns.policy_data->ima_fail_unverifiable_sigs;
+		ima_init_ns_policy(ima_ns, &setup_data);
+		return result;
+	}
 
-	ima_init_ns_policy(ima_ns, &setup_data);
+	ima_init_ns_policy(ima_ns, ima_ns->policy_setup_for_children);
+
+	return result;
 }
 
 static int ima_swap_user_ns(struct ima_namespace *ima_ns,
@@ -150,6 +157,10 @@ static struct ima_namespace *clone_ima_ns(struct user_namespace *user_ns,
 	rwlock_init(&ns->iint_tree->lock);
 	ns->iint_tree->root = RB_ROOT;
 
+	ns->policy_path_for_children = NULL;
+	ns->x509_path_for_children = NULL;
+	ns->policy_setup_for_children = NULL;
+
 	INIT_LIST_HEAD(&ns->policy_data->ima_default_rules);
 	INIT_LIST_HEAD(&ns->policy_data->ima_policy_rules);
 	INIT_LIST_HEAD(&ns->policy_data->ima_temp_rules);
@@ -199,6 +210,16 @@ int __init ima_init_namespace(void)
 	return 0;
 }
 
+static void destroy_child_config(struct ima_namespace *ima_ns)
+{
+	kfree(ima_ns->policy_path_for_children);
+	ima_ns->policy_path_for_children = NULL;
+	kfree(ima_ns->x509_path_for_children);
+	ima_ns->x509_path_for_children = NULL;
+	kfree(ima_ns->policy_setup_for_children);
+	ima_ns->policy_setup_for_children = NULL;
+}
+
 static void destroy_ima_ns(struct ima_namespace *ns)
 {
 	bool is_init_ns = (ns == &init_ima_ns);
@@ -210,6 +231,7 @@ static void destroy_ima_ns(struct ima_namespace *ns)
 	kfree(ns->iint_tree);
 	ima_delete_ns_rules(ns->policy_data, is_init_ns);
 	kfree(ns->policy_data);
+	destroy_child_config(ns);
 	kfree(ns);
 }
 
@@ -299,17 +321,21 @@ static void imans_put(struct ns_common *ns)
 
 static int imans_activate(struct ima_namespace *ima_ns)
 {
+	int res = 0;
+
 	if (ima_ns == &init_ima_ns)
-		return 0;
+		return res;
 
 	if (ima_ns->frozen)
-		return 0;
+		return res;
 
 	mutex_lock(&frozen_lock);
 	if (ima_ns->frozen)
 		goto out;
 
-	ima_set_ns_policy(ima_ns, NULL);
+	res = ima_set_ns_policy(ima_ns);
+	if (res < 0)
+		goto out;
 
 	ima_ns->frozen = true;
 
@@ -321,10 +347,12 @@ static int imans_activate(struct ima_namespace *ima_ns)
 	down_write(&ima_ns_list_lock);
 	list_add_tail(&ima_ns->list, &ima_ns_list);
 	up_write(&ima_ns_list_lock);
+
+	destroy_child_config(ima_ns);
 out:
 	mutex_unlock(&frozen_lock);
 
-	return 0;
+	return res;
 }
 
 static int imans_install(struct nsset *nsset, struct ns_common *new)
@@ -409,3 +437,116 @@ const struct proc_ns_operations imans_for_children_operations = {
 	.owner = imans_owner,
 };
 
+struct ima_kernel_param {
+	const char *name;
+	int (*set)(char *val, struct ima_namespace *ima_ns);
+};
+
+/* TODO: add ima_template, ima_template_fmt, ima_hash, ... */
+static const struct ima_kernel_param ima_kernel_params[] = {
+	{"ima_appraise", ima_default_appraise_setup},
+	{"ima_policy", ima_policy_setup},
+};
+static const size_t ima_kernel_params_size = ARRAY_SIZE(ima_kernel_params);
+
+ssize_t ima_ns_write_policy_for_children(struct ima_namespace *ima_ns,
+					 char *policy_path)
+{
+	ssize_t retval = 0;
+
+	mutex_lock(&frozen_lock);
+	if (ima_ns->frozen) {
+		retval = -EACCES;
+		goto out;
+	}
+
+	kfree(ima_ns->policy_path_for_children);
+	ima_ns->policy_path_for_children = policy_path;
+out:
+	mutex_unlock(&frozen_lock);
+
+	return retval;
+}
+
+ssize_t ima_ns_write_x509_for_children(struct ima_namespace *ima_ns,
+				       char *x509_path)
+{
+	ssize_t retval = 0;
+
+	mutex_lock(&frozen_lock);
+	if (ima_ns->frozen) {
+		retval = -EACCES;
+		goto out;
+	}
+
+	kfree(ima_ns->x509_path_for_children);
+	ima_ns->x509_path_for_children = x509_path;
+out:
+	mutex_unlock(&frozen_lock);
+
+	return retval;
+}
+
+ssize_t ima_ns_write_kcmd_for_children(struct ima_namespace *ima_ns,
+				       char *kcmd)
+{
+	u32 i;
+	char *param, *val;
+	ssize_t ret = 0;
+
+	mutex_lock(&frozen_lock);
+	if (ima_ns->frozen) {
+		ret = -EACCES;
+		goto err_unlock;
+	}
+
+	if (!ima_ns->policy_setup_for_children) {
+		ima_ns->policy_setup_for_children =
+			kmalloc(sizeof(struct ima_policy_setup_data),
+				GFP_KERNEL);
+		if (!ima_ns->policy_setup_for_children) {
+			ret = -ENOMEM;
+			goto err_unlock;
+		}
+	}
+
+	memset(ima_ns->policy_setup_for_children,
+	       0, sizeof(struct ima_policy_setup_data));
+
+#ifdef CONFIG_IMA_APPRAISE
+	ima_ns->policy_setup_for_children->ima_appraise = IMA_APPRAISE_ENFORCE;
+#endif
+
+	kcmd = skip_spaces(kcmd);
+	while (*kcmd) {
+		kcmd = next_arg(kcmd, &param, &val);
+		if (!val) {
+			ret = -EINVAL;
+			goto err_free;
+		}
+
+		for (i = 0; i < ima_kernel_params_size; i++) {
+			if (strcmp(param, ima_kernel_params[i].name) == 0)
+				break;
+		}
+
+		if (i == ima_kernel_params_size) {
+			ret = -EINVAL;
+			goto err_free;
+		}
+
+		ima_kernel_params[i].set(val, ima_ns);
+	}
+	mutex_unlock(&frozen_lock);
+
+	return ret;
+
+err_free:
+	kfree(ima_ns->policy_setup_for_children);
+	ima_ns->policy_setup_for_children = NULL;
+err_unlock:
+	mutex_unlock(&frozen_lock);
+
+	return ret;
+}
+
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 1f60ce9b2ffa..3d712c062ed0 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -217,9 +217,13 @@ struct ima_policy_data init_policy_data = {
 	.ima_rules = &init_policy_data.ima_default_rules,
 };
 
-int ima_default_measure_policy_setup(const char *str,
-				     struct ima_policy_setup_data *setup_data)
+int ima_default_measure_policy_setup(char *str, struct ima_namespace *ima_ns)
 {
+	struct ima_policy_setup_data *setup_data;
+
+	setup_data = (ima_ns == &init_ima_ns) ?
+		&init_policy_setup_data : ima_ns->policy_setup_for_children;
+
 	if (setup_data->ima_policy)
 		return 1;
 
@@ -229,7 +233,7 @@ int ima_default_measure_policy_setup(const char *str,
 
 static int __init default_measure_policy_setup(char *str)
 {
-	return ima_default_measure_policy_setup(str, &init_policy_setup_data);
+	return ima_default_measure_policy_setup(str, &init_ima_ns);
 }
 __setup("ima_tcb", default_measure_policy_setup);
 
@@ -238,15 +242,15 @@ static bool ima_fail_unverifiable_sigs __ro_after_init;
 /**
  * ima_policy_setup - parse policy configuration string "ima_policy="
  * @str: string to be parsed
- * @setup_data: pointer to a structure where parsed data is stored
- * @fail_unverifiable_sigs: boolean flag treated separately to preserve
- *                          __ro_after_init
+ * @ima_ns: pointer to the ima namespace which policy is being set
  */
-int ima_policy_setup(char *str,
-		     struct ima_policy_setup_data *setup_data,
-		     bool *fail_unverifiable_sigs)
+int ima_policy_setup(char *str, struct ima_namespace *ima_ns)
 {
 	char *p;
+	struct ima_policy_setup_data *setup_data;
+
+	setup_data = (ima_ns == &init_ima_ns) ?
+		&init_policy_setup_data : ima_ns->policy_setup_for_children;
 
 	while ((p = strsep(&str, " |\n")) != NULL) {
 		if (*p == ' ')
@@ -258,7 +262,7 @@ int ima_policy_setup(char *str,
 		else if (strcmp(p, "secure_boot") == 0)
 			setup_data->ima_use_secure_boot = true;
 		else if (strcmp(p, "fail_securely") == 0)
-			*fail_unverifiable_sigs = true;
+			setup_data->fail_unverifiable_sigs = true;
 	}
 
 	return 1;
@@ -266,21 +270,27 @@ int ima_policy_setup(char *str,
 
 static int __init policy_setup(char *str)
 {
-	return ima_policy_setup(str, &init_policy_setup_data,
-				&ima_fail_unverifiable_sigs);
+	ima_policy_setup(str, &init_ima_ns);
+	ima_fail_unverifiable_sigs =
+		init_policy_setup_data.fail_unverifiable_sigs;
+	return 1;
 }
 __setup("ima_policy=", policy_setup);
 
-int ima_default_appraise_policy_setup(const char *str,
-				      struct ima_policy_setup_data *setup_data)
+int ima_default_appraise_policy_setup(char *str, struct ima_namespace *ima_ns)
 {
+	struct ima_policy_setup_data *setup_data;
+
+	setup_data = (ima_ns == &init_ima_ns) ?
+		&init_policy_setup_data : ima_ns->policy_setup_for_children;
+
 	setup_data->ima_use_appraise_tcb = true;
 	return 1;
 }
 
 static int __init default_appraise_policy_setup(char *str)
 {
-	return ima_default_appraise_policy_setup(str, &init_policy_setup_data);
+	return ima_default_appraise_policy_setup(str, &init_ima_ns);
 }
 __setup("ima_appraise_tcb", default_appraise_policy_setup);
 
-- 
2.20.1

