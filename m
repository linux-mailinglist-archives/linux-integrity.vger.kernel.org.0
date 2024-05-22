Return-Path: <linux-integrity+bounces-2547-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3CE8CC0A8
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2024 13:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 737D228323F
	for <lists+linux-integrity@lfdr.de>; Wed, 22 May 2024 11:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79D913D530;
	Wed, 22 May 2024 11:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSbf7IZj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D2B13D529;
	Wed, 22 May 2024 11:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716378701; cv=none; b=L5sSAc0WRhzGMCMfdE3Kj5uQPpjazH/VbHoAy4C4DspLXaXtLJr+IKJPX6imWbHyLGlX+OWyoWHMmFtEZ1OlLePBlvs7vswCJRnFTd7065qcwdLZZQlsiyk23QpFqDOZKI74V+z5BpWYlmjXnqyv/tiyVJWFd2NuE/A9PSFPrCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716378701; c=relaxed/simple;
	bh=RftWGtYZutda+ggc/D573POE4wIZ/qWSGIv5UU3kk7M=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=FqlmJCcbh6S344t95BxBCKTLsZCosc6RDAEuV0x2bIGUimyXgTfAj1MQDQgJG8U4ugvjodcVH41fY65F57UYfLyifEZEiUQgqEYHY6OTQ/QP/2nlhkUfhKK1lM6x0huCSeuigFdwqPKejRKyyDWdt0Wjg3HAuTwuKvS4IMVM+7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSbf7IZj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66520C32789;
	Wed, 22 May 2024 11:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716378701;
	bh=RftWGtYZutda+ggc/D573POE4wIZ/qWSGIv5UU3kk7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JSbf7IZjd/vyIR9PbvZkzywbOC/7JgPk4Ft1uOCeUsg8qlVF2xTbFge+xHPoqXLfn
	 3BvURvg+Pmdq4Q5d8d2RYO6er39h39lw82zROGTPAOm7JTuDegGdAi88AFN0ykv3nq
	 22V5tPgjyqb/w76I1qEGdN9gtq3o1ZmqzKnGCIPDN0Vzy4nZsf3DgfyGnBNYmTEBxN
	 F/NrKySOcElaoKFtM1/KSf+6TS1RPQxbmSIgTa4yRUGRRwfna+zYEgjogMpeU97YF0
	 LH3TeVZEj+HBOe1MLA1gmidl1+n9SFvX4w+YpNy08eO76YbPf29uc2AnSDNPorrb7V
	 v2ibhomIu/T6w==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 22 May 2024 14:51:36 +0300
Message-Id: <D1G5GVUYCRZK.1G5UZ39NM96QJ@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Herbert Xu" <herbert@gondor.apana.org.au>,
 =?utf-8?b?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: "Eric Biggers" <ebiggers@kernel.org>, "James Bottomley"
 <James.Bottomley@hansenpartnership.com>, "Ard Biesheuvel"
 <ardb@kernel.org>, "Linux Crypto Mailing List"
 <linux-crypto@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <keyrings@vger.kernel.org>, <regressions@lists.linux.dev>,
 <kernel@collabora.com>, "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Tejun Heo" <tj@kernel.org>, "Linux Kernel Mailing List"
 <linux-kernel@vger.kernel.org>, "Kees Cook" <keescook@chromium.org>
Subject: Re: [v3 PATCH] hwrng: core - Remove add_early_randomness
X-Mailer: aerc 0.17.0
References: <0d260c2f7a9f67ec8bd2305919636678d06000d1.camel@HansenPartnership.com> <CAMj1kXFE_R_x10BVkU+8vrMz0RHiX0+rz-ZL+w08FH2CLQHZXA@mail.gmail.com> <66ec985f3ee229135bf748f1b0874d5367a74d7f.camel@HansenPartnership.com> <dfb0d930-7cbe-46c5-be19-d132b4906ecf@notapiano> <D1C2NPOBHAHK.20O4IME8OK1FH@kernel.org> <20240518043115.GA53815@sol.localdomain> <ZkhS1zrobNwAuANI@gondor.apana.org.au> <00bcfa65-384d-46ae-ab8b-30f12487928b@notapiano> <ZkwMnrTR_CbXcjWe@gondor.apana.org.au> <07512097-8198-4a84-b166-ef9809c2913b@notapiano> <Zk2Eso--FVsZ5AF3@gondor.apana.org.au>
In-Reply-To: <Zk2Eso--FVsZ5AF3@gondor.apana.org.au>

On Wed May 22, 2024 at 8:37 AM EEST, Herbert Xu wrote:
> On Tue, May 21, 2024 at 03:37:16PM -0400, N=C3=ADcolas F. R. A. Prado wro=
te:
> >
> > FWIW this patch fixes the warning. So feel free to add
> >=20
> > Tested-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
>
> Could you please test this patch instead?
>
> ---8<---
> A potential deadlock was reported with the config file at
>
> https://web.archive.org/web/20240522052129/https://0x0.st/XPN_.txt
>
> In this particular configuration, the deadlock doesn't exist because
> the warning triggered at a point before modules were even available.
> However, the deadlock can be real because any module loaded would
> invoke async_synchronize_full.
>
> The issue is spurious for software crypto algorithms which aren't
> themselves involved in async probing.  However, it would be hard to
> avoid for a PCI crypto driver using async probing.
>
> In this particular call trace, the problem is easily avoided because
> the only reason the module is being requested during probing is the
> add_early_randomness call in the hwrng core.  This feature is
> vestigial since there is now a kernel thread dedicated to doing
> exactly this.
>
> So remove add_early_randomness as it is no longer needed.

