Return-Path: <linux-integrity+bounces-6649-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F35B0AF9F
	for <lists+linux-integrity@lfdr.de>; Sat, 19 Jul 2025 13:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9050AA1F98
	for <lists+linux-integrity@lfdr.de>; Sat, 19 Jul 2025 11:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB2D2248B8;
	Sat, 19 Jul 2025 11:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eW9fNJZC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E2B33086;
	Sat, 19 Jul 2025 11:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752925076; cv=none; b=QSDqmZvFoB3f+pNli2cGF33A3LynuYmIU1acGRI0myye3malWupZpyCw0xgX3kaOnNaEfcY6j9VCcrzmDa6Vm23RZ2VqMPIrj0t6biMKKliCpq8f17f6OfPCsGX9OSJ4RsK572nIFB91tnpGoSlb5Qzw7/wDY5LSadRJT00Ydzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752925076; c=relaxed/simple;
	bh=WHImR9ml49rOWCFEslqOX+Ll5RQy1Y/vpMK7wGbnRrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mk9s86Hbokqdk+ROb2mTO3AMr8V1hU4tCgwU8pto+/Z0rq96L9QH8SBGzuoSntxYoj0EvxKmU+IecAJROJT2mh55PEyoO/ZgpRgUcRt2AD3Rb7Ktk2KOvn2Q1D7K55/FBzK6YhLWM03g602JIzduBvvoccG2UqVfAQa07/KxxoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eW9fNJZC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C10FC4CEE3;
	Sat, 19 Jul 2025 11:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752925075;
	bh=WHImR9ml49rOWCFEslqOX+Ll5RQy1Y/vpMK7wGbnRrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eW9fNJZCn0+MCDcGdnpSmUF5Vm7+TaQqaiHlaj/naBPXrRmZAljXoyiUwmJHhDtic
	 Q/3w9sMROeb/N3JjZKLphbTfuulzQX+RZ/OnReTzsqT8mHmrSfyBm1seEIC9zq9hsX
	 N3UtqMPddFs0qs27h6UHsImtbaGE4IMOaYiByL4uGHlxfQ2Ji5dCo6/ISk5kZYjtGK
	 EZaGxl2KUX/lWcbdOfqwIn4xgnWeOUsGBWl/79PYdprW2a8xiFPymDbeso8xpmI9in
	 n9L3CkoDX9pSwl3bp7Em1BCk6XEvbI5fCO3eXhPvarHQe3mCOPyVSBhEfDiTN1irU8
	 FTVhbAg5rZH5g==
Date: Sat, 19 Jul 2025 14:37:51 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: "Orlov, Ivan" <ivan.orlov0322@gmail.com>
Cc: Jonathan McDowell <noodles@earth.li>,
	"Orlov, Ivan" <iorlov@amazon.co.uk>,
	"peterhuewe@gmx.de" <peterhuewe@gmx.de>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Woodhouse, David" <dwmw@amazon.co.uk>
Subject: Re: [PATCH v2] tpm: Fix the timeout & use ktime
Message-ID: <aHuDj36Qa6iKsvkn@kernel.org>
References: <20250620180828.98413-1-iorlov@amazon.com>
 <aFhtKrWTDzZbpTSh@earth.li>
 <aFwnG--lzZO0mQgc@kernel.org>
 <aGeYqQG15lb2_NaU@earth.li>
 <aGfwPbMZf-SHshXH@kernel.org>
 <048723bf-4a8d-451a-911b-f9f94a4270d7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <048723bf-4a8d-451a-911b-f9f94a4270d7@gmail.com>

