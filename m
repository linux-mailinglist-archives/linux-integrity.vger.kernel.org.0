Return-Path: <linux-integrity+bounces-6419-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DF4AD5CCA
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jun 2025 19:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2D437AA9CD
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jun 2025 17:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A2014A627;
	Wed, 11 Jun 2025 17:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYu596wr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984175D8F0;
	Wed, 11 Jun 2025 17:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749661355; cv=none; b=QRLM7CfaQ+PLaNxJ1qTJeiTMaIjwNLGSJd7DreHJDO0ubbN3XTmEJqSYj46s6lJeWbTNfff5lGFCpix77hje2LsMGxN7LMd88OEguDborwCOPz6JOwwWsXxkDZbHpf4kMxPJYFyCKM8kS4nYEhOan269JCkHYAKHNGUKR+Xo0PQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749661355; c=relaxed/simple;
	bh=gie/APWznz/rqti+SiC/QQqE38KI/nINDEoN4pe6EyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oh1VlLho0qhkKUtu1wqFm9uJ6nfCZN42A0FJaBE58XOhWBEzmC3TlYFInEvDFGgk097gHs9f7PwPPnAwal8CjaJ49aSVS0m0wt58cUgJHYhc/cJ2hEdHKCi4medVYR51CSKBO8lsx9EnNAbPgn3pMkul+jAX6qIIf70dK5WYDTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYu596wr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6A9C4CEE3;
	Wed, 11 Jun 2025 17:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749661355;
	bh=gie/APWznz/rqti+SiC/QQqE38KI/nINDEoN4pe6EyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VYu596wrqAmov+UwB2AFK/pm9Oy304elurt69CnojeWCH4aczHijnRQV0w5PIQ+4n
	 NJ85Kfojz4OOMGchlgNqWLEpDjHEcfsKubUMmoLqLzmWGSvOLEO8MS9oGlz/jtvE1F
	 g2ohVolAm9f/dD5hxcZYMfKMqb1j/+lFweg7ncs8xJAzu4J6WEx50PKSdT7VRB/BKs
	 MDHYVKvs25iy2eT9DITOYdVFMwvlvZAWY5vsf6fA815B2YAB8fhaZyY0SfIcajZGf6
	 OAT5EG8NspReXDNtiuN0eZ/9kzSCz+01oGTZHGgFx5ttqbpMRhMA7ROYKsqqCpJiMQ
	 CTzdN2uw4vdAQ==
Date: Wed, 11 Jun 2025 20:02:31 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: "Orlov, Ivan" <iorlov@amazon.co.uk>
Cc: "peterhuewe@gmx.de" <peterhuewe@gmx.de>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Woodhouse, David" <dwmw@amazon.co.uk>
Subject: Re: [PATCH] tpm: Fix the timeout & use ktime
Message-ID: <aEm2p-2p3W3Xw5OU@kernel.org>
References: <20250611162508.85149-1-iorlov@amazon.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611162508.85149-1-iorlov@amazon.com>

On Wed, Jun 11, 2025 at 04:25:24PM +0000, Orlov, Ivan wrote:
> The current implementation of timeout detection works in the following
> way:
> 
> 1. Read completion status. If completed, return the data
> 2. Sleep for some time (usleep_range)
> 3. Check for timeout using current jiffies value. Return an error if
>    timed out
> 4. Goto 1
> 
> usleep_range doesn't guarantee it's always going to wake up strictly in
> (min, max) range, so such a situation is possible:
> 
> 1. Driver reads completion status. No completion yet
> 2. Process sleeps indefinitely. In the meantime, TPM responds
> 3. We check for timeout without checking for the completion again.
>    Result is lost.
> 
> Such a situation also happens for the guest VMs: if vCPU goes to sleep
> and doesn't get scheduled for some time, the guest TPM driver will
> timeout instantly after waking up without checking for the completion
> (which may already be in place).

Got it.

> 
> Instead, perform the check in the following way:
> 
> 1. Read the current timestamp
> 2. Read the completion status. If completed, return the result
> 3. Sleep
> 4. Check if the timestamp read at step 1 exceeds the timeout. Return
>    an error if it does
> 5. Goto 1
> 
> Also, use ktime instead of jiffes as a more reliable and precise timing
> source.

"also", i.e. a logically separate change which should be split up to
a separate patch.

> 
> Signed-off-by: Ivan Orlov <iorlov@amazon.com>
> ---
>  drivers/char/tpm/tpm-interface.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 8d7e4da6ed53..959330212a16 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -88,7 +88,8 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
>  	int rc;
>  	ssize_t len = 0;
>  	u32 count, ordinal;
> -	unsigned long stop;
> +	ktime_t timeout, curr_time;
> +	unsigned int ord_dur_us;
>  
>  	if (bufsiz < TPM_HEADER_SIZE)
>  		return -EINVAL;
> @@ -126,8 +127,16 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
>  	if (chip->flags & TPM_CHIP_FLAG_IRQ)
>  		goto out_recv;
>  
> -	stop = jiffies + tpm_calc_ordinal_duration(chip, ordinal);
> +	ord_dur_us = jiffies_to_usecs(tpm_calc_ordinal_duration(chip, ordinal));
> +	timeout = ktime_add_us(ktime_get(), ord_dur_us);
>  	do {
> +		/*
> +		 * Save the time of the completion check. This way even if CPU
> +		 * goes to sleep indefinitely on tpm_sleep, the driver will
> +		 * check for completion one more time instead of timing out
> +		 * instantly after waking up.
> +		 */
> +		curr_time = ktime_get();
>  		u8 status = tpm_chip_status(chip);
>  		if ((status & chip->ops->req_complete_mask) ==
>  		    chip->ops->req_complete_val)
> @@ -140,7 +149,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
>  
>  		tpm_msleep(TPM_TIMEOUT_POLL);
>  		rmb();
> -	} while (time_before(jiffies, stop));
> +	} while (ktime_before(curr_time, timeout));


Wouldn't it be simpler fix to just check completion after dropping out
of the loop?

	} while (time_before(jiffies, stop));

	if (tpm_transmit_completed(chip))
		goto out_recv;

And declare this before tpm_try_transmit():

static bool tpm_transmit_completed(struct tpm_chip *chip)
{
	u8 status = tpm_chip_status(chip);
	
	return (status & chip->ops->req_complete_mask) == chip->ops->req_complete_val;
}

>  
>  	tpm_chip_cancel(chip);
>  	dev_err(&chip->dev, "Operation Timed out\n");
> -- 
> 2.43.0
> 

BR, Jarkko

