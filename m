Return-Path: <linux-integrity+bounces-5475-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C752A7335D
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 14:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93E237A5C69
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 13:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0009D215067;
	Thu, 27 Mar 2025 13:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQfWeqvx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C689E2628D;
	Thu, 27 Mar 2025 13:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743082252; cv=none; b=KPULdEqPrgzKodrrkVqYPLt7VXY/2ao6F96BJ5wrPPGi7SJMV8ZvDuxocBmCLpAVFXZLKIDoRn4BqkTqcRMUeV/akcW3AOlm0fcSzKNt4jHnhuGgnZWFzxd08I2YZHTf/9YGXFp4LReEJDcWnQ5jY9m4Eri5q3g8U3FVfZpokIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743082252; c=relaxed/simple;
	bh=KNzepvaJce7nN+Yf+N5ir4vhknCticdnWSTq0WQXG5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIc7FaCdcJFpjigO7VZ3YwPZY3mcb7Wr35rAjnq32lvcbgvdItmZTWLiFptMYd6jsHLdxt+Hsr2tqmJeKhZ9/y9ibPpc+icPjqLjmtxPTCL7KYadrDLQRUYhQqhDBwQ/kqwWVFOVB2CdTzVaIcHTPWNribgxAgEp5xex625+81o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQfWeqvx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55F0C4CEDD;
	Thu, 27 Mar 2025 13:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743082252;
	bh=KNzepvaJce7nN+Yf+N5ir4vhknCticdnWSTq0WQXG5A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oQfWeqvxlDKLdZ8qHbjbLrY/aAcU6K0sjwm09Mz+yw9xnUTg6pnBCt7TbyN/Pr259
	 g7KrAUT6RuLdB28dGltGdClYwSEiKEP4lnIZjqmE68O7OI5YtIeSk6teATCo/1FEyV
	 1f8vkbyrwG0BwOp7IsntlE+LGyHlx0wioAIEz57pblV/pEcVyJK0V0Cr7sT40u8YUZ
	 oQkLFVaUfbFoPs2Tkktm4zgQE3rLE2XmmI/mujgMP8KrVQ4fLxH3vGa2ikiQ72XI2t
	 z0RM2j9Dfy4h4QO3z00ZKEEIjaSV/bOMCPEbiZe7lRS/95IVIqeUchekEzzthggb73
	 bDTsWHnraQinw==
Date: Thu, 27 Mar 2025 15:30:48 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: lee@kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net,
	peterhuewe@gmx.de, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-crypto@vger.kernel.org,
	jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	pmenzel@molgen.mpg.de, Yinggang Gu <guyinggang@loongson.cn>
Subject: Re: [PATCH v6 5/6] tpm: Add a driver for Loongson TPM device
Message-ID: <Z-VTCLg2hSV7YmMz@kernel.org>
References: <20250327021940.29969-1-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327021940.29969-1-zhaoqunqin@loongson.cn>

