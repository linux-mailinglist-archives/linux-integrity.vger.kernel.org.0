Return-Path: <linux-integrity+bounces-6914-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 141DBB34F0E
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Aug 2025 00:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07C5B189B3E1
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Aug 2025 22:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62296293C44;
	Mon, 25 Aug 2025 22:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKyN1Fth"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3916923026B;
	Mon, 25 Aug 2025 22:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756160999; cv=none; b=S4ZD7ICqmXNSfrJC53iwoUVoq4Nqil7AWS6mj/n/yVGnmtQMButZHXmUdqsyHufvVljEtNawjRAzNSe2zhU3kY2ybtTramSfX296ZzjFV6VUvLeiPETmQOC61k3jlXzkbtE83Sfk96SEoh7/QlG6AQXTJnfut0pmBBSiawSyBSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756160999; c=relaxed/simple;
	bh=KCpE8C5wwzfNWVZzbtlSExMzWjC41AxWD0fmOI2Jg6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nCHnc0L8mqFG0H0bHaTUbwpvakSJFMXwYZS1r4wrcghob5rfP4k6lxAOK9lxaZwhcWMbUHwUX7WBzHMB+9cqZN/Zg465H/EC7e3ZrIUErGl7vgYIYmQ8NmuhlWraK/vGBYKYiZ3PBh7Zx5Y9IVvtd6zMdQKPASyzWJ8Dg9Vhzlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKyN1Fth; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64190C4CEED;
	Mon, 25 Aug 2025 22:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756160998;
	bh=KCpE8C5wwzfNWVZzbtlSExMzWjC41AxWD0fmOI2Jg6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jKyN1Fthwpac5IcX4qZx8jyebmsKQXvHrDQGfnwKs1yQ+bAI20zx/mQgiNd1FcbGq
	 7St2Wvop6bO6wpM7VvedijlfB38wTY3J8kW7rDiGk7FzIVg+ojtp5513/2a3WGrT36
	 2oRosIrmIsfb2ytNb/mrHHcvAMFtex3fP7kICYXOQNUrjfKbsjkU7ffwbBkO2TnIR+
	 hS+gMnlsm6mb4dxHNRp69446LmjO0oImeuR2G/kL4BRTUNWGSPDU47WYxvpSwcbSQ2
	 B+tGaiZd0eCcaDP3pGW76Fvy3JkOpp0nMihkcrgM6e/miM/+jy+YiJRZMo9SUOGcwd
	 4dclpe+mzrd+Q==
Date: Tue, 26 Aug 2025 01:29:55 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: rust-for-linux@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: Using Rust on non-Rust side of kernel
Message-ID: <aKzj44NBShpMXFA0@kernel.org>
References: <aKmwPFb4cCk_E-ob@kernel.org>
 <aKxRVlyNXUGBwJ2L@earth.li>
 <aKy5z74FE4paL7za@kernel.org>
 <aKy8tWxTiK90iyLi@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKy8tWxTiK90iyLi@kernel.org>

On Mon, Aug 25, 2025 at 10:42:45PM +0300, Jarkko Sakkinen wrote:
> On Mon, Aug 25, 2025 at 10:30:27PM +0300, Jarkko Sakkinen wrote:
> > On Mon, Aug 25, 2025 at 01:04:38PM +0100, Jonathan McDowell wrote:
> > > On Sat, Aug 23, 2025 at 03:12:44PM +0300, Jarkko Sakkinen wrote:
> > > 
> > > > My goal with tpm2_protocol is to have ACPICA alike model of imports as
> > > > the crate is driven by TCG spec updates and it is very likely to be
> > > > also used by TPM-RS (also via import style process).
> > > 
> > > I'm not entirely clear on what your plan is for this / the existing TPM
> > > drivers in the kernel? I assume it's to eventually remove some of the C code
> > > in favour of the Rust implementation, but I'm missing exactly how that's
> > > expected to work.
> > 
> > There's no plan of doing anything at this point. This is more like doing
> > early research for the following questions:
> > 
> > 1. If this comes up in form or another, what are the directions of freedom.
> > 2. What could be in general done in Rust that could potentially extend
> >    the capabilities of e.g. /dev/tpmrm0 (which could be entirely
> >    different device).
> > 3. There has not been any discussion from my part of removing and/or
> >    repealing and replacing any of the C driver code.
> > 
> > It's a bit odd position IMHO to not prepare for future outcomes. Even
> > without kernel context, for the TPM marshalling/unmarshalling there does
> > not exist decent implementation as of today in *any language*.
> > 
> > There's been way too many unprepared situations of C-to-Rust
> > transformations, and learning lessons from that, I think it was the
> > priority to implement the protocol part so that it has enough time to
> > mature when the day might come.
> > 
> > > 
> > > (Given I've spent a bunch of time this year tracking down various edge case
> > > issues in the TPM code that have been causing failures in our fleet I'm
> > > understandably wary of a replacement of the core code. *It* might be a
> > > perfect spec implementation, but hardware rarely is.)
> > 
> > I think this is somewhat unconstructive comment. How do you implement
> > against anything if you don't follow the spec and later on fix the
> > incosistencies?
> > 
> > I have not observed high stream of marshalling and unmarshalling
> > associated bugs or other issues.
> > 
> > Also if you make obnoxious arguments like that please also underline
> > how implementation A is worse at dealing possible inconsistencies
> > than implementation B. Otherwise, you're only spreading FUD.
> 
> My claim is that more high granularity marshaller and unmarshaller is
> actually better at both catching and scoping incosistencies, and thus
> it speeds up resolving bugs in that code and/or create workaround and
> quirks. What is your argument?
> 
> My pure guess is that the comment was that Google's device does not have
> TPM2_ContextSave. How that does trip marshaller and/or unmarshaller
> if a command or response does not exist?
> 
> This goes beyond the topic but I want again underline that:
> 
> 1. /dev/tpmrm0 has existed since 2017.
> 2. Is used by many tools, such as systemd.
> 3. Google has failed so far to provide a change (within almost
>    nine year time period) to Linux kernel that would
>    disable /dev/tpmrm0 to any of their hardware.

I'm sorry Jonathan could have been a more polite tone but at least this
addresses your main concern: no absolutely not I'm pushing any type of
Rust driver :-) And I fully understand why someone might get a picture
that I had that type of thoughts.

I am going to most likely make experiments with kernel and most
definitely make "tpmtrace" (a tool that hooks to BPF ring buffer and
pretty prints the protocol in real-time, it's dead easy to do now).
Finally (as I've said before) it would be quite unproductive to create a
design that does not upscale to let's say to an attestation server
(which would use this to parse e.g. quotes) or downscale to a chip.

Other than that it's open for patches and from my side I'm ready to
review and apply patches and maintain stable branches once 0.11.0
is out [1].

[1] https://lore.kernel.org/tpm2/aKzaTYCI2GO_UPRB@kernel.org/T/#u

BR, Jarkko

