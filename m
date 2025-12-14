Return-Path: <linux-integrity+bounces-7977-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 326BCCBC075
	for <lists+linux-integrity@lfdr.de>; Sun, 14 Dec 2025 22:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76E0F300A86C
	for <lists+linux-integrity@lfdr.de>; Sun, 14 Dec 2025 21:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FD6314D37;
	Sun, 14 Dec 2025 21:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdrBjBRk"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7486128D850;
	Sun, 14 Dec 2025 21:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765748109; cv=none; b=JIooFOhBmOPQzDn0nPjuojcksRpz3VuGrpgsYwjlLCYN5w6VnGEWn7pDmGozsAz5QfCOTP6v057KHwqg46x+poDMGcsMXb8LWeKSoq57AmQEJ+T4/LyZUrp+ohu8S3jvmp2tHIbtMVDhAyvGA1NsjuZSmozfziJ7D++GCWG+y4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765748109; c=relaxed/simple;
	bh=KypWnrVDuSgeED74IjyErznDqhRAy6BFV3+gL/1/tFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tT6P/U1nKW4WpaOfq+h/Vw/VLiOfdW0eLVnvjlep2RKLGDVxqWArdHlvN/udWsRY6IFNpTXgFlDT5WnG5Sh4cEJ1T0djEAKTMTLZC0axh6mlM9gtWDgpznAHdolrPqYHKvcfSLHACwG0e74m7DKvg6FOxZJtrrP4A6dU3ZMstPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdrBjBRk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98293C4CEF1;
	Sun, 14 Dec 2025 21:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765748109;
	bh=KypWnrVDuSgeED74IjyErznDqhRAy6BFV3+gL/1/tFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pdrBjBRkpXEGbKtbBvoQ1tG2mJYRXQ2ywNtCgAOhrKRE8ktRev1bnHVkfOj0yVFzn
	 PiggseIQs2sa50H+ATqhsgDnb1d6Sjuw19YodGZaIW2wUcUdxvaWH1lwuBteef8LJZ
	 YbYbAj8LfpQr/xXsDydccZVlUAGoTSobjdTlaqsJrvfr+m10DCuICRwvBiBFqvdH09
	 sQXVNh7o7jvCDkkepUkLiWb9cJnY/MiSzv3UHlwuWNmcyWAfn7ruicsqFb5V7HkFhD
	 T5j0WsroDnVOMXen2F+LtXz2ds8u0YntFiIWxbrqY49YvNov6a3Bl6nzBLZY4StQ11
	 MtRQutEc5Bqhg==
Date: Sun, 14 Dec 2025 23:35:05 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] KEYS: trusted: Use get_random-fallback for TPM
Message-ID: <aT8tibM9Cx9K0VgT@kernel.org>
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
> -- 
> 2.39.5
> 

Additional cc's as this indirectly relates to hwrng.

BR, Jarkko

