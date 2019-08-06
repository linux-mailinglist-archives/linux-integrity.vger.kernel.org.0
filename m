Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F109A83D2F
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Aug 2019 00:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbfHFWH4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Aug 2019 18:07:56 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34977 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727128AbfHFWHy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Aug 2019 18:07:54 -0400
Received: by mail-pl1-f194.google.com with SMTP id w24so38413081plp.2
        for <linux-integrity@vger.kernel.org>; Tue, 06 Aug 2019 15:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h/xhP/vB7IkzGf8wgypQiR7wXsPZkOsDnbKr/VVmc1c=;
        b=TOMfBvy3auNNsbtX7pMhzSFghcR0Y3nkcmgpZPntLPGtn10unKBLqZ3VvVxcesV/Zl
         4xnaqpSB9qZYbcAj5XLMSdhF8XTnzxpLMsxth6YYHpCimGRDHSM6/l00/Hrb/qAylbFr
         J+L5fvDaOzsvGpcr7XL+8iARpP7InreIOJhos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h/xhP/vB7IkzGf8wgypQiR7wXsPZkOsDnbKr/VVmc1c=;
        b=b/W32N+wknkWAh61HJfCMpzBKY8CKdWXdfjuUXRSNgS6ll2Qx1uObW+7yBW7lS5Keq
         RrNS747hw3rHXZ8iyn2WuGhhYqLdzwo698tkZvOIq66dUDKizGprmg3pSQOe4r6sl1VL
         NHCK5glRV35FZoGwCFSN6YLvzRLeepFe3AiMamwd6H72Rp0HDMtzB5O+VCYjQdNZ8VLj
         cAsHNBBK5yNdsKxrVza3TF0hW95fVZqa/1+wmFyrxfxnC7DpQYO/kb1+2BUK6iYvCegS
         gpfvLGex2Wtn94WS+cxFazvchoaxZL4LBBCN4N3qNyUcEb19Vbi+bTjeSJcTdfxcm8LI
         dRpQ==
X-Gm-Message-State: APjAAAVpkkTy6FJd+UQ8zqfwHilqQSDuCBs4LBvG4JE61sh6ueiFNrFs
        KgejHZvdr75Fsa2lfF3/nRgLdQ==
X-Google-Smtp-Source: APXvYqwwdF1lRp3/AgWvmNMONW0hz7Usq6oiIdN3G6dHCBEdd6jsPmnih7QV1onNwq1d6FKLb0tojA==
X-Received: by 2002:a17:902:7083:: with SMTP id z3mr195085plk.87.1565129273802;
        Tue, 06 Aug 2019 15:07:53 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id p7sm98982509pfp.131.2019.08.06.15.07.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 15:07:53 -0700 (PDT)
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
Subject: [PATCH v3 2/4] tpm: tpm_tis_spi: Export functionality to other drivers
Date:   Tue,  6 Aug 2019 15:07:48 -0700
Message-Id: <20190806220750.86597-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190806220750.86597-1-swboyd@chromium.org>
References: <20190806220750.86597-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

We want to use most of the code in this driver, except we want to modify
the flow control and idle behavior. Let's "libify" this driver so that
another driver can call the code in here and slightly tweak the
behavior.

Cc: Andrey Pronin <apronin@chromium.org>
Cc: Duncan Laurie <dlaurie@chromium.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Alexander Steffen <Alexander.Steffen@infineon.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/char/tpm/tpm_tis_spi.c | 98 +++++++++++++++++++---------------
 drivers/char/tpm/tpm_tis_spi.h | 37 +++++++++++++
 2 files changed, 93 insertions(+), 42 deletions(-)
 create mode 100644 drivers/char/tpm/tpm_tis_spi.h

diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_spi.c
index 19513e622053..fd3fb4f9f506 100644
--- a/drivers/char/tpm/tpm_tis_spi.c
+++ b/drivers/char/tpm/tpm_tis_spi.c
@@ -36,26 +36,43 @@
 #include <linux/tpm.h>
 #include "tpm.h"
 #include "tpm_tis_core.h"
+#include "tpm_tis_spi.h"
 
 #define MAX_SPI_FRAMESIZE 64
 
