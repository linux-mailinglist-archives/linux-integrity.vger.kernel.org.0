Return-Path: <linux-integrity+bounces-8080-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4E4CC54AE
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 23:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37EE2303FA58
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 22:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6948334698;
	Tue, 16 Dec 2025 22:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMThKf01"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A406C30F948;
	Tue, 16 Dec 2025 22:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765922626; cv=none; b=r3iWvvabF+mf2fFVrIfYMwsGmx+9TJeJyahJXeZysoS+gr/oR26bl6aTJHU6vurVGTXop2MrEuVaTUAgrduJrbplB+26BvTcfV/J92Sq6Z7B4WFf4PTDtWhkrDa76HC1EF7oLgWTjvTeCVG1tRM/+1bN3ZsrzbCRcahF6m0eusY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765922626; c=relaxed/simple;
	bh=foBL3RjYh9d3548u2bdY1nzkwQXBvsPdjjeS8P8Sthw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=euz5THAzHz/AU89kupEKI46Ji4Sma4drGZdqCPqzuFFfDQTx8ATUVNPjUyD/OJA/a3RT9siGORPvGK4l+iIs2+R05OTA7AVcXF5pGk2ihCVJaGaF/R8cUNXzPB3Bt3OJwGzkPRrd2nAffY01jaxaWrZfx5TJLGqeiTyJqXukpCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMThKf01; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7554C4CEF1;
	Tue, 16 Dec 2025 22:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765922626;
	bh=foBL3RjYh9d3548u2bdY1nzkwQXBvsPdjjeS8P8Sthw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GMThKf01WuR+Kj3F19PTBOE1IT9Rx88IrmeY+CDxWS8WPl11nxLQ0I20zI8PLOhxQ
	 S77C4o/+hRM5LWtpxiiToWCAW629T4v48J66GTTOGnWkc+wTecpYp9ku/R/s1ESOnK
	 0WeWVlGTx+N7ouJ23EkiKMzSnew1WGeD9GTnhQhrW/Kh/toWzx0Nqh1bicccfhDvHZ
	 ErPj+LZ3xYD0kMJfqh0MtIQ+7Ty6Z8UzYgzWP52eZLCO9STor6C1krg20/HGUEafaZ
	 7/t7/93CGrjVzxZKSPJU7e1AqKCT4eO+o2DZOPGNuDk9icY+kF98kL8T3ZU0Gl4fy2
	 DhBqu4gqWfx6Q==
Date: Wed, 17 Dec 2025 00:03:41 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Biggers <ebiggers@kernel.org>, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v8 04/12] tpm: Change tpm_get_random() opportunistic
Message-ID: <aUHXPWG72CsNhgpd@kernel.org>
References: <20251216092147.2326606-1-jarkko@kernel.org>
 <20251216092147.2326606-5-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216092147.2326606-5-jarkko@kernel.org>

On Tue, Dec 16, 2025 at 11:21:38AM +0200, Jarkko Sakkinen wrote:
> hwrng framework does not have a requirement that the all bytes requested
> need to be provided. By enforcing such a requirement internally, TPM driver
> can cause unpredictability in latency, as a single tpm_get_random() call
> can result multiple TPM commands.
> 
> Especially, when TCG_TPM2_HMAC is enabled, extra roundtrips could have
> significant effect to the system latency.
> 
> Thus, send TPM command only once and return bytes received instead of
> committing to the number of requested bytes.
> 
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v7:
> - Given that hwrng is now only caller for tpm_get_random(), remove the
>   wait parameter.
> v4:
> - Fixed grammar mistakes.
> ---

IMHO, these first four patches that add sanity to tpm_get_random() usage
ought to be somewhat "dead obvious" category.

Once these are merged it is much easier to further reduce the frequency
of tpm_get_random() calls made, and test their effect on e.g. call 
frequency (as tpm_get_random() is now much more tighly bound to hwrng
requirements).

>  drivers/char/tpm/tpm-interface.c | 28 +++++-----------------------
>  1 file changed, 5 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index d157be738612..677dcef05dfb 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -626,10 +626,6 @@ static int tpm2_get_random(struct tpm_chip *chip, u8 *out, size_t max)
>   */
>  int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
>  {
> -	u32 num_bytes = max;
> -	u8 *out_ptr = out;
> -	int retries = 5;
> -	int total = 0;
>  	int rc;
>  
>  	if (!out || !max || max > TPM_MAX_RNG_DATA)
> @@ -646,28 +642,14 @@ int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
>  		rc = tpm2_start_auth_session(chip);
>  		if (rc)
>  			return rc;
> -	}
> -
> -	do {
> -		if (chip->flags & TPM_CHIP_FLAG_TPM2)
> -			rc = tpm2_get_random(chip, out_ptr, num_bytes);
> -		else
> -			rc = tpm1_get_random(chip, out_ptr, num_bytes);
> -
> -		if (rc < 0)
> -			goto err;
> -
> -		out_ptr += rc;
> -		total += rc;
> -		num_bytes -= rc;
> -	} while (retries-- && total < max);
>  
> -	tpm_put_ops(chip);
> -	return total ? total : -EIO;
> +		rc = tpm2_get_random(chip, out, max);
> +	} else {
> +		rc = tpm1_get_random(chip, out, max);
> +	}
>  
> -err:
>  	tpm_put_ops(chip);
> -	return rc;
> +	return rc != 0 ? rc : -EIO;
>  }
>  EXPORT_SYMBOL_GPL(tpm_get_random);
>  
> -- 
> 2.39.5
> 

BR, Jarkko

