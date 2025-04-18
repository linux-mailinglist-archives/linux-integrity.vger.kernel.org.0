Return-Path: <linux-integrity+bounces-5932-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC231A93551
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Apr 2025 11:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A2C04A0ABC
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Apr 2025 09:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA08270EB7;
	Fri, 18 Apr 2025 09:32:48 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4612B2DA;
	Fri, 18 Apr 2025 09:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744968768; cv=none; b=B9+a8hHmrTB0O4BeB54BgOUvD6C0uikh6sTVmPjWsTaiey0ApsqPvgh1OkfX5OfMp0bkKuMLI4+3WBycVSoD1T2ulJDsUoegx1r8sT4B6YS+/WoPa0kx2vxNt33Z3Aldw7Do5UAXYPogGLea80ruIpfO//SlJV+qoD36ww3kIgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744968768; c=relaxed/simple;
	bh=niZeXECRt3cpT8S8YnZcskec3qoU1R1+kbkBQO/iSWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ocj7yw0/fLq1Fqt3/UuSMki2iQYyhB0E+JA9Anl15gJVbcQXZ3Bd09UbWhLoNxMPOYKSfcIZwzTRRbb+irswBMtC9uwubb8bojfkwhi0xnL5Tf9exfqdrCYfVqIH3w5iUQui2YeK6nKvaad7746ocVuzy/1gHqhD/mRmdXZ7i7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.54.180])
	by gateway (Coremail) with SMTP id _____8Bx63E2HAJoO6LBAA--.58476S3;
	Fri, 18 Apr 2025 17:32:38 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.54.180])
	by front1 (Coremail) with SMTP id qMiowMCx_cYsHAJoGUKJAA--.15831S3;
	Fri, 18 Apr 2025 17:32:31 +0800 (CST)
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	peterhuewe@gmx.de,
	jarkko@kernel.org
Cc: linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-crypto@vger.kernel.org,
	jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	pmenzel@molgen.mpg.de,
	Qunqin Zhao <zhaoqunqin@loongson.cn>,
	Yinggang Gu <guyinggang@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH v8 1/5] crypto: loongson - Add Loongson Security Engine chip controller driver
Date: Fri, 18 Apr 2025 17:34:03 +0800
Message-ID: <20250418093407.1335-2-zhaoqunqin@loongson.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250418093407.1335-1-zhaoqunqin@loongson.cn>
References: <20250418093407.1335-1-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCx_cYsHAJoGUKJAA--.15831S3
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW3KrWrGw48KFW7Xr48Xr4rtFc_yoWktr18pF
	45C3y5Cr4UXF47Cws3JrZ8uF4av3savr9Fka9rXw18CF9rJ348WrWYkFyUWFZ3ZrWDXry7
	XFWkGF48CF18G3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1a6r1DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5
	McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFwIDUUUUU

Loongson Security Engine chip supports RNG, SM2, SM3 and SM4 accelerator
engines. This is the base driver for other specific engine drivers.

Co-developed-by: Yinggang Gu <guyinggang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
---
v8: As explained in the cover letter, moved this driver form MFD to here.
    Cleanned up coding style. Added some comments. Divided DMA memory
    equally among all engines.

v7: Moved Kconfig entry between MFD_INTEL_M10_BMC_PMCI and MFD_QNAP_MCU.

    Renamed se_enable_int_locked() to se_enable_int(), then moved the
    lock out of se_disable_int().
    
    "se_send_genl_cmd" ---> "se_send_cmd".
    "struct lsse_ch" ---> "struct se_channel".

v6: Replace all "ls6000se" with "loongson"
v5: Registered "ls6000se-rng" device.
v3-v4: None

 drivers/crypto/Kconfig                |   1 +
 drivers/crypto/Makefile               |   1 +
 drivers/crypto/loongson/Kconfig       |  11 ++
 drivers/crypto/loongson/Makefile      |   2 +
 drivers/crypto/loongson/loongson-se.c | 239 ++++++++++++++++++++++++++
 drivers/crypto/loongson/loongson-se.h |  52 ++++++
 6 files changed, 306 insertions(+)
 create mode 100644 drivers/crypto/loongson/Kconfig
 create mode 100644 drivers/crypto/loongson/Makefile
 create mode 100644 drivers/crypto/loongson/loongson-se.c
 create mode 100644 drivers/crypto/loongson/loongson-se.h

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 470827820..371a2bd58 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -833,6 +833,7 @@ config CRYPTO_DEV_CCREE
 	  If unsure say Y.
 
 source "drivers/crypto/hisilicon/Kconfig"
