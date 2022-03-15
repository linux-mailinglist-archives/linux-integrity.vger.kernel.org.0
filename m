Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 487384D9FBE
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Mar 2022 17:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240278AbiCOQSe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Mar 2022 12:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235918AbiCOQSd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Mar 2022 12:18:33 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Mar 2022 09:17:20 PDT
Received: from smtp14.infineon.com (smtp14.infineon.com [IPv6:2a00:18f0:1e00:4::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB5C4BBAD
        for <linux-integrity@vger.kernel.org>; Tue, 15 Mar 2022 09:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1647361040; x=1678897040;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J8DWWprsVfaMQqD6t2Khk/j348EVT+8X44Wqzite2rw=;
  b=jl3k9S4M/UkAxkQoBmXKQPS0P1p/0GXnTdyTRxXk1Wy3g7CaqDcEHxRo
   5GXrdKYqzoMXwtuXIK26WPGFOMSO7rHfM37M5aU9aV5GRUSlf8Afz3DbT
   rmT0KPOXnyvFMJjx//7tPyNTxrAA6nFgVv4TWi37Mbj2uIwIAtUtLnOt2
   U=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="113042419"
X-IronPort-AV: E=Sophos;i="5.90,184,1643670000"; 
   d="scan'208";a="113042419"
Received: from unknown (HELO mucxv002.muc.infineon.com) ([172.23.11.17])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 17:16:15 +0100
Received: from MUCSE819.infineon.com (MUCSE819.infineon.com [172.23.29.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv002.muc.infineon.com (Postfix) with ESMTPS;
        Tue, 15 Mar 2022 17:16:15 +0100 (CET)
Received: from ISCN5CG1067W80.infineon.com (172.23.8.247) by
 MUCSE819.infineon.com (172.23.29.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 15 Mar 2022 17:16:14 +0100
From:   Johannes Holland <johannes.holland@infineon.com>
To:     <peterhuewe@gmx.de>, <jarkko@kernel.org>,
        <linux-integrity@vger.kernel.org>
CC:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        Johannes Holland <johannes.holland@infineon.com>
Subject: [PATCH v2] tpm: Make implementation of read16/read32/write32 optional
Date:   Tue, 15 Mar 2022 17:14:46 +0100
Message-ID: <20220315161446.534-1-johannes.holland@infineon.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20190718170355.6464-2-Alexander.Steffen@infineon.com>
References: <20190718170355.6464-2-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE801.infineon.com (172.23.29.27) To
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

From: Alexander Steffen <Alexander.Steffen@infineon.com>

Only tpm_tis and tpm_tis_synquacer have a dedicated way to access
multiple bytes at once, every other driver will just fall back to
read_bytes/write_bytes. Therefore, move this common code out of
tpm_tis_spi_main and tpm_tis_spi_cr50 into tpm_tis_core, so that it is
automatically used when low-level drivers do not implement the
specialized methods.

Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
---
 drivers/char/tpm/tpm_tis_core.h     | 37 +++++++++++++++++++++++---
 drivers/char/tpm/tpm_tis_spi.h      |  4 ---
 drivers/char/tpm/tpm_tis_spi_cr50.c |  3 ---
 drivers/char/tpm/tpm_tis_spi_main.c | 41 -----------------------------
 4 files changed, 34 insertions(+), 51 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 3be24f221e32..a1feff9d6c1f 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -128,13 +128,35 @@ static inline int tpm_tis_read8(struct tpm_tis_data *data, u32 addr, u8 *result)
 static inline int tpm_tis_read16(struct tpm_tis_data *data, u32 addr,
 				 u16 *result)
 {
-	return data->phy_ops->read16(data, addr, result);
+	__le16 result_le;
+	int rc;
+
+	if (data->phy_ops->read16)
+		return data->phy_ops->read16(data, addr, result);
+
+	rc = data->phy_ops->read_bytes(data, addr, sizeof(u16),
+				       (u8 *)&result_le);
+	if (!rc)
+		*result = le16_to_cpu(result_le);
+
+	return rc;
 }
 
 static inline int tpm_tis_read32(struct tpm_tis_data *data, u32 addr,
 				 u32 *result)
 {
-	return data->phy_ops->read32(data, addr, result);
+	__le32 result_le;
+	int rc;
+
+	if (data->phy_ops->read32)
+		return data->phy_ops->read32(data, addr, result);
+
+	rc = data->phy_ops->read_bytes(data, addr, sizeof(u32),
+				       (u8 *)&result_le);
+	if (!rc)
+		*result = le32_to_cpu(result_le);
+
+	return rc;
 }
 
 static inline int tpm_tis_write_bytes(struct tpm_tis_data *data, u32 addr,
@@ -151,7 +173,16 @@ static inline int tpm_tis_write8(struct tpm_tis_data *data, u32 addr, u8 value)
 static inline int tpm_tis_write32(struct tpm_tis_data *data, u32 addr,
 				  u32 value)
 {
-	return data->phy_ops->write32(data, addr, value);
+	__le32 value_le;
+	int rc;
+
+	if (data->phy_ops->write32)
+		return data->phy_ops->write32(data, addr, value);
+
+	value_le = cpu_to_le32(value);
+	rc = data->phy_ops->write_bytes(data, addr, sizeof(u32),
+					(u8 *)&value_le);
+	return rc;
 }
 
 static inline bool is_bsw(void)
diff --git a/drivers/char/tpm/tpm_tis_spi.h b/drivers/char/tpm/tpm_tis_spi.h
index bba73979c368..d0f66f6f1931 100644
--- a/drivers/char/tpm/tpm_tis_spi.h
+++ b/drivers/char/tpm/tpm_tis_spi.h
@@ -31,10 +31,6 @@ extern int tpm_tis_spi_init(struct spi_device *spi, struct tpm_tis_spi_phy *phy,
 extern int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
 				u8 *in, const u8 *out);
 
-extern int tpm_tis_spi_read16(struct tpm_tis_data *data, u32 addr, u16 *result);
-extern int tpm_tis_spi_read32(struct tpm_tis_data *data, u32 addr, u32 *result);
-extern int tpm_tis_spi_write32(struct tpm_tis_data *data, u32 addr, u32 value);
-
 #ifdef CONFIG_TCG_TIS_SPI_CR50
 extern int cr50_spi_probe(struct spi_device *spi);
 #else
diff --git a/drivers/char/tpm/tpm_tis_spi_cr50.c b/drivers/char/tpm/tpm_tis_spi_cr50.c
index 7bf123d3c537..9584856d955d 100644
--- a/drivers/char/tpm/tpm_tis_spi_cr50.c
+++ b/drivers/char/tpm/tpm_tis_spi_cr50.c
@@ -236,9 +236,6 @@ static int tpm_tis_spi_cr50_write_bytes(struct tpm_tis_data *data, u32 addr,
 static const struct tpm_tis_phy_ops tpm_spi_cr50_phy_ops = {
 	.read_bytes = tpm_tis_spi_cr50_read_bytes,
 	.write_bytes = tpm_tis_spi_cr50_write_bytes,
-	.read16 = tpm_tis_spi_read16,
-	.read32 = tpm_tis_spi_read32,
-	.write32 = tpm_tis_spi_write32,
 };
 
 static void cr50_print_fw_version(struct tpm_tis_data *data)
diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
index aaa59a00eeae..f9e937c79c59 100644
--- a/drivers/char/tpm/tpm_tis_spi_main.c
+++ b/drivers/char/tpm/tpm_tis_spi_main.c
@@ -152,44 +152,6 @@ static int tpm_tis_spi_write_bytes(struct tpm_tis_data *data, u32 addr,
 	return tpm_tis_spi_transfer(data, addr, len, NULL, value);
 }
 
-int tpm_tis_spi_read16(struct tpm_tis_data *data, u32 addr, u16 *result)
-{
-	__le16 result_le;
-	int rc;
-
-	rc = data->phy_ops->read_bytes(data, addr, sizeof(u16),
-				       (u8 *)&result_le);
-	if (!rc)
-		*result = le16_to_cpu(result_le);
-
-	return rc;
-}
-
-int tpm_tis_spi_read32(struct tpm_tis_data *data, u32 addr, u32 *result)
-{
-	__le32 result_le;
-	int rc;
-
-	rc = data->phy_ops->read_bytes(data, addr, sizeof(u32),
-				       (u8 *)&result_le);
-	if (!rc)
-		*result = le32_to_cpu(result_le);
-
-	return rc;
-}
-
-int tpm_tis_spi_write32(struct tpm_tis_data *data, u32 addr, u32 value)
-{
-	__le32 value_le;
-	int rc;
-
-	value_le = cpu_to_le32(value);
-	rc = data->phy_ops->write_bytes(data, addr, sizeof(u32),
-					(u8 *)&value_le);
-
-	return rc;
-}
-
 int tpm_tis_spi_init(struct spi_device *spi, struct tpm_tis_spi_phy *phy,
 		     int irq, const struct tpm_tis_phy_ops *phy_ops)
 {
@@ -205,9 +167,6 @@ int tpm_tis_spi_init(struct spi_device *spi, struct tpm_tis_spi_phy *phy,
 static const struct tpm_tis_phy_ops tpm_spi_phy_ops = {
 	.read_bytes = tpm_tis_spi_read_bytes,
 	.write_bytes = tpm_tis_spi_write_bytes,
-	.read16 = tpm_tis_spi_read16,
-	.read32 = tpm_tis_spi_read32,
-	.write32 = tpm_tis_spi_write32,
 };
 
 static int tpm_tis_spi_probe(struct spi_device *dev)
-- 
2.31.1.windows.1

