Return-Path: <linux-integrity+bounces-6637-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5077AAFB029
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Jul 2025 11:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D79A165BBF
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Jul 2025 09:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6BF293C77;
	Mon,  7 Jul 2025 09:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NCQNC38z"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581F1293C68
	for <linux-integrity@vger.kernel.org>; Mon,  7 Jul 2025 09:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751881705; cv=none; b=BARkqC/kbsqQGQ8cInx2v6V9hamSY0X0okc1JimVEi54ywOGXX8ts5iYLz8CK1Cj0nN781E1w0Pgw8aQKwmBDvy86Cspe0wkC7itLG+eZQH+vo7yOPz7OcAkrN5qHixjzqzvL7WSYUv7wdHh2c2YGbrA8q1N4mVO5I2siJRJaf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751881705; c=relaxed/simple;
	bh=9dAF3cEjm8FTwqY4rSN+zW6ytqAo718oWGU0+iw7aHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQsKQaPmkQTMOAOZlOS0OQZnIy41mOCGxf+3erIIzvxWLygbONwPy23JtYuEzy3Tj5lQFSBgNqY1BbIih4CSGO6dOkhYPiu1Zh3px9EyIILBoNUQa/jj34NPJE6p0GFOJ01MjkLJsyVFfDb77LgRenwaBabg/+kfScHU6OC1iJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NCQNC38z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751881702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l2eNwpRiJz06WSkXzHwTd+TpkPf6RGsoGF5CBNNzDXI=;
	b=NCQNC38zNC3JZfYZwOCJxgQjiApqW6KaPpq6z2XdHiQNBs2VIu0cHs0OZeJS6MTHfNxa20
	820tTq/xy8RGadIOf1mrtRyUIRlOY+fW2zgSqXV1RSEZWYYezYsPRN1VaMaa5dfCpK5fUV
	KclnDuxsB1ovyt7laH26CK0bm+whLns=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-1CeLRbA1Ob2t3Zq-nNPKYg-1; Mon, 07 Jul 2025 05:48:21 -0400
X-MC-Unique: 1CeLRbA1Ob2t3Zq-nNPKYg-1
X-Mimecast-MFC-AGG-ID: 1CeLRbA1Ob2t3Zq-nNPKYg_1751881700
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6fb3466271fso52859056d6.0
        for <linux-integrity@vger.kernel.org>; Mon, 07 Jul 2025 02:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751881700; x=1752486500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l2eNwpRiJz06WSkXzHwTd+TpkPf6RGsoGF5CBNNzDXI=;
        b=jGITOpcm61obGn9C1OmcNdEyz8swlAtMgmMnZgWFzBimtzrl6l6nDgs6AR/jKB/6Mk
         eBXlGeTAeeDqPDJbf7Hioy6L7RKUBaKtKRQaSSluwT48CkSfx3pianlHvJghG3eHcQrV
         nTN+C0sZ+ipbYioXKgV5CqwTD/I5/gOhspGzFCLZKcw5UveXkGS/IVC6yS51lhUfXTmG
         T6J3XjpSm4Xv3mEwkwz4XMFhIgOGEYa+S306aIj0ruYgbYJmJ0M1UXpEKghuRkdXSWVT
         C/2IYxw9gVBuxqYQ42bjpUPvSXfh53HhE787P+ZsJm5hNFNXHd/aDNC8wpPr3eI39l4o
         QSxQ==
X-Forwarded-Encrypted: i=1; AJvYcCULATkFgGDMwVF0b8Pka/SUf9y+52kTR4YfM3AEZVn8FYuqW9XW5wQgBwTqs0SLgnyJVPju35bJYEtHy1px8Dk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6qCI3eGH0LOVg12wCYEStfwKMnGLJk+kZJ3A07tbT1OWAH103
	MrhZ6DOxdkzLHcHJmXRXv4IgAvvWLt8WSuCCbJjSeDsPtg0bF43yQFvkI4faa64MSzi6L2DjMeU
	K4jFRtjZisrXrAt1Mv+cnCB+OnccJTGcBsi+JlCmxPd7EBagDMqLDKJPOIp5Eixn2ZC4TvA==