+source "drivers/crypto/loongson/Kconfig"
 
 source "drivers/crypto/amlogic/Kconfig"
 
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index c97f0ebc5..479875e6c 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -50,3 +50,4 @@ obj-y += hisilicon/
 obj-$(CONFIG_CRYPTO_DEV_AMLOGIC_GXL) += amlogic/
 obj-y += intel/
 obj-y += starfive/
+obj-y += loongson/
diff --git a/drivers/crypto/loongson/Kconfig b/drivers/crypto/loongson/Kconfig
new file mode 100644
index 000000000..9fdcc73bc
--- /dev/null
+++ b/drivers/crypto/loongson/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+config CRYPTO_DEV_LOONGSON_SE
+	tristate "Loongson Security Engine chip controller driver"
+	depends on LOONGARCH && ACPI
+	select MFD_CORE
+	help
+	  The Loongson Security Engine chip supports RNG, SM2, SM3 and
+	  SM4 accelerator engines. Each engine have its own DMA buffer
+	  provided by the controller. The kernel cannot directly send
+	  commands to the engine and must first send them to the controller,
+	  which will forward them to the corresponding engine.
diff --git a/drivers/crypto/loongson/Makefile b/drivers/crypto/loongson/Makefile
new file mode 100644
index 000000000..5ebcd9ff8
--- /dev/null
+++ b/drivers/crypto/loongson/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_CRYPTO_DEV_LOONGSON_SE)	+= loongson-se.o
diff --git a/drivers/crypto/loongson/loongson-se.c b/drivers/crypto/loongson/loongson-se.c
new file mode 100644
index 000000000..aad0f2d79
--- /dev/null
+++ b/drivers/crypto/loongson/loongson-se.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (C) 2025 Loongson Technology Corporation Limited */
+
+#include <linux/acpi.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/mfd/core.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include "loongson-se.h"
+
+struct loongson_se {
+	void __iomem *base;
+	spinlock_t dev_lock;
+	struct completion cmd_completion;
+
+	void *dmam_base;
+	int dmam_size;
+
+	struct mutex engine_init_lock;
+	struct loongson_se_engine engines[SE_ENGINE_MAX];
+};
+
+struct loongson_se_controller_cmd {
+	u32 command_id;
+	u32 info[7];
+};
+
+static int loongson_se_poll(struct loongson_se *se, u32 int_bit)
+{
+	u32 status;
+	int err;
+
+	spin_lock_irq(&se->dev_lock);
+
+	/* Notify the controller that the engine needs to be started */
+	writel(int_bit, se->base + SE_L2SINT_SET);
+	/* Polling until the controller has forwarded the engine command */
+	err = readl_relaxed_poll_timeout_atomic(se->base + SE_L2SINT_STAT, status,
+						!(status & int_bit), 1, 10000);
+
+	spin_unlock_irq(&se->dev_lock);
+
+	return err;
+}
+
+static int loongson_se_send_controller_cmd(struct loongson_se *se,
+					   struct loongson_se_controller_cmd *cmd)
+{
+	u32 *send_cmd = (u32 *)cmd;
+	int err, i;
+
+	for (i = 0; i < SE_SEND_CMD_REG_LEN; i++)
+		writel(send_cmd[i], se->base + SE_SEND_CMD_REG + i * 4);
+
+	err = loongson_se_poll(se, SE_INT_CONTROLLER);
+	if (err)
+		return err;
+
+	return wait_for_completion_interruptible(&se->cmd_completion);
+}
+
+int loongson_se_send_engine_cmd(struct loongson_se_engine *engine)
+{
+	/* After engine initialization, the controller already knows
+	 * where to obtain engine commands from. Now all we need to
+	 * do is notify the controller that the engine needs to be started.
+	 */
+	int err = loongson_se_poll(engine->se, BIT(engine->id));
+
+	if (err)
+		return err;
+
+	return wait_for_completion_interruptible(&engine->completion);
+}
+EXPORT_SYMBOL_GPL(loongson_se_send_engine_cmd);
+
+struct loongson_se_engine *loongson_se_init_engine(struct device *dev, int id)
+{
+	struct loongson_se *se = dev_get_drvdata(dev);
+	struct loongson_se_engine *engine = &se->engines[id];
+	struct loongson_se_controller_cmd cmd;
+
+	engine->se = se;
+	engine->id = id;
+	init_completion(&engine->completion);
+
+	/* Divide DMA memory equally among all engines */
+	engine->buffer_size = se->dmam_size / SE_ENGINE_MAX;
+	engine->buffer_off = (se->dmam_size / SE_ENGINE_MAX) * id;
+	engine->data_buffer = se->dmam_base + engine->buffer_off;
+
+	/*
+	 * There has no engine0, use its data buffer as command buffer for other
+	 * engines. The DMA memory size is obtained from the ACPI table, which
+	 * ensures that the data buffer size of engine0 is larger than the
+	 * command buffer size of all engines.
+	 */
+	engine->command = se->dmam_base + id * (2 * SE_ENGINE_CMD_SIZE);
+	engine->command_ret = engine->command + SE_ENGINE_CMD_SIZE;
+
+	mutex_lock(&se->engine_init_lock);
+	/* Tell the controller where to find engine command */
+	cmd.command_id = SE_CMD_SET_ENGINE_CMDBUF;
+	cmd.info[0] = id;
+	cmd.info[1] = engine->command - se->dmam_base;
+	cmd.info[2] = 2 * SE_ENGINE_CMD_SIZE;
+	if (loongson_se_send_controller_cmd(se, &cmd))
+		engine = NULL;
+	mutex_unlock(&se->engine_init_lock);
+
+	return engine;
+}
+EXPORT_SYMBOL_GPL(loongson_se_init_engine);
+
+static irqreturn_t se_irq_handler(int irq, void *dev_id)
+{
+	struct loongson_se_engine *engine;
+	struct loongson_se *se = dev_id;
+	u32 int_status;
+	int id;
+
+	spin_lock(&se->dev_lock);
+
+	int_status = readl(se->base + SE_S2LINT_STAT);
+	/* For controller */
+	if (int_status & SE_INT_CONTROLLER) {
+		complete(&se->cmd_completion);
+		int_status &= ~SE_INT_CONTROLLER;
+		writel(SE_INT_CONTROLLER, se->base + SE_S2LINT_CL);
+	}
+	/* For engines */
+	while (int_status) {
+		id = __ffs(int_status);
+
+		engine = &se->engines[id];
+		complete(&engine->completion);
+		int_status &= ~BIT(id);
+		writel(BIT(id), se->base + SE_S2LINT_CL);
+	}
+
+	spin_unlock(&se->dev_lock);
+
+	return IRQ_HANDLED;
+}
+
+static int loongson_se_init(struct loongson_se *se, dma_addr_t addr, int size)
+{
+	struct loongson_se_controller_cmd cmd;
+	int err;
+
+	cmd.command_id = SE_CMD_START;
+	err = loongson_se_send_controller_cmd(se, &cmd);
+	if (err)
+		return err;
+
+	cmd.command_id = SE_CMD_SET_DMA;
+	cmd.info[0] = lower_32_bits(addr);
+	cmd.info[1] = upper_32_bits(addr);
+	cmd.info[2] = size;
+
+	return loongson_se_send_controller_cmd(se, &cmd);
+}
+
+static const struct mfd_cell engines[] = {
+	{ .name = "loongson-rng" },
+	{ .name = "loongson-tpm" },
+};
+
+static int loongson_se_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct loongson_se *se;
+	int nr_irq, irq, err;
+	dma_addr_t paddr;
+
+	se = devm_kmalloc(dev, sizeof(*se), GFP_KERNEL);
+	if (!se)
+		return -ENOMEM;
+	dev_set_drvdata(dev, se);
+	init_completion(&se->cmd_completion);
+	spin_lock_init(&se->dev_lock);
+	mutex_init(&se->engine_init_lock);
+
+	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
+	if (device_property_read_u32(dev, "dmam_size", &se->dmam_size))
+		return -ENODEV;
+	se->dmam_base = dmam_alloc_coherent(dev, se->dmam_size, &paddr, GFP_KERNEL);
+	if (!se->dmam_base)
+		return -ENOMEM;
+
+	se->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(se->base))
+		return PTR_ERR(se->base);
+	writel(SE_INT_ALL, se->base + SE_S2LINT_EN);
+
+	nr_irq = platform_irq_count(pdev);
+	if (nr_irq <= 0)
+		return -ENODEV;
+	while (nr_irq) {
+		irq = platform_get_irq(pdev, --nr_irq);
+		err = devm_request_irq(dev, irq, se_irq_handler, 0, "loongson-se", se);
+		if (err)
+			dev_err(dev, "failed to request irq: %d\n", irq);
+	}
+
+	err = loongson_se_init(se, paddr, se->dmam_size);
+	if (err)
+		return err;
+
+	return devm_mfd_add_devices(dev, 0, engines, ARRAY_SIZE(engines), NULL, 0, NULL);
+}
+
+static const struct acpi_device_id loongson_se_acpi_match[] = {
+	{"LOON0011", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, loongson_se_acpi_match);
+
+static struct platform_driver loongson_se_driver = {
+	.probe   = loongson_se_probe,
+	.driver  = {
+		.name  = "loongson-se",
+		.acpi_match_table = loongson_se_acpi_match,
+	},
+};
+module_platform_driver(loongson_se_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Yinggang Gu <guyinggang@loongson.cn>");
+MODULE_AUTHOR("Qunqin Zhao <zhaoqunqin@loongson.cn>");
+MODULE_DESCRIPTION("Loongson Security Module driver");
diff --git a/drivers/crypto/loongson/loongson-se.h b/drivers/crypto/loongson/loongson-se.h
new file mode 100644
index 000000000..f962d6143
--- /dev/null
+++ b/drivers/crypto/loongson/loongson-se.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Copyright (C) 2025 Loongson Technology Corporation Limited */
+
+#ifndef __LOONGSON_SE_H__
+#define __LOONGSON_SE_H__
+
+#define SE_SEND_CMD_REG			0x0
+#define SE_SEND_CMD_REG_LEN		0x8
+/* controller command id */
+#define SE_CMD_START			0x0
+#define SE_CMD_SET_DMA			0x3
+#define SE_CMD_SET_ENGINE_CMDBUF	0x4
+
+#define SE_S2LINT_STAT			0x88
+#define SE_S2LINT_EN			0x8c
+#define SE_S2LINT_CL			0x94
+#define SE_L2SINT_STAT			0x98
+#define SE_L2SINT_SET			0xa0
+
+#define SE_INT_ALL			0xffffffff
+#define SE_INT_CONTROLLER		BIT(0)
+
+#define SE_ENGINE_MAX			16
+#define SE_ENGINE_RNG			1
+#define SE_CMD_RNG			0x100
+
+#define SE_ENGINE_TPM			5
+#define SE_CMD_TPM			0x500
+
+#define SE_ENGINE_CMD_SIZE		32
+
+struct loongson_se_engine {
+	struct loongson_se *se;
+	int id;
+
+	/* Command buffer */
+	void *command;
+	void *command_ret;
+
+	void *data_buffer;
+	uint buffer_size;
+	/* Data buffer offset to DMA base */
+	uint buffer_off;
+
+	struct completion completion;
+
+};
+
+struct loongson_se_engine *loongson_se_init_engine(struct device *dev, int id);
+int loongson_se_send_engine_cmd(struct loongson_se_engine *engine);
+
+#endif
-- 
2.45.2


