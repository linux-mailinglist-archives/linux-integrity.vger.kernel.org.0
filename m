Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D515BA153
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Sep 2022 21:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiIOTdm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Sep 2022 15:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiIOTdS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Sep 2022 15:33:18 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D059D65E;
        Thu, 15 Sep 2022 12:33:11 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28FIX6Zq013032;
        Thu, 15 Sep 2022 19:32:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=WtcGb8DapwCKtpzJ1AR3Kt173r8IwoWCcdwDAmHB8DY=;
 b=e6696AW583c8Vkrc/HzCUMUzT+ZxjmqzAI6iwdjSeBOeb8gFDzzwhkBPJ0fOAtWNXARf
 TVOFxqmbNlVzdHzHpyIEiVZEE4VZBvK2lAUgBLJrr+hpkVxOAw8QqYlv5tweFCDeRQeR
 4KN5ax0oAXG7YfNOvmm32B+4P7StJb451NKClmk5YMR2+C63IH86Hb/o2qTjQhFonjSq
 L0hGVbaBCjM0Pu/B0vpg/Mt24MQ3hQBORj8DWZiJtYx59Lyn2DveZsZuxEdMGtuKOEJz
 z8SNFPQ1E59AU8tsCsLK5ubQY+JDzJxKpWBZbZP5xywU/ry9gLQQDvvwv8HqVfO5Rnpy cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jm9e81s3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 19:32:40 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28FJLkR9005887;
        Thu, 15 Sep 2022 19:32:39 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jm9e81s34-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 19:32:39 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28FJLBqo027065;
        Thu, 15 Sep 2022 19:32:39 GMT
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
        by ppma02wdc.us.ibm.com with ESMTP id 3jm91cgdbr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 19:32:39 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28FJWc5H9437838
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 19:32:38 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D44EAE05C;
        Thu, 15 Sep 2022 19:32:38 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F61EAE062;
        Thu, 15 Sep 2022 19:32:38 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 15 Sep 2022 19:32:38 +0000 (GMT)
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
        jpenumak@redhat.com, Stefan Berger <stefanb@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Subject: [PATCH v14 21/26] ima: Setup securityfs for IMA namespace
Date:   Thu, 15 Sep 2022 15:32:16 -0400
Message-Id: <20220915193221.1728029-22-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220915193221.1728029-1-stefanb@linux.ibm.com>
References: <20220915193221.1728029-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uSFCGS1p42btzdQMSTqXjAnem67jvwXS
X-Proofpoint-ORIG-GUID: 84yrYR6UJ0qxWQdkjeoIrJ7yR7xy3_yQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_10,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209150116
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Acked-by: Serge Hallyn <serge@hallyn.com>

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
index 024908ad4eaa..b5bcf7845e01 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -41,6 +41,7 @@ extern int ima_measure_critical_data(const char *event_label,
 				     const char *event_name,
 				     const void *buf, size_t buf_len,
 				     bool hash, u8 *digest, size_t digest_len);
+extern int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root);
 
 #ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
 extern void ima_appraise_parse_cmdline(void);
@@ -232,6 +233,12 @@ void free_ima_ns(struct user_namespace *ns);
 
 void ima_free_ns_status_list(struct list_head *head, rwlock_t *ns_list_lock);
 
+static inline int ima_securityfs_init(struct user_namespace *user_ns,
+				      struct dentry *root)
+{
+	return ima_fs_ns_init(user_ns, root);
+}
+
 #else
 
 static inline void free_ima_ns(struct user_namespace *user_ns)
@@ -243,6 +250,12 @@ static inline void ima_free_ns_status_list(struct list_head *head,
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
index c7273fdbca4c..b473ee5cfb34 100644
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
@@ -83,7 +84,10 @@ static int securityfs_fill_super(struct super_block *sb, struct fs_context *fc)
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
index 0ac76e1a0fff..6592ae2a4300 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -152,6 +152,7 @@ struct ima_namespace {
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
2.36.1