X-Gm-Gg: ASbGnctLByfOawxDcce1g4lw0HNs+TpBgMXWWwl6eBqbgttpJTpVe8tAc06Xbf/zP63
	BeGOs7BgBrckF3Q8ZPxaj7lN4rTCqwPDjSF+wSLnP4jM9Y0prpNHLKS8fcjpHPxOpdLmMUgxmbq
	IWhF3bDn1VH6vzFgF4XfKRcA2NqhzhBt8ti59r5jhEogifVPDqBw44Yq+bmK1tOIlBh7BrDr+3N
	Mwn7OQzpesFr8q0XgZxujIkNP5T3jmrScQ1F75dYWd+vxKUpRSQ1xnNgg09oOgcvRpvOjjQoz5S
	h/itdFQ6/1VFcOSzDMXmXEF2DdY=
X-Received: by 2002:a05:6214:4d03:b0:702:bcf6:34ad with SMTP id 6a1803df08f44-702c4e526d3mr166782366d6.12.1751881700460;
        Mon, 07 Jul 2025 02:48:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8iMbasc13Fuwl+kvH+EXxUYVaBsAF6X+9vjiPzFiXhyNXG8gzIQz568Gm4AGMdxJ9Ye1AUA==
X-Received: by 2002:a05:6214:4d03:b0:702:bcf6:34ad with SMTP id 6a1803df08f44-702c4e526d3mr166782136d6.12.1751881700017;
        Mon, 07 Jul 2025 02:48:20 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.202.41])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4cc75afsm55632036d6.5.2025.07.07.02.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 02:48:19 -0700 (PDT)
Date: Mon, 7 Jul 2025 11:48:07 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: lee@kernel.org, herbert@gondor.apana.org.au, jarkko@kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, davem@davemloft.net, 
	linux-crypto@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org, 
	Yinggang Gu <guyinggang@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v12 3/4] tpm: Add a driver for Loongson TPM device
Message-ID: <4uhbqaq6obk626r6dk27opaksuwezizx5bpq4eacqjogrdk6as@sinmwzhfjrsn>
References: <20250705072045.1067-1-zhaoqunqin@loongson.cn>
 <20250705072045.1067-4-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250705072045.1067-4-zhaoqunqin@loongson.cn>

On Sat, Jul 05, 2025 at 03:20:44PM +0800, Qunqin Zhao wrote:
>Loongson Security Engine supports random number generation, hash,
>symmetric encryption and asymmetric encryption. Based on these
>encryption functions, TPM2 have been implemented in the Loongson
>Security Engine firmware. This driver is responsible for copying data
>into the memory visible to the firmware and receiving data from the
>firmware.
>
>Co-developed-by: Yinggang Gu <guyinggang@loongson.cn>
>Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
>Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
>Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
>---
> drivers/char/tpm/Kconfig        |  9 ++++
> drivers/char/tpm/Makefile       |  1 +
> drivers/char/tpm/tpm_loongson.c | 84 +++++++++++++++++++++++++++++++++
> 3 files changed, 94 insertions(+)
> create mode 100644 drivers/char/tpm/tpm_loongson.c

TPM_CHIP_FLAG_SYNC support is now merged in linux-tpmdd/next tree, so 
IMHO this driver can also set it and implement a synchronous send() in 
this way (untested):

diff --git a/drivers/char/tpm/tpm_loongson.c b/drivers/char/tpm/tpm_loongson.c
index a4ec23639911..0e8eb8cee13c 100644
--- a/drivers/char/tpm/tpm_loongson.c
+++ b/drivers/char/tpm/tpm_loongson.c
@@ -15,36 +15,35 @@ struct tpm_loongson_cmd {
  	u32 pad[5];
  };

