Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15D735B7F02
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Sep 2022 04:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiINCa2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Sep 2022 22:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiINCaZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Sep 2022 22:30:25 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07EBA51A02
        for <linux-integrity@vger.kernel.org>; Tue, 13 Sep 2022 19:30:23 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28E1Ipf6032068;
        Wed, 14 Sep 2022 02:30:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=k1ezI43RjQMiDMDS10MXydcAdQFfueOvwdZ34Zexh/M=;
 b=IXPqsLBOfuX8TTePYFsXuY92Q6CVyMqCyMPTjL5+LF8eym9wE3bSsbxlsL+OeRlwkXy2
 5mtxIDIyID7VC2oGr1L+tytkY/9uggq9B3RCKDzqkBfTk6SnUBsBjTjsaaWQXssBAlsU
 Kmpeqr+loj5iu3B3b/vUKH7W4IAJlpJ+JYYRlpuVZZq4BuQGRpAQjENjnB/bT2wCQ/S0
 tw/ZbS9UZLwQGBERj52z/zabIeDr/Ykf3ZFAHD08vN5liv88oPh0y9kuiE41keUwc+OC
 oT+YUGUIk8oii84yrcpdcyif0bIvD1eAAgnpith6QGpMPswGl6PhnXgkZ6YyRKb7Pl7/ Aw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3jk56e1q01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 02:30:20 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28E2M73X028229;
        Wed, 14 Sep 2022 02:30:18 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3jjyfr8bfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 02:30:18 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28E2UFaD39453072
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 02:30:15 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3514DA4040;
        Wed, 14 Sep 2022 02:30:15 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 69495A404D;
        Wed, 14 Sep 2022 02:30:14 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.29.234])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 14 Sep 2022 02:30:14 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v3 15/15] Fix d2i_x509_fp failure
Date:   Tue, 13 Sep 2022 22:29:56 -0400
Message-Id: <20220914022956.1359218-16-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220914022956.1359218-1-zohar@linux.ibm.com>
References: <20220914022956.1359218-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WvaMjI3eWmIZ8l7WE_OoOBRnmEY6U5I9
X-Proofpoint-GUID: WvaMjI3eWmIZ8l7WE_OoOBRnmEY6U5I9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_12,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=950 impostorscore=0 malwarescore=0
 clxscore=1015 mlxscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140008
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Before calling d2i_x509_fp(), make sure the keyfile is a regular file.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/libimaevm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 5d05f1bc1720..7adfa2101373 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -251,6 +251,7 @@ EVP_PKEY *read_pub_pkey(const char *keyfile, int x509)
 {
 	FILE *fp;
 	EVP_PKEY *pkey = NULL;
+	struct stat st;
 
 	if (!keyfile)
 		return NULL;
@@ -264,6 +265,16 @@ EVP_PKEY *read_pub_pkey(const char *keyfile, int x509)
 	}
 
 	if (x509) {
+		if (fstat(fileno(fp), &st) == -1)
+			goto out;
+
+		if ((st.st_mode & S_IFMT) != S_IFREG) {
+			if (imaevm_params.verbose > LOG_INFO)
+				log_err("Keyfile is not regular file: %s\n",
+					 keyfile);
+			goto out;
+		}
+
 		X509 *crt = d2i_X509_fp(fp, NULL);
 
 		if (!crt) {
-- 
2.31.1

