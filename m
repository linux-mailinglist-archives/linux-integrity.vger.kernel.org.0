Return-Path: <linux-integrity+bounces-2432-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A41C38C8768
	for <lists+linux-integrity@lfdr.de>; Fri, 17 May 2024 15:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B964284C07
	for <lists+linux-integrity@lfdr.de>; Fri, 17 May 2024 13:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE53C54F96;
	Fri, 17 May 2024 13:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWWXlJnB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7D854BD7;
	Fri, 17 May 2024 13:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715953444; cv=none; b=DhYtZaJNgKATeiszOYtNgRgBV/uyj0vdxJvr4iDF+j1OyCD08G+gynXE1cZixcD515krRWjFzY08QHpsd0eqIo2rMWl1g6kjiLOjUfXJ3bGRipgHUSj1N99oUfizVAO8SF9avb/PtoXMeCHXlGjni/HQbx2w/yuMHjdmu8ZS6zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715953444; c=relaxed/simple;
	bh=wHlakEAftzoRqy+S9zZVLma5AlfLyoxivnFpssVTMqQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CohRavuLSmrnHFNHKuY2F6IO5MuXI3RL2fTxtqWbrATasaed/RzWH34Doqle+LsfInZBqQk5a6+2xS5i7ABpjMEKNL880mXFbVtYQE3f4uC+DheqB5Md19YThbcphd+haGBWUl68lR7bO4ZugCyK6nvRGc/oUdKcMtHGzG0/tbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWWXlJnB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F747C4AF08;
	Fri, 17 May 2024 13:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715953444;
	bh=wHlakEAftzoRqy+S9zZVLma5AlfLyoxivnFpssVTMqQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=hWWXlJnBKjPw4AVdYTHn5hMjoauPPJJ06iGusrWdsejUUJlg1NlnXH8eUjcBaXJqE
	 NMQLOLWMUnqHu6OoNQbxebDhpniREp3Q63JF/zEft1Su2UZ8Ev+yTxuzL0LH3ZOHDx
	 muX7VqG0rcOjI6Q83lQRj/6ouoOKxJrcFLyxa2pB/ozhvutrJeTVKh5vRemXpnU8Td
	 /m/qDbhCzXu8aQcUsWPPubP/2X17+xR4bRwuN19YlXTs6ZHI1dGxN/0mjMgq9Tz/8N
	 agB1znHBeRARurYPf29DHfOMdjlPHbeUkeaCt/dBtsYxldkd45xtXRgztFKuNqjAui
	 LrpXwDoV/QNPQ==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51f174e316eso727224e87.0;
        Fri, 17 May 2024 06:44:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV9cEMKMGxnGfj2IY3zyT1lJ3wtp23lErvo9NWJU7NfSbzPnm4cwny0BXBX4/5sgVFFEDENnmJbjlLcf+rv4RHcI9POGK9zpVatsixOshaArVtVYzDA6t6Y/DVhjRnXejeMdO5HGNtwk5k=
X-Gm-Message-State: AOJu0YzSwz77c2bE+qj6hub+zeOGhbAdBEii/EXadrNSFxzX8jPh6mM1
	4u8wTqIi9a0j0bT71KMg5ZTVl5H5rOnC0Lt08Rho4d24lOQ/iP1oL5RPSkD6XaUkUyrLzxTVhhU
	mhiv5+v5xzxCbSTAxNOSQCFkZ3J4=
X-Google-Smtp-Source: AGHT+IH/OXD9B8QdSVevSFO0IJ/+f4sEJ7acLRN8aew5PmK0K/Zlth+4th3PcsrdwAYSiztvICyU18O6meK82gc5LDk=
X-Received: by 2002:a19:f001:0:b0:51a:c28e:e52 with SMTP id
 2adb3069b0e04-5220fe79412mr13459090e87.46.1715953442524; Fri, 17 May 2024
 06:44:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240429202811.13643-1-James.Bottomley@HansenPartnership.com>
 <20240429202811.13643-19-James.Bottomley@HansenPartnership.com>
 <119dc5ed-f159-41be-9dda-1a056f29888d@notapiano> <0f68c283ff4bbb89b8a019d47891f798c6fff287.camel@HansenPartnership.com>
 <CAMj1kXHi4r8KY9GvX573kwqvLpMfX-J=K2hWiGAKkf5bnicwYQ@mail.gmail.com> <0d260c2f7a9f67ec8bd2305919636678d06000d1.camel@HansenPartnership.com>
