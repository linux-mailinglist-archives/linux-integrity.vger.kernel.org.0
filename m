Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D5C5F1A0B
	for <lists+linux-integrity@lfdr.de>; Sat,  1 Oct 2022 07:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiJAFvt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 1 Oct 2022 01:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiJAFvr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 1 Oct 2022 01:51:47 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5A0137451;
        Fri, 30 Sep 2022 22:51:46 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y136so5953331pfb.3;
        Fri, 30 Sep 2022 22:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=FV47g6lAcQSfb+7QY+ZpJxz+UQ0YfOzzXjOAaXjtTy0=;
        b=fPainYGL6a1+XkzQMHZT/g9kKe2+J/JY8J4W52BkCdqA3uFxCGAIVc7GKqiVyZtavT
         e5OBIip+7bOJgh/tIvZVqPhtm/UNgG0oWrTTN72OwT7+v6ytFI3QmAz8BkXmafTjzyoT
         /M1TIgMtGWIZj3JlkP2v8JDjWHpi2A1HkqFic1Ko3I/03TCK70OWU2J1zJClC27mgSmx
         neKUTCvYuTwY7PZFhdeNoXCfmxS6Vn4r6YiwQHqbQr7R/us5ihCYwcDPkwxVb1rtGt+1
         axrZdAw0AiBNt7XIaS8SCKtc3bP4pkpgYKUbkqirq9ehpCCm5KPF+GaBGwLfsOLHFxMv
         tCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=FV47g6lAcQSfb+7QY+ZpJxz+UQ0YfOzzXjOAaXjtTy0=;
        b=H+W1etyFo65763/9tc52qlY4b/sHuuOUxG9YEoe4Ht5ziGE8jIaU2bXn4deQibtPTO
         PA9IPbFaqSYZ7gMVpkWTnWP1pU4j+cjyNbhSl0bsKVBu2+Ojnqgx5SkLy47o+zI4aBvb
         9PrnftMOMNVzot8aIx5C8EilNoNT6xcUMsutxkhG92shJ5Npj65RFLwqKsAXALNTZ44j
         EsfF0YbTREj5chSpm0G1fC3JLFuru45imbDhvnkqx3522FCOB5PIYU+tTSTZj/Memh68
         PhaIORWJtd6uIon89uBLv0lGPhBxtEd9yrDGqgvLPse5gaRVKl6x/LILFNmZusIR2AMj
         FYdw==
X-Gm-Message-State: ACrzQf38IAbYtDt+hs2DRsWV2x6HSJoDUelpzNyEvklFvXT1nJ6VjRVa
        tCmk+KE2V+RebZEqgGpPrlzmhewmBWs=
X-Google-Smtp-Source: AMsMyM5W6aUGtunVqKSYaUjzv0N9wkPILZ1gFtTaIEpKkVyToK93U+WwAM8hEOUtqzESp518VbOYtA==
X-Received: by 2002:a05:6a00:d4b:b0:53f:4690:d31 with SMTP id n11-20020a056a000d4b00b0053f46900d31mr12473437pfv.73.1664603506266;
        Fri, 30 Sep 2022 22:51:46 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:63e7:415:943b:4707])
        by smtp.gmail.com with ESMTPSA id z25-20020aa79599000000b0055f6a0d82e0sm613268pfj.51.2022.09.30.22.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 22:51:45 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] tpm: st33zp24: drop support for platform data
Date:   Fri, 30 Sep 2022 22:51:40 -0700
Message-Id: <20221001055142.3196483-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
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

Drop support for platform data from the driver because there are no
users of st33zp24_platform_data structure in the mainline kernel.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

v2: reworked commit message

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
2.38.0.rc1.362.ged0d419d3c-goog

