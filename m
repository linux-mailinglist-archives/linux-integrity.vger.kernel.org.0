Return-Path: <linux-integrity+bounces-4494-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9919FE700
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Dec 2024 15:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4D991602CD
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Dec 2024 14:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27C79443;
	Mon, 30 Dec 2024 14:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WknDodpz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F5B25948F
	for <linux-integrity@vger.kernel.org>; Mon, 30 Dec 2024 14:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735568628; cv=none; b=IZn+sViSlevlpT3Kpr92BQ7GBhI3Vw2CZ/Q1/ABOHPTGarOoTGwLYkIacbr4jRaLH/UV5Y5aahIghAHHBXd7MRvEOBiQGTe7Qx1hRZxrUHBcrfo/XDkr+Y9QilaQSn+aj3jxLm02ULPch/bvb8XplChmKnxrKeTMimG2Aw8b2O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735568628; c=relaxed/simple;
	bh=inJobzTQdlsc5D2DvUnr2I79ZzQhycDRcLVmJDDe3MY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZW8IOPo2AnLfhqH5W8vRNqPLPTZYWJi4KT+TijoV2eZ/PqFasCeAztTmWDNvxEH2jzXVgqL12Dbf8J6tl8paLEGYQ0NEMmZaxQjG3Vmo43IQgfRfgMkHoaeoncd0utCAC52tF+DudxTQLMhPV2gk9S+FDabbuprSWiJx2RacT4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WknDodpz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BU3ruAf032470;
	Mon, 30 Dec 2024 14:23:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=31B5eui2smveTNDq1gwpvQwDaUb2dTbRPbBRNcclk
	Ag=; b=WknDodpz3xGLJh/HsYadjzOlkHheT/K45RKkSvH9m2Z6bweqz8zTaT1/W
	pvnqWQtlrFWC0E9zWyCrl6O15gDingEY+miPg13rkhNjtxXju5rjo9UdMA2mc1nY
	SA4kDQkvI/+UtH63goCPU+8Ya4XbS9YmV5ZdcBDGPam4jy1SQTjM5vtuMDE5D2T8
	jQKwZA3wBnYY+He5c6kBJ1TkzLi9btwHLuvPHecrxR4GRyeBnhcDquVzKifh2u2U
	x+NTFvuCdB9eVdPEQI84U2sEz5wzvkIVK0zFknkhIH/K6zoi/q/1HLxgzhVjotHy
	WRShZzOBbM4GzSXvpM+r59adFQGUQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43um0gt5c8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Dec 2024 14:23:44 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BUD3jeD026999;
	Mon, 30 Dec 2024 14:23:43 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43txc1nsqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Dec 2024 14:23:43 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BUENdJL28770972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Dec 2024 14:23:40 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C850920043;
	Mon, 30 Dec 2024 14:23:39 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F31420040;
	Mon, 30 Dec 2024 14:23:38 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.fios-router.home (unknown [9.61.82.190])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Dec 2024 14:23:38 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>
Subject: [PATCH] ima: ignore suffixed policy rule comments
Date: Mon, 30 Dec 2024 09:23:32 -0500
Message-ID: <20241230142333.1309623-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -UUj8Mrs3CEnqITeCy1zS4BQenqctIos
X-Proofpoint-GUID: -UUj8Mrs3CEnqITeCy1zS4BQenqctIos
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412300121

Lines beginning with '#' in the IMA policy are comments and are ignored.
Instead of placing the rule and comment on separate lines, allow the
comment to be suffixed to the IMA policy rule.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima_policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 23bbe2c405f0..128fab897930 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -1432,7 +1432,7 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 		int token;
 		unsigned long lnum;
 
-		if (result < 0)
+		if (result < 0 || *p == '#')  /* ignore suffixed comment */
 			break;
 		if ((*p == '\0') || (*p == ' ') || (*p == '\t'))
 			continue;
-- 
2.47.1


