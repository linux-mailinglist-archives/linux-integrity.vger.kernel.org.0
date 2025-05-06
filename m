Return-Path: <linux-integrity+bounces-6147-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E5AAAC78F
	for <lists+linux-integrity@lfdr.de>; Tue,  6 May 2025 16:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85FD7167B9A
	for <lists+linux-integrity@lfdr.de>; Tue,  6 May 2025 14:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDBE281517;
	Tue,  6 May 2025 14:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KO8PBTyP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF9E280313
	for <linux-integrity@vger.kernel.org>; Tue,  6 May 2025 14:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746540799; cv=none; b=K5CfzGTRDrXbdTg/RgDHQpIcp5EQWfSS/CiPPdBSSkuTfklw6Bq+jbaVJGxmCBnubVeXXfxBRr8XN/HzfAY4RaD/GEGszmqNVvl5K+gYyHRBRnX20g6QTWy1wckrqCrcV62mKLmYhlQ9dTjCMdADJO4nSS4ZyRWs2foRNJOvRlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746540799; c=relaxed/simple;
	bh=dvnpBTc5+V4/wKRdMg2GHV3TaYrI7wpbz7l2TiXkoro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=joOS+J4FI2q2CcTr9gpUlIUBX5jkIqXiXx+jEXAzHH9ImrrRywyAR0h+/BiNXS4vx3oTqnBWXNhyN1CmpYN3jq9MBM2QeOVkzEdcQQiOncLcFA0/5WVpsfJVnPQ7uM5ip8HBZ6Tt1MDsF86yXRRovXfSKakEt3MEvfIpF5PV+OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KO8PBTyP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746540796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UFcgBeXDokvr+kUt+Nx4wd/ULZnjMDwH1N2JLsWAOOw=;
	b=KO8PBTyPZxY9cAOtCPYyFjwSiN/wNOgbWV+YemoYvrx88icew8wprVcvnBJIYwCUEl1SSc
	E49KQswV4JFBup6D7oD7RaIzXQTe+vpASykTR47tmJ+BS7eJerGl/5Y75bxHDVORMXwHQD
	boZbtMLX8l5Ig1ci8aKZ9MHxXYt68Ak=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-6jzqjjt6Od28Gmw-S-HjPA-1; Tue, 06 May 2025 10:13:14 -0400
X-MC-Unique: 6jzqjjt6Od28Gmw-S-HjPA-1
X-Mimecast-MFC-AGG-ID: 6jzqjjt6Od28Gmw-S-HjPA_1746540794
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-acb8f9f58ebso427995566b.2
        for <linux-integrity@vger.kernel.org>; Tue, 06 May 2025 07:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746540793; x=1747145593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFcgBeXDokvr+kUt+Nx4wd/ULZnjMDwH1N2JLsWAOOw=;
        b=sRACQO17B5quFN62e8wbPxxxxKADKS2Q8oUTnYDZ4Sf3r5QZeqruVFNBV6MaNL+YWO
         PprTeyIS3AvWn33eWO5FeycZMTQ2JmaYUS3EjyvDN9L1zH3rN+bNCEC66sVMyIQbG0sM
         QcyD8uIYFsSuCurt7UBpSTuIZGTVcsWLDv2a0kqPkKsF8CG8XnUsYtNWgZM2505Vn7ot
         Kyoz+3k4IDNL2KvTisKM2o9Ku4scjhXv0fBEUGgjMElW7nutqKViXwQOQ2RhFmKnPiOT
         BL7u51+IJt4+aj76z1vipkwnHdbSMWxbYz8veXhbQ+biQaQUUSCaSXCgzeX44g6qVexF
         CE5w==
X-Forwarded-Encrypted: i=1; AJvYcCXCP+0BAGBzRfutsHs5MmAzbTQ/VBXYp8cMY3ab25t13rXhnRm6ojVbO6TkmjY/56YB303NRXZJPC2FjbXX5bg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6NJXOvc2TZaqaRoOfqTJ2DsuRTNBr0Q776t9L69i0RnqyrzkM
	UMKd8N+xn93b0xWjZmHMRhIC3dGRFfNFhcdjdyp5mmWL1/kEAOfLAF/8lXQd6lGW2FORBZnz2NP
	uhFEowl0tCspzSqVs1I23uj6POTZ+d01yyxS2d7E9i0XygNWQ5tNHpGQn0XGUyiEnpg==
X-Gm-Gg: ASbGncsGgvePjPxbmLoKwdDPm5u+2JnY8ps7LDBGPz6BVqG96HJ7RMItVBRKBzCqdIg
	s7noEPhIiQnsHGBFdL+lerR0nokKfCWpD+0lswyS3QFoXlCcqZqPiVqqpcoyYFL+q0SL3XD1rbd
	Mtl7Xucavbr9lsoAMnSt2F6AeRFOu8GTn8tYhm80oarXRppvQoXyUlgRh1gjBPnqwu6aEPdjBZK
	r6aIW0aVb4u2XRFY3wCuIFgLEOX1YD/vk3SMLqPJVkvHKmbHH4VWybCrnoODn5bqrF2WgruamGL
	AzFHUDyG8sTDqu53
