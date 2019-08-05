Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6B98341B
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Aug 2019 16:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733047AbfHFOke (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Aug 2019 10:40:34 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39757 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733021AbfHFOkd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Aug 2019 10:40:33 -0400
Received: by mail-pg1-f195.google.com with SMTP id u17so41710724pgi.6
        for <linux-integrity@vger.kernel.org>; Tue, 06 Aug 2019 07:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=1OEM8Kxh1iavtHrE6SU4/XrnKb20VgM9nqhlOhcLshg=;
        b=d7YlRKZbryzBLzrclhSdKOl6s8nlSQjzREsidggOCDnui5QblKwUjfrA5gB8/OueL+
         GFoIMJy1KeCbIAxO9oYx8/7WkYtzJvIUOUgxuF33fbWArb4ZSvPtDKSad/tmj6lxoD7z
         Z4vIZl2I0yqwTQA7Tr+CeVaqEFpfx01vNb3hA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=1OEM8Kxh1iavtHrE6SU4/XrnKb20VgM9nqhlOhcLshg=;
        b=taJZaCtTbSqbUyG9Z3ov1ElV+CeJtfavHdsk63SZg49pfdkb7PzHy8wiqymPNWG6ZJ
         HtFHcfXFDDgq+JXeC0wcKcRH4fhtcw2zTUX1OybtVaETbciG8yIN13DdO8+Jv6jlyRXQ
         jKRRcpFja8BjMHKqoPQ+BTeJQ42dAkNmbsEFp26PYoYrK9XfdF0UNmVSd1pN4y3BPPrM
         HmXd7EUnQJD9Vg57EXaSPjuJrekGohz8KTlU2y2E/roomBHPp91p/WMl0NSoqgxGZK21
         sgHSRxeIZadbLzj/GwoIqGilAvsTrcrm/jWxkC4i5qzqVmKQiAHncYyBRofT1gjL3my+
         X1RA==
X-Gm-Message-State: APjAAAXRElAfH+Z9784eX8R6+M6vj5E/S6Xa+MqnqzOW2swUtXluEKRp
        +MRM/IYQb+m458v4HAJxe1YIgQ==
X-Google-Smtp-Source: APXvYqyIdAcX9gEHIL92NTQ7Jcxp4UzryejnsH/gabMiD2oWCx9789AzjTxPqGhILNUBIkvH+fQVxQ==
X-Received: by 2002:aa7:8711:: with SMTP id b17mr4073613pfo.234.1565102432451;
        Tue, 06 Aug 2019 07:40:32 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 11sm87812562pfw.33.2019.08.06.07.40.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 07:40:31 -0700 (PDT)
Message-ID: <5d49915f.1c69fb81.bd889.bc77@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <04c0f028-308d-2dae-5067-8c239acaa3bf@infineon.com>
References: <20190716224518.62556-1-swboyd@chromium.org> <20190716224518.62556-7-swboyd@chromium.org> <04c0f028-308d-2dae-5067-8c239acaa3bf@infineon.com>
Subject: Re: [PATCH v2 6/6] tpm: Add driver for cr50 on I2C
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Duncan Laurie <dlaurie@chromium.org>, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
To:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
User-Agent: alot/0.8.1
Date:   Mon, 05 Aug 2019 16:52:55 -0700
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Quoting Alexander Steffen (2019-07-17 08:19:19)
> On 17.07.2019 00:45, Stephen Boyd wrote:
> > From: Duncan Laurie <dlaurie@chromium.org>
> >=20
> > Add TPM 2.0 compatible I2C interface for chips with cr50 firmware.
> >=20
> > The firmware running on the currently supported H1 MCU requires a
> > special driver to handle its specific protocol, and this makes it
> > unsuitable to use tpm_tis_core_* and instead it must implement the
> > underlying TPM protocol similar to the other I2C TPM drivers.
> >=20
> > - All 4 byes of status register must be read/written at once.
> > - FIFO and burst count is limited to 63 and must be drained by AP.
> > - Provides an interrupt to indicate when read response data is ready
> > and when the TPM is finished processing write data.
>=20
> And why does this prevent using the existing tpm_tis_core=20
> infrastructure? Taking the status register as an example, you could just =

> teach read_bytes to look at the requested address, and if it lies=20
> between 0x18 and 0x1b read the whole status register and then return=20
> only the subset that has been requested originally.
>=20
> Both approaches might not be pretty, but I'd prefer having shared code=20
> with explicit code paths for the differences instead of having two=20
> copies of mostly the same algorithm where a simple diff will print out a =

> lot more than just the crucial differences.

There are a few i2c tpm drivers in drivers/char/tpm/. I still haven't
looked at the details but maybe this will work out. I'm planning to drop
this patch from the series and revisit this after getting the SPI driver
merged.

>=20
> > This driver is based on the existing infineon I2C TPM driver, which
> > most closely matches the cr50 i2c protocol behavior.  The driver is
> > intentionally kept very similar in structure and style to the
> > corresponding drivers in coreboot and depthcharge.
> >=20
> > Signed-off-by: Duncan Laurie <dlaurie@chromium.org>
> > [swboyd@chromium.org: Depend on i2c even if it's a module, replace
> > boilier plate with SPDX tag, drop asm/byteorder.h include, simplify
> > return from probe]
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >   drivers/char/tpm/Kconfig    |  10 +
> >   drivers/char/tpm/Makefile   |   1 +
> >   drivers/char/tpm/cr50_i2c.c | 705 ++++++++++++++++++++++++++++++++++++
> >   3 files changed, 716 insertions(+)
> >   create mode 100644 drivers/char/tpm/cr50_i2c.c
> >=20
> > diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> > index b7028bfa6f87..57a8c3540265 100644
> > --- a/drivers/char/tpm/Kconfig
> > +++ b/drivers/char/tpm/Kconfig
> > @@ -119,6 +119,16 @@ config TCG_CR50
> >       ---help---
> >         Common routines shared by drivers for Cr50-based devices.
> >  =20
> > +config TCG_CR50_I2C
> > +     tristate "Cr50 I2C Interface"
> > +     depends on I2C
> > +     select TCG_CR50
> > +     ---help---
> > +       If you have a H1 secure module running Cr50 firmware on I2C bus,
> > +       say Yes and it will be accessible from within Linux. To compile
> > +       this driver as a module, choose M here; the module will be call=
ed
> > +       cr50_i2c.
> > +
> >   config TCG_CR50_SPI
> >       tristate "Cr50 SPI Interface"
> >       depends on SPI
> > diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> > index 4e89538c73c8..3ac3448c21fa 100644
> > --- a/drivers/char/tpm/Makefile
> > +++ b/drivers/char/tpm/Makefile
> > @@ -29,6 +29,7 @@ obj-$(CONFIG_TCG_NSC) +=3D tpm_nsc.o
> >   obj-$(CONFIG_TCG_ATMEL) +=3D tpm_atmel.o
> >   obj-$(CONFIG_TCG_CR50) +=3D cr50.o
> >   obj-$(CONFIG_TCG_CR50_SPI) +=3D cr50_spi.o
> > +obj-$(CONFIG_TCG_CR50_I2C) +=3D cr50_i2c.o
> >   obj-$(CONFIG_TCG_INFINEON) +=3D tpm_infineon.o
> >   obj-$(CONFIG_TCG_IBMVTPM) +=3D tpm_ibmvtpm.o
> >   obj-$(CONFIG_TCG_TIS_ST33ZP24) +=3D st33zp24/
> > diff --git a/drivers/char/tpm/cr50_i2c.c b/drivers/char/tpm/cr50_i2c.c
> > new file mode 100644
> > index 000000000000..25934c038b9b
> > --- /dev/null
> > +++ b/drivers/char/tpm/cr50_i2c.c
> > @@ -0,0 +1,705 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2016 Google Inc.
> > + *
> > + * Based on Linux Kernel TPM driver by
> > + * Peter Huewe <peter.huewe@infineon.com>
> > + * Copyright (C) 2011 Infineon Technologies
> > + */
> > +
> > +/*
> > + * cr50 is a firmware for H1 secure modules that requires special
> > + * handling for the I2C interface.
> > + *
> > + * - Use an interrupt for transaction status instead of hardcoded dela=
ys
> > + * - Must use write+wait+read read protocol
> > + * - All 4 bytes of status register must be read/written at once
> > + * - Burst count max is 63 bytes, and burst count behaves
> > + *   slightly differently than other I2C TPMs
> > + * - When reading from FIFO the full burstcnt must be read
> > + *   instead of just reading header and determining the remainder
> > + */
> > +
> > +#include <linux/acpi.h>
> > +#include <linux/completion.h>
> > +#include <linux/i2c.h>
> > +#include <linux/module.h>
> > +#include <linux/pm.h>
> > +#include <linux/slab.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/wait.h>
> > +#include "cr50.h"
> > +#include "tpm.h"
> > +
> > +#define CR50_MAX_BUFSIZE     63
> > +#define CR50_TIMEOUT_SHORT_MS        2       /* Short timeout during t=
ransactions */
> > +#define CR50_TIMEOUT_NOIRQ_MS        20      /* Timeout for TPM ready =
without IRQ */
> > +#define CR50_I2C_DID_VID     0x00281ae0L
> > +#define CR50_I2C_MAX_RETRIES 3       /* Max retries due to I2C errors =
*/
> > +#define CR50_I2C_RETRY_DELAY_LO      55      /* Min usecs between retr=
ies on I2C */
> > +#define CR50_I2C_RETRY_DELAY_HI      65      /* Max usecs between retr=
ies on I2C */
> > +
> > +static unsigned short rng_quality =3D 1022;
> > +
> > +module_param(rng_quality, ushort, 0644);
> > +MODULE_PARM_DESC(rng_quality,
> > +              "Estimation of true entropy, in bits per 1024 bits.");
> > +
> > +struct priv_data {
> > +     int irq;
> > +     int locality;
> > +     struct completion tpm_ready;
> > +     u8 buf[CR50_MAX_BUFSIZE + sizeof(u8)];
> > +};
> > +
> > +/*
> > + * The cr50 interrupt handler just signals waiting threads that the
> > + * interrupt was asserted.  It does not do any processing triggered
> > + * by interrupts but is instead used to avoid fixed delays.
> > + */
> > +static irqreturn_t cr50_i2c_int_handler(int dummy, void *dev_id)
> > +{
> > +     struct tpm_chip *chip =3D dev_id;
> > +     struct priv_data *priv =3D dev_get_drvdata(&chip->dev);
> > +
> > +     complete(&priv->tpm_ready);
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +/*
> > + * Wait for completion interrupt if available, otherwise use a fixed
> > + * delay for the TPM to be ready.
> > + *
> > + * Returns negative number for error, positive number for success.
> > + */
> > +static int cr50_i2c_wait_tpm_ready(struct tpm_chip *chip)
> > +{
> > +     struct priv_data *priv =3D dev_get_drvdata(&chip->dev);
> > +     long rc;
> > +
> > +     /* Use a safe fixed delay if interrupt is not supported */
> > +     if (priv->irq <=3D 0) {
> > +             msleep(CR50_TIMEOUT_NOIRQ_MS);
> > +             return 1;
> > +     }
> > +
> > +     /* Wait for interrupt to indicate TPM is ready to respond */
> > +     rc =3D wait_for_completion_timeout(&priv->tpm_ready,
> > +             msecs_to_jiffies(chip->timeout_a));
> > +
> > +     if (rc =3D=3D 0)
> > +             dev_warn(&chip->dev, "Timeout waiting for TPM ready\n");
> > +
> > +     return rc;
> > +}
> > +
> > +static void cr50_i2c_enable_tpm_irq(struct tpm_chip *chip)
> > +{
> > +     struct priv_data *priv =3D dev_get_drvdata(&chip->dev);
> > +
> > +     if (priv->irq > 0) {
> > +             reinit_completion(&priv->tpm_ready);
> > +             enable_irq(priv->irq);
> > +     }
> > +}
> > +
> > +static void cr50_i2c_disable_tpm_irq(struct tpm_chip *chip)
> > +{
> > +     struct priv_data *priv =3D dev_get_drvdata(&chip->dev);
> > +
> > +     if (priv->irq > 0)
> > +             disable_irq(priv->irq);
> > +}
> > +
> > +/*
> > + * cr50_i2c_transfer - transfer messages over i2c
> > + *
> > + * @adapter: i2c adapter
> > + * @msgs: array of messages to transfer
> > + * @num: number of messages in the array
> > + *
> > + * Call unlocked i2c transfer routine with the provided parameters and=
 retry
> > + * in case of bus errors. Returns the number of transferred messages.
> > + */
>=20
> Documentation is nice, why is it only present for some of the functions? =

> Also, the dev parameter is missing in the list of parameters above.

Ok.

>=20
> > +static int cr50_i2c_transfer(struct device *dev, struct i2c_adapter *a=
dapter,
> > +                          struct i2c_msg *msgs, int num)
> > +{
> > +     int rc, try;
> > +
> > +     for (try =3D 0; try < CR50_I2C_MAX_RETRIES; try++) {
> > +             rc =3D __i2c_transfer(adapter, msgs, num);
> > +             if (rc > 0)
> > +                     break;
> > +             if (try)
> > +                     dev_warn(dev, "i2c transfer failed (attempt %d/%d=
): %d\n",
> > +                              try+1, CR50_I2C_MAX_RETRIES, rc);
>=20
> Why does this not generate a message when the first attempt fails?
>=20

Hmm looks like an off-by-one bug.=20

> > +
> > +enum tis_access {
> > +     TPM_ACCESS_VALID =3D 0x80,
> > +     TPM_ACCESS_ACTIVE_LOCALITY =3D 0x20,
> > +     TPM_ACCESS_REQUEST_PENDING =3D 0x04,
> > +     TPM_ACCESS_REQUEST_USE =3D 0x02,
> > +};
> > +
> > +enum tis_status {
> > +     TPM_STS_VALID =3D 0x80,
> > +     TPM_STS_COMMAND_READY =3D 0x40,
> > +     TPM_STS_GO =3D 0x20,
> > +     TPM_STS_DATA_AVAIL =3D 0x10,
> > +     TPM_STS_DATA_EXPECT =3D 0x08,
> > +};
> > +
> > +enum tis_defaults {
> > +     TIS_SHORT_TIMEOUT =3D 750,        /* ms */
> > +     TIS_LONG_TIMEOUT =3D 2000,        /* 2 sec */
> > +};
>=20
> This is already defined in tpm_tis_core.h. Do you really need to=20
> redefine it here?

This whole chunk of code is copying from tpm_i2c_infineon.c and I'm not
sure why that driver redefines things either. If i include
tpm_tis_core.h then I need to undef the below defines so they can be
redefined in this file.

>=20
> > +
> > +#define      TPM_ACCESS(l)                   (0x0000 | ((l) << 4))
> > +#define      TPM_STS(l)                      (0x0001 | ((l) << 4))
> > +#define      TPM_DATA_FIFO(l)                (0x0005 | ((l) << 4))
> > +#define      TPM_DID_VID(l)                  (0x0006 | ((l) << 4))
> > +
