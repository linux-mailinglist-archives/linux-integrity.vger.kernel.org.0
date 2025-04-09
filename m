Return-Path: <linux-integrity+bounces-5682-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 955BEA8213C
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 11:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6415D8A5644
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 09:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30E825D8E1;
	Wed,  9 Apr 2025 09:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UPnJvAv9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B0325D52D
	for <linux-integrity@vger.kernel.org>; Wed,  9 Apr 2025 09:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744191853; cv=none; b=YW2JZ4hqq+nHXI3dIxZ8KSxToB+OuJeWpszoA/3pB5Zzt2h0MmbUeL8k6pzeRyqp3EF9wvhm9ywZSHcbvxirtHKy9RX/Iqqp13ZSGk0cwU1SRMYFY1X7V/Pv9vQosEth2cUCSL9fr8D52Ux2Js/kQvQfSRHDAf85J5wGzi4ouQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744191853; c=relaxed/simple;
	bh=N6owoXk28YLLwUW3i5/zFHr8Ha0tLuVKTVWuEizWYq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z5xqSdtpzWkFsDF13AkOOu3IbNgwFnCeigWEOptSC8UVYrjYRG2FoYtXE7FDa/SIUx2YOnfGtkN5GJnGi9/kxlB5YCHWTlXm72SEaJYF1DgiYrcEthx7a4QCOzE6r1wiHnkCmrRwAXliVy+E1t8lQxSvtoAOqWWzsC9sDPxHeIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UPnJvAv9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744191849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zUQJ6PUgUUIw2lyUC2lJw3AoBlYQ50F1V57qK/lUQ30=;
	b=UPnJvAv9K94lKOA5qyae4DZCocixMNGqJiV+xEfRHkZm/8AW7VnmR8BnVFLEIzvei5QnIb
	y2xq5sYZgCR2+ZXR1LSdjHSvVc0vWgVy/zjg6EFade9Gb/fg3thN0hDd+oSqZf8BLPH4e+
	CsTAbAvIio7pLacGZTIa2XGv/pKm1H8=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-aU5GXLm2NF6W0yUw4ycl0g-1; Wed, 09 Apr 2025 05:44:08 -0400
X-MC-Unique: aU5GXLm2NF6W0yUw4ycl0g-1
X-Mimecast-MFC-AGG-ID: aU5GXLm2NF6W0yUw4ycl0g_1744191847
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-703ad0aaeebso91371967b3.3
        for <linux-integrity@vger.kernel.org>; Wed, 09 Apr 2025 02:44:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744191847; x=1744796647;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zUQJ6PUgUUIw2lyUC2lJw3AoBlYQ50F1V57qK/lUQ30=;
        b=rvJiRgAiuT1+b3AhJLaLGS4cRDWq5o8MIW/5aXUloPjxoOtjtWp/nYHBbHezahuEjJ
         DHPVi4SEPGUhk7gs+rH07XeQX2AZmOGn5S6WWFG8+gGUdS5yGGG33ZhTci+ZOEIyuXwi
         AJR7NyrBRVbX1dAXCyJEPyo+pHGUmGljiwzyiQ+lbcmVScGRf01nxlm8mV8ffIpkvjtw
         9Esbd5UXCRpWd45+5dxcFe6e9LYXuYFu99VFod9YDckuL1bZaWxLVxRCs7GfwF0luGW4
         jm9llQz40S0/DqemqDi4sLF5Sfp5eY1DRcLysDVES/3jVoaFDosGJc/MrqO1qp9+s7d/
         Qx9g==
X-Forwarded-Encrypted: i=1; AJvYcCVdOC2d2Nh+IjGtt3POZvEpEm6mMEGesuTBHrc2Rb2fhEcjL/0JxkljjYdmro9DRLLV0qWumAx86h32Gy0H8Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcGht5jmwey/mEHZ8OaUpXiuuF4+oRPN5PSaspe8wvN9IZJh5Y
	Vq3EUvTDuLMBKDnyKOL6KFflDJCbMFRKzcCVuWNSyx0YJ/LbNKNO3x/ylOO7LWUZhOI+FkuruT9
	Jt+pFCpOEI3/iWtoPCk7FZb7ioroU0pJ/tI3wchPIeEcxcFyydaROcdqrLLRA410sAzG04AYcAb
	ziK+AXE2b1HCu6jWH76PZz9aHe+1f1dM8DKNHWqdPf
