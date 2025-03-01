Return-Path: <linux-integrity+bounces-5030-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFB8A4A7B0
	for <lists+linux-integrity@lfdr.de>; Sat,  1 Mar 2025 02:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 000133B8F40
	for <lists+linux-integrity@lfdr.de>; Sat,  1 Mar 2025 01:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF01E14A629;
	Sat,  1 Mar 2025 01:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8/52ggW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECA285C5E;
	Sat,  1 Mar 2025 01:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740793910; cv=none; b=Tqu/Osqsxeef3n27ex4t1WxYJq68UsNygvFJVA8P8Dl8GBV3m5mi6vgZcwfDJzxLCTa3bKHieGJrOBUi6+AaI0i8W5WNCjzTPTeGktuhIAXm6du5gx6Rvr27N0ehrJGapHU8YPm3mt7sUffFfTz4WZpsG8OUhebrWoKad6QiRqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740793910; c=relaxed/simple;
	bh=15rONcc9qjiLlXXjyOVHoZ0qnj2RwvIUpFjoXyrBmGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6jYJj28WrK+3ORVGiRLF6qiGU+rZVXux+glI7O/Wud4FOJOxL38464lS081xij3ICJ6U1fnMRVW/36V4ZAtUd26bRAr6x3keJaae7lhOjM8SjhCxOYFCjsnWQnC3Lij1kccrEtnP2bjFi8De1AphsSoNzQZmJs+/bVT0BSipcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8/52ggW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14188C4CED6;
	Sat,  1 Mar 2025 01:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740793910;
	bh=15rONcc9qjiLlXXjyOVHoZ0qnj2RwvIUpFjoXyrBmGw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q8/52ggWgJNPhmS80YqYZ58UsUa3X4jBdgZLeettP1hCEx6P4onovGuGO8T3t/2kR
	 isYSYn4dLofVrkFu4WWYJLtNvVNpMaOrRaT8Pt7+jq0jifkl3koLN0nyt19ztBJKcD
	 ldNWN4o/UhQGumDFlmKx10tcQ3lhu35AuzvUsr3o0bIqIzuCh1a4QoBGGIy91SAllR
	 L/f/uTCD+ai6aOXmQeqdRNLcmbmxMK8vIDQjXwPU5WBif0b9lnGINSCVrBWpvExYK4
	 YWK2OIY1OTDAX5ksx5KO0GW+g4dZTf9OxpyVrrEnf+Tok9j7Tpq+Vapq8Nc+fS1Quz
	 SlhrWgjXKPewQ==
Date: Sat, 1 Mar 2025 03:51:46 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>, x86@kernel.org,
	Dov Murik <dovmurik@linux.ibm.com>, linux-coco@lists.linux.dev,
	Dionna Glaze <dionnaglaze@google.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH v2 5/6] tpm: add SNP SVSM vTPM driver
Message-ID: <Z8JoMrUm9Dnoqgoi@kernel.org>
References: <20250228170720.144739-1-sgarzare@redhat.com>
 <20250228170720.144739-6-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228170720.144739-6-sgarzare@redhat.com>

On Fri, Feb 28, 2025 at 06:07:19PM +0100, Stefano Garzarella wrote:
> Add driver for the vTPM defined by the AMD SVSM spec [1].
> 
> The specification defines a protocol that a SEV-SNP guest OS can use to
> discover and talk to a vTPM emulated by the Secure VM Service Module (SVSM)
> in the guest context, but at a more privileged level (VMPL0).
> 
> The new tpm-svsm platform driver uses two functions exposed by x86/sev
> to verify that the device is actually emulated by the platform and to
> send commands and receive responses.
> 
> The vTPM is emulated through the TCG reference implementation, so this
> driver leverages tpm_tcgsim.h to fill commands and parse responses.

Why? Please don't.

