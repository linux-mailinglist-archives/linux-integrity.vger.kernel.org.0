Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A02D72E3DB
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Jun 2023 15:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240171AbjFMNPz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Jun 2023 09:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240496AbjFMNPu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Jun 2023 09:15:50 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A5A171F
        for <linux-integrity@vger.kernel.org>; Tue, 13 Jun 2023 06:15:50 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35DCl1o4014524
        for <linux-integrity@vger.kernel.org>; Tue, 13 Jun 2023 13:15:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=y1Zw56wb8jW3mnwzCQvcyypJ9Aj92Iwt4EP24rkk/Mw=;
 b=D2wEQuxdYRM3XMbN+ne5EXqY0SDBNiOJRcImu7NEdipPC1fwzB5JO0LrqRk8ys5lLqZH
 MQ4FWHPPSskfXqqRD62vxcOmEVPOx0868Alc2LrC4YC307FlDMe9pFvZS18XfFsTiH8s
 kYFVApCC98g5y95fv6wXEPjIISIXtFUxYMnRKiQpl02Np69hvkKjpwlOD9MSIKTmDIR8
 pso4RGmyNmagTrh7WFykiF1BQ+/BFlj0zSqpWVkfCepYM4D1U2stOTa7wIhpfrLMxu4u
 8uBjJFWBL3UX7DOXezP6OuMfmfE8dTQSEqfIdRgVptU5PueSlt8Qx10Xo2p5Hi6Bq6vc DA== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3r6rrugn80-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 13 Jun 2023 13:15:49 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35DCoHTa012048
        for <linux-integrity@vger.kernel.org>; Tue, 13 Jun 2023 13:15:48 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3r4gt61v10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 13 Jun 2023 13:15:48 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35DDFll556295892
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2023 13:15:47 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F9FA58065;
        Tue, 13 Jun 2023 13:15:47 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB2FA58052;
        Tue, 13 Jun 2023 13:15:46 +0000 (GMT)
Received: from sbct-2.pok.ibm.com (unknown [9.47.158.152])
        by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 13 Jun 2023 13:15:46 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils 1/2] Strip trailing newline from password entered via prompt
Date:   Tue, 13 Jun 2023 09:15:41 -0400
Message-Id: <20230613131542.3603874-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230613131542.3603874-1-stefanb@linux.ibm.com>
References: <20230613131542.3603874-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GO2at_kLcpO5ok0_pdhScrCKFHbKRIwM
X-Proofpoint-GUID: GO2at_kLcpO5ok0_pdhScrCKFHbKRIwM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_04,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxscore=0 priorityscore=1501 spamscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=999 impostorscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130115
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The password entered via the prompt contains the trainling newline ('\n')
and therefore likely none of the passwords used for keys are 'working',
meaning using a password-protected key is likely to fail when using the
prompt. Therefore, remove the trailing newline from the password.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/evmctl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/evmctl.c b/src/evmctl.c
index c35a28c..4b68091 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2936,6 +2936,7 @@ static char *get_password(void)
 	struct termios flags, tmp_flags;
 	char *password, *pwd;
 	int passlen = 64;
+	size_t actlen;
 
 	password = malloc(passlen);
 	if (!password) {
@@ -2969,6 +2970,11 @@ static char *get_password(void)
 		return NULL;
 	}
 
+	/* strip trailing '\n' */
+	actlen = strlen(password);
+	if (actlen > 0 && password[actlen - 1] == '\n')
+		password[actlen - 1] = 0;
+
 	return password;
 }
 
-- 
2.39.2

