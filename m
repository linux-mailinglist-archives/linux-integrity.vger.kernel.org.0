Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABDB523175
	for <lists+linux-integrity@lfdr.de>; Wed, 11 May 2022 13:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241140AbiEKLZT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 May 2022 07:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240040AbiEKLYu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 May 2022 07:24:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76895231CBD;
        Wed, 11 May 2022 04:24:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2EB35B82217;
        Wed, 11 May 2022 11:24:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64379C340F3;
        Wed, 11 May 2022 11:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652268250;
        bh=NQicI0jcyEUR6Fudb4tAuvnUgZQIKvtt0icfl6gJwCQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pnBq/HSTjd3IX5sroatFQhgvdbBjXhvbHffVsFtilrhkEoDFaahS2RpfiISzkj9/q
         +70G4JvExSROBu6aP+NSwstIiLgpTbYMT8BrQLnif2MjgAO2CXa/8bCodBzIb2mwlP
         UAJzOlOVQ8Weqw0AxA7sibne2diwYozkBr+xd8D6pzOMtsXfnkTMD9RXOYtTlVMvRz
         BekSrBKVaehn0qCWxIpqo1wKNaTHp6Re5mKd2BfZ8UfKC7o9zuwn5CC7zzOZYye3TV
         0TAppL932+y9djCzIN2auQEGWZNnTrA+womq4ZDhZ0zc3vy/40sjrPpASg8101A92d
         pvr1Q1EHNsd5Q==
Date:   Wed, 11 May 2022 14:22:40 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de,
        p.rosenberger@kunbus.com, Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH v4 1/6] tpm, tpm_tis_spi: Request threaded irq
Message-ID: <YnucgDH3I87RI8PN@kernel.org>
References: <20220509080559.4381-1-LinoSanfilippo@gmx.de>
 <20220509080559.4381-2-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509080559.4381-2-LinoSanfilippo@gmx.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, May 09, 2022 at 10:05:54AM +0200, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> Interrupt handling at least includes reading and writing the interrupt
> status register within the interrupt routine. Since accesses over the SPI
> bus are synchronized by a mutex, request a threaded interrupt handler to
> ensure a sleepable context during interrupt processing.
> 
> Fixes: 1a339b658d9d ("tpm_tis_spi: Pass the SPI IRQ down to the driver")
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>

When you state that it needs a sleepable context, you should bring a
context why it needs it. This not to disregard the code change overally but
you cannot make even the most obvious claim without backing data.

> ---
>  drivers/char/tpm/tpm_tis_core.c     | 15 +++++++++++++--
>  drivers/char/tpm/tpm_tis_core.h     |  1 +
>  drivers/char/tpm/tpm_tis_spi_main.c |  5 +++--
>  3 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index dc56b976d816..52369ef39b03 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -747,8 +747,19 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
>  	int rc;
>  	u32 int_status;
>  
> -	if (devm_request_irq(chip->dev.parent, irq, tis_int_handler, flags,
> -			     dev_name(&chip->dev), chip) != 0) {
> +
> +	if (priv->flags & TPM_TIS_USE_THREADED_IRQ) {
> +		rc = devm_request_threaded_irq(chip->dev.parent, irq, NULL,
> +					       tis_int_handler,
> +					       IRQF_ONESHOT | flags,
> +					       dev_name(&chip->dev),
> +					       chip);
> +	} else {
> +		rc = devm_request_irq(chip->dev.parent, irq, tis_int_handler,
> +				      flags, dev_name(&chip->dev), chip);
> +	}
> +
> +	if (rc) {
>  		dev_info(&chip->dev, "Unable to request irq: %d for probe\n",
>  			 irq);
>  		return -1;
> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
> index 3be24f221e32..43b724e55192 100644
> --- a/drivers/char/tpm/tpm_tis_core.h
> +++ b/drivers/char/tpm/tpm_tis_core.h
> @@ -86,6 +86,7 @@ enum tis_defaults {
>  enum tpm_tis_flags {
>  	TPM_TIS_ITPM_WORKAROUND		= BIT(0),
>  	TPM_TIS_INVALID_STATUS		= BIT(1),
> +	TPM_TIS_USE_THREADED_IRQ	= BIT(2),
>  };
>  
>  struct tpm_tis_data {
> diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
> index 184396b3af50..f56613f2946f 100644
> --- a/drivers/char/tpm/tpm_tis_spi_main.c
> +++ b/drivers/char/tpm/tpm_tis_spi_main.c
> @@ -223,9 +223,10 @@ static int tpm_tis_spi_probe(struct spi_device *dev)
>  	phy->flow_control = tpm_tis_spi_flow_control;
>  
>  	/* If the SPI device has an IRQ then use that */
> -	if (dev->irq > 0)
> +	if (dev->irq > 0) {
>  		irq = dev->irq;
> -	else
> +		phy->priv.flags |= TPM_TIS_USE_THREADED_IRQ;
> +	} else
>  		irq = -1;
>  
>  	init_completion(&phy->ready);
> -- 
> 2.36.0
> 


BR, Jarkko
