Return-Path: <linux-integrity+bounces-2703-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B985D8D42A4
	for <lists+linux-integrity@lfdr.de>; Thu, 30 May 2024 03:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 641881F228FF
	for <lists+linux-integrity@lfdr.de>; Thu, 30 May 2024 01:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814ABDDDA;
	Thu, 30 May 2024 01:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UvSQLrq0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E628128FA;
	Thu, 30 May 2024 01:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717030943; cv=none; b=V9OJi21rx9EeAui4akXUxDIKTbiOFtSxpbzcr4lukoa6wKwPkS9cNC/Or1qGpONNXPs+DUtrc7IuDqAfOYB3UXhH5hpt0nm2FEy79KpXmiMWhzp7lAcL9+ihVFmHvjV2omMJYJ1n777IvZVKtzI242LDgVoG9bUkBBMt7Q0eaB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717030943; c=relaxed/simple;
	bh=B8P4cw0Ri7T3pjh0FXJ7HxJGptxOJd5wZrnUVn9xPII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Gpi3zn2UC2Msg5Yrqjbs/7nTJIVseO0tQEUpldhB3PLufe2JVDg2YLYJSA+ifoXurx+Sw4JIG5KsFqvZKNPAVbFkCl5qBz5iedfp+F31CohZgJHw6vR6uaZcrS2CsKirN0TOzwbgn2f9hgyV6w6GzrACXYDHRKdcSikHwEA10fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UvSQLrq0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44TJ0aji006748;
	Thu, 30 May 2024 01:02:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=SqQCY9K/42kZL4O4lFD+1J
	zxmmzC9e7N8NRzPD0Ux6o=; b=UvSQLrq0HdfS+EnO/YSEptx3attwCTJno1NNw8
	G8vcTj5xGy+j/R8y8qkV5leKmnU1IzEeD2qTmoThMlKQlkWopCW7ls6wyUTc9Q0Q
	nRai1zmGGa0pOHezOw+aax4JSGup5Y5Gr9YKtY7jbQEPm/ffCouayBHEyZ3CkzBT
	pJYL6QjbSgbuloIrRPt3CaEOCrrrt+V+O40XF5DCVLclS9Sk4IwBkMDJd0pBrpp8
	58M3h6ozMeaY9c1oh65aZDZEYwiw5yyj29cdnLCFx8Ja9Xful9f3Mr9yNRa+tQNe
	W4s6wflw6AHw2lcsxjajHsyig9vzsBK5AsmHSigR/WHueZsA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ybadxasap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 01:02:04 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44U123t6004114
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 01:02:03 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 29 May
 2024 18:02:02 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Wed, 29 May 2024 18:02:01 -0700
Subject: [PATCH] KEYS: trusted: add MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240529-md-trusted-v1-1-56c9a0ae8e28@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAAjQV2YC/x3MQQrCQAxA0auUrA3UoAPjVcTFtEltwI6StKVQe
 nejy7f4fwcXU3G4NTuYrOr6roHzqYF+LPUpqBwGaunSXinjxDjb4rMwJkkDU6KcC0MEH5NBt//
 s/gh3xQU7K7Uff4uX1mXDqURrcBxfy/A7k3sAAAA=
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
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: y6llrNSiIkMm6FuLwUOu4CgG1z4r9vag
X-Proofpoint-GUID: y6llrNSiIkMm6FuLwUOu4CgG1z4r9vag
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_16,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=834 malwarescore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2405300006

Fix the 'make W=1' warning:
WARNING: modpost: missing MODULE_DESCRIPTION() in security/keys/trusted-keys/trusted.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 security/keys/trusted-keys/trusted_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
index 5113aeae5628..f4ab16d59663 100644
--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -395,4 +395,5 @@ static void __exit cleanup_trusted(void)
 late_initcall(init_trusted);
 module_exit(cleanup_trusted);
 
+MODULE_DESCRIPTION("Trusted Key support");
 MODULE_LICENSE("GPL");

---
base-commit: 4a4be1ad3a6efea16c56615f31117590fd881358
change-id: 20240529-md-trusted-6e6fd26299ad


