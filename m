Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32B55AB691
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Sep 2022 18:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236404AbiIBQ32 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Sep 2022 12:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236439AbiIBQ3Y (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Sep 2022 12:29:24 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9207DC0B9
        for <linux-integrity@vger.kernel.org>; Fri,  2 Sep 2022 09:29:15 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 282G0wb9030791;
        Fri, 2 Sep 2022 16:29:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=3cQT0jAMiIEKOnjXuRz1TD6kDtKHKfVNX9Wq47dPQGo=;
 b=krUg0vEJ+i1SR8CrpOSi94fzgCEnCemAjk5XUoy/lPXjPDN0Kg+d8V0AjiLEqlzkrrXu
 R0+jtHxOa6iA1bWlBvVOAjxTUz7Rm2QtI6e3nVb4CxhdhVDhPCj8W0WqXN71RSABzRRo
 9mQpXJ7NAmW/DyQv+qI5puxPA3Cb/P0RaDmIqUui1ck+7MXrK2Py0labh4XfrBlmZasd
 wgoHOq5bQzrEOMEgRCRSxgWDtpuhZ32L7l10pugSFVn+GoG/70CHBguM7hH2KqdJNMdf
 jarWXBf6A7gk9Ap+G1w442mU0akNHUbtHx/adYr/EgCfKc/y3nX5BcZ9ejIBaAzViW7F yQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jbmyx0y12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 16:29:10 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 282G7sFY011773;
        Fri, 2 Sep 2022 16:29:08 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3j7ahj8e93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Sep 2022 16:29:08 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 282GTRf038076808
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 2 Sep 2022 16:29:27 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 242B95204F;
        Fri,  2 Sep 2022 16:29:05 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.211.132.193])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id A34945204E;
        Fri,  2 Sep 2022 16:29:03 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils 11/11] Missing template data size lower bounds checking
Date:   Fri,  2 Sep 2022 12:28:36 -0400
Message-Id: <20220902162836.554839-12-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220902162836.554839-1-zohar@linux.ibm.com>
References: <20220902162836.554839-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7B_M9VC0e_u0NURkFi36LNYFckulHPEu
X-Proofpoint-ORIG-GUID: 7B_M9VC0e_u0NURkFi36LNYFckulHPEu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-02_03,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0 phishscore=0
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

