Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6BEB179B9E
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Mar 2020 23:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388281AbgCDWRI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Mar 2020 17:17:08 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46088 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387931AbgCDWRH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Mar 2020 17:17:07 -0500
Received: by mail-lj1-f193.google.com with SMTP id h18so3781876ljl.13
        for <linux-integrity@vger.kernel.org>; Wed, 04 Mar 2020 14:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e0IGbicvIOAX1Ub5RitX2a+DGhKH0sv9c2R9XvU1NYE=;
        b=eIdp12CJRvDHpLS0LqNELUU9O8bbx0YGNfm2q6SsETelIIRGVvq9BKlmJZ36i335j1
         gi57yHNDIo4IwcKd0IRzQ28DsqQE+CRLb+abjS3t8flloErYC5cc6aRmCBv0FdABXjmx
         kjaJC+KphNlFtB67Sz3RTZbz1yuocMLDQ6hjvCV4xyXiCRpMXQWYjBNoLiERYqTvzs+D
         UcXdmrxE/mkA2qF9OQ2spBMxHzmCN+zdbvN8LmzXj+JQKdL3lnij2XuEBncJZiGIpiYq
         R5kUa0rHYSzIbW47i6UURtoQQVnjEkgLdeGbXo5Xf8Py5ggfdBeEubi6oSDlpe11DOlx
         UvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e0IGbicvIOAX1Ub5RitX2a+DGhKH0sv9c2R9XvU1NYE=;
        b=ok2CBtEK72Imj59ryffHrZhnyzq9DJilaBHu29VC++pn4i3Zdkv1Gz5C7530n8LcNF
         CjsmDjHYtgFqLwLevLIHhEAAMhZj8SM/I//UO+rTVU4GYBAhHeC03xTeesyrhu7UZwsw
         DkB75vGl/g6h13osr7x6dMMz/6twfzQWytgasIyCMLGORMVW5wRf5Oa0bc1ULRRjp9aQ
         DMnXS9Yaj49q1STYEKQP+n40q5lH9dXJMzNUy0bHMmnGVjwjg4tCy3nmve/7vLyOPeYl
         8auUGk2vN4Kt+z3iFDiKp6CfEOQzzYCsBVQ44ecmgN8B4BZkj7V1QCmEYfrThqmvgAuA
         0wOA==
X-Gm-Message-State: ANhLgQ3NgMQ5mgXQ8U0pNg0BdpbJxoTVOFdXiGSG2ggDu1fdwFYZ1+Gk
        9vIWz3YIwSF9htvmEd2vhcrdbA==
X-Google-Smtp-Source: ADFU+vs+v9lwU1J0zDnJMXLB8GZNdX2i4bRTHJL8ERz24DEE4YAdBaype8OX7lFwR7NtaxHuy8urYw==
X-Received: by 2002:a2e:7c04:: with SMTP id x4mr3353698ljc.60.1583360225176;
        Wed, 04 Mar 2020 14:17:05 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-5ac9225c.014-348-6c756e10.bbcust.telenor.se. [92.34.201.90])
        by smtp.gmail.com with ESMTPSA id 67sm10881109ljj.31.2020.03.04.14.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 14:17:04 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-integrity@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Jeremy Boone <jeremy.boone@nccgroup.trust>
Subject: [PATCH] tpm: st33zp24: Convert to use GPIO descriptors
Date:   Wed,  4 Mar 2020 23:17:00 +0100
Message-Id: <20200304221700.22958-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The ST33ZP24 is using the old deprecated GPIO API.
It also goes to some measures to convert from the
new to the old API in the ACPI probe path of both
the I2C and SPI interfaces for the module.

Change the driver and subdrivers to use struct
gpio_desc * all the way and pass this around in
platform data and in probe and all associated
functions.

Cc: Jeremy Boone <jeremy.boone@nccgroup.trust>
Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/char/tpm/st33zp24/i2c.c        | 44 +++++--------------------
 drivers/char/tpm/st33zp24/spi.c        | 45 +++++---------------------
 drivers/char/tpm/st33zp24/st33zp24.c   | 12 +++----
 drivers/char/tpm/st33zp24/st33zp24.h   |  6 ++--
 include/linux/platform_data/st33zp24.h |  4 ++-
 5 files changed, 29 insertions(+), 82 deletions(-)

diff --git a/drivers/char/tpm/st33zp24/i2c.c b/drivers/char/tpm/st33zp24/i2c.c
index 35333b65acd1..9daa55894c3b 100644
--- a/drivers/char/tpm/st33zp24/i2c.c
+++ b/drivers/char/tpm/st33zp24/i2c.c
@@ -6,10 +6,8 @@
 
 #include <linux/module.h>
 #include <linux/i2c.h>
