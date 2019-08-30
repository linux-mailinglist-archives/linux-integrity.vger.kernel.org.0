Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8E4A3A6B
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Aug 2019 17:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfH3Pd7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Aug 2019 11:33:59 -0400
Received: from gloria.sntech.de ([185.11.138.130]:40936 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727859AbfH3Pd6 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Aug 2019 11:33:58 -0400
Received: from [104.132.1.107] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1i3iuN-0005N8-Kn; Fri, 30 Aug 2019 17:33:51 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andrey Pronin <apronin@chromium.org>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: Re: [PATCH v6 4/4] tpm: tpm_tis_spi: Support cr50 devices
Date:   Fri, 30 Aug 2019 17:33:48 +0200
Message-ID: <2926868.n5I8ZQlzTx@phil>
In-Reply-To: <20190829224110.91103-5-swboyd@chromium.org>
References: <20190829224110.91103-1-swboyd@chromium.org> <20190829224110.91103-5-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Am Freitag, 30. August 2019, 00:41:10 CEST schrieb Stephen Boyd:
> From: Andrey Pronin <apronin@chromium.org>
> 
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

This variant breaks building the tpm as a module:


WARNING: modpost: missing MODULE_LICENSE() in drivers/char/tpm/cr50_spi.o
see include/linux/module.h for more information
ERROR: "tpm_tis_spi_write32" [drivers/char/tpm/cr50_spi.ko] undefined!
ERROR: "tpm_tis_spi_read32" [drivers/char/tpm/cr50_spi.ko] undefined!
ERROR: "tpm_tis_spi_read16" [drivers/char/tpm/cr50_spi.ko] undefined!
ERROR: "tpm_tis_spi_init" [drivers/char/tpm/cr50_spi.ko] undefined!
ERROR: "tpm_tis_spi_transfer" [drivers/char/tpm/cr50_spi.ko] undefined!
ERROR: "tpm_tis_spi_resume" [drivers/char/tpm/tpm_tis_spi.ko] undefined!
ERROR: "cr50_spi_probe" [drivers/char/tpm/tpm_tis_spi.ko] undefined!
make[2]: *** [../scripts/Makefile.modpost:103: modules-modpost] Fehler 1
make[1]: *** [/home/devel/hstuebner/00_git-repos/linux-rockchip/Makefile:1302: modules] Fehler 2
make[1]: Verzeichnis „/home/devel/hstuebner/00_git-repos/linux-rockchip/_build-arm64“ wird verlassen
make: *** [Makefile:179: sub-make] Fehler 2


After adding a dummy MODULE_LICENSE I end up with:

ERROR: "tpm_tis_spi_write32" [drivers/char/tpm/cr50_spi.ko] undefined!
ERROR: "tpm_tis_spi_read32" [drivers/char/tpm/cr50_spi.ko] undefined!
ERROR: "tpm_tis_spi_read16" [drivers/char/tpm/cr50_spi.ko] undefined!
ERROR: "tpm_tis_spi_init" [drivers/char/tpm/cr50_spi.ko] undefined!
ERROR: "tpm_tis_spi_transfer" [drivers/char/tpm/cr50_spi.ko] undefined!
ERROR: "tpm_tis_spi_resume" [drivers/char/tpm/tpm_tis_spi.ko] undefined!
ERROR: "cr50_spi_probe" [drivers/char/tpm/tpm_tis_spi.ko] undefined!


So building things as modules this way clearly is not working. Going back
to the previous approach makes the module happy again, aka:

diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
index 6ff135d6f008..477fcddbff8c 100644
--- a/drivers/char/tpm/Makefile
+++ b/drivers/char/tpm/Makefile
@@ -21,7 +21,9 @@ tpm-$(CONFIG_EFI) += eventlog/efi.o
 tpm-$(CONFIG_OF) += eventlog/of.o
 obj-$(CONFIG_TCG_TIS_CORE) += tpm_tis_core.o
 obj-$(CONFIG_TCG_TIS) += tpm_tis.o
-obj-$(CONFIG_TCG_TIS_SPI) += tpm_tis_spi.o cr50_spi.o
+obj-$(CONFIG_TCG_TIS_SPI) += tpm_tis_spi_mod.o
+tpm_tis_spi_mod-y := tpm_tis_spi.o
+tpm_tis_spi_mod-y += cr50_spi.o
 obj-$(CONFIG_TCG_TIS_I2C_ATMEL) += tpm_i2c_atmel.o
 obj-$(CONFIG_TCG_TIS_I2C_INFINEON) += tpm_i2c_infineon.o
 obj-$(CONFIG_TCG_TIS_I2C_NUVOTON) += tpm_i2c_nuvoton.o




> ---
>  drivers/char/tpm/Makefile      |   2 +-
>  drivers/char/tpm/cr50_spi.c    | 321 +++++++++++++++++++++++++++++++++
>  drivers/char/tpm/tpm_tis_spi.c |  78 ++++----
>  drivers/char/tpm/tpm_tis_spi.h |  46 +++++
>  4 files changed, 415 insertions(+), 32 deletions(-)
>  create mode 100644 drivers/char/tpm/cr50_spi.c
>  create mode 100644 drivers/char/tpm/tpm_tis_spi.h
> 
> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> index a01c4cab902a..6ff135d6f008 100644
> --- a/drivers/char/tpm/Makefile
> +++ b/drivers/char/tpm/Makefile
> @@ -21,7 +21,7 @@ tpm-$(CONFIG_EFI) += eventlog/efi.o
>  tpm-$(CONFIG_OF) += eventlog/of.o
>  obj-$(CONFIG_TCG_TIS_CORE) += tpm_tis_core.o
>  obj-$(CONFIG_TCG_TIS) += tpm_tis.o
> -obj-$(CONFIG_TCG_TIS_SPI) += tpm_tis_spi.o
> +obj-$(CONFIG_TCG_TIS_SPI) += tpm_tis_spi.o cr50_spi.o
>  obj-$(CONFIG_TCG_TIS_I2C_ATMEL) += tpm_i2c_atmel.o
>  obj-$(CONFIG_TCG_TIS_I2C_INFINEON) += tpm_i2c_infineon.o
>  obj-$(CONFIG_TCG_TIS_I2C_NUVOTON) += tpm_i2c_nuvoton.o
> diff --git a/drivers/char/tpm/cr50_spi.c b/drivers/char/tpm/cr50_spi.c
> new file mode 100644
> index 000000000000..187a023c2556
> --- /dev/null
> +++ b/drivers/char/tpm/cr50_spi.c
> @@ -0,0 +1,321 @@
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
> +	return !time_in_range_open(jiffies, phy->last_access,
> +				   phy->spi_phy.wake_after);
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
> +	phy->wake_after = jiffies + msecs_to_jiffies(CR50_SLEEP_DELAY_MSEC);
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
> +	phy->wake_after = jiffies;
> +	init_completion(&phy->ready);
> +
> +	cr50_phy->access_delay = CR50_NOIRQ_ACCESS_DELAY;
> +	cr50_phy->last_access = jiffies;
> +	mutex_init(&cr50_phy->time_track_mutex);
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
> +	/*
> +	 * Jiffies not increased during suspend, so we need to reset
> +	 * the time to wake Cr50 after resume.
> +	 */
> +	phy->wake_after = jiffies;
> +
> +	return tpm_tis_resume(dev);
> +}
> +#endif
> diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_spi.c
> index b3ed85671dd8..5e4253e7c080 100644
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
> @@ -203,6 +194,18 @@ static int tpm_tis_spi_write32(struct tpm_tis_data *data, u32 addr, u32 value)
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
> +	phy->spi_device = spi;
> +
> +	return tpm_tis_core_init(&spi->dev, &phy->priv, irq, phy_ops, NULL);
> +}
> +
>  static const struct tpm_tis_phy_ops tpm_spi_phy_ops = {
>  	.read_bytes = tpm_tis_spi_read_bytes,
>  	.write_bytes = tpm_tis_spi_write_bytes,
> @@ -221,11 +224,6 @@ static int tpm_tis_spi_probe(struct spi_device *dev)
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
> @@ -234,11 +232,27 @@ static int tpm_tis_spi_probe(struct spi_device *dev)
>  	else
>  		irq = -1;
>  
> -	return tpm_tis_core_init(&dev->dev, &phy->priv, irq, &tpm_spi_phy_ops,
> -				 NULL);
> +	init_completion(&phy->ready);
> +	return tpm_tis_spi_init(dev, phy, irq, &tpm_spi_phy_ops);
> +}
> +
> +typedef int (*tpm_tis_spi_probe_func)(struct spi_device *);
> +
> +static int tpm_tis_spi_driver_probe(struct spi_device *spi)
> +{
> +	const struct spi_device_id *spi_dev_id = spi_get_device_id(spi);
> +	tpm_tis_spi_probe_func probe_func;
> +
> +	probe_func = of_device_get_match_data(&spi->dev);
> +	if (!probe_func && spi_dev_id)
> +		probe_func = (tpm_tis_spi_probe_func)spi_dev_id->driver_data;
> +	if (!probe_func)
> +		return -ENODEV;
> +
> +	return probe_func(spi);
>  }
>  
> -static SIMPLE_DEV_PM_OPS(tpm_tis_pm, tpm_pm_suspend, tpm_tis_resume);
> +static SIMPLE_DEV_PM_OPS(tpm_tis_pm, tpm_pm_suspend, tpm_tis_spi_resume);
>  
>  static int tpm_tis_spi_remove(struct spi_device *dev)
>  {
> @@ -250,15 +264,17 @@ static int tpm_tis_spi_remove(struct spi_device *dev)
>  }
>  
>  static const struct spi_device_id tpm_tis_spi_id[] = {
> -	{"tpm_tis_spi", 0},
> +	{ "tpm_tis_spi", (unsigned long)tpm_tis_spi_probe },
> +	{ "cr50", (unsigned long)cr50_spi_probe },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(spi, tpm_tis_spi_id);
>  
>  static const struct of_device_id of_tis_spi_match[] = {
> -	{ .compatible = "st,st33htpm-spi", },
> -	{ .compatible = "infineon,slb9670", },
> -	{ .compatible = "tcg,tpm_tis-spi", },
> +	{ .compatible = "st,st33htpm-spi", .data = tpm_tis_spi_probe },
> +	{ .compatible = "infineon,slb9670", .data = tpm_tis_spi_probe },
> +	{ .compatible = "tcg,tpm_tis-spi", .data = tpm_tis_spi_probe },
> +	{ .compatible = "google,cr50", .data = cr50_spi_probe },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, of_tis_spi_match);
> @@ -277,7 +293,7 @@ static struct spi_driver tpm_tis_spi_driver = {
>  		.of_match_table = of_match_ptr(of_tis_spi_match),
>  		.acpi_match_table = ACPI_PTR(acpi_tis_spi_match),
>  	},
> -	.probe = tpm_tis_spi_probe,
> +	.probe = tpm_tis_spi_driver_probe,
>  	.remove = tpm_tis_spi_remove,
>  	.id_table = tpm_tis_spi_id,
>  };
> diff --git a/drivers/char/tpm/tpm_tis_spi.h b/drivers/char/tpm/tpm_tis_spi.h
> new file mode 100644
> index 000000000000..afb0e9861c4f
> --- /dev/null
> +++ b/drivers/char/tpm/tpm_tis_spi.h
> @@ -0,0 +1,46 @@
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
> +struct tpm_tis_spi_phy {
> +	struct tpm_tis_data priv;
> +	struct spi_device *spi_device;
> +	int (*flow_control)(struct tpm_tis_spi_phy *phy,
> +			     struct spi_transfer *xfer);
> +	struct completion ready;
> +	unsigned long wake_after;
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
> +extern int cr50_spi_probe(struct spi_device *spi);
> +
> +#ifdef CONFIG_PM_SLEEP
> +extern int tpm_tis_spi_resume(struct device *dev);
> +#else
> +#define tpm_tis_spi_resume	NULL
> +#endif
> +
> +#endif
> 




