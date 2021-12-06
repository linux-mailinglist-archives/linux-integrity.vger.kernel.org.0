Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6498A46A2B9
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Dec 2021 18:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240450AbhLFR34 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Dec 2021 12:29:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34314 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239514AbhLFR3y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Dec 2021 12:29:54 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B6GqjMJ037123;
        Mon, 6 Dec 2021 17:26:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ZL6rEnSJMSfdiEAOdyhScdnx9YYqcfOOOWHDuINFg1Y=;
 b=pJmoTzL07worZyCiii/TsOyT6Yf+uUoiqgBnLSb6VSLR+L92AHU1yeRttvfrVMEAospW
 uLJ4nXG2a0BypdoAh9InWDldKjhu7JH3pPY/jzgXETmbDHBHCdiyXTYChDs8vHD0ZnAN
 QnjLlPpNcfUQpTeA5Q++Rj8dUAKng3JcYfi/Fc319ruI0CldT5FpyoJsO5PjaOE9EX5F
 mS8XWwJG5//hol1VwUQWyZvTtv+KObr3YxtroSPixy5j1uSyvFv2SuqARp8/KipSR576
 zkKqXXw6bjOKQOG0s9mSQHXbq4lTtgXzpgJY4MfgUfMDS/9XEWCXuGESWnufPs6+2CyY gg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cspe38mqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 17:26:12 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B6Gsf2Q005913;
        Mon, 6 Dec 2021 17:26:11 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cspe38mpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 17:26:11 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B6HECv3028335;
        Mon, 6 Dec 2021 17:26:10 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma01wdc.us.ibm.com with ESMTP id 3cqyy9tcfb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 17:26:10 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B6HQ9vD42729754
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Dec 2021 17:26:09 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4526628058;
        Mon,  6 Dec 2021 17:26:09 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2E9A62806F;
        Mon,  6 Dec 2021 17:26:09 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  6 Dec 2021 17:26:09 +0000 (GMT)
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
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 15/16] ima: Move dentries into ima_namespace
Date:   Mon,  6 Dec 2021 12:25:59 -0500
Message-Id: <20211206172600.1495968-16-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211206172600.1495968-1-stefanb@linux.ibm.com>
References: <20211206172600.1495968-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _NOCpz-9y1Q3VnAECIt8_p6uewPAFYiV
X-Proofpoint-GUID: zfW4qNSwQk8p1-qjz4RbIlwARJCUmwUb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-06_06,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112060104
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Move the dentries into the ima_namespace for reuse by virtualized
SecurityFS. Implement function freeing the dentries in order of
files and symlinks before directories.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/linux/ima.h             | 13 ++++++
 security/integrity/ima/ima_fs.c | 72 ++++++++++++++++++---------------
 2 files changed, 52 insertions(+), 33 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 889e9c70cbfb..bfb978a7f8d5 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -220,6 +220,17 @@ struct ima_h_table {
 	struct hlist_head queue[IMA_MEASURE_HTABLE_SIZE];
 };
 
+enum {
+	IMAFS_DENTRY_DIR = 0,
+	IMAFS_DENTRY_SYMLINK,
+	IMAFS_DENTRY_BINARY_RUNTIME_MEASUREMENTS,
+	IMAFS_DENTRY_ASCII_RUNTIME_MEASUREMENTS,
+	IMAFS_DENTRY_RUNTIME_MEASUREMENTS_COUNT,
+	IMAFS_DENTRY_VIOLATIONS,
+	IMAFS_DENTRY_IMA_POLICY,
+	IMAFS_DENTRY_LAST
+};
+
 struct ima_namespace {
 	struct kref kref;
 	struct user_namespace *user_ns;
@@ -266,6 +277,8 @@ struct ima_namespace {
 	struct mutex ima_write_mutex;
 	unsigned long ima_fs_flags;
 	int valid_policy;
+
+	struct dentry *dentry[IMAFS_DENTRY_LAST];
 };
 
 extern struct ima_namespace init_ima_ns;
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 68f2e58c3917..c2a886c00ac2 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -359,14 +359,6 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 	return result;
 }
 
-static struct dentry *ima_dir;
-static struct dentry *ima_symlink;
-static struct dentry *binary_runtime_measurements;
-static struct dentry *ascii_runtime_measurements;
-static struct dentry *runtime_measurements_count;
-static struct dentry *violations;
-static struct dentry *ima_policy;
-
 enum ima_fs_flags {
 	IMA_FS_BUSY,
 };
@@ -436,8 +428,8 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 
 	ima_update_policy(ns);
 #if !defined(CONFIG_IMA_WRITE_POLICY) && !defined(CONFIG_IMA_READ_POLICY)
-	securityfs_remove(ima_policy);
-	ima_policy = NULL;
+	securityfs_remove(ns->dentry[IMAFS_DENTRY_IMA_POLICY]);
+	ns->dentry[IMAFS_DENTRY_IMA_POLICY] = NULL;
 #elif defined(CONFIG_IMA_WRITE_POLICY)
 	clear_bit(IMA_FS_BUSY, &ns->ima_fs_flags);
 #elif defined(CONFIG_IMA_READ_POLICY)
