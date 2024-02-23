Return-Path: <linux-integrity+bounces-1417-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BCA8615D5
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Feb 2024 16:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D77D1F25D49
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Feb 2024 15:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AD5823C1;
	Fri, 23 Feb 2024 15:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HEIqUB13"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493F67AE45
	for <linux-integrity@vger.kernel.org>; Fri, 23 Feb 2024 15:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708702246; cv=none; b=iaFZ0r4NdDzX8mDQ83DTSS2Rccjo14doPwwDa2H4QU7StVJl/rDZuOUh/Kl+4Z3kRUes8q6HY3BaBIJNHOVR0kZtChLKT63B8VUAzoycMQ0JT+COhTtOnMwjX0+XJlQyDW+Kh3G2l73kgXRj+oP58OLJzphR7FmPNXJXOjxJ9g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708702246; c=relaxed/simple;
	bh=cf/cBRO3MOghuEqppAEkRJmHJlstUpIHBdnLQr3Hp6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fqTnUmxkknDhuXELhUfnDdkDpBdBOq5wl0ftKVXu9RS7tYcTXB5//MqshRW6HxCiIfU83aHW+1UYC7voN0g+lXkDpfevAKM5QJxg44ZneZXB2z/OMet6hdJ53wANZjiy1aOaJSDBpzmE3sPgpr58vTutuyZDIfmrC01Q8oXAhWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HEIqUB13; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NF1Bsa032542;
	Fri, 23 Feb 2024 15:30:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=5MNMhJZHGplteWkKM4HxwlwvXzRK71bfItKVFb/cdRk=;
 b=HEIqUB13HYnuFQyM7PAv+yt6nvWx235UAFj1eAO+aiZzQOif8rWL2Msw6jOousn7q7oE
 5Xa8xKeYmCpxnGyZjxTjdyWA6Zu0yGTGSbDn/coLNyDTCvMey6Wy4CewMeJ1EFsiWy4G
 cV75uUbTc8R+yC4CCS4ULdNnDFwmpomL9EfO3pxx3Ij1i8/qrO7/JHzpF9OmAbF2BW8+
 a/sQzyqOEwarBxl8IaKVeahj66J9fP2GEp0LNjMnMzlFYSGy3FXmpD/1O/7rAnZMgVGI
 u7HNzzVg5Ns5fhAAXJplJoAz2WHsMbjeFlpOrYSOL0x529B0Gip2pOn3NmQCRFeV9Ilr GA== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wew4whh8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 15:30:28 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41ND5UNW013452;
	Fri, 23 Feb 2024 15:30:27 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb7h0xesm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 15:30:27 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NFUOT68782498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 15:30:26 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1EC2D58055;
	Fri, 23 Feb 2024 15:30:24 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9242558073;
	Fri, 23 Feb 2024 15:30:23 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Feb 2024 15:30:23 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com, vt@altlinux.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 ima-evm-utils 5/6] tests: Add pkcs11 test using provider
Date: Fri, 23 Feb 2024 10:30:13 -0500
Message-ID: <20240223153014.4048133-6-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240223153014.4048133-1-stefanb@linux.ibm.com>
References: <20240223153014.4048133-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3Uh8RoXhBqrd3zr8Iqye74JiQzwH20b_
X-Proofpoint-ORIG-GUID: 3Uh8RoXhBqrd3zr8Iqye74JiQzwH20b_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_01,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 spamscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=999 impostorscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402230112

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
index 1b6cf2a..ddda241 100755
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
+  __skip() { echo "pkcs11 test is skipped: could not setup softhsm"; return "$SKIP"; }
   expect_pass __skip
   expect_pass __skip
 fi
-- 
2.43.2


