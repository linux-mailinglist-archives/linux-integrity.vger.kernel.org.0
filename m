Return-Path: <linux-integrity+bounces-6627-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D29AF969D
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Jul 2025 17:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6B11891745
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Jul 2025 15:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2613E156677;
	Fri,  4 Jul 2025 15:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N2OUUvjM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F311010942;
	Fri,  4 Jul 2025 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751642177; cv=none; b=RBiQCWmiYAa7r/RjsaBGiYEAETwT4AMsUgfMz68nJYEaIX/cNyxq5ExOEgDpPEfjWj0ga0iBLnBt00kA5qvKGrvemQDMcWl/Uf7i2r8MaWGi6p8rJaOAzn9l6awt0n/XaiIOs27iQyrJqPyNNoLqavZK1OvPC1SSlw1kPamBkyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751642177; c=relaxed/simple;
	bh=fdncFe+kRLkLN8JKby0Zgs6+T99Ms/eQIw5jZsqT9Ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNUetQEqIqYmpN8uMOOjsXs8RV22fr0jiFIfxtPnEUG5nvPkuD1Wdsn8u94VpAMf/lMq/Qw/gGCfyfJuk6SfG5zTNNBk8q9xhGEUxiZMj299y5P6RsLEtC1WRhBYZfCt4H6eA26BA1RTcSE3iy+lV28KlHTFzUT2jNJPYmbzZfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N2OUUvjM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73289C4CEE3;
	Fri,  4 Jul 2025 15:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751642176;
	bh=fdncFe+kRLkLN8JKby0Zgs6+T99Ms/eQIw5jZsqT9Ys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N2OUUvjMt2UqsDufh8VcCyObOPhay8lZQM3h1uFbdqHCFtkKcWgi6Gnl8J0DI8qPC
	 G5c6/M+LtmppkfVtj2PrpCzSI9ysYowncS7Cg5/ZyFxrRxkm9qfEOwaegiYBdEvjJN
	 /g8n/39NKKy2HEvbXjUOo6uIyT4gi73ds2GUTHAhR1K0NlzXdz3pLD9mLTCKwpFYzT
	 ZgarzHmuS1vFs8ZkOxXw2oP6zSyRKf9viUMhEv/A5y28r5WQcealVVksLSqpJhEGWr
	 Ay3MoeBIMY4NF/p94veWNytGWNdZKaAlc7vVnRRTrl5WQ4iIlDOd6jvycPSOfgzJ5E
	 zHJATaoA5UIuQ==
Date: Fri, 4 Jul 2025 18:16:13 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: "Orlov, Ivan" <iorlov@amazon.co.uk>,
	"peterhuewe@gmx.de" <peterhuewe@gmx.de>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Woodhouse, David" <dwmw@amazon.co.uk>
Subject: Re: [PATCH v2] tpm: Fix the timeout & use ktime
Message-ID: <aGfwPbMZf-SHshXH@kernel.org>
References: <20250620180828.98413-1-iorlov@amazon.com>
 <aFhtKrWTDzZbpTSh@earth.li>
 <aFwnG--lzZO0mQgc@kernel.org>
 <aGeYqQG15lb2_NaU@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGeYqQG15lb2_NaU@earth.li>

On Fri, Jul 04, 2025 at 10:02:33AM +0100, Jonathan McDowell wrote:
> On Wed, Jun 25, 2025 at 07:43:07PM +0300, Jarkko Sakkinen wrote:
> > On Sun, Jun 22, 2025 at 09:52:58PM +0100, Jonathan McDowell wrote:
> > > On Fri, Jun 20, 2025 at 06:08:31PM +0000, Orlov, Ivan wrote:
> > > > The current implementation of timeout detection works in the following
> > > > way:
> > > >
> > > > 1. Read completion status. If completed, return the data
> > > > 2. Sleep for some time (usleep_range)
> > > > 3. Check for timeout using current jiffies value. Return an error if
> > > >   timed out
> > > > 4. Goto 1
> > > >
> > > > usleep_range doesn't guarantee it's always going to wake up strictly in
> > > > (min, max) range, so such a situation is possible:
> > > >
> > > > 1. Driver reads completion status. No completion yet
> > > > 2. Process sleeps indefinitely. In the meantime, TPM responds
> > > > 3. We check for timeout without checking for the completion again.
> > > >   Result is lost.
> > > >
> > > > Such a situation also happens for the guest VMs: if vCPU goes to sleep
> > > > and doesn't get scheduled for some time, the guest TPM driver will
> > > > timeout instantly after waking up without checking for the completion
> > > > (which may already be in place).
> > > >
> > > > Perform the completion check once again after exiting the busy loop in
> > > > order to give the device the last chance to send us some data.
> > > >
> > > > Since now we check for completion in two places, extract this check into
> > > > a separate function.
> > > >
> > > > Signed-off-by: Ivan Orlov <iorlov@amazon.com>
> > > > ---
> > > > V1 -> V2:
> > > > - Exclude the jiffies -> ktime change from the patch
> > > > - Instead of recording the time before checking for completion, check
> > > >  for completion once again after leaving the loop
> > > >
> > > > drivers/char/tpm/tpm-interface.c | 17 +++++++++++++++--
> > > > 1 file changed, 15 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> > > > index 8d7e4da6ed53..6960ee2798e1 100644
> > > > --- a/drivers/char/tpm/tpm-interface.c
> > > > +++ b/drivers/char/tpm/tpm-interface.c
> > > > @@ -82,6 +82,13 @@ static bool tpm_chip_req_canceled(struct tpm_chip *chip, u8 status)
> > > > 	return chip->ops->req_canceled(chip, status);
> > > > }
> > > >
> > > > +static bool tpm_transmit_completed(struct tpm_chip *chip)
> > > > +{
> > > > +	u8 status_masked = tpm_chip_status(chip) & chip->ops->req_complete_mask;
> > > > +
> > > > +	return status_masked == chip->ops->req_complete_val;
> > > > +}
> > > > +
> > > > static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
> > > > {
> > > > 	struct tpm_header *header = buf;
> > > > @@ -129,8 +136,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
> > > > 	stop = jiffies + tpm_calc_ordinal_duration(chip, ordinal);
> > > > 	do {
> > > > 		u8 status = tpm_chip_status(chip);
> > > > -		if ((status & chip->ops->req_complete_mask) ==
> > > > -		    chip->ops->req_complete_val)
> > > > +		if (tpm_transmit_completed(chip))
> > > > 			goto out_recv;
> > > 
> > > The only thing I'd point out here is we end up doing a double status read
> > > one after the other (once here, once in tpm_transmit_completed), and I'm
> > > pretty sure I've seen instances where that caused a problem.
> > 
> > It would be easy to to prevent at least double reads after completion
> > e.g., in tpm_chip_status():
> 
> Or just take the simple approach and make the check after the while loop:
> 
> 	if ((tpm_chip_status(chip) & chip->ops->req_complete_mask) ==
> 	    chip->ops->req_complete_val)
> 		goto out_recv;
> 
> There might be potential for a longer term cleanup using chip->status to
> cache things, but I'm little concerned that's going to open paths where we
> might not correctly update it, so I think it should be a separate piece.
> 
> (I'm motivated by the fact we've started to see the "Operation Canceled"
> error and I'd like us to close on the best way to fix it. :) )

This would work for me too!

Please send a new version if you feel like it but next week I won't be
reviewing that as I'm on holiday.

> 
> J.
> -- 
> I am afraid of the dark.

BR, Jarkko