X-Received: by 2002:a17:907:a08e:b0:ace:9d4e:d0cd with SMTP id a640c23a62f3a-ad1a48bd2c0mr1016932366b.7.1746540793550;
        Tue, 06 May 2025 07:13:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBtjlS6sVWj/jhXomSr6feRAM5taE6rOBhOmzWM1geyTp2Xsw9XEuNk4QndQH7TAg8XB5sEA==
X-Received: by 2002:a17:907:a08e:b0:ace:9d4e:d0cd with SMTP id a640c23a62f3a-ad1a48bd2c0mr1016929066b.7.1746540793005;
        Tue, 06 May 2025 07:13:13 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.145.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad18914d031sm710777166b.20.2025.05.06.07.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 07:13:12 -0700 (PDT)
Date: Tue, 6 May 2025 16:13:04 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: lee@kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net, 
	peterhuewe@gmx.de, jarkko@kernel.org, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-crypto@vger.kernel.org, jgg@ziepe.ca, 
	linux-integrity@vger.kernel.org, pmenzel@molgen.mpg.de, Yinggang Gu <guyinggang@loongson.cn>, 
	Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v9 4/5] tpm: Add a driver for Loongson TPM device
Message-ID: <2nuadbg5awe6gvagxg7t5ewvxsbmiq4qrcrycvnrmt2etzq2ke@6oyzavctwrma>
References: <20250506031947.11130-1-zhaoqunqin@loongson.cn>
 <20250506031947.11130-5-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250506031947.11130-5-zhaoqunqin@loongson.cn>

On Tue, May 06, 2025 at 11:19:46AM +0800, Qunqin Zhao wrote:
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
>Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>---
>v9: "tpm_loongson_driver" --> "tpm_loongson"
>    "depends on CRYPTO_DEV_LOONGSON_SE" --> "depends on MFD_LOONGSON_SE"
>
>v8: In the send callback, it will wait until the TPM2 command is
>    completed. So do not need to wait in the recv callback.
>    Removed Jarkko's tag cause there are some changes in v8
>
>v7: Moved Kconfig entry between TCG_IBMVTPM and TCG_XEN.
>    Added Jarkko's tag(a little change, should be fine).
>
>v6: Replace all "ls6000se" with "loongson"
>    Prefix all with tpm_loongson instead of tpm_lsse.
>    Removed Jarkko's tag cause there are some changes in v6
>
>v5: None
>v4: Prefix all with tpm_lsse instead of tpm.
>    Removed MODULE_AUTHOR fields.
>
>v3: Added reminder about Loongson security engine to git log.
>
> drivers/char/tpm/Kconfig        |  9 ++++
> drivers/char/tpm/Makefile       |  1 +
> drivers/char/tpm/tpm_loongson.c | 78 +++++++++++++++++++++++++++++++++
> 3 files changed, 88 insertions(+)
> create mode 100644 drivers/char/tpm/tpm_loongson.c
>
>diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
>index fe4f3a609..13f0682c6 100644
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
>index 2b004df8c..cb534b235 100644
>--- a/drivers/char/tpm/Makefile
>+++ b/drivers/char/tpm/Makefile
>@@ -45,3 +45,4 @@ obj-$(CONFIG_TCG_CRB) += tpm_crb.o
> obj-$(CONFIG_TCG_ARM_CRB_FFA) += tpm_crb_ffa.o
> obj-$(CONFIG_TCG_VTPM_PROXY) += tpm_vtpm_proxy.o
> obj-$(CONFIG_TCG_FTPM_TEE) += tpm_ftpm_tee.o
>+obj-$(CONFIG_TCG_LOONGSON) += tpm_loongson.o
>diff --git a/drivers/char/tpm/tpm_loongson.c b/drivers/char/tpm/tpm_loongson.c
>new file mode 100644
>index 000000000..cbbd9c22a
>--- /dev/null
>+++ b/drivers/char/tpm/tpm_loongson.c
>@@ -0,0 +1,78 @@
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
>+	memcpy(buf, tpm_engine->data_buffer, cmd_ret->data_len);

Should we limit the memcpy to `count`?

I mean, can happen that `count` is less than `cmd_ret->data_len`?

Thanks,
Stefano

>+
>+	return cmd_ret->data_len;
>+}
>+
>+static int tpm_loongson_send(struct tpm_chip *chip, u8 *buf, size_t count)
>+{
>+	struct loongson_se_engine *tpm_engine = dev_get_drvdata(&chip->dev);
>+	struct tpm_loongson_cmd *cmd = tpm_engine->command;
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
>+		.name  = "loongson-tpm",
>+	},
>+};
>+module_platform_driver(tpm_loongson);
>+
>+MODULE_ALIAS("platform:loongson-tpm");
>+MODULE_LICENSE("GPL");
>+MODULE_DESCRIPTION("Loongson TPM driver");
>-- 
>2.45.2
>
>