> 
> The device cannot be hot-plugged/unplugged as it is emulated by the
> platform, so we can use module_platform_driver_probe(). The probe
> function will only check whether in the current runtime configuration,
> SVSM is present and provides a vTPM.
> 
> [1] "Secure VM Service Module for SEV-SNP Guests"
>     Publication # 58019 Revision: 1.00
>     https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  drivers/char/tpm/tpm_svsm.c | 120 ++++++++++++++++++++++++++++++++++++
>  drivers/char/tpm/Kconfig    |  10 +++
>  drivers/char/tpm/Makefile   |   1 +
>  3 files changed, 131 insertions(+)
>  create mode 100644 drivers/char/tpm/tpm_svsm.c
> 
> diff --git a/drivers/char/tpm/tpm_svsm.c b/drivers/char/tpm/tpm_svsm.c
> new file mode 100644
> index 000000000000..1c34133990c5
> --- /dev/null
> +++ b/drivers/char/tpm/tpm_svsm.c
> @@ -0,0 +1,120 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
> + *
> + * Driver for the vTPM defined by the AMD SVSM spec [1].
> + *
> + * The specification defines a protocol that a SEV-SNP guest OS can use to
> + * discover and talk to a vTPM emulated by the Secure VM Service Module (SVSM)
> + * in the guest context, but at a more privileged level (usually VMPL0).
> + *
> + * The vTPM is emulated through the TCG reference implementation, so this
> + * driver leverages tpm_tcgsim.h to fill commands and parse responses.
> + *
> + * [1] "Secure VM Service Module for SEV-SNP Guests"
> + *     Publication # 58019 Revision: 1.00
> + *     https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
> + */
> +
> +#include <asm/sev.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/tpm_tcgsim.h>
> +
> +#include "tpm.h"
> +
> +struct tpm_svsm_priv {
> +	u8 buffer[TPM_TCGSIM_MAX_BUFFER];
> +	u8 locality;
> +};
> +
> +static int tpm_svsm_send_recv(struct tpm_chip *chip, u8 *buf, size_t buf_len,
> +			      size_t to_send)
> +{
> +	struct tpm_svsm_priv *priv = dev_get_drvdata(&chip->dev);
> +	int ret;
> +
> +	ret = tpm_tcgsim_fill_send_cmd((struct tpm_send_cmd_req *)priv->buffer,
> +				       priv->locality, buf, to_send);
> +	if (ret)
> +		return ret;
> +
> +	ret = snp_svsm_vtpm_send_command(priv->buffer);
> +	if (ret)
> +		return ret;
> +
> +	return tpm_tcgsim_parse_send_cmd((struct tpm_send_cmd_resp *)priv->buffer,
> +					 buf, buf_len);
> +}
> +
> +static struct tpm_class_ops tpm_chip_ops = {
> +	.flags = TPM_OPS_AUTO_STARTUP,
> +	.send_recv = tpm_svsm_send_recv,
> +};
> +
> +static int __init tpm_svsm_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct tpm_svsm_priv *priv;
> +	struct tpm_chip *chip;
> +	int err;
> +
> +	if (!snp_svsm_vtpm_probe())
> +		return -ENODEV;
> +
> +	priv = devm_kmalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	/*
> +	 * FIXME: before implementing locality we need to agree what it means
> +	 * for the SNP SVSM vTPM
> +	 */
> +	priv->locality = 0;
> +
> +	chip = tpmm_chip_alloc(dev, &tpm_chip_ops);
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +
> +	dev_set_drvdata(&chip->dev, priv);
> +
> +	err = tpm2_probe(chip);
> +	if (err)
> +		return err;
> +
> +	err = tpm_chip_register(chip);
> +	if (err)
> +		return err;
> +
> +	dev_info(dev, "SNP SVSM vTPM %s device\n",
> +		 (chip->flags & TPM_CHIP_FLAG_TPM2) ? "2.0" : "1.2");
> +
> +	return 0;
> +}
> +
> +static void __exit tpm_svsm_remove(struct platform_device *pdev)
> +{
> +	struct tpm_chip *chip = platform_get_drvdata(pdev);
> +
> +	tpm_chip_unregister(chip);
> +}
> +
> +/*
> + * tpm_svsm_remove() lives in .exit.text. For drivers registered via
> + * module_platform_driver_probe() this is ok because they cannot get unbound
> + * at runtime. So mark the driver struct with __refdata to prevent modpost
> + * triggering a section mismatch warning.
> + */
> +static struct platform_driver tpm_svsm_driver __refdata = {
> +	.remove = __exit_p(tpm_svsm_remove),
> +	.driver = {
> +		.name = "tpm-svsm",
> +	},
> +};
> +
> +module_platform_driver_probe(tpm_svsm_driver, tpm_svsm_probe);
> +
> +MODULE_DESCRIPTION("SNP SVSM vTPM Driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:tpm-svsm");
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index 0fc9a510e059..fc3f1d10d31d 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -225,5 +225,15 @@ config TCG_FTPM_TEE
>  	help
>  	  This driver proxies for firmware TPM running in TEE.
>  
> +config TCG_SVSM
> +	tristate "SNP SVSM vTPM interface"
> +	depends on AMD_MEM_ENCRYPT
> +	help
> +	  This is a driver for the AMD SVSM vTPM protocol that a SEV-SNP guest
> +	  OS can use to discover and talk to a vTPM emulated by the Secure VM
> +	  Service Module (SVSM) in the guest context, but at a more privileged
> +	  level (usually VMPL0).  To compile this driver as a module, choose M
> +	  here; the module will be called tpm_svsm.
> +
>  source "drivers/char/tpm/st33zp24/Kconfig"
>  endif # TCG_TPM
> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> index 9bb142c75243..52d9d80a0f56 100644
> --- a/drivers/char/tpm/Makefile
> +++ b/drivers/char/tpm/Makefile
> @@ -44,3 +44,4 @@ obj-$(CONFIG_TCG_XEN) += xen-tpmfront.o
>  obj-$(CONFIG_TCG_CRB) += tpm_crb.o
>  obj-$(CONFIG_TCG_VTPM_PROXY) += tpm_vtpm_proxy.o
>  obj-$(CONFIG_TCG_FTPM_TEE) += tpm_ftpm_tee.o
> +obj-$(CONFIG_TCG_SVSM) += tpm_svsm.o
> -- 
> 2.48.1
> 

OK, so this is like ARM's driver architecture using SMC, and I think
tpm_ftpm_tee is probably one great reflection for this overall. Is this
correct analysis, or not?

BR, Jarkko

