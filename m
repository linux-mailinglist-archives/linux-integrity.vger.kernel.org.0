Return-Path: <linux-integrity+bounces-2440-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F21A8C8F99
	for <lists+linux-integrity@lfdr.de>; Sat, 18 May 2024 06:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2F2F282CB4
	for <lists+linux-integrity@lfdr.de>; Sat, 18 May 2024 04:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C75B8F49;
	Sat, 18 May 2024 04:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCTwAgtz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363B64C8B;
	Sat, 18 May 2024 04:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716006678; cv=none; b=cWdt4VMc8rHctT/1ySee88JUinZHLtWQ/KqOffx+fk4OQlRo9H+YR13X1dn+soLOX8qiaBVU+rKa3tGXVizSlZo2BFteIHQGuPih/FeNu3I+hCoU7KErXME5YjFNAjtt2RHscDkK7y+iv50UZdpLjjlcJ2dFhopVnRGqONiSSMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716006678; c=relaxed/simple;
	bh=yHlF0RNK2ZiLjSzvRN9fYJygVVSLmdKT2x521bdwC7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZpo8HEABKhrkp+82dgRsGIJ444nmKBSiaiLztcEtXMWPpwGztFzezEGc1uwYHWSq0suO4EDIYiSUJvfX+XNgbSCJEAkD8qJiMMI70I9Dmt1nLA3pZq8LkfdzMmwEHU7yuwIjJv7/A1jJ+jLTp7b8EGPipx2JaNLkdSeNPC2O4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCTwAgtz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A29CC113CC;
	Sat, 18 May 2024 04:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716006677;
	bh=yHlF0RNK2ZiLjSzvRN9fYJygVVSLmdKT2x521bdwC7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TCTwAgtzxxcO1hbNtL5uw9Fdh7H+FT2osw50t6TWju3ccYJ+tvjHbiP+ZhNYy27gK
	 19wLPSri/cGVdjfWr73MOZfzNN/tvYWtYEnNwYaHE99dmcVHO4hUcwR5MmA40/hlkf
	 MTxPqFNtOXMu67CnuvD7wAAsX3qXUj0hkcMw/O6Gx38QEqNwlLQObkfezhCD63nIMY
	 2FpxIO9+rcoXSAqlO761WTECJJukBkWnMEDlTnhBpd/EOjDoAfv/M36XNmYSbDCGAB
	 selUJIx7EgcCHjFCB7niRXOGa0TkmzLVuiVBlVRsCEOzOiKEMYDeLNkHdlStlcJhsR
	 5Kmd/5BcbgA+Q==
Date: Fri, 17 May 2024 21:31:15 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	regressions@lists.linux.dev, kernel@collabora.com
Subject: Re: [PATCH v8 18/22] tpm: add session encryption protection to
 tpm2_get_random()
Message-ID: <20240518043115.GA53815@sol.localdomain>
References: <20240429202811.13643-1-James.Bottomley@HansenPartnership.com>
 <20240429202811.13643-19-James.Bottomley@HansenPartnership.com>
 <119dc5ed-f159-41be-9dda-1a056f29888d@notapiano>
 <0f68c283ff4bbb89b8a019d47891f798c6fff287.camel@HansenPartnership.com>
 <CAMj1kXHi4r8KY9GvX573kwqvLpMfX-J=K2hWiGAKkf5bnicwYQ@mail.gmail.com>
 <0d260c2f7a9f67ec8bd2305919636678d06000d1.camel@HansenPartnership.com>
 <CAMj1kXFE_R_x10BVkU+8vrMz0RHiX0+rz-ZL+w08FH2CLQHZXA@mail.gmail.com>
 <66ec985f3ee229135bf748f1b0874d5367a74d7f.camel@HansenPartnership.com>
 <dfb0d930-7cbe-46c5-be19-d132b4906ecf@notapiano>
 <D1C2NPOBHAHK.20O4IME8OK1FH@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D1C2NPOBHAHK.20O4IME8OK1FH@kernel.org>

