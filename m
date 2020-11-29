Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143932C79A6
	for <lists+linux-integrity@lfdr.de>; Sun, 29 Nov 2020 15:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgK2OwA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 29 Nov 2020 09:52:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgK2OwA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 29 Nov 2020 09:52:00 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382B8C0613CF;
        Sun, 29 Nov 2020 06:51:20 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id 608D51F4484F
Message-ID: <cbbb87015574eb06c7a9d99bd5757b257e0aa36b.camel@collabora.com>
Subject: Re: [PATCH v2] char: tpm: add i2c driver for cr50
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Adrian Ratiu <adrian.ratiu@collabora.com>,
        linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Helen Koike <helen.koike@collabora.com>,
        Duncan Laurie <dlaurie@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>, kernel@collabora.com,
        linux-kernel@vger.kernel.org
Date:   Sun, 29 Nov 2020 11:51:07 -0300
In-Reply-To: <20201129032933.GE39488@kernel.org>
References: <20201120172345.4040187-1-adrian.ratiu@collabora.com>
         <20201123220643.GA16777@kernel.org>
         <f36c43f81968a9ce2f3342e5c2c069722d8bfc7f.camel@collabora.com>
         <7edf80b70e4dd67d6f95c796c1ae26df9e51ba8d.camel@kernel.org>
         <6409c32842ab080d91d1851a58f7ec7bb4524336.camel@collabora.com>
         <20201129032933.GE39488@kernel.org>
