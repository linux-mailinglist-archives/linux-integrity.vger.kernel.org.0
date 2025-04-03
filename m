Return-Path: <linux-integrity+bounces-5565-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8794FA79A0C
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Apr 2025 04:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69651171499
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Apr 2025 02:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C892D197A68;
	Thu,  3 Apr 2025 02:46:06 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9B416F0FE;
	Thu,  3 Apr 2025 02:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743648366; cv=none; b=ZVIiZk0thxrL+/e2TwlTZte27fJR9KtG+7k2PpTb0egn2TFbYTCNSSmI8YmiYVbttQ90VJ7+TnJaH6hqQxtYPkXj5x8EciyC/g4Hr3R6lC03EH+D8BLGRCHExSBaPEDCIp3vzvmx1eEYg/jOEQAOFTcp7wJSHjiP0pDEsAXa0AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743648366; c=relaxed/simple;
	bh=tCjNVxL3l+t2SU7mdgmKzyw+JXSRqWQas8sTDWEDNIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4eYBB2TU/nqFKooObaA2m0i/FzusDDt+3B1jc0SQCRigDPq+yZcWUHwK8jfY20AY9Cckcak6jEWiIAXBV1roZk4izERSmjDsGXYB0sMsobYbg+9U+tHtAsK8FZut6kgBF2go3CrmMxt0eznbn99Geh1IdJ5A0I6icg5SNTiYfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.54.180])
	by gateway (Coremail) with SMTP id _____8DxfWto9u1n3cavAA--.31087S3;
	Thu, 03 Apr 2025 10:46:00 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.54.180])
	by front1 (Coremail) with SMTP id qMiowMBx3MRY9u1n8SFtAA--.62246S5;
	Thu, 03 Apr 2025 10:45:59 +0800 (CST)
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
Subject: [PATCH v7 3/6] crypto: loongson - add Loongson RNG driver support
Date: Thu,  3 Apr 2025 10:46:42 +0800
Message-ID: <20250403024645.4427-4-zhaoqunqin@loongson.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250403024645.4427-1-zhaoqunqin@loongson.cn>
References: <20250403024645.4427-1-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBx3MRY9u1n8SFtAA--.62246S5
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Jr15CFW3uF4fXw4kGr47Jrc_yoWxtFWrpF
	4Fk3yUCr45GFsrCFZ5JrW5CFy5Zasav3sFgFW7Jw1Y9r97AF1DXFWfJFyUAFZrArZ5GrWa
	qFZakFWUKa1UG3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AK
	xVWxJr0_GcWln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4Xo7DUUUU

Loongson's Random Number Generator is found inside Loongson security
engine.

Co-developed-by: Yinggang Gu <guyinggang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
---
v7: Change the lsrng_ prefix to loongson_rng_
v6: Replace all "ls6000se" with "loongson"
v2-v5: None

 drivers/crypto/Kconfig                 |   1 +
 drivers/crypto/Makefile                |   1 +
 drivers/crypto/loongson/Kconfig        |   6 +
 drivers/crypto/loongson/Makefile       |   2 +
 drivers/crypto/loongson/loongson-rng.c | 190 +++++++++++++++++++++++++
 5 files changed, 200 insertions(+)
 create mode 100644 drivers/crypto/loongson/Kconfig
 create mode 100644 drivers/crypto/loongson/Makefile
 create mode 100644 drivers/crypto/loongson/loongson-rng.c

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 19ab145f9..567ed81b0 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -855,5 +855,6 @@ config CRYPTO_DEV_SA2UL
 
 source "drivers/crypto/aspeed/Kconfig"
 source "drivers/crypto/starfive/Kconfig"
+source "drivers/crypto/loongson/Kconfig"
 
 endif # CRYPTO_HW
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index fef18ffdb..643c3710b 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -50,3 +50,4 @@ obj-y += hisilicon/
 obj-$(CONFIG_CRYPTO_DEV_AMLOGIC_GXL) += amlogic/
 obj-y += intel/
 obj-y += starfive/
+obj-y += loongson/
diff --git a/drivers/crypto/loongson/Kconfig b/drivers/crypto/loongson/Kconfig
new file mode 100644
index 000000000..4368701ad
--- /dev/null
+++ b/drivers/crypto/loongson/Kconfig
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+config CRYPTO_DEV_LOONGSON_RNG
+        tristate "Support for Loongson RNG Driver"
+        depends on MFD_LOONGSON_SE
+        help
+          Support for Loongson RNG Driver.
diff --git a/drivers/crypto/loongson/Makefile b/drivers/crypto/loongson/Makefile
new file mode 100644
index 000000000..b8b013c86
--- /dev/null
+++ b/drivers/crypto/loongson/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_CRYPTO_DEV_LOONGSON_RNG)	+= loongson-rng.o
diff --git a/drivers/crypto/loongson/loongson-rng.c b/drivers/crypto/loongson/loongson-rng.c
new file mode 100644
index 000000000..307014992
--- /dev/null
+++ b/drivers/crypto/loongson/loongson-rng.c
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
+#include <linux/mfd/loongson-se.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/random.h>
+#include <crypto/internal/rng.h>
+
+struct loongson_rng_list {
+	struct mutex lock;
+	struct list_head list;
+	int is_init;
+};
+
+struct lsrng {
+	bool is_used;
+	struct se_channel *se_ch;
+	struct list_head list;
+	struct completion rng_completion;
+};
+
+struct loongson_rng_ctx {
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
+static struct loongson_rng_list rng_devices;
+
+static void loongson_rng_complete(struct se_channel *ch)
+{
+	struct lsrng *rng = (struct lsrng *)ch->priv;
+
+	complete(&rng->rng_completion);
+}
+
+static int loongson_rng_generate(struct crypto_rng *tfm, const u8 *src,
+			  unsigned int slen, u8 *dstn, unsigned int dlen)
+{
+	struct loongson_rng_ctx *ctx = crypto_rng_ctx(tfm);
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
+static int loongson_rng_init(struct crypto_tfm *tfm)
+{
+	struct loongson_rng_ctx *ctx = crypto_tfm_ctx(tfm);
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
+static void loongson_rng_exit(struct crypto_tfm *tfm)
+{
+	struct loongson_rng_ctx *ctx = crypto_tfm_ctx(tfm);
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
+static struct rng_alg loongson_rng_alg = {
+	.generate = loongson_rng_generate,
+	.seed =	no_seed,
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
+static void loongson_rng_add_to_list(struct lsrng *rng)
+{
+	mutex_lock(&rng_devices.lock);
+	list_add_tail(&rng->list, &rng_devices.list);
+	mutex_unlock(&rng_devices.lock);
+}
+
+static int loongson_rng_probe(struct platform_device *pdev)
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
+				sizeof(struct rng_msg) * 2, rng, loongson_rng_complete);
+	if (!rng->se_ch)
+		return -ENODEV;
+	msg = rng->se_ch->smsg;
+	msg->cmd = SE_CMD_RNG;
+	msg->out_off = rng->se_ch->off;
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


