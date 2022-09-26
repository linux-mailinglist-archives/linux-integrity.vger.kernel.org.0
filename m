Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E005E98D7
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Sep 2022 07:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbiIZFkJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Sep 2022 01:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbiIZFkH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Sep 2022 01:40:07 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C104517045;
        Sun, 25 Sep 2022 22:40:03 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id s26so5595463pgv.7;
        Sun, 25 Sep 2022 22:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=dSYEUAayX2mBF64whhmu237xF7qkCSlutx0zb2SUaeA=;
        b=KVs2phhFD7VGjzbKzthUMu4LUhPfEprhSge6ToxqIyvJanF6Ca9UXRz+NKZ+8kpuSe
         CS7RpNysHTwZ9UV0bwP5wTiIJPPPr0xYVFSWv3xz0Gvec1rGRflTc88fPJc0fJIxfp1B
         9G2DpJDq5m1cqCtgWQTcqmTWnDKwMJfQ2aapLWa7A9W2z9OTs7KJ1Nut4ffC2C8UnKw8
         zIDidjnONmoe1irB0psM/kByeNSsoqwPIhhLWqI3J/MFKQiPZEdQzM5EeRYQMdbMiZSc
         UMxhbhVFrIqXqAarsSUhaOgVjoSHbyeSjHbdwUPOFdrazDbS/nta+WyAav/LQVVbk/NF
         5Bew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dSYEUAayX2mBF64whhmu237xF7qkCSlutx0zb2SUaeA=;
        b=ucK0WI1MSHcWRBsqgxB03vmXKVB0PbTEaNa4W6ZhvzUk6IXofZ+u8sQGlvoLxoXatI
         2z2LhQOTpB28AB05h68xItS7G2ig3L8cK9B9zhYFBO2mpEOmpx4r7mOR2oq4sc8Y8q5r
         wVnNOpY+hudhJRC5MJUfukxrJt8LWIJXI+zNFrUyeCsiTAWbjR4q4gNWUPTEGdcy1OKe
         /mAp10fKpihk558jrpNV9cUA2dWb/n8kCZbnqHsGDyv1usa7rq8LmyPgD2zhagc+Pc9e
         pkBfT8y4AwNQMi66C7IqZbaSWRMuHbT91/CAyAMt1CpLWNS+4BvPayUCv4+qOsNzLX4N
         Puzg==
X-Gm-Message-State: ACrzQf3M94V7BOxs6SqjakeXD6sCKhoJ9vMmPkUQEKX+VTUcgyavoZKv
        H7Uei2mz0/8wgGwJ8V2PFR3wjTjBxTs=
X-Google-Smtp-Source: AMsMyM42UnwNJWzO8asS+HgsVplnIGBoEtYeKuBEyvd2ZjN7lsF72tZk1dW2hl804lyF26YRRQ+ijA==
X-Received: by 2002:a63:1e4b:0:b0:439:1ca4:22f9 with SMTP id p11-20020a631e4b000000b004391ca422f9mr17615399pgm.588.1664170802770;
        Sun, 25 Sep 2022 22:40:02 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:7e1b:858c:19dc:934])
        by smtp.gmail.com with ESMTPSA id h18-20020a170902f71200b00176b0dec886sm10120350plo.58.2022.09.25.22.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 22:40:02 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] tpm: st33zp24: switch to using gpiod API
Date:   Sun, 25 Sep 2022 22:39:57 -0700
Message-Id: <20220926053958.1541912-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
In-Reply-To: <20220926053958.1541912-1-dmitry.torokhov@gmail.com>
References: <20220926053958.1541912-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch switches the driver from legacy gpio API to the newer gpiod
API, so that eventually we can drop the former.

During conversion it was noted that the gpio handling code for SPI and
I2C variants duplicates each other, so it was moved into the core.

