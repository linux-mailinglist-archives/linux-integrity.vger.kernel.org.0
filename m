Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6C98AA80
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Aug 2019 00:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfHLWgk (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Aug 2019 18:36:40 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36029 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbfHLWg3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Aug 2019 18:36:29 -0400
Received: by mail-pf1-f196.google.com with SMTP id r7so50424556pfl.3
        for <linux-integrity@vger.kernel.org>; Mon, 12 Aug 2019 15:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0c9PwmTM9ltU5QnbUwiYR8+C/VbtsAVi1RzWAMtBrRs=;
        b=NSVNdUkTnYkW+V2DvGuJh+mIquZ2rsUpyqli1yFhBeJl1XeDySN2NQPqxaroQcm+7m
         /lc8OR8QNA2uSqZ4XWj4jcnAXoci1AswHQyzxpZKQKyzY2L+sfUYQMz5l33B3A2LlHm5
         4bYXPSA++/AzcxL++LzN2BNxysR06xyhu1P9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0c9PwmTM9ltU5QnbUwiYR8+C/VbtsAVi1RzWAMtBrRs=;
        b=HvSyjBjcus+xZ86xbmRAavvZnJg4xYCsAyALYLLsvuGkqWRwpk7CpyRBjlhiYPrerk
         CInB5m7SyW/tIZvKxUmxN2cgwImsNBFvFZVdtxTWOWpblzzuQo8Oe4nNS1+opd6KNBB5
         pAMOYYRELtsWiDnR8FKdq+cT6kPulygqyo8yg7j2sOFJIkamFo5Nekp+Cgk+QrTiweFJ
         N9brvYDNZdpL3D5uXivwn2RxRnwfgLUn/OVLW0ZBGqxFxDrMqRaTAwW4s/g1a7aTOM7q
         9nb7vBUXmEXgamV/JG2ea00dbjmlRBP1Fxf5HPlThOYnqi8Rubem6DfJZTeiwQqpn9K1
         1jEg==
X-Gm-Message-State: APjAAAUSUzI8FSVuRRAmL9F5xMCKJJGrdMkmQOs2BDwZK0D38ormvZeM
        SgALZ1uyHDT0m9AOBhxZBBs0Bu172aXfyQ==
X-Google-Smtp-Source: APXvYqzdYeQ+IDgSl0t3LCKduwWR6Vzyc0PPLvErKyjapSqGM173P9/NUNDxkIuv/5ftEGNmS02aoQ==
X-Received: by 2002:aa7:8f2e:: with SMTP id y14mr8497036pfr.113.1565649387975;
        Mon, 12 Aug 2019 15:36:27 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b6sm93911594pgq.26.2019.08.12.15.36.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 15:36:27 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: [PATCH v4 4/6] tpm: tpm_tis_spi: Export functionality to other drivers
Date:   Mon, 12 Aug 2019 15:36:20 -0700
Message-Id: <20190812223622.73297-5-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
In-Reply-To: <20190812223622.73297-1-swboyd@chromium.org>
References: <20190812223622.73297-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Export a new function, tpm_tis_spi_init(), and the associated
read/write/transfer APIs so that we can create variant drivers based on
the core functionality of this TPM SPI driver. Variant drivers can wrap
the tpm_tis_spi_phy struct with their own struct and override the
behavior of tpm_tis_spi_transfer() by supplying their own flow control
and pre-transfer hooks. This shares the most code between the core
driver and any variants that want to override certain behavior without
cluttering the core driver.

Cc: Andrey Pronin <apronin@chromium.org>
Cc: Duncan Laurie <dlaurie@chromium.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Alexander Steffen <Alexander.Steffen@infineon.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/char/tpm/tpm_tis_spi.c | 52 ++++++++++++++++------------------
 drivers/char/tpm/tpm_tis_spi.h | 37 ++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 27 deletions(-)
 create mode 100644 drivers/char/tpm/tpm_tis_spi.h

diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_spi.c
index 93f49b1941f0..fd3fb4f9f506 100644
--- a/drivers/char/tpm/tpm_tis_spi.c
+++ b/drivers/char/tpm/tpm_tis_spi.c
@@ -36,23 +36,10 @@
 #include <linux/tpm.h>
 #include "tpm.h"
 #include "tpm_tis_core.h"
+#include "tpm_tis_spi.h"
 
 #define MAX_SPI_FRAMESIZE 64
 
-struct tpm_tis_spi_phy {
-	struct tpm_tis_data priv;
-	struct spi_device *spi_device;
-	int (*flow_control)(struct tpm_tis_spi_phy *phy,
-			    struct spi_transfer *xfer);
-	void (*pre_transfer)(struct tpm_tis_spi_phy *phy);
-	u8 *iobuf;
-};
-
-static inline struct tpm_tis_spi_phy *to_tpm_tis_spi_phy(struct tpm_tis_data *data)
-{
-	return container_of(data, struct tpm_tis_spi_phy, priv);
-}
-
 static int tpm_tis_spi_flow_control(struct tpm_tis_spi_phy *phy,
 				    struct spi_transfer *spi_xfer)
 {
@@ -81,7 +68,7 @@ static int tpm_tis_spi_flow_control(struct tpm_tis_spi_phy *phy,
 	return 0;
 }
 
-static int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
+int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
 				u8 *in, const u8 *out)
 {
 	struct tpm_tis_spi_phy *phy = to_tpm_tis_spi_phy(data);
@@ -148,9 +135,10 @@ static int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
 	spi_bus_unlock(phy->spi_device->master);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(tpm_tis_spi_transfer);
 
-static int tpm_tis_spi_read_bytes(struct tpm_tis_data *data, u32 addr,
-				  u16 len, u8 *result)
+static int tpm_tis_spi_read_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
+				  u8 *result)
 {
 	return tpm_tis_spi_transfer(data, addr, len, result, NULL);
 }
@@ -161,7 +149,7 @@ static int tpm_tis_spi_write_bytes(struct tpm_tis_data *data, u32 addr,
 	return tpm_tis_spi_transfer(data, addr, len, NULL, value);
 }
 
-static int tpm_tis_spi_read16(struct tpm_tis_data *data, u32 addr, u16 *result)
+int tpm_tis_spi_read16(struct tpm_tis_data *data, u32 addr, u16 *result)
 {
 	__le16 result_le;
 	int rc;
@@ -173,8 +161,9 @@ static int tpm_tis_spi_read16(struct tpm_tis_data *data, u32 addr, u16 *result)
 
 	return rc;
 }
+EXPORT_SYMBOL_GPL(tpm_tis_spi_read16);
 
-static int tpm_tis_spi_read32(struct tpm_tis_data *data, u32 addr, u32 *result)
+int tpm_tis_spi_read32(struct tpm_tis_data *data, u32 addr, u32 *result)
 {
 	__le32 result_le;
 	int rc;
@@ -186,8 +175,9 @@ static int tpm_tis_spi_read32(struct tpm_tis_data *data, u32 addr, u32 *result)
 
 	return rc;
 }
+EXPORT_SYMBOL_GPL(tpm_tis_spi_read32);
 
-static int tpm_tis_spi_write32(struct tpm_tis_data *data, u32 addr, u32 value)
+int tpm_tis_spi_write32(struct tpm_tis_data *data, u32 addr, u32 value)
 {
 	__le32 value_le;
 	int rc;
@@ -198,6 +188,20 @@ static int tpm_tis_spi_write32(struct tpm_tis_data *data, u32 addr, u32 value)
 
 	return rc;
 }
+EXPORT_SYMBOL_GPL(tpm_tis_spi_write32);
+
+int tpm_tis_spi_init(struct spi_device *spi, struct tpm_tis_spi_phy *phy,
+		     int irq, const struct tpm_tis_phy_ops *phy_ops)
+{
+	phy->iobuf = devm_kmalloc(&spi->dev, MAX_SPI_FRAMESIZE, GFP_KERNEL);
+	if (!phy->iobuf)
+		return -ENOMEM;
+
+	phy->spi_device = spi;
+
+	return tpm_tis_core_init(&spi->dev, &phy->priv, irq, phy_ops, NULL);
+}
+EXPORT_SYMBOL_GPL(tpm_tis_spi_init);
 
 static const struct tpm_tis_phy_ops tpm_spi_phy_ops = {
 	.read_bytes = tpm_tis_spi_read_bytes,
@@ -217,11 +221,6 @@ static int tpm_tis_spi_probe(struct spi_device *dev)
 	if (!phy)
 		return -ENOMEM;
 
-	phy->spi_device = dev;
-
-	phy->iobuf = devm_kmalloc(&dev->dev, MAX_SPI_FRAMESIZE, GFP_KERNEL);
-	if (!phy->iobuf)
-		return -ENOMEM;
 	phy->flow_control = tpm_tis_spi_flow_control;
 
 	/* If the SPI device has an IRQ then use that */
@@ -230,8 +229,7 @@ static int tpm_tis_spi_probe(struct spi_device *dev)
 	else
 		irq = -1;
 
-	return tpm_tis_core_init(&dev->dev, &phy->priv, irq, &tpm_spi_phy_ops,
-				 NULL);
+	return tpm_tis_spi_init(dev, phy, irq, &tpm_spi_phy_ops);
 }
 
 static SIMPLE_DEV_PM_OPS(tpm_tis_pm, tpm_pm_suspend, tpm_tis_resume);
diff --git a/drivers/char/tpm/tpm_tis_spi.h b/drivers/char/tpm/tpm_tis_spi.h
new file mode 100644
index 000000000000..48be5130794a
--- /dev/null
+++ b/drivers/char/tpm/tpm_tis_spi.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2015 Infineon Technologies AG
+ * Copyright (C) 2016 STMicroelectronics SAS
+ */
+
+#ifndef TPM_TIS_SPI_H
+#define TPM_TIS_SPI_H
+
+#include "tpm_tis_core.h"
+
+struct tpm_tis_spi_phy {
+	struct tpm_tis_data priv;
+	struct spi_device *spi_device;
+	int (*flow_control)(struct tpm_tis_spi_phy *phy,
+			     struct spi_transfer *xfer);
+	void (*pre_transfer)(struct tpm_tis_spi_phy *phy);
+
+	u8 *iobuf;
+};
+
+static inline struct tpm_tis_spi_phy *to_tpm_tis_spi_phy(struct tpm_tis_data *data)
+{
+	return container_of(data, struct tpm_tis_spi_phy, priv);
+}
+
+extern int tpm_tis_spi_init(struct spi_device *spi, struct tpm_tis_spi_phy *phy,
+			    int irq, const struct tpm_tis_phy_ops *phy_ops);
+
+extern int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
+				u8 *in, const u8 *out);
+
+extern int tpm_tis_spi_read16(struct tpm_tis_data *data, u32 addr, u16 *result);
+extern int tpm_tis_spi_read32(struct tpm_tis_data *data, u32 addr, u32 *result);
+extern int tpm_tis_spi_write32(struct tpm_tis_data *data, u32 addr, u32 value);
+
+#endif
-- 
Sent by a computer through tubes

