Return-Path: <linux-integrity+bounces-8000-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 909BCCBFDEB
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 22:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D2E23013EDA
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 21:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679BC30B501;
	Mon, 15 Dec 2025 21:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILfwOI9Y"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBDC224AED;
	Mon, 15 Dec 2025 21:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765832999; cv=none; b=gmc+FfIlbkwyqX/P0Uux1b2S+PXAZmR42P3fyl0T5iXbatfq+IjpmVUUh5WInchrIk/QzGTQg2wfzG0alvE11ebxvCK+e3g3wzWVAq9786kr4K1wttIdKuDGl4NORPekNkN5Jtxvqqugnf3sWcrOkdXBDXYbFHx7as6Rs7SRmi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765832999; c=relaxed/simple;
	bh=MsvNKVtpAR5OJSz96/tz/gDOnw1HKiXZVOzT23K0Iaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wjzaq3A2b9FPEMxiiA/EkAufy/klhrl6+kFoqTNHZPs92YOZZp+A7IAbCvyQ/8yvIVNig7wyCewfTDqgE8/q3qJnOi8+lnExgNf0nkkWNA2GAmmIaG12lb+P3QyKbNbrnm6VkcAhgdARH+/+MFEnez5YKRTW27Lmwz5OZ9PZcrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILfwOI9Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E679C4CEF5;
	Mon, 15 Dec 2025 21:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765832998;
	bh=MsvNKVtpAR5OJSz96/tz/gDOnw1HKiXZVOzT23K0Iaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ILfwOI9YemhDjV3evosDEKUTcnxGWMzXjweL81Ers8lmMO01CdK4PzsMLEbN36c6s
	 oZr5E85/LeUj2cK90Qc3NeaGynygaQAJMRIpdIAs7q1SPFGrg1xvA5Kno4qInvfLYf
	 8R2KPYym3KRYvre12Uuh284jhKugkJjnA75Y4weDgt/r75dZHylHbjhV6PZ/VSA+Ie
	 11fu86+XSUxK/oArb5jF0hrxXwRBXi3Pnc5j0Dzq6DjilyTWAMZdnefKCWCfZFt83T
	 cA9b0y0hQ/Kn8fTOOp4VQOw6FShUR4RqOFbLA4HuZzYDr5s8qW3Dx/pHsE34RbuNDU
	 MRl/W09dVasQw==
Date: Mon, 15 Dec 2025 23:09:54 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
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
Message-ID: <aUB5IsJeWhFvX-cA@kernel.org>
References: <20251214213236.339586-1-jarkko@kernel.org>
 <20251215200939.GA10539@google.com>
 <aUBxKqL5hFibwI3r@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUBxKqL5hFibwI3r@kernel.org>

On Mon, Dec 15, 2025 at 10:35:57PM +0200, Jarkko Sakkinen wrote:
> On Mon, Dec 15, 2025 at 08:09:39PM +0000, Eric Biggers wrote:
> > On Sun, Dec 14, 2025 at 11:32:36PM +0200, Jarkko Sakkinen wrote:
> > > 1. tpm2_get_random() is costly when TCG_TPM2_HMAC is enabled and thus its
> > >    use should be pooled rather than directly used. This both reduces
> > >    latency and improves its predictability.
> > > 
> > > 2. Linux is better off overall if every subsystem uses the same source for
> > >    the random bistream as the de-facto choice, unless *force majeure*
> > >    reasons point to some other direction.
> > > 
> > > In the case, of TPM there is no reason for trusted keys to invoke TPM
> > > directly.
> > > 
> > > Thus, unset '.get_random', which causes fallback to kernel_get_random().
> > > 
> > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > ---
> > >  security/keys/trusted-keys/trusted_tpm1.c | 6 ------
> > >  1 file changed, 6 deletions(-)
> > > 
> > > diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
> > > index 636acb66a4f6..33b7739741c3 100644
> > > --- a/security/keys/trusted-keys/trusted_tpm1.c
> > > +++ b/security/keys/trusted-keys/trusted_tpm1.c
> > > @@ -936,11 +936,6 @@ static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
> > >  	return ret;
> > >  }
> > >  
> > > -static int trusted_tpm_get_random(unsigned char *key, size_t key_len)
> > > -{
> > > -	return tpm_get_random(chip, key, key_len);
> > > -}
> > > -
> > >  static int __init init_digests(void)
> > >  {
> > >  	int i;
> > > @@ -992,6 +987,5 @@ struct trusted_key_ops trusted_key_tpm_ops = {
> > >  	.init = trusted_tpm_init,
> > >  	.seal = trusted_tpm_seal,
> > >  	.unseal = trusted_tpm_unseal,
> > > -	.get_random = trusted_tpm_get_random,
> > >  	.exit = trusted_tpm_exit,
> > >  };
> > 
> > Reviewed-by: Eric Biggers <ebiggers@kernel.org>
> > 
> > Agreed that kernel code should prefer the standard Linux RNG whenever
> > possible.  Note that the standard Linux RNG already incorporates entropy
> > from hardware RNGs, when available.
> 
> I get also the argument of using TPM RNG here just for the sake of
> matching the creation with fully internally generated TPM objects.
> 
> I'm a bit little in-between what to do with this patch.
> 
> I suggested a comment to James. Other alternative would be do this
> change and update this patch with a comment:
> 
> /*
>  * tpm_get_random() was used previously here as the RNG in order to match
>  * rng with the objects generated internally inside the TPM. However, since
>  * e.g., FIPS certification requires kernel crypto and rng to be FIPS
>  * certified, formally kernel_get_random() is equally legit source for
>  * the random numbers.
>  */
> 
> It's longish but I think this fully covers the whole issue.
> 
> And if there is ever need to return to this, it's a good remainder of
> the design choices.

I'll supplement the patch with that explanatory comment. I think the
previous discussions pointed out by James were useful reflection point 
and that comment summarizes that discussion.

I'll add your reviewd-by to the next version, as no additional code 
changes will be implemented.

I think that this discussion also implies that the callback itself is
somewhat questionable, perhaps even harmful. Same arguments apply also
to e.g., TEE trusted keys. IMHO, would be overall best for Linux to a
have a one single call path for generating random numbers.

Using combined entropy also decreases corrateral damage caused by e.g.,
a buggy TPM firmware, which does happen sometimes in the wild.

BR, Jarkko

