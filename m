Return-Path: <linux-integrity+bounces-2846-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7664B8FF9AE
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jun 2024 03:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D7381C21CA8
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jun 2024 01:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77ECA14006;
	Fri,  7 Jun 2024 01:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iqGqqMcW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DDEDF53;
	Fri,  7 Jun 2024 01:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717724849; cv=none; b=DWYNM0WSrV6ZxTdKmERU8nUNSET22n1NHwVtAvpf0Anc0If1Lx/KmZiiDrTiSH61iiPAS3wNEvpATv5FCMjz+Hkz1+19FZryA23UnuUMm4beKVIM5NHhWFSjHam14KWfcnolaqlm8ovjrPFJEUpV1EJ2DaEUTYlktpYXg2nF92I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717724849; c=relaxed/simple;
	bh=PFdvUHfLWlHTzQWNtu/rgCvxUtZMFBHG1KbepupJ/jg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Kpl2PN3cNMI4/tfnn3/QkjlFS67aj28qJgOdwemKgPlgQyKJXDh/425IrY86sOQj0k19CyETL6D2EcHD++b7hM2YA/yGn3JcKz55BazxlXcjY1yu5vkS+5ZmI5V4XWXsgY8H9XpgBpuDS006xPMstnW/78b6F2NGsLQMYSVLA7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=iqGqqMcW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 456H5fj1030556;
	Fri, 7 Jun 2024 01:47:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WVdQWvlQNoYYuEe1/wV5CRvI2Y6oxvhs5eGwMoTSvDo=; b=iqGqqMcWmcjVKNuf
	53dP0jUWVgtdt0bIssbN+qIHCJBIGNxKBu7t9ZoPYYxsjMDWdxpge3wve5CzJ3uj
	VXYfwhFb90mDZC5DQv189Jz9EAWZTunPNeR0qKVbSQ5KF0BTltWKAShpA8l0pgd4
	jgyCGralhnQbJ103P9T2O74lhp+UTyqNiifxfi85VdS4qum2e5tTJ5mnMBSPlm9a
	Opolw9o7jpg5nV1PYPpDIbui9IerM44F5pMObx2XHZ8MJofexl2LCh5F3axjUfyk
	PXmLTm9zvXbuKRVlREdAc+WlZDJgNpQRBY/3i7wN17WNwbg1LZqox/BE8z6PZeQU
	VEGHqQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yk8tca53y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 01:47:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4571l8Nu004811
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Jun 2024 01:47:08 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 6 Jun 2024
 18:47:08 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 6 Jun 2024 18:47:06 -0700
Subject: [PATCH v3 1/2] KEYS: trusted: add missing MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240606-md-trusted-v3-1-42716f15e66e@quicinc.com>
References: <20240606-md-trusted-v3-0-42716f15e66e@quicinc.com>
In-Reply-To: <20240606-md-trusted-v3-0-42716f15e66e@quicinc.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen
	<jarkko@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>,
        David Howells
	<dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
        James Morris
	<jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
CC: <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5NnjIA4jWau4_3g4D5FQsoNUB0fHdWbN
X-Proofpoint-GUID: 5NnjIA4jWau4_3g4D5FQsoNUB0fHdWbN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_20,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406070012

kbuild reports:

WARNING: modpost: missing MODULE_DESCRIPTION() in security/keys/trusted-keys/trusted.o

Add the missing MODULE_DESCRIPTION() macro invocation.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 security/keys/trusted-keys/trusted_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
index 5113aeae5628..e2d9644efde1 100644
--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -395,4 +395,5 @@ static void __exit cleanup_trusted(void)
 late_initcall(init_trusted);
 module_exit(cleanup_trusted);
 
+MODULE_DESCRIPTION("Trusted Key type");
 MODULE_LICENSE("GPL");

-- 
2.42.0


