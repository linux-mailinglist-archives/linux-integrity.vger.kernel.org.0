Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8F9562716
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Jul 2022 01:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiF3X3v (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Jun 2022 19:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiF3X3v (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Jun 2022 19:29:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D5F44A26;
        Thu, 30 Jun 2022 16:29:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EA1861976;
        Thu, 30 Jun 2022 23:29:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA59C341C8;
        Thu, 30 Jun 2022 23:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656631787;
        bh=8zDDjljtuKH3a9AgBRxpKjei6gBVIIFR7+gDI3NefmA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kE8+B/IVSYN+lmjrK1jVUxKOa2NnjWCmwEJsjs3jP1IMl1x7l5mLHXw91DcBfAf6q
         VlmkHnXdnwJr4bIzhgv/+z1Nc3+8t7tFx/NlVbsxCNKX7/mG+EgvNIkYav0KOu07Fe
         MIuQ32T0/zSjbSHKA5Ja1LvcD6i6hiUDA8h74llQhdq0TZffxelSqpV2ZqKu8NEeaY
         YWmHJNU2kKd/QcxLpGU4GWSR0XACUbdqx5XAwDJCkrNcMD14lYc2BPSlMzvZt27Pat
         Wwa9y3xj0SpKbZEhqkxVMgh3k1ZDiIXjeKKX2d4OX/X+UMqs9vwS1teSpII6PRdnuv
         HKdJfDn0wIM9g==
Date:   Fri, 1 Jul 2022 02:29:44 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com
Subject: Re: [PATCH v7 07/10] tmp, tmp_tis: Implement usage counter for
 locality
Message-ID: <Yr4x6KRSvzlXNdH2@kernel.org>
References: <20220629232653.1306735-1-LinoSanfilippo@gmx.de>
 <20220629232653.1306735-8-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629232653.1306735-8-LinoSanfilippo@gmx.de>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 30, 2022 at 01:26:50AM +0200, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> Implement a usage counter for the (default) locality used by the TPM TIS
> driver:
> Request the locality from the TPM if it has not been claimed yet, otherwise
> only increment the counter. Also release the locality if the counter is 0
> otherwise only decrement the counter. Ensure thread-safety by protecting
> the counter with a mutex.
> 
> This allows to request and release the locality from a thread and the
> interrupt handler at the same time without the danger to interfere with
> each other.
> 
> By doing this refactor the names of the amended functions to use the proper
> prefix.
> 
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> Tested-by: Michael Niew??hner <linux@mniewoehner.de>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 75 ++++++++++++++++++++++-----------
>  drivers/char/tpm/tpm_tis_core.h |  2 +
>  2 files changed, 53 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index bd4eeb0b2192..e50a2c78de9f 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -165,16 +165,27 @@ static bool check_locality(struct tpm_chip *chip, int l)
>  	return false;
>  }
>  
> -static int release_locality(struct tpm_chip *chip, int l)
> +static int tpm_tis_release_locality_locked(struct tpm_tis_data *priv, int l)
> +{
> +	tpm_tis_write8(priv, TPM_ACCESS(l), TPM_ACCESS_ACTIVE_LOCALITY);
> +
> +	return 0;
> +}
> +
> +static int tpm_tis_release_locality(struct tpm_chip *chip, int l)
>  {
>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>  
> -	tpm_tis_write8(priv, TPM_ACCESS(l), TPM_ACCESS_ACTIVE_LOCALITY);
> +	mutex_lock(&priv->locality_count_mutex);
> +	priv->locality_count--;
> +	if (priv->locality_count == 0)
> +		tpm_tis_release_locality_locked(priv, l);
> +	mutex_unlock(&priv->locality_count_mutex);
>  
>  	return 0;
>  }
>  
> -static int request_locality(struct tpm_chip *chip, int l)
> +static int tpm_tis_request_locality_locked(struct tpm_chip *chip, int l)
>  {
>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>  	unsigned long stop, timeout;
> @@ -215,6 +226,20 @@ static int request_locality(struct tpm_chip *chip, int l)
>  	return -1;
>  }
>  
> +static int tpm_tis_request_locality(struct tpm_chip *chip, int l)
> +{
> +	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> +	int ret = 0;
> +
> +	mutex_lock(&priv->locality_count_mutex);
> +	if (priv->locality_count == 0)
> +		ret = tpm_tis_request_locality_locked(chip, l);
> +	if (!ret)
> +		priv->locality_count++;
> +	mutex_unlock(&priv->locality_count_mutex);
> +	return ret;
> +}
> +
>  static u8 tpm_tis_status(struct tpm_chip *chip)
>  {
>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> @@ -668,7 +693,7 @@ static int probe_itpm(struct tpm_chip *chip)
>  	if (vendor != TPM_VID_INTEL)
>  		return 0;
>  
> -	if (request_locality(chip, 0) != 0)
> +	if (tpm_tis_request_locality(chip, 0) != 0)
>  		return -EBUSY;
>  
>  	rc = tpm_tis_send_data(chip, cmd_getticks, len);
> @@ -689,7 +714,7 @@ static int probe_itpm(struct tpm_chip *chip)
>  
>  out:
>  	tpm_tis_ready(chip);
> -	release_locality(chip, priv->locality);
> +	tpm_tis_release_locality(chip, priv->locality);
>  
>  	return rc;
>  }
> @@ -751,7 +776,7 @@ static int tpm_tis_gen_interrupt(struct tpm_chip *chip)
>  	cap_t cap;
>  	int ret;
>  
> -	ret = request_locality(chip, 0);
> +	ret = tpm_tis_request_locality(chip, 0);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -760,7 +785,7 @@ static int tpm_tis_gen_interrupt(struct tpm_chip *chip)
>  	else
>  		ret = tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap, desc, 0);
>  
> -	release_locality(chip, 0);
> +	tpm_tis_release_locality(chip, 0);
>  
>  	return ret;
>  }
> @@ -785,33 +810,33 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
>  	}
>  	priv->irq = irq;
>  
> -	rc = request_locality(chip, 0);
> +	rc = tpm_tis_request_locality(chip, 0);
>  	if (rc < 0)
>  		return rc;
>  
>  	rc = tpm_tis_read8(priv, TPM_INT_VECTOR(priv->locality),
>  			   &original_int_vec);
>  	if (rc < 0) {
> -		release_locality(chip, priv->locality);
> +		tpm_tis_release_locality(chip, priv->locality);
>  		return rc;
>  	}
>  
>  	rc = tpm_tis_write8(priv, TPM_INT_VECTOR(priv->locality), irq);
>  	if (rc < 0) {
> -		release_locality(chip, priv->locality);
> +		tpm_tis_release_locality(chip, priv->locality);
>  		return rc;
>  	}
>  
>  	rc = tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &int_status);
>  	if (rc < 0) {
> -		release_locality(chip, priv->locality);
> +		tpm_tis_release_locality(chip, priv->locality);
>  		return rc;
>  	}
>  
>  	/* Clear all existing */
>  	rc = tpm_tis_write32(priv, TPM_INT_STATUS(priv->locality), int_status);
>  	if (rc < 0) {
> -		release_locality(chip, priv->locality);
> +		tpm_tis_release_locality(chip, priv->locality);
>  		return rc;
>  	}
>  
> @@ -819,11 +844,11 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
>  	rc = tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality),
>  			     intmask | TPM_GLOBAL_INT_ENABLE);
>  	if (rc < 0) {
> -		release_locality(chip, priv->locality);
> +		tpm_tis_release_locality(chip, priv->locality);
>  		return rc;
>  	}
>  
> -	release_locality(chip, priv->locality);
> +	tpm_tis_release_locality(chip, priv->locality);
>  	clear_bit(TPM_TIS_IRQ_TESTED, &priv->flags);
>  
>  	/* Generate an interrupt by having the core call through to
> @@ -959,8 +984,8 @@ static const struct tpm_class_ops tpm_tis = {
>  	.req_complete_mask = TPM_STS_DATA_AVAIL | TPM_STS_VALID,
>  	.req_complete_val = TPM_STS_DATA_AVAIL | TPM_STS_VALID,
>  	.req_canceled = tpm_tis_req_canceled,
> -	.request_locality = request_locality,
> -	.relinquish_locality = release_locality,
> +	.request_locality = tpm_tis_request_locality,
> +	.relinquish_locality = tpm_tis_release_locality,
>  	.clk_enable = tpm_tis_clkrun_enable,
>  };
>  
> @@ -994,6 +1019,8 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  	priv->timeout_min = TPM_TIMEOUT_USECS_MIN;
>  	priv->timeout_max = TPM_TIMEOUT_USECS_MAX;
>  	priv->phy_ops = phy_ops;
> +	priv->locality_count = 0;
> +	mutex_init(&priv->locality_count_mutex);
>  
>  	dev_set_drvdata(&chip->dev, priv);
>  
> @@ -1071,14 +1098,14 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  
>  	intmask &= ~TPM_GLOBAL_INT_ENABLE;
>  
> -	rc = request_locality(chip, 0);
> +	rc = tpm_tis_request_locality(chip, 0);
>  	if (rc < 0) {
>  		rc = -ENODEV;
>  		goto out_err;
>  	}
>  
>  	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
> -	release_locality(chip, 0);
> +	tpm_tis_release_locality(chip, 0);
>  
>  	rc = tpm_chip_start(chip);
>  	if (rc)
> @@ -1112,13 +1139,13 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  		 * proper timeouts for the driver.
>  		 */
>  
> -		rc = request_locality(chip, 0);
> +		rc = tpm_tis_request_locality(chip, 0);
>  		if (rc < 0)
>  			goto out_err;
>  
>  		rc = tpm_get_timeouts(chip);
>  
> -		release_locality(chip, 0);
> +		tpm_tis_release_locality(chip, 0);
>  
>  		if (rc) {
>  			dev_err(dev, "Could not get TPM timeouts and durations\n");
> @@ -1138,11 +1165,11 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  			dev_err(&chip->dev, FW_BUG
>  					"TPM interrupt not working, polling instead\n");
>  
> -			rc = request_locality(chip, 0);
> +			rc = tpm_tis_request_locality(chip, 0);
>  			if (rc < 0)
>  				goto out_err;
>  			disable_interrupts(chip);
> -			release_locality(chip, 0);
> +			tpm_tis_release_locality(chip, 0);
>  		}
>  	}
>  
> @@ -1209,13 +1236,13 @@ int tpm_tis_resume(struct device *dev)
>  	 * an error code but for unknown reason it isn't handled.
>  	 */
>  	if (!(chip->flags & TPM_CHIP_FLAG_TPM2)) {
> -		ret = request_locality(chip, 0);
> +		ret = tpm_tis_request_locality(chip, 0);
>  		if (ret < 0)
>  			return ret;
>  
>  		tpm1_do_selftest(chip);
>  
> -		release_locality(chip, 0);
> +		tpm_tis_release_locality(chip, 0);
>  	}
>  
>  	return 0;
> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
> index e005eb99480e..7c6c14707e31 100644
> --- a/drivers/char/tpm/tpm_tis_core.h
> +++ b/drivers/char/tpm/tpm_tis_core.h
> @@ -91,6 +91,8 @@ enum tpm_tis_flags {
>  
>  struct tpm_tis_data {
>  	u16 manufacturer_id;
> +	struct mutex locality_count_mutex;
> +	unsigned int locality_count;
>  	int locality;
>  	int irq;
>  	unsigned int int_mask;
> -- 
> 2.25.1
> 

I'm kind of thinking that should tpm_tis_data have a lock for its
contents?

I kind of doubt that we would ever need more than one lock for it,
and it would give some more ensurance to not be race, especially
when re-enabling interrupts this feels important to be "extra safe".

I looked at this commit, and did not see anything that would prevent
using a spin lock instead of mutex. With a spin lock priv can be
accessed also in the interrupt context.

So instead prepend this patch with a patch that adds:

        struct spin_lock lock;

And something like:

        static inline struct tpm_tis_data *tpm_tis_priv_get(struct tpm_chip *chip)
        {
                struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);

                spin_lock(&priv->lock); 
                return priv; 
        }

        static inline void tpm_tis_priv_put(struct tpm_tis_data *priv)
        {
                spin_unlock(&priv->lock);
        }

And change the sites where priv is used to acquire the instance with this.

BR, Jarkko
