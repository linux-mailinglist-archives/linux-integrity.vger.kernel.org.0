Return-Path: <linux-integrity+bounces-4224-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BCB9DAA5E
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Nov 2024 16:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DB4FB2091F
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Nov 2024 15:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5D71FF617;
	Wed, 27 Nov 2024 15:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hboARJf/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082E51FCFDB;
	Wed, 27 Nov 2024 15:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732719957; cv=none; b=XYm/8a0fH7e0+O5RKb533bu6bxglVdJFA3r8lBLH0M6nJSgtVb5YGhzRMZQvPxn0sNdHJOV3fpkV9DDNC+7QmYlAcySYsAbqY3TWxkn83EjVH7te7ctNYi7sUxrM1eg9VVpC0ipJ99A8bfQ/Bbr2Qx077GPXsQnGq5FphULLUYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732719957; c=relaxed/simple;
	bh=oIMZ8RIaq9mv0luKoOVAL1Q1fGWX4YvE7H0phVBT7PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I1fHqI1tospH2VdqLO80+d0mLf8mDF1xNq3wvW88mmSYJhfXRPMNlmhG9o7h/Hnvd3V0Ho5luVi3TPpSD3YcVUlYSkZqxXy5rZ0W6AVsm5x4I8fgZYIC1uSAmXopYaCZjhgsjzMcFTHPUWUTqYo/eWI1DCwpRgtjbCL768YQalw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hboARJf/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ARDotVM020312;
	Wed, 27 Nov 2024 15:05:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=k2wRYhaBSTr5h/XIrDdIpEbqcnEof54Nqe3cJNy0D
	Iw=; b=hboARJf/d7+qmydbeNq3HJvCS4dlzXNewiZQR6GgPwqapK2qPKdiXIDhL
	tkI4EB/oHP39dzU8LalB0CytwirSj1d14yiEKmKiE3daIiyORn9i+deFbIAICSFc
	R/DwQ1dszz6Ur5sqwKQ9/8I7djK/1XdXj4tzJE+tGqE6/GgQFwr7lg2nXDBYyeZg
	//Yc0zQkxKYd8rqyf2OgJeSu0iw6kAy6/8dAcYPQiXr+kePLMStsoBVpLDY8ckoZ
	n595TaQCf8N7O9TT5T3NPV51BIu9lrBZYYFfAQrERgMa+7S+tgZ9JCxBuAFvF/lV
	LA4BxGN/vFboqQj+J/UFA3jsu47Kw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 435ecmpfjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 15:05:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ARBPAOR008850;
	Wed, 27 Nov 2024 15:05:42 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 433scrxq1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 15:05:42 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4ARF5eln18809248
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Nov 2024 15:05:41 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D80AC2004B;
	Wed, 27 Nov 2024 15:05:40 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EF6E20043;
	Wed, 27 Nov 2024 15:05:39 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.fios-router.home (unknown [9.61.125.198])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 Nov 2024 15:05:39 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        roberto.sassu@huawei.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] ima: instantiate the bprm_creds_for_exec() hook
Date: Wed, 27 Nov 2024 10:05:26 -0500
Message-ID: <20241127150526.97348-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MBw2oAuT7UXv1Qi0UVLZvlqLQ2Z_vgZh
X-Proofpoint-GUID: MBw2oAuT7UXv1Qi0UVLZvlqLQ2Z_vgZh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 bulkscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411270119

Like direct file execution (e.g. ./script.sh), indirect file exection
(e.g. sh script.sh) need to be measured and appraised.  Instantiate
the new security_bprm_creds_for_exec() hook to measure and verify the
indirect file's integrity.  Unlike direct file execution, indirect file
execution is optionally enforced by the interpreter.

Define two new audit messages:
- Userspace-enforcing-IMA-signature-required
- Userspace-not-enforcing-IMA-signature-required

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima_appraise.c | 24 +++++++++++++++++++++++-
 security/integrity/ima/ima_main.c     | 22 ++++++++++++++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 656c709b974f..5a3b5cdecb51 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/file.h>
+#include <linux/binfmts.h>
 #include <linux/fs.h>
 #include <linux/xattr.h>
 #include <linux/magic.h>
@@ -16,6 +17,7 @@
 #include <linux/fsverity.h>
 #include <keys/system_keyring.h>
 #include <uapi/linux/fsverity.h>
+#include <linux/securebits.h>
 
 #include "ima.h"
 
@@ -469,6 +471,26 @@ int ima_check_blacklist(struct ima_iint_cache *iint,
 	return rc;
 }
 
+static int is_bprm_creds_for_exec(enum ima_hooks func, struct file *file,
+				  const char **cause)
+{
+	const struct cred *cred = current_cred();
+	struct linux_binprm *bprm = NULL;
+
+	if (func == BPRM_CHECK) {
+		bprm = container_of(&file, struct linux_binprm, file);
+		if (!bprm->is_check)
+			return 0;
+
+		if (cred->securebits & SECBIT_EXEC_RESTRICT_FILE)
+			*cause = "Userspace-enforcing-IMA-signature-required";
+		else
+			*cause = "Userspace-not-enforcing-IMA-signature-required";
+		return 1;
+	}
+	return 0;
+}
+
 /*
  * ima_appraise_measurement - appraise file measurement
  *
@@ -502,7 +524,7 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 		if (iint->flags & IMA_DIGSIG_REQUIRED) {
 			if (iint->flags & IMA_VERITY_REQUIRED)
 				cause = "verity-signature-required";
-			else
+			else if (!is_bprm_creds_for_exec(func, file, &cause))
 				cause = "IMA-signature-required";
 		} else {
 			cause = "missing-hash";
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 06132cf47016..2b5d6bae77a4 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -554,6 +554,27 @@ static int ima_bprm_check(struct linux_binprm *bprm)
 				   MAY_EXEC, CREDS_CHECK);
 }
 
+/**
+ * ima_bprm_creds_for_exec - based on policy, collect/store/appraise measurement.
+ * @bprm: contains the linux_binprm structure
+ *
+ * Based on the IMA policy and the execvat(2) AT_CHECK flag, measure and
+ * appraise the integrity of a file to be executed by script interpreters.
+ * Unlike any of the other LSM hooks where the kernel enforces file integrity,
+ * enforcing file integrity is left up to the discretion of the script
+ * interpreter (userspace).
+ *
+ * On success return 0.  On integrity appraisal error, assuming the file
+ * is in policy and IMA-appraisal is in enforcing mode, return -EACCES.
+ */
+static int ima_bprm_creds_for_exec(struct linux_binprm *bprm)
+{
+	if (!bprm->is_check)
+		return 0;
+
+	return ima_bprm_check(bprm);
+}
+
 /**
  * ima_file_check - based on policy, collect/store measurement.
  * @file: pointer to the file to be measured
@@ -1177,6 +1198,7 @@ static int __init init_ima(void)
 
 static struct security_hook_list ima_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(bprm_check_security, ima_bprm_check),
+	LSM_HOOK_INIT(bprm_creds_for_exec, ima_bprm_creds_for_exec),
 	LSM_HOOK_INIT(file_post_open, ima_file_check),
 	LSM_HOOK_INIT(inode_post_create_tmpfile, ima_post_create_tmpfile),
 	LSM_HOOK_INIT(file_release, ima_file_free),
-- 
2.47.0


