Return-Path: <linux-integrity+bounces-7997-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4118ECBFB30
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 21:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF14C302107B
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 20:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E7F2E7BCA;
	Mon, 15 Dec 2025 20:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CSf3rTKr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF8E2505A5;
	Mon, 15 Dec 2025 20:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765829382; cv=none; b=t4U4vmfLjLQifTJEcMtP5XpH9scagI4nxaIN5SldQvvqWO8V9zhowhYXzGPhSFj/9t2tmTyBRTUMR/jr8vVjxi7DipxoCO5SeVlrsne+yhrWqnecXZPvYEGQjYnzpBdjuWJxGuGvL6R0rpztsAK5RIvSq5xBh0mf18GZwRTmi0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765829382; c=relaxed/simple;
	bh=ATht8IaRKm6Y3YiiFshaC/90ksDrtpsQQsc5R7ZPPCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFmG2kDUOkx0+fB7UTQZ5LdiB00GIMZcDowiB5obkSxBstKDH28c30TDswQoW9cN8SAXgdldArU/MsUEjTUaogT/pz5YC24QsObCiSZwNpMtWYjFglwO5zLMVNn1duh4gWzngkvrglA74B9KzbxwwOvpQvBJ8tjPUj+wiqwr7do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CSf3rTKr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6963DC4CEF5;
	Mon, 15 Dec 2025 20:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765829381;
	bh=ATht8IaRKm6Y3YiiFshaC/90ksDrtpsQQsc5R7ZPPCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CSf3rTKrxef81x8tSBwde9QmFF3eo1Y5V1hOyJAhmLeofwOiXERXqtHRkxra66GBN
	 HLp7MRkST4HQbVaa64XW545PwdI3my/GfXk/C/QBEgijoOyTyYZ/+fmfMZjM3eRF2g
	 LgMBBd410HsYLaMXJKFGJmUQb517iIF5o45/u+GEU3Pn4GJ6FozrCqhU6wLp24j7Fd
	 smUNHpl5ylmk9J5SfkpN9CsUIpKglMTaNiWukYGFi99RcwLCF5fLVxxFzPGtxYCnGZ
	 bF7cwcoivIFQu8coHyyry6Wl8GsosvdOanBujg9Huu+HXSecrBRk7dDOA+gBV1QCR+
	 QNn0ultAbBQqw==
Date: Mon, 15 Dec 2025 20:09:39 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH] KEYS: trusted: Use get_random-fallback for TPM
Message-ID: <20251215200939.GA10539@google.com>
References: <20251214213236.339586-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251214213236.339586-1-jarkko@kernel.org>

On Sun, Dec 14, 2025 at 11:32:36PM +0200, Jarkko Sakkinen wrote:
> 1. tpm2_get_random() is costly when TCG_TPM2_HMAC is enabled and thus its
>    use should be pooled rather than directly used. This both reduces
>    latency and improves its predictability.
> 
> 2. Linux is better off overall if every subsystem uses the same source for
>    the random bistream as the de-facto choice, unless *force majeure*
>    reasons point to some other direction.
> 
> In the case, of TPM there is no reason for trusted keys to invoke TPM
> directly.
> 
> Thus, unset '.get_random', which causes fallback to kernel_get_random().
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  security/keys/trusted-keys/trusted_tpm1.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
> index 636acb66a4f6..33b7739741c3 100644
> --- a/security/keys/trusted-keys/trusted_tpm1.c
> +++ b/security/keys/trusted-keys/trusted_tpm1.c
> @@ -936,11 +936,6 @@ static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
>  	return ret;
>  }
>  
> -static int trusted_tpm_get_random(unsigned char *key, size_t key_len)
> -{
> -	return tpm_get_random(chip, key, key_len);
> -}
> -
>  static int __init init_digests(void)
>  {
>  	int i;
> @@ -992,6 +987,5 @@ struct trusted_key_ops trusted_key_tpm_ops = {
>  	.init = trusted_tpm_init,
>  	.seal = trusted_tpm_seal,
>  	.unseal = trusted_tpm_unseal,
> -	.get_random = trusted_tpm_get_random,
>  	.exit = trusted_tpm_exit,
>  };

Reviewed-by: Eric Biggers <ebiggers@kernel.org>

Agreed that kernel code should prefer the standard Linux RNG whenever
possible.  Note that the standard Linux RNG already incorporates entropy
from hardware RNGs, when available.

- Eric