Organization: Collabora
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 2020-11-29 at 05:29 +0200, Jarkko Sakkinen wrote:
> On Thu, Nov 26, 2020 at 03:19:24AM -0300, Ezequiel Garcia wrote:
> > On Thu, 2020-11-26 at 05:30 +0200, Jarkko Sakkinen wrote:
> > > On Tue, 2020-11-24 at 10:14 -0300, Ezequiel Garcia wrote:
> > > > Hi Jarkko,
> > > > 
> > > > Thanks for your review.
> > > > 
> > > > On Tue, 2020-11-24 at 00:06 +0200, Jarkko Sakkinen wrote:
> > > > > On Fri, Nov 20, 2020 at 07:23:45PM +0200, Adrian Ratiu wrote:
> > > > > > From: "dlaurie@chromium.org" <dlaurie@chromium.org>
> > > > > > 
> > > > > > Add TPM 2.0 compatible I2C interface for chips with cr50
> > > > > > firmware.
> > > > > > 
> > > > > > The firmware running on the currently supported H1 MCU requires a
> > > > > > special driver to handle its specific protocol, and this makes it
> > > > > > unsuitable to use tpm_tis_core_* and instead it must implement
> > > > > > the
> > > > > > underlying TPM protocol similar to the other I2C TPM drivers.
> > > > > > 
> > > > > > - All 4 byes of status register must be read/written at once.
> > > > > > - FIFO and burst count is limited to 63 and must be drained by
> > > > > > AP.
> > > > > > - Provides an interrupt to indicate when read response data is
> > > > > > ready
> > > > > > and when the TPM is finished processing write data.
> > > > > > 
> > > > > > This driver is based on the existing infineon I2C TPM driver,
> > > > > > which
> > > > > > most closely matches the cr50 i2c protocol behavior.
> > > > > > 
> > > > > > Cc: Helen Koike <helen.koike@collabora.com>
> > > > > > Signed-off-by: Duncan Laurie <dlaurie@chromium.org>
> > > > > > [swboyd@chromium.org: Depend on i2c even if it's a module,
> > > > > > replace
> > > > > > boilier plate with SPDX tag, drop asm/byteorder.h include,
> > > > > > simplify
> > > > > > return from probe]
> > > > > > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > > > > > Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
> > > > > > Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> > > > > > ---
> > > > > > Changes in v2:
> > > > > >   - Various small fixes all over (reorder includes, MAX_BUFSIZE,
> > > > > > comments, etc)
> > > > > >   - Reworked return values of i2c_wait_tpm_ready() to fix timeout
> > > > > > mis-handling
> > > > > > so ret == 0 now means success, the wait period jiffies is ignored
> > > > > > because that
> > > > > > number is meaningless and return a proper timeout error in case
> > > > > > jiffies == 0.
> > > > > >   - Make i2c default to 1 message per transfer (requested by
> > > > > > Helen)
> > > > > >   - Move -EIO error reporting to transfer function to cleanup
> > > > > > transfer() itself
> > > > > > and its R/W callers
> > > > > >   - Remove magic value hardcodings and introduce enum
> > > > > > force_release.
> > > > > > 
> > > > > > v1 posted at https://lkml.org/lkml/2020/2/25/349
> > > > > > 
> > > > > > Applies on next-20201120, tested on Chromebook EVE.
> > > > > > ---
> > > > > >  drivers/char/tpm/Kconfig            |  10 +
> > > > > >  drivers/char/tpm/Makefile           |   2 +
> > > > > >  drivers/char/tpm/tpm_tis_i2c_cr50.c | 768
> > > > > > ++++++++++++++++++++++++++++
> > > > > >  3 files changed, 780 insertions(+)
> > > > > >  create mode 100644 drivers/char/tpm/tpm_tis_i2c_cr50.c
> > > > > > 
> > > > > > diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> > > > > > index a18c314da211..4308f9ca7a43 100644
> > > > > > --- a/drivers/char/tpm/Kconfig
> > > > > > +++ b/drivers/char/tpm/Kconfig
> > > > > > @@ -86,6 +86,16 @@ config TCG_TIS_SYNQUACER
> > > > > >           To compile this driver as a module, choose  M here;
> > > > > >           the module will be called tpm_tis_synquacer.
> > > > > >  
> > > > > > +config TCG_TIS_I2C_CR50
> > > > > > +       tristate "TPM Interface Specification 2.0 Interface (I2C
> > > > > > - CR50)"
> > > > > > +       depends on I2C
> > > > > > +       select TCG_CR50
> > > > > > +       help
> > > > > > +         This is a driver for the Google cr50 I2C TPM interface
> > > > > > which is a
> > > > > > +         custom microcontroller and requires a custom i2c
> > > > > > protocol interface
> > > > > > +         to handle the limitations of the hardware.  To compile
> > > > > > this driver
> > > > > > +         as a module, choose M here; the module will be called
> > > > > > tcg_tis_i2c_cr50.
> > > > > > +
> > > > > >  config TCG_TIS_I2C_ATMEL
> > > > > >         tristate "TPM Interface Specification 1.2 Interface (I2C
> > > > > > - Atmel)"
> > > > > >         depends on I2C
> > > > > > diff --git a/drivers/char/tpm/Makefile
> > > > > > b/drivers/char/tpm/Makefile
> > > > > > index 84db4fb3a9c9..66d39ea6bd10 100644
> > > > > > --- a/drivers/char/tpm/Makefile
> > > > > > +++ b/drivers/char/tpm/Makefile
> > > > > > @@ -27,6 +27,8 @@ obj-$(CONFIG_TCG_TIS_SPI) += tpm_tis_spi.o
> > > > > >  tpm_tis_spi-y := tpm_tis_spi_main.o
> > > > > >  tpm_tis_spi-$(CONFIG_TCG_TIS_SPI_CR50) += tpm_tis_spi_cr50.o
> > > > > >  
> > > > > > +obj-$(CONFIG_TCG_TIS_I2C_CR50) += tpm_tis_i2c_cr50.o
> > > > > > +
> > > > > >  obj-$(CONFIG_TCG_TIS_I2C_ATMEL) += tpm_i2c_atmel.o
> > > > > >  obj-$(CONFIG_TCG_TIS_I2C_INFINEON) += tpm_i2c_infineon.o
> > > > > >  obj-$(CONFIG_TCG_TIS_I2C_NUVOTON) += tpm_i2c_nuvoton.o
> > > > > > diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c
> > > > > > b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> > > > > > new file mode 100644
> > > > > > index 000000000000..37555dafdca0
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> > > > > > @@ -0,0 +1,768 @@
> > > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > > +/*
> > > > > > + * Copyright 2016 Google Inc.
> > > > > > + *
> > > > > > + * Based on Linux Kernel TPM driver by
> > > > > > + * Peter Huewe <peter.huewe@infineon.com>
> > > > > > + * Copyright (C) 2011 Infineon Technologies
> > > > > > + */
> > > > > > +
> > > > > > +/*
> > > > > > + * cr50 is a firmware for H1 secure modules that requires
> > > > > > special
> > > > > > + * handling for the I2C interface.
> > > > > > + *
> > > > > > + * - Use an interrupt for transaction status instead of
> > > > > > hardcoded delays
> > > > > > + * - Must use write+wait+read read protocol
> > > > > > + * - All 4 bytes of status register must be read/written at once
> > > > > > + * - Burst count max is 63 bytes, and burst count behaves
> > > > > > + *   slightly differently than other I2C TPMs
> > > > > > + * - When reading from FIFO the full burstcnt must be read
> > > > > > + *   instead of just reading header and determining the
> > > > > > remainder
> > > > > > + */
> > > > > > +
> > > > > > +#include <linux/acpi.h>
> > > > > > +#include <linux/completion.h>
> > > > > > +#include <linux/i2c.h>
> > > > > > +#include <linux/interrupt.h>
> > > > > > +#include <linux/module.h>
> > > > > > +#include <linux/pm.h>
> > > > > > +#include <linux/slab.h>
> > > > > > +#include <linux/wait.h>
> > > > > > +
> > > > > > +#include "tpm_tis_core.h"
> > > > > > +
> > > > > > +#define CR50_MAX_BUFSIZE       64
> > > > > > +#define CR50_TIMEOUT_SHORT_MS  2       /* Short timeout during
> > > > > > transactions */
> > > > > > +#define CR50_TIMEOUT_NOIRQ_MS  20      /* Timeout for TPM ready
> > > > > > without IRQ */
> > > > > > +#define CR50_I2C_DID_VID       0x00281ae0L
> > > > > > +#define CR50_I2C_MAX_RETRIES   3       /* Max retries due to I2C
> > > > > > errors */
> > > > > > +#define CR50_I2C_RETRY_DELAY_LO        55      /* Min usecs
> > > > > > between retries on I2C */
> > > > > > +#define CR50_I2C_RETRY_DELAY_HI        65      /* Max usecs
> > > > > > between retries on I2C */
> > > > > 
> > > > > CR50_ -> TPM_CR50_
> > > > > 
> > > > > > +
> > > > > > +#define TPM_I2C_ACCESS(l)      (0x0000 | ((l) << 4))
> > > > > > +#define TPM_I2C_STS(l)         (0x0001 | ((l) << 4))
> > > > > > +#define TPM_I2C_DATA_FIFO(l)   (0x0005 | ((l) << 4))
> > > > > > +#define TPM_I2C_DID_VID(l)     (0x0006 | ((l) << 4))
> > > > > > +
> > > > > > +struct priv_data {
> > > > > > +       int irq;
> > > > > > +       int locality;
> > > > > > +       struct completion tpm_ready;
> > > > > > +       u8 buf[CR50_MAX_BUFSIZE];
> > > > > > +};
> > > > > 
> > > > > tpm_i2c_cr50_priv_data
> > > > > 
> > > > > > +
> > > > > > +enum force_release {
> > > > > > +       CR50_NO_FORCE = 0x0,
> > > > > > +       CR50_FORCE = 0x1,
> > > > > > +};
> > > > > 
> > > > > I'd just 
> > > > > 
> > > > > #define TPM_I2C_CR50_NO_FORCE   0
> > > > > #define TPM_I2C_CR50_FORCE      1
> > > > > 
> > > > 
> > > > A proper enumerated type has advantages over a preprocessor macro:
> > > > even if the compiler won't warn you, static analyzers can warn
> > > > about a misuse.
> > > 
> > > Why don't you just use "bool", "true" and "false"? I ignored that
> > > this has nothing to do with the hardware last time.
> > > 
> > 
> > Well, boolean parameters are a known anti-pattern [1].
> > 
> > [1] https://people.mpi-inf.mpg.de/~jblanche/api-design.pdf
> 
> It's an internal function to begin with.
> 

Too bad you see it that way. Anti-patterns spread like the flu,
and then it takes a lot of energy to take care of them.

Cheers,
Ezequiel

