Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE875236BD
	for <lists+linux-integrity@lfdr.de>; Wed, 11 May 2022 17:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245517AbiEKPLj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 May 2022 11:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245554AbiEKPLH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 May 2022 11:11:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B522DA8D;
        Wed, 11 May 2022 08:11:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E9AAB82495;
        Wed, 11 May 2022 15:11:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88C2C340EE;
        Wed, 11 May 2022 15:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652281863;
        bh=Is3ld2rj7eoXcoAoTL8llrIXex9PRPpshhLsbMbT6es=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mMA2KIqu6H/4epqSJsI+jDmXUpOJJ1sw5FPk5+hbW8sUurqbVcevJc6tZDvjFiSwC
         /XdAbb3NVfG/GZLHUe549y6ZUZQvn0WIKIbdZga/95aYspL9wyKmBgXvgg8kh53d4g
         P2x0U/2+7PQrK6v0RqEV9C5FvS+RDln0j/86HK50PoUkChSeQnMrY49+6tVeqdLzEy
         O1XPodV/sX01+SbHeC7Br6l8pJGFSdo/3KKhLdo5kth2H4U1gtrAoBNFbvHCCpc1zw
         EgL9V1aRs+1taqhnDq2VzACruHzR+pLtcS2KflIjs4226VGuG1kJPDDXDyAZulSVwL
         SseZCcjJcHXDQ==
Date:   Wed, 11 May 2022 18:09:33 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de,
        p.rosenberger@kunbus.com, Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH v4 5/6] tpm, tpm_tis: Move irq test from tpm_tis_send()
 to tpm_tis_probe_irq_single()
Message-ID: <YnvRrT19Pe2SPDNe@kernel.org>
References: <20220509080559.4381-1-LinoSanfilippo@gmx.de>
 <20220509080559.4381-6-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509080559.4381-6-LinoSanfilippo@gmx.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, May 09, 2022 at 10:05:58AM +0200, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> There is no need to check for the irq test completion at each data
> transmission during the driver livetime. Instead do the check only once at
> driver startup.
> 
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 68 +++++++++++----------------------
>  1 file changed, 22 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index bdfde1cd71fe..4c65718feb7d 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -432,7 +432,7 @@ static void disable_interrupts(struct tpm_chip *chip)
>   * tpm.c can skip polling for the data to be available as the interrupt is
>   * waited for here
>   */
> -static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
> +static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
>  {
>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>  	int rc;
> @@ -465,30 +465,6 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
>  	return rc;
>  }
>  
> -static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
> -{
> -	int rc, irq;
> -	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> -
> -	if (!(chip->flags & TPM_CHIP_FLAG_IRQ) ||
> -	     test_bit(TPM_TIS_IRQTEST_OK, &priv->irqtest_flags))
> -		return tpm_tis_send_main(chip, buf, len);
> -
> -	/* Verify receipt of the expected IRQ */
> -	irq = priv->irq;
> -	priv->irq = 0;
> -	chip->flags &= ~TPM_CHIP_FLAG_IRQ;
> -	rc = tpm_tis_send_main(chip, buf, len);
> -	priv->irq = irq;
> -	chip->flags |= TPM_CHIP_FLAG_IRQ;
> -	if (!test_bit(TPM_TIS_IRQTEST_OK, &priv->irqtest_flags))
> -		tpm_msleep(1);
> -	if (!test_bit(TPM_TIS_IRQTEST_OK, &priv->irqtest_flags))
> -		disable_interrupts(chip);
> -	set_bit(TPM_TIS_IRQTEST_OK, &priv->irqtest_flags);
> -	return rc;
> -}
> -
>  struct tis_vendor_durations_override {
>  	u32 did_vid;
>  	struct tpm1_version version;
> @@ -759,51 +735,54 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
>  
>  	rc = tpm_tis_read8(priv, TPM_INT_VECTOR(priv->locality),
>  			   &original_int_vec);
> -	if (rc < 0)
> +	if (rc < 0) {
> +		disable_interrupts(chip);
>  		return rc;
> +	}
>  
>  	rc = tpm_tis_write8(priv, TPM_INT_VECTOR(priv->locality), irq);
>  	if (rc < 0)
> -		return rc;
> +		goto out_err;
>  
>  	rc = tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &int_status);
>  	if (rc < 0)
> -		return rc;
> +		goto out_err;
>  
>  	/* Clear all existing */
>  	rc = tpm_tis_write32(priv, TPM_INT_STATUS(priv->locality), int_status);
>  	if (rc < 0)
> -		return rc;
> +		goto out_err;
>  
>  	/* Turn on */
>  	rc = tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality),
>  			     intmask | TPM_GLOBAL_INT_ENABLE);
>  	if (rc < 0)
> -		return rc;
> +		goto out_err;
>  
>  	clear_bit(TPM_TIS_IRQTEST_OK, &priv->irqtest_flags);
> -	chip->flags |= TPM_CHIP_FLAG_IRQ;
>  
>  	/* Generate an interrupt by having the core call through to
>  	 * tpm_tis_send
>  	 */
>  	rc = tpm_tis_gen_interrupt(chip);
>  	if (rc < 0)
> -		return rc;
> +		goto out_err;
>  
> -	/* tpm_tis_send will either confirm the interrupt is working or it
> -	 * will call disable_irq which undoes all of the above.
> -	 */
> -	if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
> -		rc = tpm_tis_write8(priv, original_int_vec,
> -				TPM_INT_VECTOR(priv->locality));
> -		if (rc < 0)
> -			return rc;
> +	tpm_msleep(1);
>  
> -		return 1;
> -	}
> +	/* Verify receipt of the expected IRQ */
> +	if (!test_bit(TPM_TIS_IRQTEST_OK, &priv->irqtest_flags))
> +		goto out_err;
> +
> +	chip->flags |= TPM_CHIP_FLAG_IRQ;
>  
>  	return 0;
> +
> +out_err:
> +	disable_interrupts(chip);
> +	tpm_tis_write8(priv, original_int_vec, TPM_INT_VECTOR(priv->locality));
> +
> +	return rc;
>  }
>  
>  /* Try to find the IRQ the TPM is using. This is for legacy x86 systems that
> @@ -1075,12 +1054,9 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  		if (irq) {
>  			tpm_tis_probe_irq_single(chip, intmask, IRQF_SHARED,
>  						 irq);
> -			if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
> +			if (!(chip->flags & TPM_CHIP_FLAG_IRQ))
>  				dev_err(&chip->dev, FW_BUG
>  					"TPM interrupt not working, polling instead\n");
> -
> -				disable_interrupts(chip);
> -			}
>  		} else {
>  			tpm_tis_probe_irq(chip, intmask);
>  		}
> -- 
> 2.36.0
> 

For me this looks just code shuffling.

I don't disagree but changing working code without actual semantical
reasons neither makes sense.

BR, Jarkko
