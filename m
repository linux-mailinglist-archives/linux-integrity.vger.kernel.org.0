Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5B95B7F01
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Sep 2022 04:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiINCa1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Sep 2022 22:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiINCaY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Sep 2022 22:30:24 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5007245057
        for <linux-integrity@vger.kernel.org>; Tue, 13 Sep 2022 19:30:23 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28E2Dl0P026766;
        Wed, 14 Sep 2022 02:30:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=drT64InxfTIATQKuCRL+GopbslNgDcvCaBLvhsbs44Y=;
 b=HADy8p5QciE7mN6I3mSOMg9QlfUaJpghAXP6Ooc39GwKZOvTidot4izYzXQ3dX26xQAf
 kcoJ1u6lM+41ng+jxH0tPFJWN84CRZPjWaU3hJXw3pO4YqGRCyqREzvdlsUWymjz9xsX
 6auS9R3vHqF0VhiAJ/NsPnmefdovOFQjwzcFlUd3vdQlFNjK6docRkvlP3OKN7OYRRee
 9W3CTJmsQnvsA484Bpm3qXdDurcNmuVBYl48FZzDgHYD8r5Ezt14b5GNh16favLDiaPB
 tWgs5gT22R2S2KDhnSSHomH6DT3UlHV5Xb5NQ79T+xWcaZoBKoYQk141S2U1MEWtQVGg 6A== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jk605g9ps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 02:30:18 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28E2KbpC026697;
        Wed, 14 Sep 2022 02:30:16 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3jjytx0av1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 02:30:16 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28E2Ubbl18612718
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 02:30:37 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4956EA4055;
        Wed, 14 Sep 2022 02:30:13 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 918D8A404D;
        Wed, 14 Sep 2022 02:30:12 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.29.234])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 14 Sep 2022 02:30:12 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v3 13/15] Compile a newer version of OpenSSL
Date:   Tue, 13 Sep 2022 22:29:54 -0400
Message-Id: <20220914022956.1359218-14-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220914022956.1359218-1-zohar@linux.ibm.com>
References: <20220914022956.1359218-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jPRyjCOBPSxNBHOpX_I_OnfhtQSg1kRE
X-Proofpoint-GUID: jPRyjCOBPSxNBHOpX_I_OnfhtQSg1kRE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_12,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140008
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

With the distros shipping OpenSSL 3 with engine support, the original
purpose for compiling OpenSSL 3 to test sm2/sm3 is no longer necessary
and could be removed.  Or, it could be re-purposed for building OpenSSL
without engine support, which is needed for testing.

For both travis and github actions, update openssl-3.0.0-beta1 with
openssl-3.0.5.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .github/workflows/ci.yml | 6 +++---
 .travis.yml              | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
index dc06fce64ba5..5595855512e4 100644
--- a/.github/workflows/ci.yml
+++ b/.github/workflows/ci.yml
@@ -17,7 +17,7 @@ jobs:
               ARCH: i386
               TSS: tpm2-tss
               VARIANT: i386
-              COMPILE_SSL: openssl-3.0.0-beta1
+              COMPILE_SSL: openssl-3.0.5
 
           # cross compilation builds
           - container: "debian:stable"
@@ -52,7 +52,7 @@ jobs:
             env:
               CC: clang
               TSS: ibmtss
-              COMPILE_SSL: openssl-3.0.0-beta1
+              COMPILE_SSL: openssl-3.0.5
 
           - container: "opensuse/leap"
             env:
@@ -63,7 +63,7 @@ jobs:
             env:
               CC: gcc
               TSS: ibmtss
-              COMPILE_SSL: openssl-3.0.0-beta1
+              COMPILE_SSL: openssl-3.0.5
 
           - container: "ubuntu:xenial"
             env:
diff --git a/.travis.yml b/.travis.yml
index edd2a21b83d3..09db401928f6 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -9,7 +9,7 @@ matrix:
     include:
         # 32 bit build
         - os: linux
-          env: DISTRO=debian:stable VARIANT=i386 ARCH=i386 TSS=tpm2-tss COMPILE_SSL=openssl-3.0.0-beta1
+          env: DISTRO=debian:stable VARIANT=i386 ARCH=i386 TSS=tpm2-tss COMPILE_SSL=openssl-3.0.5
           compiler: gcc
 
         # cross compilation builds
@@ -32,7 +32,7 @@ matrix:
 
         # glibc (gcc/clang)
         - os: linux
-          env: DISTRO=opensuse/tumbleweed TSS=ibmtss CONTAINER=podman CONTAINER_ARGS="--runtime=/usr/bin/crun --network=host" COMPILE_SSL=openssl-3.0.0-beta1
+          env: DISTRO=opensuse/tumbleweed TSS=ibmtss CONTAINER=podman CONTAINER_ARGS="--runtime=/usr/bin/crun --network=host" COMPILE_SSL=openssl-3.0.5
           compiler: clang
 
         - os: linux
@@ -40,7 +40,7 @@ matrix:
           compiler: gcc
 
         - os: linux
-          env: DISTRO=ubuntu:jammy TSS=ibmtss COMPILE_SSL=openssl-3.0.0-beta1
+          env: DISTRO=ubuntu:jammy TSS=ibmtss COMPILE_SSL=openssl-3.0.5
           compiler: gcc
 
         - os: linux
-- 
2.31.1

