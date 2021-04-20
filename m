Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95884365F47
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Apr 2021 20:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbhDTSbJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Apr 2021 14:31:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64388 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233558AbhDTSbD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Apr 2021 14:31:03 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13KI43bF018900
        for <linux-integrity@vger.kernel.org>; Tue, 20 Apr 2021 14:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=0H/PsC6xAwk/MfxDLacEJza/zj+fdEXBUYeTAc+WhFA=;
 b=anSTk/B+l7xRIMBip5bhlB1br3JXpm+oi/yv3fhn6gJ8RbnjULkw2nvQF1z/K4gyQCQ5
 cyAzM6HSduW/ye7dt7vN6G+lB6DZdNf90bG1tBqRJTamvz0MRsZHhtk00ytjYeFVbMBC
 MeGT6+V0uHou6ANzFU5sOp2VXkWghM4f5pbtK8Q+I1kQdUdpnI+05GXsgvWAlQ/6oEqd
 HrYGEJHtIVpNlCfWK4eNe6gnp/v7TfUdqo2DbheWaNX9Uwjw13q2rvYv5QAjKrnqYTz4
 6jcRFTZNdj5MEzI5uzqCky5srXB6rt7g84gdGbOfABLV26LzkTPjsr7ERrSR7JYo+xqh mw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3822vc2q0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 20 Apr 2021 14:30:25 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13KI49Yo019665
        for <linux-integrity@vger.kernel.org>; Tue, 20 Apr 2021 14:30:25 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3822vc2pyp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Apr 2021 14:30:25 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13KIMnJj006484;
        Tue, 20 Apr 2021 18:30:23 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma05wdc.us.ibm.com with ESMTP id 37yqa948d0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Apr 2021 18:30:23 +0000
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13KIUMhX14811486
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 18:30:22 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA3AE6E056;
        Tue, 20 Apr 2021 18:30:22 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 819DA6E053;
        Tue, 20 Apr 2021 18:30:22 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.47.158.155])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 20 Apr 2021 18:30:22 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 3/3] libimaevm: Have sign_hash_v2 call sign_hash_v2_pkey after reading key file
Date:   Tue, 20 Apr 2021 14:30:15 -0400
Message-Id: <20210420183015.861644-4-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210420183015.861644-1-stefanb@linux.ibm.com>
References: <20210420183015.861644-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3FZff-UK34t4EQUXGWXiOz6mNQWZyAs-
X-Proofpoint-ORIG-GUID: 9EEE0ITLpK9YSLMtEaSYmvEqa-t4Qh-x
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-20_08:2021-04-20,2021-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 mlxscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104200123
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Have sign_hash_v2 call sign_hash_v2_pkey after reading the key file.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/libimaevm.c | 65 ++++++++-----------------------------------------
 1 file changed, 10 insertions(+), 55 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index bb425af..f7f070c 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -991,15 +991,9 @@ err:
 static int sign_hash_v2(const char *algo, const unsigned char *hash,
 			int size, const char *keyfile, unsigned char *sig)
 {
-	struct signature_v2_hdr *hdr;
-	int len = -1;
+	char *error = NULL;
 	EVP_PKEY *pkey;
-	char name[20];
-	EVP_PKEY_CTX *ctx = NULL;
-	const EVP_MD *md;
-	size_t sigsize;
-	const char *st;
-	uint32_t keyid;
+	int len = -1;
 
 	if (!hash) {
 		log_err("sign_hash_v2: hash is null\n");
@@ -1011,16 +1005,6 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
 		return -1;
 	}
 
-	if (!sig) {
-		log_err("sign_hash_v2: sig is null\n");
-		return -1;
-	}
-
-	if (!algo) {
-		log_err("sign_hash_v2: algo is null\n");
-		return -1;
-	}
-
 	log_info("hash(%s): ", imaevm_params.hash_algo);
 	log_dump(hash, size);
 
@@ -1028,49 +1012,20 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
 	if (!pkey)
 		return -1;
 
-	hdr = (struct signature_v2_hdr *)sig;
-	hdr->version = (uint8_t) DIGSIG_VERSION_2;
-
-	hdr->hash_algo = imaevm_get_hash_algo(algo);
-	if (hdr->hash_algo == (uint8_t)-1) {
-		log_err("sign_hash_v2: hash algo is unknown: %s\n", algo);
-		return -1;
-	}
-
-	calc_keyid_v2(&keyid, name, pkey);
-	hdr->keyid = keyid;
-
-	st = "EVP_PKEY_CTX_new";
-	if (!(ctx = EVP_PKEY_CTX_new(pkey, NULL)))
-		goto err;
-	st = "EVP_PKEY_sign_init";
-	if (!EVP_PKEY_sign_init(ctx))
-		goto err;
-	st = "EVP_get_digestbyname";
-	if (!(md = EVP_get_digestbyname(imaevm_params.hash_algo)))
-		goto err;
-	st = "EVP_PKEY_CTX_set_signature_md";
-	if (!EVP_PKEY_CTX_set_signature_md(ctx, md))
-		goto err;
-	st = "EVP_PKEY_sign";
-	sigsize = MAX_SIGNATURE_SIZE - sizeof(struct signature_v2_hdr) - 1;
-	if (!EVP_PKEY_sign(ctx, hdr->sig, &sigsize, hash, size))
+	len = sign_hash_v2_pkey(algo, hash, size, pkey, sig, MAX_SIGNATURE_SIZE - 1,
+	                        &error);
+	if (len < 0) {
+		log_err("%s\n", error);
+		output_openssl_errors();
 		goto err;
-	len = (int)sigsize;
+	}
 
-	/* we add bit length of the signature to make it gnupg compatible */
-	hdr->sig_size = __cpu_to_be16(len);
-	len += sizeof(*hdr);
 	log_info("evm/ima signature: %d bytes\n", len);
 
 err:
-	if (len == -1) {
-		log_err("sign_hash_v2: signing failed: (%s) in %s\n",
-			ERR_reason_error_string(ERR_peek_error()), st);
-		output_openssl_errors();
-	}
-	EVP_PKEY_CTX_free(ctx);
+	free(error);
 	EVP_PKEY_free(pkey);
+
 	return len;
 }
 
-- 
2.30.2

