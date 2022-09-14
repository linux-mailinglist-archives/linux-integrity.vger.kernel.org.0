Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910C95B7EF6
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Sep 2022 04:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiINCaT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 13 Sep 2022 22:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiINCaS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 13 Sep 2022 22:30:18 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6685B4507D
        for <linux-integrity@vger.kernel.org>; Tue, 13 Sep 2022 19:30:15 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28E2N0BJ012443;
        Wed, 14 Sep 2022 02:30:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=JjFObJdu+i+lj8LbsPGzkBLkTS7fnDG4hTTvTkuUpJk=;
 b=knQ/kR5oM+JbMdlyH2xy7KG1Pom29biusKKH/70UV7EUw5F8/T4U6ba4WgyULvm/B3Hx
 k7cKPZUzqLm8WbSP3jW1W0RkK810u40hNrHua+qY0uqGqaqYql6EGoqmQw7o4rC8o9QF
 7TgznGIt8Tfladi6WLBKbfmVG2TUxLoPbCbIsodGvWyY747PN8isrz/tDSHrFzrhzRz2
 nCufnTURJula8Cm69cgI3F+/yTY0ddzk6HAc8Yd5uT08gjE9Qfi1e33ZAa2zGJJuFyuC
 xu/orTezveuvhj7ZT2YwY7f16k2WcD16e33PdUeY9VVGd6B5r0zG/xOXBQI1+mN6ZEdo 8g== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jk64fr3g6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 02:30:11 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28E2KVr2026673;
        Wed, 14 Sep 2022 02:30:09 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3jjytx0auv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Sep 2022 02:30:09 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28E2U5d743254156
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 02:30:05 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C04D3A4051;
        Wed, 14 Sep 2022 02:30:05 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0761FA4040;
        Wed, 14 Sep 2022 02:30:05 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.29.234])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 14 Sep 2022 02:30:04 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils v3 05/15] Replace the low level HMAC calls when calculating the EVM HMAC
Date:   Tue, 13 Sep 2022 22:29:46 -0400
Message-Id: <20220914022956.1359218-6-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220914022956.1359218-1-zohar@linux.ibm.com>
References: <20220914022956.1359218-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8b-oB106q9MjnKMsQDIqSYk8Hw3mEzqR
X-Proofpoint-ORIG-GUID: 8b-oB106q9MjnKMsQDIqSYk8Hw3mEzqR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_12,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140008
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Calculating the EVM HMAC and labeling the filesystem was originally
included in ima-evm-utils for debugging purposes only.  For now,
instead of removing EVM HMAC support just replace the low level
HMAC_ calls with EVP_ calls.

The '-a, --hashalgo' specifies the IMA hash or signature algorithm.
The kernel EVM HMAC is limited to SHA1.  Fix ima-evm-utils by hard
coding the EVM HMAC algorithm to SHA1.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 58 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 25 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 641504047a36..27d2061f23be 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -61,6 +61,7 @@
 #include <openssl/asn1.h>
 #include <openssl/sha.h>
 #include <openssl/pem.h>
+#include <openssl/evp.h>
 #include <openssl/hmac.h>
 #include <openssl/err.h>
 #include <openssl/rsa.h>
@@ -1159,12 +1160,12 @@ static int cmd_setxattr_ima(struct command *cmd)
 
 static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *hash)
 {
-        const EVP_MD *md;
+	size_t mdlen;
+	EVP_MD_CTX *pctx;
+	EVP_PKEY *pkey = NULL;
 	struct stat st;
 	int err = -1;
 	uint32_t generation = 0;
-	HMAC_CTX *pctx;
-	unsigned int mdlen;
 	char **xattrname;
 	unsigned char xattr_value[1024];
 	unsigned char *key;
@@ -1175,10 +1176,8 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
 	struct h_misc_64 hmac_misc;
 	int hmac_size;
 #if OPENSSL_VERSION_NUMBER < 0x10100000
-	HMAC_CTX ctx;
+	EVP_MD_CTX ctx;
 	pctx = &ctx;
-#else
-	pctx = HMAC_CTX_new();
 #endif
 
 	key = file2bin(keyfile, NULL, &keylen);
@@ -1226,19 +1225,26 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
 		goto out;
 	}
 
