Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E140054D0D5
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jun 2022 20:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349054AbiFOSXw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jun 2022 14:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346397AbiFOSXs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jun 2022 14:23:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9E425294;
        Wed, 15 Jun 2022 11:23:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2D41B82130;
        Wed, 15 Jun 2022 18:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5D4C36AF2;
        Wed, 15 Jun 2022 18:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655317424;
        bh=zObHqLUh2Rncs2EFcgmp5EbS5j6sE7FLEKEpqYw7Hfc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QsaiN+I9lB+w/4rklbNVmHf5zAK8JOiTSNF8/RnIJtGn9TQ1HS1k56Yx/XpAbHiKN
         tFf2HYsMP4lTjsDkZhVhPD2p04kEo7swymPhPnHMgLX6kDSR7GzIo2xdEM/DKN/vAP
         0Q4Z1dogGiwlnM1I2d9S+9wHhVAnDiIBdAehKM+YN6kM+8BAM24aIVoUk9zg3E9Tei
         MvYyNiymrmLpmZkg6pRA3ooUK1OJ7EoACOvc6lC+Ov0XefhLdXhzI/MJsVrddfjv5G
         4Ke6J1h6uUNEDirIwdpuIGCed7W7+uLWDnr2RUlj8rWDjP42AdJcFc+N4jjrYT6xen
         /1gJfXcEWV5Uw==
Date:   Wed, 15 Jun 2022 21:21:34 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     LinoSanfilippo@gmx.de
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com
Subject: Re: [PATCH v5 06/10] tpm, tpm_tis: Only handle supported interrupts
 in wait_for_tpm_stat()
Message-ID: <YqojLqfoy2NXTTGV@iki.fi>
References: <20220610110846.8307-1-LinoSanfilippo@gmx.de>
 <20220610110846.8307-7-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610110846.8307-7-LinoSanfilippo@gmx.de>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 10, 2022 at 01:08:42PM +0200, LinoSanfilippo@gmx.de wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> According to the TPM Interface Specification (TIS) interrupts for
> "stsValid" and "commandReady" might not be supported.
> 
> Take this into account and only wait for interrupts which are actually in
> use in wait_for_tpm_stat(). After that process all the remaining status
> changes by polling the status register.
> 
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 46 ++++++++++++++++++++++++---------
>  1 file changed, 34 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 2f03fefa1706..028bec44362d 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -53,41 +53,63 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
>  	long rc;
>  	u8 status;
>  	bool canceled = false;
> +	u8 active_irqs = 0;

Something like sts_mask would be a better name. Calling it
'active_irqs' is a bit confusing.

> +	int ret = 0;
>  
>  	/* check current status */
>  	status = chip->ops->status(chip);
>  	if ((status & mask) == mask)
>  		return 0;
>  
> -	stop = jiffies + timeout;
> +	/* check what status changes can be handled by irqs */
> +	if (priv->irqs_in_use & TPM_INTF_STS_VALID_INT)
> +		active_irqs |= TPM_STS_VALID;
>  
> -	if (chip->flags & TPM_CHIP_FLAG_IRQ) {
> +	if (priv->irqs_in_use & TPM_INTF_DATA_AVAIL_INT)
> +		active_irqs |= TPM_STS_DATA_AVAIL;
> +
> +	if (priv->irqs_in_use & TPM_INTF_CMD_READY_INT)
> +		active_irqs |= TPM_STS_COMMAND_READY;
> +
> +	active_irqs &= mask;
> +
> +	stop = jiffies + timeout;
> +	/* process status changes with irq support */
> +	if (active_irqs) {
> +		ret = -ETIME;
>  again:
>  		timeout = stop - jiffies;
>  		if ((long)timeout <= 0)
>  			return -ETIME;
>  		rc = wait_event_interruptible_timeout(*queue,
> -			wait_for_tpm_stat_cond(chip, mask, check_cancel,
> +			wait_for_tpm_stat_cond(chip, active_irqs, check_cancel,
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
> +	mask &= ~active_irqs;
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
> -- 
> 2.36.1
> 

BR, Jarkko