-struct tpm_tis_spi_phy {
-	struct tpm_tis_data priv;
-	struct spi_device *spi_device;
-	u8 *iobuf;
-};
-
-static inline struct tpm_tis_spi_phy *to_tpm_tis_spi_phy(struct tpm_tis_data *data)
+static int tpm_tis_spi_flow_control(struct tpm_tis_spi_phy *phy,
+				    struct spi_transfer *spi_xfer)
 {
-	return container_of(data, struct tpm_tis_spi_phy, priv);
+	struct spi_message m;
+	int ret, i;
+
+	if ((phy->iobuf[3] & 0x01) == 0) {
+		// handle SPI wait states
+		phy->iobuf[0] = 0;
+
+		for (i = 0; i < TPM_RETRY; i++) {
+			spi_xfer->len = 1;
+			spi_message_init(&m);
+			spi_message_add_tail(spi_xfer, &m);
+			ret = spi_sync_locked(phy->spi_device, &m);
+			if (ret < 0)
+				return ret;
+			if (phy->iobuf[0] & 0x01)
+				break;
+		}
+
+		if (i == TPM_RETRY)
+			return -ETIMEDOUT;
+	}
+
+	return 0;
 }
 
-static int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
+int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
 				u8 *in, const u8 *out)
 {
 	struct tpm_tis_spi_phy *phy = to_tpm_tis_spi_phy(data);
 	int ret = 0;
-	int i;
 	struct spi_message m;
 	struct spi_transfer spi_xfer;
 	u8 transfer_len;
@@ -82,26 +99,9 @@ static int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
 		if (ret < 0)
 			goto exit;
 
-		if ((phy->iobuf[3] & 0x01) == 0) {
-			// handle SPI wait states
-			phy->iobuf[0] = 0;
-
-			for (i = 0; i < TPM_RETRY; i++) {
-				spi_xfer.len = 1;
-				spi_message_init(&m);
-				spi_message_add_tail(&spi_xfer, &m);
-				ret = spi_sync_locked(phy->spi_device, &m);
-				if (ret < 0)
-					goto exit;
-				if (phy->iobuf[0] & 0x01)
-					break;
-			}
-
-			if (i == TPM_RETRY) {
-				ret = -ETIMEDOUT;
-				goto exit;
-			}
-		}
+		ret = phy->flow_control(phy, &spi_xfer);
+		if (ret < 0)
+			goto exit;
 
 		spi_xfer.cs_change = 0;
 		spi_xfer.len = transfer_len;
@@ -117,6 +117,8 @@ static int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
 
 		spi_message_init(&m);
 		spi_message_add_tail(&spi_xfer, &m);
+		if (phy->pre_transfer)
+			phy->pre_transfer(phy);
 		ret = spi_sync_locked(phy->spi_device, &m);
 		if (ret < 0)
 			goto exit;
@@ -133,9 +135,10 @@ static int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
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
@@ -146,7 +149,7 @@ static int tpm_tis_spi_write_bytes(struct tpm_tis_data *data, u32 addr,
 	return tpm_tis_spi_transfer(data, addr, len, NULL, value);
 }
 
-static int tpm_tis_spi_read16(struct tpm_tis_data *data, u32 addr, u16 *result)
+int tpm_tis_spi_read16(struct tpm_tis_data *data, u32 addr, u16 *result)
 {
 	__le16 result_le;
 	int rc;
@@ -158,8 +161,9 @@ static int tpm_tis_spi_read16(struct tpm_tis_data *data, u32 addr, u16 *result)
 
 	return rc;
 }
+EXPORT_SYMBOL_GPL(tpm_tis_spi_read16);
 
-static int tpm_tis_spi_read32(struct tpm_tis_data *data, u32 addr, u32 *result)
+int tpm_tis_spi_read32(struct tpm_tis_data *data, u32 addr, u32 *result)
 {
 	__le32 result_le;
 	int rc;
@@ -171,8 +175,9 @@ static int tpm_tis_spi_read32(struct tpm_tis_data *data, u32 addr, u32 *result)
 
 	return rc;
 }
+EXPORT_SYMBOL_GPL(tpm_tis_spi_read32);
 
-static int tpm_tis_spi_write32(struct tpm_tis_data *data, u32 addr, u32 value)
+int tpm_tis_spi_write32(struct tpm_tis_data *data, u32 addr, u32 value)
 {
 	__le32 value_le;
 	int rc;
@@ -183,6 +188,20 @@ static int tpm_tis_spi_write32(struct tpm_tis_data *data, u32 addr, u32 value)
 
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
@@ -202,11 +221,7 @@ static int tpm_tis_spi_probe(struct spi_device *dev)
 	if (!phy)
 		return -ENOMEM;
 
-	phy->spi_device = dev;
-
-	phy->iobuf = devm_kmalloc(&dev->dev, MAX_SPI_FRAMESIZE, GFP_KERNEL);
-	if (!phy->iobuf)
-		return -ENOMEM;
+	phy->flow_control = tpm_tis_spi_flow_control;
 
 	/* If the SPI device has an IRQ then use that */
 	if (dev->irq > 0)
@@ -214,8 +229,7 @@ static int tpm_tis_spi_probe(struct spi_device *dev)
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

