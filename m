Return-Path: <linux-integrity+bounces-4796-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7AFA31CCC
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Feb 2025 04:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3BC9163CE1
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Feb 2025 03:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194F01DDA1B;
	Wed, 12 Feb 2025 03:31:58 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD111DC19E;
	Wed, 12 Feb 2025 03:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739331118; cv=none; b=sfpHB+SAGY8C0e4S/DDWVKEB5HroSFl0YtlMvhIij4XoHMmvgGnTb5dp78r/YA9TsS1ejera5LI8F4mIz/4HlaG3LMXm6bZi+FvH5r4G07oxsgdwaEw47z8PBatTL5YGqN7ex8E8+veDYm3KsHRVGvyQdnVjtOeYWW03Z6tOVck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739331118; c=relaxed/simple;
	bh=fAjXhqUBPCyLO1dLIbk1ZZhjdtzlMNensvH/h2QwlDY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c0gtRzTVtL5PN0U0gY5XIGxThYoPzWHsN8pTt/NUkCHuOlvgRdXCOJSv6rUQw3GxU+Ma510ztuKyb0vF0OCOdoC4vgKCx7wSbyTtgq6L16DShb4vGE7+YPV6IOcOqkgkmj+sb0k34i7C+IzswQ2/IvzPHtkAixH26mYt7ATb+28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.54.90])
	by gateway (Coremail) with SMTP id _____8Bx32slFqxnecpyAA--.3089S3;
	Wed, 12 Feb 2025 11:31:49 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.54.90])
	by front1 (Coremail) with SMTP id qMiowMCx_cYUFqxnxxENAA--.51918S4;
	Wed, 12 Feb 2025 11:31:39 +0800 (CST)
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
	Qunqin Zhao <zhaoqunqin@loongson.cn>,
	Yinggang Gu <guyinggang@loongson.cn>
Subject: [PATCH v2 2/3] crypto: loongson - add Loongson RNG driver support
Date: Wed, 12 Feb 2025 11:31:12 +0800
Message-Id: <20250212033113.15137-3-zhaoqunqin@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250212033113.15137-1-zhaoqunqin@loongson.cn>
References: <20250212033113.15137-1-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCx_cYUFqxnxxENAA--.51918S4
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Jr15CFWktF1kZFWxCFyfGrX_yoW3JF4UpF
	4Fk3y8CrWUGFsrKFZ5JrWrCFW3X3sa9a4agFW7Gwn09r92yFyDXayfAFyUAFWDAFWxWrWa
	gFZa9F4UKa1UJ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
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
	0xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8_gA5UUUUU==

Loongson's Random Number Generator is found inside Loongson 6000SE.

Co-developed-by: Yinggang Gu <guyinggang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
---
v2: None

 MAINTAINERS                            |   6 +
 drivers/crypto/Kconfig                 |   1 +
 drivers/crypto/Makefile                |   1 +
 drivers/crypto/loongson/Kconfig        |   6 +
 drivers/crypto/loongson/Makefile       |   2 +
 drivers/crypto/loongson/ls6000se-rng.c | 190 +++++++++++++++++++++++++
 6 files changed, 206 insertions(+)
 create mode 100644 drivers/crypto/loongson/Kconfig
 create mode 100644 drivers/crypto/loongson/Makefile
 create mode 100644 drivers/crypto/loongson/ls6000se-rng.c

diff --git a/MAINTAINERS b/MAINTAINERS
index cd6c029398..6493d58436 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13480,6 +13480,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/gpio/loongson,ls-gpio.yaml
 F:	drivers/gpio/gpio-loongson-64bit.c
 
+LOONGSON CRYPTO DRIVER
+M:	Qunqin Zhao <zhaoqunqin@loongson.com>
+L:	linux-crypto@vger.kernel.org
+S:	Maintained
+F:	drivers/crypto/loongson/
+
 LOONGSON-2 APB DMA DRIVER
 M:	Binbin Zhou <zhoubinbin@loongson.cn>
 L:	dmaengine@vger.kernel.org
diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 0a9cdd31cb..80caf6158e 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -872,5 +872,6 @@ config CRYPTO_DEV_SA2UL
 
 source "drivers/crypto/aspeed/Kconfig"
 source "drivers/crypto/starfive/Kconfig"
+source "drivers/crypto/loongson/Kconfig"
 
 endif # CRYPTO_HW
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index ad4ccef67d..a80e2586f7 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -52,3 +52,4 @@ obj-y += hisilicon/
 obj-$(CONFIG_CRYPTO_DEV_AMLOGIC_GXL) += amlogic/
 obj-y += intel/
 obj-y += starfive/
