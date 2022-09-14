Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4905B8A3A
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Sep 2022 16:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiINOWl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Sep 2022 10:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiINOWk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Sep 2022 10:22:40 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375454662E
        for <linux-integrity@vger.kernel.org>; Wed, 14 Sep 2022 07:22:40 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28EDcKoY001958;
        Wed, 14 Sep 2022 14:22:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=LODsS5t7h/+tzVHK/nhlYnXa40qU63cMZFpFgldEKaI=;
 b=kC+3c6g6d3xtIp1vrSM86jfYzH/ucDjHsgd0TNPwKgv6JehjIkHaxh/NYluNN8u+0eX5
 zhpGjM+Em0Jrel/G6cqZQZ0szxjOe57vKUfOiPkbbVdcN5pk5FaBBcaNE+aClX2afjgk
 3+iT9HLsXPDM7/5G9us0zvf7My/RnEZQriZXyt1kYK2KOIFAzuu+/uzm2e8CTrMlbWAW
 fniHBwhYj5l57T3Ip1I3/+Aeegpq1UDGSjvSOALKNoSeAAoO5ibwsQQ+KxyQ6zsmMXcR
 X6ke+OPe8hjxAfmM35lPs9PIXl49pD86EiE7sVwDLawNFljXrOjESmOr6vsh+Rz8dpyQ 4w== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jkfmpjnb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 14:22:37 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28EEKdYe021418;
        Wed, 14 Sep 2022 14:22:34 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3jjytx1398-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 14:22:34 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28EEMVc435193200
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 14:22:31 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8181152050;
        Wed, 14 Sep 2022 14:22:31 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.65.200.242])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id DF48A5204E;
        Wed, 14 Sep 2022 14:22:30 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils 2/4] Define and verify the template data length upper bounds
Date:   Wed, 14 Sep 2022 10:22:23 -0400
Message-Id: <20220914142225.1381077-3-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220914142225.1381077-1-zohar@linux.ibm.com>
References: <20220914142225.1381077-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3s34ebS-gDo6LP11VQs57o1V6PrOdaGh
X-Proofpoint-GUID: 3s34ebS-gDo6LP11VQs57o1V6PrOdaGh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_06,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140068
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The template data length is variable, based on the template format.
Define some sort of upper bounds.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c |  3 ++-
 src/imaevm.h | 10 ++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index bcf724c828f7..9ab804fee37a 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2189,7 +2189,8 @@ static int ima_measurement(const char *file)
 				log_err("Unable to read template length\n");
 				goto out;
 			}
-			if (entry.template_len == 0) {
+			if (entry.template_len == 0 ||
+			    entry.template_len > MAX_TEMPLATE_SIZE) {
 				log_err("Invalid template data len\n");
 				goto out;
 			}
diff --git a/src/imaevm.h b/src/imaevm.h
index 8114bd051514..c43312d01dec 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -91,6 +91,16 @@
 #define MAX_DIGEST_SIZE		64
 #define MAX_SIGNATURE_SIZE	1024
 
+/*
+ * The maximum template data size is dependent on the template format. For
+ * example the 'ima-modsig' template includes two signatures - one for the
+ * entire file, the other without the appended signature - and other fields
+ * (e.g. file digest, file name, file digest without the appended signature).
+ *
+ * Other template formats are much smaller.
+ */
+#define MAX_TEMPLATE_SIZE	(MAX_SIGNATURE_SIZE * 4)
+
 #define __packed __attribute__((packed))
 
 enum evm_ima_xattr_type {
-- 
2.31.1

