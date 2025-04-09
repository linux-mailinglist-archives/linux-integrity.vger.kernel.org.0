Return-Path: <linux-integrity+bounces-5688-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A8DA827A4
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 16:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1D32467B2D
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 14:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAE318CBE1;
	Wed,  9 Apr 2025 14:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JR0BsReO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB0069D2B;
	Wed,  9 Apr 2025 14:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744208515; cv=none; b=gPMgTUFBV35rsM98CjprRPXXcX5omNxXbFbUUwcVbmcB/jygqa6DRD0rxhs3vVT5WE4HGQ8lvZUEdVq33omouFG9MLP+7CHRBtdEGYH5Xuk5frN8T6DVwo4PtzfuoV/QOw/MmsMAOlbtKZw8FsKIgdPPW6ooQdhs92BWGiNsJkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744208515; c=relaxed/simple;
	bh=vAmC2drAHBzHtNgBifeXzr5zmsNl5tXCpvkQpn8quHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7abfnKOCTdk791AFUrgtI1+NG4lMIGMqNIRPImNuGiNlZUUWwiGECToCruXVnfsDaYJv+xY4qkZYXt2mx6xI4nUcWBQOIrjLamBsm77AaNDFsZ8Yzks6dcxvir+FKyVdjjj4GYRdweYCkDn/0ajZX/+OHwYW7QK/jz51rvZVoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JR0BsReO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2B5BC4CEE2;
	Wed,  9 Apr 2025 14:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744208515;
	bh=vAmC2drAHBzHtNgBifeXzr5zmsNl5tXCpvkQpn8quHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JR0BsReO5qUEp66JmGFNad8PN643CouBXNz1iLv2AHpXBISgGu9yLrcXgg1eTh8Gc
	 mJnAPDwXQOOjsxMi+lt3ijTNwBaRwSsptAKpkhDd2GZLf4tBHuO+jnx1GpCtjwJjeE
	 qCvEXQ3vnAhBSWOyz8sNB1qDElfRE1+IC2u/GU8vtW2C+np6memRISCwo/ai5hqw8x
	 zAAfk5tT1ytyPVuutLPAoF/nm9YlA4XFfqjuWatFE11fk+z22K9huBrRimyuIKyZ05
	 ZVEl80l54HZdUopGGMRVYqnnax6NERNfqh7V2AVHU560Lmt+5EKri1slua18Z0hnOl
	 tmsPvkfDMiOUw==
Date: Wed, 9 Apr 2025 17:21:50 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-coco@lists.linux.dev,
	linux-integrity@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Joerg Roedel <jroedel@suse.de>,
	Dionna Glaze <dionnaglaze@google.com>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	linux-kernel@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v6 3/4] tpm: add SNP SVSM vTPM driver
Message-ID: <Z_aCfqp1EQBxRrRx@kernel.org>
References: <20250403100943.120738-1-sgarzare@redhat.com>
 <20250403100943.120738-4-sgarzare@redhat.com>
 <Z-7b9VPEhmVYHjbX@kernel.org>
 <CAGxU2F7a8uLz0367FubJhnwOAqGSpymTc9GefRAT5foRPHV9VA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGxU2F7a8uLz0367FubJhnwOAqGSpymTc9GefRAT5foRPHV9VA@mail.gmail.com>

