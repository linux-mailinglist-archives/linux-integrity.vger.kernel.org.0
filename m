Return-Path: <linux-integrity+bounces-5934-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC82A93556
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Apr 2025 11:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80D331B65828
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Apr 2025 09:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA58A2741B6;
	Fri, 18 Apr 2025 09:32:49 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACED26FDBF;
	Fri, 18 Apr 2025 09:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744968769; cv=none; b=eEYNjwhbGkwsUUWlVkmpx7rZqgskDZ/kcG8NiA9DlRgCxBMSqfKSm00+k5enXsh0CoGg2GyR38Sqe38BoE5QsKCEJMxFnh/4z4hfRGmk1Xi8YPdqm7Mmbu10VHC0c44rKrXufDaqRV5DfCfij4CcUqaZNTRxlUutkno62p7uYDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744968769; c=relaxed/simple;
	bh=rsAQHpoXjm0DVUp+feISvmwaBBAofmkY+c/dxc5Z9sU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DwpWxG9XbUhclsg1jhOUzr5mK/0MUN+jhmVETwx1YdhIIALK6BBbToQj208OSO1eppRy7EWVsNg1JKI18NfbypMidk3HM8QlNweem/7vfIis+5h5A0GUm9RrkwnHavKo8bbFFMTdymbmq0/v21sRF5kleQT3gUZck6tT0Few9co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.54.180])
	by gateway (Coremail) with SMTP id _____8AxWXE7HAJoSKLBAA--.58953S3;
	Fri, 18 Apr 2025 17:32:43 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.54.180])
	by front1 (Coremail) with SMTP id qMiowMCx_cYsHAJoGUKJAA--.15831S6;
	Fri, 18 Apr 2025 17:32:39 +0800 (CST)
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
Subject: [PATCH v8 4/5] tpm: Add a driver for Loongson TPM device
Date: Fri, 18 Apr 2025 17:34:06 +0800
Message-ID: <20250418093407.1335-5-zhaoqunqin@loongson.cn>
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
X-CM-TRANSID:qMiowMCx_cYsHAJoGUKJAA--.15831S6
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Gw1kXFWxCF1kCw1kZr4UJrc_yoW7Xr1rpF
	WrCa47Cr45Jr4jk39xArWDuFW3Z3s3XrWDKay7J34UuFyDA34rXryktFy7XF47Zrs7Gry2
	qFZ3CFW8uF1Uu3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1a6r1DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3
	AwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Q18PUUUUU==

Loongson Security Engine supports random number generation, hash,
symmetric encryption and asymmetric encryption. Based on these
encryption functions, TPM2 have been implemented in the Loongson
Security Engine firmware. This driver is responsible for copying data
into the memory visible to the firmware and receiving data from the
firmware.

Co-developed-by: Yinggang Gu <guyinggang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
---
v8: In the send callback, it will wait until the TPM2 command is
    completed. So do not need to wait in the recv callback.
    Removed Jarkko's tag cause there are some changes in v8

v7: Moved Kconfig entry between TCG_IBMVTPM and TCG_XEN.
    Added Jarkko's tag(a little change, should be fine).

v6: Replace all "ls6000se" with "loongson"
    Prefix all with tpm_loongson instead of tpm_lsse.
    Removed Jarkko's tag cause there are some changes in v6

v5: None
v4: Prefix all with tpm_lsse instead of tpm.
    Removed MODULE_AUTHOR fields.

v3: Added reminder about Loongson security engine to git log.

 drivers/char/tpm/Kconfig        |  9 ++++
 drivers/char/tpm/Makefile       |  1 +
 drivers/char/tpm/tpm_loongson.c | 78 +++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+)
 create mode 100644 drivers/char/tpm/tpm_loongson.c

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index fe4f3a609..34302a875 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -189,6 +189,15 @@ config TCG_IBMVTPM
 	  will be accessible from within Linux.  To compile this driver
 	  as a module, choose M here; the module will be called tpm_ibmvtpm.
 
+config TCG_LOONGSON
+	tristate "Loongson TPM Interface"
+	depends on CRYPTO_DEV_LOONGSON_SE
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
index 2b004df8c..cb534b235 100644
--- a/drivers/char/tpm/Makefile
+++ b/drivers/char/tpm/Makefile
@@ -45,3 +45,4 @@ obj-$(CONFIG_TCG_CRB) += tpm_crb.o
 obj-$(CONFIG_TCG_ARM_CRB_FFA) += tpm_crb_ffa.o
 obj-$(CONFIG_TCG_VTPM_PROXY) += tpm_vtpm_proxy.o
 obj-$(CONFIG_TCG_FTPM_TEE) += tpm_ftpm_tee.o
+obj-$(CONFIG_TCG_LOONGSON) += tpm_loongson.o
diff --git a/drivers/char/tpm/tpm_loongson.c b/drivers/char/tpm/tpm_loongson.c
new file mode 100644
index 000000000..c4d69d28d
--- /dev/null
+++ b/drivers/char/tpm/tpm_loongson.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Loongson Technology Corporation Limited. */
+
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/wait.h>
+
+#include "../../drivers/crypto/loongson/loongson-se.h"
+#include "tpm.h"
+
+struct tpm_loongson_cmd {
+	u32 cmd_id;
+	u32 data_off;
+	u32 data_len;
+	u32 pad[5];
+};
+
+static int tpm_loongson_recv(struct tpm_chip *chip, u8 *buf, size_t count)
+{
+	struct loongson_se_engine *tpm_engine = dev_get_drvdata(&chip->dev);
+	struct tpm_loongson_cmd *cmd_ret = tpm_engine->command_ret;
+
+	memcpy(buf, tpm_engine->data_buffer, cmd_ret->data_len);
+
+	return cmd_ret->data_len;
+}
+
+static int tpm_loongson_send(struct tpm_chip *chip, u8 *buf, size_t count)
+{
+	struct loongson_se_engine *tpm_engine = dev_get_drvdata(&chip->dev);
+	struct tpm_loongson_cmd *cmd = tpm_engine->command;
+
+	cmd->data_len = count;
+	memcpy(tpm_engine->data_buffer, buf, count);
+
+	return loongson_se_send_engine_cmd(tpm_engine);
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
+	struct loongson_se_engine *tpm_engine;
+	struct device *dev = &pdev->dev;
+	struct tpm_loongson_cmd *cmd;
+	struct tpm_chip *chip;
+
+	tpm_engine = loongson_se_init_engine(dev->parent, SE_ENGINE_TPM);
+	if (!tpm_engine)
+		return -ENODEV;
+	cmd = tpm_engine->command;
+	cmd->cmd_id = SE_CMD_TPM;
+	cmd->data_off = tpm_engine->buffer_off;
+
+	chip = tpmm_chip_alloc(dev, &tpm_loongson_ops);
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	chip->flags = TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_IRQ;
+	dev_set_drvdata(&chip->dev, tpm_engine);
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


