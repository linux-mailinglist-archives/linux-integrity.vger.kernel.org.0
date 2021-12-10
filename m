Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6683A470AB2
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Dec 2021 20:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343720AbhLJTva (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Dec 2021 14:51:30 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9506 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1343707AbhLJTv3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Dec 2021 14:51:29 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BAJRlLq004890;
        Fri, 10 Dec 2021 19:47:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=eYWEmDlzCVAiGJLTBHVFTM/ZODKRMSFQ2u0Jgxs2IC8=;
 b=YlQ/y114xDeLOAeVWMBXGOoRsDYa9OaXAYGbt3ZbAdkd7QTY+D/XGDnrAlrVEZPQoOpB
 2cH06eZLTjjE3nltPpZz4Cf+dZBlVvazVOjyOLZ9v0p9iesTOHdyxCYIMK7JH1XCu8Me
 2LVrI02N4+tsw3NiABzLCBdpi+sEszd2kvpOCMUZ0mznPmRVP+T7vU4E7nn2yHBpAFvk
 T696BbClkCb4ggFri+7XS+O1tNzBsE3J88v4avVO3pDTMYNsU+8Wv2cYr+NAJ25q3yOG
 Ak6X/UOSDNxm61e8hYaWg2UKqL2mQ0VjNodBm0zyidHv/ZuKlH0u3pQCiwvU30BvhQM2 lA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cvd2v0a0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 19:47:42 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BAJSZhV007661;
        Fri, 10 Dec 2021 19:47:41 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cvd2v0a0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 19:47:41 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BAJcgUO013152;
        Fri, 10 Dec 2021 19:47:40 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma01wdc.us.ibm.com with ESMTP id 3cqyycnqk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 19:47:40 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BAJlexq8061584
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 19:47:40 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D9F1AE05F;
        Fri, 10 Dec 2021 19:47:40 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E54C2AE067;
        Fri, 10 Dec 2021 19:47:39 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri, 10 Dec 2021 19:47:39 +0000 (GMT)
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
Subject: [PATCH v6 17/17] ima: Setup securityfs for IMA namespace
Date:   Fri, 10 Dec 2021 14:47:36 -0500
Message-Id: <20211210194736.1538863-18-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211210194736.1538863-1-stefanb@linux.ibm.com>
References: <20211210194736.1538863-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Hwo6Bjyz6GGOr1tOsRo4RoBd8GBnN3qq
X-Proofpoint-ORIG-GUID: DoieSRaiN9daNSgfDvGlM80uH4zFymWY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-10_07,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 phishscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112100106
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
 include/linux/ima.h             | 15 ++++++++++++-
 security/inode.c                |  7 +++++-
 security/integrity/ima/ima_fs.c | 40 ++++++++++++++++++++++++---------
 3 files changed, 49 insertions(+), 13 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index cc950ccbf157..5524f439d9cf 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -40,6 +40,7 @@ extern int ima_measure_critical_data(const char *event_label,
 				     const char *event_name,
 				     const void *buf, size_t buf_len,
 				     bool hash, u8 *digest, size_t digest_len);
+extern int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root);
 
 #ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
 extern void ima_appraise_parse_cmdline(void);
@@ -275,6 +276,7 @@ struct ima_namespace {
 	int valid_policy;
 
 	struct dentry *policy_dentry;
+	bool policy_dentry_removed;
 };
 
 extern struct ima_namespace init_ima_ns;
@@ -284,12 +286,17 @@ extern struct list_head ima_default_rules;
 
 void free_ima_ns(struct user_namespace *ns);
 int create_ima_ns(struct user_namespace *user_ns);
-
 static inline struct ima_namespace *get_current_ns(void)
 {
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
@@ -308,6 +315,12 @@ static inline struct ima_namespace *get_current_ns(void)
 {
 	return &init_ima_ns;
 }
+
+static inline int ima_securityfs_init(struct user_namespace *ns, struct dentry *root)
+{
+	return 0;
+}
+
 #endif /* CONFIG_IMA_NS */
 
 #if defined(CONFIG_IMA_APPRAISE) && defined(CONFIG_INTEGRITY_TRUSTED_KEYRING)
diff --git a/security/inode.c b/security/inode.c
index c77ae8ecc464..c9327389ad80 100644
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
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 84b3bf2f1454..f1c3cde25c80 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -479,6 +479,7 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 #if !defined(CONFIG_IMA_WRITE_POLICY) && !defined(CONFIG_IMA_READ_POLICY)
 	securityfs_remove(ns->policy_dentry);
 	ns->policy_dentry = NULL;
+	ns->policy_dentry_removed = true;
 #elif defined(CONFIG_IMA_WRITE_POLICY)
 	clear_bit(IMA_FS_BUSY, &ns->ima_fs_flags);
 #elif defined(CONFIG_IMA_READ_POLICY)
@@ -495,21 +496,31 @@ static const struct file_operations ima_measure_policy_ops = {
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
@@ -541,11 +552,15 @@ static int __init ima_fs_ns_init(struct user_namespace *user_ns)
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
@@ -556,10 +571,13 @@ static int __init ima_fs_ns_init(struct user_namespace *user_ns)
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

