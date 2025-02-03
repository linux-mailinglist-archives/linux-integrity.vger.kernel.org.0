Return-Path: <linux-integrity+bounces-4700-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5A2A2652B
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Feb 2025 21:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B47061883BCB
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Feb 2025 20:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302BA20F07A;
	Mon,  3 Feb 2025 20:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OTk3+PO7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D0120F071
	for <linux-integrity@vger.kernel.org>; Mon,  3 Feb 2025 20:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738616340; cv=none; b=lN5S7OllFPxVdAI2wFT1yYx6/ZoFyevGSk4xVdeaeAZfA8YVpYpphpc7YooLsDr6hL60jhFrkbcK+37uXSDihjgsFfbx3zSMCCREpexdB9kCLwWCX8pnJGJBYYcZMSskBBbTotQ9P/2PN49I+1WToLeCUziyNusM97CabzCOLow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738616340; c=relaxed/simple;
	bh=bDT0O+Bqrl0IXhzn6X2v4dtrHREwzI3nLkubEuokL8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g8G2iqw2wnNcQg6uBi7cJVD7dkpEv7mV1j8tK8OayeTT8LIGCN+u6w7quxnjFkfeCvVfTABo1NEViK0MDBlQktfEDq9gpdSkrBDgcU6jk2V+nrGn7vtDU42T3LEpM6AGbYwSzdOFgZccEyTFMfvE+QMIJBOwg0gB6LQpEC/X53Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OTk3+PO7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513EAkZF006345;
	Mon, 3 Feb 2025 20:58:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ClOCcL0A6MFB3GLlrxCiYOxJUlIA9aT3Xt6cUPadX
	Ik=; b=OTk3+PO74f15o+ShlR7SPRGzavonSYi+5hMArSwuaNF/+oQfvV/dGqj1S
	MXEqQdhMwFrozni8re4oUp51JByqhqtYMjtlNrNgT5cVf3UodgkA2Ql+I2GE9qe2
	J96iyHDxPCiBmq5dy46Hi/HCzFKd6Xa7NZGXlWsQQGtTyzvcwJK21GLtsUvKSNPc
	eECKWRTtDpn4uTZfikEv1xVTKtLtBthWJpqH6jRq4ShSO5fpKLGuN7TX9D+Dl2wX
	wAJWecvzWIk/o6QEvuk5BpUCfww+q4Y3sG8kaJBSXie+6Qc1nZxT6dKl6JOUCYrN
	TubfkSBSeTxEoLDORtLvXF5/FmOZg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44jmmycqxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 20:58:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 513IYZ1R007139;
	Mon, 3 Feb 2025 20:58:50 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hxaygbs4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 20:58:50 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 513Kwkes59244812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Feb 2025 20:58:46 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82D17200BE;
	Mon,  3 Feb 2025 20:58:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 58573200BF;
	Mon,  3 Feb 2025 20:58:45 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.fios-router.home (unknown [9.61.83.5])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Feb 2025 20:58:45 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huawei.com
Subject: [RFC PATCH] ima: limit the number of open-writers integrity violations
Date: Mon,  3 Feb 2025 15:58:39 -0500
Message-ID: <20250203205839.720225-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: D_HWLwP8woafB1dImLNTmxuXR2j8xCMl
X-Proofpoint-ORIG-GUID: D_HWLwP8woafB1dImLNTmxuXR2j8xCMl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_08,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 phishscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 mlxlogscore=698 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502030148

Limit the number of open-writers integrity violation audit messages
and records in the IMA measurement list emitted when re-opening a
file for read.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima.h      |  1 +
 security/integrity/ima/ima_main.c | 32 +++++++++++++++++++++++++------
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 24d09ea91b87..f1196fe1a9ff 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -144,6 +144,7 @@ struct ima_kexec_hdr {
 #define IMA_DIGSIG_REQUIRED	0x01000000
 #define IMA_PERMIT_DIRECTIO	0x02000000
 #define IMA_NEW_FILE		0x04000000
+#define IMA_VIOLATION		0x08000000
 #define IMA_FAIL_UNVERIFIABLE_SIGS	0x10000000
 #define IMA_MODSIG_ALLOWED	0x20000000
 #define IMA_CHECK_BLACKLIST	0x40000000
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 9f9897a7c217..a4474f1e7189 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -126,19 +126,32 @@ static void ima_rdwr_violation_check(struct file *file,
 	bool send_tomtou = false, send_writers = false;
 
 	if (mode & FMODE_WRITE) {
+		if (!iint)
+			iint = ima_iint_find(inode);
+
 		if (atomic_read(&inode->i_readcount) && IS_IMA(inode)) {
-			if (!iint)
-				iint = ima_iint_find(inode);
 			/* IMA_MEASURE is set from reader side */
 			if (iint && test_bit(IMA_MUST_MEASURE,
 						&iint->atomic_flags))
 				send_tomtou = true;
 		}
+
+		if (iint)
+			iint->flags &= ~IMA_VIOLATION;
 	} else {
 		if (must_measure)
 			set_bit(IMA_MUST_MEASURE, &iint->atomic_flags);
-		if (inode_is_open_for_write(inode) && must_measure)
-			send_writers = true;
+
+		if (inode_is_open_for_write(inode) && must_measure) {
+			if (!iint)
+				iint = ima_iint_find(inode);
+
+			/* Limit number of open_writers violations */
+			if (iint && !(iint->flags & IMA_VIOLATION)) {
+				send_writers = true;
+				iint->flags |= IMA_VIOLATION;
+			}
+		}
 	}
 
 	if (!send_tomtou && !send_writers)
@@ -268,11 +281,18 @@ static int process_measurement(struct file *file, const struct cred *cred,
 
 	mutex_lock(&iint->mutex);
 
+	/*
+	 * Reset the appraisal flags and the policy rule specific flags, if
+	 * ima_inode_post_setattr was called.
+	 *
+	 * Although "open-writers" violations are limited to FILE_CHECK rules,
+	 * the flag is not policy rule specific and should not be reset.  The
+	 * flag prevents superfluous "open-writers" violations.
+	 */
 	if (test_and_clear_bit(IMA_CHANGE_ATTR, &iint->atomic_flags))
-		/* reset appraisal flags if ima_inode_post_setattr was called */
 		iint->flags &= ~(IMA_APPRAISE | IMA_APPRAISED |
 				 IMA_APPRAISE_SUBMASK | IMA_APPRAISED_SUBMASK |
-				 IMA_NONACTION_FLAGS);
+				 (IMA_NONACTION_FLAGS & ~IMA_VIOLATION));
 
 	/*
 	 * Re-evaulate the file if either the xattr has changed or the
-- 
2.48.1


