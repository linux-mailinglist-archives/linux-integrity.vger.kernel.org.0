Return-Path: <linux-integrity+bounces-4233-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EF49DAEB9
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Nov 2024 22:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161A21651B9
	for <lists+linux-integrity@lfdr.de>; Wed, 27 Nov 2024 21:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94AFB14658C;
	Wed, 27 Nov 2024 21:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EseRpknu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8065B140E38;
	Wed, 27 Nov 2024 21:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732741374; cv=none; b=FDReR6mo8EPdcatQfH/dMxqieLdrk0KGubmfTsjIeaUI7ODHJKSIqDcOOkOzm2R/+yQ8H2C+RxrHPpH3uqwArSsIrn9n9Qqklfoe0h3v0pQMozr9rF+AJan+4jR8fyfamIJH6HhOu59zmkNqZFvSCvX/hBBxCihNDAgSmwIaSdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732741374; c=relaxed/simple;
	bh=t6m3YvbjS8NicfRrUZkEJsoXFNyppTRQ8GvBsQvPZ0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tqp/BqxJDxOjJTx9pZdxfBq55zMjfz32Iz04yDeOkCnyRsHTvNoBWTe9rKNWV9WKcV/3frr2zM7b7qOW4gC0OMHRSCXiAwvQ0mifcVbDN5Q4tNb+pyA90TWeRC7y0k0w2f7pMABMxV4UjXqJzLozphfHguHS3QfbBUDRjQX6GFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EseRpknu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ARHXgA5018057;
	Wed, 27 Nov 2024 21:02:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Py0nmOg/OGfeoc6ZQj8Xz5DCd3iv4EoR9dulVzsxZ
	94=; b=EseRpknuo35h+WupTL6QrCMWpK+iNwjAjOfRxC+i1b5nZh8N3xGsD5S+X
	XaTuzK2a6Kyk8FwbXU3kJYvGYchi4zJOlYd4gLu3kIcTkuTtrvFF9453jt49j0Xf
	I5sNTRfsZJEIuYeULQRYs34rA6uijsTRxq4P53qqqiG+NSjnTpg3KHIdvcl8vjjP
	YHf3E7QpNZ679H4z4zP/HC3kqaxujp3J1ANQ2Ij/dNR9JrVVHgE4v8XcWmB43aDp
	g/CF419kKv47Pc9FlRU10XmJ9kkfCLfoNHivKBhv1ztEoCxdtvgdVJdY+SrCm4ai
	rs9r4TlZZb4PCEF7pHlX3dvqeppWA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4366yx12vs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 21:02:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ARK81oa012010;
	Wed, 27 Nov 2024 21:02:41 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43672ga5jk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Nov 2024 21:02:41 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4ARL2dNA42860910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Nov 2024 21:02:39 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BBD820040;
	Wed, 27 Nov 2024 21:02:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB12120043;
	Wed, 27 Nov 2024 21:02:37 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.fios-router.home (unknown [9.61.172.160])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 Nov 2024 21:02:37 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        roberto.sassu@huawei.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ima: instantiate the bprm_creds_for_exec() hook
Date: Wed, 27 Nov 2024 16:02:34 -0500
Message-ID: <20241127210234.121546-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: S98G5gwaC1k6Z3ghZ4LRLR3dTusTb67d
X-Proofpoint-GUID: S98G5gwaC1k6Z3ghZ4LRLR3dTusTb67d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 clxscore=1015 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2411270163

Like direct file execution (e.g. ./script.sh), indirect file execution
(e.g. sh script.sh) needs to be measured and appraised.  Instantiate
the new security_bprm_creds_for_exec() hook to measure and verify the
indirect file's integrity.  Unlike direct file execution, indirect file
execution integrity is optionally enforced by the interpreter.

