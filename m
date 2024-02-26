Return-Path: <linux-integrity+bounces-1472-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3DC867FB0
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Feb 2024 19:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16A90291191
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Feb 2024 18:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5136512EBF3;
	Mon, 26 Feb 2024 18:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZxW+zShu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA48712E1CC
	for <linux-integrity@vger.kernel.org>; Mon, 26 Feb 2024 18:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708971680; cv=none; b=c8KXfzO8rwFcl5CByfX+UoDAJupVC8araUa/mkwxiEUtB02+mUryKMQHzszY5TadRfbhjnqcHZ93i+OOalS7s8wfeMA/w58a1xK+6qWcXKhOQxrGycLoVYmInKVZeUyU20CgZTOUayHFdkoZbbqMtnAFinwlNXs9ThenY3uQy/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708971680; c=relaxed/simple;
	bh=zMGAVGweC5y/MoocSFCaaMw0eIfXKNEOcdoa4FZ/GyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rCsttyhD0J21pMNccmx48WGYgif9skbUuZM1SPpsTW9knpC0omnJ442wx/KjxC4wgL86adRx7Bo6jt5x5RKWUB8f5nWXiljHFZI9V8jdi5QS4QplRIYgZBnyRpUo79EXGGphQT8otOlasv97VfKyopz6Vug/+hTl5Iw1uDQgsRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZxW+zShu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41QHQt9w011013;
	Mon, 26 Feb 2024 18:21:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=2Lz1yA32rQxf186cgFelNmMiudGyBBMc9qhYFADfnxg=;
 b=ZxW+zShuEzyPfhPIT5ZmTavBKVWmtJ8m128WvcA+jcHzzSfvcCP4CEfjRSGz3PH30fyx
 BdE6wnW2EV1iVppHQlbHGLIBJYAg1O9ASCAmRJTPzzZs2tcEHptbCwN9tXqip9yIsrJn
 7WIc79JmwEcrTpMPZRKhSa9INpQnx5dCXFS3975KtKfKqWuFY7vEbAlU7ZgEHG5z/x9o
 dwQFPueYnKj1u4wrZ2gQByG9MAdoKEb+Zi9Ej2vwVfoEiM/1DaTD9VbLOV2LAB3SXur4
 sr0U5lSU8MDh+LTZh14CKGI97Y1Cs/cBIrx3fMcX46jGWzsJ9TibDI0VaEaku798sdIH RQ== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wgy24sakj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 18:21:08 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41QHTp0A024127;
	Mon, 26 Feb 2024 18:21:08 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wfw0k2jtk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 18:21:08 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41QIL4ZQ27263560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 18:21:06 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9DFC75805C;
	Mon, 26 Feb 2024 18:21:04 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1566D58060;
	Mon, 26 Feb 2024 18:21:04 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Feb 2024 18:21:03 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com, vt@altlinux.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 ima-evm-utils 1/7] tests: Skip pkcs11 test if no engine support in evmctl
Date: Mon, 26 Feb 2024 13:20:55 -0500
Message-ID: <20240226182101.25210-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240226182101.25210-1-stefanb@linux.ibm.com>
References: <20240226182101.25210-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FT6jf02aiOGBCISmUQVPok8ijjoJvRoY
X-Proofpoint-ORIG-GUID: FT6jf02aiOGBCISmUQVPok8ijjoJvRoY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 mlxscore=0 mlxlogscore=825 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402260139

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


