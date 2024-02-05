Return-Path: <linux-integrity+bounces-1037-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B56849CCC
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Feb 2024 15:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80791284445
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Feb 2024 14:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617DD2CCB4;
	Mon,  5 Feb 2024 14:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G8G6mXPD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CC22CCDF
	for <linux-integrity@vger.kernel.org>; Mon,  5 Feb 2024 14:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707142545; cv=none; b=W7iOT6H5SDfem8lDxdYzI28j+WqlQpVr+RzM0StUJhuCVPZy9aV+Sazz0kGBlIMmiMzq2q8jkWWIvdIhWZvtHF1N5QD8Ep6HjlE/BnW24v+JwlP25TOwpcs5D4l3N8vdL8mHawGMICWBkz2NrMPEL1zQ1qsIbxfDJMDOYUgAd6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707142545; c=relaxed/simple;
	bh=4C46mIomaJFkL6P1EXY7AdxcwrB4TUibdUT5+dgvZNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WKIRH3QKiZbpFTlheYStqHzOqGhjhnv09Hp+PjUeakr9q0tdELSjg9olKvbk+FaAsuaaczSXQlG2+CLf1uZQFC+dskFTNLoWvqUgwmiTO6BZXtYYGqiCZQurG1MZNgOz03hU7B4sPTlwKmIc6n90jN+2Hx/Diqi6End6ZGWns38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G8G6mXPD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 415E36rl013478;
	Mon, 5 Feb 2024 14:15:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=CC+DqwjGYhg4BST+o71TOT6eTcupYMaDbmlrZ6/nlDI=;
 b=G8G6mXPDwYdHFSK70v8p4Gq8s1w4UCCUdm8umMIasb0giWGLn7yWC4gPGgl9gNvBVxlL
 NML1fK285cSG1bExsAX3+MjVkTVsk4SRdzuiC9F0J4ZrQUT9uf57/TNg+PE3nVXgsotA
 alBufsj2jedAOV5XXGfYSCFURynBf+DAO4TvdYoUUX6qrNT+AqPHwPI4nq8OBwVn6V8k
 gl7iqnoH3bdv5hZkzETDIKwxyV+k1EjltIg5E+dxyZL1dESQjZADWROsCX37yg9FGmBk
 kVxhUdekY9WFlWCaPalz7JuqEdDCPwEd9ZLe6gS/PUUW23ytuMyhH2P0Hv6DWbmWUr6a gw== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w313mrcy8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 14:15:34 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 415CxkV0019996;
	Mon, 5 Feb 2024 14:15:34 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w1ytss5p3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Feb 2024 14:15:34 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 415EFWSc14418586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Feb 2024 14:15:33 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB29B5805E;
	Mon,  5 Feb 2024 14:15:32 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E5EA58052;
	Mon,  5 Feb 2024 14:15:32 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Feb 2024 14:15:32 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v1 ima-evm-utils 5/6] tests: Add pkcs11 test using provider
Date: Mon,  5 Feb 2024 09:15:27 -0500
Message-ID: <20240205141528.3566511-6-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205141528.3566511-1-stefanb@linux.ibm.com>
References: <20240205141528.3566511-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zZQA_6QKQd54rEincSUrF9SHjTMj7kWJ
X-Proofpoint-ORIG-GUID: zZQA_6QKQd54rEincSUrF9SHjTMj7kWJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_08,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 mlxlogscore=909 bulkscore=0 phishscore=0
 mlxscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050108

Adjust the existing pkcs11 engine test cases to pass --engine pkcs11 via
an option (OPTS) to evmctl rather than using a global variable. Then
duplicate the pkcs11 engine tests and pass --provider pkcs11 to run the
same tests using OpenSSL provider. Also check whether evmctl was compiled
with provider support and if the pkcs11 provider is installed.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/functions.sh     |  1 -
 tests/sign_verify.test | 19 ++++++++++++++++---
 2 files changed, 16 insertions(+), 4 deletions(-)

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
index 1b6cf2a..0ba7bea 100755
--- a/tests/sign_verify.test
+++ b/tests/sign_verify.test
@@ -439,11 +439,24 @@ expect_fail \
 # Test signing with key described by pkcs11 URI
 _softhsm_setup "${WORKDIR}"
 if [ -n "${PKCS11_KEYURI}" ]; then
-  expect_pass check_sign FILE=pkcs11test TYPE=ima KEY="${PKCS11_KEYURI}" ALG=sha256 PREFIX=0x030204aabbccdd0100 OPTS=--keyid=aabbccdd
-  expect_pass check_sign FILE=pkcs11test TYPE=ima KEY="${PKCS11_KEYURI}" ALG=sha1   PREFIX=0x030202aabbccdd0100 OPTS=--keyid=aabbccdd
+  expect_pass check_sign FILE=pkcs11test TYPE=ima KEY="${PKCS11_KEYURI}" ALG=sha256 PREFIX=0x030204aabbccdd0100 OPTS="--keyid=aabbccdd --engine pkcs11"
+  expect_pass check_sign FILE=pkcs11test TYPE=ima KEY="${PKCS11_KEYURI}" ALG=sha1   PREFIX=0x030202aabbccdd0100 OPTS="--keyid=aabbccdd --engine pkcs11"
+
+  # provider may not be supported or pkcs11 provider not installed
+  if evmctl --help 2>/dev/null | grep -q provider && \
+     openssl list -providers -provider pkcs11 ; then
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
+  __skip() { echo "pkcs11 test is skipped: could not setup softhsm"; return "$SKIP"; }
   expect_pass __skip
   expect_pass __skip
 fi
-- 
2.43.0


