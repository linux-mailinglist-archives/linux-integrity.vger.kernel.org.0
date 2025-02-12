Return-Path: <linux-integrity+bounces-4797-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6F9A31CD3
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Feb 2025 04:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56F437A428B
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Feb 2025 03:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462201F37B8;
	Wed, 12 Feb 2025 03:32:03 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8671E1DEFDD;
	Wed, 12 Feb 2025 03:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739331123; cv=none; b=ASprwd7WUmf33vDKb3M2ZVDfLbn0YfQWRQZPJzq24YQ8Ug+03r5cwE9TnuCb6foI3rI+2m0E/AbIxs4jZ/won2oe+NS6kkD9VVETzcpGKrolwgW/Ceaeg3E3yJhEPLZVdYVfWRWXFjA+xqWZ3OfOZdHRanijVLe5ztj1ZeM8hd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739331123; c=relaxed/simple;
	bh=EHw7z8g8mtLD0aY8DUDoR5M7dB45HIaBPKlgoUDASC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rxeU6UFJBHbUVOeVRr22oLY4uAmCBlr06UpPsFQ9iwpckNppZs6/om54g5NAjDa7jJ4vmbnajyrlVNLn7IKrmFnMo2qaGAOSgJ6X/S34hSbSFq5By2i9YfBimmhS7B8FTok25opiv/I009z/hZ98u89in93MMWZ+FB9JW5f1jkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.54.90])
	by gateway (Coremail) with SMTP id _____8BxjawrFqxng8pyAA--.36169S3;
	Wed, 12 Feb 2025 11:31:55 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.54.90])
	by front1 (Coremail) with SMTP id qMiowMCx_cYUFqxnxxENAA--.51918S5;
	Wed, 12 Feb 2025 11:31:46 +0800 (CST)
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
Subject: [PATCH v2 3/3] tpm: Add a driver for Loongson TPM device
Date: Wed, 12 Feb 2025 11:31:13 +0800
Message-Id: <20250212033113.15137-4-zhaoqunqin@loongson.cn>
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
X-CM-TRANSID:qMiowMCx_cYUFqxnxxENAA--.51918S5
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxCr4fGF4kGryruw47tw43Arc_yoWrKFy8pF
	4rCa43CrW5GF47t39xJr4DuFsxX3s2qFW7KrWxJasxZr90yas8uF4ktFy5JFsxXr97GFWa
	qa9a9F4a9F4jywcCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
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

TPM2.0 is implemented in Loongson security engine. This is the driver
for it.

Co-developed-by: Yinggang Gu <guyinggang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
---
 MAINTAINERS                 |   1 +
 drivers/char/tpm/Kconfig    |   9 ++++
 drivers/char/tpm/Makefile   |   1 +
 drivers/char/tpm/tpm_lsse.c | 104 ++++++++++++++++++++++++++++++++++++
 4 files changed, 115 insertions(+)
 create mode 100644 drivers/char/tpm/tpm_lsse.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6493d58436..6aad0f08ad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13484,6 +13484,7 @@ LOONGSON CRYPTO DRIVER
 M:	Qunqin Zhao <zhaoqunqin@loongson.com>
 L:	linux-crypto@vger.kernel.org
 S:	Maintained
+F:	drivers/char/tpm/tpm_lsse.c
 F:	drivers/crypto/loongson/
 
 LOONGSON-2 APB DMA DRIVER
diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 0fc9a510e0..56d0417065 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -225,5 +225,14 @@ config TCG_FTPM_TEE
 	help
 	  This driver proxies for firmware TPM running in TEE.
 
+config TCG_LSSE
+	tristate "Loongson TPM Interface"
+	depends on MFD_LS6000SE
+	help
+	  If you want to make Loongson TPM support available, say Yes and
+	  it will be accessible from within Linux. To compile this
+	  driver as a module, choose M here; the module will be called
+	  tpm_lsse.
+
 source "drivers/char/tpm/st33zp24/Kconfig"
 endif # TCG_TPM
diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
index 9bb142c752..bf2280352d 100644
--- a/drivers/char/tpm/Makefile
+++ b/drivers/char/tpm/Makefile
@@ -44,3 +44,4 @@ obj-$(CONFIG_TCG_XEN) += xen-tpmfront.o
 obj-$(CONFIG_TCG_CRB) += tpm_crb.o
 obj-$(CONFIG_TCG_VTPM_PROXY) += tpm_vtpm_proxy.o
 obj-$(CONFIG_TCG_FTPM_TEE) += tpm_ftpm_tee.o
+obj-$(CONFIG_TCG_LSSE) += tpm_lsse.o
diff --git a/drivers/char/tpm/tpm_lsse.c b/drivers/char/tpm/tpm_lsse.c
new file mode 100644
index 0000000000..3fd2d9bac8
--- /dev/null
+++ b/drivers/char/tpm/tpm_lsse.c
@@ -0,0 +1,104 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Loongson Technology Corporation Limited. */
+
+#include <linux/device.h>
+#include <linux/mfd/ls6000se.h>
+#include <linux/platform_device.h>
+#include <linux/wait.h>
+
+#include "tpm.h"
+
+struct tpm_msg {
+	u32 cmd;
+	u32 data_off;
+	u32 data_len;
+	u32 info[5];
+};
+
+struct tpm_dev {
+	struct lsse_ch *se_ch;
+	struct completion tpm_completion;
+};
+
+static void tpm_complete(struct lsse_ch *ch)
+{
+	struct tpm_dev *td = ch->priv;
+
+	complete(&td->tpm_completion);
+}
+
+static int tpm_ls_recv(struct tpm_chip *chip, u8 *buf, size_t count)
+{
+	struct tpm_dev *td = dev_get_drvdata(&chip->dev);
+	struct tpm_msg *rmsg;
+	int sig;
+
+	sig = wait_for_completion_interruptible(&td->tpm_completion);
+	if (sig)
+		return sig;
+
+	rmsg = td->se_ch->rmsg;
+	memcpy(buf, td->se_ch->data_buffer, rmsg->data_len);
+
+	return rmsg->data_len;
+}
+
+static int tpm_ls_send(struct tpm_chip *chip, u8 *buf, size_t count)
+{
+	struct tpm_dev *td = dev_get_drvdata(&chip->dev);
+	struct tpm_msg *smsg = td->se_ch->smsg;
+
+	memcpy(td->se_ch->data_buffer, buf, count);
+	smsg->data_len = count;
+
+	return se_send_ch_requeset(td->se_ch);
+}
+
+static const struct tpm_class_ops lsse_tpm_ops = {
+	.flags = TPM_OPS_AUTO_STARTUP,
+	.recv = tpm_ls_recv,
+	.send = tpm_ls_send,
+};
+
+static int lsse_tpm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct tpm_chip *chip;
+	struct tpm_msg *smsg;
+	struct tpm_dev *td;
+
+	td = devm_kzalloc(dev, sizeof(struct tpm_dev), GFP_KERNEL);
+	if (!td)
+		return -ENOMEM;
+
+	init_completion(&td->tpm_completion);
+	td->se_ch = se_init_ch(dev->parent, SE_CH_TPM, PAGE_SIZE,
+			       2 * sizeof(struct tpm_msg), td, tpm_complete);
+	if (!td->se_ch)
+		return -ENODEV;
+	smsg = td->se_ch->smsg;
+	smsg->cmd = SE_CMD_TPM;
+	smsg->data_off = td->se_ch->off;
+
+	chip = tpmm_chip_alloc(dev, &lsse_tpm_ops);
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	chip->flags = TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_IRQ;
+	dev_set_drvdata(&chip->dev, td);
+
+	return tpm_chip_register(chip);
+}
+
+static struct platform_driver lsse_tpm_driver = {
+	.probe   = lsse_tpm_probe,
+	.driver  = {
+		.name  = "ls6000se-tpm",
+	},
+};
+module_platform_driver(lsse_tpm_driver);
+
+MODULE_ALIAS("platform:ls6000se-tpm");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Yinggang Gu <guyinggang@loongson.cn>");
+MODULE_AUTHOR("Qunqin Zhao <zhaoqunqin@loongson.cn>");
+MODULE_DESCRIPTION("Loongson TPM driver");
-- 
2.43.0


