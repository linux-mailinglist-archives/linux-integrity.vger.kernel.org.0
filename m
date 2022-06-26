Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D8555AF76
	for <lists+linux-integrity@lfdr.de>; Sun, 26 Jun 2022 08:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233098AbiFZGYB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 26 Jun 2022 02:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbiFZGYB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 26 Jun 2022 02:24:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8047B101D3;
        Sat, 25 Jun 2022 23:24:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 365E3B80CF6;
        Sun, 26 Jun 2022 06:23:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85530C34114;
        Sun, 26 Jun 2022 06:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656224637;
        bh=WB3vT3WVZkW9Hgvvw424FD+cwJ0iWOXgy3acAWvUG30=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gabpwz7T+5T0u402eXby2IHjeNtClSYoG5fcgx8p805kmn9Rb0+USot1IaXqwlczV
         QRtb8J5D36Go2xZO6rGb3NVrdNUDAV91/W5pqMuwjEcCbXfMJiKkOlUHZEMv0KocI0
         h/9Dj/gTS8Gt3iPGx18MItiQrKHykwRLHXbhG16zxgT49YD8H5OfDrcCp+ahJZFXzu
         Sd2h3yigdxIOMGXPNDTfiru6OqTqLMaB5bEbqGRmYGF8gDl+cF6xyYXkEM12XXnZTT
         T/GfsEacPsEdMkzl49ayZ4zPG4RQJDuHzuvnYzeC+JQL7RRvNo+1TWZE5QBX6QKW0V
         nsJsMnPFGAqNA==
Date:   Sun, 26 Jun 2022 09:23:54 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com
Subject: Re: [PATCH v6 1/9] tpm, tpm_tis: Avoid cache incoherency in test for
 interrupts
Message-ID: <Yrf7elJccYq+vvN7@kernel.org>
References: <20220621132447.16281-1-LinoSanfilippo@gmx.de>
 <20220621132447.16281-2-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621132447.16281-2-LinoSanfilippo@gmx.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jun 21, 2022 at 03:24:39PM +0200, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> The interrupt handler that sets the boolean variable irq_tested may run on