Also, it seems that the driver never assigned tpm_dev->io_lpcpd in the
past, so gpio-based power management was most likely not working ever.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/char/tpm/st33zp24/i2c.c      | 101 +--------------------------
 drivers/char/tpm/st33zp24/spi.c      | 100 +-------------------------
 drivers/char/tpm/st33zp24/st33zp24.c |  39 +++++++++--
 drivers/char/tpm/st33zp24/st33zp24.h |   4 +-
 4 files changed, 39 insertions(+), 205 deletions(-)

diff --git a/drivers/char/tpm/st33zp24/i2c.c b/drivers/char/tpm/st33zp24/i2c.c
index c560532647c8..614c7d8ed84f 100644
--- a/drivers/char/tpm/st33zp24/i2c.c
+++ b/drivers/char/tpm/st33zp24/i2c.c
@@ -6,10 +6,7 @@
 
 #include <linux/module.h>
 #include <linux/i2c.h>
-#include <linux/gpio.h>
-#include <linux/gpio/consumer.h>
-#include <linux/of_irq.h>
-#include <linux/of_gpio.h>
+#include <linux/of.h>
 #include <linux/acpi.h>
 #include <linux/tpm.h>
 
@@ -21,7 +18,6 @@
 struct st33zp24_i2c_phy {
 	struct i2c_client *client;
 	u8 buf[ST33ZP24_BUFSIZE + 1];
-	int io_lpcpd;
 };
 
 /*
@@ -98,85 +94,6 @@ static const struct st33zp24_phy_ops i2c_phy_ops = {
 	.recv = st33zp24_i2c_recv,
 };
 
-static const struct acpi_gpio_params lpcpd_gpios = { 1, 0, false };
-
-static const struct acpi_gpio_mapping acpi_st33zp24_gpios[] = {
-	{ "lpcpd-gpios", &lpcpd_gpios, 1 },
-	{},
-};
-
-static int st33zp24_i2c_acpi_request_resources(struct i2c_client *client)
-{
-	struct tpm_chip *chip = i2c_get_clientdata(client);
-	struct st33zp24_dev *tpm_dev = dev_get_drvdata(&chip->dev);
-	struct st33zp24_i2c_phy *phy = tpm_dev->phy_id;
-	struct gpio_desc *gpiod_lpcpd;
-	struct device *dev = &client->dev;
-	int ret;
-
-	ret = devm_acpi_dev_add_driver_gpios(dev, acpi_st33zp24_gpios);
-	if (ret)
-		return ret;
-
-	/* Get LPCPD GPIO from ACPI */
-	gpiod_lpcpd = devm_gpiod_get(dev, "lpcpd", GPIOD_OUT_HIGH);
-	if (IS_ERR(gpiod_lpcpd)) {
-		dev_err(&client->dev,
-			"Failed to retrieve lpcpd-gpios from acpi.\n");
-		phy->io_lpcpd = -1;
-		/*
-		 * lpcpd pin is not specified. This is not an issue as
-		 * power management can be also managed by TPM specific
-		 * commands. So leave with a success status code.
-		 */
-		return 0;
-	}
-
-	phy->io_lpcpd = desc_to_gpio(gpiod_lpcpd);
-
-	return 0;
-}
-
-static int st33zp24_i2c_of_request_resources(struct i2c_client *client)
-{
-	struct tpm_chip *chip = i2c_get_clientdata(client);
-	struct st33zp24_dev *tpm_dev = dev_get_drvdata(&chip->dev);
-	struct st33zp24_i2c_phy *phy = tpm_dev->phy_id;
-	struct device_node *pp;
-	int gpio;
-	int ret;
-
-	pp = client->dev.of_node;
-	if (!pp) {
-		dev_err(&client->dev, "No platform data\n");
-		return -ENODEV;
-	}
-
-	/* Get GPIO from device tree */
-	gpio = of_get_named_gpio(pp, "lpcpd-gpios", 0);
-	if (gpio < 0) {
-		dev_err(&client->dev,
-			"Failed to retrieve lpcpd-gpios from dts.\n");
-		phy->io_lpcpd = -1;
-		/*
-		 * lpcpd pin is not specified. This is not an issue as
-		 * power management can be also managed by TPM specific
-		 * commands. So leave with a success status code.
-		 */
-		return 0;
-	}
-	/* GPIO request and configuration */
-	ret = devm_gpio_request_one(&client->dev, gpio,
-			GPIOF_OUT_INIT_HIGH, "TPM IO LPCPD");
-	if (ret) {
-		dev_err(&client->dev, "Failed to request lpcpd pin\n");
-		return -ENODEV;
-	}
-	phy->io_lpcpd = gpio;
-
-	return 0;
-}
-
 /*
  * st33zp24_i2c_probe initialize the TPM device
  * @param: client, the i2c_client description (TPM I2C description).
@@ -187,7 +104,6 @@ static int st33zp24_i2c_of_request_resources(struct i2c_client *client)
 static int st33zp24_i2c_probe(struct i2c_client *client,
 			      const struct i2c_device_id *id)
 {
-	int ret;
 	struct st33zp24_i2c_phy *phy;
 
 	if (!client) {
@@ -208,20 +124,7 @@ static int st33zp24_i2c_probe(struct i2c_client *client,
 
 	phy->client = client;
 
-	if (client->dev.of_node) {
-		ret = st33zp24_i2c_of_request_resources(client);
-		if (ret)
-			return ret;
-	} else if (ACPI_HANDLE(&client->dev)) {
-		ret = st33zp24_i2c_acpi_request_resources(client);
-		if (ret)
-			return ret;
-	} else {
-		return -ENODEV;
-	}
-
-	return st33zp24_probe(phy, &i2c_phy_ops, &client->dev, client->irq,
-			      phy->io_lpcpd);
+	return st33zp24_probe(phy, &i2c_phy_ops, &client->dev, client->irq);
 }
 
 /*
diff --git a/drivers/char/tpm/st33zp24/spi.c b/drivers/char/tpm/st33zp24/spi.c
index 49630f2cb9b4..ff4adbe104cf 100644
--- a/drivers/char/tpm/st33zp24/spi.c
+++ b/drivers/char/tpm/st33zp24/spi.c
@@ -6,10 +6,7 @@
 
 #include <linux/module.h>
 #include <linux/spi/spi.h>
-#include <linux/gpio.h>
-#include <linux/gpio/consumer.h>
-#include <linux/of_irq.h>
-#include <linux/of_gpio.h>
+#include <linux/of.h>
 #include <linux/acpi.h>
 #include <linux/tpm.h>
 
@@ -60,7 +57,6 @@ struct st33zp24_spi_phy {
 	u8 tx_buf[ST33ZP24_SPI_BUFFER_SIZE];
 	u8 rx_buf[ST33ZP24_SPI_BUFFER_SIZE];
 
-	int io_lpcpd;
 	int latency;
 };
 
@@ -217,84 +213,6 @@ static const struct st33zp24_phy_ops spi_phy_ops = {
 	.recv = st33zp24_spi_recv,
 };
 
-static const struct acpi_gpio_params lpcpd_gpios = { 1, 0, false };
-
-static const struct acpi_gpio_mapping acpi_st33zp24_gpios[] = {
-	{ "lpcpd-gpios", &lpcpd_gpios, 1 },
-	{},
-};
-
-static int st33zp24_spi_acpi_request_resources(struct spi_device *spi_dev)
-{
-	struct tpm_chip *chip = spi_get_drvdata(spi_dev);
-	struct st33zp24_dev *tpm_dev = dev_get_drvdata(&chip->dev);
-	struct st33zp24_spi_phy *phy = tpm_dev->phy_id;
-	struct gpio_desc *gpiod_lpcpd;
-	struct device *dev = &spi_dev->dev;
-	int ret;
-
-	ret = devm_acpi_dev_add_driver_gpios(dev, acpi_st33zp24_gpios);
-	if (ret)
-		return ret;
-
-	/* Get LPCPD GPIO from ACPI */
-	gpiod_lpcpd = devm_gpiod_get(dev, "lpcpd", GPIOD_OUT_HIGH);
-	if (IS_ERR(gpiod_lpcpd)) {
-		dev_err(dev, "Failed to retrieve lpcpd-gpios from acpi.\n");
-		phy->io_lpcpd = -1;
-		/*
-		 * lpcpd pin is not specified. This is not an issue as
-		 * power management can be also managed by TPM specific
-		 * commands. So leave with a success status code.
-		 */
-		return 0;
-	}
-
-	phy->io_lpcpd = desc_to_gpio(gpiod_lpcpd);
-
-	return 0;
-}
-
-static int st33zp24_spi_of_request_resources(struct spi_device *spi_dev)
-{
-	struct tpm_chip *chip = spi_get_drvdata(spi_dev);
-	struct st33zp24_dev *tpm_dev = dev_get_drvdata(&chip->dev);
-	struct st33zp24_spi_phy *phy = tpm_dev->phy_id;
-	struct device_node *pp;
-	int gpio;
-	int ret;
-
-	pp = spi_dev->dev.of_node;
-	if (!pp) {
-		dev_err(&spi_dev->dev, "No platform data\n");
-		return -ENODEV;
-	}
-
-	/* Get GPIO from device tree */
-	gpio = of_get_named_gpio(pp, "lpcpd-gpios", 0);
-	if (gpio < 0) {
-		dev_err(&spi_dev->dev,
-			"Failed to retrieve lpcpd-gpios from dts.\n");
-		phy->io_lpcpd = -1;
-		/*
-		 * lpcpd pin is not specified. This is not an issue as
-		 * power management can be also managed by TPM specific
-		 * commands. So leave with a success status code.
-		 */
-		return 0;
-	}
-	/* GPIO request and configuration */
-	ret = devm_gpio_request_one(&spi_dev->dev, gpio,
-			GPIOF_OUT_INIT_HIGH, "TPM IO LPCPD");
-	if (ret) {
-		dev_err(&spi_dev->dev, "Failed to request lpcpd pin\n");
-		return -ENODEV;
-	}
-	phy->io_lpcpd = gpio;
-
-	return 0;
-}
-
 /*
  * st33zp24_spi_probe initialize the TPM device
  * @param: dev, the spi_device description (TPM SPI description).
@@ -303,7 +221,6 @@ static int st33zp24_spi_of_request_resources(struct spi_device *spi_dev)
  */
 static int st33zp24_spi_probe(struct spi_device *dev)
 {
-	int ret;
 	struct st33zp24_spi_phy *phy;
 
 	/* Check SPI platform functionnalities */
@@ -320,24 +237,11 @@ static int st33zp24_spi_probe(struct spi_device *dev)
 
 	phy->spi_device = dev;
 
-	if (dev->dev.of_node) {
-		ret = st33zp24_spi_of_request_resources(dev);
-		if (ret)
-			return ret;
-	} else if (ACPI_HANDLE(&dev->dev)) {
-		ret = st33zp24_spi_acpi_request_resources(dev);
-		if (ret)
-			return ret;
-	} else {
-		return -ENODEV;
-	}
-
 	phy->latency = st33zp24_spi_evaluate_latency(phy);
 	if (phy->latency <= 0)
 		return -ENODEV;
 
-	return st33zp24_probe(phy, &spi_phy_ops, &dev->dev, dev->irq,
-			      phy->io_lpcpd);
+	return st33zp24_probe(phy, &spi_phy_ops, &dev->dev, dev->irq);
 }
 
 /*
diff --git a/drivers/char/tpm/st33zp24/st33zp24.c b/drivers/char/tpm/st33zp24/st33zp24.c
index 15b393e92c8e..a5b554cd4778 100644
--- a/drivers/char/tpm/st33zp24/st33zp24.c
+++ b/drivers/char/tpm/st33zp24/st33zp24.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2009 - 2016 STMicroelectronics
  */
 
