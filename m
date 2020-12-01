Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D122CAA92
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Dec 2020 19:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404274AbgLASOZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Dec 2020 13:14:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59564 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404272AbgLASOY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Dec 2020 13:14:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606846376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xG8YkW0PrbTHFtBLz08Sb5iV4/R6ix3ZMzpAuZrWhHs=;
        b=cT6uqBKZS8NQtzdq0UFJyXAdwB2J/Bdpxsio49hVmUqtH4BhAef4W77ZbGr94hR3mZMmm3
        j/Cfkn5EY5lRABH33tvYgPkmkZyHAqFAC9GyYXk51q0a/Cxy6OVOB4hWbEXQTo2+TTRDou
        RtfSawNQsImW0Kncgi1oj/gjt9QAyLo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-h0eQTqagN2Gga3sN6pShcA-1; Tue, 01 Dec 2020 13:12:55 -0500
X-MC-Unique: h0eQTqagN2Gga3sN6pShcA-1
Received: by mail-qk1-f198.google.com with SMTP id x196so2035485qkb.12
        for <linux-integrity@vger.kernel.org>; Tue, 01 Dec 2020 10:12:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=xG8YkW0PrbTHFtBLz08Sb5iV4/R6ix3ZMzpAuZrWhHs=;
        b=taYg+1h/0eTkkjoMG9ixPeUDr0oZhHRrDC8mu7D00xLGtJL7ArAfPr3UdlRZuGfjpX
         fGNn9l9TPXrOfibowEJfBrZNJNzmU/CNIBHHfKHuO9eYlYkLUuvDxLeJikgU6AEj4a3v
         tJXOhnL4PRReN2SPu8irAFYosD/ICnX6UYE2pceNQ2tTv89eGbq4jAm1XQKjtCKFGBHi
         idDp+Hdn3iF1qg011TMXlNZxpn8eCQBm+TqwfhHoHtY4AmQRs3fi+2/OpUeaiFStbZGj
         th0ex8ypzHzwDu6YHfsQCRazFTp9NXzq5cGuT9zfZLLZ9W+S3AmWQGDIDXrFZ13mhR4p
         eVJA==
X-Gm-Message-State: AOAM530oQPMYS+YcGn5OyBPkOPtI3ecsmOSqmM63smJA0PFNvrDqvPoo
        N5Uv/FZxjMSFz8l2GV91tMxj+w14P09piEALqobQNTwOkKqZYszJINwGmxPZAgREEbIA7TZ3E9O
        iTrq3mhyqkMr74WL0JzDbNUM1EDZZ
X-Received: by 2002:aed:31c5:: with SMTP id 63mr4244982qth.367.1606846374954;
        Tue, 01 Dec 2020 10:12:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwCd8bXhFk6x21DuWwoVFOXPxKpJuXkRSaGH0KXEeipEKmNNob+xzPRJzZIdZFlbQGQlz8vNA==
X-Received: by 2002:aed:31c5:: with SMTP id 63mr4244955qth.367.1606846374639;
        Tue, 01 Dec 2020 10:12:54 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id z8sm365143qti.22.2020.12.01.10.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 10:12:53 -0800 (PST)
References: <20201001180925.13808-1-James.Bottomley@HansenPartnership.com>
 <20201001180925.13808-4-James.Bottomley@HansenPartnership.com>
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v2 3/5] tpm_tis: Fix interrupts for TIS TPMs without
 legacy cycles
In-reply-to: <20201001180925.13808-4-James.Bottomley@HansenPartnership.com>
Date:   Tue, 01 Dec 2020 11:12:51 -0700
Message-ID: <87h7p5mm3g.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


James Bottomley @ 2020-10-01 11:09 MST:

