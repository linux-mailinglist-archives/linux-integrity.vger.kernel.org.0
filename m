Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6F6A20EC
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Aug 2019 18:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbfH2Qc3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Aug 2019 12:32:29 -0400
Received: from mga04.intel.com ([192.55.52.120]:58296 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726739AbfH2Qc3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Aug 2019 12:32:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 09:32:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,444,1559545200"; 
   d="scan'208";a="180926006"
Received: from friedlmi-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.54.26])
  by fmsmga008.fm.intel.com with ESMTP; 29 Aug 2019 09:32:22 -0700
Date:   Thu, 29 Aug 2019 19:32:21 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Andrey Pronin <apronin@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v5 4/4] tpm: tpm_tis_spi: Support cr50 devices
Message-ID: <20190829163221.72njmrixakywqi5z@linux.intel.com>
References: <20190828082150.42194-1-swboyd@chromium.org>
 <20190828082150.42194-5-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828082150.42194-5-swboyd@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Aug 28, 2019 at 01:21:50AM -0700, Stephen Boyd wrote:
> Add TPM2.0 PTP FIFO compatible SPI interface for chips with Cr50
> firmware. The firmware running on the currently supported H1 Secure
> Microcontroller requires a special driver to handle its specifics:
> 
>  - need to ensure a certain delay between SPI transactions, or else
>    the chip may miss some part of the next transaction
>  - if there is no SPI activity for some time, it may go to sleep,
>    and needs to be waken up before sending further commands
>  - access to vendor-specific registers
> 
> Cr50 firmware has a requirement to wait for the TPM to wakeup before
> sending commands over the SPI bus. Otherwise, the firmware could be in
> deep sleep and not respond. The method to wait for the device to wakeup
> is slightly different than the usual flow control mechanism described in
> the TCG SPI spec. Add a completion to tpm_tis_spi_transfer() before we
> start a SPI transfer so we can keep track of the last time the TPM
> driver accessed the SPI bus to support the flow control mechanism.
> 
> Split the cr50 logic off into a different file to keep it out of the
> normal code flow of the existing SPI driver while making it all part of
> the same module when the code is optionally compiled into the same
> module. Export a new function, tpm_tis_spi_init(), and the associated
> read/write/transfer APIs so that we can do this. Make the cr50 code wrap
> the tpm_tis_spi_phy struct with its own struct to override the behavior
> of tpm_tis_spi_transfer() by supplying a custom flow control hook. This
> shares the most code between the core driver and the cr50 support
> without combining everything into the core driver or exporting module
> symbols.
> 
> Signed-off-by: Andrey Pronin <apronin@chromium.org>
> Cc: Andrey Pronin <apronin@chromium.org>
> Cc: Duncan Laurie <dlaurie@chromium.org>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Alexander Steffen <Alexander.Steffen@infineon.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
> [swboyd@chromium.org: Replace boilerplate with SPDX tag, drop
> suspended bit and remove ifdef checks in cr50.h, migrate to functions
> exported in tpm_tis_spi.h, combine into one module instead of two]
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/char/tpm/Kconfig       |   7 +
>  drivers/char/tpm/Makefile      |   4 +-
>  drivers/char/tpm/cr50_spi.c    | 327 +++++++++++++++++++++++++++++++++
>  drivers/char/tpm/tpm_tis_spi.c |  58 +++---
>  drivers/char/tpm/tpm_tis_spi.h |  54 ++++++
>  5 files changed, 423 insertions(+), 27 deletions(-)
>  create mode 100644 drivers/char/tpm/cr50_spi.c
>  create mode 100644 drivers/char/tpm/tpm_tis_spi.h
> 
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index 88a3c06fc153..1074a576a4ea 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -67,6 +67,13 @@ config TCG_TIS_SPI
>  	  within Linux. To compile this driver as a module, choose  M here;
>  	  the module will be called tpm_tis_spi.
>  
> +config TCG_CR50_SPI
> +	bool "Cr50 SPI Interface"
> +	depends on TCG_TIS_SPI
> +	---help---
> +	  If you have a H1 secure module running Cr50 firmware on SPI bus,
> +	  say Yes and it will be accessible from within Linux.
> +
>  config TCG_TIS_I2C_ATMEL
>  	tristate "TPM Interface Specification 1.2 Interface (I2C - Atmel)"
>  	depends on I2C
> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> index a01c4cab902a..d1a8c7be655d 100644
> --- a/drivers/char/tpm/Makefile
> +++ b/drivers/char/tpm/Makefile
> @@ -21,7 +21,9 @@ tpm-$(CONFIG_EFI) += eventlog/efi.o
>  tpm-$(CONFIG_OF) += eventlog/of.o
>  obj-$(CONFIG_TCG_TIS_CORE) += tpm_tis_core.o
>  obj-$(CONFIG_TCG_TIS) += tpm_tis.o
> -obj-$(CONFIG_TCG_TIS_SPI) += tpm_tis_spi.o
> +obj-$(CONFIG_TCG_TIS_SPI) += tpm_tis_spi_mod.o
> +tpm_tis_spi_mod-$(CONFIG_TCG_TIS_SPI) += tpm_tis_spi.o
> +tpm_tis_spi_mod-$(CONFIG_TCG_CR50_SPI) += cr50_spi.o
>  obj-$(CONFIG_TCG_TIS_I2C_ATMEL) += tpm_i2c_atmel.o
>  obj-$(CONFIG_TCG_TIS_I2C_INFINEON) += tpm_i2c_infineon.o
>  obj-$(CONFIG_TCG_TIS_I2C_NUVOTON) += tpm_i2c_nuvoton.o
> diff --git a/drivers/char/tpm/cr50_spi.c b/drivers/char/tpm/cr50_spi.c
> new file mode 100644
> index 000000000000..535674f4b02a
> --- /dev/null
> +++ b/drivers/char/tpm/cr50_spi.c
> @@ -0,0 +1,327 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2016 Google, Inc
> + *
> + * This device driver implements a TCG PTP FIFO interface over SPI for chips
> + * with Cr50 firmware.
> + * It is based on tpm_tis_spi driver by Peter Huewe and Christophe Ricard.
> + */
> +
> +#include <linux/completion.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/pm.h>
> +#include <linux/spi/spi.h>
> +#include <linux/wait.h>
> +
> +#include "tpm_tis_core.h"
> +#include "tpm_tis_spi.h"
> +
> +/*
> + * Cr50 timing constants:
> + * - can go to sleep not earlier than after CR50_SLEEP_DELAY_MSEC.
> + * - needs up to CR50_WAKE_START_DELAY_USEC to wake after sleep.
> + * - requires waiting for "ready" IRQ, if supported; or waiting for at least
> + *   CR50_NOIRQ_ACCESS_DELAY_MSEC between transactions, if IRQ is not supported.
> + * - waits for up to CR50_FLOW_CONTROL for flow control 'ready' indication.
> + */
> +#define CR50_SLEEP_DELAY_MSEC			1000
> +#define CR50_WAKE_START_DELAY_USEC		1000
> +#define CR50_NOIRQ_ACCESS_DELAY			msecs_to_jiffies(2)
> +#define CR50_READY_IRQ_TIMEOUT			msecs_to_jiffies(TPM2_TIMEOUT_A)
> +#define CR50_FLOW_CONTROL			msecs_to_jiffies(TPM2_TIMEOUT_A)
> +#define MAX_IRQ_CONFIRMATION_ATTEMPTS		3
> +
> +#define TPM_CR50_FW_VER(l)			(0x0f90 | ((l) << 12))
> +#define TPM_CR50_MAX_FW_VER_LEN			64
> +
> +struct cr50_spi_phy {
> +	struct tpm_tis_spi_phy spi_phy;
> +
> +	struct mutex time_track_mutex;
> +	unsigned long last_access;
> +	unsigned long wake_after;
> +
> +	unsigned long access_delay;
> +
> +	unsigned int irq_confirmation_attempt;
> +	bool irq_needs_confirmation;
> +	bool irq_confirmed;
> +};
> +
> +static inline struct cr50_spi_phy *to_cr50_spi_phy(struct tpm_tis_spi_phy *phy)
> +{
> +	return container_of(phy, struct cr50_spi_phy, spi_phy);
> +}
> +
> +/*
> + * The cr50 interrupt handler just signals waiting threads that the
> + * interrupt was asserted.  It does not do any processing triggered
> + * by interrupts but is instead used to avoid fixed delays.
> + */
> +static irqreturn_t cr50_spi_irq_handler(int dummy, void *dev_id)
> +{
> +	struct cr50_spi_phy *cr50_phy = dev_id;
> +
> +	cr50_phy->irq_confirmed = true;
> +	complete(&cr50_phy->spi_phy.ready);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/*
> + * Cr50 needs to have at least some delay between consecutive
> + * transactions. Make sure we wait.
> + */
> +static void cr50_ensure_access_delay(struct cr50_spi_phy *phy)
> +{
> +	unsigned long allowed_access = phy->last_access + phy->access_delay;
> +	unsigned long time_now = jiffies;
> +	struct device *dev = &phy->spi_phy.spi_device->dev;
> +
> +	/*
> +	 * Note: There is a small chance, if Cr50 is not accessed in a few days,
> +	 * that time_in_range will not provide the correct result after the wrap
> +	 * around for jiffies. In this case, we'll have an unneeded short delay,
> +	 * which is fine.
> +	 */
> +	if (time_in_range_open(time_now, phy->last_access, allowed_access)) {
> +		unsigned long remaining, timeout = allowed_access - time_now;
> +
> +		remaining = wait_for_completion_timeout(&phy->spi_phy.ready,
> +							timeout);
> +		if (!remaining && phy->irq_confirmed)
> +			dev_warn(dev, "Timeout waiting for TPM ready IRQ\n");
> +	}
> +
> +	if (phy->irq_needs_confirmation) {
> +		unsigned int attempt = ++phy->irq_confirmation_attempt;
> +
> +		if (phy->irq_confirmed) {
> +			phy->irq_needs_confirmation = false;
> +			phy->access_delay = CR50_READY_IRQ_TIMEOUT;
> +			dev_info(dev, "TPM ready IRQ confirmed on attempt %u\n",
> +				 attempt);
> +		} else if (attempt > MAX_IRQ_CONFIRMATION_ATTEMPTS) {
> +			phy->irq_needs_confirmation = false;
> +			dev_warn(dev, "IRQ not confirmed - will use delays\n");
> +		}
> +	}
> +}
> +
> +/*
> + * Cr50 might go to sleep if there is no SPI activity for some time and
> + * miss the first few bits/bytes on the bus. In such case, wake it up
> + * by asserting CS and give it time to start up.
> + */
> +static bool cr50_needs_waking(struct cr50_spi_phy *phy)
> +{
> +	/*
> +	 * Note: There is a small chance, if Cr50 is not accessed in a few days,
> +	 * that time_in_range will not provide the correct result after the wrap
> +	 * around for jiffies. In this case, we'll probably timeout or read
> +	 * incorrect value from TPM_STS and just retry the operation.
> +	 */
> +	return !time_in_range_open(jiffies, phy->last_access, phy->wake_after);
> +}
> +
> +static void cr50_wake_if_needed(struct cr50_spi_phy *cr50_phy)
> +{
> +	struct tpm_tis_spi_phy *phy = &cr50_phy->spi_phy;
> +
> +	if (cr50_needs_waking(cr50_phy)) {
> +		/* Assert CS, wait 1 msec, deassert CS */
> +		struct spi_transfer spi_cs_wake = { .delay_usecs = 1000 };
> +
> +		spi_sync_transfer(phy->spi_device, &spi_cs_wake, 1);
> +		/* Wait for it to fully wake */
> +		usleep_range(CR50_WAKE_START_DELAY_USEC,
> +			     CR50_WAKE_START_DELAY_USEC * 2);
> +	}
> +
> +	/* Reset the time when we need to wake Cr50 again */
> +	cr50_phy->wake_after = jiffies + msecs_to_jiffies(CR50_SLEEP_DELAY_MSEC);
> +}
> +
> +/*
> + * Flow control: clock the bus and wait for cr50 to set LSB before
> + * sending/receiving data. TCG PTP spec allows it to happen during
> + * the last byte of header, but cr50 never does that in practice,
> + * and earlier versions had a bug when it was set too early, so don't
> + * check for it during header transfer.
> + */
> +static int cr50_spi_flow_control(struct tpm_tis_spi_phy *phy,
> +				 struct spi_transfer *spi_xfer)
> +{
> +	struct device *dev = &phy->spi_device->dev;
> +	unsigned long timeout = jiffies + CR50_FLOW_CONTROL;
> +	struct spi_message m;
> +	int ret;
> +
> +	spi_xfer->len = 1;
> +
> +	do {
> +		spi_message_init(&m);
> +		spi_message_add_tail(spi_xfer, &m);
> +		ret = spi_sync_locked(phy->spi_device, &m);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (time_after(jiffies, timeout)) {
> +			dev_warn(dev, "Timeout during flow control\n");
> +			return -EBUSY;
> +		}
> +	} while (!(phy->iobuf[0] & 0x01));
> +
> +	return 0;
> +}
> +
> +static int tpm_tis_spi_cr50_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
> +				     u8 *in, const u8 *out)
> +{
> +	struct tpm_tis_spi_phy *phy = to_tpm_tis_spi_phy(data);
> +	struct cr50_spi_phy *cr50_phy = to_cr50_spi_phy(phy);
> +	int ret;
> +
> +	mutex_lock(&cr50_phy->time_track_mutex);
> +	/*
> +	 * Do this outside of spi_bus_lock in case cr50 is not the
> +	 * only device on that spi bus.
> +	 */
> +	cr50_ensure_access_delay(cr50_phy);
> +	cr50_wake_if_needed(cr50_phy);
> +
> +	ret = tpm_tis_spi_transfer(data, addr, len, in, out);
> +
> +	cr50_phy->last_access = jiffies;
> +	mutex_unlock(&cr50_phy->time_track_mutex);
> +
> +	return ret;
> +}
> +
> +static int tpm_tis_spi_cr50_read_bytes(struct tpm_tis_data *data, u32 addr,
> +				       u16 len, u8 *result)
> +{
> +	return tpm_tis_spi_cr50_transfer(data, addr, len, result, NULL);
> +}
> +
> +static int tpm_tis_spi_cr50_write_bytes(struct tpm_tis_data *data, u32 addr,
> +					u16 len, const u8 *value)
> +{
> +	return tpm_tis_spi_cr50_transfer(data, addr, len, NULL, value);
> +}
> +
> +static const struct tpm_tis_phy_ops tpm_spi_cr50_phy_ops = {
> +	.read_bytes = tpm_tis_spi_cr50_read_bytes,
> +	.write_bytes = tpm_tis_spi_cr50_write_bytes,
> +	.read16 = tpm_tis_spi_read16,
> +	.read32 = tpm_tis_spi_read32,
> +	.write32 = tpm_tis_spi_write32,
> +};
> +
> +static void cr50_print_fw_version(struct tpm_tis_data *data)
> +{
> +	struct tpm_tis_spi_phy *phy = to_tpm_tis_spi_phy(data);
> +	int i, len = 0;
> +	char fw_ver[TPM_CR50_MAX_FW_VER_LEN + 1];
> +	char fw_ver_block[4];
> +
> +	/*
> +	 * Write anything to TPM_CR50_FW_VER to start from the beginning
> +	 * of the version string
> +	 */
> +	tpm_tis_write8(data, TPM_CR50_FW_VER(data->locality), 0);
> +
> +	/* Read the string, 4 bytes at a time, until we get '\0' */
> +	do {
> +		tpm_tis_read_bytes(data, TPM_CR50_FW_VER(data->locality), 4,
> +				   fw_ver_block);
> +		for (i = 0; i < 4 && fw_ver_block[i]; ++len, ++i)
> +			fw_ver[len] = fw_ver_block[i];
> +	} while (i == 4 && len < TPM_CR50_MAX_FW_VER_LEN);
> +	fw_ver[len] = '\0';
> +
> +	dev_info(&phy->spi_device->dev, "Cr50 firmware version: %s\n", fw_ver);
> +}
> +
> +int cr50_spi_probe(struct spi_device *spi)
> +{
> +	struct tpm_tis_spi_phy *phy;
> +	struct cr50_spi_phy *cr50_phy;
> +	int ret;
> +	struct tpm_chip *chip;
> +
> +	cr50_phy = devm_kzalloc(&spi->dev, sizeof(*cr50_phy), GFP_KERNEL);
> +	if (!cr50_phy)
> +		return -ENOMEM;
> +
> +	phy = &cr50_phy->spi_phy;
> +	phy->flow_control = cr50_spi_flow_control;
> +	phy->is_cr50 = true;
> +
> +	cr50_phy->access_delay = CR50_NOIRQ_ACCESS_DELAY;
> +
> +	mutex_init(&cr50_phy->time_track_mutex);
> +	cr50_phy->wake_after = jiffies;
> +	cr50_phy->last_access = jiffies;
> +
> +	if (spi->irq > 0) {
> +		ret = devm_request_irq(&spi->dev, spi->irq, cr50_spi_irq_handler,
> +				       IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +				       "cr50_spi", cr50_phy);
> +		if (ret < 0) {
> +			if (ret == -EPROBE_DEFER)
> +				return ret;
> +			dev_warn(&spi->dev, "Requesting IRQ %d failed: %d\n",
> +				 spi->irq, ret);
> +			/*
> +			 * This is not fatal, the driver will fall back to
> +			 * delays automatically, since ready will never
> +			 * be completed without a registered irq handler.
> +			 * So, just fall through.
> +			 */
> +		} else {
> +			/*
> +			 * IRQ requested, let's verify that it is actually
> +			 * triggered, before relying on it.
> +			 */
> +			cr50_phy->irq_needs_confirmation = true;
> +		}
> +	} else {
> +		dev_warn(&spi->dev,
> +			 "No IRQ - will use delays between transactions.\n");
> +	}
> +
> +	ret = tpm_tis_spi_init(spi, phy, -1, &tpm_spi_cr50_phy_ops);
> +	if (ret)
> +		return ret;
> +
> +	cr50_print_fw_version(&phy->priv);
> +
> +	chip = dev_get_drvdata(&spi->dev);
> +	chip->flags |= TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED;
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +int tpm_tis_spi_resume(struct device *dev)
> +{
> +	struct tpm_chip *chip = dev_get_drvdata(dev);
> +	struct tpm_tis_data *data = dev_get_drvdata(&chip->dev);
> +	struct tpm_tis_spi_phy *phy = to_tpm_tis_spi_phy(data);
> +	struct cr50_spi_phy *cr50_phy;
> +
> +	if (phy->is_cr50) {
> +		cr50_phy = to_cr50_spi_phy(phy);
> +		/*
> +		 * Jiffies not increased during suspend, so we need to reset
> +		 * the time to wake Cr50 after resume.
> +		 */
> +		cr50_phy->wake_after = jiffies;
> +	}

To simplify the code I would just put also wake_after to
tpm_tis_spi_phy.

> +
> +	return tpm_tis_resume(dev);
> +}
> +#endif
> diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_spi.c
> index b3ed85671dd8..fdac842a61ed 100644
> --- a/drivers/char/tpm/tpm_tis_spi.c
> +++ b/drivers/char/tpm/tpm_tis_spi.c
> @@ -20,6 +20,7 @@
>   * Dorn and Kyleen Hall and Jarko Sakkinnen.
>   */
>  
> +#include <linux/completion.h>
>  #include <linux/init.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
> @@ -31,27 +32,16 @@
>  
>  #include <linux/spi/spi.h>
>  #include <linux/gpio.h>
> +#include <linux/of_device.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_gpio.h>
>  #include <linux/tpm.h>
>  #include "tpm.h"
>  #include "tpm_tis_core.h"
> +#include "tpm_tis_spi.h"
>  
>  #define MAX_SPI_FRAMESIZE 64
>  
> -struct tpm_tis_spi_phy {
> -	struct tpm_tis_data priv;
> -	struct spi_device *spi_device;
> -	int (*flow_control)(struct tpm_tis_spi_phy *phy,
> -			    struct spi_transfer *xfer);
> -	u8 *iobuf;
> -};
> -
> -static inline struct tpm_tis_spi_phy *to_tpm_tis_spi_phy(struct tpm_tis_data *data)
> -{
> -	return container_of(data, struct tpm_tis_spi_phy, priv);
> -}
> -
>  /*
>   * TCG SPI flow control is documented in section 6.4 of the spec[1]. In short,
>   * keep trying to read from the device until MISO goes high indicating the
> @@ -87,8 +77,8 @@ static int tpm_tis_spi_flow_control(struct tpm_tis_spi_phy *phy,
>  	return 0;
>  }
>  
> -static int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
> -				u8 *in, const u8 *out)
> +int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
> +			 u8 *in, const u8 *out)
>  {
>  	struct tpm_tis_spi_phy *phy = to_tpm_tis_spi_phy(data);
>  	int ret = 0;
> @@ -136,6 +126,7 @@ static int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
>  
>  		spi_message_init(&m);
>  		spi_message_add_tail(&spi_xfer, &m);
> +		reinit_completion(&phy->ready);
>  		ret = spi_sync_locked(phy->spi_device, &m);
>  		if (ret < 0)
>  			goto exit;
> @@ -165,7 +156,7 @@ static int tpm_tis_spi_write_bytes(struct tpm_tis_data *data, u32 addr,
>  	return tpm_tis_spi_transfer(data, addr, len, NULL, value);
>  }
>  
> -static int tpm_tis_spi_read16(struct tpm_tis_data *data, u32 addr, u16 *result)
> +int tpm_tis_spi_read16(struct tpm_tis_data *data, u32 addr, u16 *result)
>  {
>  	__le16 result_le;
>  	int rc;
> @@ -178,7 +169,7 @@ static int tpm_tis_spi_read16(struct tpm_tis_data *data, u32 addr, u16 *result)
>  	return rc;
>  }
>  
> -static int tpm_tis_spi_read32(struct tpm_tis_data *data, u32 addr, u32 *result)
> +int tpm_tis_spi_read32(struct tpm_tis_data *data, u32 addr, u32 *result)
>  {
>  	__le32 result_le;
>  	int rc;
> @@ -191,7 +182,7 @@ static int tpm_tis_spi_read32(struct tpm_tis_data *data, u32 addr, u32 *result)
>  	return rc;
>  }
>  
> -static int tpm_tis_spi_write32(struct tpm_tis_data *data, u32 addr, u32 value)
> +int tpm_tis_spi_write32(struct tpm_tis_data *data, u32 addr, u32 value)
>  {
>  	__le32 value_le;
>  	int rc;
> @@ -203,6 +194,19 @@ static int tpm_tis_spi_write32(struct tpm_tis_data *data, u32 addr, u32 value)
>  	return rc;
>  }
>  
> +int tpm_tis_spi_init(struct spi_device *spi, struct tpm_tis_spi_phy *phy,
> +		     int irq, const struct tpm_tis_phy_ops *phy_ops)
> +{
> +	phy->iobuf = devm_kmalloc(&spi->dev, MAX_SPI_FRAMESIZE, GFP_KERNEL);
> +	if (!phy->iobuf)
> +		return -ENOMEM;
> +
> +	init_completion(&phy->ready);
> +	phy->spi_device = spi;
> +
> +	return tpm_tis_core_init(&spi->dev, &phy->priv, irq, phy_ops, NULL);
> +}
> +
>  static const struct tpm_tis_phy_ops tpm_spi_phy_ops = {
>  	.read_bytes = tpm_tis_spi_read_bytes,
>  	.write_bytes = tpm_tis_spi_write_bytes,
> @@ -215,17 +219,18 @@ static int tpm_tis_spi_probe(struct spi_device *dev)
>  {
>  	struct tpm_tis_spi_phy *phy;
>  	int irq;
> +	struct device_node *np = dev->dev.of_node;
> +	const struct spi_device_id *spi_dev_id = spi_get_device_id(dev);
> +
> +	if (of_device_is_compatible(np, "google,cr50") ||
> +	    (spi_dev_id && spi_dev_id->driver_data == TPM_IS_CR50))
> +		return cr50_spi_probe(dev);

You could keep pointers to probes directly in driver_data.

>  
>  	phy = devm_kzalloc(&dev->dev, sizeof(struct tpm_tis_spi_phy),
>  			   GFP_KERNEL);
>  	if (!phy)
>  		return -ENOMEM;
>  
> -	phy->spi_device = dev;
> -
> -	phy->iobuf = devm_kmalloc(&dev->dev, MAX_SPI_FRAMESIZE, GFP_KERNEL);
> -	if (!phy->iobuf)
> -		return -ENOMEM;
>  	phy->flow_control = tpm_tis_spi_flow_control;
>  
>  	/* If the SPI device has an IRQ then use that */
> @@ -234,11 +239,10 @@ static int tpm_tis_spi_probe(struct spi_device *dev)
>  	else
>  		irq = -1;
>  
> -	return tpm_tis_core_init(&dev->dev, &phy->priv, irq, &tpm_spi_phy_ops,
> -				 NULL);
> +	return tpm_tis_spi_init(dev, phy, irq, &tpm_spi_phy_ops);
>  }
>  
> -static SIMPLE_DEV_PM_OPS(tpm_tis_pm, tpm_pm_suspend, tpm_tis_resume);
> +static SIMPLE_DEV_PM_OPS(tpm_tis_pm, tpm_pm_suspend, tpm_tis_spi_resume);
>  
>  static int tpm_tis_spi_remove(struct spi_device *dev)
>  {
> @@ -251,6 +255,7 @@ static int tpm_tis_spi_remove(struct spi_device *dev)
>  
>  static const struct spi_device_id tpm_tis_spi_id[] = {
>  	{"tpm_tis_spi", 0},
> +	{"cr50", TPM_IS_CR50},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(spi, tpm_tis_spi_id);
> @@ -259,6 +264,7 @@ static const struct of_device_id of_tis_spi_match[] = {
>  	{ .compatible = "st,st33htpm-spi", },
>  	{ .compatible = "infineon,slb9670", },
>  	{ .compatible = "tcg,tpm_tis-spi", },
> +	{ .compatible = "google,cr50", },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, of_tis_spi_match);
> diff --git a/drivers/char/tpm/tpm_tis_spi.h b/drivers/char/tpm/tpm_tis_spi.h
> new file mode 100644
> index 000000000000..6eab998fa905
> --- /dev/null
> +++ b/drivers/char/tpm/tpm_tis_spi.h
> @@ -0,0 +1,54 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2015 Infineon Technologies AG
> + * Copyright (C) 2016 STMicroelectronics SAS
> + */
> +
> +#ifndef TPM_TIS_SPI_H
> +#define TPM_TIS_SPI_H
> +
> +#include "tpm_tis_core.h"
> +
> +#define TPM_IS_CR50	1
> +
> +struct tpm_tis_spi_phy {
> +	struct tpm_tis_data priv;
> +	struct spi_device *spi_device;
> +	int (*flow_control)(struct tpm_tis_spi_phy *phy,
> +			     struct spi_transfer *xfer);
> +	struct completion ready;
> +	bool is_cr50;
> +
> +	u8 *iobuf;
> +};
> +
> +static inline struct tpm_tis_spi_phy *to_tpm_tis_spi_phy(struct tpm_tis_data *data)
> +{
> +	return container_of(data, struct tpm_tis_spi_phy, priv);
> +}
> +
> +extern int tpm_tis_spi_init(struct spi_device *spi, struct tpm_tis_spi_phy *phy,
> +			    int irq, const struct tpm_tis_phy_ops *phy_ops);
> +
> +extern int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
> +				u8 *in, const u8 *out);
> +
> +extern int tpm_tis_spi_read16(struct tpm_tis_data *data, u32 addr, u16 *result);
> +extern int tpm_tis_spi_read32(struct tpm_tis_data *data, u32 addr, u32 *result);
> +extern int tpm_tis_spi_write32(struct tpm_tis_data *data, u32 addr, u32 value);
> +
> +#ifdef CONFIG_TCG_CR50_SPI
> +extern int cr50_spi_probe(struct spi_device *spi);
> +#else
> +static inline int cr50_spi_probe(struct spi_device *spi) { return -ENODEV; }
> +#endif
> +
> +#ifdef CONFIG_PM_SLEEP
> +#ifdef CONFIG_TCG_CR50_SPI
> +extern int tpm_tis_spi_resume(struct device *dev);
> +#else
> +#define tpm_tis_spi_resume tpm_tis_resume
> +#endif
> +#endif
> +
> +#endif
> -- 
> Sent by a computer through tubes
> 

/Jarkko
