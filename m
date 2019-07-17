Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 998BC6C1C8
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2019 21:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbfGQT5h (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jul 2019 15:57:37 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42781 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbfGQT5h (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jul 2019 15:57:37 -0400
Received: by mail-pl1-f196.google.com with SMTP id ay6so12529186plb.9
        for <linux-integrity@vger.kernel.org>; Wed, 17 Jul 2019 12:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:cc:from:user-agent:date;
        bh=iwMpxTkjgL83FuKyw0WPsr67HOgXM4S+LDsS5kZmLLo=;
        b=M7Eoj/iMSIVk2mNbrcYDLaWmudhOh0RUGc74CLcSo2ePzN09gO7c2bXhuWtrYfW4rF
         FTrFi1WjGsgVbbL6peDa1PTqIntcIHNpUDzeMmdRO1gxal/TNse/6/szcEM63gCQMnWy
         vgdHj6UR7+M5YiKeCK8syfa504zKM6plz3c4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:cc:from
         :user-agent:date;
        bh=iwMpxTkjgL83FuKyw0WPsr67HOgXM4S+LDsS5kZmLLo=;
        b=T2Q5VNck73qcay92flUVlFMbmKkfXNQ+1K2aoBFDIyHaXc6MLnkWPxzP0tsl+ELJwP
         X3XPMrr4kV6vKNC0N91Cv0TjJLF3VU1pa0E6LqbD7dEtB4KmbLwr4LK61AGOFiEnfHJF
         w7QcHy1K8VlC9IabYptJggj071BTKzyFN0iTzKUBcsevCDmUtLl7a9UsA20JMS5+uH46
         zVOD4l0SKGVZ8lpUkiDVnuTrzSDbml7MVLcKNWidcm3BSH8zgHzNIjsgxyI55IKd2rz4
         SoXVarh89xkHn3rwwwMfB2uSInTHjKuDz8LOikW+bwupoUvNuVmHklwr7cNz3E3WEeCh
         tuiQ==
X-Gm-Message-State: APjAAAV+bq52qpakpzGDRSj2vCai2JucwRcdjRKVTvfIK2mA2efPPwwJ
        wG74lu37FWZXuJU/5FxzpPHABQ==
X-Google-Smtp-Source: APXvYqwGahtqb6kGKiT7txRKFiysfsH/p6967e4udDMdMn72x+jJ8diX/QO5PCjuF9Wpw4wWR74dJg==
X-Received: by 2002:a17:902:b944:: with SMTP id h4mr44442955pls.179.1563393456071;
        Wed, 17 Jul 2019 12:57:36 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id l189sm29098491pfl.7.2019.07.17.12.57.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 12:57:35 -0700 (PDT)
Message-ID: <5d2f7daf.1c69fb81.c0b13.c3d4@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <f824e3ab-ae2f-8c2f-549a-16569b10966e@infineon.com>
References: <20190716224518.62556-1-swboyd@chromium.org> <20190716224518.62556-6-swboyd@chromium.org> <f824e3ab-ae2f-8c2f-549a-16569b10966e@infineon.com>
Subject: Re: [PATCH v2 5/6] tpm: add driver for cr50 on SPI
To:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Cc:     Andrey Pronin <apronin@chromium.org>, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Wed, 17 Jul 2019 12:57:34 -0700
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Quoting Alexander Steffen (2019-07-17 05:00:06)
> On 17.07.2019 00:45, Stephen Boyd wrote:
> > From: Andrey Pronin <apronin@chromium.org>
> >=20
> > Add TPM2.0 PTP FIFO compatible SPI interface for chips with Cr50
> > firmware. The firmware running on the currently supported H1
> > Secure Microcontroller requires a special driver to handle its
> > specifics:
> >   - need to ensure a certain delay between spi transactions, or else
> >     the chip may miss some part of the next transaction;
> >   - if there is no spi activity for some time, it may go to sleep,
> >     and needs to be waken up before sending further commands;
> >   - access to vendor-specific registers.
> >=20
> > Signed-off-by: Andrey Pronin <apronin@chromium.org>
> > [swboyd@chromium.org: Replace boilerplate with SPDX tag, drop
> > suspended bit and remove ifdef checks in cr50.h, push tpm.h
> > include into cr50.c]
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>

> > diff --git a/drivers/char/tpm/cr50_spi.c b/drivers/char/tpm/cr50_spi.c
> > new file mode 100644
> > index 000000000000..3c1b472297ad
> > --- /dev/null
> > +++ b/drivers/char/tpm/cr50_spi.c
> > @@ -0,0 +1,450 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2016 Google, Inc
> > + *
> > + * This device driver implements a TCG PTP FIFO interface over SPI for=
 chips
> > + * with Cr50 firmware.
> > + * It is based on tpm_tis_spi driver by Peter Huewe and Christophe Ric=
ard.
> > + */
> > +
> > +#include <linux/init.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/pm.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/wait.h>
> > +#include "cr50.h"
> > +#include "tpm_tis_core.h"
> > +
> > +/*
> > + * Cr50 timing constants:
> > + * - can go to sleep not earlier than after CR50_SLEEP_DELAY_MSEC.
> > + * - needs up to CR50_WAKE_START_DELAY_MSEC to wake after sleep.
> > + * - requires waiting for "ready" IRQ, if supported; or waiting for at=
 least
> > + *   CR50_NOIRQ_ACCESS_DELAY_MSEC between transactions, if IRQ is not =
supported.
> > + * - waits for up to CR50_FLOW_CONTROL_MSEC for flow control 'ready' i=
ndication.
> > + */
> > +#define CR50_SLEEP_DELAY_MSEC                        1000
> > +#define CR50_WAKE_START_DELAY_MSEC           1
> > +#define CR50_NOIRQ_ACCESS_DELAY_MSEC         2
> > +#define CR50_READY_IRQ_TIMEOUT_MSEC          TPM2_TIMEOUT_A
> > +#define CR50_FLOW_CONTROL_MSEC                       TPM2_TIMEOUT_A
> > +#define MAX_IRQ_CONFIRMATION_ATTEMPTS                3
> > +
> > +#define MAX_SPI_FRAMESIZE                    64
> > +
> > +#define TPM_CR50_FW_VER(l)                   (0x0F90 | ((l) << 12))
> > +#define TPM_CR50_MAX_FW_VER_LEN                      64
> > +
> > +static unsigned short rng_quality =3D 1022;
> > +module_param(rng_quality, ushort, 0644);
> > +MODULE_PARM_DESC(rng_quality,
> > +              "Estimation of true entropy, in bits per 1024 bits.");
>=20
> What is the purpose of this parameter? None of the other TPM drivers=20
> have it.

I think the idea is to let users override the quality if they decide
that they don't want to use the default value specified in the driver.

>=20
> > +
> > +struct cr50_spi_phy {
> > +     struct tpm_tis_data priv;
> > +     struct spi_device *spi_device;
> > +
> > +     struct mutex time_track_mutex;
> > +     unsigned long last_access_jiffies;
> > +     unsigned long wake_after_jiffies;
> > +
> > +     unsigned long access_delay_jiffies;
> > +     unsigned long sleep_delay_jiffies;
> > +     unsigned int wake_start_delay_msec;
> > +
> > +     struct completion tpm_ready;
> > +
> > +     unsigned int irq_confirmation_attempt;
> > +     bool irq_needs_confirmation;
> > +     bool irq_confirmed;
> > +
> > +     u8 tx_buf[MAX_SPI_FRAMESIZE] ____cacheline_aligned;
> > +     u8 rx_buf[MAX_SPI_FRAMESIZE] ____cacheline_aligned;
> > +};
> > +
> > +static struct cr50_spi_phy *to_cr50_spi_phy(struct tpm_tis_data *data)
> > +{
> > +     return container_of(data, struct cr50_spi_phy, priv);
> > +}
> > +
> > +/*
> > + * The cr50 interrupt handler just signals waiting threads that the
> > + * interrupt was asserted.  It does not do any processing triggered
> > + * by interrupts but is instead used to avoid fixed delays.
> > + */
> > +static irqreturn_t cr50_spi_irq_handler(int dummy, void *dev_id)
> > +{
> > +     struct cr50_spi_phy *phy =3D dev_id;
> > +
> > +     phy->irq_confirmed =3D true;
> > +     complete(&phy->tpm_ready);
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +/*
> > + * Cr50 needs to have at least some delay between consecutive
> > + * transactions. Make sure we wait.
> > + */
> > +static void cr50_ensure_access_delay(struct cr50_spi_phy *phy)
> > +{
> > +     /*
> > +      * Note: There is a small chance, if Cr50 is not accessed in a fe=
w days,
> > +      * that time_in_range will not provide the correct result after t=
he wrap
> > +      * around for jiffies. In this case, we'll have an unneeded short=
 delay,
> > +      * which is fine.
> > +      */
> > +     unsigned long allowed_access =3D
> > +             phy->last_access_jiffies + phy->access_delay_jiffies;
> > +     unsigned long time_now =3D jiffies;
> > +
> > +     if (time_in_range_open(time_now,
> > +                            phy->last_access_jiffies, allowed_access))=
 {
> > +             unsigned long remaining =3D
> > +                     wait_for_completion_timeout(&phy->tpm_ready,
> > +                                                 allowed_access - time=
_now);
> > +             if (remaining =3D=3D 0 && phy->irq_confirmed) {
> > +                     dev_warn(&phy->spi_device->dev,
> > +                              "Timeout waiting for TPM ready IRQ\n");
> > +             }
> > +     }
> > +     if (phy->irq_needs_confirmation) {
> > +             if (phy->irq_confirmed) {
> > +                     phy->irq_needs_confirmation =3D false;
> > +                     phy->access_delay_jiffies =3D
> > +                             msecs_to_jiffies(CR50_READY_IRQ_TIMEOUT_M=
SEC);
> > +                     dev_info(&phy->spi_device->dev,
> > +                              "TPM ready IRQ confirmed on attempt %u\n=
",
> > +                              phy->irq_confirmation_attempt);
> > +             } else if (++phy->irq_confirmation_attempt >
> > +                        MAX_IRQ_CONFIRMATION_ATTEMPTS) {
> > +                     phy->irq_needs_confirmation =3D false;
> > +                     dev_warn(&phy->spi_device->dev,
> > +                              "IRQ not confirmed - will use delays\n");
> > +             }
> > +     }
> > +}
> > +
> > +/*
> > + * Cr50 might go to sleep if there is no SPI activity for some time and
> > + * miss the first few bits/bytes on the bus. In such case, wake it up
> > + * by asserting CS and give it time to start up.
> > + */
> > +static bool cr50_needs_waking(struct cr50_spi_phy *phy)
> > +{
> > +     /*
> > +      * Note: There is a small chance, if Cr50 is not accessed in a fe=
w days,
> > +      * that time_in_range will not provide the correct result after t=
he wrap
> > +      * around for jiffies. In this case, we'll probably timeout or re=
ad
> > +      * incorrect value from TPM_STS and just retry the operation.
> > +      */
> > +     return !time_in_range_open(jiffies,
> > +                                phy->last_access_jiffies,
> > +                                phy->wake_after_jiffies);
> > +}
> > +
> > +static void cr50_wake_if_needed(struct cr50_spi_phy *phy)
> > +{
> > +     if (cr50_needs_waking(phy)) {
> > +             /* Assert CS, wait 1 msec, deassert CS */
> > +             struct spi_transfer spi_cs_wake =3D { .delay_usecs =3D 10=
00 };
> > +
> > +             spi_sync_transfer(phy->spi_device, &spi_cs_wake, 1);
> > +             /* Wait for it to fully wake */
> > +             msleep(phy->wake_start_delay_msec);
>=20
> wake_start_delay_msec is always 1, isn't it? (Why is that a variable at=20
> all? I see only one place that ever sets it.) Then msleep is not the=20
> best function to use, since it will usually sleep much longer. Use=20
> usleep_range instead. See Documentation/timers/timers-howto.txt.

Thanks. Will fix to be 1ms to 2ms range.

>=20
> > +     }
> > +     /* Reset the time when we need to wake Cr50 again */
> > +     phy->wake_after_jiffies =3D jiffies + phy->sleep_delay_jiffies;
> > +}
> > +
> > +/*
> > + * Flow control: clock the bus and wait for cr50 to set LSB before
> > + * sending/receiving data. TCG PTP spec allows it to happen during
> > + * the last byte of header, but cr50 never does that in practice,
> > + * and earlier versions had a bug when it was set too early, so don't
> > + * check for it during header transfer.
> > + */
> > +static int cr50_spi_flow_control(struct cr50_spi_phy *phy)
> > +{
> > +     unsigned long timeout_jiffies =3D
> > +             jiffies + msecs_to_jiffies(CR50_FLOW_CONTROL_MSEC);
> > +     struct spi_message m;
> > +     int ret;
> > +     struct spi_transfer spi_xfer =3D {
> > +             .rx_buf =3D phy->rx_buf,
> > +             .len =3D 1,
> > +             .cs_change =3D 1,
> > +     };
> > +
> > +     do {
> > +             spi_message_init(&m);
> > +             spi_message_add_tail(&spi_xfer, &m);
> > +             ret =3D spi_sync_locked(phy->spi_device, &m);
> > +             if (ret < 0)
> > +                     return ret;
> > +             if (time_after(jiffies, timeout_jiffies)) {
> > +                     dev_warn(&phy->spi_device->dev,
> > +                              "Timeout during flow control\n");
> > +                     return -EBUSY;
> > +             }
> > +     } while (!(phy->rx_buf[0] & 0x01));
> > +     return 0;
> > +}
> > +
> > +static int cr50_spi_xfer_bytes(struct tpm_tis_data *data, u32 addr,
> > +                            u16 len, const u8 *tx, u8 *rx)
> > +{
> > +     struct cr50_spi_phy *phy =3D to_cr50_spi_phy(data);
> > +     struct spi_message m;
> > +     struct spi_transfer spi_xfer =3D {
> > +             .tx_buf =3D phy->tx_buf,
> > +             .rx_buf =3D phy->rx_buf,
> > +             .len =3D 4,
> > +             .cs_change =3D 1,
> > +     };
> > +     int ret;
> > +
> > +     if (len > MAX_SPI_FRAMESIZE)
> > +             return -EINVAL;
> > +
> > +     /*
> > +      * Do this outside of spi_bus_lock in case cr50 is not the
> > +      * only device on that spi bus.
> > +      */
> > +     mutex_lock(&phy->time_track_mutex);
> > +     cr50_ensure_access_delay(phy);
> > +     cr50_wake_if_needed(phy);
> > +
> > +     phy->tx_buf[0] =3D (tx ? 0x00 : 0x80) | (len - 1);
> > +     phy->tx_buf[1] =3D 0xD4;
> > +     phy->tx_buf[2] =3D (addr >> 8) & 0xFF;
> > +     phy->tx_buf[3] =3D addr & 0xFF;
> > +
> > +     spi_message_init(&m);
> > +     spi_message_add_tail(&spi_xfer, &m);
> > +
> > +     spi_bus_lock(phy->spi_device->master);
> > +     ret =3D spi_sync_locked(phy->spi_device, &m);
> > +     if (ret < 0)
> > +             goto exit;
> > +
> > +     ret =3D cr50_spi_flow_control(phy);
> > +     if (ret < 0)
> > +             goto exit;
> > +
> > +     spi_xfer.cs_change =3D 0;
> > +     spi_xfer.len =3D len;
> > +     if (tx) {
> > +             memcpy(phy->tx_buf, tx, len);
> > +             spi_xfer.rx_buf =3D NULL;
> > +     } else {
> > +             spi_xfer.tx_buf =3D NULL;
> > +     }
> > +
> > +     spi_message_init(&m);
> > +     spi_message_add_tail(&spi_xfer, &m);
> > +     reinit_completion(&phy->tpm_ready);
> > +     ret =3D spi_sync_locked(phy->spi_device, &m);
> > +     if (rx)
> > +             memcpy(rx, phy->rx_buf, len);
> > +
> > +exit:
> > +     spi_bus_unlock(phy->spi_device->master);
> > +     phy->last_access_jiffies =3D jiffies;
> > +     mutex_unlock(&phy->time_track_mutex);
> > +
> > +     return ret;
> > +}
>=20
> This copies a lot of code from tpm_tis_spi, but then slightly changes=20
> some things, without really explaining why.

The commit text has some explanations. Here's the copy/paste from above:

> >   - need to ensure a certain delay between spi transactions, or else
> >     the chip may miss some part of the next transaction;
> >   - if there is no spi activity for some time, it may go to sleep,
> >     and needs to be waken up before sending further commands;
> >   - access to vendor-specific registers.

Do you want me to describe something further?

> For example, struct=20
> cr50_spi_phy contains both tx_buf and rx_buf, whereas tpm_tis_spi uses a =

> single iobuf, that is allocated via devm_kmalloc instead of being part=20
> of the struct. Maybe the difference matters, maybe not, who knows?

Ok. Are you asking if this is a full-duplex SPI device?

>=20
> Can't the code be shared more explicitly, e.g. by cr50_spi wrapping=20
> tpm_tis_spi, so that it can intercept the calls, execute the additional=20
> actions (like waking up the device), but then let tpm_tis_spi do the=20
> common work?
>=20

I suppose the read{16,32} and write32 functions could be reused. I'm not
sure how great it will be if we combine these two drivers, but I can
give it a try today and see how it looks.

