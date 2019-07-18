Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D42E6D27D
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jul 2019 19:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfGRRES (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jul 2019 13:04:18 -0400
Received: from smtp2.infineon.com ([217.10.52.18]:8977 "EHLO
        smtp2.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbfGRRER (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jul 2019 13:04:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1563469456; x=1595005456;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=heLYrmjBPyUnLaTN4TrtKotWUK3hXKg9X6cg/q0TclU=;
  b=IfHgUDX5lp+uZIa4xOB470ObUg/wv0G+twTzXiYTesgzo3s96X8bjZRf
   HDXmnfHmvxHhON+oK4hAeVW3KKkcuAeEBUYvL7gNDcGdqys9e2PRWQ4cZ
   glFif6StDi3bdDe4ZJRkyL0cyW4Q9wRdodk6rq/MRjZfDLFKldW3saHoX
   Q=;
IronPort-SDR: TpfhNt1YBeVg9gcVJltMOgZwbDXu/+FPabXeJtXNPuTQy89ye804Zcd0ebWrfD3qcbZ2yw72ax
 Y2eC/eJj6TUQ==
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6000,8403,9322"; a="6919389"
X-IronPort-AV: E=Sophos;i="5.64,278,1559512800"; 
   d="scan'208";a="6919389"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2019 19:04:13 +0200
Received: from MUCSE708.infineon.com (MUCSE708.infineon.com [172.23.7.82])
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS;
        Thu, 18 Jul 2019 19:04:13 +0200 (CEST)
Received: from ISCNPC0VBFBX.infineon.com (172.23.8.247) by
 MUCSE708.infineon.com (172.23.7.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.1.1591.10; Thu, 18 Jul 2019 19:04:13 +0200
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
To:     <linux-integrity@vger.kernel.org>,
        <jarkko.sakkinen@linux.intel.com>
CC:     <tmaimon77@gmail.com>, <oshrialkoby85@gmail.com>,
        <Eyal.Cohen@nuvoton.com>, <Dan.Morav@nuvoton.com>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: [RFC PATCH 1/2] tpm: Make implementation of read16/read32/write32 optional
Date:   Thu, 18 Jul 2019 19:03:54 +0200
Message-ID: <20190718170355.6464-2-Alexander.Steffen@infineon.com>
X-Mailer: git-send-email 2.18.0.windows.1
In-Reply-To: <20190718170355.6464-1-Alexander.Steffen@infineon.com>
References: <20190718170355.6464-1-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE707.infineon.com (172.23.7.81) To
 MUCSE708.infineon.com (172.23.7.82)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Only tpm_tis has a faster way to access multiple bytes at once, every other
driver will just fall back to read_bytes/write_bytes. Therefore, move this
common code out of tpm_tis_spi into tpm_tis_core, so that it is
automatically used when low-level drivers do not implement the specialized
methods.

Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
---
 drivers/char/tpm/tpm_tis_core.h | 41 ++++++++++++++++++++++++++++++---
 drivers/char/tpm/tpm_tis_spi.c  | 41 ---------------------------------
 2 files changed, 38 insertions(+), 44 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 7337819f5d7b..2c6557b29a1d 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -122,13 +122,37 @@ static inline int tpm_tis_read8(struct tpm_tis_data *data, u32 addr, u8 *result)
 static inline int tpm_tis_read16(struct tpm_tis_data *data, u32 addr,
 				 u16 *result)
 {
-	return data->phy_ops->read16(data, addr, result);
+	if (data->phy_ops->read16) {
+		return data->phy_ops->read16(data, addr, result);
+	} else {
+		__le16 result_le;
+		int rc;
+
+		rc = data->phy_ops->read_bytes(data, addr, sizeof(u16),
+					       (u8 *)&result_le);
+		if (!rc)
+			*result = le16_to_cpu(result_le);
+
+		return rc;
+	}
 }
 
 static inline int tpm_tis_read32(struct tpm_tis_data *data, u32 addr,
 				 u32 *result)
 {
-	return data->phy_ops->read32(data, addr, result);
+	if (data->phy_ops->read32) {
+		return data->phy_ops->read32(data, addr, result);
+	} else {
+		__le32 result_le;
+		int rc;
+
+		rc = data->phy_ops->read_bytes(data, addr, sizeof(u32),
+					       (u8 *)&result_le);
+		if (!rc)
+			*result = le32_to_cpu(result_le);
+
+		return rc;
+	}
 }
 
 static inline int tpm_tis_write_bytes(struct tpm_tis_data *data, u32 addr,
@@ -145,7 +169,18 @@ static inline int tpm_tis_write8(struct tpm_tis_data *data, u32 addr, u8 value)
 static inline int tpm_tis_write32(struct tpm_tis_data *data, u32 addr,
 				  u32 value)
 {
-	return data->phy_ops->write32(data, addr, value);
+	if (data->phy_ops->write32) {
+		return data->phy_ops->write32(data, addr, value);
+	} else {
+		__le32 value_le;
+		int rc;
+
+		value_le = cpu_to_le32(value);
+		rc = data->phy_ops->write_bytes(data, addr, sizeof(u32),
+						(u8 *)&value_le);
+
+		return rc;
+	}
 }
 
 static inline bool is_bsw(void)
diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_spi.c
index 19513e622053..da82924b08fe 100644
--- a/drivers/char/tpm/tpm_tis_spi.c
+++ b/drivers/char/tpm/tpm_tis_spi.c
@@ -146,50 +146,9 @@ static int tpm_tis_spi_write_bytes(struct tpm_tis_data *data, u32 addr,
 	return tpm_tis_spi_transfer(data, addr, len, NULL, value);
 }
 
-static int tpm_tis_spi_read16(struct tpm_tis_data *data, u32 addr, u16 *result)
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
-static int tpm_tis_spi_read32(struct tpm_tis_data *data, u32 addr, u32 *result)
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
-static int tpm_tis_spi_write32(struct tpm_tis_data *data, u32 addr, u32 value)
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
 static const struct tpm_tis_phy_ops tpm_spi_phy_ops = {
 	.read_bytes = tpm_tis_spi_read_bytes,
 	.write_bytes = tpm_tis_spi_write_bytes,
-	.read16 = tpm_tis_spi_read16,
-	.read32 = tpm_tis_spi_read32,
-	.write32 = tpm_tis_spi_write32,
 };
 
 static int tpm_tis_spi_probe(struct spi_device *dev)
-- 
2.17.1

