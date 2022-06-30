Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA375626F2
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Jul 2022 01:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbiF3XSt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Jun 2022 19:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbiF3XSt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Jun 2022 19:18:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0933B1D;
        Thu, 30 Jun 2022 16:18:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B083B82D20;
        Thu, 30 Jun 2022 23:18:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7808C34115;
        Thu, 30 Jun 2022 23:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656631125;
        bh=Nr3CKmGZB57NzBUuiTYNFL4T5Qf4aowgFyby0BK2IJc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mvL3ra1E6zOFCz0vCFYOC1cqdlXPEV4+IlPdQHfHSv7NlIZXrklifGezzRJAYB6dr
         fYT/69413+aon/O4NMD0K5izQs1i7c1QArWjfv6+e0NCw8d87cM/0T+hCayW/F21hX
         YBE4peWDKa1RCW5zRzWkxvLrOTNIK0hACB74OZbYgJKEaU+8XgWNGxKJdUvHmhXR1y
         gA3rCXE1LUfmlVdG4U+jGkhM06dHsbpOiXSOpX6WZIrT7Zq20kpXiyrL+NQcLWoA1+
         OZUU5hegHNdWCgdfHz8Y7FJHo0sRQgHG1yWUXoY8Q4t+K/KMn2Gbny80yPQ9mU3gf0
         r+4zmTzG/PyWQ==
Date:   Fri, 1 Jul 2022 02:18:41 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com
Subject: Re: [PATCH v7 05/10] tpm, tpm_tis: Only handle supported interrupts
Message-ID: <Yr4vUSrShAWntLeP@kernel.org>
References: <20220629232653.1306735-1-LinoSanfilippo@gmx.de>
 <20220629232653.1306735-6-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629232653.1306735-6-LinoSanfilippo@gmx.de>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 30, 2022 at 01:26:48AM +0200, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> According to the TPM Interface Specification (TIS) support for "stsValid"