On Fri, May 17, 2024 at 07:48:48PM +0300, Jarkko Sakkinen wrote:
> On Fri May 17, 2024 at 7:22 PM EEST, Nícolas F. R. A. Prado wrote:
> > On Fri, May 17, 2024 at 07:25:40AM -0700, James Bottomley wrote:
> > > On Fri, 2024-05-17 at 15:43 +0200, Ard Biesheuvel wrote:
> > > > On Fri, 17 May 2024 at 15:35, James Bottomley
> > > > <James.Bottomley@hansenpartnership.com> wrote:
> > > [...]
> > > > > Thanks for the analysis.  If I look at how CRYPTO_ECC does it, that
> > > > > selects CRYPTO_RNG_DEFAULT which pulls in CRYPTO_DRBG, so the fix
> > > > > would be the attached.  Does that look right to you Ard?
> > > > 
> > > > No it doesn't - it's CRYPTO_RNG_DEFAULT not CRYTPO_RNG_DEFAULT :-)
> > > > 
> > > > With that fixed,
> > > > 
> > > > Acked-by: Ard Biesheuvel <ardb@kernel.org>
> > > 
> > > Erm, oops, sorry about that; so attached is the update.
> > > 
> > > James
> > > 
> > > ---8>8>8><8<8<8---
> > > 
> > > From 2ac337a33e6416ef806e2c692b9239d193e8468f Mon Sep 17 00:00:00 2001
> > > From: James Bottomley <James.Bottomley@HansenPartnership.com>
> > > Date: Fri, 17 May 2024 06:29:31 -0700
> > > Subject: [PATCH] tpm: Fix sessions cryptography requirement for Random Numbers
> > > MIME-Version: 1.0
> > > Content-Type: text/plain; charset=UTF-8
> > > Content-Transfer-Encoding: 8bit
> > > 
> > > The ECDH code in tpm2-sessions.c requires an initial random number
> > > generator to generate the key pair.  If the configuration doesn't have
> > > CONFIG_RNG_DEFAULT, it will try to pull this in as a module (which is
> > > impossible for the early kernel boot where the TPM starts).  Fix this
> > > by selecting the required RNG.
> > > 
> > > Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > > Fixes: 1b6d7f9eb150 ("tpm: add session encryption protection to tpm2_get_random()")
> > > Acked-by: Ard Biesheuvel <ardb@kernel.org>
> > > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> > > ---
> > >  drivers/char/tpm/Kconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> > > index 4f83ee7021d0..ecdd3db4be2b 100644
> > > --- a/drivers/char/tpm/Kconfig
> > > +++ b/drivers/char/tpm/Kconfig
> > > @@ -31,6 +31,7 @@ config TCG_TPM2_HMAC
> > >  	bool "Use HMAC and encrypted transactions on the TPM bus"
> > >  	default y
> > >  	select CRYPTO_ECDH
> > > +	select CRYPTO_RNG_DEFAULT
> > >  	select CRYPTO_LIB_AESCFB
> > >  	select CRYPTO_LIB_SHA256
> > >  	help
> > > -- 
> > > 2.35.3
> > > 
> > > 
> >
> > Hi James,
> >
> > thanks for the patch. But I actually already had that config enabled builtin. I
> > also had ECDH and DRBG which have been suggested previously:
> >
> > 	CONFIG_CRYPTO_RNG_DEFAULT=y
> >
> > 	CONFIG_CRYPTO_DRBG_MENU=y
> > 	CONFIG_CRYPTO_DRBG_HMAC=y
> > 	# CONFIG_CRYPTO_DRBG_HASH is not set
> > 	# CONFIG_CRYPTO_DRBG_CTR is not set
> > 	CONFIG_CRYPTO_DRBG=y
> >
> > 	CONFIG_CRYPTO_ECDH=y
> >
> > I've pasted my full config here: http://0x0.st/XPN_.txt
> >
> > Adding a debug print I see that the module that the code tries to load is
> > "crypto-hmac(sha512)". I would have expected to see 
> >
> > 	MODULE_ALIAS_CRYPTO("hmac(sha512)");
> >
> > in crypto/drbg.c, but I don't see it anywhere in the tree. Maybe it is missing?
> 

This is "normal" behavior when the crypto API instantiates a template:

    1. drbg.c asks for "hmac(sha512)"

    2. The crypto API looks for a direct implementation of "hmac(sha512)".
       This includes requesting a module with alias "crypto-hmac(sha512)".

    3. If none is found, the "hmac" template is instantiated instead.

There are two possible fixes for the bug.  Either fix ecc_gen_privkey() to just
use get_random_bytes() instead of the weird crypto API RNG, or make
drbg_init_hash_kernel() pass the CRYPTO_NOLOAD flag to crypto_alloc_shash().

Or if the TPM driver could be changed to not need to generate an ECC private key
at probe time, that would also avoid this problem.

- Eric

