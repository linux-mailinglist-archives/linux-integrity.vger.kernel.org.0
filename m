Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285544E22F9
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Mar 2022 10:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236441AbiCUJLf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 21 Mar 2022 05:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244006AbiCUJLe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Mar 2022 05:11:34 -0400
Received: from smtp14.infineon.com (smtp14.infineon.com [IPv6:2a00:18f0:1e00:4::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7515EDDA
        for <linux-integrity@vger.kernel.org>; Mon, 21 Mar 2022 02:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1647853809; x=1679389809;
  h=from:to:cc:subject:date:message-id:reply-to:mime-version:
   content-transfer-encoding;
  bh=TEJdzigz69+WJ/9ep5YOdUJgzgQmM6SegsJy1m7Y1JY=;
  b=Vyrf+ZR5ij1A8NUrKWCKTcC+iK28oPSpYdIw8JZUt9SWHOw9Kh5hZQiP
   aaHZOm5jjDYn8IexYRpHM9NgOhBtu3FlxgxGNhAaIXyd137W/oXkwzzvR
   yIdkAhmZcazL71QeW4//O/OYGsezhRLLVkdsimFs3i5Nn8hKP5Za6rPhy
   s=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="113686894"
X-IronPort-AV: E=Sophos;i="5.90,198,1643670000"; 
   d="scan'208";a="113686894"
Received: from unknown (HELO mucxv001.muc.infineon.com) ([172.23.11.16])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 10:10:06 +0100
Received: from MUCSE819.infineon.com (MUCSE819.infineon.com [172.23.29.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv001.muc.infineon.com (Postfix) with ESMTPS;
        Mon, 21 Mar 2022 10:10:06 +0100 (CET)
Received: from ISCN5CG1067W80.infineon.com (172.23.8.247) by
 MUCSE819.infineon.com (172.23.29.45) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 21 Mar 2022 10:10:05 +0100
From:   Johannes Holland <johannes.holland@infineon.com>
To:     <peterhuewe@gmx.de>, <jarkko@kernel.org>,
        <linux-integrity@vger.kernel.org>
CC:     <Alexander.Steffen@infineon.com>,
        Johannes Holland <johannes.holland@infineon.com>
Subject: [PATCH v4] tpm: Remove read16/read32/write32 calls from tpm_tis_phy_ops
Date:   Mon, 21 Mar 2022 10:09:24 +0100
Message-ID: <20220321090924.1951-1-johannes.holland@infineon.com>
X-Mailer: git-send-email 2.31.1.windows.1
Reply-To: <20220318151647.410-1-johannes.holland@infineon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE802.infineon.com (172.23.29.28) To
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

Only tpm_tis and tpm_tis_synquacer have a dedicated way to access
multiple bytes at once, every other driver will just fall back to
read_bytes/write_bytes. Therefore, remove the read16/read32/write32
calls and move their logic to read_bytes/write_bytes.

Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
---=0D
Changelog:=0D
 * v2:
   * rebase and apply changes to tpm_tis_synquacer, as well
   * move variable declarations to beginning of functions
 * v3:
   * remove read16/read32/write32 api calls altogether and always call
     read_bytes/write_bytes=0D
 * v4:=0D
   * add Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>=0D
   * move changelog out of commit message=0D
   * add comment to enum tpm_tis_io_mode=0D
=20
 drivers/char/tpm/tpm_tis.c           |  67 ++++++++---------
 drivers/char/tpm/tpm_tis_core.h      |  58 +++++++++++---
 drivers/char/tpm/tpm_tis_spi.h       |   4 -
 drivers/char/tpm/tpm_tis_spi_cr50.c  |   7 +-
 drivers/char/tpm/tpm_tis_spi_main.c  |  45 +----------
 drivers/char/tpm/tpm_tis_synquacer.c | 108 ++++++++++++---------------
 6 files changed, 128 insertions(+), 161 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index d3f2e5364c27..bcff6429e0b4 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -153,50 +153,46 @@ static int check_acpi_tpm2(struct device *dev)
 #endif
=20
 static int tpm_tcg_read_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
-			      u8 *result)
+			      u8 *result, enum tpm_tis_io_mode io_mode)
 {
 	struct tpm_tis_tcg_phy *phy =3D to_tpm_tis_tcg_phy(data);
-
-	while (len--)
-		*result++ =3D ioread8(phy->iobase + addr);
+	__le16 result_le16;
+	__le32 result_le32;
+
+	switch (io_mode) {
+	case TPM_TIS_PHYS_8:
+		while (len--)
+			*result++ =3D ioread8(phy->iobase + addr);
+		break;
+	case TPM_TIS_PHYS_16:
+		result_le16 =3D cpu_to_le16(ioread16(phy->iobase + addr));
+		memcpy(result, &result_le16, sizeof(u16));
+		break;
+	case TPM_TIS_PHYS_32:
+		result_le32 =3D cpu_to_le32(ioread32(phy->iobase + addr));
+		memcpy(result, &result_le32, sizeof(u32));
+		break;
+	}
=20
 	return 0;
 }
=20
 static int tpm_tcg_write_bytes(struct tpm_tis_data *data, u32 addr, u16 le=
n,
-			       const u8 *value)
+			       const u8 *value, enum tpm_tis_io_mode io_mode)
 {
 	struct tpm_tis_tcg_phy *phy =3D to_tpm_tis_tcg_phy(data);
=20
-	while (len--)
-		iowrite8(*value++, phy->iobase + addr);
-
-	return 0;
-}
-
-static int tpm_tcg_read16(struct tpm_tis_data *data, u32 addr, u16 *result)
-{
-	struct tpm_tis_tcg_phy *phy =3D to_tpm_tis_tcg_phy(data);
-
-	*result =3D ioread16(phy->iobase + addr);
-
-	return 0;
-}
-
-static int tpm_tcg_read32(struct tpm_tis_data *data, u32 addr, u32 *result)
-{
-	struct tpm_tis_tcg_phy *phy =3D to_tpm_tis_tcg_phy(data);
-
-	*result =3D ioread32(phy->iobase + addr);
-
-	return 0;
-}
-
-static int tpm_tcg_write32(struct tpm_tis_data *data, u32 addr, u32 value)
-{
-	struct tpm_tis_tcg_phy *phy =3D to_tpm_tis_tcg_phy(data);
-
-	iowrite32(value, phy->iobase + addr);
+	switch (io_mode) {
+	case TPM_TIS_PHYS_8:
+		while (len--)
+			iowrite8(*value++, phy->iobase + addr);
+		break;
+	case TPM_TIS_PHYS_16:
+		return -EINVAL;
+	case TPM_TIS_PHYS_32:
+		iowrite32(le32_to_cpu(*((__le32 *)value)), phy->iobase + addr);
+		break;
+	}
=20
 	return 0;
 }
@@ -204,9 +200,6 @@ static int tpm_tcg_write32(struct tpm_tis_data *data, u=
32 addr, u32 value)
 static const struct tpm_tis_phy_ops tpm_tcg =3D {
 	.read_bytes =3D tpm_tcg_read_bytes,
 	.write_bytes =3D tpm_tcg_write_bytes,
-	.read16 =3D tpm_tcg_read16,
-	.read32 =3D tpm_tcg_read32,
-	.write32 =3D tpm_tcg_write32,
 };
=20
 static int tpm_tis_init(struct device *dev, struct tpm_info *tpm_info)
diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_cor=
e.h
index 3be24f221e32..6c203f36b8a1 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -104,54 +104,88 @@ struct tpm_tis_data {
 	unsigned int timeout_max; /* usecs */
 };
=20
+/*
+ * IO modes to indicate how many bytes should be read/written at once in t=
he
+ * tpm_tis_phy_ops read_bytes/write_bytes calls. Use TPM_TIS_PHYS_8 to
+ * receive/transmit byte-wise, TPM_TIS_PHYS_16 for two bytes etc.
+ */
+enum tpm_tis_io_mode {
+	TPM_TIS_PHYS_8,
+	TPM_TIS_PHYS_16,
+	TPM_TIS_PHYS_32,
+};
+
 struct tpm_tis_phy_ops {
+	/* data is passed in little endian */
 	int (*read_bytes)(struct tpm_tis_data *data, u32 addr, u16 len,
-			  u8 *result);
+			  u8 *result, enum tpm_tis_io_mode mode);
 	int (*write_bytes)(struct tpm_tis_data *data, u32 addr, u16 len,
-			   const u8 *value);
-	int (*read16)(struct tpm_tis_data *data, u32 addr, u16 *result);
-	int (*read32)(struct tpm_tis_data *data, u32 addr, u32 *result);
-	int (*write32)(struct tpm_tis_data *data, u32 addr, u32 src);
+			   const u8 *value, enum tpm_tis_io_mode mode);
 };
