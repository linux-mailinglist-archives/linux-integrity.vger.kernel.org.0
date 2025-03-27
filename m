Return-Path: <linux-integrity+bounces-5488-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33850A7404E
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 22:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DC3F3B7935
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 21:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFEA1D88AC;
	Thu, 27 Mar 2025 21:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxhVSU17"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D791C6FF3;
	Thu, 27 Mar 2025 21:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743110992; cv=none; b=ThHB+uU9o9gD8c+3rJf1Mv8JLOh1hW0pPldXmtGmZof3PTtx4rXSuyXzNAqa+NzJyCHJwTRoDS5GEp1K9XBF41M2FJq/fjZcfdqZ9KsWPsPbIgXS/ioBbOe/zNRRPhy5Eh+d5rKYyo0CYLZ6HOifg/VQkBinyjYK4GujSHqIeGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743110992; c=relaxed/simple;
	bh=tE+oXcdbvUI7DFZBZ3VQ31SAkPdORoIC//rAD7PbP9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6qVV6am7RMPOGQv9hCKIwE75iAhUedL95mPEsnCAFOVfRX8RXz3/shFMKUso6tfBYyhPuI9DR7qcndV7UqC40dWl955BqCP6nsRQ09z+uidwWA4q8+JJ810P2L1XqcUy+Iw1P+BbfaTULPNS6NEMLceCS71NXZBtJ6Gu7DSAS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxhVSU17; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D460C4CEDD;
	Thu, 27 Mar 2025 21:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743110991;
	bh=tE+oXcdbvUI7DFZBZ3VQ31SAkPdORoIC//rAD7PbP9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bxhVSU17wAZqIxspBFOr4SfTmaUTRxHg6beLptpAGF9tJT1W1tdzlH7KeGbWv3iAn
	 xhqVt/agFK8FZKnQeQu5+CmevR816OFXSf4cKWN43QikS/TnIjrnsEuYGwzZb3g8sc
	 QIP/bzzJG4O/mRDBmaSfLXJwMVqoHBhi0Eiqfal1ZeCz+8x0lG1xSqQ7GHzdP53hyS
	 1iwluMuJaxPBrHJTCAuE8qZhz4r1Ogstg9ItfLnckUWK2CvfzeeV7soffZTC6yCzUQ
	 mtHKyqy+42mjrl6Vl1h/PI7gNBPT668kSWAnz60n97bed3VljPgt8bUoNfKfEZyBTj
	 qST60J/+k+kMw==
Date: Thu, 27 Mar 2025 23:29:46 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-integrity@vger.kernel.org, Sumit Garg <sumit.garg@kernel.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Make chip->{status,cancel,req_canceled} opt
Message-ID: <Z-XDSoTtEGfJJx9i@kernel.org>
References: <20250326161838.123606-1-jarkko@kernel.org>
 <exzxzomw7wcobjuoje37x6i2ta54xzx5ho74t3atd7g74xltlb@ymw2pn3yo27b>
 <Z-VRWy8jLkA0cpow@kernel.org>
 <56428ff1ac4355482df881e6226518c2a62beb6d.camel@HansenPartnership.com>
 <Z-Vn91fADShpp65e@kernel.org>
 <Z-VpjSZSMOk73_Dg@kernel.org>
 <bxm7fa2st6glsegemyxbwj4q47azl7h3qmg4vo7o4xqa4ahstj@frtabtwa7jok>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bxm7fa2st6glsegemyxbwj4q47azl7h3qmg4vo7o4xqa4ahstj@frtabtwa7jok>

On Thu, Mar 27, 2025 at 04:37:13PM +0100, Stefano Garzarella wrote:
> On Thu, Mar 27, 2025 at 05:06:53PM +0200, Jarkko Sakkinen wrote:
> > On Thu, Mar 27, 2025 at 05:00:11PM +0200, Jarkko Sakkinen wrote:
> > > On Thu, Mar 27, 2025 at 10:12:36AM -0400, James Bottomley wrote:
> > > > On Thu, 2025-03-27 at 15:23 +0200, Jarkko Sakkinen wrote:
> > > > > On Thu, Mar 27, 2025 at 10:58:00AM +0100, Stefano Garzarella wrote:
> > > > [...]
> > > > > > > @@ -65,6 +89,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip
> > > > > > > *chip, void *buf, size_t bufsiz)
> > > > > > > 	ssize_t len = 0;
> > > > > > > 	u32 count, ordinal;
> > > > > > > 	unsigned long stop;
> > > > > > > +	u8 status;
> > > > > >
> > > > > > Why move `status` out of the do/while block?
> > > > >
> > > > > I'm not a huge fan of stack allocations inside blocks, unless there
> > > > > is a particular reason to do so.
> > > >
> > > > The move to scope based locking and freeing in cleanup.h necessitates
> > > > using scope based variables as well, so they're something we all have
> > > > to embrace.  They're also useful to tell the compiler when it can
> > > > reclaim the variable and they often create an extra stack frame that
> > > > allows the reclaim to be effective (even if the compiler can work out
> > > > where a variable is no longer reference, the space can't be reclaimed
> > > > if it's in the middle of an in-use stack frame).  I'd say the rule of
> > > > thumb should be only do something like this if it improves readability
> > > > or allows you to remove an additional block from the code.
> > > 
> > > Reclaiming here is only shift in the frame pointer, nothing to do with
> > > reclaiming resources or freeing locks. Consolidating value state into
> > > single location does improve readability as far as I'm concerned.
> > 
> > Anyhow, I reverted that change given the feedback :-)
> > 
> > Since I'm late sending PR, I'll put this patch to my 6.15 PR.
> 
> Okay, so I'll not include it in my series and I'll rebase my series on your
> tree.

Let's hold on for what Linus think (i.e. pr-tracker-bot).

I.e., conditional yes.

> 
> Thanks,
> Stefano
> 

BR, Jarkko

