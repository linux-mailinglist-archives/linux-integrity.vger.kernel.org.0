Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF94F4769BE
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Dec 2021 06:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbhLPFoB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Dec 2021 00:44:01 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28182 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233787AbhLPFn6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Dec 2021 00:43:58 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BG4UwV9031157;
        Thu, 16 Dec 2021 05:43:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=nxJtknNeyKIwcN3IydUK+ugfg9tts3rhuAX/3zm37/c=;
 b=Kqlyej3EcRhGqKkVdTOtI+0+UEDUAMR8M0QyGA8fR1RrsVs241ZOzA627LwRsgYDyAx/
 wBx5UAprTwP6XCcn4CLGwN0pZxk+dhMtKb2tUOcxnNx2bWYoB2oElGnELYHLjvFscCwK
 Ocmr70GIPttOYxHfjvRzCdSkECL24xke7REsqNWDjnSF6tSZARl10zsrd8aOdkFJRoZo
 M+bYAHybqTahPjA+itKLkl7uzOgWA3CfsxMlL2z/Dq87V6gD/1a2MEvaFtLDJwgcwnUA
 SWQVyMIjSxryMzyfbLXFsKUVJk7zCwB6NKMek+NkjGdFB99c+fJ/Hp3H0/9gn2pKuWaG VA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cyr21yw8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 05:43:45 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BG5UnPh011884;
        Thu, 16 Dec 2021 05:43:44 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cyr21yw8e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 05:43:44 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BG5fxuY019886;
        Thu, 16 Dec 2021 05:43:43 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma04wdc.us.ibm.com with ESMTP id 3cy76wbag4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Dec 2021 05:43:43 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BG5hgUR13500968
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 05:43:42 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8AF986E050;
        Thu, 16 Dec 2021 05:43:42 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 70AC96E05D;
        Thu, 16 Dec 2021 05:43:41 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 16 Dec 2021 05:43:41 +0000 (GMT)
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
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v7 13/14] ima: Move dentry into ima_namespace and others onto stack
Date:   Thu, 16 Dec 2021 00:43:22 -0500
Message-Id: <20211216054323.1707384-14-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216054323.1707384-1-stefanb@linux.vnet.ibm.com>
References: <20211216054323.1707384-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: E0YsGeq274IcuOL8026OvRpzICNDj97u
X-Proofpoint-ORIG-GUID: v7TRZ33HUffCYs90TmEVJEJqQYgXnE1V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-16_01,2021-12-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxscore=0 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160033
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

Move the policy file dentry into the ima_namespace for reuse by
virtualized SecurityFS and for being able to remove it from
the filesystem. Move the other dentries onto the stack.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/ima/ima.h    |  2 ++
 security/integrity/ima/ima_fs.c | 33 +++++++++++++++++++--------------
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index cb6c92a67ff9..d51703290e25 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -146,6 +146,8 @@ struct ima_namespace {
 	struct mutex ima_write_mutex;
 	unsigned long ima_fs_flags;
 	int valid_policy;
+
+	struct dentry *policy_dentry;
 } __randomize_layout;
 
 extern const int read_idmap[];
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 611c4271d474..7c5a721f4f3d 100644
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
@@ -437,8 +429,8 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 
 	ima_update_policy(ns);
 #if !defined(CONFIG_IMA_WRITE_POLICY) && !defined(CONFIG_IMA_READ_POLICY)
-	securityfs_remove(ima_policy);
-	ima_policy = NULL;
+	securityfs_remove(ns->policy_dentry);
+	ns->policy_dentry = NULL;
 #elif defined(CONFIG_IMA_WRITE_POLICY)
 	clear_bit(IMA_FS_BUSY, &ns->ima_fs_flags);
 #elif defined(CONFIG_IMA_READ_POLICY)
@@ -455,8 +447,16 @@ static const struct file_operations ima_measure_policy_ops = {
 	.llseek = generic_file_llseek,
 };
 
-int __init ima_fs_init(void)
+static int __init ima_fs_ns_init(struct user_namespace *user_ns)
 {
+	struct ima_namespace *ns = user_ns->ima_ns;
+	struct dentry *ima_dir;
+	struct dentry *ima_symlink = NULL;
+	struct dentry *binary_runtime_measurements = NULL;
+	struct dentry *ascii_runtime_measurements = NULL;
+	struct dentry *runtime_measurements_count = NULL;
+	struct dentry *violations = NULL;
+
 	ima_dir = securityfs_create_dir("ima", integrity_dir);
 	if (IS_ERR(ima_dir))
 		return -1;
@@ -493,20 +493,25 @@ int __init ima_fs_init(void)
 	if (IS_ERR(violations))
 		goto out;
 
-	ima_policy = securityfs_create_file("policy", POLICY_FILE_FLAGS,
+	ns->policy_dentry = securityfs_create_file("policy", POLICY_FILE_FLAGS,
 					    ima_dir, NULL,
 					    &ima_measure_policy_ops);
-	if (IS_ERR(ima_policy))
+	if (IS_ERR(ns->policy_dentry))
 		goto out;
 
 	return 0;
 out:
+	securityfs_remove(ns->policy_dentry);
 	securityfs_remove(violations);
 	securityfs_remove(runtime_measurements_count);
 	securityfs_remove(ascii_runtime_measurements);
 	securityfs_remove(binary_runtime_measurements);
 	securityfs_remove(ima_symlink);
 	securityfs_remove(ima_dir);
-	securityfs_remove(ima_policy);
 	return -1;
 }
+
+int __init ima_fs_init(void)
+{
+	return ima_fs_ns_init(&init_user_ns);
+}
-- 
2.31.1

