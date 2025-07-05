Return-Path: <linux-integrity+bounces-6633-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1848EAF9EAF
	for <lists+linux-integrity@lfdr.de>; Sat,  5 Jul 2025 09:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB64D1BC67DC
	for <lists+linux-integrity@lfdr.de>; Sat,  5 Jul 2025 07:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278B9277C8E;
	Sat,  5 Jul 2025 07:21:51 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8154B275853;
	Sat,  5 Jul 2025 07:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751700111; cv=none; b=J78vYfEwqDK2gs0M4Rk6llEio0SyGtrgXO6B2kOb/vWvMQofYIJDf8voyLgxChyvjqEX5hCmltwnpfhRiY0n6S2htJq+gfgBAF9k52QOgO2PB8/vtb3sV9IpH8CH//+Oit5HCLFhOhyABPvB80JrI4WoXz02MRQo9DD+EYxw+us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751700111; c=relaxed/simple;
	bh=PIP3dPe5IBLWopjuQleVcQheQOnxCZ8Xaa3K7GPX70U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XSKOcpEkwLEVNC6LXx7Xf2gtKAuLoGIUjOX7JIXuhU3CMICxbz8fY4M/m3FvcfAa87S/K9/FRRTjvVirKX/h7Z6V4OiB6mbsBUQCrILRR2qGC3/muFr6bOVcuvrXQloEE8KbcgotNCqYxOidbk2WljPhcuynbKJx4pgA1MikLPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.54.123])
	by gateway (Coremail) with SMTP id _____8AxHHKL0mhoJbsiAQ--.9746S3;
	Sat, 05 Jul 2025 15:21:47 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.54.123])
	by front1 (Coremail) with SMTP id qMiowJBxZOSA0mhoElgKAA--.60805S4;
	Sat, 05 Jul 2025 15:21:46 +0800 (CST)
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
Subject: [PATCH v12 2/4] crypto: loongson - add Loongson RNG driver support
Date: Sat,  5 Jul 2025 15:20:43 +0800
Message-ID: <20250705072045.1067-3-zhaoqunqin@loongson.cn>
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
X-CM-TRANSID:qMiowJBxZOSA0mhoElgKAA--.60805S4
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Jr15CFWDCr4DJF17Jw48KrX_yoW3Xr4xpF
	4Yk34UCrW5JFsrCrZ5trW5AFW5Zas3Zr9FgFZrXw15Wr97AFykXryxJFyUAFW7Ar9rGrWa
	qFZ3GF48Ka1UC3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
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
	x2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jz5lbUUUUU=

Loongson's Random Number Generator is found inside Loongson Security
Engine chip.

Co-developed-by: Yinggang Gu <guyinggang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/crypto/Kconfig                 |   1 +
 drivers/crypto/Makefile                |   1 +
 drivers/crypto/loongson/Kconfig        |   5 +
 drivers/crypto/loongson/Makefile       |   1 +
 drivers/crypto/loongson/loongson-rng.c | 209 +++++++++++++++++++++++++
 5 files changed, 217 insertions(+)
 create mode 100644 drivers/crypto/loongson/Kconfig
 create mode 100644 drivers/crypto/loongson/Makefile
 create mode 100644 drivers/crypto/loongson/loongson-rng.c

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 9f8a3a5be..f6117bc77 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -827,6 +827,7 @@ config CRYPTO_DEV_CCREE
 	  If unsure say Y.
 
 source "drivers/crypto/hisilicon/Kconfig"
+source "drivers/crypto/loongson/Kconfig"
 
 source "drivers/crypto/amlogic/Kconfig"
 
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index 22eadcc8f..125b99b24 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -44,6 +44,7 @@ obj-y += inside-secure/
 obj-$(CONFIG_CRYPTO_DEV_ARTPEC6) += axis/
 obj-y += xilinx/
 obj-y += hisilicon/
+obj-y += loongson/
 obj-$(CONFIG_CRYPTO_DEV_AMLOGIC_GXL) += amlogic/
 obj-y += intel/
 obj-y += starfive/
