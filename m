Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1BB5BA16F
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Sep 2022 21:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiIOTdy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 15 Sep 2022 15:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiIOTdU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 15 Sep 2022 15:33:20 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118649D8C0;
        Thu, 15 Sep 2022 12:33:13 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28FI29T8024602;
        Thu, 15 Sep 2022 19:32:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=4QXIrWbNHABFqoS2P328C5JXbkYch6GxSkC6WBPPHVg=;
 b=Fs+RMVjgJeAWkcBZaH9gq2no9kLOtpvc5ndyLT1in5brJfa5uyy8yl6X2AZItCmxS255
 uCL72egR4mJoKXIBe+HM0HsiyhVtS0A+QPtzyu1OKFm8AY9ZEE9QxKTEnQxjCWidEd5C
 9ohJE0ZKYdQm0IO35ai+nFvvEMXVtGv2F9kGlyLynHChjfQdMqM5TRyzRzoGRXNAlTx5
 +L58z8Ub1yb7KZ1O7w/ENLDfig2eKo/8ctSVDvlzjonm8ozTo+uaF/p6kn47Gg1QH52R
 v2EDReBgS3Pg428m0C6dh6APMRGYJWwITYSUWXIdu8+oX+tDLqyo0si8tvbkoKmV39dx LQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jm8yn2nxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 19:32:39 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28FJB2tm002948;
        Thu, 15 Sep 2022 19:32:38 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jm8yn2nwb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 19:32:38 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28FJKKZr010413;
        Thu, 15 Sep 2022 19:32:36 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03wdc.us.ibm.com with ESMTP id 3jm91w0d12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Sep 2022 19:32:36 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28FJWaKt4653618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Sep 2022 19:32:36 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B307AE05C;
        Thu, 15 Sep 2022 19:32:36 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F22D1AE062;
        Thu, 15 Sep 2022 19:32:35 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Thu, 15 Sep 2022 19:32:35 +0000 (GMT)
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
        jpenumak@redhat.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v14 07/26] ima: Move some IMA policy and filesystem related variables into ima_namespace
Date:   Thu, 15 Sep 2022 15:32:02 -0400
Message-Id: <20220915193221.1728029-8-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220915193221.1728029-1-stefanb@linux.ibm.com>
References: <20220915193221.1728029-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: spTaz59eRKEjaXqybDVM9hbyZDdVWlLk
X-Proofpoint-GUID: 6ipx_BAByGZVm4AEuKyAEG0GPsRuspv_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_10,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209150119
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Move the variables ima_write_mutex, ima_fs_flag, and valid_policy, which
are related to updating the IMA policy, into the ima_namespace. This way
each IMA namespace can set these variables independently in its instance
of securityfs.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Acked-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Acked-by: Serge Hallyn <serge@hallyn.com>
---
 security/integrity/ima/ima.h             |  5 ++++
 security/integrity/ima/ima_fs.c          | 32 +++++++++++-------------
 security/integrity/ima/ima_init_ima_ns.c |  4 +++
 3 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 82e8af2bf698..a144edfdb9a1 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -137,6 +137,11 @@ struct ima_namespace {
 	struct ima_h_table ima_htable;
 	struct list_head ima_measurements;	/* list of all measurements */
 	unsigned long binary_runtime_size;	/* used by init_ima_ns */
+
+	/* securityfs support related variables */
+	struct mutex ima_write_mutex;
+	unsigned long ima_fs_flags;
+	int valid_policy;
 } __randomize_layout;
 extern struct ima_namespace init_ima_ns;
 
diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 5ef0e2b2cf64..4cf786f0bba8 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -24,8 +24,6 @@
 
 #include "ima.h"
 
-static DEFINE_MUTEX(ima_write_mutex);
-
 bool ima_canonical_fmt;
 static int __init default_canonical_fmt_setup(char *str)
 {
@@ -36,8 +34,6 @@ static int __init default_canonical_fmt_setup(char *str)
 }
 __setup("ima_canonical_fmt", default_canonical_fmt_setup);
 
-static int valid_policy = 1;
-
 static ssize_t ima_show_htable_value(char __user *buf, size_t count,
 				     loff_t *ppos, atomic_long_t *val)
 {
@@ -338,7 +334,7 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 		goto out;
 	}
 
-	result = mutex_lock_interruptible(&ima_write_mutex);
+	result = mutex_lock_interruptible(&ns->ima_write_mutex);
 	if (result < 0)
 		goto out_free;
 
@@ -353,12 +349,12 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 	} else {
 		result = ima_parse_add_rule(ns, data);
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
@@ -375,8 +371,6 @@ enum ima_fs_flags {
 	IMA_FS_BUSY,
 };
 
-static unsigned long ima_fs_flags;
-
 #ifdef	CONFIG_IMA_READ_POLICY
 static const struct seq_operations ima_policy_seqops = {
 		.start = ima_policy_start,
@@ -391,6 +385,8 @@ static const struct seq_operations ima_policy_seqops = {
  */
 static int ima_open_policy(struct inode *inode, struct file *filp)
 {
+	struct ima_namespace *ns = &init_ima_ns;
+
 	if (!(filp->f_flags & O_WRONLY)) {
 #ifndef	CONFIG_IMA_READ_POLICY
 		return -EACCES;
@@ -402,7 +398,7 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
 		return seq_open(filp, &ima_policy_seqops);
 #endif
 	}
-	if (test_and_set_bit(IMA_FS_BUSY, &ima_fs_flags))
+	if (test_and_set_bit(IMA_FS_BUSY, &ns->ima_fs_flags))
 		return -EBUSY;
 	return 0;
 }
@@ -416,25 +412,25 @@ static int ima_open_policy(struct inode *inode, struct file *filp)
  */
 static int ima_release_policy(struct inode *inode, struct file *file)
 {
-	const char *cause = valid_policy ? "completed" : "failed";
 	struct ima_namespace *ns = &init_ima_ns;
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
 
@@ -443,7 +439,7 @@ static int ima_release_policy(struct inode *inode, struct file *file)
 	securityfs_remove(ima_policy);
 	ima_policy = NULL;
 #elif defined(CONFIG_IMA_WRITE_POLICY)
-	clear_bit(IMA_FS_BUSY, &ima_fs_flags);
+	clear_bit(IMA_FS_BUSY, &ns->ima_fs_flags);
 #elif defined(CONFIG_IMA_READ_POLICY)
 	inode->i_mode &= ~S_IWUSR;
 #endif
diff --git a/security/integrity/ima/ima_init_ima_ns.c b/security/integrity/ima/ima_init_ima_ns.c
index a7477072c587..425eed1c6838 100644
--- a/security/integrity/ima/ima_init_ima_ns.c
+++ b/security/integrity/ima/ima_init_ima_ns.c
@@ -26,6 +26,10 @@ static int ima_init_namespace(struct ima_namespace *ns)
 	else
 		ns->binary_runtime_size = ULONG_MAX;
 
+	mutex_init(&ns->ima_write_mutex);
+	ns->valid_policy = 1;
+	ns->ima_fs_flags = 0;
+
 	return 0;
 }
 
-- 
2.36.1

