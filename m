Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF476D27B
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jul 2019 19:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfGRREQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jul 2019 13:04:16 -0400
Received: from smtp11.infineon.com ([217.10.52.105]:53101 "EHLO
        smtp11.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727730AbfGRREP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jul 2019 13:04:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1563469455; x=1595005455;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B+35LXPE+vnSS2m7JM6UC870BrUpxQLmaTE5RYgqc6Q=;
  b=f+83A6lNDzHa/7ZCu/DdbOPjOontm/ErW9UhC/B+0ixIuGWUV+B8f4TU
   pg36ETFzHY04kUaIpO54njoGHXA4uMf0/sfDb5BRxffAtoY6JS7AlaTcg
   seHNFppomZ22WFBA2EL86tMtcgx+nGpjwvwl93SGsAMQ/AkeLlPuI2ZJg
   Q=;
IronPort-SDR: hAN+ofWr5IfbAxuThoYYNVjEqnqZiPF9gT5BuXq1iLrjAvz/sU1R5CN6L51mbXw8WKXO3EQV8H
 UQ8Imd8usMTEh1rg2wYeq6/BKhc9IJb3pZ74H3Gmvet0PAiLe/JFLBnfpgeo3F63JYQXa1IS+4
 7bZlDZFCpWgKNSP4eDX0QugJbAKDFerpRe0E2x+69yzPSDrfPxG+pD5EeWGICG4EPa5/MMi4zX
 6XWd40wbjeyRINwcbwmukRsNn5e1cl3wVlfzNbsagG42cmzkVGTth67ANrd3C2/kju/A28i4R4
 +b8=
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6000,8403,9322"; a="128253232"
X-IronPort-AV: E=Sophos;i="5.64,278,1559512800"; 
   d="scan'208";a="128253232"
Received: from unknown (HELO mucxv001.muc.infineon.com) ([172.23.11.16])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2019 19:04:14 +0200
Received: from MUCSE708.infineon.com (MUCSE708.infineon.com [172.23.7.82])
        by mucxv001.muc.infineon.com (Postfix) with ESMTPS;
        Thu, 18 Jul 2019 19:04:14 +0200 (CEST)
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
Subject: [RFC PATCH 2/2] tpm: Add tpm_tis_i2c backend for tpm_tis_core
Date:   Thu, 18 Jul 2019 19:03:55 +0200
Message-ID: <20190718170355.6464-3-Alexander.Steffen@infineon.com>
X-Mailer: git-send-email 2.18.0.windows.1
In-Reply-To: <20190718170355.6464-1-Alexander.Steffen@infineon.com>
References: <20190718170355.6464-1-Alexander.Steffen@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE707.infineon.com (172.23.7.81) To
 MUCSE708.infineon.com (172.23.7.82)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Implements the minimal functionality necessary to talk to an I2C TPM
according to the TCG TPM I2C Interface Specification.

Limitations:
* No IRQ support
* No support for updating GUARD_TIME (uses always the default of 250µs)
* No support for Data Checksum register (optional feature only for I2C)

Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
---
 drivers/char/tpm/Kconfig       |  11 ++
 drivers/char/tpm/Makefile      |   1 +
 drivers/char/tpm/tpm_tis_i2c.c | 233 +++++++++++++++++++++++++++++++++
 3 files changed, 245 insertions(+)
 create mode 100644 drivers/char/tpm/tpm_tis_i2c.c

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 17bfbf9f572f..383371d30931 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -67,6 +67,17 @@ config TCG_TIS_SPI
 	  within Linux. To compile this driver as a module, choose  M here;
 	  the module will be called tpm_tis_spi.
 
+config TCG_TIS_I2C
+	tristate "TPM I2C Interface Specification"
+	depends on I2C
+	select TCG_TIS_CORE
+	---help---
+	  If you have a TPM security chip which is connected to a regular
+	  I2C master (i.e. most embedded platforms) that is compliant with the
+	  TCG TPM I2C Interface Specification say Yes and it will be accessible from
+	  within Linux. To compile this driver as a module, choose  M here;
+	  the module will be called tpm_tis_i2c.
+
 config TCG_TIS_I2C_ATMEL
 	tristate "TPM Interface Specification 1.2 Interface (I2C - Atmel)"
 	depends on I2C
diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
index c354cdff9c62..c969e4250a1d 100644
--- a/drivers/char/tpm/Makefile
+++ b/drivers/char/tpm/Makefile
@@ -22,6 +22,7 @@ tpm-$(CONFIG_OF) += eventlog/of.o
 obj-$(CONFIG_TCG_TIS_CORE) += tpm_tis_core.o
 obj-$(CONFIG_TCG_TIS) += tpm_tis.o
 obj-$(CONFIG_TCG_TIS_SPI) += tpm_tis_spi.o
+obj-$(CONFIG_TCG_TIS_I2C) += tpm_tis_i2c.o
 obj-$(CONFIG_TCG_TIS_I2C_ATMEL) += tpm_i2c_atmel.o
 obj-$(CONFIG_TCG_TIS_I2C_INFINEON) += tpm_i2c_infineon.o
 obj-$(CONFIG_TCG_TIS_I2C_NUVOTON) += tpm_i2c_nuvoton.o
diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
new file mode 100644
index 000000000000..d6eea9e2af5b
--- /dev/null
+++ b/drivers/char/tpm/tpm_tis_i2c.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2019 Infineon Technologies AG
+ *
+ * Authors:
+ * Alexander Steffen <alexander.steffen@infineon.com>
+ *
+ * Maintained by: <tpmdd-devel@lists.sourceforge.net>
+ *
+ * Device driver for TCG/TCPA TPM (trusted platform module).
+ * Specifications at www.trustedcomputinggroup.org
+ *
+ * This device driver implements the TPM interface as defined in
+ * the TCG TPM I2C Interface Specification Familiy 2.0, Revision 1.00.
+ *
+ * It is based on the tpm_tis_spi device driver.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/wait.h>
+#include <linux/acpi.h>
+#include <linux/freezer.h>
+
+#include <linux/i2c.h>
+#include <linux/tpm.h>
+#include "tpm.h"
+#include "tpm_tis_core.h"
+
+struct tpm_tis_i2c_phy {
+	struct tpm_tis_data priv;
+	struct i2c_client *i2c_client;
+	u8 *iobuf;
+};
+
+static inline struct tpm_tis_i2c_phy *to_tpm_tis_i2c_phy(struct tpm_tis_data *data)
+{
+	return container_of(data, struct tpm_tis_i2c_phy, priv);
+}
+
+static u8 address_to_register(u32 addr)
+{
+	addr &= 0xFFF;
+	switch (addr) {
+		// adapt register addresses that have changed compared to
+		// older TIS versions
+		case TPM_ACCESS(0):
+			return 0x04;
+		case TPM_DID_VID(0):
+			return 0x48;
+		case TPM_RID(0):
+			return 0x4C;
+		default:
+			return addr;
+	}
+}
+
+static int tpm_tis_i2c_read_bytes(struct tpm_tis_data *data, u32 addr,
+				  u16 len, u8 *result)
+{
+	struct tpm_tis_i2c_phy *phy = to_tpm_tis_i2c_phy(data);
+	int ret;
+
+	u8 locality[] = {
+		0, // TPM_LOC_SEL
+		addr >> 12, // locality
+	};
+	u8 reg = address_to_register(addr);
+	struct i2c_msg msgs[] = {
+		{
+			.addr = phy->i2c_client->addr,
+			.len = sizeof(locality),
+			.buf = locality,
+		},
+		{
+			.addr = phy->i2c_client->addr,
+			.len = sizeof(reg),
+			.buf = &reg,
+		},
+		{
+			.addr = phy->i2c_client->addr,
+			.len = len,
+			.buf = result,
+			.flags = I2C_M_RD,
+		},
+	};
+
+	ret = i2c_transfer(phy->i2c_client->adapter, msgs, ARRAY_SIZE(msgs));
+
+	if (ret < 0)
+		return ret;
+
+	usleep_range(250, 300); // wait default GUARD_TIME of 250µs
+
+	return 0;
+}
+
+static int tpm_tis_i2c_write_bytes(struct tpm_tis_data *data, u32 addr,
+				   u16 len, const u8 *value)
+{
+	struct tpm_tis_i2c_phy *phy = to_tpm_tis_i2c_phy(data);
+	int ret;
+
+	u8 locality[] = {
+		0, // TPM_LOC_SEL
+		addr >> 12, // locality
+	};
+
+	if (phy->iobuf) {
+		if (len > TPM_BUFSIZE - 1)
+			return -EIO;
+
+		phy->iobuf[0] = address_to_register(addr);
+		memcpy(phy->iobuf + 1, value, len);
+
+		{
+			struct i2c_msg msgs[] = {
+				{
+					.addr = phy->i2c_client->addr,
+					.len = sizeof(locality),
+					.buf = locality,
+				},
+				{
+					.addr = phy->i2c_client->addr,
+					.len = len + 1,
+					.buf = phy->iobuf,
+				},
+			};
+
+			ret = i2c_transfer(phy->i2c_client->adapter, msgs,
+					   ARRAY_SIZE(msgs));
+		}
+	} else {
+		u8 reg = address_to_register(addr);
+
+		struct i2c_msg msgs[] = {
+			{
+				.addr = phy->i2c_client->addr,
+				.len = sizeof(locality),
+				.buf = locality,
+			},
+			{
+				.addr = phy->i2c_client->addr,
+				.len = sizeof(reg),
+				.buf = &reg,
+			},
+			{
+				.addr = phy->i2c_client->addr,
+				.len = len,
+				.buf = (u8*)value,
+				.flags = I2C_M_NOSTART,
+			},
+		};
+
+		ret = i2c_transfer(phy->i2c_client->adapter, msgs,
+				   ARRAY_SIZE(msgs));
+	}
+
+	if (ret < 0)
+		return ret;
+
+	usleep_range(250, 300); // wait default GUARD_TIME of 250µs
+
+	return 0;
+}
+
+static const struct tpm_tis_phy_ops tpm_i2c_phy_ops = {
+	.read_bytes = tpm_tis_i2c_read_bytes,
+	.write_bytes = tpm_tis_i2c_write_bytes,
+};
+
+static int tpm_tis_i2c_probe(struct i2c_client *dev, const struct i2c_device_id *id)
+{
+	struct tpm_tis_i2c_phy *phy;
+
+	phy = devm_kzalloc(&dev->dev, sizeof(struct tpm_tis_i2c_phy),
+			   GFP_KERNEL);
+	if (!phy)
+		return -ENOMEM;
+
+	phy->i2c_client = dev;
+
+	if (!i2c_check_functionality(dev->adapter, I2C_FUNC_NOSTART)) {
+		phy->iobuf = devm_kmalloc(&dev->dev, TPM_BUFSIZE, GFP_KERNEL);
+		if (!phy->iobuf)
+			return -ENOMEM;
+	}
+
+	return tpm_tis_core_init(&dev->dev, &phy->priv, -1, &tpm_i2c_phy_ops,
+				 NULL);
+}
+
+static SIMPLE_DEV_PM_OPS(tpm_tis_pm, tpm_pm_suspend, tpm_tis_resume);
+
+static int tpm_tis_i2c_remove(struct i2c_client *dev)
+{
+	struct tpm_chip *chip = i2c_get_clientdata(dev);
+
+	tpm_chip_unregister(chip);
+	tpm_tis_remove(chip);
+	return 0;
+}
+
+static const struct i2c_device_id tpm_tis_i2c_id[] = {
+	{"tpm_tis_i2c", 0},
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_id);
+
+static const struct of_device_id of_tis_i2c_match[] = {
+	{ .compatible = "tcg,tpm_tis-i2c", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_tis_i2c_match);
+
+static struct i2c_driver tpm_tis_i2c_driver = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "tpm_tis_i2c",
+		.pm = &tpm_tis_pm,
+		.of_match_table = of_match_ptr(of_tis_i2c_match),
+	},
+	.probe = tpm_tis_i2c_probe,
+	.remove = tpm_tis_i2c_remove,
+	.id_table = tpm_tis_i2c_id,
+};
+module_i2c_driver(tpm_tis_i2c_driver);
+
+MODULE_DESCRIPTION("TPM Driver for native I2C access");
+MODULE_LICENSE("GPL");
-- 
2.17.1