-#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/of_irq.h>
-#include <linux/of_gpio.h>
 #include <linux/acpi.h>
 #include <linux/tpm.h>
 #include <linux/platform_data/st33zp24.h>
@@ -22,7 +20,7 @@
 struct st33zp24_i2c_phy {
 	struct i2c_client *client;
 	u8 buf[ST33ZP24_BUFSIZE + 1];
-	int io_lpcpd;
+	struct gpio_desc *io_lpcpd;
 };
 
 /*
@@ -124,7 +122,7 @@ static int st33zp24_i2c_acpi_request_resources(struct i2c_client *client)
 	if (IS_ERR(gpiod_lpcpd)) {
 		dev_err(&client->dev,
 			"Failed to retrieve lpcpd-gpios from acpi.\n");
-		phy->io_lpcpd = -1;
+		phy->io_lpcpd = NULL;
 		/*
 		 * lpcpd pin is not specified. This is not an issue as
 		 * power management can be also managed by TPM specific
@@ -133,7 +131,7 @@ static int st33zp24_i2c_acpi_request_resources(struct i2c_client *client)
 		return 0;
 	}
 
-	phy->io_lpcpd = desc_to_gpio(gpiod_lpcpd);
+	phy->io_lpcpd = gpiod_lpcpd;
 
 	return 0;
 }
@@ -143,22 +141,14 @@ static int st33zp24_i2c_of_request_resources(struct i2c_client *client)
 	struct tpm_chip *chip = i2c_get_clientdata(client);
 	struct st33zp24_dev *tpm_dev = dev_get_drvdata(&chip->dev);
 	struct st33zp24_i2c_phy *phy = tpm_dev->phy_id;
-	struct device_node *pp;
-	int gpio;
-	int ret;
-
-	pp = client->dev.of_node;
-	if (!pp) {
-		dev_err(&client->dev, "No platform data\n");
-		return -ENODEV;
-	}
+	struct gpio_desc *gpiod;
 
 	/* Get GPIO from device tree */
-	gpio = of_get_named_gpio(pp, "lpcpd-gpios", 0);
-	if (gpio < 0) {
+	gpiod = devm_gpiod_get(&client->dev, "lpcpd", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpiod)) {
 		dev_err(&client->dev,
 			"Failed to retrieve lpcpd-gpios from dts.\n");
-		phy->io_lpcpd = -1;
+		phy->io_lpcpd = NULL;
 		/*
 		 * lpcpd pin is not specified. This is not an issue as
 		 * power management can be also managed by TPM specific
@@ -166,14 +156,7 @@ static int st33zp24_i2c_of_request_resources(struct i2c_client *client)
 		 */
 		return 0;
 	}
-	/* GPIO request and configuration */
-	ret = devm_gpio_request_one(&client->dev, gpio,
-			GPIOF_OUT_INIT_HIGH, "TPM IO LPCPD");
-	if (ret) {
-		dev_err(&client->dev, "Failed to request lpcpd pin\n");
-		return -ENODEV;
-	}
-	phy->io_lpcpd = gpio;
+	phy->io_lpcpd = gpiod;
 
 	return 0;
 }
@@ -184,7 +167,6 @@ static int st33zp24_i2c_request_resources(struct i2c_client *client)
 	struct st33zp24_dev *tpm_dev = dev_get_drvdata(&chip->dev);
 	struct st33zp24_i2c_phy *phy = tpm_dev->phy_id;
 	struct st33zp24_platform_data *pdata;
-	int ret;
 
 	pdata = client->dev.platform_data;
 	if (!pdata) {
@@ -195,16 +177,6 @@ static int st33zp24_i2c_request_resources(struct i2c_client *client)
 	/* store for late use */
 	phy->io_lpcpd = pdata->io_lpcpd;
 
-	if (gpio_is_valid(pdata->io_lpcpd)) {
-		ret = devm_gpio_request_one(&client->dev,
-				pdata->io_lpcpd, GPIOF_OUT_INIT_HIGH,
-				"TPM IO_LPCPD");
-		if (ret) {
-			dev_err(&client->dev, "Failed to request lpcpd pin\n");
-			return ret;
-		}
-	}
-
 	return 0;
 }
 
