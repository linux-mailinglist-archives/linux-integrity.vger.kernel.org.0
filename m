Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB80D409F8C
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Sep 2021 00:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235332AbhIMWTl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Sep 2021 18:19:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33040 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234971AbhIMWTl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Sep 2021 18:19:41 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18DKxkQt016237
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 18:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=wjHGJfLFp5MELLimnys9VLNA1Buz2chGceJe2ZWXMEs=;
 b=N0LWZOxttIZe5Kmj5mo27yEMGEvVpHDjqiRmGX0BdipqzMlBz4VDD4UF4EWmMhTl86ej
 fIIdCaHvo2elRymfbZ1CoSB3N5VKqvyU45AeaNzHji7klwIto7jx/HvV7jSxwZfHoJsI
 ptzqeAPVNnQZTmua//uYAWd63FwZVsAXcDCieBHzvUCnE1ZTri6g0HYNn7153VbgR5X3
 cwEtGN0krqEPjA8kfoJe7sVEOTdTu1dnuRBO2LZxTqb3Qd+WyEJJc8pXAVvwq7wP59eG
 f/I6hufM0aH+x88/WyxbX72Mkq09m2W8btRwq7r7KnGrJKGVjG8uzb9eIWxRiBJo/7pG 4Q== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3b23jaamnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 18:18:24 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18DMHMEP016618
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 22:18:23 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma04wdc.us.ibm.com with ESMTP id 3b0m3ajw47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 22:18:23 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18DMIMEC17695164
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Sep 2021 22:18:22 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 58D8DBE054;
        Mon, 13 Sep 2021 22:18:22 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0622DBE06F;
        Mon, 13 Sep 2021 22:18:22 +0000 (GMT)
Received: from sbct-2.pok.ibm.com (unknown [9.47.158.152])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 13 Sep 2021 22:18:21 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v4 4/9] evmctl: Define and use an ENGINE field in libimaevm_params
Date:   Mon, 13 Sep 2021 18:18:08 -0400
Message-Id: <20210913221813.2554880-5-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210913221813.2554880-1-stefanb@linux.ibm.com>
References: <20210913221813.2554880-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pe0jw2u8Z_Lww-ftyKR9qb5axGWk9Gxq
X-Proofpoint-ORIG-GUID: pe0jw2u8Z_Lww-ftyKR9qb5axGWk9Gxq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0 spamscore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=789 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109130048
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Extend the global libimaevm_params structure with an ENGINE field 'eng'
and use it in place of the local ENGINE variable in main().

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/evmctl.c | 11 +++++------
 src/imaevm.h |  2 ++
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 4b6f3fb..625a511 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2651,7 +2651,6 @@ static ENGINE *setup_engine(const char *engine_id)
 int main(int argc, char *argv[])
 {
 	int err = 0, c, lind;
-	ENGINE *eng = NULL;
 	unsigned long keyid;
 	char *eptr;
 
@@ -2772,8 +2771,8 @@ int main(int argc, char *argv[])
 			verify_list_sig = 1;
 			break;
 		case 139: /* --engine e */
-			eng = setup_engine(optarg);
-			if (!eng)
+			imaevm_params.eng = setup_engine(optarg);
+			if (!imaevm_params.eng)
 				goto error;
 			break;
 		case 140: /* --xattr-user */
@@ -2849,9 +2848,9 @@ int main(int argc, char *argv[])
 	}
 
 error:
-	if (eng) {
-		ENGINE_finish(eng);
-		ENGINE_free(eng);
+	if (imaevm_params.eng) {
+		ENGINE_finish(imaevm_params.eng);
+		ENGINE_free(imaevm_params.eng);
 #if OPENSSL_API_COMPAT < 0x10100000L
 		ENGINE_cleanup();
 #endif
diff --git a/src/imaevm.h b/src/imaevm.h
index 491f136..8792aa2 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -48,6 +48,7 @@
 #include <errno.h>
 #include <sys/types.h>
 #include <openssl/rsa.h>
+#include <openssl/engine.h>
 
 #ifdef USE_FPRINTF
 #define do_log(level, fmt, args...)	\
@@ -197,6 +198,7 @@ struct libimaevm_params {
 	const char *keyfile;
 	const char *keypass;
 	uint32_t keyid;		/* keyid overriding value, unless 0. (Host order.) */
+	ENGINE *eng;
 };
 
 struct RSA_ASN1_template {
-- 
2.31.1

