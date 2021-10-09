Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C78B2427A71
	for <lists+linux-integrity@lfdr.de>; Sat,  9 Oct 2021 15:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbhJINKd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 9 Oct 2021 09:10:33 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:48112 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233117AbhJINKb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 9 Oct 2021 09:10:31 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0Ur7b0Ea_1633784909;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0Ur7b0Ea_1633784909)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 09 Oct 2021 21:08:30 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-security-module@vger.kernel.org
Cc:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH 1/2] crypto: use SM3 instead of SM3_256
Date:   Sat,  9 Oct 2021 21:08:27 +0800
Message-Id: <20211009130828.101396-2-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.3.ge56e4f7
In-Reply-To: <20211009130828.101396-1-tianjia.zhang@linux.alibaba.com>
References: <20211009130828.101396-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

According to https://tools.ietf.org/id/draft-oscca-cfrg-sm3-01.html,
SM3 always produces a 256-bit hash value and there are no plans for
other length development, so there is no ambiguity in the name of sm3.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 Documentation/security/keys/trusted-encrypted.rst | 2 +-
 crypto/hash_info.c                                | 4 ++--
 drivers/char/tpm/tpm2-cmd.c                       | 2 +-
 include/crypto/hash_info.h                        | 2 +-
 include/uapi/linux/hash_info.h                    | 2 +-
 security/keys/trusted-keys/trusted_tpm2.c         | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
index 80d5a5af62a1..3292461517f6 100644
--- a/Documentation/security/keys/trusted-encrypted.rst
+++ b/Documentation/security/keys/trusted-encrypted.rst
@@ -162,7 +162,7 @@ Usage::
                      default 1 (resealing allowed)
        hash=         hash algorithm name as a string. For TPM 1.x the only
                      allowed value is sha1. For TPM 2.x the allowed values
-                     are sha1, sha256, sha384, sha512 and sm3-256.
+                     are sha1, sha256, sha384, sha512 and sm3.
        policydigest= digest for the authorization policy. must be calculated
                      with the same hash algorithm as specified by the 'hash='
                      option.
diff --git a/crypto/hash_info.c b/crypto/hash_info.c
index a49ff96bde77..fe0119407219 100644
--- a/crypto/hash_info.c
+++ b/crypto/hash_info.c
@@ -26,7 +26,7 @@ const char *const hash_algo_name[HASH_ALGO__LAST] = {
 	[HASH_ALGO_TGR_128]	= "tgr128",
 	[HASH_ALGO_TGR_160]	= "tgr160",
 	[HASH_ALGO_TGR_192]	= "tgr192",
-	[HASH_ALGO_SM3_256]	= "sm3",
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
index a25815a6f625..20f55de9d87b 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -19,7 +19,7 @@ static struct tpm2_hash tpm2_hash_map[] = {
 	{HASH_ALGO_SHA256, TPM_ALG_SHA256},
 	{HASH_ALGO_SHA384, TPM_ALG_SHA384},
 	{HASH_ALGO_SHA512, TPM_ALG_SHA512},
-	{HASH_ALGO_SM3_256, TPM_ALG_SM3_256},
+	{HASH_ALGO_SM3, TPM_ALG_SM3_256},
 };
 
 int tpm2_get_timeouts(struct tpm_chip *chip)
diff --git a/include/crypto/hash_info.h b/include/crypto/hash_info.h
index dd4f06785049..c1e6b2884732 100644
--- a/include/crypto/hash_info.h
+++ b/include/crypto/hash_info.h
@@ -32,7 +32,7 @@
 #define TGR192_DIGEST_SIZE 24
 
 /* not defined in include/crypto/ */
-#define SM3256_DIGEST_SIZE 32
+#define SM3_DIGEST_SIZE 32
 
 extern const char *const hash_algo_name[HASH_ALGO__LAST];
 extern const int hash_digest_size[HASH_ALGO__LAST];
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
index 0165da386289..52a696035176 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -23,7 +23,7 @@ static struct tpm2_hash tpm2_hash_map[] = {
 	{HASH_ALGO_SHA256, TPM_ALG_SHA256},
 	{HASH_ALGO_SHA384, TPM_ALG_SHA384},
 	{HASH_ALGO_SHA512, TPM_ALG_SHA512},
-	{HASH_ALGO_SM3_256, TPM_ALG_SM3_256},
+	{HASH_ALGO_SM3, TPM_ALG_SM3_256},
 };
 
 static u32 tpm2key_oid[] = { 2, 23, 133, 10, 1, 5 };
-- 
2.19.1.3.ge56e4f7

