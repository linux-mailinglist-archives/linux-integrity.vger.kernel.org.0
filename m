Return-Path: <linux-integrity+bounces-2441-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3C88C8FE0
	for <lists+linux-integrity@lfdr.de>; Sat, 18 May 2024 09:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE11A1C20DC4
	for <lists+linux-integrity@lfdr.de>; Sat, 18 May 2024 07:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850A6BE68;
	Sat, 18 May 2024 07:04:03 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD27C2F4A;
	Sat, 18 May 2024 07:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716015843; cv=none; b=miS+Jsv1dtqBm9xIqmDJtsyneBFXGE1GhYHLPw0Jbs5BR+en63eyAwxS61VkNV/vEO6Vqi8+4EbYnZUfzpwRCuVe59FeZj9Vovr1T9xvJ+bvRsG6Vny2wcdsXIIEaC/+cwldM4/h6uVb0pZBROxgl3Yt1Ar2qUP4WKXg/j1agE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716015843; c=relaxed/simple;
	bh=b5Mc/hQDoJO4JLJ1jg3SNgkXajd60OaC6wKDoek4Tnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xbu0wTVO3hZnOJvShn7FdM1L6+GquFLXvrCpSc4VO8HH28Z9RQFr6mMAYErhRLNwru1cwX/dqmgOklNM083BxLJ/0k6DV401WkHi5ggmFw0iiaGiPzIawMQR3GYTwoCZgsKPjA2NgzinWXvkaz29fLjA0xlqFrJHG+LEt8oWeB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s8E6g-00H2mk-1Y;
	Sat, 18 May 2024 15:03:51 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 18 May 2024 15:03:51 +0800
Date: Sat, 18 May 2024 15:03:51 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	regressions@lists.linux.dev, kernel@collabora.com
Subject: [PATCH] crypto: api - Do not load modules until algapi is ready
Message-ID: <ZkhS1zrobNwAuANI@gondor.apana.org.au>
References: <20240429202811.13643-19-James.Bottomley@HansenPartnership.com>
 <119dc5ed-f159-41be-9dda-1a056f29888d@notapiano>
 <0f68c283ff4bbb89b8a019d47891f798c6fff287.camel@HansenPartnership.com>
 <CAMj1kXHi4r8KY9GvX573kwqvLpMfX-J=K2hWiGAKkf5bnicwYQ@mail.gmail.com>
 <0d260c2f7a9f67ec8bd2305919636678d06000d1.camel@HansenPartnership.com>
 <CAMj1kXFE_R_x10BVkU+8vrMz0RHiX0+rz-ZL+w08FH2CLQHZXA@mail.gmail.com>
 <66ec985f3ee229135bf748f1b0874d5367a74d7f.camel@HansenPartnership.com>
 <dfb0d930-7cbe-46c5-be19-d132b4906ecf@notapiano>
 <D1C2NPOBHAHK.20O4IME8OK1FH@kernel.org>
 <20240518043115.GA53815@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240518043115.GA53815@sol.localdomain>

On Fri, May 17, 2024 at 09:31:15PM -0700, Eric Biggers wrote:
>
> This is "normal" behavior when the crypto API instantiates a template:
> 
>     1. drbg.c asks for "hmac(sha512)"
> 
>     2. The crypto API looks for a direct implementation of "hmac(sha512)".
>        This includes requesting a module with alias "crypto-hmac(sha512)".
> 
>     3. If none is found, the "hmac" template is instantiated instead.
> 
> There are two possible fixes for the bug.  Either fix ecc_gen_privkey() to just
> use get_random_bytes() instead of the weird crypto API RNG, or make
> drbg_init_hash_kernel() pass the CRYPTO_NOLOAD flag to crypto_alloc_shash().
> 
> Or if the TPM driver could be changed to not need to generate an ECC private key
> at probe time, that would also avoid this problem.

Thanks for diagnosing the problem.  This is easy to fix though,
we could simply reuse the static branch that was created for
boot-time self-testing:

---8<---
When the Crypto API is built into the kernel, it may be invoked
during system initialisation before modules can be loaded.  Ensure
that it doesn't load modules if this is the case by checking
crypto_boot_test_finished().

