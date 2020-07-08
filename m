Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A9B21946A
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Jul 2020 01:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgGHXj6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Jul 2020 19:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgGHXj5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Jul 2020 19:39:57 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F67C08C5CE
        for <linux-integrity@vger.kernel.org>; Wed,  8 Jul 2020 16:39:56 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id 9so258491ljv.5
        for <linux-integrity@vger.kernel.org>; Wed, 08 Jul 2020 16:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XmP6LUmqKKJO4OAeMBEHwlyEFTd6VCnogaHIKsw0bfU=;
        b=suDgcwAydC7EIBd9z35ck3ZXUvaJ9PNmHagG8YqtZ1sxTJPpca92DHLE64ZbYphI1D
         F7BP6HsAa0Lsn+SgymgzZsvy//7jShI1NOGlOlQNswPc+QoBiqvBbqo4iciqkuurl4VZ
         FTCR6sJ5SqyCdB/TygoI8cEH1qpnO5JgDCDru5Fj0IOg5ga0Vq7j3KcqRm4oKpeAMStG
         q5aLhH1skVF6JlMuyplgF6f8DZxbXCU6MlGyKijm53r6aQlMlbiQtirYgAKzqOKky15E
         2hi3xzYShqrZKWwfRpTA9g1exADvKbgS5WO9i72rPX3wf7LWRFENGGeFq2UMEurCZJfL
         t+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XmP6LUmqKKJO4OAeMBEHwlyEFTd6VCnogaHIKsw0bfU=;
        b=naKGf+iUTNmSrWisy0bQ2FITMgbML/Yuvfbaw7V8gdz46I2GmnWeDT18RIFkxMwgoB
         TBxWklUhk7Uffr6CL+FwlmD8tg0dhB7tJYMfBtV6mb6D8hviP2QG4u3TEg7a1KSmCo3V
         8VnSPc+HkIvC4N/yKXA7o5ql+p9o09Zvyp+wGjgJQRg/NJaLFs4BJUgTuThDLlF4Np29
         f6ybNRW0sMM9yqmk6WDOftW82RdlIKbhHDOwk1cObkOSzpj5F0zUTk+GX/qLrA7r+naE
         76UgSi/2SWO00les3v61gZ3UTq+vUocZrO16TDbMvhJZ9JuFiM4ol5uz4UKxQJRk8vRu
         N+xw==
X-Gm-Message-State: AOAM533YGOAhSoR5TrcLn9jyzSYDdD+8dKzktcxXSJhLLenvP2crEHL8
        yBBRbSbhomfGsArNNYlBxgf3HtzqNNg1YKnEVbqpQA==
X-Google-Smtp-Source: ABdhPJxki0WE1DP1HlJpYU0r+Rnm403mp5KDWtsKs85Q/ApmALrGZyeYQ6Pk24LHGgW7hDvpTRVCL5Vpfp7j8S01Y3c=
X-Received: by 2002:a2e:3619:: with SMTP id d25mr34269180lja.204.1594251595225;
 Wed, 08 Jul 2020 16:39:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200708131424.18729-1-masahisa.kojima@linaro.org>
 <20200708131424.18729-2-masahisa.kojima@linaro.org> <20200708163027.GC549022@linux.intel.com>
In-Reply-To: <20200708163027.GC549022@linux.intel.com>
From:   Masahisa Kojima <masahisa.kojima@linaro.org>
Date:   Thu, 9 Jul 2020 08:39:43 +0900
Message-ID: <CADQ0-X_SNA9WyZ+Cx=fZm5fa2HhmvF9VSMJyV1AHakQSXjVUDw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] tpm: tis: add support for MMIO TPM on SynQuacer
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, ardb@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Ard, Jakko,

Thank you very much for your comments.
I will update code including ACPI  support, then send the next version.

Regards,
Masahisa

