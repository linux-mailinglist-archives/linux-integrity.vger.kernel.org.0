Return-Path: <linux-integrity+bounces-1490-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A75286B477
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Feb 2024 17:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A80D81C20CAE
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Feb 2024 16:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787B115F32D;
	Wed, 28 Feb 2024 16:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MJlcuw5T"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8442415DBBB
	for <linux-integrity@vger.kernel.org>; Wed, 28 Feb 2024 16:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136873; cv=none; b=NO0mXNDvYJhQOwWq0r8wLFhEOlNge4iDoJAz6IodNFvpeakuc9l8dz4W7Hl3XkA1lqRRGna6K2mCEt3nFugEIEwnM9OIt7vJw7Lfw6qXMRBLg98PuaX66iX49saj1Kb80sJwvytkXHbT+3uixWZeKDokuxw1rutMAHb3bhr88TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136873; c=relaxed/simple;
	bh=AtRW7jklFDL1ukZ9woG1s51F9RTHnmjb+EklXIyhK60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gvFyTLVvrY6+H8joYNU7G2PqJChPBcSblHLVk73d0s+U+uNAvpgpT2k7lX1BWsphe+ZMSp33Yvc5Tqut84LO0tZQ2Nm7aFzR7AuOPq+RG+1mu1Vx5L8u1whLt2PLOlRB1MLzcAx9DPz0WfQHBU60r4waVSQNz6fiRntgreuXVZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MJlcuw5T; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41SF2Knk010867;
	Wed, 28 Feb 2024 16:14:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=TYF72XV/UoIgUxdKwiHCq1RqywtiOaUr2MpnslvQlTU=;
 b=MJlcuw5TkiZgXHLvj9XJEcAmsWLuOgLGfuH4WSVNlL5qyylclX6+0Dsp8TswkyoMaEqT
 qW7711ELNNBEcOYmuXWN8Upu7vlyokl1/vmdlQfbHHVKLXCHeb2A+tv4rDHFwqXt1k/a
 T7oZF+XlLRp2Zada/yubIhcSzfwZYHGpua4mGP2vIuDmwa9P5SwXPUAOkwSvnOQ9wHB5
 vvRy67IFgR5BHLqLbgC5tWn0p9YVo4n7JlaZEDJ7wsbA/ZVJOmFGxhePTBpisi1ieKsc
 dc/EpgF7aZBMIUvq8mKP6NmF2NwHjIJRtYAeamgc0dFtHZlM2omPGkz/vNCYMbMeQp2T 0A== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wj7492s1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 16:14:25 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41SFD6bD008170;
	Wed, 28 Feb 2024 16:14:23 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wfv9mf6e4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 16:14:23 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41SGEKHi9044872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Feb 2024 16:14:22 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FC765805E;
	Wed, 28 Feb 2024 16:14:20 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2633958055;
	Wed, 28 Feb 2024 16:14:20 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Feb 2024 16:14:20 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com, vt@altlinux.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 ima-evm-utils 6/7] tests: Add pkcs11 test using provider
Date: Wed, 28 Feb 2024 11:14:06 -0500
Message-ID: <20240228161408.284098-7-stefanb@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: EH6JoA_6z7G0VSPz1cnHtxwZ5boVFLAm
X-Proofpoint-GUID: EH6JoA_6z7G0VSPz1cnHtxwZ5boVFLAm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402280127

Adjust the existing pkcs11 engine test cases to pass --engine pkcs11 via
an option (OPTS) to evmctl rather than using a global variable. Then
duplicate the pkcs11 engine tests and pass --provider pkcs11 to run the
same tests using OpenSSL provider. Also check whether evmctl was compiled
with provider support and if the pkcs11 provider is installed.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/functions.sh     |  1 -
 tests/sign_verify.test | 20 +++++++++++++++++---
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/tests/functions.sh b/tests/functions.sh
index c39b894..962a436 100755
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -373,7 +373,6 @@ _softhsm_setup() {
     PKCS11_KEYURI=$(echo "$msg" | sed -n 's|^keyuri: \(.*\)|\1|p')
     export PKCS11_KEYURI
 
-    export EVMCTL_ENGINE="--engine pkcs11"
     export OPENSSL_ENGINE="-engine pkcs11"
     export OPENSSL_KEYFORM="-keyform engine"
   else
diff --git a/tests/sign_verify.test b/tests/sign_verify.test
index 16c7ada..f9522e0 100755
--- a/tests/sign_verify.test
+++ b/tests/sign_verify.test
@@ -447,10 +447,24 @@ if [ -n "${PKCS11_KEYURI}" ]; then
     expect_pass __skip
     expect_pass __skip
   fi
+
+  # provider may not be supported or pkcs11 provider not installed
+  if evmctl --help 2>/dev/null | grep -q provider && \
+     openssl list -providers -provider pkcs11 2>/dev/null; then
+    PKCS11_PRIVKEYURI=${PKCS11_KEYURI//type=public/type=private}
+
+    expect_pass check_sign FILE=pkcs11test TYPE=ima KEY="${PKCS11_PRIVKEYURI}" ALG=sha256 PREFIX=0x030204aabbccdd0100 OPTS="--keyid=aabbccdd --provider pkcs11"
+    expect_pass check_sign FILE=pkcs11test TYPE=ima KEY="${PKCS11_PRIVKEYURI}" ALG=sha1   PREFIX=0x030202aabbccdd0100 OPTS="--keyid=aabbccdd --provider pkcs11"
+  else
+    __skip() { echo "pkcs11 test with provider is skipped since no provider support or pkcs11 not installed"; return "$SKIP"; }
+    expect_pass __skip
+    expect_pass __skip
+  fi
 else
   # to have a constant number of tests, skip these two tests
-  __skip() { echo "pkcs11 test is skipped: could not setup softhsm"; return $SKIP; }
-  expect_pass __skip
-  expect_pass __skip
+  __skip() { echo "pkcs11 test is skipped: could not setup softhsm"; return "$SKIP"; }
+  for i in $(seq 0 3); do
+    expect_pass __skip
+  done
 fi
 _softhsm_teardown "${WORKDIR}"
-- 
2.43.2