diff --git a/drivers/crypto/loongson/Kconfig b/drivers/crypto/loongson/Kconfig
new file mode 100644
index 000000000..15475da8f
--- /dev/null
+++ b/drivers/crypto/loongson/Kconfig
@@ -0,0 +1,5 @@
+config CRYPTO_DEV_LOONGSON_RNG
+	tristate "Support for Loongson RNG Driver"
+	depends on MFD_LOONGSON_SE
+	help
+	  Support for Loongson RNG Driver.
diff --git a/drivers/crypto/loongson/Makefile b/drivers/crypto/loongson/Makefile
new file mode 100644
index 000000000..1ce5ec32b
--- /dev/null
+++ b/drivers/crypto/loongson/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_CRYPTO_DEV_LOONGSON_RNG)  += loongson-rng.o
diff --git a/drivers/crypto/loongson/loongson-rng.c b/drivers/crypto/loongson/loongson-rng.c
new file mode 100644
index 000000000..3a4940260
--- /dev/null
+++ b/drivers/crypto/loongson/loongson-rng.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2019 HiSilicon Limited. */
+/* Copyright (c) 2025 Loongson Technology Corporation Limited. */
+
+#include <linux/crypto.h>
+#include <linux/err.h>
+#include <linux/hw_random.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/mfd/loongson-se.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/random.h>
+#include <crypto/internal/rng.h>
+
+#define SE_SEED_SIZE 32
+
+struct loongson_rng_list {
+	struct mutex lock;
+	struct list_head list;
+	int registered;
+};
+
+struct loongson_rng {
+	u32 used;
+	struct loongson_se_engine *engine;
+	struct list_head list;
+	struct mutex lock;
+};
+
+struct loongson_rng_ctx {
+	struct loongson_rng *rng;
+};
+
+struct loongson_rng_cmd {
+	u32 cmd_id;
+	union {
+		u32 len;
+		u32 ret;
+	} u;
+	u32 seed_off;
+	u32 out_off;
+	u32 pad[4];
+};
+
+static struct loongson_rng_list rng_devices = {
+	.lock = __MUTEX_INITIALIZER(rng_devices.lock),
+	.list = LIST_HEAD_INIT(rng_devices.list),
+};
+
+static int loongson_rng_generate(struct crypto_rng *tfm, const u8 *src,
+			  unsigned int slen, u8 *dstn, unsigned int dlen)
+{
+	struct loongson_rng_ctx *ctx = crypto_rng_ctx(tfm);
+	struct loongson_rng *rng = ctx->rng;
+	struct loongson_rng_cmd *cmd = rng->engine->command;
+	int err, len;
+
+	mutex_lock(&rng->lock);
+	cmd->seed_off = 0;
+	do {
+		len = min(dlen, rng->engine->buffer_size);
+		cmd = rng->engine->command;
+		cmd->u.len = len;
+		err = loongson_se_send_engine_cmd(rng->engine);
+		if (err)
+			break;
+
+		cmd = rng->engine->command_ret;
+		if (cmd->u.ret) {
+			err = -EIO;
+			break;
+		}
+
+		memcpy(dstn, rng->engine->data_buffer, len);
+		dlen -= len;
+		dstn += len;
+	} while (dlen > 0);
+	mutex_unlock(&rng->lock);
+
+	return err;
+}
+
+static int loongson_rng_init(struct crypto_tfm *tfm)
+{
+	struct loongson_rng_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct loongson_rng *rng;
+	u32 min_used = U32_MAX;
+
+	mutex_lock(&rng_devices.lock);
+	list_for_each_entry(rng, &rng_devices.list, list) {
+		if (rng->used < min_used) {
+			ctx->rng = rng;
+			min_used = rng->used;
+		}
+	}
+	ctx->rng->used++;
+	mutex_unlock(&rng_devices.lock);
+
+	return 0;
+}
+
+static void loongson_rng_exit(struct crypto_tfm *tfm)
+{
+	struct loongson_rng_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	mutex_lock(&rng_devices.lock);
+	ctx->rng->used--;
+	mutex_unlock(&rng_devices.lock);
+}
+
+static int loongson_rng_seed(struct crypto_rng *tfm, const u8 *seed,
+			     unsigned int slen)
+{
+	struct loongson_rng_ctx *ctx = crypto_rng_ctx(tfm);
+	struct loongson_rng *rng = ctx->rng;
+	struct loongson_rng_cmd *cmd;
+	int err;
+
+	if (slen < SE_SEED_SIZE)
+		return -EINVAL;
+
+	slen = min(slen, rng->engine->buffer_size);
+
+	mutex_lock(&rng->lock);
+	cmd = rng->engine->command;
+	cmd->u.len = slen;
+	cmd->seed_off = rng->engine->buffer_off;
+	memcpy(rng->engine->data_buffer, seed, slen);
+	err = loongson_se_send_engine_cmd(rng->engine);
+	if (err)
+		goto out;
+
+	cmd = rng->engine->command_ret;
+	if (cmd->u.ret)
+		err = -EIO;
+out:
+	mutex_unlock(&rng->lock);
+
+	return err;
+}
+
+static struct rng_alg loongson_rng_alg = {
+	.generate = loongson_rng_generate,
+	.seed =	loongson_rng_seed,
+	.seedsize = SE_SEED_SIZE,
+	.base = {
+		.cra_name = "stdrng",
+		.cra_driver_name = "loongson_stdrng",
+		.cra_priority = 300,
+		.cra_ctxsize = sizeof(struct loongson_rng_ctx),
+		.cra_module = THIS_MODULE,
+		.cra_init = loongson_rng_init,
+		.cra_exit = loongson_rng_exit,
+	},
+};
+
+static int loongson_rng_probe(struct platform_device *pdev)
+{
+	struct loongson_rng_cmd *cmd;
+	struct loongson_rng *rng;
+	int ret = 0;
+
+	rng = devm_kzalloc(&pdev->dev, sizeof(*rng), GFP_KERNEL);
+	if (!rng)
+		return -ENOMEM;
+
+	rng->engine = loongson_se_init_engine(pdev->dev.parent, SE_ENGINE_RNG);
+	if (!rng->engine)
+		return -ENODEV;
+	cmd = rng->engine->command;
+	cmd->cmd_id = SE_CMD_RNG;
+	cmd->out_off = rng->engine->buffer_off;
+	mutex_init(&rng->lock);
+
+	mutex_lock(&rng_devices.lock);
+
+	if (!rng_devices.registered) {
+		ret = crypto_register_rng(&loongson_rng_alg);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to register crypto(%d)\n", ret);
+			goto out;
+		}
+		rng_devices.registered = 1;
+	}
+
+	list_add_tail(&rng->list, &rng_devices.list);
+out:
+	mutex_unlock(&rng_devices.lock);
+
+	return ret;
+}
+
+static struct platform_driver loongson_rng_driver = {
+	.probe		= loongson_rng_probe,
+	.driver		= {
+		.name	= "loongson-rng",
+	},
+};
+module_platform_driver(loongson_rng_driver);
+
+MODULE_ALIAS("platform:loongson-rng");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Yinggang Gu <guyinggang@loongson.cn>");
+MODULE_AUTHOR("Qunqin Zhao <zhaoqunqin@loongson.cn>");
+MODULE_DESCRIPTION("Loongson Random Number Generator driver");
-- 
2.45.2