On Thu, 9 Jul 2020 at 01:30, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Wed, Jul 08, 2020 at 10:14:23PM +0900, Masahisa Kojima wrote:
> > When fitted, the SynQuacer platform exposes its SPI TPM via a MMIO
> > window that is backed by the SPI command sequencer in the SPI bus
> > controller. This arrangement has the limitation that only byte size
> > accesses are supported, and so we'll need to provide a separate module
> > that take this into account.
> >
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > ---
> >  drivers/char/tpm/Kconfig             |  12 ++
> >  drivers/char/tpm/Makefile            |   1 +
> >  drivers/char/tpm/tpm_tis_synquacer.c | 196 +++++++++++++++++++++++++++
> >  3 files changed, 209 insertions(+)
> >  create mode 100644 drivers/char/tpm/tpm_tis_synquacer.c
> >
> > diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> > index 58b4c573d176..a18c314da211 100644
> > --- a/drivers/char/tpm/Kconfig
> > +++ b/drivers/char/tpm/Kconfig
> > @@ -74,6 +74,18 @@ config TCG_TIS_SPI_CR50
> >         If you have a H1 secure module running Cr50 firmware on SPI bus,
> >         say Yes and it will be accessible from within Linux.
> >
> > +config TCG_TIS_SYNQUACER
> > +     tristate "TPM Interface Specification 1.2 Interface / TPM 2.0 FIFO Interface (MMIO - SynQuacer)"
> > +     depends on ARCH_SYNQUACER
> > +     select TCG_TIS_CORE
> > +     help
> > +       If you have a TPM security chip that is compliant with the
> > +       TCG TIS 1.2 TPM specification (TPM1.2) or the TCG PTP FIFO
> > +       specification (TPM2.0) say Yes and it will be accessible from
> > +       within Linux on Socionext SynQuacer platform.
> > +       To compile this driver as a module, choose  M here;
> > +       the module will be called tpm_tis_synquacer.
> > +
> >  config TCG_TIS_I2C_ATMEL
> >       tristate "TPM Interface Specification 1.2 Interface (I2C - Atmel)"
> >       depends on I2C
> > diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> > index 9567e5197f74..84db4fb3a9c9 100644
> > --- a/drivers/char/tpm/Makefile
> > +++ b/drivers/char/tpm/Makefile
> > @@ -21,6 +21,7 @@ tpm-$(CONFIG_EFI) += eventlog/efi.o
> >  tpm-$(CONFIG_OF) += eventlog/of.o
> >  obj-$(CONFIG_TCG_TIS_CORE) += tpm_tis_core.o
> >  obj-$(CONFIG_TCG_TIS) += tpm_tis.o
> > +obj-$(CONFIG_TCG_TIS_SYNQUACER) += tpm_tis_synquacer.o
> >
> >  obj-$(CONFIG_TCG_TIS_SPI) += tpm_tis_spi.o
> >  tpm_tis_spi-y := tpm_tis_spi_main.o
> > diff --git a/drivers/char/tpm/tpm_tis_synquacer.c b/drivers/char/tpm/tpm_tis_synquacer.c
> > new file mode 100644
> > index 000000000000..51f0aedcedcc
> > --- /dev/null
> > +++ b/drivers/char/tpm/tpm_tis_synquacer.c
> > @@ -0,0 +1,196 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2020 Linaro Ltd.
> > + *
> > + * This device driver implements MMIO TPM on SynQuacer Platform.
> > + */
> > +#include <linux/init.h>
> > +#include <linux/module.h>
> > +#include <linux/slab.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/kernel.h>
> > +#include "tpm.h"
> > +#include "tpm_tis_core.h"
> > +
> > +struct tpm_info {
>
> struct tpm_tis_synquacer_info
>
> > +     struct resource res;
> > +     /* irq > 0 means: use irq $irq;
> > +      * irq = 0 means: autoprobe for an irq;
> > +      * irq = -1 means: no irq support
> > +      */
> > +     int irq;
> > +};
> > +
> > +struct tpm_tis_tcg_phy {
>
> struct tpm_tis_synquacer_phy
>
> > +     struct tpm_tis_data priv;
> > +     void __iomem *iobase;
> > +};
> > +
> > +static inline struct tpm_tis_tcg_phy *to_tpm_tis_tcg_phy(struct tpm_tis_data *data)
> > +{
> > +     return container_of(data, struct tpm_tis_tcg_phy, priv);
> > +}
> > +
> > +static int tpm_tcg_read_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
> > +                           u8 *result)
>
> tpm_tis_synquacer_read_bytes (similar suggestions to similar stuff that
> follows).
>
> > +{
> > +     struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
> > +
> > +     while (len--)
> > +             *result++ = ioread8(phy->iobase + addr);
> > +
> > +     return 0;
> > +}
> > +
> > +static int tpm_tcg_write_bytes(struct tpm_tis_data *data, u32 addr, u16 len,
> > +                            const u8 *value)
> > +{
> > +     struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
> > +
> > +     while (len--)
> > +             iowrite8(*value++, phy->iobase + addr);
> > +
> > +     return 0;
> > +}
> > +
> > +static int tpm_tcg_read16_bw(struct tpm_tis_data *data, u32 addr, u16 *result)
> > +{
> > +     struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
> > +
> > +     /*
> > +      * Due to the limitation of SPI controller on SynQuacer,
> > +      * 16/32 bits access must be done in byte-wise and descending order.
> > +      */
> > +     *result = (ioread8(phy->iobase + addr + 1) << 8) |
> > +               (ioread8(phy->iobase + addr));
> > +
> > +     return 0;
> > +}
> > +
> > +static int tpm_tcg_read32_bw(struct tpm_tis_data *data, u32 addr, u32 *result)
> > +{
> > +     struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
> > +
> > +     /*
> > +      * Due to the limitation of SPI controller on SynQuacer,
> > +      * 16/32 bits access must be done in byte-wise and descending order.
> > +      */
> > +     *result = (ioread8(phy->iobase + addr + 3) << 24) |
> > +               (ioread8(phy->iobase + addr + 2) << 16) |
> > +               (ioread8(phy->iobase + addr + 1) << 8) |
> > +               (ioread8(phy->iobase + addr));
> > +
> > +     return 0;
> > +}
> > +
> > +static int tpm_tcg_write32_bw(struct tpm_tis_data *data, u32 addr, u32 value)
> > +{
> > +     struct tpm_tis_tcg_phy *phy = to_tpm_tis_tcg_phy(data);
> > +
> > +     /*
> > +      * Due to the limitation of SPI controller on SynQuacer,
> > +      * 16/32 bits access must be done in byte-wise and descending order.
> > +      */
> > +     iowrite8(value >> 24, phy->iobase + addr + 3);
> > +     iowrite8(value >> 16, phy->iobase + addr + 2);
> > +     iowrite8(value >> 8, phy->iobase + addr + 1);
> > +     iowrite8(value, phy->iobase + addr);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct tpm_tis_phy_ops tpm_tcg_bw = {
> > +     .read_bytes     = tpm_tcg_read_bytes,
> > +     .write_bytes    = tpm_tcg_write_bytes,
> > +     .read16         = tpm_tcg_read16_bw,
> > +     .read32         = tpm_tcg_read32_bw,
> > +     .write32        = tpm_tcg_write32_bw,
> > +};
> > +
> > +static int tpm_tis_synquacer_init(struct device *dev, struct tpm_info *tpm_info)
> > +{
> > +     struct tpm_tis_tcg_phy *phy;
> > +     int irq = -1;
> > +
> > +     phy = devm_kzalloc(dev, sizeof(struct tpm_tis_tcg_phy), GFP_KERNEL);
> > +     if (phy == NULL)
> > +             return -ENOMEM;
> > +
> > +     phy->iobase = devm_ioremap_resource(dev, &tpm_info->res);
> > +     if (IS_ERR(phy->iobase))
> > +             return PTR_ERR(phy->iobase);
> > +
> > +     return tpm_tis_core_init(dev, &phy->priv, irq, &tpm_tcg_bw,
> > +                              ACPI_HANDLE(dev));
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(tpm_tis_synquacer_pm, tpm_pm_suspend, tpm_tis_resume);
> > +
> > +static int tpm_tis_synquacer_probe(struct platform_device *pdev)
> > +{
> > +     struct tpm_info tpm_info = {};
> > +     struct resource *res;
> > +
> > +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +     if (res == NULL) {
> > +             dev_err(&pdev->dev, "no memory resource defined\n");
> > +             return -ENODEV;
> > +     }
> > +     tpm_info.res = *res;
> > +
> > +     tpm_info.irq = -1;
> > +
> > +     return tpm_tis_synquacer_init(&pdev->dev, &tpm_info);
> > +}
> > +
> > +static int tpm_tis_synquacer_remove(struct platform_device *pdev)
> > +{
> > +     struct tpm_chip *chip = dev_get_drvdata(&pdev->dev);
> > +
> > +     tpm_chip_unregister(chip);
> > +     tpm_tis_remove(chip);
> > +
> > +     return 0;
> > +}
> > +
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id tis_synquacer_of_platform_match[] = {
> > +     {.compatible = "socionext,synquacer-tpm-mmio"},
> > +     {},
> > +};
> > +MODULE_DEVICE_TABLE(of, tis_synquacer_of_platform_match);
> > +#endif
> > +
> > +static struct platform_driver tis_synquacer_drv = {
> > +     .probe = tpm_tis_synquacer_probe,
> > +     .remove = tpm_tis_synquacer_remove,
> > +     .driver = {
> > +             .name           = "tpm_tis_synquacer",
> > +             .pm             = &tpm_tis_synquacer_pm,
> > +             .of_match_table = of_match_ptr(tis_synquacer_of_platform_match),
> > +     },
> > +};
> > +
> > +static int __init init_tis_synquacer(void)
>
> tpm_tis_synquacer_module_init
>
> > +{
> > +     int rc;
> > +
> > +     rc = platform_driver_register(&tis_synquacer_drv);
> > +     if (rc)
> > +             return rc;
> > +
> > +     return 0;
> > +}
> > +
> > +static void __exit cleanup_tis_synquacer(void)
>
> tpm_tis_synquacer_module_exit
>
> > +{
> > +     platform_driver_unregister(&tis_synquacer_drv);
> > +}
> > +
> > +module_init(init_tis_synquacer);
> > +module_exit(cleanup_tis_synquacer);
> > +MODULE_AUTHOR("Masahisa Kojima (masahisa.kojima@linaro.org)");
> > +MODULE_DESCRIPTION("TPM MMIO Driver for Socionext SynQuacer platform");
> > +MODULE_VERSION("2.0");
> > +MODULE_LICENSE("GPL");
> > --
> > 2.20.1
> >
>
> /Jarkko
