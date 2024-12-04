Return-Path: <linux-integrity+bounces-4286-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CDB9E4489
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Dec 2024 20:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25F1116858E
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Dec 2024 19:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFEE1C3BE4;
	Wed,  4 Dec 2024 19:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HiAzTTOM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B77C2391AA;
	Wed,  4 Dec 2024 19:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733340341; cv=none; b=DtXYC5pHkyL/u9DVK0FNfjQIslBfGze5hIbtiJihRWjPPxPKPI59tKzMD7kbn1OG5WlqplXbunlaHlc8rNHSgMhUlUL0C3bmLv60wYk2/Eg6aOQ4vNQ9oGtpMGi0a7vI7DJ5EAXIzr7SwnxBjI39NkqG7Mb2ec2MhrcEohIYPw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733340341; c=relaxed/simple;
	bh=EerDhxJpSU5cCC4UM+W+smPICn3fsnMpZc0x2ONSUZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JgzZ3pTr85NI0vXuf8xp2QsGqoUIlxqxm4ynKCFsL1GsN6fOxCfVz2LoQYZ5uy3pR/VF2EAvKfONQt+bS4Cfzg0SzqFi4if7A4zMb7x0vOTk7BTDle1Scc15XZrUwmEK2XfUYjzCQ2QlZ7BIqvvtMIp9r5sD3ofYPUtvtHCvMOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HiAzTTOM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4FxYJK010244;
	Wed, 4 Dec 2024 19:25:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=JJ9ZRvfwunck08W7rLxglNPCEXNky9oQEKVt+rM4a
	+4=; b=HiAzTTOMK0wWE7PZWBTbx5yxSAzoJZcFqFOnYG9UYhRRWkVdmRhuKjRjO
	HpNaJ0MBfyTb4UcTojRcSJEWKavzfPOJT43TnIUZcQVwrrTJkWWxbU8Xa+2+BRFG
	MthWFOAKTGvzjXITzv0BjzD+p0ErSCqUj4on0/kkv0n1BugkpbRa9J604cGZgFqc
	/i0Oc4CUBjuXv2zt2WQYC1AEaCJUaepvS9ef0sRsW+7sb1DW9wp2XcmkgGX6bC+Y
	uH/WuKq/eJEjvEF/r06Ou8TXvEqWLduoLth78OHOtOXltet1sevTgZ7N5RI/PFqL
	dlfH0iw8dTPR/uCIEouUHHVRWWC+Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ahve3qjb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 19:25:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4IwtrH022960;
	Wed, 4 Dec 2024 19:25:23 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 438e1n5b9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 19:25:23 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B4JPLtY30802616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Dec 2024 19:25:21 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4935820049;
	Wed,  4 Dec 2024 19:25:21 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87D4320040;
	Wed,  4 Dec 2024 19:25:19 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.watson.ibm.com (unknown [9.31.103.152])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Dec 2024 19:25:19 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        roberto.sassu@huawei.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>,
        Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>,
        audit@vger.kernel.org
Subject: [PATCH v2] ima: instantiate the bprm_creds_for_exec() hook
Date: Wed,  4 Dec 2024 14:25:14 -0500
Message-ID: <20241204192514.40308-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iOqdpHeouk3A7X1sMprDgAJHPij2y0EY
X-Proofpoint-ORIG-GUID: iOqdpHeouk3A7X1sMprDgAJHPij2y0EY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412040145

Like direct file execution (e.g. ./script.sh), indirect file execution
(e.g. sh script.sh) needs to be measured and appraised.  Instantiate
the new security_bprm_creds_for_exec() hook to measure and verify the
indirect file's integrity.  Unlike direct file execution, indirect file
execution is optionally enforced by the interpreter.

Differentiate kernel and userspace enforced integrity audit messages.

Co-developed-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
Changelog v3:
- Mickael: add comment ima_bprm_creds_for_exec(), minor code cleanup,
  add Co-developed-by tag.