+#include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/kernel.h>
@@ -12,7 +13,7 @@
 #include <linux/freezer.h>
 #include <linux/string.h>
 #include <linux/interrupt.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/sched.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
@@ -432,11 +433,18 @@ static const struct tpm_class_ops st33zp24_tpm = {
 	.req_canceled = st33zp24_req_canceled,
 };
 
+static const struct acpi_gpio_params lpcpd_gpios = { 1, 0, false };
+
+static const struct acpi_gpio_mapping acpi_st33zp24_gpios[] = {
+	{ "lpcpd-gpios", &lpcpd_gpios, 1 },
+	{ },
+};
+
 /*
  * initialize the TPM device
  */
 int st33zp24_probe(void *phy_id, const struct st33zp24_phy_ops *ops,
-		   struct device *dev, int irq, int io_lpcpd)
+		   struct device *dev, int irq)
 {
 	int ret;
 	u8 intmask = 0;
@@ -463,6 +471,25 @@ int st33zp24_probe(void *phy_id, const struct st33zp24_phy_ops *ops,
 
 	tpm_dev->locality = LOCALITY0;
 
+	if (ACPI_COMPANION(dev)) {
+		ret = devm_acpi_dev_add_driver_gpios(dev, acpi_st33zp24_gpios);
+		if (ret)
+			return ret;
+	}
+
+	/*
+	 * Get LPCPD GPIO. If lpcpd pin is not specified. This is not an
+	 * issue as power management can be also managed by TPM specific
+	 * commands.
+	 */
+	tpm_dev->io_lpcpd = devm_gpiod_get_optional(dev, "lpcpd",
+						    GPIOD_OUT_HIGH);
+	ret = PTR_ERR_OR_ZERO(tpm_dev->io_lpcpd);
+	if (ret) {
+		dev_err(dev, "failed to request lpcpd gpio: %d\n", ret);
+		return ret;
+	}
+
 	if (irq) {
 		/* INTERRUPT Setup */
 		init_waitqueue_head(&tpm_dev->read_queue);
@@ -525,8 +552,8 @@ int st33zp24_pm_suspend(struct device *dev)
 
 	int ret = 0;
 
-	if (gpio_is_valid(tpm_dev->io_lpcpd))
-		gpio_set_value(tpm_dev->io_lpcpd, 0);
+	if (tpm_dev->io_lpcpd)
+		gpiod_set_value_cansleep(tpm_dev->io_lpcpd, 0);
 	else
 		ret = tpm_pm_suspend(dev);
 
@@ -540,8 +567,8 @@ int st33zp24_pm_resume(struct device *dev)
 	struct st33zp24_dev *tpm_dev = dev_get_drvdata(&chip->dev);
 	int ret = 0;
 
-	if (gpio_is_valid(tpm_dev->io_lpcpd)) {
-		gpio_set_value(tpm_dev->io_lpcpd, 1);
+	if (tpm_dev->io_lpcpd) {
+		gpiod_set_value_cansleep(tpm_dev->io_lpcpd, 1);
 		ret = wait_for_stat(chip,
 				TPM_STS_VALID, chip->timeout_b,
 				&tpm_dev->read_queue, false);
diff --git a/drivers/char/tpm/st33zp24/st33zp24.h b/drivers/char/tpm/st33zp24/st33zp24.h
index 6a26dbc3206b..5acc85f711e6 100644
--- a/drivers/char/tpm/st33zp24/st33zp24.h
+++ b/drivers/char/tpm/st33zp24/st33zp24.h
@@ -20,7 +20,7 @@ struct st33zp24_dev {
 	int locality;
 	int irq;
 	u32 intrs;
-	int io_lpcpd;
+	struct gpio_desc *io_lpcpd;
 	wait_queue_head_t read_queue;
 };
 
@@ -36,6 +36,6 @@ int st33zp24_pm_resume(struct device *dev);
 #endif
 
 int st33zp24_probe(void *phy_id, const struct st33zp24_phy_ops *ops,
-		   struct device *dev, int irq, int io_lpcpd);
+		   struct device *dev, int irq);
 void st33zp24_remove(struct tpm_chip *chip);
 #endif /* __LOCAL_ST33ZP24_H__ */
-- 
2.37.3.998.g577e59143f-goog

