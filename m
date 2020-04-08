Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A38071A1A2F
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Apr 2020 05:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgDHDHM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Apr 2020 23:07:12 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38290 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgDHDHM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Apr 2020 23:07:12 -0400
Received: by mail-qt1-f196.google.com with SMTP id 13so2665043qtt.5;
        Tue, 07 Apr 2020 20:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VMs6pkkDIDsmecqZHU0wzCDUHfQWS5zfYqzf+iTg04c=;
        b=L/ApaN2oajbPAo/BtfJQISdwUpErMmki+nQgyYf0V7i1W1ScAXANuyTTdv+sQHxSpS
         tMe+IeK8QlR5PEF1D24LnuFpqGG7ycx5PleN67LwT5MnIAjXHWHx5NVvj6LudZM9AYRm
         AWX8DcQu9IB8acJlFPq8crOHMj3WQd8NG2kk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VMs6pkkDIDsmecqZHU0wzCDUHfQWS5zfYqzf+iTg04c=;
        b=WXwKUt8wc5pdr1eNUECFmHPr9p4qFtO/x6PkPPIrD0/e+EzISftyjsdrJVJJE0rhL/
         3oVJThJ6rh8gLFIjZWVxDbpLzXH1OzTXKYWdlB7WctqY7WX7pK1WMvpGajxjTR+uFnWt
         /AHZz7YGTv2gGjs2P1fdPRj6D1Y6RzqrQIQwtdGpEoHx/bDZI0aV2eZM8o6UzdhVXhAY
         mgqCOi5cU37vNfUAMnkF2SPZJXEW5gTSdZjvhErxBFwyXvjIpC2RxkWwttF1U+CPk/6d
         o1mGRwN43m4bQj8EcJtbfUMFhM6BjxEH73NL9zLFeAgT3p81BBUBLfiCEbLfkS27YmeP
         a/+g==
X-Gm-Message-State: AGi0Pua5+m0XvZ9wn6XTE618PcHqPauD6GSWMCI6UviF9QL8+iLIA8E5
        orz2cyjkEg7kpigacuzGs9ulllKSVcU4Ih7carE=
X-Google-Smtp-Source: APiQypKGl8BsC5XeR2EwydrxInbm1BCQUeFdNGzau0dwf+b7leAZr0WpiL2iOHe/FOTQOpH2oec8zn+wRrpI7S8StH8=
X-Received: by 2002:ac8:7769:: with SMTP id h9mr5497525qtu.234.1586315229708;
 Tue, 07 Apr 2020 20:07:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200405125352.183693-1-amirmizi6@gmail.com> <20200405125352.183693-8-amirmizi6@gmail.com>
In-Reply-To: <20200405125352.183693-8-amirmizi6@gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 8 Apr 2020 03:06:58 +0000
Message-ID: <CACPK8XeGRq-NbwvJgKcO8odxEkdRrMTrhBsvqf7+cYXGBJxSDA@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] tpm: tpm_tis: add tpm_tis_i2c driver
To:     amirmizi6@gmail.com
Cc:     Eyal.Cohen@nuvoton.com, jarkko.sakkinen@linux.intel.com,
        oshrialkoby85@gmail.com, alexander.steffen@infineon.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, benoit.houyere@st.com,
        peterhuewe@gmx.de, christophe-h.richard@st.com, jgg@ziepe.ca,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        Tomer Maimon <tmaimon77@gmail.com>, gcwilson@us.ibm.com,
        kgoldman@us.ibm.com, Dan.Morav@nuvoton.com,
        oren.tanami@nuvoton.com, shmulik.hager@nuvoton.com,
        amir.mizinski@nuvoton.com, Eddie James <eajames@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sun, 5 Apr 2020 at 12:56, <amirmizi6@gmail.com> wrote:
>
> From: Amir Mizinski <amirmizi6@gmail.com>
>
> Implements the functionality needed to communicate with an I2C TPM
> according to the TCG TPM I2C Interface Specification.
>
> Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
> Tested-by: Eddie James <eajames@linux.ibm.com>
> ---
>  drivers/char/tpm/Kconfig       |  12 ++
>  drivers/char/tpm/Makefile      |   1 +
>  drivers/char/tpm/tpm_tis_i2c.c | 292 +++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 305 insertions(+)
>  create mode 100644 drivers/char/tpm/tpm_tis_i2c.c
>
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index aacdeed..b166ad3 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -74,6 +74,18 @@ config TCG_TIS_SPI_CR50
>           If you have a H1 secure module running Cr50 firmware on SPI bus=
,
>           say Yes and it will be accessible from within Linux.
>
> +config TCG_TIS_I2C
> +       tristate "TPM I2C Interface Specification"
> +       depends on I2C
> +       depends on CRC_CCITT

