Return-Path: <linux-integrity+bounces-6855-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42129B2758E
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Aug 2025 04:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39EDE5C6371
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Aug 2025 02:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE14C293C65;
	Fri, 15 Aug 2025 02:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUzFXGgh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F84A293B75;
	Fri, 15 Aug 2025 02:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755224409; cv=none; b=YovqJFNdz4Vs6ssRF6qH1ygB4Pk1FJ70fgiM/4aBAngtp52doHl9+rPjfpykZ9Ue36soDkLcnfh70VT3Ds908RV7vzahl2mYnXBM+jkKS7UdOqwufcy7iQe/BJiN0xz2jPbBKP4yOdXmORN7SPLgiclMGaonNGo7Na+go9jByAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755224409; c=relaxed/simple;
	bh=/gp0HarhTsQfxd5MpNq6tN/wZQpwT+x+otUmkb+a17c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VtkoYcIQZRq6YA73OiYqbMiO1S9wgIUakd8Q/bqZZU9aXFpofADZvxn68jd7SOx8DZ91wZjukwX/0H6aIQhWdX7PUNoCmuOV1KCGu7ezZLDQhxpqIqWORU7uckMNMALRJmin52Ezi8TaRmH6526+/6HvDASDsYqAjl2WC1S78yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUzFXGgh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66ACC4CEF8;
	Fri, 15 Aug 2025 02:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755224409;
	bh=/gp0HarhTsQfxd5MpNq6tN/wZQpwT+x+otUmkb+a17c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uUzFXGghm/6Ful9dDr+sqFdSd22XUhlN4ZFtnViBTynTRd5MUrwkp9p90prfIiuBN
	 7n8smdnJ7aU+q9s3nWc2Az/Zqo+5Okb1z0egVHzcon58gqroiSNL08v0iY0rgSDI9b
	 0QhQSsTemyuht1HcXJXfwXcKpsdCI7Jl40D+bpkxjphofaMqTJIlaSzpN0CoL9PmQd
	 mDAtg/O2Fh5dXS4xUJV3t58naIvqfoudzOizpccdOTg/rcBtppxjOs8yQoKCw2hzf0
	 2Apv5J7sDujWlNLtUSkqnL/7FuVKTmmFqFYU0gnOJLT3ip6z3Pt7KBUK5vOaFEIJ7i
	 W5dT5+ynWtzJw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
	linux-crypto@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 2/2] lib/digsig: Use SHA-1 library instead of crypto_shash
Date: Thu, 14 Aug 2025 19:17:33 -0700
Message-ID: <20250815021733.25689-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815021733.25689-1-ebiggers@kernel.org>
References: <20250815021733.25689-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that a SHA-1 library API is available, use it instead of
crypto_shash.  This is simpler and faster.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 lib/Kconfig  |  3 +--
 lib/digsig.c | 46 ++++++----------------------------------------
 2 files changed, 7 insertions(+), 42 deletions(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index c483951b624ff..e629449dd2a36 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -475,12 +475,11 @@ config MPILIB
 	  which is used by IMA/EVM digital signature extension.
 
 config SIGNATURE
 	tristate
 	depends on KEYS
-	select CRYPTO
-	select CRYPTO_SHA1
+	select CRYPTO_LIB_SHA1
 	select MPILIB
 	help
 	  Digital signature verification. Currently only RSA is supported.
 	  Implementation is done using GnuPG MPI library
 
diff --git a/lib/digsig.c b/lib/digsig.c
index 04b5e55ed95f5..5ddcc52f76863 100644
--- a/lib/digsig.c
+++ b/lib/digsig.c
@@ -16,19 +16,15 @@
 
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/key.h>
-#include <linux/crypto.h>
-#include <crypto/hash.h>
 #include <crypto/sha1.h>
 #include <keys/user-type.h>
 #include <linux/mpi.h>
 #include <linux/digsig.h>
 
-static struct crypto_shash *shash;
-
 static const char *pkcs_1_v1_5_decode_emsa(const unsigned char *msg,
 						unsigned long  msglen,
 						unsigned long  modulus_bitlen,
 						unsigned long *outlen)
 {
@@ -197,16 +193,16 @@ static int digsig_verify_rsa(struct key *key,
  *
  */
 int digsig_verify(struct key *keyring, const char *sig, int siglen,
 						const char *data, int datalen)
 {
-	int err = -ENOMEM;
 	struct signature_hdr *sh = (struct signature_hdr *)sig;
-	struct shash_desc *desc = NULL;
+	struct sha1_ctx ctx;
 	unsigned char hash[SHA1_DIGEST_SIZE];
 	struct key *key;
 	char name[20];
+	int err;
 
 	if (siglen < sizeof(*sh) + 2)
 		return -EINVAL;
 
 	if (sh->algo != PUBKEY_ALGO_RSA)
@@ -229,51 +225,21 @@ int digsig_verify(struct key *keyring, const char *sig, int siglen,
 	if (IS_ERR(key)) {
 		pr_err("key not found, id: %s\n", name);
 		return PTR_ERR(key);
 	}
 
-	desc = kzalloc(sizeof(*desc) + crypto_shash_descsize(shash),
-		       GFP_KERNEL);
-	if (!desc)
-		goto err;
-
-	desc->tfm = shash;
-
-	crypto_shash_init(desc);
-	crypto_shash_update(desc, data, datalen);
-	crypto_shash_update(desc, sig, sizeof(*sh));
-	crypto_shash_final(desc, hash);
-
-	kfree(desc);
+	sha1_init(&ctx);
+	sha1_update(&ctx, data, datalen);
+	sha1_update(&ctx, sig, sizeof(*sh));
+	sha1_final(&ctx, hash);
 
 	/* pass signature mpis address */
 	err = digsig_verify_rsa(key, sig + sizeof(*sh), siglen - sizeof(*sh),
 			     hash, sizeof(hash));
 
-err:
 	key_put(key);
 
 	return err ? -EINVAL : 0;
 }
 EXPORT_SYMBOL_GPL(digsig_verify);
 
-static int __init digsig_init(void)
-{
-	shash = crypto_alloc_shash("sha1", 0, 0);
-	if (IS_ERR(shash)) {
-		pr_err("shash allocation failed\n");
-		return  PTR_ERR(shash);
-	}
-
-	return 0;
-
-}
-
-static void __exit digsig_cleanup(void)
-{
-	crypto_free_shash(shash);
-}
-
-module_init(digsig_init);
-module_exit(digsig_cleanup);
-
 MODULE_LICENSE("GPL");
-- 
2.50.1


