Return-Path: <linux-integrity+bounces-1475-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F08867FB3
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Feb 2024 19:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D6B11F27359
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Feb 2024 18:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223BD12E1FF;
	Mon, 26 Feb 2024 18:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PTdrfDwg"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A44812EBC8
	for <linux-integrity@vger.kernel.org>; Mon, 26 Feb 2024 18:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708971682; cv=none; b=S3bAbvaFsbOxDH+yp4wSAWU10aLWpi/aJxuVm8VQvllvHXKPD6qzO96U/3BV0HeYurkKcoRhJ+n3lHPtO8zYGtjc6tslq92lzyRBgp6jbtMGkJOK+RmY998HHSdYHd5Mbziby+PkO01yfJ0IdjvkkvOskTW4PYbTTlhgHJcJ5do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708971682; c=relaxed/simple;
	bh=AtRW7jklFDL1ukZ9woG1s51F9RTHnmjb+EklXIyhK60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CTt/cWY1RTcn4Sp59ZCiUbDv7QCaRREDXbeE7/20IhefsmwDBwQJBogQ2WMJzQ1trPE6mhSMvtSrGDmezDbhc+h0ZMvwCuXv/dVCDTrOeXF4IgHCLmRNEgMlbbIxIIeRPcRErzRO1J9FTUQYux0eYgZ6aNpLEkPhndkYGMMWKng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PTdrfDwg; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41QGvRcn014978;
	Mon, 26 Feb 2024 18:21:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=TYF72XV/UoIgUxdKwiHCq1RqywtiOaUr2MpnslvQlTU=;
 b=PTdrfDwg67jspThQmZ891600r7WxVl3LA3c69fsjyO9s74QDcvPQXI4mnl1fDSANFwtD
 Bm3/hxn1rBDDq9VGnccAkOXDTbqNiYMnVV0n4+oFaykHETV53AMgLu8HwAmCHutJbhLY
 SdBguGBWX/puTb0nQ16mL9Js4ti3M9pgbU/baBa/IVeSHg5nCXyM7xkFwDDbfxhxqPhd
 FEOwtW7o16fX0b6wF1n5ZwPZMhxeS4lv6WURXiKwMcPGJTkac441z4YJr5wcO7CKiwkZ
 jTLgZrz557arpIiRJNYs4DBQRGY8YGNq/H+DG89HXfPaC88APgGldXjmLqz4K4IAVFzD cQ== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wgwh7ku0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 18:21:12 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41QGBYgo012324;
	Mon, 26 Feb 2024 18:21:11 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wfwg22e7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 18:21:11 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41QIL8ej16646810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Feb 2024 18:21:10 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B28958061;
	Mon, 26 Feb 2024 18:21:08 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A74F15805B;
	Mon, 26 Feb 2024 18:21:07 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Feb 2024 18:21:07 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com, vt@altlinux.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 ima-evm-utils 6/7] tests: Add pkcs11 test using provider
Date: Mon, 26 Feb 2024 13:21:00 -0500
Message-ID: <20240226182101.25210-7-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: ic8bt2SdCbfg66j8PH8UoZG_z_SN4kLl
X-Proofpoint-ORIG-GUID: ic8bt2SdCbfg66j8PH8UoZG_z_SN4kLl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0 mlxscore=0
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2402260139

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


