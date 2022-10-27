Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E91860F0FC
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Oct 2022 09:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbiJ0HNz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Oct 2022 03:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbiJ0HNy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Oct 2022 03:13:54 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3C278BC8;
        Thu, 27 Oct 2022 00:13:53 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y13so643463pfp.7;
        Thu, 27 Oct 2022 00:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aO2vSiBw4r8kxSG3x2i3TU8RhpwFlgnN7/8MKjdn5V8=;
        b=gHMufNYgTorNIK4InMe7Dj0RAninDI8s2CXXIxPeZYqPuvUoydVL50WgCIjUD6tFQD
         vkGLjZZv2VG30qWH9iSi7DNZEnC6xMDnEgJ9W6FoZRbnMmR709niHvmjdGWrcWg8uata
         lSv6W77/0NRd4hj09n/+aoFjUshn7LX5ifTQMThjJmUQxsdj2nIYQzmXawbgCF2wWZXt
         Gmwe4pAO55u14XLbIDxcOmN3Ovse+1b22u7WecmahZNSeaU/t5zCUTWVaTsM0iyqnLFB
         5j5aSf9Xq79hxOIeYCG29Vc7IMurihx4HOyI/bZKYZnusOJX6XBG123uCeltOm6ckmts
         1uqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aO2vSiBw4r8kxSG3x2i3TU8RhpwFlgnN7/8MKjdn5V8=;
        b=yp3ndAeUpCxZiaKLCYoqeIB3C44NihPegqdlvJJmwV4/DajvJxl6WfQs2zSiV++8AF
         CnmiSoAx9xvygdg7bIaLxDpjxPfsuKSQbRczBvwZCH5iA2OsrObkTMI5pJ/SOFQDwtfq
         Mo/JBOwxPDjU0vHkDHJXgoH6a2v586IAVB0fPiqlenGIIle8cZSdBatIsEb303t9XDd5
         WxxcmZYfnOGwEFq+v99DmRH+iW0BLF/TFTJkyrFyE7j39bfMKghvLp4CVD9TC2jBLWjV
         UUm6WMrwXuz/maOeARx2MTcQ7WFISYRS8I8IOCeEX4bOTZt+fPtzYIb+p3/uh2vWUIUc
         LKXA==
X-Gm-Message-State: ACrzQf1zOyKfJyvWTtL9x6/b3unUm4yR7XI8ThF3r6UO7gAr3sMm2zH+
        6nQ6pVr1oNrtWNi7rAofOfM=
X-Google-Smtp-Source: AMsMyM7c62gCHmDhwf0fkI1bBedhh2891jwMJODg6Mp91qSINRhz/wRejeHf+2Z3XJysL4z7Ri1+Vw==
X-Received: by 2002:a05:6a00:1781:b0:561:7f7f:dc38 with SMTP id s1-20020a056a00178100b005617f7fdc38mr48494158pfg.42.1666854833298;
        Thu, 27 Oct 2022 00:13:53 -0700 (PDT)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:99d6:ae15:f9aa:1819])
        by smtp.gmail.com with ESMTPSA id je11-20020a170903264b00b00186ac812ab0sm496321plb.83.2022.10.27.00.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 00:13:52 -0700 (PDT)
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] tpm: st33zp24: drop support for platform data
Date:   Thu, 27 Oct 2022 00:13:47 -0700
Message-Id: <20221027071349.991730-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
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

v3: switch back to using TPM_ST33_SPI macro when setting SPI driver name 
v2: reworked commit message

 drivers/char/tpm/st33zp24/i2c.c        | 41 ++-----------------------
 drivers/char/tpm/st33zp24/spi.c        | 42 ++------------------------
 drivers/char/tpm/st33zp24/st33zp24.h   |  3 ++
 include/linux/platform_data/st33zp24.h | 16 ----------
 4 files changed, 9 insertions(+), 93 deletions(-)
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
index 22d184884694..2b121d009959 100644
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
2.38.0.135.g90850a2211-goog

