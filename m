Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFF656BEE7
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2019 17:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfGQPTY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jul 2019 11:19:24 -0400
Received: from smtp11.infineon.com ([217.10.52.105]:60795 "EHLO
        smtp11.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfGQPTX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jul 2019 11:19:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1563376762; x=1594912762;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=UKX50UWYnnQyqksfuHlH3rW3cC/sTas/6FqtPxBoZ0o=;
  b=IlVNf6V7lLw9XvoOvWY9JTkq227cLejvOceO1M4C9hNnc0saVELrYlYV
   zCAxueJCBwpIo8xlGSvXCVOxbISgdbRPk10CDehV6TvqtZEPi4n/f2QH2
   U/qokrdIcepHawwMQGgPd0mPlwQLs5o3YXtbzdzKpfwANW7tkmp+emn1B
   c=;
IronPort-SDR: f95y7huKy/tuAcNsqKuajC4UX0JbQ8CxcoTNvOodBNQ71BUhALbC5Mztk+pbTYu4b27DOYO6TP
 1zWc91iNJWQSw+BfpSrfPW5fsXvmkFye6qN2DcqQI9wszxkI5RrY4VgYdySwYa8pLJUuvNcEjD
 abRCezzctZ3gPiL8qqnMAmfbBn5btyeml4i/q4yIGy20MU10VCYLoqp6Qo6MwFTUwPdNw9uEWV
 08GJf+KCHa5WPn2k7s0SCnnf6GPnFbCQTm83u9+hKp5AOX6NuIXrQd8G9jZEVG4KBPvL0vXfvS
 6T4=
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6000,8403,9320"; a="128132221"
X-IronPort-AV: E=Sophos;i="5.64,274,1559512800"; 
   d="scan'208";a="128132221"
Received: from unknown (HELO mucxv001.muc.infineon.com) ([172.23.11.16])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2019 17:19:20 +0200
Received: from MUCSE708.infineon.com (MUCSE708.infineon.com [172.23.7.82])
        by mucxv001.muc.infineon.com (Postfix) with ESMTPS;
        Wed, 17 Jul 2019 17:19:20 +0200 (CEST)
Received: from [10.154.32.63] (172.23.8.247) by MUCSE708.infineon.com
 (172.23.7.82) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1591.10; Wed, 17
 Jul 2019 17:19:20 +0200
Subject: Re: [PATCH v2 6/6] tpm: Add driver for cr50 on I2C
To:     Stephen Boyd <swboyd@chromium.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     Duncan Laurie <dlaurie@chromium.org>,
        <linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-integrity@vger.kernel.org>,
        Andrey Pronin <apronin@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
References: <20190716224518.62556-1-swboyd@chromium.org>
 <20190716224518.62556-7-swboyd@chromium.org>
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
Message-ID: <04c0f028-308d-2dae-5067-8c239acaa3bf@infineon.com>
Date:   Wed, 17 Jul 2019 17:19:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190716224518.62556-7-swboyd@chromium.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE703.infineon.com (172.23.7.73) To
 MUCSE708.infineon.com (172.23.7.82)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 17.07.2019 00:45, Stephen Boyd wrote:
> From: Duncan Laurie <dlaurie@chromium.org>
> 
> Add TPM 2.0 compatible I2C interface for chips with cr50 firmware.
> 
> The firmware running on the currently supported H1 MCU requires a
> special driver to handle its specific protocol, and this makes it
> unsuitable to use tpm_tis_core_* and instead it must implement the
> underlying TPM protocol similar to the other I2C TPM drivers.
> 
> - All 4 byes of status register must be read/written at once.
> - FIFO and burst count is limited to 63 and must be drained by AP.
> - Provides an interrupt to indicate when read response data is ready
> and when the TPM is finished processing write data.

And why does this prevent using the existing tpm_tis_core 
infrastructure? Taking the status register as an example, you could just 
teach read_bytes to look at the requested address, and if it lies 
between 0x18 and 0x1b read the whole status register and then return 
only the subset that has been requested originally.

Both approaches might not be pretty, but I'd prefer having shared code 
with explicit code paths for the differences instead of having two 
copies of mostly the same algorithm where a simple diff will print out a 
lot more than just the crucial differences.

> This driver is based on the existing infineon I2C TPM driver, which
> most closely matches the cr50 i2c protocol behavior.  The driver is
> intentionally kept very similar in structure and style to the
> corresponding drivers in coreboot and depthcharge.
> 
> Signed-off-by: Duncan Laurie <dlaurie@chromium.org>
> [swboyd@chromium.org: Depend on i2c even if it's a module, replace
> boilier plate with SPDX tag, drop asm/byteorder.h include, simplify
> return from probe]
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>   drivers/char/tpm/Kconfig    |  10 +
>   drivers/char/tpm/Makefile   |   1 +
>   drivers/char/tpm/cr50_i2c.c | 705 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 716 insertions(+)
>   create mode 100644 drivers/char/tpm/cr50_i2c.c
> 
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index b7028bfa6f87..57a8c3540265 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -119,6 +119,16 @@ config TCG_CR50
>   	---help---
>   	  Common routines shared by drivers for Cr50-based devices.
>   
> +config TCG_CR50_I2C
> +	tristate "Cr50 I2C Interface"
> +	depends on I2C
> +	select TCG_CR50
> +	---help---
> +	  If you have a H1 secure module running Cr50 firmware on I2C bus,
> +	  say Yes and it will be accessible from within Linux. To compile
> +	  this driver as a module, choose M here; the module will be called
> +	  cr50_i2c.
> +
>   config TCG_CR50_SPI
>   	tristate "Cr50 SPI Interface"
>   	depends on SPI
> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> index 4e89538c73c8..3ac3448c21fa 100644
> --- a/drivers/char/tpm/Makefile
> +++ b/drivers/char/tpm/Makefile
> @@ -29,6 +29,7 @@ obj-$(CONFIG_TCG_NSC) += tpm_nsc.o
>   obj-$(CONFIG_TCG_ATMEL) += tpm_atmel.o
>   obj-$(CONFIG_TCG_CR50) += cr50.o
>   obj-$(CONFIG_TCG_CR50_SPI) += cr50_spi.o
> +obj-$(CONFIG_TCG_CR50_I2C) += cr50_i2c.o
>   obj-$(CONFIG_TCG_INFINEON) += tpm_infineon.o
>   obj-$(CONFIG_TCG_IBMVTPM) += tpm_ibmvtpm.o
>   obj-$(CONFIG_TCG_TIS_ST33ZP24) += st33zp24/
> diff --git a/drivers/char/tpm/cr50_i2c.c b/drivers/char/tpm/cr50_i2c.c
> new file mode 100644
> index 000000000000..25934c038b9b
> --- /dev/null
> +++ b/drivers/char/tpm/cr50_i2c.c
> @@ -0,0 +1,705 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2016 Google Inc.
> + *
> + * Based on Linux Kernel TPM driver by
> + * Peter Huewe <peter.huewe@infineon.com>
> + * Copyright (C) 2011 Infineon Technologies
> + */
> +
> +/*
> + * cr50 is a firmware for H1 secure modules that requires special
> + * handling for the I2C interface.
> + *
> + * - Use an interrupt for transaction status instead of hardcoded delays
> + * - Must use write+wait+read read protocol
> + * - All 4 bytes of status register must be read/written at once
> + * - Burst count max is 63 bytes, and burst count behaves
> + *   slightly differently than other I2C TPMs
> + * - When reading from FIFO the full burstcnt must be read
> + *   instead of just reading header and determining the remainder
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/completion.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/pm.h>
> +#include <linux/slab.h>
> +#include <linux/interrupt.h>
> +#include <linux/wait.h>
> +#include "cr50.h"
> +#include "tpm.h"
> +
> +#define CR50_MAX_BUFSIZE	63
> +#define CR50_TIMEOUT_SHORT_MS	2	/* Short timeout during transactions */
> +#define CR50_TIMEOUT_NOIRQ_MS	20	/* Timeout for TPM ready without IRQ */
> +#define CR50_I2C_DID_VID	0x00281ae0L
> +#define CR50_I2C_MAX_RETRIES	3	/* Max retries due to I2C errors */
> +#define CR50_I2C_RETRY_DELAY_LO	55	/* Min usecs between retries on I2C */
> +#define CR50_I2C_RETRY_DELAY_HI	65	/* Max usecs between retries on I2C */
> +
> +static unsigned short rng_quality = 1022;
> +
> +module_param(rng_quality, ushort, 0644);
> +MODULE_PARM_DESC(rng_quality,
> +		 "Estimation of true entropy, in bits per 1024 bits.");
> +
> +struct priv_data {
> +	int irq;
> +	int locality;
> +	struct completion tpm_ready;
> +	u8 buf[CR50_MAX_BUFSIZE + sizeof(u8)];
> +};
> +
> +/*
> + * The cr50 interrupt handler just signals waiting threads that the
> + * interrupt was asserted.  It does not do any processing triggered
> + * by interrupts but is instead used to avoid fixed delays.
> + */
> +static irqreturn_t cr50_i2c_int_handler(int dummy, void *dev_id)
> +{
> +	struct tpm_chip *chip = dev_id;
> +	struct priv_data *priv = dev_get_drvdata(&chip->dev);
> +
> +	complete(&priv->tpm_ready);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/*
> + * Wait for completion interrupt if available, otherwise use a fixed
> + * delay for the TPM to be ready.
> + *
> + * Returns negative number for error, positive number for success.
> + */
> +static int cr50_i2c_wait_tpm_ready(struct tpm_chip *chip)
> +{
> +	struct priv_data *priv = dev_get_drvdata(&chip->dev);
> +	long rc;
> +
> +	/* Use a safe fixed delay if interrupt is not supported */
> +	if (priv->irq <= 0) {
> +		msleep(CR50_TIMEOUT_NOIRQ_MS);
> +		return 1;
> +	}
> +
> +	/* Wait for interrupt to indicate TPM is ready to respond */
> +	rc = wait_for_completion_timeout(&priv->tpm_ready,
> +		msecs_to_jiffies(chip->timeout_a));
> +
> +	if (rc == 0)
> +		dev_warn(&chip->dev, "Timeout waiting for TPM ready\n");
> +
> +	return rc;
> +}
> +
> +static void cr50_i2c_enable_tpm_irq(struct tpm_chip *chip)
> +{
> +	struct priv_data *priv = dev_get_drvdata(&chip->dev);
> +
> +	if (priv->irq > 0) {
> +		reinit_completion(&priv->tpm_ready);
> +		enable_irq(priv->irq);
> +	}
> +}
> +
> +static void cr50_i2c_disable_tpm_irq(struct tpm_chip *chip)
> +{
> +	struct priv_data *priv = dev_get_drvdata(&chip->dev);
> +
> +	if (priv->irq > 0)
> +		disable_irq(priv->irq);
> +}
> +
> +/*
> + * cr50_i2c_transfer - transfer messages over i2c
> + *
> + * @adapter: i2c adapter
> + * @msgs: array of messages to transfer
> + * @num: number of messages in the array
> + *
> + * Call unlocked i2c transfer routine with the provided parameters and retry
> + * in case of bus errors. Returns the number of transferred messages.
> + */

Documentation is nice, why is it only present for some of the functions? 
Also, the dev parameter is missing in the list of parameters above.

> +static int cr50_i2c_transfer(struct device *dev, struct i2c_adapter *adapter,
> +			     struct i2c_msg *msgs, int num)
> +{
> +	int rc, try;
> +
> +	for (try = 0; try < CR50_I2C_MAX_RETRIES; try++) {
> +		rc = __i2c_transfer(adapter, msgs, num);
> +		if (rc > 0)
> +			break;
> +		if (try)
> +			dev_warn(dev, "i2c transfer failed (attempt %d/%d): %d\n",
> +				 try+1, CR50_I2C_MAX_RETRIES, rc);

Why does this not generate a message when the first attempt fails?

> +		usleep_range(CR50_I2C_RETRY_DELAY_LO, CR50_I2C_RETRY_DELAY_HI);
> +	}
> +
> +	return rc;
> +}
> +
> +/*
> + * cr50_i2c_read() - read from TPM register
> + *
> + * @chip: TPM chip information
> + * @addr: register address to read from
> + * @buffer: provided by caller
> + * @len: number of bytes to read
> + *
> + * 1) send register address byte 'addr' to the TPM
> + * 2) wait for TPM to indicate it is ready
> + * 3) read 'len' bytes of TPM response into the provided 'buffer'
> + *
> + * Returns negative number for error, 0 for success.
> + */
> +static int cr50_i2c_read(struct tpm_chip *chip, u8 addr, u8 *buffer, size_t len)
> +{
> +	struct i2c_client *client = to_i2c_client(chip->dev.parent);
> +	struct i2c_msg msg1 = {
> +		.addr = client->addr,
> +		.len = 1,
> +		.buf = &addr
> +	};
> +	struct i2c_msg msg2 = {
> +		.addr = client->addr,
> +		.flags = I2C_M_RD,
> +		.len = len,
> +		.buf = buffer
> +	};
> +	int rc;
> +
> +	i2c_lock_bus(client->adapter, I2C_LOCK_SEGMENT);
> +
> +	/* Prepare for completion interrupt */
> +	cr50_i2c_enable_tpm_irq(chip);
> +
> +	/* Send the register address byte to the TPM */
> +	rc = cr50_i2c_transfer(&chip->dev, client->adapter, &msg1, 1);
> +	if (rc <= 0)
> +		goto out;
> +
> +	/* Wait for TPM to be ready with response data */
> +	rc = cr50_i2c_wait_tpm_ready(chip);
> +	if (rc < 0)
> +		goto out;
> +
> +	/* Read response data from the TPM */
> +	rc = cr50_i2c_transfer(&chip->dev, client->adapter, &msg2, 1);
> +
> +out:
> +	cr50_i2c_disable_tpm_irq(chip);
> +	i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
> +
> +	if (rc < 0)
> +		return rc;
> +	if (rc == 0)
> +		return -EIO; /* No i2c segments transferred */
> +
> +	return 0;
> +}
> +
> +/*
> + * cr50_i2c_write() - write to TPM register
> + *
> + * @chip: TPM chip information
> + * @addr: register address to write to
> + * @buffer: data to write
> + * @len: number of bytes to write
> + *
> + * 1) prepend the provided address to the provided data
> + * 2) send the address+data to the TPM
> + * 3) wait for TPM to indicate it is done writing
> + *
> + * Returns negative number for error, 0 for success.
> + */
> +static int cr50_i2c_write(struct tpm_chip *chip, u8 addr, u8 *buffer,
> +			  size_t len)
> +{
> +	struct priv_data *priv = dev_get_drvdata(&chip->dev);
> +	struct i2c_client *client = to_i2c_client(chip->dev.parent);
> +	struct i2c_msg msg1 = {
> +		.addr = client->addr,
> +		.len = len + 1,
> +		.buf = priv->buf
> +	};
> +	int rc;
> +
> +	if (len > CR50_MAX_BUFSIZE)
> +		return -EINVAL;
> +
> +	i2c_lock_bus(client->adapter, I2C_LOCK_SEGMENT);
> +
> +	/* Prepend the 'register address' to the buffer */
> +	priv->buf[0] = addr;
> +	memcpy(priv->buf + 1, buffer, len);
> +
> +	/* Prepare for completion interrupt */
> +	cr50_i2c_enable_tpm_irq(chip);
> +
> +	/* Send write request buffer with address */
> +	rc = cr50_i2c_transfer(&chip->dev, client->adapter, &msg1, 1);
> +	if (rc <= 0)
> +		goto out;
> +
> +	/* Wait for TPM to be ready, ignore timeout */
> +	cr50_i2c_wait_tpm_ready(chip);
> +
> +out:
> +	cr50_i2c_disable_tpm_irq(chip);
> +	i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
> +
> +	if (rc < 0)
> +		return rc;
> +	if (rc == 0)
> +		return -EIO; /* No i2c segments transferred */
> +
> +	return 0;
> +}
> +
> +enum tis_access {
> +	TPM_ACCESS_VALID = 0x80,
> +	TPM_ACCESS_ACTIVE_LOCALITY = 0x20,
> +	TPM_ACCESS_REQUEST_PENDING = 0x04,
> +	TPM_ACCESS_REQUEST_USE = 0x02,
> +};
> +
> +enum tis_status {
> +	TPM_STS_VALID = 0x80,
> +	TPM_STS_COMMAND_READY = 0x40,
> +	TPM_STS_GO = 0x20,
> +	TPM_STS_DATA_AVAIL = 0x10,
> +	TPM_STS_DATA_EXPECT = 0x08,
> +};
> +
> +enum tis_defaults {
> +	TIS_SHORT_TIMEOUT = 750,	/* ms */
> +	TIS_LONG_TIMEOUT = 2000,	/* 2 sec */
> +};

This is already defined in tpm_tis_core.h. Do you really need to 
redefine it here?

> +
> +#define	TPM_ACCESS(l)			(0x0000 | ((l) << 4))
> +#define	TPM_STS(l)			(0x0001 | ((l) << 4))
> +#define	TPM_DATA_FIFO(l)		(0x0005 | ((l) << 4))
> +#define	TPM_DID_VID(l)			(0x0006 | ((l) << 4))
> +
> +static int check_locality(struct tpm_chip *chip, int loc)
> +{
> +	u8 mask = TPM_ACCESS_VALID | TPM_ACCESS_ACTIVE_LOCALITY;
> +	u8 buf;
> +	int rc;
> +
> +	rc = cr50_i2c_read(chip, TPM_ACCESS(loc), &buf, 1);
> +	if (rc < 0)
> +		return rc;
> +
> +	if ((buf & mask) == mask)
> +		return loc;
> +
> +	return -EIO;
> +}
> +
> +static void release_locality(struct tpm_chip *chip, int force)
> +{
> +	struct priv_data *priv = dev_get_drvdata(&chip->dev);
> +	u8 mask = TPM_ACCESS_VALID | TPM_ACCESS_REQUEST_PENDING;
> +	u8 addr = TPM_ACCESS(priv->locality);
> +	u8 buf;
> +
> +	if (cr50_i2c_read(chip, addr, &buf, 1) < 0)
> +		return;
> +
> +	if (force || (buf & mask) == mask) {
> +		buf = TPM_ACCESS_ACTIVE_LOCALITY;
> +		cr50_i2c_write(chip, addr, &buf, 1);
> +	}
> +
> +	priv->locality = 0;
> +}
> +
> +static int request_locality(struct tpm_chip *chip, int loc)
> +{
> +	struct priv_data *priv = dev_get_drvdata(&chip->dev);
> +	u8 buf = TPM_ACCESS_REQUEST_USE;
> +	unsigned long stop;
> +	int rc;
> +
> +	if (check_locality(chip, loc) == loc)
> +		return loc;
> +
> +	rc = cr50_i2c_write(chip, TPM_ACCESS(loc), &buf, 1);
> +	if (rc < 0)
> +		return rc;
> +
> +	stop = jiffies + chip->timeout_a;
> +	do {
> +		if (check_locality(chip, loc) == loc) {
> +			priv->locality = loc;
> +			return loc;
> +		}
> +		msleep(CR50_TIMEOUT_SHORT_MS);
> +	} while (time_before(jiffies, stop));
> +
> +	return -ETIMEDOUT;
> +}
> +
> +/* cr50 requires all 4 bytes of status register to be read */
> +static u8 cr50_i2c_tis_status(struct tpm_chip *chip)
> +{
> +	struct priv_data *priv = dev_get_drvdata(&chip->dev);
> +	u8 buf[4];
> +
> +	if (cr50_i2c_read(chip, TPM_STS(priv->locality), buf, sizeof(buf)) < 0)
> +		return 0;
> +	return buf[0];
> +}
> +
> +/* cr50 requires all 4 bytes of status register to be written */
> +static void cr50_i2c_tis_ready(struct tpm_chip *chip)
> +{
> +	struct priv_data *priv = dev_get_drvdata(&chip->dev);
> +	u8 buf[4] = { TPM_STS_COMMAND_READY };
> +
> +	cr50_i2c_write(chip, TPM_STS(priv->locality), buf, sizeof(buf));
> +	msleep(CR50_TIMEOUT_SHORT_MS);
> +}
> +
> +/*
> + * cr50 uses bytes 3:2 of status register for burst count and
> + * all 4 bytes must be read
> + */
> +static int cr50_i2c_wait_burststs(struct tpm_chip *chip, u8 mask,
> +				  size_t *burst, int *status)
> +{
> +	struct priv_data *priv = dev_get_drvdata(&chip->dev);
> +	unsigned long stop;
> +	u8 buf[4];
> +
> +	/* wait for burstcount */
> +	stop = jiffies + chip->timeout_b;
> +	do {
> +		if (cr50_i2c_read(chip, TPM_STS(priv->locality),
> +				  (u8 *)&buf, sizeof(buf)) < 0) {
> +			msleep(CR50_TIMEOUT_SHORT_MS);
> +			continue;
> +		}
> +
> +		*status = *buf;
> +		*burst = le16_to_cpup((__le16 *)(buf + 1));
> +
> +		if ((*status & mask) == mask &&
> +		    *burst > 0 && *burst <= CR50_MAX_BUFSIZE)
> +			return 0;
> +
> +		msleep(CR50_TIMEOUT_SHORT_MS);
> +	} while (time_before(jiffies, stop));
> +
> +	dev_err(&chip->dev, "Timeout reading burst and status\n");
> +	return -ETIMEDOUT;
> +}
> +
> +static int cr50_i2c_tis_recv(struct tpm_chip *chip, u8 *buf, size_t buf_len)
> +{
> +	struct priv_data *priv = dev_get_drvdata(&chip->dev);
> +	int status, rc;
> +	size_t burstcnt, cur, len, expected;
> +	u8 addr = TPM_DATA_FIFO(priv->locality);
> +	u8 mask = TPM_STS_VALID | TPM_STS_DATA_AVAIL;
> +
> +	if (buf_len < TPM_HEADER_SIZE)
> +		return -EINVAL;
> +
> +	rc = cr50_i2c_wait_burststs(chip, mask, &burstcnt, &status);
> +	if (rc < 0)
> +		goto out_err;
> +
> +	if (burstcnt > buf_len || burstcnt < TPM_HEADER_SIZE) {
> +		dev_err(&chip->dev,
> +			"Unexpected burstcnt: %zu (max=%zu, min=%d)\n",
> +			burstcnt, buf_len, TPM_HEADER_SIZE);
> +		rc = -EIO;
> +		goto out_err;
> +	}
> +
> +	/* Read first chunk of burstcnt bytes */
> +	rc = cr50_i2c_read(chip, addr, buf, burstcnt);
> +	if (rc < 0) {
> +		dev_err(&chip->dev, "Read of first chunk failed\n");
> +		goto out_err;
> +	}
> +
> +	/* Determine expected data in the return buffer */
> +	expected = be32_to_cpup((__be32 *)(buf + 2));
> +	if (expected > buf_len) {
> +		dev_err(&chip->dev, "Too much data in FIFO\n");
> +		goto out_err;
> +	}
> +
> +	/* Now read the rest of the data */
> +	cur = burstcnt;
> +	while (cur < expected) {
> +		/* Read updated burst count and check status */
> +		rc = cr50_i2c_wait_burststs(chip, mask, &burstcnt, &status);
> +		if (rc < 0)
> +			goto out_err;
> +
> +		len = min_t(size_t, burstcnt, expected - cur);
> +		rc = cr50_i2c_read(chip, addr, buf + cur, len);
> +		if (rc < 0) {
> +			dev_err(&chip->dev, "Read failed\n");
> +			goto out_err;
> +		}
> +
> +		cur += len;
> +	}
> +
> +	/* Ensure TPM is done reading data */
> +	rc = cr50_i2c_wait_burststs(chip, TPM_STS_VALID, &burstcnt, &status);
> +	if (rc < 0)
> +		goto out_err;
> +	if (status & TPM_STS_DATA_AVAIL) {
> +		dev_err(&chip->dev, "Data still available\n");
> +		rc = -EIO;
> +		goto out_err;
> +	}
> +
> +	release_locality(chip, 0);
> +	return cur;
> +
> +out_err:
> +	/* Abort current transaction if still pending */
> +	if (cr50_i2c_tis_status(chip) & TPM_STS_COMMAND_READY)
> +		cr50_i2c_tis_ready(chip);
> +
> +	release_locality(chip, 0);
> +	return rc;
> +}
> +
> +static int cr50_i2c_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
> +{
> +	struct priv_data *priv = dev_get_drvdata(&chip->dev);
> +	int rc, status;
> +	size_t burstcnt, limit, sent = 0;
> +	u8 tpm_go[4] = { TPM_STS_GO };
> +	unsigned long stop;
> +
> +	rc = request_locality(chip, 0);
> +	if (rc < 0)
> +		return rc;
> +
> +	/* Wait until TPM is ready for a command */
> +	stop = jiffies + chip->timeout_b;
> +	while (!(cr50_i2c_tis_status(chip) & TPM_STS_COMMAND_READY)) {
> +		if (time_after(jiffies, stop)) {
> +			rc = -ETIMEDOUT;
> +			goto out_err;
> +		}
> +
> +		cr50_i2c_tis_ready(chip);
> +	}
> +
> +	while (len > 0) {
> +		u8 mask = TPM_STS_VALID;
> +
> +		/* Wait for data if this is not the first chunk */
> +		if (sent > 0)
> +			mask |= TPM_STS_DATA_EXPECT;
> +
> +		/* Read burst count and check status */
> +		rc = cr50_i2c_wait_burststs(chip, mask, &burstcnt, &status);
> +		if (rc < 0)
> +			goto out_err;
> +
> +		/*
> +		 * Use burstcnt - 1 to account for the address byte
> +		 * that is inserted by cr50_i2c_write()
> +		 */
> +		limit = min_t(size_t, burstcnt - 1, len);
> +		rc = cr50_i2c_write(chip, TPM_DATA_FIFO(priv->locality),
> +				    &buf[sent], limit);
> +		if (rc < 0) {
> +			dev_err(&chip->dev, "Write failed\n");
> +			goto out_err;
> +		}
> +
> +		sent += limit;
> +		len -= limit;
> +	}
> +
> +	/* Ensure TPM is not expecting more data */
> +	rc = cr50_i2c_wait_burststs(chip, TPM_STS_VALID, &burstcnt, &status);
> +	if (rc < 0)
> +		goto out_err;
> +	if (status & TPM_STS_DATA_EXPECT) {
> +		dev_err(&chip->dev, "Data still expected\n");
> +		rc = -EIO;
> +		goto out_err;
> +	}
> +
> +	/* Start the TPM command */
> +	rc = cr50_i2c_write(chip, TPM_STS(priv->locality), tpm_go,
> +			    sizeof(tpm_go));
> +	if (rc < 0) {
> +		dev_err(&chip->dev, "Start command failed\n");
> +		goto out_err;
> +	}
> +	return 0;
> +
> +out_err:
> +	/* Abort current transaction if still pending */
> +	if (cr50_i2c_tis_status(chip) & TPM_STS_COMMAND_READY)
> +		cr50_i2c_tis_ready(chip);
> +
> +	release_locality(chip, 0);
> +	return rc;
> +}
> +
> +static bool cr50_i2c_req_canceled(struct tpm_chip *chip, u8 status)
> +{
> +	return (status == TPM_STS_COMMAND_READY);
> +}
> +
> +static const struct tpm_class_ops cr50_i2c = {
> +	.flags = TPM_OPS_AUTO_STARTUP,
> +	.status = &cr50_i2c_tis_status,
> +	.recv = &cr50_i2c_tis_recv,
> +	.send = &cr50_i2c_tis_send,
> +	.cancel = &cr50_i2c_tis_ready,
> +	.req_complete_mask = TPM_STS_DATA_AVAIL | TPM_STS_VALID,
> +	.req_complete_val = TPM_STS_DATA_AVAIL | TPM_STS_VALID,
> +	.req_canceled = &cr50_i2c_req_canceled,
> +};
> +
> +static int cr50_i2c_init(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct tpm_chip *chip;
> +	struct priv_data *priv;
> +	u8 buf[4];
> +	u32 vendor;
> +	int rc;
> +
> +	chip = tpmm_chip_alloc(dev, &cr50_i2c);
> +	if (IS_ERR(chip))
> +		return PTR_ERR(chip);
> +
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	/* cr50 is a TPM 2.0 chip */
> +	chip->flags |= TPM_CHIP_FLAG_TPM2;
> +
> +	/* Default timeouts */
> +	chip->timeout_a = msecs_to_jiffies(TIS_SHORT_TIMEOUT);
> +	chip->timeout_b = msecs_to_jiffies(TIS_LONG_TIMEOUT);
> +	chip->timeout_c = msecs_to_jiffies(TIS_SHORT_TIMEOUT);
> +	chip->timeout_d = msecs_to_jiffies(TIS_SHORT_TIMEOUT);
> +
> +	dev_set_drvdata(&chip->dev, priv);
> +	init_completion(&priv->tpm_ready);
> +
> +	if (client->irq > 0) {
> +		rc = devm_request_irq(dev, client->irq, cr50_i2c_int_handler,
> +				      IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +				      dev->driver->name, chip);
> +		if (rc < 0) {
> +			dev_err(dev, "Failed to probe IRQ %d\n", client->irq);
> +			return rc;
> +		}
> +
> +		disable_irq(client->irq);
> +		priv->irq = client->irq;
> +	} else {
> +		dev_warn(dev, "No IRQ, will use %ums delay for TPM ready\n",
> +			 CR50_TIMEOUT_NOIRQ_MS);
> +	}
> +
> +	rc = request_locality(chip, 0);
> +	if (rc < 0) {
> +		dev_err(dev, "Could not request locality\n");
> +		return rc;
> +	}
> +
> +	/* Read four bytes from DID_VID register */
> +	rc = cr50_i2c_read(chip, TPM_DID_VID(0), buf, sizeof(buf));
> +	if (rc < 0) {
> +		dev_err(dev, "Could not read vendor id\n");
> +		release_locality(chip, 1);
> +		return rc;
> +	}
> +
> +	vendor = le32_to_cpup((__le32 *)buf);
> +	if (vendor != CR50_I2C_DID_VID) {
> +		dev_err(dev, "Vendor ID did not match! ID was %08x\n", vendor);
> +		release_locality(chip, 1);
> +		return -ENODEV;
> +	}
> +
> +	dev_info(dev, "cr50 TPM 2.0 (i2c 0x%02x irq %d id 0x%x)\n",
> +		 client->addr, client->irq, vendor >> 16);
> +
> +	chip->hwrng.quality = rng_quality;
> +
> +	return tpm_chip_register(chip);
> +}
> +
> +static const struct i2c_device_id cr50_i2c_table[] = {
> +	{"cr50_i2c", 0},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(i2c, cr50_i2c_table);
> +
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id cr50_i2c_acpi_id[] = {
> +	{ "GOOG0005", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, cr50_i2c_acpi_id);
> +#endif
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id of_cr50_i2c_match[] = {
> +	{ .compatible = "google,cr50", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, of_cr50_i2c_match);
> +#endif
> +
> +static int cr50_i2c_probe(struct i2c_client *client,
> +			  const struct i2c_device_id *id)
> +{
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> +		return -ENODEV;
> +
> +	return cr50_i2c_init(client);
> +}
> +
> +static int cr50_i2c_remove(struct i2c_client *client)
> +{
> +	struct tpm_chip *chip = i2c_get_clientdata(client);
> +
> +	tpm_chip_unregister(chip);
> +	release_locality(chip, 1);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(cr50_i2c_pm, cr50_suspend, cr50_resume);
> +
> +static struct i2c_driver cr50_i2c_driver = {
> +	.id_table = cr50_i2c_table,
> +	.probe = cr50_i2c_probe,
> +	.remove = cr50_i2c_remove,
> +	.driver = {
> +		.name = "cr50_i2c",
> +		.pm = &cr50_i2c_pm,
> +		.acpi_match_table = ACPI_PTR(cr50_i2c_acpi_id),
> +		.of_match_table = of_match_ptr(of_cr50_i2c_match),
> +	},
> +};
> +
> +module_i2c_driver(cr50_i2c_driver);
> +
> +MODULE_DESCRIPTION("cr50 TPM I2C Driver");
> +MODULE_LICENSE("GPL")
