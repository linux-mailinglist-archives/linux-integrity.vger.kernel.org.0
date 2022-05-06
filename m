Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E83151DE10
	for <lists+linux-integrity@lfdr.de>; Fri,  6 May 2022 19:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444055AbiEFRHl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 6 May 2022 13:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444052AbiEFRHj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 6 May 2022 13:07:39 -0400
Received: from smtp14.infineon.com (smtp14.infineon.com [IPv6:2a00:18f0:1e00:4::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847C853B79;
        Fri,  6 May 2022 10:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1651856636; x=1683392636;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PSSkm86mVhCI42rlq4kvJ5CFBrNmZmY/lBpkEykOz+I=;
  b=HCEFMMtSESX85bJ+xTOfVhgqAfP+rkaJWCc3soI7fTorrySdsTciv1xI
   F+JzWh5uuMbZwm4BfVHFbK5TdIHr3y3OVBZzg47w966p73C2l05tjEL9F
   mPf5ze5vCallt1ocIKfVFuy/bCk1WjkkyCjB088D6PXpqdByA8pk4+8Fo
   M=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="119527609"
X-IronPort-AV: E=Sophos;i="5.91,203,1647298800"; 
   d="scan'208";a="119527609"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 19:03:53 +0200
Received: from MUCSE819.infineon.com (MUCSE819.infineon.com [172.23.29.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS;
        Fri,  6 May 2022 19:03:53 +0200 (CEST)
Received: from ISCN5CG1067W80.agb.infineon.com (172.23.8.247) by
 MUCSE819.infineon.com (172.23.29.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 6 May 2022 19:03:53 +0200
From:   Johannes Holland <johannes.holland@infineon.com>
To:     <jarkko@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <peterhuewe@gmx.de>, <jgg@ziepe.ca>,
        <krzysztof.kozlowski+dt@linaro.org>,
        Johannes Holland <johannes.holland@infineon.com>
Subject: [PATCH v2 2/4] tpm: Add tpm_tis_verify_crc to the tpm_tis_phy_ops protocol layer
Date:   Fri, 6 May 2022 19:00:13 +0200
Message-ID: <20220506170013.22598-2-johannes.holland@infineon.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220506170013.22598-1-johannes.holland@infineon.com>
References: <20220506170013.22598-1-johannes.holland@infineon.com>
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
 drivers/char/tpm/tpm_tis_i2c.c  | 28 ++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+)

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
index 6c203f36b8a1..66a5a13cd1df 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -121,6 +121,8 @@ struct tpm_tis_phy_ops {
 			  u8 *result, enum tpm_tis_io_mode mode);
 	int (*write_bytes)(struct tpm_tis_data *data, u32 addr, u16 len,
 			   const u8 *value, enum tpm_tis_io_mode mode);
+	int (*verify_crc)(struct tpm_tis_data *data, size_t len,
+			  const u8 *value);
 };
 
 static inline int tpm_tis_read_bytes(struct tpm_tis_data *data, u32 addr,
@@ -188,6 +190,14 @@ static inline int tpm_tis_write32(struct tpm_tis_data *data, u32 addr,
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
index 34d12f78e7ab..5bae8374b877 100644
--- a/drivers/char/tpm/tpm_tis_i2c.c
+++ b/drivers/char/tpm/tpm_tis_i2c.c
@@ -24,6 +24,7 @@
 #include <linux/gpio.h>
 #include <linux/of_irq.h>
 #include <linux/of_gpio.h>
+#include <linux/crc-ccitt.h>
 #include <linux/tpm.h>
 #include "tpm_tis_core.h"
 
@@ -33,6 +34,7 @@
 #define TPM_I2C_INTERFACE_CAPABILITY 0x30
 #define TPM_I2C_DEVICE_ADDRESS 0x38
 #define TPM_I2C_DATA_CSUM_ENABLE 0x40
+#define TPM_DATA_CSUM 0x44
 #define TPM_I2C_DID_VID 0x48
 #define TPM_I2C_RID 0x4C
 
@@ -253,6 +255,24 @@ static int tpm_tis_i2c_write_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
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
@@ -286,12 +306,14 @@ static SIMPLE_DEV_PM_OPS(tpm_tis_pm, tpm_pm_suspend, tpm_tis_resume);
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
 
@@ -316,6 +338,12 @@ static int tpm_tis_i2c_probe(struct i2c_client *dev,
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
2.34.1

