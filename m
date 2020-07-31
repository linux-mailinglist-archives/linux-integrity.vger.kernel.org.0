Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23458234ADC
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jul 2020 20:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387791AbgGaSYo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 31 Jul 2020 14:24:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4158 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387705AbgGaSYo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 31 Jul 2020 14:24:44 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06VIJ8Lo055075;
        Fri, 31 Jul 2020 14:24:40 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32mq62j64n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 14:24:40 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06VIJEKO055300;
        Fri, 31 Jul 2020 14:24:40 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32mq62j641-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 14:24:39 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06VIKe03028933;
        Fri, 31 Jul 2020 18:24:37 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 32gcq0vn8k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 18:24:37 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06VIOZIF11207102
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jul 2020 18:24:35 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6456E52052;
        Fri, 31 Jul 2020 18:24:35 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.ibmuc.com (unknown [9.160.38.42])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 3095352051;
        Fri, 31 Jul 2020 18:24:34 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [ima-evm-utils: PATCH 4/5] ima-evm-utils: travis: support tpm2-tss
Date:   Fri, 31 Jul 2020 14:24:07 -0400
Message-Id: <20200731182408.696931-5-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200731182408.696931-1-zohar@linux.ibm.com>
References: <20200731182408.696931-1-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-31_07:2020-07-31,2020-07-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007310135
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Running the "boot_aggregate" test without a physical TPM, requires
installing and initializing a software TPM.  For now, use the same
method of initializing the TPM, based on the IBM tss, for both the
IBM and Intel's tss.

Build both the IBM and INTEL's tss.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .travis.yml               | 17 ++++++++++++++++-
 tests/install-tpm2-tss.sh | 19 +++++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)
 create mode 100755 tests/install-tpm2-tss.sh

diff --git a/.travis.yml b/.travis.yml
index 0a3476572f74..11a827c02f0a 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -11,12 +11,27 @@ addons:
    - xsltproc
    - docbook-xsl
    - docbook-xml
+matrix:
+   include:
+     - env: TSS=ibmtss
+     - env: TSS=tpm2-tss
 install:
+   - if [ "${TSS}" = "tpm2-tss" ]; then
+           sudo apt-get install lcov pandoc autoconf-archive liburiparser-dev;
+           sudo apt-get install libdbus-1-dev libglib2.0-dev dbus-x11 libgcrypt-dev;
+           sudo apt-get install libssl-dev doxygen libjson-c-dev;
+           sudo apt-get install libini-config-dev libltdl-dev;
+           sudo apt-get install uuid-dev libcurl4-openssl-dev;
+          ./tests/install-tpm2-tss.sh;
+     fi
    - ./tests/install-swtpm.sh
    - ./tests/install-tss.sh
+
 script:
+   - export LD_LIBRARY_PATH=/usr/local/lib64:/usr/local/lib;
+   - export PATH=$PATH:/usr/local/bin;
    - autoreconf -i && ./configure && make -j$(nproc) && sudo make install && VERBOSE=1 make check;
 
    - tail -3 tests/ima_hash.log;
    - tail -3 tests/sign_verify.log;
-   - tail -3 tests/boot_aggregate.log;
+   - tail -20 tests/boot_aggregate.log;
diff --git a/tests/install-tpm2-tss.sh b/tests/install-tpm2-tss.sh
new file mode 100755
index 000000000000..7a71b57a8729
--- /dev/null
+++ b/tests/install-tpm2-tss.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+
+git clone https://github.com/tpm2-software/tpm2-tss.git
+cd tpm2-tss
+./bootstrap
+./configure
+make -j$(nproc)
+sudo make install
+sudo ldconfig
+cd ..
+rm -rf tpm2-tss
+
+git clone https://github.com/tpm2-software/tpm2-tools.git
+cd tpm2-tools
+./bootstrap && ./configure --prefix=/usr
+make -j$(nproc)
+sudo make install
+cd ..
+rm -rf tpm2-tools
-- 
2.18.4

