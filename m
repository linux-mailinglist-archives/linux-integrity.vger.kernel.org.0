Return-Path: <linux-integrity+bounces-7999-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CB1CBFD14
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 21:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 331BC304EDA4
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 20:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DCC332EB6;
	Mon, 15 Dec 2025 20:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/2aHAhs"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168C3331A6B;
	Mon, 15 Dec 2025 20:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765830958; cv=none; b=cMkTaZhkbp/XplV96Y6SZaWDcZOuc55hg/LHlTvcM7rBpJJRh0J7WuvnZZGfjY0CHFuiIjDzETs/o5PSYvzQf3iqtnyqPV4NCq1R2vmazAsT0X1Kpv9AlN8Oi3g1Ck3KOtamiUgiTUk65GQACZw0YSOCueAH4POJRzinQGQroFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765830958; c=relaxed/simple;
	bh=dpOu2TYpHv17u6kWo4ouCwBz8hVFUIS+JHvLsT3UZQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bf4c6yt1ojV9+yUxLZUuK7rwG8MfnDUeqb/pmZh/EvYgiopu68038TxhBoeF07TMi/uIvs5bfHoAOXfTAHK66IyE3srLv7sPKCjL8PhkMPZF9Ulb1wtw10Pcfa9P5tm47VzymLxgp+c+TRbGMAoh+wc5PqLVhKPcc3P5ceCgu6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/2aHAhs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB66C4CEF5;
	Mon, 15 Dec 2025 20:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765830957;
	bh=dpOu2TYpHv17u6kWo4ouCwBz8hVFUIS+JHvLsT3UZQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c/2aHAhsGKHm5DxegvAlRz0n73krzW5d/pF1AIcFRpMdcSDRaVDpFXvxtpOuAMsqW
	 IxmhoTFwN7Xl/jq6F9q5x8KoWhOlybNWGa6fdzr2JEyywY3UMxKqEIUcTt6zS4/2Zg
	 G+Oq9ABa94yOf61qraLV5i8IrsP9+PNO7Zf704hbZJtzip8BkGEG/215/3GeNgiAcT
	 xISrucreksVRDGN8TxuXe3/qzuefwFJXcuez9bsmEMQVDqTkf5nZx+CNkUWVYUf0m4
	 18VruZqEO9DVEmIlfQon4f7v8IjXfvt/SBGuK192XhHKpcs6p9cMCnJ/8q+JToIMbu
	 tP+QDglLcL8vQ==
Date: Mon, 15 Dec 2025 22:35:54 +0200
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
Message-ID: <aUBxKqL5hFibwI3r@kernel.org>
References: <20251214213236.339586-1-jarkko@kernel.org>
 <20251215200939.GA10539@google.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215200939.GA10539@google.com>

On Mon, Dec 15, 2025 at 08:09:39PM +0000, Eric Biggers wrote:
> On Sun, Dec 14, 2025 at 11:32:36PM +0200, Jarkko Sakkinen wrote:
> > 1. tpm2_get_random() is costly when TCG_TPM2_HMAC is enabled and thus its
> >    use should be pooled rather than directly used. This both reduces
> >    latency and improves its predictability.
> > 
> > 2. Linux is better off overall if every subsystem uses the same source for
> >    the random bistream as the de-facto choice, unless *force majeure*
> >    reasons point to some other direction.
> > 
> > In the case, of TPM there is no reason for trusted keys to invoke TPM
> > directly.
> > 
> > Thus, unset '.get_random', which causes fallback to kernel_get_random().
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> >  security/keys/trusted-keys/trusted_tpm1.c | 6 ------
> >  1 file changed, 6 deletions(-)
> > 
> > diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
> > index 636acb66a4f6..33b7739741c3 100644
> > --- a/security/keys/trusted-keys/trusted_tpm1.c
> > +++ b/security/keys/trusted-keys/trusted_tpm1.c
> > @@ -936,11 +936,6 @@ static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
> >  	return ret;
> >  }
> >  
> > -static int trusted_tpm_get_random(unsigned char *key, size_t key_len)
> > -{
> > -	return tpm_get_random(chip, key, key_len);
> > -}
> > -
> >  static int __init init_digests(void)
> >  {
> >  	int i;
> > @@ -992,6 +987,5 @@ struct trusted_key_ops trusted_key_tpm_ops = {
> >  	.init = trusted_tpm_init,
> >  	.seal = trusted_tpm_seal,
> >  	.unseal = trusted_tpm_unseal,
> > -	.get_random = trusted_tpm_get_random,
> >  	.exit = trusted_tpm_exit,
> >  };
> 
> Reviewed-by: Eric Biggers <ebiggers@kernel.org>
> 
> Agreed that kernel code should prefer the standard Linux RNG whenever
> possible.  Note that the standard Linux RNG already incorporates entropy
> from hardware RNGs, when available.

I get also the argument of using TPM RNG here just for the sake of
matching the creation with fully internally generated TPM objects.

I'm a bit little in-between what to do with this patch.

I suggested a comment to James. Other alternative would be do this
change and update this patch with a comment:

/*
 * tpm_get_random() was used previously here as the RNG in order to match
 * rng with the objects generated internally inside the TPM. However, since
 * e.g., FIPS certification requires kernel crypto and rng to be FIPS
 * certified, formally kernel_get_random() is equally legit source for
 * the random numbers.
 */

It's longish but I think this fully covers the whole issue.

And if there is ever need to return to this, it's a good remainder of
the design choices.

> 
> - Eric

BR, Jarkko

