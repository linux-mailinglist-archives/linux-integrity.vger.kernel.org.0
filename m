Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B5061530D
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Nov 2022 21:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbiKAUSl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Nov 2022 16:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiKAUSg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Nov 2022 16:18:36 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AC31903E
        for <linux-integrity@vger.kernel.org>; Tue,  1 Nov 2022 13:18:32 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1ITpEA032429;
        Tue, 1 Nov 2022 20:18:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=drT64InxfTIATQKuCRL+GopbslNgDcvCaBLvhsbs44Y=;
 b=m4GzPQuOoAb93KVtzH0AnjmVj4ElcNdUb3S0dIaFEA54Uw/2oXDrbpObvHfsnRbC21Wj
 VMFUe6qJlWRiXR5is4eDEZQ3Av4pbSJHoCqkyNgSwTvEoeIs+2M8wO60sV87+LPpe0Ni
 kut5SMZiA05WivajYedIh5oMqDSCAjXar8n0boM9mZYF5UeCbBct5wcJdlnU6PnbMy39
 7qEsz2kOr0nk+tD2+WOqymzenkttnvH/GPJi2kPyOTnUjAQWMvOlzLHMgp84mIhVmyPi
 Pmp06wgUO0ayRSdzm1Y+fJo90+HOOw7AVEagIvZTUYrRAhAjHqOVGkOJyCEfWfuu/yFC 8Q== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kjvbhd7xt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 20:18:27 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A1K5ZON004786;
        Tue, 1 Nov 2022 20:18:25 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3kgut8w8cd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Nov 2022 20:18:25 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A1KIMZE64815600
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Nov 2022 20:18:22 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 675DBA405C;
        Tue,  1 Nov 2022 20:18:22 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC132A405B;
        Tue,  1 Nov 2022 20:18:21 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.14.52])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  1 Nov 2022 20:18:21 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v4 15/17] Compile a newer version of OpenSSL
Date:   Tue,  1 Nov 2022 16:18:01 -0400
Message-Id: <20221101201803.372652-16-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221101201803.372652-1-zohar@linux.ibm.com>
References: <20221101201803.372652-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: G_7rmw3HhOOvauHIjd9qG0rTbSVPdHUp
X-Proofpoint-ORIG-GUID: G_7rmw3HhOOvauHIjd9qG0rTbSVPdHUp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_09,2022-11-01_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211010143
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

