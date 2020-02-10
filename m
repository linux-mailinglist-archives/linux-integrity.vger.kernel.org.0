Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBCC1580CE
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Feb 2020 18:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgBJRKM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Feb 2020 12:10:12 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:36755 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728162AbgBJRKM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Feb 2020 12:10:12 -0500
X-Greylist: delayed 2425 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Feb 2020 12:09:57 EST
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 01AGT3Ua011285;
        Mon, 10 Feb 2020 18:29:03 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10140)
        id 650AC6032E; Mon, 10 Feb 2020 18:29:03 +0200 (IST)
From:   amirmizi6@gmail.com
To:     Eyal.Cohen@nuvoton.com, jarkko.sakkinen@linux.intel.com,
        oshrialkoby85@gmail.com, alexander.steffen@infineon.com,
        robh+dt@kernel.org, mark.rutland@arm.com, peterhuewe@gmx.de,
        jgg@ziepe.ca, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com,
        Amir Mizinski <amirmizi6@gmail.com>
Subject: [PATCH v3 1/7] char: tpm: Make implementation of read16 read32 write32 optional
Date:   Mon, 10 Feb 2020 18:28:32 +0200
Message-Id: <20200210162838.173903-2-amirmizi6@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200210162838.173903-1-amirmizi6@gmail.com>
References: <20200210162838.173903-1-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Amir Mizinski <amirmizi6@gmail.com>

Only tpm_tis has a faster way to access multiple bytes at once, every other
driver will just fall back to read_bytes/write_bytes. Therefore, move this
common code out of tpm_tis_spi into tpm_tis_core, so that it is
automatically used when low-level drivers do not implement the specialized
methods.

This commit is based on previous work by Alexander Steffen.

Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
---
 drivers/char/tpm/tpm_tis_core.h | 38 +++++++++++++++++++++++++++++++++++---
 drivers/char/tpm/tpm_tis_spi.c  | 41 -----------------------------------------
 2 files changed, 35 insertions(+), 44 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 7337819..d06c65b 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -122,13 +122,35 @@ static inline int tpm_tis_read8(struct tpm_tis_data *data, u32 addr, u8 *result)
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
@@ -145,7 +167,17 @@ static inline int tpm_tis_write8(struct tpm_tis_data *data, u32 addr, u8 value)
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
+
+	return rc;
 }
 
 static inline bool is_bsw(void)
diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_spi.c
index d1754fd..95fef9d 100644
--- a/drivers/char/tpm/tpm_tis_spi.c
+++ b/drivers/char/tpm/tpm_tis_spi.c
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
2.7.4

