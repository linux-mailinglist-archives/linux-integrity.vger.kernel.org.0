Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F456616CF9
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Nov 2022 19:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbiKBSpw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Nov 2022 14:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbiKBSpq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Nov 2022 14:45:46 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369492D77D
        for <linux-integrity@vger.kernel.org>; Wed,  2 Nov 2022 11:45:45 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2Haeqw011473
        for <linux-integrity@vger.kernel.org>; Wed, 2 Nov 2022 18:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=9jmewiu0dtifcz0k0DUgXZBwtuUKObO9/M9DmPORY/g=;
 b=KxIlzI5NdboT7DEFf/iD/dFbGbxGU3C+HxD/HJ+syKvKl+l9a9Xr0pCERElrLlyevw73
 IjNvuwwkBAWezlWqnzosbfUaW8d9P1cEKYkaswxbWjlVGXQ1KMzUMt7y/hxZ1JkBED16
 GpN2ZySzPDNut8GKUdzXLCS1aDGsq5ppPN9mExfxPPQDjIKLp10sXRXiYJotYkVNBBLq
 gMcnBCJUxt+mgFLF5GPVRDxK8MLtDL1WFvj7Kc3DuPOXQD6jB2vSXh/L57AzjhEpmFcm
 z+cfqL1QJL70RuM3T+KdwvXVxbI2NFO0Dn3EdSAyi5YQ7jGo9ADyS2GMOkIEykIIKnc8 Gg== 
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kkqxwyws0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 02 Nov 2022 18:45:44 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A2IanRL031916
        for <linux-integrity@vger.kernel.org>; Wed, 2 Nov 2022 18:45:44 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma04dal.us.ibm.com with ESMTP id 3kgutabfbm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 02 Nov 2022 18:45:43 +0000
Received: from smtpav06.dal12v.mail.ibm.com ([9.208.128.130])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A2Ijgv252756830
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Nov 2022 18:45:42 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4797C58043;
        Wed,  2 Nov 2022 18:45:42 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF31A5805F;
        Wed,  2 Nov 2022 18:45:41 +0000 (GMT)
Received: from sbct-2.pok.ibm.com (unknown [9.47.158.152])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  2 Nov 2022 18:45:41 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v1 4/4] Change condition to free(pub)
Date:   Wed,  2 Nov 2022 14:45:34 -0400
Message-Id: <20221102184534.1075049-5-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102184534.1075049-1-stefanb@linux.ibm.com>
References: <20221102184534.1075049-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vi4cmhYfetFfmdcSmn49A6S5ts4MNnnV
X-Proofpoint-GUID: vi4cmhYfetFfmdcSmn49A6S5ts4MNnnV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_14,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211020120
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Change the condition under which pub is freed to make it clearer for the
reader and analyzer.

This change gets rid of the following gcc -fanalyzer warning:

evmctl.c:1140:12: warning: leak of ‘pub’ [CWE-401] [-Wanalyzer-malloc-leak]
 1140 |         if (imaevm_params.x509)
      |            ^

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/evmctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 4f55fb6..59a56c8 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1137,7 +1137,7 @@ static int cmd_import(struct command *cmd)
 		log_info("keyid: %d\n", id);
 		printf("%d\n", id);
 	}
-	if (imaevm_params.x509)
+	if (pub != _pub)
 		free(pub);
 	return err;
 }
-- 
2.38.1

