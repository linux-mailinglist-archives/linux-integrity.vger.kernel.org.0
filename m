Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEAB562720
	for <lists+linux-integrity@lfdr.de>; Fri,  1 Jul 2022 01:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbiF3Xca (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Jun 2022 19:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232931AbiF3Xca (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Jun 2022 19:32:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5767C564FB;
        Thu, 30 Jun 2022 16:32:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 142E9B82D3D;
        Thu, 30 Jun 2022 23:32:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF4DC34115;
        Thu, 30 Jun 2022 23:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656631946;
        bh=SkLaMnpJNXsbocnQ0nS6E/TN9Vv3ebN0PiTISVWRHM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iJmuw/JaXtNbWxiEEwX5gAZ5GwPtdCxOJTSJq+rBAxeOf5gLVuLsdus+gTjfBNJAa
         try7GffWJQN5Aq/nbgdpMfxV/2S/OEZLUGztAO1eEhB7+XeyzDQVOyuZqhM86zAHgj
         B2qZHIikwfEzjFyh6hGLGgHO8UVc0nLj/5KX9RJcGvMuNi2mEnT3cA1tnV4J7XcrQa
         on/nmIy0nXRxmkTLO5zc/o/U13K0luKGJpxwWbSu8dF1PF6C/rQ0sIqH7Ni2tvhmqf
         1fNHdO/1dXfqEtS34N4hV62cU2TY4I3hnnoEKSDijE1b2CZLWAMesdy0lw4QGifNDn
         HTa/0thdpipmg==
Date:   Fri, 1 Jul 2022 02:32:23 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com
Subject: Re: [PATCH v7 08/10] tpm, tpm_tis: Request threaded interrupt handler
Message-ID: <Yr4yh4u+wSWU1ux5@kernel.org>
References: <20220629232653.1306735-1-LinoSanfilippo@gmx.de>
 <20220629232653.1306735-9-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629232653.1306735-9-LinoSanfilippo@gmx.de>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jun 30, 2022 at 01:26:51AM +0200, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> The TIS interrupt handler at least has to read and write the interrupt
> status register. In case of SPI both operations result in a call to
> tpm_tis_spi_transfer() which uses the bus_lock_mutex of the spi device
> and thus must only be called from a sleepable context.
> 
> To ensure this request a threaded interrupt handler.
> 
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> Tested-by: Michael Niew??hner <linux@mniewoehner.de>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index e50a2c78de9f..83b31c25e55c 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -802,8 +802,11 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
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
> 2.25.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
