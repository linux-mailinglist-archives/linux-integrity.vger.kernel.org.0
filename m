Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61755466FE1
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Dec 2021 03:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378105AbhLCCf3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Dec 2021 21:35:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44962 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1378157AbhLCCfT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Dec 2021 21:35:19 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B31nBX5025973;
        Fri, 3 Dec 2021 02:31:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=AED+qUOO25rCa3VmYDO2+99VYEWrUFcfb+DFXKbNz6w=;
 b=jKXFsgHOig/EQ+mCwlLmQze2OS0eMzUcvtxn1zP8rBwClmjRQmfcCLsdfu+xn8fVTb1g
 yif2Oat5I8KXYEWRErWvqhmmFstWFy5bDjg7w536s075ejOieUITqpdmwQHyu4iOqXm1
 EbWVXgKCdweXZK4kBIxEmPiz1ahEGJx17yqzSY8TeMz3PD0f2R+UpUdDU0A6OdXw1f16
 5b6dyKMnPHfYMMklxH68DJ3yEp41uDyPmNk/oS9DNBVqvzbmOGqEetFLdq1MkwIEblv2
 dcgCErmFY8j2NUWtNn1Gg3AgO/Yd77nb9n6TxGtS+YE2bcwXUhiA9zDvYqDX+LmMS3CE lA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cq9wb8kjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 02:31:47 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B32GUM5018081;
        Fri, 3 Dec 2021 02:31:46 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cq9wb8kj3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 02:31:46 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B32RYbs011937;
        Fri, 3 Dec 2021 02:31:44 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma05wdc.us.ibm.com with ESMTP id 3ckcacugyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 02:31:44 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B32VhlW46072140
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Dec 2021 02:31:43 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 346126E086;
        Fri,  3 Dec 2021 02:31:43 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F2736E085;
        Fri,  3 Dec 2021 02:31:42 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri,  3 Dec 2021 02:31:42 +0000 (GMT)
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
Subject: [RFC v2 14/19] ima: Move some IMA policy and filesystem related variables into ima_namespace
Date:   Thu,  2 Dec 2021 21:31:13 -0500
Message-Id: <20211203023118.1447229-15-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211203023118.1447229-1-stefanb@linux.ibm.com>
References: <20211203023118.1447229-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 42g6qqQJWEjYDp5IbZeg8qUIXK8_KvVW
X-Proofpoint-GUID: S8_c-qFvZR1MXpl-mqyz7NQJtcD4xWFU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-02_16,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112030012
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Move the ima_write_mutex, ima_fs_flag, and valid_policy variables into
ima_namespace. This way each IMA namespace can set those variables
independently.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/linux/ima.h                      |  5 ++++
 security/integrity/ima/ima_fs.c          | 35 +++++++++++-------------
 security/integrity/ima/ima_init_ima_ns.c |  4 +++
 3 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index 53f944469de7..889e9c70cbfb 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -261,6 +261,11 @@ struct ima_namespace {
 	struct ima_h_table ima_htable;
 	struct list_head ima_measurements;
 	unsigned long binary_runtime_size;
+
+	/* IMA's filesystem */
+	struct mutex ima_write_mutex;
+	unsigned long ima_fs_flags;
+	int valid_policy;
 };
 
 extern struct ima_namespace init_ima_ns;
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index c35e15fb313f..6c86f81c9998 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -25,8 +25,6 @@
 
 #include "ima.h"
 
-static DEFINE_MUTEX(ima_write_mutex);
-
 bool ima_canonical_fmt;
 static int __init default_canonical_fmt_setup(char *str)
 {
@@ -37,8 +35,6 @@ static int __init default_canonical_fmt_setup(char *str)
 }
 __setup("ima_canonical_fmt", default_canonical_fmt_setup);
 
-static int valid_policy = 1;
-
 static ssize_t ima_show_htable_value(char __user *buf, size_t count,
 				     loff_t *ppos, atomic_long_t *val)
 {
@@ -320,6 +316,7 @@ static ssize_t ima_read_policy(char *path)
 static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 				size_t datalen, loff_t *ppos)
 {
+	struct ima_namespace *ns = get_current_ns();
 	char *data;
 	ssize_t result;
 
@@ -337,7 +334,7 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 		goto out;
 	}
 
