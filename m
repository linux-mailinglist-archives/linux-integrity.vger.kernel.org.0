Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845924A65DC
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Feb 2022 21:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240219AbiBAUiP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Feb 2022 15:38:15 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29394 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239781AbiBAUiM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Feb 2022 15:38:12 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 211JSkDc019788;
        Tue, 1 Feb 2022 20:37:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=iqwhRx0IcUDyYsFOHXDjoCW/DzELq8iqUis5ktL6+zI=;
 b=qteCGKYIOfJai8oOMjSMf14s4nG6604MDWJX/CprwkpjSLewQ3Lxuk8s2AdMxoaJAz6u
 sncI3qlI1IwOmc7359Cz8zDh3KzfrEqHLpM+58kfLnpb9XdHmghoX521SqDcjuSU1QwX
 CaI0Zaah1m19sXkejN1WZuGI/1GnXE6rsg7R02Qn6kLx2uKCMBZBY8v3mYpKfGh4dU6t
 opxiJADWdwb6fy9GLeQjFa0x2AFAiHFyYANgJfCQLL4GpaBzVfMrQh0a0DcKLiq8oWFI
 bQFrNaF6KN91aKAa8aLlFPp9JwxnwTUpg5Z6DYdP7oFFzm1YONGKJlKwUoCqjSSmkltu 2g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dyb29h754-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 20:37:56 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 211KbuTS036913;
        Tue, 1 Feb 2022 20:37:56 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dyb29h74p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 20:37:56 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 211KX6OB024225;
        Tue, 1 Feb 2022 20:37:54 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03wdc.us.ibm.com with ESMTP id 3dvw7as4d9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Feb 2022 20:37:54 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 211KbqeS41484694
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Feb 2022 20:37:52 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67AEEB2070;
        Tue,  1 Feb 2022 20:37:52 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47D81B206C;
        Tue,  1 Feb 2022 20:37:52 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  1 Feb 2022 20:37:52 +0000 (GMT)
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
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH v10 23/27] ima: Setup securityfs for IMA namespace
Date:   Tue,  1 Feb 2022 15:37:31 -0500
Message-Id: <20220201203735.164593-24-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220201203735.164593-1-stefanb@linux.ibm.com>
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VJB2DUFpeBvVnB4Uuk3kEvYGOuH6bSkI
X-Proofpoint-ORIG-GUID: bg77z-c22FfiL5Y2EO3jpBgKxsDVerG8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_09,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0
 clxscore=1011 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202010114
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Setup securityfs with symlinks, directories, and files for IMA
namespacing support. The same directory structure that IMA uses on the
host is also created for the namespacing case.

The securityfs file and directory ownerships cannot be set when the
IMA namespace is initialized. Therefore, delay the setup of the file
system to a later point when securityfs is in securityfs_fill_super.

Introduce a variable ima_policy_removed in ima_namespace that is used to
remember whether the policy file has previously been removed and thus
should not be created again in case of unmounting and again mounting
securityfs inside an IMA namespace.

This filesystem can now be mounted as follows:

mount -t securityfs /sys/kernel/security/ /sys/kernel/security/

The following directories, symlinks, and files are available
when IMA namespacing is enabled, otherwise it will be empty:

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
Acked-by: Christian Brauner <brauner@kernel.org>

---

v9:
 - rename policy_dentry_removed to ima_policy_removed
---
 include/linux/ima.h             | 13 ++++++++++
 security/inode.c                |  6 ++++-
 security/integrity/ima/ima.h    |  1 +
 security/integrity/ima/ima_fs.c | 46 +++++++++++++++++++++++----------
 4 files changed, 52 insertions(+), 14 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 2fe32f1bf84b..c584527c0f47 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -41,6 +41,7 @@ extern int ima_measure_critical_data(const char *event_label,
 				     const char *event_name,
 				     const void *buf, size_t buf_len,
 				     bool hash, u8 *digest, size_t digest_len);
+extern int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root);
 
 #ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
 extern void ima_appraise_parse_cmdline(void);
@@ -227,6 +228,12 @@ void free_ima_ns(struct user_namespace *ns);
 
 void ima_free_ns_status_list(struct list_head *head, rwlock_t *ns_list_lock);
 
+static inline int ima_securityfs_init(struct user_namespace *user_ns,
+				      struct dentry *root)
+{
+	return ima_fs_ns_init(user_ns, root);
+}
+
 #else
 
 static inline void free_ima_ns(struct user_namespace *user_ns)
