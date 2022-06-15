Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4067354D0C3
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jun 2022 20:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245251AbiFOSPq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jun 2022 14:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242198AbiFOSPq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jun 2022 14:15:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D04354027;
        Wed, 15 Jun 2022 11:15:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E548B820BE;
        Wed, 15 Jun 2022 18:15:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66435C34115;
        Wed, 15 Jun 2022 18:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655316942;
        bh=v5SELp/Zv2AwkgsyVxbExTIxFpzr4qyKKQyN+fu3A9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QO1j/2XVlASvfLqrtFY6TxfP1GHbXW6kWk8Tvoi288I+5kenqR15LJ21aFUqymED8
         j/7spvV4eq2S+25vNz/5V7jnobRWsKMLrlpwh1lQFQ2yo17Rnl1QdFTZcXf80c+o4P
         +QHjYtlso7dIqsuBEI7ZkXLV5haZS4zim81omF1z5rScIyoXLbyAnuEhF96uOy+um3
         Bf85eHGhLbDqjKfDCiGDJoBA+ZVe7/wfH4nRhEdgoi0sN9coeyvJfU8uSYqhqm50MF
         uPeHKS5HQUAgXit4teFKs3aHdIk77DS9Eao0WcP1nMHamPuiyXGOMoY5isCGJ3PXW7
         TkNB0or1AXdZg==
Date:   Wed, 15 Jun 2022 21:13:34 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     LinoSanfilippo@gmx.de
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com
Subject: Re: [PATCH v5 04/10] tpm, tmp_tis: Claim locality before writing
 interrupt registers
Message-ID: <YqohTtlsRw8WJ8Y0@iki.fi>
References: <20220610110846.8307-1-LinoSanfilippo@gmx.de>
 <20220610110846.8307-5-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610110846.8307-5-LinoSanfilippo@gmx.de>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 10, 2022 at 01:08:40PM +0200, LinoSanfilippo@gmx.de wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> In tpm_tis_probe_single_irq interrupt registers TPM_INT_VECTOR,

nit: tpm_tis_probe_single_irq()

> TPM_INT_STATUS and TPM_INT_ENABLE are modified to setup the interrupts.
> Currently these modifications are done without holding a locality thus they
> have no effect. Fix this by claiming the (default) locality before the
> registers are written.
> 
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index dee701609b80..718525fcadc0 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -756,30 +756,45 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
>  	}
>  	priv->irq = irq;
>  
> +	rc = request_locality(chip, 0);
> +	if (rc < 0)
> +		return rc;
> +
>  	rc = tpm_tis_read8(priv, TPM_INT_VECTOR(priv->locality),
>  			   &original_int_vec);
> -	if (rc < 0)
> +	if (rc < 0) {
> +		release_locality(chip, priv->locality);
>  		return rc;
> +	}
>  
>  	rc = tpm_tis_write8(priv, TPM_INT_VECTOR(priv->locality), irq);
> -	if (rc < 0)
> +	if (rc < 0) {
> +		release_locality(chip, priv->locality);
>  		return rc;
> +	}
>  
>  	rc = tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &int_status);
> -	if (rc < 0)
> +	if (rc < 0) {
> +		release_locality(chip, priv->locality);
>  		return rc;
> +	}
>  
>  	/* Clear all existing */
>  	rc = tpm_tis_write32(priv, TPM_INT_STATUS(priv->locality), int_status);
> -	if (rc < 0)
> +	if (rc < 0) {
> +		release_locality(chip, priv->locality);
>  		return rc;
> +	}
>  
>  	/* Turn on */
>  	rc = tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality),
>  			     intmask | TPM_GLOBAL_INT_ENABLE);
> -	if (rc < 0)
> +	if (rc < 0) {
> +		release_locality(chip, priv->locality);
>  		return rc;
> +	}
>  
> +	release_locality(chip, priv->locality);
>  	clear_bit(TPM_TIS_IRQ_TESTED, &priv->irqtest_flags);
>  
>  	/* Generate an interrupt by having the core call through to
> -- 
> 2.36.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
