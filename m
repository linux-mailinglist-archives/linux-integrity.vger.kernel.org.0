Return-Path: <linux-integrity+bounces-5025-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F60A4A46F
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Feb 2025 21:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 456A77AA110
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Feb 2025 20:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A9510E5;
	Fri, 28 Feb 2025 20:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="muniTs6A"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944D71BCA0E
	for <linux-integrity@vger.kernel.org>; Fri, 28 Feb 2025 20:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740776137; cv=none; b=hfzKWF0/vWBjEduJ0f6xSVnqRvYwNnztiTK0XwNe/BhlnJY810ZSD1Wz2DWH5gzx1r3bJQmFnwOD998R/7e7HERk2ZnRHEzoV6aPIU/kUpLbwjH1llu684fIQC8Vf1l/VV4IoQ315Ur3c6nXZPP6KcUK7tEunb5yQzkmScaDfqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740776137; c=relaxed/simple;
	bh=mbGn3NPdNP+a59nXzr+JrntI6znar5qKyqw6huZRiFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p55OTx0tqYbSw19rEGjfFLDK0a5Nmh06RhLGpAuAViTBd+lt4kvnQdqAmsc3ANsJr7YRqtdjVMzNRGMzjLS/gqQTTkEpV/ZR3A2G4Ao1wDN1TYVu+T57NnU7v5JtZ8MpcMYLc1YBmeJl/nYoBn+MAY+hpRP2YZBynvQDZcdrEgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=muniTs6A; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SJaQFa015651;
	Fri, 28 Feb 2025 20:55:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7TkAxx9U7T0kN+B2H
	HzQupk+wbLfn5Q3Jqm+06qmABk=; b=muniTs6AF/jL37JGiohhyhMZbr5LsdjKL
	2sPuXUe7gSZj48wTI6RvTMBS1QUi8RwRZ5RR0o+MteUqZMesaxZG2/hbaDaMXJ7P
	YQZb5fV0mZey3xa/221Xy3FB8Jq5/zKMys9k0GqoRFBITdl5y4wnfqvyFyFPiNP2
	Oq7e77wmUx1ufYQ4oFCnziMH/Q67OkewbrAhszv6Jej3XfcRYuu1oOc0Z1X6y1dd
	lDW3koLYdhPqS3SvLv6AzShSvtSKvrDK0srLetNmuWt2BgDNV7eaEXXQYZAfRFcu
	ol0HrjyYML4lpDnw+RlAs2uIbL8/0V3A9WgaN0XaajWlPW38C/uiQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45316adxjk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 20:55:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51SK1cd1026285;
	Fri, 28 Feb 2025 20:55:24 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44yswp0kmj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 20:55:24 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51SKtKeO30802666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 20:55:20 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63DCD20043;
	Fri, 28 Feb 2025 20:55:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBE0920040;
	Fri, 28 Feb 2025 20:55:18 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com.com (unknown [9.61.94.47])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Feb 2025 20:55:18 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huawei.com,
        Stefan Berger <stefanb@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>
Subject: [PATCH v2 2/2] ima: limit the number of ToMToU integrity violations
Date: Fri, 28 Feb 2025 15:55:05 -0500
Message-ID: <20250228205505.476845-3-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228205505.476845-1-zohar@linux.ibm.com>
References: <20250228205505.476845-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _FzJdi_XbgNJhNmBsAgvaf_uEsYw6dyW
X-Proofpoint-GUID: _FzJdi_XbgNJhNmBsAgvaf_uEsYw6dyW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_06,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 spamscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502280148

Each time a file in policy, that is already opened for read, is opened
for write, a Time-of-Measure-Time-of-Use (ToMToU) integrity violation
audit message is emitted and a violation record is added to the IMA
measurement list.  This occurs even if a ToMToU violation has already
been recorded.

Limit the number of ToMToU integrity violations per file open for read.

Note: The IMA_MAY_EMIT_TOMTOU atomic flag must be set from the reader
side based on policy.  This may result in a per file open for read
ToMToU violation.

Since IMA_MUST_MEASURE is only used for violations, rename the atomic
IMA_MUST_MEASURE flag to IMA_MAY_EMIT_TOMTOU.

Tested-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
Changelog v2:
- Based on Roberto's review, renamed the atomic flag name, updated the patch
description.
- Added Petr's and Stefan's tags.

 security/integrity/ima/ima.h      | 2 +-
 security/integrity/ima/ima_main.c | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index 3423b3088de5..e0489c6f7f59 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -181,7 +181,7 @@ struct ima_kexec_hdr {
 #define IMA_UPDATE_XATTR	1
 #define IMA_CHANGE_ATTR		2
 #define IMA_DIGSIG		3
-#define IMA_MUST_MEASURE	4
+#define IMA_MAY_EMIT_TOMTOU	4
 #define IMA_EMITTED_OPENWRITERS	5

 /* IMA integrity metadata associated with an inode */
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 95118c1887cb..f3e7ac513db3 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -129,14 +129,15 @@ static void ima_rdwr_violation_check(struct file *file,
 		if (atomic_read(&inode->i_readcount) && IS_IMA(inode)) {
 			if (!iint)
 				iint = ima_iint_find(inode);
+
 			/* IMA_MEASURE is set from reader side */
-			if (iint && test_bit(IMA_MUST_MEASURE,
-						&iint->atomic_flags))
+			if (iint && test_and_clear_bit(IMA_MAY_EMIT_TOMTOU,
+						       &iint->atomic_flags))
 				send_tomtou = true;
 		}
 	} else {
 		if (must_measure)
-			set_bit(IMA_MUST_MEASURE, &iint->atomic_flags);
+			set_bit(IMA_MAY_EMIT_TOMTOU, &iint->atomic_flags);

 		/* Limit number of open_writers violations */
 		if (inode_is_open_for_write(inode) && must_measure) {
--
2.48.1