diff --git a/drivers/char/tpm/st33zp24/spi.c b/drivers/char/tpm/st33zp24/spi.c
index 26e09de50f1e..279525e258a6 100644
--- a/drivers/char/tpm/st33zp24/spi.c
+++ b/drivers/char/tpm/st33zp24/spi.c
@@ -6,10 +6,8 @@
 
 #include <linux/module.h>
 #include <linux/spi/spi.h>
-#include <linux/gpio.h>
 #include <linux/gpio/consumer.h>
 #include <linux/of_irq.h>
-#include <linux/of_gpio.h>
 #include <linux/acpi.h>
 #include <linux/tpm.h>
 #include <linux/platform_data/st33zp24.h>
@@ -61,7 +59,7 @@ struct st33zp24_spi_phy {
 	u8 tx_buf[ST33ZP24_SPI_BUFFER_SIZE];
 	u8 rx_buf[ST33ZP24_SPI_BUFFER_SIZE];
 
-	int io_lpcpd;
+	struct gpio_desc *io_lpcpd;
 	int latency;
 };
 
@@ -242,7 +240,7 @@ static int st33zp24_spi_acpi_request_resources(struct spi_device *spi_dev)
 	gpiod_lpcpd = devm_gpiod_get(dev, "lpcpd", GPIOD_OUT_HIGH);
 	if (IS_ERR(gpiod_lpcpd)) {
 		dev_err(dev, "Failed to retrieve lpcpd-gpios from acpi.\n");
-		phy->io_lpcpd = -1;
+		phy->io_lpcpd = NULL;
 		/*
 		 * lpcpd pin is not specified. This is not an issue as
 		 * power management can be also managed by TPM specific
@@ -251,7 +249,7 @@ static int st33zp24_spi_acpi_request_resources(struct spi_device *spi_dev)
 		return 0;
 	}
 
-	phy->io_lpcpd = desc_to_gpio(gpiod_lpcpd);
+	phy->io_lpcpd = gpiod_lpcpd;
 
 	return 0;
 }
@@ -261,22 +259,14 @@ static int st33zp24_spi_of_request_resources(struct spi_device *spi_dev)
 	struct tpm_chip *chip = spi_get_drvdata(spi_dev);
 	struct st33zp24_dev *tpm_dev = dev_get_drvdata(&chip->dev);
 	struct st33zp24_spi_phy *phy = tpm_dev->phy_id;
-	struct device_node *pp;
-	int gpio;
-	int ret;
-
-	pp = spi_dev->dev.of_node;
-	if (!pp) {
-		dev_err(&spi_dev->dev, "No platform data\n");
-		return -ENODEV;
-	}
+	struct gpio_desc *gpiod;
 
 	/* Get GPIO from device tree */
-	gpio = of_get_named_gpio(pp, "lpcpd-gpios", 0);
-	if (gpio < 0) {
+	gpiod = devm_gpiod_get(&spi_dev->dev, "lpcpd", GPIOD_OUT_HIGH);
+	if (IS_ERR(gpiod)) {
 		dev_err(&spi_dev->dev,
 			"Failed to retrieve lpcpd-gpios from dts.\n");
-		phy->io_lpcpd = -1;
+		phy->io_lpcpd = NULL;
 		/*
 		 * lpcpd pin is not specified. This is not an issue as
 		 * power management can be also managed by TPM specific
@@ -284,14 +274,7 @@ static int st33zp24_spi_of_request_resources(struct spi_device *spi_dev)
 		 */
 		return 0;
 	}
-	/* GPIO request and configuration */
-	ret = devm_gpio_request_one(&spi_dev->dev, gpio,
-			GPIOF_OUT_INIT_HIGH, "TPM IO LPCPD");
-	if (ret) {
-		dev_err(&spi_dev->dev, "Failed to request lpcpd pin\n");
-		return -ENODEV;
-	}
-	phy->io_lpcpd = gpio;
+	phy->io_lpcpd = gpiod;
 
 	return 0;
 }
@@ -302,7 +285,6 @@ static int st33zp24_spi_request_resources(struct spi_device *dev)
 	struct st33zp24_dev *tpm_dev = dev_get_drvdata(&chip->dev);
 	struct st33zp24_spi_phy *phy = tpm_dev->phy_id;
 	struct st33zp24_platform_data *pdata;
-	int ret;
 
 	pdata = dev->dev.platform_data;
 	if (!pdata) {
@@ -313,17 +295,6 @@ static int st33zp24_spi_request_resources(struct spi_device *dev)
 	/* store for late use */
 	phy->io_lpcpd = pdata->io_lpcpd;
 
-	if (gpio_is_valid(pdata->io_lpcpd)) {
-		ret = devm_gpio_request_one(&dev->dev,
-				pdata->io_lpcpd, GPIOF_OUT_INIT_HIGH,
-				"TPM IO_LPCPD");
-		if (ret) {
-			dev_err(&dev->dev, "%s : reset gpio_request failed\n",
-				__FILE__);
-			return ret;
-		}
-	}
-
 	return 0;
 }
 
diff --git a/drivers/char/tpm/st33zp24/st33zp24.c b/drivers/char/tpm/st33zp24/st33zp24.c
index 37bb13f516be..0cacc13df25d 100644
--- a/drivers/char/tpm/st33zp24/st33zp24.c
+++ b/drivers/char/tpm/st33zp24/st33zp24.c
@@ -12,7 +12,7 @@
 #include <linux/freezer.h>
 #include <linux/string.h>
 #include <linux/interrupt.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/sched.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
@@ -508,7 +508,7 @@ static const struct tpm_class_ops st33zp24_tpm = {
  *	 -1 in other case.
  */
 int st33zp24_probe(void *phy_id, const struct st33zp24_phy_ops *ops,
-		   struct device *dev, int irq, int io_lpcpd)
+		   struct device *dev, int irq, struct gpio_desc *io_lpcpd)
 {
 	int ret;
 	u8 intmask = 0;
@@ -609,8 +609,8 @@ int st33zp24_pm_suspend(struct device *dev)
 
 	int ret = 0;
 
-	if (gpio_is_valid(tpm_dev->io_lpcpd))
-		gpio_set_value(tpm_dev->io_lpcpd, 0);
+	if (tpm_dev->io_lpcpd)
+		gpiod_set_value(tpm_dev->io_lpcpd, 0);
 	else
 		ret = tpm_pm_suspend(dev);
 
@@ -629,8 +629,8 @@ int st33zp24_pm_resume(struct device *dev)
 	struct st33zp24_dev *tpm_dev = dev_get_drvdata(&chip->dev);
 	int ret = 0;
 
-	if (gpio_is_valid(tpm_dev->io_lpcpd)) {
-		gpio_set_value(tpm_dev->io_lpcpd, 1);
+	if (tpm_dev->io_lpcpd) {
+		gpiod_set_value(tpm_dev->io_lpcpd, 1);
 		ret = wait_for_stat(chip,
 				TPM_STS_VALID, chip->timeout_b,
 				&tpm_dev->read_queue, false);
diff --git a/drivers/char/tpm/st33zp24/st33zp24.h b/drivers/char/tpm/st33zp24/st33zp24.h
index 6747be1e2502..3a8871eebbb6 100644
--- a/drivers/char/tpm/st33zp24/st33zp24.h
+++ b/drivers/char/tpm/st33zp24/st33zp24.h
@@ -10,6 +10,8 @@
 #define TPM_WRITE_DIRECTION	0x80
 #define ST33ZP24_BUFSIZE	2048
 
+struct gpio_desc;
+
 struct st33zp24_dev {
 	struct tpm_chip *chip;
 	void *phy_id;
@@ -17,7 +19,7 @@ struct st33zp24_dev {
 	int locality;
 	int irq;
 	u32 intrs;
-	int io_lpcpd;
+	struct gpio_desc *io_lpcpd;
 	wait_queue_head_t read_queue;
 };
 
@@ -33,6 +35,6 @@ int st33zp24_pm_resume(struct device *dev);
 #endif
 
 int st33zp24_probe(void *phy_id, const struct st33zp24_phy_ops *ops,
-		   struct device *dev, int irq, int io_lpcpd);
+		   struct device *dev, int irq, struct gpio_desc *io_lpcpd);
 int st33zp24_remove(struct tpm_chip *chip);
 #endif /* __LOCAL_ST33ZP24_H__ */
diff --git a/include/linux/platform_data/st33zp24.h b/include/linux/platform_data/st33zp24.h
index 61db674f36cc..933034350ff5 100644
--- a/include/linux/platform_data/st33zp24.h
+++ b/include/linux/platform_data/st33zp24.h
@@ -9,8 +9,10 @@
 #define TPM_ST33_I2C			"st33zp24-i2c"
 #define TPM_ST33_SPI			"st33zp24-spi"
 
+struct gpio_desc;
+
 struct st33zp24_platform_data {
-	int io_lpcpd;
+	struct gpio_desc *io_lpcpd;
 };
 
 #endif /* __ST33ZP24_H__ */
-- 
2.17.1

