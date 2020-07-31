Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FE4234AD9
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jul 2020 20:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387790AbgGaSYm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 31 Jul 2020 14:24:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16120 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387758AbgGaSYl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 31 Jul 2020 14:24:41 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06VIJGwV172567;
        Fri, 31 Jul 2020 14:24:38 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32mpqxavvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 14:24:37 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06VIK3w6176105;
        Fri, 31 Jul 2020 14:24:37 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32mpqxavv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 14:24:37 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06VIJuar031164;
        Fri, 31 Jul 2020 18:24:35 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 32gcpx7j6w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 18:24:35 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06VIOWQi36831274
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jul 2020 18:24:33 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E119F52051;
        Fri, 31 Jul 2020 18:24:32 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.ibmuc.com (unknown [9.160.38.42])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id BE47E5204F;
        Fri, 31 Jul 2020 18:24:31 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [ima-evm-utils: PATCH 2/5] ima-evm-utils: travis: download, compile, and install a swTPM
Date:   Fri, 31 Jul 2020 14:24:05 -0400
Message-Id: <20200731182408.696931-3-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200731182408.696931-1-zohar@linux.ibm.com>
References: <20200731182408.696931-1-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-31_07:2020-07-31,2020-07-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007310135
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Verifying the "boot_aggregate" requires reading the TPM PCRs for each of
the TPM banks.  In test environments without a physical TPM, a software
TPM may be used.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .travis.yml            |  2 ++
 tests/install-swtpm.sh | 11 +++++++++++
 2 files changed, 13 insertions(+)
 create mode 100755 tests/install-swtpm.sh

diff --git a/.travis.yml b/.travis.yml
index bf287898221e..fa2a37625d52 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -11,6 +11,8 @@ addons:
    - xsltproc
    - docbook-xsl
    - docbook-xml
+install:
+   - ./tests/install-swtpm.sh
 script:
    - autoreconf -i && ./configure && make -j$(nproc) && sudo make install && VERBOSE=1 make check TESTS="ima_hash.test sign_verify.test";
 
diff --git a/tests/install-swtpm.sh b/tests/install-swtpm.sh
new file mode 100755
index 000000000000..071e9c9ae442
--- /dev/null
+++ b/tests/install-swtpm.sh
@@ -0,0 +1,11 @@
+#!/bin/sh
+
+set -ex
+wget https://sourceforge.net/projects/ibmswtpm2/files/ibmtpm1332.tar.gz/download
+mkdir ibmtpm1332
+cd ibmtpm1332
+tar -xvzf ../download
+cd src
+make -j$(nproc)
+sudo cp tpm_server /usr/local/bin/
+cd ../..
-- 
2.18.4

