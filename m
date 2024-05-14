Return-Path: <linux-integrity+bounces-2407-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911AE8C5B01
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 20:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEA66B2183A
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 18:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F375E1802CC;
	Tue, 14 May 2024 18:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UEcth81K"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746F91E487
	for <linux-integrity@vger.kernel.org>; Tue, 14 May 2024 18:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715710999; cv=none; b=T1RW77GEbaRB4AgDkaUmPTaKrXKDGMfIgejXYPxpp112zxyOIO26XmnE5kaOhWrxMtLYK+Mw2aOe3H9rGoI7qM7WeEoqdAZtxsm5z+0wekgnBYBYepN1aggQqNy2HLHSJPw85kirpe07S2aRX+pfaonuaWffBjOgV9PtWR1JnME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715710999; c=relaxed/simple;
	bh=WxtBOBX4ox7lKdW3HAHc3dbiWXTmZhs0SoavfJNLdsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YvNL1J2uDHHsM0HKEJpVZzZw0bCyb9S85iRgrYSfRAXEGwfOqNLAEyr7qpVr5Drs9syeESAqDA3XWe5eHg7ca3XQeApuadwV0RA9LYtA48hR61VywXbn/sH1scI5q5XxwbDUPRwRLn5wa5uum/IVyYHacM7Iv/K5GtmGPDkj5NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UEcth81K; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44EHvWu2000854;
	Tue, 14 May 2024 18:23:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=tuckmyljxvprMirqAf2PupBbauQldPLsj0z4AMTtLlA=;
 b=UEcth81KUj/oTZVa8w3sZwzHD95srD1MNAjLZ6HpUQCSIQt6klW8eQerUk/+vnoPTtix
 1mq3lP0r0gxzhWXZ2n++GWZCxbxcChoED2FjYLN04A2A+qmrrxZJufGE/RpCXTaBkJ3L
 NS9920Y08Ew8OImsfGXaEKjDesTy6laM85oFjHAuDwKAyWNcgOQ/Fb3iSfyGv1Wg3VjJ
 +LPppZ/p2EsA8w+0kxzjq8Z1XNvRIW/Y+cHmpW4uO+qyTz54CKCfWqdOK8Sdkd85RuxO
 c1tOwELNKwAai5D2s/o1GDsrVxxeUQGKuGiqzcBe+/4eqpzW2YqtDAiaqI/EP6ly7FXU Kg== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4ct9g1k5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 18:23:07 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44EG0Ykm006769;
	Tue, 14 May 2024 18:23:06 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y2mgmeueu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 18:23:06 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44EIN3uA27525870
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 18:23:05 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7544A58052;
	Tue, 14 May 2024 18:23:03 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22F4A5805A;
	Tue, 14 May 2024 18:23:03 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 May 2024 18:23:03 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH 1/2] evmctl: Replace OSS_PROVIDER_load with OSSL_PROVIDER_try_load (Ubuntu)
Date: Tue, 14 May 2024 14:22:59 -0400
Message-ID: <20240514182300.92440-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514182300.92440-1-stefanb@linux.ibm.com>
References: <20240514182300.92440-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TXEsS0y2OauLIgHzAlo7bSiLSyja2CQe
X-Proofpoint-ORIG-GUID: TXEsS0y2OauLIgHzAlo7bSiLSyja2CQe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_10,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 mlxscore=0 mlxlogscore=907 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405140130

To avoid the following type of issue replace OSSL_PROVIDER_load with
OSSL_PROVIDER_try_load():

+ evmctl  --engine gost ima_sign --keyid=aabbccdd --provider pkcs11 \
  --sigfile --hashalgo sha256 \
  --key pkcs11:model=SoftHSM%20v2;manufacturer=SoftHSM%20project;... \
  --xattr-user pkcs11test

evmctl ima_sign failed with (1)
  EVP_DigestInit() failed
  openssl: error:0308010C:digital envelope routines::unsupported
  openssl: error:03000086:digital envelope routines::initialization error

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/evmctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index ffe2fc9..3ebda6f 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -3049,7 +3049,7 @@ static char *get_password(void)
 #if CONFIG_IMA_EVM_PROVIDER
 static OSSL_PROVIDER *setup_provider(const char *name)
 {
-	OSSL_PROVIDER *p = OSSL_PROVIDER_load(NULL, name);
+	OSSL_PROVIDER *p = OSSL_PROVIDER_try_load(NULL, name, 1);
 
 	if (!p) {
 		log_err("provider %s isn't available\n", optarg);
-- 
2.45.0


