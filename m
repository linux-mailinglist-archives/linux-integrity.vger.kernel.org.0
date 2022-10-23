Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71809609128
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Oct 2022 06:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJWEcg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 23 Oct 2022 00:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiJWEcg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 23 Oct 2022 00:32:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50134785A2;
        Sat, 22 Oct 2022 21:32:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DBCAAB80BA4;
        Sun, 23 Oct 2022 04:32:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297DBC433D6;
        Sun, 23 Oct 2022 04:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666499551;
        bh=sirvSAtiv504QnaXIWE9W4xA3lx621yDIWT/Uekn+Yo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tutucQVptfhT1VaZwUYwkwNTuwgUkehk7uiCUUiCu28qhiYM5FkIyqFTAUmrFxQjK
         RpCOUJ2y9wWiwQXa1COJQxZOeOvUaJuC3i+lj4Pn8mHVzsoqino5YT+6R439mSr3kG
         id4uQeRY/i/VyC11U7jwuDPfythkFAjkQMfuoAnFQq356xvTQgJ5QJx9NsWB9qvcCy
         sx+uolpkKoPuNeOnp0UeKbS1TL3TJ2/3YW7iXaDEtDa1fv06Vv+Fu7SE1vA034BWYQ
         EZedqBpvPyvqJnPLPe+WRKHT4KwWQpCDc5iYWW+m2U3ERIn6ymTXytJf7FdEgzYjx9
         kJLrDWjWD/9ag==
Date:   Sun, 23 Oct 2022 07:32:24 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, jandryuk@gmail.com,
        pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com, lukas@wunner.de,
        p.rosenberger@kunbus.com
Subject: Re: [PATCH v8 07/11] tpm, tpm_tis: do not check for the active
 locality in interrupt handler
Message-ID: <Y1TD2G9osaaJPanS@kernel.org>
References: <20221017235732.10145-1-LinoSanfilippo@gmx.de>
 <20221017235732.10145-8-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017235732.10145-8-LinoSanfilippo@gmx.de>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Oct 18, 2022 at 01:57:28AM +0200, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> After driver initialization tpm_tis_data->locality may only be modified in
> case of a LOCALITY CHANGE interrupt. In this case the interrupt handler
> iterates over all localities only to assign the active one to
> tpm_tis_data->locality.
> 
> However this information is never used any more, so the assignment is not
> needed.
> Furthermore without the assignment tpm_tis_data->locality cannot change any
> more at driver runtime, and thus no protection against concurrent
> modification is required when the variable is read at other places.
> 
> So remove this iteration entirely.
> 
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

> ---
>  drivers/char/tpm/tpm_tis_core.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 181c291b0bb8..4336f7ea8c2b 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -728,7 +728,7 @@ static irqreturn_t tis_int_handler(int dummy, void *dev_id)
>  	struct tpm_chip *chip = dev_id;
>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>  	u32 interrupt;
> -	int i, rc;
> +	int rc;
>  
>  	rc = tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &interrupt);
>  	if (rc < 0)
> @@ -740,10 +740,7 @@ static irqreturn_t tis_int_handler(int dummy, void *dev_id)
>  	set_bit(TPM_TIS_IRQ_TESTED, &priv->flags);
>  	if (interrupt & TPM_INTF_DATA_AVAIL_INT)
>  		wake_up_interruptible(&priv->read_queue);
> -	if (interrupt & TPM_INTF_LOCALITY_CHANGE_INT)
> -		for (i = 0; i < 5; i++)
> -			if (check_locality(chip, i))
> -				break;
> +
>  	if (interrupt &
>  	    (TPM_INTF_LOCALITY_CHANGE_INT | TPM_INTF_STS_VALID_INT |
>  	     TPM_INTF_CMD_READY_INT))
> -- 
> 2.36.1
> 

BR, Jarkko
