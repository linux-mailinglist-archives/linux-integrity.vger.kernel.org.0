Return-Path: <linux-integrity+bounces-6504-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BC6AE7354
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jun 2025 01:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 072667B1B3B
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Jun 2025 23:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86E125A2CE;
	Tue, 24 Jun 2025 23:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRhtQ6V3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92668190664;
	Tue, 24 Jun 2025 23:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750808136; cv=none; b=XkjcS6m3dPwojO1yciy3viIMpelRlpjMB8yoDI4LE8LPUN6FDhOdkl0wyb1aBxniR3YjLrPE3aTuIzCOFpEHrzQ+iEddi/Mpuysnw5ZQExmrbxXg/QlMdmikr151hEBM7uuqOPzE1kXvcWKLYdqHfr30PwhSwBmeiDOn1gZfvqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750808136; c=relaxed/simple;
	bh=DBSni6pXshmHKrIebjfJdljvqz+aDXOLlSVsdM1Y+BY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZOmjSJAdKjmtfHUhxvhZfYPQRri/a/FLL6UWWqyP25OK2yf1i2XhLgYGmSQWxwcbZF/wiE0mlLtVsoeo2z4hXbB8BskRg+q2qP+QjQHeniibgO/F+U4epnLD761sdDXJXdMcEe3GQP62QG3sDNn3wB2MwT2yfWsjTIxGsH3Yhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRhtQ6V3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9513AC4CEE3;
	Tue, 24 Jun 2025 23:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750808136;
	bh=DBSni6pXshmHKrIebjfJdljvqz+aDXOLlSVsdM1Y+BY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HRhtQ6V3o9Diw0R9OYYSQfaIr7Taf1gXaiOIDxUgTlWcRZVayB6sw5B2QQURXvsZG
	 g2NFejNtNuPvqOuAq9hzibyeXJo0kJ7MFVCUJ9IrrGlz52ocLq6K+uZ+Ko8F8bCfBd
	 ymMhAeAwhoh/cPe99Yqi3N2kX2M46eJUBkeXKpu1BI8jiV+5YLXQAAHhkrLF2tCApr
	 fusjJFLWmRdtVjK0KAmvJmyVv82ouFhhM8gAxZbZi1tvZjAA346liH9DXuooypOn1l
	 N5wnZcyGxM/NTx1nv6rBFAMb7XKUxdA/sGWNoLiRicr6GAeN5RACFUJ0MVLGtXFlGF
	 C2O6X6RIgYAQA==
Date: Wed, 25 Jun 2025 02:35:32 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: lee@kernel.org, herbert@gondor.apana.org.au,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	davem@davemloft.net, linux-crypto@vger.kernel.org,
	peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	Yinggang Gu <guyinggang@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v11 3/4] tpm: Add a driver for Loongson TPM device
Message-ID: <aFs2RDOeOKvWUN2L@kernel.org>
References: <20250619025138.2854-1-zhaoqunqin@loongson.cn>
 <20250619025138.2854-4-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619025138.2854-4-zhaoqunqin@loongson.cn>

On Thu, Jun 19, 2025 at 10:51:37AM +0800, Qunqin Zhao wrote:
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
> index 000000000..5cbdb37f8
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
> +		.name  = "loongson-tpm",

This patch looks otherwise great but I'd prefer here tho use
"tpm_loongson_probe" for the value of the name field.

> +	},
> +};
> +module_platform_driver(tpm_loongson);
> +
> +MODULE_ALIAS("platform:loongson-tpm");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Loongson TPM driver");
> -- 
> 2.45.2
> 

BR, Jarkko

