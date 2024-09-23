Return-Path: <linux-integrity+bounces-3662-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 904E097E6E5
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Sep 2024 09:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7F0B1C2109A
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Sep 2024 07:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8B83EA64;
	Mon, 23 Sep 2024 07:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HtGwTc3f"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9354A328B6;
	Mon, 23 Sep 2024 07:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727077973; cv=none; b=Ju09Vl6Je1RS5BL8UrPzKOV3yeGQ2OknwLZDA+YuwRrzQv8yBADM7IkjJeLtZOSPlBgUQ0ac+pymzkWiljx/5trwF/yquVfspn6dTLtnr+PBfxiur2GMURRwzGRNhF/jR3B2eMVMVmYj0BZCE5Fzr51WGlVzsanmrsgpTr2V6Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727077973; c=relaxed/simple;
	bh=5vYOnSMxFKKlpLtXPG+k6NrCmUagI+4dIIO8nAch5aU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=RkupAkpjsplqlsnzJqtm8q2q5ENaWV4B70NriSImVQIh+RDEiw1I0pkIwzQs6SuXBhAlryHT9DioO49L7wN5shykxRsQIkzo6wKv1rUDJQV9Xekd7zanPvTKbIcccyxjdJjEAC3F4vSeHKvPXk8DSjLReO8i9zDJzM2kuXHkPWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HtGwTc3f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA755C4CEC4;
	Mon, 23 Sep 2024 07:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727077973;
	bh=5vYOnSMxFKKlpLtXPG+k6NrCmUagI+4dIIO8nAch5aU=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=HtGwTc3fkiDRGdArlqdbnnT3bwqrvAUIWgsx0S/3ja88AwpLHRzNjnhrDvzGqeoJI
	 v4kDtVvC1Bxn4vWVOAr8zxCM2+JUCNKWpzSMKrrWYqyai409iuhLZ0phHggFl3YUvj
	 OPoPVqBsWJMLcmW+dLLKuWjDz+jGSRMFKlCK2aRW7nK2Q7xHvcQjwFCjCy8S2caKf7
	 I4pXyGXGMvaT1zZLCqKJeo2QAFyQEZXVE42gvYkxTPg8W7RcSS9eumVJBQRXcd3oNf
	 Ekcb3Ou51I1hdYyTANgRXf3ZvGq5/iglOXD2RaMR6JmPvN4teL5ur6sr+1bgWSbefL
	 XPLd3TDcm0Wdw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Sep 2024 10:52:49 +0300
Message-Id: <D4DI1M1ELFXK.2COGZN6O5HABD@kernel.org>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH] hwrng: core - Add WARN_ON for buggy read return values
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Herbert Xu" <herbert@gondor.apana.org.au>, "Linux Crypto Mailing List"
 <linux-crypto@vger.kernel.org>, "Guangwu Zhang" <guazhang@redhat.com>
X-Mailer: aerc 0.18.2
References: <ZvEFQAWVgWNd9j7e@gondor.apana.org.au>
In-Reply-To: <ZvEFQAWVgWNd9j7e@gondor.apana.org.au>

On Mon Sep 23, 2024 at 9:05 AM EEST, Herbert Xu wrote:
> Dear TPM maintainers:

There's really only just me (for past 10 years). Maybe that should be
updatred.

>
> Please have a look at the tpm hwrng driver because it appears to
> be returning a length longer than the buffer length that we gave
> it.  In particular, tpm2 appears to be the culprit (though I didn't
> really check tpm1 at all so it could also be buggy).
>
> The following patch hopefully should confirm that this is indeed
> caused by TPM and not some other HWRNG driver.




>
> ---8<---
> If a buggy driver returns a length that is longer than the size
> of the buffer provided to it, then this may lead to a buffer overread
> in the caller.
>
> Stop this by adding a check for it in the hwrng core.
>
> Reported-by: Guangwu Zhang <guazhang@redhat.com>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>
> diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.=
c
> index 57c51efa5613..018316f54621 100644
> --- a/drivers/char/hw_random/core.c
> +++ b/drivers/char/hw_random/core.c
> @@ -181,8 +181,15 @@ static inline int rng_get_data(struct hwrng *rng, u8=
 *buffer, size_t size,
>  	int present;
> =20
>  	BUG_ON(!mutex_is_locked(&reading_mutex));
> -	if (rng->read)
> -		return rng->read(rng, (void *)buffer, size, wait);
> +	if (rng->read) {
> +		int err;
> +
> +		err =3D rng->read(rng, buffer, size, wait);
> +		if (WARN_ON_ONCE(err > 0 && err > size))

Are you sure you want to use WARN_ON_ONCE here instead of
pr_warn_once()? I.e. is it worth of taking down the whole
kernel?

> +			err =3D size;
> +
> +		return err;
> +	}
> =20
>  	if (rng->data_present)
>  		present =3D rng->data_present(rng, wait);

BR, Jarkko

