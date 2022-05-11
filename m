Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 911545236B4
	for <lists+linux-integrity@lfdr.de>; Wed, 11 May 2022 17:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244815AbiEKPIY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 May 2022 11:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbiEKPIX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 May 2022 11:08:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46105B3D2;
        Wed, 11 May 2022 08:08:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EE4161786;
        Wed, 11 May 2022 15:08:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC32C34113;
        Wed, 11 May 2022 15:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652281701;
        bh=5wQc2u6AI7WUu6vn5eGyT4CKzjuF4xPJhTQmdOr5gIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aGCwpJLAPout44O6oVp+LtLIygxrHlNuMf4AozAX0T1drJ2aF5VbZSLfTl9NwJqBf
         dhFn7buAik4vX7gfedMm3E3XmTMfYD47h5bTIDjZnL7OqTcbbv28RhrEWhfBQr5k1q
         MAfrtuG6ujrAuOx8mXkQS24RbDs/h8mhcMO6kbO0plGW2jtZjRssoExMpcA5V/F9J/
         Wel2+2rYnEME9qutM8WjbcT4fs/V3P7fGMQ4mnGUJBNVowLpoLVsvxH7BRV7n2O+fa
         pkRC98g+QUcTD8zRx7SWD4AAXqpPKqmTFjm16+A2K05QFYm4gMm/+VrzaSZVDvwaYx
         cZlUT8AELfe5Q==
Date:   Wed, 11 May 2022 18:06:51 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de,
        p.rosenberger@kunbus.com, Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH v4 4/6] tpm, tpm_tis: avoid CPU cache incoherency in irq
 test
Message-ID: <YnvRC3FI7bcXj7zL@kernel.org>
References: <20220509080559.4381-1-LinoSanfilippo@gmx.de>
 <20220509080559.4381-5-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509080559.4381-5-LinoSanfilippo@gmx.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, May 09, 2022 at 10:05:57AM +0200, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> The interrupt handler that sets irq_tested to indicate that interrupts are
> working may run on another CPU than the thread that checks this variable in
> tmp_tis_send().
> 
> Since no synchronization is used to access irq_tested, there is no
> guarantee for cache coherency between the CPUs, so that the value set by
> the interrupt handler might not be visible to the testing thread.
> 
> Avoid this issue by using a bitfield instead of a boolean variable and by
> accessing this field with bit manipulating functions that guarantee cache
> coherency.
> 
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 13 +++++++------
>  drivers/char/tpm/tpm_tis_core.h |  6 +++++-
>  2 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 4f3b82c3f205..bdfde1cd71fe 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -470,7 +470,8 @@ static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
>  	int rc, irq;
>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>  
> -	if (!(chip->flags & TPM_CHIP_FLAG_IRQ) || priv->irq_tested)
> +	if (!(chip->flags & TPM_CHIP_FLAG_IRQ) ||
> +	     test_bit(TPM_TIS_IRQTEST_OK, &priv->irqtest_flags))
>  		return tpm_tis_send_main(chip, buf, len);
>  
>  	/* Verify receipt of the expected IRQ */
> @@ -480,11 +481,11 @@ static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
>  	rc = tpm_tis_send_main(chip, buf, len);
>  	priv->irq = irq;
>  	chip->flags |= TPM_CHIP_FLAG_IRQ;
> -	if (!priv->irq_tested)
> +	if (!test_bit(TPM_TIS_IRQTEST_OK, &priv->irqtest_flags))
>  		tpm_msleep(1);
> -	if (!priv->irq_tested)
> +	if (!test_bit(TPM_TIS_IRQTEST_OK, &priv->irqtest_flags))
>  		disable_interrupts(chip);
> -	priv->irq_tested = true;
> +	set_bit(TPM_TIS_IRQTEST_OK, &priv->irqtest_flags);
>  	return rc;
>  }
>  
> @@ -689,7 +690,7 @@ static irqreturn_t tis_int_handler(int dummy, void *dev_id)
>  	if (interrupt == 0)
>  		return IRQ_NONE;
>  
> -	priv->irq_tested = true;
> +	set_bit(TPM_TIS_IRQTEST_OK, &priv->irqtest_flags);
>  	if (interrupt & TPM_INTF_DATA_AVAIL_INT)
>  		wake_up_interruptible(&priv->read_queue);
>  	if (interrupt & TPM_INTF_LOCALITY_CHANGE_INT)
> @@ -780,7 +781,7 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
>  	if (rc < 0)
>  		return rc;
>  
> -	priv->irq_tested = false;
> +	clear_bit(TPM_TIS_IRQTEST_OK, &priv->irqtest_flags);
>  	chip->flags |= TPM_CHIP_FLAG_IRQ;
>  
>  	/* Generate an interrupt by having the core call through to
> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
> index 43b724e55192..c8972ea8e13e 100644
> --- a/drivers/char/tpm/tpm_tis_core.h
> +++ b/drivers/char/tpm/tpm_tis_core.h
> @@ -89,11 +89,15 @@ enum tpm_tis_flags {
>  	TPM_TIS_USE_THREADED_IRQ	= BIT(2),
>  };
>  
> +enum tpm_tis_irqtest_flags {
> +	TPM_TIS_IRQTEST_OK		= BIT(0),
> +};
> +
>  struct tpm_tis_data {
>  	u16 manufacturer_id;
>  	int locality;
>  	int irq;
> -	bool irq_tested;
> +	unsigned long irqtest_flags;
>  	unsigned long flags;
>  	void __iomem *ilb_base_addr;
>  	u16 clkrun_enabled;
> -- 
> 2.36.0
> 

So, this would caused by changing to threaded IRQs?

BR, Jarkko
