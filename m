Return-Path: <linux-integrity+bounces-7418-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C23ABCE138
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Oct 2025 19:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B30A5356526
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Oct 2025 17:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98DF21CC47;
	Fri, 10 Oct 2025 17:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sq3SIhWP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AD018EAB;
	Fri, 10 Oct 2025 17:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760117202; cv=none; b=kikyAaTM+pyg8b5snnLRrclCbosLfw6CorcMk/eXrhV30hA39MVzUxXgHQH6OuL7PJb+N381UOkbnd9/cFddKLh2uOrETAxlngS5PNkQJls8eYVueqgcmjG05aAfhTQayRRwK837ASVL5dF2gpsgmuhAiGikl3FhQE3ndgGU1XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760117202; c=relaxed/simple;
	bh=yfT6N5HMuFsulEv0jGG9X/xOELVYT6TNPjuWTZgZtEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBLtbIyOr1PTB8g1tALLNdXoS9RfIIx1GCkg2njC/QlmrGZKJQwOJapnqN5tJkeQrPs9rTCAMEB5aBWCem8hI9EEONwiEM4vasgr+M9b9H4USiApHSRZe/tri14yvD70GTEET/vWDq5kyDW1XwmEd0J7yzqF2Leh7VXA0JrJFTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sq3SIhWP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD345C4CEF1;
	Fri, 10 Oct 2025 17:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760117202;
	bh=yfT6N5HMuFsulEv0jGG9X/xOELVYT6TNPjuWTZgZtEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sq3SIhWPFFFawAC65sWBDnx3tGFLkK00472iXjCe81Br9kVaLuo1nbrVbD3zeDhbT
	 NlNvHs+1Bbjns3sbWM58EvEilWCrCpZbbAdOuviig/HJek4RqhABaXpVRTIiU3M5ta
	 1taWXP+m+56FuxBFrewFx0g4yUjC8GTAjRUXmQVrtdij0DXJ+yw+dDhBRD2FRiJWZ7
	 Oz8s1XYRV6PFYZ0N8vtJd63NKk/fZi0GrrQY2ttMrcRyU7pYfALGWbQPyihas11xOI
	 nqgIDkXfeo1x3ac0TGPqL/R+2XkOXcDfkgn1iyE7pzBk+Jcso5dUwmFsc8KihEd400
	 9U5vYDJLg+h1A==
Date: Fri, 10 Oct 2025 20:26:38 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-v6.18-2
Message-ID: <aOlBzobMDAQ39WgU@kernel.org>
References: <aOibAOKu_lEsSlC8@kernel.org>
 <CAHk-=whUUZpENHKMrrVQwqfBgP9Lm=SxW+a3WmoxZR3JObdrUA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whUUZpENHKMrrVQwqfBgP9Lm=SxW+a3WmoxZR3JObdrUA@mail.gmail.com>

On Fri, Oct 10, 2025 at 08:51:09AM -0700, Linus Torvalds wrote:
> On Thu, 9 Oct 2025 at 22:35, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-v6.18-2
> 
> So I've pulled this, but I'm still unhappy about the explanation.
> 
> You tried to explain a one-line single-character change in that pull
> request, and even in that explanation you spent most effort on
> dismissing other peoples concerns.

For what it is, most of it comes from:

1. "tpm: use a map for tpm2_calc_ordinal_duration()"
    Flattened out timeout calculations to a table and increase timeout
    for TPM2_SelfTest, which addresses longer timeout on Raspeberry Pi.
2. "tpm: Prevent local DOS via tpm/tpm0/ppi/*operations"
   Caches TPM physical presence interface ACPI functions on first run
   instead of requesting for every read.

Also:

1. I went through Chris' email because you asked to refer to it.
2. I also spent time re-testing O_EXCL change throughly once more. From
   my subjective perspective I was exactly trying to address other people's
   concerns.

That said, I fell off the track and yeah not well delivered agreed.
 
> That one-liner would have been - and is - sufficiently explained by
> "it performs badly and breaks some configurations". There's absolutely
> no reason to then go on to describe how *you* don't care about those
> configurations.

Maybe I had a bad choice of words but there's no configuration that
breaks with anything sold as discrete TPM chips, embedded SoC, fTPM's
or anything really. I got the impression of a bug in the wild, other
than the perf regression.

> 
> But lookie here:
> 
>  8 files changed, 137 insertions(+), 199 deletions(-)
> 
> that's the actual meat of the pull request, and it gets not a peep of
> commentary.
> 
> I'd also like to point out that Microsoft spent *years* trying to do
> the "we require certain typical TPM setups", and people complained
> about their idiocy.
> 
> For all I know, they still push that crap.
> 
> I would certainly are *NOT* that stupid, and we are not going down that path.
> 
> So when it comes to TPM, the rule is not "typical cases work".
> 
> The rule is "if it causes problems, we acknowledge them and we avoid them".

I deeply care anything that can be bought with money or even anything
that drifts away from a spec manageable amount.


 
> Thus the whole "disable TCG_TPM2_HMAC" really doesn't merit this kind
> of long explanation.
> 
> In contrast, the *other* changes are probably much more interesting than that.

Very true :-)

 
>              Linus

BR, Jarkko

