Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D7B508A11
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Apr 2022 16:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379393AbiDTOKT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 Apr 2022 10:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379356AbiDTOKL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Apr 2022 10:10:11 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818D2443C2;
        Wed, 20 Apr 2022 07:07:15 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23KCw3Z0009679;
        Wed, 20 Apr 2022 14:06:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=0aaHikcX69ppYw+khij2a0+H9P9GpuMwRxEjjyrSAgg=;
 b=bLeqgKDAV9eZ2597A7YHxmSy+abD0hp5pCI72t+C062Ail2mhIQGmCMxIpHRlRkSjGs9
 lsygwXEDgIczIODX5bm5VOznI9WNfys647lAQrabmqHgrLvmIPJdtGDIZGIVQmGEOx9I
 lz0YGG8oJe4h7THC2hH3W1Hva+2KvUlbhDcB6Pm0PrPplvLgf6aGw6AAdxMql+gknFie
 rnthQxG0mVrb+/Iy3GUziMpCiBf6hMj6UgbRZdrrgpt0NHNLJMetmoxt66nqccEInfLm
 A5E9nQxTaL9p8t0eWsY9UC2NHF08YEMadlUzkHI0lqHMlmvBzBVAJmDjciSR39AYHYuC 7A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fhxh8bnn5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 14:06:45 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 23KDlU3M017207;
        Wed, 20 Apr 2022 14:06:44 GMT
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fhxh8bnmc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 14:06:44 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23KE2uGZ012738;
        Wed, 20 Apr 2022 14:06:42 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma04wdc.us.ibm.com with ESMTP id 3ffneactw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 14:06:42 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23KE6fxu38273484
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 14:06:42 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D28B3AE05F;
        Wed, 20 Apr 2022 14:06:41 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2C30AE062;
        Wed, 20 Apr 2022 14:06:41 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 20 Apr 2022 14:06:41 +0000 (GMT)
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
        jpenumak@redhat.com, Stefan Berger <stefanb@linux.ibm.com>,
        Christian Brauner <brauner@kernel.org>
Subject: [PATCH v12 07/26] ima: Move some IMA policy and filesystem related variables into ima_namespace
Date:   Wed, 20 Apr 2022 10:06:14 -0400
Message-Id: <20220420140633.753772-8-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420140633.753772-1-stefanb@linux.ibm.com>
References: <20220420140633.753772-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2joupSDg_qWwI-RiX3Dnb7BWjSYItfry
X-Proofpoint-GUID: mRgaahSKo4gzUbGXib9SiRsYv_4hY7Ap
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_03,2022-04-20_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 impostorscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204200081
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
2.34.1

