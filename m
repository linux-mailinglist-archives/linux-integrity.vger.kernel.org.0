Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB1B4769D2
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Dec 2021 06:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233872AbhLPFoN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Dec 2021 00:44:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59276 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233820AbhLPFoA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Dec 2021 00:44:00 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BG4UrQh018664;
        Thu, 16 Dec 2021 05:43:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=WZTt5N+m24l3rB3fSDkkd5mvrbAxssRN3e1Z6VuINmQ=;
 b=FAYJwRQP+jG65NAZlJwZwYN8EfLNKu+qeFFdu0qIxD4oCP9EeATAnSHU0cqCIfzWFBHe
 bTUld9G+KBNC/+4yhVjib+BIOU2mlsTNIxzRFZnDZYELmjYFFL8yllBxUM+sQKkrCNUo
 9He982mDbBQboi05ZaupgkaKX3wJ69k1lbbSPGJ/0BzrM5I04zkwtdvdRt49AyzHzG/Q
 /a5drCFieokGM6ElHQ+jlpxa9r5z57lH2pB0Rm0q8ztmUOq4D1AVNwui6Ewhmc5NjSd1
 ncXUnRdF3+8ULi2UxWF4UUYip13bJYSr891Z01lYeJ7VV3LIk3agehULAi/gNe4WBrPc UQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cyn1jm9ak-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 05:43:47 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BG50el1007800;
        Thu, 16 Dec 2021 05:43:46 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cyn1jm9aa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 05:43:46 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BG5fvVJ032291;
        Thu, 16 Dec 2021 05:43:45 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma04dal.us.ibm.com with ESMTP id 3cy7hf9bsc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 05:43:45 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BG5hhnc31785366
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 05:43:43 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C51C96E053;
        Thu, 16 Dec 2021 05:43:43 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A26346E052;
        Thu, 16 Dec 2021 05:43:42 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 16 Dec 2021 05:43:42 +0000 (GMT)
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
        Stefan Berger <stefanb@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: [PATCH v7 14/14] ima: Setup securityfs for IMA namespace
Date:   Thu, 16 Dec 2021 00:43:23 -0500
Message-Id: <20211216054323.1707384-15-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216054323.1707384-1-stefanb@linux.vnet.ibm.com>
References: <20211216054323.1707384-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Sc4s3QC2UR58vrd4hIX3JvLoWYd3q0B6
X-Proofpoint-GUID: 1ao4xZzJj2v9K4_cmHTZGy5udDvbQHip
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-16_01,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160033
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Setup securityfs with symlinks, directories, and files for IMA
namespacing support. The same directory structure that IMA uses on the
host is also created for the namespacing case.

The securityfs file and directory ownerships cannot be set when the
IMA namespace is initialized. Therefore, delay the setup of the file
system to a later point when securityfs is in securityfs_fill_super.

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
 include/linux/ima.h             | 14 ++++++++++++
 security/inode.c                |  6 ++++-
 security/integrity/ima/ima.h    |  1 +
 security/integrity/ima/ima_fs.c | 40 ++++++++++++++++++++++++---------
 4 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index f9e592bb9560..a2705aa5242a 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -40,6 +40,7 @@ extern int ima_measure_critical_data(const char *event_label,
 				     const char *event_name,
 				     const void *buf, size_t buf_len,
 				     bool hash, u8 *digest, size_t digest_len);
+extern int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root);
 
 #ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
 extern void ima_appraise_parse_cmdline(void);
@@ -232,6 +233,12 @@ static inline struct ima_namespace *get_current_ns(void)
 	return current_user_ns()->ima_ns;
 }
 
+static inline int ima_securityfs_init(struct user_namespace *user_ns,
+				      struct dentry *root)
+{
+	return ima_fs_ns_init(user_ns, root);
+}
+
 #else
 
 static inline void free_ima_ns(struct user_namespace *user_ns)
@@ -250,6 +257,13 @@ static inline struct ima_namespace *get_current_ns(void)
 {
 	return &init_ima_ns;
 }