Changelog v2:
- Mickael: Use same audit messages with new audit message number
- Stefan Berger: Return boolean from is_bprm_creds_for_exec()

 include/uapi/linux/audit.h            |  1 +
 security/integrity/ima/ima_appraise.c | 27 +++++++++++++++++++++++--
 security/integrity/ima/ima_main.c     | 29 +++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 2 deletions(-)

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
index 656c709b974f..fc0d1f3cceca 100644
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
@@ -469,6 +470,17 @@ int ima_check_blacklist(struct ima_iint_cache *iint,
 	return rc;
 }
 
+static bool is_bprm_creds_for_exec(enum ima_hooks func, struct file *file)
+{
+	struct linux_binprm *bprm;
+
+	if (func == BPRM_CHECK) {
+		bprm = container_of(&file, struct linux_binprm, file);
+		return bprm->is_check;
+	}
+	return false;
+}
+
 /*
  * ima_appraise_measurement - appraise file measurement
  *
@@ -483,6 +495,7 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 			     int xattr_len, const struct modsig *modsig)
 {
 	static const char op[] = "appraise_data";
+	int audit_msgno = AUDIT_INTEGRITY_DATA;
 	const char *cause = "unknown";
 	struct dentry *dentry = file_dentry(file);
 	struct inode *inode = d_backing_inode(dentry);
@@ -494,6 +507,16 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
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
@@ -569,7 +592,7 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 	     (iint->flags & IMA_FAIL_UNVERIFIABLE_SIGS))) {
 		status = INTEGRITY_FAIL;
 		cause = "unverifiable-signature";
-		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
+		integrity_audit_msg(audit_msgno, inode, filename,
 				    op, cause, rc, 0);
 	} else if (status != INTEGRITY_PASS) {
 		/* Fix mode, but don't replace file signatures. */
@@ -589,7 +612,7 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 			status = INTEGRITY_PASS;
 		}
 
-		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
+		integrity_audit_msg(audit_msgno, inode, filename,
 				    op, cause, rc, 0);
 	} else {
 		ima_cache_flags(iint, func);
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 06132cf47016..5d4ac8aa2f1f 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -554,6 +554,34 @@ static int ima_bprm_check(struct linux_binprm *bprm)
 				   MAY_EXEC, CREDS_CHECK);
 }
 
+/**
+ * ima_bprm_creds_for_exec - collect/store/appraise measurement.
+ * @bprm: contains the linux_binprm structure
+ *
+ * Based on the IMA policy and the execvat(2) AT_EXECVE_CHECK flag, measure
+ * and appraise the integrity of a file to be executed by script interpreters.
+ * Unlike any of the other LSM hooks where the kernel enforces file integrity,
+ * enforcing file integrity is left up to the discretion of the script
+ * interpreter (userspace).
+ *
+ * On success return 0.  On integrity appraisal error, assuming the file
+ * is in policy and IMA-appraisal is in enforcing mode, return -EACCES.
+ */
+static int ima_bprm_creds_for_exec(struct linux_binprm *bprm)
+{
+	/*
+	 * As security_bprm_check() is called multiple times, both
+	 * the script and the shebang interpreter are measured, appraised,
+	 * and audited. Limit usage of this LSM hook to just measuring,
+	 * appraising, and auditing the indirect script execution
+	 * (e.g. ./sh example.sh).
+	 */
+	if (!bprm->is_check)
+		return 0;
+
+	return ima_bprm_check(bprm);
+}
+
 /**
  * ima_file_check - based on policy, collect/store measurement.
  * @file: pointer to the file to be measured
@@ -1177,6 +1205,7 @@ static int __init init_ima(void)
 
 static struct security_hook_list ima_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(bprm_check_security, ima_bprm_check),
+	LSM_HOOK_INIT(bprm_creds_for_exec, ima_bprm_creds_for_exec),
 	LSM_HOOK_INIT(file_post_open, ima_file_check),
 	LSM_HOOK_INIT(inode_post_create_tmpfile, ima_post_create_tmpfile),
 	LSM_HOOK_INIT(file_release, ima_file_free),
-- 
2.47.0


