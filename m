Return-Path: <linux-integrity+bounces-6267-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C6CABF23A
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 12:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A0831BC0B17
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 10:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07E2262804;
	Wed, 21 May 2025 10:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ft9qK69F"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6432620FC;
	Wed, 21 May 2025 10:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747825115; cv=none; b=aHZTQzQWx7yhAIJnCB3/C80r5CG0Im6IRC91m8Nhmnf0i6VNdnrXNWgT6bDBYYGTE/NoEyDHqhFS45/+H7H4OkNoRtUC4/q8/yOAAD7Pwuw4L+/+0uhTFdVEP1A+2fMPXrqB4+aOQU0Nvc/PxR1pQdMQRplg5DCZmBlP2eu+Yw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747825115; c=relaxed/simple;
	bh=WH8RQf6bUZn016PysqDM75R3nB09GwE/tGFYUasp/ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oCE8d0d7iR/IgG8HHFejYh9KiDJUZ9RlM88khjAPAHV+JUMukLsY1COE0G4oBBd2WzZP6DEG01zOBpBKdLrMgKu2hiD8yBrBgfYczwCSpoo6Y77p5dPBEI2RAgrG/F9FJ6ATdNaeZgRYjbO5WuC0q/LRk+teuxvyjnNlpEaGWis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ft9qK69F; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54L8pRJE014308;
	Wed, 21 May 2025 10:58:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qwvXwgQXJIkG0QGSj
	4RsHe537NK9WFzkfnyk5v2o2AI=; b=Ft9qK69Fuso5iibjRn/GxJn8vISX62iBk
	fuS9F+p1k9VAxxn06YI2lW8xzYpu0tan/+A9O4fkuX2+Azc9p9/Wt8jXcc2cDgyt
	J0j0/mLHL7UNhcPyr168gLDkZjurfV/BJ/iOadPFqSM+AWJcsanRFH5htPnjmZ0N
	jfNbrZlbHYYGWmogsgbTtvook0WotKBhl/3mdVUdaU77Uq5Bj7rxMs4hssR2/n3u
	WfYoMJ31PguNwnO0zgMkdX2l4LOSB8lE6qif7McX62hPEB+7/RgKoRLyh+Z1qf7T
	snGO6WUdblhTe7tJl5dRtunAJHZ2Arf+E7Kw4vdOfLJoRWrhX4ySg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46sbph0j2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 10:58:16 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54LArXmJ023166;
	Wed, 21 May 2025 10:58:15 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46sbph0j2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 10:58:15 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54L9d7a5031996;
	Wed, 21 May 2025 10:58:14 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46rwmq3t9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 May 2025 10:58:14 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54LAwA6P54460686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 10:58:10 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5978520043;
	Wed, 21 May 2025 10:58:10 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDEDC20040;
	Wed, 21 May 2025 10:58:07 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.in.ibm.com (unknown [9.204.203.112])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 May 2025 10:58:07 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, naveen@kernel.org, ajd@linux.ibm.com,
        zohar@linux.ibm.com, nayna@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] integrity/platform_certs: Allow loading of keys in the static key management mode
Date: Wed, 21 May 2025 16:27:59 +0530
Message-ID: <20250521105759.8408-4-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521105759.8408-1-ssrish@linux.ibm.com>
References: <20250521105759.8408-1-ssrish@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDEwNSBTYWx0ZWRfX3GkG9UUHZUy9 livt8OcJDQIVDJMd/MNG3TiU2jLdlkx4oKtyR98xTsZPuEJJcnbUK+hUVW4bbIrAdauk6TrtVr2 TKfCYyqGw8Iw1JIaRf5Aj8vyhN3zu3y2skpU/1+yn+zYR0FkomTc/M3Xkw8ByX1mGUCVqLOAUYo
 +ZXyi8P0bO62OISNuYgyCBKaEQ43i3C4l9Ejad9HRFAs0oMYVRNTSSxlcQyce7DmmEs335017TK bOo4QOmmGu+tuarqxNm+qNIu2sotwo2gRjNBhOKio9+5pZb5U9/L7DSKkjIXJx/YKgFUPinUY/T 2VCQ4riJV0BvsXZT5S7CXKKyu3FpKpX6lXnMLmYpj+xV2HKCrfOMpfz6kLxKZltthkoo4x/xXSv
 t1WGhcCqofAQWpL5OiwgWw68sZue9gpwkq8x16QxLGEYyS9+Je9SY8n27fuT6F+5PQUb3zbP
X-Proofpoint-ORIG-GUID: ZEowoLJegkq3_yvN2FQDjrR4hOkpLnUy
X-Authority-Analysis: v=2.4 cv=L5kdQ/T8 c=1 sm=1 tr=0 ts=682db1c8 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=AtMIOgTZpS777Q0Lz8kA:9
X-Proofpoint-GUID: 2iT4jmr_S-xxe10ezReX3mPakJehOwXr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_03,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015
 mlxlogscore=999 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505210105

On PLPKS enabled PowerVM LPAR, there is no provision to load signed
third-party kernel modules when the key management mode is static. This
is because keys from secure boot secvars are only loaded when the key
management mode is dynamic.

Allow loading of the trustedcadb and moduledb keys even in the static
key management mode, where the secvar format string takes the form
"ibm,plpks-sb-v0".

Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Nayna Jain <nayna@linux.ibm.com>
Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
---
 security/integrity/platform_certs/load_powerpc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/integrity/platform_certs/load_powerpc.c b/security/integrity/platform_certs/load_powerpc.c
index c85febca3343..714c961a00f5 100644
--- a/security/integrity/platform_certs/load_powerpc.c
+++ b/security/integrity/platform_certs/load_powerpc.c
@@ -75,12 +75,13 @@ static int __init load_powerpc_certs(void)
 		return -ENODEV;
 
 	// Check for known secure boot implementations from OPAL or PLPKS
-	if (strcmp("ibm,edk2-compat-v1", buf) && strcmp("ibm,plpks-sb-v1", buf)) {
+	if (strcmp("ibm,edk2-compat-v1", buf) && strcmp("ibm,plpks-sb-v1", buf) &&
+	    strcmp("ibm,plpks-sb-v0", buf)) {
 		pr_err("Unsupported secvar implementation \"%s\", not loading certs\n", buf);
 		return -ENODEV;
 	}
 
-	if (strcmp("ibm,plpks-sb-v1", buf) == 0)
+	if (strcmp("ibm,plpks-sb-v1", buf) == 0 || strcmp("ibm,plpks-sb-v0", buf) == 0)
 		/* PLPKS authenticated variables ESL data is prefixed with 8 bytes of timestamp */
 		offset = 8;
 
-- 
2.47.1


