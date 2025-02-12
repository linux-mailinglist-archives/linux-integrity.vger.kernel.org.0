Return-Path: <linux-integrity+bounces-4801-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1201A33176
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Feb 2025 22:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49FA17A1CF2
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Feb 2025 21:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C6B202F61;
	Wed, 12 Feb 2025 21:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjdQU5r0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A79201025;
	Wed, 12 Feb 2025 21:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739395714; cv=none; b=Ok9Al4J9c9lFQEttcHjRUI88svhiD7/bi4RkrfzqEj/EUixl3ekIWzJ3WRX9CVLQciE6QZB0kYfzq6koivpIQgSdJ4qEqPdP9k4gMZ5AOvL/6AFZ7KGEaI1KydrxY9TiZNBL1onwsLdbzlaUmWReX8BqvIerlQB5rJ6WE6ki0p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739395714; c=relaxed/simple;
	bh=3wVlpaRQ6HPfHX6my7rDrBIwcLZA9m/C84oqxjK6E+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1HF9y8GocMbRoGM30uQS5CNfG8eLl0fUw+qmzUCr8Dijg9roTLHbmBogIheBvPoEnhvYI9jeydmpbtM3VxdSo5klXh3FpH+AOEYaQgD2HEFqz3rx0dYqna9VuxsYqP736Upo0WKX/K//iXByTq0F0cdx1K2jmJVq3EBsbt6jmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rjdQU5r0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B5DC4CEDF;
	Wed, 12 Feb 2025 21:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739395713;
	bh=3wVlpaRQ6HPfHX6my7rDrBIwcLZA9m/C84oqxjK6E+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rjdQU5r0bsOd4U/htAFwpC/28QAXrNGZZHgrnbhlETG6GBxYyp+KYpp+IYKbVLSjR
	 J79MRB0Kp6GHXjI6p2qRnipvuJ71KNJOvAZ8eOtTOKt3O1DE9YuBXjo2L2ObV8mR8F
	 gzwy+kWHPchM7j/qCnhT9RNyF5Pxiwa91OMjTUiiuY3Sp1a4b/Xtl4WtmCH58bziDk
	 wzX26DvIJY6BdqZxdi+0bS8fHlo6iM319RVPgET7QItZeAl5sFMoFyywXB2VZ7JusJ
	 tfVcV9Wcn3Vyb+/9GU7UyC+TectuuqV1Kc1g/IwrsbV9fO6VSoOX6m7UMTFaBDnAgz
	 PFhgGdXejgtnA==
Date: Wed, 12 Feb 2025 23:28:28 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: lee@kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net,
	peterhuewe@gmx.de, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-crypto@vger.kernel.org,
	jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	Yinggang Gu <guyinggang@loongson.cn>
Subject: Re: [PATCH v2 3/3] tpm: Add a driver for Loongson TPM device
Message-ID: <Z60SfDaWnbgddUnA@kernel.org>
References: <20250212033113.15137-1-zhaoqunqin@loongson.cn>
 <20250212033113.15137-4-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212033113.15137-4-zhaoqunqin@loongson.cn>

On Wed, Feb 12, 2025 at 11:31:13AM +0800, Qunqin Zhao wrote:
> TPM2.0 is implemented in Loongson security engine. This is the driver

TPM 2.0 or just TPM2 (either is fine with me). Quick reminder what 
Loongson security engine (I could not know that and it would be nice
to have that in git log).

> for it.
> 
> Co-developed-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
> ---
>  MAINTAINERS                 |   1 +
>  drivers/char/tpm/Kconfig    |   9 ++++
>  drivers/char/tpm/Makefile   |   1 +
>  drivers/char/tpm/tpm_lsse.c | 104 ++++++++++++++++++++++++++++++++++++
>  4 files changed, 115 insertions(+)
>  create mode 100644 drivers/char/tpm/tpm_lsse.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6493d58436..6aad0f08ad 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13484,6 +13484,7 @@ LOONGSON CRYPTO DRIVER
>  M:	Qunqin Zhao <zhaoqunqin@loongson.com>
>  L:	linux-crypto@vger.kernel.org
>  S:	Maintained
> +F:	drivers/char/tpm/tpm_lsse.c
>  F:	drivers/crypto/loongson/
>  
>  LOONGSON-2 APB DMA DRIVER

Probably MAINTAINERS update should be a separate patch.

> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index 0fc9a510e0..56d0417065 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -225,5 +225,14 @@ config TCG_FTPM_TEE
>  	help
>  	  This driver proxies for firmware TPM running in TEE.
>  
> +config TCG_LSSE
> +	tristate "Loongson TPM Interface"
> +	depends on MFD_LS6000SE
> +	help
> +	  If you want to make Loongson TPM support available, say Yes and
> +	  it will be accessible from within Linux. To compile this
> +	  driver as a module, choose M here; the module will be called
> +	  tpm_lsse.
> +
>  source "drivers/char/tpm/st33zp24/Kconfig"
>  endif # TCG_TPM
> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> index 9bb142c752..bf2280352d 100644
> --- a/drivers/char/tpm/Makefile
> +++ b/drivers/char/tpm/Makefile
> @@ -44,3 +44,4 @@ obj-$(CONFIG_TCG_XEN) += xen-tpmfront.o
>  obj-$(CONFIG_TCG_CRB) += tpm_crb.o
>  obj-$(CONFIG_TCG_VTPM_PROXY) += tpm_vtpm_proxy.o
>  obj-$(CONFIG_TCG_FTPM_TEE) += tpm_ftpm_tee.o
> +obj-$(CONFIG_TCG_LSSE) += tpm_lsse.o
> diff --git a/drivers/char/tpm/tpm_lsse.c b/drivers/char/tpm/tpm_lsse.c
> new file mode 100644
> index 0000000000..3fd2d9bac8
> --- /dev/null
> +++ b/drivers/char/tpm/tpm_lsse.c
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Loongson Technology Corporation Limited. */
> +
> +#include <linux/device.h>
> +#include <linux/mfd/ls6000se.h>
> +#include <linux/platform_device.h>
> +#include <linux/wait.h>
> +
> +#include "tpm.h"
> +
> +struct tpm_msg {
> +	u32 cmd;
> +	u32 data_off;
> +	u32 data_len;
> +	u32 info[5];
> +};
> +
> +struct tpm_dev {
> +	struct lsse_ch *se_ch;
> +	struct completion tpm_completion;
> +};
> +
> +static void tpm_complete(struct lsse_ch *ch)
> +{
> +	struct tpm_dev *td = ch->priv;
> +
> +	complete(&td->tpm_completion);
> +}
> +
> +static int tpm_ls_recv(struct tpm_chip *chip, u8 *buf, size_t count)
> +{
> +	struct tpm_dev *td = dev_get_drvdata(&chip->dev);
> +	struct tpm_msg *rmsg;
> +	int sig;
> +
> +	sig = wait_for_completion_interruptible(&td->tpm_completion);
> +	if (sig)
> +		return sig;
> +
> +	rmsg = td->se_ch->rmsg;
> +	memcpy(buf, td->se_ch->data_buffer, rmsg->data_len);
> +
> +	return rmsg->data_len;
> +}
> +
> +static int tpm_ls_send(struct tpm_chip *chip, u8 *buf, size_t count)
> +{
> +	struct tpm_dev *td = dev_get_drvdata(&chip->dev);
> +	struct tpm_msg *smsg = td->se_ch->smsg;
> +
> +	memcpy(td->se_ch->data_buffer, buf, count);
> +	smsg->data_len = count;
> +
> +	return se_send_ch_requeset(td->se_ch);
> +}
> +
> +static const struct tpm_class_ops lsse_tpm_ops = {
> +	.flags = TPM_OPS_AUTO_STARTUP,
> +	.recv = tpm_ls_recv,
> +	.send = tpm_ls_send,
> +};
> +
> +static int lsse_tpm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct tpm_chip *chip;
> +	struct tpm_msg *smsg;
> +	struct tpm_dev *td;
> +
> +	td = devm_kzalloc(dev, sizeof(struct tpm_dev), GFP_KERNEL);
> +	if (!td)
> +		return -ENOMEM;
> +
> +	init_completion(&td->tpm_completion);
> +	td->se_ch = se_init_ch(dev->parent, SE_CH_TPM, PAGE_SIZE,
> +			       2 * sizeof(struct tpm_msg), td, tpm_complete);
> +	if (!td->se_ch)
> +		return -ENODEV;
> +	smsg = td->se_ch->smsg;
> +	smsg->cmd = SE_CMD_TPM;
> +	smsg->data_off = td->se_ch->off;
> +
> +	chip = tpmm_chip_alloc(dev, &lsse_tpm_ops);
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +	chip->flags = TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_IRQ;
> +	dev_set_drvdata(&chip->dev, td);
> +
> +	return tpm_chip_register(chip);
> +}
> +
> +static struct platform_driver lsse_tpm_driver = {
> +	.probe   = lsse_tpm_probe,
> +	.driver  = {
> +		.name  = "ls6000se-tpm",
> +	},
> +};
> +module_platform_driver(lsse_tpm_driver);
> +
> +MODULE_ALIAS("platform:ls6000se-tpm");
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Yinggang Gu <guyinggang@loongson.cn>");
> +MODULE_AUTHOR("Qunqin Zhao <zhaoqunqin@loongson.cn>");
> +MODULE_DESCRIPTION("Loongson TPM driver");
> -- 
> 2.43.0
> 

BR, Jarkko