> another CPU as the thread that checks irq_tested as part of the irq test in
> tmp_tis_send().
> 
> Since nothing guarantees cache coherency between CPUs for unsynchronized
> accesses to boolean variables the testing thread might not perceive the
> value change done in the interrupt handler.
> 
> Avoid this issue by setting the bit TPM_TIS_IRQ_TESTED in the flags field
> of the tpm_tis_data struct and by accessing this field with the bit
> manipulating functions that provide cache coherency.
> 
> Also convert all other existing sites to use the proper macros when
> accessing this bitfield.
> 
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/char/tpm/tpm_tis.c      |  2 +-
>  drivers/char/tpm/tpm_tis_core.c | 21 +++++++++++----------
>  drivers/char/tpm/tpm_tis_core.h |  2 +-
>  3 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index bcff6429e0b4..ce43412eb398 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -226,7 +226,7 @@ static int tpm_tis_init(struct device *dev, struct tpm_info *tpm_info)
>  		irq = tpm_info->irq;
>  
>  	if (itpm || is_itpm(ACPI_COMPANION(dev)))
> -		phy->priv.flags |= TPM_TIS_ITPM_WORKAROUND;
> +		set_bit(TPM_TIS_ITPM_WORKAROUND, &phy->priv.flags);
>  
>  	return tpm_tis_core_init(dev, &phy->priv, irq, &tpm_tcg,
>  				 ACPI_HANDLE(dev));
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index dc56b976d816..b5fd4ff46666 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -343,7 +343,7 @@ static int tpm_tis_send_data(struct tpm_chip *chip, const u8 *buf, size_t len)
>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>  	int rc, status, burstcnt;
>  	size_t count = 0;
> -	bool itpm = priv->flags & TPM_TIS_ITPM_WORKAROUND;
> +	bool itpm = test_bit(TPM_TIS_ITPM_WORKAROUND, &priv->flags);
>  
>  	status = tpm_tis_status(chip);
>  	if ((status & TPM_STS_COMMAND_READY) == 0) {
> @@ -470,7 +470,8 @@ static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
>  	int rc, irq;
>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>  
> -	if (!(chip->flags & TPM_CHIP_FLAG_IRQ) || priv->irq_tested)
> +	if (!(chip->flags & TPM_CHIP_FLAG_IRQ) ||
> +	     test_bit(TPM_TIS_IRQ_TESTED, &priv->flags))
>  		return tpm_tis_send_main(chip, buf, len);
>  
>  	/* Verify receipt of the expected IRQ */
> @@ -480,11 +481,11 @@ static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
>  	rc = tpm_tis_send_main(chip, buf, len);
>  	priv->irq = irq;
>  	chip->flags |= TPM_CHIP_FLAG_IRQ;
> -	if (!priv->irq_tested)
> +	if (!test_bit(TPM_TIS_IRQ_TESTED, &priv->flags))
>  		tpm_msleep(1);
> -	if (!priv->irq_tested)
> +	if (!test_bit(TPM_TIS_IRQ_TESTED, &priv->flags))
>  		disable_interrupts(chip);
> -	priv->irq_tested = true;
> +	set_bit(TPM_TIS_IRQ_TESTED, &priv->flags);
>  	return rc;
>  }
>  
> @@ -627,7 +628,7 @@ static int probe_itpm(struct tpm_chip *chip)
>  	size_t len = sizeof(cmd_getticks);
>  	u16 vendor;
>  
> -	if (priv->flags & TPM_TIS_ITPM_WORKAROUND)
> +	if (test_bit(TPM_TIS_ITPM_WORKAROUND, &priv->flags))
>  		return 0;
>  
>  	rc = tpm_tis_read16(priv, TPM_DID_VID(0), &vendor);
> @@ -647,13 +648,13 @@ static int probe_itpm(struct tpm_chip *chip)
>  
>  	tpm_tis_ready(chip);
>  
> -	priv->flags |= TPM_TIS_ITPM_WORKAROUND;
> +	set_bit(TPM_TIS_ITPM_WORKAROUND, &priv->flags);
>  
>  	rc = tpm_tis_send_data(chip, cmd_getticks, len);
>  	if (rc == 0)
>  		dev_info(&chip->dev, "Detected an iTPM.\n");
>  	else {
> -		priv->flags &= ~TPM_TIS_ITPM_WORKAROUND;
> +		clear_bit(TPM_TIS_ITPM_WORKAROUND, &priv->flags);
>  		rc = -EFAULT;
>  	}
>  
> @@ -693,7 +694,7 @@ static irqreturn_t tis_int_handler(int dummy, void *dev_id)
>  	if (interrupt == 0)
>  		return IRQ_NONE;
>  
> -	priv->irq_tested = true;
> +	set_bit(TPM_TIS_IRQ_TESTED, &priv->flags);
>  	if (interrupt & TPM_INTF_DATA_AVAIL_INT)
>  		wake_up_interruptible(&priv->read_queue);
>  	if (interrupt & TPM_INTF_LOCALITY_CHANGE_INT)
> @@ -779,7 +780,7 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
>  	if (rc < 0)
>  		return rc;
>  
> -	priv->irq_tested = false;
> +	clear_bit(TPM_TIS_IRQ_TESTED, &priv->flags);
>  
>  	/* Generate an interrupt by having the core call through to
>  	 * tpm_tis_send
> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
> index 6c203f36b8a1..bf07379dea42 100644
> --- a/drivers/char/tpm/tpm_tis_core.h
> +++ b/drivers/char/tpm/tpm_tis_core.h
> @@ -86,13 +86,13 @@ enum tis_defaults {
>  enum tpm_tis_flags {
>  	TPM_TIS_ITPM_WORKAROUND		= BIT(0),
>  	TPM_TIS_INVALID_STATUS		= BIT(1),
> +	TPM_TIS_IRQ_TESTED		= BIT(2),
>  };
>  
>  struct tpm_tis_data {
>  	u16 manufacturer_id;
>  	int locality;
>  	int irq;
> -	bool irq_tested;
>  	unsigned long flags;
>  	void __iomem *ilb_base_addr;
>  	u16 clkrun_enabled;
> -- 
> 2.36.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
