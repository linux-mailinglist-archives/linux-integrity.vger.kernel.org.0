Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF05BA29E3
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Aug 2019 00:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfH2WlR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Aug 2019 18:41:17 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44674 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728161AbfH2WlQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Aug 2019 18:41:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id c81so3087848pfc.11
        for <linux-integrity@vger.kernel.org>; Thu, 29 Aug 2019 15:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rBbuZ1/hGmJSVpkE9Mk+PjVfNnVUpgjwmAPJurf50Uw=;
        b=SHvNEqei1ZS8TI8jCsCLljpnGaeQzj+jmy2e4Dt/V2F8DU7fgljClHtVF0ypE7xm9Y
         AMQX58J/FGcyjKaaEDOk6vByw9CBU8M7Xh/fq/Te3zBLLMEImd1tb44iV5kwrd4TXsnE
         ++dkZn9wY0nV88zK4s/PQgmUqd70ztpZ4p8iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rBbuZ1/hGmJSVpkE9Mk+PjVfNnVUpgjwmAPJurf50Uw=;
        b=UQh32tz83Kt+vtpAKlbEKXKTXxQ1pKhODPUNYCBhwzlZXhNi42iUvUlU8bvLXsp8id
         JT4DNW7CE0TcW5msy0VLerL014iG+A0DBOLu4QUa0VXxX7uY5P3B8TX20zzjHQga8MtG
         e8ZAm7FGVvEEwxJRTgT3vGl5rXkPgAGDQ8F7g4ZAo90nAmZXRkHRuQLF3m1xOy5Ocptq
         3AqlcKoh++ZJ5DpQACHU/NmucFVIK+6hsLFzVoyCCB24SFVxc5PYUOXzOrRrYnXi02gN
         pI2h1LLBbYrUvCRIYpeTLi8ESRQS28J5W5iFbC1ORk1NgTv+R1cpLUAzyB6fPsIIAunh
         pIEg==
X-Gm-Message-State: APjAAAU05YAj1kNn29AgeGF7kf1Cb3MSTX1PyzKCUcO3BKhUHWvenlNy
        VTnxMWouAKUX8pf1O8aWSFpEAw==
X-Google-Smtp-Source: APXvYqxyvNJwkyVnmD3OT1dFORms9ipIdM8SjYwxZ4FwHBHShyUee+OUUBD3CkV8aXNvXVivX3dHkw==
X-Received: by 2002:aa7:957a:: with SMTP id x26mr11137280pfq.16.1567118475028;
        Thu, 29 Aug 2019 15:41:15 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id q8sm3882531pjd.28.2019.08.29.15.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 15:41:14 -0700 (PDT)
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
Subject: [PATCH v6 3/4] tpm: tpm_tis_spi: Introduce a flow control callback
Date:   Thu, 29 Aug 2019 15:41:09 -0700
Message-Id: <20190829224110.91103-4-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190829224110.91103-1-swboyd@chromium.org>
References: <20190829224110.91103-1-swboyd@chromium.org>
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
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
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

