Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A65F37187C
	for <lists+linux-integrity@lfdr.de>; Mon,  3 May 2021 17:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhECPx6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 May 2021 11:53:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:39946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230236AbhECPxz (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 May 2021 11:53:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 23E4561139;
        Mon,  3 May 2021 15:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620057181;
        bh=dtRR4Uq9hYnY1Bes1pVKnOXHCLy2I6C1OgZlDq4I7sY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qLmjWDMkHNhCEYNU+12Fni72j/oBpg/+JoPpJRy/BuzDtTasQuxpEqDl0p4461F73
         7HExOZrUzV/m0ppzFjowFPyXvWxplDhmfFmnEgEaUHt18mKx5eRJLn4IrifmyWmCxH
         2t+KCwhjr5NOpS7ykK3T8wa0AgmHwbUfPF+0aXYtqQtEubpDoUlOiQ2gqP+eZEzEuU
         uAgeBsXmNe1JT1A2MOhSTEMNlnRhPnSBKrE886u6HAqhvcoNmq5HpJKb1zcYsf5Tw4
         +yOPUneoUCUfGgBIsXMiZ7Zi1CnR9e2vdwvDPA84jBkiAzkff6wjquwth546LwskOq
         sQ05w3DHOZIYQ==
Date:   Mon, 3 May 2021 18:52:59 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        James.Bottomley@hansenpartnership.com, keescook@chromium.org,
        jsnitsel@redhat.com, ml.linux@elloe.vision,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] tpm: Only enable supported irqs
Message-ID: <YJAcWyTs2T3xHnFx@kernel.org>
References: <20210501135727.17747-1-LinoSanfilippo@gmx.de>
 <20210501135727.17747-5-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210501135727.17747-5-LinoSanfilippo@gmx.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, May 01, 2021 at 03:57:27PM +0200, Lino Sanfilippo wrote:
> Do not set interrupts which are not supported by the hardware. Instead use
> the information from the capability query and activate only the reported
> interrupts.
> 
> Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>

Zero reasoning again, why.


> ---
>  drivers/char/tpm/tpm_tis_core.c | 68 ++++++++++++++++++---------------
>  drivers/char/tpm/tpm_tis_core.h |  1 +
>  2 files changed, 38 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 9615234054aa..757498a63f57 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -936,13 +936,47 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  	if (rc)
>  		goto out_err;
>  
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
> +		priv->supported_irqs |= TPM_INTF_CMD_READY_INT;
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
> +	if (intfcaps & TPM_INTF_LOCALITY_CHANGE_INT) {
> +		priv->supported_irqs |= TPM_INTF_LOCALITY_CHANGE_INT;
> +		dev_dbg(dev, "\tLocality Change Int Support\n");
> +	}
> +	if (intfcaps & TPM_INTF_STS_VALID_INT) {
> +		priv->supported_irqs |= TPM_INTF_STS_VALID_INT;
> +		dev_dbg(dev, "\tSts Valid Int Support\n");
> +	}
> +	if (intfcaps & TPM_INTF_DATA_AVAIL_INT) {
> +		priv->supported_irqs |= TPM_INTF_DATA_AVAIL_INT;
> +		dev_dbg(dev, "\tData Avail Int Support\n");
> +	}
> +
>  	/* Take control of the TPM's interrupt hardware and shut it off */
>  	rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
>  	if (rc < 0)
>  		goto out_err;
>  
> -	intmask |= TPM_INTF_CMD_READY_INT | TPM_INTF_LOCALITY_CHANGE_INT |
> -		   TPM_INTF_DATA_AVAIL_INT | TPM_INTF_STS_VALID_INT;
> +	intmask |= priv->supported_irqs;
> +
>  	intmask &= ~TPM_GLOBAL_INT_ENABLE;
>  	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
>  
> @@ -971,32 +1005,6 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
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
> @@ -1066,9 +1074,7 @@ static void tpm_tis_reenable_interrupts(struct tpm_chip *chip)
>  	if (rc < 0)
>  		goto out;
>  
> -	intmask |= TPM_INTF_CMD_READY_INT
> -	    | TPM_INTF_LOCALITY_CHANGE_INT | TPM_INTF_DATA_AVAIL_INT
> -	    | TPM_INTF_STS_VALID_INT | TPM_GLOBAL_INT_ENABLE;
> +	intmask |= priv->supported_irqs | TPM_GLOBAL_INT_ENABLE;
>  
>  	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
>  
> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
> index dc5f92b18dca..8ff62213d8fc 100644
> --- a/drivers/char/tpm/tpm_tis_core.h
> +++ b/drivers/char/tpm/tpm_tis_core.h
> @@ -89,6 +89,7 @@ struct tpm_tis_data {
>  	u16 manufacturer_id;
>  	int locality;
>  	int irq;
> +	unsigned int supported_irqs;
>  	unsigned int flags;
>  	void __iomem *ilb_base_addr;
>  	u16 clkrun_enabled;
> -- 
> 2.31.1

/Jarkko
> 
