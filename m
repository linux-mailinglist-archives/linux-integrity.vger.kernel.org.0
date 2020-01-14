Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13A6513AC13
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2020 15:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbgANORJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Jan 2020 09:17:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:33988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725994AbgANORI (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Jan 2020 09:17:08 -0500
Received: from localhost.localdomain (aaubervilliers-681-1-7-206.w90-88.abo.wanadoo.fr [90.88.129.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56EB92468B;
        Tue, 14 Jan 2020 14:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579011428;
        bh=aXlNmzU3c4DebfOZqxQIuf2kGpmEOcf7xtmQHre7OJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y283MTURx/bz6qeJVYlyRxufy4OQzwRT+/RKaZbTkKKPRx9KkNxYxa38ldJI0MKTo
         PhpPPic7On2n9h6QQ9BLKYRT/QN22QiLOMPlfe3cz/ABncAt3LpdvnQjdQ8vGtIQ6W
         BwiFPQdK6rxTp6N2ALcE9tN9FEp57I+DthIxGnt4=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, jarkko.sakkinen@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, masahisa.kojima@linaro.org,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca
Subject: [PATCH v2 2/2] tpm: tis: add support for MMIO TPM on SynQuacer
Date:   Tue, 14 Jan 2020 15:16:47 +0100
Message-Id: <20200114141647.109347-3-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200114141647.109347-1-ardb@kernel.org>
References: <20200114141647.109347-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When fitted, the SynQuacer platform exposes its SPI TPM via a MMIO
window that is backed by the SPI command sequencer in the SPI bus
controller. This arrangement has the limitation that only byte size
accesses are supported, and so we'll need to provide a separate set
of read and write accessors that take this into account.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/char/tpm/tpm_tis.c | 50 +++++++++++++++++++-
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index e7df342a317d..2466295fcfe8 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -32,6 +32,7 @@
 
 struct tpm_info {
 	struct resource res;
+	const struct tpm_tis_phy_ops *ops;
 	/* irq > 0 means: use irq $irq;
 	 * irq = 0 means: autoprobe for an irq;
 	 * irq = -1 means: no irq support
@@ -186,6 +187,48 @@ static const struct tpm_tis_phy_ops tpm_tcg = {
 	.write32 = tpm_tcg_write32,
 };
 
+static int tpm_tcg_read16_bw(struct tpm_tis_data *data, u32 addr, u16 *result)
+{
+	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
+
+	*result = (ioread8(phy->iobase + addr)) |
+		  (ioread8(phy->iobase + addr + 1) << 8);
+
+	return 0;
+}
+
+static int tpm_tcg_read32_bw(struct tpm_tis_data *data, u32 addr, u32 *result)
+{
+	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
+
+	*result = (ioread8(phy->iobase + addr)) |
+		  (ioread8(phy->iobase + addr + 1) << 8) |
+		  (ioread8(phy->iobase + addr + 2) << 16) |
+		  (ioread8(phy->iobase + addr + 3) << 24);
+
+	return 0;
+}
+
+static int tpm_tcg_write32_bw(struct tpm_tis_data *data, u32 addr, u32 value)
+{
+	struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
+
+	iowrite8(value, phy->iobase + addr);
+	iowrite8(value >> 8, phy->iobase + addr + 1);
+	iowrite8(value >> 16, phy->iobase + addr + 2);
+	iowrite8(value >> 24, phy->iobase + addr + 3);
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
 static int tpm_tis_init(struct device *dev, struct tpm_info *tpm_info)
 {
 	struct tpm_tis_tcg_phy *phy;
@@ -210,7 +253,7 @@ static int tpm_tis_init(struct device *dev, struct tpm_info *tpm_info)
 	if (itpm || is_itpm(ACPI_COMPANION(dev)))
 		phy->priv.flags |= TPM_TIS_ITPM_WORKAROUND;
 
-	return tpm_tis_core_init(dev, &phy->priv, irq, &tpm_tcg,
+	return tpm_tis_core_init(dev, &phy->priv, irq, tpm_info->ops,
 				 ACPI_HANDLE(dev));
 }
 
@@ -219,7 +262,7 @@ static SIMPLE_DEV_PM_OPS(tpm_tis_pm, tpm_pm_suspend, tpm_tis_resume);
 static int tpm_tis_pnp_init(struct pnp_dev *pnp_dev,
 			    const struct pnp_device_id *pnp_id)
 {
-	struct tpm_info tpm_info = {};
+	struct tpm_info tpm_info = { .ops = &tpm_tcg };
 	struct resource *res;
 
 	res = pnp_get_resource(pnp_dev, IORESOURCE_MEM, 0);
@@ -295,6 +338,8 @@ static int tpm_tis_plat_probe(struct platform_device *pdev)
 			tpm_info.irq = 0;
 	}
 
+	tpm_info.ops = of_device_get_match_data(&pdev->dev) ?: &tpm_tcg;
+
 	return tpm_tis_init(&pdev->dev, &tpm_info);
 }
 
@@ -311,6 +356,7 @@ static int tpm_tis_plat_remove(struct platform_device *pdev)
 #ifdef CONFIG_OF
 static const struct of_device_id tis_of_platform_match[] = {
 	{.compatible = "tcg,tpm-tis-mmio"},
+	{.compatible = "socionext,synquacer-tpm-mmio", .data = &tpm_tcg_bw},
 	{},
 };
 MODULE_DEVICE_TABLE(of, tis_of_platform_match);
-- 
2.20.1

