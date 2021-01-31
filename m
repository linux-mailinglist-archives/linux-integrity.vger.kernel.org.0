Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E404E309A13
	for <lists+linux-integrity@lfdr.de>; Sun, 31 Jan 2021 04:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbhAaD2H (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 30 Jan 2021 22:28:07 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:51033 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229468AbhAaD2H (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 30 Jan 2021 22:28:07 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UNMfCVs_1612063641;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UNMfCVs_1612063641)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 31 Jan 2021 11:27:21 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        linux-integrity@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>
Cc:     tianjia.zhang@linux.alibaba.com
Subject: [PATCH ima-evm-utils] ima-evm-utils: ima_sign supports SM2 and SM3 algorithm combination
Date:   Sun, 31 Jan 2021 11:27:21 +0800
Message-Id: <20210131032721.79050-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.3.ge56e4f7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The combination of SM2 and SM3 algorithms has been implemented in the
kernel. At present, the ima-evm-utils signature tool does not support
this combination of algorithms. This is because SM2 sign require a
USERID, which requires the use of a higher-level sign functions of
OpenSSL. this patch use the EVP_DigestSign series of functions to
sign to support various signature algorithm combinations.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 src/libimaevm.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index fa6c278..89b9b88 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -891,6 +891,7 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
 	EVP_PKEY *pkey;
 	char name[20];
 	EVP_PKEY_CTX *ctx = NULL;
+	EVP_MD_CTX *mctx = NULL;
 	const EVP_MD *md;
 	size_t sigsize;
 	const char *st;
@@ -932,24 +933,47 @@ static int sign_hash_v2(const char *algo, const unsigned char *hash,
 		return -1;
 	}
 
+#if OPENSSL_VERSION_NUMBER < 0x30000000
+	/*
+	 * SM2 and SM3 should go together. If SM3 hash algorithm and EC private
+	 * key are used at the same time, check whether it is SM2 private key.
+	 */
+	if (hdr->hash_algo == PKEY_HASH_SM3_256 && EVP_PKEY_id(pkey) == EVP_PKEY_EC) {
+		EC_KEY *ec = EVP_PKEY_get0_EC_KEY(pkey);
+		int curve = EC_GROUP_get_curve_name(EC_KEY_get0_group(ec));
+		if (curve == NID_sm2)
+			EVP_PKEY_set_alias_type(pkey, EVP_PKEY_SM2);
+	}
+#endif
+
 	calc_keyid_v2(&keyid, name, pkey);
 	hdr->keyid = keyid;
 
 	st = "EVP_PKEY_CTX_new";
 	if (!(ctx = EVP_PKEY_CTX_new(pkey, NULL)))
 		goto err;
-	st = "EVP_PKEY_sign_init";
-	if (!EVP_PKEY_sign_init(ctx))
+	st = "EVP_MD_CTX_new";
+	if (!(mctx = EVP_MD_CTX_new()))
 		goto err;
+	if (EVP_PKEY_id(pkey) == EVP_PKEY_SM2) {
+		st = "EVP_PKEY_CTX_set1_id";
+		/* Set SM2 default userid */
+		if (!EVP_PKEY_CTX_set1_id(ctx, "1234567812345678", 16))
+			goto err;
+	}
+	EVP_MD_CTX_set_pkey_ctx(mctx, ctx);
 	st = "EVP_get_digestbyname";
 	if (!(md = EVP_get_digestbyname(imaevm_params.hash_algo)))
 		goto err;
-	st = "EVP_PKEY_CTX_set_signature_md";
-	if (!EVP_PKEY_CTX_set_signature_md(ctx, md))
+	st = "EVP_DigestSignInit";
+	if (!EVP_DigestSignInit(mctx, NULL, md, NULL, pkey))
+		goto err;
+	st = "EVP_DigestSignUpdate";
+	if (!EVP_DigestSignUpdate(mctx, hash, size))
 		goto err;
-	st = "EVP_PKEY_sign";
+	st = "EVP_DigestSignFinal";
 	sigsize = MAX_SIGNATURE_SIZE - sizeof(struct signature_v2_hdr) - 1;
-	if (!EVP_PKEY_sign(ctx, hdr->sig, &sigsize, hash, size))
+	if (!EVP_DigestSignFinal(mctx, hdr->sig, &sigsize))
 		goto err;
 	len = (int)sigsize;
 
@@ -964,6 +988,7 @@ err:
 			ERR_reason_error_string(ERR_peek_error()), st);
 		output_openssl_errors();
 	}
+	EVP_MD_CTX_free(mctx);
 	EVP_PKEY_CTX_free(ctx);
 	EVP_PKEY_free(pkey);
 	return len;
-- 
2.19.1.3.ge56e4f7

