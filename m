Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7242188B1
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Jul 2020 15:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729434AbgGHNPZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Jul 2020 09:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729413AbgGHNPZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Jul 2020 09:15:25 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAD8C08C5DC
        for <linux-integrity@vger.kernel.org>; Wed,  8 Jul 2020 06:15:25 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id p3so21658103pgh.3
        for <linux-integrity@vger.kernel.org>; Wed, 08 Jul 2020 06:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xeH6T0xnzW7jFBhFc0hgdvqYTZU942iahhJCQgsP6LI=;
        b=f3XM/bklDRHyh0jy9YOqLyIbbuDKBYLnr2E0gAbFagx8W98n2v9PhOLaEJjKs0zAbv
         I65JFuaNwWJXKh+8I9BJNN5r5ISCUxQJ47Gx4bC4jhyayyOKvbEU6bwyXlvmof3by78m
         xnYlbSg2l0oD/4hvCXZ+62boL1Tan34ZWIVDuxc1Du66YvmgigTPoKMUTlgqxIYnP38P
         PJQTw7Dz3fHvoMzc3+vAvdTxq0ZW70dWQGeQ9+FoblFV23A74Pfc3eNI8ezgBH0SIN37
         KsvNzj4eO1qCNvVLARdw9ikchN4/Kbsv3EwMBYUENuRjOcZVXn3FUKdXyh36NYZON/z7
         fOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xeH6T0xnzW7jFBhFc0hgdvqYTZU942iahhJCQgsP6LI=;
        b=Uc/Um0a+e3R+UqGMWbTG6CKSDLytbtj4YGWS5ZMm1RpEH5p1CKWAXSgM3zdA6SFXBt
         eHTiEChdSLW8JlCueGR/fyc/KwMpulZ7s6SWf+19vLoVnfTSvMamFS+d1MS3KPKs14kU
         vrYzKKw114qMVT5e+xGGM90anhGucLiHzqUSLptiTb423U/rtcXHp5XS/QPAYBnn9JeP
         NqvB2U1qLLPpUp3IHNNEqv0cerPBdFeOb7Qbnz2Pk2dubtzqjfrK8J6+DwfXAXIDmsXR
         Jotzom1byelCQs6/tRCI9dBJcIv0x1RrAnvv8LPi4B9C0cVSp4bHmxW5m+HKWjP4RJLW
         YXew==
X-Gm-Message-State: AOAM531MATjgk3hhJC+YIbhieY3KKLVanqU8UOTTuPgWSmokhrjM5dF6
        tqkEceNMcCEkx/v6Eli5RbjCmQ==
X-Google-Smtp-Source: ABdhPJxfXU930uaRwT098kELAmtJZl0Hguk0ooGKImAuHhy6P2vyi5V03PKTOloOtFQ1Vb+W9DMHOg==
X-Received: by 2002:a05:6a00:845:: with SMTP id q5mr38208443pfk.247.1594214124566;
        Wed, 08 Jul 2020 06:15:24 -0700 (PDT)
Received: from debian.flets-east.jp ([2400:2411:502:a100:c84b:19e2:9b53:48bb])
        by smtp.gmail.com with ESMTPSA id y63sm4096366pgb.49.2020.07.08.06.15.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2020 06:15:23 -0700 (PDT)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     masahisa.kojima@linaro.org, jarkko.sakkinen@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca
Subject: [PATCH v3 1/2] tpm: tis: add support for MMIO TPM on SynQuacer
Date:   Wed,  8 Jul 2020 22:14:23 +0900
Message-Id: <20200708131424.18729-2-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200708131424.18729-1-masahisa.kojima@linaro.org>
References: <20200708131424.18729-1-masahisa.kojima@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When fitted, the SynQuacer platform exposes its SPI TPM via a MMIO
window that is backed by the SPI command sequencer in the SPI bus
controller. This arrangement has the limitation that only byte size
accesses are supported, and so we'll need to provide a separate module
that take this into account.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
---
 drivers/char/tpm/Kconfig             |  12 ++
 drivers/char/tpm/Makefile            |   1 +
 drivers/char/tpm/tpm_tis_synquacer.c | 196 +++++++++++++++++++++++++++
 3 files changed, 209 insertions(+)
 create mode 100644 drivers/char/tpm/tpm_tis_synquacer.c

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 58b4c573d176..a18c314da211 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -74,6 +74,18 @@ config TCG_TIS_SPI_CR50
 	  If you have a H1 secure module running Cr50 firmware on SPI bus,
 	  say Yes and it will be accessible from within Linux.
 
