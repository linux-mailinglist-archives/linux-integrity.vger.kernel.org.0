Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA0AC2CC2F2
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Dec 2020 18:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbgLBRDD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Dec 2020 12:03:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:33518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbgLBRDD (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Dec 2020 12:03:03 -0500
Date:   Wed, 2 Dec 2020 19:02:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606928541;
        bh=BHhpU8hXaddVdOs7TH+Q5WpalCMfOdcpLuzHQZ/WC6g=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=Znqni+yNu/Fzm02M4QeeSA+c2CLWqvo/AC8kwByHEAjvjGUUMJRfIldimGkowlwyq
         ArUIwdujzGMfTuUZGxSw9/iJfHkwjnwsbLWwI+WgVUH7vKjkkNdBHVAhH6kLBxQktp
         rvWuhzG88aov6gWUxYLyrbEFiWVCspn2HLf/7SIY=
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        kernel@collabora.com, Duncan Laurie <dlaurie@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Helen Koike <helen.koike@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: Re: [PATCH v4] char: tpm: add i2c driver for cr50
Message-ID: <20201202170215.GB91318@kernel.org>
References: <20201202105805.132183-1-adrian.ratiu@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201202105805.132183-1-adrian.ratiu@collabora.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Dec 02, 2020 at 12:58:05PM +0200, Adrian Ratiu wrote:
> From: "dlaurie@chromium.org" <dlaurie@chromium.org>
> 
> Add TPM 2.0 compatible I2C interface for chips with cr50 firmware.
> 
> The firmware running on the currently supported H1 MCU requires a
> special driver to handle its specific protocol, and this makes it
> unsuitable to use tpm_tis_core_* and instead it must implement the
> underlying TPM protocol similar to the other I2C TPM drivers.
> 
> - All 4 bytes of status register must be read/written at once.
> - FIFO and burst count is limited to 63 and must be drained by AP.
> - Provides an interrupt to indicate when read response data is ready
> and when the TPM is finished processing write data.
> 
> This driver is based on the existing infineon I2C TPM driver, which
> most closely matches the cr50 i2c protocol behavior.
> 
> Cc: Helen Koike <helen.koike@collabora.com>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Ezequiel Garcia <ezequiel@collabora.com>
> Signed-off-by: Duncan Laurie <dlaurie@chromium.org>
> [swboyd@chromium.org: Depend on i2c even if it's a module, replace
> boilier plate with SPDX tag, drop asm/byteorder.h include, simplify
> return from probe]
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
> Changes in v4:
>   - Replace force_release enum with defines (Jarkko)
> 
> Changes in v3:
>   - Misc small fixes (typos/renamings, comments, default values)
>   - Moved i2c_write memcpy before lock to minimize critical section (Helen)
>   - Dropped priv->locality because it stored a constant value (Helen)
>   - Many kdoc, function name and style fixes in general (Jarkko)
>   - Kept the force release enum instead of defines or bool (Ezequiel)
> 
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
> Applies on next-20201201, tested on Chromebook EVE.
> ---
>  drivers/char/tpm/Kconfig            |  10 +
>  drivers/char/tpm/Makefile           |   2 +
>  drivers/char/tpm/tpm_tis_i2c_cr50.c | 767 ++++++++++++++++++++++++++++
>  3 files changed, 779 insertions(+)
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
> index 000000000000..a374853a3b4b
> --- /dev/null
> +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> @@ -0,0 +1,767 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2016 Google Inc.

Should be 2020.

> + *
> + * Based on Linux Kernel TPM driver by
> + * Peter Huewe <peter.huewe@infineon.com>
> + * Copyright (C) 2011 Infineon Technologies

Not sure how this was derived.

> + *
> + * cr50 is a firmware for H1 secure modules that requires special
> + * handling for the I2C interface.
> + *
> + * - Use an interrupt for transaction status instead of hardcoded delays.
> + * - Must use write+wait+read read protocol.
> + * - All 4 bytes of status register must be read/written at once.
> + * - Burst count max is 63 bytes, and burst count behaves slightly differently
> + *   than other I2C TPMs.
> + * - When reading from FIFO the full burstcnt must be read instead of just
> + *   reading header and determining the remainder.
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
> +#define TPM_CR50_MAX_BUFSIZE		64
> +#define TPM_CR50_TIMEOUT_SHORT_MS	2	/* Short timeout during transactions */
> +#define TPM_CR50_TIMEOUT_NOIRQ_MS	20	/* Timeout for TPM ready without IRQ */
> +#define TPM_CR50_I2C_DID_VID		0x00281ae0L /* Device and vendor ID reg value */
> +#define TPM_CR50_I2C_MAX_RETRIES	3	/* Max retries due to I2C errors */
> +#define TPM_CR50_I2C_RETRY_DELAY_LO	55	/* Min usecs between retries on I2C */
> +#define TPM_CR50_I2C_RETRY_DELAY_HI	65	/* Max usecs between retries on I2C */
> +
> +#define TPM_I2C_ACCESS(l)	(0x0000 | ((l) << 4))
> +#define TPM_I2C_STS(l)		(0x0001 | ((l) << 4))
> +#define TPM_I2C_DATA_FIFO(l)	(0x0005 | ((l) << 4))
> +#define TPM_I2C_DID_VID(l)	(0x0006 | ((l) << 4))
> +
> +#define TPM_I2C_CR50_NO_FORCE	0
> +#define TPM_I2C_CR50_FORCE	1

No need for these.

> +
> +/**
> + * struct tpm_i2c_cr50_priv_data - Driver private data.
> + * @irq: Irq number used for this chip. 
> + *       If irq <= 0, then a fixed timeout is used instead of waiting for irq.
> + * @tpm_ready: Struct used by irq handler to signal R/W readiness.
> + * @buf: Buffer used for i2c writes, with i2c address prepended to content.

Not properly aligned.

https://www.kernel.org/doc/Documentation/kernel-doc-nano-HOWTO.txt

> + */
> +struct tpm_i2c_cr50_priv_data {
> +	int irq;
> +	struct completion tpm_ready;
> +	u8 buf[TPM_CR50_MAX_BUFSIZE];
> +};
> +
> +/**
> + * tpm_cr50_i2c_int_handler() - cr50 interrupt handler.
> + * @dummy: Unused parameter.
> + * @dev_id: TPM chip information.

This is alignment everywhere. Why the parameter is called "dev_id" anyway?

> + *
> + * The cr50 interrupt handler signals waiting threads that the
> + * interrupt has been asserted. It does not do any interrupt triggered
> + * processing but is instead used to avoid fixed delays.
> + */
> +static irqreturn_t tpm_cr50_i2c_int_handler(int dummy, void *dev_id)
> +{
> +	struct tpm_chip *chip = dev_id;
> +	struct tpm_i2c_cr50_priv_data *priv = dev_get_drvdata(&chip->dev);
> +
> +	complete(&priv->tpm_ready);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/**
> + * tpm_cr50_i2c_wait_tpm_ready() - Wait for tpm to signal ready.
> + * @chip: TPM chip information.
> + *
> + * Wait for completion interrupt if available, otherwise use a fixed
> + * delay for the TPM to be ready.
> + *
> + * Return: 0 for success or timeout error number.
> + */
> +static int tpm_cr50_i2c_wait_tpm_ready(struct tpm_chip *chip)
> +{
> +	struct tpm_i2c_cr50_priv_data *priv = dev_get_drvdata(&chip->dev);
> +
> +	/* Use a safe fixed delay if interrupt is not supported */
> +	if (priv->irq <= 0) {
> +		msleep(TPM_CR50_TIMEOUT_NOIRQ_MS);
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
> +/**
> + * tpm_cr50_i2c_enable_tpm_irq() - Enable TPM irq.
> + * @chip: TPM chip information.
> + */
> +static void tpm_cr50_i2c_enable_tpm_irq(struct tpm_chip *chip)
> +{
> +	struct tpm_i2c_cr50_priv_data *priv = dev_get_drvdata(&chip->dev);
> +
> +	if (priv->irq > 0) {
> +		reinit_completion(&priv->tpm_ready);
> +		enable_irq(priv->irq);
> +	}
> +}
> +
> +/**
> + * tpm_cr50_i2c_disable_tpm_irq() - Disable TPM irq.
> + * @chip: TPM chip information.
> + */
> +static void tpm_cr50_i2c_disable_tpm_irq(struct tpm_chip *chip)
> +{
> +	struct tpm_i2c_cr50_priv_data *priv = dev_get_drvdata(&chip->dev);
> +
> +	if (priv->irq > 0)
> +		disable_irq(priv->irq);
> +}
> +
> +/**
> + * tpm_cr50_i2c_transfer_message() - Transfer a message over i2c.
> + * @dev: Device information.
> + * @adapter: I2C adapter.
> + * @msg:Mmessage to transfer.

Alignment etc.

> + *
> + * Call unlocked i2c transfer routine with the provided parameters and
> + * retry in case of bus errors.
> + *
> + * Return: 0 on success, otherwise negative errno.
> + */
> +static int tpm_cr50_i2c_transfer_message(struct device *dev,
> +					 struct i2c_adapter *adapter,
> +					 struct i2c_msg *msg)
> +{
> +	int rc;
> +	unsigned int try;

Opposite order would be more readable (reverse christmas tree).

> +
> +	for (try = 0; try < TPM_CR50_I2C_MAX_RETRIES; try++) {
> +		rc = __i2c_transfer(adapter, msg, 1);
> +		if (rc == 1)
> +			return 0; /* Successfully transferred the message */
> +		if (try)
> +			dev_warn(dev, "i2c transfer failed (attempt %d/%d): %d\n",
> +				 try + 1, TPM_CR50_I2C_MAX_RETRIES, rc);
> +		usleep_range(TPM_CR50_I2C_RETRY_DELAY_LO,
> +			     TPM_CR50_I2C_RETRY_DELAY_HI);

Can be probably put into one line without checkpatch.pl complaining.

Giving up at this point.

/Jarkko