> and "commandReady" interrupts is only optional.
> This has to be taken into account when handling the interrupts in functions
> like wait_for_tpm_stat(). To determine the supported interrupts use the
> capability query.
> 
> Also adjust wait_for_tpm_stat() to only wait for interrupt reported status
> changes. After that process all the remaining status changes by polling
> the status register.
> 
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> Tested-by: Michael Niew??hner <linux@mniewoehner.de>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 119 +++++++++++++++++++-------------
>  drivers/char/tpm/tpm_tis_core.h |   1 +
>  2 files changed, 72 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 09d8f04cbc81..c13599e94ab6 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -53,41 +53,63 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
>  	long rc;
>  	u8 status;
>  	bool canceled = false;
> +	u8 sts_mask = 0;
> +	int ret = 0;
>  
>  	/* check current status */
>  	status = chip->ops->status(chip);
>  	if ((status & mask) == mask)
>  		return 0;
>  
> -	stop = jiffies + timeout;
> +	/* check which status changes can be handled by irqs */
> +	if (priv->int_mask & TPM_INTF_STS_VALID_INT)
> +		sts_mask |= TPM_STS_VALID;
>  
> -	if (chip->flags & TPM_CHIP_FLAG_IRQ) {
> +	if (priv->int_mask & TPM_INTF_DATA_AVAIL_INT)
> +		sts_mask |= TPM_STS_DATA_AVAIL;
> +
> +	if (priv->int_mask & TPM_INTF_CMD_READY_INT)
> +		sts_mask |= TPM_STS_COMMAND_READY;
> +
> +	sts_mask &= mask;
> +
> +	stop = jiffies + timeout;
> +	/* process status changes with irq support */
> +	if (sts_mask) {
> +		ret = -ETIME;
>  again:
>  		timeout = stop - jiffies;
>  		if ((long)timeout <= 0)
>  			return -ETIME;
>  		rc = wait_event_interruptible_timeout(*queue,
> -			wait_for_tpm_stat_cond(chip, mask, check_cancel,
> +			wait_for_tpm_stat_cond(chip, sts_mask, check_cancel,
>  					       &canceled),
>  			timeout);
>  		if (rc > 0) {
>  			if (canceled)
>  				return -ECANCELED;
> -			return 0;
> +			ret = 0;
>  		}
>  		if (rc == -ERESTARTSYS && freezing(current)) {
>  			clear_thread_flag(TIF_SIGPENDING);
>  			goto again;
>  		}
> -	} else {
> -		do {
> -			usleep_range(priv->timeout_min,
> -				     priv->timeout_max);
> -			status = chip->ops->status(chip);
> -			if ((status & mask) == mask)
> -				return 0;
> -		} while (time_before(jiffies, stop));
>  	}
> +
> +	if (ret)
> +		return ret;
> +
> +	mask &= ~sts_mask;
> +	if (!mask) /* all done */
> +		return 0;
> +	/* process status changes without irq support */
> +	do {
> +		status = chip->ops->status(chip);
> +		if ((status & mask) == mask)
> +			return 0;
> +		usleep_range(priv->timeout_min,
> +			     priv->timeout_max);
> +	} while (time_before(jiffies, stop));
>  	return -ETIME;
>  }
>  
> @@ -1007,8 +1029,39 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  	if (rc < 0)
>  		goto out_err;
>  
> -	intmask |= TPM_INTF_CMD_READY_INT | TPM_INTF_LOCALITY_CHANGE_INT |
> -		   TPM_INTF_DATA_AVAIL_INT | TPM_INTF_STS_VALID_INT;
> +	/* Figure out the capabilities */
> +	rc = tpm_tis_read32(priv, TPM_INTF_CAPS(priv->locality), &intfcaps);
> +	if (rc < 0)
> +		goto out_err;
> +
> +	dev_dbg(dev, "TPM interface capabilities (0x%x):\n",
> +		intfcaps);
> +	if (intfcaps & TPM_INTF_BURST_COUNT_STATIC)
> +		dev_dbg(dev, "\tBurst Count Static\n");
> +	if (intfcaps & TPM_INTF_CMD_READY_INT) {
> +		intmask |= TPM_INTF_CMD_READY_INT;
> +		dev_dbg(dev, "\tCommand Ready Int Support\n");
> +	}
> +	if (intfcaps & TPM_INTF_INT_EDGE_FALLING)
> +		dev_dbg(dev, "\tInterrupt Edge Falling\n");
> +	if (intfcaps & TPM_INTF_INT_EDGE_RISING)
> +		dev_dbg(dev, "\tInterrupt Edge Rising\n");
> +	if (intfcaps & TPM_INTF_INT_LEVEL_LOW)
> +		dev_dbg(dev, "\tInterrupt Level Low\n");
> +	if (intfcaps & TPM_INTF_INT_LEVEL_HIGH)
> +		dev_dbg(dev, "\tInterrupt Level High\n");
> +	if (intfcaps & TPM_INTF_LOCALITY_CHANGE_INT)
> +		intmask |= TPM_INTF_LOCALITY_CHANGE_INT;
> +		dev_dbg(dev, "\tLocality Change Int Support\n");
> +	if (intfcaps & TPM_INTF_STS_VALID_INT) {
> +		intmask |= TPM_INTF_STS_VALID_INT;
> +		dev_dbg(dev, "\tSts Valid Int Support\n");
> +	}
> +	if (intfcaps & TPM_INTF_DATA_AVAIL_INT) {
> +		intmask |= TPM_INTF_DATA_AVAIL_INT;
> +		dev_dbg(dev, "\tData Avail Int Support\n");
> +	}
> +
>  	intmask &= ~TPM_GLOBAL_INT_ENABLE;
>  
>  	rc = request_locality(chip, 0);
> @@ -1042,32 +1095,6 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  		goto out_err;
>  	}
>  
> -	/* Figure out the capabilities */
> -	rc = tpm_tis_read32(priv, TPM_INTF_CAPS(priv->locality), &intfcaps);
> -	if (rc < 0)
> -		goto out_err;
> -
> -	dev_dbg(dev, "TPM interface capabilities (0x%x):\n",
> -		intfcaps);
> -	if (intfcaps & TPM_INTF_BURST_COUNT_STATIC)
> -		dev_dbg(dev, "\tBurst Count Static\n");
> -	if (intfcaps & TPM_INTF_CMD_READY_INT)
> -		dev_dbg(dev, "\tCommand Ready Int Support\n");
> -	if (intfcaps & TPM_INTF_INT_EDGE_FALLING)
> -		dev_dbg(dev, "\tInterrupt Edge Falling\n");
> -	if (intfcaps & TPM_INTF_INT_EDGE_RISING)
> -		dev_dbg(dev, "\tInterrupt Edge Rising\n");
> -	if (intfcaps & TPM_INTF_INT_LEVEL_LOW)
> -		dev_dbg(dev, "\tInterrupt Level Low\n");
> -	if (intfcaps & TPM_INTF_INT_LEVEL_HIGH)
> -		dev_dbg(dev, "\tInterrupt Level High\n");
> -	if (intfcaps & TPM_INTF_LOCALITY_CHANGE_INT)
> -		dev_dbg(dev, "\tLocality Change Int Support\n");
> -	if (intfcaps & TPM_INTF_STS_VALID_INT)
> -		dev_dbg(dev, "\tSts Valid Int Support\n");
> -	if (intfcaps & TPM_INTF_DATA_AVAIL_INT)
> -		dev_dbg(dev, "\tData Avail Int Support\n");
> -
>  	/* INTERRUPT Setup */
>  	init_waitqueue_head(&priv->read_queue);
>  	init_waitqueue_head(&priv->int_queue);
> @@ -1098,7 +1125,9 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  		else
>  			tpm_tis_probe_irq(chip, intmask);
>  
> -		if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
> +		if (chip->flags & TPM_CHIP_FLAG_IRQ) {
> +			priv->int_mask = intmask;
> +		} else {
>  			dev_err(&chip->dev, FW_BUG
>  					"TPM interrupt not working, polling instead\n");
>  
> @@ -1145,13 +1174,7 @@ static void tpm_tis_reenable_interrupts(struct tpm_chip *chip)
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
> +	intmask = priv->int_mask | TPM_GLOBAL_INT_ENABLE;
>  
>  	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
>  
> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
> index bf07379dea42..e005eb99480e 100644
> --- a/drivers/char/tpm/tpm_tis_core.h
> +++ b/drivers/char/tpm/tpm_tis_core.h
> @@ -93,6 +93,7 @@ struct tpm_tis_data {
>  	u16 manufacturer_id;
>  	int locality;
>  	int irq;
> +	unsigned int int_mask;
>  	unsigned long flags;
>  	void __iomem *ilb_base_addr;
>  	u16 clkrun_enabled;
> -- 
> 2.25.1
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