@@ -238,6 +245,12 @@ static inline void ima_free_ns_status_list(struct list_head *head,
 {
 }
 
+static inline int ima_securityfs_init(struct user_namespace *ns,
+				      struct dentry *root)
+{
+	return 0;
+}
+
 #endif /* CONFIG_IMA_NS */
 
 #endif /* _LINUX_IMA_H */
diff --git a/security/inode.c b/security/inode.c
index e525ba960063..cdb08520151c 100644
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
@@ -81,7 +82,10 @@ static int securityfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_op = &securityfs_super_operations;
 	sb->s_root->d_inode->i_op = &securityfs_dir_inode_operations;
 
-	return 0;
+	if (ns != &init_user_ns)
+		error = ima_securityfs_init(ns, sb->s_root);
+
+	return error;
 }
 
 static int securityfs_get_tree(struct fs_context *fc)
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index ec0b81c7dbf5..1e3f9dda218d 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -148,6 +148,7 @@ struct ima_namespace {
 	int valid_policy;
 
 	struct dentry *ima_policy;
+	bool ima_policy_removed;
 
 	struct notifier_block ima_lsm_policy_notifier;
 } __randomize_layout;
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index c41aa61b7393..84cd02a9e19b 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -21,6 +21,7 @@
 #include <linux/rcupdate.h>
 #include <linux/parser.h>
 #include <linux/vmalloc.h>
+#include <linux/ima.h>
 
 #include "ima.h"
 
@@ -433,6 +434,7 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 #if !defined(CONFIG_IMA_WRITE_POLICY) && !defined(CONFIG_IMA_READ_POLICY)
 	securityfs_remove(ns->ima_policy);
 	ns->ima_policy = NULL;
+	ns->ima_policy_removed = true;
 #elif defined(CONFIG_IMA_WRITE_POLICY)
 	clear_bit(IMA_FS_BUSY, &ns->ima_fs_flags);
 #elif defined(CONFIG_IMA_READ_POLICY)
@@ -449,9 +451,11 @@ static const struct file_operations ima_measure_policy_ops = {
 	.llseek = generic_file_llseek,
 };
 
-static int __init ima_fs_ns_init(struct ima_namespace *ns)
+int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
 {
-	struct dentry *ima_dir;
+	struct ima_namespace *ns = ima_ns_from_user_ns(user_ns);
+	struct dentry *int_dir;
+	struct dentry *ima_dir = NULL;
 	struct dentry *ima_symlink = NULL;
 	struct dentry *binary_runtime_measurements = NULL;
 	struct dentry *ascii_runtime_measurements = NULL;
@@ -459,11 +463,22 @@ static int __init ima_fs_ns_init(struct ima_namespace *ns)
 	struct dentry *violations = NULL;
 	int ret;
 
-	ima_dir = securityfs_create_dir("ima", integrity_dir);
-	if (IS_ERR(ima_dir))
-		return PTR_ERR(ima_dir);
+	/* FIXME: update when evm and integrity are namespaced */
+	if (user_ns != &init_user_ns) {
+		int_dir = securityfs_create_dir("integrity", root);
+		if (IS_ERR(int_dir))
+			return PTR_ERR(int_dir);
+	} else {
+		int_dir = integrity_dir;
+	}
 
-	ima_symlink = securityfs_create_symlink("ima", NULL, "integrity/ima",
+	ima_dir = securityfs_create_dir("ima", int_dir);
+	if (IS_ERR(ima_dir)) {
+		ret = PTR_ERR(ima_dir);
+		goto out;
+	}
+
+	ima_symlink = securityfs_create_symlink("ima", root, "integrity/ima",
 						NULL);
 	if (IS_ERR(ima_symlink)) {
 		ret = PTR_ERR(ima_symlink);
@@ -505,12 +520,15 @@ static int __init ima_fs_ns_init(struct ima_namespace *ns)
 		goto out;
 	}
 
-	ns->ima_policy = securityfs_create_file("policy", POLICY_FILE_FLAGS,
-						ima_dir, NULL,
-						&ima_measure_policy_ops);
-	if (IS_ERR(ns->ima_policy)) {
-		ret = PTR_ERR(ns->ima_policy);
-		goto out;
+	if (!ns->ima_policy_removed) {
+		ns->ima_policy =
+		    securityfs_create_file("policy", POLICY_FILE_FLAGS,
+					   ima_dir, NULL,
+					   &ima_measure_policy_ops);
+		if (IS_ERR(ns->ima_policy)) {
+			ret = PTR_ERR(ns->ima_policy);
+			goto out;
+		}
 	}
 
 	return 0;
@@ -522,11 +540,13 @@ static int __init ima_fs_ns_init(struct ima_namespace *ns)
 	securityfs_remove(binary_runtime_measurements);
 	securityfs_remove(ima_symlink);
 	securityfs_remove(ima_dir);
+	if (user_ns != &init_user_ns)
+		securityfs_remove(int_dir);
 
 	return ret;
 }
 
 int __init ima_fs_init(void)
 {
-	return ima_fs_ns_init(&init_ima_ns);
+	return ima_fs_ns_init(&init_user_ns, NULL);
 }
-- 
2.31.1