=20
 static inline int tpm_tis_read_bytes(struct tpm_tis_data *data, u32 addr,
 				     u16 len, u8 *result)
 {
-	return data->phy_ops->read_bytes(data, addr, len, result);
+	return data->phy_ops->read_bytes(data, addr, len, result,
+					 TPM_TIS_PHYS_8);
 }
=20
 static inline int tpm_tis_read8(struct tpm_tis_data *data, u32 addr, u8 *r=
esult)
 {
-	return data->phy_ops->read_bytes(data, addr, 1, result);
+	return data->phy_ops->read_bytes(data, addr, 1, result, TPM_TIS_PHYS_8);
 }
=20
 static inline int tpm_tis_read16(struct tpm_tis_data *data, u32 addr,
 				 u16 *result)
 {
-	return data->phy_ops->read16(data, addr, result);
+	__le16 result_le;
+	int rc;
+
+	rc =3D data->phy_ops->read_bytes(data, addr, sizeof(u16),
+				       (u8 *)&result_le, TPM_TIS_PHYS_16);
+	if (!rc)
+		*result =3D le16_to_cpu(result_le);
+
+	return rc;
 }
=20
 static inline int tpm_tis_read32(struct tpm_tis_data *data, u32 addr,
 				 u32 *result)
 {
-	return data->phy_ops->read32(data, addr, result);
+	__le32 result_le;
+	int rc;
+
+	rc =3D data->phy_ops->read_bytes(data, addr, sizeof(u32),
+				       (u8 *)&result_le, TPM_TIS_PHYS_32);
+	if (!rc)
+		*result =3D le32_to_cpu(result_le);
+
+	return rc;
 }
