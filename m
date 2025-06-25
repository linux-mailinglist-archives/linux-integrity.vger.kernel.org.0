Return-Path: <linux-integrity+bounces-6523-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A004FAE8B08
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jun 2025 19:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D8CD1895B85
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jun 2025 17:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D5E2D877E;
	Wed, 25 Jun 2025 16:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSRiDNPT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E9D2D5419;
	Wed, 25 Jun 2025 16:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750870173; cv=none; b=Y3+vGL3MD/zQmrEvlutduiiNM5KvgGfugzj0HxMXDrJ2TTIIswWi9ZXfNXsKFyn9CUE5UrjYtMdgz9HBv+eaL2YYxdGfeK8LiahiyxrzBojyLNuEzSIN0XDWxVHbPvJzAGWCOyFczIhckZ6VKH790up+Pjao0j0raaE0VJKsNE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750870173; c=relaxed/simple;
	bh=hJ9IT1sDWJS1Qd9kgWQahG6lGAg4gN1nxTf5Bx35lTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=biA80kzdvzAZijDtQjSThq2CnDddBCASMPsFOkGQqsgDhF/BfikJq0Q6YyOsIYhDhgIt1JplO2Cr4/gUG5HBHRJTGhEXw6TUvQkZuGaEeM4UAKv7dfzaGKsRNkwwPBmmo9PFh+cvdaHo51kkTowYGXKYSGN3ALWLjaaI/g1AthI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSRiDNPT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D33C4CEEA;
	Wed, 25 Jun 2025 16:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750870173;
	bh=hJ9IT1sDWJS1Qd9kgWQahG6lGAg4gN1nxTf5Bx35lTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HSRiDNPTXbn4O9UGLpsTTb7caMI4LNipWhOJOr/wCEhL1B49Q56xuqUepdnY2Fl8X
	 ZArJKg1tiQlyZsbQ1sK7pLiQ8B8Awj+jYa80BywD8ZIfhsd3Azh3xfKRER1a0p2w9P
	 4vgieWP7jWg649mFW+DryVPTjbeFkIxNmELwgea65Jqm2NHk4nQokUJo95Vr5EuQc4
	 +RuXrLBWQ880PbqdGEw9zhwPfViwRMncOPPomNxGNgeZRIrfsDRPWEZ3Ckv+p3Lvu6
	 J5qyttSprM8mCPaTOCfdxhzEvn2uYqtaXuMvYVEI5epNyMnKLogSanIV6yTy+O7TcW
	 NQnfDp9cpPJvQ==
Date: Wed, 25 Jun 2025 19:49:29 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: "Orlov, Ivan" <iorlov@amazon.co.uk>,
	"peterhuewe@gmx.de" <peterhuewe@gmx.de>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Woodhouse, David" <dwmw@amazon.co.uk>
Subject: Re: [PATCH v2] tpm: Fix the timeout & use ktime
Message-ID: <aFwomWU28ijZj3CZ@kernel.org>
References: <20250620180828.98413-1-iorlov@amazon.com>
 <aFhtKrWTDzZbpTSh@earth.li>
 <aFwnG--lzZO0mQgc@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFwnG--lzZO0mQgc@kernel.org>

On Wed, Jun 25, 2025 at 07:43:11PM +0300, Jarkko Sakkinen wrote:
> On Sun, Jun 22, 2025 at 09:52:58PM +0100, Jonathan McDowell wrote:
> > On Fri, Jun 20, 2025 at 06:08:31PM +0000, Orlov, Ivan wrote:
> > > The current implementation of timeout detection works in the following
> > > way:
> > > 
> > > 1. Read completion status. If completed, return the data
> > > 2. Sleep for some time (usleep_range)
> > > 3. Check for timeout using current jiffies value. Return an error if
> > >   timed out
> > > 4. Goto 1
> > > 
> > > usleep_range doesn't guarantee it's always going to wake up strictly in
> > > (min, max) range, so such a situation is possible:
> > > 
> > > 1. Driver reads completion status. No completion yet
> > > 2. Process sleeps indefinitely. In the meantime, TPM responds
> > > 3. We check for timeout without checking for the completion again.
> > >   Result is lost.
> > > 
> > > Such a situation also happens for the guest VMs: if vCPU goes to sleep
> > > and doesn't get scheduled for some time, the guest TPM driver will
> > > timeout instantly after waking up without checking for the completion
> > > (which may already be in place).
> > > 
> > > Perform the completion check once again after exiting the busy loop in
> > > order to give the device the last chance to send us some data.
> > > 
> > > Since now we check for completion in two places, extract this check into
> > > a separate function.
> > > 
> > > Signed-off-by: Ivan Orlov <iorlov@amazon.com>
> > > ---
> > > V1 -> V2:
> > > - Exclude the jiffies -> ktime change from the patch
> > > - Instead of recording the time before checking for completion, check
> > >  for completion once again after leaving the loop
> > > 
> > > drivers/char/tpm/tpm-interface.c | 17 +++++++++++++++--
> > > 1 file changed, 15 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> > > index 8d7e4da6ed53..6960ee2798e1 100644
> > > --- a/drivers/char/tpm/tpm-interface.c
> > > +++ b/drivers/char/tpm/tpm-interface.c
> > > @@ -82,6 +82,13 @@ static bool tpm_chip_req_canceled(struct tpm_chip *chip, u8 status)
> > > 	return chip->ops->req_canceled(chip, status);
> > > }
> > > 
> > > +static bool tpm_transmit_completed(struct tpm_chip *chip)
> > > +{
> > > +	u8 status_masked = tpm_chip_status(chip) & chip->ops->req_complete_mask;
> > > +
> > > +	return status_masked == chip->ops->req_complete_val;
> > > +}
> > > +
> > > static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
> > > {
> > > 	struct tpm_header *header = buf;
> > > @@ -129,8 +136,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
> > > 	stop = jiffies + tpm_calc_ordinal_duration(chip, ordinal);
> > > 	do {
> > > 		u8 status = tpm_chip_status(chip);
> > > -		if ((status & chip->ops->req_complete_mask) ==
> > > -		    chip->ops->req_complete_val)
> > > +		if (tpm_transmit_completed(chip))
> > > 			goto out_recv;
> > 
> > The only thing I'd point out here is we end up doing a double status read
> > one after the other (once here, once in tpm_transmit_completed), and I'm
> > pretty sure I've seen instances where that caused a problem.
> 
> It would be easy to to prevent at least double reads after completion
> e.g., in tpm_chip_status():
> 
> /*
>  * Read the chip status bitmask. After completion, the returned will mask will
>  * return value cached at the point of completion up until the next transmit.
>  */
> static u8 tpm_chip_status(struct tpm_chip *chip)
> {
> 	u8 status_masked = chip->status & chip->ops_req_complete_mask;
> 
> 	if (status_masked == chip->ops->req_complete_val)
> 		return chip->status;
> 
> 	chip->status = tpm_chip_status(chip);

OOPS:

	chip->status = chip->ops->status(chip);

Couple of additional constraints:

1. tpm_chip_alloc() should initialize chip->status to chip->ops->req_complete_mask.
2. tpm_try_transmit() should reset the value to chip->ops->req_complete_mask on
   failure paths.

With these constraints there is framework where chip->ops->status() is
only invoked when it actually makes sense i.e., only during the course
of tpm_try_trasmit().

BR, Jarkko

