Return-Path: <linux-integrity+bounces-7995-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C81CBF9D2
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 20:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3688330532B0
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Dec 2025 19:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14875328615;
	Mon, 15 Dec 2025 19:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQfJY1B4"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A6132860A;
	Mon, 15 Dec 2025 19:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765827807; cv=none; b=CYh7aeVqU7sMAqmmTgO6bl8y+1R4Alhd8qop8bW+kr/kmnCdVbEz1m0SVlUqhJBj8PBZ+o/5d3f/h6ImVzWIAAAM2F4jVJvPZ28Pa1XUJNGWRRpDiUL8pUOKpetiQx8NbaiRHseJw8uXxdgDVIlTbTiDAjNYd+0OaJjkF1vfKQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765827807; c=relaxed/simple;
	bh=1818rPQS9rLRu83VuxQ+h/HCQ5TQatiiaGQ7D4cXuak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5zZBg204A5IJLNiuRaQtcqzJCNMp/T3Sr9LdSAfzn2uTh4wcvf4IdGiFawpmYPMvFPcBxry2HzO3Ft3p5z2KDvRr63vb35FSLwnb+oq9nxNuzueFgl4MnwoT2p1kNN4mt6eeLyLJ8HH7wriZAcc+HEB7qTiL3H9lT1U7a3bxoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQfJY1B4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96181C4CEF5;
	Mon, 15 Dec 2025 19:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765827806;
	bh=1818rPQS9rLRu83VuxQ+h/HCQ5TQatiiaGQ7D4cXuak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dQfJY1B4MZuT0NmsC+jszc1MnyjvyjEcJlSgHR+PLS/ofnZcBYjACuHcsDFApeySO
	 3Y5cDNmEcaif+x6f4YBDKJMECEc/RIHeVmNC+BUzi4qXwATP/uTVWZDJDfiXY+Ms3w
	 T/ka5L28Z7RWrfr7K4iMY7CbVTiT8lrYDNPBMNeZqpZXX3GJTZVKawPjEKD3omVqXQ
	 tenWZC9y/UrlH5WbuL65gThtapYRNHyDVQZe857CO/ohma5cMlNm31gqLPrIqEx0qJ
	 8W84RrZdekBf4AEk3riLBWmXuWr9IQssAP9Cb2298x+5BK9rY5Ic/TBRfp5cAa0irq
	 XNdG6Xu9T8IaQ==
Date: Mon, 15 Dec 2025 21:43:22 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-integrity@vger.kernel.org, David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KEYS: trusted: Use get_random-fallback for TPM
Message-ID: <aUBk2nUpd2V8p9qc@kernel.org>
References: <20251214213236.339586-1-jarkko@kernel.org>
 <64e3e4e0a92848fd3b02a213c754f096d2026463.camel@HansenPartnership.com>
 <aT-uHgyYw3XhFasi@kernel.org>
 <60cf8bd2afbad5e930119d73ccf069e95ee4fd9d.camel@HansenPartnership.com>
 <aT_Lh8l3E2yQJYI7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aT_Lh8l3E2yQJYI7@kernel.org>

On Mon, Dec 15, 2025 at 10:49:15AM +0200, Jarkko Sakkinen wrote:
> On Mon, Dec 15, 2025 at 04:55:58PM +0900, James Bottomley wrote:
> > On Mon, 2025-12-15 at 08:43 +0200, Jarkko Sakkinen wrote:
> > > On Mon, Dec 15, 2025 at 07:18:41AM +0900, James Bottomley wrote:
> > > > On Sun, 2025-12-14 at 23:32 +0200, Jarkko Sakkinen wrote:
> > > > > 1. tpm2_get_random() is costly when TCG_TPM2_HMAC is enabled and
> > > > > thus its use should be pooled rather than directly used. This
> > > > > both reduces latency and improves its predictability.
> > > > > 
> > > > > 2. Linux is better off overall if every subsystem uses the same
> > > > > source for the random bistream as the de-facto choice, unless
> > > > > *force majeure* reasons point to some other direction.
> > > > > 
> > > > > In the case, of TPM there is no reason for trusted keys to invoke
> > > > > TPM directly.
> > > > 
> > > > That assertion isn't correct: you seem to have forgotten we had
> > > > this argument six or seven years ago, but even that was a reprise
> > > > of an even earlier one.  Lore doesn't go back far enough for the
> > > > intermediate one on the tpm list, but the original was cc'd to
> > > > lkml:
> > > > 
> > > > https://lore.kernel.org/all/1378920168.26698.64.camel@localhost/
> > > > 
> > > > The decision then was to use the same random source as the key
> > > > protection.  Unfortunately most of the active participants have
> > > > moved on from IBM and I don't have their current email addresses,
> > > > but the bottom line is there were good reasons to do trusted keys
> > > > this way that your assertions above don't overcome.  I'm not saying
> > > > we shouldn't reconsider the situation, but we need a reasoned
> > > > debate rather than simply doing it by fiat.
> > > 
> > > The way I see this is that given that kernel is not running inside
> > > TPM, FIPS certification of the RNG does not have any measurable
> > > value.
> > > 
> > > Random data generation should happen as part of object creation
> > > process i.e. should be fully self-contained process within the TPM in
> > > order for FIPS to matter.
> > 
> > In FIPS terms, there's no distinction between keeping the whole
> > generation process internal to the TPM and using the FIPS certified rng
> > of the TPM to source the contents of a kernel protected key.  Both
> > provide equally valid, and FIPS certified data.
> 
> I understand being "FIPS certified" embedding the premise that kernel
> is also FIPS certified, which covers also crypto etc. This is the case
> with enterprise kernels.
> 
> I have understanding FIPS certification dies at the point when random
> data is acquired by a kernel, which is not FIPS certified. It's not 
> really a safe closure.
> 
> Using same code path for RNG universally should actually help with any
> certification processes.

I think there is misunderstanding with FIPS.

Having FIPS certificated RNG in TPM matters but it only matters only in 
the sense that callers can be FIPS certified as they use that RNG as a 
source.

Using FIPS certified RNG does not magically make callers be FIPS 
ceritified actors. The data is contaminated in that sense at the point
when kernel acquires it.

BR, Jarkko