In-Reply-To: <0d260c2f7a9f67ec8bd2305919636678d06000d1.camel@HansenPartnership.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 17 May 2024 15:43:51 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFE_R_x10BVkU+8vrMz0RHiX0+rz-ZL+w08FH2CLQHZXA@mail.gmail.com>
Message-ID: <CAMj1kXFE_R_x10BVkU+8vrMz0RHiX0+rz-ZL+w08FH2CLQHZXA@mail.gmail.com>
Subject: Re: [PATCH v8 18/22] tpm: add session encryption protection to tpm2_get_random()
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	=?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>, 
	linux-integrity@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>, 
	keyrings@vger.kernel.org, regressions@lists.linux.dev, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 17 May 2024 at 15:35, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Fri, 2024-05-17 at 09:20 +0200, Ard Biesheuvel wrote:
> > On Fri, 17 May 2024 at 03:59, James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > >
> > > On Thu, 2024-05-16 at 20:25 -0400, N=C3=ADcolas F. R. A. Prado wrote:
> > ...
> > > > KernelCI has identified a new warning and I tracked it down to
> > > > this
> > > > commit. It
> > > > was observed on the following platforms:
> > > > * mt8183-kukui-jacuzzi-juniper-sku16
> > > > * sc7180-trogdor-kingoftown
> > > > (but probably affects all platforms that have a tpm driver with
> > > > async
> > > > probe)
> > > >
> > > > [    2.175146] Call trace:
> > > > [    2.177587]  __request_module+0x188/0x1f4
> > > > [    2.181596]  crypto_alg_mod_lookup+0x178/0x21c
> > > > [    2.186042]  crypto_alloc_tfm_node+0x58/0x114
> > > > [    2.190396]  crypto_alloc_shash+0x24/0x30
> > > > [    2.194404]  drbg_init_hash_kernel+0x28/0xdc
> > > > [    2.198673]  drbg_kcapi_seed+0x21c/0x420
> > > > [    2.202593]  crypto_rng_reset+0x84/0xb4
> > > > [    2.206425]  crypto_get_default_rng+0xa4/0xd8
> > > > [    2.210779]  ecc_gen_privkey+0x58/0xd0
> > > > [    2.214526]  ecdh_set_secret+0x90/0x198
> > > > [    2.218360]  tpm_buf_append_salt+0x164/0x2dc
> > >
> > > This looks like a misconfiguration.  The kernel is trying to load
> > > the
> > > ecdh module, but it should have been selected as built in by this
> > > in
> > > drivers/char/tpm/Kconfig:
> > >
> > > config TCG_TPM2_HMAC
> > >         bool "Use HMAC and encrypted transactions on the TPM bus"
> > >         default y
> > >         select CRYPTO_ECDH
> > >         select CRYPTO_LIB_AESCFB
> > >         select CRYPTO_LIB_SHA256
> > >
> >
> > The module request is not for ECDH itself but for the DRBG it
> > attempts
> > to use to generate the secret.
> >
> > Given that CRYPTO_ECDH does not strictly require a DRBG in principle,
> > but does in this particular case, I think it makes sense to select
> > CRYPTO_DRBG here (or depend on it being builtin), rather than
> > updating the Kconfig rules for CRYPTO_ECDH itself.
>
> Thanks for the analysis.  If I look at how CRYPTO_ECC does it, that
> selects CRYPTO_RNG_DEFAULT which pulls in CRYPTO_DRBG, so the fix would
> be the attached.  Does that look right to you Ard?

No it doesn't - it's CRYPTO_RNG_DEFAULT not CRYTPO_RNG_DEFAULT :-)

With that fixed,

Acked-by: Ard Biesheuvel <ardb@kernel.org>



> And does it work
> Nicolas?
>
> James
>
> ---8>8>8><8<8<8---
>
> From 8c60ffd959eaa65627aca6596c35bb9cbfd9bee6 Mon Sep 17 00:00:00 2001
> From: James Bottomley <James.Bottomley@HansenPartnership.com>
> Date: Fri, 17 May 2024 06:29:31 -0700
> Subject: [PATCH] tpm: Fix sessions cryptography requirement for Random Nu=
mbers
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> The ECDH code in tpm2-sessions.c requires an initial random number
> generator to generate the key pair.  If the configuration doesn't have
> CONFIG_RNG_DEFAULT, it will try to pull this in as a module (which is
> impossible for the early kernel boot where the TPM starts).  Fix this
> by selecting the required RNG.
>
> Reported-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> Fixes: 1b6d7f9eb150 ("tpm: add session encryption protection to tpm2_get_=
random()")
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  drivers/char/tpm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index 4f83ee7021d0..12065eddb922 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -31,6 +31,7 @@ config TCG_TPM2_HMAC
>         bool "Use HMAC and encrypted transactions on the TPM bus"
>         default y
>         select CRYPTO_ECDH
> +       select CRYTPO_RNG_DEFAULT
>         select CRYPTO_LIB_AESCFB
>         select CRYPTO_LIB_SHA256
>         help
> --
> 2.35.3
>
>

