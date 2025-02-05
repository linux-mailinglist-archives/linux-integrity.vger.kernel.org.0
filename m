Return-Path: <linux-integrity+bounces-4725-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2044DA282E7
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Feb 2025 04:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EA977A053E
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Feb 2025 03:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94030213E6F;
	Wed,  5 Feb 2025 03:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rxZCrkR/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7519213E60
	for <linux-integrity@vger.kernel.org>; Wed,  5 Feb 2025 03:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738726346; cv=none; b=AKc3a83DpnQTQSHQacy43xp2Ip/LmfsmshOBZMU+Ty4VPmcPl+eD8y2Q7jY3M0vRc8kbB5Mo6ScRXYwGXYLBdT32P/0jyEmtQ2wf/jYID8DF0Qtgr+Z6Hhr/tn8zezZbkeMM8SxyB6ZnMH+U0Q56gg8TgzYWSQ0vDaXsPpFeMdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738726346; c=relaxed/simple;
	bh=9L3kvJrGUbFj/JUQLRfE3T3s52/1GZ4DYdZJzxHHv54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H28H+DLTA8CrAhC89JnITVDfxiwEBbpM1yDUEQR9cXTJWDtagRMpMVmFhvTI2E0o/Tpr78hbQiUnO+F95p2PzCtAE3qaqNx2+1rhfgQ9vdErSt1MWg7QIZvHgHvf/+bus0OUyBDO0eqBSPlIb+2HJ4lF7RvNxlaSFC/Y0DvrlbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rxZCrkR/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514GEnPq023279;
	Wed, 5 Feb 2025 03:32:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=cte2NDqAVcADxjNadHkYl9FRnmzbKfytOpqiWzaal
	gw=; b=rxZCrkR/QWUa+vSR5RvsB3Mf8Ljt/Sk3ijSayrJu+GisvwcUIgVTybYry
	cVQQv1AZ1fpTEagSqqF08iEs/cS0QKkSYL3rTx9t2iUtzseLpdvWiDnSPFyK1rDo
	GrKTxpIS/5HSHFNv/rfIFa/Opiz6oyrtSVgOM4Wmg5SRR5Be+PZIgbvJsyIFOroo
	nGpZ0NzLBteZQ3Ojh8Nfssv8mg+wu6uQ43m19l1hwCMn4RxtVghyZRXNHMpfPlIU
	70BwAKoI2+E6FSECxWammt+L7rK6jlL1yA0PsCpoE8/99rsFrkN5TbVLKaT4lGza
	W5Wv1dBbbK1i/DIwF2E1YWpMeaE4w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44kn62k7ng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 03:32:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 515178bI005310;
	Wed, 5 Feb 2025 03:32:18 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44j05jxjed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 03:32:18 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5153WEeg57999668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Feb 2025 03:32:14 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9C5A20084;
	Wed,  5 Feb 2025 03:32:14 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64C7A20085;
	Wed,  5 Feb 2025 03:32:13 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.fios-router.home (unknown [9.61.30.140])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Feb 2025 03:32:13 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huawei.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [RFC PATCH v2 1/2] ima: limit the number of open-writers integrity violations
Date: Tue,  4 Feb 2025 22:32:09 -0500
Message-ID: <20250205033210.849509-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aBmfEWTuvbYCdOchpNzw6YrrDFZZuL26
X-Proofpoint-ORIG-GUID: aBmfEWTuvbYCdOchpNzw6YrrDFZZuL26
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_01,2025-02-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=834 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502050023

Limit the number of open-writers integrity violation audit messages
and records in the IMA measurement list emitted when re-opening a
file for read.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima.h      |  1 +
 security/integrity/ima/ima_main.c | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index a4f284bd846c..7f21568544dd 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -182,6 +182,7 @@ struct ima_kexec_hdr {
 #define IMA_CHANGE_ATTR		2
 #define IMA_DIGSIG		3
 #define IMA_MUST_MEASURE	4
+#define IMA_LIMIT_VIOLATIONS	5
 
 /* IMA integrity metadata associated with an inode */
 struct ima_iint_cache {
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 28b8b0db6f9b..5091ad931677 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -137,8 +137,16 @@ static void ima_rdwr_violation_check(struct file *file,
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
+			if (iint && !test_and_set_bit(IMA_LIMIT_VIOLATIONS,
+						      &iint->atomic_flags))
+				send_writers = true;
+		}
 	}
 
 	if (!send_tomtou && !send_writers)
@@ -167,6 +175,8 @@ static void ima_check_last_writer(struct ima_iint_cache *iint,
 	if (atomic_read(&inode->i_writecount) == 1) {
 		struct kstat stat;
 
+		clear_bit(IMA_LIMIT_VIOLATIONS, &iint->atomic_flags);
+
 		update = test_and_clear_bit(IMA_UPDATE_XATTR,
 					    &iint->atomic_flags);
 		if ((iint->flags & IMA_NEW_FILE) ||
-- 
2.48.1