On Thu, Mar 27, 2025 at 10:19:39AM +0800, Qunqin Zhao wrote:
> Loongson security engine supports random number generation, hash,
> symmetric encryption and asymmetric encryption. Based on these
> encryption functions, TPM2 have been implemented in the Loongson
> security engine firmware. This driver is responsible for copying data
> into the memory visible to the firmware and receiving data from the
> firmware.
> 
> Co-developed-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
> ---
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
>  drivers/char/tpm/Kconfig        |   9 +++
>  drivers/char/tpm/Makefile       |   1 +
>  drivers/char/tpm/tpm_loongson.c | 103 ++++++++++++++++++++++++++++++++
>  3 files changed, 113 insertions(+)
>  create mode 100644 drivers/char/tpm/tpm_loongson.c
> 
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index 0fc9a510e..5d0e7a1f8 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -225,5 +225,14 @@ config TCG_FTPM_TEE
>  	help
>  	  This driver proxies for firmware TPM running in TEE.
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
>  source "drivers/char/tpm/st33zp24/Kconfig"
>  endif # TCG_TPM
> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> index 9bb142c75..e84a2f7a9 100644
> --- a/drivers/char/tpm/Makefile
> +++ b/drivers/char/tpm/Makefile
> @@ -44,3 +44,4 @@ obj-$(CONFIG_TCG_XEN) += xen-tpmfront.o
>  obj-$(CONFIG_TCG_CRB) += tpm_crb.o
>  obj-$(CONFIG_TCG_VTPM_PROXY) += tpm_vtpm_proxy.o
>  obj-$(CONFIG_TCG_FTPM_TEE) += tpm_ftpm_tee.o
> +obj-$(CONFIG_TCG_LOONGSON) += tpm_loongson.o
> diff --git a/drivers/char/tpm/tpm_loongson.c b/drivers/char/tpm/tpm_loongson.c
> new file mode 100644
> index 000000000..91e0390c8
> --- /dev/null
> +++ b/drivers/char/tpm/tpm_loongson.c
> @@ -0,0 +1,103 @@
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
> +struct tpm_loongson_msg {
> +	u32 cmd;
> +	u32 data_off;
> +	u32 data_len;
> +	u32 info[5];
> +};
> +
> +struct tpm_loongson_dev {
> +	struct lsse_ch *se_ch;
> +	struct completion tpm_loongson_completion;
> +};
> +
> +static void tpm_loongson_complete(struct lsse_ch *ch)
> +{
> +	struct tpm_loongson_dev *td = ch->priv;
> +
> +	complete(&td->tpm_loongson_completion);
> +}
> +
> +static int tpm_loongson_recv(struct tpm_chip *chip, u8 *buf, size_t count)
> +{
> +	struct tpm_loongson_dev *td = dev_get_drvdata(&chip->dev);
> +	struct tpm_loongson_msg *rmsg;
> +	int sig;
> +
> +	sig = wait_for_completion_interruptible(&td->tpm_loongson_completion);
> +	if (sig)
> +		return sig;
> +
> +	rmsg = td->se_ch->rmsg;
> +	memcpy(buf, td->se_ch->data_buffer, rmsg->data_len);
> +
> +	return rmsg->data_len;
> +}
> +
> +static int tpm_loongson_send(struct tpm_chip *chip, u8 *buf, size_t count)
> +{
> +	struct tpm_loongson_dev *td = dev_get_drvdata(&chip->dev);
> +	struct tpm_loongson_msg *smsg = td->se_ch->smsg;
> +
> +	memcpy(td->se_ch->data_buffer, buf, count);
> +	smsg->data_len = count;
> +
> +	return se_send_ch_requeset(td->se_ch);
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
> +	struct device *dev = &pdev->dev;
> +	struct tpm_loongson_msg *smsg;
> +	struct tpm_loongson_dev *td;
> +	struct tpm_chip *chip;
> +
> +	td = devm_kzalloc(dev, sizeof(struct tpm_loongson_dev), GFP_KERNEL);
> +	if (!td)
> +		return -ENOMEM;
> +
> +	init_completion(&td->tpm_loongson_completion);
> +	td->se_ch = se_init_ch(dev->parent, SE_CH_TPM, PAGE_SIZE,
> +			       2 * sizeof(struct tpm_loongson_msg), td,
> +			       tpm_loongson_complete);
> +	if (!td->se_ch)
> +		return -ENODEV;
> +	smsg = td->se_ch->smsg;
> +	smsg->cmd = SE_CMD_TPM;
> +	smsg->data_off = td->se_ch->off;
> +
> +	chip = tpmm_chip_alloc(dev, &tpm_loongson_ops);
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +	chip->flags = TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_IRQ;
> +	dev_set_drvdata(&chip->dev, td);
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
> +
> +MODULE_ALIAS("platform:loongson-tpm");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Loongson TPM driver");
> -- 
> 2.45.2
> 

Looks good to me.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

