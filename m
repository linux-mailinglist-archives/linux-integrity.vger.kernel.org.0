Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A61234ADB
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jul 2020 20:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387716AbgGaSYn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 31 Jul 2020 14:24:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46832 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387705AbgGaSYn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 31 Jul 2020 14:24:43 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06VILxXr082527;
        Fri, 31 Jul 2020 14:24:38 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32mr22rpx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 14:24:38 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06VIM0IK082573;
        Fri, 31 Jul 2020 14:24:38 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32mr22rpwm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 14:24:38 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06VIM1j1028318;
        Fri, 31 Jul 2020 18:24:36 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 32jgvptnhc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 18:24:36 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06VIN8Ot57999770
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jul 2020 18:23:08 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED3545204E;
        Fri, 31 Jul 2020 18:24:33 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.ibmuc.com (unknown [9.160.38.42])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 1992A52051;
        Fri, 31 Jul 2020 18:24:32 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [ima-evm-utils: PATCH 3/5] ima-evm-utils: travis: dependency on TSS for initializing software TPM
Date:   Fri, 31 Jul 2020 14:24:06 -0400
Message-Id: <20200731182408.696931-4-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200731182408.696931-1-zohar@linux.ibm.com>
References: <20200731182408.696931-1-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-31_06:2020-07-31,2020-07-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=982
 suspectscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007310133
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Verifying the "boot_aggregate" requires reading the TPM PCRs for each of
the TPM banks.  In test environments without a physical TPM, a software
TPM may be used, but requires initializing the TPM PCRs.  By walking and
replaying the TPM event log, a software TPM may be properly initialized.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .travis.yml          | 4 +++-
 tests/install-tss.sh | 8 ++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)
 create mode 100755 tests/install-tss.sh

diff --git a/.travis.yml b/.travis.yml
index fa2a37625d52..0a3476572f74 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -13,8 +13,10 @@ addons:
    - docbook-xml
 install:
    - ./tests/install-swtpm.sh
+   - ./tests/install-tss.sh
 script:
-   - autoreconf -i && ./configure && make -j$(nproc) && sudo make install && VERBOSE=1 make check TESTS="ima_hash.test sign_verify.test";
+   - autoreconf -i && ./configure && make -j$(nproc) && sudo make install && VERBOSE=1 make check;
 
    - tail -3 tests/ima_hash.log;
    - tail -3 tests/sign_verify.log;
+   - tail -3 tests/boot_aggregate.log;
diff --git a/tests/install-tss.sh b/tests/install-tss.sh
new file mode 100755
index 000000000000..c9c179eee6a8
--- /dev/null
+++ b/tests/install-tss.sh
@@ -0,0 +1,8 @@
+#!/bin/sh
+
+set -ex
+git clone https://git.code.sf.net/p/ibmtpm20tss/tss
+cd tss
+autoreconf -i && ./configure --disable-tpm-1.2 --disable-hwtpm && make -j$(nproc) && sudo make install
+cd ..
+rm -rf tss
-- 
2.18.4

