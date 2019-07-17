Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E74276BC0C
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2019 14:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbfGQMAN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jul 2019 08:00:13 -0400
Received: from smtp2.infineon.com ([217.10.52.18]:1666 "EHLO
        smtp2.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfGQMAM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jul 2019 08:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1563364808; x=1594900808;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=1zZdHMCY+28AHk7CXx43l8XV9oj34+quIUG13fqlnlM=;
  b=Hzm8GM/vxckmmkwGVGC1SENwH0oGgHlmSwobtc9lkyh47Nlewl51ehe1
   hZR86qHIg7bYBajR2bzjWq9T2sdTidupHXwmKCCFrLdwWa0a/ScXKcXwW
   CbtzBHfd0/xC4gT2gV986RnKVMQhC0JgnepXuEsN09+F/Q5ceg9w8fUSY
   w=;
IronPort-SDR: NnPH6BZt+ve+kIBECjdiM2SRwY6x+ea281gScrdvSZx8Lx5QMQfoCI83RDyi7STOmgUuwoHtjH
 J62bSesQfSzA==
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6000,8403,9320"; a="6777095"
X-IronPort-AV: E=Sophos;i="5.64,274,1559512800"; 
   d="scan'208";a="6777095"
Received: from unknown (HELO mucxv002.muc.infineon.com) ([172.23.11.17])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2019 14:00:07 +0200
Received: from MUCSE708.infineon.com (MUCSE708.infineon.com [172.23.7.82])
        by mucxv002.muc.infineon.com (Postfix) with ESMTPS;
        Wed, 17 Jul 2019 14:00:07 +0200 (CEST)
Received: from [10.154.32.63] (172.23.8.247) by MUCSE708.infineon.com
 (172.23.7.82) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.1591.10; Wed, 17
 Jul 2019 14:00:06 +0200
Subject: Re: [PATCH v2 5/6] tpm: add driver for cr50 on SPI
To:     Stephen Boyd <swboyd@chromium.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
CC:     Andrey Pronin <apronin@chromium.org>,
        <linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-integrity@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
References: <20190716224518.62556-1-swboyd@chromium.org>
 <20190716224518.62556-6-swboyd@chromium.org>
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
Message-ID: <f824e3ab-ae2f-8c2f-549a-16569b10966e@infineon.com>
Date:   Wed, 17 Jul 2019 14:00:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190716224518.62556-6-swboyd@chromium.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE705.infineon.com (172.23.7.79) To
 MUCSE708.infineon.com (172.23.7.82)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 17.07.2019 00:45, Stephen Boyd wrote:
> From: Andrey Pronin <apronin@chromium.org>
> 
> Add TPM2.0 PTP FIFO compatible SPI interface for chips with Cr50
> firmware. The firmware running on the currently supported H1
> Secure Microcontroller requires a special driver to handle its
> specifics:
>   - need to ensure a certain delay between spi transactions, or else
>     the chip may miss some part of the next transaction;
>   - if there is no spi activity for some time, it may go to sleep,
>     and needs to be waken up before sending further commands;
>   - access to vendor-specific registers.
> 
> Signed-off-by: Andrey Pronin <apronin@chromium.org>
> [swboyd@chromium.org: Replace boilerplate with SPDX tag, drop
> suspended bit and remove ifdef checks in cr50.h, push tpm.h
> include into cr50.c]
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>   drivers/char/tpm/Kconfig    |  16 ++
>   drivers/char/tpm/Makefile   |   2 +
>   drivers/char/tpm/cr50.c     |  33 +++
>   drivers/char/tpm/cr50.h     |  15 ++
>   drivers/char/tpm/cr50_spi.c | 450 ++++++++++++++++++++++++++++++++++++
>   5 files changed, 516 insertions(+)
>   create mode 100644 drivers/char/tpm/cr50.c
>   create mode 100644 drivers/char/tpm/cr50.h
>   create mode 100644 drivers/char/tpm/cr50_spi.c
> 
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index 88a3c06fc153..b7028bfa6f87 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -114,6 +114,22 @@ config TCG_ATMEL
>   	  will be accessible from within Linux.  To compile this driver
>   	  as a module, choose M here; the module will be called tpm_atmel.
>   
> +config TCG_CR50
> +	bool
> +	---help---
> +	  Common routines shared by drivers for Cr50-based devices.
> +

Is it a common pattern to add config options that are not useful on 
their own? When would I ever enable TCG_CR50 without also enabling 
TCG_CR50_SPI? Why can't you just use TCG_CR50_SPI for everything?

> +config TCG_CR50_SPI
> +	tristate "Cr50 SPI Interface"
> +	depends on SPI
> +	select TCG_TIS_CORE
> +	select TCG_CR50
> +	---help---
> +	  If you have a H1 secure module running Cr50 firmware on SPI bus,
> +	  say Yes and it will be accessible from within Linux. To compile
> +	  this driver as a module, choose M here; the module will be called
> +	  cr50_spi.
> +
>   config TCG_INFINEON
>   	tristate "Infineon Technologies TPM Interface"
>   	depends on PNP
> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> index a01c4cab902a..4e89538c73c8 100644
> --- a/drivers/char/tpm/Makefile
> +++ b/drivers/char/tpm/Makefile
> @@ -27,6 +27,8 @@ obj-$(CONFIG_TCG_TIS_I2C_INFINEON) += tpm_i2c_infineon.o
>   obj-$(CONFIG_TCG_TIS_I2C_NUVOTON) += tpm_i2c_nuvoton.o
>   obj-$(CONFIG_TCG_NSC) += tpm_nsc.o
>   obj-$(CONFIG_TCG_ATMEL) += tpm_atmel.o
> +obj-$(CONFIG_TCG_CR50) += cr50.o
> +obj-$(CONFIG_TCG_CR50_SPI) += cr50_spi.o
>   obj-$(CONFIG_TCG_INFINEON) += tpm_infineon.o
>   obj-$(CONFIG_TCG_IBMVTPM) += tpm_ibmvtpm.o
>   obj-$(CONFIG_TCG_TIS_ST33ZP24) += st33zp24/
> diff --git a/drivers/char/tpm/cr50.c b/drivers/char/tpm/cr50.c
> new file mode 100644
> index 000000000000..8c83ec25f8e1
> --- /dev/null
> +++ b/drivers/char/tpm/cr50.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2016 Google Inc.
> + */
> +
> +/*
> + * This file contains common code for devices with Cr50 firmware.
> + */
> +
> +#include <linux/export.h>
> +#include <linux/suspend.h>
> +#include "cr50.h"
> +#include "tpm.h"
> +
> +#ifdef CONFIG_PM_SLEEP
> +int cr50_resume(struct device *dev)
> +{
> +	if (pm_suspend_via_firmware())
> +		return tpm_pm_resume(dev);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(cr50_resume);
> +
> +int cr50_suspend(struct device *dev)
> +{
> +	if (pm_suspend_via_firmware())
> +		return tpm_pm_suspend(dev);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(cr50_suspend);
> +#endif /* CONFIG_PM_SLEEP */
> diff --git a/drivers/char/tpm/cr50.h b/drivers/char/tpm/cr50.h
> new file mode 100644
> index 000000000000..1c635fae03e8
> --- /dev/null
> +++ b/drivers/char/tpm/cr50.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright 2016 Google Inc.
> + * This file contains common code for devices with Cr50 firmware.
> + */
> +
> +#ifndef __CR50_H__
> +#define __CR50_H__
> +
> +struct device;
> +
> +int cr50_resume(struct device *dev);
> +int cr50_suspend(struct device *dev);
> +
> +#endif /* __CR50_H__ */
> diff --git a/drivers/char/tpm/cr50_spi.c b/drivers/char/tpm/cr50_spi.c
> new file mode 100644
> index 000000000000..3c1b472297ad
> --- /dev/null
> +++ b/drivers/char/tpm/cr50_spi.c
> @@ -0,0 +1,450 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2016 Google, Inc
> + *
> + * This device driver implements a TCG PTP FIFO interface over SPI for chips
> + * with Cr50 firmware.
> + * It is based on tpm_tis_spi driver by Peter Huewe and Christophe Ricard.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/pm.h>
> +#include <linux/spi/spi.h>
> +#include <linux/wait.h>
> +#include "cr50.h"
> +#include "tpm_tis_core.h"
> +
> +/*
> + * Cr50 timing constants:
> + * - can go to sleep not earlier than after CR50_SLEEP_DELAY_MSEC.
> + * - needs up to CR50_WAKE_START_DELAY_MSEC to wake after sleep.
> + * - requires waiting for "ready" IRQ, if supported; or waiting for at least
> + *   CR50_NOIRQ_ACCESS_DELAY_MSEC between transactions, if IRQ is not supported.
> + * - waits for up to CR50_FLOW_CONTROL_MSEC for flow control 'ready' indication.
> + */
> +#define CR50_SLEEP_DELAY_MSEC			1000
> +#define CR50_WAKE_START_DELAY_MSEC		1
> +#define CR50_NOIRQ_ACCESS_DELAY_MSEC		2
> +#define CR50_READY_IRQ_TIMEOUT_MSEC		TPM2_TIMEOUT_A
> +#define CR50_FLOW_CONTROL_MSEC			TPM2_TIMEOUT_A
> +#define MAX_IRQ_CONFIRMATION_ATTEMPTS		3
> +
> +#define MAX_SPI_FRAMESIZE			64
> +
> +#define TPM_CR50_FW_VER(l)			(0x0F90 | ((l) << 12))
> +#define TPM_CR50_MAX_FW_VER_LEN			64
> +
> +static unsigned short rng_quality = 1022;
> +module_param(rng_quality, ushort, 0644);
> +MODULE_PARM_DESC(rng_quality,
> +		 "Estimation of true entropy, in bits per 1024 bits.");

What is the purpose of this parameter? None of the other TPM drivers 
have it.

> +
> +struct cr50_spi_phy {
> +	struct tpm_tis_data priv;
> +	struct spi_device *spi_device;
> +
> +	struct mutex time_track_mutex;
> +	unsigned long last_access_jiffies;
> +	unsigned long wake_after_jiffies;
> +
> +	unsigned long access_delay_jiffies;
> +	unsigned long sleep_delay_jiffies;
> +	unsigned int wake_start_delay_msec;
> +
> +	struct completion tpm_ready;
> +
> +	unsigned int irq_confirmation_attempt;
> +	bool irq_needs_confirmation;
> +	bool irq_confirmed;
> +
> +	u8 tx_buf[MAX_SPI_FRAMESIZE] ____cacheline_aligned;
> +	u8 rx_buf[MAX_SPI_FRAMESIZE] ____cacheline_aligned;
> +};
> +
> +static struct cr50_spi_phy *to_cr50_spi_phy(struct tpm_tis_data *data)
> +{
> +	return container_of(data, struct cr50_spi_phy, priv);
> +}
> +
> +/*
> + * The cr50 interrupt handler just signals waiting threads that the
> + * interrupt was asserted.  It does not do any processing triggered
> + * by interrupts but is instead used to avoid fixed delays.
> + */
> +static irqreturn_t cr50_spi_irq_handler(int dummy, void *dev_id)
> +{
> +	struct cr50_spi_phy *phy = dev_id;
> +
> +	phy->irq_confirmed = true;
> +	complete(&phy->tpm_ready);
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
> +	/*
> +	 * Note: There is a small chance, if Cr50 is not accessed in a few days,
> +	 * that time_in_range will not provide the correct result after the wrap
> +	 * around for jiffies. In this case, we'll have an unneeded short delay,
> +	 * which is fine.
> +	 */
> +	unsigned long allowed_access =
> +		phy->last_access_jiffies + phy->access_delay_jiffies;
> +	unsigned long time_now = jiffies;
> +
> +	if (time_in_range_open(time_now,
> +			       phy->last_access_jiffies, allowed_access)) {
> +		unsigned long remaining =
> +			wait_for_completion_timeout(&phy->tpm_ready,
> +						    allowed_access - time_now);
> +		if (remaining == 0 && phy->irq_confirmed) {
> +			dev_warn(&phy->spi_device->dev,
> +				 "Timeout waiting for TPM ready IRQ\n");
> +		}
> +	}
> +	if (phy->irq_needs_confirmation) {
> +		if (phy->irq_confirmed) {
> +			phy->irq_needs_confirmation = false;
> +			phy->access_delay_jiffies =
> +				msecs_to_jiffies(CR50_READY_IRQ_TIMEOUT_MSEC);
> +			dev_info(&phy->spi_device->dev,
> +				 "TPM ready IRQ confirmed on attempt %u\n",
> +				 phy->irq_confirmation_attempt);
> +		} else if (++phy->irq_confirmation_attempt >
> +			   MAX_IRQ_CONFIRMATION_ATTEMPTS) {
> +			phy->irq_needs_confirmation = false;
> +			dev_warn(&phy->spi_device->dev,
> +				 "IRQ not confirmed - will use delays\n");
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
> +	return !time_in_range_open(jiffies,
> +				   phy->last_access_jiffies,
> +				   phy->wake_after_jiffies);
> +}
> +
> +static void cr50_wake_if_needed(struct cr50_spi_phy *phy)
> +{
> +	if (cr50_needs_waking(phy)) {
> +		/* Assert CS, wait 1 msec, deassert CS */
> +		struct spi_transfer spi_cs_wake = { .delay_usecs = 1000 };
> +
> +		spi_sync_transfer(phy->spi_device, &spi_cs_wake, 1);
> +		/* Wait for it to fully wake */
> +		msleep(phy->wake_start_delay_msec);

wake_start_delay_msec is always 1, isn't it? (Why is that a variable at 
all? I see only one place that ever sets it.) Then msleep is not the 
best function to use, since it will usually sleep much longer. Use 
usleep_range instead. See Documentation/timers/timers-howto.txt.

> +	}
> +	/* Reset the time when we need to wake Cr50 again */
> +	phy->wake_after_jiffies = jiffies + phy->sleep_delay_jiffies;
> +}
> +
> +/*
> + * Flow control: clock the bus and wait for cr50 to set LSB before
> + * sending/receiving data. TCG PTP spec allows it to happen during
> + * the last byte of header, but cr50 never does that in practice,
> + * and earlier versions had a bug when it was set too early, so don't
> + * check for it during header transfer.
> + */
> +static int cr50_spi_flow_control(struct cr50_spi_phy *phy)
> +{
> +	unsigned long timeout_jiffies =
> +		jiffies + msecs_to_jiffies(CR50_FLOW_CONTROL_MSEC);
> +	struct spi_message m;
> +	int ret;
> +	struct spi_transfer spi_xfer = {
> +		.rx_buf = phy->rx_buf,
> +		.len = 1,
> +		.cs_change = 1,
> +	};
> +
> +	do {
> +		spi_message_init(&m);
> +		spi_message_add_tail(&spi_xfer, &m);
> +		ret = spi_sync_locked(phy->spi_device, &m);
> +		if (ret < 0)
> +			return ret;
> +		if (time_after(jiffies, timeout_jiffies)) {
> +			dev_warn(&phy->spi_device->dev,
> +				 "Timeout during flow control\n");
> +			return -EBUSY;
> +		}
> +	} while (!(phy->rx_buf[0] & 0x01));
> +	return 0;
> +}
> +
> +static int cr50_spi_xfer_bytes(struct tpm_tis_data *data, u32 addr,
> +			       u16 len, const u8 *tx, u8 *rx)
> +{
> +	struct cr50_spi_phy *phy = to_cr50_spi_phy(data);
> +	struct spi_message m;
> +	struct spi_transfer spi_xfer = {
> +		.tx_buf = phy->tx_buf,
> +		.rx_buf = phy->rx_buf,
> +		.len = 4,
> +		.cs_change = 1,
> +	};
> +	int ret;
> +
> +	if (len > MAX_SPI_FRAMESIZE)
> +		return -EINVAL;
> +
> +	/*
> +	 * Do this outside of spi_bus_lock in case cr50 is not the
> +	 * only device on that spi bus.
> +	 */
> +	mutex_lock(&phy->time_track_mutex);
> +	cr50_ensure_access_delay(phy);
> +	cr50_wake_if_needed(phy);
> +
> +	phy->tx_buf[0] = (tx ? 0x00 : 0x80) | (len - 1);
> +	phy->tx_buf[1] = 0xD4;
> +	phy->tx_buf[2] = (addr >> 8) & 0xFF;
> +	phy->tx_buf[3] = addr & 0xFF;
> +
> +	spi_message_init(&m);
> +	spi_message_add_tail(&spi_xfer, &m);
> +
> +	spi_bus_lock(phy->spi_device->master);
> +	ret = spi_sync_locked(phy->spi_device, &m);
> +	if (ret < 0)
> +		goto exit;
> +
> +	ret = cr50_spi_flow_control(phy);
> +	if (ret < 0)
> +		goto exit;
> +
> +	spi_xfer.cs_change = 0;
> +	spi_xfer.len = len;
> +	if (tx) {
> +		memcpy(phy->tx_buf, tx, len);
> +		spi_xfer.rx_buf = NULL;
> +	} else {
> +		spi_xfer.tx_buf = NULL;
> +	}
> +
> +	spi_message_init(&m);
> +	spi_message_add_tail(&spi_xfer, &m);
> +	reinit_completion(&phy->tpm_ready);
> +	ret = spi_sync_locked(phy->spi_device, &m);
> +	if (rx)
> +		memcpy(rx, phy->rx_buf, len);
> +
> +exit:
> +	spi_bus_unlock(phy->spi_device->master);
> +	phy->last_access_jiffies = jiffies;
> +	mutex_unlock(&phy->time_track_mutex);
> +
> +	return ret;
> +}
> +
> +static int cr50_spi_read_bytes(struct tpm_tis_data *data, u32 addr,
> +			       u16 len, u8 *result)
> +{
> +	return cr50_spi_xfer_bytes(data, addr, len, NULL, result);
> +}
> +
> +static int cr50_spi_write_bytes(struct tpm_tis_data *data, u32 addr,
> +				u16 len, const u8 *value)
> +{
> +	return cr50_spi_xfer_bytes(data, addr, len, value, NULL);
> +}
> +
> +static int cr50_spi_read16(struct tpm_tis_data *data, u32 addr, u16 *result)
> +{
> +	int rc;
> +	__le16 le_val;
> +
> +	rc = data->phy_ops->read_bytes(data, addr, sizeof(u16), (u8 *)&le_val);
> +	if (!rc)
> +		*result = le16_to_cpu(le_val);
> +	return rc;
> +}
> +
> +static int cr50_spi_read32(struct tpm_tis_data *data, u32 addr, u32 *result)
> +{
> +	int rc;
> +	__le32 le_val;
> +
> +	rc = data->phy_ops->read_bytes(data, addr, sizeof(u32), (u8 *)&le_val);
> +	if (!rc)
> +		*result = le32_to_cpu(le_val);
> +	return rc;
> +}
> +
> +static int cr50_spi_write32(struct tpm_tis_data *data, u32 addr, u32 value)
> +{
> +	__le32 le_val = cpu_to_le32(value);
> +
> +	return data->phy_ops->write_bytes(data, addr, sizeof(u32),
> +					   (u8 *)&le_val);
> +}
> +
> +static void cr50_get_fw_version(struct tpm_tis_data *data, char *fw_ver)
> +{
> +	int i, len = 0;
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
> +	fw_ver[len] = 0;
> +}
> +
> +static const struct tpm_tis_phy_ops cr50_spi_phy_ops = {
> +	.read_bytes = cr50_spi_read_bytes,
> +	.write_bytes = cr50_spi_write_bytes,
> +	.read16 = cr50_spi_read16,
> +	.read32 = cr50_spi_read32,
> +	.write32 = cr50_spi_write32,
> +	.max_xfer_size = MAX_SPI_FRAMESIZE,
> +};
> +
> +static int cr50_spi_probe(struct spi_device *dev)
> +{
> +	char fw_ver[TPM_CR50_MAX_FW_VER_LEN + 1];
> +	struct cr50_spi_phy *phy;
> +	int rc;
> +
> +	phy = devm_kzalloc(&dev->dev, sizeof(*phy), GFP_KERNEL);
> +	if (!phy)
> +		return -ENOMEM;
> +
> +	phy->spi_device = dev;
> +
> +	phy->access_delay_jiffies =
> +		msecs_to_jiffies(CR50_NOIRQ_ACCESS_DELAY_MSEC);
> +	phy->sleep_delay_jiffies = msecs_to_jiffies(CR50_SLEEP_DELAY_MSEC);
> +	phy->wake_start_delay_msec = CR50_WAKE_START_DELAY_MSEC;
> +
> +	mutex_init(&phy->time_track_mutex);
> +	phy->wake_after_jiffies = jiffies;
> +	phy->last_access_jiffies = jiffies;
> +
> +	init_completion(&phy->tpm_ready);
> +	if (dev->irq > 0) {
> +		rc = devm_request_irq(&dev->dev, dev->irq, cr50_spi_irq_handler,
> +				      IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +				      "cr50_spi", phy);
> +		if (rc < 0) {
> +			if (rc == -EPROBE_DEFER)
> +				return rc;
> +			dev_warn(&dev->dev, "Requesting IRQ %d failed: %d\n",
> +				 dev->irq, rc);
> +			/*
> +			 * This is not fatal, the driver will fall back to
> +			 * delays automatically, since tpm_ready will never
> +			 * be completed without a registered irq handler.
> +			 * So, just fall through.
> +			 */
> +		} else {
> +			/*
> +			 * IRQ requested, let's verify that it is actually
> +			 * triggered, before relying on it.
> +			 */
> +			phy->irq_needs_confirmation = true;
> +		}
> +	} else {
> +		dev_warn(&dev->dev,
> +			 "No IRQ - will use delays between transactions.\n");
> +	}
> +
> +	phy->priv.rng_quality = rng_quality;
> +
> +	rc = tpm_tis_core_init(&dev->dev, &phy->priv, -1, &cr50_spi_phy_ops,
> +			       NULL);
> +	if (rc < 0)
> +		return rc;
> +
> +	cr50_get_fw_version(&phy->priv, fw_ver);
> +	dev_info(&dev->dev, "Cr50 firmware version: %s\n", fw_ver);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int cr50_spi_resume(struct device *dev)
> +{
> +	struct tpm_chip *chip = dev_get_drvdata(dev);
> +	struct tpm_tis_data *data = dev_get_drvdata(&chip->dev);
> +	struct cr50_spi_phy *phy = to_cr50_spi_phy(data);
> +
> +	/*
> +	 * Jiffies not increased during suspend, so we need to reset
> +	 * the time to wake Cr50 after resume.
> +	 */
> +	phy->wake_after_jiffies = jiffies;
> +
> +	return cr50_resume(dev);
> +}
> +#endif
> +
> +static SIMPLE_DEV_PM_OPS(cr50_spi_pm, cr50_suspend, cr50_spi_resume);
> +
> +static int cr50_spi_remove(struct spi_device *dev)
> +{
> +	struct tpm_chip *chip = spi_get_drvdata(dev);
> +
> +	tpm_chip_unregister(chip);
> +	tpm_tis_remove(chip);
> +	return 0;
> +}
> +
> +static const struct spi_device_id cr50_spi_id[] = {
> +	{ "cr50", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, cr50_spi_id);
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id of_cr50_spi_match[] = {
> +	{ .compatible = "google,cr50", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, of_cr50_spi_match);
> +#endif
> +
> +static struct spi_driver cr50_spi_driver = {
> +	.driver = {
> +		.name = "cr50_spi",
> +		.pm = &cr50_spi_pm,
> +		.of_match_table = of_match_ptr(of_cr50_spi_match),
> +	},
> +	.probe = cr50_spi_probe,
> +	.remove = cr50_spi_remove,
> +	.id_table = cr50_spi_id,
> +};
> +module_spi_driver(cr50_spi_driver);
> +
> +MODULE_DESCRIPTION("Cr50 TCG PTP FIFO SPI driver");
> +MODULE_LICENSE("GPL v2");

This copies a lot of code from tpm_tis_spi, but then slightly changes 
some things, without really explaining why. For example, struct 
cr50_spi_phy contains both tx_buf and rx_buf, whereas tpm_tis_spi uses a 
single iobuf, that is allocated via devm_kmalloc instead of being part 
of the struct. Maybe the difference matters, maybe not, who knows?

Can't the code be shared more explicitly, e.g. by cr50_spi wrapping 
tpm_tis_spi, so that it can intercept the calls, execute the additional 
actions (like waking up the device), but then let tpm_tis_spi do the 
common work?

Alexander
