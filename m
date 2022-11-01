Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3009A6142B0
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Nov 2022 02:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiKABKl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 31 Oct 2022 21:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiKABKk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 31 Oct 2022 21:10:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204101105;
        Mon, 31 Oct 2022 18:10:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A29D461502;
        Tue,  1 Nov 2022 01:10:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C433C433D6;
        Tue,  1 Nov 2022 01:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667265038;
        bh=qLy2TfcOFgE4fgTsOrBXN6W06XFZRRXtX8Spsfbg9KE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=le6IU0fhccIYQ/I/d1jPbMO1MHVLtaglP43F6wa1oACvEgTxFT1m60YoTqPDQ9slC
         cefbzWr4757XOqoQg9yU2GANGDEhLmeyg4OAtS71dJc+RwpqATHS5RvF4S/DidJ4Hm
         82nM1G5e2kP80QjLQm5jRU/u/8FqRpMGQiOq1d9wk9QM/BwRjcuRMzx5Hnre3EAU2M
         0sOzInmMh7pzXFcTEj+soTq0czYmSWrDFWRIOLbHZ5ujmhbb4G9DTite2n6DL0S4Af
         zUbhbgGwozl95lHWFp7/P25iFbFDKU/IVROj2T9JC/xBPKmVWK+C7BTYC2EPW7FD89
         QqljiVIYtw1mg==
Date:   Tue, 1 Nov 2022 03:10:34 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] tpm: st33zp24: switch to using gpiod API
Message-ID: <Y2ByClyLBIjw8F0M@kernel.org>
References: <20221027071349.991730-1-dmitry.torokhov@gmail.com>
 <20221027071349.991730-2-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027071349.991730-2-dmitry.torokhov@gmail.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 27, 2022 at 12:13:48AM -0700, Dmitry Torokhov wrote:
