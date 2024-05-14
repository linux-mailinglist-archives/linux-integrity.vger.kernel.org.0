Return-Path: <linux-integrity+bounces-2406-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B578C5B00
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 20:23:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F7EBB217F4
	for <lists+linux-integrity@lfdr.de>; Tue, 14 May 2024 18:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FC81802C6;
	Tue, 14 May 2024 18:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CuvKBWlj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AB31802CC
	for <linux-integrity@vger.kernel.org>; Tue, 14 May 2024 18:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715710999; cv=none; b=vDjF1VzTkQPFQocKOICGP5Ui+SLQ22aF5mUT4LmJtqbuFiH/yquJqfz5xNw0Ony0fD/E5h20JwMhL02/Wn7mctEyYJS8W+hwtRmDcumPKVTydUKYBFg8Q2CezQcXImJnhI7usH4T/ra3CptDJuspb0EJSkSYxVSjaP42mhLQRYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715710999; c=relaxed/simple;
	bh=Y+E6CGRaJuBbPOCYksR1GFIEdOILRx4c5aYH1LeD8zc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d5Ztxr6QiTMtOJyWsjE4AI+epEH5I7QxoyyC+btaLb+0/oesjqGJGhUFV770f1K7Fqq+WTOGe5AwACb1+taSUQgRQFE8jA/oTA3YVF5Cl9JFRBj021GE26fx1MC42Si0LN7EKyLlaKhvGCTDb1as2yXaImqvyzCB39wu1PYnWsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CuvKBWlj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44EFr6G3000899;
	Tue, 14 May 2024 18:23:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=zjTgQ131t5umNnTwIvbJrh8GwgHndcVmkpzxLHgVfMY=;
 b=CuvKBWljYlh2yuHdZ4yqWuvb6/5K10bKZbe4eYOIoNbywd1+nwY/Zv9wgz/Uila5EyRc
 RWjWX9u4W9ZdHBpvUVp/D/LltBKGescN7QIe4/vFqLqfJYiozsoPc/lrQY4b0edDBb9c
 JjvDBFsQxmGOEdUiAFpgT94VvMR67nuMiwWZRd3/J9S/+SR3496sdUflGJ6XrdR/eKNs
 mbnfZJCfkKdp7IVeGCWOL+AaR2kCtDJh1eVBERTzwsgJc87MyqnoQizG3wY5bw2xviOg
 PmWeM5mmMt3qo+u0/NDUGvb74aJF3FYAvBucqbtghE5fNjWSyzZEDuPHaQoamOdlFmio fw== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4ayv8cpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 18:23:08 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44EFBmp2002257;
	Tue, 14 May 2024 18:23:07 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y2m0p6xkj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 May 2024 18:23:07 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44EIN3Sq42139952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 May 2024 18:23:06 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D47145805E;
	Tue, 14 May 2024 18:23:03 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B54D5805A;
	Tue, 14 May 2024 18:23:03 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 May 2024 18:23:03 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils PATCH 2/2] tests: Use EVMCTL_ENGINE to set engine or provider for test case
Date: Tue, 14 May 2024 14:23:00 -0400
Message-ID: <20240514182300.92440-3-stefanb@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: mauV-liEFZGMH4SG1fAhKam95EdmxQUG
X-Proofpoint-GUID: mauV-liEFZGMH4SG1fAhKam95EdmxQUG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-14_10,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405140130

Use EVMCTL_ENGINE to pass --provider or --engine to evmctl. Before, when
gost tests were running, EVMCTL_ENGINE was still set to '--engine gost'
and was used on the command line for evmctl by a pkcs11 tests as well.

Note: Ubuntu 22.04 (Noble) currently seems to have an issue when softhsm is
used via --engine pkcs11. In this case ENGINE_finish() in evmctl causes a
crash/segfault. However, when pkcs11-provider is installed and used by
evcmtl then this issue does not occur. Therefore, we cannot currently run
tests on Ubuntu 22.04 that use softhsm via pkcs11 engine. Users should
install and use the pkcs11-provider instead and not force usage of the
engine by passing '--engine pkcs11' to the command line.

Fixes: ffde173250 ("tests: Add pkcs11 test using provider")
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/sign_verify.test | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/sign_verify.test b/tests/sign_verify.test
index f9522e0..4e7945a 100755
--- a/tests/sign_verify.test
+++ b/tests/sign_verify.test
@@ -440,8 +440,8 @@ expect_fail \
 _softhsm_setup "${WORKDIR}"
 if [ -n "${PKCS11_KEYURI}" ]; then
   if evmctl --help 2>/dev/null | grep -q engine; then
-    expect_pass check_sign FILE=pkcs11test TYPE=ima KEY="${PKCS11_KEYURI}" ALG=sha256 PREFIX=0x030204aabbccdd0100 OPTS="--keyid=aabbccdd --engine pkcs11"
-    expect_pass check_sign FILE=pkcs11test TYPE=ima KEY="${PKCS11_KEYURI}" ALG=sha1   PREFIX=0x030202aabbccdd0100 OPTS="--keyid=aabbccdd --engine pkcs11"
+    expect_pass check_sign FILE=pkcs11test TYPE=ima KEY="${PKCS11_KEYURI}" ALG=sha256 PREFIX=0x030204aabbccdd0100 OPTS="--keyid=aabbccdd" EVMCTL_ENGINE="--engine pkcs11"
+    expect_pass check_sign FILE=pkcs11test TYPE=ima KEY="${PKCS11_KEYURI}" ALG=sha1   PREFIX=0x030202aabbccdd0100 OPTS="--keyid=aabbccdd" EVMCTL_ENGINE="--engine pkcs11"
   else
     __skip() { echo "pkcs11 test with engine is skipped since there is no engine support"; return "$SKIP"; }
     expect_pass __skip
@@ -453,8 +453,8 @@ if [ -n "${PKCS11_KEYURI}" ]; then
      openssl list -providers -provider pkcs11 2>/dev/null; then
     PKCS11_PRIVKEYURI=${PKCS11_KEYURI//type=public/type=private}
 
-    expect_pass check_sign FILE=pkcs11test TYPE=ima KEY="${PKCS11_PRIVKEYURI}" ALG=sha256 PREFIX=0x030204aabbccdd0100 OPTS="--keyid=aabbccdd --provider pkcs11"
-    expect_pass check_sign FILE=pkcs11test TYPE=ima KEY="${PKCS11_PRIVKEYURI}" ALG=sha1   PREFIX=0x030202aabbccdd0100 OPTS="--keyid=aabbccdd --provider pkcs11"
+    expect_pass check_sign FILE=pkcs11test TYPE=ima KEY="${PKCS11_PRIVKEYURI}" ALG=sha256 PREFIX=0x030204aabbccdd0100 OPTS="--keyid=aabbccdd" EVMCTL_ENGINE="--provider pkcs11"
+    expect_pass check_sign FILE=pkcs11test TYPE=ima KEY="${PKCS11_PRIVKEYURI}" ALG=sha1   PREFIX=0x030202aabbccdd0100 OPTS="--keyid=aabbccdd" EVMCTL_ENGINE="--provider pkcs11"
   else
     __skip() { echo "pkcs11 test with provider is skipped since no provider support or pkcs11 not installed"; return "$SKIP"; }
     expect_pass __skip
-- 
2.45.0


