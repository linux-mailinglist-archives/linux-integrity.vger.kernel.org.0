Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104FD3E5C1B
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Aug 2021 15:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238309AbhHJNrX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Aug 2021 09:47:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26796 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238288AbhHJNrX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Aug 2021 09:47:23 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17ADZI3g076846
        for <linux-integrity@vger.kernel.org>; Tue, 10 Aug 2021 09:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=9n30euOzcCAjMwq0mwEJRhi+xXhekyNHYt00fUhShWE=;
 b=DpyaVWsc5LCsj5eCrSf/7uhEw2wWB1PY7C0aB+2Q6fAaA0HZggFLIzI/Uom6LJpH6HmO
 8gKXw5neEdXu/uIQqBoHtJCrmysEtGXnUz7+KjS/Pu0dgSOJr6zT7bA/147/9agSq6Tz
 QK3v2CW98mR7H9tpkQbczYsGytaqNXGwTQqVll/0Y+a+5vwtrm33UEwLdwIX5vIWc1zH
 1Oyh2GntfyiOQWyESlNh9WV1pJVitOB6eGCEHbXxT68DdN4umqErsxy4k9hGpsi6dKC4
 untEyYtAzJWBxWBruy8/rIqDkzAh2lXVoAxwXZ7BldNsdoCQyIxnOtxvBBpAUcb8ltaD SQ== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3abkndkfkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 10 Aug 2021 09:47:01 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 17ADh8ZY010286
        for <linux-integrity@vger.kernel.org>; Tue, 10 Aug 2021 13:47:00 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma05wdc.us.ibm.com with ESMTP id 3a9htbv413-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 10 Aug 2021 13:47:00 +0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 17ADjxf530540144
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 13:45:59 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4232DB2071;
        Tue, 10 Aug 2021 13:45:59 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 34436B2082;
        Tue, 10 Aug 2021 13:45:59 +0000 (GMT)
Received: from sbct-2.. (unknown [9.47.158.152])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 10 Aug 2021 13:45:59 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.vnet.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 4/8] evmctl: Extend libimaevm_params with ENGINE field and use it
Date:   Tue, 10 Aug 2021 09:45:53 -0400
Message-Id: <20210810134557.2444863-5-stefanb@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210810134557.2444863-1-stefanb@linux.vnet.ibm.com>
References: <20210810134557.2444863-1-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ENux57DuXneTb3QyKtTaf45ikvm5mkgR
X-Proofpoint-GUID: ENux57DuXneTb3QyKtTaf45ikvm5mkgR
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-10_05:2021-08-10,2021-08-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=743 impostorscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108100087
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

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

