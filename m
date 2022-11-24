Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48EBF636EF3
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Nov 2022 01:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiKXAdM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Nov 2022 19:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKXAdL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Nov 2022 19:33:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E00BEB58;
        Wed, 23 Nov 2022 16:33:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D5BCB82196;
        Thu, 24 Nov 2022 00:33:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83228C433D6;
        Thu, 24 Nov 2022 00:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669249988;
        bh=r2YSkx4S3CaVZq6vXL3CvOrMYOo2Ac88h2M8CUqOXbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RAteV+gPaMzc+1HKGPNrokPxyOVOpbqSMVHSE+mu/NcjgbA8rEtJQjhVnFt+Llipl
         n809HBiCaiKavWOO/0AzVwVsfdXO3uZ7+LkH3c51eWqsk7yG1kn7EEUynhPfwms6Oy
         dzX6BMSi5RGjHmNLdoSq3LtyXFzKoUqWFbI0edNnjHvPLwjSiJF/yzCPZqrLfby/mV
         o4EMcnXuH71sBqHLvugwPO+VDmfG9WetMWZEBmzjxZ7c5y2mtptPONWTR4HAqBheMS
         vYFd934zKIOCTnP4qt++38vH4djGYS50BelCm6ZXr/ki1IFwsWHa9673NXzwdFQprA
         lZ6HfP/l2sY6g==
Date:   Thu, 24 Nov 2022 02:32:40 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, jandryuk@gmail.com,
        pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com, lukas@wunner.de,
        p.rosenberger@kunbus.com
Subject: Re: [PATCH v10 12/14] tpm, tpm_tis: Claim locality when interrupts
 are reenabled on resume
Message-ID: <Y367qEbEc6C3/MQj@kernel.org>
References: <20221120133134.28926-1-LinoSanfilippo@gmx.de>
 <20221120133134.28926-13-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221120133134.28926-13-LinoSanfilippo@gmx.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, Nov 20, 2022 at 02:31:32PM +0100, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> In tpm_tis_resume() make sure that the locality has been claimed when
> tpm_tis_reenable_interrupts() is called. Otherwise the writings to the
> register might not have any effect.
> 
> Fixes: 45baa1d1fa39 ("tpm_tis: Re-enable interrupts upon (S3) resume")
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 4312c5cc13da..2514e60f6778 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -1220,28 +1220,27 @@ int tpm_tis_resume(struct device *dev)
>  	struct tpm_chip *chip = dev_get_drvdata(dev);
>  	int ret;
>  
> +	ret = tpm_tis_request_locality(chip, 0);
> +	if (ret < 0)
> +		return ret;
> +
>  	if (chip->flags & TPM_CHIP_FLAG_IRQ)
>  		tpm_tis_reenable_interrupts(chip);
>  
>  	ret = tpm_pm_resume(dev);
>  	if (ret)
> -		return ret;
> +		goto out;
>  
>  	/*
>  	 * TPM 1.2 requires self-test on resume. This function actually returns
>  	 * an error code but for unknown reason it isn't handled.
>  	 */
> -	if (!(chip->flags & TPM_CHIP_FLAG_TPM2)) {
> -		ret = tpm_tis_request_locality(chip, 0);
> -		if (ret < 0)
> -			return ret;
> -
> +	if (!(chip->flags & TPM_CHIP_FLAG_TPM2))
>  		tpm1_do_selftest(chip);
> +out:
> +	tpm_tis_relinquish_locality(chip, 0);
>  
> -		tpm_tis_relinquish_locality(chip, 0);
> -	}
> -
> -	return 0;
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(tpm_tis_resume);
>  #endif
> -- 
> 2.36.1
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