=20
 static inline int tpm_tis_write_bytes(struct tpm_tis_data *data, u32 addr,
 				      u16 len, const u8 *value)
 {
-	return data->phy_ops->write_bytes(data, addr, len, value);
+	return data->phy_ops->write_bytes(data, addr, len, value,
+					  TPM_TIS_PHYS_8);
 }
=20
 static inline int tpm_tis_write8(struct tpm_tis_data *data, u32 addr, u8 v=
alue)
 {
-	return data->phy_ops->write_bytes(data, addr, 1, &value);
+	return data->phy_ops->write_bytes(data, addr, 1, &value,
+					  TPM_TIS_PHYS_8);
 }
=20
 static inline int tpm_tis_write32(struct tpm_tis_data *data, u32 addr,
 				  u32 value)
 {
-	return data->phy_ops->write32(data, addr, value);
+	__le32 value_le;
+	int rc;
+
+	value_le =3D cpu_to_le32(value);
+	rc =3D  data->phy_ops->write_bytes(data, addr, sizeof(u32),
+					 (u8 *)&value_le, TPM_TIS_PHYS_32);
+	return rc;
 }
=20
 static inline bool is_bsw(void)
diff --git a/drivers/char/tpm/tpm_tis_spi.h b/drivers/char/tpm/tpm_tis_spi.h
index bba73979c368..d0f66f6f1931 100644
--- a/drivers/char/tpm/tpm_tis_spi.h
+++ b/drivers/char/tpm/tpm_tis_spi.h
@@ -31,10 +31,6 @@ extern int tpm_tis_spi_init(struct spi_device *spi, stru=
ct tpm_tis_spi_phy *phy,
 extern int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 l=
en,
 				u8 *in, const u8 *out);