@@ -454,58 +446,72 @@ static const struct file_operations ima_measure_policy_ops = {
 	.llseek = generic_file_llseek,
 };
 
-int __init ima_fs_init(void)
+static void ima_fs_ns_free_dentries(struct ima_namespace *ns)
 {
-	ima_dir = securityfs_create_dir("ima", integrity_dir);
-	if (IS_ERR(ima_dir))
+	int i;
+
+	for (i = IMAFS_DENTRY_LAST - 1; i >= 0; i--)
+		securityfs_remove(ns->dentry[i]);
+
+	memset(ns->dentry, 0, sizeof(ns->dentry));
+}
+
+static int __init ima_fs_ns_init(struct user_namespace *user_ns)
+{
+	struct ima_namespace *ns = user_ns->ima_ns;
+	struct dentry *ima_dir;
+
+	ns->dentry[IMAFS_DENTRY_DIR] = securityfs_create_dir("ima", integrity_dir);
+	if (IS_ERR(ns->dentry[IMAFS_DENTRY_DIR]))
 		return -1;
+	ima_dir = ns->dentry[IMAFS_DENTRY_DIR];
 
-	ima_symlink = securityfs_create_symlink("ima", NULL, "integrity/ima",
-						NULL);
-	if (IS_ERR(ima_symlink))
+	ns->dentry[IMAFS_DENTRY_SYMLINK] =
+	    securityfs_create_symlink("ima", NULL, "integrity/ima", NULL);
+	if (IS_ERR(ns->dentry[IMAFS_DENTRY_SYMLINK]))
 		goto out;
 
-	binary_runtime_measurements =
+	ns->dentry[IMAFS_DENTRY_BINARY_RUNTIME_MEASUREMENTS] =
 	    securityfs_create_file("binary_runtime_measurements",
 				   S_IRUSR | S_IRGRP, ima_dir, NULL,
 				   &ima_measurements_ops);
-	if (IS_ERR(binary_runtime_measurements))
+	if (IS_ERR(ns->dentry[IMAFS_DENTRY_BINARY_RUNTIME_MEASUREMENTS]))
 		goto out;
 
-	ascii_runtime_measurements =
+	ns->dentry[IMAFS_DENTRY_ASCII_RUNTIME_MEASUREMENTS] =
 	    securityfs_create_file("ascii_runtime_measurements",
 				   S_IRUSR | S_IRGRP, ima_dir, NULL,
 				   &ima_ascii_measurements_ops);
-	if (IS_ERR(ascii_runtime_measurements))
+	if (IS_ERR(ns->dentry[IMAFS_DENTRY_ASCII_RUNTIME_MEASUREMENTS]))
 		goto out;
 
-	runtime_measurements_count =
+	ns->dentry[IMAFS_DENTRY_RUNTIME_MEASUREMENTS_COUNT] =
 	    securityfs_create_file("runtime_measurements_count",
 				   S_IRUSR | S_IRGRP, ima_dir, NULL,
 				   &ima_measurements_count_ops);
-	if (IS_ERR(runtime_measurements_count))
+	if (IS_ERR(ns->dentry[IMAFS_DENTRY_RUNTIME_MEASUREMENTS_COUNT]))
 		goto out;
 
-	violations =
+	ns->dentry[IMAFS_DENTRY_VIOLATIONS] =
 	    securityfs_create_file("violations", S_IRUSR | S_IRGRP,
 				   ima_dir, NULL, &ima_htable_violations_ops);
-	if (IS_ERR(violations))
+	if (IS_ERR(ns->dentry[IMAFS_DENTRY_VIOLATIONS]))
 		goto out;
 
-	ima_policy = securityfs_create_file("policy", POLICY_FILE_FLAGS,
+	ns->dentry[IMAFS_DENTRY_IMA_POLICY] =
+	    securityfs_create_file("policy", POLICY_FILE_FLAGS,
 					    ima_dir, NULL,
 					    &ima_measure_policy_ops);
-	if (IS_ERR(ima_policy))
+	if (IS_ERR(ns->dentry[IMAFS_DENTRY_IMA_POLICY]))
 		goto out;
 
 	return 0;
 out:
-	securityfs_remove(violations);
-	securityfs_remove(runtime_measurements_count);
-	securityfs_remove(ascii_runtime_measurements);
-	securityfs_remove(binary_runtime_measurements);
-	securityfs_remove(ima_symlink);
-	securityfs_remove(ima_dir);
-	securityfs_remove(ima_policy);
+	ima_fs_ns_free_dentries(ns);
 	return -1;
 }
+
+int __init ima_fs_init(void)
+{
+	return ima_fs_ns_init(&init_user_ns);
+}
-- 
2.31.1

