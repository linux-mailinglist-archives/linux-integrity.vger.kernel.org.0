Return-Path: <linux-integrity+bounces-5472-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3541A732FB
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 14:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CB4A3BF619
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 13:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0818D215061;
	Thu, 27 Mar 2025 13:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJyOPrgP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A7E2144D1;
	Thu, 27 Mar 2025 13:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743080683; cv=none; b=j3Jiv4zVMCypDLaIJ0yMMpM7NZ3bP+nMp93EX905rcdcRxCNAZnVBO7IgvikLwZfa59ew8cRb+K7M6m4q4Jo85ZmUoAi6N9IO6dKMyWZchMbZRSyQWAUxrARBb5h2Uu6zOq1yH/bWtskLbuiDZHz/BGb0xzZoIjkvMsunh8FvGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743080683; c=relaxed/simple;
	bh=xhrgFuz1vouc6eTd9s7u/Z+nm7I3LXD3Vys4lqppiS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hT/aLZUKiyK6qeuKw0viy++B/zMWrzvKQB9d4oTLGovBbwNfH1WQLR0aDQvSOLyJHrvvaUpi5fhK9C3L0G07POvTr7UYzm9jiGmvSG3MBFxYse8FdVwqJLmfRmwvgn2TXkzvwjeg7SCI5jXx0BguQ7Cf2Qd6HVI8ssXbur0BrvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJyOPrgP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED570C4CEDD;
	Thu, 27 Mar 2025 13:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743080683;
	bh=xhrgFuz1vouc6eTd9s7u/Z+nm7I3LXD3Vys4lqppiS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BJyOPrgPpfJLnMlcT7qMMQp94LAl/n0viykTpItKLK6VzpvHG3DRl+VhTJ3LVz751
	 Wdxbi3YgRVJ6/n6RMVF1st+/fqplpekL7CX9RNDZ7uoaHt66XIMP/4blTpMhCrqLIY
	 pCQdzMsnzkrGgZhrhXFhbO+EUdyg4xh+nq919LXmiR6Os9q3VvECumB96abmfSHWpG
	 9lW1KBIJCrzLGrPlzw7AAR1ChGEXm5tUsdsAcC0dtRrmsq200v6Kxpxi3BPvy4K+rS
	 4KQqwBWULjKZiNpE0FYyUok+HHIwLORkigytiWmS0prafCC/k0eQ7X58X6r6lUmRwF
	 rodWg+uc5X/zw==
Date: Thu, 27 Mar 2025 15:04:39 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Sumit Garg <sumit.garg@kernel.org>,
	linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
	linux-integrity@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: Re: [PATCH 2/2] tpm/tpm_ftpm_tee: use send_recv() op
Message-ID: <Z-VM56u1zWQSPemh@kernel.org>
References: <20250320152433.144083-1-sgarzare@redhat.com>
 <20250320152433.144083-3-sgarzare@redhat.com>
 <Z-I86tWMcD6b_YeM@sumit-X1>
 <Z-Pu4FhcntnKii61@kernel.org>
 <Z+QQWe/upJuVpU8r@ziepe.ca>
 <Z-QV5y1JGBDpsPuH@kernel.org>
 <Z-QkGUenPAMid63l@kernel.org>
 <Z-RlbEN9BoKnTN2E@kernel.org>
 <6mpece5tkoie6ngv3j3xzjkotn6x6wu2vjs7pc44ns76z6v3d2@c6jinanngw5o>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6mpece5tkoie6ngv3j3xzjkotn6x6wu2vjs7pc44ns76z6v3d2@c6jinanngw5o>

On Thu, Mar 27, 2025 at 10:27:48AM +0100, Stefano Garzarella wrote:
> On Wed, Mar 26, 2025 at 10:37:09PM +0200, Jarkko Sakkinen wrote:
> > On Wed, Mar 26, 2025 at 05:58:33PM +0200, Jarkko Sakkinen wrote:
> > > On Wed, Mar 26, 2025 at 04:57:47PM +0200, Jarkko Sakkinen wrote:
> > > > On Wed, Mar 26, 2025 at 11:34:01AM -0300, Jason Gunthorpe wrote:
> > > > > On Wed, Mar 26, 2025 at 02:11:12PM +0200, Jarkko Sakkinen wrote:
> > > > >
> > > > > > Generally speaking I don't see enough value in complicating
> > > > > > callback interface. It's better to handle complications in
> > > > > > the leaves (i.e. dictatorship of majority ;-) ).
> > > > >
> > > > > That is very much not the way most driver subsystems view the
> > > > > world. We want to pull logical things into the core code and remove
> > > > > them from drivers to make the drivers simpler and more robust.
> > > > >
> > > > > The amount of really dumb driver boiler plate that this series
> > > > > obviously removes is exactly the sort of stuff we should be fixing by
> > > > > improving the core code.
> > > > >
> > > > > The callback interface was never really sanely designed, it was just
> > > > > built around the idea of pulling the timout processing into the core
> > > > > code for TIS hardware. It should be revised to properly match these
> > > > > new HW types that don't have this kind of timeout mechanism.
> > > >
> > > > Both TIS and CRB, which are TCG standards and they span to many
> > > > different types of drivers and busses. I don't have the figures but
> > > > probably they cover vast majority of the hardware.
> > > >
> > > > We are talking about 39 lines of reduced complexity at the cost
> > > > of complicating branching at the top level. I doubt that there
> > > > is either any throughput or latency issues.
> > > >
> > > > What is measurable benefit? The rationale is way way too abstract
> > > > for me to cope, sorry.
> > > 
> > > E.g., here's how you can get rid of extra cruft in tpm_ftpm_tee w/o
> > > any new callbacks.
> 
> Yeah, I agree that your patch should go in any case, with send_recv() or
> not. It's a good cleanup.
> 
> > 
> > Measurable benefit: no need to allocate memory buffer.
> 
> That's right, I read the whole thread before responding, but that's exactly
> what I wanted to highlight. Implementing send_recv() we could completely
> remove the buffer for the cache here in tpm_ftpm_tee, simplifying it quite a
> bit.
> 
> In tpm_svsm instead we allocate it while probing anyway to avoid having to
> allocate it every time, but we could potentially do the same (I don't know
> if it makes sense honestly). We do this because for SVSM any buffer is fine,
> as it can access all guest kernel memory, whereas IIUC for ftpm it has to be
> taken from shared memory.
> 
> > 
> > Let's take that as a starting point ;-)
> 
> Yeah!
> 
> > 
> > On that basis I can consider this (i.e. something to measure).
> 
> Okay, I explain this better in the commit description for the next version!

Awesome :-) Thanks for the patience with this. I rather precautionaly
throw sticks on the road than go through fixes post upstreaming, which
is factors more nasty and time-consuming...

> 
> Thanks,
> Stefano
> 

BR, Jarkko

