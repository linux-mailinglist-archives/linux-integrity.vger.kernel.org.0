Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51655A58B4
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Aug 2022 03:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiH3BAS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Aug 2022 21:00:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiH3BAR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Aug 2022 21:00:17 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BB88E47B
        for <linux-integrity@vger.kernel.org>; Mon, 29 Aug 2022 18:00:13 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27U0ljhs009624;
        Tue, 30 Aug 2022 01:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=XJakh9xhGVgEMmc4jaKcZU+zFgYpSkoa8s0HulTBWRU=;
 b=KS2W3rHLBksD0R9rlyhylAYu103CcVxlfayOyMR2GopugEHNVAxA34pzEWJi2WodnJtd
 ns98wKEP/u2MuTTO/NZon9AgeyNR26+ybcb0EXbaIhtq6Jdvu3AKEJ5dWAHNMdkKf+m3
 x8voJgun3Lotnqp4jQVHfHo9S99bBxwQEtUEmFXgvVftTJew0N0MLafZUopmNHNdgP0o
 paE1+udOvXM6ZPSXcK2iIJplCPZBOADRYeszOiv9tnwQUsnOvclsSuCBVTcb6cPal4eN
 FdSiA3VXuvlvw7AHBRaXVXwRQMBZvptdtUDOima7aHXc7me0B7i8ltzuiMcBC8U5+FsL ag== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j98auge8n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 01:00:09 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27U0o8d8006549;
        Tue, 30 Aug 2022 01:00:07 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 3j7aw8t5j1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 01:00:07 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27U10Pkn38994242
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 01:00:26 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 29819A4040;
        Tue, 30 Aug 2022 01:00:04 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1E5CA404D;
        Tue, 30 Aug 2022 01:00:02 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.211.117.120])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 30 Aug 2022 01:00:02 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [RFC PATCH ima-evm-utils 11/11] Missing template data size lower bounds checking
Date:   Mon, 29 Aug 2022 20:59:36 -0400
Message-Id: <20220830005936.189922-12-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220830005936.189922-1-zohar@linux.ibm.com>
References: <20220830005936.189922-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: C1L4_14iXs8Nx0lAqMszf5nB4aJpHyNH
X-Proofpoint-GUID: C1L4_14iXs8Nx0lAqMszf5nB4aJpHyNH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_13,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 suspectscore=0 mlxlogscore=981 impostorscore=0 malwarescore=0 bulkscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208290107
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

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/evmctl.c b/src/evmctl.c
index 4619bb433926..0d8f93bf5d26 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2189,6 +2189,10 @@ static int ima_measurement(const char *file)
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