+config TCG_TIS_SYNQUACER
+	tristate "TPM Interface Specification 1.2 Interface / TPM 2.0 FIFO Interface (MMIO - SynQuacer)"
+	depends on ARCH_SYNQUACER
+	select TCG_TIS_CORE
+	help
+	  If you have a TPM security chip that is compliant with the
+	  TCG TIS 1.2 TPM specification (TPM1.2) or the TCG PTP FIFO
+	  specification (TPM2.0) say Yes and it will be accessible from
+	  within Linux on Socionext SynQuacer platform.
+	  To compile this driver as a module, choose  M here;
+	  the module will be called tpm_tis_synquacer.
+
 config TCG_TIS_I2C_ATMEL
 	tristate "TPM Interface Specification 1.2 Interface (I2C - Atmel)"
 	depends on I2C
diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
index 9567e5197f74..84db4fb3a9c9 100644
--- a/drivers/char/tpm/Makefile
+++ b/drivers/char/tpm/Makefile
@@ -21,6 +21,7 @@ tpm-$(CONFIG_EFI) += eventlog/efi.o
 tpm-$(CONFIG_OF) += eventlog/of.o
 obj-$(CONFIG_TCG_TIS_CORE) += tpm_tis_core.o
 obj-$(CONFIG_TCG_TIS) += tpm_tis.o
+obj-$(CONFIG_TCG_TIS_SYNQUACER) += tpm_tis_synquacer.o
 
 obj-$(CONFIG_TCG_TIS_SPI) += tpm_tis_spi.o
 tpm_tis_spi-y := tpm_tis_spi_main.o
