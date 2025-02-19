Return-Path: <linux-integrity+bounces-4896-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D43D8A3B288
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Feb 2025 08:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F8DF1898C9D
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Feb 2025 07:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679A51C1F13;
	Wed, 19 Feb 2025 07:34:33 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3C31ADC89;
	Wed, 19 Feb 2025 07:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739950473; cv=none; b=aBxBZ2M8Mvsm2w9B6YH2JVn0BGpn/w/hrl1dcQwxNK89+8XEHkn4Tl5ORH8TOLZcC9LfgvWvXd+ZpmJXvwI601FkMdAhaYn5meq3+gua41OX2LGOEeOO/PvUlAVHTl0/GOzlL+fKqys4fs/ISbs1jErT2qu9tyfFMouNMBj2Ph8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739950473; c=relaxed/simple;
	bh=T5Ez1Mu843MHYwECo8p3CuvxpMslyADb6v0L5uXFSgM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bXawoxqg2ACXmoJMiY8vB5hvxxd6iR9hmQgK7DleDdVMPAEkTKTtiib0bruqQ2icKFug2GrrvMUJtaVgKwn8IqhkEa6mdJBT4rGbuoBxRyO+HQNk8PLJEFUQM8ObJ0vTItKzfVZvmdoCaDFjfovyr4ilx0iwyPduIPTVCVOS+BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.54.90])
	by gateway (Coremail) with SMTP id _____8BxrnKBibVn87l6AA--.15293S3;
	Wed, 19 Feb 2025 15:34:25 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.54.90])
	by front1 (Coremail) with SMTP id qMiowMCx_cZyibVn17IbAA--.40645S3;
	Wed, 19 Feb 2025 15:34:23 +0800 (CST)
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
Subject: [PATCH V3 5/6] tpm: Add a driver for Loongson TPM device
Date: Wed, 19 Feb 2025 15:33:49 +0800
Message-Id: <20250219073350.16915-2-zhaoqunqin@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20250219073350.16915-1-zhaoqunqin@loongson.cn>
References: <20250219073350.16915-1-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCx_cZyibVn17IbAA--.40645S3
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxAr4Dtw1xXw1ktFy5tF1rKrX_yoWrKrW8pF
	45Ca43Cr45GFW7t393Jr4DuF9xJ392qFW7K3yxJasxur90yas8uFWktFWUJFy3XrZ7GFya
	qa9a9FW5uF1jywcCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3
	AwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVW7JVWDJwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWxJVW8Jr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU022NJUUUUU==

Loongson security engine supports random number generation, hash,
symmetric encryption and asymmetric encryption. Based on these
encryption functions, TPM2 have been implemented in the Loongson
security engine firmware. This driver is responsible for copying data
into the memory visible to the firmware and receiving data from the
firmware.

Co-developed-by: Yinggang Gu <guyinggang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
---
v3: Added reminder about Loongson security engine to git log.

 drivers/char/tpm/Kconfig    |   9 ++++
 drivers/char/tpm/Makefile   |   1 +
 drivers/char/tpm/tpm_lsse.c | 104 ++++++++++++++++++++++++++++++++++++
 3 files changed, 114 insertions(+)
 create mode 100644 drivers/char/tpm/tpm_lsse.c

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


