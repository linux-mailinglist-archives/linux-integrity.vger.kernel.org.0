Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5D85236B8
	for <lists+linux-integrity@lfdr.de>; Wed, 11 May 2022 17:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245471AbiEKPJq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 May 2022 11:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245433AbiEKPJq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 May 2022 11:09:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5D25A5BA;
        Wed, 11 May 2022 08:09:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 099A4617F4;
        Wed, 11 May 2022 15:09:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164F3C340EE;
        Wed, 11 May 2022 15:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652281784;
        bh=+5yhdEg3t7GmuaYfoKfEfexhg5W3/y5N1bM9raZWrGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IBY5WeqxFQIsvZwdQLVR9GkA5PwhiSY6/1rd0dgaHKLxhFW6thgEhZXndBnhCLjmS
         jbXYJOdaMshS5BDHa8cXWyQY5oKStPOqgRdoSb3hhDjRiVHDZrVwyo5MqtqOonEdHC
         5J5XS0MkTv7ZRNQIooeeLcV3Cyd3E7FuFNwe+wr5c9BV+l2a0p6hBGmZBbOPx9zbFB
         bYFeQiGDKA6JWe9bgxiPlWu6oXyqly1TmLxzSXFchguUywApwUV6j2bp/ZwZrc9Omx
         7q5ZrW//Hu0a4enfgTsYirseppHifF8T49s8HW0qg4CR5GbBMWyqubaBR+gsGx/LUW
         gpBv7UeNFH27w==
Date:   Wed, 11 May 2022 18:08:14 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de,
        p.rosenberger@kunbus.com, Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH v4 6/6] tpm, tpm_tis: Only enable supported IRQs
Message-ID: <YnvRXiMxMRF3mIb8@kernel.org>
References: <20220509080559.4381-1-LinoSanfilippo@gmx.de>
 <20220509080559.4381-7-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509080559.4381-7-LinoSanfilippo@gmx.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, May 09, 2022 at 10:05:59AM +0200, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> Instead of blindly trying to enable all possible interrupts, use the result
> from the capability query and request only the interrupts that are actually
> supported.
> 
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 67 ++++++++++++++++++---------------
>  drivers/char/tpm/tpm_tis_core.h |  1 +
>  2 files changed, 37 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 4c65718feb7d..784e153e2895 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -976,13 +976,46 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  		goto out_err;
>  	}
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
>  	intmask &= ~TPM_GLOBAL_INT_ENABLE;
>  
>  	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
> @@ -1009,32 +1042,6 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
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
> @@ -1101,9 +1108,7 @@ static void tpm_tis_reenable_interrupts(struct tpm_chip *chip)
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
> index c8972ea8e13e..3d6b05c6fdba 100644
> --- a/drivers/char/tpm/tpm_tis_core.h
> +++ b/drivers/char/tpm/tpm_tis_core.h
> @@ -97,6 +97,7 @@ struct tpm_tis_data {
>  	u16 manufacturer_id;
>  	int locality;
>  	int irq;
> +	unsigned int supported_irqs;
>  	unsigned long irqtest_flags;
>  	unsigned long flags;
>  	void __iomem *ilb_base_addr;
> -- 
> 2.36.0
> 

Does the existing code cause issues in a some specific environment?

BR, Jarkko