-	md = EVP_get_digestbyname(imaevm_params.hash_algo);
-	if (!md) {
-		log_err("EVP_get_digestbyname(%s) failed\n",
-			imaevm_params.hash_algo);
+#if OPENSSL_VERSION_NUMBER >= 0x10100000
+	pctx = EVP_MD_CTX_new();
+	if (!pctx) {
+		log_err("EVP_MD_CTX_new failed\n");
 		goto out;
 	}
+#endif
 
-	err = !HMAC_Init_ex(pctx, evmkey, sizeof(evmkey), md, NULL);
-	if (err) {
+	pkey = EVP_PKEY_new_mac_key(EVP_PKEY_HMAC, NULL, evmkey, sizeof(evmkey));
+	if (!pkey) {
 		log_err("HMAC_Init() failed\n");
 		goto out;
 	}
 
+	err = EVP_DigestSignInit(pctx, NULL, EVP_sha1(), NULL, pkey);
+	if (err != 1) {
+		log_err("EVP_DigestSignInit() failed\n");
+		goto out;
+	}
+
 	for (xattrname = evm_config_xattrnames; *xattrname != NULL; xattrname++) {
 		err = lgetxattr(file, *xattrname, xattr_value, sizeof(xattr_value));
 		if (err < 0) {
@@ -1249,12 +1255,12 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
 			log_info("skipping xattr: %s\n", *xattrname);
 			continue;
 		}
-		/*log_debug("name: %s, value: %s, size: %d\n", *xattrname, xattr_value, err);*/
 		log_info("name: %s, size: %d\n", *xattrname, err);
 		log_debug_dump(xattr_value, err);
-		err = !HMAC_Update(pctx, xattr_value, err);
-		if (err) {
-			log_err("HMAC_Update() failed\n");
+
+		err = EVP_DigestSignUpdate(pctx, xattr_value, err);
+		if (err != 1) {
+			log_err("EVP_DigestSignUpdate() failed\n");
 			goto out_ctx_cleanup;
 		}
 	}
@@ -1293,23 +1299,24 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
 	log_debug("hmac_misc (%d): ", hmac_size);
 	log_debug_dump(&hmac_misc, hmac_size);
 
-	err = !HMAC_Update(pctx, (const unsigned char *)&hmac_misc, hmac_size);
-	if (err) {
+	err = EVP_DigestSignUpdate(pctx, &hmac_misc, hmac_size);
+	if (err != 1) {
 		log_err("HMAC_Update() failed\n");
 		goto out_ctx_cleanup;
 	}
-	err = !HMAC_Final(pctx, hash, &mdlen);
-	if (err)
+	err = EVP_DigestSignFinal(pctx, hash, &mdlen);
+	if (err != 1)
 		log_err("HMAC_Final() failed\n");
 out_ctx_cleanup:
-#if OPENSSL_VERSION_NUMBER < 0x10100000
-	HMAC_CTX_cleanup(pctx);
-#else
-	HMAC_CTX_free(pctx);
+	EVP_PKEY_free(pkey);
+#if OPENSSL_VERSION_NUMBER >= 0x10100000
+	EVP_MD_CTX_free(pctx);
 #endif
 out:
 	free(key);
-	return err ?: mdlen;
+	if (err == 1)
+		return mdlen;
+	return err;
 }
 
 static int hmac_evm(const char *file, const char *key)
@@ -1333,6 +1340,7 @@ static int hmac_evm(const char *file, const char *key)
 		err = lsetxattr(file, xattr_evm, sig, len + 1, 0);
 		if (err < 0) {
 			log_err("setxattr failed: %s\n", file);
+			errno = 0;
 			return err;
 		}
 	}
-- 
2.31.1

