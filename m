Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC585254DC
	for <lists+linux-integrity@lfdr.de>; Thu, 12 May 2022 20:31:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344924AbiELSbX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 May 2022 14:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245317AbiELSbW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 May 2022 14:31:22 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BFB5A2DB
        for <linux-integrity@vger.kernel.org>; Thu, 12 May 2022 11:31:21 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CIRV5Q012863;
        Thu, 12 May 2022 18:31:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=XWosdQQEIoeUlYqagamzepd4m8mhF3PkiJ0ei1FawGQ=;
 b=SlAgcrtNVADVF4Z3KQjEnZ4aArWeqoqJmKZye0tnfUndMFKOUOtt0WlgT4WtdfXz61qD
 39oYG7mr4CzH08wPUzEfD0HBbkOXsMHG2Em2E8qn3XH0Jz8nwb0BsMIqyIdvIvIXDu/h
 /swhSnjry3AzKPUw4gMgypnfA+kyzz4kqr+P7qNyBMD6KvR1NR7z/IBoR4QdE4rRe33A
 4N2l7GJ5wVZpLu/RVDzfycAXiBa90tGjmsL2wbcAKotWJwprM7/3SuGM17bQAIaSQkdw
 +hbOMGClBqWIjmoNrVUJRq/eCWOV9RvS23nE865cEmK83QE7tkuBWRNlWFTwvCnpkskE hA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3g173b8pud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 18:31:18 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24CIDlEh026333;
        Thu, 12 May 2022 18:31:16 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3fwgd8yead-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 18:31:16 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24CIUpfK31457728
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 May 2022 18:30:51 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E49E42041;
        Thu, 12 May 2022 18:31:13 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5A3C4203F;
        Thu, 12 May 2022 18:31:12 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.watson.ibm.com (unknown [9.31.98.41])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 May 2022 18:31:12 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 ima-evm-utils 1/3] initialize errno in cmd_sign_hash()
Date:   Thu, 12 May 2022 14:30:54 -0400
Message-Id: <20220512183056.307597-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TaRL9nAfVK1L5JGRyhOCfy2bfNAaUipW
X-Proofpoint-GUID: TaRL9nAfVK1L5JGRyhOCfy2bfNAaUipW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_15,2022-05-12_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 mlxlogscore=917 priorityscore=1501
 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120081
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Prevent "errno: No such file or directory (2)" message.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/evmctl.c b/src/evmctl.c
index 8bdd34817408..ca9449498321 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -737,6 +737,7 @@ static int cmd_sign_hash(struct command *cmd)
 	unsigned char sig[MAX_SIGNATURE_SIZE] = "\x03";
 	int siglen;
 
+	errno = 0;
 	key = imaevm_params.keyfile ? : "/etc/keys/privkey_evm.pem";
 
 	/* support reading hash (eg. output of shasum) */
-- 
2.27.0

