Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86791563B13
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Jul 2022 22:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiGAUOd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 1 Jul 2022 16:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbiGAUOU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 1 Jul 2022 16:14:20 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275F7387B1
        for <linux-integrity@vger.kernel.org>; Fri,  1 Jul 2022 13:13:39 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 261IkmEV002279
        for <linux-integrity@vger.kernel.org>; Fri, 1 Jul 2022 20:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=DG5Fjkd0eiUJPH0OqcwIwdPdvgh0dmwDdKx5EDndjj0=;
 b=mElJVxZBvx6hW+scjDw4EASPoOAxuRkTsUmlt7t29G4gazbVYMo+WusF7SUyt4TDA8uC
 l4IOPXDPgfZkE+LN4wPG5E1NZcErXffF9/y4tOpV/Zpp/45MJKAsF2nrv10TtA/q+dH6
 YoNH4XdmMcaSJgkt5CyOaw32Y2xQyVzI+GTHL5ttESMsapxEeZxEXTD8T26G8tKeLeaq
 4jjQ8MpVkxjHx3vtO2VuJMGwM26umG8DoT9bnSQ9WvN967+yKe0R78sk08mqNlavvKrR
 DX7Zv3NlQM3gueyfAAdKUgbMluS/9uwpQjDnQr97mBPL2mFpaPdkwzvWBxyZYgtjjEIZ cg== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h26g7j2q6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 01 Jul 2022 20:13:38 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 261K6g6P014397
        for <linux-integrity@vger.kernel.org>; Fri, 1 Jul 2022 20:13:36 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 3gwt08yjyy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 01 Jul 2022 20:13:36 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 261KDXMg24379762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Jul 2022 20:13:33 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1758442041;
        Fri,  1 Jul 2022 20:13:33 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB1204203F;
        Fri,  1 Jul 2022 20:13:31 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.211.154.188])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 Jul 2022 20:13:31 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Stefan Berger <stefanb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH] ima: fix violation measurement list record
Date:   Fri,  1 Jul 2022 16:13:25 -0400
Message-Id: <20220701201325.396766-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0EPKXO3wHTx2OjYmwy4r03r1umQ3gkZH
X-Proofpoint-GUID: 0EPKXO3wHTx2OjYmwy4r03r1umQ3gkZH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-01_12,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 bulkscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2207010081
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

This is just a cosmetic which should not affect attestation.

Reported-by: Stefan Berger <stefanb@linux.ibm.com>
Fixes: 09091c44cb73 ("ima: use IMA default hash algorithm for integrity violations")
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima_template_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index c877f01a5471..67359845c975 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -326,7 +326,7 @@ static int ima_eventdigest_init_common(const u8 *digest, u32 digestsize,
 		 * Make room for the digest by increasing the offset of
 		 * IMA_DIGEST_SIZE.
 		 */
-		offset += IMA_DIGEST_SIZE;
+		offset += hash_digest_size[hash_algo];
 
 	return ima_write_template_field_data(buffer, offset + digestsize,
 					     fmt, field_data);
-- 
2.27.0

