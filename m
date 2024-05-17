Return-Path: <linux-integrity+bounces-2437-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9218C89F2
	for <lists+linux-integrity@lfdr.de>; Fri, 17 May 2024 18:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACCEA1C212F6
	for <lists+linux-integrity@lfdr.de>; Fri, 17 May 2024 16:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117A212FB18;
	Fri, 17 May 2024 16:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WFmp9B1V"
X-Original-To: linux-integrity@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232CE12FB08;
	Fri, 17 May 2024 16:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715962976; cv=none; b=dyclK6lcMsBhumHxBmtPL1peTdcwAuysiaNV5tBXP1uUaDrlJ6JlNxGckDuAvKleb7CeEJP88kNwBXdUP1WDczbeyB3Ft7N1H7fqJfRw/8Zums2gJ0eAGCU6EodDmkDF6HMeaOcAylbLymLDMLCNlNLVaEH86yUJU+fhgXQMY0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715962976; c=relaxed/simple;
	bh=Y8VYJSRaClIxsKWMyAcpAo4yWf+eyBO54OeCvA+DW2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZVnVtPQs31I1K5ZLwgWBcTYQJdYteGgn0l9MUJHSB1EfMFt5zjhUdARj4E/Q+36Ea1XxDqsbDSEfqEbPCf4s8ELM4Mt2ho7UjmNotzHUxUcr4BD2kxkZxcJyM6ibS6JRN292IZX3XDSyY9NMZ40NMMhS+W8EuDdpu7tRj3p9eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WFmp9B1V; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1715962971;
	bh=Y8VYJSRaClIxsKWMyAcpAo4yWf+eyBO54OeCvA+DW2Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WFmp9B1V31C84xEt+V6MsjtsHgF+duR9E4VHGNjlD5SeCH6OeGllaG+dEOTRxvgvD
	 aSjbNj+pAn+96eLf1lwow1QQ4vROsJmWKFJ1+7pRbYG1Hogdm4DlwkA16H/xFK1vTm
	 4NxP2sGYVhHkKgA4JsGY8U+vwk8Z0y89Vp6tIaaIUCvLkIMuKc3Tt/CNBEE4IqrtMU
	 rPapZpSEpXA9KBp3rOCpno6kXQ2vqkTNaYISIv0cSyzYeS2EBr6p1Jfjh3QJ0JZwQV
	 QI9848VK0313QlS4MAhU4nQsfhjj7VxWyjZxB3Zb4jxFwgj65doAuunI5WG1cE2QYz
	 xck5xMIWt07ug==
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9268F3780627;
	Fri, 17 May 2024 16:22:49 +0000 (UTC)
Date: Fri, 17 May 2024 12:22:47 -0400
From: =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado <nfraprado@collabora.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Ard Biesheuvel <ardb@kernel.org>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-integrity@vger.kernel.org,
	Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
	regressions@lists.linux.dev, kernel@collabora.com
Subject: Re: [PATCH v8 18/22] tpm: add session encryption protection to
 tpm2_get_random()
Message-ID: <dfb0d930-7cbe-46c5-be19-d132b4906ecf@notapiano>
References: <20240429202811.13643-1-James.Bottomley@HansenPartnership.com>
 <20240429202811.13643-19-James.Bottomley@HansenPartnership.com>
 <119dc5ed-f159-41be-9dda-1a056f29888d@notapiano>
 <0f68c283ff4bbb89b8a019d47891f798c6fff287.camel@HansenPartnership.com>
 <CAMj1kXHi4r8KY9GvX573kwqvLpMfX-J=K2hWiGAKkf5bnicwYQ@mail.gmail.com>
 <0d260c2f7a9f67ec8bd2305919636678d06000d1.camel@HansenPartnership.com>
 <CAMj1kXFE_R_x10BVkU+8vrMz0RHiX0+rz-ZL+w08FH2CLQHZXA@mail.gmail.com>
 <66ec985f3ee229135bf748f1b0874d5367a74d7f.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66ec985f3ee229135bf748f1b0874d5367a74d7f.camel@HansenPartnership.com>

On Fri, May 17, 2024 at 07:25:40AM -0700, James Bottomley wrote:
> On Fri, 2024-05-17 at 15:43 +0200, Ard Biesheuvel wrote:
> > On Fri, 17 May 2024 at 15:35, James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> [...]
> > > Thanks for the analysis.  If I look at how CRYPTO_ECC does it, that
> > > selects CRYPTO_RNG_DEFAULT which pulls in CRYPTO_DRBG, so the fix
> > > would be the attached.  Does that look right to you Ard?
> > 
> > No it doesn't - it's CRYPTO_RNG_DEFAULT not CRYTPO_RNG_DEFAULT :-)
> > 
> > With that fixed,
> > 
> > Acked-by: Ard Biesheuvel <ardb@kernel.org>
> 
> Erm, oops, sorry about that; so attached is the update.
> 
> James
> 
> ---8>8>8><8<8<8---
> 
> From 2ac337a33e6416ef806e2c692b9239d193e8468f Mon Sep 17 00:00:00 2001
> From: James Bottomley <James.Bottomley@HansenPartnership.com>
> Date: Fri, 17 May 2024 06:29:31 -0700
> Subject: [PATCH] tpm: Fix sessions cryptography requirement for Random Numbers
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> The ECDH code in tpm2-sessions.c requires an initial random number
> generator to generate the key pair.  If the configuration doesn't have
> CONFIG_RNG_DEFAULT, it will try to pull this in as a module (which is
> impossible for the early kernel boot where the TPM starts).  Fix this
> by selecting the required RNG.
> 
> Reported-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Fixes: 1b6d7f9eb150 ("tpm: add session encryption protection to tpm2_get_random()")
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
>  drivers/char/tpm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index 4f83ee7021d0..ecdd3db4be2b 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -31,6 +31,7 @@ config TCG_TPM2_HMAC
>  	bool "Use HMAC and encrypted transactions on the TPM bus"
>  	default y
>  	select CRYPTO_ECDH
> +	select CRYPTO_RNG_DEFAULT
>  	select CRYPTO_LIB_AESCFB
>  	select CRYPTO_LIB_SHA256
>  	help
> -- 
> 2.35.3
> 
> 

Hi James,

thanks for the patch. But I actually already had that config enabled builtin. I
also had ECDH and DRBG which have been suggested previously:

	CONFIG_CRYPTO_RNG_DEFAULT=y

	CONFIG_CRYPTO_DRBG_MENU=y
	CONFIG_CRYPTO_DRBG_HMAC=y
	# CONFIG_CRYPTO_DRBG_HASH is not set
	# CONFIG_CRYPTO_DRBG_CTR is not set
	CONFIG_CRYPTO_DRBG=y

	CONFIG_CRYPTO_ECDH=y

I've pasted my full config here: http://0x0.st/XPN_.txt

Adding a debug print I see that the module that the code tries to load is
"crypto-hmac(sha512)". I would have expected to see 

	MODULE_ALIAS_CRYPTO("hmac(sha512)");

in crypto/drbg.c, but I don't see it anywhere in the tree. Maybe it is missing?

Thanks,
Nícolas