X-Gm-Gg: ASbGncu63yvHEcxi4HQWsgq1xfLJCdx21YKkGCCwKwQPXhhgHvl8vC6mNrTiDhY171C
	0h1fbvlF7ZJtRZqSyXI/mx2h/B0VwVRahDBpnwIb8yiSjIy7ypP/fns1vVj69y29dqMg=
X-Received: by 2002:a05:6902:4911:b0:e5a:e6eb:d444 with SMTP id 3f1490d57ef6-e702f598b5cmr3242973276.2.1744191847066;
        Wed, 09 Apr 2025 02:44:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXDmAsuDjN6cm8V61wNyn1AoIquIc3555mQ1UNfgKbyZZMSjx+xjvWUm/M/Di/3xDlbAaupDLE32Ade1Q+NBs=
X-Received: by 2002:a05:6902:4911:b0:e5a:e6eb:d444 with SMTP id
 3f1490d57ef6-e702f598b5cmr3242931276.2.1744191846714; Wed, 09 Apr 2025
 02:44:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403100943.120738-1-sgarzare@redhat.com> <20250403100943.120738-4-sgarzare@redhat.com>
 <Z-7b9VPEhmVYHjbX@kernel.org>
In-Reply-To: <Z-7b9VPEhmVYHjbX@kernel.org>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 9 Apr 2025 11:43:55 +0200
X-Gm-Features: ATxdqUHoBAw1a642SjFJq29zM4LubIhp9qI7SBYfox5FR3hyUch8jrRr6-te6JM
Message-ID: <CAGxU2F7a8uLz0367FubJhnwOAqGSpymTc9GefRAT5foRPHV9VA@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] tpm: add SNP SVSM vTPM driver
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Peter Huewe <peterhuewe@gmx.de>, 
	Jason Gunthorpe <jgg@ziepe.ca>, "H. Peter Anvin" <hpa@zytor.com>, linux-coco@lists.linux.dev, 
	linux-integrity@vger.kernel.org, Borislav Petkov <bp@alien8.de>, 
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>, 
	Joerg Roedel <jroedel@suse.de>, Dionna Glaze <dionnaglaze@google.com>, 
	Claudio Carvalho <cclaudio@linux.ibm.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, linux-kernel@vger.kernel.org, 
	Dov Murik <dovmurik@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Apr 2025 at 21:05, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Thu, Apr 03, 2025 at 12:09:41PM +0200, Stefano Garzarella wrote:
