Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F194F7C7D
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Apr 2022 12:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiDGKPV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 7 Apr 2022 06:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiDGKPU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 7 Apr 2022 06:15:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE8FF7D;
        Thu,  7 Apr 2022 03:13:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3359261331;
        Thu,  7 Apr 2022 10:13:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B024EC385A0;
        Thu,  7 Apr 2022 10:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649326398;
        bh=kv4VPfhv936hoI5/MSPdmDXKBAIHMAivA8NCZwL5fhw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qLb1Ou9D1Q+b6fYnbgsJLBuKduQ1/LUFVFt/v8xSIWrzM+YK8Bd7VcfX3k0QO2Lqv
         ObjVoWt7r0vgCn886+RoA7A6mVs2OFRD8189cF4nXn4hyJAIHYxy4mBz5P5A/rCZvJ
         1gV7ddFRhG4QGo06up4yFY6JskokcA/frnTHb5SUFc1v4bTXqBp9wZKxBiB+wKvuwo
         Ok0//mxjGHh1mebahBwSUJLUV0tdAQfhnJSNqhcmhHfLNeSlf0JWDzU1Gc5q390V9/
         fSISez990QT6WO9nD5HRRj0IqG0JNq30QsckrWeP64TKFsuHRT1SP9+kf4WS9cRO0Y
         Ceiux4ACF4vlA==
Date:   Thu, 7 Apr 2022 13:14:27 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     "Jes B. Klinke" <jbk@chromium.org>
Cc:     linux-integrity@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: cr50: Add new device/vendor ID 0x504a6666
Message-ID: <Yk65g6frcMRyOPTK@kernel.org>
References: <20220405173741.4023216-1-jbk@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405173741.4023216-1-jbk@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Apr 05, 2022 at 10:37:41AM -0700, Jes B. Klinke wrote:
> Accept one additional numerical value of DID:VID for next generation
> Google TPM, to be used in future Chromebooks.
> 
> This patch touches more lines than may seem necessary, as a result of
> the need to move the error case to sit after the two recognized cases.
> 
> Signed-off-by: Jes B. Klinke <jbk@chromium.org>
> ---
> 
>  drivers/char/tpm/tpm_tis_i2c_cr50.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> index f6c0affbb4567..bf54ebd6724b0 100644
> --- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
> +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> @@ -31,6 +31,7 @@
>  #define TPM_CR50_TIMEOUT_SHORT_MS	2		/* Short timeout during transactions */
>  #define TPM_CR50_TIMEOUT_NOIRQ_MS	20		/* Timeout for TPM ready without IRQ */
>  #define TPM_CR50_I2C_DID_VID		0x00281ae0L	/* Device and vendor ID reg value */
> +#define TPM_TI50_I2C_DID_VID		0x504a6666L	/* Device and vendor ID reg value */
>  #define TPM_CR50_I2C_MAX_RETRIES	3		/* Max retries due to I2C errors */
>  #define TPM_CR50_I2C_RETRY_DELAY_LO	55		/* Min usecs between retries on I2C */
>  #define TPM_CR50_I2C_RETRY_DELAY_HI	65		/* Max usecs between retries on I2C */
> @@ -742,16 +743,20 @@ static int tpm_cr50_i2c_probe(struct i2c_client *client)
>  	}
>  
>  	vendor = le32_to_cpup((__le32 *)buf);
> -	if (vendor != TPM_CR50_I2C_DID_VID) {
> -		dev_err(dev, "Vendor ID did not match! ID was %08x\n", vendor);
> -		tpm_cr50_release_locality(chip, true);
> -		return -ENODEV;
> +	if (vendor == TPM_CR50_I2C_DID_VID) {
> +		dev_info(dev, "cr50 TPM 2.0 (i2c 0x%02x irq %d id 0x%x)\n",
> +			 client->addr, client->irq, vendor >> 16);
> +		return tpm_chip_register(chip);
> +	}
> +	if (vendor == TPM_TI50_I2C_DID_VID) {
> +		dev_info(dev, "ti50 TPM 2.0 (i2c 0x%02x irq %d id 0x%x)\n",
> +			 client->addr, client->irq, vendor >> 16);
> +		return tpm_chip_register(chip);
>  	}
>  
> -	dev_info(dev, "cr50 TPM 2.0 (i2c 0x%02x irq %d id 0x%x)\n",
> -		 client->addr, client->irq, vendor >> 16);
> -
> -	return tpm_chip_register(chip);
> +	dev_err(dev, "Vendor ID did not match! ID was %08x\n", vendor);
> +	tpm_cr50_release_locality(chip, true);
> +	return -ENODEV;
>  }
>  
>  /**
> -- 
> 2.35.1.1094.g7c7d902a7c-goog
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
