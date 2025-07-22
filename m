Return-Path: <linux-integrity+bounces-6700-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F990B0E728
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Jul 2025 01:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 016151CC152D
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Jul 2025 23:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF6228B519;
	Tue, 22 Jul 2025 23:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSlFjeEQ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0594E28B50B;
	Tue, 22 Jul 2025 23:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753226582; cv=none; b=VgX5q6fyRG7aHUbq4j/6w1iX8LdfXZiyul+DQtUZqeQD9yz7l48wbyAeyOxgvZZQifMKXxcp0V1UjuOA3jPNPS/ZaulfQGEaEKmU6LjVegwHGuwbmf4xOhWrabP0nBLX2PpJ/jzAHw2D2wXkk4mnegMgaJfE4dSQ3ldKdDsBbrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753226582; c=relaxed/simple;
	bh=HBLhn20/CLD1HW+c4eQLNkCqvP+zMCJHSADkazYo/TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJUksgj8AKn1hrZ+qsfiD9mzgRVRbvXrv2lAQqwOKwnsifcsJTlJ8VN2w58Hou99SVzLmSYrBe0sOOrRG71Fc06ElSugohUpDvwrZVKPXBR9jG5C4xOa7H8BKsFZna6PJKbCNYbm0ABkWZ8gNHY/MUEnNXdCiJS5vw50zbqLxME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSlFjeEQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB14C4CEEB;
	Tue, 22 Jul 2025 23:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753226581;
	bh=HBLhn20/CLD1HW+c4eQLNkCqvP+zMCJHSADkazYo/TE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mSlFjeEQyq0Iya5iWLRfZDWYFkgzzHRZg13eVHUniYERawrujSVB3lP0GvqyePOEG
	 gJv3hipmL+P8tlQQNlhn+OXTZdrB8zsSO5ziEIrIDMgreAEfl6vJIPX8jNzd1BbwRi
	 jj5RR0dqYNtq+232GTfHu8A4H9T1Fe/CSjFqbSVssfti+tdmImi2bkdmopoFe6bpPq
	 2lKmghEbpafXFRVQb3ilSVACCd4z/pe1XQ0jqZuSQKX0BlXQawJUHRb9dIs1hC5XfU
	 IrScIcrQ2P1XzJAJfI2v9jd0WNZResdGQYBS34rzJkHRKojmhcCmgBpDg/fclRLQj2
	 nS8Fu+z4DQYTQ==
Date: Wed, 23 Jul 2025 02:22:57 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Ivan Orlov <ivan.orlov0322@gmail.com>
Cc: peterhuewe@gmx.de, iorlov@amazon.co.uk, jgg@ziepe.ca,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	dwmw@amazon.co.uk, noodles@earth.li
Subject: Re: [PATCH v3] tpm: Check for completion after timeout
Message-ID: <aIAdUQGwyTEL9IrI@kernel.org>
References: <20250719201340.24447-1-ivan.orlov0322@gmail.com>
 <aIAcWFGjWEViwwh6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIAcWFGjWEViwwh6@kernel.org>

On Wed, Jul 23, 2025 at 02:18:52AM +0300, Jarkko Sakkinen wrote:
> On Sat, Jul 19, 2025 at 08:13:39PM +0000, Ivan Orlov wrote:
> > The current implementation of timeout detection works in the following
> > way:
> > 
> > 1. Read completion status. If completed, return the data
> > 2. Sleep for some time (usleep_range)
> > 3. Check for timeout using current jiffies value. Return an error if
> >    timed out
> > 4. Goto 1
> > 
> > usleep_range doesn't guarantee it's always going to wake up strictly in
> > (min, max) range, so such a situation is possible:
> > 
> > 1. Driver reads completion status. No completion yet
> > 2. Process sleeps indefinitely. In the meantime, TPM responds
> > 3. We check for timeout without checking for the completion again.
> >    Result is lost.
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
> > Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> > ---
> > V1 -> V2:
> > - Exclude the jiffies -> ktime change from the patch
> > - Instead of recording the time before checking for completion, check
> >   for completion once again after leaving the loop
> > V2 -> V3:
> > - Avoid reading the chip status twice in the inner loop by passing
> >   status into tpm_transmit_completed
> > 
> >  drivers/char/tpm/tpm-interface.c | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> > index 8d7e4da6ed53..8d18b33aa62d 100644
> > --- a/drivers/char/tpm/tpm-interface.c
> > +++ b/drivers/char/tpm/tpm-interface.c
> > @@ -82,6 +82,13 @@ static bool tpm_chip_req_canceled(struct tpm_chip *chip, u8 status)
> >  	return chip->ops->req_canceled(chip, status);
> >  }
> >  
> > +static bool tpm_transmit_completed(u8 status, struct tpm_chip *chip)
> > +{
> > +	u8 status_masked = status & chip->ops->req_complete_mask;
> > +
> > +	return status_masked == chip->ops->req_complete_val;
> > +}
> > +
> >  static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
> >  {
> >  	struct tpm_header *header = buf;
> > @@ -129,8 +136,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
> >  	stop = jiffies + tpm_calc_ordinal_duration(chip, ordinal);
> >  	do {
> >  		u8 status = tpm_chip_status(chip);
> > -		if ((status & chip->ops->req_complete_mask) ==
> > -		    chip->ops->req_complete_val)
> > +		if (tpm_transmit_completed(status, chip))
> >  			goto out_recv;
> >  
> >  		if (tpm_chip_req_canceled(chip, status)) {
> > @@ -142,6 +148,13 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
> >  		rmb();
> >  	} while (time_before(jiffies, stop));
> >  
> > +	/*
> > +	 * Check for completion one more time, just in case the device reported
> > +	 * it while the driver was sleeping in the busy loop above.
> > +	 */
> > +	if (tpm_transmit_completed(tpm_chip_status(chip), chip))
> > +		goto out_recv;
> > +
> >  	tpm_chip_cancel(chip);
> >  	dev_err(&chip->dev, "Operation Timed out\n");
> >  	return -ETIME;
> > -- 
> > 2.43.0
> > 
> 
> I guess this is completed too by now ...
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Just saying (i.e. I will fix it up): s/Reviewed-By/Reviewed-by/g ;-)

checkpatch.pl does scream about this but yeah not a huge deal!

BR, Jarkko

