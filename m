Return-Path: <linux-integrity+bounces-4495-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCC19FE701
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Dec 2024 15:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E3FE1881F60
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Dec 2024 14:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B531A76DE;
	Mon, 30 Dec 2024 14:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nQT3vk40"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB0825948F
	for <linux-integrity@vger.kernel.org>; Mon, 30 Dec 2024 14:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735568632; cv=none; b=XsL0xbD0gs4aiwPz3lbK307NUGutZeOH6FRaE23Ym0qFJZWrFXs+b5kYBozuciFLiq37//6yflgp1tiIWbhGmkOG9vNUJNRg/OkhK3PLWyk+o6bVR2KlKscMqSFAPmibcm9cSSukqDJGqAJCSOfCDFNRlhfY930deeUdbyGj0Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735568632; c=relaxed/simple;
	bh=fY1kjXf2gyPPlaKB/H9I9rd8vs9aowUu1yL9tyMKwto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dLFhlIN1OC4j4focgpDaGLUgLnNRvAkLtmarcEJrLjB7thTNmV2F7CvLiGXyXbLJfR2epOEbZ51iRBvlwUavIT0MzpTop2KcQOcEZxIDHUo4PLHVJQ4d8fi8VdgaHwN0icF4HbCFf3/rLfMZ1TKG1/RbE9YOkAHxsDx7oCNC790=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nQT3vk40; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BTNw7b9030259;
	Mon, 30 Dec 2024 14:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=QEnPxPO7b9BBf5MOq
	gSEgvJhMStVn6b28z7QhdpbBfk=; b=nQT3vk40ICL4NYgcUeqP/TQQtOOQJzizE
	VnY8q1yVOKKeFJQo+Svj5KrV0anattTUZyA7dz7N9q/S8tU2SJoPWcnMRfIXFIPu
	C9jrrK6LneHNddF8zyBmyAQT1hFG5GztYSqJvJStP9KaBeJgFvhN9F43f62YS/SL
	+xeJn/JClRQQ55xdLVj50Q8rozp0J6Ku3He95KvRYF11z50sZrZjhvTGvjqX59hx
	3R9Fkwwy16culkHU8DLDG8d295+bQgy4h6IbFcpRsv4EIYgNHYZ4lNSEg0gQj1pO
	cNKBvNG4D3gOj0XS40CE1lyRLyxjJ1X6cxuZy5+kRoG98ARZhGB/Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ugjh2p1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Dec 2024 14:23:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BUD1ASo027055;
	Mon, 30 Dec 2024 14:23:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43txc1nsqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Dec 2024 14:23:46 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BUENgmi20382018
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Dec 2024 14:23:43 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAAC420040;
	Mon, 30 Dec 2024 14:23:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD04720043;
	Mon, 30 Dec 2024 14:23:41 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.fios-router.home (unknown [9.61.82.190])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Dec 2024 14:23:41 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>
Subject: [PATCH] ima: limit the builtin 'tcb' dont_measure tmpfs policy rule
Date: Mon, 30 Dec 2024 09:23:33 -0500
Message-ID: <20241230142333.1309623-2-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241230142333.1309623-1-zohar@linux.ibm.com>
References: <20241230142333.1309623-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9kRdiHY09-Dpt08vdNAMbO3_eegzptAN
X-Proofpoint-GUID: 9kRdiHY09-Dpt08vdNAMbO3_eegzptAN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxlogscore=791 adultscore=0
 mlxscore=0 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412300121

With a custom policy similar to the builtin IMA 'tcb' policy [1], arch
specific policy, and a kexec boot command line measurement policy rule,
the kexec boot command line is not measured due to the dont_measure
tmpfs rule.

Limit the builtin 'tcb' dont_measure tmpfs policy rule to just the
"func=FILE_CHECK" hook.  Depending on the end users security threat
model, a custom policy might not even include this dont_measure tmpfs
rule.

Note: as a result of this policy rule change, other measurements might
also be included in the IMA-measurement list that previously weren't
included.

[1] https://ima-doc.readthedocs.io/en/latest/ima-policy.html#ima-tcb

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima_policy.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 21a8e54c383f..23bbe2c405f0 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -148,7 +148,8 @@ static struct ima_rule_entry dont_measure_rules[] __ro_after_init = {
 	{.action = DONT_MEASURE, .fsmagic = PROC_SUPER_MAGIC, .flags = IMA_FSMAGIC},
 	{.action = DONT_MEASURE, .fsmagic = SYSFS_MAGIC, .flags = IMA_FSMAGIC},
 	{.action = DONT_MEASURE, .fsmagic = DEBUGFS_MAGIC, .flags = IMA_FSMAGIC},
-	{.action = DONT_MEASURE, .fsmagic = TMPFS_MAGIC, .flags = IMA_FSMAGIC},
+	{.action = DONT_MEASURE, .fsmagic = TMPFS_MAGIC, .func = FILE_CHECK,
+	 .flags = IMA_FSMAGIC | IMA_FUNC},
 	{.action = DONT_MEASURE, .fsmagic = DEVPTS_SUPER_MAGIC, .flags = IMA_FSMAGIC},
 	{.action = DONT_MEASURE, .fsmagic = BINFMTFS_MAGIC, .flags = IMA_FSMAGIC},
 	{.action = DONT_MEASURE, .fsmagic = SECURITYFS_MAGIC, .flags = IMA_FSMAGIC},
-- 
2.47.1


