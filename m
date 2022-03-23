Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674A34E5BCD
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Mar 2022 00:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344900AbiCWXcn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Mar 2022 19:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241475AbiCWXcm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Mar 2022 19:32:42 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A9290CD8
        for <linux-integrity@vger.kernel.org>; Wed, 23 Mar 2022 16:31:11 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22NK1Xpa001438;
        Wed, 23 Mar 2022 23:31:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=6OWHzXsVz7AKaMufFCWuuHm6SPCb97H9O49yCLw5nCA=;
 b=ObF267DGZxTfy+wdD/R9qprx2p2CyT8htV82eL+U8NaSiIAK4wcTjYGoRPcigyRtY+Km
 +9RmnzgUt4bGuhghTQjjcVNQyV15DeBFY9aIG6pd7PnZtHkr52JaHydSWIMtnPX903yx
 nKl3RXSsVIqSrtIGlNe5/8Ke2oaCi7peHHyrL2fz/2jCCwN9qEDJ4G32NVtizs9uXiz7
 coCCizctXr3X5hSKc+69Qf7b1anGiNzu/ozd5b/Y57vlS2mXN0nhnvXrAU0bMnYfvZiw
 2sKRAVw+u5zdG1289cWVoTSpk8s+xebzuPLxXSF8xE4KNQfxvo5ismGP3jA0IAUe+ULt Fw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f053qb512-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Mar 2022 23:31:08 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22NNGvYW012903;
        Wed, 23 Mar 2022 23:31:06 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3ew6ej1jvb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Mar 2022 23:31:06 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22NNV3xd33685810
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Mar 2022 23:31:03 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46B4CA4054;
        Wed, 23 Mar 2022 23:31:03 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90DCEA4060;
        Wed, 23 Mar 2022 23:31:02 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.65.73.171])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 23 Mar 2022 23:31:02 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>
Subject: [PATCH ima-evm-utils] travis: include CentOS stream 8
Date:   Wed, 23 Mar 2022 19:30:57 -0400
Message-Id: <20220323233057.42287-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: atgcrl8Ecln4b_bXRBUuFlM1bhr8gB7L
X-Proofpoint-GUID: atgcrl8Ecln4b_bXRBUuFlM1bhr8gB7L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-23_08,2022-03-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203230120
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Replace CentOS 8 with CentOS stream 8.
Use podman for both CentOS 7 & 8.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .travis.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index bdf78a1b12cd..0b70971a3c76 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -52,11 +52,11 @@ matrix:
           compiler: clang
 
         - os: linux
-          env: DISTRO=centos:7 TSS=tpm2-tss
+          env: DISTRO=centos:7 TSS=tpm2-tss CONTAINER=podman CONTAINER_ARGS="--runtime=/usr/bin/crun --network=host"
           compiler: gcc
 
         - os: linux
-          env: DISTRO=centos:latest TSS=tpm2-tss
+          env: REPO="quay.io/centos/" DISTRO="${REPO}centos:stream8" TSS=tpm2-tss CONTAINER=podman CONTAINER_ARGS="--runtime=/usr/bin/crun --network=host"
           compiler: clang
 
         - os: linux
-- 
2.27.0

