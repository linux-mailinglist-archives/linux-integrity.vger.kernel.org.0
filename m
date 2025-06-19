Return-Path: <linux-integrity+bounces-6476-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B63ADFB80
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Jun 2025 04:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C35BF1BC1533
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Jun 2025 02:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8592622488B;
	Thu, 19 Jun 2025 02:52:58 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0C422686F;
	Thu, 19 Jun 2025 02:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750301578; cv=none; b=FxvO7jWi/6s0seoC/YYUwJeP3vzCILXL+35z1VahR54rlA18LX91y9e5+3n6OH7G1g80oEqFXUBFk99S1FpxD1PNKPASE/IIpK4qDaqjJJB6bKb1IrmMNE8vgiasmq0mxnFIBzocCeGBzMoaF7iN4Q4X9Coba4/PG/i5ST/MLhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750301578; c=relaxed/simple;
	bh=Q71hmn1POyymOjzwHRDvDm1L+AVvl8ERwiQQhtFcgOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aNoF/FpPQ3XQHXTooC0OmUvMgWMtp+NUIE0z5/A41OjYTRVGbmE64WHb3Jop8PmBih+MxMtYshP5QqwTwf0eC61KSsdQHhWXvosmA3g0LDO13AEApz4jYd/LLOdCtXsN7SRbeJe+gqfCslbZ9cw5Di51I+fiIPtCeTtYNL2UBEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.54.180])
	by gateway (Coremail) with SMTP id _____8BxnnN8e1Noxo0ZAQ--.22889S3;
	Thu, 19 Jun 2025 10:52:44 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.54.180])
	by front1 (Coremail) with SMTP id qMiowMAxj8VPe1NoOXYgAQ--.34847S5;
	Thu, 19 Jun 2025 10:52:30 +0800 (CST)
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
To: lee@kernel.org,
	herbert@gondor.apana.org.au,
	jarkko@kernel.org
Cc: linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	davem@davemloft.net,
	linux-crypto@vger.kernel.org,
	peterhuewe@gmx.de,
	jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	Qunqin Zhao <zhaoqunqin@loongson.cn>,
	Yinggang Gu <guyinggang@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH v11 3/4] tpm: Add a driver for Loongson TPM device
Date: Thu, 19 Jun 2025 10:51:37 +0800
Message-ID: <20250619025138.2854-4-zhaoqunqin@loongson.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250619025138.2854-1-zhaoqunqin@loongson.cn>
References: <20250619025138.2854-1-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMAxj8VPe1NoOXYgAQ--.34847S5
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxWryDtr4rXw4fWr4xtr1xXrc_yoWruFyDpF
	WrCa47Cr45Aw4jkrsxJrWDuFW3Z34fWFWqkay7J34UuFyqy34rXrykGFy7Xw17Ars7Gry2
	gFZ5CF48uF1UurXCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8_gA5UUUUU==

Loongson Security Engine supports random number generation, hash,
symmetric encryption and asymmetric encryption. Based on these
encryption functions, TPM2 have been implemented in the Loongson
Security Engine firmware. This driver is responsible for copying data
into the memory visible to the firmware and receiving data from the
firmware.

Co-developed-by: Yinggang Gu <guyinggang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/char/tpm/Kconfig        |  9 ++++
 drivers/char/tpm/Makefile       |  1 +
 drivers/char/tpm/tpm_loongson.c | 84 +++++++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+)
 create mode 100644 drivers/char/tpm/tpm_loongson.c

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index dddd702b2..ba3924eb1 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -189,6 +189,15 @@ config TCG_IBMVTPM
 	  will be accessible from within Linux.  To compile this driver
 	  as a module, choose M here; the module will be called tpm_ibmvtpm.
 
+config TCG_LOONGSON
+	tristate "Loongson TPM Interface"
+	depends on MFD_LOONGSON_SE
+	help
+	  If you want to make Loongson TPM support available, say Yes and
+	  it will be accessible from within Linux. To compile this
+	  driver as a module, choose M here; the module will be called
+	  tpm_loongson.
+
 config TCG_XEN
 	tristate "XEN TPM Interface"
 	depends on TCG_TPM && XEN
diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
index 9de1b3ea3..5b5cdc0d3 100644
--- a/drivers/char/tpm/Makefile
+++ b/drivers/char/tpm/Makefile
@@ -46,3 +46,4 @@ obj-$(CONFIG_TCG_ARM_CRB_FFA) += tpm_crb_ffa.o
 obj-$(CONFIG_TCG_VTPM_PROXY) += tpm_vtpm_proxy.o
 obj-$(CONFIG_TCG_FTPM_TEE) += tpm_ftpm_tee.o
 obj-$(CONFIG_TCG_SVSM) += tpm_svsm.o
+obj-$(CONFIG_TCG_LOONGSON) += tpm_loongson.o
diff --git a/drivers/char/tpm/tpm_loongson.c b/drivers/char/tpm/tpm_loongson.c
new file mode 100644
index 000000000..5cbdb37f8
--- /dev/null
+++ b/drivers/char/tpm/tpm_loongson.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Loongson Technology Corporation Limited. */
+
+#include <linux/device.h>
+#include <linux/mfd/loongson-se.h>
+#include <linux/platform_device.h>
+#include <linux/wait.h>
+
+#include "tpm.h"
+
+struct tpm_loongson_cmd {
+	u32 cmd_id;
+	u32 data_off;
+	u32 data_len;
+	u32 pad[5];
+};
+
+static int tpm_loongson_recv(struct tpm_chip *chip, u8 *buf, size_t count)
+{
+	struct loongson_se_engine *tpm_engine = dev_get_drvdata(&chip->dev);
+	struct tpm_loongson_cmd *cmd_ret = tpm_engine->command_ret;
+
+	if (cmd_ret->data_len > count)
+		return -EIO;
+
+	memcpy(buf, tpm_engine->data_buffer, cmd_ret->data_len);
+
+	return cmd_ret->data_len;
+}
+
+static int tpm_loongson_send(struct tpm_chip *chip, u8 *buf, size_t count)
+{
+	struct loongson_se_engine *tpm_engine = dev_get_drvdata(&chip->dev);
+	struct tpm_loongson_cmd *cmd = tpm_engine->command;
+
+	if (count > tpm_engine->buffer_size)
+		return -E2BIG;
+
+	cmd->data_len = count;
+	memcpy(tpm_engine->data_buffer, buf, count);
+
+	return loongson_se_send_engine_cmd(tpm_engine);
+}
+
+static const struct tpm_class_ops tpm_loongson_ops = {
+	.flags = TPM_OPS_AUTO_STARTUP,
+	.recv = tpm_loongson_recv,
+	.send = tpm_loongson_send,
+};
+
+static int tpm_loongson_probe(struct platform_device *pdev)
+{
+	struct loongson_se_engine *tpm_engine;
+	struct device *dev = &pdev->dev;
+	struct tpm_loongson_cmd *cmd;
+	struct tpm_chip *chip;
+
+	tpm_engine = loongson_se_init_engine(dev->parent, SE_ENGINE_TPM);
+	if (!tpm_engine)
+		return -ENODEV;
+	cmd = tpm_engine->command;
+	cmd->cmd_id = SE_CMD_TPM;
+	cmd->data_off = tpm_engine->buffer_off;
+
+	chip = tpmm_chip_alloc(dev, &tpm_loongson_ops);
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	chip->flags = TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_IRQ;
+	dev_set_drvdata(&chip->dev, tpm_engine);
+
+	return tpm_chip_register(chip);
+}
+
+static struct platform_driver tpm_loongson = {
+	.probe   = tpm_loongson_probe,
+	.driver  = {
+		.name  = "loongson-tpm",
+	},
+};
+module_platform_driver(tpm_loongson);
+
+MODULE_ALIAS("platform:loongson-tpm");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Loongson TPM driver");
-- 
2.45.2


