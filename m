Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6805D470AC1
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Dec 2021 20:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343781AbhLJTvk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Dec 2021 14:51:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20286 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1343723AbhLJTva (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Dec 2021 14:51:30 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BAJT7qd007275;
        Fri, 10 Dec 2021 19:47:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=u6PgdV+NKwF7N9A69Elc9vH38PnC24ZEh2+pcZ+phZg=;
 b=XER5yorF6KXEDUfRLW6Lfvw9On266NJ/MXoxaj/37ESub3vTioFJcZ41/aQsz9mH33K9
 B/KuNgMW0GAt/8AE22cK/uVojBXK2FRO/prZkrbhx8HgidbaYGjMJ8CjKOvEF8M/82Tu
 FtIiRUOzra46jB8Rl1kZ6OkJHHYf1kWbzFtezSLpvzOeueV14tFeWuZ0uvYHBSalahKl
 +fAMNnm9HcUNC9sC3clVvaHHISn23eEcdmbwuKk7y0sHkd4XExZrB8nfMP0YvC++gVyA
 rplGasBnNPghqK1x8K3UWMrhN9V1YMHqCstk9jBtGjqwta9z6RWLj0kv2oKdk0/P5J4V Nw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cvd370a17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 19:47:42 +0000
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1BAJgB41029194;
        Fri, 10 Dec 2021 19:47:41 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cvd370a0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 19:47:41 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1BAJlHLd029464;
        Fri, 10 Dec 2021 19:47:41 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma02dal.us.ibm.com with ESMTP id 3cqyydm09u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 19:47:41 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1BAJleL012976630
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Dec 2021 19:47:40 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3FA2AE060;
        Fri, 10 Dec 2021 19:47:39 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C706FAE064;
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
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v6 16/17] ima: Move dentry into ima_namespace and others onto stack
Date:   Fri, 10 Dec 2021 14:47:35 -0500
Message-Id: <20211210194736.1538863-17-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211210194736.1538863-1-stefanb@linux.ibm.com>
References: <20211210194736.1538863-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pualFYN857t0R6rlgU8boLoVTR670g6C
X-Proofpoint-GUID: 2SRy88NSXkwGdBZCikDEj2S3f9mbeIzs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-10_07,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 clxscore=1015 mlxscore=0 malwarescore=0 spamscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112100106
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Move the policy file dentry into the ima_namespace for reuse by
virtualized SecurityFS and for being able to remove it from
the filesystem. Move the other dentries onto the stack.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/linux/ima.h             |  2 ++
 security/integrity/ima/ima_fs.c | 33 +++++++++++++++++++--------------
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index ca300306a715..cc950ccbf157 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -273,6 +273,8 @@ struct ima_namespace {
 	struct mutex ima_write_mutex;
 	unsigned long ima_fs_flags;
 	int valid_policy;
+
+	struct dentry *policy_dentry;
 };
 
 extern struct ima_namespace init_ima_ns;
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 090ee85bfa3a..84b3bf2f1454 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -405,14 +405,6 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
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
@@ -485,8 +477,8 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 
 	ima_update_policy(ns);
 #if !defined(CONFIG_IMA_WRITE_POLICY) && !defined(CONFIG_IMA_READ_POLICY)
-	securityfs_remove(ima_policy);
-	ima_policy = NULL;
+	securityfs_remove(ns->policy_dentry);
+	ns->policy_dentry = NULL;
 #elif defined(CONFIG_IMA_WRITE_POLICY)
 	clear_bit(IMA_FS_BUSY, &ns->ima_fs_flags);
 #elif defined(CONFIG_IMA_READ_POLICY)
@@ -503,8 +495,16 @@ static const struct file_operations ima_measure_policy_ops = {
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
@@ -541,20 +541,25 @@ int __init ima_fs_init(void)
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

