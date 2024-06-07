Return-Path: <linux-integrity+bounces-2845-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF53A8FF9AA
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jun 2024 03:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 327401F241E7
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jun 2024 01:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDF810A19;
	Fri,  7 Jun 2024 01:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WOdn/kkw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEF64C76;
	Fri,  7 Jun 2024 01:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717724848; cv=none; b=WJWMAqbNpWriiTBO0yVxczYY4pJCYcdQrrveZ26+IZxE01MnkVz24Mpk8ZLB8ApqMwIwfvJFjQMAMCSsWZoXwOiBtRoNDuvoslVvrKxS4+kCsXPk7Zr36d1dl9m2OCi4T3CwqsfgfO9YUc5OsmYFMk5KLfhtGKhZJ/5xJ+eM1Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717724848; c=relaxed/simple;
	bh=vEQGruV7vNomyN1/16lhy+/kKw+pGXABrWp8XaCgJ3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=GV/4RgnpcmhQNOFEe0S4/x0s9xC9mATC2FCDfyiYlpamZGbMGmzXAV7zDz89POop3UD0Kn5QNbAJuvavbPmC4p0XHgNiDrjakyHbmkxkMYZ47uaC2A+aLtecYRsB2o6S21c4sAfX6FjVdrgsH9iqwZy8dFUB5C64zgjYK+/lg90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WOdn/kkw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 456LprOG009857;
	Fri, 7 Jun 2024 01:47:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	m8ztMMV0XfBkGZrE/9oEW6+dpAh7sNaqLenUpmWCesk=; b=WOdn/kkw+i/Fe4MJ
	0oeav343TfBBklbLWxUwoM895bMIY+9T5dfHkCnkOlqWQfc6eM0TqBDCIUsSOZBj
	Zdv3QrUca+RKyMnswy2k6RyLPekOhobpRDbrnie8gzOTHKKBDvhEMXdXGa/u6p6D
	7P6bWge/WCTNLU+OWAoNdwfURMMxEl+74HfQQDuSKPb347KuQm8SUt0W1mXOlrNI
	BwBI6/F83wGC20u7q3aAyVxkTbj6EHuMaFYkEQspwm8Soir3FV/2pBpfprghjK0E
	yvytFsvk91jLJknS1Pf9YuZ1B2U8e+kfK16Yl0VWfxFEIEuDQcX/rIt5J9AwvhmY
	AEC1wQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yjh3tw0fs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 01:47:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4571l9s0004936
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Jun 2024 01:47:09 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 6 Jun 2024
 18:47:08 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Thu, 6 Jun 2024 18:47:07 -0700
Subject: [PATCH v3 2/2] KEYS: encrypted: add missing MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240606-md-trusted-v3-2-42716f15e66e@quicinc.com>
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
X-Proofpoint-GUID: k9lB1TD4tAzTUchkfJHb6CFCyNOZt2ym
X-Proofpoint-ORIG-GUID: k9lB1TD4tAzTUchkfJHb6CFCyNOZt2ym
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_20,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406070012

During kbuild, with W=1, modpost will warn when a module doesn't have
a MODULE_DESCRIPTION(). The encrypted-keys module does not have a
MODULE_DESCRIPTION().  But currently, even with an allmodconfig
configuration, this module is built-in, and as a result, kbuild does
not currently warn about the missing MODULE_DESCRIPTION().

However, just in case it is built as a module in the future, add the
missing MODULE_DESCRIPTION() macro invocation.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 security/keys/encrypted-keys/encrypted.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
index 8af2136069d2..831cb84fd75a 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -1040,4 +1040,5 @@ static void __exit cleanup_encrypted(void)
 late_initcall(init_encrypted);
 module_exit(cleanup_encrypted);
 
+MODULE_DESCRIPTION("Encrypted key type");
 MODULE_LICENSE("GPL");

-- 
2.42.0