-static int tpm_loongson_recv(struct tpm_chip *chip, u8 *buf, size_t count)
+static int tpm_loongson_send(struct tpm_chip *chip, u8 *buf, size_t bufsiz,
+			     size_t cmd_len)
  {
  	struct loongson_se_engine *tpm_engine = dev_get_drvdata(&chip->dev);
-	struct tpm_loongson_cmd *cmd_ret = tpm_engine->command_ret;
-
-	if (cmd_ret->data_len > count)
-		return -EIO;
+	struct tpm_loongson_cmd *cmd = tpm_engine->command;
+	struct tpm_loongson_cmd *cmd_ret;
+	int ret;

-	memcpy(buf, tpm_engine->data_buffer, cmd_ret->data_len);
+	if (cmd_len > tpm_engine->buffer_size)
+		return -E2BIG;

-	return cmd_ret->data_len;
-}
+	cmd->data_len = cmd_len;
+	memcpy(tpm_engine->data_buffer, buf, cmd_len);

-static int tpm_loongson_send(struct tpm_chip *chip, u8 *buf, size_t count)
-{
-	struct loongson_se_engine *tpm_engine = dev_get_drvdata(&chip->dev);
-	struct tpm_loongson_cmd *cmd = tpm_engine->command;
+	ret = loongson_se_send_engine_cmd(tpm_engine);
+	if (ret)
+		return ret;

-	if (count > tpm_engine->buffer_size)
-		return -E2BIG;
+	cmd_ret = tpm_engine->command_ret;
+	if (cmd_ret->data_len > bufsiz)
+		return -EIO;

-	cmd->data_len = count;
-	memcpy(tpm_engine->data_buffer, buf, count);
+	memcpy(buf, tpm_engine->data_buffer, cmd_ret->data_len);

-	return loongson_se_send_engine_cmd(tpm_engine);
+	return cmd_ret->data_len;
  }

  static const struct tpm_class_ops tpm_loongson_ops = {
  	.flags = TPM_OPS_AUTO_STARTUP,
-	.recv = tpm_loongson_recv,
  	.send = tpm_loongson_send,
  };

@@ -65,7 +64,7 @@ static int tpm_loongson_probe(struct platform_device *pdev)
  	chip = tpmm_chip_alloc(dev, &tpm_loongson_ops);
  	if (IS_ERR(chip))
  		return PTR_ERR(chip);
-	chip->flags = TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_IRQ;
+	chip->flags = TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_SYNC;
  	dev_set_drvdata(&chip->dev, tpm_engine);

  	return tpm_chip_register(chip);

Thanks,
Stefano

