Return-Path: <linux-integrity+bounces-6510-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AF26AE7974
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jun 2025 10:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E9CC7A3747
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Jun 2025 08:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4CA1EDA09;
	Wed, 25 Jun 2025 08:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRKEbPeK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9CA17A2F8;
	Wed, 25 Jun 2025 08:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750838733; cv=none; b=PbEuX5vAGkN3BbkI17eim/Bia3iKrcnMSLR6dMwfcrt8KZpBq0BnDHzLQfwYogdQMknMYmiivmydTCVBpAjosKB9TLKYNoGIa7EfJkA+RAxiQJOrhx3CHyVtUKXDKe35xp7YUFbj18dbgFPfA6P/WJ16jSRCGEzJNbZCDall71A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750838733; c=relaxed/simple;
	bh=aFMZBNy3/VRl880erNtl5opyOHksS+udQxCFuFgNaxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jeJlk7LmagRaEuJdwxS5zobnH0DIodj3USDe5fTlsJS1A8jQ1n2JN6Nc8I2vVx9/icRm2pF+EESxfuXhEEZ/3e2501IkjT3P8dXZmt4dYsK9Ci5OC7hwUvl84qDfrSAqHyvzVyi7D9ELfnkzlJFUB2r8QZMbZ3uPTdk9HJyeBSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRKEbPeK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48974C4CEEA;
	Wed, 25 Jun 2025 08:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750838732;
	bh=aFMZBNy3/VRl880erNtl5opyOHksS+udQxCFuFgNaxU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hRKEbPeK1kwVm+G+hspXLeZ8xLB+3tMDsuA08YEYENPK1HySl0Vhm0NYzCNBZyv9J
	 V+6Cf6I1sxRdXMrkn6JxVaaCBh2tq/li/ti5kZrMeawfDg2SAA4mxNcPqtC4bj1c+V
	 2O++TTxJLqXy3dGCsq5DeBWHbotd26bF9JixcD0KxlQ0Ou+0zcf5dDGIi992xbHd/6
	 xE5W4TRJhwJt4VE+QPuNiDXgfV/UtM75t04uNiAHwxKKo/znEIuvNv8Z2zUDHccnAI
	 sdSQuHZEeIWBw74b/2OKHNiLQzmJPYk1PT31U+3qd3cXyWkOQYkX5C0QksPghp4Wyb
	 DSpBt1Xj8zq6w==
Date: Wed, 25 Jun 2025 09:05:27 +0100
From: Lee Jones <lee@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Qunqin Zhao <zhaoqunqin@loongson.cn>, herbert@gondor.apana.org.au,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	davem@davemloft.net, linux-crypto@vger.kernel.org,
	peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	Yinggang Gu <guyinggang@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v11 3/4] tpm: Add a driver for Loongson TPM device
Message-ID: <20250625080527.GN795775@google.com>
References: <20250619025138.2854-1-zhaoqunqin@loongson.cn>
 <20250619025138.2854-4-zhaoqunqin@loongson.cn>
 <aFs2RDOeOKvWUN2L@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aFs2RDOeOKvWUN2L@kernel.org>

On Wed, 25 Jun 2025, Jarkko Sakkinen wrote:

