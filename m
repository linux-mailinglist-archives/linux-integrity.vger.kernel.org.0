Return-Path: <linux-integrity+bounces-6650-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5999BB0AFAE
	for <lists+linux-integrity@lfdr.de>; Sat, 19 Jul 2025 14:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D32053B1C07
	for <lists+linux-integrity@lfdr.de>; Sat, 19 Jul 2025 12:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD467224227;
	Sat, 19 Jul 2025 12:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gbzfNgO+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF0172629;
	Sat, 19 Jul 2025 12:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752926978; cv=none; b=tW8V+Ya8tJXW1lIRkNdMBJvgo7BgtZ1VTNBJ7xnfoe4FjVkRNitGess1ZYj95VwpTfUtMJ/xly1DRIow5gJwhYqnSVR3bZg4b2bt50bxYm83DLAwpes9LvroSqnpuViiLzM4+4UEjnBmgRFWtRUtEuhiNYIMc7A/bwWNGtwSLEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752926978; c=relaxed/simple;
	bh=fn8YKQ7uo24LYlUXF5nhxlSDkHFZ7BfRQEgFvald5DQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idH7h9am3IeJa3hlEzP4gzqlmUD1W5LwKoaYR7WAiqe7Z53a77Bis+TTuz354K7qA8IbbVR+G2Ukh1KTPRJD++UKrsm5xy2BSgGL9ryDePplX9zwejjD+g7Hnn23jZAHeHgYqt4MmcB8HuDUEXlzYOoxBYkBWOa9gdhAc4rU8TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gbzfNgO+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25EBBC4CEE3;
	Sat, 19 Jul 2025 12:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752926978;
	bh=fn8YKQ7uo24LYlUXF5nhxlSDkHFZ7BfRQEgFvald5DQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gbzfNgO+gNc1/m/rzqJxptbWswW03Ne9ZkgRQ0blpJoai+V27hkVFiPDRAiLrTO2d
	 VFTQY3lW1U4rDOa2wX6Tm7+9+gL6HJtVnllzgaq+SCr+RaiPGKsPVRMVDnJvV5XTzP
	 asaUG9tufPYhStkZv3WcbzcLi5qZjFtEft1Va+1XRJdZ1KTKj2uGw1JvT14YZNpwOg
	 Y5FJfSNVGidE0uW13wZdFlPpxA2L/uUK4gavstmt6hf3Ql3oxhbm+bIT5fDNt/btvi
	 XRNy8ancv6qUcf5VKRsCDab7rYGt8z3YhLWzGkp/44wT17uMEJbDZdp2EaM/+Ph6RC
	 o2B6OQ8mhieew==
Date: Sat, 19 Jul 2025 15:09:34 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: lee@kernel.org, herbert@gondor.apana.org.au,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	davem@davemloft.net, linux-crypto@vger.kernel.org,
	peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	Yinggang Gu <guyinggang@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v12 3/4] tpm: Add a driver for Loongson TPM device
Message-ID: <aHuK_pY2Ap4B7JWZ@kernel.org>
References: <20250705072045.1067-1-zhaoqunqin@loongson.cn>
 <20250705072045.1067-4-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250705072045.1067-4-zhaoqunqin@loongson.cn>

