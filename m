Return-Path: <linux-integrity+bounces-7161-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E3AB85C45
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 17:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2F4C5612FF
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Sep 2025 15:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B41B23B616;
	Thu, 18 Sep 2025 15:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FD2QmrKN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E7F22D7B5;
	Thu, 18 Sep 2025 15:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758210492; cv=none; b=el1p3ia2iPZafxeS/i3lWu6L+5+lW9xvTp71+WAZuah/vSkP6Sfc11MIsJv+4/13UFKq/Qkt2LLOCvqYnmeQGF5FXeEZC5lEs/8x7spBG1MjhsU9C9ZOALEZvUvhul9pcA6HBIFLq3UvzKCUlmpvTJ30jiVUQaSRrt4aefiz9R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758210492; c=relaxed/simple;
	bh=JT3ECR8y3wiOUot8uXmFiGz+zMI4wQ4XDLAlJPjll14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBm3jxjtPXFZHQnAbUWf2Ka4NxIRwMhdWH9SADT9aC7TriEh+yrE6NphbxhkdF192+bUUyU3oOjzioffinlmG4R4kpVWTGuT7EE1tuDiDmIBA79RKOv5EusZ0CmxU6QxixyFI4OTaCCSr0DN9/OW10PkGxL+4aUT1cbfiP8UxEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FD2QmrKN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE0E7C4CEE7;
	Thu, 18 Sep 2025 15:48:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758210491;
	bh=JT3ECR8y3wiOUot8uXmFiGz+zMI4wQ4XDLAlJPjll14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FD2QmrKN5yIySe/pKeqRq5r0fM3eWM4bAjiS7qF7FI364PckEHdaXGhrGKj1NAP7k
	 4c+gaP+IrI6ZOftmqLrVDpfuOYiMWqS7FJtp+XvH2Fr4/DueVeqDUfUGvhnoLdEhdL
	 yuEPi9ILPfzrDbz1k70K2BfUTS4aQ6JAKCa+d6YpaJV5RLIt4QZ6XGDth32k+UsK93
	 4DdBg0OM40oosv024r/vGxLaaoaP1kPYn6gkOdko4+yS1uGHcNce7z6fIyfmhVXCxM
	 wTzDqtzxYqQjrXaQv4SZU2ol7qaY4n3t8ztToOGs9PRocbDu8vnHelKSfLJRToe1sF
	 3sVsMKedRnZKA==
Date: Thu, 18 Sep 2025 18:48:06 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-integrity@vger.kernel.org, tpm2@lists.linux.dev
Subject: Re: tpm2key.asn1 parent identification
Message-ID: <aMwptnyYedvdqdHc@kernel.org>
References: <aMboFXNNX7WZaOaS@kernel.org>
 <6e1f2713288b48a1cc0311d01e281a98d8e7f45d.camel@HansenPartnership.com>
 <aMgnm1OkDj9XnStc@kernel.org>
 <aMhWHy1LQVqpyW5E@kernel.org>
 <8c2817f5bbf8202b50d93b6044d6595ea4b29b9a.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c2817f5bbf8202b50d93b6044d6595ea4b29b9a.camel@HansenPartnership.com>

