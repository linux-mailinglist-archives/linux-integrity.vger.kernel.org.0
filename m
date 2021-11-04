Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF076445482
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Nov 2021 15:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbhKDOIB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Nov 2021 10:08:01 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:47756 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231332AbhKDOIA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Nov 2021 10:08:00 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 1A4E27JY029314;
        Thu, 4 Nov 2021 16:02:07 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10140)
        id E8B5663A21; Thu,  4 Nov 2021 16:02:18 +0200 (IST)
From:   amirmizi6@gmail.com
To:     Eyal.Cohen@nuvoton.com, jarkko@kernel.org, oshrialkoby85@gmail.com,
        alexander.steffen@infineon.com, robh+dt@kernel.org,
        mark.rutland@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org, benoit.houyere@st.com,
        eajames@linux.ibm.com, joel@jms.id.au
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com,
        Amir Mizinski <amirmizi6@gmail.com>
Subject: [PATCH v19 4/5] tpm: tpm_tis: Add tpm_tis_i2c driver
Date:   Thu,  4 Nov 2021 16:02:10 +0200
Message-Id: <20211104140211.6258-5-amirmizi6@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20211104140211.6258-1-amirmizi6@gmail.com>
References: <20211104140211.6258-1-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Amir Mizinski <amirmizi6@gmail.com>

I2C support for TPM devices on the TIS interface is currently available
only as a proprietary driver implementation for each TPM vendor.
This patch implements the infrastructure for a TCG-compliant TPM TIS I2C
driver with the functionality required to communicate with a TPM device
over I2C according to the "TCG PC Client PTP Interface Specification"
and "Device Driver Design Principles for TPM 2.0"

References:
[1] "TCG PC Client Platform TPM Profile(PTP) Interface Specification for
TPM 2.0" Version 01.03 Revision 22 at:
https://trustedcomputinggroup.org/resource/pc-client-platform-tpm-profile-ptp-specification/
[2] "TCG PC Client Device Driver Design Principles for TPM 2.0"
Version 1.0 Revision 27 at:
https://trustedcomputinggroup.org/resource/tcg-pc-client-device-driver-design-principles-for-tpm-2-0/

Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
Tested-by: Eddie James <eajames@linux.ibm.com>
Tested-by: Joel Stanley <joel@jms.id.au>
---
 drivers/char/tpm/Kconfig       |  12 ++
 drivers/char/tpm/Makefile      |   1 +
 drivers/char/tpm/tpm_tis_i2c.c | 263 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 276 insertions(+)
 create mode 100644 drivers/char/tpm/tpm_tis_i2c.c

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 4308f9c..4137ded 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -86,6 +86,18 @@ config TCG_TIS_SYNQUACER
 	  To compile this driver as a module, choose  M here;
 	  the module will be called tpm_tis_synquacer.
 
+config TCG_TIS_I2C
+	tristate "TPM I2C Interface Specification"
+	depends on I2C
+	select CRC_CCITT
+	select TCG_TIS_CORE
+	help
+	  If you have a TPM security chip, compliant with the TCG TPM PTP
+	  (I2C interface) specification and connected to an I2C bus master,
+	  say Yes and it will be accessible from within Linux.
+	  To compile this driver as a module, choose M here;
+	  the module will be called tpm_tis_i2c.
+
 config TCG_TIS_I2C_CR50
 	tristate "TPM Interface Specification 2.0 Interface (I2C - CR50)"
 	depends on I2C
diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
index 66d39ea..0222b1d 100644
--- a/drivers/char/tpm/Makefile
+++ b/drivers/char/tpm/Makefile
@@ -29,6 +29,7 @@ tpm_tis_spi-$(CONFIG_TCG_TIS_SPI_CR50) += tpm_tis_spi_cr50.o
 
 obj-$(CONFIG_TCG_TIS_I2C_CR50) += tpm_tis_i2c_cr50.o
 
+obj-$(CONFIG_TCG_TIS_I2C) += tpm_tis_i2c.o
 obj-$(CONFIG_TCG_TIS_I2C_ATMEL) += tpm_i2c_atmel.o
 obj-$(CONFIG_TCG_TIS_I2C_INFINEON) += tpm_i2c_infineon.o
 obj-$(CONFIG_TCG_TIS_I2C_NUVOTON) += tpm_i2c_nuvoton.o
diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
new file mode 100644
index 0000000..12984a3
--- /dev/null
+++ b/drivers/char/tpm/tpm_tis_i2c.c
@@ -0,0 +1,263 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2014-2021 Nuvoton Technology corporation
+ *
+ * TPM TIS I2C Device Driver Interface for devices that implement the TPM
+ * I2C Interface defined by "TCG PC Client Platform TPM Profile (PTP)
+ * Specification version 01.05 r14" and "TCG PC Client Device Driver
+ * Design Principles version 1.0 r27" for TPM 2.0 at
+ * www.trustedcomputinggroup.org
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
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/gpio.h>
+#include <linux/of_irq.h>
+#include <linux/of_gpio.h>
+#include <linux/tpm.h>
+#include "tpm_tis_core.h"
+
+#define TPM_LOC_SEL			0x04
+#define TPM_I2C_INTERFACE_CAPABILITY	0x30
+#define TPM_I2C_DEVICE_ADDRESS		0x38
+#define TPM_DATA_CSUM_ENABLE		0x40
+#define TPM_I2C_DID_VID			0x48
+#define TPM_I2C_RID			0x4C
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
+static int tpm_tis_i2c_read_bytes(struct tpm_tis_data *data, u32 addr, u16 len, u8 *result)
+{
+	struct tpm_tis_i2c_phy *phy = to_tpm_tis_i2c_phy(data);
+	u8 reg = address_to_register(addr);
+	int ret;
+	int i = 0;
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
+		struct i2c_msg msgs[] = {
+			{
+				.addr = phy->i2c_client->addr,
+				.len = len + 1,
+				.buf = phy->iobuf,
+			},
+		};
+
+		do {
+			ret = i2c_transfer(phy->i2c_client->adapter,
+					   msgs, ARRAY_SIZE(msgs));
+			// wait default GUARD_TIME of 250µs
+			usleep_range(250, 300);
+		} while (ret < 0 && i++ < TPM_RETRY);
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
+
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
+	return 0;
+}
+
+int tpm_tis_i2c_read16(struct tpm_tis_data *data, u32 addr, u16 *result)
+{
+	__le16 result_le;
+	int rc;
+
+	rc = data->phy_ops->read_bytes(data, addr, sizeof(u16),
+				       (u8 *)&result_le);
+	if (!rc)
+		*result = le16_to_cpu(result_le);
+
+	return rc;
+}
+
+int tpm_tis_i2c_read32(struct tpm_tis_data *data, u32 addr, u32 *result)
+{
+	__le32 result_le;
+	int rc;
+
+	rc = data->phy_ops->read_bytes(data, addr, sizeof(u32),
+				       (u8 *)&result_le);
+	if (!rc)
+		*result = le32_to_cpu(result_le);
+
+	return rc;
+}
+
+int tpm_tis_i2c_write32(struct tpm_tis_data *data, u32 addr, u32 value)
+{
+	__le32 value_le;
+	int rc;
+
+	value_le = cpu_to_le32(value);
+
+	rc = data->phy_ops->write_bytes(data, addr, sizeof(u32),
+					(u8 *)&value_le);
+
+	return rc;
+}
+
+static SIMPLE_DEV_PM_OPS(tpm_tis_pm, tpm_pm_suspend, tpm_tis_resume);
+
+static const struct tpm_tis_phy_ops tpm_i2c_phy_ops = {
+	.read_bytes = tpm_tis_i2c_read_bytes,
+	.write_bytes = tpm_tis_i2c_write_bytes,
+	.read16 = tpm_tis_i2c_read16,
+	.read32 = tpm_tis_i2c_read32,
+	.write32 = tpm_tis_i2c_write32,
+};
+
+static int tpm_tis_i2c_probe(struct i2c_client *dev, const struct i2c_device_id *id)
+{
+	struct tpm_tis_i2c_phy *phy;
+	const u8 loc_init = 0;
+	int rc;
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
+	/*select locality 0 (the driver will access only via locality 0)*/
+	rc = tpm_tis_i2c_write_bytes(&phy->priv, TPM_LOC_SEL, 1, &loc_init);
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
+	{ .compatible = "nuvoton,npct75x", },
+	{ .compatible = "tcg,tpm-tis-i2c", },
+	{}
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
+	.id_table = tpm_tis_i2c_id,
+};
+
+module_i2c_driver(tpm_tis_i2c_driver);
+
+MODULE_DESCRIPTION("TPM Driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4

