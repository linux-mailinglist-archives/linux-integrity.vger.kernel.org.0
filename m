Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0406530C4AE
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Feb 2021 17:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235967AbhBBP7M (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Feb 2021 10:59:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43508 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235885AbhBBP5Q (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Feb 2021 10:57:16 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 112FWMTN140921;
        Tue, 2 Feb 2021 10:56:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=LvSZqEh97YHxdRMnXnMDj20GwsfIEeRV+OxiRIvPD9s=;
 b=nDEdvipt7BIRPEFLD/kdYJTXCmNlSwWEjKdotiEtABq/OOvup8SfsBYhFQ/t/am/POgE
 JoOco455qqGWlr7TdzntDHGMLmzhqqOAUGrbRgsVv03Qaf2EhVW6wRcc7CCNG5WNanD1
 0EJMw5oW8952TU1rg2bATyDSnZJCTpFV1i0aWJFf/Dk/AHWNtjkydWqEXEy1KTgHFyMj
 qQ4jPLr1YCMYLNlo/uZiqO/mavB/IsXaocN93YkbLUyJeUN33bB7MJJrmvPIXqitqvf9
 Qn9vuTdDNbdpdj72CNM7C2Vn84C0ytgXAucwwwNXsVU6yDr59lI8rANEJJwZO9Ps3yeb gQ== 
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36f8sfjdut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Feb 2021 10:56:28 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 112FbtDv005459;
        Tue, 2 Feb 2021 15:56:28 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma02dal.us.ibm.com with ESMTP id 36f5t4t1d0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Feb 2021 15:56:28 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 112FuRG831392064
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Feb 2021 15:56:27 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 67D19AC065;
        Tue,  2 Feb 2021 15:56:27 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 517DAAC062;
        Tue,  2 Feb 2021 15:56:27 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  2 Feb 2021 15:56:27 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     zohar@linux.ibm.com, vt@altlinux.org,
        linux-integrity@vger.kernel.org
Cc:     Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 2/2] ima_evm_utils: Add testing with elliptic curves prime192v1 and 256v1
Date:   Tue,  2 Feb 2021 10:56:25 -0500
Message-Id: <20210202155625.3555769-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210202155625.3555769-1-stefanb@linux.ibm.com>
References: <20210202155625.3555769-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-02_07:2021-02-02,2021-02-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 spamscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102020104
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add test cases that test the signing and signature verification with the
elliptic curves prime192v1 and prime256v1, also known as NIST P192 and
P256. These curves will soon be supported by Linux. If OpenSSL cannot
generate prime192v1 keys, as is the case on Fedora, where this curve is
not supported, the respective tests will be skipped automatically.

The r and s integer components of the signature can have varying size.
Therefore we do the size checks for the entire signature with a regular
expression that accounts for the varying size. The most typical cases
are supported following hours of running the tests with varying keys.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/gen-keys.sh      | 20 ++++++++++++++++++++
 tests/sign_verify.test | 15 +++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/tests/gen-keys.sh b/tests/gen-keys.sh
index 407876b..46130cf 100755
--- a/tests/gen-keys.sh
+++ b/tests/gen-keys.sh
@@ -66,6 +66,26 @@ for m in 1024 2048; do
   fi
 done
 
+for curve in prime192v1 prime256v1; do
+  if [ "$1" = clean ] || [ "$1" = force ]; then
+    rm -f test-$curve.cer test-$curve.key test-$curve.pub
+  fi
+  if [ "$1" = clean ]; then
+    continue
+  fi
+  if [ ! -e test-$curve.key ]; then
+    log openssl req -verbose -new -nodes -utf8 -sha1 -days 10000 -batch -x509 \
+      -config test-ca.conf \
+      -newkey ec \
+      -pkeyopt ec_paramgen_curve:$curve \
+      -out test-$curve.cer -outform DER \
+      -keyout test-$curve.key
+    if [ -s test-$curve.key ]; then
+      log openssl pkey -in test-$curve.key -out test-$curve.pub -pubout
+    fi
+  fi
+done
+
 # EC-RDSA
 for m in \
   gost2012_256:A \
diff --git a/tests/sign_verify.test b/tests/sign_verify.test
index 2477b34..4f2caaa 100755
--- a/tests/sign_verify.test
+++ b/tests/sign_verify.test
@@ -367,6 +367,21 @@ sign_verify  rsa1024  sha384  0x030205:K:0080
 sign_verify  rsa1024  sha512  0x030206:K:0080
 sign_verify  rsa1024  rmd160  0x030203:K:0080
 
+# Test v2 signatures with ECDSA
+# Signature length is typically 0x34-0x38 bytes long, very rarely 0x33
+sign_verify  prime192v1 sha1   0x030202:K:003[345678]
+sign_verify  prime192v1 sha224 0x030207:K:003[345678]
+sign_verify  prime192v1 sha256 0x030204:K:003[345678]
+sign_verify  prime192v1 sha384 0x030205:K:003[345678]
+sign_verify  prime192v1 sha512 0x030206:K:003[345678]
+
+# Signature length is typically 0x44-0x48 bytes long, very rarely 0x43
+sign_verify  prime256v1 sha1   0x030202:K:004[345678]
+sign_verify  prime256v1 sha224 0x030207:K:004[345678]
+sign_verify  prime256v1 sha256 0x030204:K:004[345678]
+sign_verify  prime256v1 sha384 0x030205:K:004[345678]
+sign_verify  prime256v1 sha512 0x030206:K:004[345678]
+
 # Test v2 signatures with EC-RDSA
 _enable_gost_engine
 sign_verify  gost2012_256-A md_gost12_256 0x030212:K:0040
-- 
2.26.2

