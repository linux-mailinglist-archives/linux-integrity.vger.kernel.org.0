Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D6C6187B2
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Nov 2022 19:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiKCSj1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Nov 2022 14:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiKCSj0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Nov 2022 14:39:26 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890122DE7
        for <linux-integrity@vger.kernel.org>; Thu,  3 Nov 2022 11:39:25 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3IJ5dl020806;
        Thu, 3 Nov 2022 18:39:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=Y//fm9Dgzbk+PFjbKzqhMOboUHD60qTJUUpmKo88SPU=;
 b=EF7M6i/iINR+H076B8ugi/ZwbT1Ip8K1PkU1w4XE3cfGI50cSkKV4drlHFUVc9SyO3Ge
 tehu7GuMZ//Pu/dyeN45ttXeK2qtvu+tUKiZGUl7qq4pymY7w60jDbuGQB1jsuDhE9WA
 462svcdj7TK3grHX1RU6keUG/o8QX2bE9EYsOYPcQ0kRORJSKlWXywJtj508NWT3obyd
 tUGJUB2yR+9wnwTNwiliDvNZuThTFp1P4z2ZtC6T3p0NF5FJzTFOyVv7QRLeXXYkyAzj
 NyndaEimAeDlJODedxjllaY+gG8W9KvEd4bN13HuOmNeorRLuiLWQFK3/FnDJ8bT7usS Uw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kmfr0s2gm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 18:39:21 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A3IZuS3019577;
        Thu, 3 Nov 2022 18:39:19 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3kgut918e7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 18:39:19 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A3IdGXI7865012
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Nov 2022 18:39:16 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5875E42041;
        Thu,  3 Nov 2022 18:39:16 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93C614203F;
        Thu,  3 Nov 2022 18:39:15 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.20.100])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  3 Nov 2022 18:39:15 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v5 04/17] travis: update dist=focal
Date:   Thu,  3 Nov 2022 14:38:51 -0400
Message-Id: <20221103183904.103562-5-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221103183904.103562-1-zohar@linux.ibm.com>
References: <20221103183904.103562-1-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 25V7L5af-tCc8u-QanK9aK2T7mmO6C9a
X-Proofpoint-ORIG-GUID: 25V7L5af-tCc8u-QanK9aK2T7mmO6C9a
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211030125
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Although Github Actions is available on Github Enterprise Server 3.x
single server edition, as well as the unpaid version, it is not
available in Github Enterprise Server 3.x cluster edition[1].

Continue updating travis.yml.

[1] https://docs.github.com/en/enterprise-server@3.0/admin/release-notes#github-packages

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 5741116e418a..edd2a21b83d3 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -1,6 +1,6 @@
 # Copyright (c) 2017-2021 Petr Vorel <pvorel@suse.cz>
 
-dist: bionic
+dist: focal
 language: C
 services:
     - docker
-- 
2.31.1

