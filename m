Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6710160ECC
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Feb 2020 10:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbgBQJhJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Feb 2020 04:37:09 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:55970 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728698AbgBQJhI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Feb 2020 04:37:08 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0Tq9UD5i_1581932217;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0Tq9UD5i_1581932217)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 17 Feb 2020 17:36:57 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com,
        ebiggers@kernel.org, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com
Cc:     linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] crypto: fix mismatched hash algorithm name sm3-256 to sm3
Date:   Mon, 17 Feb 2020 17:36:48 +0800
Message-Id: <20200217093649.97938-2-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200217093649.97938-1-tianjia.zhang@linux.alibaba.com>
References: <20200217093649.97938-1-tianjia.zhang@linux.alibaba.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The name sm3-256 is defined in hash_algo_name in hash_info, but the
algorithm name implemented in sm3_generic.c is sm3, which will cause
the sm3-256 algorithm to be not found in some application scenarios of
the hash algorithm, and an ENOENT error will occur. For example,
IMA, keys, and other subsystems that reference hash_algo_name all use
the hash algorithm of sm3.

According to https://tools.ietf.org/id/draft-oscca-cfrg-sm3-01.html,
SM3 always produces a 256-bit hash value and there are no plans for
other length development, so there is no ambiguity in the name of sm3.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 Documentation/security/keys/trusted-encrypted.rst | 2 +-
 crypto/hash_info.c                                | 4 ++--
 drivers/char/tpm/tpm2-cmd.c                       | 2 +-
 include/crypto/hash_info.h                        | 2 +-
 include/linux/tpm.h                               | 2 +-
 include/uapi/linux/hash_info.h                    | 2 +-
 security/keys/trusted-keys/trusted_tpm2.c         | 2 +-
 7 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
index 50ac8bcd6970..5b6fea88f335 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -66,7 +66,7 @@ Usage::
                      default 1 (resealing allowed)
        hash=         hash algorithm name as a string. For TPM 1.x the only
                      allowed value is sha1. For TPM 2.x the allowed values
-                     are sha1, sha256, sha384, sha512 and sm3-256.
+                     are sha1, sha256, sha384, sha512 and sm3.
        policydigest= digest for the authorization policy. must be calculated
                      with the same hash algorithm as specified by the 'hash='
                      option.
diff --git a/crypto/hash_info.c b/crypto/hash_info.c
index c754cb75dd1a..fe0119407219 100644
--- a/crypto/hash_info.c
+++ b/crypto/hash_info.c
@@ -26,7 +26,7 @@ const char *const hash_algo_name[HASH_ALGO__LAST] = {
 	[HASH_ALGO_TGR_128]	= "tgr128",
 	[HASH_ALGO_TGR_160]	= "tgr160",
 	[HASH_ALGO_TGR_192]	= "tgr192",
-	[HASH_ALGO_SM3_256]	= "sm3-256",
+	[HASH_ALGO_SM3]		= "sm3",
 	[HASH_ALGO_STREEBOG_256] = "streebog256",
 	[HASH_ALGO_STREEBOG_512] = "streebog512",
 };
@@ -50,7 +50,7 @@ const int hash_digest_size[HASH_ALGO__LAST] = {
 	[HASH_ALGO_TGR_128]	= TGR128_DIGEST_SIZE,
 	[HASH_ALGO_TGR_160]	= TGR160_DIGEST_SIZE,
 	[HASH_ALGO_TGR_192]	= TGR192_DIGEST_SIZE,
-	[HASH_ALGO_SM3_256]	= SM3256_DIGEST_SIZE,
+	[HASH_ALGO_SM3]		= SM3_DIGEST_SIZE,
 	[HASH_ALGO_STREEBOG_256] = STREEBOG256_DIGEST_SIZE,
 	[HASH_ALGO_STREEBOG_512] = STREEBOG512_DIGEST_SIZE,
 };
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 13696deceae8..44412538e47c 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -19,7 +19,7 @@ static struct tpm2_hash tpm2_hash_map[] = {
 	{HASH_ALGO_SHA256, TPM_ALG_SHA256},
 	{HASH_ALGO_SHA384, TPM_ALG_SHA384},
 	{HASH_ALGO_SHA512, TPM_ALG_SHA512},
-	{HASH_ALGO_SM3_256, TPM_ALG_SM3_256},
+	{HASH_ALGO_SM3, TPM_ALG_SM3},
 };
 
 int tpm2_get_timeouts(struct tpm_chip *chip)
diff --git a/include/crypto/hash_info.h b/include/crypto/hash_info.h
index eb9d2e368969..07cd6e0b0fee 100644
--- a/include/crypto/hash_info.h
+++ b/include/crypto/hash_info.h
@@ -31,7 +31,7 @@
 #define TGR192_DIGEST_SIZE 24
 
 /* not defined in include/crypto/ */
-#define SM3256_DIGEST_SIZE 32
+#define SM3_DIGEST_SIZE 32
 
 extern const char *const hash_algo_name[HASH_ALGO__LAST];
 extern const int hash_digest_size[HASH_ALGO__LAST];
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 03e9b184411b..042c3eb5f051 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -39,7 +39,7 @@ enum tpm_algorithms {
 	TPM_ALG_SHA384		= 0x000C,
 	TPM_ALG_SHA512		= 0x000D,
 	TPM_ALG_NULL		= 0x0010,
-	TPM_ALG_SM3_256		= 0x0012,
+	TPM_ALG_SM3		= 0x0012,
 };
 
 struct tpm_digest {
diff --git a/include/uapi/linux/hash_info.h b/include/uapi/linux/hash_info.h
index 74a8609fcb4d..1355525dd4aa 100644
--- a/include/uapi/linux/hash_info.h
+++ b/include/uapi/linux/hash_info.h
@@ -32,7 +32,7 @@ enum hash_algo {
 	HASH_ALGO_TGR_128,
 	HASH_ALGO_TGR_160,
 	HASH_ALGO_TGR_192,
-	HASH_ALGO_SM3_256,
+	HASH_ALGO_SM3,
 	HASH_ALGO_STREEBOG_256,
 	HASH_ALGO_STREEBOG_512,
 	HASH_ALGO__LAST
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 08ec7f48f01d..cbd5574a88c8 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -17,7 +17,7 @@ static struct tpm2_hash tpm2_hash_map[] = {
 	{HASH_ALGO_SHA256, TPM_ALG_SHA256},
 	{HASH_ALGO_SHA384, TPM_ALG_SHA384},
 	{HASH_ALGO_SHA512, TPM_ALG_SHA512},
-	{HASH_ALGO_SM3_256, TPM_ALG_SM3_256},
+	{HASH_ALGO_SM3, TPM_ALG_SM3},
 };
 
 /**
-- 
2.17.1