"vestigial" did not know that word before ;-) Something learned.

What is the kthread doing this currently?

>
> Reported-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Fixes: 1b6d7f9eb150 ("tpm: add session encryption protection to tpm2_get_=
random()")
> Link: https://lore.kernel.org/r/119dc5ed-f159-41be-9dda-1a056f29888d@nota=
piano/
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>
> diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.=
c
> index f5c71a617a99..4084df65c9fa 100644
> --- a/drivers/char/hw_random/core.c
> +++ b/drivers/char/hw_random/core.c
> @@ -64,19 +64,6 @@ static size_t rng_buffer_size(void)
>  	return RNG_BUFFER_SIZE;
>  }
> =20
> -static void add_early_randomness(struct hwrng *rng)
> -{
> -	int bytes_read;
> -
> -	mutex_lock(&reading_mutex);
> -	bytes_read =3D rng_get_data(rng, rng_fillbuf, 32, 0);
> -	mutex_unlock(&reading_mutex);
> -	if (bytes_read > 0) {
> -		size_t entropy =3D bytes_read * 8 * rng->quality / 1024;
> -		add_hwgenerator_randomness(rng_fillbuf, bytes_read, entropy, false);
> -	}
> -}
> -
>  static inline void cleanup_rng(struct kref *kref)
>  {
>  	struct hwrng *rng =3D container_of(kref, struct hwrng, ref);
> @@ -340,13 +327,12 @@ static ssize_t rng_current_store(struct device *dev=
,
>  				 const char *buf, size_t len)
>  {
>  	int err;
> -	struct hwrng *rng, *old_rng, *new_rng;
> +	struct hwrng *rng, *new_rng;
> =20
>  	err =3D mutex_lock_interruptible(&rng_mutex);
>  	if (err)
>  		return -ERESTARTSYS;
> =20
> -	old_rng =3D current_rng;
>  	if (sysfs_streq(buf, "")) {
>  		err =3D enable_best_rng();
>  	} else {
> @@ -362,11 +348,8 @@ static ssize_t rng_current_store(struct device *dev,
>  	new_rng =3D get_current_rng_nolock();
>  	mutex_unlock(&rng_mutex);
> =20
> -	if (new_rng) {
> -		if (new_rng !=3D old_rng)
> -			add_early_randomness(new_rng);
> +	if (new_rng)
>  		put_rng(new_rng);
> -	}
> =20
>  	return err ? : len;
>  }
> @@ -544,7 +527,6 @@ int hwrng_register(struct hwrng *rng)
>  {
>  	int err =3D -EINVAL;
>  	struct hwrng *tmp;
> -	bool is_new_current =3D false;
> =20
>  	if (!rng->name || (!rng->data_read && !rng->read))
>  		goto out;
> @@ -573,25 +555,8 @@ int hwrng_register(struct hwrng *rng)
>  		err =3D set_current_rng(rng);
>  		if (err)
>  			goto out_unlock;
> -		/* to use current_rng in add_early_randomness() we need
> -		 * to take a ref
> -		 */
> -		is_new_current =3D true;
> -		kref_get(&rng->ref);
>  	}
>  	mutex_unlock(&rng_mutex);
> -	if (is_new_current || !rng->init) {
> -		/*
> -		 * Use a new device's input to add some randomness to
> -		 * the system.  If this rng device isn't going to be
> -		 * used right away, its init function hasn't been
> -		 * called yet by set_current_rng(); so only use the
> -		 * randomness from devices that don't need an init callback
> -		 */
> -		add_early_randomness(rng);
> -	}
> -	if (is_new_current)
> -		put_rng(rng);
>  	return 0;
>  out_unlock:
>  	mutex_unlock(&rng_mutex);
> @@ -602,12 +567,11 @@ EXPORT_SYMBOL_GPL(hwrng_register);
> =20
>  void hwrng_unregister(struct hwrng *rng)
>  {
> -	struct hwrng *old_rng, *new_rng;
> +	struct hwrng *new_rng;
>  	int err;
> =20
>  	mutex_lock(&rng_mutex);
> =20
> -	old_rng =3D current_rng;
>  	list_del(&rng->list);
>  	complete_all(&rng->dying);
>  	if (current_rng =3D=3D rng) {
> @@ -626,11 +590,8 @@ void hwrng_unregister(struct hwrng *rng)
>  	} else
>  		mutex_unlock(&rng_mutex);
> =20
> -	if (new_rng) {
> -		if (old_rng !=3D new_rng)
> -			add_early_randomness(new_rng);
> +	if (new_rng)
>  		put_rng(new_rng);
> -	}
> =20
>  	wait_for_completion(&rng->cleanup_done);
>  }

I have no doubts that such thread would not exist, so:

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

