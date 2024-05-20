Return-Path: <linux-integrity+bounces-2475-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 371C98CA016
	for <lists+linux-integrity@lfdr.de>; Mon, 20 May 2024 17:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 956AAB21737
	for <lists+linux-integrity@lfdr.de>; Mon, 20 May 2024 15:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5381713777B;
	Mon, 20 May 2024 15:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="yCvpzJLt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E35136E3F;
	Mon, 20 May 2024 15:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716220204; cv=none; b=d1kA5gt+4My05S31mp8MwZqSb+zj5Gl23J1xdikDV9xIQ39vGi31AOW/jWobKbNp5NVlYWT0oUO5Iwz48uzK3Z61U7OBHU+VjkuGglep/BcVB+1t8ScLj2Fs8QTx2I8vDsoVPAqOLxR+Fw4EQcsMHpC3+DXBNrPZaNFzzEEUYHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716220204; c=relaxed/simple;
	bh=FRmcBDetcinYBDoqkppxu1Lcf/uZRV6S1eCCD+tFbNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTBu5FXMfyX47idHL5kb8QXh0fiQ6g+6MW5q/WWSfgt1NlQyqnui5d0Vymg/PX0dsl2a6WiJsVnfkoHQVR7xw3GdXjbK5ulkShklFkVnUzeD0lJzo3R+LpQP2NlBZBZI+NNq+d0aDVARYjHVZS7G/xeNzIsPweLcXx8rcEwO/S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=yCvpzJLt; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716220200;
	bh=FRmcBDetcinYBDoqkppxu1Lcf/uZRV6S1eCCD+tFbNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yCvpzJLt0zpEkXm6wVoKCvYFI2o3Y0P4nbRSv2SamYk1TmKPDAM9hBDzbsML/6H6y
	 ItaY5bpDEvB5rI2bi6GcNB7FSU8q9PgoymholDAXXHLSv1dFxa+ddOBFGzsxd3atM9
	 Vh1BHnpmKWuZaQ3BPJEAoEOtAf04Hnay9DlnHcUzfJsQwSoqP6TrIYucbDd0wqeiHn
	 2ew2j81rRwVkTR8LinNQGevca6uwKojC8QsKSjM3kTE6jvp2JwtUpNcZVNd6h037z+
	 K7FsCuCdoTY0xnTRFB4IZn6ZFWl9JkPWD9ZeGppmDLuPKuvwnwehQXmxQ0sFB4hPU+
	 ZuXz5XzzXXqOQ==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7F49E37810C3;
	Mon, 20 May 2024 15:49:58 +0000 (UTC)
Date: Mon, 20 May 2024 11:49:56 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Eric Biggers <ebiggers@kernel.org>, Jarkko Sakkinen <jarkko@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	regressions@lists.linux.dev, kernel@collabora.com
Subject: Re: [PATCH] crypto: api - Do not load modules until algapi is ready
Message-ID: <00bcfa65-384d-46ae-ab8b-30f12487928b@notapiano>
References: <119dc5ed-f159-41be-9dda-1a056f29888d@notapiano>
 <0f68c283ff4bbb89b8a019d47891f798c6fff287.camel@HansenPartnership.com>
 <CAMj1kXHi4r8KY9GvX573kwqvLpMfX-J=K2hWiGAKkf5bnicwYQ@mail.gmail.com>
 <0d260c2f7a9f67ec8bd2305919636678d06000d1.camel@HansenPartnership.com>
 <CAMj1kXFE_R_x10BVkU+8vrMz0RHiX0+rz-ZL+w08FH2CLQHZXA@mail.gmail.com>
 <66ec985f3ee229135bf748f1b0874d5367a74d7f.camel@HansenPartnership.com>
 <dfb0d930-7cbe-46c5-be19-d132b4906ecf@notapiano>
 <D1C2NPOBHAHK.20O4IME8OK1FH@kernel.org>
 <20240518043115.GA53815@sol.localdomain>
 <ZkhS1zrobNwAuANI@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZkhS1zrobNwAuANI@gondor.apana.org.au>