> Switch the driver from legacy gpio API (that uses flat GPIO numbering)
> to the newer gpiod API (which used descriptors and respects line
> polarities specified in ACPI or device tree).
> 
> Because gpio handling code for SPI and I2C variants duplicates each
> other it is moved into the core code for the driver.
> 
> Also, it seems that the driver never assigned tpm_dev->io_lpcpd in the
> past, so gpio-based power management was most likely not working ever.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
> 
> v3: no changes
> v2: reworked commit message
> 
>  drivers/char/tpm/st33zp24/i2c.c      | 101 +--------------------------
>  drivers/char/tpm/st33zp24/spi.c      | 100 +-------------------------
>  drivers/char/tpm/st33zp24/st33zp24.c |  39 +++++++++--
>  drivers/char/tpm/st33zp24/st33zp24.h |   4 +-
>  4 files changed, 39 insertions(+), 205 deletions(-)
> 
> diff --git a/drivers/char/tpm/st33zp24/i2c.c b/drivers/char/tpm/st33zp24/i2c.c
> index c560532647c8..614c7d8ed84f 100644
> --- a/drivers/char/tpm/st33zp24/i2c.c
> +++ b/drivers/char/tpm/st33zp24/i2c.c
> @@ -6,10 +6,7 @@
>  
>  #include <linux/module.h>
>  #include <linux/i2c.h>
> -#include <linux/gpio.h>
> -#include <linux/gpio/consumer.h>
> -#include <linux/of_irq.h>
> -#include <linux/of_gpio.h>
> +#include <linux/of.h>
>  #include <linux/acpi.h>
>  #include <linux/tpm.h>
>  
> @@ -21,7 +18,6 @@
>  struct st33zp24_i2c_phy {
>  	struct i2c_client *client;
>  	u8 buf[ST33ZP24_BUFSIZE + 1];
> -	int io_lpcpd;
>  };
>  
>  /*
> @@ -98,85 +94,6 @@ static const struct st33zp24_phy_ops i2c_phy_ops = {
>  	.recv = st33zp24_i2c_recv,
>  };
>  
> -static const struct acpi_gpio_params lpcpd_gpios = { 1, 0, false };
> -
> -static const struct acpi_gpio_mapping acpi_st33zp24_gpios[] = {
> -	{ "lpcpd-gpios", &lpcpd_gpios, 1 },
> -	{},
> -};
> -
> -static int st33zp24_i2c_acpi_request_resources(struct i2c_client *client)
> -{
> -	struct tpm_chip *chip = i2c_get_clientdata(client);
> -	struct st33zp24_dev *tpm_dev = dev_get_drvdata(&chip->dev);
> -	struct st33zp24_i2c_phy *phy = tpm_dev->phy_id;
> -	struct gpio_desc *gpiod_lpcpd;
> -	struct device *dev = &client->dev;
> -	int ret;
> -
> -	ret = devm_acpi_dev_add_driver_gpios(dev, acpi_st33zp24_gpios);
> -	if (ret)
> -		return ret;
> -
> -	/* Get LPCPD GPIO from ACPI */
> -	gpiod_lpcpd = devm_gpiod_get(dev, "lpcpd", GPIOD_OUT_HIGH);
> -	if (IS_ERR(gpiod_lpcpd)) {
> -		dev_err(&client->dev,
> -			"Failed to retrieve lpcpd-gpios from acpi.\n");
> -		phy->io_lpcpd = -1;
> -		/*
> -		 * lpcpd pin is not specified. This is not an issue as
> -		 * power management can be also managed by TPM specific
> -		 * commands. So leave with a success status code.
> -		 */
> -		return 0;
> -	}
> -
> -	phy->io_lpcpd = desc_to_gpio(gpiod_lpcpd);
> -
> -	return 0;
> -}
> -
> -static int st33zp24_i2c_of_request_resources(struct i2c_client *client)
> -{
> -	struct tpm_chip *chip = i2c_get_clientdata(client);
> -	struct st33zp24_dev *tpm_dev = dev_get_drvdata(&chip->dev);
> -	struct st33zp24_i2c_phy *phy = tpm_dev->phy_id;
> -	struct device_node *pp;
> -	int gpio;
> -	int ret;
> -
> -	pp = client->dev.of_node;
> -	if (!pp) {
> -		dev_err(&client->dev, "No platform data\n");
> -		return -ENODEV;
> -	}
> -
> -	/* Get GPIO from device tree */
> -	gpio = of_get_named_gpio(pp, "lpcpd-gpios", 0);
> -	if (gpio < 0) {
> -		dev_err(&client->dev,
> -			"Failed to retrieve lpcpd-gpios from dts.\n");
> -		phy->io_lpcpd = -1;
> -		/*
> -		 * lpcpd pin is not specified. This is not an issue as
> -		 * power management can be also managed by TPM specific
> -		 * commands. So leave with a success status code.
> -		 */
> -		return 0;
> -	}
> -	/* GPIO request and configuration */
> -	ret = devm_gpio_request_one(&client->dev, gpio,
> -			GPIOF_OUT_INIT_HIGH, "TPM IO LPCPD");
> -	if (ret) {
> -		dev_err(&client->dev, "Failed to request lpcpd pin\n");
> -		return -ENODEV;
> -	}
> -	phy->io_lpcpd = gpio;
> -
> -	return 0;
> -}
> -
>  /*
>   * st33zp24_i2c_probe initialize the TPM device
>   * @param: client, the i2c_client description (TPM I2C description).
> @@ -187,7 +104,6 @@ static int st33zp24_i2c_of_request_resources(struct i2c_client *client)
>  static int st33zp24_i2c_probe(struct i2c_client *client,
>  			      const struct i2c_device_id *id)
>  {
> -	int ret;
>  	struct st33zp24_i2c_phy *phy;
>  
>  	if (!client) {
> @@ -208,20 +124,7 @@ static int st33zp24_i2c_probe(struct i2c_client *client,
>  
>  	phy->client = client;
>  
> -	if (client->dev.of_node) {
> -		ret = st33zp24_i2c_of_request_resources(client);
> -		if (ret)
> -			return ret;
> -	} else if (ACPI_HANDLE(&client->dev)) {
> -		ret = st33zp24_i2c_acpi_request_resources(client);
> -		if (ret)
> -			return ret;
> -	} else {
> -		return -ENODEV;
> -	}
> -
> -	return st33zp24_probe(phy, &i2c_phy_ops, &client->dev, client->irq,
> -			      phy->io_lpcpd);
> +	return st33zp24_probe(phy, &i2c_phy_ops, &client->dev, client->irq);
>  }
>  
>  /*
> diff --git a/drivers/char/tpm/st33zp24/spi.c b/drivers/char/tpm/st33zp24/spi.c
> index 2b121d009959..25b0e7994d27 100644
> --- a/drivers/char/tpm/st33zp24/spi.c
> +++ b/drivers/char/tpm/st33zp24/spi.c
> @@ -6,10 +6,7 @@
>  
>  #include <linux/module.h>
>  #include <linux/spi/spi.h>
> -#include <linux/gpio.h>
> -#include <linux/gpio/consumer.h>
> -#include <linux/of_irq.h>
> -#include <linux/of_gpio.h>
> +#include <linux/of.h>
>  #include <linux/acpi.h>
>  #include <linux/tpm.h>
>  
> @@ -60,7 +57,6 @@ struct st33zp24_spi_phy {
>  	u8 tx_buf[ST33ZP24_SPI_BUFFER_SIZE];
>  	u8 rx_buf[ST33ZP24_SPI_BUFFER_SIZE];
>  
> -	int io_lpcpd;
>  	int latency;
>  };
>  
> @@ -217,84 +213,6 @@ static const struct st33zp24_phy_ops spi_phy_ops = {
>  	.recv = st33zp24_spi_recv,
>  };
>  
> -static const struct acpi_gpio_params lpcpd_gpios = { 1, 0, false };
> -
> -static const struct acpi_gpio_mapping acpi_st33zp24_gpios[] = {
> -	{ "lpcpd-gpios", &lpcpd_gpios, 1 },
> -	{},
> -};
> -
> -static int st33zp24_spi_acpi_request_resources(struct spi_device *spi_dev)
> -{
> -	struct tpm_chip *chip = spi_get_drvdata(spi_dev);
> -	struct st33zp24_dev *tpm_dev = dev_get_drvdata(&chip->dev);
> -	struct st33zp24_spi_phy *phy = tpm_dev->phy_id;
> -	struct gpio_desc *gpiod_lpcpd;
> -	struct device *dev = &spi_dev->dev;
> -	int ret;
> -
> -	ret = devm_acpi_dev_add_driver_gpios(dev, acpi_st33zp24_gpios);
> -	if (ret)
> -		return ret;
> -
> -	/* Get LPCPD GPIO from ACPI */
> -	gpiod_lpcpd = devm_gpiod_get(dev, "lpcpd", GPIOD_OUT_HIGH);
> -	if (IS_ERR(gpiod_lpcpd)) {
> -		dev_err(dev, "Failed to retrieve lpcpd-gpios from acpi.\n");
> -		phy->io_lpcpd = -1;
> -		/*
> -		 * lpcpd pin is not specified. This is not an issue as
> -		 * power management can be also managed by TPM specific
> -		 * commands. So leave with a success status code.
> -		 */
> -		return 0;
> -	}
> -
> -	phy->io_lpcpd = desc_to_gpio(gpiod_lpcpd);
> -
> -	return 0;
> -}
> -
> -static int st33zp24_spi_of_request_resources(struct spi_device *spi_dev)
> -{
> -	struct tpm_chip *chip = spi_get_drvdata(spi_dev);
> -	struct st33zp24_dev *tpm_dev = dev_get_drvdata(&chip->dev);
> -	struct st33zp24_spi_phy *phy = tpm_dev->phy_id;
> -	struct device_node *pp;
> -	int gpio;
> -	int ret;
> -
> -	pp = spi_dev->dev.of_node;
> -	if (!pp) {
> -		dev_err(&spi_dev->dev, "No platform data\n");
> -		return -ENODEV;
> -	}
> -
> -	/* Get GPIO from device tree */
> -	gpio = of_get_named_gpio(pp, "lpcpd-gpios", 0);
> -	if (gpio < 0) {
> -		dev_err(&spi_dev->dev,
> -			"Failed to retrieve lpcpd-gpios from dts.\n");
> -		phy->io_lpcpd = -1;
> -		/*
> -		 * lpcpd pin is not specified. This is not an issue as
> -		 * power management can be also managed by TPM specific
> -		 * commands. So leave with a success status code.
> -		 */
> -		return 0;
> -	}
> -	/* GPIO request and configuration */
> -	ret = devm_gpio_request_one(&spi_dev->dev, gpio,
> -			GPIOF_OUT_INIT_HIGH, "TPM IO LPCPD");
> -	if (ret) {
> -		dev_err(&spi_dev->dev, "Failed to request lpcpd pin\n");
> -		return -ENODEV;
> -	}
> -	phy->io_lpcpd = gpio;
> -
> -	return 0;
> -}
> -
>  /*
>   * st33zp24_spi_probe initialize the TPM device
>   * @param: dev, the spi_device description (TPM SPI description).
> @@ -303,7 +221,6 @@ static int st33zp24_spi_of_request_resources(struct spi_device *spi_dev)
>   */
>  static int st33zp24_spi_probe(struct spi_device *dev)
>  {
> -	int ret;
>  	struct st33zp24_spi_phy *phy;
>  
>  	/* Check SPI platform functionnalities */
> @@ -320,24 +237,11 @@ static int st33zp24_spi_probe(struct spi_device *dev)
>  
>  	phy->spi_device = dev;
>  
> -	if (dev->dev.of_node) {
> -		ret = st33zp24_spi_of_request_resources(dev);
> -		if (ret)
> -			return ret;
> -	} else if (ACPI_HANDLE(&dev->dev)) {
> -		ret = st33zp24_spi_acpi_request_resources(dev);
> -		if (ret)
> -			return ret;
> -	} else {
> -		return -ENODEV;
> -	}
> -
>  	phy->latency = st33zp24_spi_evaluate_latency(phy);
>  	if (phy->latency <= 0)
>  		return -ENODEV;
>  
> -	return st33zp24_probe(phy, &spi_phy_ops, &dev->dev, dev->irq,
> -			      phy->io_lpcpd);
> +	return st33zp24_probe(phy, &spi_phy_ops, &dev->dev, dev->irq);
>  }
>  
>  /*
> diff --git a/drivers/char/tpm/st33zp24/st33zp24.c b/drivers/char/tpm/st33zp24/st33zp24.c
> index 15b393e92c8e..a5b554cd4778 100644
> --- a/drivers/char/tpm/st33zp24/st33zp24.c
> +++ b/drivers/char/tpm/st33zp24/st33zp24.c
> @@ -4,6 +4,7 @@
>   * Copyright (C) 2009 - 2016 STMicroelectronics
>   */
>  
> +#include <linux/acpi.h>
>  #include <linux/module.h>
>  #include <linux/fs.h>
>  #include <linux/kernel.h>
> @@ -12,7 +13,7 @@
>  #include <linux/freezer.h>
>  #include <linux/string.h>
>  #include <linux/interrupt.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/sched.h>
>  #include <linux/uaccess.h>
>  #include <linux/io.h>
> @@ -432,11 +433,18 @@ static const struct tpm_class_ops st33zp24_tpm = {
>  	.req_canceled = st33zp24_req_canceled,
>  };
>  
> +static const struct acpi_gpio_params lpcpd_gpios = { 1, 0, false };
> +
> +static const struct acpi_gpio_mapping acpi_st33zp24_gpios[] = {
> +	{ "lpcpd-gpios", &lpcpd_gpios, 1 },
> +	{ },
> +};
> +
>  /*
>   * initialize the TPM device
>   */
>  int st33zp24_probe(void *phy_id, const struct st33zp24_phy_ops *ops,
> -		   struct device *dev, int irq, int io_lpcpd)
> +		   struct device *dev, int irq)
>  {
>  	int ret;
>  	u8 intmask = 0;
> @@ -463,6 +471,25 @@ int st33zp24_probe(void *phy_id, const struct st33zp24_phy_ops *ops,
>  
>  	tpm_dev->locality = LOCALITY0;
>  
> +	if (ACPI_COMPANION(dev)) {
> +		ret = devm_acpi_dev_add_driver_gpios(dev, acpi_st33zp24_gpios);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/*
> +	 * Get LPCPD GPIO. If lpcpd pin is not specified. This is not an
> +	 * issue as power management can be also managed by TPM specific
> +	 * commands.
> +	 */
> +	tpm_dev->io_lpcpd = devm_gpiod_get_optional(dev, "lpcpd",
> +						    GPIOD_OUT_HIGH);
> +	ret = PTR_ERR_OR_ZERO(tpm_dev->io_lpcpd);
> +	if (ret) {
> +		dev_err(dev, "failed to request lpcpd gpio: %d\n", ret);
> +		return ret;
> +	}
> +
>  	if (irq) {
>  		/* INTERRUPT Setup */
>  		init_waitqueue_head(&tpm_dev->read_queue);
> @@ -525,8 +552,8 @@ int st33zp24_pm_suspend(struct device *dev)
>  
>  	int ret = 0;
>  
> -	if (gpio_is_valid(tpm_dev->io_lpcpd))
> -		gpio_set_value(tpm_dev->io_lpcpd, 0);
> +	if (tpm_dev->io_lpcpd)
> +		gpiod_set_value_cansleep(tpm_dev->io_lpcpd, 0);
>  	else
>  		ret = tpm_pm_suspend(dev);
>  
> @@ -540,8 +567,8 @@ int st33zp24_pm_resume(struct device *dev)
>  	struct st33zp24_dev *tpm_dev = dev_get_drvdata(&chip->dev);
>  	int ret = 0;
>  
> -	if (gpio_is_valid(tpm_dev->io_lpcpd)) {
> -		gpio_set_value(tpm_dev->io_lpcpd, 1);
> +	if (tpm_dev->io_lpcpd) {
> +		gpiod_set_value_cansleep(tpm_dev->io_lpcpd, 1);
>  		ret = wait_for_stat(chip,
>  				TPM_STS_VALID, chip->timeout_b,
>  				&tpm_dev->read_queue, false);
> diff --git a/drivers/char/tpm/st33zp24/st33zp24.h b/drivers/char/tpm/st33zp24/st33zp24.h
> index 6a26dbc3206b..5acc85f711e6 100644
> --- a/drivers/char/tpm/st33zp24/st33zp24.h
> +++ b/drivers/char/tpm/st33zp24/st33zp24.h
> @@ -20,7 +20,7 @@ struct st33zp24_dev {
>  	int locality;
>  	int irq;
>  	u32 intrs;
> -	int io_lpcpd;
> +	struct gpio_desc *io_lpcpd;
>  	wait_queue_head_t read_queue;
>  };
>  
> @@ -36,6 +36,6 @@ int st33zp24_pm_resume(struct device *dev);
>  #endif
>  
>  int st33zp24_probe(void *phy_id, const struct st33zp24_phy_ops *ops,
> -		   struct device *dev, int irq, int io_lpcpd);
> +		   struct device *dev, int irq);
>  void st33zp24_remove(struct tpm_chip *chip);
>  #endif /* __LOCAL_ST33ZP24_H__ */
> -- 
> 2.38.0.135.g90850a2211-goog
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