On Fri, Jul 04, 2025 at 04:39:20PM +0100, Orlov, Ivan wrote:
> On 04/07/2025 16:16, Jarkko Sakkinen wrote:
> > On Fri, Jul 04, 2025 at 10:02:33AM +0100, Jonathan McDowell wrote:
> > > On Wed, Jun 25, 2025 at 07:43:07PM +0300, Jarkko Sakkinen wrote:
> > > > On Sun, Jun 22, 2025 at 09:52:58PM +0100, Jonathan McDowell wrote:
> > > > > On Fri, Jun 20, 2025 at 06:08:31PM +0000, Orlov, Ivan wrote:
> > > > > > The current implementation of timeout detection works in the following
> > > > > > way:
> > > > > > 
> > > > > > 1. Read completion status. If completed, return the data
> > > > > > 2. Sleep for some time (usleep_range)
> > > > > > 3. Check for timeout using current jiffies value. Return an error if
> > > > > >    timed out
> > > > > > 4. Goto 1
> > > > > > 
> > > > > > usleep_range doesn't guarantee it's always going to wake up strictly in
> > > > > > (min, max) range, so such a situation is possible:
> > > > > > 
> > > > > > 1. Driver reads completion status. No completion yet
> > > > > > 2. Process sleeps indefinitely. In the meantime, TPM responds
> > > > > > 3. We check for timeout without checking for the completion again.
> > > > > >    Result is lost.
> > > > > > 
> > > > > > Such a situation also happens for the guest VMs: if vCPU goes to sleep
> > > > > > and doesn't get scheduled for some time, the guest TPM driver will
> > > > > > timeout instantly after waking up without checking for the completion
> > > > > > (which may already be in place).
> > > > > > 
> > > > > > Perform the completion check once again after exiting the busy loop in
> > > > > > order to give the device the last chance to send us some data.
> > > > > > 
> > > > > > Since now we check for completion in two places, extract this check into
> > > > > > a separate function.
> > > > > > 
> > > > > > Signed-off-by: Ivan Orlov <iorlov@amazon.com>
> > > > > > ---
> > > > > > V1 -> V2:
> > > > > > - Exclude the jiffies -> ktime change from the patch
> > > > > > - Instead of recording the time before checking for completion, check
> > > > > >   for completion once again after leaving the loop
> > > > > > 
> > > > > > drivers/char/tpm/tpm-interface.c | 17 +++++++++++++++--
> > > > > > 1 file changed, 15 insertions(+), 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> > > > > > index 8d7e4da6ed53..6960ee2798e1 100644
> > > > > > --- a/drivers/char/tpm/tpm-interface.c
> > > > > > +++ b/drivers/char/tpm/tpm-interface.c
> > > > > > @@ -82,6 +82,13 @@ static bool tpm_chip_req_canceled(struct tpm_chip *chip, u8 status)
> > > > > > 	return chip->ops->req_canceled(chip, status);
> > > > > > }
> > > > > > 
> > > > > > +static bool tpm_transmit_completed(struct tpm_chip *chip)
> > > > > > +{
> > > > > > +	u8 status_masked = tpm_chip_status(chip) & chip->ops->req_complete_mask;
> > > > > > +
> > > > > > +	return status_masked == chip->ops->req_complete_val;
> > > > > > +}
> > > > > > +
> > > > > > static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
> > > > > > {
> > > > > > 	struct tpm_header *header = buf;
> > > > > > @@ -129,8 +136,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
> > > > > > 	stop = jiffies + tpm_calc_ordinal_duration(chip, ordinal);
> > > > > > 	do {
> > > > > > 		u8 status = tpm_chip_status(chip);
> > > > > > -		if ((status & chip->ops->req_complete_mask) ==
> > > > > > -		    chip->ops->req_complete_val)
> > > > > > +		if (tpm_transmit_completed(chip))
> > > > > > 			goto out_recv;
> > > > > 
> > > > > The only thing I'd point out here is we end up doing a double status read
> > > > > one after the other (once here, once in tpm_transmit_completed), and I'm
> > > > > pretty sure I've seen instances where that caused a problem.
> > > > 
> > > > It would be easy to to prevent at least double reads after completion
> > > > e.g., in tpm_chip_status():
> > > 
> > > Or just take the simple approach and make the check after the while loop:
> > > 
> > > 	if ((tpm_chip_status(chip) & chip->ops->req_complete_mask) ==
> > > 	    chip->ops->req_complete_val)
> > > 		goto out_recv;
> > > 
> > > There might be potential for a longer term cleanup using chip->status to
> > > cache things, but I'm little concerned that's going to open paths where we
> > > might not correctly update it, so I think it should be a separate piece.
> > > 
> > > (I'm motivated by the fact we've started to see the "Operation Canceled"
> > > error and I'd like us to close on the best way to fix it. :) )
> > 
> > This would work for me too!
> > 
> 
> Hi, and sorry for the late reply :(
> 
> I believe this option would work for us as well. Please let me know whether
> you'd like me to send V3 or you feel free to send it yourself if you want.

Please send one more patch. I just came from holiday and now have
hands full backtracking last two weeks.

> 
> --
> Kind regards,
> Ivan Orlov

BR, Jarkko

