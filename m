Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B44271580DE
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Feb 2020 18:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgBJRK2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Feb 2020 12:10:28 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:36755 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728208AbgBJRK0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Feb 2020 12:10:26 -0500
X-Greylist: delayed 2425 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Feb 2020 12:09:57 EST
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 01AGT9su011303;
        Mon, 10 Feb 2020 18:29:09 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10140)
        id A1B566032E; Mon, 10 Feb 2020 18:29:09 +0200 (IST)
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
Subject: [PATCH v3 7/7] char: tpm: add tpm_tis_i2c driver
Date:   Mon, 10 Feb 2020 18:28:38 +0200
Message-Id: <20200210162838.173903-8-amirmizi6@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200210162838.173903-1-amirmizi6@gmail.com>
References: <20200210162838.173903-1-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Amir Mizinski <amirmizi6@gmail.com>

Implements the functionality needed to communicate with an I2C TPM
according to the TCG TPM I2C Interface Specification.

Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
---
 drivers/char/tpm/Kconfig       |  12 ++
 drivers/char/tpm/Makefile      |   1 +
 drivers/char/tpm/tpm_tis_i2c.c | 292 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 305 insertions(+)
 create mode 100644 drivers/char/tpm/tpm_tis_i2c.c

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index aacdeed..b482bbf 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -74,6 +74,18 @@ config TCG_TIS_SPI_CR50
 	  If you have a H1 secure module running Cr50 firmware on SPI bus,
 	  say Yes and it will be accessible from within Linux.
 
+config TCG_TIS_I2C
+	tristate "TPM I2C Interface Specification"
+	depends on I2C
+	 depends on CRC_CCITT
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
index 5a0d99d..5c9a31d 100644
--- a/drivers/char/tpm/Makefile
+++ b/drivers/char/tpm/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_TCG_TIS) += tpm_tis.o
 obj-$(CONFIG_TCG_TIS_SPI) += tpm_tis_spi_mod.o
 tpm_tis_spi_mod-y := tpm_tis_spi.o
 tpm_tis_spi_mod-$(CONFIG_TCG_TIS_SPI_CR50) += tpm_tis_spi_cr50.o
+obj-$(CONFIG_TCG_TIS_I2C) += tpm_tis_i2c.o
 obj-$(CONFIG_TCG_TIS_I2C_ATMEL) += tpm_i2c_atmel.o
 obj-$(CONFIG_TCG_TIS_I2C_INFINEON) += tpm_i2c_infineon.o
 obj-$(CONFIG_TCG_TIS_I2C_NUVOTON) += tpm_i2c_nuvoton.o
diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
new file mode 100644
index 0000000..c10ec7e
--- /dev/null
+++ b/drivers/char/tpm/tpm_tis_i2c.c
@@ -0,0 +1,292 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2014-2019 Nuvoton Technology corporation
+ *
+ * TPM TIS I2C
+ *
+ * TPM TIS I2C Device Driver Interface for devices that implement the TPM I2C
+ * Interface defined by TCG PC Client Platform TPM Profile (PTP) Specification
+ * Revision 01.03 v22 at www.trustedcomputinggroup.org
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
+#include <linux/crc-ccitt.h>
+
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/gpio.h>
+#include <linux/of_irq.h>
+#include <linux/of_gpio.h>
+#include <linux/tpm.h>
+#include "tpm.h"
+#include "tpm_tis_core.h"
+
+#define TPM_LOC_SEL                    0x04
+#define TPM_I2C_INTERFACE_CAPABILITY   0x30
+#define TPM_I2C_DEVICE_ADDRESS         0x38
+#define TPM_DATA_CSUM_ENABLE           0x40
+#define TPM_DATA_CSUM                  0x44
+#define TPM_I2C_DID_VID                        0x48
+#define TPM_I2C_RID                    0x4C
+
+//#define I2C_IS_TPM2 1
+
+struct tpm_tis_i2c_phy {
+	struct tpm_tis_data priv;
+	struct i2c_client *i2c_client;
+	bool data_csum;
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
+
+	switch (addr) {
+		// adapt register addresses that have changed compared to
+		// older TIS versions
+	case TPM_ACCESS(0):
+		return 0x04;
+	case TPM_LOC_SEL:
+		return 0x00;
+	case TPM_DID_VID(0):
+		return 0x48;
+	case TPM_RID(0):
+		return 0x4C;
+	default:
+		return addr;
+	}
+}
+
+static int tpm_tis_i2c_read_bytes(struct tpm_tis_data *data, u32 addr,
+				  u16 len, u8 *result)
+{
+	struct tpm_tis_i2c_phy *phy = to_tpm_tis_i2c_phy(data);
+	int ret = 0;
+	int i = 0;
+	u8 reg = address_to_register(addr);
+	struct i2c_msg msgs[] = {
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
+	do {
+		ret = i2c_transfer(phy->i2c_client->adapter, msgs,
+				   ARRAY_SIZE(msgs));
+		usleep_range(250, 300); // wait default GUARD_TIME of 250µs
+
+	} while (ret < 0 && i++ < TPM_RETRY);
+
+	if (ret < 0)
+		return ret;
+
+
+	return 0;
+}
+
+static int tpm_tis_i2c_write_bytes(struct tpm_tis_data *data, u32 addr,
+				   u16 len, const u8 *value)
+{
+	struct tpm_tis_i2c_phy *phy = to_tpm_tis_i2c_phy(data);
+	int ret = 0;
+	int i = 0;
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
+					.len = len + 1,
+					.buf = phy->iobuf,
+				},
+			};
+
+			do {
+				ret = i2c_transfer(phy->i2c_client->adapter,
+						   msgs, ARRAY_SIZE(msgs));
+				// wait default GUARD_TIME of 250µs
+				usleep_range(250, 300);
+			} while (ret < 0 && i++ < TPM_RETRY);
+		}
+	} else {
+		u8 reg = address_to_register(addr);
+
+		struct i2c_msg msgs[] = {
+			{
+				.addr = phy->i2c_client->addr,
+				.len = sizeof(reg),
+				.buf = &reg,
+			},
+			{
+				.addr = phy->i2c_client->addr,
+				.len = len,
+				.buf = (u8 *)value,
+				.flags = I2C_M_NOSTART,
+			},
+		};
+		do {
+			ret = i2c_transfer(phy->i2c_client->adapter, msgs,
+					   ARRAY_SIZE(msgs));
+			// wait default GUARD_TIME of 250µs
+			usleep_range(250, 300);
+		} while (ret < 0 && i++ < TPM_RETRY);
+	}
+
+	if (ret < 0)
+		return ret;
+
+
+	return 0;
+}
+
+static bool tpm_tis_i2c_check_data(struct tpm_tis_data *data,
+				   const u8 *buf, size_t len)
+{
+	struct tpm_tis_i2c_phy *phy = to_tpm_tis_i2c_phy(data);
+	u16 crc, crc_tpm;
+	int rc;
+
+	if (phy->data_csum) {
+		crc = crc_ccitt(0x0000, buf, len);
+		rc = tpm_tis_read16(data, TPM_DATA_CSUM, &crc_tpm);
+		if (rc < 0)
+			return false;
+
+		crc_tpm = be16_to_cpu(crc_tpm);
+		return crc == crc_tpm;
+	}
+
+	return true;
+}
+
+static SIMPLE_DEV_PM_OPS(tpm_tis_pm, tpm_pm_suspend, tpm_tis_resume);
+
+static int csum_state_store(struct tpm_tis_data *data, u8 new_state)
+{
+	struct tpm_tis_i2c_phy *phy = to_tpm_tis_i2c_phy(data);
+	u8 cur_state;
+	int rc;
+
+	rc = tpm_tis_i2c_write_bytes(&phy->priv, TPM_DATA_CSUM_ENABLE,
+				     1, &new_state);
+	if (rc < 0)
+		return rc;
+
+	rc = tpm_tis_i2c_read_bytes(&phy->priv, TPM_DATA_CSUM_ENABLE,
+				    1, &cur_state);
+	if (rc < 0)
+		return rc;
+
+	if (new_state == cur_state)
+		phy->data_csum = (bool)new_state;
+
+	return rc;
+}
+
+static const struct tpm_tis_phy_ops tpm_i2c_phy_ops = {
+	.read_bytes = tpm_tis_i2c_read_bytes,
+	.write_bytes = tpm_tis_i2c_write_bytes,
+	.check_data = tpm_tis_i2c_check_data,
+};
+
+static int tpm_tis_i2c_probe(struct i2c_client *dev,
+			     const struct i2c_device_id *id)
+{
+	struct tpm_tis_i2c_phy *phy;
+	int rc;
+	int CRC_Checksum = 0;
+	const u8 loc_init = 0;
+	struct device_node *np;
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
+	// select locality 0 (the driver will access only via locality 0)
+	rc = tpm_tis_i2c_write_bytes(&phy->priv, TPM_LOC_SEL, 1, &loc_init);
+	if (rc < 0)
+		return rc;
+
+	// set CRC checksum calculation enable
+	np = dev->dev.of_node;
+	if (of_property_read_bool(np, "crc-checksum"))
+		CRC_Checksum = 1;
+
+	rc = csum_state_store(&phy->priv, CRC_Checksum);
+	if (rc < 0)
+		return rc;
+
+	return tpm_tis_core_init(&dev->dev, &phy->priv, -1, &tpm_i2c_phy_ops,
+					NULL);
+}
+
+static const struct i2c_device_id tpm_tis_i2c_id[] = {
+	{"tpm_tis_i2c", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_id);
+
+static const struct of_device_id of_tis_i2c_match[] = {
+	{ .compatible = "tcg,tpm-tis-i2c", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, of_tis_i2c_match);
+
+static const struct acpi_device_id acpi_tis_i2c_match[] = {
+	{"SMO0768", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, acpi_tis_i2c_match);
+
+static struct i2c_driver tpm_tis_i2c_driver = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "tpm_tis_i2c",
+		.pm = &tpm_tis_pm,
+		.of_match_table = of_match_ptr(of_tis_i2c_match),
+		.acpi_match_table = ACPI_PTR(acpi_tis_i2c_match),
+	},
+	.probe = tpm_tis_i2c_probe,
+	.id_table = tpm_tis_i2c_id,
+};
+
+module_i2c_driver(tpm_tis_i2c_driver);
+
+MODULE_DESCRIPTION("TPM Driver for native I2C access");
+MODULE_LICENSE("GPL");
-- 
2.7.4

