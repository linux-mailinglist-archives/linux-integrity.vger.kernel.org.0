Return-Path: <linux-integrity+bounces-5265-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8F4A5EF08
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Mar 2025 10:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A5401617B4
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Mar 2025 09:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1917F263F32;
	Thu, 13 Mar 2025 09:07:29 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A220263883;
	Thu, 13 Mar 2025 09:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741856849; cv=none; b=ORA1DPVtnTf6Iv+fnDxAX0S6SG/2jR4LeObJMT7VfA1CyxhGdKxyXGu0qH7q7ow7GKfe0aF2OS0P52aD9HoF8ETERT+hQqBBxdbUagA8FfuJheubx7nP0CcTgH1Q7qsSQEjSPb24rJyevFJEkFRGo+Ab3hArMQqy30lXpmGFjmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741856849; c=relaxed/simple;
	bh=8JmJW98ciVKFEtP59T+5FqjzkoZUzYd6jTT9+BV4zyg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r1W/AnUG+iQ2DmlXnyfeqNm1oLXHjHA8t3hng5TgLJ1ZOQMO3VPtrZsaRtQJgkw988dQUag2SwXvVdDyiMzZ6skfLP2NxNS5KlUMCmw3dizDMEod5TVgCLA981fL3VqF5Cy04KawzdgWaHJKZHtA06PVdD4mng2o4aeZzVes4TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.54.90])
	by gateway (Coremail) with SMTP id _____8CxvnJNoNJnBL6UAA--.56825S3;
	Thu, 13 Mar 2025 17:07:25 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.54.90])
	by front1 (Coremail) with SMTP id qMiowMBx3MRLoNJnbjpIAA--.3773S2;
	Thu, 13 Mar 2025 17:07:23 +0800 (CST)
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
	Yinggang Gu <guyinggang@loongson.cn>
Subject: [PATCH v5 5/6] tpm: Add a driver for Loongson TPM device
Date: Thu, 13 Mar 2025 17:07:01 +0800
Message-Id: <20250313090702.21300-1-zhaoqunqin@loongson.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBx3MRLoNJnbjpIAA--.3773S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxAr4Dtw1xXw1ktFyrXw1kWFX_yoWrKw4UpF
	45Ca4akr45JFWUt39xJF4DuF9xJ34kXFWUKrW7Jas8ur90yas8WFsrtFyUJ3W3ZrWkGrya
	qFZa9rW3WF15AwcCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Wrv_
	ZF1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jxxhdUUUUU=

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
v5: None
v4: Prefix all with tpm_lsse instead of tpm.
    Removed MODULE_AUTHOR fields.

v3: Added reminder about Loongson security engine to git log.

 drivers/char/tpm/Kconfig    |   9 ++++
 drivers/char/tpm/Makefile   |   1 +
 drivers/char/tpm/tpm_lsse.c | 103 ++++++++++++++++++++++++++++++++++++
 3 files changed, 113 insertions(+)
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
index 0000000000..b476309c97
--- /dev/null
+++ b/drivers/char/tpm/tpm_lsse.c
@@ -0,0 +1,103 @@
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
+struct tpm_lsse_msg {
+	u32 cmd;
+	u32 data_off;
+	u32 data_len;
+	u32 info[5];
+};
+
+struct tpm_lsse_dev {
+	struct lsse_ch *se_ch;
+	struct completion tpm_lsse_completion;
+};
+
+static void tpm_lsse_complete(struct lsse_ch *ch)
+{
+	struct tpm_lsse_dev *td = ch->priv;
+
+	complete(&td->tpm_lsse_completion);
+}
+
+static int tpm_lsse_recv(struct tpm_chip *chip, u8 *buf, size_t count)
+{
+	struct tpm_lsse_dev *td = dev_get_drvdata(&chip->dev);
+	struct tpm_lsse_msg *rmsg;
+	int sig;
+
+	sig = wait_for_completion_interruptible(&td->tpm_lsse_completion);
+	if (sig)
+		return sig;
+
+	rmsg = td->se_ch->rmsg;
+	memcpy(buf, td->se_ch->data_buffer, rmsg->data_len);
+
+	return rmsg->data_len;
+}
+
+static int tpm_lsse_send(struct tpm_chip *chip, u8 *buf, size_t count)
+{
+	struct tpm_lsse_dev *td = dev_get_drvdata(&chip->dev);
+	struct tpm_lsse_msg *smsg = td->se_ch->smsg;
+
+	memcpy(td->se_ch->data_buffer, buf, count);
+	smsg->data_len = count;
+
+	return se_send_ch_requeset(td->se_ch);
+}
+
+static const struct tpm_class_ops tpm_lsse_ops = {
+	.flags = TPM_OPS_AUTO_STARTUP,
+	.recv = tpm_lsse_recv,
+	.send = tpm_lsse_send,
+};
+
+static int tpm_lsse_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct tpm_lsse_msg *smsg;
+	struct tpm_lsse_dev *td;
+	struct tpm_chip *chip;
+
+	td = devm_kzalloc(dev, sizeof(struct tpm_lsse_dev), GFP_KERNEL);
+	if (!td)
+		return -ENOMEM;
+
+	init_completion(&td->tpm_lsse_completion);
+	td->se_ch = se_init_ch(dev->parent, SE_CH_TPM, PAGE_SIZE,
+			       2 * sizeof(struct tpm_lsse_msg), td,
+			       tpm_lsse_complete);
+	if (!td->se_ch)
+		return -ENODEV;
+	smsg = td->se_ch->smsg;
+	smsg->cmd = SE_CMD_TPM;
+	smsg->data_off = td->se_ch->off;
+
+	chip = tpmm_chip_alloc(dev, &tpm_lsse_ops);
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	chip->flags = TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_IRQ;
+	dev_set_drvdata(&chip->dev, td);
+
+	return tpm_chip_register(chip);
+}
+
+static struct platform_driver tpm_lsse_driver = {
+	.probe   = tpm_lsse_probe,
+	.driver  = {
+		.name  = "ls6000se-tpm",
+	},
+};
+module_platform_driver(tpm_lsse_driver);
+
+MODULE_ALIAS("platform:ls6000se-tpm");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Loongson TPM driver");
-- 
2.43.0


