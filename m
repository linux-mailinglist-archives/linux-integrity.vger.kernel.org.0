Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D70D23BA60
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Aug 2020 14:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgHDMc0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Aug 2020 08:32:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26090 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726536AbgHDMb5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Aug 2020 08:31:57 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 074C25s9069019;
        Tue, 4 Aug 2020 08:05:38 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32q6aa9wbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Aug 2020 08:05:38 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 074C3Sai074331;
        Tue, 4 Aug 2020 08:05:37 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32q6aa9wag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Aug 2020 08:05:37 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 074BusCO011346;
        Tue, 4 Aug 2020 12:05:36 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 32mynh39n4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Aug 2020 12:05:36 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 074C5XHE24838438
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Aug 2020 12:05:34 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C836BA4065;
        Tue,  4 Aug 2020 12:05:33 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A5E0A4062;
        Tue,  4 Aug 2020 12:05:33 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.7.87])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  4 Aug 2020 12:05:32 +0000 (GMT)
Message-ID: <70b421b26c7073dcc7d9b8f210ba2900ecf2b8d3.camel@linux.ibm.com>
Subject: Re: [ima-evm-utils: PATCH v1 5/5] ima-evm-utils: travis: openssl
 gost engine
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>,
        Bruno Meneguele <bmeneg@redhat.com>
Date:   Tue, 04 Aug 2020 08:05:31 -0400
In-Reply-To: <20200731182408.696931-6-zohar@linux.ibm.com>
References: <20200731182408.696931-1-zohar@linux.ibm.com>
         <20200731182408.696931-6-zohar@linux.ibm.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-04_03:2020-08-03,2020-08-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 adultscore=0 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=974 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008040086
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The openssl version might not have gost openssl engine support.
Download from source, rebuild and install local version.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .travis.yml                  | 10 ++++++++++
 tests/install-gost-engine.sh | 10 ++++++++++
 2 files changed, 20 insertions(+)
 create mode 100755 tests/install-gost-engine.sh

diff --git a/.travis.yml b/.travis.yml
index 11a827c02f0a..887f6bbea9b9 100644
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
@@ -30,6 +37,9 @@ install:
 script:
    - export LD_LIBRARY_PATH=/usr/local/lib64:/usr/local/lib;
    - export PATH=$PATH:/usr/local/bin;
+   - if [ "${SSL}" = "openssl" ]; then
+        export OPENSSL_ENGINES="$OPENSSL_ENGINES:$PWD/engines/bin";
+     fi
    - autoreconf -i && ./configure && make -j$(nproc) && sudo make install && VERBOSE=1 make check;
 
    - tail -3 tests/ima_hash.log;
diff --git a/tests/install-gost-engine.sh b/tests/install-gost-engine.sh
new file mode 100755
index 000000000000..2563aa4953f7
--- /dev/null
+++ b/tests/install-gost-engine.sh
@@ -0,0 +1,10 @@
+#!/bin/sh
+
+openssl version
+
+git clone --branch openssl_1_1_0 https://github.com/gost-engine/engine.git
+cd engine
+cmake .
+cmake --build .
+# note: install target is missing, later set the environment variable.
+cd ..
-- 
2.18.4