> If a TIS TPM doesn't have legacy cycles, any write to the interrupt
> registers is ignored unless a locality is active.  This means even to
> set up the interrupt vectors a locality must first be activated.  Fix
> this by activating the 0 locality in the interrupt probe setup.
>
> Since the TPM_EOI signalling also requires an active locality, the
> interrupt routine cannot end an interrupt if the locality is released.
> This can lead to a situation where the TPM goes command ready after
> locality release and since the interrupt cannot be ended it refires
> continuously.  Fix this by disabling all interrupts except locality
> change when a locality is released (this only fires when a locality
> becomes active, meaning the TPM_EOI should work).
>
> Finally, since we now disable all status based interrupts in the
> locality release, they must be re-enabled before waiting to check the
> condition, so add interrupt enabling to the status wait.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>
> ---
>
> v2: renamed functions
> ---
>  drivers/char/tpm/tpm_tis_core.c | 125 ++++++++++++++++++++++++++------
>  1 file changed, 101 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 431919d5f48a..0c07da8cd680 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -29,6 +29,46 @@
>  
>  static void tpm_tis_clkrun_enable(struct tpm_chip *chip, bool value);
>  
> +static void tpm_tis_enable_interrupt(struct tpm_chip *chip, u8 mask)
> +{
> +	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> +	u32 intmask;
> +
> +	/* Take control of the TPM's interrupt hardware and shut it off */
> +	tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
> +
> +	intmask |= mask | TPM_GLOBAL_INT_ENABLE;
> +
> +	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
> +}
> +
> +static void tpm_tis_disable_interrupt(struct tpm_chip *chip, u8 mask)
> +{
> +	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> +	u32 intmask;
> +
> +	/* Take control of the TPM's interrupt hardware and shut it off */
> +	tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
> +
> +	intmask &= ~mask;
> +
> +	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
> +}
> +
> +static void tpm_tis_enable_stat_interrupts(struct tpm_chip *chip, u8 stat)
> +{
> +	u32 mask = 0;
> +
> +	if (stat & TPM_STS_COMMAND_READY)
> +		mask |= TPM_INTF_CMD_READY_INT;
> +	if (stat & TPM_STS_VALID)
> +		mask |= TPM_INTF_STS_VALID_INT;
> +	if (stat & TPM_STS_DATA_AVAIL)
> +		mask |= TPM_INTF_DATA_AVAIL_INT;
> +
> +	tpm_tis_enable_interrupt(chip, mask);
> +}
> +
>  static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8 mask,
>  					bool check_cancel, bool *canceled)
>  {
> @@ -65,11 +105,14 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
>  		timeout = stop - jiffies;
>  		if ((long)timeout <= 0)
>  			return -ETIME;
> +		tpm_tis_enable_stat_interrupts(chip, mask);
>  		rc = wait_event_interruptible_timeout(*queue,
>  			wait_for_tpm_stat_cond(chip, mask, check_cancel,
>  					       &canceled),
>  			timeout);
>  		if (rc > 0) {
> +			if (rc == 1)
> +				dev_err(&chip->dev, "Lost Interrupt waiting for TPM stat\n");

With my proposed patch to check for the interrupt storm condition I
sometimes see this message. Do you think it would make sense to have a
check here and in the request_locality location to see that
TPM_CHIP_FLAG is still enabled? It will print a message about the
interrupt storm being detected, and switching to polling, so I don't
know if this will cause confusion for people to have this show up as
well in that case.

>  			if (canceled)
>  				return -ECANCELED;
>  			return 0;
> @@ -138,6 +181,28 @@ static bool check_locality(struct tpm_chip *chip, int l)
>  static int release_locality(struct tpm_chip *chip, int l)
>  {
>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> +	u32 int_status;
> +	int rc;
> +
> +	/*
> +	 * Note that once we relinquish the locality, all writes to
> +	 * the interrupt registers become ineffective meaning we can't
> +	 * do a TPM_EOI.  This means we must disable every interrupt
> +	 * except the locality change one to avoid interrupt
> +	 * storms.
> +	 */
> +	tpm_tis_disable_interrupt(chip, TPM_INTF_CMD_READY_INT
> +				  | TPM_INTF_STS_VALID_INT
> +				  | TPM_INTF_DATA_AVAIL_INT);
> +
> +	rc = tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &int_status);
> +	if (rc < 0)
> +		return rc;
> +
> +	/* Clear all pending */
> +	rc = tpm_tis_write32(priv, TPM_INT_STATUS(priv->locality), int_status);
> +	if (rc < 0)
> +		return rc;
>  
>  	tpm_tis_write8(priv, TPM_ACCESS(l), TPM_ACCESS_ACTIVE_LOCALITY);
>  
> @@ -164,12 +229,17 @@ static int request_locality(struct tpm_chip *chip, int l)
>  		timeout = stop - jiffies;
>  		if ((long)timeout <= 0)
>  			return -1;
> +
>  		rc = wait_event_interruptible_timeout(priv->int_queue,
>  						      (check_locality
>  						       (chip, l)),
>  						      timeout);
> -		if (rc > 0)
> +		if (rc > 1)
> +			return l;
> +		if (rc == 1) {
> +			dev_info(&chip->dev, "Lost Interrupt waiting for locality\n");
>  			return l;
> +		}
>  		if (rc == -ERESTARTSYS && freezing(current)) {
>  			clear_thread_flag(TIF_SIGPENDING);
>  			goto again;
> @@ -465,6 +535,10 @@ static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
>  	irq = priv->irq;
>  	priv->irq = 0;
>  	chip->flags &= ~TPM_CHIP_FLAG_IRQ;
> +	tpm_tis_enable_interrupt(chip, TPM_INTF_CMD_READY_INT
> +				 | TPM_INTF_LOCALITY_CHANGE_INT
> +				 | TPM_INTF_DATA_AVAIL_INT
> +				 | TPM_INTF_STS_VALID_INT);
>  	rc = tpm_tis_send_main(chip, buf, len);
>  	priv->irq = irq;
>  	chip->flags |= TPM_CHIP_FLAG_IRQ;
> @@ -719,7 +793,7 @@ static int tpm_tis_gen_interrupt(struct tpm_chip *chip)
>   * irq is seen then leave the chip setup for IRQ operation, otherwise reverse
>   * everything and leave in polling mode. Returns 0 on success.
>   */
> -static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
> +static int tpm_tis_probe_irq_single(struct tpm_chip *chip,
>  				    int flags, int irq)
>  {
>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> @@ -753,9 +827,11 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
>  	if (rc < 0)
>  		return rc;
>  
> -	/* Turn on */
> -	rc = tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality),
> -			     intmask | TPM_GLOBAL_INT_ENABLE);
> +	/*
> +	 * Turn on.  The locality change interrupt is the only one
> +	 * always enabled
> +	 */
> +	tpm_tis_enable_interrupt(chip, TPM_INTF_LOCALITY_CHANGE_INT);
>  	if (rc < 0)
>  		return rc;
>  
> @@ -787,7 +863,7 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
>   * do not have ACPI/etc. We typically expect the interrupt to be declared if
>   * present.
>   */
> -static void tpm_tis_probe_irq(struct tpm_chip *chip, u32 intmask)
> +static void tpm_tis_probe_irq(struct tpm_chip *chip)
>  {
>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>  	u8 original_int_vec;
> @@ -801,11 +877,9 @@ static void tpm_tis_probe_irq(struct tpm_chip *chip, u32 intmask)
>  	if (!original_int_vec) {
>  		if (IS_ENABLED(CONFIG_X86))
>  			for (i = 3; i <= 15; i++)
> -				if (!tpm_tis_probe_irq_single(chip, intmask, 0,
> -							      i))
> +				if (!tpm_tis_probe_irq_single(chip, 0, i))
>  					return;
> -	} else if (!tpm_tis_probe_irq_single(chip, intmask, 0,
> -					     original_int_vec))
> +	} else if (!tpm_tis_probe_irq_single(chip, 0, original_int_vec))
>  		return;
>  }
>  
> @@ -1030,8 +1104,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  		}
>  
>  		if (irq) {
> -			tpm_tis_probe_irq_single(chip, intmask, IRQF_SHARED,
> -						 irq);
> +			tpm_tis_probe_irq_single(chip, IRQF_SHARED, irq);
>  			if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
>  				dev_err(&chip->dev, FW_BUG
>  					"TPM interrupt not working, polling instead\n");
> @@ -1039,7 +1112,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  				disable_interrupts(chip);
>  			}
>  		} else {
> -			tpm_tis_probe_irq(chip, intmask);
> +			tpm_tis_probe_irq(chip);
>  		}
>  	}
>  
> @@ -1065,12 +1138,23 @@ EXPORT_SYMBOL_GPL(tpm_tis_core_init);
>  static void tpm_tis_reenable_interrupts(struct tpm_chip *chip)
>  {
>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> -	u32 intmask;
>  	int rc;
>  
>  	if (chip->ops->clk_enable != NULL)
>  		chip->ops->clk_enable(chip, true);
>  
> +	/*
> +	 * must have the locality before we can enable interrupts, so
> +	 * poll for the locality being ready
> +	 */
> +	chip->flags &= ~TPM_CHIP_FLAG_IRQ;
> +	if (request_locality(chip, 0) != 0) {
> +		dev_err(&chip->dev, "Failed to enable interrupts after suspend\n");
> +		goto out;
> +	}
> +	chip->flags |= TPM_CHIP_FLAG_IRQ;
> +
> +
>  	/* reenable interrupts that device may have lost or
>  	 * BIOS/firmware may have disabled
>  	 */
> @@ -1078,17 +1162,10 @@ static void tpm_tis_reenable_interrupts(struct tpm_chip *chip)
>  	if (rc < 0)
>  		goto out;
>  
> -	rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
> -	if (rc < 0)
> -		goto out;
> -
> -	intmask |= TPM_INTF_CMD_READY_INT
> -	    | TPM_INTF_LOCALITY_CHANGE_INT | TPM_INTF_DATA_AVAIL_INT
> -	    | TPM_INTF_STS_VALID_INT | TPM_GLOBAL_INT_ENABLE;
> +	tpm_tis_enable_interrupt(chip, TPM_INTF_LOCALITY_CHANGE_INT);
>  
> -	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
> -
> -out:
> + out:
> +	release_locality(chip, 0);
>  	if (chip->ops->clk_enable != NULL)
>  		chip->ops->clk_enable(chip, false);


