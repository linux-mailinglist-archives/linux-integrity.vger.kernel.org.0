Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799C954D0E3
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jun 2022 20:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240583AbiFOS04 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jun 2022 14:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242474AbiFOS0z (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jun 2022 14:26:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0702C46CA2;
        Wed, 15 Jun 2022 11:26:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2F47B820BE;
        Wed, 15 Jun 2022 18:26:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2465C34115;
        Wed, 15 Jun 2022 18:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655317612;
        bh=fRkYpPI/6cwJUF3rOB9VLtfSWvCjuLf4RTvivAv/DBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HtDiTPjlMT83zHhELaNuA/+2c1NlwH5Ow5Rm8ZVZtoRg5o3/ZhroNh4y2vyZNzIRN
         FE8V9FvXXCQgBiJeeSMGP5/pDfgIdgLn3LLAJktTzMK8nVIgSdbtMTvXnPM5yC0cAR
         y1UQofHHjAb48UsyJ212i+uFOj5w0x8C9ou7iPh8fCDRiF8iu76zWIqrhwv+z5OkCc
         ZgWAxxUeRlbgqbdPVOvY6Dg+sg7id/ce2aeFMv3ZRdEhnFtOOBgJY2qeMQUJIqDZBy
         PMe/IdmNWhkT7ZaHbDdC/0vC3XUjMtmbCGbqa+SQl7HKqrUA2vmytkaenvorjvr78f
         +4SNJuWrzVaxw==
Date:   Wed, 15 Jun 2022 21:24:43 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     LinoSanfilippo@gmx.de
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com
Subject: Re: [PATCH v5 08/10] tpm, tpm_tis: Request threaded interrupt handler
Message-ID: <Yqoj6zaIrNB+aKph@iki.fi>
References: <20220610110846.8307-1-LinoSanfilippo@gmx.de>
 <20220610110846.8307-9-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610110846.8307-9-LinoSanfilippo@gmx.de>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 10, 2022 at 01:08:44PM +0200, LinoSanfilippo@gmx.de wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> The TIS interrupt handler at least has to read and write the interrupt
> status register. In case of SPI both operations result in a call to
> tpm_tis_spi_transfer() which uses the bus_lock_mutex of the spi device
> and thus must only be called from a sleepable context.
> 
> To ensure this request a threaded interrupt handler.
> 
> Fixes: 1a339b658d9d ("tpm_tis_spi: Pass the SPI IRQ down to the driver")
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 0ef74979bc2c..8b5aa4fdbe92 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -794,8 +794,11 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
>  	int rc;
>  	u32 int_status;
>  
> -	if (devm_request_irq(chip->dev.parent, irq, tis_int_handler, flags,
> -			     dev_name(&chip->dev), chip) != 0) {
> +
> +	rc = devm_request_threaded_irq(chip->dev.parent, irq, NULL,
> +				       tis_int_handler, IRQF_ONESHOT | flags,
> +				       dev_name(&chip->dev), chip);
> +	if (rc) {
>  		dev_info(&chip->dev, "Unable to request irq: %d for probe\n",
>  			 irq);
>  		return -1;
> -- 
> 2.36.1
> 

I actually would not add fixes tag to this because given that
interrupt support is quite unusable, this should not cause any
harm.

The code change itself is fine.

BR, Jarkko
