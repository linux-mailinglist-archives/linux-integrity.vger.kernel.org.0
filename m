Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3BE46C489
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Dec 2021 21:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241514AbhLGU0f (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Dec 2021 15:26:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31504 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241304AbhLGU0S (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Dec 2021 15:26:18 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B7Jbfb7027243;
        Tue, 7 Dec 2021 20:22:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=JUuy3t+8HN+Piv8GDxJ6jewhg6X4npu2ObmOtAqQBVs=;
 b=ejSKBfkesazQ2q+FlsQ/lAozebF3lJPIM5CTElCaapVqPzAUmnEsdXMSgio9NKRHBCr3
 +5KBpYAVlJ0C3VwnCQgGc8QyRYw3xWh/4Wp6gWGppRKC9YjL1tb2wWs9XPdk2x9SFfRd
 m+onmxFzW2PHKZudDFzhrwJWoA/WjAHrrFErWzNoJmlsSdy7kb263RIhhRyJ36b/Vdte
 wJX8ecgvAmDuJaHnkis+imPPrW6YtUuDRWYX9lFix2UHWJsyRl+kevLawpUC7oGCCcrS
 y2IXNRN2kJR2WJxby1z4+SMQ6GIXO4eQlHTpCYJ1kIvTWSXfMxN0ECaKkG5JGfgSGG5j WQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ct811j0aa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 20:22:38 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B7K9RPv027980;
        Tue, 7 Dec 2021 20:22:38 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ct811j09y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 20:22:38 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B7K7pZd018282;
        Tue, 7 Dec 2021 20:22:37 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma03dal.us.ibm.com with ESMTP id 3cqyyb2dvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 20:22:37 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B7KMZWD35979676
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Dec 2021 20:22:35 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2CC6136055;
        Tue,  7 Dec 2021 20:22:35 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34326136063;
        Tue,  7 Dec 2021 20:22:33 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  7 Dec 2021 20:22:33 +0000 (GMT)
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
Subject: [PATCH v4 16/16] ima: Setup securityfs for IMA namespace
Date:   Tue,  7 Dec 2021 15:21:27 -0500
Message-Id: <20211207202127.1508689-17-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211207202127.1508689-1-stefanb@linux.ibm.com>
References: <20211207202127.1508689-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: u5JWlByzX5ou1sDi1oDbOtGqTmc2uSwR
X-Proofpoint-GUID: 8zMaXG6qlEx67FT8-zaOzXLNt8u15auB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-07_07,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112070122
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

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
 include/linux/ima.h             | 17 ++++++++++++++++-
 security/inode.c                | 12 +++++++++++-
 security/integrity/ima/ima_fs.c | 33 ++++++++++++++++++++++++++-------
 3 files changed, 53 insertions(+), 9 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index bfb978a7f8d5..a8017272d78d 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -66,6 +66,10 @@ static inline const char * const *arch_get_ima_policy(void)
 }
 #endif
 
+extern int ima_fs_ns_init(struct user_namespace *user_ns,
+			  struct dentry *root);
+extern void ima_fs_ns_free_dentries(struct user_namespace *user_ns);
+
 #else
 static inline enum hash_algo ima_get_current_hash_algo(void)
 {
@@ -154,6 +158,15 @@ static inline int ima_measure_critical_data(const char *event_label,
 	return -ENOENT;
 }
 
+static inline int ima_fs_ns_init(struct user_namespace *ns, struct dentry *root)
+{
+	return 0;
+}
+
+static inline void ima_fs_ns_free_dentries(struct user_namespace *user_ns)
+{
+}
+
 #endif /* CONFIG_IMA */
 
 #ifndef CONFIG_IMA_KEXEC
@@ -221,7 +234,8 @@ struct ima_h_table {
 };
 
 enum {
-	IMAFS_DENTRY_DIR = 0,
+	IMAFS_DENTRY_INTEGRITY_DIR = 0,
+	IMAFS_DENTRY_DIR,
 	IMAFS_DENTRY_SYMLINK,
 	IMAFS_DENTRY_BINARY_RUNTIME_MEASUREMENTS,
 	IMAFS_DENTRY_ASCII_RUNTIME_MEASUREMENTS,
@@ -333,6 +347,7 @@ static inline struct ima_namespace *get_current_ns(void)
 {
 	return &init_ima_ns;
 }
+
 #endif /* CONFIG_IMA_NS */
 
 #if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
diff --git a/security/inode.c b/security/inode.c
index 121ac1874dde..10ee20917f42 100644
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
+		error = ima_fs_ns_init(ns, sb->s_root);
+
+	return error;
 }
 
 static int securityfs_get_tree(struct fs_context *fc)
@@ -69,6 +74,11 @@ static int securityfs_init_fs_context(struct fs_context *fc)
 
 static void securityfs_kill_super(struct super_block *sb)
 {
+	struct user_namespace *ns = sb->s_fs_info;
+
+	if (ns != &init_user_ns)
+		ima_fs_ns_free_dentries(ns);
+
 	kill_litter_super(sb);
 }
 
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index e2cee1457aaa..ea366c8e68c6 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -447,8 +447,9 @@ static const struct file_operations ima_measure_policy_ops = {
 	.llseek = generic_file_llseek,
 };
 
-static void ima_fs_ns_free_dentries(struct ima_namespace *ns)
+void ima_fs_ns_free_dentries(struct user_namespace *user_ns)
 {
+	struct ima_namespace *ns = user_ns->ima_ns;
 	int i;
 
 	for (i = IMAFS_DENTRY_LAST - 1; i >= 0; i--)
@@ -457,18 +458,36 @@ static void ima_fs_ns_free_dentries(struct ima_namespace *ns)
 	memset(ns->dentry, 0, sizeof(ns->dentry));
 }
 
-static int __init ima_fs_ns_init(struct user_namespace *user_ns)
+int ima_fs_ns_init(struct user_namespace *user_ns,
+		   struct dentry *root)
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
 
@@ -508,11 +527,11 @@ static int __init ima_fs_ns_init(struct user_namespace *user_ns)
 
 	return 0;
 out:
-	ima_fs_ns_free_dentries(ns);
+	ima_fs_ns_free_dentries(user_ns);
 	return -1;
 }
 
 int __init ima_fs_init(void)
 {
-	return ima_fs_ns_init(&init_user_ns);
+	return ima_fs_ns_init(&init_user_ns, NULL);
 }
-- 
2.31.1