> > From: Stefano Garzarella <sgarzare@redhat.com>
> >
> > Add driver for the vTPM defined by the AMD SVSM spec [1].
> >
> > The specification defines a protocol that a SEV-SNP guest OS can use to
> > discover and talk to a vTPM emulated by the Secure VM Service Module (SVSM)
> > in the guest context, but at a more privileged level (VMPL0).
> >
> > The new tpm-svsm platform driver uses two functions exposed by x86/sev
> > to verify that the device is actually emulated by the platform and to
> > send commands and receive responses.
> >
> > The device cannot be hot-plugged/unplugged as it is emulated by the
> > platform, so we can use module_platform_driver_probe(). The probe
> > function will only check whether in the current runtime configuration,
> > SVSM is present and provides a vTPM.
> >
> > This device does not support interrupts and sends responses to commands
> > synchronously. In order to have .recv() called just after .send() in
> > tpm_try_transmit(), the .status() callback returns 0, and both
> > .req_complete_mask and .req_complete_val are set to 0.
> >
> > [1] "Secure VM Service Module for SEV-SNP Guests"
> >     Publication # 58019 Revision: 1.00
> >
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> > v6:
> > - removed the `locality` field (set to 0) and the FIXME comment [Jarkko]
> > v5:
> > - removed cancel/status/req_* ops after rebase on master that cotains
> >   commit 980a573621ea ("tpm: Make chip->{status,cancel,req_canceled} opt")
> > v4:
> > - moved "asm" includes after the "linux" includes [Tom]
> > - allocated buffer separately [Tom/Jarkko/Jason]
> > v3:
> > - removed send_recv() ops and followed the ftpm driver implementing .status,
> >   .req_complete_mask, .req_complete_val, etc. [Jarkko]
> > - removed link to the spec because those URLs are unstable [Borislav]
> > ---
> >  drivers/char/tpm/tpm_svsm.c | 128 ++++++++++++++++++++++++++++++++++++
> >  drivers/char/tpm/Kconfig    |  10 +++
> >  drivers/char/tpm/Makefile   |   1 +
> >  3 files changed, 139 insertions(+)
> >  create mode 100644 drivers/char/tpm/tpm_svsm.c
> >
> > diff --git a/drivers/char/tpm/tpm_svsm.c b/drivers/char/tpm/tpm_svsm.c
> > new file mode 100644
> > index 000000000000..b9242c9eab87
> > --- /dev/null
> > +++ b/drivers/char/tpm/tpm_svsm.c
> > @@ -0,0 +1,128 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
> > + *
> > + * Driver for the vTPM defined by the AMD SVSM spec [1].
> > + *
> > + * The specification defines a protocol that a SEV-SNP guest OS can use to
> > + * discover and talk to a vTPM emulated by the Secure VM Service Module (SVSM)
> > + * in the guest context, but at a more privileged level (usually VMPL0).
> > + *
> > + * [1] "Secure VM Service Module for SEV-SNP Guests"
> > + *     Publication # 58019 Revision: 1.00
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/tpm_svsm.h>
> > +
> > +#include <asm/sev.h>
> > +
> > +#include "tpm.h"
> > +
> > +struct tpm_svsm_priv {
> > +     void *buffer;
> > +};
> > +
> > +static int tpm_svsm_send(struct tpm_chip *chip, u8 *buf, size_t len)
> > +{
> > +     struct tpm_svsm_priv *priv = dev_get_drvdata(&chip->dev);
> > +     int ret;
> > +
> > +     ret = svsm_vtpm_cmd_request_fill(priv->buffer, 0, buf, len);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /*
> > +      * The SVSM call uses the same buffer for the command and for the
> > +      * response, so after this call, the buffer will contain the response
> > +      * that can be used by .recv() op.
> > +      */
> > +     return snp_svsm_vtpm_send_command(priv->buffer);
> > +}
> > +
> > +static int tpm_svsm_recv(struct tpm_chip *chip, u8 *buf, size_t len)
> > +{
> > +     struct tpm_svsm_priv *priv = dev_get_drvdata(&chip->dev);
> > +
> > +     /*
> > +      * The internal buffer contains the response after we send the command
> > +      * to SVSM.
> > +      */
> > +     return svsm_vtpm_cmd_response_parse(priv->buffer, buf, len);
> > +}
> > +
> > +static struct tpm_class_ops tpm_chip_ops = {
> > +     .flags = TPM_OPS_AUTO_STARTUP,
> > +     .recv = tpm_svsm_recv,
> > +     .send = tpm_svsm_send,
> > +};
> > +
> > +static int __init tpm_svsm_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev = &pdev->dev;
> > +     struct tpm_svsm_priv *priv;
> > +     struct tpm_chip *chip;
> > +     int err;
> > +
> > +     if (!snp_svsm_vtpm_probe())
> > +             return -ENODEV;
> > +
> > +     priv = devm_kmalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +     if (!priv)
> > +             return -ENOMEM;
> > +
> > +     /*
> > +      * The maximum buffer supported is one page (see SVSM_VTPM_MAX_BUFFER
> > +      * in tpm_svsm.h).
> > +      */
> > +     priv->buffer = (void *)devm_get_free_pages(dev, GFP_KERNEL, 0);
> > +     if (!priv->buffer)
> > +             return -ENOMEM;
> > +
> > +     chip = tpmm_chip_alloc(dev, &tpm_chip_ops);
> > +     if (IS_ERR(chip))
> > +             return PTR_ERR(chip);
> > +
> > +     dev_set_drvdata(&chip->dev, priv);
> > +
> > +     err = tpm2_probe(chip);
> > +     if (err)
> > +             return err;
> > +
> > +     err = tpm_chip_register(chip);
> > +     if (err)
> > +             return err;
> > +
> > +     dev_info(dev, "SNP SVSM vTPM %s device\n",
> > +              (chip->flags & TPM_CHIP_FLAG_TPM2) ? "2.0" : "1.2");
> > +
> > +     return 0;
> > +}
> > +
> > +static void __exit tpm_svsm_remove(struct platform_device *pdev)
> > +{
> > +     struct tpm_chip *chip = platform_get_drvdata(pdev);
> > +
> > +     tpm_chip_unregister(chip);
> > +}
> > +
> > +/*
> > + * tpm_svsm_remove() lives in .exit.text. For drivers registered via
> > + * module_platform_driver_probe() this is ok because they cannot get unbound
> > + * at runtime. So mark the driver struct with __refdata to prevent modpost
> > + * triggering a section mismatch warning.
> > + */
> > +static struct platform_driver tpm_svsm_driver __refdata = {
> > +     .remove = __exit_p(tpm_svsm_remove),
> > +     .driver = {
> > +             .name = "tpm-svsm",
> > +     },
> > +};
> > +
> > +module_platform_driver_probe(tpm_svsm_driver, tpm_svsm_probe);
> > +
> > +MODULE_DESCRIPTION("SNP SVSM vTPM Driver");
> > +MODULE_LICENSE("GPL");
> > +MODULE_ALIAS("platform:tpm-svsm");
> > diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> > index fe4f3a609934..dddd702b2454 100644
> > --- a/drivers/char/tpm/Kconfig
> > +++ b/drivers/char/tpm/Kconfig
> > @@ -234,5 +234,15 @@ config TCG_FTPM_TEE
> >       help
> >         This driver proxies for firmware TPM running in TEE.
> >
> > +config TCG_SVSM
> > +     tristate "SNP SVSM vTPM interface"
> > +     depends on AMD_MEM_ENCRYPT
> > +     help
> > +       This is a driver for the AMD SVSM vTPM protocol that a SEV-SNP guest
> > +       OS can use to discover and talk to a vTPM emulated by the Secure VM
> > +       Service Module (SVSM) in the guest context, but at a more privileged
> > +       level (usually VMPL0).  To compile this driver as a module, choose M
> > +       here; the module will be called tpm_svsm.
> > +
> >  source "drivers/char/tpm/st33zp24/Kconfig"
> >  endif # TCG_TPM
> > diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> > index 2b004df8c04b..9de1b3ea34a9 100644
> > --- a/drivers/char/tpm/Makefile
> > +++ b/drivers/char/tpm/Makefile
> > @@ -45,3 +45,4 @@ obj-$(CONFIG_TCG_CRB) += tpm_crb.o
> >  obj-$(CONFIG_TCG_ARM_CRB_FFA) += tpm_crb_ffa.o
> >  obj-$(CONFIG_TCG_VTPM_PROXY) += tpm_vtpm_proxy.o
> >  obj-$(CONFIG_TCG_FTPM_TEE) += tpm_ftpm_tee.o
> > +obj-$(CONFIG_TCG_SVSM) += tpm_svsm.o
> > --
> > 2.49.0
> >
> >
>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

In the next version I'm moving the snp_svsm_vtpm_probe() call from
here to sev core where the device is registered.
See https://lore.kernel.org/linux-integrity/o2u7p3wb64lcc4sziunr274hyubkgmspzdjcvihbpzkw6mkvpo@sjq3vi4y2qfl/

Do I carry your R-b for this patch (and patch 4) or would you rather
take a look at v7?

Thanks,
Stefano


