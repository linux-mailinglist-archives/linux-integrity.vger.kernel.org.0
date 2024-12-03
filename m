Return-Path: <linux-integrity+bounces-4280-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3671C9E2FEB
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Dec 2024 00:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 000681626E2
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Dec 2024 23:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2612202F84;
	Tue,  3 Dec 2024 23:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kCD+enVb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7BD55897;
	Tue,  3 Dec 2024 23:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733268889; cv=none; b=NLPrj1gHudR+NLG8A4jbda6zya5/MHPMFztVXOqXf6Sk0S5aA00VTGP5RZBOY8+7zU+YxIM7iZvoydolEkWykdgHfUwquj3bSmJn+/RXrZWYGxmb1uY6eRwUMca6wFxHpBCAbEj/jZXlNyPky8XmXv00ru6ksYpt5MATFeYvqN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733268889; c=relaxed/simple;
	bh=BEBL2bpHnCsC21zu0UDZ80GnZqN75aCgXuUrt/nYgAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pEHWpoVq3Zqa/qPb+JfsOKf4RlKJWbJ3SFZCKaf0+Rl2xoCu2O5Ztz9v9w+Ev+xeWBW+fYNAZa9znYrbDIIXyn7m+ibgluUhQ7yQj0y2NrSzUM42un6m1c7S6v7JJ1VbjwB04rV7FdrzsvXKjMwhVLBU4xJ2LCKeUheC/OOeAQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kCD+enVb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3K069e002901;
	Tue, 3 Dec 2024 23:34:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=nA9SjGy9jz4LWF/XLkoUoFQ4mwaT7n/v+IYNFkXWv
	VE=; b=kCD+enVb+kffxlH91nAgOAZ0+732AXHinUa5k2Qkmb34Yw09wbyO+PLA6
	yCDwiaV9l7/CNHGY3foGSskWavC8FgS6092jUESxqFWUkUv2gW7XC/EcLOsMPoKo
	cIQKCRN6EmR2owvocblC3DgU870/vzw+2ZOxXUdhCHCS9rFVn5RpHVhMblhVo0eE
	FeZrrYdDU1NiLGf0IGmoGGN1TQn5AJVrkzW40uoe5w+sflqBqQmM2Mn68z6sQosx
	EJC9r2mtIC2GavmOKCJ8JtoOPuCH6kOX/hXTg9uZWzfFE3e+GnJaEvagPV7SuwGc
	18UCF6cfmCbpy5AGIHGcnwIbUoPzA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 437r4pmrup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 23:34:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B3MWBZZ023551;
	Tue, 3 Dec 2024 23:34:31 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 438e1n18gc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Dec 2024 23:34:31 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B3NYTgr21103038
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Dec 2024 23:34:29 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12B262004B;
	Tue,  3 Dec 2024 23:34:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 099C920040;
	Tue,  3 Dec 2024 23:34:27 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.fios-router.home (unknown [9.61.153.147])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Dec 2024 23:34:26 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        roberto.sassu@huawei.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>,
        Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>,
        audit@vger.kernel.org
Subject: [PATCH v2] ima: instantiate the bprm_creds_for_exec() hook
Date: Tue,  3 Dec 2024 18:34:24 -0500
Message-ID: <20241203233424.287880-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hHr46sg7u6JUU6btydTrFUaUjL6wyzfD
X-Proofpoint-ORIG-GUID: hHr46sg7u6JUU6btydTrFUaUjL6wyzfD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 clxscore=1011 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412030194

Like direct file execution (e.g. ./script.sh), indirect file exection
(e.g. sh script.sh) needs to be measured and appraised.  Instantiate
the new security_bprm_creds_for_exec() hook to measure and verify the
indirect file's integrity.  Unlike direct file execution, indirect file
execution is optionally enforced by the interpreter.

Differentiate kernel and userspace enforced integrity audit messages.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
Changelog v2:
- Mickael: Use same audit messages with new audit message number
- Stefan Berger: Return boolean from is_bprm_creds_for_exec() 

 include/uapi/linux/audit.h            |  1 +
 security/integrity/ima/ima_appraise.c | 28 +++++++++++++++++++++++++--
 security/integrity/ima/ima_main.c     | 22 +++++++++++++++++++++
 3 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index 75e21a135483..826337905466 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -161,6 +161,7 @@
 #define AUDIT_INTEGRITY_RULE	    1805 /* policy rule */
 #define AUDIT_INTEGRITY_EVM_XATTR   1806 /* New EVM-covered xattr */
 #define AUDIT_INTEGRITY_POLICY_RULE 1807 /* IMA policy rules */
+#define AUDIT_INTEGRITY_DATA_CHECK  1808 /* Userspace enforced data integrity */
 
 #define AUDIT_KERNEL		2000	/* Asynchronous audit record. NOT A REQUEST. */
 
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 656c709b974f..144e0b39fbcd 100644
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
@@ -469,6 +470,18 @@ int ima_check_blacklist(struct ima_iint_cache *iint,
 	return rc;
 }
 
+static bool is_bprm_creds_for_exec(enum ima_hooks func, struct file *file)
+{
+	struct linux_binprm *bprm = NULL;
+
+	if (func == BPRM_CHECK) {
+		bprm = container_of(&file, struct linux_binprm, file);
+		if (bprm->is_check)
+			return true;
+	}
+	return false;
+}
+
 /*
  * ima_appraise_measurement - appraise file measurement
  *
@@ -483,6 +496,7 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 			     int xattr_len, const struct modsig *modsig)
 {
 	static const char op[] = "appraise_data";
+	int audit_msgno = AUDIT_INTEGRITY_DATA;
 	const char *cause = "unknown";
 	struct dentry *dentry = file_dentry(file);
 	struct inode *inode = d_backing_inode(dentry);
@@ -494,6 +508,16 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 	if (!(inode->i_opflags & IOP_XATTR) && !try_modsig)
 		return INTEGRITY_UNKNOWN;
 
+	/*
+	 * Unlike any of the other LSM hooks where the kernel enforces file
+	 * integrity, enforcing file integrity for the bprm_creds_for_exec()
+	 * LSM hook with the AT_EXECVE_CHECK flag is left up to the discretion
+	 * of the script interpreter(userspace). Differentiate kernel and
+	 * userspace enforced integrity audit messages.
+	 */
+	if (is_bprm_creds_for_exec(func, file))
+		audit_msgno = AUDIT_INTEGRITY_DATA_CHECK;
+
 	/* If reading the xattr failed and there's no modsig, error out. */
 	if (rc <= 0 && !try_modsig) {
 		if (rc && rc != -ENODATA)
@@ -569,7 +593,7 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 	     (iint->flags & IMA_FAIL_UNVERIFIABLE_SIGS))) {
 		status = INTEGRITY_FAIL;
 		cause = "unverifiable-signature";
-		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
+		integrity_audit_msg(audit_msgno, inode, filename,
 				    op, cause, rc, 0);
 	} else if (status != INTEGRITY_PASS) {
 		/* Fix mode, but don't replace file signatures. */
@@ -589,7 +613,7 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 			status = INTEGRITY_PASS;
 		}
 
-		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
+		integrity_audit_msg(audit_msgno, inode, filename,
 				    op, cause, rc, 0);
 	} else {
 		ima_cache_flags(iint, func);
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 06132cf47016..f0830e6d0cda 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -554,6 +554,27 @@ static int ima_bprm_check(struct linux_binprm *bprm)
 				   MAY_EXEC, CREDS_CHECK);
 }
 
+/**
+ * ima_bprm_creds_for_exec - collect/store/appraise measurement.
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