On Sat, May 18, 2024 at 03:03:51PM +0800, Herbert Xu wrote:
> On Fri, May 17, 2024 at 09:31:15PM -0700, Eric Biggers wrote:
> >
> > This is "normal" behavior when the crypto API instantiates a template:
> > 
> >     1. drbg.c asks for "hmac(sha512)"
> > 
> >     2. The crypto API looks for a direct implementation of "hmac(sha512)".
> >        This includes requesting a module with alias "crypto-hmac(sha512)".
> > 
> >     3. If none is found, the "hmac" template is instantiated instead.
> > 
> > There are two possible fixes for the bug.  Either fix ecc_gen_privkey() to just
> > use get_random_bytes() instead of the weird crypto API RNG, or make
> > drbg_init_hash_kernel() pass the CRYPTO_NOLOAD flag to crypto_alloc_shash().
> > 
> > Or if the TPM driver could be changed to not need to generate an ECC private key
> > at probe time, that would also avoid this problem.
> 
> Thanks for diagnosing the problem.  This is easy to fix though,
> we could simply reuse the static branch that was created for
> boot-time self-testing:
> 
> ---8<---
> When the Crypto API is built into the kernel, it may be invoked
> during system initialisation before modules can be loaded.  Ensure
> that it doesn't load modules if this is the case by checking
> crypto_boot_test_finished().
> 
> Add a call to wait_for_device_probe so that the drivers that may
> call into the Crypto API have finished probing.
> 
> Reported-by: Nícolas F. R. A. Prado" <nfraprado@collabora.com>
> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> diff --git a/crypto/algapi.c b/crypto/algapi.c
> index 85bc279b4233..c018bcbd1f46 100644
> --- a/crypto/algapi.c
> +++ b/crypto/algapi.c
> @@ -7,6 +7,7 @@
>  
>  #include <crypto/algapi.h>
>  #include <crypto/internal/simd.h>
> +#include <linux/device/driver.h>
>  #include <linux/err.h>
>  #include <linux/errno.h>
>  #include <linux/fips.h>
> @@ -1056,9 +1057,12 @@ EXPORT_SYMBOL_GPL(crypto_type_has_alg);
>  
>  static void __init crypto_start_tests(void)
>  {
> -	if (IS_ENABLED(CONFIG_CRYPTO_MANAGER_DISABLE_TESTS))
> +	if (!IS_BUILTIN(CONFIG_CRYPTO_ALGAPI))
>  		return;
>  
> +	if (IS_ENABLED(CONFIG_CRYPTO_MANAGER_DISABLE_TESTS))
> +		goto test_done;
> +
>  	for (;;) {
>  		struct crypto_larval *larval = NULL;
>  		struct crypto_alg *q;
> @@ -1092,6 +1096,8 @@ static void __init crypto_start_tests(void)
>  		crypto_wait_for_test(larval);
>  	}
>  
> +test_done:
> +	wait_for_device_probe();
>  	set_crypto_boot_test_finished();
>  }
>  
> diff --git a/crypto/api.c b/crypto/api.c
> index 6aa5a3b4ed5e..5c970af04ba9 100644
> --- a/crypto/api.c
> +++ b/crypto/api.c
> @@ -31,9 +31,8 @@ EXPORT_SYMBOL_GPL(crypto_alg_sem);
>  BLOCKING_NOTIFIER_HEAD(crypto_chain);
>  EXPORT_SYMBOL_GPL(crypto_chain);
>  
> -#ifndef CONFIG_CRYPTO_MANAGER_DISABLE_TESTS
> +#if IS_BUILTIN(CONFIG_CRYPTO_ALGAPI)
>  DEFINE_STATIC_KEY_FALSE(__crypto_boot_test_finished);
> -EXPORT_SYMBOL_GPL(__crypto_boot_test_finished);
>  #endif
>  
>  static struct crypto_alg *crypto_larval_wait(struct crypto_alg *alg);
> @@ -280,7 +279,7 @@ static struct crypto_alg *crypto_larval_lookup(const char *name, u32 type,
>  	mask &= ~(CRYPTO_ALG_LARVAL | CRYPTO_ALG_DEAD);
>  
>  	alg = crypto_alg_lookup(name, type, mask);
> -	if (!alg && !(mask & CRYPTO_NOLOAD)) {
> +	if (crypto_boot_test_finished() && !alg && !(mask & CRYPTO_NOLOAD)) {
>  		request_module("crypto-%s", name);
>  
>  		if (!((type ^ CRYPTO_ALG_NEED_FALLBACK) & mask &
> diff --git a/crypto/internal.h b/crypto/internal.h
> index 63e59240d5fb..d27166a92eca 100644
> --- a/crypto/internal.h
> +++ b/crypto/internal.h
> @@ -66,7 +66,7 @@ extern struct blocking_notifier_head crypto_chain;
>  
>  int alg_test(const char *driver, const char *alg, u32 type, u32 mask);
>  
> -#ifdef CONFIG_CRYPTO_MANAGER_DISABLE_TESTS
> +#if !IS_BUILTIN(CONFIG_CRYPTO_ALGAPI)
>  static inline bool crypto_boot_test_finished(void)
>  {
>  	return true;
> @@ -84,7 +84,7 @@ static inline void set_crypto_boot_test_finished(void)
>  {
>  	static_branch_enable(&__crypto_boot_test_finished);
>  }
> -#endif /* !CONFIG_CRYPTO_MANAGER_DISABLE_TESTS */
> +#endif /* !IS_BUILTIN(CONFIG_CRYPTO_ALGAPI) */
>  
>  #ifdef CONFIG_PROC_FS
>  void __init crypto_init_proc(void);
> -- 

Hi Herbert,

Unfortunately this patch didn't work either. The warning is still there
unchanged.

The warning is triggered by a driver that probes asynchronously registering a
TPM device, which ends up requesting a module to be loaded synchronously. So I
don't think waiting would even help here. I believe one possible solution would
be to request the module asynchronously and defer probe. Not ideal but I think
would work.

Alternatively, could the initialization code that loads this module
(hmac(sha512)) be run synchronously before the TPM device is registered? Or is
it device specific?

PS: the wait_for_device_probe() call in the patch didn't actually wait for
anything in this case since when the crypto tests code ran there weren't any
probes in progress

Thanks,
Nícolas

