Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5C4819963D
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Mar 2020 14:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbgCaMU1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Mar 2020 08:20:27 -0400
Received: from mga07.intel.com ([134.134.136.100]:47847 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730343AbgCaMU0 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Mar 2020 08:20:26 -0400
IronPort-SDR: jbxyutGQ45u1rUUuFwA7jPcJBcor6cz+76v6JZwDzjUE2JPtZb+A+pWxGwAQqrR1VEhZ23m74w
 b/noNcrvYNaQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 05:20:23 -0700
IronPort-SDR: AmZp5kKDQyRag9za5g+qVlOGgvZ2oJAjKP6s55ExrR+UaZjq2hFr37M+ytY/TqDZLK0jzFz/pu
 IJwwMHn4l3EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,327,1580803200"; 
   d="scan'208";a="249033366"
Received: from tking1-mobl2.ger.corp.intel.com (HELO localhost) ([10.252.59.94])
  by orsmga003.jf.intel.com with ESMTP; 31 Mar 2020 05:20:14 -0700
Date:   Tue, 31 Mar 2020 15:20:13 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     amirmizi6@gmail.com
Cc:     Eyal.Cohen@nuvoton.com, oshrialkoby85@gmail.com,
        alexander.steffen@infineon.com, robh+dt@kernel.org,
        mark.rutland@arm.com, peterhuewe@gmx.de, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com
Subject: Re: [PATCH v4 7/7] tpm: tpm_tis: add tpm_tis_i2c driver
Message-ID: <20200331122013.GC9284@linux.intel.com>
References: <20200331113207.107080-1-amirmizi6@gmail.com>
 <20200331113207.107080-8-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200331113207.107080-8-amirmizi6@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 31, 2020 at 02:32:07PM +0300, amirmizi6@gmail.com wrote:
> From: Amir Mizinski <amirmizi6@gmail.com>
> 
> Implements the functionality needed to communicate with an I2C TPM
> according to the TCG TPM I2C Interface Specification.
> 
> Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
> ---
>  drivers/char/tpm/Kconfig       |  12 ++
>  drivers/char/tpm/Makefile      |   1 +
>  drivers/char/tpm/tpm_tis_i2c.c | 292 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 305 insertions(+)
>  create mode 100644 drivers/char/tpm/tpm_tis_i2c.c
> 
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index aacdeed..b482bbf 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -74,6 +74,18 @@ config TCG_TIS_SPI_CR50
>           If you have a H1 secure module running Cr50 firmware on SPI bus,
>           say Yes and it will be accessible from within Linux.
> 
> +config TCG_TIS_I2C
> +       tristate "TPM I2C Interface Specification"
> +       depends on I2C
> +        depends on CRC_CCITT
> +       select TCG_TIS_CORE
> +       ---help---
> +         If you have a TPM security chip which is connected to a regular
> +         I2C master (i.e. most embedded platforms) that is compliant with the
> +         TCG TPM I2C Interface Specification say Yes and it will be accessible from
> +         within Linux. To compile this driver as a module, choose  M here;
> +         the module will be called tpm_tis_i2c.
> +
>  config TCG_TIS_I2C_ATMEL
>         tristate "TPM Interface Specification 1.2 Interface (I2C - Atmel)"
>         depends on I2C
> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> index 9567e51..97999cf 100644
> --- a/drivers/char/tpm/Makefile
> +++ b/drivers/char/tpm/Makefile
> @@ -26,6 +26,7 @@ obj-$(CONFIG_TCG_TIS_SPI) += tpm_tis_spi.o
>  tpm_tis_spi-y := tpm_tis_spi_main.o
>  tpm_tis_spi-$(CONFIG_TCG_TIS_SPI_CR50) += tpm_tis_spi_cr50.o
> 
> +obj-$(CONFIG_TCG_TIS_I2C) += tpm_tis_i2c.o
>  obj-$(CONFIG_TCG_TIS_I2C_ATMEL) += tpm_i2c_atmel.o
>  obj-$(CONFIG_TCG_TIS_I2C_INFINEON) += tpm_i2c_infineon.o
>  obj-$(CONFIG_TCG_TIS_I2C_NUVOTON) += tpm_i2c_nuvoton.o
> diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2c.c
> new file mode 100644
> index 0000000..c10ec7e
> --- /dev/null
> +++ b/drivers/char/tpm/tpm_tis_i2c.c
> @@ -0,0 +1,292 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2014-2019 Nuvoton Technology corporation
> + *
> + * TPM TIS I2C
> + *
> + * TPM TIS I2C Device Driver Interface for devices that implement the TPM I2C
> + * Interface defined by TCG PC Client Platform TPM Profile (PTP) Specification
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
> +static inline struct tpm_tis_i2c_phy *to_tpm_tis_i2c_phy(struct tpm_tis_data *data)
> +{
> +       return container_of(data, struct tpm_tis_i2c_phy, priv);
> +}
> +
> +static u8 address_to_register(u32 addr)
> +{
> +       addr &= 0xFFF;
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
> +       struct tpm_tis_i2c_phy *phy = to_tpm_tis_i2c_phy(data);
> +       int ret = 0;
> +       int i = 0;
> +       u8 reg = address_to_register(addr);
> +       struct i2c_msg msgs[] = {
> +               {
> +                       .addr = phy->i2c_client->addr,
> +                       .len = sizeof(reg),
> +                       .buf = &reg,
> +               },
> +               {
> +                       .addr = phy->i2c_client->addr,
> +                       .len = len,
> +                       .buf = result,
> +                       .flags = I2C_M_RD,
> +               },
> +       };
> +
> +       do {
> +               ret = i2c_transfer(phy->i2c_client->adapter, msgs,
> +                                  ARRAY_SIZE(msgs));
> +               usleep_range(250, 300); // wait default GUARD_TIME of 250µs
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
> +       struct tpm_tis_i2c_phy *phy = to_tpm_tis_i2c_phy(data);
> +       int ret = 0;
> +       int i = 0;
> +
> +       if (phy->iobuf) {
> +               if (len > TPM_BUFSIZE - 1)
> +                       return -EIO;
> +
> +               phy->iobuf[0] = address_to_register(addr);
> +               memcpy(phy->iobuf + 1, value, len);
> +
> +               {
> +                       struct i2c_msg msgs[] = {
> +                               {
> +                                       .addr = phy->i2c_client->addr,
> +                                       .len = len + 1,
> +                                       .buf = phy->iobuf,
> +                               },
> +                       };
> +
> +                       do {
> +                               ret = i2c_transfer(phy->i2c_client->adapter,
> +                                                  msgs, ARRAY_SIZE(msgs));
> +                               // wait default GUARD_TIME of 250µs
> +                               usleep_range(250, 300);
> +                       } while (ret < 0 && i++ < TPM_RETRY);
> +               }
> +       } else {
> +               u8 reg = address_to_register(addr);
> +
> +               struct i2c_msg msgs[] = {
> +                       {
> +                               .addr = phy->i2c_client->addr,
> +                               .len = sizeof(reg),
> +                               .buf = &reg,
> +                       },
> +                       {
> +                               .addr = phy->i2c_client->addr,
> +                               .len = len,
> +                               .buf = (u8 *)value,
> +                               .flags = I2C_M_NOSTART,
> +                       },
> +               };
> +               do {
> +                       ret = i2c_transfer(phy->i2c_client->adapter, msgs,
> +                                          ARRAY_SIZE(msgs));
> +                       // wait default GUARD_TIME of 250µs
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
> +       struct tpm_tis_i2c_phy *phy = to_tpm_tis_i2c_phy(data);
> +       u16 crc, crc_tpm;
> +       int rc;
> +
> +       if (phy->data_csum) {
> +               crc = crc_ccitt(0x0000, buf, len);
> +               rc = tpm_tis_read16(data, TPM_DATA_CSUM, &crc_tpm);
> +               if (rc < 0)
> +                       return false;
> +
> +               crc_tpm = be16_to_cpu(crc_tpm);
> +               return crc == crc_tpm;
> +       }
> +
> +       return true;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(tpm_tis_pm, tpm_pm_suspend, tpm_tis_resume);
> +
> +static int csum_state_store(struct tpm_tis_data *data, u8 new_state)
> +{
> +       struct tpm_tis_i2c_phy *phy = to_tpm_tis_i2c_phy(data);
> +       u8 cur_state;
> +       int rc;
> +
> +       rc = tpm_tis_i2c_write_bytes(&phy->priv, TPM_DATA_CSUM_ENABLE,
> +                                    1, &new_state);
> +       if (rc < 0)
> +               return rc;
> +
> +       rc = tpm_tis_i2c_read_bytes(&phy->priv, TPM_DATA_CSUM_ENABLE,
> +                                   1, &cur_state);
> +       if (rc < 0)
> +               return rc;
> +
> +       if (new_state == cur_state)
> +               phy->data_csum = (bool)new_state;
> +
> +       return rc;
> +}
> +
> +static const struct tpm_tis_phy_ops tpm_i2c_phy_ops = {
> +       .read_bytes = tpm_tis_i2c_read_bytes,
> +       .write_bytes = tpm_tis_i2c_write_bytes,
> +       .check_data = tpm_tis_i2c_check_data,
> +};
> +
> +static int tpm_tis_i2c_probe(struct i2c_client *dev,
> +                            const struct i2c_device_id *id)
> +{
> +       struct tpm_tis_i2c_phy *phy;
> +       int rc;
> +       int CRC_Checksum = 0;
> +       const u8 loc_init = 0;
> +       struct device_node *np;
> +
> +       phy = devm_kzalloc(&dev->dev, sizeof(struct tpm_tis_i2c_phy),
> +                          GFP_KERNEL);
> +       if (!phy)
> +               return -ENOMEM;
> +
> +       phy->i2c_client = dev;
> +
> +       if (!i2c_check_functionality(dev->adapter, I2C_FUNC_NOSTART)) {
> +               phy->iobuf = devm_kmalloc(&dev->dev, TPM_BUFSIZE, GFP_KERNEL);
> +               if (!phy->iobuf)
> +                       return -ENOMEM;
> +       }
> +
> +       // select locality 0 (the driver will access only via locality 0)
> +       rc = tpm_tis_i2c_write_bytes(&phy->priv, TPM_LOC_SEL, 1, &loc_init);
> +       if (rc < 0)
> +               return rc;
> +
> +       // set CRC checksum calculation enable
> +       np = dev->dev.of_node;
> +       if (of_property_read_bool(np, "crc-checksum"))
> +               CRC_Checksum = 1;
> +
> +       rc = csum_state_store(&phy->priv, CRC_Checksum);
> +       if (rc < 0)
> +               return rc;
> +
> +       return tpm_tis_core_init(&dev->dev, &phy->priv, -1, &tpm_i2c_phy_ops,
> +                                       NULL);
> +}
> +
> +static const struct i2c_device_id tpm_tis_i2c_id[] = {
> +       {"tpm_tis_i2c", 0},
> +       {}
> +};
> +MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_id);
> +
> +static const struct of_device_id of_tis_i2c_match[] = {
> +       { .compatible = "tcg,tpm-tis-i2c", },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, of_tis_i2c_match);
> +
> +static const struct acpi_device_id acpi_tis_i2c_match[] = {
> +       {"SMO0768", 0},
> +       {}
> +};
> +MODULE_DEVICE_TABLE(acpi, acpi_tis_i2c_match);
> +
> +static struct i2c_driver tpm_tis_i2c_driver = {
> +       .driver = {
> +               .owner = THIS_MODULE,
> +               .name = "tpm_tis_i2c",
> +               .pm = &tpm_tis_pm,
> +               .of_match_table = of_match_ptr(of_tis_i2c_match),
> +               .acpi_match_table = ACPI_PTR(acpi_tis_i2c_match),
> +       },
> +       .probe = tpm_tis_i2c_probe,
> +       .id_table = tpm_tis_i2c_id,
> +};
> +
> +module_i2c_driver(tpm_tis_i2c_driver);
> +
> +MODULE_DESCRIPTION("TPM Driver for native I2C access");

Just put "TPM Driver" here.

/Jarkko
