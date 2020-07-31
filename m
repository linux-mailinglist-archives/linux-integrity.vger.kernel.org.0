Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4A7234ADD
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jul 2020 20:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387705AbgGaSYq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 31 Jul 2020 14:24:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39506 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387690AbgGaSYq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 31 Jul 2020 14:24:46 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06VIJND7023365;
        Fri, 31 Jul 2020 14:24:42 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32mp9ykj2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 14:24:42 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06VIJTpr023615;
        Fri, 31 Jul 2020 14:24:41 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32mp9ykj1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 14:24:41 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06VIGUSV019553;
        Fri, 31 Jul 2020 18:24:39 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 32gcqgqhqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 18:24:39 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06VIOb4931588750
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jul 2020 18:24:37 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2725252050;
        Fri, 31 Jul 2020 18:24:37 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.ibmuc.com (unknown [9.160.38.42])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id BCC465204E;
        Fri, 31 Jul 2020 18:24:35 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [ima-evm-utils: PATCH 5/5] ima-evm-utils: travis: openssl gost engine
Date:   Fri, 31 Jul 2020 14:24:08 -0400
Message-Id: <20200731182408.696931-6-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200731182408.696931-1-zohar@linux.ibm.com>
References: <20200731182408.696931-1-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-31_07:2020-07-31,2020-07-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 suspectscore=0 mlxlogscore=870 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007310135
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The openssl version on travis doesn't have gost openssl engine support.
Download from source, rebuild and install local version.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .travis.yml                  |  7 +++++++
 tests/install-gost-engine.sh | 10 ++++++++++
 2 files changed, 17 insertions(+)
 create mode 100755 tests/install-gost-engine.sh

diff --git a/.travis.yml b/.travis.yml
index 11a827c02f0a..f5fb2c1da448 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -15,6 +15,13 @@ matrix:
    include:
      - env: TSS=ibmtss
      - env: TSS=tpm2-tss
+
+before_install:
+   - if [ "${SSL}" = "openssl" ]; then
+        ./tests/install-gost-engine.sh;
+        openssl version;
+     fi
+
 install:
    - if [ "${TSS}" = "tpm2-tss" ]; then
            sudo apt-get install lcov pandoc autoconf-archive liburiparser-dev;
diff --git a/tests/install-gost-engine.sh b/tests/install-gost-engine.sh
new file mode 100755
index 000000000000..01bcf2c3bc21
--- /dev/null
+++ b/tests/install-gost-engine.sh
@@ -0,0 +1,10 @@
+#!/bin/sh
+
+openssl version
+
+git clone https://github.com/gost-engine/engine.git
+cd engine
+#cmake -DOPENSSL_INCLUDE_DIR=/usr/local/include/openssl -DOPENSSL_SSL_LIBRARY=/usr/local/lib64/libss.so -DOPENSSL_CRYPTO_LIBRARY=/usr/local/lib64/libcrypto.so -DOPENSSL_ENGINES_DIR=/usr/local/lib64/engines-1.1 .
+cmake .
+sudo make install
+cd ..
-- 
2.18.4

