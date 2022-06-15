Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B42654CB65
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jun 2022 16:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240054AbiFOOcQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jun 2022 10:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiFOOcQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jun 2022 10:32:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862DB49B64;
        Wed, 15 Jun 2022 07:32:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D4E860AB0;
        Wed, 15 Jun 2022 14:32:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25DB8C34115;
        Wed, 15 Jun 2022 14:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655303534;
        bh=Oem7MqbkCZEaURs3v3eZLONkUT4Nvbai0WIqLG04674=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LwE/9tXxtaVSqbBvHvB07lcYyhfyTSpy3aRU5szzydOvIKnJnv0TATOjokDDQGwkA
         otm2Mcl6k8YRclyIZZHukhttKBvw2i5+6dP+eV1xL7CIVXG0ZMeiYyjRnu/eli5aLC
         5Dcs+diGXrvl3NciVq7NfpcmWXnmCWEpvfCrXLziYE5+cL9Jtyf4VOl9ZMt791uUre
         H8ZnTyEElAAbkcv4sW/h26otQoSD7sIPAM+e80XTyDq/mCc7YsvCdE4tsc3TZhPhPH
         CITGuL8HVoReifMJ4XBBF/BJEyeuwp7AA+6M4iM0DQpnV6VTQ5LovNsNnaF0JotdVX
         JOo/K0d32cbEQ==
Date:   Wed, 15 Jun 2022 17:32:10 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     LinoSanfilippo@gmx.de
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com
Subject: Re: [PATCH v5 01/10] tpm, tpm_tis: Avoid cache incoherency in test
 for interrupts
Message-ID: <YqntNDU5tcwgDdvG@kernel.org>
References: <20220610110846.8307-1-LinoSanfilippo@gmx.de>
 <20220610110846.8307-2-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610110846.8307-2-LinoSanfilippo@gmx.de>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 10, 2022 at 01:08:37PM +0200, LinoSanfilippo@gmx.de wrote:
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
> Avoid this issue by using a bitfield instead of a boolean variable and by
> accessing this field with the bit manipulating functions that provide cache
> coherency.
> 
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 13 +++++++------
>  drivers/char/tpm/tpm_tis_core.h |  6 +++++-
>  2 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index dc56b976d816..6f2cf75add8b 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -470,7 +470,8 @@ static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
>  	int rc, irq;
>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>  
> -	if (!(chip->flags & TPM_CHIP_FLAG_IRQ) || priv->irq_tested)
> +	if (!(chip->flags & TPM_CHIP_FLAG_IRQ) ||
> +	     test_bit(TPM_TIS_IRQ_TESTED, &priv->irqtest_flags))
>  		return tpm_tis_send_main(chip, buf, len);
>  
>  	/* Verify receipt of the expected IRQ */
> @@ -480,11 +481,11 @@ static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
>  	rc = tpm_tis_send_main(chip, buf, len);
>  	priv->irq = irq;
>  	chip->flags |= TPM_CHIP_FLAG_IRQ;
> -	if (!priv->irq_tested)
> +	if (!test_bit(TPM_TIS_IRQ_TESTED, &priv->irqtest_flags))
>  		tpm_msleep(1);
> -	if (!priv->irq_tested)
> +	if (!test_bit(TPM_TIS_IRQ_TESTED, &priv->irqtest_flags))
>  		disable_interrupts(chip);
> -	priv->irq_tested = true;
> +	set_bit(TPM_TIS_IRQ_TESTED, &priv->irqtest_flags);
>  	return rc;
>  }
>  
> @@ -693,7 +694,7 @@ static irqreturn_t tis_int_handler(int dummy, void *dev_id)
>  	if (interrupt == 0)
>  		return IRQ_NONE;
>  
> -	priv->irq_tested = true;
> +	set_bit(TPM_TIS_IRQ_TESTED, &priv->irqtest_flags);
>  	if (interrupt & TPM_INTF_DATA_AVAIL_INT)
>  		wake_up_interruptible(&priv->read_queue);
>  	if (interrupt & TPM_INTF_LOCALITY_CHANGE_INT)
> @@ -779,7 +780,7 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
>  	if (rc < 0)
>  		return rc;
>  
> -	priv->irq_tested = false;
> +	clear_bit(TPM_TIS_IRQ_TESTED, &priv->irqtest_flags);
>  
>  	/* Generate an interrupt by having the core call through to
>  	 * tpm_tis_send
> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
> index 3be24f221e32..0f29d0b68c3e 100644
> --- a/drivers/char/tpm/tpm_tis_core.h
> +++ b/drivers/char/tpm/tpm_tis_core.h
> @@ -88,11 +88,15 @@ enum tpm_tis_flags {
>  	TPM_TIS_INVALID_STATUS		= BIT(1),
>  };
>  
> +enum tpm_tis_irqtest_flags {
> +	TPM_TIS_IRQ_TESTED		= BIT(0),
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
> 2.36.1
> 

Otherwise looks fine, but please add TPM_TIS_IRQ_TESTED to 'flags', and
convert existing sites to use set_bit() and and test_bit().

BR, Jarkko
