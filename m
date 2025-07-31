Return-Path: <linux-integrity+bounces-6749-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 286E6B17634
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Jul 2025 20:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03E32A828C7
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Jul 2025 18:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47359242D63;
	Thu, 31 Jul 2025 18:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VVaerfcH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F9B1C5F06;
	Thu, 31 Jul 2025 18:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753987759; cv=none; b=SkrN3mjJCHeddN5O0DrhpL/Vs5cHUbvkP/9g3fuR7LD37eMr6sVmutEj7PipStaLB260/UUdUo1zhnfcx/tAoGSyeSKL1uCfa63zX+bPYvTPlNYefd9yFnzjIKujH8U3kurJQP6wzb/Nd3VpN/X708DRSwKGMQuJjoOlmtTr97o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753987759; c=relaxed/simple;
	bh=8csK6swCc2bWjZBm+cN1AiKEXk/UxCCqfxJTAeGWQ7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BYw5/UuPr6eT5e3Lum932DMuCaJbJzRuNfuarQSMWqJxBwZFSTqIUuHQQGFmdb3bl/N9yb8LR4eEUwQcovUeZR+ROdP4Wl8KtWnkptOkfuf4WgEGlpUigcPVX4AHPr6It5RI6P+mprVvWDMlJbs0IMdnSKTt+EftXwQv9gJK538=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VVaerfcH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F05C4CEEF;
	Thu, 31 Jul 2025 18:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753987757;
	bh=8csK6swCc2bWjZBm+cN1AiKEXk/UxCCqfxJTAeGWQ7o=;
	h=From:To:Cc:Subject:Date:From;
	b=VVaerfcH4aDZlAFjYkQslTxHfZayd6XU3ZjsLvBoGHbu+s2PAeZII5ESzuExA2C9l
	 RJiKN+3FXKfJIWVfnaZZg6bxrBuGOSOziPc4Dqu7UxVv55LQHdWr+lB94jQWzmS9C7
	 Z7LVCCEy/82EDEwPdJFQHAfMg+7O2CncoBoXrzWQjJyuUhX9P2vq49fhoUu+bUs7oS
	 9h0QOu/DCX9idOtK/ADF9ewvguJUVItVoegtmMyxzS/eJMMBNugTBV4x7KqDtjv2lo
	 UukfCwfh4w62I20hPvJVfQReB7VBBg0U6MzDeYMYedQD9umlJhbaTqsBD+V6t8jU/H
	 SbFIs0X5gBqeQ==
From: Eric Biggers <ebiggers@kernel.org>
To: keyrings@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] KEYS: encrypted: Use SHA-256 library instead of crypto_shash
Date: Thu, 31 Jul 2025 11:47:47 -0700
Message-ID: <20250731184747.12335-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of the "sha256" crypto_shash, just use sha256().  Similarly,
instead of the "hmac(sha256)" crypto_shash, just use
hmac_sha256_usingrawkey().  This is simpler and faster.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 security/keys/Kconfig                    |  3 +-
 security/keys/encrypted-keys/encrypted.c | 63 ++++--------------------
 2 files changed, 11 insertions(+), 55 deletions(-)

diff --git a/security/keys/Kconfig b/security/keys/Kconfig
index d4f5fc1e72638..64477e2c4a212 100644
--- a/security/keys/Kconfig
+++ b/security/keys/Kconfig
@@ -85,14 +85,13 @@ endif
 
 config ENCRYPTED_KEYS
 	tristate "ENCRYPTED KEYS"
 	depends on KEYS
 	select CRYPTO
-	select CRYPTO_HMAC
 	select CRYPTO_AES
 	select CRYPTO_CBC
-	select CRYPTO_SHA256
+	select CRYPTO_LIB_SHA256
 	select CRYPTO_RNG
 	help
 	  This option provides support for create/encrypting/decrypting keys
 	  in the kernel.  Encrypted keys are instantiated using kernel
 	  generated random numbers or provided decrypted data, and are
diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
index 831cb84fd75a1..513c09e2b01cf 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -25,22 +25,19 @@
 #include <linux/random.h>
 #include <linux/rcupdate.h>
 #include <linux/scatterlist.h>
 #include <linux/ctype.h>
 #include <crypto/aes.h>
-#include <crypto/hash.h>
 #include <crypto/sha2.h>
 #include <crypto/skcipher.h>
 #include <crypto/utils.h>
 
 #include "encrypted.h"
 #include "ecryptfs_format.h"
 
 static const char KEY_TRUSTED_PREFIX[] = "trusted:";
 static const char KEY_USER_PREFIX[] = "user:";
-static const char hash_alg[] = "sha256";
-static const char hmac_alg[] = "hmac(sha256)";
 static const char blkcipher_alg[] = "cbc(aes)";
 static const char key_format_default[] = "default";
 static const char key_format_ecryptfs[] = "ecryptfs";
 static const char key_format_enc32[] = "enc32";
 static unsigned int ivsize;
@@ -52,12 +49,10 @@ static int blksize;
 #define HASH_SIZE SHA256_DIGEST_SIZE
 #define MAX_DATA_SIZE 4096
 #define MIN_DATA_SIZE  20
 #define KEY_ENC32_PAYLOAD_LEN 32
 