-	result = mutex_lock_interruptible(&ima_write_mutex);
+	result = mutex_lock_interruptible(&ns->ima_write_mutex);
 	if (result < 0)
 		goto out_free;
 
@@ -350,14 +347,14 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 				    1, 0);
 		result = -EACCES;
 	} else {
-		result = ima_parse_add_rule(get_current_ns(), data);
+		result = ima_parse_add_rule(ns, data);
 	}
-	mutex_unlock(&ima_write_mutex);
+	mutex_unlock(&ns->ima_write_mutex);
 out_free:
 	kfree(data);
 out:
 	if (result < 0)
-		valid_policy = 0;
+		ns->valid_policy = 0;
 
 	return result;
 }
@@ -374,8 +371,6 @@ enum ima_fs_flags {
 	IMA_FS_BUSY,
 };
 
-static unsigned long ima_fs_flags;
-
 #ifdef	CONFIG_IMA_READ_POLICY
 static const struct seq_operations ima_policy_seqops = {
 		.start = ima_policy_start,
@@ -390,6 +385,8 @@ static const struct seq_operations ima_policy_seqops = {
  */
 static int ima_open_policy(struct inode *inode, struct file *filp)
 {
+	struct ima_namespace *ns = get_current_ns();
+
 	if (!(filp->f_flags & O_WRONLY)) {
 #ifndef	CONFIG_IMA_READ_POLICY
 		return -EACCES;
@@ -401,7 +398,7 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
 		return seq_open(filp, &ima_policy_seqops);
 #endif
 	}
-	if (test_and_set_bit(IMA_FS_BUSY, &ima_fs_flags))
+	if (test_and_set_bit(IMA_FS_BUSY, &ns->ima_fs_flags))
 		return -EBUSY;
 	return 0;
 }
@@ -415,25 +412,25 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
  */
 static int ima_release_policy(struct inode *inode, struct file *file)
 {
-	const char *cause = valid_policy ? "completed" : "failed";
 	struct ima_namespace *ns = get_current_ns();
+	const char *cause = ns->valid_policy ? "completed" : "failed";
 
 	if ((file->f_flags & O_ACCMODE) == O_RDONLY)
 		return seq_release(inode, file);
 
-	if (valid_policy && ima_check_policy(ns) < 0) {
+	if (ns->valid_policy && ima_check_policy(ns) < 0) {
 		cause = "failed";
-		valid_policy = 0;
+		ns->valid_policy = 0;
 	}
 
 	pr_info("policy update %s\n", cause);
 	integrity_audit_msg(AUDIT_INTEGRITY_STATUS, NULL, NULL,
-			    "policy_update", cause, !valid_policy, 0);
+			    "policy_update", cause, !ns->valid_policy, 0);
 
-	if (!valid_policy) {
+	if (!ns->valid_policy) {
 		ima_delete_rules(ns);
-		valid_policy = 1;
-		clear_bit(IMA_FS_BUSY, &ima_fs_flags);
+		ns->valid_policy = 1;
+		clear_bit(IMA_FS_BUSY, &ns->ima_fs_flags);
 		return 0;
 	}
 
@@ -442,7 +439,7 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 	securityfs_remove(ima_policy);
 	ima_policy = NULL;
 #elif defined(CONFIG_IMA_WRITE_POLICY)
-	clear_bit(IMA_FS_BUSY, &ima_fs_flags);
+	clear_bit(IMA_FS_BUSY, &ns->ima_fs_flags);
 #elif defined(CONFIG_IMA_READ_POLICY)
 	inode->i_mode &= ~S_IWUSR;
 #endif
diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
index 57e46a10c001..22ff74e85a5f 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -49,6 +49,10 @@ int ima_init_namespace(struct ima_namespace *ns)
 	else
 		ns->binary_runtime_size = ULONG_MAX;
 
+	mutex_init(&ns->ima_write_mutex);
+	ns->valid_policy = 1;
+	ns->ima_fs_flags = 0;
+
 	return 0;
 }
 
-- 
2.31.1

