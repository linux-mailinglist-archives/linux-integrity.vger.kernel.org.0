Return-Path: <linux-integrity+bounces-5975-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C21A95659
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Apr 2025 20:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A4B918960AD
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Apr 2025 18:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7981EB5CB;
	Mon, 21 Apr 2025 18:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JDX5Hns2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E53B1DFDA5;
	Mon, 21 Apr 2025 18:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745261892; cv=none; b=cyQ0GtmC0xj2ZU8MULGFyTO0yMOrSkOgkHcy/GqXPD5b0NxA0FCx+FgX90ECqWkF99ygDopBhbQcO9nuMGfOCLd2nPylWdlhbjjQ9ibKMw6/U+99ba6u1HNGt9py4zeWgrciNTTHFZ7ZBotn5tnpSnq2bM5bFNwI4XIbLuOpytY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745261892; c=relaxed/simple;
	bh=B6sys5WdN91Aw6eHyVt/FtKngZPJQdoTWF7tsS23tyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lueq5Z+VqcssOhdzWm/k1TEenM80aro3W1WM9b9C8nX6VoUUTYuNtIfQix+04EQ/j1FEIN9dL3Zv2LEXojnLA/Rk0UTg/Re5uAH0x5EU0FqGngmDYU3rjx6v9WBre2Cm8pnGDEo6k1OSF1NqQMNHLIGc8kufRxT885SECl2cXRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JDX5Hns2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D548C4CEE4;
	Mon, 21 Apr 2025 18:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745261891;
	bh=B6sys5WdN91Aw6eHyVt/FtKngZPJQdoTWF7tsS23tyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JDX5Hns2KRvUaHfWr5Dk8GDwNDEtbg2c7Wf28ZBBW9rRno4JODflvPGjEaKPaEQkX
	 AmOoQU8cWNZGSymOq3w+GhIR8WOmJHDIvxW9l109Jz18A3a3ah3NulNnSZ9CxT1lRS
	 MAwI6Jcu3yvgURPQhFf/LP2mVSOeRX3yJBmdAhMhWdb5aUVkvwCH9rPYplGPFrq+X5
	 fwOk/sim0UaekNq0vOVxqtja4AyQWD/0sagTRn+KeOxsmvHkcBsDhXhRkPfFYjzzCs
	 MpkkyxAQvriLMT7Yw0jfs3Cyawiz6UGU65OSOPHTqA8p3SjRGG+9lK8BT/1o+xlYGf
	 IuHAJt6TXP7Mw==
Date: Mon, 21 Apr 2025 21:58:07 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, peterhuewe@gmx.de,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	linux-crypto@vger.kernel.org, jgg@ziepe.ca,
	linux-integrity@vger.kernel.org, pmenzel@molgen.mpg.de,
	Yinggang Gu <guyinggang@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v8 4/5] tpm: Add a driver for Loongson TPM device
Message-ID: <aAaVP8yG6rM436uw@kernel.org>
References: <20250418093407.1335-1-zhaoqunqin@loongson.cn>
 <20250418093407.1335-5-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250418093407.1335-5-zhaoqunqin@loongson.cn>

On Fri, Apr 18, 2025 at 05:34:06PM +0800, Qunqin Zhao wrote:
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
> v8: In the send callback, it will wait until the TPM2 command is
>     completed. So do not need to wait in the recv callback.
>     Removed Jarkko's tag cause there are some changes in v8
> 
> v7: Moved Kconfig entry between TCG_IBMVTPM and TCG_XEN.
>     Added Jarkko's tag(a little change, should be fine).
> 
> v6: Replace all "ls6000se" with "loongson"
>     Prefix all with tpm_loongson instead of tpm_lsse.
>     Removed Jarkko's tag cause there are some changes in v6
> 
> v5: None
> v4: Prefix all with tpm_lsse instead of tpm.
>     Removed MODULE_AUTHOR fields.
> 
> v3: Added reminder about Loongson security engine to git log.
> 
>  drivers/char/tpm/Kconfig        |  9 ++++
>  drivers/char/tpm/Makefile       |  1 +
>  drivers/char/tpm/tpm_loongson.c | 78 +++++++++++++++++++++++++++++++++
>  3 files changed, 88 insertions(+)
>  create mode 100644 drivers/char/tpm/tpm_loongson.c
> 
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index fe4f3a609..34302a875 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -189,6 +189,15 @@ config TCG_IBMVTPM
>  	  will be accessible from within Linux.  To compile this driver
>  	  as a module, choose M here; the module will be called tpm_ibmvtpm.
>  
> +config TCG_LOONGSON
> +	tristate "Loongson TPM Interface"
> +	depends on CRYPTO_DEV_LOONGSON_SE
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
> index 2b004df8c..cb534b235 100644
> --- a/drivers/char/tpm/Makefile
> +++ b/drivers/char/tpm/Makefile
> @@ -45,3 +45,4 @@ obj-$(CONFIG_TCG_CRB) += tpm_crb.o
>  obj-$(CONFIG_TCG_ARM_CRB_FFA) += tpm_crb_ffa.o
>  obj-$(CONFIG_TCG_VTPM_PROXY) += tpm_vtpm_proxy.o
>  obj-$(CONFIG_TCG_FTPM_TEE) += tpm_ftpm_tee.o
> +obj-$(CONFIG_TCG_LOONGSON) += tpm_loongson.o
> diff --git a/drivers/char/tpm/tpm_loongson.c b/drivers/char/tpm/tpm_loongson.c
> new file mode 100644
> index 000000000..c4d69d28d
> --- /dev/null
> +++ b/drivers/char/tpm/tpm_loongson.c
> @@ -0,0 +1,78 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Loongson Technology Corporation Limited. */
> +
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/wait.h>
> +
> +#include "../../drivers/crypto/loongson/loongson-se.h"
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
> +static struct platform_driver tpm_loongson_driver = {
> +	.probe   = tpm_loongson_probe,
> +	.driver  = {
> +		.name  = "loongson-tpm",
> +	},
> +};
> +module_platform_driver(tpm_loongson_driver);


It's otherwise fine but this should be just "tpm_loongson" :-)

+1 revision add

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

as long as this is renamed.

> +
> +MODULE_ALIAS("platform:loongson-tpm");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Loongson TPM driver");
> -- 
> 2.45.2
> 
> 

BR, Jarkko

