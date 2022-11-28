Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C3C639EE8
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Nov 2022 02:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiK1B3E (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 27 Nov 2022 20:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiK1B3D (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 27 Nov 2022 20:29:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E76AA461;
        Sun, 27 Nov 2022 17:29:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D8EE60F53;
        Mon, 28 Nov 2022 01:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF52C433D7;
        Mon, 28 Nov 2022 01:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669598939;
        bh=2J3xNZDQoeEripp4SMFhNJ+YDa5yHhIfCSU4QcV7Mj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aRtNVL+krhH2+mFtQU52seUZVwlWjFQk4Wsyv7VRf2WFCVm+2eXo9Wm+pi046wMY/
         0jiSOyyyNxOhv6cBknBHN1CiH20DcsOO8ULuePmyyk+ds0Kt6YYQTq4qWVnEqMAHnj
         3B34cJN2PInF7Uw90mUiq08HoFMpZf63J3uMVscTmDIer/9S22kjp4V74wM2+BP33H
         hB/FnULz8tcB+SfTbSjavP0MFQknxva2joApj9D8WShROu48wXpvWolXUzIW0eAAMK
         c0lNF2Uj+lNp9gnehmfZAcqaPseMMDYA2mhX+NbNh1btAQD5aEcah8Gkutj5NMjGQ1
         bNb4IKEKzemsg==
Date:   Mon, 28 Nov 2022 03:28:55 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, jandryuk@gmail.com,
        pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com, lukas@wunner.de,
        p.rosenberger@kunbus.com
Subject: Re: [PATCH v11 09/14] tpm, tpm: Implement usage counter for locality
Message-ID: <Y4QO14Otk+u5Nxl4@kernel.org>
References: <20221124135538.31020-1-LinoSanfilippo@gmx.de>
 <20221124135538.31020-10-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221124135538.31020-10-LinoSanfilippo@gmx.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Nov 24, 2022 at 02:55:33PM +0100, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> Implement a usage counter for the (default) locality used by the TPM TIS
> driver:
> Request the locality from the TPM if it has not been claimed yet, otherwise
> only increment the counter. Also release the locality if the counter is 0
> otherwise only decrement the counter. Since in case of SPI the register
> accesses are locked by means of the SPI bus mutex use a sleepable lock
> (i.e. also a mutex) to ensure thread-safety of the counter which may be
> accessed by both a userspace thread and the interrupt handler.
> 
> By doing this refactor the names of the amended functions to use a more
> appropriate prefix.
> 
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> Tested-by: Michael Niewöhner <linux@mniewoehner.de>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 63 +++++++++++++++++++++++----------
>  drivers/char/tpm/tpm_tis_core.h |  2 ++
>  2 files changed, 47 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index d705dfb64cf9..f00f1057fd27 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -165,16 +165,27 @@ static bool check_locality(struct tpm_chip *chip, int l)
>  	return false;
>  }
>  
> -static int release_locality(struct tpm_chip *chip, int l)
> +static int __tpm_tis_relinquish_locality(struct tpm_tis_data *priv, int l)
> +{
> +	tpm_tis_write8(priv, TPM_ACCESS(l), TPM_ACCESS_ACTIVE_LOCALITY);
> +
> +	return 0;
> +}
> +
> +static int tpm_tis_relinquish_locality(struct tpm_chip *chip, int l)
>  {
>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>  
> -	tpm_tis_write8(priv, TPM_ACCESS(l), TPM_ACCESS_ACTIVE_LOCALITY);
> +	mutex_lock(&priv->locality_count_mutex);
> +	priv->locality_count--;
> +	if (priv->locality_count == 0)
> +		__tpm_tis_relinquish_locality(priv, l);
> +	mutex_unlock(&priv->locality_count_mutex);
>  
>  	return 0;
>  }
>  
> -static int request_locality(struct tpm_chip *chip, int l)
> +static int __tpm_tis_request_locality(struct tpm_chip *chip, int l)
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
> +		ret = __tpm_tis_request_locality(chip, l);
> +	if (!ret)
> +		priv->locality_count++;
> +	mutex_unlock(&priv->locality_count_mutex);
> +	return ret;
> +}
> +
>  static u8 tpm_tis_status(struct tpm_chip *chip)
>  {
>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> @@ -682,7 +707,7 @@ static int probe_itpm(struct tpm_chip *chip)
>  	if (vendor != TPM_VID_INTEL)
>  		return 0;
>  
> -	if (request_locality(chip, 0) != 0)
> +	if (tpm_tis_request_locality(chip, 0) != 0)
>  		return -EBUSY;
>  
>  	rc = tpm_tis_send_data(chip, cmd_getticks, len);
> @@ -703,7 +728,7 @@ static int probe_itpm(struct tpm_chip *chip)
>  
>  out:
>  	tpm_tis_ready(chip);
> -	release_locality(chip, priv->locality);
> +	tpm_tis_relinquish_locality(chip, priv->locality);
>  
>  	return rc;
>  }
> @@ -788,14 +813,14 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
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
> +		tpm_tis_relinquish_locality(chip, priv->locality);
>  		return rc;
>  	}
>  
> @@ -834,7 +859,7 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
>  		rc = -1;
>  	}
>  
> -	release_locality(chip, priv->locality);
> +	tpm_tis_relinquish_locality(chip, priv->locality);
>  
>  	return rc;
>  }
> @@ -950,8 +975,8 @@ static const struct tpm_class_ops tpm_tis = {
>  	.req_complete_mask = TPM_STS_DATA_AVAIL | TPM_STS_VALID,
>  	.req_complete_val = TPM_STS_DATA_AVAIL | TPM_STS_VALID,
>  	.req_canceled = tpm_tis_req_canceled,
> -	.request_locality = request_locality,
> -	.relinquish_locality = release_locality,
> +	.request_locality = tpm_tis_request_locality,
> +	.relinquish_locality = tpm_tis_relinquish_locality,
>  	.clk_enable = tpm_tis_clkrun_enable,
>  };
>  
> @@ -985,6 +1010,8 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  	priv->timeout_min = TPM_TIMEOUT_USECS_MIN;
>  	priv->timeout_max = TPM_TIMEOUT_USECS_MAX;
>  	priv->phy_ops = phy_ops;
> +	priv->locality_count = 0;
> +	mutex_init(&priv->locality_count_mutex);
>  
>  	dev_set_drvdata(&chip->dev, priv);
>  
> @@ -1063,14 +1090,14 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
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
> +	tpm_tis_relinquish_locality(chip, 0);
>  
>  	rc = tpm_chip_start(chip);
>  	if (rc)
> @@ -1104,13 +1131,13 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
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
> +		tpm_tis_relinquish_locality(chip, 0);
>  
>  		if (rc) {
>  			dev_err(dev, "Could not get TPM timeouts and durations\n");
> @@ -1130,11 +1157,11 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  			dev_err(&chip->dev, FW_BUG
>  					"TPM interrupt not working, polling instead\n");
>  
> -			rc = request_locality(chip, 0);
> +			rc = tpm_tis_request_locality(chip, 0);
>  			if (rc < 0)
>  				goto out_err;
>  			disable_interrupts(chip);
> -			release_locality(chip, 0);
> +			tpm_tis_relinquish_locality(chip, 0);
>  		}
>  	}
>  
> @@ -1201,13 +1228,13 @@ int tpm_tis_resume(struct device *dev)
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
> +		tpm_tis_relinquish_locality(chip, 0);
>  	}
>  
>  	return 0;
> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
> index 2deef11c88db..13bdcf38e56f 100644
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
> 2.36.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
