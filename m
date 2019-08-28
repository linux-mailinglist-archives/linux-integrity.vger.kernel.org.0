Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 622559FCCF
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Aug 2019 10:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfH1IWI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Aug 2019 04:22:08 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43161 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfH1IVz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Aug 2019 04:21:55 -0400
Received: by mail-pl1-f195.google.com with SMTP id 4so871117pld.10
        for <linux-integrity@vger.kernel.org>; Wed, 28 Aug 2019 01:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zBHpNvufe28nLemPiNmtcBO4lsWCA9oHO3YETBlFgi4=;
        b=CsodN8TyIXBUvJIf8wrH4ECCazW4cHFoHhyOesxNpaIdhZoxOUHWaSA10IQOlNTD0D
         KbfLc9iTL244E3wQojl7eL/NeLFhWUCi/ZHveyHaByH30l7mTy1SWPjz7Jq1OUr1w5cb
         5+jMzeIpWl9EsbExUX8qKFs55sslZwFuXnIKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zBHpNvufe28nLemPiNmtcBO4lsWCA9oHO3YETBlFgi4=;
        b=cg5EYzsGoREaDxoX18ZaNryyCBSG2mLz+9YM/CJu6qqkXpZVvyWMpMxJWC5Ip4a5ds
         e6oU0g0wOrtlpBn6U+aoi1TM2eVQbnnGYsrrCl63TfmrUfTZcEbaDJrSk1HU6xA8PCPR
         Myd9ArfbcK2Ef+D3y+twUHUaHeE3T7rVSRG3+uDui69gSVpFAeT9iIaGAt+26kpZAcKN
         PiwbIn9G97tT7D8ChXITnbBQnnQ3EUP30oVO1WLUEdysZBP5XBg121TsIG5lRCyDMvUC
         wrRh5KKb+sN8HUYOABEZXz4uylJDkof6UR4cZTHi8FkPRUlPYq646tFJU+aUQPgvric7
         qvZQ==
X-Gm-Message-State: APjAAAV0gwDPQauz2O4GdBeWAl5s1lfw6A4rOEAvT460X/xBxBmLlm+1
        aOKqYHAlbSJGd9dKbIQXphwf4Q==
X-Google-Smtp-Source: APXvYqxNfuZcG+FCfxCwwXrymGrrC78fPo1dlzMiQr2RsEW1DtIZgFw5mh5ldb74v70RfnvZ/HcTuQ==
X-Received: by 2002:a17:902:1024:: with SMTP id b33mr3126228pla.325.1566980514791;
        Wed, 28 Aug 2019 01:21:54 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id y10sm1296959pjp.27.2019.08.28.01.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 01:21:54 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v5 3/4] tpm: tpm_tis_spi: Introduce a flow control callback
Date:   Wed, 28 Aug 2019 01:21:49 -0700
Message-Id: <20190828082150.42194-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190828082150.42194-1-swboyd@chromium.org>
References: <20190828082150.42194-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Cr50 firmware has a different flow control protocol than the one used by
this TPM PTP SPI driver. Introduce a flow control callback so we can
override the standard sequence with the custom one that Cr50 uses.

Cc: Andrey Pronin <apronin@chromium.org>
Cc: Duncan Laurie <dlaurie@chromium.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Alexander Steffen <Alexander.Steffen@infineon.com>
Cc: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/char/tpm/tpm_tis_spi.c | 62 ++++++++++++++++++++++------------
 1 file changed, 41 insertions(+), 21 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_spi.c
index 19513e622053..b3ed85671dd8 100644
--- a/drivers/char/tpm/tpm_tis_spi.c
+++ b/drivers/char/tpm/tpm_tis_spi.c
@@ -42,6 +42,8 @@
 struct tpm_tis_spi_phy {
 	struct tpm_tis_data priv;
 	struct spi_device *spi_device;
+	int (*flow_control)(struct tpm_tis_spi_phy *phy,
+			    struct spi_transfer *xfer);
 	u8 *iobuf;
 };
 
@@ -50,12 +52,46 @@ static inline struct tpm_tis_spi_phy *to_tpm_tis_spi_phy(struct tpm_tis_data *da
 	return container_of(data, struct tpm_tis_spi_phy, priv);
 }
 
+/*
+ * TCG SPI flow control is documented in section 6.4 of the spec[1]. In short,
+ * keep trying to read from the device until MISO goes high indicating the
+ * wait state has ended.
+ *
+ * [1] https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-profile-ptp-specification/
+ */
+static int tpm_tis_spi_flow_control(struct tpm_tis_spi_phy *phy,
+				    struct spi_transfer *spi_xfer)
+{
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
+}
+
 static int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
 				u8 *in, const u8 *out)
 {
 	struct tpm_tis_spi_phy *phy = to_tpm_tis_spi_phy(data);
 	int ret = 0;
-	int i;
 	struct spi_message m;
 	struct spi_transfer spi_xfer;
 	u8 transfer_len;
@@ -82,26 +118,9 @@ static int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
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
@@ -207,6 +226,7 @@ static int tpm_tis_spi_probe(struct spi_device *dev)
 	phy->iobuf = devm_kmalloc(&dev->dev, MAX_SPI_FRAMESIZE, GFP_KERNEL);
 	if (!phy->iobuf)
 		return -ENOMEM;
+	phy->flow_control = tpm_tis_spi_flow_control;
 
 	/* If the SPI device has an IRQ then use that */
 	if (dev->irq > 0)
-- 
Sent by a computer through tubes

