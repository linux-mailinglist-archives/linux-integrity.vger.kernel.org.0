Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39AF84F10BD
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Apr 2022 10:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242863AbiDDIVO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 4 Apr 2022 04:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242810AbiDDIVL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Apr 2022 04:21:11 -0400
Received: from smtp14.infineon.com (smtp14.infineon.com [IPv6:2a00:18f0:1e00:4::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0775A3B3DF;
        Mon,  4 Apr 2022 01:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1649060355; x=1680596355;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HZAeER+GF4DeCd0T5DQyrJUecS9jb/Q9WsI2cTcl1gA=;
  b=RP7r7ERMDI00kvxtF9nwRLHcUnDxhFaPDPfvp8kRvkmK7JHDAK002l1+
   Q1BypZSqcjmGUMKABeXGU19yS3kZP7tgT4vX4nsr1dhmhJJkWMdSSM3jH
   5gCzL/tpDG30dDeWjsDab9fFHm7WX1F+9zQbl4DijDEYllHMokHIJZNue
   s=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6200,9189,10306"; a="115548205"
X-IronPort-AV: E=Sophos;i="5.90,233,1643670000"; 
   d="scan'208";a="115548205"
Received: from unknown (HELO mucxv002.muc.infineon.com) ([172.23.11.17])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 10:19:12 +0200
Received: from MUCSE819.infineon.com (MUCSE819.infineon.com [172.23.29.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv002.muc.infineon.com (Postfix) with ESMTPS;
        Mon,  4 Apr 2022 10:19:11 +0200 (CEST)
Received: from ISCN5CG1067W80.infineon.com (172.23.8.247) by
 MUCSE819.infineon.com (172.23.29.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 4 Apr 2022 10:19:11 +0200
From:   Johannes Holland <johannes.holland@infineon.com>
To:     <peterhuewe@gmx.de>, <jarkko@kernel.org>, <jgg@ziepe.ca>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <amirmizi6@gmail.com>, <robh@kernel.org>,
        Johannes Holland <johannes.holland@infineon.com>
Subject: [PATCH 2/4] tpm: Add tpm_tis_verify_crc to the tpm_tis_phy_ops protocol layer
Date:   Mon, 4 Apr 2022 10:18:33 +0200
Message-ID: <20220404081835.495-2-johannes.holland@infineon.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20220404081835.495-1-johannes.holland@infineon.com>
References: <20220404081835.495-1-johannes.holland@infineon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE812.infineon.com (172.23.29.38) To
 MUCSE819.infineon.com (172.23.29.45)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Other than SPI TPMs, I2C TPMs implement a CRC feature for command and
response blobs. Add CRC validation to the TIS protocol according to the
TCG PC Client Platform TPM Profile (PTP) specification for TPM 2.0 v1.04
revision 14

The CRC is calculated over the entirety of the FIFO register. Since the
phy_ops layer is not aware when the core layer is done reading/writing
the FIFO, CRC verification must be triggered from the core layer. To
this end, add an optional phy_ops API call.

Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
---
 drivers/char/tpm/tpm_tis_core.c | 14 ++++++++++++++
 drivers/char/tpm/tpm_tis_core.h | 10 ++++++++++
 drivers/char/tpm/tpm_tis_i2c.c  | 34 ++++++++++++++++++++++++++++++---
 3 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index dc56b976d816..f1c893a5a38f 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -289,6 +289,7 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 	int size = 0;
 	int status;
 	u32 expected;
+	int rc;
 
 	if (count < TPM_HEADER_SIZE) {
 		size = -EIO;
@@ -328,6 +329,13 @@ static int tpm_tis_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 		goto out;
 	}
 
+	rc = tpm_tis_verify_crc(priv, (size_t)size, buf);
+	if (rc < 0) {
+		dev_err(&chip->dev, "Error crc mismatch for response.\n");
+		size = rc;
+		goto out;
+	}
+
 out:
 	tpm_tis_ready(chip);
 	return size;
@@ -443,6 +451,12 @@ static int tpm_tis_send_main(struct tpm_chip *chip, const u8 *buf, size_t len)
 	if (rc < 0)
 		return rc;
 
+	rc = tpm_tis_verify_crc(priv, len, buf);
+	if (rc < 0) {
+		dev_err(&chip->dev, "Error crc mismatch for command.\n");
+		return rc;
+	}
+
 	/* go and do it */
 	rc = tpm_tis_write8(priv, TPM_STS(priv->locality), TPM_STS_GO);
 	if (rc < 0)
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index e2b8e6de25b4..21b4a67c9aac 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -116,6 +116,8 @@ struct tpm_tis_phy_ops {
 			  u8 *result, enum tpm_tis_io_mode mode);
 	int (*write_bytes)(struct tpm_tis_data *data, u32 addr, u16 len,
 			   const u8 *value, enum tpm_tis_io_mode mode);
+	int (*verify_crc)(struct tpm_tis_data *data, size_t len,
+			  const u8 *value);
 };
 
 static inline int tpm_tis_read_bytes(struct tpm_tis_data *data, u32 addr,
@@ -183,6 +185,14 @@ static inline int tpm_tis_write32(struct tpm_tis_data *data, u32 addr,
 	return rc;
 }
 
+static inline int tpm_tis_verify_crc(struct tpm_tis_data *data, size_t len,
+				     const u8 *value)
+{
+	if (!data->phy_ops->verify_crc)
+		return 0;
+	return data->phy_ops->verify_crc(data, len, value);
+}
+
 static inline bool is_bsw(void)
 {
 #ifdef CONFIG_X86
diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
index 206406c97325..0608bb6c7b90 100644
--- a/drivers/char/tpm/tpm_tis_i2c.c
+++ b/drivers/char/tpm/tpm_tis_i2c.c
@@ -29,6 +29,7 @@
 #include <linux/gpio.h>
 #include <linux/of_irq.h>
 #include <linux/of_gpio.h>
+#include <linux/crc-ccitt.h>
 #include <linux/tpm.h>
 #include "tpm_tis_core.h"
 
@@ -38,6 +39,7 @@
 #define TPM_I2C_INTERFACE_CAPABILITY 0x30
 #define TPM_I2C_DEVICE_ADDRESS 0x38
 #define TPM_I2C_DATA_CSUM_ENABLE 0x40
+#define TPM_DATA_CSUM 0x44
 #define TPM_I2C_DID_VID 0x48
 #define TPM_I2C_RID 0x4C
 
@@ -211,7 +213,7 @@ static int tpm_tis_i2c_read_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
 		msg.len = sizeof(reg);
 		msg.buf = &reg;
 		msg.flags = 0;
-		retry_i2c_transfer_until_ack(data, &msg);
+		ret = retry_i2c_transfer_until_ack(data, &msg);
 		if (ret < 0)
 			return ret;
 
@@ -219,7 +221,7 @@ static int tpm_tis_i2c_read_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
 		msg.buf = result;
 		msg.len = len;
 		msg.flags = I2C_M_RD;
-		retry_i2c_transfer_until_ack(data, &msg);
+		ret = retry_i2c_transfer_until_ack(data, &msg);
 		if (ret < 0)
 			return ret;
 
@@ -251,13 +253,31 @@ static int tpm_tis_i2c_write_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
 
 	msg.len = sizeof(reg) + len;
 	msg.buf = phy->io_buf;
-	retry_i2c_transfer_until_ack(data, &msg);
+	ret = retry_i2c_transfer_until_ack(data, &msg);
 	if (ret < 0)
 		return ret;
 
 	return 0;
 }
 
+static int tpm_tis_i2c_verify_crc(struct tpm_tis_data *data, size_t len,
+				  const u8 *value)
+{
+	u16 crc_tpm, crc_host;
+	int rc;
+
+	rc = tpm_tis_read16(data, TPM_DATA_CSUM, &crc_tpm);
+	if (rc < 0)
+		return rc;
+
+	/* reflect crc result, regardless of host endianness */
+	crc_host = swab16(crc_ccitt(0, value, len));
+	if (crc_tpm != crc_host)
+		return -EIO;
+
+	return 0;
+}
+
 static int init_guard_time(struct tpm_tis_i2c_phy *phy)
 {
 	u32 i2c_caps;
@@ -291,12 +311,14 @@ static SIMPLE_DEV_PM_OPS(tpm_tis_pm, tpm_pm_suspend, tpm_tis_resume);
 static const struct tpm_tis_phy_ops tpm_i2c_phy_ops = {
 	.read_bytes = tpm_tis_i2c_read_bytes,
 	.write_bytes = tpm_tis_i2c_write_bytes,
+	.verify_crc = tpm_tis_i2c_verify_crc,
 };
 
 static int tpm_tis_i2c_probe(struct i2c_client *dev,
 			     const struct i2c_device_id *id)
 {
 	struct tpm_tis_i2c_phy *phy;
+	const u8 crc_enable = 1;
 	const u8 locality = 0;
 	int ret;
 
@@ -321,6 +343,12 @@ static int tpm_tis_i2c_probe(struct i2c_client *dev,
 	if (ret)
 		return ret;
 
+	ret = tpm_tis_i2c_write_bytes(&phy->priv, TPM_I2C_DATA_CSUM_ENABLE,
+				      sizeof(crc_enable), &crc_enable,
+				      TPM_TIS_PHYS_8);
+	if (ret)
+		return ret;
+
 	return tpm_tis_core_init(&dev->dev, &phy->priv, -1, &tpm_i2c_phy_ops,
 				 NULL);
 }
-- 
2.31.1.windows.1