>
>diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
>index dddd702b2..ba3924eb1 100644
>--- a/drivers/char/tpm/Kconfig
>+++ b/drivers/char/tpm/Kconfig
>@@ -189,6 +189,15 @@ config TCG_IBMVTPM
> 	  will be accessible from within Linux.  To compile this driver
> 	  as a module, choose M here; the module will be called tpm_ibmvtpm.
>
>+config TCG_LOONGSON
>+	tristate "Loongson TPM Interface"
>+	depends on MFD_LOONGSON_SE
>+	help
>+	  If you want to make Loongson TPM support available, say Yes and
>+	  it will be accessible from within Linux. To compile this
>+	  driver as a module, choose M here; the module will be called
>+	  tpm_loongson.
>+
> config TCG_XEN
> 	tristate "XEN TPM Interface"
> 	depends on TCG_TPM && XEN
>diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
>index 9de1b3ea3..5b5cdc0d3 100644
>--- a/drivers/char/tpm/Makefile
>+++ b/drivers/char/tpm/Makefile
>@@ -46,3 +46,4 @@ obj-$(CONFIG_TCG_ARM_CRB_FFA) += tpm_crb_ffa.o
> obj-$(CONFIG_TCG_VTPM_PROXY) += tpm_vtpm_proxy.o
> obj-$(CONFIG_TCG_FTPM_TEE) += tpm_ftpm_tee.o
> obj-$(CONFIG_TCG_SVSM) += tpm_svsm.o
>+obj-$(CONFIG_TCG_LOONGSON) += tpm_loongson.o
>diff --git a/drivers/char/tpm/tpm_loongson.c b/drivers/char/tpm/tpm_loongson.c
>new file mode 100644
>index 000000000..a4ec23639
>--- /dev/null
>+++ b/drivers/char/tpm/tpm_loongson.c
>@@ -0,0 +1,84 @@
>+// SPDX-License-Identifier: GPL-2.0
>+/* Copyright (c) 2025 Loongson Technology Corporation Limited. */
>+
>+#include <linux/device.h>
>+#include <linux/mfd/loongson-se.h>
>+#include <linux/platform_device.h>
>+#include <linux/wait.h>
>+
>+#include "tpm.h"
>+
>+struct tpm_loongson_cmd {
>+	u32 cmd_id;
>+	u32 data_off;
>+	u32 data_len;
>+	u32 pad[5];
>+};
>+
>+static int tpm_loongson_recv(struct tpm_chip *chip, u8 *buf, size_t count)
>+{
>+	struct loongson_se_engine *tpm_engine = dev_get_drvdata(&chip->dev);
>+	struct tpm_loongson_cmd *cmd_ret = tpm_engine->command_ret;
>+
>+	if (cmd_ret->data_len > count)
>+		return -EIO;
>+
>+	memcpy(buf, tpm_engine->data_buffer, cmd_ret->data_len);
>+
>+	return cmd_ret->data_len;
>+}
>+
>+static int tpm_loongson_send(struct tpm_chip *chip, u8 *buf, size_t count)
>+{
>+	struct loongson_se_engine *tpm_engine = dev_get_drvdata(&chip->dev);
>+	struct tpm_loongson_cmd *cmd = tpm_engine->command;
>+
>+	if (count > tpm_engine->buffer_size)
>+		return -E2BIG;
>+
>+	cmd->data_len = count;
>+	memcpy(tpm_engine->data_buffer, buf, count);
>+
>+	return loongson_se_send_engine_cmd(tpm_engine);
>+}
>+
>+static const struct tpm_class_ops tpm_loongson_ops = {
>+	.flags = TPM_OPS_AUTO_STARTUP,
>+	.recv = tpm_loongson_recv,
>+	.send = tpm_loongson_send,
>+};
>+
>+static int tpm_loongson_probe(struct platform_device *pdev)
>+{
>+	struct loongson_se_engine *tpm_engine;
>+	struct device *dev = &pdev->dev;
>+	struct tpm_loongson_cmd *cmd;
>+	struct tpm_chip *chip;
>+
>+	tpm_engine = loongson_se_init_engine(dev->parent, SE_ENGINE_TPM);
>+	if (!tpm_engine)
>+		return -ENODEV;
>+	cmd = tpm_engine->command;
>+	cmd->cmd_id = SE_CMD_TPM;
>+	cmd->data_off = tpm_engine->buffer_off;
>+
>+	chip = tpmm_chip_alloc(dev, &tpm_loongson_ops);
>+	if (IS_ERR(chip))
>+		return PTR_ERR(chip);
>+	chip->flags = TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_IRQ;
>+	dev_set_drvdata(&chip->dev, tpm_engine);
>+
>+	return tpm_chip_register(chip);
>+}
>+
>+static struct platform_driver tpm_loongson = {
>+	.probe   = tpm_loongson_probe,
>+	.driver  = {
>+		.name  = "tpm_loongson",
>+	},
>+};
>+module_platform_driver(tpm_loongson);
>+
>+MODULE_ALIAS("platform:tpm_loongson");
>+MODULE_LICENSE("GPL");
>+MODULE_DESCRIPTION("Loongson TPM driver");
>-- 
>2.45.2
>
>


