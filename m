Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFDB5E98D6
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Sep 2022 07:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbiIZFkI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Sep 2022 01:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbiIZFkH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Sep 2022 01:40:07 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B53A167F8;
        Sun, 25 Sep 2022 22:40:02 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id b75so5593630pfb.7;
        Sun, 25 Sep 2022 22:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=q5q/pcoR5gK1IIB9xUnqRycDl4QSWIGORl5qJdRKAlU=;
        b=kilmXACPBwgGDUyCOTufSNuEpS5jGnEpSeJ5P0H++obXSnftsE968Z4jODHCWlVkfI
         YWm3hxV3GrFKj2G5McycpTffYH3kTeUDVNRR3NThIGOxZAne5LoTuZorzX3soSIsXVe8
         Q67S59ORA1wyGuI6rpdrvficI+aWLEGditR0c3OPADLyNROFOJYbPtl2Wvbv9yRT2Gm7
         ywQMfHxCDDNir1XxhufVuok+WF5QACRFAdvtWagRKK2xB/wb9b/Ie4m65hJlXdsgwDQ5
         0CKvWg/qIFWDddNn0lbprIiyeuQyu0JAlq8PGckuMiWiejrgmPJz/t15+eQDtOBvEEif
         zjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=q5q/pcoR5gK1IIB9xUnqRycDl4QSWIGORl5qJdRKAlU=;
        b=rP94jJcEAixegrV1LctYGf0y3riaN6khO2cvDxz5//y1y4Z++GSP1T4UKlVhYBhAHA
         KeSgUp3c/vlVRU2lzh81ox0Il6cIq7f4XMi96c68tmTFH6LGR87Z2Q5udXZ4gkWWVl/B
         5VK4u0SxsJhs7bUz0Xk65bgWvm3Clqx/Yfe1TUDoiEHYATaY+ZUlLJtrGKzFsOqBatNj
         XVIZ5AiTy7r/f8srgYxzXYNMBwXRFmL5t7YK/+bpUK0WmApfKrw0ei994yAlULABZ1ZD
         ohhv7hUpqXFqcE2tnsNlsI4hflbGRyhNXTKUopWbKXcPxC1QcnuqbXPgZ2pkel0y2C9+
         5Vzw==
X-Gm-Message-State: ACrzQf2F2odD9jS2dsTOY3A9vgkeOsrh9tMhXfcWmmSVuUpmgiN/bl9M
        PmQytuhTPo+k5zLOZs4KHp0=
X-Google-Smtp-Source: AMsMyM78fghL+9zCc59H4edjUDWmgdkmu+TEpSQdhvWRz0P58xy4ODEN8U8p8KfxSovhuZpbz6Lvgg==
X-Received: by 2002:a05:6a02:10e:b0:43b:e57d:2bfa with SMTP id bg14-20020a056a02010e00b0043be57d2bfamr18019941pgb.263.1664170801725;
        Sun, 25 Sep 2022 22:40:01 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:7e1b:858c:19dc:934])
        by smtp.gmail.com with ESMTPSA id h18-20020a170902f71200b00176b0dec886sm10120350plo.58.2022.09.25.22.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 22:40:01 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] tpm: st33zp24: drop support for platform data
Date:   Sun, 25 Sep 2022 22:39:56 -0700
Message-Id: <20220926053958.1541912-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
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

There are no users of st33zp24_platform_data in mainline, and new boards
should be using device tree or ACPI to describe resources, so let's drop
support for platform data from the driver.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/char/tpm/st33zp24/i2c.c        | 41 ++----------------------
 drivers/char/tpm/st33zp24/spi.c        | 44 +++-----------------------
 drivers/char/tpm/st33zp24/st33zp24.h   |  3 ++
 include/linux/platform_data/st33zp24.h | 16 ----------
 4 files changed, 10 insertions(+), 94 deletions(-)
 delete mode 100644 include/linux/platform_data/st33zp24.h

diff --git a/drivers/char/tpm/st33zp24/i2c.c b/drivers/char/tpm/st33zp24/i2c.c
index a3aa411389e7..c560532647c8 100644
--- a/drivers/char/tpm/st33zp24/i2c.c
+++ b/drivers/char/tpm/st33zp24/i2c.c
@@ -12,7 +12,6 @@
 #include <linux/of_gpio.h>
 #include <linux/acpi.h>
 #include <linux/tpm.h>
-#include <linux/platform_data/st33zp24.h>
 
 #include "../tpm.h"
 #include "st33zp24.h"
@@ -178,36 +177,6 @@ static int st33zp24_i2c_of_request_resources(struct i2c_client *client)
 	return 0;
 }
 
