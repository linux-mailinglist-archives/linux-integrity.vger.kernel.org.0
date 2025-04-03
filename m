Return-Path: <linux-integrity+bounces-5567-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2295EA79A18
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Apr 2025 04:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55BA81891BAB
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Apr 2025 02:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4A019AD48;
	Thu,  3 Apr 2025 02:46:56 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA601194A73;
	Thu,  3 Apr 2025 02:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743648416; cv=none; b=nJpkBtXHK5nIyOB7vrzFpRtEtmafVSfjwmFZ42Nxcs7Xw/TDSlsugf5HOIuhanHKyDkMedK24bVT2455HU0nEcPJxcoCoK4rp9fDRAfOF8BYnm5ta8In3v0isEvY0RXwpic8Fv74qlxLZRRgeNFu99/S0eHYKSuT8Kl0CfjP3P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743648416; c=relaxed/simple;
	bh=j96DN75Q9TvfZfL7/FAP9Tz80HzbJtXmCGTt4R+kQd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t3LhUY3buy2NEvfy8cOp3OTIpmbe7sR03bHtN6mBvqnyb9X3v/a45xmudEbuBa7smVZYSHovU3wNWoLoAapdPL7RkY8IH2X+UxR5jTdSBUYsH1Ex00T0a4Ob6v5dD8VTh3vgmU72YcybBkb4+C8oJX5LJYckgZhtWlcp4TQ5q1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.54.180])
	by gateway (Coremail) with SMTP id _____8AxHHKc9u1nWsevAA--.31022S3;
	Thu, 03 Apr 2025 10:46:52 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.54.180])
	by front1 (Coremail) with SMTP id qMiowMCx7xua9u1ndyJtAA--.61678S2;
	Thu, 03 Apr 2025 10:46:51 +0800 (CST)
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
Subject: [PATCH v7 5/6] tpm: Add a driver for Loongson TPM device
Date: Thu,  3 Apr 2025 10:47:49 +0800
Message-ID: <20250403024750.4448-1-zhaoqunqin@loongson.cn>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCx7xua9u1ndyJtAA--.61678S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Gw1kXFWxCF1kZF1rJr18WFX_yoW7Cr1DpF
	W5Ca4Uur45Jr4UtwsxArWUuFsxZ34fXFZrKay7Jw15uryqy3s5XrWktFyUJa13ArWkGry2
	qFZa9r45GF15uwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AK
	xVWxJr0_GcWln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26rWY
	6Fy7McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0_WrPUUUUU==

Loongson security engine supports random number generation, hash,
symmetric encryption and asymmetric encryption. Based on these
encryption functions, TPM2 have been implemented in the Loongson
security engine firmware. This driver is responsible for copying data
into the memory visible to the firmware and receiving data from the
firmware.

Co-developed-by: Yinggang Gu <guyinggang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
---
v7: Moved Kconfig entry between TCG_IBMVTPM and TCG_XEN.
    Added Jarkko's tag(a little change, should be fine).

v6: Replace all "ls6000se" with "loongson"
    Prefix all with tpm_loongson instead of tpm_lsse.
    Removed Jarkko's tag cause there are some changes in v6

v5: None
v4: Prefix all with tpm_lsse instead of tpm.
    Removed MODULE_AUTHOR fields.
 
v3: Added reminder about Loongson security engine to git log.

 drivers/char/tpm/Kconfig        |   9 +++
 drivers/char/tpm/Makefile       |   1 +
 drivers/char/tpm/tpm_loongson.c | 103 ++++++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+)
 create mode 100644 drivers/char/tpm/tpm_loongson.c

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 0fc9a510e..a5152e83a 100644
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
index 9bb142c75..e84a2f7a9 100644
--- a/drivers/char/tpm/Makefile
+++ b/drivers/char/tpm/Makefile
@@ -44,3 +44,4 @@ obj-$(CONFIG_TCG_XEN) += xen-tpmfront.o
 obj-$(CONFIG_TCG_CRB) += tpm_crb.o
 obj-$(CONFIG_TCG_VTPM_PROXY) += tpm_vtpm_proxy.o
 obj-$(CONFIG_TCG_FTPM_TEE) += tpm_ftpm_tee.o
+obj-$(CONFIG_TCG_LOONGSON) += tpm_loongson.o
diff --git a/drivers/char/tpm/tpm_loongson.c b/drivers/char/tpm/tpm_loongson.c
new file mode 100644
index 000000000..8b7da8cdd
--- /dev/null
+++ b/drivers/char/tpm/tpm_loongson.c
@@ -0,0 +1,103 @@
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
+struct tpm_loongson_msg {
+	u32 cmd;
+	u32 data_off;
+	u32 data_len;
+	u32 info[5];
+};
+
+struct tpm_loongson_dev {
+	struct se_channel *se_ch;
+	struct completion tpm_loongson_completion;
+};
+
+static void tpm_loongson_complete(struct se_channel *ch)
+{
+	struct tpm_loongson_dev *td = ch->priv;
+
+	complete(&td->tpm_loongson_completion);
+}
+
+static int tpm_loongson_recv(struct tpm_chip *chip, u8 *buf, size_t count)
+{
+	struct tpm_loongson_dev *td = dev_get_drvdata(&chip->dev);
+	struct tpm_loongson_msg *rmsg;
+	int sig;
+
+	sig = wait_for_completion_interruptible(&td->tpm_loongson_completion);
+	if (sig)
+		return sig;
+
+	rmsg = td->se_ch->rmsg;
+	memcpy(buf, td->se_ch->data_buffer, rmsg->data_len);
+
+	return rmsg->data_len;
+}
+
+static int tpm_loongson_send(struct tpm_chip *chip, u8 *buf, size_t count)
+{
+	struct tpm_loongson_dev *td = dev_get_drvdata(&chip->dev);
+	struct tpm_loongson_msg *smsg = td->se_ch->smsg;
+
+	memcpy(td->se_ch->data_buffer, buf, count);
+	smsg->data_len = count;
+
+	return se_send_ch_requeset(td->se_ch);
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
+	struct device *dev = &pdev->dev;
+	struct tpm_loongson_msg *smsg;
+	struct tpm_loongson_dev *td;
+	struct tpm_chip *chip;
+
+	td = devm_kzalloc(dev, sizeof(struct tpm_loongson_dev), GFP_KERNEL);
+	if (!td)
+		return -ENOMEM;
+
+	init_completion(&td->tpm_loongson_completion);
+	td->se_ch = se_init_ch(dev->parent, SE_CH_TPM, PAGE_SIZE,
+			       2 * sizeof(struct tpm_loongson_msg), td,
+			       tpm_loongson_complete);
+	if (!td->se_ch)
+		return -ENODEV;
+	smsg = td->se_ch->smsg;
+	smsg->cmd = SE_CMD_TPM;
+	smsg->data_off = td->se_ch->off;
+
+	chip = tpmm_chip_alloc(dev, &tpm_loongson_ops);
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	chip->flags = TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_IRQ;
+	dev_set_drvdata(&chip->dev, td);
+
+	return tpm_chip_register(chip);
+}
+
+static struct platform_driver tpm_loongson_driver = {
+	.probe   = tpm_loongson_probe,
+	.driver  = {
+		.name  = "loongson-tpm",
+	},
+};
+module_platform_driver(tpm_loongson_driver);
+
+MODULE_ALIAS("platform:loongson-tpm");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Loongson TPM driver");
-- 
2.45.2


