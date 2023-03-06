Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B6A6ABE54
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Mar 2023 12:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbjCFLhe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Mar 2023 06:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjCFLhd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Mar 2023 06:37:33 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D406BB94
        for <linux-integrity@vger.kernel.org>; Mon,  6 Mar 2023 03:37:31 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326Ant2g027039;
        Mon, 6 Mar 2023 11:37:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=BWFZ8pP4NHONdLtZiL8zwGjfFo2t83VPrQhA5U9M5Ng=;
 b=KrGuZv+Mvq3ty9nskSb4uhAJ9vvTTz8lOnvmRQtWyKS3x8W6N4DbYtQBQMZxA/Un1wfY
 7wrsnDty1nUR6/v+mLiMWaqMYcwZl9yxUb/30vBDgReodUA2Q+zX8mHX5EYDRtBlp2RG
 IC/pkVzhLxnfRh3MaokwMenn8MnP8HH9Zae8LaOWmRRyZ8gTbrhAo6XbkQHItBeKAD5N
 mHHNlxXGgtsaj4oSm5ARrKv3YxL5cbnVqf1TjcjgK1QbX6xgIJndNDJ6auqRbQO7crUB
 9O5upV9ePC2m0hdmsE/LAEdeeuAdPt1kGCZOhnns3Dtd1sDsp0iL+m4CHOVFfUjgBk0s sQ== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p500dhjgb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 11:37:20 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3264Y4bH004489;
        Mon, 6 Mar 2023 11:37:17 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3p41b0t3sv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 11:37:17 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 326BbFW043516168
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Mar 2023 11:37:15 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49E7F2004F;
        Mon,  6 Mar 2023 11:37:15 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D374A2004E;
        Mon,  6 Mar 2023 11:37:13 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.111.157])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Mar 2023 11:37:13 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>, Petr Vorel <pvorel@suse.cz>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>
Subject: [PATCH ima-evm-utils 2/2] tests: fix gen-keys.sh to generate sha256 certificates
Date:   Mon,  6 Mar 2023 06:36:35 -0500
Message-Id: <20230306113635.350582-2-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230306113635.350582-1-zohar@linux.ibm.com>
References: <20230306113635.350582-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Lx_hnoA6DDSC6jCY0oL5HKMwkoFjSTdF
X-Proofpoint-GUID: Lx_hnoA6DDSC6jCY0oL5HKMwkoFjSTdF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_04,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 phishscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303060101
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On systems with OpenSSL sha1 disabled, the sign-verify.test fails:

- openssl dgst   -sha1 sha1.txt
- openssl dgst   -sha1 -sign test-rsa1024.key -hex sha1.txt
Error setting context
804BD5CF787F0000:error:03000098:digital envelope routines:do_sigver_init:invalid digest:crypto/evp/m_sigver.c:343:
sha1 (test-rsa1024.key) test is skipped (openssl is unable to sign)

Instead of enabling sha1 support on these systems by setting the environment
variable OPENSSL_ENABLE_SHA1_SIGNATURES, generate a sha256 certificate.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 tests/gen-keys.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/gen-keys.sh b/tests/gen-keys.sh
index 1a6c22a2f3c4..8905cdf2d216 100755
--- a/tests/gen-keys.sh
+++ b/tests/gen-keys.sh
@@ -71,7 +71,7 @@ for m in 1024 1024_skid 2048; do
     ext=
   fi
   if [ ! -e test-rsa$m.key ]; then
-    log openssl req -verbose -new -nodes -utf8 -sha1 -days 10000 -batch -x509 $ext \
+    log openssl req -verbose -new -nodes -utf8 -sha256 -days 10000 -batch -x509 $ext \
       -config test-ca.conf \
       -newkey rsa:$bits \
       -out test-rsa$m.cer -outform DER \
@@ -93,7 +93,7 @@ for curve in prime192v1 prime256v1; do
     continue
   fi
   if [ ! -e test-$curve.key ]; then
-    log openssl req -verbose -new -nodes -utf8 -sha1 -days 10000 -batch -x509 \
+    log openssl req -verbose -new -nodes -utf8 -sha256 -days 10000 -batch -x509 \
       -config test-ca.conf \
       -newkey ec \
       -pkeyopt ec_paramgen_curve:$curve \
-- 
2.31.1

