Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3D96187BD
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Nov 2022 19:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiKCSjh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Nov 2022 14:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiKCSjg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Nov 2022 14:39:36 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3945100
        for <linux-integrity@vger.kernel.org>; Thu,  3 Nov 2022 11:39:35 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3ILfYW017946;
        Thu, 3 Nov 2022 18:39:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=CiYsHNxdCzAvIhN7ZJXAN7xP8VTBAjAlo9sSpWve3MA=;
 b=eVveBsK5eX4QfEyuoD3WCRB7jKCdXaXC0dA4dKbWadH7uq2eDQJlbZFLk3+34nHPk3Pb
 hqlITdCnAXbVOmvlMVT80bEzWFUhDdv94bRva550HEuMp3idQPZoj9zy9vHbi3CegOjZ
 XV+rD2f3rIhcz56v+acuVhVcd0SICf7jAJvq9hx9yOUWpKFCJVjAxy9OKqw2a8itGoly
 Sb66dYjAV/FusG19YweHeYRg9fQ0Po4YeRbNus2fxV7czDMwATKB7DljnxAlcg69Iqwx
 btH00pCI1tsVZ4IEA4YVkOy2aSBaGkvHa6/b55D8+iFMrS9/zEwjGv2Fr3R8PHGQm0cN 5g== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kmgtsngxf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 18:39:32 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A3IadUB005345;
        Thu, 3 Nov 2022 18:39:30 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3kgut9974y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 18:39:30 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A3IXsA545351256
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Nov 2022 18:33:54 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 368C142041;
        Thu,  3 Nov 2022 18:39:27 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21FF44203F;
        Thu,  3 Nov 2022 18:39:26 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.20.100])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  3 Nov 2022 18:39:26 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v5 14/17] Base sm2/sm3 test on openssl version installed
Date:   Thu,  3 Nov 2022 14:39:01 -0400
Message-Id: <20221103183904.103562-15-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221103183904.103562-1-zohar@linux.ibm.com>
References: <20221103183904.103562-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: x-i918gknYJdY_HYVE-jGZ47cnqqyh4e
X-Proofpoint-GUID: x-i918gknYJdY_HYVE-jGZ47cnqqyh4e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 mlxscore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030125
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Since the distros are now shipping with OpenSSL 3, no need
to build it.  Limit the sm2/sm3 test to OpenSSL 3.

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 tests/sign_verify.test | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tests/sign_verify.test b/tests/sign_verify.test
index 3e9548e1aeb7..2bc365ab408d 100755
--- a/tests/sign_verify.test
+++ b/tests/sign_verify.test
@@ -416,9 +416,12 @@ sign_verify  prime256v1 sha384 0x030205:K:004[345678]
 sign_verify  prime256v1 sha512 0x030206:K:004[345678]
 
 # If openssl 3.0 is installed, test the SM2/3 algorithm combination
-if [ -x /opt/openssl3/bin/openssl ]; then
-  PATH=/opt/openssl3/bin:$PATH LD_LIBRARY_PATH=/opt/openssl3/lib \
-    sign_verify  sm2    sm3    0x030211:K:004[345678]
+ssl_major_version=$(openssl version | sed -n 's/^OpenSSL \([^\.]\).*/\1/p')
+if [ "${ssl_major_version}" = 3 ]; then
+   sign_verify  sm2    sm3    0x030211:K:004[345678]
+else
+	__skip() { echo "sm2/sm3 tests are skipped (ssl version)"; return $SKIP; }
+  expect_pass __skip
 fi
 
 # Test v2 signatures with EC-RDSA
-- 
2.31.1

