Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA186187BF
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Nov 2022 19:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiKCSjl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 3 Nov 2022 14:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiKCSjk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 3 Nov 2022 14:39:40 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0258A100
        for <linux-integrity@vger.kernel.org>; Thu,  3 Nov 2022 11:39:39 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3IG2KB020838;
        Thu, 3 Nov 2022 18:39:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=GMQ7klPrAK8gIF8M2qKmMp7dg+LDA2WtNHFf9z1bTIY=;
 b=eXtS/IschSddJu50CCBhd8q+Rv9y7zINs51TQ111M1UqBUEfHOePOgr442nM//KygbwM
 IdfvSSNhvBlKy5t2iz2nXQs8G6WVo+GyTv30P+TSVoY5LAHd4o3H+QLJCGHmjC9HJA0N
 9DX2CjCOPooG1yJTMtEXT7v9H7EFPkC6+9Xq4DKI/WfBNM+GAbMdVEi5QMKXETVNR5Sx
 hwVyeObY29Ix1IjQXd5JL7ekLhsHd2gQMzf09M+knGoEb6e4VMMOWjEJyqANjpANf4Ps
 5Y95Ocr6mwTT6eZp67bTOYfyYtLiBMtcs9WuJwb8aaSmHg2/lzVXOvrZX7ybtqbOrfpo 7A== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kmfr0s2pf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 18:39:35 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A3IZuS5019577;
        Thu, 3 Nov 2022 18:39:33 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3kgut918ed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 18:39:33 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A3IdUH58978980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 3 Nov 2022 18:39:30 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B16442049;
        Thu,  3 Nov 2022 18:39:30 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 980C54203F;
        Thu,  3 Nov 2022 18:39:29 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.20.100])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  3 Nov 2022 18:39:29 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v5 17/17] Make sure the key file is a regular file
Date:   Thu,  3 Nov 2022 14:39:04 -0400
Message-Id: <20221103183904.103562-18-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221103183904.103562-1-zohar@linux.ibm.com>
References: <20221103183904.103562-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bPPNAmhOCcBJy574DkV9JqxncvpO1woi
X-Proofpoint-ORIG-GUID: bPPNAmhOCcBJy574DkV9JqxncvpO1woi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2210170000 definitions=main-2211030125
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Before attempting to use the key file, make sure it is a regular file.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/libimaevm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 8070ffd61a2c..c09ed98fe508 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -250,6 +250,7 @@ EVP_PKEY *read_pub_pkey(const char *keyfile, int x509)
 {
 	FILE *fp;
 	EVP_PKEY *pkey = NULL;
+	struct stat st;
 
 	if (!keyfile)
 		return NULL;
@@ -261,6 +262,17 @@ EVP_PKEY *read_pub_pkey(const char *keyfile, int x509)
 		return NULL;
 	}
 
+	if (fstat(fileno(fp), &st) == -1) {
+		log_err("Failed to fstat key file: %s\n", keyfile);
+		goto out;
+	}
+
+	if ((st.st_mode & S_IFMT) != S_IFREG) {
+		if (imaevm_params.verbose > LOG_INFO)
+			log_err("Key file is not regular file: %s\n", keyfile);
+		goto out;
+	}
+
 	if (x509) {
 		X509 *crt = d2i_X509_fp(fp, NULL);
 
-- 
2.31.1