> On Thu, Jun 19, 2025 at 10:51:37AM +0800, Qunqin Zhao wrote:
> > Loongson Security Engine supports random number generation, hash,
> > symmetric encryption and asymmetric encryption. Based on these
> > encryption functions, TPM2 have been implemented in the Loongson
> > Security Engine firmware. This driver is responsible for copying data
> > into the memory visible to the firmware and receiving data from the
> > firmware.
> > 
> > Co-developed-by: Yinggang Gu <guyinggang@loongson.cn>
> > Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> > Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
> > Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> > ---
> >  drivers/char/tpm/Kconfig        |  9 ++++
> >  drivers/char/tpm/Makefile       |  1 +
> >  drivers/char/tpm/tpm_loongson.c | 84 +++++++++++++++++++++++++++++++++
> >  3 files changed, 94 insertions(+)
> >  create mode 100644 drivers/char/tpm/tpm_loongson.c
> > 
> > diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> > index dddd702b2..ba3924eb1 100644
> > --- a/drivers/char/tpm/Kconfig
> > +++ b/drivers/char/tpm/Kconfig
> > @@ -189,6 +189,15 @@ config TCG_IBMVTPM
> >  	  will be accessible from within Linux.  To compile this driver
> >  	  as a module, choose M here; the module will be called tpm_ibmvtpm.
> >  
> > +config TCG_LOONGSON
> > +	tristate "Loongson TPM Interface"
> > +	depends on MFD_LOONGSON_SE
> > +	help
> > +	  If you want to make Loongson TPM support available, say Yes and
> > +	  it will be accessible from within Linux. To compile this
> > +	  driver as a module, choose M here; the module will be called
> > +	  tpm_loongson.
> > +
> >  config TCG_XEN
> >  	tristate "XEN TPM Interface"
> >  	depends on TCG_TPM && XEN
> > diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> > index 9de1b3ea3..5b5cdc0d3 100644
> > --- a/drivers/char/tpm/Makefile
> > +++ b/drivers/char/tpm/Makefile
> > @@ -46,3 +46,4 @@ obj-$(CONFIG_TCG_ARM_CRB_FFA) += tpm_crb_ffa.o
> >  obj-$(CONFIG_TCG_VTPM_PROXY) += tpm_vtpm_proxy.o
> >  obj-$(CONFIG_TCG_FTPM_TEE) += tpm_ftpm_tee.o
> >  obj-$(CONFIG_TCG_SVSM) += tpm_svsm.o
> > +obj-$(CONFIG_TCG_LOONGSON) += tpm_loongson.o
> > diff --git a/drivers/char/tpm/tpm_loongson.c b/drivers/char/tpm/tpm_loongson.c
> > new file mode 100644
> > index 000000000..5cbdb37f8
> > --- /dev/null
> > +++ b/drivers/char/tpm/tpm_loongson.c
> > @@ -0,0 +1,84 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2025 Loongson Technology Corporation Limited. */
> > +
> > +#include <linux/device.h>
> > +#include <linux/mfd/loongson-se.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/wait.h>
> > +
> > +#include "tpm.h"
> > +
> > +struct tpm_loongson_cmd {
> > +	u32 cmd_id;
> > +	u32 data_off;
> > +	u32 data_len;
> > +	u32 pad[5];
> > +};
> > +
> > +static int tpm_loongson_recv(struct tpm_chip *chip, u8 *buf, size_t count)
> > +{
> > +	struct loongson_se_engine *tpm_engine = dev_get_drvdata(&chip->dev);
> > +	struct tpm_loongson_cmd *cmd_ret = tpm_engine->command_ret;
> > +
> > +	if (cmd_ret->data_len > count)
> > +		return -EIO;
> > +
> > +	memcpy(buf, tpm_engine->data_buffer, cmd_ret->data_len);
> > +
> > +	return cmd_ret->data_len;
> > +}
> > +
> > +static int tpm_loongson_send(struct tpm_chip *chip, u8 *buf, size_t count)
> > +{
> > +	struct loongson_se_engine *tpm_engine = dev_get_drvdata(&chip->dev);
> > +	struct tpm_loongson_cmd *cmd = tpm_engine->command;
> > +
> > +	if (count > tpm_engine->buffer_size)
> > +		return -E2BIG;
> > +
> > +	cmd->data_len = count;
> > +	memcpy(tpm_engine->data_buffer, buf, count);
> > +
> > +	return loongson_se_send_engine_cmd(tpm_engine);
> > +}
> > +
> > +static const struct tpm_class_ops tpm_loongson_ops = {
> > +	.flags = TPM_OPS_AUTO_STARTUP,
> > +	.recv = tpm_loongson_recv,
> > +	.send = tpm_loongson_send,
> > +};
> > +
> > +static int tpm_loongson_probe(struct platform_device *pdev)
> > +{
> > +	struct loongson_se_engine *tpm_engine;
> > +	struct device *dev = &pdev->dev;
> > +	struct tpm_loongson_cmd *cmd;
> > +	struct tpm_chip *chip;
> > +
> > +	tpm_engine = loongson_se_init_engine(dev->parent, SE_ENGINE_TPM);
> > +	if (!tpm_engine)
> > +		return -ENODEV;
> > +	cmd = tpm_engine->command;
> > +	cmd->cmd_id = SE_CMD_TPM;
> > +	cmd->data_off = tpm_engine->buffer_off;
> > +
> > +	chip = tpmm_chip_alloc(dev, &tpm_loongson_ops);
> > +	if (IS_ERR(chip))
> > +		return PTR_ERR(chip);
> > +	chip->flags = TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_IRQ;
> > +	dev_set_drvdata(&chip->dev, tpm_engine);
> > +
> > +	return tpm_chip_register(chip);
> > +}
> > +
> > +static struct platform_driver tpm_loongson = {
> > +	.probe   = tpm_loongson_probe,
> > +	.driver  = {
> > +		.name  = "loongson-tpm",
> 
> This patch looks otherwise great but I'd prefer here tho use
> "tpm_loongson_probe" for the value of the name field.

Where does this stipulation come from?  No other driver does this [0].
driver.name should be a nicely formatted, human readable string
describing the name of the device.  Not a function name.

[0] git grep -A15 "static struct platform_driver" | grep ".name = .*probe"

-- 
Lee Jones [李琼斯]

