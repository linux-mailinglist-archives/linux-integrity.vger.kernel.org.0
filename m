Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC876F0889
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Apr 2023 17:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243711AbjD0Pll (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Apr 2023 11:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243700AbjD0Plk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Apr 2023 11:41:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1975E420E
        for <linux-integrity@vger.kernel.org>; Thu, 27 Apr 2023 08:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682610051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YEofZFRl2d8BOu5BwJ07xScSj7ivyiDT35/EYFvK1+Y=;
        b=CSspNxfirBvK/d5ngj35SCIUV+y4HBdCf2T51yiD5YIN2IrFPqnhowaMYk9uAY8fN2c7vG
        lPmZQ415qf3F8KB6njyKJ4Nqt6M4Iv1djpiPYJobm/TSo+ELP6Xqee+rwuiRC8Srlkr0Sy
        D5D3y6MaEZ2AEThfG1IFFDa5yndteys=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-EriRS00AO6mXfL-mT_i4Tg-1; Thu, 27 Apr 2023 11:11:48 -0400
X-MC-Unique: EriRS00AO6mXfL-mT_i4Tg-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-74df5c5fd00so672362985a.3
        for <linux-integrity@vger.kernel.org>; Thu, 27 Apr 2023 08:11:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682608303; x=1685200303;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YEofZFRl2d8BOu5BwJ07xScSj7ivyiDT35/EYFvK1+Y=;
        b=ZyQoe6XHcnu5mhbbV/KflgOVDWa1Wa0CTIVb79dL85DZ+1IwSmgcRa284xT8zGMRbI
         qmaNchImNfosyz/tGOGf7ydQdLNDVfPRJ6B9kBFML2AImvhSlTyLEbCHrpV5LExc1OSz
         PfMJP7DKeSM4QXcGgHS0bGQPKlDSoWqC3bo6f3R6r5CiPtIB8jf3obC6TYXUj6YADQLY
         jbndriVIoVrbC/s0Cspgxs2RFjSWR0E17wjKwRfQgSWny97XURyLc6DEBsV9mb2Vn6LM
         UTduNpcm941W9HONwgvBdruqJJfMEvIy7gaQ2RMRO08VY481TF3rzhQNsXjqjlDJSbUo
         R5Xw==
X-Gm-Message-State: AC+VfDxnztZoLaPEBQrAPQMXrG57eTIh7Z3x6ZnJmM96Fylmw9zfz3eG
        s28FYlsEqtqfj9bb99ML2btFD0SbzFb9H8zV1Gf3UfqgQoS7SZZk1rCNKBGvoRClenZHUWmGcES
        CfdbQJIJyRzAQCuJeTeV7BxBv+Ix2
X-Received: by 2002:a05:622a:46:b0:3ef:2db1:6e75 with SMTP id y6-20020a05622a004600b003ef2db16e75mr3419079qtw.24.1682608303213;
        Thu, 27 Apr 2023 08:11:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5f58NHVqn1RA2uKocIydh5vQ5dAAMKPYsXYY23arXK+tFiRm0qCVuoSCXJRiBpsH9QLmxHKg==
X-Received: by 2002:a05:622a:46:b0:3ef:2db1:6e75 with SMTP id y6-20020a05622a004600b003ef2db16e75mr3419054qtw.24.1682608302970;
        Thu, 27 Apr 2023 08:11:42 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id t10-20020a05622a148a00b003eec85171d6sm6235196qtx.61.2023.04.27.08.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 08:11:42 -0700 (PDT)
Date:   Thu, 27 Apr 2023 08:11:40 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        stable@vger.kernel.org, "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH 1/2] tpm_tis: Use tpm_chip_{start,stop} decoration inside
 tpm_tis_resume
Message-ID: <5qxby65cn22wolrlm4xemxfpfxyjgwjchhoev45egiwaubrqdc@f2ufxypkhnjt>
References: <20230426172928.3963287-1-jarkko@kernel.org>
 <20230426172928.3963287-2-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230426172928.3963287-2-jarkko@kernel.org>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Apr 26, 2023 at 08:29:27PM +0300, Jarkko Sakkinen wrote:
> Before sending a TPM command, CLKRUN protocol must be disabled. This is not
> done in the case of tpm1_do_selftest() call site inside tpm_tis_resume().
> 
> Address this by decorating the calls with tpm_chip_{start,stop}, which arm
> and disarm the TPM chip for transmission, and take care of disabling and
> re-enabling CLKRUN, among other things.
> 
> Cc: stable@vger.kernel.org
> Reported-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Link: https://lore.kernel.org/linux-integrity/CS68AWILHXS4.3M36M1EKZLUMS@suppilovahvero/
> Fixes: a3fbfae82b4c ("tpm: take TPM chip power gating out of tpm_transmit()")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 43 +++++++++++++++------------------
>  1 file changed, 19 insertions(+), 24 deletions(-)


Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com

> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index c2421162cf34..73707026e358 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -1209,25 +1209,20 @@ static void tpm_tis_reenable_interrupts(struct tpm_chip *chip)
>  	u32 intmask;
>  	int rc;
>  
> -	if (chip->ops->clk_enable != NULL)
> -		chip->ops->clk_enable(chip, true);
> -
> -	/* reenable interrupts that device may have lost or
> -	 * BIOS/firmware may have disabled
> +	/*
> +	 * Re-enable interrupts that device may have lost or BIOS/firmware may
> +	 * have disabled.
>  	 */
>  	rc = tpm_tis_write8(priv, TPM_INT_VECTOR(priv->locality), priv->irq);
> -	if (rc < 0)
> -		goto out;
> +	if (rc < 0) {
> +		dev_err(&chip->dev, "Setting IRQ failed.\n");
> +		return;
> +	}
>  
>  	intmask = priv->int_mask | TPM_GLOBAL_INT_ENABLE;
> -
> -	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
> -
> -out:
> -	if (chip->ops->clk_enable != NULL)
> -		chip->ops->clk_enable(chip, false);
> -
> -	return;
> +	rc = tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
> +	if (rc < 0)
> +		dev_err(&chip->dev, "Enabling interrupts failed.\n");
>  }
>  
>  int tpm_tis_resume(struct device *dev)
> @@ -1235,27 +1230,27 @@ int tpm_tis_resume(struct device *dev)
>  	struct tpm_chip *chip = dev_get_drvdata(dev);
>  	int ret;
>  
> -	ret = tpm_tis_request_locality(chip, 0);
> -	if (ret < 0)
> +	ret = tpm_chip_start(chip);
> +	if (ret)
>  		return ret;
>  
>  	if (chip->flags & TPM_CHIP_FLAG_IRQ)
>  		tpm_tis_reenable_interrupts(chip);
>  
> -	ret = tpm_pm_resume(dev);
> -	if (ret)
> -		goto out;
> -
>  	/*
>  	 * TPM 1.2 requires self-test on resume. This function actually returns
>  	 * an error code but for unknown reason it isn't handled.
>  	 */
>  	if (!(chip->flags & TPM_CHIP_FLAG_TPM2))
>  		tpm1_do_selftest(chip);
> -out:
> -	tpm_tis_relinquish_locality(chip, 0);
>  
> -	return ret;
> +	tpm_chip_stop(chip);
> +
> +	ret = tpm_pm_resume(dev);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(tpm_tis_resume);
>  #endif
> -- 
> 2.39.2
> 

