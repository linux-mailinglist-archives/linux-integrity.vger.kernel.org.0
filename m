Return-Path: <linux-integrity+bounces-5481-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62653A73551
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 16:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7B0B18878B6
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 15:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C20154425;
	Thu, 27 Mar 2025 15:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQh0KIvA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC8114A0B7;
	Thu, 27 Mar 2025 15:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743088018; cv=none; b=WsSLPJAvg0CDdthQ9fMr5hqM9OIQHOnaCLC3J6B+NpI03Bi93HZ5lwjlhl5ILm/E1QTR4cZsC2oPZW3xYqJMSlJ5v6a8C3TuYcUpIUz6edOXWP93LchHtBAiK4B7mQtZQxgDhJ4iZtaIakRXoM59EAoIX8HUIXUTM+LaxiJJgaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743088018; c=relaxed/simple;
	bh=vnz0gNM+HdXIJH3M8cd9DH0u3q3YnsIMhkwztLO7+bY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=teNzBQ/V3XDou+hZeh4tupkUQPxS0W+yHtuNBec4wXht0B+GmiA1FACpStfVeY9EGwSsHBNiCap7oz1u6kGvvrj/WDXVvHX/0x65ktW7/s3SmkCv/pAZ0XdjfbZ6JgFrCXpUoT817W8UkZit782t6VqcXlGN7fdF+EJMs/Zyw/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQh0KIvA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401D7C4CEDD;
	Thu, 27 Mar 2025 15:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743088017;
	bh=vnz0gNM+HdXIJH3M8cd9DH0u3q3YnsIMhkwztLO7+bY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rQh0KIvA2XJUJEbG/1PZz3M2mi+/+suo2rJYNNVC1UjturOB8kQIY5hioe2pN6t0J
	 jXDjO+uJDlI4izLHWos47bfjmXIvFlTn9TCn0KKYdH3wf5Vf9KOzfzooHtiOqKNp7Z
	 Tesbb2j1U/SqUCYOr5OWGPOqreF1hD1GVz+MIMtxnesbXA9834CxI03eBFxq8pYcF0
	 S0As7FBmh4Bm5NUMf6Ftd16hMQp4SymtgZIqcqiYT6SXkXV8jo7GxcqH8J6FwQ0dVa
	 szc+pGmNR2hhLb1gjdpTUbjWZMStlEMzW9zHfRL2ncVf0ytU4TBSnzoAMjHEbZTMT5
	 iCt1HiuCGlFqA==
Date: Thu, 27 Mar 2025 17:06:53 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	linux-integrity@vger.kernel.org, Sumit Garg <sumit.garg@kernel.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Make chip->{status,cancel,req_canceled} opt
Message-ID: <Z-VpjSZSMOk73_Dg@kernel.org>
References: <20250326161838.123606-1-jarkko@kernel.org>
 <exzxzomw7wcobjuoje37x6i2ta54xzx5ho74t3atd7g74xltlb@ymw2pn3yo27b>
 <Z-VRWy8jLkA0cpow@kernel.org>
 <56428ff1ac4355482df881e6226518c2a62beb6d.camel@HansenPartnership.com>
 <Z-Vn91fADShpp65e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-Vn91fADShpp65e@kernel.org>

On Thu, Mar 27, 2025 at 05:00:11PM +0200, Jarkko Sakkinen wrote:
> On Thu, Mar 27, 2025 at 10:12:36AM -0400, James Bottomley wrote:
> > On Thu, 2025-03-27 at 15:23 +0200, Jarkko Sakkinen wrote:
> > > On Thu, Mar 27, 2025 at 10:58:00AM +0100, Stefano Garzarella wrote:
> > [...]
> > > > > @@ -65,6 +89,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip
> > > > > *chip, void *buf, size_t bufsiz)
> > > > > 	ssize_t len = 0;
> > > > > 	u32 count, ordinal;
> > > > > 	unsigned long stop;
> > > > > +	u8 status;
> > > > 
> > > > Why move `status` out of the do/while block?
> > > 
> > > I'm not a huge fan of stack allocations inside blocks, unless there
> > > is a particular reason to do so.
> > 
> > The move to scope based locking and freeing in cleanup.h necessitates
> > using scope based variables as well, so they're something we all have
> > to embrace.  They're also useful to tell the compiler when it can
> > reclaim the variable and they often create an extra stack frame that
> > allows the reclaim to be effective (even if the compiler can work out
> > where a variable is no longer reference, the space can't be reclaimed
> > if it's in the middle of an in-use stack frame).  I'd say the rule of
> > thumb should be only do something like this if it improves readability
> > or allows you to remove an additional block from the code.
> 
> Reclaiming here is only shift in the frame pointer, nothing to do with
> reclaiming resources or freeing locks. Consolidating value state into
> single location does improve readability as far as I'm concerned.

Anyhow, I reverted that change given the feedback :-)

Since I'm late sending PR, I'll put this patch to my 6.15 PR.

BR, Jarkko

