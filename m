Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07DA5AF51C
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Sep 2022 21:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbiIFTzg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Sep 2022 15:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiIFTxf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Sep 2022 15:53:35 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAFBB3B0D
        for <linux-integrity@vger.kernel.org>; Tue,  6 Sep 2022 12:51:01 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286JBuHw012286;
        Tue, 6 Sep 2022 19:50:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=3cQT0jAMiIEKOnjXuRz1TD6kDtKHKfVNX9Wq47dPQGo=;
 b=rM8ONJ81a2zP7kd0Rv77Zjsd8ZhbDIStvkGcqvD9WuWTMbMQg2WVNSGGdGFZk6iRXVEJ
 H/gwv0t7OBlJ9BK/H3AKn1vpyIXGEMNGJiwQ3Tz0cyVb6oqj6PMUjmK9lEAQMK5OzWtb
 Fe64bJGqP8nzfVHuG1vXSEjGY7ZSpp9Hif++O9+MAGrD3Tk+Z0KZ1/5INl9rTmwAtlZ/
 oTCk6YqSLoZDEl5OyB7UM37cKFpxFXx/7l76yrogVGWIU7aNls+UWwkK/ulF4OXSGaJt
 Kl0G8B5TjXcGufDu41GrELeg3MFeFMDHBsGBFkjHpc8O9zpebx9J2g0d9BQSEKrD781i uA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jec5892v9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 19:50:55 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 286JaHV6012990;
        Tue, 6 Sep 2022 19:50:53 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 3jbx6hm6m1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 19:50:53 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 286JooA737749246
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 6 Sep 2022 19:50:50 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8311911C04C;
        Tue,  6 Sep 2022 19:50:50 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18CE911C04A;
        Tue,  6 Sep 2022 19:50:49 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.211.107.58])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  6 Sep 2022 19:50:48 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v2 11/12] Missing template data size lower bounds checking
Date:   Tue,  6 Sep 2022 15:50:20 -0400
Message-Id: <20220906195021.854090-12-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220906195021.854090-1-zohar@linux.ibm.com>
References: <20220906195021.854090-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XGgQtrrG7lFEq6Zp0unaFRzP8lB6Lpnl
X-Proofpoint-ORIG-GUID: XGgQtrrG7lFEq6Zp0unaFRzP8lB6Lpnl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060090
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Each record in the IMA measurement list must contain some template data.
Ensure the template data is not zero length.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/evmctl.c b/src/evmctl.c
index aac669438a1c..e603449b7d9e 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2188,6 +2188,10 @@ static int ima_measurement(const char *file)
 				log_err("Unable to read template length\n");
 				goto out;
 			}
+			if (entry.template_len == 0) {
+				log_err("Invalid template data len\n");
+				goto out;
+			}
 		} else {
 			entry.template_len = SHA_DIGEST_LENGTH +
 					     TCG_EVENT_NAME_LEN_MAX + 1;
-- 
2.31.1

