Return-Path: <linux-integrity+bounces-7382-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B9661BBE4EA
	for <lists+linux-integrity@lfdr.de>; Mon, 06 Oct 2025 16:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A3154EB399
	for <lists+linux-integrity@lfdr.de>; Mon,  6 Oct 2025 14:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C293F29A31C;
	Mon,  6 Oct 2025 14:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cT2DuKTv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D3F1E570D;
	Mon,  6 Oct 2025 14:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759760298; cv=none; b=cWiCH4XjnycdB47ae8Pezd1z7h+m7y8ITybP4HLvdcZmvD74brSXv9OlzNVWVOA2IP333dj1hqmw+vwbISb2QI+q3+9wwcadOIxuFO4+8Qk+U34l8Qlpt6Y8Nl/PyK44q9gooqFhgTvF4uhqBfvzFapJT192OtUnyy+6JqJGAkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759760298; c=relaxed/simple;
	bh=nEaSVOanl5k6WKOgap9cfNjneoyL3wULm9rxvYRal6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WsIgUnrNW4rGXtGp1mhS4sL5f1SPX5b+XsFJ2Z7IJsAA4Tb0cDzAqEGRpXHk0LZLsgRxMiMH0kwr97YwT3tPWqf0k6ddp54/3BI3R9CXM9yPfY9jlP91e17+R1upahRCT/P/oblXXss9rp5GTYzzPzppeyv2OK8pdgCR1is37Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cT2DuKTv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F0AC4CEF5;
	Mon,  6 Oct 2025 14:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759760297;
	bh=nEaSVOanl5k6WKOgap9cfNjneoyL3wULm9rxvYRal6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cT2DuKTvOPR0iK4HEjUaijCOpM3Zrr5/XNlKH5vpL2zThMJITnjz5KSbvO9saK/zh
	 3t3UBSvc1VmDexL//Y0tNLIoB1wrMA2ewXr3qxHENWq9TscNLOOFajjrifjS6Mri19
	 CZ5hEsEPm9BU5cIOJ7Cmfmw1s4EINyGFm4gh2dQ1TouIEIx7fdUxIywzsjwzfL1rJY
	 fGnoibCVylhc+x1kyutTDtOGY832lYqZPH5jbL0cxweBlsjpxWS1szsU0RcYhf5f47
	 r3DnVQiKVdd/UiCozyg4gtxaZUsg17URUzC2ksy0EGuQCBgDBXI2Bu9RlJbs21CTD2
	 YRCopNCwtQGbQ==
Date: Mon, 6 Oct 2025 17:18:13 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-v6.18
Message-ID: <aOPPpVK8rJUuDgWD@kernel.org>
References: <aOKTFv1vh1cvvcLk@kernel.org>
 <CAHk-=wiCWiDcLEE3YqQo78piVHpwY2iXFW--6FbmFAURtor2+w@mail.gmail.com>
 <aOOu1f1QWQNtkl6c@kernel.org>
 <aOPOZwp_inGui9Bx@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOPOZwp_inGui9Bx@kernel.org>

On Mon, Oct 06, 2025 at 05:13:02PM +0300, Jarkko Sakkinen wrote:
> On Mon, Oct 06, 2025 at 02:58:17PM +0300, Jarkko Sakkinen wrote:
> > On Sun, Oct 05, 2025 at 11:09:08AM -0700, Linus Torvalds wrote:
> > > On Sun, 5 Oct 2025 at 08:47, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > >
> > > >      This pull request disables
> > > > TCG_TPM2_HMAC from the default configuration as it does not perform well
> > > > enough [1].
> > > >
> > > > [1] https://lore.kernel.org/linux-integrity/20250825203223.629515-1-jarkko@kernel.org/
> > > 
> > > This link is entirely useless, and doesn't explain what the problem
> > > was and *why* TPM2_TCG_HMAC shouldn't be on by default.
> > > 
> > > I think a much better link is
> > > 
> > >    https://lore.kernel.org/linux-integrity/20250814162252.3504279-1-cfenn@google.com/
> > > 
> > > which talks about the problems that TPM2_TCG_HMAC causes.
> > > 
> > > Which weren't just about "not performing well enough", but actually
> > > about how it breaks TPM entirely for some cases.
> > 
> > Fair enough. I'll also enumerate the issues, and also roadmap
> > to heal the feature.
> 
> So some of the arguments in Chris' email are debatable, such as
> this list:
> 
> - TPM_RH_NULL
> - TPM2_CreatePrimary
> - TPM2_ContextSave
> - ECDH-P256
> - AES-128-CFB
> 
> 
> We've never encountered a TPM chip without those TPM commands, and e.g.
> /dev/tpmrm0 heavily relies on TPM2_ContextSave, and has been in the
> mainline since 2017. And further, this has been the case on ARM too.
> 
> So using all of the arguments as rationale for the change that according
> to Chris' email are broken because I cannnot objectively on all of the
> arguments.
> 
> E.g. I have to assume to this day that all known TPM chips have those
> commands because no smoking gun exists. And if DID exist, then I'd
> assume someone would fixed /dev/tpmrm0 ages ago.
> 
> That said, I do agree on disabling the feature for the time being:
> we have consensus on actions but not really on stimulus tbh.
> And if there is stimulus I would postpone this patch to create
> fix also for /dev/tpmrm0.
> 
> Argument where I meet with Chris suggestion are:
> 
> 1. Performance. The key generation during boot is extremely bad
>    idea and depending on the deployment the encryption cost is
>    too much (e.g. with my laptop having fTPM it does not really
>    matter).
> 2. Null seed was extremely bad idea. The way I'm planning to actually
>    fix this is to parametrize the primary key to a persistent key handle
>    stored into nvram of the chip instead of genration. This will address
>    also ambiguity and can be linked directly to vendor ceritifcate
>    for e.g. to perfom remote attesttion.
> 
> Things don't go broken by saying that they are broken and nothing
> elsewhere in the mainline has supporting evidence that those commands
> would be optional. I cannot agree on argument which I have zero
> means to measure in any possible way.
> 
> This is exactly also the root reason why I wrote my own commit instead
> with the same change: I could have never signed off the commit that
> I don't believe is true in its storyline.
> 
> So if I write cover for the pull request where I use the subset of
> arguments with shared consensus would that be enough to get this
> through? As for primary key handle fix I rather do that with
> time and proper care.

I had to use few hours to remind why I did my commit instead of acking
the original and this is the root. We've never had e.g. a bug in the
wild that would /dev/tpmrm0 to be broken because ContextSave is not
available, and it is *widely* used device across all major platforms.

BR, Jarkko