On Tue, Sep 16, 2025 at 10:33:43PM -0400, James Bottomley wrote:
> On Mon, 2025-09-15 at 21:08 +0300, Jarkko Sakkinen wrote:
> > On Mon, Sep 15, 2025 at 05:50:07PM +0300, Jarkko Sakkinen wrote:
> > > On Sun, Sep 14, 2025 at 11:24:24PM -0400, James Bottomley wrote:
> > > > On Sun, 2025-09-14 at 19:08 +0300, Jarkko Sakkinen wrote:
> > > > > Hi,
> > > > > 
> > > > > In practice, while implementing tpm2sh and its self-contained
> > > > > TPM emulator called "MockTPM", I've noticed that
> > > > > 'tpm2key.asn1.' has a major bottleneck, but luckily it is easy
> > > > > to squash.
> > > > > 
> > > > > Parent handle should never be persisted, as it defies the
> > > > > existential reason of having a file format in the first place.
> > > > 
> > > > Actually, if you read the spec:it describes how to handle non-
> > > > persistent parents by defining the exact form of the P256 parent
> > > > you derive from the permanent handle in section 3.1.8:
> > > > 
> > > > https://www.hansenpartnership.com/draft-bottomley-tpm2-keys.html
> > > > 
> > > > This is the way all the implementations (well except the kernel,
> > > > but that's fixable) do it.
> > > 
> > > Even if you fix it to persistent handle, the problem does not go
> > > magically go away. Read public attributes are ubiquitos and
> > > cryptographically correct way to do the binding.
> > > 
> > > > 
> > > > > To address this issue I just added couple of optional fields to
> > > > > TPMKey:
> > > > > 
> > > > >   parentName   [6] EXPLICIT OCTET STRING OPTIONAL,
> > > > >   parentPubkey [7] EXPLICIT OCTET STRING OPTIONAL
> > > > 
> > > > So that's a bit redundant, since if you know the key, you know
> > > > its name.
> > > 
> > > What I know is irrelevant here :-)
> > > 
> > > > 
> > > > > By persisting this information TPM2_GetCapability +
> > > > > TPM2_ReadPublic can be used to acquire an appropriate handle.
> > > > 
> > > > It can, how?  If the parent is a primary, you can't insert it
> > > > from a public key, you have to derive it and if it's non-primary,
> > > > you need its parent to do the insertion.
> > > 
> > > Transient handle is like file handle and persistent handle is like
> > > inode number. Neither unambigiuously (and this is dead obvious)
> > > does not identify any possible key.
> > > 
> > > Further by binding key correctly, the requirement of being
> > > persistent key goes away, which is a limiting factor.
> > > 
> > > > 
> > > > > I'd highly recommend to add this quirk to anything that
> > > > > processes this ASN.1 format.
> > > > 
> > > > Well, patches to the standard are accepted:
> > > > 
> > > > https://groups.io/g/openssl-tpm2-engine/topics
> > 
> > Further there is two options:
> > 
> > 1. Either remove TPM2 key ASN.1 support from kernel entirely.
> > 2. Fix the 0day bug.
> 
> Can you please explain in technical terms what you see as a zero day
> bug in the current implementation?

It's essentially ambiguity problem in my opinion that locks in the
creator TPM if you know the expected parent. 0day might be overstatement
yes, but it is essentially the immutable reference in this scheme.
If you want to scope it, it's essentially a great way to add some defence
in depth to the scheme.

> 
> > It is unacceptable to make strong binding to a random open source
> > project. I zero care what OpenSSL TPM2 engine does with the file
> > format.
> 
> I don't really get what you mean here, but the tone, which is also in
> several of your replies is unmistakably hostile.  My usual playbook for
> defusing this is to respond only to technical content.  However,
> several people have cited to me this hostility as the reason they're
> unwilling to engage further with the linux-integrity@ or keyrings@
> lists and have moved on to pursue other interests. Since losing
> talented contributors because of things like this is a tragedy and
> because it's partly my fault for letting this continue, I'm now asking
> you to please make the effort to tone down the hostile rhetoric. 
> That's not to say you can't do technical criticism, you absolutely can,
> just do it without hectoring and implying sinister motivations.

This goes a bit off-topic but I don't recognize this as I'm usually
helpful in my own code reviews at least, and acknowledging my own
misconceptions.

> 
> I think most of us have noticed that there seem to be various
> circumstances in your life that are producing significant stress but at
> the same time, that's not a reason to take it out on the mailing lists.
> There are resources available to help with maintainer stress and
> burnout and I'd certainly be happy to connect you or help out here in
> another way if you'd like.

Sure I get that but as said there's been mostly positive tone in
the patch reviews.

> 
> Regards,
> 
> James
> 

BRm Jarkko

