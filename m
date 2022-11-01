Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9A76142AD
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Nov 2022 02:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiKABKR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 31 Oct 2022 21:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiKABKQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 31 Oct 2022 21:10:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406F42193;
        Mon, 31 Oct 2022 18:10:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5104B81AF4;
        Tue,  1 Nov 2022 01:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0943C433D6;
        Tue,  1 Nov 2022 01:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667265012;
        bh=L8M4nBukKhf1sCZsZg5fAQdCgOQvb5+E+oiYnfdo+RI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V7ZrOpybf8qOOPlHSBKu259+m22MeITVllK1MUbhnNwY1OqXFFt/xIq+02SsM5flH
         WEdlaIXphXOe6FVRFX4IG7tlbiYxdQUffgbDCjRZUXrXHz2tE2tvDdBvae1rQNabRG
         c17+62eXEWzuTyo7oQBx21F4c63BQgPd0k2AjoItFVNC3L3jWj5pUkCPNMf7zGrQqQ
         l5+KELbt4XW5J4F03HyYljEQxHzlNYxQg58EvVzksB6wCD1fHG8Ycj+GtL9Xb8y2uU
         cAGrPl/ZvlilmkCnm6O+PpKeJ7THo0p5tgEb729JqiJhX52jNIAjk9CRaw5mDjaOxs
         +1A1+wl5bROYw==
