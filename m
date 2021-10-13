Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B20542BE89
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Oct 2021 13:02:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbhJMLEQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Oct 2021 07:04:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25438 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233422AbhJMLDy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Oct 2021 07:03:54 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19DAWjNY021851;
        Wed, 13 Oct 2021 07:01:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=pp1;
 bh=Px8pkOv21BYoBjV0MsiMZ5RdlpIGjMih1XX8iRmQ+n4=;
 b=dmq+KU4lWzoORY+icHikD573vDLKwHwp+Ei5VdCCYXYnfzl9o+ShFJqGp/xZDs5NZgx1
 lO0taxXD8oHOdySQZ/VuGtKhbd9/p1CrDoFVxoTbAIhz4vqIkZKmq6mZwdmrAkSkLYAi
 GuSBTFi6jhBq6sj2Dd5A5v4twi0jhOcUXcqLJ6gVtrziJG/CaCzIlMDyyoLeDS2wKd39
 1uUuDsFqbtHDenpM+lkl14BKvSmQ5ISq87Vd+fLSa5aSJnqw69xzPMay9HXzaa5TsSY3
 JIc81C6E/diex3HtC/lJfRJXnCmsYKN7Weh9VtgfrDZOxd4vGAU5Vdarr4aopDc3/SoH 8w== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bnr79fry8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 07:01:40 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 19DAxbEu001715;
        Wed, 13 Oct 2021 11:01:32 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3bk2qa7mj7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 11:01:32 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 19DB1Ptj52363708
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 11:01:25 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50FEEAE065;
        Wed, 13 Oct 2021 11:01:25 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71110AE055;
        Wed, 13 Oct 2021 11:01:20 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.27.171])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 13 Oct 2021 11:01:19 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 1/2] ima: define ima_trusted_for hook
Date:   Wed, 13 Oct 2021 07:01:12 -0400
Message-Id: <20211013110113.13239-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0Qa3CeZ6ycpWRLqrL4IA72DQIGVC8Lle
X-Proofpoint-ORIG-GUID: 0Qa3CeZ6ycpWRLqrL4IA72DQIGVC8Lle
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-13_04,2021-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=955 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110130071
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

A major interpreter integrity gap exists which allows files read by
the interpreter to be executed without measuring the file or verifying
the file's signature.

The kernel has no knowledge about the file being read by the interpreter.
Only the interpreter knows the context(eg. data, execute) and must be
trusted to provide that information accurately.

To close this integrity gap, define an ima_trusted_for hook to allow
IMA to measure the file and verify the file's signature based on policy.

Sample policy rules:
	measure func=TRUSTED_FOR_CHECK
	appraise func=TRUSTED_FOR_CHECK

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
Mickaël, here is the first LSM/integrity instantiation of the trusted_for
hook.

 Documentation/ABI/testing/ima_policy |  2 +-
 security/integrity/ima/ima.h         |  1 +
 security/integrity/ima/ima_main.c    | 23 +++++++++++++++++++++++
 security/integrity/ima/ima_policy.c  |  3 +++
 4 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index e1a04bd3b9e5..85618e726801 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -34,7 +34,7 @@ Description:
 				[FIRMWARE_CHECK]
 				[KEXEC_KERNEL_CHECK] [KEXEC_INITRAMFS_CHECK]
 				[KEXEC_CMDLINE] [KEY_CHECK] [CRITICAL_DATA]
-				[SETXATTR_CHECK]
+				[SETXATTR_CHECK] [TRUSTED_FOR_CHECK]
 			mask:= [[^]MAY_READ] [[^]MAY_WRITE] [[^]MAY_APPEND]
 			       [[^]MAY_EXEC]
 			fsmagic:= hex value
diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index be965a8715e4..827236dbbefb 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -202,6 +202,7 @@ static inline unsigned int ima_hash_key(u8 *digest)
 	hook(KEY_CHECK, key)				\
 	hook(CRITICAL_DATA, critical_data)		\
 	hook(SETXATTR_CHECK, setxattr_check)		\
+	hook(TRUSTED_FOR_CHECK, trusted_for_check)	\
 	hook(MAX_CHECK, none)
 
 #define __ima_hook_enumify(ENUM, str)	ENUM,
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 465865412100..e09054ac3352 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -26,6 +26,7 @@
 #include <linux/ima.h>
 #include <linux/iversion.h>
 #include <linux/fs.h>
+#include <uapi/linux/trusted-for.h>
 
 #include "ima.h"
 
@@ -519,6 +520,28 @@ int ima_file_check(struct file *file, int mask)
 }
 EXPORT_SYMBOL_GPL(ima_file_check);
 
+/**
+ * ima_trusted_for - based on policy, measure/appraise/audit measurement
+ * @file: pointer to the file to be measured/appraised/audit
+ * @usage: limit enumeration to TRUSTED_FOR_EXECUTION
+ *
+ * Measure/appraise/audit files being executed by an interpreter.
+ *
+ * On success return 0.  On integrity appraisal error, assuming the file
+ * is in policy and IMA-appraisal is in enforcing mode, return -EACCES.
+ */
+int ima_trusted_for(struct file *file, const enum trusted_for_usage usage)
+{
+	u32 secid;
+
+	if (usage != TRUSTED_FOR_EXECUTION)
+		return 0;
+
+	security_task_getsecid_subj(current, &secid);
+	return process_measurement(file, current_cred(), secid, NULL,
+				   0, MAY_EXEC, TRUSTED_FOR_CHECK);
+}
+
 static int __ima_inode_hash(struct inode *inode, char *buf, size_t buf_size)
 {
 	struct integrity_iint_cache *iint;
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 320ca80aacab..847803a24201 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1210,6 +1210,7 @@ static bool ima_validate_rule(struct ima_rule_entry *entry)
 	case POST_SETATTR:
 	case FIRMWARE_CHECK:
 	case POLICY_CHECK:
+	case TRUSTED_FOR_CHECK:
 		if (entry->flags & ~(IMA_FUNC | IMA_MASK | IMA_FSMAGIC |
 				     IMA_UID | IMA_FOWNER | IMA_FSUUID |
 				     IMA_INMASK | IMA_EUID | IMA_PCR |
@@ -1423,6 +1424,8 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 			/* PATH_CHECK is for backwards compat */
 			else if (strcmp(args[0].from, "PATH_CHECK") == 0)
 				entry->func = FILE_CHECK;
+			else if (strcmp(args[0].from, "TRUSTED_FOR_CHECK") == 0)
+				entry->func = TRUSTED_FOR_CHECK;
 			else if (strcmp(args[0].from, "MODULE_CHECK") == 0)
 				entry->func = MODULE_CHECK;
 			else if (strcmp(args[0].from, "FIRMWARE_CHECK") == 0)
-- 
2.27.0