+obj-y += loongson/
diff --git a/drivers/crypto/loongson/Kconfig b/drivers/crypto/loongson/Kconfig
new file mode 100644
index 0000000000..2b0b8b3241
--- /dev/null
+++ b/drivers/crypto/loongson/Kconfig
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+config CRYPTO_DEV_LS6000SE_RNG
+        tristate "Support for Loongson 6000SE RNG Driver"
+        depends on MFD_LS6000SE
+        help
+          Support for Loongson 6000SE RNG Driver.
diff --git a/drivers/crypto/loongson/Makefile b/drivers/crypto/loongson/Makefile
new file mode 100644
index 0000000000..17b0fa89e9
--- /dev/null
+++ b/drivers/crypto/loongson/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_CRYPTO_DEV_LS6000SE_RNG)	+= ls6000se-rng.o
diff --git a/drivers/crypto/loongson/ls6000se-rng.c b/drivers/crypto/loongson/ls6000se-rng.c
new file mode 100644
index 0000000000..b366475782
--- /dev/null
+++ b/drivers/crypto/loongson/ls6000se-rng.c
@@ -0,0 +1,190 @@
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
+#include <linux/mfd/ls6000se.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/random.h>
+#include <crypto/internal/rng.h>
+
+struct lsrng_list {
+	struct mutex lock;
+	struct list_head list;
+	int is_init;
+};
+
+struct lsrng {
+	bool is_used;
+	struct lsse_ch *se_ch;
+	struct list_head list;
+	struct completion rng_completion;
+};
+
+struct lsrng_ctx {
+	struct lsrng *rng;
+};
+
+struct rng_msg {
+	u32 cmd;
+	union {
+		u32 len;
+		u32 ret;
+	} u;
+	u32 resved;
+	u32 out_off;
+	u32 pad[4];
+};
+
+static atomic_t rng_active_devs;
+static struct lsrng_list rng_devices;
+
+static void lsrng_complete(struct lsse_ch *ch)
+{
+	struct lsrng *rng = (struct lsrng *)ch->priv;
+
+	complete(&rng->rng_completion);
+}
+
+static int lsrng_generate(struct crypto_rng *tfm, const u8 *src,
+			  unsigned int slen, u8 *dstn, unsigned int dlen)
+{
+	struct lsrng_ctx *ctx = crypto_rng_ctx(tfm);
+	struct lsrng *rng = ctx->rng;
+	struct rng_msg *msg;
+	int err, len;
+
+	do {
+		len = min(dlen, PAGE_SIZE);
+		msg = rng->se_ch->smsg;
+		msg->u.len = len;
+		err = se_send_ch_requeset(rng->se_ch);
+		if (err)
+			return err;
+
+		wait_for_completion_interruptible(&rng->rng_completion);
+
+		msg = rng->se_ch->rmsg;
+		if (msg->u.ret)
+			return -EFAULT;
+
+		memcpy(dstn, rng->se_ch->data_buffer, len);
+		dlen -= len;
+		dstn += len;
+	} while (dlen > 0);
+
+	return 0;
+}
+
+static int lsrng_init(struct crypto_tfm *tfm)
+{
+	struct lsrng_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct lsrng *rng;
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
+static void lsrng_exit(struct crypto_tfm *tfm)
+{
+	struct lsrng_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	mutex_lock(&rng_devices.lock);
+	ctx->rng->is_used = false;
+	mutex_unlock(&rng_devices.lock);
+}
+
+static int no_seed(struct crypto_rng *tfm, const u8 *seed, unsigned int slen)
+{
+	return 0;
+}
+
+static struct rng_alg lsrng_alg = {
+	.generate = lsrng_generate,
+	.seed =	no_seed,
+	.base = {
+		.cra_name = "stdrng",
+		.cra_driver_name = "loongson_stdrng",
+		.cra_priority = 300,
+		.cra_ctxsize = sizeof(struct lsrng_ctx),
+		.cra_module = THIS_MODULE,
+		.cra_init = lsrng_init,
+		.cra_exit = lsrng_exit,
+	},
+};
+
+static void lsrng_add_to_list(struct lsrng *rng)
+{
+	mutex_lock(&rng_devices.lock);
+	list_add_tail(&rng->list, &rng_devices.list);
+	mutex_unlock(&rng_devices.lock);
+}
+
+static int lsrng_probe(struct platform_device *pdev)
+{
+	struct rng_msg *msg;
+	struct lsrng *rng;
+	int ret;
+
+	rng = devm_kzalloc(&pdev->dev, sizeof(*rng), GFP_KERNEL);
+	if (!rng)
+		return -ENOMEM;
+
+	init_completion(&rng->rng_completion);
+	rng->se_ch = se_init_ch(pdev->dev.parent, SE_CH_RNG, PAGE_SIZE,
+				sizeof(struct rng_msg) * 2, rng, lsrng_complete);
+	if (!rng->se_ch)
+		return -ENODEV;
+	msg = rng->se_ch->smsg;
+	msg->cmd = SE_CMD_RNG;
+	msg->out_off = rng->se_ch->off;
+
+	if (!rng_devices.is_init) {
+		ret = crypto_register_rng(&lsrng_alg);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to register crypto(%d)\n", ret);
+			return ret;
+		}
+		INIT_LIST_HEAD(&rng_devices.list);
+		mutex_init(&rng_devices.lock);
+		rng_devices.is_init = true;
+	}
+
+	lsrng_add_to_list(rng);
+	atomic_inc(&rng_active_devs);
+
+	return 0;
+}
+
+static struct platform_driver lsrng_driver = {
+	.probe		= lsrng_probe,
+	.driver		= {
+		.name	= "ls6000se-rng",
+	},
+};
+module_platform_driver(lsrng_driver);
+
+MODULE_ALIAS("platform:ls6000se-rng");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Yinggang Gu <guyinggang@loongson.cn>");
+MODULE_AUTHOR("Qunqin Zhao <zhaoqunqin@loongson.cn>");
+MODULE_DESCRIPTION("Loongson random number generator driver");
-- 
2.43.0


