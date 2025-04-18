Return-Path: <linux-integrity+bounces-5935-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E2EA9355A
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Apr 2025 11:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B46B1B65716
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Apr 2025 09:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14E22571B2;
	Fri, 18 Apr 2025 09:32:53 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C892741C9;
	Fri, 18 Apr 2025 09:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744968773; cv=none; b=VsUn2PXhZ4r0Xs5vsUfQMYuULbnr+17pK4XOtojDj7oJUIJnsUHXtoumlWmCFctmQkLJwL+I5DvKs0/V6cq9sC+fJ/uth2lbpI0a41n9BcyFeYBkwxpnFngmnHV/bAFbzVYmqHGBbS6xVLzDIhYoZfsiyO5wwCLK3IMQsd+Uers=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744968773; c=relaxed/simple;
	bh=noH75sxi+2I9Xnc6LUTaRGiOzVsG1ODIu9XdqaU4uFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SnAEJgSaeep6tKUkrCK/ToIrdriG32s7ldgR5MVC9OzSiHsWDYx4J7jPy5Oj5W4X69II0eKWSRuRx4XSBcFRD7FI38yajPaxga5/NxGta4MjEq1EXTQ0+zKsbD3/+lj8Ob00l1weY96uLVyOWeylduyY2evuS2LXHEU5rBPFhHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.54.180])
	by gateway (Coremail) with SMTP id _____8AxCGo0HAJoM6LBAA--.58718S3;
	Fri, 18 Apr 2025 17:32:36 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.54.180])
	by front1 (Coremail) with SMTP id qMiowMCx_cYsHAJoGUKJAA--.15831S4;
	Fri, 18 Apr 2025 17:32:34 +0800 (CST)
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
Subject: [PATCH v8 2/5] crypto: loongson - add Loongson RNG driver support
Date: Fri, 18 Apr 2025 17:34:04 +0800
Message-ID: <20250418093407.1335-3-zhaoqunqin@loongson.cn>
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
X-CM-TRANSID:qMiowMCx_cYsHAJoGUKJAA--.15831S4
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Jr15Cw18Kr48Xr48WFW5CFX_yoWxur4xpF
	4Sya4Uur45GFsrC395trW5CrW5Z3s8Z3srWa9rX3W5Kr97Aw1kXryxJFyUArW7ArZxWry7
	XFZ5GF40ka1UG3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5
	McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4eMKDUUUU

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

 drivers/crypto/loongson/Kconfig        |   6 +
 drivers/crypto/loongson/Makefile       |   1 +
 drivers/crypto/loongson/loongson-rng.c | 198 +++++++++++++++++++++++++
 3 files changed, 205 insertions(+)
 create mode 100644 drivers/crypto/loongson/loongson-rng.c

diff --git a/drivers/crypto/loongson/Kconfig b/drivers/crypto/loongson/Kconfig
index 9fdcc73bc..2a5ac65ea 100644
--- a/drivers/crypto/loongson/Kconfig
+++ b/drivers/crypto/loongson/Kconfig
@@ -9,3 +9,9 @@ config CRYPTO_DEV_LOONGSON_SE
 	  provided by the controller. The kernel cannot directly send
 	  commands to the engine and must first send them to the controller,
 	  which will forward them to the corresponding engine.
+
+config CRYPTO_DEV_LOONGSON_RNG
+	tristate "Support for Loongson RNG Driver"
+	depends on CRYPTO_DEV_LOONGSON_SE
+	help
+	  Support for Loongson RNG Driver.
diff --git a/drivers/crypto/loongson/Makefile b/drivers/crypto/loongson/Makefile
index 5ebcd9ff8..1a614b28c 100644
--- a/drivers/crypto/loongson/Makefile
+++ b/drivers/crypto/loongson/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_CRYPTO_DEV_LOONGSON_SE)	+= loongson-se.o
+obj-$(CONFIG_CRYPTO_DEV_LOONGSON_RNG)	+= loongson-rng.o
diff --git a/drivers/crypto/loongson/loongson-rng.c b/drivers/crypto/loongson/loongson-rng.c
new file mode 100644
index 000000000..2fb989811
--- /dev/null
+++ b/drivers/crypto/loongson/loongson-rng.c
@@ -0,0 +1,198 @@
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
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/random.h>
+#include <crypto/internal/rng.h>
+
+#include "loongson-se.h"
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


