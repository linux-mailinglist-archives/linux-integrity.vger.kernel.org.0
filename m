Return-Path: <linux-integrity+bounces-2438-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCA28C8A44
	for <lists+linux-integrity@lfdr.de>; Fri, 17 May 2024 18:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC8DA1C21E84
	for <lists+linux-integrity@lfdr.de>; Fri, 17 May 2024 16:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E15713D890;
	Fri, 17 May 2024 16:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDUJlkxZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0A738DD6;
	Fri, 17 May 2024 16:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715964533; cv=none; b=gcK96rqsuVHCQSdPVyJRxYesLop7dGopXoWHhsbabq2QPCE974sPfuNzqKzPHpD1vHmolZXLomPud/zLxQ+dtAWmK+1Nh6dzNC68t0i7yFEwsn/QDa3NehcEF0ryZqDDxBnsmK0NntGlMpN1q++QbJqrTNcefj8PrY9CRRKaMe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715964533; c=relaxed/simple;
	bh=UGkdLRqZ6n3b8m0rCAFb9FxggqgZvS7s7r5YjUFxV/s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=HZy6oZMe8iaIC5oD/4jGdEbizuST+6zvtGpHSRXwjKD5ezLapWiIht+nt+acb+9YPXYLDoagrAG6Z16yuLkge6sT0QnzrxD7tkne5Sg97B2bLb/npWI3Y6VaWFj6ZjnKAjcTJrfs4LXq/hjXSOU/Bm7PR1wTZGc0jqchjtXCIsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDUJlkxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD1EC2BD10;
	Fri, 17 May 2024 16:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715964532;
	bh=UGkdLRqZ6n3b8m0rCAFb9FxggqgZvS7s7r5YjUFxV/s=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=kDUJlkxZiXqWz8DV3xX4JG+pjnQr7+gpM5367q5r2232f7PxD7E103JpoVL3dcb3v
	 BPfHFX6Mq6AZhQxSPViM5+nCYxYK4uIYA1mMowSoqyjsX0OqHhejUttWRkJjfphQ/O
	 QhKLOR0e2o4X2p4fE+OmYu4p8i2kWHouN4a5Uw9zAhKs10wuRfHjr6J3Aw+GIy3/6N
	 tGSmod6sTDtm8RNx8dO/yILAY7u0vCcqsRRyRV028Ep8j5F0ZyutSZOj2N47GeFWpP
	 bt9IOJtsIHf88gH3+Sf4j6GNDZCeaoB9+JrsM07P6Dvfdu06tT6h2KnxFAdwuD5Ehl
	 1S9Cso3tRTOpA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 May 2024 19:48:48 +0300
Message-Id: <D1C2NPOBHAHK.20O4IME8OK1FH@kernel.org>
Cc: "Ard Biesheuvel" <ardb@kernel.org>, "Linux Crypto Mailing List"
 <linux-crypto@vger.kernel.org>, "Herbert Xu" <herbert@gondor.apana.org.au>,
 <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
 <regressions@lists.linux.dev>, <kernel@collabora.com>
Subject: Re: [PATCH v8 18/22] tpm: add session encryption protection to
 tpm2_get_random()
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: =?utf-8?b?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 "James Bottomley" <James.Bottomley@hansenpartnership.com>
X-Mailer: aerc 0.17.0
References: <20240429202811.13643-1-James.Bottomley@HansenPartnership.com>
 <20240429202811.13643-19-James.Bottomley@HansenPartnership.com>
 <119dc5ed-f159-41be-9dda-1a056f29888d@notapiano>
 <0f68c283ff4bbb89b8a019d47891f798c6fff287.camel@HansenPartnership.com>
 <CAMj1kXHi4r8KY9GvX573kwqvLpMfX-J=K2hWiGAKkf5bnicwYQ@mail.gmail.com>
 <0d260c2f7a9f67ec8bd2305919636678d06000d1.camel@HansenPartnership.com>
 <CAMj1kXFE_R_x10BVkU+8vrMz0RHiX0+rz-ZL+w08FH2CLQHZXA@mail.gmail.com>
 <66ec985f3ee229135bf748f1b0874d5367a74d7f.camel@HansenPartnership.com>
 <dfb0d930-7cbe-46c5-be19-d132b4906ecf@notapiano>
In-Reply-To: <dfb0d930-7cbe-46c5-be19-d132b4906ecf@notapiano>

