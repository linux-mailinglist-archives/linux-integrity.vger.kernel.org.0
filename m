Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2947B2440DC
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Aug 2020 23:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgHMVtG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Aug 2020 17:49:06 -0400
Received: from mga11.intel.com ([192.55.52.93]:56960 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbgHMVtG (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Aug 2020 17:49:06 -0400
IronPort-SDR: vWsIAAdbEkdSWLd+QmFrmIw+kKoBGjqnMD6k/yf/RD7TP4bLaBEyBq6AvMC+MHfa4AxrVxFIao
 1bXrJKsS/mKw==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="151976416"
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; 
   d="scan'208";a="151976416"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2020 14:48:03 -0700
IronPort-SDR: Y7Z6czkVoQ5cKwAwQhiVijFTbbPnsZhMxDEUoCYg0gkhJawoE5rC7vO/pLTC3ubeIH6AxPWr2I
 X3UyVXJ0/ZVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; 
   d="scan'208";a="439922391"
Received: from chenghao-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.42.17])
  by orsmga004.jf.intel.com with ESMTP; 13 Aug 2020 14:48:00 -0700
Date:   Fri, 14 Aug 2020 00:48:00 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Masahisa Kojima <masahisa.kojima@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ardb@kernel.org, devicetree <devicetree@vger.kernel.org>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca
Subject: Re: [PATCH v4 1/2] tpm: tis: add support for MMIO TPM on SynQuacer
Message-ID: <20200813214800.GA5941@linux.intel.com>
References: <20200717084932.3449-1-masahisa.kojima@linaro.org>
 <20200717084932.3449-2-masahisa.kojima@linaro.org>
 <20200723023634.GI45081@linux.intel.com>
 <CADQ0-X8wYq97iqoKHAoyTN3qJf_f243e3HEhzjkbNAT-8FEEGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADQ0-X8wYq97iqoKHAoyTN3qJf_f243e3HEhzjkbNAT-8FEEGQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jul 27, 2020 at 12:13:44PM +0900, Masahisa Kojima wrote:
