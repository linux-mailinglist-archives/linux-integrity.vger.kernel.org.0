Return-Path: <linux-integrity+bounces-5480-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D19A73533
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 16:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6976E179FC8
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 15:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9E47DA73;
	Thu, 27 Mar 2025 15:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMkjjW3J"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E9935964;
	Thu, 27 Mar 2025 15:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743087611; cv=none; b=QUVyeZa74XgyJf0O+k96kHQpuf19xo3ihhQquss9katFjEX+ZF18hIlJrL/DF8dcd302g84JmmrwNNxrOA3VH/XEVzIMtZOQNSchx1THDptbjq6IDcaYjjkaxokPZFGWsqyMRRR+1EmyO81KB8ZIV7Ft72oc4V1RStaXNDqeVwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743087611; c=relaxed/simple;
	bh=klpGMr9a21Z6cQTS4hRM6Ey834DG6b500S9KgvCdbFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tAczxXP7vkmASThlwjuRsdiXnYoCKxCbdtEgCTKaLX8l/o+54u06GSvrxSnj8nS2rXeXmW/2RF2F7/Digp3/05tD9+RCHQDUTS8H0UfkTqMGriwbSxtFR66TL+migH3G1TprqLEiD+vTAZ4PEWs2WAex4n1NBMN6GkfxyJLOdOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMkjjW3J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96277C4CEDD;
	Thu, 27 Mar 2025 15:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743087611;
	bh=klpGMr9a21Z6cQTS4hRM6Ey834DG6b500S9KgvCdbFU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HMkjjW3J5VrliGE5Fq7qba9UAZ5FICvWjzXxi3z80+oAUyqfp9N03qioSE3Yp25qP
	 iqEPINYw0vX63TXhLylrsTxaFxQ3RkaQsz9YOlgYWZk+GelGvinmarOI5jqFUX7WYC
	 x1hSF5rgFRaLhBBKKGrzvgF5EL+MCbDgtDnBoQkaHKO4punhhrn6MdvqpN1XAwMqGY
	 3tUoaFUi5vuLGkkslJEzPD67ry4kwInB7mzRfpta7GJe7eZg166ivO4yWzn7kaMtf6
	 1jFsP/HULisvbHifCK0MojS7N/XmBskmlYknOCK9Qf04TcP4pA1tuay2pqIJAkMHJ6
	 eows7QuNy/k2A==
Date: Thu, 27 Mar 2025 17:00:07 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	linux-integrity@vger.kernel.org, Sumit Garg <sumit.garg@kernel.org>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Make chip->{status,cancel,req_canceled} opt
Message-ID: <Z-Vn91fADShpp65e@kernel.org>
References: <20250326161838.123606-1-jarkko@kernel.org>
 <exzxzomw7wcobjuoje37x6i2ta54xzx5ho74t3atd7g74xltlb@ymw2pn3yo27b>
 <Z-VRWy8jLkA0cpow@kernel.org>
 <56428ff1ac4355482df881e6226518c2a62beb6d.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56428ff1ac4355482df881e6226518c2a62beb6d.camel@HansenPartnership.com>

On Thu, Mar 27, 2025 at 10:12:36AM -0400, James Bottomley wrote:
> On Thu, 2025-03-27 at 15:23 +0200, Jarkko Sakkinen wrote:
> > On Thu, Mar 27, 2025 at 10:58:00AM +0100, Stefano Garzarella wrote:
> [...]
> > > > @@ -65,6 +89,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip
> > > > *chip, void *buf, size_t bufsiz)
> > > > 	ssize_t len = 0;
> > > > 	u32 count, ordinal;
> > > > 	unsigned long stop;
> > > > +	u8 status;
> > > 
> > > Why move `status` out of the do/while block?
> > 
> > I'm not a huge fan of stack allocations inside blocks, unless there
> > is a particular reason to do so.
> 
> The move to scope based locking and freeing in cleanup.h necessitates
> using scope based variables as well, so they're something we all have
> to embrace.  They're also useful to tell the compiler when it can
> reclaim the variable and they often create an extra stack frame that
> allows the reclaim to be effective (even if the compiler can work out
> where a variable is no longer reference, the space can't be reclaimed
> if it's in the middle of an in-use stack frame).  I'd say the rule of
> thumb should be only do something like this if it improves readability
> or allows you to remove an additional block from the code.

Reclaiming here is only shift in the frame pointer, nothing to do with
reclaiming resources or freeing locks. Consolidating value state into
single location does improve readability as far as I'm concerned.
 
> Regards,
> 
> James
> 

BR, Jarkko