-static struct crypto_shash *hash_tfm;
-
 enum {
 	Opt_new, Opt_load, Opt_update, Opt_err
 };
 
 enum {
@@ -327,39 +322,18 @@ static struct key *request_user_key(const char *master_desc, const u8 **master_k
 	*master_keylen = upayload->datalen;
 error:
 	return ukey;
 }
 
-static int calc_hmac(u8 *digest, const u8 *key, unsigned int keylen,
-		     const u8 *buf, unsigned int buflen)
-{
-	struct crypto_shash *tfm;
-	int err;
-
-	tfm = crypto_alloc_shash(hmac_alg, 0, 0);
-	if (IS_ERR(tfm)) {
-		pr_err("encrypted_key: can't alloc %s transform: %ld\n",
-		       hmac_alg, PTR_ERR(tfm));
-		return PTR_ERR(tfm);
-	}
-
-	err = crypto_shash_setkey(tfm, key, keylen);
-	if (!err)
-		err = crypto_shash_tfm_digest(tfm, buf, buflen, digest);
-	crypto_free_shash(tfm);
-	return err;
-}
-
 enum derived_key_type { ENC_KEY, AUTH_KEY };
 
 /* Derive authentication/encryption key from trusted key */
 static int get_derived_key(u8 *derived_key, enum derived_key_type key_type,
 			   const u8 *master_key, size_t master_keylen)
 {
 	u8 *derived_buf;
 	unsigned int derived_buf_len;
-	int ret;
 
 	derived_buf_len = strlen("AUTH_KEY") + 1 + master_keylen;
 	if (derived_buf_len < HASH_SIZE)
 		derived_buf_len = HASH_SIZE;
 
@@ -372,14 +346,13 @@ static int get_derived_key(u8 *derived_key, enum derived_key_type key_type,
 	else
 		strcpy(derived_buf, "ENC_KEY");
 
 	memcpy(derived_buf + strlen(derived_buf) + 1, master_key,
 	       master_keylen);
-	ret = crypto_shash_tfm_digest(hash_tfm, derived_buf, derived_buf_len,
-				      derived_key);
+	sha256(derived_buf, derived_buf_len, derived_key);
 	kfree_sensitive(derived_buf);
-	return ret;
+	return 0;
 }
 
 static struct skcipher_request *init_skcipher_req(const u8 *key,
 						  unsigned int key_len)
 {
@@ -501,14 +474,14 @@ static int datablob_hmac_append(struct encrypted_key_payload *epayload,
 	ret = get_derived_key(derived_key, AUTH_KEY, master_key, master_keylen);
 	if (ret < 0)
 		goto out;
 
 	digest = epayload->format + epayload->datablob_len;
-	ret = calc_hmac(digest, derived_key, sizeof derived_key,
-			epayload->format, epayload->datablob_len);
-	if (!ret)
-		dump_hmac(NULL, digest, HASH_SIZE);
+	hmac_sha256_usingrawkey(derived_key, sizeof(derived_key),
+				epayload->format, epayload->datablob_len,
+				digest);
+	dump_hmac(NULL, digest, HASH_SIZE);
 out:
 	memzero_explicit(derived_key, sizeof(derived_key));
 	return ret;
 }
 
@@ -532,13 +505,12 @@ static int datablob_hmac_verify(struct encrypted_key_payload *epayload,
 		p = epayload->master_desc;
 		len -= strlen(epayload->format) + 1;
 	} else
 		p = epayload->format;
 
-	ret = calc_hmac(digest, derived_key, sizeof derived_key, p, len);
-	if (ret < 0)
-		goto out;
+	hmac_sha256_usingrawkey(derived_key, sizeof(derived_key), p, len,
+				digest);
 	ret = crypto_memneq(digest, epayload->format + epayload->datablob_len,
 			    sizeof(digest));
 	if (ret) {
 		ret = -EINVAL;
 		dump_hmac("datablob",
@@ -1009,33 +981,18 @@ EXPORT_SYMBOL_GPL(key_type_encrypted);
 
 static int __init init_encrypted(void)
 {
 	int ret;
 
-	hash_tfm = crypto_alloc_shash(hash_alg, 0, 0);
-	if (IS_ERR(hash_tfm)) {
-		pr_err("encrypted_key: can't allocate %s transform: %ld\n",
-		       hash_alg, PTR_ERR(hash_tfm));
-		return PTR_ERR(hash_tfm);
-	}
-
 	ret = aes_get_sizes();
 	if (ret < 0)
-		goto out;
-	ret = register_key_type(&key_type_encrypted);
-	if (ret < 0)
-		goto out;
-	return 0;
-out:
-	crypto_free_shash(hash_tfm);
-	return ret;
-
+		return ret;
+	return register_key_type(&key_type_encrypted);
 }
 
 static void __exit cleanup_encrypted(void)
 {
-	crypto_free_shash(hash_tfm);
 	unregister_key_type(&key_type_encrypted);
 }
 
 late_initcall(init_encrypted);
 module_exit(cleanup_encrypted);

base-commit: d6084bb815c453de27af8071a23163a711586a6c
-- 
2.50.1


