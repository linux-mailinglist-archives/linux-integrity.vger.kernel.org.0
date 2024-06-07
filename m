Return-Path: <linux-integrity+bounces-2847-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 621F08FF9B3
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jun 2024 03:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 067D6282A7B
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jun 2024 01:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9EFDF53;
	Fri,  7 Jun 2024 01:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bMkIfNvO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E83218AED;
	Fri,  7 Jun 2024 01:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717724852; cv=none; b=oD9rTNFYIEw57RbMm5qGLI2Tvb1dZH+bYkFXMJJZShgNbMIaN6/mkegpx8PvqeOIx5KZXxcM/bJtjZ1VXnQ1/ogYBjat+9diI5cs9YjmY7B/Tpr6ZwP+YfqaEwqNFevu2aXmsM2TrAGxMFqenZslrrOrsWbhpVQ/Q9REeqMJ7VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717724852; c=relaxed/simple;
	bh=lljZuqYukZyEmYSGBhhaDVoSPK7v+6xUi8qoX4lNp8g=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=hZJxpbV78GnXCo1Da5n2ob0GRg/4MbyeeP1V7Iso1le7dOG6ITzDrzKiTBryP9m7erx1+CwRxb87mOOve7VdiiaaC1VFpJQinVlnYyvRttpVyEaXc40KvcN2X/Nqy/IT67ylfIN6Laf4SIEyyn1/Hd8hjFRoDYQMZhHQbQKYWKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bMkIfNvO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 456BJ7Ov020522;
	Fri, 7 Jun 2024 01:47:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=UTKUmy30z8UWj0ZDFijMos
	Pvljucz2hlVutidAK6+0U=; b=bMkIfNvOCaW2HADI4jndManDrevGYTtLkEj2tS
	tdRXl3/59rsLsuOoB0QiB88K0ibUaKa+Rex5tH4YwF2Z0SOVT2Zn6T7EuHi+PYwt
	fFzFpH3pNsbKiHvoAhViQxSP/pPK/bmzGNALQqNoc+fLGrFXt9b96XaIbet39wdr
	ExUTDeX4u9yjKFlLSu0m2v7b0fDdVfaUaBq40am0ffzPcpDe99+6EZbUArkOaKk2
	abfpgk8vz6zCOXNSItAe8nm1kwxbAIj85aLKDSpmF0HqdXazYM84aO+akiT5Brbi
	S3Q0ZIC64V51ivtMlzommiq2Eoetuyf0mz66ME/emi5YT0tQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yk3h2ts8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 01:47:11 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4571l8TS004804
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Jun 2024 01:47:08 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 6 Jun 2024
 18:47:08 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Subject: [PATCH v3 0/2] KEYS: add missing MODULE_DESCRIPTION() macros
Date: Thu, 6 Jun 2024 18:47:05 -0700
Message-ID: <20240606-md-trusted-v3-0-42716f15e66e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJlmYmYC/23NQQ6CMBQE0KuYrq1pP1KoK+9hXJT2Iz+Roi0QD
 OHuFlaSuJxk3szMIgbCyC6HmQUcKVLnU8iOB2Yb4x/IyaXMQMBZ5KB563gfhtij4wpV7UCB1sa
 xBF4Ba5q2sds95cpE5FUw3jbrxJP8MPHWJBvWekOx78Jnux7liv6+jJJLniurjTBYIpTX90CWv
 D3ZrmXrzwg/OBM7DAnLXNbCFhVCAXu8LMsXb+HbOgIBAAA=
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
X-Proofpoint-GUID: GIZ9O3KAj5Leok73_YWWC4KTgh_hF58J
X-Proofpoint-ORIG-GUID: GIZ9O3KAj5Leok73_YWWC4KTgh_hF58J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_20,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 spamscore=0 mlxlogscore=806 adultscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406070012


---
Changes in v3:
- Per Jarkko's feedback, this is now a series since a 2nd patch was
  added to address the missing MODULE_DESCRIPTION() in the
  encrypted-keys module (even though this is currently built-in, even
  with an allmodconfig, at least for x86)
- Also per Jarkko's feedback, the MODULE_DESCRIPTION() in the trusted
  module was updated.
- Link to v2: https://lore.kernel.org/r/20240530-md-trusted-v2-1-151f0c7be272@quicinc.com

Changes in v2:
- reword commit text per Jarkko's guidance
- Link to v1: https://lore.kernel.org/r/20240529-md-trusted-v1-1-56c9a0ae8e28@quicinc.com

---
Jeff Johnson (2):
      KEYS: trusted: add missing MODULE_DESCRIPTION()
      KEYS: encrypted: add missing MODULE_DESCRIPTION()

 security/keys/encrypted-keys/encrypted.c  | 1 +
 security/keys/trusted-keys/trusted_core.c | 1 +
 2 files changed, 2 insertions(+)
---
base-commit: 4a4be1ad3a6efea16c56615f31117590fd881358
change-id: 20240529-md-trusted-6e6fd26299ad