+
+static inline int ima_securityfs_init(struct user_namespace *ns,
+				      struct dentry *root)
+{
+	return 0;
+}
+
 #endif /* CONFIG_IMA_NS */
 
 #if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
diff --git a/security/inode.c b/security/inode.c
index a0d9f086e3d5..ad9395d121f2 100644
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
@@ -77,7 +78,10 @@ static int securityfs_fill_super(struct super_block *sb, struct fs_context *fc)
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
index d51703290e25..9b0f6a3763f9 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -148,6 +148,7 @@ struct ima_namespace {
 	int valid_policy;
 
 	struct dentry *policy_dentry;
+	bool policy_dentry_removed;
 } __randomize_layout;
 
 extern const int read_idmap[];
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 7c5a721f4f3d..3b8001ba62e3 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -431,6 +431,7 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 #if !defined(CONFIG_IMA_WRITE_POLICY) && !defined(CONFIG_IMA_READ_POLICY)
 	securityfs_remove(ns->policy_dentry);
 	ns->policy_dentry = NULL;
+	ns->policy_dentry_removed = true;
 #elif defined(CONFIG_IMA_WRITE_POLICY)
 	clear_bit(IMA_FS_BUSY, &ns->ima_fs_flags);
 #elif defined(CONFIG_IMA_READ_POLICY)
@@ -447,21 +448,31 @@ static const struct file_operations ima_measure_policy_ops = {
 	.llseek = generic_file_llseek,
 };
 
-static int __init ima_fs_ns_init(struct user_namespace *user_ns)
+int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
 {
 	struct ima_namespace *ns = user_ns->ima_ns;
-	struct dentry *ima_dir;
+	struct dentry *int_dir;
+	struct dentry *ima_dir = NULL;
 	struct dentry *ima_symlink = NULL;
 	struct dentry *binary_runtime_measurements = NULL;
 	struct dentry *ascii_runtime_measurements = NULL;
 	struct dentry *runtime_measurements_count = NULL;
 	struct dentry *violations = NULL;
 
-	ima_dir = securityfs_create_dir("ima", integrity_dir);
+	/* FIXME: update when evm and integrity are namespaced */
+	if (user_ns != &init_user_ns) {
+		int_dir =
+			securityfs_create_dir("integrity", root);
+		if (IS_ERR(int_dir))
+			return -1;
+	} else
+		int_dir = integrity_dir;
+
+	ima_dir = securityfs_create_dir("ima", int_dir);
 	if (IS_ERR(ima_dir))
-		return -1;
+		goto out;
 
-	ima_symlink = securityfs_create_symlink("ima", NULL, "integrity/ima",
+	ima_symlink = securityfs_create_symlink("ima", root, "integrity/ima",
 						NULL);
 	if (IS_ERR(ima_symlink))
 		goto out;
@@ -493,11 +504,15 @@ static int __init ima_fs_ns_init(struct user_namespace *user_ns)
 	if (IS_ERR(violations))
 		goto out;
 
-	ns->policy_dentry = securityfs_create_file("policy", POLICY_FILE_FLAGS,
-					    ima_dir, NULL,
-					    &ima_measure_policy_ops);
-	if (IS_ERR(ns->policy_dentry))
-		goto out;
+
+	if (!ns->policy_dentry_removed) {
+		ns->policy_dentry =
+		    securityfs_create_file("policy", POLICY_FILE_FLAGS,
+					   ima_dir, NULL,
+					   &ima_measure_policy_ops);
+		if (IS_ERR(ns->policy_dentry))
+			goto out;
+	}
 
 	return 0;
 out:
@@ -508,10 +523,13 @@ static int __init ima_fs_ns_init(struct user_namespace *user_ns)
 	securityfs_remove(binary_runtime_measurements);
 	securityfs_remove(ima_symlink);
 	securityfs_remove(ima_dir);
+	if (user_ns != &init_user_ns)
+		securityfs_remove(integrity_dir);
+
 	return -1;
 }
 
 int __init ima_fs_init(void)
 {
-	return ima_fs_ns_init(&init_user_ns);
+	return ima_fs_ns_init(&init_user_ns, NULL);
 }
-- 
2.31.1

