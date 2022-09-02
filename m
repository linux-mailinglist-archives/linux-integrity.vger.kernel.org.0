Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE63E5AB687
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Sep 2022 18:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235698AbiIBQ3G (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Sep 2022 12:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235657AbiIBQ3F (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Sep 2022 12:29:05 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB13DABBC
        for <linux-integrity@vger.kernel.org>; Fri,  2 Sep 2022 09:28:59 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 282G12tF031022;
        Fri, 2 Sep 2022 16:28:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=TQcyyTF48z5cUYqJ4+Py8BCPqtYiPwHcGac9ZWrdcw4=;
 b=X9TRnDIJ/+2IKwFj17S/keVmgxaGxZrWNOIDSxQNCZGfIUIkmi5O9edSkzClPsZcMbD8
 /DceMoJkeau3TH3JHMcCgIX73dwhiIyzsj41WGHDAIwCWytTHLz4ttaY0uIP6dffio/K
 VeD+SJDpx0VODcgTnjVGe4xWAg7G0Piq1Ek/EdTo96g/bcMUM8+yGMN8gCLx2enCgK2G
 uIO/VHAMsEya/J5bDzUlZqKGf7ZS2UuhemCEKpmaZ4SdGPw/RQ0Ucwv2669hGXwz8C5C
 DEzwvxWUZ9M4aQSI/g4WQGPfIyVwxPuJGOJd+/wphrvTWAXLKX3kVn+zD9r4eY0vMv4c bA== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jbmyx0xs2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 16:28:55 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 282G8YfN019266;
        Fri, 2 Sep 2022 16:28:52 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 3j7aw8x5k1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 16:28:52 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 282GSnT635258720
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Sep 2022 16:28:49 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9BD7152050;
        Fri,  2 Sep 2022 16:28:49 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.211.132.193])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 6495B5204F;
        Fri,  2 Sep 2022 16:28:48 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils 02/11] travis: update dist=focal
Date:   Fri,  2 Sep 2022 12:28:27 -0400
Message-Id: <20220902162836.554839-3-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220902162836.554839-1-zohar@linux.ibm.com>
References: <20220902162836.554839-1-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: R5ro3mNtI8pvlSfCSXK69-SdL0balD8v
X-Proofpoint-ORIG-GUID: R5ro3mNtI8pvlSfCSXK69-SdL0balD8v
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-02_03,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 mlxlogscore=976 mlxscore=0 bulkscore=0 phishscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2209020075
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Although Github Actions is available on Github Enterprise Server 3.x
single server edition, as well as the unpaid version, it is not
available in Github Enterprise Server 3.x cluster edition[1].  Continue
to support travis.

[1] https://docs.github.com/en/enterprise-server@3.0/admin/release-notes#github-packages

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .travis.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index b18c871be200..cc76c0adb312 100644
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

