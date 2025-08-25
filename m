Return-Path: <linux-integrity+bounces-6907-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7DFB34B10
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Aug 2025 21:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F6D817A8E9
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Aug 2025 19:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603D328467B;
	Mon, 25 Aug 2025 19:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dzd4WqTC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAF42741DA;
	Mon, 25 Aug 2025 19:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756150970; cv=none; b=IiPp2htwd18IzejwdFvt/5Bam32Pp30Yto0yl5FSJtTssqfrGicKOLyfsmfvpDFgwvJkamJRrVE1EIyziSv05qurF2XqWTmXTx6DQyK7YoGVFgrA2HMcnsUicRxggkX/7LJ1O0qDpttTjDiXX2lQMOOX0O9R2Yd7zzIyK3S8TKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756150970; c=relaxed/simple;
	bh=go2OdVXB1EMo9PkYI2ISajD9aSoOPe0O0f/6XmQjQ8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTTS7RUrjmuDhvm2hzrdFVRdPhWFAHwklbPIaQdG8yd/3oos5OVue2oFEFEi5E2qdlj+4//GjCS0XeaWFgCTGRVQz9BJgH2AxQdU0yu0HjSE9d+6preE48Jz1yKCszXtbo+zGM4MRyYWb9tfpOwX2JYgEjqNPaQjnZskEFpMPiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dzd4WqTC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6DEC4CEED;
	Mon, 25 Aug 2025 19:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756150969;
	bh=go2OdVXB1EMo9PkYI2ISajD9aSoOPe0O0f/6XmQjQ8s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dzd4WqTCN/FcCmw9/aI3pQWl8IoGkIATIMqw2BQE9UkxsYk3bis7zt+dWV54EKdYX
	 92Ho/MJklHyw3QRal+SuTEIqivjI6lQ8fDoA4Bb05DJFVTOs4g6VPlJFGKBCWpNlJ9
	 dsK8SbyWlEFgOMTOyJLbE/OtLiJy3mhexbzpMo6G4wSgN9a/Rzj1QD+UZQtG7yNsSp
	 7Fn6VLJSyFARAdViOFGORarNALHpOH6dzFGuY8f6gonmxXm8Q9srJ/lfFA8dDSyllH
	 cGhMNEV5p/cBrW2WDeaNpVQkvWNbsKzLXL0690An4jXjPvRqNyHEvlB7h+q1hVPlaN
	 tLlDMTXdvAVxw==
Date: Mon, 25 Aug 2025 22:42:45 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: rust-for-linux@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: Using Rust on non-Rust side of kernel
Message-ID: <aKy8tWxTiK90iyLi@kernel.org>
References: <aKmwPFb4cCk_E-ob@kernel.org>
 <aKxRVlyNXUGBwJ2L@earth.li>
 <aKy5z74FE4paL7za@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKy5z74FE4paL7za@kernel.org>

On Mon, Aug 25, 2025 at 10:30:27PM +0300, Jarkko Sakkinen wrote:
> On Mon, Aug 25, 2025 at 01:04:38PM +0100, Jonathan McDowell wrote:
> > On Sat, Aug 23, 2025 at 03:12:44PM +0300, Jarkko Sakkinen wrote:
> > 
> > > My goal with tpm2_protocol is to have ACPICA alike model of imports as
> > > the crate is driven by TCG spec updates and it is very likely to be
> > > also used by TPM-RS (also via import style process).
> > 
> > I'm not entirely clear on what your plan is for this / the existing TPM
> > drivers in the kernel? I assume it's to eventually remove some of the C code
> > in favour of the Rust implementation, but I'm missing exactly how that's
> > expected to work.
> 
> There's no plan of doing anything at this point. This is more like doing
> early research for the following questions:
> 
> 1. If this comes up in form or another, what are the directions of freedom.
> 2. What could be in general done in Rust that could potentially extend
>    the capabilities of e.g. /dev/tpmrm0 (which could be entirely
>    different device).
> 3. There has not been any discussion from my part of removing and/or
>    repealing and replacing any of the C driver code.
> 
> It's a bit odd position IMHO to not prepare for future outcomes. Even
> without kernel context, for the TPM marshalling/unmarshalling there does
> not exist decent implementation as of today in *any language*.
> 
> There's been way too many unprepared situations of C-to-Rust
> transformations, and learning lessons from that, I think it was the
> priority to implement the protocol part so that it has enough time to
> mature when the day might come.
> 
> > 
> > (Given I've spent a bunch of time this year tracking down various edge case
> > issues in the TPM code that have been causing failures in our fleet I'm
> > understandably wary of a replacement of the core code. *It* might be a
> > perfect spec implementation, but hardware rarely is.)
> 
> I think this is somewhat unconstructive comment. How do you implement
> against anything if you don't follow the spec and later on fix the
> incosistencies?
> 
> I have not observed high stream of marshalling and unmarshalling
> associated bugs or other issues.
> 
> Also if you make obnoxious arguments like that please also underline
> how implementation A is worse at dealing possible inconsistencies
> than implementation B. Otherwise, you're only spreading FUD.

My claim is that more high granularity marshaller and unmarshaller is
actually better at both catching and scoping incosistencies, and thus
it speeds up resolving bugs in that code and/or create workaround and
quirks. What is your argument?

My pure guess is that the comment was that Google's device does not have
TPM2_ContextSave. How that does trip marshaller and/or unmarshaller
if a command or response does not exist?

This goes beyond the topic but I want again underline that:

1. /dev/tpmrm0 has existed since 2017.
2. Is used by many tools, such as systemd.
3. Google has failed so far to provide a change (within almost
   nine year time period) to Linux kernel that would
   disable /dev/tpmrm0 to any of their hardware.

BR, Jarkko

