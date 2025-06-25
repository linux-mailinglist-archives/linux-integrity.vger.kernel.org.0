Return-Path: <linux-integrity+bounces-6522-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35482AE8A91
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jun 2025 18:48:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D883C3B9975
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jun 2025 16:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40DF2E717B;
	Wed, 25 Jun 2025 16:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIZQoXRj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85012D6620;
	Wed, 25 Jun 2025 16:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750869791; cv=none; b=rTe5e68GD4dh5SjSbbLFTcLrcoZ3b4Mx7JnLIfw0DlkGa5lLbaYK6gDZoWyRuX9o93O2n2EjC1DUBRaTv1GDUfzyXG2HpeuX0v6oHaOwRPyX47MFsJfT+HLGpnQAGROPmit29GuFX10jh82pa5f0VrGuRyoisDhOdDK4CWKS1Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750869791; c=relaxed/simple;
	bh=cGUv2CNBzq8vRhYQyXdVewQNEc85rFT6i3y9uZ6djqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVcIBNDFWZTzQ/WdDJ9ru/Av54CcAkr/Kn4xiHIlzMSrWZl7m9+OM/iz/iPABGLyObsgVrzysqmkCtL5b0ru5gyXeuNAKo5CQFiZJLT0tvVQnQWbIsNasVYPgozq9/BDOFpyb2tW8YIxv0ZL6dHYjWL25/L59FZfc5KQD67BAhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIZQoXRj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8898C4CEEA;
	Wed, 25 Jun 2025 16:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750869791;
	bh=cGUv2CNBzq8vRhYQyXdVewQNEc85rFT6i3y9uZ6djqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GIZQoXRjPJf7bB9nJwnxXrptTu7KAo3FIQNN/Qx3re80R0ixpmIIcKBYMXjFCjUYA
	 j43xvw+D4pOPKMacA08z8ulicpCdbAd6bTcAGGGEzNPS3c7wJzraRzFRLOLZLP+TrS
	 jTeVaHd0rWrr0EuC8p7EmHgsxw9LDe6eToUPBqLuj8BHWUvnEg2bIcWvCAN9jPAno6
	 6SoixPbKPkFBb2PHl4RU4FQ98JrfsPd9c4CeyWnTvRBOPq+mYyrETHwXfvnvY/6diA
	 sY2eWe7D5VJ8BPnpwcXRhMPHiGTKqZlbcLGxdTrwCbeZD6q3/4UWeOtORMAL45UzL5
	 puI38zYxf1UJA==
Date: Wed, 25 Jun 2025 19:43:07 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: "Orlov, Ivan" <iorlov@amazon.co.uk>,
	"peterhuewe@gmx.de" <peterhuewe@gmx.de>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Woodhouse, David" <dwmw@amazon.co.uk>
Subject: Re: [PATCH v2] tpm: Fix the timeout & use ktime
Message-ID: <aFwnG--lzZO0mQgc@kernel.org>
References: <20250620180828.98413-1-iorlov@amazon.com>
 <aFhtKrWTDzZbpTSh@earth.li>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFhtKrWTDzZbpTSh@earth.li>

On Sun, Jun 22, 2025 at 09:52:58PM +0100, Jonathan McDowell wrote:
> On Fri, Jun 20, 2025 at 06:08:31PM +0000, Orlov, Ivan wrote:
> > The current implementation of timeout detection works in the following
> > way:
> > 
> > 1. Read completion status. If completed, return the data
> > 2. Sleep for some time (usleep_range)
> > 3. Check for timeout using current jiffies value. Return an error if
> >   timed out
> > 4. Goto 1
> > 
> > usleep_range doesn't guarantee it's always going to wake up strictly in
> > (min, max) range, so such a situation is possible:
> > 
> > 1. Driver reads completion status. No completion yet
> > 2. Process sleeps indefinitely. In the meantime, TPM responds
> > 3. We check for timeout without checking for the completion again.
> >   Result is lost.
> > 
> > Such a situation also happens for the guest VMs: if vCPU goes to sleep
> > and doesn't get scheduled for some time, the guest TPM driver will
> > timeout instantly after waking up without checking for the completion
> > (which may already be in place).
> > 
> > Perform the completion check once again after exiting the busy loop in
> > order to give the device the last chance to send us some data.
> > 
> > Since now we check for completion in two places, extract this check into
> > a separate function.
> > 
> > Signed-off-by: Ivan Orlov <iorlov@amazon.com>
> > ---
> > V1 -> V2:
> > - Exclude the jiffies -> ktime change from the patch
> > - Instead of recording the time before checking for completion, check
> >  for completion once again after leaving the loop
> > 
> > drivers/char/tpm/tpm-interface.c | 17 +++++++++++++++--
> > 1 file changed, 15 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> > index 8d7e4da6ed53..6960ee2798e1 100644
> > --- a/drivers/char/tpm/tpm-interface.c
> > +++ b/drivers/char/tpm/tpm-interface.c
> > @@ -82,6 +82,13 @@ static bool tpm_chip_req_canceled(struct tpm_chip *chip, u8 status)
> > 	return chip->ops->req_canceled(chip, status);
> > }
> > 
> > +static bool tpm_transmit_completed(struct tpm_chip *chip)
> > +{
> > +	u8 status_masked = tpm_chip_status(chip) & chip->ops->req_complete_mask;
> > +
> > +	return status_masked == chip->ops->req_complete_val;
> > +}
> > +
> > static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
> > {
> > 	struct tpm_header *header = buf;
> > @@ -129,8 +136,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
> > 	stop = jiffies + tpm_calc_ordinal_duration(chip, ordinal);
> > 	do {
> > 		u8 status = tpm_chip_status(chip);
> > -		if ((status & chip->ops->req_complete_mask) ==
> > -		    chip->ops->req_complete_val)
> > +		if (tpm_transmit_completed(chip))
> > 			goto out_recv;
> 
> The only thing I'd point out here is we end up doing a double status read
> one after the other (once here, once in tpm_transmit_completed), and I'm
> pretty sure I've seen instances where that caused a problem.

It would be easy to to prevent at least double reads after completion
e.g., in tpm_chip_status():

/*
 * Read the chip status bitmask. After completion, the returned will mask will
 * return value cached at the point of completion up until the next transmit.
 */
static u8 tpm_chip_status(struct tpm_chip *chip)
{
	u8 status_masked = chip->status & chip->ops_req_complete_mask;

	if (status_masked == chip->ops->req_complete_val)
		return chip->status;

	chip->status = tpm_chip_status(chip);

	return chip->status;
}

I think tpm_chip_status() should be the gatekeeper for such event, or
like the correct layer of abstraction here ...

Then just reset chip->status to zero at the beginning of tpm_try_transmit().

BR, Jarkko

