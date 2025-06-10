Return-Path: <linux-integrity+bounces-6403-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CE1AD44AE
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Jun 2025 23:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E71AE3A66BE
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Jun 2025 21:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96527283CAC;
	Tue, 10 Jun 2025 21:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OidWgXIS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02B5284B5F;
	Tue, 10 Jun 2025 21:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749590386; cv=none; b=AcZCiafOvSeAC35FJ6hk/ixdKsMQMV6mn7MdVWIR5uEoMg7qTR0+KVipPNKaV5T+HMxOuzv6Bfge5lSL8Vd9bpHWUOWdmWnCL14a5UKsy0VIedp5fZtCfo6fqMWORfuXppB1QoFhYFn+XVKpuiWvaCSoxiQ7EQ1uJplb/VTPjKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749590386; c=relaxed/simple;
	bh=WH8RQf6bUZn016PysqDM75R3nB09GwE/tGFYUasp/ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wc1p4/H4/zPU/nFmmHbbMHuYk1T4qJ+eK7ndukMA+imB2SX54cKuOT1t1kKd0qWwXyt/3y/WoURIfKrbzwPoH9uqRoRWJ/0Iel8Az5W0vL/gLM0raB33K+P3e4ioMlD/8JCn9J3fXLeWc6kLPIVDb0T7VKqxb+8xwx5GbIC81jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OidWgXIS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AGFtYw008154;
	Tue, 10 Jun 2025 21:19:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qwvXwgQXJIkG0QGSj
	4RsHe537NK9WFzkfnyk5v2o2AI=; b=OidWgXIS7o+r7++GArplKJ7P6K+PIM2sK
	UuRkz9EVD63L0Q9uM8JUfJ0SOJR1jJf3D8v0JF5ISc2t5NI54ymv/4hfk1lTm2ce
	G8kZIiPWcZfPoi87TMrxwpGwgv3fvnVCeZuanlTxUSLRwfDwSJzfeoInkCVQK591
	Wp4aqS/Je9WcAmyl//JJcm3DW/KJRHCLkr4PnCLG62FrYtT/0tn1yzbiTWVDcTSB
	MqBtFBdq1ZTOTs43JLDyLrf5/D0osdWup7J+65AXhAUZ0vaRUBhyw2XkW7HMTz3M
	Dbjh/7oOtRfZpAOPHJDz+NOFttTGCHWfMkdhcuWAOKpdEvNyIXbSg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474x4m60pu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 21:19:26 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55ALDuet019150;
	Tue, 10 Jun 2025 21:19:26 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474x4m60pq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 21:19:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55AJnWJr015186;
	Tue, 10 Jun 2025 21:19:25 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 474yrtcqbb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 21:19:25 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55ALJLFc29426324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 21:19:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC91D2004E;
	Tue, 10 Jun 2025 21:19:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DDA4520043;
	Tue, 10 Jun 2025 21:19:18 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com.com (unknown [9.39.26.197])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Jun 2025 21:19:18 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, naveen@kernel.org, ajd@linux.ibm.com,
        zohar@linux.ibm.com, nayna@linux.ibm.com, rnsastry@linux.ibm.com,
        msuchanek@suse.de, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] integrity/platform_certs: Allow loading of keys in the static key management mode
Date: Wed, 11 Jun 2025 02:49:07 +0530
Message-ID: <20250610211907.101384-4-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610211907.101384-1-ssrish@linux.ibm.com>
References: <20250610211907.101384-1-ssrish@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Y4X4sgeN c=1 sm=1 tr=0 ts=6848a15e cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=AtMIOgTZpS777Q0Lz8kA:9
X-Proofpoint-GUID: q4zdhWag_zhb8L3Jjsh8UOPm_I5jTCnc
X-Proofpoint-ORIG-GUID: WBQR6cdcqVUld135lsKeaseqYHLNtSzL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDE3NCBTYWx0ZWRfX7+ftWgf99YPY s2K6Uk+PpWPaMygwPvgeoCzzIXnkyurHiVVjmEwFS7moS/HSu4153k+AKN1GRNR8+tBQYtPwKrR jgs3l55QijI04p69N2XKzlfGTtjwSyCBxMbeiZtA+J+hfqvwM4vv+0+p9H4ow3VSZOL3K5Q6Iw2
 hbv+BE8O45e0I5rlk4/7/KSbaCcqcRUFv6U/4SiAoZute6BPojSi09czWmlNNks1nVVGLjeeHMa 5lAILmToOqBtA1b6kNEzwFnibV8lQVIu1z/5YqJY6pA1HVDm8Bndooc3PkBt5svotLN939pT8dZ OYSFkFuWm7xl46EtMx6/buRojMKfqF5KAqjVmH539//OVRGYzRxgFYDGIRyjLjd5Xxprg9BBgKt
 D03J3G9XZHhNzIEIECEJh5Pt5+hywxfCKVtrkXWVGoD9DIPHEWIXkE9i6QPU7ZDQCaIE2wTS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_10,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506100174

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


