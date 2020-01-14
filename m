Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0085C13A416
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2020 10:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgANJqI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Jan 2020 04:46:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:41484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729058AbgANJqH (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Jan 2020 04:46:07 -0500
Received: from dogfood.home (amontpellier-657-1-18-247.w109-210.abo.wanadoo.fr [109.210.65.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E2EE24677;
        Tue, 14 Jan 2020 09:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578995167;
        bh=SmiZtzMoexg1Njd+KZhXcW9QojCMA3BUfkuTMPaIhVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kc8EHVA7K5jLbgk13OA8RydKktz1ZY47r2s404QJCOMXU44H6usas3Mc3kg5j3kMK
         PJQIaxHej8TD/jjIHCMyUJ/HAScO7A9prlt7QvhNYzvqhutJl8isslaPIBFtuzPz3p
         J/T9lk9UzqyGyYNKuNBAjpl7mYV4mBOBOsYIFdoE=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     jarkko.sakkinen@linux.intel.com
Cc:     linux-arm-kernel@lists.infradead.org, masahisa.kojima@linaro.org,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 2/2] tpm: tis: add support for MMIO TPM on SynQuacer
Date:   Tue, 14 Jan 2020 10:45:05 +0100
Message-Id: <20200114094505.11855-3-ardb@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200114094505.11855-1-ardb@kernel.org>
References: <20200114094505.11855-1-ardb@kernel.org>
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
 drivers/char/tpm/tpm_tis.c | 31 ++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index e7df342a317d..693e48096035 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -32,6 +32,7 @@
 
 struct tpm_info {
 	struct resource res;
+	const struct tpm_tis_phy_ops *ops;
 	/* irq > 0 means: use irq $irq;
 	 * irq = 0 means: autoprobe for an irq;
 	 * irq = -1 means: no irq support
@@ -186,6 +187,29 @@ static const struct tpm_tis_phy_ops tpm_tcg = {
 	.write32 = tpm_tcg_write32,
 };
 
+static int tpm_tcg_read16_bw(struct tpm_tis_data *data, u32 addr, u16 *result)
+{
+	return tpm_tcg_read_bytes(data, addr, 2, (u8 *)result);
+}
+
+static int tpm_tcg_read32_bw(struct tpm_tis_data *data, u32 addr, u32 *result)
+{
+	return tpm_tcg_read_bytes(data, addr, 4, (u8 *)result);
+}
+
+static int tpm_tcg_write32_bw(struct tpm_tis_data *data, u32 addr, u32 value)
+{
+	return tpm_tcg_write_bytes(data, addr, 4, (u8 *)&value);
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
@@ -210,7 +234,7 @@ static int tpm_tis_init(struct device *dev, struct tpm_info *tpm_info)
 	if (itpm || is_itpm(ACPI_COMPANION(dev)))
 		phy->priv.flags |= TPM_TIS_ITPM_WORKAROUND;
 
-	return tpm_tis_core_init(dev, &phy->priv, irq, &tpm_tcg,
+	return tpm_tis_core_init(dev, &phy->priv, irq, tpm_info->ops,
 				 ACPI_HANDLE(dev));
 }
 
@@ -219,7 +243,7 @@ static SIMPLE_DEV_PM_OPS(tpm_tis_pm, tpm_pm_suspend, tpm_tis_resume);
 static int tpm_tis_pnp_init(struct pnp_dev *pnp_dev,
 			    const struct pnp_device_id *pnp_id)
 {
-	struct tpm_info tpm_info = {};
+	struct tpm_info tpm_info = { .ops = &tpm_tcg };
 	struct resource *res;
 
 	res = pnp_get_resource(pnp_dev, IORESOURCE_MEM, 0);
@@ -295,6 +319,8 @@ static int tpm_tis_plat_probe(struct platform_device *pdev)
 			tpm_info.irq = 0;
 	}
 
+	tpm_info.ops = of_device_get_match_data(&pdev->dev) ?: &tpm_tcg;
+
 	return tpm_tis_init(&pdev->dev, &tpm_info);
 }
 
@@ -311,6 +337,7 @@ static int tpm_tis_plat_remove(struct platform_device *pdev)
 #ifdef CONFIG_OF
 static const struct of_device_id tis_of_platform_match[] = {
 	{.compatible = "tcg,tpm-tis-mmio"},
+	{.compatible = "socionext,synquacer-tpm-mmio", .data = &tpm_tcg_bw},
 	{},
 };
 MODULE_DEVICE_TABLE(of, tis_of_platform_match);
-- 
2.20.1

