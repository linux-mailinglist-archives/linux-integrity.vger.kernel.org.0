Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118D77AF426
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Sep 2023 21:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjIZTaO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 Sep 2023 15:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjIZTaN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Sep 2023 15:30:13 -0400
X-Greylist: delayed 565 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 26 Sep 2023 12:30:06 PDT
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FA6FC;
        Tue, 26 Sep 2023 12:30:05 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id B91712800B48B;
        Tue, 26 Sep 2023 21:20:38 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id AC0D1155F66; Tue, 26 Sep 2023 21:20:38 +0200 (CEST)
Message-Id: <75b775d0526e72f292e0546a306b37680714686c.1695754856.git.lukas@wunner.de>
In-Reply-To: <ae40859b82494d75e9ad7bf616b3264138ad1f6a.1695754856.git.lukas@wunner.de>
References: <ae40859b82494d75e9ad7bf616b3264138ad1f6a.1695754856.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Tue, 26 Sep 2023 21:09:36 +0200
Subject: [PATCH 2/2] reset: Add Infineon SLB9670 TPM reset driver
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        linux-integrity@vger.kernel.org, devicetree@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Lino Sanfilippo <l.sanfilippo@kunbus.com>

Normally the platform firmware is responsible for taking a Trusted
Platform Module out of reset on boot and storing measurements into it.

However if the platform firmware is incapable of doing that -- as is the
case on the Raspberry Pi -- then the onus is on the kernel to take the
TPM out of reset before trying to attach a driver to it.

Provide a reset driver for such platforms.

The Infineon SLB9670 TPM requires a specific reset sequence on its RST#
pin which is documented in sections 5.4 and 5.5 of the datasheet:

https://www.infineon.com/dgdl/Infineon-SLB%209670VQ2.0-DataSheet-v01_04-EN.pdf?fileId=5546d4626fc1ce0b016fc78270350cd6

The sequence with minimum wait intervals is as follows:

  deassert RST#
  wait at least 60 ms
  assert RST#
  wait at least 2 usecs
  deassert RST#
  wait at least 60 ms
  assert RST#
  wait at least 2 usecs
  deassert RST#
  wait at least 60 ms before issuing the first TPM command

Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/reset/Kconfig         |   9 +++
 drivers/reset/Makefile        |   1 +
 drivers/reset/reset-slb9670.c | 141 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 151 insertions(+)
 create mode 100644 drivers/reset/reset-slb9670.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index ccd59dd..3296e33 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -229,6 +229,15 @@ config RESET_SIMPLE
 	   - Allwinner SoCs
 	   - SiFive FU740 SoCs
 
+config RESET_SLB9670
+	tristate "Infineon SLB9670 TPM Reset Driver"
+	depends on TCG_TIS_SPI
+	help
+	  This enables the reset driver for the Infineon SLB9670 Trusted
+	  Platform Module. Only say Y here if your platform firmware is
+	  incapable of taking the TPM out of reset on boot, requiring the
+	  kernel to do so.
+
 config RESET_SOCFPGA
 	bool "SoCFPGA Reset Driver" if COMPILE_TEST && (!ARM || !ARCH_INTEL_SOCFPGA)
 	default ARM && ARCH_INTEL_SOCFPGA
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 8270da8..d9c182e 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_RESET_RASPBERRYPI) += reset-raspberrypi.o
 obj-$(CONFIG_RESET_RZG2L_USBPHY_CTRL) += reset-rzg2l-usbphy-ctrl.o
 obj-$(CONFIG_RESET_SCMI) += reset-scmi.o
 obj-$(CONFIG_RESET_SIMPLE) += reset-simple.o
+obj-$(CONFIG_RESET_SLB9670) += reset-slb9670.o
 obj-$(CONFIG_RESET_SOCFPGA) += reset-socfpga.o
 obj-$(CONFIG_RESET_SUNPLUS) += reset-sunplus.o
 obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