=20
-extern int tpm_tis_spi_read16(struct tpm_tis_data *data, u32 addr, u16 *re=
sult);
-extern int tpm_tis_spi_read32(struct tpm_tis_data *data, u32 addr, u32 *re=
sult);
-extern int tpm_tis_spi_write32(struct tpm_tis_data *data, u32 addr, u32 va=
lue);
-
 #ifdef CONFIG_TCG_TIS_SPI_CR50
 extern int cr50_spi_probe(struct spi_device *spi);
 #else
diff --git a/drivers/char/tpm/tpm_tis_spi_cr50.c b/drivers/char/tpm/tpm_tis=
_spi_cr50.c
index 7bf123d3c537..f4937280e940 100644
--- a/drivers/char/tpm/tpm_tis_spi_cr50.c
+++ b/drivers/char/tpm/tpm_tis_spi_cr50.c
@@ -222,13 +222,13 @@ static int tpm_tis_spi_cr50_transfer(struct tpm_tis_d=
ata *data, u32 addr, u16 le
 }
=20
 static int tpm_tis_spi_cr50_read_bytes(struct tpm_tis_data *data, u32 addr,
-				       u16 len, u8 *result)
+				       u16 len, u8 *result, enum tpm_tis_io_mode io_mode)
 {
 	return tpm_tis_spi_cr50_transfer(data, addr, len, result, NULL);
 }
=20
 static int tpm_tis_spi_cr50_write_bytes(struct tpm_tis_data *data, u32 add=
r,
-					u16 len, const u8 *value)
+					u16 len, const u8 *value, enum tpm_tis_io_mode io_mode)
 {
 	return tpm_tis_spi_cr50_transfer(data, addr, len, NULL, value);
 }
@@ -236,9 +236,6 @@ static int tpm_tis_spi_cr50_write_bytes(struct tpm_tis_=
data *data, u32 addr,
 static const struct tpm_tis_phy_ops tpm_spi_cr50_phy_ops =3D {
 	.read_bytes =3D tpm_tis_spi_cr50_read_bytes,
 	.write_bytes =3D tpm_tis_spi_cr50_write_bytes,
-	.read16 =3D tpm_tis_spi_read16,
-	.read32 =3D tpm_tis_spi_read32,
-	.write32 =3D tpm_tis_spi_write32,
 };
=20
 static void cr50_print_fw_version(struct tpm_tis_data *data)
diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis=
_spi_main.c
index aaa59a00eeae..d0920c3c400f 100644
--- a/drivers/char/tpm/tpm_tis_spi_main.c
+++ b/drivers/char/tpm/tpm_tis_spi_main.c
@@ -141,55 +141,17 @@ int tpm_tis_spi_transfer(struct tpm_tis_data *data, u=
32 addr, u16 len,
 }
=20
 static int tpm_tis_spi_read_bytes(struct tpm_tis_data *data, u32 addr,
-				  u16 len, u8 *result)
+				  u16 len, u8 *result, enum tpm_tis_io_mode io_mode)
 {
 	return tpm_tis_spi_transfer(data, addr, len, result, NULL);
 }
=20
 static int tpm_tis_spi_write_bytes(struct tpm_tis_data *data, u32 addr,
-				   u16 len, const u8 *value)
+				   u16 len, const u8 *value, enum tpm_tis_io_mode io_mode)
 {
 	return tpm_tis_spi_transfer(data, addr, len, NULL, value);
 }