Add a call to wait_for_device_probe so that the drivers that may
call into the Crypto API have finished probing.

Reported-by: Nícolas F. R. A. Prado" <nfraprado@collabora.com>
Reported-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/crypto/algapi.c b/crypto/algapi.c
index 85bc279b4233..c018bcbd1f46 100644
--- a/crypto/algapi.c
+++ b/crypto/algapi.c
@@ -7,6 +7,7 @@
 
 #include <crypto/algapi.h>
 #include <crypto/internal/simd.h>
+#include <linux/device/driver.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/fips.h>
@@ -1056,9 +1057,12 @@ EXPORT_SYMBOL_GPL(crypto_type_has_alg);
 
 static void __init crypto_start_tests(void)
 {
-	if (IS_ENABLED(CONFIG_CRYPTO_MANAGER_DISABLE_TESTS))
+	if (!IS_BUILTIN(CONFIG_CRYPTO_ALGAPI))
 		return;
 
+	if (IS_ENABLED(CONFIG_CRYPTO_MANAGER_DISABLE_TESTS))
+		goto test_done;
+
 	for (;;) {
 		struct crypto_larval *larval = NULL;
 		struct crypto_alg *q;
@@ -1092,6 +1096,8 @@ static void __init crypto_start_tests(void)
 		crypto_wait_for_test(larval);
 	}
 
+test_done:
+	wait_for_device_probe();
 	set_crypto_boot_test_finished();
 }
 
diff --git a/crypto/api.c b/crypto/api.c
index 6aa5a3b4ed5e..5c970af04ba9 100644
--- a/crypto/api.c
+++ b/crypto/api.c
@@ -31,9 +31,8 @@ EXPORT_SYMBOL_GPL(crypto_alg_sem);
 BLOCKING_NOTIFIER_HEAD(crypto_chain);
 EXPORT_SYMBOL_GPL(crypto_chain);
 
-#ifndef CONFIG_CRYPTO_MANAGER_DISABLE_TESTS
+#if IS_BUILTIN(CONFIG_CRYPTO_ALGAPI)
 DEFINE_STATIC_KEY_FALSE(__crypto_boot_test_finished);
-EXPORT_SYMBOL_GPL(__crypto_boot_test_finished);
 #endif
 
 static struct crypto_alg *crypto_larval_wait(struct crypto_alg *alg);
@@ -280,7 +279,7 @@ static struct crypto_alg *crypto_larval_lookup(const char *name, u32 type,
 	mask &= ~(CRYPTO_ALG_LARVAL | CRYPTO_ALG_DEAD);
 
 	alg = crypto_alg_lookup(name, type, mask);
-	if (!alg && !(mask & CRYPTO_NOLOAD)) {
+	if (crypto_boot_test_finished() && !alg && !(mask & CRYPTO_NOLOAD)) {
 		request_module("crypto-%s", name);
 
 		if (!((type ^ CRYPTO_ALG_NEED_FALLBACK) & mask &
diff --git a/crypto/internal.h b/crypto/internal.h
index 63e59240d5fb..d27166a92eca 100644
--- a/crypto/internal.h
+++ b/crypto/internal.h
@@ -66,7 +66,7 @@ extern struct blocking_notifier_head crypto_chain;
 
 int alg_test(const char *driver, const char *alg, u32 type, u32 mask);
 
-#ifdef CONFIG_CRYPTO_MANAGER_DISABLE_TESTS
+#if !IS_BUILTIN(CONFIG_CRYPTO_ALGAPI)
 static inline bool crypto_boot_test_finished(void)
 {
 	return true;
@@ -84,7 +84,7 @@ static inline void set_crypto_boot_test_finished(void)
 {
 	static_branch_enable(&__crypto_boot_test_finished);
 }
-#endif /* !CONFIG_CRYPTO_MANAGER_DISABLE_TESTS */
+#endif /* !IS_BUILTIN(CONFIG_CRYPTO_ALGAPI) */
 
 #ifdef CONFIG_PROC_FS
 void __init crypto_init_proc(void);
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

