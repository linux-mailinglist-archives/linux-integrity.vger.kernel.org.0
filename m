Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36947641E18
	for <lists+linux-integrity@lfdr.de>; Sun,  4 Dec 2022 18:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiLDRCD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 4 Dec 2022 12:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiLDRCC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 4 Dec 2022 12:02:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A0525F9;
        Sun,  4 Dec 2022 09:02:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2602660EB7;
        Sun,  4 Dec 2022 17:02:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F76C433C1;
        Sun,  4 Dec 2022 17:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670173320;
        bh=qzIh5lYDbuWNcCiYp8t2nrrPpr4S52NNRYnpTEYgCSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kH2oAviqxL46MHZpQ731QJCNCu9f/D3QfimG5ibVgi4wiW6mPB53e/GUwaoZ2leR4
         PxVrG9wnKe+uveeFbF6jHbrE+4XcDLf7N5t0YysBu5365vJSHuLwgkDKG9y2jVIZx2
         VRt4F5wdhBh19s+3R/vNncnSFAu5OplNlW+wzjbqoBZdfqQtGC/rLxMi3U8YRqIrBZ
         6kMik7nAnp/4WxIlShkWD0nVeeNo+gyk+f4wuUq0W4ux/JiuqWL+GBv2jtMNTKuBGU
         +fRqRCv8gMOsdX2mJz0ky/Ndwzld3CF8SpPPyqqI6FoztFS4175x9vKI4SZPnLH1bL
         F0iv5qwyWg6EA==
Date:   Sun, 4 Dec 2022 17:01:56 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, jandryuk@gmail.com,
        pmenzel@molgen.mpg.de, l.sanfilippo@kunbus.com, lukas@wunner.de,
        p.rosenberger@kunbus.com
Subject: Re: [PATCH v11 13/14] tpm, tpm_tis: startup chip before testing for
 interrupts
Message-ID: <Y4zSbKvNa6S5kIYJ@kernel.org>
References: <20221124135538.31020-1-LinoSanfilippo@gmx.de>
 <20221124135538.31020-14-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124135538.31020-14-LinoSanfilippo@gmx.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Nov 24, 2022 at 02:55:37PM +0100, Lino Sanfilippo wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> In tpm_tis_gen_interrupt() a request for a property value is sent to the
> TPM to test if interrupts are generated. However after a power cycle the
> TPM responds with TPM_RC_INITIALIZE which indicates that the TPM is not
> yet properly initialized.
> Fix this by first starting the TPM up before the request is sent. For this
> the startup implementation is removed from tpm_chip_register() and put
> into the new function tpm_chip_startup() which is called before the
> interrupts are tested.
> 
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/char/tpm/tpm-chip.c     | 38 +++++++++++++++++++++------------
>  drivers/char/tpm/tpm.h          |  1 +
>  drivers/char/tpm/tpm_tis_core.c |  5 +++++
>  3 files changed, 30 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 783d65fc71f0..370aa1f529f2 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -543,6 +543,30 @@ static int tpm_get_pcr_allocation(struct tpm_chip *chip)
>  	return rc;
>  }
>  
> +/*
> + * tpm_chip_startup() - performs auto startup and allocates the PCRs
> + * @chip: TPM chip to use.
> + */
> +int tpm_chip_startup(struct tpm_chip *chip)
> +{
> +	int rc;
> +
> +	rc = tpm_chip_start(chip);
> +	if (rc)
> +		return rc;
> +
> +	rc = tpm_auto_startup(chip);
> +	if (rc)
> +		goto stop;
> +
> +	rc = tpm_get_pcr_allocation(chip);
> +stop:
> +	tpm_chip_stop(chip);
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_GPL(tpm_chip_startup);
> +
>  /*
>   * tpm_chip_register() - create a character device for the TPM chip
>   * @chip: TPM chip to use.
> @@ -558,20 +582,6 @@ int tpm_chip_register(struct tpm_chip *chip)
>  {
>  	int rc;
>  
> -	rc = tpm_chip_start(chip);
> -	if (rc)
> -		return rc;
> -	rc = tpm_auto_startup(chip);
> -	if (rc) {
> -		tpm_chip_stop(chip);
> -		return rc;
> -	}
> -
> -	rc = tpm_get_pcr_allocation(chip);
> -	tpm_chip_stop(chip);
> -	if (rc)
> -		return rc;
> -
>  	tpm_sysfs_add_device(chip);
>  
>  	tpm_bios_log_setup(chip);
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 24ee4e1cc452..919bb0b88b12 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -190,6 +190,7 @@ static inline void tpm_msleep(unsigned int delay_msec)
>  		     delay_msec * 1000);
>  };
>  
> +int tpm_chip_startup(struct tpm_chip *chip);
>  int tpm_chip_start(struct tpm_chip *chip);
>  void tpm_chip_stop(struct tpm_chip *chip);
>  struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip);
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index ddaf362e62c1..94a2bfb244b3 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -1129,6 +1129,11 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  	/* INTERRUPT Setup */
>  	init_waitqueue_head(&priv->read_queue);
>  	init_waitqueue_head(&priv->int_queue);
> +
> +	rc = tpm_chip_startup(chip);
> +	if (rc)
> +		goto out_err;
> +
>  	if (irq != -1) {
>  		/*
>  		 * Before doing irq testing issue a command to the TPM in polling mode
> -- 
> 2.36.1
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