> Hi Jarkko,
> 
> Thank you for your comments.
> 
> On Thu, 23 Jul 2020 at 11:36, Jarkko Sakkinen
> <jarkko.sakkinen@linux.intel.com> wrote:
> >
> > On Fri, Jul 17, 2020 at 05:49:31PM +0900, Masahisa Kojima wrote:
> > > When fitted, the SynQuacer platform exposes its SPI TPM via a MMIO
> > > window that is backed by the SPI command sequencer in the SPI bus
> > > controller. This arrangement has the limitation that only byte size
> > > accesses are supported, and so we'll need to provide a separate module
> > > that take this into account.
> > >
> > > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > > ---
> > >  drivers/char/tpm/Kconfig             |  12 ++
> > >  drivers/char/tpm/Makefile            |   1 +
> > >  drivers/char/tpm/tpm_tis_synquacer.c | 209 +++++++++++++++++++++++++++
> > >  3 files changed, 222 insertions(+)
> > >  create mode 100644 drivers/char/tpm/tpm_tis_synquacer.c
> > >
> > > diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> > > index 58b4c573d176..a18c314da211 100644
> > > --- a/drivers/char/tpm/Kconfig
> > > +++ b/drivers/char/tpm/Kconfig
> > > @@ -74,6 +74,18 @@ config TCG_TIS_SPI_CR50
> > >         If you have a H1 secure module running Cr50 firmware on SPI bus,
> > >         say Yes and it will be accessible from within Linux.
> > >
> > > +config TCG_TIS_SYNQUACER
> > > +     tristate "TPM Interface Specification 1.2 Interface / TPM 2.0 FIFO Interface (MMIO - SynQuacer)"
> > > +     depends on ARCH_SYNQUACER
> > > +     select TCG_TIS_CORE
> > > +     help
> > > +       If you have a TPM security chip that is compliant with the
> > > +       TCG TIS 1.2 TPM specification (TPM1.2) or the TCG PTP FIFO
> > > +       specification (TPM2.0) say Yes and it will be accessible from
> > > +       within Linux on Socionext SynQuacer platform.
> > > +       To compile this driver as a module, choose  M here;
> > > +       the module will be called tpm_tis_synquacer.
> > > +
> > >  config TCG_TIS_I2C_ATMEL
> > >       tristate "TPM Interface Specification 1.2 Interface (I2C - Atmel)"
> > >       depends on I2C
> > > diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> > > index 9567e5197f74..84db4fb3a9c9 100644
> > > --- a/drivers/char/tpm/Makefile
> > > +++ b/drivers/char/tpm/Makefile
> > > @@ -21,6 +21,7 @@ tpm-$(CONFIG_EFI) += eventlog/efi.o
> > >  tpm-$(CONFIG_OF) += eventlog/of.o
> > >  obj-$(CONFIG_TCG_TIS_CORE) += tpm_tis_core.o
> > >  obj-$(CONFIG_TCG_TIS) += tpm_tis.o
> > > +obj-$(CONFIG_TCG_TIS_SYNQUACER) += tpm_tis_synquacer.o
> > >
> > >  obj-$(CONFIG_TCG_TIS_SPI) += tpm_tis_spi.o
> > >  tpm_tis_spi-y := tpm_tis_spi_main.o
> > > diff --git a/drivers/char/tpm/tpm_tis_synquacer.c b/drivers/char/tpm/tpm_tis_synquacer.c
> > > new file mode 100644
> > > index 000000000000..ac2a1d2a5001
> > > --- /dev/null
> > > +++ b/drivers/char/tpm/tpm_tis_synquacer.c
> > > @@ -0,0 +1,209 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (C) 2020 Linaro Ltd.
> > > + *
> > > + * This device driver implements MMIO TPM on SynQuacer Platform.
> > > + */
> > > +#include <linux/acpi.h>
> > > +#include <linux/init.h>
> > > +#include <linux/module.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/kernel.h>
> > > +#include "tpm.h"
> > > +#include "tpm_tis_core.h"
> > > +
> > > +struct tpm_tis_synquacer_info {
> > > +     struct resource res;
> > > +     /* irq > 0 means: use irq $irq;
> > > +      * irq = 0 means: autoprobe for an irq;
> > > +      * irq = -1 means: no irq support
> > > +      */
> > > +     int irq;
> > > +};
> >
> > According to the coding style, multi-line comments must begin with an
> > empty line.
> >
> > Also it would be preferable to have the comment prepending the struct
> > for easier read:
> >
> > /*
> >  * irq > 0 means: use irq $irq;
> >  * irq = 0 means: autoprobe for an irq;
> >  * irq = -1 means: no irq support
> >  */
> > struct tpm_tis_synquacer_info {
> 
> I will modify.
> 
> >
> > > +
> > > +struct tpm_tis_synquacer_phy {
> > > +     struct tpm_tis_data priv;
> > > +     void __iomem *iobase;
> > > +};
> > > +
> > > +static inline struct tpm_tis_synquacer_phy *to_tpm_tis_tcg_phy(struct tpm_tis_data *data)
> > > +{
> > > +     return container_of(data, struct tpm_tis_synquacer_phy, priv);
> > > +}
> > > +
> > > +static int tpm_tis_synquacer_read_bytes(struct tpm_tis_data *data, u32 addr,
> > > +                                     u16 len, u8 *result)
> > > +{
> > > +     struct tpm_tis_synquacer_phy *phy = to_tpm_tis_tcg_phy(data);
> > > +
> > > +     while (len--)
> > > +             *result++ = ioread8(phy->iobase + addr);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int tpm_tis_synquacer_write_bytes(struct tpm_tis_data *data, u32 addr,
> > > +                                      u16 len, const u8 *value)
> > > +{
> > > +     struct tpm_tis_synquacer_phy *phy = to_tpm_tis_tcg_phy(data);
> > > +
> > > +     while (len--)
> > > +             iowrite8(*value++, phy->iobase + addr);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int tpm_tis_synquacer_read16_bw(struct tpm_tis_data *data,
> > > +                                    u32 addr, u16 *result)
> > > +{
> > > +     struct tpm_tis_synquacer_phy *phy = to_tpm_tis_tcg_phy(data);
> > > +
> > > +     /*
> > > +      * Due to the limitation of SPI controller on SynQuacer,
> > > +      * 16/32 bits access must be done in byte-wise and descending order.
> > > +      */
> > > +     *result = (ioread8(phy->iobase + addr + 1) << 8) |
> > > +               (ioread8(phy->iobase + addr));
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int tpm_tis_synquacer_read32_bw(struct tpm_tis_data *data,
> > > +                                    u32 addr, u32 *result)
> > > +{
> > > +     struct tpm_tis_synquacer_phy *phy = to_tpm_tis_tcg_phy(data);
> > > +
> > > +     /*
> > > +      * Due to the limitation of SPI controller on SynQuacer,
> > > +      * 16/32 bits access must be done in byte-wise and descending order.
> > > +      */
> > > +     *result = (ioread8(phy->iobase + addr + 3) << 24) |
> > > +               (ioread8(phy->iobase + addr + 2) << 16) |
> > > +               (ioread8(phy->iobase + addr + 1) << 8) |
> > > +               (ioread8(phy->iobase + addr));
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static int tpm_tis_synquacer_write32_bw(struct tpm_tis_data *data,
> > > +                                     u32 addr, u32 value)
> > > +{
> > > +     struct tpm_tis_synquacer_phy *phy = to_tpm_tis_tcg_phy(data);
> > > +
> > > +     /*
> > > +      * Due to the limitation of SPI controller on SynQuacer,
> > > +      * 16/32 bits access must be done in byte-wise and descending order.
> > > +      */
> > > +     iowrite8(value >> 24, phy->iobase + addr + 3);
> > > +     iowrite8(value >> 16, phy->iobase + addr + 2);
> > > +     iowrite8(value >> 8, phy->iobase + addr + 1);
> > > +     iowrite8(value, phy->iobase + addr);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static const struct tpm_tis_phy_ops tpm_tcg_bw = {
> > > +     .read_bytes     = tpm_tis_synquacer_read_bytes,
> > > +     .write_bytes    = tpm_tis_synquacer_write_bytes,
> > > +     .read16         = tpm_tis_synquacer_read16_bw,
> > > +     .read32         = tpm_tis_synquacer_read32_bw,
> > > +     .write32        = tpm_tis_synquacer_write32_bw,
> > > +};
> > > +
> > > +static int tpm_tis_synquacer_init(struct device *dev,
> > > +                               struct tpm_tis_synquacer_info *tpm_info)
> > > +{
> > > +     struct tpm_tis_synquacer_phy *phy;
> > > +
> > > +     phy = devm_kzalloc(dev, sizeof(struct tpm_tis_synquacer_phy), GFP_KERNEL);
> > > +     if (phy == NULL)
> > > +             return -ENOMEM;
> > > +
> > > +     phy->iobase = devm_ioremap_resource(dev, &tpm_info->res);
> > > +     if (IS_ERR(phy->iobase))
> > > +             return PTR_ERR(phy->iobase);
> > > +
> > > +     return tpm_tis_core_init(dev, &phy->priv, tpm_info->irq, &tpm_tcg_bw,
> > > +                              ACPI_HANDLE(dev));
> > > +}
> > > +
> > > +static SIMPLE_DEV_PM_OPS(tpm_tis_synquacer_pm, tpm_pm_suspend, tpm_tis_resume);
> > > +
> > > +static int tpm_tis_synquacer_probe(struct platform_device *pdev)
> > > +{
> > > +     struct tpm_tis_synquacer_info tpm_info = {};
> > > +     struct resource *res;
> > > +
> > > +     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > +     if (res == NULL) {
> > > +             dev_err(&pdev->dev, "no memory resource defined\n");
> > > +             return -ENODEV;
> > > +     }
> > > +     tpm_info.res = *res;
> > > +
> > > +     tpm_info.irq = -1;
> > > +
> > > +     return tpm_tis_synquacer_init(&pdev->dev, &tpm_info);
> > > +}
> > > +
> > > +static int tpm_tis_synquacer_remove(struct platform_device *pdev)
> > > +{
> > > +     struct tpm_chip *chip = dev_get_drvdata(&pdev->dev);
> > > +
> > > +     tpm_chip_unregister(chip);
> > > +     tpm_tis_remove(chip);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +#ifdef CONFIG_OF
> > > +static const struct of_device_id tis_synquacer_of_platform_match[] = {
> > > +     {.compatible = "socionext,synquacer-tpm-mmio"},
> > > +     {},
> > > +};
> > > +MODULE_DEVICE_TABLE(of, tis_synquacer_of_platform_match);
> > > +#endif
> > > +
> > > +#ifdef CONFIG_ACPI
> > > +static const struct acpi_device_id tpm_synquacer_acpi_tbl[] = {
> > > +     { "SCX0009" },
> > > +     {},
> > > +};
> > > +MODULE_DEVICE_TABLE(acpi, tpm_synquacer_acpi_tbl);
> > > +#endif
> > > +
> > > +static struct platform_driver tis_synquacer_drv = {
> > > +     .probe = tpm_tis_synquacer_probe,
> > > +     .remove = tpm_tis_synquacer_remove,
> > > +     .driver = {
> > > +             .name           = "tpm_tis_synquacer",
> > > +             .pm             = &tpm_tis_synquacer_pm,
> > > +             .of_match_table = of_match_ptr(tis_synquacer_of_platform_match),
> > > +             .acpi_match_table = ACPI_PTR(tpm_synquacer_acpi_tbl),
> > > +     },
> > > +};
> > > +
> > > +static int __init tpm_tis_synquacer_module_init(void)
> > > +{
> > > +     int rc;
> > > +
> > > +     rc = platform_driver_register(&tis_synquacer_drv);
> > > +     if (rc)
> > > +             return rc;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static void __exit tpm_tis_synquacer_module_exit(void)
> > > +{
> > > +     platform_driver_unregister(&tis_synquacer_drv);
> > > +}
> > > +
> > > +module_init(tpm_tis_synquacer_module_init);
> > > +module_exit(tpm_tis_synquacer_module_exit);
> > > +MODULE_AUTHOR("Masahisa Kojima (masahisa.kojima@linaro.org)");
> >
> > It is completely redundant field because authorship is part of the
> > commit object itself. And it does not tell the truth after a while
> > anyway. MODULE_AUTHOR() made more sense before there was any sort of
> > legit versio control in place.
> >
> > I think it would be better not to have it as we don't have any use
> > for this data. It is just cruft hanging there.
> 
> OK, I will remove MODULE_AUTHOR() line.
> I will also plan to remove MODULE_VERSION("2.0").
> tpm_tis_spi_main.c only has MODULE_DESCRIPTION() and MODULE_LICENSE(),
> I plan to follow this example.
> 
> Regards,
> Masahisa

Yeah, I mean in GIT log your authority will be already sealed :-)

/Jarkko