diff --git a/drivers/reset/reset-slb9670.c b/drivers/reset/reset-slb9670.c
new file mode 100644
index 00000000..cc09ab5
--- /dev/null
+++ b/drivers/reset/reset-slb9670.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Reset driver for Infineon SLB9670 Trusted Platform Module
+ *
+ * Copyright (C) 2022 KUNBUS GmbH
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+
+/*
+ * Time intervals used in the reset sequence:
+ *
+ * RSTIN: minimum time to hold the reset line deasserted
+ * WRST: minimum time to hold the reset line asserted
+ */
+#define SLB9670_TIME_RSTIN	60 /* msecs */
+#define SLB9670_TIME_WRST	2  /* usecs */
+
+struct reset_slb9670 {
+	struct reset_controller_dev rcdev;
+	struct gpio_desc *gpio;
+};
+
+static inline struct reset_slb9670 *
+to_reset_slb9670(struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct reset_slb9670, rcdev);
+}
+
+static int reset_slb9670_assert(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	struct reset_slb9670 *reset_slb9670 = to_reset_slb9670(rcdev);
+
+	gpiod_set_value(reset_slb9670->gpio, 1);
+	return 0;
+}
+
+static int reset_slb9670_deassert(struct reset_controller_dev *rcdev,
+				  unsigned long id)
+{
+	struct reset_slb9670 *reset_slb9670 = to_reset_slb9670(rcdev);
+
+	/*
+	 * Perform the reset sequence: Deassert and assert the reset line twice
+	 * and wait the respective time intervals. After a last wait interval
+	 * of RSTIN the chip is ready to receive the first command.
+	 */
+	gpiod_set_value(reset_slb9670->gpio, 0);
+	msleep(SLB9670_TIME_RSTIN);
+	gpiod_set_value(reset_slb9670->gpio, 1);
+	udelay(SLB9670_TIME_WRST);
+	gpiod_set_value(reset_slb9670->gpio, 0);
+	msleep(SLB9670_TIME_RSTIN);
+	gpiod_set_value(reset_slb9670->gpio, 1);
+	udelay(SLB9670_TIME_WRST);
+	gpiod_set_value(reset_slb9670->gpio, 0);
+	msleep(SLB9670_TIME_RSTIN);
+
+	return 0;
+}
+
+static int reset_slb9670_reset(struct reset_controller_dev *rcdev,
+			       unsigned long id)
+{
+	int ret;
+
+	ret = reset_slb9670_assert(rcdev, id);
+	if (ret)
+		return ret;
+
+	return reset_slb9670_deassert(rcdev, id);
+}
+
+static int reset_slb9670_status(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	struct reset_slb9670 *reset_slb9670 = to_reset_slb9670(rcdev);
+
+	return gpiod_get_value(reset_slb9670->gpio);
+}
+
+static const struct reset_control_ops reset_slb9670_ops = {
+	.assert		= reset_slb9670_assert,
+	.deassert	= reset_slb9670_deassert,
+	.reset		= reset_slb9670_reset,
+	.status		= reset_slb9670_status,
+};
+
+static int reset_slb9670_of_xlate(struct reset_controller_dev *rcdev,
+				  const struct of_phandle_args *reset_spec)
+{
+	return 0;
+}
+
+static int reset_slb9670_probe(struct platform_device *pdev)
+{
+	struct reset_slb9670 *reset_slb9670;
+	struct device *dev = &pdev->dev;
+
+	reset_slb9670 = devm_kzalloc(dev, sizeof(*reset_slb9670), GFP_KERNEL);
+	if (!reset_slb9670)
+		return -ENOMEM;
+
+	reset_slb9670->gpio = devm_gpiod_get(dev, "reset", GPIOD_ASIS);
+	if (IS_ERR(reset_slb9670->gpio))
+		return dev_err_probe(dev, PTR_ERR(reset_slb9670->gpio),
+				     "cannot get reset gpio\n");
+
+	reset_slb9670->rcdev.nr_resets = 1;
+	reset_slb9670->rcdev.owner = THIS_MODULE;
+	reset_slb9670->rcdev.of_node = dev->of_node;
+	reset_slb9670->rcdev.ops = &reset_slb9670_ops;
+	reset_slb9670->rcdev.of_xlate = reset_slb9670_of_xlate;
+	reset_slb9670->rcdev.of_reset_n_cells = 0;
+
+	return devm_reset_controller_register(dev, &reset_slb9670->rcdev);
+}
+
+static const struct of_device_id reset_slb9670_dt_ids[] = {
+	{ .compatible = "infineon,slb9670-reset" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, reset_slb9670_dt_ids);
+
+static struct platform_driver reset_slb9670_driver = {
+	.probe	= reset_slb9670_probe,
+	.driver = {
+		.name		= "reset-slb9670",
+		.of_match_table	= reset_slb9670_dt_ids,
+	},
+};
+module_platform_driver(reset_slb9670_driver);
+
+MODULE_DESCRIPTION("Infineon SLB9670 TPM Reset Driver");
+MODULE_AUTHOR("Lino Sanfilippo <l.sanfilippo@kunbus.com>");
+MODULE_LICENSE("GPL");
-- 
2.40.1