=20
-int tpm_tis_spi_read16(struct tpm_tis_data *data, u32 addr, u16 *result)
-{
-	__le16 result_le;
-	int rc;
-
-	rc =3D data->phy_ops->read_bytes(data, addr, sizeof(u16),
-				       (u8 *)&result_le);
-	if (!rc)
-		*result =3D le16_to_cpu(result_le);
-
-	return rc;
-}
-
-int tpm_tis_spi_read32(struct tpm_tis_data *data, u32 addr, u32 *result)
-{
-	__le32 result_le;
-	int rc;
-
-	rc =3D data->phy_ops->read_bytes(data, addr, sizeof(u32),
-				       (u8 *)&result_le);
-	if (!rc)
-		*result =3D le32_to_cpu(result_le);
-
-	return rc;
-}
-
-int tpm_tis_spi_write32(struct tpm_tis_data *data, u32 addr, u32 value)
-{
-	__le32 value_le;
-	int rc;
-
-	value_le =3D cpu_to_le32(value);
-	rc =3D data->phy_ops->write_bytes(data, addr, sizeof(u32),
-					(u8 *)&value_le);
-
-	return rc;
-}
-
 int tpm_tis_spi_init(struct spi_device *spi, struct tpm_tis_spi_phy *phy,
 		     int irq, const struct tpm_tis_phy_ops *phy_ops)
 {
@@ -205,9 +167,6 @@ int tpm_tis_spi_init(struct spi_device *spi, struct tpm=
_tis_spi_phy *phy,
 static const struct tpm_tis_phy_ops tpm_spi_phy_ops =3D {
 	.read_bytes =3D tpm_tis_spi_read_bytes,
 	.write_bytes =3D tpm_tis_spi_write_bytes,
-	.read16 =3D tpm_tis_spi_read16,
-	.read32 =3D tpm_tis_spi_read32,
-	.write32 =3D tpm_tis_spi_write32,
 };
=20
 static int tpm_tis_spi_probe(struct spi_device *dev)
diff --git a/drivers/char/tpm/tpm_tis_synquacer.c b/drivers/char/tpm/tpm_ti=
s_synquacer.c
index e47bdd272704..2751be8e6065 100644
--- a/drivers/char/tpm/tpm_tis_synquacer.c
+++ b/drivers/char/tpm/tpm_tis_synquacer.c
@@ -35,72 +35,63 @@ static inline struct tpm_tis_synquacer_phy *to_tpm_tis_=
tcg_phy(struct tpm_tis_da
 }
=20
 static int tpm_tis_synquacer_read_bytes(struct tpm_tis_data *data, u32 add=
r,
-					u16 len, u8 *result)
+					u16 len, u8 *result,
+					enum tpm_tis_io_mode io_mode)
 {
 	struct tpm_tis_synquacer_phy *phy =3D to_tpm_tis_tcg_phy(data);
-
-	while (len--)
-		*result++ =3D ioread8(phy->iobase + addr);
+	__le16 result_le16;
+	__le32 result_le32;
+	u16 result16;
+	u32 result32;
+
+	switch (io_mode) {
+	case TPM_TIS_PHYS_8:
+		while (len--)
+			*result++ =3D ioread8(phy->iobase + addr);
+		break;
+	case TPM_TIS_PHYS_16:
+		result[1] =3D ioread8(phy->iobase + addr + 1);
+		result[0] =3D ioread8(phy->iobase + addr);
+		break;
+	case TPM_TIS_PHYS_32:
+		result[3] =3D ioread8(phy->iobase + addr + 3);
+		result[2] =3D ioread8(phy->iobase + addr + 2);
+		result[1] =3D ioread8(phy->iobase + addr + 1);
+		result[0] =3D ioread8(phy->iobase + addr);
+		break;
+	}
=20
 	return 0;
 }
=20
 static int tpm_tis_synquacer_write_bytes(struct tpm_tis_data *data, u32 ad=
dr,
-					 u16 len, const u8 *value)
+					 u16 len, const u8 *value,
+					 enum tpm_tis_io_mode io_mode)
 {
 	struct tpm_tis_synquacer_phy *phy =3D to_tpm_tis_tcg_phy(data);
-
-	while (len--)
-		iowrite8(*value++, phy->iobase + addr);
-
-	return 0;
-}
-
-static int tpm_tis_synquacer_read16_bw(struct tpm_tis_data *data,
-				       u32 addr, u16 *result)
-{
-	struct tpm_tis_synquacer_phy *phy =3D to_tpm_tis_tcg_phy(data);
-
-	/*
-	 * Due to the limitation of SPI controller on SynQuacer,
-	 * 16/32 bits access must be done in byte-wise and descending order.
-	 */
-	*result =3D (ioread8(phy->iobase + addr + 1) << 8) |
-		  (ioread8(phy->iobase + addr));
-
-	return 0;
-}
-
-static int tpm_tis_synquacer_read32_bw(struct tpm_tis_data *data,
-				       u32 addr, u32 *result)
-{
-	struct tpm_tis_synquacer_phy *phy =3D to_tpm_tis_tcg_phy(data);
-
-	/*
-	 * Due to the limitation of SPI controller on SynQuacer,
-	 * 16/32 bits access must be done in byte-wise and descending order.
-	 */
-	*result =3D (ioread8(phy->iobase + addr + 3) << 24) |
-		  (ioread8(phy->iobase + addr + 2) << 16) |
-		  (ioread8(phy->iobase + addr + 1) << 8) |
-		  (ioread8(phy->iobase + addr));
-
-	return 0;
-}
-
-static int tpm_tis_synquacer_write32_bw(struct tpm_tis_data *data,
-					u32 addr, u32 value)
-{
-	struct tpm_tis_synquacer_phy *phy =3D to_tpm_tis_tcg_phy(data);
-
-	/*
-	 * Due to the limitation of SPI controller on SynQuacer,
-	 * 16/32 bits access must be done in byte-wise and descending order.
-	 */
-	iowrite8(value >> 24, phy->iobase + addr + 3);
-	iowrite8(value >> 16, phy->iobase + addr + 2);
-	iowrite8(value >> 8, phy->iobase + addr + 1);
-	iowrite8(value, phy->iobase + addr);
+	__le16 result_le16;
+	__le32 result_le32;
+	u16 result16;
+	u32 result32;
+
+	switch (io_mode) {
+	case TPM_TIS_PHYS_8:
+		while (len--)
+			iowrite8(*value++, phy->iobase + addr);
+		break;
+	case TPM_TIS_PHYS_16:
+		return -EINVAL;
+	case TPM_TIS_PHYS_32:
+		/*
+		 * Due to the limitation of SPI controller on SynQuacer,
+		 * 16/32 bits access must be done in byte-wise and descending order.
+		 */
+		iowrite8(&value[3], phy->iobase + addr + 3);
+		iowrite8(&value[2], phy->iobase + addr + 2);
+		iowrite8(&value[1], phy->iobase + addr + 1);
+		iowrite8(&value[0], phy->iobase + addr);
+		break;
+	}
=20
 	return 0;
 }
@@ -108,9 +99,6 @@ static int tpm_tis_synquacer_write32_bw(struct tpm_tis_d=
ata *data,
 static const struct tpm_tis_phy_ops tpm_tcg_bw =3D {
 	.read_bytes	=3D tpm_tis_synquacer_read_bytes,
 	.write_bytes	=3D tpm_tis_synquacer_write_bytes,
-	.read16		=3D tpm_tis_synquacer_read16_bw,
-	.read32		=3D tpm_tis_synquacer_read32_bw,
-	.write32	=3D tpm_tis_synquacer_write32_bw,
 };
=20
 static int tpm_tis_synquacer_init(struct device *dev,
--=20
2.31.1.windows.1

