Return-Path: <linux-integrity+bounces-2718-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 322498D4E3B
	for <lists+linux-integrity@lfdr.de>; Thu, 30 May 2024 16:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3F681F22D8C
	for <lists+linux-integrity@lfdr.de>; Thu, 30 May 2024 14:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308AA17C22D;
	Thu, 30 May 2024 14:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bYNSued6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F28E186E41;
	Thu, 30 May 2024 14:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717080246; cv=none; b=EjFBp3Vpj/209KZtDprLoNBuURMcTXWSFwoCuZlg3L/l+mhUovKKvU7BoYJ2j9LUFOfyTggnJSaSpSy4EHUiVnZxIqAOYvGzHqqaZ9Xh3QJBUS5JJcC8qzG0kLX2+JIA4pr+IqSsD02FGLo2WxzLPOisy51erBs+OkIHmIU4FtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717080246; c=relaxed/simple;
	bh=tg25GOAnFuC79KlOusqk+YPD90SDgnC8fQbadRbSbLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=EMlgrgy71EuWqMdVFYsIY/ACXR7FlZCBiI5zEy6882clxHAAY9CTOktnmgcLexYmsFrMsWSdl4bSQq8hKU30O5Imn0HvrZbcbRyDVf73qDSFHa5mCfbdZGmUtnJlktOkMmtW4Pnvj2mJVUKqHgGMRfNQDMG/GP5hn9AhHBP4M54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bYNSued6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44U7c8uY011441;
	Thu, 30 May 2024 14:43:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=XLdpCL5+8Hsj0t8FHTcGuy
	JPg9m5dUgCcHm4X27HLRo=; b=bYNSued6tO57Yi1nNNy94V/kJw/PkCGNV5Eg7k
	XJzLKjjcWruazj+j8RiWUe0bme+w1HX0TaunhDoSY6sxUzcqmvUQUvfC8+FqbYBu
	w6baoUU9hRX9RVsH1k9YRXodp+9El3G9iUxKMWu7thSjSryg3ozeArmc7hx0rfRM
	msA9lxtDLHrug/OLBpiUYzavnTFiKBwgzuBAzvUFPka2VZBnOmwEADx/2Sx8CJLu
	ODdw3uI4Kmx8YpkT5GNClmKILUL4Q/aX5a+2fvfSsfMEC9QJ6Fu6Tme14jAhbfxZ
	VY8Cm88QaDcwzSHYqb0IEak3TZO2DLtV8rc7mNaHXI4SaqgA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yb9yjcdf1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 14:43:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44UEhrs3026550
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 May 2024 14:43:53 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 30 May
 2024 07:43:52 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 30 May 2024 07:43:43 -0700
Subject: [PATCH v2] KEYS: trusted: add missing MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240530-md-trusted-v2-1-151f0c7be272@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAJ6QWGYC/22NQQ6CMBBFr0Jm7RiYSENdeQ/DorSDTCJFWiAYw
 t0trF2+5L/3N4gchCPcsw0CLxJl8AnokoHtjH8xiksMlNMtL0lj73AKc5zYoWLVOlKktXGQhE/
 gVtYz9qwTNyYyNsF42x2Jt/h5xd4kNxzzTuI0hO95vRSH9PdlKbDAUlltcsMVU/UYZ7Hi7dUOP
 dT7vv8Ak4jAjsUAAAA=
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
X-Proofpoint-GUID: BuoUwixUMpD6WNZG7a24fG8fQUScbc2O
X-Proofpoint-ORIG-GUID: BuoUwixUMpD6WNZG7a24fG8fQUScbc2O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_09,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405300111

kbuild reports:

WARNING: modpost: missing MODULE_DESCRIPTION() in security/keys/trusted-keys/trusted.o

Add the missing MODULE_DESCRIPTION() macro invocation.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
Changes in v2:
- reword commit text per Jarkko's guidance
- Link to v1: https://lore.kernel.org/r/20240529-md-trusted-v1-1-56c9a0ae8e28@quicinc.com
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


