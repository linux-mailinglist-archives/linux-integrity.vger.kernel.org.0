Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692AD46DE35
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Dec 2021 23:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237348AbhLHWW4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Dec 2021 17:22:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62654 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240643AbhLHWWO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Dec 2021 17:22:14 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B8M2nDv018264;
        Wed, 8 Dec 2021 22:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=SnSnTm1PB90pI8Qe6SlC9VcztsKW6e9iEXPZsyVca9M=;
 b=pn2orsz/qQAu/K4BiUYWEGo9SrwtoDmhgcYpe4rStfT7rEohYXFS+20KVgnF0p8f//Ue
 JjFFrOg3piK3W157Ne2tXmX9pVua23gZlxAnfw2AbLN3ZRzQdM5fkCF+D69slBKNsgql
 QnBVd12OBy3TY4IGspvwPufMDIom3efaOLqA274XHaDGw68rQ2jZNeGcYooHw0WVnIpB
 BugsFohreRYq/6JfkH7rtn6M04yqC7k9c/TXXdyjrFcWx/EyPnGrAQJbfh+48BB3NQgL
 ni714Ox2cI1A9YdwVNXg1Tl5ryajhYFIGbFjxBxY5Wt7v9J7XPYfHGzvzJkAkRNCAATo Rg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cu55g07ep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 22:18:28 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B8MFhqi004767;
        Wed, 8 Dec 2021 22:18:28 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cu55g07ee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 22:18:28 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B8MDuaP021830;
        Wed, 8 Dec 2021 22:18:27 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma03dal.us.ibm.com with ESMTP id 3cqyybyknt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 22:18:27 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B8MIP2Y15139128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Dec 2021 22:18:25 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CBD728059;
        Wed,  8 Dec 2021 22:18:25 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D64C2805E;
        Wed,  8 Dec 2021 22:18:25 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  8 Dec 2021 22:18:25 +0000 (GMT)
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
        Stefan Berger <stefanb@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: [PATCH v5 16/16] ima: Setup securityfs for IMA namespace
Date:   Wed,  8 Dec 2021 17:18:18 -0500
Message-Id: <20211208221818.1519628-17-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211208221818.1519628-1-stefanb@linux.ibm.com>
References: <20211208221818.1519628-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MYrHImFelqNxSpFEJsD4ZmdBlsXibsuV
X-Proofpoint-ORIG-GUID: W13sAap3KwackieVGKEhhrZY8ljl2dA3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-08_08,2021-12-08_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 suspectscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112080121
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Setup securityfs with symlinks, directories, and files for IMA
namespacing support. The same directory structure that IMA uses on the
host is also created for the namespacing case.

The securityfs file and directory ownerships cannot be set when the
IMA namespace is initialized. Therefore, delay the setup of the file
system to a later point when securityfs is in securityfs_fill_super.

Only take an additional reference on the dentry in the init_user_ns
case. This avoids having to explicitly free the dentries when the
superblock is killed. Adjust the documentation of securityfs_create_dentry
to reflect this.

This filesystem can now be mounted as follows:

mount -t securityfs /sys/kernel/security/ /sys/kernel/security/

The following directories, symlinks, and files are then available.

$ ls -l sys/kernel/security/
total 0
lr--r--r--. 1 root root 0 Dec  2 00:18 ima -> integrity/ima
drwxr-xr-x. 3 root root 0 Dec  2 00:18 integrity

$ ls -l sys/kernel/security/ima/
total 0
-r--r-----. 1 root root 0 Dec  2 00:18 ascii_runtime_measurements
-r--r-----. 1 root root 0 Dec  2 00:18 binary_runtime_measurements
-rw-------. 1 root root 0 Dec  2 00:18 policy
-r--r-----. 1 root root 0 Dec  2 00:18 runtime_measurements_count
-r--r-----. 1 root root 0 Dec  2 00:18 violations

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 include/linux/ima.h             | 12 ++++++++++-
 security/inode.c                | 20 ++++++++++++++-----
 security/integrity/ima/ima_fs.c | 35 ++++++++++++++++++++++++++-------
 3 files changed, 54 insertions(+), 13 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 4dd64e318b15..32bf98092143 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -66,6 +66,9 @@ static inline const char * const *arch_get_ima_policy(void)
 }
 #endif
 
