Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36DE223759
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Jul 2020 10:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgGQIuS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Jul 2020 04:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgGQIuR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Jul 2020 04:50:17 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE57C061755
        for <linux-integrity@vger.kernel.org>; Fri, 17 Jul 2020 01:50:17 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mn17so6207945pjb.4
        for <linux-integrity@vger.kernel.org>; Fri, 17 Jul 2020 01:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hRI9+M8x3rX5N8lHLXY7VIxGZcILlVx4V1n6t6KTjFI=;
        b=K0ahTUhH2yynvg7PEUDHiPPwSqKFNHsIuyZQFnsKDydtS2+ENT9Gpcg8PqlC4czLKB
         enYbOZiLaphhUtjJJMzdpLNB+kGm6nhaHDY0pkS/rkPBYisHjii54xBmf3xuiaRRRqcw
         HuNvd5wprfgjrC7jPSA0hrAkrTWOgHuWP9RBj+Np03CH4cNkZDIfKSmlcnVMBt0ZDd4L
         2uY/ttoFkc1HCEIZgA4SkrKjvjtFkesO/0YrTAoLp8925vMvVN03xHWSlnfXUmoZbsbU
         Dv48FM4np175PQ7633Iz+ouXAvPZP2nyR02cum4rzvLk8yV1k/7x4/UdCZm0aX6jg5iz
         1mDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hRI9+M8x3rX5N8lHLXY7VIxGZcILlVx4V1n6t6KTjFI=;
        b=pZTjXVaxMG1D8EXLGVNzgvt+XdlE/3yy6pz4lqdB7l0LAZtRzJA7LSmFyXfYaUgOz1
         r0rIowKIPw5ImwRfRyCuEbyZI5PxcI7vkG+ZJCtRjY9WJeJDh/qKffC9bMKXU3DhtE2+
         KzBjzTBM8tMi2qpALw1xATrypmGyBgucdqfKgahd299hPwcBfqFCISshNHwPFc2G/Ndv
         lqXVpygMKGtKPTZ85+0xlF0P5pnwAktAp5xT9zgC8kE/YfYCW1smbJj7Ku1Tk5pdZ5eh
         qZdqq34vxtJGy6/7tkhwSOUa95yMskCpGirmdBc/e2+xpFMmM0VtMRR9nxoP6A/u6bgE
         iJ9w==
X-Gm-Message-State: AOAM530mcpcb8yBoCiRHbTXhl3k/SwdEf8JFKKF+W7JmAkqZG/2u+oZ7
        8Lq2b9YH/YJvW7mmHreQUOHvBT/TXH3abg==
X-Google-Smtp-Source: ABdhPJyJhC3CIG6fAVNhBsSC5cPFoP5iorOF53JMHPmgEw5JRbIraPJhbyxByj8fnTaz4V3iQA2nBA==
X-Received: by 2002:a17:902:eb49:: with SMTP id i9mr6459968pli.231.1594975817050;
        Fri, 17 Jul 2020 01:50:17 -0700 (PDT)
