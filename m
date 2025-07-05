Return-Path: <linux-integrity+bounces-6634-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F845AF9EB4
	for <lists+linux-integrity@lfdr.de>; Sat,  5 Jul 2025 09:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59B6D7B9882
	for <lists+linux-integrity@lfdr.de>; Sat,  5 Jul 2025 07:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706C3273D65;
	Sat,  5 Jul 2025 07:21:55 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A8D28506C;
	Sat,  5 Jul 2025 07:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751700115; cv=none; b=CzZY10EAFVxAj4tWbPPN5sBYIY063S6SwMFdQd1jnZ8nOmlvg1p588YVOZe/vQHrlwZoSPv9KWaFsHd+6dY18++FJhBFGHws/xTNJCUkTBRNvvn2NenosiRmclLTKd1O5DzsMQrB/wHCk1KhKBLbaHi83J7/YTN7sc4mkrK9pqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751700115; c=relaxed/simple;
	bh=tPpwY4R3NBoA6mpE6E9gqgbSxyjJKnoOh/CLppfru98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=byv9LXi/kQP0T0rgHnDSkU/TwoJitDX+RP13v8a/VuP5JCfRdYlnDlYkiSq4nMfO/ukhs7dwlMiy4ZicCESCt5Ea5qogMt+BXVhA/L8msU1DWxnm+njFobM+JQTCjWZwz1c/0lPoJCVGhc/ksWJgCodQ0sfTauVvl6GV5ia8Mk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.54.123])
	by gateway (Coremail) with SMTP id _____8AxquCP0mhoObsiAQ--.34732S3;
	Sat, 05 Jul 2025 15:21:51 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.54.123])
	by front1 (Coremail) with SMTP id qMiowJBxZOSA0mhoElgKAA--.60805S5;
	Sat, 05 Jul 2025 15:21:50 +0800 (CST)
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
Subject: [PATCH v12 3/4] tpm: Add a driver for Loongson TPM device
Date: Sat,  5 Jul 2025 15:20:44 +0800
Message-ID: <20250705072045.1067-4-zhaoqunqin@loongson.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250705072045.1067-1-zhaoqunqin@loongson.cn>
References: <20250705072045.1067-1-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxZOSA0mhoElgKAA--.60805S5
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxWryDtr4rXw4fWr4xtr1xXrc_yoWruFyDpF
	WrCa47Cr45Aw4jkrsxJrWDuFW3Z34fWFWqkay7J34UuFyqy34rXryktFy7Xw17Ars7Gry2
	gFZ5CF48uF1UurXCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
	WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jz5lbUUUUU=

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
index 000000000..a4ec23639
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
+		.name  = "tpm_loongson",
+	},
+};
+module_platform_driver(tpm_loongson);
+
+MODULE_ALIAS("platform:tpm_loongson");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Loongson TPM driver");
-- 
2.45.2


