Return-Path: <linux-integrity+bounces-4726-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B7AA282E8
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Feb 2025 04:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 018141617CA
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Feb 2025 03:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAD6211A09;
	Wed,  5 Feb 2025 03:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QIL3R1mK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7748D1E505
	for <linux-integrity@vger.kernel.org>; Wed,  5 Feb 2025 03:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738726385; cv=none; b=A0G78W3AN7cipuc2YCsfVqMJTbjCKMCRDZ0elOHEQksw+SQgvNKuUPDgFkb6QvPZhf3Qj2kGTm1XCilu2SNyxgPc7CwS+2etiJJwLz2gE2IeC8OH5HR9RRxDOZTMAbJcjWqJBquxhEtmSqSasAywsyybfqk+YtdSbwLrLpQp9lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738726385; c=relaxed/simple;
	bh=nm7s+2WB+Oyf67RTFY9LtD8rjuFr2I3Eub9jRMEEIb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6VybSZnAHUJkFio1jWf0CPjZzW0uCLYQMXoADKJb6YHaKCoMo5BN1Z52C8WpbbQujRp7y7Nv/gpLfU1eKFvHW7NReTwWGwb+ZzF1b7ViYdtA9hyYpV6bW/r06vLoH/umK+ZyaenF1m3RG8O3RthmoEUwptcSRYoyh1RY/ivk1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QIL3R1mK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514GF4gm031837;
	Wed, 5 Feb 2025 03:32:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wnzIvqIBrkfDL9rQ5
	Ke1izjPOxmj1RH0+GkpTf2GT3E=; b=QIL3R1mKI9XmPlDhfeYN8+D76yQj0OOVh
	YS6PaccBqGw7enu/TgqHAmWM6ruWkVKmLfHzGd/lEcGuobnzWsUNxdPhklIpX8x9
	zILFyLr/riitZYwxSvPZlQdu9UO3xMQc+v9JnSjkcUwirKxhazcj1ZLTbhY9thZ6
	0oi/bMUO9SkQJMgjOOPj2ILpMJbY8k25ksZQWrC8qWvQjolXeSTbUoiCH5+i9GmZ
	Vqa+C2sPIOmzPE5C0a7W30kh0FrLBjYuCsM8xzCXR01kRFT7CROkKoQ7+2R48vpm
	LcSm22YcV8W7kAj2yy09eQg1PCZIi9/Knn8zrwpH17s8tUc0NO1Kw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44kekp5441-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 03:32:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5151Q6Eb021486;
	Wed, 5 Feb 2025 03:32:21 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44j0n1eey3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 03:32:21 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5153WI2s60162330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Feb 2025 03:32:18 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0444720085;
	Wed,  5 Feb 2025 03:32:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A712C20084;
	Wed,  5 Feb 2025 03:32:16 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.fios-router.home (unknown [9.61.30.140])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Feb 2025 03:32:16 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huawei.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [RFC PATCH v2 2/2] ima: limit the number of ToMToU integrity violations
Date: Tue,  4 Feb 2025 22:32:10 -0500
Message-ID: <20250205033210.849509-2-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250205033210.849509-1-zohar@linux.ibm.com>
References: <20250205033210.849509-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: trj-bstHEsiUPE8gq1ia1RMXSHSgg7hz
X-Proofpoint-GUID: trj-bstHEsiUPE8gq1ia1RMXSHSgg7hz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_01,2025-02-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 phishscore=0 mlxlogscore=567 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502050023

Limit the number of Time-of-Measure-Time-of-Use (ToMToU) integrity
violation audit messages and records in the IMA measurement list
emitted when re-opening a file for write.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 5091ad931677..b35afb844048 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -129,9 +129,10 @@ static void ima_rdwr_violation_check(struct file *file,
 		if (atomic_read(&inode->i_readcount) && IS_IMA(inode)) {
 			if (!iint)
 				iint = ima_iint_find(inode);
+
 			/* IMA_MEASURE is set from reader side */
-			if (iint && test_bit(IMA_MUST_MEASURE,
-						&iint->atomic_flags))
+			if (iint && test_and_clear_bit(IMA_MUST_MEASURE,
+						       &iint->atomic_flags))
 				send_tomtou = true;
 		}
 	} else {
-- 
2.48.1


