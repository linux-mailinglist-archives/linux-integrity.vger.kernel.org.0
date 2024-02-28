Return-Path: <linux-integrity+bounces-1489-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD6586B476
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Feb 2024 17:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 048E52875A7
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Feb 2024 16:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955F415F314;
	Wed, 28 Feb 2024 16:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oNeRGEPM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95993FB89
	for <linux-integrity@vger.kernel.org>; Wed, 28 Feb 2024 16:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136872; cv=none; b=qanAEixWI9qPW6p/V1UgDwKMPCY2Qo2GULp4FsSQ2M11qw19dr5NbK7yaRZga++8RelDVwFN8foksPh/5f+we2/NcwwYHtc+RmO2/CL0RvN4YJ06QVzUJCicZPQrJel7qtKnQGGN6xhRCJFwtjrTjVKG5if1FiaG779mFMfqvuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136872; c=relaxed/simple;
	bh=zMGAVGweC5y/MoocSFCaaMw0eIfXKNEOcdoa4FZ/GyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NLxx0b/cX1oWXR20vXj5cv4+ICr0z+byizOjcKvJcN6fEwFhKlXvM7wIDbLiEtHBuv5tIj4z+tGq/t4OtcFyRv/w+mI6qydnBlFnfp/+3Ol/YDH2WG21TOg3qA8nPxSfnER37r/ZYblKrLru00hlsJZW3LXXj2zDKpGBoqQriwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oNeRGEPM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41SGCNZw029549;
	Wed, 28 Feb 2024 16:14:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=2Lz1yA32rQxf186cgFelNmMiudGyBBMc9qhYFADfnxg=;
 b=oNeRGEPMYM9BF8yZ73I6wXTfl/NywxSY22hhZ+ZhOx4XPP5rWSkRtWfUaCWG+y37frYR
 057YKhmzHxxykbLV9exwEK8VJlVoISQAUtQUwjV+LqvHjR9ZfV3RcVF+IJ8aKx9bhCWh
 RnqaLESc+5A9iMAAIoQ+FAuz1wpccCdntcpqrqdpz7DOIFpS3oBw5tsSSWg0IDh7O3lU
 2W6bHIkmV07/0RFKZwavSoBb5vkS/GV+BllZPw6urcQmuKgN2M5gJbTT+PA4noxNFwya
 C4x8T2SQSirXsivEiqcmIeTclVBlKXbmbFcFnHZuujRM9ylAaQ5T3TNXNuAQInZbH8OQ 5A== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wj850r2jr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 16:14:22 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41SET1es008189;
	Wed, 28 Feb 2024 16:14:21 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfv9mf6dx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 16:14:21 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41SGEIsX15336086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 16:14:20 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 232F45805E;
	Wed, 28 Feb 2024 16:14:18 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD4BB58060;
	Wed, 28 Feb 2024 16:14:17 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Feb 2024 16:14:17 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com, vt@altlinux.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 ima-evm-utils 1/7] tests: Skip pkcs11 test if no engine support in evmctl
Date: Wed, 28 Feb 2024 11:14:01 -0500
Message-ID: <20240228161408.284098-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228161408.284098-1-stefanb@linux.ibm.com>
References: <20240228161408.284098-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Iy_EtdfYz2dAyx7XmuJKRMxGfB_d-sk5
X-Proofpoint-GUID: Iy_EtdfYz2dAyx7XmuJKRMxGfB_d-sk5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 adultscore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=831 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402280127

Check the evmctl help screen for engine support and skip the pkcs11
test if no engine support is compiled into evmctl.

Fixes: c1635add22af ("Disable use of OpenSSL "engine" support")
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/sign_verify.test | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tests/sign_verify.test b/tests/sign_verify.test
index 1b6cf2a..16c7ada 100755
--- a/tests/sign_verify.test
+++ b/tests/sign_verify.test
@@ -439,8 +439,14 @@ expect_fail \
 # Test signing with key described by pkcs11 URI
 _softhsm_setup "${WORKDIR}"
 if [ -n "${PKCS11_KEYURI}" ]; then
-  expect_pass check_sign FILE=pkcs11test TYPE=ima KEY="${PKCS11_KEYURI}" ALG=sha256 PREFIX=0x030204aabbccdd0100 OPTS=--keyid=aabbccdd
-  expect_pass check_sign FILE=pkcs11test TYPE=ima KEY="${PKCS11_KEYURI}" ALG=sha1   PREFIX=0x030202aabbccdd0100 OPTS=--keyid=aabbccdd
+  if evmctl --help 2>/dev/null | grep -q engine; then
+    expect_pass check_sign FILE=pkcs11test TYPE=ima KEY="${PKCS11_KEYURI}" ALG=sha256 PREFIX=0x030204aabbccdd0100 OPTS="--keyid=aabbccdd --engine pkcs11"
+    expect_pass check_sign FILE=pkcs11test TYPE=ima KEY="${PKCS11_KEYURI}" ALG=sha1   PREFIX=0x030202aabbccdd0100 OPTS="--keyid=aabbccdd --engine pkcs11"
+  else
+    __skip() { echo "pkcs11 test with engine is skipped since there is no engine support"; return "$SKIP"; }
+    expect_pass __skip
+    expect_pass __skip
+  fi
 else
   # to have a constant number of tests, skip these two tests
   __skip() { echo "pkcs11 test is skipped: could not setup softhsm"; return $SKIP; }
-- 
2.43.2


