Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2B685AF4EB
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Sep 2022 21:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiIFTzB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Sep 2022 15:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiIFTw7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Sep 2022 15:52:59 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADF7A9243
        for <linux-integrity@vger.kernel.org>; Tue,  6 Sep 2022 12:50:46 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286Jn5Lk016911;
        Tue, 6 Sep 2022 19:50:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=jembsahyVt8BStfk6GqIR48niDiqjpxX6bKc7iQ7zrs=;
 b=iXaEpj/5G0tJQ6h15yn2ZBfihyt0PvyA0SYkyG9RuvKo8E4PsLwc5IU4ZFxKeWz9C3cj
 H5JJyQjmdvC77q+FP855segxK3LcrHA+//uZiZ95bXoZiEG0DITUVamJHBnqxCQJCf7K
 cFfCH53rvKdt2aAeE/dHvbGrQax8HDSCVE98yjBYx7aaKuB6pk4t1iyIERE/xtVIAEzw
 5x7tlkc7VMennHTTxzrkmnIqGOTclooLeRPbDGWakLIErfjjNdpImlaRgJensG2zIrpc
 OD9Qhhv6Z/35/+vz4+6ZNzLIFYu+kEEWCvMRNcOudvySQ/aNtA/4aMOn1NjlAD+hd+vc 3Q== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jecpq00r6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 19:50:38 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 286JoaD5007445;
        Tue, 6 Sep 2022 19:50:36 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 3jbxj8u36w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 19:50:36 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 286Jl30f42402178
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Sep 2022 19:47:03 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AFDEC11C04C;
        Tue,  6 Sep 2022 19:50:32 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13BB311C04A;
        Tue,  6 Sep 2022 19:50:31 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.211.107.58])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  6 Sep 2022 19:50:30 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v2 01/12] travis: use the distro OpenSSL version on jammy
Date:   Tue,  6 Sep 2022 15:50:10 -0400
Message-Id: <20220906195021.854090-2-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220906195021.854090-1-zohar@linux.ibm.com>
References: <20220906195021.854090-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eQvQoABC7aYTnJVz_lrgzTOM-Qvmuzo5
X-Proofpoint-ORIG-GUID: eQvQoABC7aYTnJVz_lrgzTOM-Qvmuzo5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060090
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Use the distro OpenSSL version on jammy, which is newer than
OpenSSL 3-beta.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 5741116e418a..b18c871be200 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -40,7 +40,7 @@ matrix:
           compiler: gcc
 
         - os: linux
-          env: DISTRO=ubuntu:jammy TSS=ibmtss COMPILE_SSL=openssl-3.0.0-beta1
+          env: DISTRO=ubuntu:jammy TSS=ibmtss
           compiler: gcc
 
         - os: linux
-- 
2.31.1

