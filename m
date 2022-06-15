Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5658854D0DF
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jun 2022 20:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356130AbiFOSZb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jun 2022 14:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245336AbiFOSZ3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jun 2022 14:25:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0748936694;
        Wed, 15 Jun 2022 11:25:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D4BB61C36;
        Wed, 15 Jun 2022 18:25:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39DD5C3411C;
        Wed, 15 Jun 2022 18:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655317527;
        bh=TKz+MoBx361FqhpuLU25ZFeB5xn7vox/KsAYOW8gYoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RuS+3FA3y9QBVx67brxIF+rQqLzjj5xYhKIcjRZbyeLJIP8d2GU3goxuaJSPtV4RN
         I1Z2hekRseMXkqOSGpCG4PXfmS3LnEGmK8RLyGDJto+TtU0i2m3uzYqYSuqcmIgPiC
         toZopFtQ/LYS50vjwzFDrGv4gI+QgvwrpApDwMSlBpDe3KH2fouUWi6notXtZXqYne
         Wn5RbsX28aM5t4vmuq8U0tRr12mJg4kA0SECJ3iB+fd9lVjlG0xgE5rqp3o+sQfeO7
         Mbj/9j8Vxasuuu7uojzDfcBakdbNbqInV+i6dS3Rl7KyBuXZu+4yYtdRM8/H0wY680
         wN8am1Z2u0NbQ==
Date:   Wed, 15 Jun 2022 21:23:18 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     LinoSanfilippo@gmx.de
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com
Subject: Re: [PATCH v5 07/10] tmp, tmp_tis: Implement usage counter for
 locality
Message-ID: <Yqojlh5J0660gfaT@iki.fi>
References: <20220610110846.8307-1-LinoSanfilippo@gmx.de>
 <20220610110846.8307-8-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610110846.8307-8-LinoSanfilippo@gmx.de>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Jun 10, 2022 at 01:08:43PM +0200, LinoSanfilippo@gmx.de wrote:
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> 
> Implement a usage counter for the (default) locality used by the TPM TIS
> driver:
> Request the locality from the TPM if it has not been claimed yet, otherwise
> only increment the counter. Also release the locality if the counter is 0
> otherwise only decrement the counter. Ensure thread-safety by protecting
> the counter with a mutex.
> 
> This allows to request and release the locality from a thread and the
> interrupt handler at the same time without the danger to interfere with
> each other.
> 
> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> ---
>  drivers/char/tpm/tpm_tis_core.c | 30 ++++++++++++++++++++++++++++--
>  drivers/char/tpm/tpm_tis_core.h |  2 ++
>  2 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 028bec44362d..0ef74979bc2c 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -158,16 +158,26 @@ static bool check_locality(struct tpm_chip *chip, int l)
>  	return false;
>  }
>  
> +static int release_locality_locked(struct tpm_tis_data *priv, int l)
> +{
> +	tpm_tis_write8(priv, TPM_ACCESS(l), TPM_ACCESS_ACTIVE_LOCALITY);

nit: empty line here

Also it would not hurt to prefix it with tpm_tis.

This is for simple and practical reasons, like grepping. I don't
mind if you do that also for other functions (if you want to).

> +	return 0;
> +}
> +
>  static int release_locality(struct tpm_chip *chip, int l)
>  {
>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>  
> -	tpm_tis_write8(priv, TPM_ACCESS(l), TPM_ACCESS_ACTIVE_LOCALITY);
> +	mutex_lock(&priv->locality_count_mutex);
> +	priv->locality_count--;
> +	if (priv->locality_count == 0)
> +		release_locality_locked(priv, l);
> +	mutex_unlock(&priv->locality_count_mutex);
>  
>  	return 0;
>  }
>  
> -static int request_locality(struct tpm_chip *chip, int l)
> +static int request_locality_locked(struct tpm_chip *chip, int l)
>  {
>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
>  	unsigned long stop, timeout;
> @@ -208,6 +218,20 @@ static int request_locality(struct tpm_chip *chip, int l)
>  	return -1;
>  }
>  
> +static int request_locality(struct tpm_chip *chip, int l)
> +{
> +	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> +	int ret = 0;
> +
> +	mutex_lock(&priv->locality_count_mutex);
> +	if (priv->locality_count == 0)
> +		ret = request_locality_locked(chip, l);
> +	if (!ret)
> +		priv->locality_count++;
> +	mutex_unlock(&priv->locality_count_mutex);
> +	return ret;
> +}
> +
>  static u8 tpm_tis_status(struct tpm_chip *chip)
>  {
>  	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
> @@ -987,6 +1011,8 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
>  	priv->timeout_min = TPM_TIMEOUT_USECS_MIN;
>  	priv->timeout_max = TPM_TIMEOUT_USECS_MAX;
>  	priv->phy_ops = phy_ops;
> +	priv->locality_count = 0;
> +	mutex_init(&priv->locality_count_mutex);
>  
>  	dev_set_drvdata(&chip->dev, priv);
>  
> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
> index 8e02faa4079d..e1871c482da2 100644
> --- a/drivers/char/tpm/tpm_tis_core.h
> +++ b/drivers/char/tpm/tpm_tis_core.h
> @@ -94,6 +94,8 @@ enum tpm_tis_irqtest_flags {
>  
>  struct tpm_tis_data {
>  	u16 manufacturer_id;
> +	struct mutex locality_count_mutex;
> +	unsigned int locality_count;
>  	int locality;
>  	int irq;
>  	unsigned int irqs_in_use;
> -- 
> 2.36.1
> 

BR, Jarkko