On Wed, Apr 09, 2025 at 11:43:55AM +0200, Stefano Garzarella wrote:
> On Thu, 3 Apr 2025 at 21:05, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Thu, Apr 03, 2025 at 12:09:41PM +0200, Stefano Garzarella wrote:
> > > From: Stefano Garzarella <sgarzare@redhat.com>
> > >
> > > Add driver for the vTPM defined by the AMD SVSM spec [1].
> > >
> > > The specification defines a protocol that a SEV-SNP guest OS can use to
> > > discover and talk to a vTPM emulated by the Secure VM Service Module (SVSM)
> > > in the guest context, but at a more privileged level (VMPL0).
> > >
> > > The new tpm-svsm platform driver uses two functions exposed by x86/sev
> > > to verify that the device is actually emulated by the platform and to
> > > send commands and receive responses.
> > >
> > > The device cannot be hot-plugged/unplugged as it is emulated by the
> > > platform, so we can use module_platform_driver_probe(). The probe
> > > function will only check whether in the current runtime configuration,
> > > SVSM is present and provides a vTPM.
> > >
> > > This device does not support interrupts and sends responses to commands
> > > synchronously. In order to have .recv() called just after .send() in
> > > tpm_try_transmit(), the .status() callback returns 0, and both
> > > .req_complete_mask and .req_complete_val are set to 0.
> > >
> > > [1] "Secure VM Service Module for SEV-SNP Guests"
> > >     Publication # 58019 Revision: 1.00
> > >
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > ---
> > > v6:
> > > - removed the `locality` field (set to 0) and the FIXME comment [Jarkko]
> > > v5:
> > > - removed cancel/status/req_* ops after rebase on master that cotains
> > >   commit 980a573621ea ("tpm: Make chip->{status,cancel,req_canceled} opt")
> > > v4:
> > > - moved "asm" includes after the "linux" includes [Tom]
> > > - allocated buffer separately [Tom/Jarkko/Jason]
> > > v3:
> > > - removed send_recv() ops and followed the ftpm driver implementing .status,
> > >   .req_complete_mask, .req_complete_val, etc. [Jarkko]
> > > - removed link to the spec because those URLs are unstable [Borislav]
> > > ---
> > >  drivers/char/tpm/tpm_svsm.c | 128 ++++++++++++++++++++++++++++++++++++
> > >  drivers/char/tpm/Kconfig    |  10 +++
> > >  drivers/char/tpm/Makefile   |   1 +
> > >  3 files changed, 139 insertions(+)
> > >  create mode 100644 drivers/char/tpm/tpm_svsm.c
> > >
> > > diff --git a/drivers/char/tpm/tpm_svsm.c b/drivers/char/tpm/tpm_svsm.c
> > > new file mode 100644
> > > index 000000000000..b9242c9eab87
> > > --- /dev/null
> > > +++ b/drivers/char/tpm/tpm_svsm.c
> > > @@ -0,0 +1,128 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
> > > + *
> > > + * Driver for the vTPM defined by the AMD SVSM spec [1].
> > > + *
> > > + * The specification defines a protocol that a SEV-SNP guest OS can use to
> > > + * discover and talk to a vTPM emulated by the Secure VM Service Module (SVSM)
> > > + * in the guest context, but at a more privileged level (usually VMPL0).
> > > + *
> > > + * [1] "Secure VM Service Module for SEV-SNP Guests"
> > > + *     Publication # 58019 Revision: 1.00
> > > + */
> > > +
> > > +#include <linux/module.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/tpm_svsm.h>
> > > +
> > > +#include <asm/sev.h>
> > > +
> > > +#include "tpm.h"
> > > +
> > > +struct tpm_svsm_priv {
> > > +     void *buffer;
> > > +};
> > > +
> > > +static int tpm_svsm_send(struct tpm_chip *chip, u8 *buf, size_t len)
> > > +{
> > > +     struct tpm_svsm_priv *priv = dev_get_drvdata(&chip->dev);
> > > +     int ret;
> > > +
> > > +     ret = svsm_vtpm_cmd_request_fill(priv->buffer, 0, buf, len);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     /*
> > > +      * The SVSM call uses the same buffer for the command and for the
> > > +      * response, so after this call, the buffer will contain the response
> > > +      * that can be used by .recv() op.
> > > +      */
> > > +     return snp_svsm_vtpm_send_command(priv->buffer);
> > > +}
> > > +
> > > +static int tpm_svsm_recv(struct tpm_chip *chip, u8 *buf, size_t len)
> > > +{
> > > +     struct tpm_svsm_priv *priv = dev_get_drvdata(&chip->dev);
> > > +
> > > +     /*
> > > +      * The internal buffer contains the response after we send the command
> > > +      * to SVSM.
> > > +      */
> > > +     return svsm_vtpm_cmd_response_parse(priv->buffer, buf, len);
> > > +}
> > > +
> > > +static struct tpm_class_ops tpm_chip_ops = {
> > > +     .flags = TPM_OPS_AUTO_STARTUP,
> > > +     .recv = tpm_svsm_recv,
> > > +     .send = tpm_svsm_send,
> > > +};
> > > +
> > > +static int __init tpm_svsm_probe(struct platform_device *pdev)
> > > +{
> > > +     struct device *dev = &pdev->dev;
> > > +     struct tpm_svsm_priv *priv;
> > > +     struct tpm_chip *chip;
> > > +     int err;
> > > +
> > > +     if (!snp_svsm_vtpm_probe())
> > > +             return -ENODEV;
> > > +
> > > +     priv = devm_kmalloc(dev, sizeof(*priv), GFP_KERNEL);
> > > +     if (!priv)
> > > +             return -ENOMEM;
> > > +
> > > +     /*
> > > +      * The maximum buffer supported is one page (see SVSM_VTPM_MAX_BUFFER
> > > +      * in tpm_svsm.h).
> > > +      */
> > > +     priv->buffer = (void *)devm_get_free_pages(dev, GFP_KERNEL, 0);
> > > +     if (!priv->buffer)
> > > +             return -ENOMEM;
> > > +
> > > +     chip = tpmm_chip_alloc(dev, &tpm_chip_ops);
> > > +     if (IS_ERR(chip))
> > > +             return PTR_ERR(chip);
> > > +
> > > +     dev_set_drvdata(&chip->dev, priv);
> > > +
> > > +     err = tpm2_probe(chip);
> > > +     if (err)
> > > +             return err;
> > > +
> > > +     err = tpm_chip_register(chip);
> > > +     if (err)
> > > +             return err;
> > > +
> > > +     dev_info(dev, "SNP SVSM vTPM %s device\n",
> > > +              (chip->flags & TPM_CHIP_FLAG_TPM2) ? "2.0" : "1.2");
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static void __exit tpm_svsm_remove(struct platform_device *pdev)
> > > +{
> > > +     struct tpm_chip *chip = platform_get_drvdata(pdev);
> > > +
> > > +     tpm_chip_unregister(chip);
> > > +}
> > > +
> > > +/*
> > > + * tpm_svsm_remove() lives in .exit.text. For drivers registered via
> > > + * module_platform_driver_probe() this is ok because they cannot get unbound
> > > + * at runtime. So mark the driver struct with __refdata to prevent modpost
> > > + * triggering a section mismatch warning.
> > > + */
> > > +static struct platform_driver tpm_svsm_driver __refdata = {
> > > +     .remove = __exit_p(tpm_svsm_remove),
> > > +     .driver = {
> > > +             .name = "tpm-svsm",
> > > +     },
> > > +};
> > > +
> > > +module_platform_driver_probe(tpm_svsm_driver, tpm_svsm_probe);
> > > +
> > > +MODULE_DESCRIPTION("SNP SVSM vTPM Driver");
> > > +MODULE_LICENSE("GPL");
> > > +MODULE_ALIAS("platform:tpm-svsm");
> > > diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> > > index fe4f3a609934..dddd702b2454 100644
> > > --- a/drivers/char/tpm/Kconfig
> > > +++ b/drivers/char/tpm/Kconfig
> > > @@ -234,5 +234,15 @@ config TCG_FTPM_TEE
> > >       help
> > >         This driver proxies for firmware TPM running in TEE.
> > >
> > > +config TCG_SVSM
> > > +     tristate "SNP SVSM vTPM interface"
> > > +     depends on AMD_MEM_ENCRYPT
> > > +     help
> > > +       This is a driver for the AMD SVSM vTPM protocol that a SEV-SNP guest
> > > +       OS can use to discover and talk to a vTPM emulated by the Secure VM
> > > +       Service Module (SVSM) in the guest context, but at a more privileged
> > > +       level (usually VMPL0).  To compile this driver as a module, choose M
> > > +       here; the module will be called tpm_svsm.
> > > +
> > >  source "drivers/char/tpm/st33zp24/Kconfig"
> > >  endif # TCG_TPM
> > > diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> > > index 2b004df8c04b..9de1b3ea34a9 100644
> > > --- a/drivers/char/tpm/Makefile
> > > +++ b/drivers/char/tpm/Makefile
> > > @@ -45,3 +45,4 @@ obj-$(CONFIG_TCG_CRB) += tpm_crb.o
> > >  obj-$(CONFIG_TCG_ARM_CRB_FFA) += tpm_crb_ffa.o
> > >  obj-$(CONFIG_TCG_VTPM_PROXY) += tpm_vtpm_proxy.o
> > >  obj-$(CONFIG_TCG_FTPM_TEE) += tpm_ftpm_tee.o
> > > +obj-$(CONFIG_TCG_SVSM) += tpm_svsm.o
> > > --
> > > 2.49.0
> > >
> > >
> >
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> In the next version I'm moving the snp_svsm_vtpm_probe() call from
> here to sev core where the device is registered.
> See https://lore.kernel.org/linux-integrity/o2u7p3wb64lcc4sziunr274hyubkgmspzdjcvihbpzkw6mkvpo@sjq3vi4y2qfl/
> 
> Do I carry your R-b for this patch (and patch 4) or would you rather
> take a look at v7?

I'm fine with it. I'm sure that Boris et al make the complains if/when
required :-) This whole process has been going on smoothly overall, and
all my concerns have been addressed.

> 
> Thanks,
> Stefano
> 

BR, Jarkko