Received: from debian.flets-east.jp ([2400:2411:502:a100:c84b:19e2:9b53:48bb])
        by smtp.gmail.com with ESMTPSA id f207sm7309364pfa.107.2020.07.17.01.50.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jul 2020 01:50:16 -0700 (PDT)
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     masahisa.kojima@linaro.org, jarkko.sakkinen@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, ardb@kernel.org,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca
Subject: [PATCH v4 1/2] tpm: tis: add support for MMIO TPM on SynQuacer
Date:   Fri, 17 Jul 2020 17:49:31 +0900
Message-Id: <20200717084932.3449-2-masahisa.kojima@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200717084932.3449-1-masahisa.kojima@linaro.org>
References: <20200717084932.3449-1-masahisa.kojima@linaro.org>
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
 drivers/char/tpm/tpm_tis_synquacer.c | 209 +++++++++++++++++++++++++++
 3 files changed, 222 insertions(+)
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
index 000000000000..ac2a1d2a5001
--- /dev/null
+++ b/drivers/char/tpm/tpm_tis_synquacer.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Linaro Ltd.
+ *
+ * This device driver implements MMIO TPM on SynQuacer Platform.
+ */
+#include <linux/acpi.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/kernel.h>
+#include "tpm.h"
+#include "tpm_tis_core.h"
+
+struct tpm_tis_synquacer_info {
+	struct resource res;
+	/* irq > 0 means: use irq $irq;
+	 * irq = 0 means: autoprobe for an irq;
+	 * irq = -1 means: no irq support
+	 */
+	int irq;
+};
+
+struct tpm_tis_synquacer_phy {
+	struct tpm_tis_data priv;
+	void __iomem *iobase;
+};
+
+static inline struct tpm_tis_synquacer_phy *to_tpm_tis_tcg_phy(struct tpm_tis_data *data)
+{
+	return container_of(data, struct tpm_tis_synquacer_phy, priv);
+}
+
+static int tpm_tis_synquacer_read_bytes(struct tpm_tis_data *data, u32 addr,
+					u16 len, u8 *result)
+{
+	struct tpm_tis_synquacer_phy *phy = to_tpm_tis_tcg_phy(data);
+
+	while (len--)
+		*result++ = ioread8(phy->iobase + addr);
+
+	return 0;
+}
+
+static int tpm_tis_synquacer_write_bytes(struct tpm_tis_data *data, u32 addr,
+					 u16 len, const u8 *value)
+{
+	struct tpm_tis_synquacer_phy *phy = to_tpm_tis_tcg_phy(data);
+
+	while (len--)
+		iowrite8(*value++, phy->iobase + addr);
+
+	return 0;
+}
+
+static int tpm_tis_synquacer_read16_bw(struct tpm_tis_data *data,
+				       u32 addr, u16 *result)
+{
+	struct tpm_tis_synquacer_phy *phy = to_tpm_tis_tcg_phy(data);
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
+static int tpm_tis_synquacer_read32_bw(struct tpm_tis_data *data,
+				       u32 addr, u32 *result)
+{
+	struct tpm_tis_synquacer_phy *phy = to_tpm_tis_tcg_phy(data);
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
+static int tpm_tis_synquacer_write32_bw(struct tpm_tis_data *data,
+					u32 addr, u32 value)
+{
+	struct tpm_tis_synquacer_phy *phy = to_tpm_tis_tcg_phy(data);
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
+	.read_bytes	= tpm_tis_synquacer_read_bytes,
+	.write_bytes	= tpm_tis_synquacer_write_bytes,
+	.read16		= tpm_tis_synquacer_read16_bw,
+	.read32		= tpm_tis_synquacer_read32_bw,
+	.write32	= tpm_tis_synquacer_write32_bw,
+};
+
+static int tpm_tis_synquacer_init(struct device *dev,
+				  struct tpm_tis_synquacer_info *tpm_info)
+{
+	struct tpm_tis_synquacer_phy *phy;
+
+	phy = devm_kzalloc(dev, sizeof(struct tpm_tis_synquacer_phy), GFP_KERNEL);
+	if (phy == NULL)
+		return -ENOMEM;
+
+	phy->iobase = devm_ioremap_resource(dev, &tpm_info->res);
+	if (IS_ERR(phy->iobase))
+		return PTR_ERR(phy->iobase);
+
+	return tpm_tis_core_init(dev, &phy->priv, tpm_info->irq, &tpm_tcg_bw,
+				 ACPI_HANDLE(dev));
+}
+
+static SIMPLE_DEV_PM_OPS(tpm_tis_synquacer_pm, tpm_pm_suspend, tpm_tis_resume);
+
+static int tpm_tis_synquacer_probe(struct platform_device *pdev)
+{
+	struct tpm_tis_synquacer_info tpm_info = {};
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
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id tpm_synquacer_acpi_tbl[] = {
+	{ "SCX0009" },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, tpm_synquacer_acpi_tbl);
+#endif
+
+static struct platform_driver tis_synquacer_drv = {
+	.probe = tpm_tis_synquacer_probe,
+	.remove = tpm_tis_synquacer_remove,
+	.driver = {
+		.name		= "tpm_tis_synquacer",
+		.pm		= &tpm_tis_synquacer_pm,
+		.of_match_table = of_match_ptr(tis_synquacer_of_platform_match),
+		.acpi_match_table = ACPI_PTR(tpm_synquacer_acpi_tbl),
+	},
+};
+
+static int __init tpm_tis_synquacer_module_init(void)
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
+static void __exit tpm_tis_synquacer_module_exit(void)
+{
+	platform_driver_unregister(&tis_synquacer_drv);
+}
+
+module_init(tpm_tis_synquacer_module_init);
+module_exit(tpm_tis_synquacer_module_exit);
+MODULE_AUTHOR("Masahisa Kojima (masahisa.kojima@linaro.org)");
+MODULE_DESCRIPTION("TPM MMIO Driver for Socionext SynQuacer platform");
+MODULE_VERSION("2.0");
+MODULE_LICENSE("GPL");
-- 
2.20.1

