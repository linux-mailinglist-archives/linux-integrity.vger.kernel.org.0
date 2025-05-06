Return-Path: <linux-integrity+bounces-6133-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B28ECAAB9BE
	for <lists+linux-integrity@lfdr.de>; Tue,  6 May 2025 09:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA1DF1C05E3F
	for <lists+linux-integrity@lfdr.de>; Tue,  6 May 2025 06:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4EF283FD1;
	Tue,  6 May 2025 04:05:02 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A51428C02B;
	Tue,  6 May 2025 03:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746501539; cv=none; b=kccCXX7wLCZL5l7aN+sbom/4fJA4+FYFQ4cBrDS1WctDDhpCy+tALWbs5PFrZFyzKpGcPMGJzyv+uZJ2Pb3xwj39m1ws3FlOTG7q5cYc+Lz1d0fmBiXrm9LUREOLk1RxyggHQkg9FIhSWzbXg01XAX9FXWuqsIq4nKPHwO1IG6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746501539; c=relaxed/simple;
	bh=td7+9bsL4X+8x1xQv02DxRpHNz5O1/IlVOCeN1UpYDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tAzGexefkpCcS7s25R6qoL1vZucfdpX3sXJPWABL9lyKs2jbn3nB0BNwr5QY8N5DZzzACL0fl4Fq/60p3q7RG5rJLn2hCF9/wIMO6uJ3LaE4VJVRTJvzXGNiTSCOD8RtLs4zS8tFJBQFrA0RJNMI19JELQfoGCeBPuMdyoGokn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.54.178])
	by gateway (Coremail) with SMTP id _____8DxzOKefxlopUrWAA--.23700S3;
	Tue, 06 May 2025 11:18:54 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.54.178])
	by front1 (Coremail) with SMTP id qMiowMCx7MSPfxloqre1AA--.770S4;
	Tue, 06 May 2025 11:18:47 +0800 (CST)
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
To: lee@kernel.org,
	herbert@gondor.apana.org.au,
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
Subject: [PATCH v9 2/5] crypto: loongson - add Loongson RNG driver support
Date: Tue,  6 May 2025 11:19:44 +0800
Message-ID: <20250506031947.11130-3-zhaoqunqin@loongson.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250506031947.11130-1-zhaoqunqin@loongson.cn>
References: <20250506031947.11130-1-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCx7MSPfxloqre1AA--.770S4
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Jr15Cw18Wr1ktF1rtw15Jrc_yoW3XryxpF
	4Fy34UCrW5GFsrCFZ5trW5CrW5ZasIvr9rKFZrX345Wr97Ar1kXrWxJFyUAFW7ArZ7GrW3
	XFZ3GF48Ka1UG3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
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

Loongson's Random Number Generator is found inside Loongson Security
Engine chip.

Co-developed-by: Yinggang Gu <guyinggang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
---
v8: Added reseed callbak. "lsrng" --> "loongson_rng".
v7: Change the lsrng_ prefix to loongson_rng_
v6: Replace all "ls6000se" with "loongson"
v2-v5: None

 drivers/crypto/Kconfig                 |   1 +
 drivers/crypto/Makefile                |   1 +
 drivers/crypto/loongson/Kconfig        |   5 +
 drivers/crypto/loongson/Makefile       |   1 +
 drivers/crypto/loongson/loongson-rng.c | 197 +++++++++++++++++++++++++
 5 files changed, 205 insertions(+)
 create mode 100644 drivers/crypto/loongson/Kconfig
 create mode 100644 drivers/crypto/loongson/Makefile
 create mode 100644 drivers/crypto/loongson/loongson-rng.c

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
index c97f0ebc5..fbd039058 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -47,6 +47,7 @@ obj-y += inside-secure/
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
index 000000000..bc0a4404b
--- /dev/null
+++ b/drivers/crypto/loongson/loongson-rng.c
@@ -0,0 +1,197 @@
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
+	int is_init;
+};
+
+struct loongson_rng {
+	bool is_used;
+	struct loongson_se_engine *engine;
+	struct list_head list;
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
+static atomic_t rng_active_devs;
+static struct loongson_rng_list rng_devices;
+
+static int loongson_rng_generate(struct crypto_rng *tfm, const u8 *src,
+			  unsigned int slen, u8 *dstn, unsigned int dlen)
+{
+	struct loongson_rng_ctx *ctx = crypto_rng_ctx(tfm);
+	struct loongson_rng *rng = ctx->rng;
+	struct loongson_rng_cmd *cmd = rng->engine->command;
+	int err, len;
+
+	cmd->seed_off = 0;
+	do {
+		len = min(dlen, rng->engine->buffer_size);
+		cmd = rng->engine->command;
+		cmd->u.len = len;
+		err = loongson_se_send_engine_cmd(rng->engine);
+		if (err)
+			return err;
+
+		cmd = rng->engine->command_ret;
+		if (cmd->u.ret)
+			return -EFAULT;
+
+		memcpy(dstn, rng->engine->data_buffer, len);
+		dlen -= len;
+		dstn += len;
+	} while (dlen > 0);
+
+	return 0;
+}
+
+static int loongson_rng_init(struct crypto_tfm *tfm)
+{
+	struct loongson_rng_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct loongson_rng *rng;
+	int ret = -EBUSY;
+
+	mutex_lock(&rng_devices.lock);
+	list_for_each_entry(rng, &rng_devices.list, list) {
+		if (!rng->is_used) {
+			rng->is_used = true;
+			ctx->rng = rng;
+			ret = 0;
+			break;
+		}
+	}
+	mutex_unlock(&rng_devices.lock);
+
+	return ret;
+}
+
+static void loongson_rng_exit(struct crypto_tfm *tfm)
+{
+	struct loongson_rng_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	mutex_lock(&rng_devices.lock);
+	ctx->rng->is_used = false;
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
+	cmd = rng->engine->command;
+	cmd->u.len = slen;
+	cmd->seed_off = rng->engine->buffer_off;
+	memcpy(rng->engine->data_buffer, seed, slen);
+	err = loongson_se_send_engine_cmd(rng->engine);
+	cmd = rng->engine->command_ret;
+	if (err || cmd->u.ret)
+		return -EFAULT;
+
+	return 0;
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
+static void loongson_rng_add_to_list(struct loongson_rng *rng)
+{
+	mutex_lock(&rng_devices.lock);
+	list_add_tail(&rng->list, &rng_devices.list);
+	mutex_unlock(&rng_devices.lock);
+}
+
+static int loongson_rng_probe(struct platform_device *pdev)
+{
+	struct loongson_rng_cmd *cmd;
+	struct loongson_rng *rng;
+	int ret;
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
+
+	if (!rng_devices.is_init) {
+		ret = crypto_register_rng(&loongson_rng_alg);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to register crypto(%d)\n", ret);
+			return ret;
+		}
+		INIT_LIST_HEAD(&rng_devices.list);
+		mutex_init(&rng_devices.lock);
+		rng_devices.is_init = true;
+	}
+
+	loongson_rng_add_to_list(rng);
+	atomic_inc(&rng_active_devs);
+
+	return 0;
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
+MODULE_DESCRIPTION("Loongson random number generator driver");
-- 
2.45.2


