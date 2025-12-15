Return-Path: <linux-integrity+bounces-8006-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 987E6CC02A3
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Dec 2025 00:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 622DC301373C
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 23:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322D228A3FA;
	Mon, 15 Dec 2025 23:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0nhdpCn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31DE216E24;
	Mon, 15 Dec 2025 23:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765840671; cv=none; b=rtaR45TcD+FDfZkgOAmIXrGZ7QWpoOW9GrctsMil+ADIElhEtibKhh6nef8017e9pCnqI0ZyhzTeysHDVBET6APILjiFqLdXcDMF6qYmc9HdaewyvXVOuG9H7+0YxQRK6XaUGFg3Zyzqm8wEPoJoQZ0TTtXzlwPsaMnDTlzYW5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765840671; c=relaxed/simple;
	bh=cQRf2Prx0GqKDyhCvxGPBQCnsU7wwfIKq/Tx292M6yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgsUgGUm3TecC/T8B0/zYhTHXVGKTIaPBW3bIKm02qMHAoklfGTLIwLy+mBGhYCmd8ChjnBZ/c/6oGaT8Py7lSDFytlGmk5v01V+6ekrj+sn/SC9FR21PyDWkqzbOn/vl97Q/Fgce5+bYPMD+UHONUIzLqY425xpKglC1l9Gh60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0nhdpCn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E3FC4CEF5;
	Mon, 15 Dec 2025 23:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765840670;
	bh=cQRf2Prx0GqKDyhCvxGPBQCnsU7wwfIKq/Tx292M6yw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N0nhdpCnIxhJ8KLjsAaATZrN1ThHHZreG108ANbZqSGy8T34NGZAwydskmZcs8RZM
	 vjm/RKbG2C1peG3WlgidzVte2KRw8tpUeJ0qc3mJ5iS8o7KaNwSHTMo499tvW9s6xa
	 c0/7CjK5JuNTPmG6XZrqOAts5yQtv8oiSVoGiBSCnZSLckhQp1mvyBlpCJjRUFPeUU
	 l4At/3LQbOZlHhEX9zwlfXNiiSDWiYsNng0HBW4pGOP+ETvS+IPxTYh6DIYQycaK2o
	 983QK+zimO9LB6vJqNb5xyTVo5Z0nGqOlo+KiLPYKWzTvv8riDzDSxUQBMjX98xZot
	 0Euttrns/ScWA==
Date: Tue, 16 Dec 2025 01:17:46 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Eric Biggers <ebiggers@kernel.org>, David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] KEYS: trusted: Use get_random-fallback for TPM
Message-ID: <aUCXGlTiG2w6LYkW@kernel.org>
References: <20251215231438.565522-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215231438.565522-1-jarkko@kernel.org>

On Tue, Dec 16, 2025 at 01:14:38AM +0200, Jarkko Sakkinen wrote:
> 1. tpm2_get_random() is costly when TCG_TPM2_HMAC is enabled and thus its
>    use should be pooled rather than directly used. This both reduces
>    latency and improves its predictability.
> 
> 2. Linux is better off overall if every subsystem uses the same source for
>    generating the random numbers required.
> 
> Thus, unset '.get_random', which causes fallback to kernel_get_random().
> 
> One might argue that TPM RNG should be used so that generated trusted keys
> have the matching entropy with the TPM internally generated objects.
> 
> This argument does some weight into it but as far cryptography goes, FIPS
> certification sets the exact bar, not which exact FIPS certified RNG will
> be used. Thus, the rational choice is obviously to pick the lowest latency
> path.
> 
> Finally, there also some actual defence in depth benefits on using kernel
> RNG. E.g., it helps to mitigate TPM firmware bugs concerning RNG
> implementation, which do happen in the wild occasionally.
> 
> Reviewed-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> v2:
> - Added Eric's reviewed-by tag.
> - Addressed concerns from James by writing more details to the commit
>   message and documenting random number generation to the source
>   code.
> ---
>  security/keys/trusted-keys/trusted_tpm1.c | 6 ------
>  security/keys/trusted-keys/trusted_tpm2.c | 9 +++++++++
>  2 files changed, 9 insertions(+), 6 deletions(-)
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
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index a7ea4a1c3bed..d16be47f1305 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -2,6 +2,15 @@
>  /*
>   * Copyright (C) 2004 IBM Corporation
>   * Copyright (C) 2014 Intel Corporation
> +
> +/**
> + * DOC: Random Number Generation
> + *
> + * tpm_get_random() was previously used here as the RNG in order to have equal
> + * entropy with the objects fully inside the TPM. However, as far as goes,
> + * kernel RNG is equally fine, as long as long as it is FIPS certified. Also,
> + * using kernel RNG has the benefit of mitigating bugs in the TPM firmware
> + * associated with the RNG.
>   */

Sorry, this should have gone to trusted_tpm1.c :-)

>  
>  #include <linux/asn1_encoder.h>
> -- 
> 2.39.5
> 

BR, Jarkko

