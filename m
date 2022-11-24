Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB14636F82
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Nov 2022 01:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiKXAzc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Nov 2022 19:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiKXAza (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Nov 2022 19:55:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BDC1CB22;
        Wed, 23 Nov 2022 16:55:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5938E61FA5;
        Thu, 24 Nov 2022 00:55:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D30AC433C1;
        Thu, 24 Nov 2022 00:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669251326;
        bh=pLW65m8aHNW4BJNIPMaKb6eMDExChW0Rr5u4CD1FHqA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u8uI1hedZS5EklV6Y55pZE/IJmRpt0dY6UX9ajdSlb2gVNu00jflteyrDG3t011hH
         xYLZyxUlYVZerLcvZTwr6qRySZEdj06fpKjb2yWDqAG1j8AbvEIQHFqVosI9BAF76o
         MVqSGXw+zGRJIIr7Toqm/972ARFTEZ4aJzORxFIQGzNv/HFBlNV81/AG9fnRHZE+iY
         skzUMbOwStIIrFTsYjYKl1kleuQcwU3TUF45Cnwa2I0ldizVpg4L3dhylmU9g8jhzV
         ksTCN4ZlsLO1OfDsxrN/0EO5wzdVbhlc3y9P3JmFHSfETt16mr2/V3trdTUEnQJdNT
         CTX1JTwucFk5Q==
Date:   Thu, 24 Nov 2022 02:55:22 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, jandryuk@gmail.com,
        pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com, lukas@wunner.de,
        p.rosenberger@kunbus.com
Subject: Re: [PATCH v10 05/14] tpm, tpm_tis: Claim locality before writing
 interrupt registers
Message-ID: <Y37A+g+E6H6LGn+4@kernel.org>
References: <20221120133134.28926-1-LinoSanfilippo@gmx.de>
 <20221120133134.28926-6-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221120133134.28926-6-LinoSanfilippo@gmx.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Nov 20, 2022 at 02:31:25PM +0100, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> In tpm_tis_probe_single_irq() interrupt registers TPM_INT_VECTOR,
> TPM_INT_STATUS and TPM_INT_ENABLE are modified to setup the interrupts.
> Currently these modifications are done without holding a locality thus they
> have no effect. Fix this by claiming the (default) locality before the
> registers are written.
> 
> Since now tpm_tis_gen_interrupt() is called with the locality already
> claimed remove locality request and release from this function.
> 
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 1eac1279594d..58a53ec534aa 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -734,18 +734,11 @@ static void tpm_tis_gen_interrupt(struct tpm_chip *chip)
>  	const char *desc = "attempting to generate an interrupt";
>  	u32 cap2;
>  	cap_t cap;
> -	int ret;
> -
> -	ret = request_locality(chip, 0);
> -	if (ret < 0)
> -		return;
>  
>  	if (chip->flags & TPM_CHIP_FLAG_TPM2)
>  		tpm2_get_tpm_pt(chip, 0x100, &cap2, desc);
>  	else
>  		tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap, desc, 0);
> -
> -	release_locality(chip, 0);
>  }
>  
>  /* Register the IRQ and issue a command that will cause an interrupt. If an
> @@ -768,10 +761,16 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
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
>  	if (rc < 0)
> @@ -805,10 +804,12 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
>  	if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
>  		tpm_tis_write8(priv, original_int_vec,
>  			       TPM_INT_VECTOR(priv->locality));
> -		return -1;
> +		rc = -1;
>  	}
>  
> -	return 0;
> +	release_locality(chip, priv->locality);
> +
> +	return rc;
>  }
>  
>  /* Try to find the IRQ the TPM is using. This is for legacy x86 systems that
> -- 
> 2.36.1
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
