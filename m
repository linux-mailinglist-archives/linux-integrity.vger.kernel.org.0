Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F2E5670C1
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Jul 2022 16:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbiGEOQs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 5 Jul 2022 10:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbiGEOQY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 5 Jul 2022 10:16:24 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543791DA64
        for <linux-integrity@vger.kernel.org>; Tue,  5 Jul 2022 07:10:48 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 265E7bcm018003
        for <linux-integrity@vger.kernel.org>; Tue, 5 Jul 2022 14:10:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=+bk0mNqvWAcKa+UBNMYuRj7aNZGXCgwufPgyzYxmplA=;
 b=EaSd7XoeqRdPkoCOCCfJIJH5VmZRWRw1U86Kl19EA5M3834iTQoIXpfxDc1N8znHVn2h
 eSgSHIkBSr2ltxYXsxFuWgM6XEv25aazASzsQiQR3bnllGZQwO7O3XTPEnGM+UQim7OS
 8pXPNjPL2LFoFdDcRloHr95MSgy19Au6guUemSZ0TAmO4uydjc2m+EWmbT6jlrM2m4mR
 aL+MoiigGP32+PD5Uk0ZGHI0HG2bsXMJveOYRArH3h23tNHWiSEZJHP67O3L/YRi6lTG
 NzQZL9Xhpt0QIak7/ASj9fEd7ILG9EVlHTZFuKME32BMHSFF5uOZ7/fZjn1ymN7WR4t5 Ww== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h4nkeagb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 05 Jul 2022 14:10:47 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 265E5W5s030733
        for <linux-integrity@vger.kernel.org>; Tue, 5 Jul 2022 14:10:45 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3h2dn944rt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 05 Jul 2022 14:10:45 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 265EAgXj9765262
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Jul 2022 14:10:42 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50B394203F;
        Tue,  5 Jul 2022 14:10:42 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31C9B42041;
        Tue,  5 Jul 2022 14:10:41 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.211.104.119])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  5 Jul 2022 14:10:40 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v2] ima: fix violation measurement list record
Date:   Tue,  5 Jul 2022 10:10:35 -0400
Message-Id: <20220705141035.1101598-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Fw5hnPGrBfq46-9rIG45RebuUPOO-OLO
X-Proofpoint-GUID: Fw5hnPGrBfq46-9rIG45RebuUPOO-OLO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-05_10,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2207050061
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Although the violation digest in the IMA measurement list is always
zeroes, the size of the digest should be based on the hash algorithm.
Until recently the hash algorithm was hard coded to sha1.  Fix the
violation digest size included in the IMA measurement list.

This is just a cosmetic change which should not affect attestation.

Reported-by: Stefan Berger <stefanb@linux.ibm.com>
Fixes: 09091c44cb73 ("ima: use IMA default hash algorithm for integrity violations")
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima_template_lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index c877f01a5471..34a8cabe09b1 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -324,9 +324,9 @@ static int ima_eventdigest_init_common(const u8 *digest, u32 digestsize,
 		/*
 		 * If digest is NULL, the event being recorded is a violation.
 		 * Make room for the digest by increasing the offset of
-		 * IMA_DIGEST_SIZE.
+		 * hash algorithm digest size.
 		 */
-		offset += IMA_DIGEST_SIZE;
+		offset += hash_digest_size[hash_algo];
 
 	return ima_write_template_field_data(buffer, offset + digestsize,
 					     fmt, field_data);
-- 
2.27.0

