Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11950234ADA
	for <lists+linux-integrity@lfdr.de>; Fri, 31 Jul 2020 20:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387758AbgGaSYm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 31 Jul 2020 14:24:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16080 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387716AbgGaSYl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 31 Jul 2020 14:24:41 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06VIJJoo042268;
        Fri, 31 Jul 2020 14:24:38 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32mndxwg55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 14:24:37 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06VIL6ma046985;
        Fri, 31 Jul 2020 14:24:37 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32mndxwg4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 14:24:37 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06VIKCeJ031693;
        Fri, 31 Jul 2020 18:24:35 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 32gcpx7j6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 31 Jul 2020 18:24:34 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06VIOVAC29819208
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 31 Jul 2020 18:24:31 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64A7B52050;
        Fri, 31 Jul 2020 18:24:31 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.ibmuc.com (unknown [9.160.38.42])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 9E0E05204E;
        Fri, 31 Jul 2020 18:24:29 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Bruno Meneguele <bmeneg@redhat.com>,
        Mimi Zohar <zoahr@linux.ibm.com>
Subject: [ima-evm-utils: PATCH 1/5] ima-evm-utils: travis: define travis.yml
Date:   Fri, 31 Jul 2020 14:24:04 -0400
Message-Id: <20200731182408.696931-2-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200731182408.696931-1-zohar@linux.ibm.com>
References: <20200731182408.696931-1-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-31_07:2020-07-31,2020-07-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 mlxscore=0 bulkscore=0 suspectscore=1 phishscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007310135
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Initial travis.yml file without the "boot_aggregate" test.

Signed-off-by: Mimi Zohar <zoahr@linux.ibm.com>
---
 .travis.yml | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 .travis.yml

diff --git a/.travis.yml b/.travis.yml
new file mode 100644
index 000000000000..bf287898221e
--- /dev/null
+++ b/.travis.yml
@@ -0,0 +1,18 @@
+language: C
+addons:
+ apt:
+  packages:
+   - libkeyutils-dev
+   - libattr1-dev
+   - attr
+   - openssl
+   - libssl-dev
+   - asciidoc
+   - xsltproc
+   - docbook-xsl
+   - docbook-xml
+script:
+   - autoreconf -i && ./configure && make -j$(nproc) && sudo make install && VERBOSE=1 make check TESTS="ima_hash.test sign_verify.test";
+
+   - tail -3 tests/ima_hash.log;
+   - tail -3 tests/sign_verify.log;
-- 
2.18.4

