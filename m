Return-Path: <linux-integrity+bounces-2429-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 826478C814B
	for <lists+linux-integrity@lfdr.de>; Fri, 17 May 2024 09:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CD3B281A46
	for <lists+linux-integrity@lfdr.de>; Fri, 17 May 2024 07:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD4B171C1;
	Fri, 17 May 2024 07:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwSf1K5a"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62937171B0;
	Fri, 17 May 2024 07:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715930464; cv=none; b=IDigDwwEEsx7IU9z3gjm23gfZ1YmXrFWqMuEIq00zjIY1k6V4IBJvys+OgptH+oBH+bqhA333C35nkbxQNvZe5OublKOsc6zr7t8S1PwD1CX0uAQS10MCUcq6J1MORZhgTbeEh4eydDzEBJIzG7rz6iXaSnM0s1OBTROGmKml5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715930464; c=relaxed/simple;
	bh=SIUg7VYoJmij3fonCdmr3MryScfMF3C/ZPKy4UtDcuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BVafLXw/an4yN0OZ3F7CCsY+KrgiG79wOwisn++McOlDQ4Hr8zu6ZGZFDiG9lCgrypMeQ+o2EPLnUZZgbBeBpii33jGPTdxl3qLpVa9wbfM/cM1KaJfaVr4tFKNoRTsH5fg5TZYMeQjYPtWUBZfxs63yKL9dwlgedwBHv3MVk2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwSf1K5a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C19C4AF08;
	Fri, 17 May 2024 07:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715930463;
	bh=SIUg7VYoJmij3fonCdmr3MryScfMF3C/ZPKy4UtDcuw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VwSf1K5a9MG2pTSJ5rXb534zsIKrJtsbaQdp4wSvWyGHonugP5d/qJLYVqIuBw28U
	 j/3NjRN8ZL+u12zVaWIJZblCtUoFStCbkEhwtNQWxDLRsahnJ5ggWCO65hDBoL57v/
	 pik9LlfKfToe/S1iOElVoLHqzKa9i09Uv82gjCvfdJup/2SWIqvuDy4nLeYpixKx7N
	 A4EdF7cRQtAq7dhPvlLLMGWtM23s4BdOZ4F8aXPSaZ36YASLFapV83bg5LaPIUk3X0
	 HC1en+erFt2wGv06/Aju4TjAg7TikBMrMpAeqrxzaK6C3KtyqeBPwLhU9QqxJkmYXZ
	 MLdW6TP1FPazQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51fb14816f6so350129e87.0;
        Fri, 17 May 2024 00:21:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWtz8a7FK7YPQyyeBeyFImxvgGjOdZOPR3Y9zIQyXJb6LCN0bT+86TYbRjL6sgPQAMKX+2K/oLEbvYQ3pE16ip9cNMHwtz0CuNF8xMp0uj3G8kSnHuRj3XeKSkqBlGkthwWQJuQq33GdZCZLmNbmrYiaYN5Y/OTzC4mTxyOxREHxsHsyCdVDhU=
X-Gm-Message-State: AOJu0Yx8mdQm3hO5ndf+8RKLnh8q+wAnFhC7JJwdYNNRXwiD0isPkTR3
	8e3tcvKbmBceu3uxSvlZYDYCtx+r5Kep1foxxm/QhIF/DD/1kKZBaS2i6lqyOKiPh1SXHCYhCmD
	WDNOFqW4FWkNA6DoWjKhMVrr3nLk=
X-Google-Smtp-Source: AGHT+IGbAGb/Mn0n0yXWThjkNZ0Z1HZ07+Y6+iKeiXXDb0sZqnNgMRipDPT9nl4mF74HreX5huUwq3I77KJ9YdVrfoI=
X-Received: by 2002:a05:6512:3981:b0:51c:b44a:f6ae with SMTP id
 2adb3069b0e04-5220fc7814amr16867521e87.21.1715930462237; Fri, 17 May 2024
 00:21:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429202811.13643-1-James.Bottomley@HansenPartnership.com>
 <20240429202811.13643-19-James.Bottomley@HansenPartnership.com>
 <119dc5ed-f159-41be-9dda-1a056f29888d@notapiano> <0f68c283ff4bbb89b8a019d47891f798c6fff287.camel@HansenPartnership.com>
In-Reply-To: <0f68c283ff4bbb89b8a019d47891f798c6fff287.camel@HansenPartnership.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 17 May 2024 09:20:49 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHi4r8KY9GvX573kwqvLpMfX-J=K2hWiGAKkf5bnicwYQ@mail.gmail.com>
Message-ID: <CAMj1kXHi4r8KY9GvX573kwqvLpMfX-J=K2hWiGAKkf5bnicwYQ@mail.gmail.com>
Subject: Re: [PATCH v8 18/22] tpm: add session encryption protection to tpm2_get_random()
To: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	linux-integrity@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>, 
	keyrings@vger.kernel.org, regressions@lists.linux.dev, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 17 May 2024 at 03:59, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Thu, 2024-05-16 at 20:25 -0400, N=C3=ADcolas F. R. A. Prado wrote:
...
> > KernelCI has identified a new warning and I tracked it down to this
> > commit. It
> > was observed on the following platforms:
> > * mt8183-kukui-jacuzzi-juniper-sku16
> > * sc7180-trogdor-kingoftown
> > (but probably affects all platforms that have a tpm driver with async
> > probe)
> >
> > [    2.175146] Call trace:
> > [    2.177587]  __request_module+0x188/0x1f4
> > [    2.181596]  crypto_alg_mod_lookup+0x178/0x21c
> > [    2.186042]  crypto_alloc_tfm_node+0x58/0x114
> > [    2.190396]  crypto_alloc_shash+0x24/0x30
> > [    2.194404]  drbg_init_hash_kernel+0x28/0xdc
> > [    2.198673]  drbg_kcapi_seed+0x21c/0x420
> > [    2.202593]  crypto_rng_reset+0x84/0xb4
> > [    2.206425]  crypto_get_default_rng+0xa4/0xd8
> > [    2.210779]  ecc_gen_privkey+0x58/0xd0
> > [    2.214526]  ecdh_set_secret+0x90/0x198
> > [    2.218360]  tpm_buf_append_salt+0x164/0x2dc
>
> This looks like a misconfiguration.  The kernel is trying to load the
> ecdh module, but it should have been selected as built in by this in
> drivers/char/tpm/Kconfig:
>
> config TCG_TPM2_HMAC
>         bool "Use HMAC and encrypted transactions on the TPM bus"
>         default y
>         select CRYPTO_ECDH
>         select CRYPTO_LIB_AESCFB
>         select CRYPTO_LIB_SHA256
>

The module request is not for ECDH itself but for the DRBG it attempts
to use to generate the secret.

Given that CRYPTO_ECDH does not strictly require a DRBG in principle,
but does in this particular case, I think it makes sense to select
CRYPTO_DRBG here (or depend on it being builtin), rather than updating
the Kconfig rules for CRYPTO_ECDH itself.

