Return-Path: <linux-integrity+bounces-2448-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DCE8C90D5
	for <lists+linux-integrity@lfdr.de>; Sat, 18 May 2024 14:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26DD2B20A7C
	for <lists+linux-integrity@lfdr.de>; Sat, 18 May 2024 12:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A27328379;
	Sat, 18 May 2024 12:31:20 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5B3BE49;
	Sat, 18 May 2024 12:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716035480; cv=none; b=VBg0HWLkwHvv6E7P+bsDUQE9jkXmL/gHdZZx4VTFrgiTW25vjrEw5aS51pSSHpEC7gD6Ro3ugxuH6Vlj73Q4LnCaHl5W8BMgauXa/MomPyE8Jz9qn4zf2EaREFGx5Wj3PuZbmJJgn8hrjFBgRVgrRedzSe87WVzDkeZ4e+ZopUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716035480; c=relaxed/simple;
	bh=YaHyg4NL1kWUWTrvUb2RJjbRMf1rRmn/5oDvx0WxbTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2/uXctmjQ349FABIvMMY6fM9tUC85qO4G428kE0E6enUWpIrAohE12rVP3/PSsHKLjE56LHnNI8z8gSbnk52aLoJ9rs9lxj9bb0E/7OXvK6QQMjXpvCS+pxePY/ECT1/+HWMZ7tzUWs0y2aazc79Qte6Ap2i9SK0iN2ML2v7eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s8JDL-00H5cY-1d;
	Sat, 18 May 2024 20:31:04 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 18 May 2024 20:31:04 +0800
Date: Sat, 18 May 2024 20:31:04 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	regressions@lists.linux.dev, kernel@collabora.com
Subject: Re: [PATCH v8 18/22] tpm: add session encryption protection to
 tpm2_get_random()
Message-ID: <ZkifiKqvlT6-6P6L@gondor.apana.org.au>
References: <119dc5ed-f159-41be-9dda-1a056f29888d@notapiano>
 <0f68c283ff4bbb89b8a019d47891f798c6fff287.camel@HansenPartnership.com>
 <CAMj1kXHi4r8KY9GvX573kwqvLpMfX-J=K2hWiGAKkf5bnicwYQ@mail.gmail.com>
 <0d260c2f7a9f67ec8bd2305919636678d06000d1.camel@HansenPartnership.com>
 <CAMj1kXFE_R_x10BVkU+8vrMz0RHiX0+rz-ZL+w08FH2CLQHZXA@mail.gmail.com>
 <66ec985f3ee229135bf748f1b0874d5367a74d7f.camel@HansenPartnership.com>
 <dfb0d930-7cbe-46c5-be19-d132b4906ecf@notapiano>
 <D1C2NPOBHAHK.20O4IME8OK1FH@kernel.org>
 <20240518043115.GA53815@sol.localdomain>
 <D1CPSP3UHQPK.1LOE5IQ6IMHYP@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D1CPSP3UHQPK.1LOE5IQ6IMHYP@kernel.org>

On Sat, May 18, 2024 at 01:56:44PM +0300, Jarkko Sakkinen wrote:
>
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -36,6 +36,8 @@ config TCG_TPM2_HMAC
>         bool "Use HMAC and encrypted transactions on the TPM bus"
>         default y
> +       select CRYPTO_DRBG
>         select CRYPTO_ECDH
> +       select CRYPTO_HMAC
> +       select CRYPTO_SHA512
>         select CRYPTO_LIB_AESCFB
>         select CRYPTO_LIB_SHA256
>         help

This isn't necessary because ECDH selects ECC which already
selects the DRBG and all the required algorithms.

You can verify this with the failing .config file as it has
everything needed built into the kernel (which is in fact
where the problem is).

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