+extern int ima_securityfs_init(struct user_namespace *user_ns,
+			       struct dentry *root);
+
 #else
 static inline enum hash_algo ima_get_current_hash_algo(void)
 {
@@ -154,6 +157,11 @@ static inline int ima_measure_critical_data(const char *event_label,
 	return -ENOENT;
 }
 
+static inline int ima_securityfs_init(struct user_namespace *ns, struct dentry *root)
+{
+	return 0;
+}
+
 #endif /* CONFIG_IMA */
 
 #ifndef CONFIG_IMA_KEXEC
@@ -221,7 +229,8 @@ struct ima_h_table {
 };
 
 enum {
-	IMAFS_DENTRY_DIR = 0,
+	IMAFS_DENTRY_INTEGRITY_DIR = 0,
+	IMAFS_DENTRY_DIR,
 	IMAFS_DENTRY_SYMLINK,
 	IMAFS_DENTRY_BINARY_RUNTIME_MEASUREMENTS,
 	IMAFS_DENTRY_ASCII_RUNTIME_MEASUREMENTS,
@@ -336,6 +345,7 @@ static inline struct ima_namespace *get_current_ns(void)
 {
 	return &init_ima_ns;
 }
+
 #endif /* CONFIG_IMA_NS */
 
 #if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
diff --git a/security/inode.c b/security/inode.c
index c1aef4613a17..eaccba7017d9 100644
--- a/security/inode.c
+++ b/security/inode.c
@@ -16,6 +16,7 @@
 #include <linux/fs_context.h>
 #include <linux/mount.h>
 #include <linux/pagemap.h>
+#include <linux/ima.h>
 #include <linux/init.h>
 #include <linux/namei.h>
 #include <linux/security.h>
@@ -41,6 +42,7 @@ static const struct super_operations securityfs_super_operations = {
 static int securityfs_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	static const struct tree_descr files[] = {{""}};
+	struct user_namespace *ns = fc->user_ns;
 	int error;
 
 	error = simple_fill_super(sb, SECURITYFS_MAGIC, files);
@@ -49,7 +51,10 @@ static int securityfs_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	sb->s_op = &securityfs_super_operations;
 
-	return 0;
+	if (ns != &init_user_ns)
+		error = ima_securityfs_init(ns, sb->s_root);
+
+	return error;
 }
 
 static int securityfs_get_tree(struct fs_context *fc)
@@ -97,11 +102,15 @@ static struct file_system_type fs_type = {
  * securityfs_create_dir() function is recommended to be used
  * instead).
  *
- * This function returns a pointer to a dentry if it succeeds.  This
+ * This function returns a pointer to a dentry if it succeeds. If the
+ * dentry was created while the init_user_ns was active, then this
  * pointer must be passed to the securityfs_remove() function when the
  * file is to be removed (no automatic cleanup happens if your module
- * is unloaded, you are responsible here).  If an error occurs, the
- * function will return the error value (via ERR_PTR).
+ * is unloaded, you are responsible here). If any other user namespace
+ * was active then the dentry may be removed using securityfs_remove()
+ * when a module is removed but no cleanup must be done once the
+ * superblock was delete since then it will be deleted automatically.
+ * If an error occurs, the function will return the error value (via ERR_PTR).
  *
  * If securityfs is not enabled in the kernel, the value %-ENODEV is
  * returned.
@@ -169,7 +178,8 @@ static struct dentry *securityfs_create_dentry(const char *name, umode_t mode,
 		inode->i_fop = fops;
 	}
 	d_instantiate(dentry, inode);
-	dget(dentry);
+	if (ns == &init_user_ns)
+		dget(dentry);
 	inode_unlock(dir);
 	return dentry;
 
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 3810d11fb463..778983fd9a73 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -447,8 +447,12 @@ static const struct file_operations ima_measure_policy_ops = {
 	.llseek = generic_file_llseek,
 };
 
-static void ima_fs_ns_free_dentries(struct ima_namespace *ns)
+/* Remove the dentries. In case user_ns == &init_user_ns this function
+ * does not need to be called since there's one less reference to dentries.
+ */
+static void ima_fs_ns_free_dentries(struct user_namespace *user_ns)
 {
+	struct ima_namespace *ns = user_ns->ima_ns;
 	int i;
 
 	for (i = IMAFS_DENTRY_LAST - 1; i >= 0; i--)
@@ -457,18 +461,35 @@ static void ima_fs_ns_free_dentries(struct ima_namespace *ns)
 	memset(ns->dentry, 0, sizeof(ns->dentry));
 }
 
-static int __init ima_securityfs_init(struct user_namespace *user_ns)
+int ima_securityfs_init(struct user_namespace *user_ns, struct dentry *root)
 {
 	struct ima_namespace *ns = user_ns->ima_ns;
 	struct dentry *ima_dir;
 
-	ns->dentry[IMAFS_DENTRY_DIR] = securityfs_create_dir("ima", integrity_dir);
+	/* already initialized? */
+	if (ns->dentry[IMAFS_DENTRY_INTEGRITY_DIR])
+		return 0;
+
+	/* FIXME: update when evm and integrity are namespaced */
+	if (user_ns != &init_user_ns) {
+		ns->dentry[IMAFS_DENTRY_INTEGRITY_DIR] =
+			securityfs_create_dir("integrity", root);
+		if (IS_ERR(ns->dentry[IMAFS_DENTRY_INTEGRITY_DIR])) {
+			ns->dentry[IMAFS_DENTRY_INTEGRITY_DIR] = NULL;
+			return -1;
+		}
+	} else
+		ns->dentry[IMAFS_DENTRY_INTEGRITY_DIR] = integrity_dir;
+
+	ns->dentry[IMAFS_DENTRY_DIR] =
+	    securityfs_create_dir("ima",
+				  ns->dentry[IMAFS_DENTRY_INTEGRITY_DIR]);
 	if (IS_ERR(ns->dentry[IMAFS_DENTRY_DIR]))
-		return -1;
+		goto out;
 	ima_dir = ns->dentry[IMAFS_DENTRY_DIR];
 
 	ns->dentry[IMAFS_DENTRY_SYMLINK] =
-	    securityfs_create_symlink("ima", NULL, "integrity/ima", NULL);
+	    securityfs_create_symlink("ima", root, "integrity/ima", NULL);
 	if (IS_ERR(ns->dentry[IMAFS_DENTRY_SYMLINK]))
 		goto out;
 
@@ -508,11 +529,11 @@ static int __init ima_securityfs_init(struct user_namespace *user_ns)
 
 	return 0;
 out:
-	ima_fs_ns_free_dentries(ns);
+	ima_fs_ns_free_dentries(user_ns);
 	return -1;
 }
 
 int __init ima_fs_init(void)
 {
-	return ima_securityfs_init(&init_user_ns);
+	return ima_securityfs_init(&init_user_ns, NULL);
 }
-- 
2.31.1

