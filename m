Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E625A58B5
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Aug 2022 03:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiH3BBA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Aug 2022 21:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiH3BA6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Aug 2022 21:00:58 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750B89E116
        for <linux-integrity@vger.kernel.org>; Mon, 29 Aug 2022 18:00:57 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27U0kfeU013920;
        Tue, 30 Aug 2022 01:00:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Xw5RzkvWDuFt4ms2okEmdcGg53AlMaKqPaxVzFBNADA=;
 b=fT0eSXnFF/KyzaozD8XcTTQh9ODpRxeKS/cX0Rkbi3geqY0w0+DQKcxjbfcyuct1FZdd
 rve0m7j8SRli84v5xuEJ1MsHdCyIahVLvUT54TME6SsYQ1LXXQ7AUYytcD4iwkOkfseG
 hvVHI9yc0pl5e1E7cbr5JKCiRXC/mbFCzSjqQl++xvH9gLHz83lVwmZvLQHscpUvpId4
 Zncty5izrPKajcxOimrncLBKPDIL2hI5u7MfcV+F13kbovAxU50Scr+cQSDDLtlWZ2k6
 SHiYD5NAQnU4mecN5/YCQCItqgcA/Qm/z/nuhg3wZXBZdsxLZ7xacIQ/SMR+dcFI1+HA iA== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j98a7gf67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 01:00:53 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27U0oCgH012775;
        Tue, 30 Aug 2022 00:59:59 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 3j7ahht5kf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 00:59:59 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27U0xuIe37486956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Aug 2022 00:59:56 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E16B3A4040;
        Tue, 30 Aug 2022 00:59:55 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0D0DA4051;
        Tue, 30 Aug 2022 00:59:54 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.211.117.120])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 30 Aug 2022 00:59:54 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [RFC PATCH ima-evm-utils 06/11] Replace the low level HMAC calls when calculating the EVM HMAC
Date:   Mon, 29 Aug 2022 20:59:31 -0400
Message-Id: <20220830005936.189922-7-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220830005936.189922-1-zohar@linux.ibm.com>
References: <20220830005936.189922-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TlvB7Sbr-NwTsQ3YJ4KIQrukFSepzPPg
X-Proofpoint-GUID: TlvB7Sbr-NwTsQ3YJ4KIQrukFSepzPPg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_13,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208290107
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

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 57 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 32 insertions(+), 25 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 6534950f3683..913b85f6b620 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1160,12 +1160,12 @@ static int cmd_setxattr_ima(struct command *cmd)
 
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
@@ -1176,10 +1176,8 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
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
@@ -1227,19 +1225,26 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
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
@@ -1250,12 +1255,12 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
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
@@ -1294,23 +1299,24 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
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
@@ -1334,6 +1340,7 @@ static int hmac_evm(const char *file, const char *key)
 		err = lsetxattr(file, xattr_evm, sig, len + 1, 0);
 		if (err < 0) {
 			log_err("setxattr failed: %s\n", file);
+			errno = 0;
 			return err;
 		}
 	}
-- 
2.31.1

