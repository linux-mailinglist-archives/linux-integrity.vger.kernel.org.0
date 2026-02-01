Return-Path: <linux-integrity+bounces-8399-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEuRIPTSf2lLyAIAu9opvQ
	(envelope-from <linux-integrity+bounces-8399-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 01 Feb 2026 23:25:56 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22DAEC7618
	for <lists+linux-integrity@lfdr.de>; Sun, 01 Feb 2026 23:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D68F93004F6E
	for <lists+linux-integrity@lfdr.de>; Sun,  1 Feb 2026 22:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973292DF6F4;
	Sun,  1 Feb 2026 22:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcCKjCnJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FA11DF751;
	Sun,  1 Feb 2026 22:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769984750; cv=none; b=Kbcsj8bf4ZI0UuTpgZN1hPHTzJ585ssbTYJ3BZZDzbXIYkNQQ5MhKnb4bfmV19Ltz3MOXN4K2agjGY9vgqAq8LkAbkSs1i0Q2t3EgnJvkxsWXVC8/UDpKnGnr/I4blfrEwl+D92r0dwoNzyOlLLXPQZsJQ83DPTAl1W/B7iblaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769984750; c=relaxed/simple;
	bh=9EdrK7F7aeQYhR8iex0yLB+0WdXRInybjibBOo4Z6fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGP8e/Ud5mw6z6ZeEhC0S2mmbFmn22yxRzFqFiDlKTf3wQPWcbu71FQ2tMj3eaSggn0KeE2ymS9rNfjvUxVhvdyfJBCEFHNTP+MkVlNvphVp0Qv0zjqcjX8Puhhn+vBu/ecFse7QU3G7m5AkG/EA27QGE4ifdSuBhuIn7mFQ7Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcCKjCnJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E74C4CEF7;
	Sun,  1 Feb 2026 22:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769984750;
	bh=9EdrK7F7aeQYhR8iex0yLB+0WdXRInybjibBOo4Z6fs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jcCKjCnJrksV1sbrwJBSUT40dF3lvQUyERj4mG6Ci32Rh0SPNLSy8mjUYT1YSPlpA
	 j0MA4aPTsFlz17NAM//D9j8wrOy0lLVwQBLNJqMKOkHGZpTA5nCrnmLaYr6l1qVD71
	 5pU/G8U0cP5SkydDzjftX8xsOR1+Gz5l/XevTDgY+BrIblWp0urp0aO9NZadSK/1d/
	 V1IP8TfPMWP5lc8k8PMPekL591Vet8t9Ph3IJ9OhJnSyqUWl+H/npO2fUUcDn//HkB
	 Q7YYqJHc8kxFvgnnd1xvQcPahZ3egAr6k4/ktLL+Ay0lrsUiSq516KMlGTIjVK99rr
	 Kx9ukt8gwfgcg==
Date: Mon, 2 Feb 2026 00:25:46 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: linux-integrity@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 01/11] KEYS: trusted: Use get_random-fallback for TPM
Message-ID: <aX_S6rSHHCXquebP@kernel.org>
References: <20260125192526.782202-1-jarkko@kernel.org>
 <20260125192526.782202-2-jarkko@kernel.org>
 <facea3621fc240ebb05dedb0127d8a514970d40d.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <facea3621fc240ebb05dedb0127d8a514970d40d.camel@huaweicloud.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8399-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 22DAEC7618
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 05:18:55PM +0100, Roberto Sassu wrote:
> On Sun, 2026-01-25 at 21:25 +0200, Jarkko Sakkinen wrote:
> > 1. tpm2_get_random() is costly when TCG_TPM2_HMAC is enabled and thus its
> >    use should be pooled rather than directly used. This both reduces
> >    latency and improves its predictability.
> > 
> > 2. Linux is better off overall if every subsystem uses the same source for
> >    generating the random numbers required.
> > 
> > Thus, unset '.get_random', which causes fallback to kernel_get_random().
> > 
> > One might argue that TPM RNG should be used for the generated trusted keys,
> > so that they have matching entropy with the TPM internally generated
> > objects.
> > 
> > This argument does have some weight into it but as far cryptography goes,
> > FIPS certification sets the exact bar, not which exact FIPS certified RNG
> > will be used. Thus, the rational choice is obviously to pick the lowest
> > latency path, which is kernel RNG.
> > 
> > Finally, there is an actual defence in depth benefit when using kernel RNG
> > as it helps to mitigate TPM firmware bugs concerning RNG implementation,
> > given the obfuscation by the other entropy sources.
> > 
> > Reviewed-by: Eric Biggers <ebiggers@kernel.org>
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> > v7:
> > - A new patch. Simplifies follow up patches.
> > ---
> >  security/keys/trusted-keys/trusted_tpm1.c | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> > 
> > diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
> > index 636acb66a4f6..7ce7e31bcdfb 100644
> > --- a/security/keys/trusted-keys/trusted_tpm1.c
> > +++ b/security/keys/trusted-keys/trusted_tpm1.c
> > @@ -6,6 +6,16 @@
> >   * See Documentation/security/keys/trusted-encrypted.rst
> >   */
> >  
> > +/**
> > + * DOC: Random Number Generation
> > + *
> > + * tpm_get_random() was previously used here as the RNG in order to have equal
> > + * entropy with the objects fully inside the TPM. However, as far as goes,
> > + * kernel RNG is equally fine, as long as long as it is FIPS certified. Also,
> > + * using kernel RNG has the benefit of mitigating bugs in the TPM firmware
> > + * associated with the RNG.
> > + */
> 
> If we switch to the kernel RNG that is better, and the TPM one is
> flawed, I guess we are going to have big problems anyway, since the TPM
> random number generator is used by the TPM itself internally.
> 
> I think it makes sense to leave as it is.

There's neither really formal case for not doing this unless the random
number provided by TPM would be opaque to kernel because as soon as CPU
touches it, the "risk" matches kernel RNG generated random number.

These change do have a measurable benefit as they  objectively decrease
TPM traffic.

And as we probably know, security certifications do not really apply
simply by using TPM RNG.

BR, Jarkko