Date:   Tue, 1 Nov 2022 03:10:07 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] tpm: st33zp24: drop support for platform data
Message-ID: <Y2Bx70gjNZGQsPkA@kernel.org>
References: <20221027071349.991730-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027071349.991730-1-dmitry.torokhov@gmail.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 27, 2022 at 12:13:47AM -0700, Dmitry Torokhov wrote:
> Drop support for platform data from the driver because there are no
> users of st33zp24_platform_data structure in the mainline kernel.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> v3: switch back to using TPM_ST33_SPI macro when setting SPI driver name 
> v2: reworked commit message
> 
>  drivers/char/tpm/st33zp24/i2c.c        | 41 ++-----------------------
>  drivers/char/tpm/st33zp24/spi.c        | 42 ++------------------------
>  drivers/char/tpm/st33zp24/st33zp24.h   |  3 ++
>  include/linux/platform_data/st33zp24.h | 16 ----------
>  4 files changed, 9 insertions(+), 93 deletions(-)
>  delete mode 100644 include/linux/platform_data/st33zp24.h
> 
> diff --git a/drivers/char/tpm/st33zp24/i2c.c b/drivers/char/tpm/st33zp24/i2c.c
> index a3aa411389e7..c560532647c8 100644
> --- a/drivers/char/tpm/st33zp24/i2c.c
> +++ b/drivers/char/tpm/st33zp24/i2c.c
> @@ -12,7 +12,6 @@
>  #include <linux/of_gpio.h>
>  #include <linux/acpi.h>
>  #include <linux/tpm.h>
> -#include <linux/platform_data/st33zp24.h>
>  
>  #include "../tpm.h"
>  #include "st33zp24.h"
> @@ -178,36 +177,6 @@ static int st33zp24_i2c_of_request_resources(struct i2c_client *client)
>  	return 0;
>  }
>  
> -static int st33zp24_i2c_request_resources(struct i2c_client *client)
> -{
> -	struct tpm_chip *chip = i2c_get_clientdata(client);
> -	struct st33zp24_dev *tpm_dev = dev_get_drvdata(&chip->dev);
> -	struct st33zp24_i2c_phy *phy = tpm_dev->phy_id;
> -	struct st33zp24_platform_data *pdata;
> -	int ret;
> -
> -	pdata = client->dev.platform_data;
> -	if (!pdata) {
> -		dev_err(&client->dev, "No platform data\n");
> -		return -ENODEV;
> -	}
> -
> -	/* store for late use */
> -	phy->io_lpcpd = pdata->io_lpcpd;
> -
> -	if (gpio_is_valid(pdata->io_lpcpd)) {
> -		ret = devm_gpio_request_one(&client->dev,
> -				pdata->io_lpcpd, GPIOF_OUT_INIT_HIGH,
> -				"TPM IO_LPCPD");
> -		if (ret) {
> -			dev_err(&client->dev, "Failed to request lpcpd pin\n");
> -			return ret;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
>  /*
>   * st33zp24_i2c_probe initialize the TPM device
>   * @param: client, the i2c_client description (TPM I2C description).
> @@ -219,7 +188,6 @@ static int st33zp24_i2c_probe(struct i2c_client *client,
>  			      const struct i2c_device_id *id)
>  {
>  	int ret;
> -	struct st33zp24_platform_data *pdata;
>  	struct st33zp24_i2c_phy *phy;
>  
>  	if (!client) {
> @@ -240,19 +208,16 @@ static int st33zp24_i2c_probe(struct i2c_client *client,
>  
>  	phy->client = client;
>  
> -	pdata = client->dev.platform_data;
> -	if (!pdata && client->dev.of_node) {
> +	if (client->dev.of_node) {
>  		ret = st33zp24_i2c_of_request_resources(client);
>  		if (ret)
>  			return ret;
> -	} else if (pdata) {
> -		ret = st33zp24_i2c_request_resources(client);
> -		if (ret)
> -			return ret;
>  	} else if (ACPI_HANDLE(&client->dev)) {
>  		ret = st33zp24_i2c_acpi_request_resources(client);
>  		if (ret)
>  			return ret;
> +	} else {
> +		return -ENODEV;
>  	}
>  
>  	return st33zp24_probe(phy, &i2c_phy_ops, &client->dev, client->irq,
> diff --git a/drivers/char/tpm/st33zp24/spi.c b/drivers/char/tpm/st33zp24/spi.c
> index 22d184884694..2b121d009959 100644
> --- a/drivers/char/tpm/st33zp24/spi.c
> +++ b/drivers/char/tpm/st33zp24/spi.c
> @@ -12,7 +12,6 @@
>  #include <linux/of_gpio.h>
>  #include <linux/acpi.h>
>  #include <linux/tpm.h>
> -#include <linux/platform_data/st33zp24.h>
>  
>  #include "../tpm.h"
>  #include "st33zp24.h"
> @@ -296,37 +295,6 @@ static int st33zp24_spi_of_request_resources(struct spi_device *spi_dev)
>  	return 0;
>  }
>  
> -static int st33zp24_spi_request_resources(struct spi_device *dev)
> -{
> -	struct tpm_chip *chip = spi_get_drvdata(dev);
> -	struct st33zp24_dev *tpm_dev = dev_get_drvdata(&chip->dev);
> -	struct st33zp24_spi_phy *phy = tpm_dev->phy_id;
> -	struct st33zp24_platform_data *pdata;
> -	int ret;
> -
> -	pdata = dev->dev.platform_data;
> -	if (!pdata) {
> -		dev_err(&dev->dev, "No platform data\n");
> -		return -ENODEV;
> -	}
> -
> -	/* store for late use */
> -	phy->io_lpcpd = pdata->io_lpcpd;
> -
> -	if (gpio_is_valid(pdata->io_lpcpd)) {
> -		ret = devm_gpio_request_one(&dev->dev,
> -				pdata->io_lpcpd, GPIOF_OUT_INIT_HIGH,
> -				"TPM IO_LPCPD");
> -		if (ret) {
> -			dev_err(&dev->dev, "%s : reset gpio_request failed\n",
> -				__FILE__);
> -			return ret;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
>  /*
>   * st33zp24_spi_probe initialize the TPM device
>   * @param: dev, the spi_device description (TPM SPI description).
> @@ -336,7 +304,6 @@ static int st33zp24_spi_request_resources(struct spi_device *dev)
>  static int st33zp24_spi_probe(struct spi_device *dev)
>  {
>  	int ret;
> -	struct st33zp24_platform_data *pdata;
>  	struct st33zp24_spi_phy *phy;
>  
>  	/* Check SPI platform functionnalities */
> @@ -353,19 +320,16 @@ static int st33zp24_spi_probe(struct spi_device *dev)
>  
>  	phy->spi_device = dev;
>  
> -	pdata = dev->dev.platform_data;
> -	if (!pdata && dev->dev.of_node) {
> +	if (dev->dev.of_node) {
>  		ret = st33zp24_spi_of_request_resources(dev);
>  		if (ret)
>  			return ret;
> -	} else if (pdata) {
> -		ret = st33zp24_spi_request_resources(dev);
> -		if (ret)
> -			return ret;
>  	} else if (ACPI_HANDLE(&dev->dev)) {
>  		ret = st33zp24_spi_acpi_request_resources(dev);
>  		if (ret)
>  			return ret;
> +	} else {
> +		return -ENODEV;
>  	}
>  
>  	phy->latency = st33zp24_spi_evaluate_latency(phy);
> diff --git a/drivers/char/tpm/st33zp24/st33zp24.h b/drivers/char/tpm/st33zp24/st33zp24.h
> index b387a476c555..6a26dbc3206b 100644
> --- a/drivers/char/tpm/st33zp24/st33zp24.h
> +++ b/drivers/char/tpm/st33zp24/st33zp24.h
> @@ -7,6 +7,9 @@
>  #ifndef __LOCAL_ST33ZP24_H__
>  #define __LOCAL_ST33ZP24_H__
>  
> +#define TPM_ST33_I2C		"st33zp24-i2c"
> +#define TPM_ST33_SPI		"st33zp24-spi"
> +
>  #define TPM_WRITE_DIRECTION	0x80
>  #define ST33ZP24_BUFSIZE	2048
>  
> diff --git a/include/linux/platform_data/st33zp24.h b/include/linux/platform_data/st33zp24.h
> deleted file mode 100644
> index 61db674f36cc..000000000000
> --- a/include/linux/platform_data/st33zp24.h
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-or-later */
> -/*
> - * STMicroelectronics TPM Linux driver for TPM 1.2 ST33ZP24
> - * Copyright (C) 2009 - 2016  STMicroelectronics
> - */
> -#ifndef __ST33ZP24_H__
> -#define __ST33ZP24_H__
> -
> -#define TPM_ST33_I2C			"st33zp24-i2c"
> -#define TPM_ST33_SPI			"st33zp24-spi"
> -
> -struct st33zp24_platform_data {
> -	int io_lpcpd;
> -};
> -
> -#endif /* __ST33ZP24_H__ */
> -- 
> 2.38.0.135.g90850a2211-goog
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
