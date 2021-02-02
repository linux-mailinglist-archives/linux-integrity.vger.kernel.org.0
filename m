Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F3630B4DD
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Feb 2021 02:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbhBBBvo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Feb 2021 20:51:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3432 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229527AbhBBBvm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Feb 2021 20:51:42 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 1121XKb3096458;
        Mon, 1 Feb 2021 20:51:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=UcLBDpQL5uSyvwUfsyuIIJPekr63rF+3HUTqdOc/ac0=;
 b=CsbDxLl6Gi2SWaZ8cGMHn5aCnRgsTaDnJ6Tgb2fVj1Xx/mbVaZ+RHnvb+0a+YFWnZeK9
 HF+iNW3D/fjjK31pk2+m5DHm1k+/BWX0dMTbL3K8mQ5TcHQk7stHZme4PnRe+CLgoaZS
 BiCPaPD0GVc/1uI0Bma62IOkraW6/Tun747M2PMgtdV4c575J0DPHs1VkQEfkxZ//vm5
 Ii+kWUv9hKBszGk6FT4xRsdruLlTe0tA+0K3e54M4b+QwCszYt/qXm1rvS7MRgGt51d1
 8R2xqXWNcxxm7GR1sY1jvuHD8STF0d9m5zBoERKTbQ1Niycc1iSXk+a7yEcWlneLAA8V jA== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36evxsgkq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Feb 2021 20:51:00 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1121m1oU014868;
        Tue, 2 Feb 2021 01:50:59 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma04dal.us.ibm.com with ESMTP id 36er4cjavn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Feb 2021 01:50:59 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1121ovRU25297348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Feb 2021 01:50:57 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 900C96A051;
        Tue,  2 Feb 2021 01:50:57 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46F6B6A04F;
        Tue,  2 Feb 2021 01:50:57 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue,  2 Feb 2021 01:50:57 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     zohar@linux.ibm.com, vt@altlinux.org,
        linux-integrity@vger.kernel.org
Cc:     Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH] ima_evm_utils: Add testing with elliptic curves prime192v1 and 256v1
Date:   Mon,  1 Feb 2021 20:50:55 -0500
Message-Id: <20210202015055.1506308-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-01_14:2021-01-29,2021-02-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 bulkscore=0 clxscore=1015 mlxscore=0 malwarescore=0 phishscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102020007
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add test cases that test the signing and signature verification with the
elliptic curves prime192v1 and prime256v1, also known as NIST P192 and
P256. These curves will soon be supported by Linux. If OpenSSL cannot
generate prime192v1 keys, as is the case on Fedora, where this curve is
not supported, the respective tests will be skipped automatically.

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
index 288e133..b4fffda 100755
--- a/tests/sign_verify.test
+++ b/tests/sign_verify.test
@@ -366,6 +366,21 @@ sign_verify  rsa1024  sha384  0x030205:K:0080
 sign_verify  rsa1024  sha512  0x030206:K:0080
 sign_verify  rsa1024  rmd160  0x030203:K:0080
 
+# Test v2 signatures with ECDSA
+# Signature length can be 0x36-0x38 bytes long
+sign_verify  prime192v1 sha1   0x030202:K:003[678]
+sign_verify  prime192v1 sha224 0x030207:K:003[678]
+sign_verify  prime192v1 sha256 0x030204:K:003[678]
+sign_verify  prime192v1 sha384 0x030205:K:003[678]
+sign_verify  prime192v1 sha512 0x030206:K:003[678]
+
+# Signature length can be 0x46-0x48 bytes long
+sign_verify  prime256v1 sha1   0x030202:K:004[678]
+sign_verify  prime256v1 sha224 0x030207:K:004[678]
+sign_verify  prime256v1 sha256 0x030204:K:004[678]
+sign_verify  prime256v1 sha384 0x030205:K:004[678]
+sign_verify  prime256v1 sha512 0x030206:K:004[678]
+
 # Test v2 signatures with EC-RDSA
 _enable_gost_engine
 sign_verify  gost2012_256-A md_gost12_256 0x030212:K:0040
-- 
2.26.2

