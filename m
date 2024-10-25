Return-Path: <linux-integrity+bounces-3913-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4519B0620
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Oct 2024 16:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67B82B24858
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Oct 2024 14:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A581155C8C;
	Fri, 25 Oct 2024 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4uAq5RO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E41670809;
	Fri, 25 Oct 2024 14:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729867662; cv=none; b=mi20ZbDP0Kn49DKu+9NjGDAhZFJ4iX2DlLALkmI5+ibpkmoKkmrm4wvmknENzsGYxk9bVN3HiijqSdoKlYFx7rJEFTbEcfdlWaPlt3xn4BsgybRT2i7Pc/LYp6ztnQwMhHWT3BShMIfnLQDeiX+gWgGXXi7qDVdQPAa7tvK4zts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729867662; c=relaxed/simple;
	bh=oShrWHWcljZokYmT9YyRMqv4UbAa7cq5MJNVTYh8YYU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=BFCNpbWTbUHR3manROa2UWNLdsmkNTYW7WP/2Z+Fon43GhkOboJ+SBRjCEV/EwB+8xIo8ZYev60liZeJZhhYZmUkObzI7OtXMiiLyNZdjfLzn0J6y7o9z/6OoIAOJB9PtiG879KeyLgLhP0oOodpd5+qQW45zV3CDGT5PU1ScSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4uAq5RO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091C0C4CEE3;
	Fri, 25 Oct 2024 14:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729867660;
	bh=oShrWHWcljZokYmT9YyRMqv4UbAa7cq5MJNVTYh8YYU=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=S4uAq5ROqjZfgSGA+6gxv2i2D9X83o7nW+2mYJXFMjktVHNtByrIGEPH1YkGX2lVV
	 rKJP7XdgSCL2D/JFm38qb1qK99hVQyD5ewTP6UoP/YznBBHK+62z9faP2NrHOyfScZ
	 5BoDwzD6OmpNEvYKZv4jF7g2nF5jeoha+MQ7lYo93NMH9i5EnTpLqhiR6JkO7YKIkp
	 IvU/NqHLq7Q8NBX5lfdEDZNj5GlFFaNGFbcJSsjRx6vJ6EIX3C6PiE1gx0HSw8LOwM
	 YxtrOKrcdEI/rTKBygGI6HERDM+AdOaWwQfTNQmBphMD8n/K1JzqNwM4f42qA7alQ6
	 +8NLRQbKyy/IQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Oct 2024 17:47:36 +0300
Message-Id: <D54YWMOV7KOO.2X0N035UHEFBD@kernel.org>
Subject: Re: [REGRESSION][BISECTED] tpm: Popping noise in USB headphones
 since 1b6d7f9eb150
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Christian Heusel" <christian@heusel.eu>, "Peter Huewe"
 <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>, "James Bottomley"
 <James.Bottomley@hansenpartnership.com>
Cc: <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <regressions@lists.linux.dev>
X-Mailer: aerc 0.18.2
References: <7d052744-4bfa-40bc-ba06-1b4c47a5eb87@heusel.eu>
In-Reply-To: <7d052744-4bfa-40bc-ba06-1b4c47a5eb87@heusel.eu>

Yeah, this is on the list.

See: https://bugzilla.kernel.org/show_bug.cgi?id=3D219383#c5

I had a fix for the AMD boot-time issue already over a month ago
but unfortunately took time to get enough feedback.

BR, Jarkko

On Fri Oct 25, 2024 at 3:11 AM EEST, Christian Heusel wrote:
> Hello everyone,
>
> Adam reports that since switching to the 6.10 kernel they have a popping
> sound from time to time (roughly every 10 minues) on their headphones
> which are connected via a [UGREEN's 5-in-1 USB-C Hub][0].
>
> We have then done a [lengthy bisection][1] on the mainline kernel which
> came to the conclusion that the following commit is the culprit of the
> issue:
>
>     1b6d7f9eb150 ("tpm: add session encryption protection to tpm2_get_ran=
dom()")
>
> Since I thought that these results are likely not correct Adam has
> verified our results again by re-testing the bisection steps and again
> came to the same conclusion. Additionally I have shot the same question
> [at Jarkko on Mastodon] to find out if it's possible that changes in the
> TPM subsystem can have such an effect.. Without knowing the exact commit
> we had bisected to he pointed to the same functionality:
>
> > Jarkko Sakkinen (@jarkko@social.kernel.org):
> >
> > @gromit i might actually might have hunch for this but have been
> > unmotivated to move forward before these patches are merged. One thing
> > at a time IMHO, especially with performance fixes.
> > NOTE: this is a hyphothesis.
> >
> > tpm2_get_random() needs to be reconsidered with encryption as hwrng
> > calls it often enough and there's now more overhead.
> >
> > It pulls entropy in small chunks subtracting the length in the look
> > like you would use read() syscall from user space. This is not right.
> > This leads to small and variable size exchanges and yeah generally
> > that equates to an inefficient implemenation with bad latency
> > properties.
>
> If there are any patches to test or if further input is needed from the
> initial reporter on our Bugtracker we can do that!
>
> Thank you all for your hard work on the kernel!
>
> Cheers,
> Chris
>
>
> [0]: https://uk.ugreen.com/collections/hubs-1/products/ugreen-5-in-1-4k-h=
dmi-usb-c-hub
> [1]: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/is=
sues/79#note_210599
> [2]: https://chaos.social/@gromit/113345582873908273
>
> ---
> #regzbot introduced: 1b6d7f9eb150=20
> #regzbot link: https://gitlab.archlinux.org/archlinux/packaging/packages/=
linux/-/issues/79
> #regzbot link: https://chaos.social/@gromit/113345582873908273
> #regzbot title: tpm: popping sound in headphones connected via USB-C


