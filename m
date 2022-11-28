Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BBF639EE2
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Nov 2022 02:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiK1B0S (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 27 Nov 2022 20:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiK1B0S (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 27 Nov 2022 20:26:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D67CD;
        Sun, 27 Nov 2022 17:26:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E873760ED5;
        Mon, 28 Nov 2022 01:26:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0395C433D6;
        Mon, 28 Nov 2022 01:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669598776;
        bh=B1htm4HwGGsFjqztFOgllqoGcM7Hw05Z4A9/DM3em9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P4bvNfXNELqu18a1XgFIe25X9LdhdQY/NcycNVNwIkp32mL3tZt1fvGonl6FNu0Jr
         vFtoVZlmf5UjUy5PGKjxlzP9ty60jbSNIO0FiGmm3peuIK9QWKb8PjqyFV3kWnuV1R
         MnuU+Pv7UmcwtJTulH9MlcYRllzOTS30PBFbAW83A6NCg+KLVhvPU6xFKv+4IyC8Ox
         DQC3+nUKwglqUlfHlbqs2p5XCUMvwFjO8/42QctrQgIpoIhBAivyMZpDFu0FQtL2JL
         v86Kyu4GEPKreQ9G3wrpU+Fw3NH0jXChJN5gHa0E7zFR1Sb/IQMYIHyGHCA/18tm/V
         ls1OOcwEs4+xA==
Date:   Mon, 28 Nov 2022 03:26:12 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, jandryuk@gmail.com,
        pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com, lukas@wunner.de,
        p.rosenberger@kunbus.com
Subject: Re: [PATCH v11 04/14] tpm, tpm_tis: Do not skip reset of original
 interrupt vector
Message-ID: <Y4QONBR0o2IbrQDy@kernel.org>
References: <20221124135538.31020-1-LinoSanfilippo@gmx.de>
 <20221124135538.31020-5-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124135538.31020-5-LinoSanfilippo@gmx.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Nov 24, 2022 at 02:55:28PM +0100, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> If in tpm_tis_probe_irq_single() an error occurs after the original
> interrupt vector has been read, restore the interrupts before the error is
> returned.
> 
> Since the caller does not check the error value, return -1 in any case that
> the TPM_CHIP_FLAG_IRQ flag is not set. Since the return value of function
> tpm_tis_gen_interrupt() is not longer used, make it a void function.
> 
> Fixes: 1107d065fdf1 ("tpm_tis: Introduce intermediate layer for TPM access")
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 29 +++++++++++------------------
>  1 file changed, 11 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 603b82ca56da..81b9726d3ed2 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -729,7 +729,7 @@ static irqreturn_t tis_int_handler(int dummy, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> -static int tpm_tis_gen_interrupt(struct tpm_chip *chip)
> +static void tpm_tis_gen_interrupt(struct tpm_chip *chip)
>  {
>  	const char *desc = "attempting to generate an interrupt";
>  	u32 cap2;
> @@ -738,7 +738,7 @@ static int tpm_tis_gen_interrupt(struct tpm_chip *chip)
>  
>  	ret = request_locality(chip, 0);
>  	if (ret < 0)
> -		return ret;
> +		return;
>  
>  	if (chip->flags & TPM_CHIP_FLAG_TPM2)
>  		ret = tpm2_get_tpm_pt(chip, 0x100, &cap2, desc);
> @@ -746,8 +746,6 @@ static int tpm_tis_gen_interrupt(struct tpm_chip *chip)
>  		ret = tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap, desc, 0);
>  
>  	release_locality(chip, 0);
> -
> -	return ret;
>  }
>  
>  /* Register the IRQ and issue a command that will cause an interrupt. If an
> @@ -777,42 +775,37 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
>  
>  	rc = tpm_tis_write8(priv, TPM_INT_VECTOR(priv->locality), irq);
>  	if (rc < 0)
> -		return rc;
> +		goto restore_irqs;
>  
>  	rc = tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &int_status);
>  	if (rc < 0)
> -		return rc;
> +		goto restore_irqs;
>  
>  	/* Clear all existing */
>  	rc = tpm_tis_write32(priv, TPM_INT_STATUS(priv->locality), int_status);
>  	if (rc < 0)
> -		return rc;
> -
> +		goto restore_irqs;
>  	/* Turn on */
>  	rc = tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality),
>  			     intmask | TPM_GLOBAL_INT_ENABLE);
>  	if (rc < 0)
> -		return rc;
> +		goto restore_irqs;
>  
>  	clear_bit(TPM_TIS_IRQ_TESTED, &priv->flags);
>  
>  	/* Generate an interrupt by having the core call through to
>  	 * tpm_tis_send
>  	 */
> -	rc = tpm_tis_gen_interrupt(chip);
> -	if (rc < 0)
> -		return rc;
> +	tpm_tis_gen_interrupt(chip);
>  
> +restore_irqs:
>  	/* tpm_tis_send will either confirm the interrupt is working or it
>  	 * will call disable_irq which undoes all of the above.
>  	 */
>  	if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
> -		rc = tpm_tis_write8(priv, original_int_vec,
> -				TPM_INT_VECTOR(priv->locality));
> -		if (rc < 0)
> -			return rc;
> -
> -		return 1;
> +		tpm_tis_write8(priv, original_int_vec,
> +			       TPM_INT_VECTOR(priv->locality));
> +		return -1;
>  	}
>  
>  	return 0;
> -- 
> 2.36.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