All the other users in the kernel "select CRC_CCITT" instead of
depending on it. If we do that it's easier to enable this driver, so I
recommend going that route.

I tested your series (backported on to a 5.4 tree) and it worked well
on my platform. For the series:

Tested-by: Joel Stanley <joel@jms.id.au>




> +       select TCG_TIS_CORE
> +       ---help---
> +         If you have a TPM security chip which is connected to a regular
> +         I2C master (i.e. most embedded platforms) that is compliant wit=
h the
> +         TCG TPM I2C Interface Specification say Yes and it will be acce=
ssible from
> +         within Linux. To compile this driver as a module, choose  M her=
e;
> +         the module will be called tpm_tis_i2c.
> +
>  config TCG_TIS_I2C_ATMEL
>         tristate "TPM Interface Specification 1.2 Interface (I2C - Atmel)=
"
>         depends on I2C
> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> index 9567e51..97999cf 100644
> --- a/drivers/char/tpm/Makefile
> +++ b/drivers/char/tpm/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_TCG_TIS_SPI) +=3D tpm_tis_spi.o
>  tpm_tis_spi-y :=3D tpm_tis_spi_main.o
>  tpm_tis_spi-$(CONFIG_TCG_TIS_SPI_CR50) +=3D tpm_tis_spi_cr50.o
>
> +obj-$(CONFIG_TCG_TIS_I2C) +=3D tpm_tis_i2c.o
>  obj-$(CONFIG_TCG_TIS_I2C_ATMEL) +=3D tpm_i2c_atmel.o
>  obj-$(CONFIG_TCG_TIS_I2C_INFINEON) +=3D tpm_i2c_infineon.o
>  obj-$(CONFIG_TCG_TIS_I2C_NUVOTON) +=3D tpm_i2c_nuvoton.o
> diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2=
c.c
> new file mode 100644
> index 0000000..83c0b3a
> --- /dev/null
> +++ b/drivers/char/tpm/tpm_tis_i2c.c
> @@ -0,0 +1,292 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2014-2019 Nuvoton Technology corporation
> + *
> + * TPM TIS I2C
> + *
> + * TPM TIS I2C Device Driver Interface for devices that implement the TP=
M I2C
> + * Interface defined by TCG PC Client Platform TPM Profile (PTP) Specifi=
cation
> + * Revision 01.03 v22 at www.trustedcomputinggroup.org
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/slab.h>
> +#include <linux/interrupt.h>
> +#include <linux/wait.h>
> +#include <linux/acpi.h>
> +#include <linux/freezer.h>
> +#include <linux/crc-ccitt.h>
> +
> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/gpio.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_gpio.h>
> +#include <linux/tpm.h>
> +#include "tpm.h"
> +#include "tpm_tis_core.h"
> +
> +#define TPM_LOC_SEL                    0x04
> +#define TPM_I2C_INTERFACE_CAPABILITY   0x30
> +#define TPM_I2C_DEVICE_ADDRESS         0x38
> +#define TPM_DATA_CSUM_ENABLE           0x40
> +#define TPM_DATA_CSUM                  0x44
> +#define TPM_I2C_DID_VID                        0x48
> +#define TPM_I2C_RID                    0x4C
> +
> +//#define I2C_IS_TPM2 1
> +
> +struct tpm_tis_i2c_phy {
> +       struct tpm_tis_data priv;
> +       struct i2c_client *i2c_client;
> +       bool data_csum;
> +       u8 *iobuf;
> +};
> +
> +static inline struct tpm_tis_i2c_phy *to_tpm_tis_i2c_phy(struct tpm_tis_=
data *data)
> +{
> +       return container_of(data, struct tpm_tis_i2c_phy, priv);
> +}
> +
> +static u8 address_to_register(u32 addr)
> +{
> +       addr &=3D 0xFFF;
> +
> +       switch (addr) {
> +               // adapt register addresses that have changed compared to
> +               // older TIS versions
> +       case TPM_ACCESS(0):
> +               return 0x04;
> +       case TPM_LOC_SEL:
> +               return 0x00;
> +       case TPM_DID_VID(0):
> +               return 0x48;
> +       case TPM_RID(0):
> +               return 0x4C;
> +       default:
> +               return addr;
> +       }
> +}
> +
> +static int tpm_tis_i2c_read_bytes(struct tpm_tis_data *data, u32 addr,
> +                                 u16 len, u8 *result)
> +{
> +       struct tpm_tis_i2c_phy *phy =3D to_tpm_tis_i2c_phy(data);
> +       int ret =3D 0;
> +       int i =3D 0;
> +       u8 reg =3D address_to_register(addr);
> +       struct i2c_msg msgs[] =3D {
> +               {
> +                       .addr =3D phy->i2c_client->addr,
> +                       .len =3D sizeof(reg),
> +                       .buf =3D &reg,
> +               },
> +               {
> +                       .addr =3D phy->i2c_client->addr,
> +                       .len =3D len,
> +                       .buf =3D result,
> +                       .flags =3D I2C_M_RD,
> +               },
> +       };
> +
> +       do {
> +               ret =3D i2c_transfer(phy->i2c_client->adapter, msgs,
> +                                  ARRAY_SIZE(msgs));
> +               usleep_range(250, 300); // wait default GUARD_TIME of 250=
=C2=B5s
> +
> +       } while (ret < 0 && i++ < TPM_RETRY);
> +
> +       if (ret < 0)
> +               return ret;
> +
> +
> +       return 0;
> +}
> +
> +static int tpm_tis_i2c_write_bytes(struct tpm_tis_data *data, u32 addr,
> +                                  u16 len, const u8 *value)
> +{
> +       struct tpm_tis_i2c_phy *phy =3D to_tpm_tis_i2c_phy(data);
> +       int ret =3D 0;
> +       int i =3D 0;
> +
> +       if (phy->iobuf) {
> +               if (len > TPM_BUFSIZE - 1)
> +                       return -EIO;
> +
> +               phy->iobuf[0] =3D address_to_register(addr);
> +               memcpy(phy->iobuf + 1, value, len);
> +
> +               {
> +                       struct i2c_msg msgs[] =3D {
> +                               {
> +                                       .addr =3D phy->i2c_client->addr,
> +                                       .len =3D len + 1,
> +                                       .buf =3D phy->iobuf,
> +                               },
> +                       };
> +
> +                       do {
> +                               ret =3D i2c_transfer(phy->i2c_client->ada=
pter,
> +                                                  msgs, ARRAY_SIZE(msgs)=
);
> +                               // wait default GUARD_TIME of 250=C2=B5s
> +                               usleep_range(250, 300);
> +                       } while (ret < 0 && i++ < TPM_RETRY);
> +               }
> +       } else {
> +               u8 reg =3D address_to_register(addr);
> +
> +               struct i2c_msg msgs[] =3D {
> +                       {
> +                               .addr =3D phy->i2c_client->addr,
> +                               .len =3D sizeof(reg),
> +                               .buf =3D &reg,
> +                       },
> +                       {
> +                               .addr =3D phy->i2c_client->addr,
> +                               .len =3D len,
> +                               .buf =3D (u8 *)value,
> +                               .flags =3D I2C_M_NOSTART,
> +                       },
> +               };
> +               do {
> +                       ret =3D i2c_transfer(phy->i2c_client->adapter, ms=
gs,
> +                                          ARRAY_SIZE(msgs));
> +                       // wait default GUARD_TIME of 250=C2=B5s
> +                       usleep_range(250, 300);
> +               } while (ret < 0 && i++ < TPM_RETRY);
> +       }
> +
> +       if (ret < 0)
> +               return ret;
> +
> +
> +       return 0;
> +}
> +
> +static bool tpm_tis_i2c_check_data(struct tpm_tis_data *data,
> +                                  const u8 *buf, size_t len)
> +{
> +       struct tpm_tis_i2c_phy *phy =3D to_tpm_tis_i2c_phy(data);
> +       u16 crc, crc_tpm;
> +       int rc;
> +
> +       if (phy->data_csum) {
> +               crc =3D crc_ccitt(0x0000, buf, len);
> +               rc =3D tpm_tis_read16(data, TPM_DATA_CSUM, &crc_tpm);
> +               if (rc < 0)
> +                       return false;
> +
> +               crc_tpm =3D be16_to_cpu(crc_tpm);
> +               return crc =3D=3D crc_tpm;
> +       }
> +
> +       return true;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(tpm_tis_pm, tpm_pm_suspend, tpm_tis_resume);
> +
> +static int csum_state_store(struct tpm_tis_data *data, u8 new_state)
> +{
> +       struct tpm_tis_i2c_phy *phy =3D to_tpm_tis_i2c_phy(data);
> +       u8 cur_state;
> +       int rc;
> +
> +       rc =3D tpm_tis_i2c_write_bytes(&phy->priv, TPM_DATA_CSUM_ENABLE,
> +                                    1, &new_state);
> +       if (rc < 0)
> +               return rc;
> +
> +       rc =3D tpm_tis_i2c_read_bytes(&phy->priv, TPM_DATA_CSUM_ENABLE,
> +                                   1, &cur_state);
> +       if (rc < 0)
> +               return rc;
> +
> +       if (new_state =3D=3D cur_state)
> +               phy->data_csum =3D (bool)new_state;
> +
> +       return rc;
> +}
> +
> +static const struct tpm_tis_phy_ops tpm_i2c_phy_ops =3D {
> +       .read_bytes =3D tpm_tis_i2c_read_bytes,
> +       .write_bytes =3D tpm_tis_i2c_write_bytes,
> +       .check_data =3D tpm_tis_i2c_check_data,
> +};
> +
> +static int tpm_tis_i2c_probe(struct i2c_client *dev,
> +                            const struct i2c_device_id *id)
> +{
> +       struct tpm_tis_i2c_phy *phy;
> +       int rc;
> +       int CRC_Checksum =3D 0;
> +       const u8 loc_init =3D 0;
> +       struct device_node *np;
> +
> +       phy =3D devm_kzalloc(&dev->dev, sizeof(struct tpm_tis_i2c_phy),
> +                          GFP_KERNEL);
> +       if (!phy)
> +               return -ENOMEM;
> +
> +       phy->i2c_client =3D dev;
> +
> +       if (!i2c_check_functionality(dev->adapter, I2C_FUNC_NOSTART)) {
> +               phy->iobuf =3D devm_kmalloc(&dev->dev, TPM_BUFSIZE, GFP_K=
ERNEL);
> +               if (!phy->iobuf)
> +                       return -ENOMEM;
> +       }
> +
> +       // select locality 0 (the driver will access only via locality 0)
> +       rc =3D tpm_tis_i2c_write_bytes(&phy->priv, TPM_LOC_SEL, 1, &loc_i=
nit);
> +       if (rc < 0)
> +               return rc;
> +
> +       // set CRC checksum calculation enable
> +       np =3D dev->dev.of_node;
> +       if (of_property_read_bool(np, "crc-checksum"))
> +               CRC_Checksum =3D 1;
> +
> +       rc =3D csum_state_store(&phy->priv, CRC_Checksum);
> +       if (rc < 0)
> +               return rc;
> +
> +       return tpm_tis_core_init(&dev->dev, &phy->priv, -1, &tpm_i2c_phy_=
ops,
> +                                       NULL);
> +}
> +
> +static const struct i2c_device_id tpm_tis_i2c_id[] =3D {
> +       {"tpm_tis_i2c", 0},
> +       {}
> +};
> +MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_id);
> +
> +static const struct of_device_id of_tis_i2c_match[] =3D {
> +       { .compatible =3D "tcg,tpm-tis-i2c", },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, of_tis_i2c_match);
> +
> +static const struct acpi_device_id acpi_tis_i2c_match[] =3D {
> +       {"SMO0768", 0},
> +       {}
> +};
> +MODULE_DEVICE_TABLE(acpi, acpi_tis_i2c_match);
> +
> +static struct i2c_driver tpm_tis_i2c_driver =3D {
> +       .driver =3D {
> +               .owner =3D THIS_MODULE,
> +               .name =3D "tpm_tis_i2c",
> +               .pm =3D &tpm_tis_pm,
> +               .of_match_table =3D of_match_ptr(of_tis_i2c_match),
> +               .acpi_match_table =3D ACPI_PTR(acpi_tis_i2c_match),
> +       },
> +       .probe =3D tpm_tis_i2c_probe,
> +       .id_table =3D tpm_tis_i2c_id,
> +};
> +
> +module_i2c_driver(tpm_tis_i2c_driver);
> +
> +MODULE_DESCRIPTION("TPM Driver");
> +MODULE_LICENSE("GPL");
> --
> 2.7.4
>
