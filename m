Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A822C182B
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Nov 2020 23:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730427AbgKWWGx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 Nov 2020 17:06:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:41312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732290AbgKWWGw (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Nov 2020 17:06:52 -0500
Received: from kernel.org (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF1E12065E;
        Mon, 23 Nov 2020 22:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606169209;
        bh=oaN6KRuK3VSxyJTGGOI0z7tSBdDlBU6KSTVVAUX8xP0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t/dMxXTl0eW/hyY4n5zPNCGyXGcJfc8WKwggSe3YZrfVOH6lNL5HXKa9Y/YdtSl/Z
         yKwHPZajvFY2enDuaK9ctDdGhQAh2U21WZUBqUP3pKagtu+1HK+RzgPQyiSKigML32
         VXZ3+93RDhNRVP9RmiDHc9l7x5xiom7IgVn97d2c=
Date:   Tue, 24 Nov 2020 00:06:43 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Helen Koike <helen.koike@collabora.com>,
        Duncan Laurie <dlaurie@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>, kernel@collabora.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] char: tpm: add i2c driver for cr50
Message-ID: <20201123220643.GA16777@kernel.org>
References: <20201120172345.4040187-1-adrian.ratiu@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120172345.4040187-1-adrian.ratiu@collabora.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Nov 20, 2020 at 07:23:45PM +0200, Adrian Ratiu wrote:
> From: "dlaurie@chromium.org" <dlaurie@chromium.org>
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
> 
> This driver is based on the existing infineon I2C TPM driver, which
> most closely matches the cr50 i2c protocol behavior.
> 
> Cc: Helen Koike <helen.koike@collabora.com>
> Signed-off-by: Duncan Laurie <dlaurie@chromium.org>
> [swboyd@chromium.org: Depend on i2c even if it's a module, replace
> boilier plate with SPDX tag, drop asm/byteorder.h include, simplify
> return from probe]
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
> Changes in v2:
>   - Various small fixes all over (reorder includes, MAX_BUFSIZE, comments, etc)
>   - Reworked return values of i2c_wait_tpm_ready() to fix timeout mis-handling
> so ret == 0 now means success, the wait period jiffies is ignored because that
> number is meaningless and return a proper timeout error in case jiffies == 0.
>   - Make i2c default to 1 message per transfer (requested by Helen)
>   - Move -EIO error reporting to transfer function to cleanup transfer() itself
> and its R/W callers
>   - Remove magic value hardcodings and introduce enum force_release.
> 
> v1 posted at https://lkml.org/lkml/2020/2/25/349
> 
> Applies on next-20201120, tested on Chromebook EVE.
> ---
>  drivers/char/tpm/Kconfig            |  10 +
>  drivers/char/tpm/Makefile           |   2 +
>  drivers/char/tpm/tpm_tis_i2c_cr50.c | 768 ++++++++++++++++++++++++++++
>  3 files changed, 780 insertions(+)
>  create mode 100644 drivers/char/tpm/tpm_tis_i2c_cr50.c
> 
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index a18c314da211..4308f9ca7a43 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -86,6 +86,16 @@ config TCG_TIS_SYNQUACER
>  	  To compile this driver as a module, choose  M here;
>  	  the module will be called tpm_tis_synquacer.
>  
> +config TCG_TIS_I2C_CR50
> +	tristate "TPM Interface Specification 2.0 Interface (I2C - CR50)"
> +	depends on I2C
> +	select TCG_CR50
> +	help
> +	  This is a driver for the Google cr50 I2C TPM interface which is a
> +	  custom microcontroller and requires a custom i2c protocol interface
> +	  to handle the limitations of the hardware.  To compile this driver
> +	  as a module, choose M here; the module will be called tcg_tis_i2c_cr50.
> +
>  config TCG_TIS_I2C_ATMEL
>  	tristate "TPM Interface Specification 1.2 Interface (I2C - Atmel)"
>  	depends on I2C
> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> index 84db4fb3a9c9..66d39ea6bd10 100644
> --- a/drivers/char/tpm/Makefile
> +++ b/drivers/char/tpm/Makefile
> @@ -27,6 +27,8 @@ obj-$(CONFIG_TCG_TIS_SPI) += tpm_tis_spi.o
>  tpm_tis_spi-y := tpm_tis_spi_main.o
>  tpm_tis_spi-$(CONFIG_TCG_TIS_SPI_CR50) += tpm_tis_spi_cr50.o
>  
> +obj-$(CONFIG_TCG_TIS_I2C_CR50) += tpm_tis_i2c_cr50.o
> +
>  obj-$(CONFIG_TCG_TIS_I2C_ATMEL) += tpm_i2c_atmel.o
>  obj-$(CONFIG_TCG_TIS_I2C_INFINEON) += tpm_i2c_infineon.o
>  obj-$(CONFIG_TCG_TIS_I2C_NUVOTON) += tpm_i2c_nuvoton.o
> diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> new file mode 100644
> index 000000000000..37555dafdca0
> --- /dev/null
> +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> @@ -0,0 +1,768 @@
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
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/pm.h>
> +#include <linux/slab.h>
> +#include <linux/wait.h>
> +
> +#include "tpm_tis_core.h"
> +
> +#define CR50_MAX_BUFSIZE	64
> +#define CR50_TIMEOUT_SHORT_MS	2	/* Short timeout during transactions */
> +#define CR50_TIMEOUT_NOIRQ_MS	20	/* Timeout for TPM ready without IRQ */
> +#define CR50_I2C_DID_VID	0x00281ae0L
> +#define CR50_I2C_MAX_RETRIES	3	/* Max retries due to I2C errors */
> +#define CR50_I2C_RETRY_DELAY_LO	55	/* Min usecs between retries on I2C */
> +#define CR50_I2C_RETRY_DELAY_HI	65	/* Max usecs between retries on I2C */

CR50_ -> TPM_CR50_

> +
> +#define TPM_I2C_ACCESS(l)	(0x0000 | ((l) << 4))
> +#define TPM_I2C_STS(l)		(0x0001 | ((l) << 4))
> +#define TPM_I2C_DATA_FIFO(l)	(0x0005 | ((l) << 4))
> +#define TPM_I2C_DID_VID(l)	(0x0006 | ((l) << 4))
> +
> +struct priv_data {
> +	int irq;
> +	int locality;
> +	struct completion tpm_ready;
> +	u8 buf[CR50_MAX_BUFSIZE];
> +};

tpm_i2c_cr50_priv_data

> +
> +enum force_release {
> +	CR50_NO_FORCE = 0x0,
> +	CR50_FORCE = 0x1,
> +};

I'd just 

#define TPM_I2C_CR50_NO_FORCE	0
#define TPM_I2C_CR50_FORCE	1

> +
> +/*
> + * The cr50 interrupt handler just signals waiting threads that the
> + * interrupt was asserted.  It does not do any processing triggered
> + * by interrupts but is instead used to avoid fixed delays.
> + *
> + * @dummy: unuesed parameter
> + * @dev_id: TPM chip information
> + */

Please review for kdoc:

https://www.kernel.org/doc/Documentation/kernel-doc-nano-HOWTO.txt

> +static irqreturn_t cr50_i2c_int_handler(int dummy, void *dev_id)

cr50 -> tpm_i2c_cr50_

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
> + * @chip: TPM chip information
> + *
> + * Returns 0 for success, negative number for timeout
> + */
> +static int cr50_i2c_wait_tpm_ready(struct tpm_chip *chip)

Ditto.

> +{
> +	struct priv_data *priv = dev_get_drvdata(&chip->dev);
> +
> +	/* Use a safe fixed delay if interrupt is not supported */
> +	if (priv->irq <= 0) {
> +		msleep(CR50_TIMEOUT_NOIRQ_MS);
> +		return 0;
> +	}
> +
> +	/* Wait for interrupt to indicate TPM is ready to respond */
> +	if (!wait_for_completion_timeout(&priv->tpm_ready,
> +					 msecs_to_jiffies(chip->timeout_a))) {
> +		dev_warn(&chip->dev, "Timeout waiting for TPM ready\n");
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * cr50_i2c_enable_tpm_irq - enable TPM irq
> + *
> + * @chip: TPM chip information
> + */
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
> +/*
> + * cr50_i2c_disable_tpm_irq - disable TPM irq
> + *
> + * @chip: TPM chip information
> + */
> +static void cr50_i2c_disable_tpm_irq(struct tpm_chip *chip)
> +{
> +	struct priv_data *priv = dev_get_drvdata(&chip->dev);
> +
> +	if (priv->irq > 0)
> +		disable_irq(priv->irq);
> +}
> +
> +/*
> + * cr50_i2c_transfer_message - transfer a message over i2c
> + *
> + * @dev: device information
> + * @adapter: i2c adapter
> + * @msg: message to transfer
> + *
> + * Call unlocked i2c transfer routine with the provided parameters and retry
> + * in case of bus errors. Returns 0 on success, otherwise negative errno.
> + */
> +static int cr50_i2c_transfer_message(struct device *dev,
> +				     struct i2c_adapter *adapter,
> +				     struct i2c_msg *msg)
> +{
> +	int rc = 0;
> +	unsigned int try;
> +
> +	for (try = 0; try < CR50_I2C_MAX_RETRIES; try++) {
> +		rc = __i2c_transfer(adapter, msg, 1);
> +		if (rc == 1)
> +			return 0; /* Successfully transferred the message */
> +		if (try)
> +			dev_warn(dev, "i2c transfer failed (attempt %d/%d): %d\n",
> +				 try + 1, CR50_I2C_MAX_RETRIES, rc);
> +		usleep_range(CR50_I2C_RETRY_DELAY_LO, CR50_I2C_RETRY_DELAY_HI);
> +	}
> +
> +	return -EIO; /* No i2c message transferred */
> +}
> +
> +/*
> + * cr50_i2c_read() - read from TPM register
> + *

Not only wrong formatting but seems that these kdoc's have differing
formatting (no newline).

> + * @chip: TPM chip information
> + * @addr: register address to read from
> + * @buffer: provided by caller
> + * @len: number of bytes to read
> + *
> + * 1) send register address byte 'addr' to the TPM
> + * 2) wait for TPM to indicate it is ready
> + * 3) read 'len' bytes of TPM response into the provided 'buffer'

Please write proper sentences instead of lower-case (also applies
to parameters as you can see from kernel documentation).

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
> +	rc = cr50_i2c_transfer_message(&chip->dev, client->adapter, &msg1);
> +	if (rc < 0)
> +		goto out;
> +
> +	/* Wait for TPM to be ready with response data */
> +	rc = cr50_i2c_wait_tpm_ready(chip);
> +	if (rc < 0)
> +		goto out;
> +
> +	/* Read response data from the TPM */
> +	rc = cr50_i2c_transfer_message(&chip->dev, client->adapter, &msg2);
> +
> +out:
> +	cr50_i2c_disable_tpm_irq(chip);
> +	i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
> +
> +	if (rc < 0)
> +		return rc;
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
> +	if (len > CR50_MAX_BUFSIZE - 1)
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
> +	rc = cr50_i2c_transfer_message(&chip->dev, client->adapter, &msg1);
> +	if (rc < 0)
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
> +
> +	return 0;
> +}
> +
> +/*
> + * cr50_check_locality - verify TPM locality
> + *
> + * @chip: TPM chip information
> + *
> + * Returns negative number for error, 0 for success.
> + */
> +static int cr50_check_locality(struct tpm_chip *chip)
> +{
> +	u8 mask = TPM_ACCESS_VALID | TPM_ACCESS_ACTIVE_LOCALITY;
> +	u8 buf;
> +	int rc;
> +
> +	rc = cr50_i2c_read(chip, TPM_I2C_ACCESS(0), &buf, sizeof(buf));
> +	if (rc < 0)
> +		return rc;
> +
> +	if ((buf & mask) == mask)
> +		return 0;
> +
> +	return -EIO;
> +}
> +
> +/*
> + * cr50_release_locality - release TPM locality
> + *
> + * @chip: TPM chip information
> + * @force: flag to force release if set
> + */
> +static void cr50_release_locality(struct tpm_chip *chip,
> +				  enum force_release force)
> +{
> +	struct priv_data *priv = dev_get_drvdata(&chip->dev);
> +	u8 mask = TPM_ACCESS_VALID | TPM_ACCESS_REQUEST_PENDING;
> +	u8 addr = TPM_I2C_ACCESS(priv->locality);
> +	u8 buf;
> +
> +	if (cr50_i2c_read(chip, addr, &buf, sizeof(buf)) < 0)
> +		return;
> +
> +	if (force || (buf & mask) == mask) {
> +		buf = TPM_ACCESS_ACTIVE_LOCALITY;
> +		cr50_i2c_write(chip, addr, &buf, sizeof(buf));
> +	}
> +
> +	priv->locality = 0;
> +}
> +
> +/*
> + * request_locality - request TPM locality
> + *
> + * @chip: TPM chip information
> + */
> +static int request_locality(struct tpm_chip *chip)
> +{
> +	struct priv_data *priv = dev_get_drvdata(&chip->dev);
> +	u8 buf = TPM_ACCESS_REQUEST_USE;
> +	unsigned long stop;
> +	int rc;
> +
> +	if (!cr50_check_locality(chip))
> +		return 0;
> +
> +	rc = cr50_i2c_write(chip, TPM_I2C_ACCESS(0), &buf, sizeof(buf));
> +	if (rc < 0)
> +		return rc;
> +
> +	stop = jiffies + chip->timeout_a;
> +	do {
> +		if (!cr50_check_locality(chip)) {
> +			priv->locality = 0;
> +			return 0;
> +		}
> +		msleep(CR50_TIMEOUT_SHORT_MS);
> +	} while (time_before(jiffies, stop));
> +
> +	return -ETIMEDOUT;
> +}
> +
> +/*
> + * cr50 requires all 4 bytes of status register to be read
> + *
> + * @chip: TPM chip information
> + *
> + * Returns TPM status
> + */
> +static u8 cr50_i2c_tis_status(struct tpm_chip *chip)
> +{
> +	struct priv_data *priv = dev_get_drvdata(&chip->dev);
> +	u8 buf[4];
> +
> +	if (cr50_i2c_read(chip, TPM_I2C_STS(priv->locality),
> +			  buf, sizeof(buf)) < 0)
> +		return 0;
> +	return buf[0];
> +}
> +
> +/*
> + * cr50 requires all 4 bytes of status register to be written
> + *
> + * @chip: TPM chip information
> + */
> +static void cr50_i2c_tis_ready(struct tpm_chip *chip)
> +{
> +	struct priv_data *priv = dev_get_drvdata(&chip->dev);
> +	u8 buf[4] = { TPM_STS_COMMAND_READY };
> +
> +	cr50_i2c_write(chip, TPM_I2C_STS(priv->locality), buf, sizeof(buf));
> +	msleep(CR50_TIMEOUT_SHORT_MS);
> +}
> +
> +/*
> + * cr50 uses bytes 3:2 of status register for burst count and
> + * all 4 bytes must be read
> + *
> + * @chip: TPM chip information
> + * @mask: status mask
> + * @burst: return value for burst
> + * @status: return value for statis
> + *
> + * Returns negative number for error, 0 for success.
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
> +		if (cr50_i2c_read(chip, TPM_I2C_STS(priv->locality),
> +				  buf, sizeof(buf)) < 0) {
> +			msleep(CR50_TIMEOUT_SHORT_MS);
> +			continue;
> +		}
> +
> +		*status = *buf;
> +		*burst = le16_to_cpup((__le16 *)(buf + 1));
> +
> +		if ((*status & mask) == mask &&
> +		    *burst > 0 && *burst <= CR50_MAX_BUFSIZE - 1)
> +			return 0;
> +
> +		msleep(CR50_TIMEOUT_SHORT_MS);
> +	} while (time_before(jiffies, stop));
> +
> +	dev_err(&chip->dev, "Timeout reading burst and status\n");
> +	return -ETIMEDOUT;
> +}
> +
> +/*
> + * cr50_i2c_tis_recv - TPM reception callback
> + *
> + * @chip: TPM chip information
> + * @buf: reception buffer
> + * @buf_len: buffer length to read
> + *
> + * Returns negative number for error, number of bytes read for success.
> + */
> +static int cr50_i2c_tis_recv(struct tpm_chip *chip, u8 *buf, size_t buf_len)
> +{
> +	struct priv_data *priv = dev_get_drvdata(&chip->dev);
> +	int status, rc;
> +	size_t burstcnt, cur, len, expected;
> +	u8 addr = TPM_I2C_DATA_FIFO(priv->locality);
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
> +		dev_err(&chip->dev, "Buffer too small to receive i2c data\n");
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
> +	cr50_release_locality(chip, CR50_NO_FORCE);
> +	return cur;
> +
> +out_err:
> +	/* Abort current transaction if still pending */
> +	if (cr50_i2c_tis_status(chip) & TPM_STS_COMMAND_READY)
> +		cr50_i2c_tis_ready(chip);
> +
> +	cr50_release_locality(chip, CR50_NO_FORCE);
> +	return rc;
> +}
> +
> +/*
> + * cr50_i2c_tis_send - TPM emission callback
> + *
> + * @chip: TPM chip information
> + * @buf: buffer to send
> + * @len: buffer length
> + *
> + * Returns negative number for error, 0 for success.
> + */
> +static int cr50_i2c_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
> +{
> +	struct priv_data *priv = dev_get_drvdata(&chip->dev);
> +	int rc, status;
> +	size_t burstcnt, limit, sent = 0;
> +	u8 tpm_go[4] = { TPM_STS_GO };
> +	unsigned long stop;
> +
> +	rc = request_locality(chip);
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
> +		rc = cr50_i2c_write(chip, TPM_I2C_DATA_FIFO(priv->locality),
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
> +	rc = cr50_i2c_write(chip, TPM_I2C_STS(priv->locality), tpm_go,
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
> +	cr50_release_locality(chip, CR50_NO_FORCE);
> +	return rc;
> +}
> +
> +/*
> + * cr50_i2c_req_canceled - callback to notify a request cancel
> + *
> + * @chip: TPM chip information
> + * @status: status given by the cancel callback
> + *
> + * Return if command is ready or not
> + */
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
> +/*
> + * cr50_i2c_probe - driver prbe function
> + *
> + * @client: i2x client information
> + * @id: i2c device id
> + *
> + * Returns negative number for error, 0 for success.
> + */
> +static int cr50_i2c_probe(struct i2c_client *client,
> +			  const struct i2c_device_id *id)
> +{
> +	struct device *dev = &client->dev;
> +	struct tpm_chip *chip;
> +	struct priv_data *priv;
> +	u8 buf[4];
> +	u32 vendor;
> +	int rc;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> +		return -ENODEV;
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
> +	chip->flags |= TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED;
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
> +	rc = request_locality(chip);
> +	if (rc < 0) {
> +		dev_err(dev, "Could not request locality\n");
> +		return rc;
> +	}
> +
> +	/* Read four bytes from DID_VID register */
> +	rc = cr50_i2c_read(chip, TPM_I2C_DID_VID(0), buf, sizeof(buf));
> +	if (rc < 0) {
> +		dev_err(dev, "Could not read vendor id\n");
> +		cr50_release_locality(chip, CR50_FORCE);
> +		return rc;
> +	}
> +
> +	vendor = le32_to_cpup((__le32 *)buf);
> +	if (vendor != CR50_I2C_DID_VID) {
> +		dev_err(dev, "Vendor ID did not match! ID was %08x\n", vendor);
> +		cr50_release_locality(chip, CR50_FORCE);
> +		return -ENODEV;
> +	}
> +
> +	dev_info(dev, "cr50 TPM 2.0 (i2c 0x%02x irq %d id 0x%x)\n",
> +		 client->addr, client->irq, vendor >> 16);
> +
> +	return tpm_chip_register(chip);
> +}
> +
> +/*
> + * cr50_i2c_probe - driver prbe function
> + *
> + * @client: i2x client information
> + *
> + * Returns 0
> + */
> +static int cr50_i2c_remove(struct i2c_client *client)
> +{
> +	struct tpm_chip *chip = i2c_get_clientdata(client);
> +
> +	tpm_chip_unregister(chip);
> +	cr50_release_locality(chip, CR50_FORCE);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(cr50_i2c_pm, tpm_pm_suspend, tpm_pm_resume);
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
> +MODULE_LICENSE("GPL");
> -- 
> 2.29.2
> 
> 

I did not enumerate every possible style error but instead showed some
examples, because there were so many.

/Jarkko