Update the audit messages to differentiate between kernel and userspace
enforced integrity.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima_appraise.c | 84 ++++++++++++++++++++-------
 security/integrity/ima/ima_main.c     | 22 +++++++
 2 files changed, 86 insertions(+), 20 deletions(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 656c709b974f..b5f8e49cde9d 100644
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
 
@@ -276,7 +278,8 @@ static int calc_file_id_hash(enum evm_ima_xattr_type type,
  */
 static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint,
 			struct evm_ima_xattr_data *xattr_value, int xattr_len,
-			enum integrity_status *status, const char **cause)
+			enum integrity_status *status, const char **cause,
+			bool is_check)
 {
 	struct ima_max_digest_data hash;
 	struct signature_v2_hdr *sig;
@@ -292,9 +295,11 @@ static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint,
 		if (*status != INTEGRITY_PASS_IMMUTABLE) {
 			if (iint->flags & IMA_DIGSIG_REQUIRED) {
 				if (iint->flags & IMA_VERITY_REQUIRED)
-					*cause = "verity-signature-required";
+					*cause = !is_check ? "verity-signature-required" :
+						"verity-signature-required(userspace)";
 				else
-					*cause = "IMA-signature-required";
+					*cause = !is_check ? "IMA-signature-required" :
+						"IMA-signature-required(userspace)";
 				*status = INTEGRITY_FAIL;
 				break;
 			}
@@ -314,7 +319,8 @@ static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint,
 		else
 			rc = -EINVAL;
 		if (rc) {
-			*cause = "invalid-hash";
+			*cause = !is_check ? "invalid-hash" :
+				"invalid-hash(userspace)";
 			*status = INTEGRITY_FAIL;
 			break;
 		}
@@ -325,14 +331,16 @@ static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint,
 
 		mask = IMA_DIGSIG_REQUIRED | IMA_VERITY_REQUIRED;
 		if ((iint->flags & mask) == mask) {
-			*cause = "verity-signature-required";
+			*cause = !is_check ? "verity-signature-required" :
+				"verity-signature-required(userspace)";
 			*status = INTEGRITY_FAIL;
 			break;
 		}
 
 		sig = (typeof(sig))xattr_value;
 		if (sig->version >= 3) {
-			*cause = "invalid-signature-version";
+			*cause = !is_check ? "invalid-signature-version" :
+				"invalid-signature-version(userspace)";
 			*status = INTEGRITY_FAIL;
 			break;
 		}
@@ -353,7 +361,8 @@ static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint,
 						     iint->ima_hash->digest,
 						     iint->ima_hash->length);
 		if (rc) {
-			*cause = "invalid-signature";
+			*cause = !is_check ? "invalid-signature" :
+				"invalid-signature(userspace)";
 			*status = INTEGRITY_FAIL;
 		} else {
 			*status = INTEGRITY_PASS;
@@ -364,7 +373,8 @@ static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint,
 
 		if (iint->flags & IMA_DIGSIG_REQUIRED) {
 			if (!(iint->flags & IMA_VERITY_REQUIRED)) {
-				*cause = "IMA-signature-required";
+				*cause = !is_check ? "IMA-signature-required" :
+					"IMA-signature-required(userspace)";
 				*status = INTEGRITY_FAIL;
 				break;
 			}
@@ -372,7 +382,8 @@ static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint,
 
 		sig = (typeof(sig))xattr_value;
 		if (sig->version != 3) {
-			*cause = "invalid-signature-version";
+			*cause = !is_check ? "invalid-signature-version" :
+				"invalid-signature-version(userspace)";
 			*status = INTEGRITY_FAIL;
 			break;
 		}
@@ -382,7 +393,8 @@ static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint,
 				       container_of(&hash.hdr,
 					       struct ima_digest_data, hdr));
 		if (rc) {
-			*cause = "sigv3-hashing-error";
+			*cause = !is_check ? "sigv3-hashing-error" :
+				"sigv3-hashing-error(userspace)";
 			*status = INTEGRITY_FAIL;
 			break;
 		}
@@ -392,7 +404,8 @@ static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint,
 					     xattr_len, hash.digest,
 					     hash.hdr.length);
 		if (rc) {
-			*cause = "invalid-verity-signature";
+			*cause = !is_check ? "invalid-verity-signature" :
+				"invalid-verify-signature(userspace)";
 			*status = INTEGRITY_FAIL;
 		} else {
 			*status = INTEGRITY_PASS;
@@ -401,7 +414,8 @@ static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint,
 		break;
 	default:
 		*status = INTEGRITY_UNKNOWN;
-		*cause = "unknown-ima-data";
+		*cause = !is_check ? "unknown-ima-data" :
+			"unknown-ima-data(userspace)";
 		break;
 	}
 
@@ -469,6 +483,18 @@ int ima_check_blacklist(struct ima_iint_cache *iint,
 	return rc;
 }
 
+static int is_bprm_creds_for_exec(enum ima_hooks func, struct file *file)
+{
+	struct linux_binprm *bprm = NULL;
+
+	if (func == BPRM_CHECK) {
+		bprm = container_of(&file, struct linux_binprm, file);
+		if (bprm->is_check)
+			return 1;
+	}
+	return 0;
+}
+
 /*
  * ima_appraise_measurement - appraise file measurement
  *
@@ -489,11 +515,24 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 	enum integrity_status status = INTEGRITY_UNKNOWN;
 	int rc = xattr_len;
 	bool try_modsig = iint->flags & IMA_MODSIG_ALLOWED && modsig;
+	bool is_check = false;
 
 	/* If not appraising a modsig, we need an xattr. */
 	if (!(inode->i_opflags & IOP_XATTR) && !try_modsig)
 		return INTEGRITY_UNKNOWN;
 
+	/*
+	 * Unlike any of the other LSM hooks where the kernel enforces file
+	 * integrity, enforcing file integrity for the bprm_creds_for_exec()
+	 * LSM hook is left up to the discretion of the script interpreter
+	 * (userspace).
+	 *
+	 * Since the SECBIT_EXEC_RESTRICT_FILE flag is just a hint as to
+	 * userspace intentions, simply annotate the audit messages indicating
+	 * a userspace based query.
+	 */
+	is_check = is_bprm_creds_for_exec(func, file);
+
 	/* If reading the xattr failed and there's no modsig, error out. */
 	if (rc <= 0 && !try_modsig) {
 		if (rc && rc != -ENODATA)
@@ -501,11 +540,14 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 
 		if (iint->flags & IMA_DIGSIG_REQUIRED) {
 			if (iint->flags & IMA_VERITY_REQUIRED)
-				cause = "verity-signature-required";
+				cause = !is_check ? "verity-signature-required" :
+					"verity-signature-required(userspace)";
 			else
-				cause = "IMA-signature-required";
+				cause = !is_check ? "IMA-signature-required" :
+					"IMA-signature-required(userspace)";
 		} else {
-			cause = "missing-hash";
+			cause = !is_check ? "missing-hash" :
+				"missing-hash(userspace)";
 		}
 
 		status = INTEGRITY_NOLABEL;
@@ -531,14 +573,15 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 			break;
 		fallthrough;
 	case INTEGRITY_NOLABEL:		/* No security.evm xattr. */
-		cause = "missing-HMAC";
+		cause = !is_check ? "missing-HMAC" : "missing-HMAC(userspace)";
 		goto out;
 	case INTEGRITY_FAIL_IMMUTABLE:
 		set_bit(IMA_DIGSIG, &iint->atomic_flags);
-		cause = "invalid-fail-immutable";
+		cause = !is_check ? "invalid-fail-immutable" :
+		       "invalid-fail-immutable(userspace)";
 		goto out;
 	case INTEGRITY_FAIL:		/* Invalid HMAC/signature. */
-		cause = "invalid-HMAC";
+		cause = !is_check ? "invalid-HMAC" : "invalid-HMAC(userspace)";
 		goto out;
 	default:
 		WARN_ONCE(true, "Unexpected integrity status %d\n", status);
@@ -546,7 +589,7 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 
 	if (xattr_value)
 		rc = xattr_verify(func, iint, xattr_value, xattr_len, &status,
-				  &cause);
+				  &cause, is_check);
 
 	/*
 	 * If we have a modsig and either no imasig or the imasig's key isn't
@@ -568,7 +611,8 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 	    ((inode->i_sb->s_iflags & SB_I_UNTRUSTED_MOUNTER) ||
 	     (iint->flags & IMA_FAIL_UNVERIFIABLE_SIGS))) {
 		status = INTEGRITY_FAIL;
-		cause = "unverifiable-signature";
+		cause = !is_check ? "unverifiable-signature" :
+			"unverifiable-signature(userspace)";
 		integrity_audit_msg(AUDIT_INTEGRITY_DATA, inode, filename,
 				    op, cause, rc, 0);
 	} else if (status != INTEGRITY_PASS) {
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