-static int st33zp24_i2c_request_resources(struct i2c_client *client)
-{
-	struct tpm_chip *chip = i2c_get_clientdata(client);
-	struct st33zp24_dev *tpm_dev = dev_get_drvdata(&chip->dev);
-	struct st33zp24_i2c_phy *phy = tpm_dev->phy_id;
-	struct st33zp24_platform_data *pdata;
-	int ret;
-
-	pdata = client->dev.platform_data;
-	if (!pdata) {
-		dev_err(&client->dev, "No platform data\n");
-		return -ENODEV;
-	}
-
-	/* store for late use */
-	phy->io_lpcpd = pdata->io_lpcpd;
-
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
-	return 0;
-}
-
 /*
  * st33zp24_i2c_probe initialize the TPM device
  * @param: client, the i2c_client description (TPM I2C description).
@@ -219,7 +188,6 @@ static int st33zp24_i2c_probe(struct i2c_client *client,
 			      const struct i2c_device_id *id)
 {
 	int ret;
-	struct st33zp24_platform_data *pdata;
 	struct st33zp24_i2c_phy *phy;
 
 	if (!client) {
@@ -240,19 +208,16 @@ static int st33zp24_i2c_probe(struct i2c_client *client,
 
 	phy->client = client;
 
-	pdata = client->dev.platform_data;
-	if (!pdata && client->dev.of_node) {
+	if (client->dev.of_node) {
 		ret = st33zp24_i2c_of_request_resources(client);
 		if (ret)
 			return ret;
-	} else if (pdata) {
-		ret = st33zp24_i2c_request_resources(client);
-		if (ret)
-			return ret;
 	} else if (ACPI_HANDLE(&client->dev)) {
 		ret = st33zp24_i2c_acpi_request_resources(client);
 		if (ret)
 			return ret;
+	} else {
+		return -ENODEV;
 	}
 
 	return st33zp24_probe(phy, &i2c_phy_ops, &client->dev, client->irq,
diff --git a/drivers/char/tpm/st33zp24/spi.c b/drivers/char/tpm/st33zp24/spi.c
index 22d184884694..49630f2cb9b4 100644
--- a/drivers/char/tpm/st33zp24/spi.c
+++ b/drivers/char/tpm/st33zp24/spi.c
@@ -12,7 +12,6 @@
 #include <linux/of_gpio.h>
 #include <linux/acpi.h>
 #include <linux/tpm.h>
-#include <linux/platform_data/st33zp24.h>
 
 #include "../tpm.h"
 #include "st33zp24.h"
@@ -296,37 +295,6 @@ static int st33zp24_spi_of_request_resources(struct spi_device *spi_dev)
 	return 0;
 }
 
-static int st33zp24_spi_request_resources(struct spi_device *dev)
-{
-	struct tpm_chip *chip = spi_get_drvdata(dev);
-	struct st33zp24_dev *tpm_dev = dev_get_drvdata(&chip->dev);
-	struct st33zp24_spi_phy *phy = tpm_dev->phy_id;
-	struct st33zp24_platform_data *pdata;
-	int ret;
-
-	pdata = dev->dev.platform_data;
-	if (!pdata) {
-		dev_err(&dev->dev, "No platform data\n");
-		return -ENODEV;
-	}
-
-	/* store for late use */
-	phy->io_lpcpd = pdata->io_lpcpd;
-
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
-	return 0;
-}
-
 /*
  * st33zp24_spi_probe initialize the TPM device
  * @param: dev, the spi_device description (TPM SPI description).
@@ -336,7 +304,6 @@ static int st33zp24_spi_request_resources(struct spi_device *dev)
 static int st33zp24_spi_probe(struct spi_device *dev)
 {
 	int ret;
-	struct st33zp24_platform_data *pdata;
 	struct st33zp24_spi_phy *phy;
 
 	/* Check SPI platform functionnalities */
@@ -353,19 +320,16 @@ static int st33zp24_spi_probe(struct spi_device *dev)
 
 	phy->spi_device = dev;
 
-	pdata = dev->dev.platform_data;
-	if (!pdata && dev->dev.of_node) {
+	if (dev->dev.of_node) {
 		ret = st33zp24_spi_of_request_resources(dev);
 		if (ret)
 			return ret;
-	} else if (pdata) {
-		ret = st33zp24_spi_request_resources(dev);
-		if (ret)
-			return ret;
 	} else if (ACPI_HANDLE(&dev->dev)) {
 		ret = st33zp24_spi_acpi_request_resources(dev);
 		if (ret)
 			return ret;
+	} else {
+		return -ENODEV;
 	}
 
 	phy->latency = st33zp24_spi_evaluate_latency(phy);
@@ -411,7 +375,7 @@ static SIMPLE_DEV_PM_OPS(st33zp24_spi_ops, st33zp24_pm_suspend,
 
 static struct spi_driver st33zp24_spi_driver = {
 	.driver = {
-		.name = TPM_ST33_SPI,
+		.name = "st33zp24-spi",
 		.pm = &st33zp24_spi_ops,
 		.of_match_table = of_match_ptr(of_st33zp24_spi_match),
 		.acpi_match_table = ACPI_PTR(st33zp24_spi_acpi_match),
diff --git a/drivers/char/tpm/st33zp24/st33zp24.h b/drivers/char/tpm/st33zp24/st33zp24.h
index b387a476c555..6a26dbc3206b 100644
--- a/drivers/char/tpm/st33zp24/st33zp24.h
+++ b/drivers/char/tpm/st33zp24/st33zp24.h
@@ -7,6 +7,9 @@
 #ifndef __LOCAL_ST33ZP24_H__
 #define __LOCAL_ST33ZP24_H__
 
+#define TPM_ST33_I2C		"st33zp24-i2c"
+#define TPM_ST33_SPI		"st33zp24-spi"
+
 #define TPM_WRITE_DIRECTION	0x80
 #define ST33ZP24_BUFSIZE	2048
 
diff --git a/include/linux/platform_data/st33zp24.h b/include/linux/platform_data/st33zp24.h
deleted file mode 100644
index 61db674f36cc..000000000000
--- a/include/linux/platform_data/st33zp24.h
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * STMicroelectronics TPM Linux driver for TPM 1.2 ST33ZP24
- * Copyright (C) 2009 - 2016  STMicroelectronics
- */
-#ifndef __ST33ZP24_H__
-#define __ST33ZP24_H__
-
-#define TPM_ST33_I2C			"st33zp24-i2c"
-#define TPM_ST33_SPI			"st33zp24-spi"
-
-struct st33zp24_platform_data {
-	int io_lpcpd;
-};
-
-#endif /* __ST33ZP24_H__ */
-- 
2.37.3.998.g577e59143f-goog