On Fri May 17, 2024 at 7:22 PM EEST, N=C3=ADcolas F. R. A. Prado wrote:
> On Fri, May 17, 2024 at 07:25:40AM -0700, James Bottomley wrote:
> > On Fri, 2024-05-17 at 15:43 +0200, Ard Biesheuvel wrote:
> > > On Fri, 17 May 2024 at 15:35, James Bottomley
> > > <James.Bottomley@hansenpartnership.com> wrote:
> > [...]
> > > > Thanks for the analysis.=C2=A0 If I look at how CRYPTO_ECC does it,=
 that
> > > > selects CRYPTO_RNG_DEFAULT which pulls in CRYPTO_DRBG, so the fix
> > > > would be the attached.=C2=A0 Does that look right to you Ard?
> > >=20
> > > No it doesn't - it's CRYPTO_RNG_DEFAULT not CRYTPO_RNG_DEFAULT :-)
> > >=20
> > > With that fixed,
> > >=20
> > > Acked-by: Ard Biesheuvel <ardb@kernel.org>
> >=20
> > Erm, oops, sorry about that; so attached is the update.
> >=20
> > James
> >=20
> > ---8>8>8><8<8<8---
> >=20
> > From 2ac337a33e6416ef806e2c692b9239d193e8468f Mon Sep 17 00:00:00 2001
> > From: James Bottomley <James.Bottomley@HansenPartnership.com>
> > Date: Fri, 17 May 2024 06:29:31 -0700
> > Subject: [PATCH] tpm: Fix sessions cryptography requirement for Random =
Numbers
> > MIME-Version: 1.0
> > Content-Type: text/plain; charset=3DUTF-8
> > Content-Transfer-Encoding: 8bit
> >=20
> > The ECDH code in tpm2-sessions.c requires an initial random number
> > generator to generate the key pair.  If the configuration doesn't have
> > CONFIG_RNG_DEFAULT, it will try to pull this in as a module (which is
> > impossible for the early kernel boot where the TPM starts).  Fix this
> > by selecting the required RNG.
> >=20
> > Reported-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> > Fixes: 1b6d7f9eb150 ("tpm: add session encryption protection to tpm2_ge=
t_random()")
> > Acked-by: Ard Biesheuvel <ardb@kernel.org>
> > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> > ---
> >  drivers/char/tpm/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> > index 4f83ee7021d0..ecdd3db4be2b 100644
> > --- a/drivers/char/tpm/Kconfig
> > +++ b/drivers/char/tpm/Kconfig
> > @@ -31,6 +31,7 @@ config TCG_TPM2_HMAC
> >  	bool "Use HMAC and encrypted transactions on the TPM bus"
> >  	default y
> >  	select CRYPTO_ECDH
> > +	select CRYPTO_RNG_DEFAULT
> >  	select CRYPTO_LIB_AESCFB
> >  	select CRYPTO_LIB_SHA256
> >  	help
> > --=20
> > 2.35.3
> >=20
> >=20
>
> Hi James,
>
> thanks for the patch. But I actually already had that config enabled buil=
tin. I
> also had ECDH and DRBG which have been suggested previously:
>
> 	CONFIG_CRYPTO_RNG_DEFAULT=3Dy
>
> 	CONFIG_CRYPTO_DRBG_MENU=3Dy
> 	CONFIG_CRYPTO_DRBG_HMAC=3Dy
> 	# CONFIG_CRYPTO_DRBG_HASH is not set
> 	# CONFIG_CRYPTO_DRBG_CTR is not set
> 	CONFIG_CRYPTO_DRBG=3Dy
>
> 	CONFIG_CRYPTO_ECDH=3Dy
>
> I've pasted my full config here: http://0x0.st/XPN_.txt
>
> Adding a debug print I see that the module that the code tries to load is
> "crypto-hmac(sha512)". I would have expected to see=20
>
> 	MODULE_ALIAS_CRYPTO("hmac(sha512)");
>
> in crypto/drbg.c, but I don't see it anywhere in the tree. Maybe it is mi=
ssing?

1. Bug fixes need to be submitted as described in
   https://www.kernel.org/doc/html/latest/process/submitting-patches.html
2. The patch is missing the transcript:
   https://lore.kernel.org/linux-integrity/D1BRZ60B9O5S.3NAT20QPQE6KH@kerne=
l.org/

There's nothing to review at this point.

>
> Thanks,
> N=C3=ADcolas

BR, Jarkko