On Sat, Jul 05, 2025 at 03:20:44PM +0800, Qunqin Zhao wrote:
> Loongson Security Engine supports random number generation, hash,
> symmetric encryption and asymmetric encryption. Based on these
> encryption functions, TPM2 have been implemented in the Loongson
> Security Engine firmware. This driver is responsible for copying data
> into the memory visible to the firmware and receiving data from the
> firmware.
> 
> Co-developed-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  drivers/char/tpm/Kconfig        |  9 ++++
>  drivers/char/tpm/Makefile       |  1 +
>  drivers/char/tpm/tpm_loongson.c | 84 +++++++++++++++++++++++++++++++++
>  3 files changed, 94 insertions(+)
>  create mode 100644 drivers/char/tpm/tpm_loongson.c
> 
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index dddd702b2..ba3924eb1 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -189,6 +189,15 @@ config TCG_IBMVTPM
>  	  will be accessible from within Linux.  To compile this driver
>  	  as a module, choose M here; the module will be called tpm_ibmvtpm.
>  
> +config TCG_LOONGSON
> +	tristate "Loongson TPM Interface"
> +	depends on MFD_LOONGSON_SE
> +	help
> +	  If you want to make Loongson TPM support available, say Yes and
> +	  it will be accessible from within Linux. To compile this
> +	  driver as a module, choose M here; the module will be called
> +	  tpm_loongson.
> +
>  config TCG_XEN
>  	tristate "XEN TPM Interface"
>  	depends on TCG_TPM && XEN
> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> index 9de1b3ea3..5b5cdc0d3 100644
> --- a/drivers/char/tpm/Makefile
> +++ b/drivers/char/tpm/Makefile
> @@ -46,3 +46,4 @@ obj-$(CONFIG_TCG_ARM_CRB_FFA) += tpm_crb_ffa.o
>  obj-$(CONFIG_TCG_VTPM_PROXY) += tpm_vtpm_proxy.o
>  obj-$(CONFIG_TCG_FTPM_TEE) += tpm_ftpm_tee.o
>  obj-$(CONFIG_TCG_SVSM) += tpm_svsm.o
> +obj-$(CONFIG_TCG_LOONGSON) += tpm_loongson.o
> diff --git a/drivers/char/tpm/tpm_loongson.c b/drivers/char/tpm/tpm_loongson.c
> new file mode 100644
> index 000000000..a4ec23639
> --- /dev/null
> +++ b/drivers/char/tpm/tpm_loongson.c
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Loongson Technology Corporation Limited. */
> +
> +#include <linux/device.h>
> +#include <linux/mfd/loongson-se.h>
> +#include <linux/platform_device.h>
> +#include <linux/wait.h>
> +
> +#include "tpm.h"
> +
> +struct tpm_loongson_cmd {
> +	u32 cmd_id;
> +	u32 data_off;
> +	u32 data_len;
> +	u32 pad[5];
> +};
> +
> +static int tpm_loongson_recv(struct tpm_chip *chip, u8 *buf, size_t count)
> +{
> +	struct loongson_se_engine *tpm_engine = dev_get_drvdata(&chip->dev);
> +	struct tpm_loongson_cmd *cmd_ret = tpm_engine->command_ret;
> +
> +	if (cmd_ret->data_len > count)
> +		return -EIO;
> +
> +	memcpy(buf, tpm_engine->data_buffer, cmd_ret->data_len);
> +
> +	return cmd_ret->data_len;
> +}
> +
> +static int tpm_loongson_send(struct tpm_chip *chip, u8 *buf, size_t count)
> +{
> +	struct loongson_se_engine *tpm_engine = dev_get_drvdata(&chip->dev);
> +	struct tpm_loongson_cmd *cmd = tpm_engine->command;
> +
> +	if (count > tpm_engine->buffer_size)
> +		return -E2BIG;
> +
> +	cmd->data_len = count;
> +	memcpy(tpm_engine->data_buffer, buf, count);
> +
> +	return loongson_se_send_engine_cmd(tpm_engine);
> +}
> +
> +static const struct tpm_class_ops tpm_loongson_ops = {
> +	.flags = TPM_OPS_AUTO_STARTUP,
> +	.recv = tpm_loongson_recv,
> +	.send = tpm_loongson_send,
> +};
> +
> +static int tpm_loongson_probe(struct platform_device *pdev)
> +{
> +	struct loongson_se_engine *tpm_engine;
> +	struct device *dev = &pdev->dev;
> +	struct tpm_loongson_cmd *cmd;
> +	struct tpm_chip *chip;
> +
> +	tpm_engine = loongson_se_init_engine(dev->parent, SE_ENGINE_TPM);
> +	if (!tpm_engine)
> +		return -ENODEV;
> +	cmd = tpm_engine->command;
> +	cmd->cmd_id = SE_CMD_TPM;
> +	cmd->data_off = tpm_engine->buffer_off;
> +
> +	chip = tpmm_chip_alloc(dev, &tpm_loongson_ops);
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +	chip->flags = TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_IRQ;
> +	dev_set_drvdata(&chip->dev, tpm_engine);
> +
> +	return tpm_chip_register(chip);
> +}
> +
> +static struct platform_driver tpm_loongson = {
> +	.probe   = tpm_loongson_probe,
> +	.driver  = {
> +		.name  = "tpm_loongson",
> +	},
> +};
> +module_platform_driver(tpm_loongson);
> +
> +MODULE_ALIAS("platform:tpm_loongson");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Loongson TPM driver");
> -- 
> 2.45.2
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Can you take this through loongson tree? It's highly unlikely to
conflict with anything.

BR, Jarkko