diff --git a/drivers/char/tpm/tpm_tis_synquacer.c b/drivers/char/tpm/tpm_tis_synquacer.c
new file mode 100644
index 000000000000..51f0aedcedcc
--- /dev/null
+++ b/drivers/char/tpm/tpm_tis_synquacer.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Linaro Ltd.
+ *
+ * This device driver implements MMIO TPM on SynQuacer Platform.
+ */
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/kernel.h>
+#include "tpm.h"
+#include "tpm_tis_core.h"
+
+struct tpm_info {
+	struct resource res;
+	/* irq > 0 means: use irq $irq;
+	 * irq = 0 means: autoprobe for an irq;
+	 * irq = -1 means: no irq support
+	 */
+	int irq;
+};
+
+struct tpm_tis_tcg_phy {
+	struct tpm_tis_data priv;
+	void __iomem *iobase;
+};
+
+static inline struct tpm_tis_tcg_phy *to_tpm_tis_tcg_phy(struct tpm_tis_data *data)
+{
+	return container_of(data, struct tpm_tis_tcg_phy, priv);
+}
+
+static int tpm_tcg_read_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
+			      u8 *result)
+{
+	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
+
+	while (len--)
+		*result++ = ioread8(phy->iobase + addr);
+
+	return 0;
+}
+
+static int tpm_tcg_write_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
+			       const u8 *value)
+{
+	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
+
+	while (len--)
+		iowrite8(*value++, phy->iobase + addr);
+
+	return 0;
+}
+
+static int tpm_tcg_read16_bw(struct tpm_tis_data *data, u32 addr, u16 *result)
+{
+	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
+
+	/*
+	 * Due to the limitation of SPI controller on SynQuacer,
+	 * 16/32 bits access must be done in byte-wise and descending order.
+	 */
+	*result = (ioread8(phy->iobase + addr + 1) << 8) |
+		  (ioread8(phy->iobase + addr));
+
+	return 0;
+}
+
+static int tpm_tcg_read32_bw(struct tpm_tis_data *data, u32 addr, u32 *result)
+{
+	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
+
+	/*
+	 * Due to the limitation of SPI controller on SynQuacer,
+	 * 16/32 bits access must be done in byte-wise and descending order.
+	 */
+	*result = (ioread8(phy->iobase + addr + 3) << 24) |
+		  (ioread8(phy->iobase + addr + 2) << 16) |
+		  (ioread8(phy->iobase + addr + 1) << 8) |
+		  (ioread8(phy->iobase + addr));
+
+	return 0;
+}
+
+static int tpm_tcg_write32_bw(struct tpm_tis_data *data, u32 addr, u32 value)
+{
+	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
+
+	/*
+	 * Due to the limitation of SPI controller on SynQuacer,
+	 * 16/32 bits access must be done in byte-wise and descending order.
+	 */
+	iowrite8(value >> 24, phy->iobase + addr + 3);
+	iowrite8(value >> 16, phy->iobase + addr + 2);
+	iowrite8(value >> 8, phy->iobase + addr + 1);
+	iowrite8(value, phy->iobase + addr);
+
+	return 0;
+}
+
+static const struct tpm_tis_phy_ops tpm_tcg_bw = {
+	.read_bytes	= tpm_tcg_read_bytes,
+	.write_bytes	= tpm_tcg_write_bytes,
+	.read16		= tpm_tcg_read16_bw,
+	.read32		= tpm_tcg_read32_bw,
+	.write32	= tpm_tcg_write32_bw,
+};
+
+static int tpm_tis_synquacer_init(struct device *dev, struct tpm_info *tpm_info)
+{
+	struct tpm_tis_tcg_phy *phy;
+	int irq = -1;
+
+	phy = devm_kzalloc(dev, sizeof(struct tpm_tis_tcg_phy), GFP_KERNEL);
+	if (phy == NULL)
+		return -ENOMEM;
+
+	phy->iobase = devm_ioremap_resource(dev, &tpm_info->res);
+	if (IS_ERR(phy->iobase))
+		return PTR_ERR(phy->iobase);
+
+	return tpm_tis_core_init(dev, &phy->priv, irq, &tpm_tcg_bw,
+				 ACPI_HANDLE(dev));
+}
+
+static SIMPLE_DEV_PM_OPS(tpm_tis_synquacer_pm, tpm_pm_suspend, tpm_tis_resume);
+
+static int tpm_tis_synquacer_probe(struct platform_device *pdev)
+{
+	struct tpm_info tpm_info = {};
+	struct resource *res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res == NULL) {
+		dev_err(&pdev->dev, "no memory resource defined\n");
+		return -ENODEV;
+	}
+	tpm_info.res = *res;
+
+	tpm_info.irq = -1;
+
+	return tpm_tis_synquacer_init(&pdev->dev, &tpm_info);
+}
+
+static int tpm_tis_synquacer_remove(struct platform_device *pdev)
+{
+	struct tpm_chip *chip = dev_get_drvdata(&pdev->dev);
+
+	tpm_chip_unregister(chip);
+	tpm_tis_remove(chip);
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id tis_synquacer_of_platform_match[] = {
+	{.compatible = "socionext,synquacer-tpm-mmio"},
+	{},
+};
+MODULE_DEVICE_TABLE(of, tis_synquacer_of_platform_match);
+#endif
+
+static struct platform_driver tis_synquacer_drv = {
+	.probe = tpm_tis_synquacer_probe,
+	.remove = tpm_tis_synquacer_remove,
+	.driver = {
+		.name		= "tpm_tis_synquacer",
+		.pm		= &tpm_tis_synquacer_pm,
+		.of_match_table = of_match_ptr(tis_synquacer_of_platform_match),
+	},
+};
+
+static int __init init_tis_synquacer(void)
+{
+	int rc;
+
+	rc = platform_driver_register(&tis_synquacer_drv);
+	if (rc)
+		return rc;
+
+	return 0;
+}
+
+static void __exit cleanup_tis_synquacer(void)
+{
+	platform_driver_unregister(&tis_synquacer_drv);
+}
+
+module_init(init_tis_synquacer);
+module_exit(cleanup_tis_synquacer);
+MODULE_AUTHOR("Masahisa Kojima (masahisa.kojima@linaro.org)");
+MODULE_DESCRIPTION("TPM MMIO Driver for Socionext SynQuacer platform");
+MODULE_VERSION("2.0");
+MODULE_LICENSE("GPL");
-- 
2.20.1

