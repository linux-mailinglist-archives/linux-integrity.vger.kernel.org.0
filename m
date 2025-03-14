Return-Path: <linux-integrity+bounces-5281-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6B7A613E3
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Mar 2025 15:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00EE68811D6
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Mar 2025 14:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BC82010E1;
	Fri, 14 Mar 2025 14:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFpQYiNn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128A91FF5EB;
	Fri, 14 Mar 2025 14:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741963411; cv=none; b=LDHRCGmgjnVP41cAVeLq7cZu4rtko8HyeKiVnT5PdNo4T1VT5wl07xBhqDptm4xagWK2TeuS5hP6nLr94Q1k+J0v6sY75AXA6dczThUjyWp0EftHGG0NT8W7/6BdVUg//phiohxumGGBONK9+S/OXrHWbV4KaCOiJVPQHFoSb3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741963411; c=relaxed/simple;
	bh=OmBBejdQ6MPMCpK44mLQ8HFIWOmjQLb426wFuXj8jkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrJ6Jy0Rm1kN+GNbu2RpJEmhHsFYezTygQ2FUL2FJPCVY+js4GEIcvweflwFRA+PwQuD2xnMFYL3sbrI5P7AP1FeOy1f20MQhfjlV5yAiQep0Y+1nJmqfvVUyflJ0r3a4Fa6ZXDOkAZiFD1zZwEH330c2M67a7YCiz72q8KRcho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFpQYiNn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59AE6C4CEE3;
	Fri, 14 Mar 2025 14:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741963410;
	bh=OmBBejdQ6MPMCpK44mLQ8HFIWOmjQLb426wFuXj8jkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fFpQYiNn8BK3GSRaTkmH0zb+nSODczrSo69/HHZE/fMKliEr410dXzUTJouOtgdNg
	 xEYwcbf/tS7qU51N9IWwh0i+KWxQAYFvXNDFLRFNIAWMBLuhS3GTD+bnC2IPfrdyyO
	 fwa3QixFnKqg26v6mucQdL2Hy5aAu3ea6Y1436znV7A8rhZfQsZq7x+IyAgCCKqOuH
	 hmU1jikY5AWdBinYN0XvBA5S8lH8hFUbGpNZ1NO7mVou81GVSm6jDO4A+xZtMcIyD9
	 K7mhPXySTl/kCt2LngJaYm7ocd7e5j6uTShuOy0VNdKQSNNetcGuOy/sxPDcWmFO4Q
	 sSW7cc2XVUWUQ==
Date: Fri, 14 Mar 2025 16:43:26 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: lee@kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net,
	peterhuewe@gmx.de, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-crypto@vger.kernel.org,
	jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	pmenzel@molgen.mpg.de, Yinggang Gu <guyinggang@loongson.cn>
Subject: Re: [PATCH v5 5/6] tpm: Add a driver for Loongson TPM device
Message-ID: <Z9RAjuhBS62HD55L@kernel.org>
References: <20250313090702.21300-1-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313090702.21300-1-zhaoqunqin@loongson.cn>

On Thu, Mar 13, 2025 at 05:07:01PM +0800, Qunqin Zhao wrote:
> Loongson security engine supports random number generation, hash,
> symmetric encryption and asymmetric encryption. Based on these
> encryption functions, TPM2 have been implemented in the Loongson
> security engine firmware. This driver is responsible for copying data
> into the memory visible to the firmware and receiving data from the firmware.
> Co-developed-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
> ---
> v5: None
> v4: Prefix all with tpm_lsse instead of tpm.
>     Removed MODULE_AUTHOR fields.
> 
> v3: Added reminder about Loongson security engine to git log.
> 
>  drivers/char/tpm/Kconfig    |   9 ++++
>  drivers/char/tpm/Makefile   |   1 +
>  drivers/char/tpm/tpm_lsse.c | 103 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 113 insertions(+)
>  create mode 100644 drivers/char/tpm/tpm_lsse.c
> 
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
> index 0000000000..b476309c97
> --- /dev/null
> +++ b/drivers/char/tpm/tpm_lsse.c
> @@ -0,0 +1,103 @@
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
> +struct tpm_lsse_msg {
> +	u32 cmd;
> +	u32 data_off;
> +	u32 data_len;
> +	u32 info[5];
> +};
> +
> +struct tpm_lsse_dev {
> +	struct lsse_ch *se_ch;
> +	struct completion tpm_lsse_completion;
> +};
> +
> +static void tpm_lsse_complete(struct lsse_ch *ch)
> +{
> +	struct tpm_lsse_dev *td = ch->priv;
> +
> +	complete(&td->tpm_lsse_completion);
> +}
> +
> +static int tpm_lsse_recv(struct tpm_chip *chip, u8 *buf, size_t count)
> +{
> +	struct tpm_lsse_dev *td = dev_get_drvdata(&chip->dev);
> +	struct tpm_lsse_msg *rmsg;
> +	int sig;
> +
> +	sig = wait_for_completion_interruptible(&td->tpm_lsse_completion);
> +	if (sig)
> +		return sig;
> +
> +	rmsg = td->se_ch->rmsg;
> +	memcpy(buf, td->se_ch->data_buffer, rmsg->data_len);
> +
> +	return rmsg->data_len;
> +}
> +
> +static int tpm_lsse_send(struct tpm_chip *chip, u8 *buf, size_t count)
> +{
> +	struct tpm_lsse_dev *td = dev_get_drvdata(&chip->dev);
> +	struct tpm_lsse_msg *smsg = td->se_ch->smsg;
> +
> +	memcpy(td->se_ch->data_buffer, buf, count);
> +	smsg->data_len = count;
> +
> +	return se_send_ch_requeset(td->se_ch);
> +}
> +
> +static const struct tpm_class_ops tpm_lsse_ops = {
> +	.flags = TPM_OPS_AUTO_STARTUP,
> +	.recv = tpm_lsse_recv,
> +	.send = tpm_lsse_send,
> +};
> +
> +static int tpm_lsse_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct tpm_lsse_msg *smsg;
> +	struct tpm_lsse_dev *td;
> +	struct tpm_chip *chip;
> +
> +	td = devm_kzalloc(dev, sizeof(struct tpm_lsse_dev), GFP_KERNEL);
> +	if (!td)
> +		return -ENOMEM;
> +
> +	init_completion(&td->tpm_lsse_completion);
> +	td->se_ch = se_init_ch(dev->parent, SE_CH_TPM, PAGE_SIZE,
> +			       2 * sizeof(struct tpm_lsse_msg), td,
> +			       tpm_lsse_complete);
> +	if (!td->se_ch)
> +		return -ENODEV;
> +	smsg = td->se_ch->smsg;
> +	smsg->cmd = SE_CMD_TPM;
> +	smsg->data_off = td->se_ch->off;
> +
> +	chip = tpmm_chip_alloc(dev, &tpm_lsse_ops);
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +	chip->flags = TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_IRQ;
> +	dev_set_drvdata(&chip->dev, td);
> +
> +	return tpm_chip_register(chip);
> +}
> +
> +static struct platform_driver tpm_lsse_driver = {
> +	.probe   = tpm_lsse_probe,
> +	.driver  = {
> +		.name  = "ls6000se-tpm",
> +	},
> +};
> +module_platform_driver(tpm_lsse_driver);
> +
> +MODULE_ALIAS("platform:ls6000se-tpm");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Loongson TPM driver");
> -- 
> 2.43.0
> 
> 

Makes sense to me and obviously operations list is just send and
receive, given TPM_CHIP_FLAG_IRQ.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

