Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3A638AA7C
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Aug 2019 00:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfHLWge (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 12 Aug 2019 18:36:34 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41550 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbfHLWga (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 12 Aug 2019 18:36:30 -0400
Received: by mail-pf1-f196.google.com with SMTP id 196so3256325pfz.8
        for <linux-integrity@vger.kernel.org>; Mon, 12 Aug 2019 15:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qrp73fXN1Yecimm4jOuhlrZx9sZom7dIuI2rB8EzAMQ=;
        b=e9YOzvMoqGvTy/w3AqKHjoTT9kvQX9rXs636F1KGuXZHw/DyILcC+NRMuDeFwys3/1
         yHExMAeqimr+yNYFA6+mJqtYm4FaGlAybXTbmaMjKoZu7wSk07xWqysNaqzKvqBVdK97
         lY6UBIUDrptcFyfnSeRaDtbR3+ttVXHp1XxYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qrp73fXN1Yecimm4jOuhlrZx9sZom7dIuI2rB8EzAMQ=;
        b=eKiuNXu8AvgJnofQdv4AbvJ3ccYJiF/uLSteSo6BtyXjF4ILS1++RWESUzugfI3CtW
         LX/r7BJ244GS5NaNXlsh6efL/bLJH2D2/D9+chy3LBSFt9y5KzdxbrfJTv/cAW0bo3OC
         8m5fUW7rNa9WAUKL7XkazaZcjbVA3cmPyd/8snmVi7iWCKnbRxJ/IOf/wlHrV7BdW3xd
         g+h+x6lS9hqwREFHkPLHZKOfBy4zEX0xD+AzGPvQqo5U7mdFL9eyyeCNwy+vZSJHIr7+
         3a0S83qVtnzgnMRCZnqnhYRpasfkSj2p4tLUViOr21Y9D4isugERvVdIwNcb0x/fto+y
         Iblw==
X-Gm-Message-State: APjAAAWMCn05Ns84wtI0ilh8OncpkgNCflPKjEYcEnNXRODflhpjAI3c
        PEjVo8xuDz0/ofuUE17HVfRGvtZCbLmYGw==
X-Google-Smtp-Source: APXvYqyhP4sM6THnCEWTNQ0nYzfk9l6TrEKVMOMggtTk5qGcOxyOglgGE66XdTNu2JFmd3YnuIN/mg==
X-Received: by 2002:aa7:9719:: with SMTP id a25mr11654929pfg.2.1565649389764;
        Mon, 12 Aug 2019 15:36:29 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id b6sm93911594pgq.26.2019.08.12.15.36.28
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 15:36:29 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Andrey Pronin <apronin@chromium.org>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: [PATCH v4 6/6] tpm: add driver for cr50 on SPI
Date:   Mon, 12 Aug 2019 15:36:22 -0700
Message-Id: <20190812223622.73297-7-swboyd@chromium.org>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
In-Reply-To: <20190812223622.73297-1-swboyd@chromium.org>
References: <20190812223622.73297-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Andrey Pronin <apronin@chromium.org>

Add TPM2.0 PTP FIFO compatible SPI interface for chips with Cr50
firmware. The firmware running on the currently supported H1
Secure Microcontroller requires a special driver to handle its
specifics:

 - need to ensure a certain delay between spi transactions, or else
   the chip may miss some part of the next transaction;
 - if there is no spi activity for some time, it may go to sleep,
   and needs to be waken up before sending further commands;
 - access to vendor-specific registers.

Signed-off-by: Andrey Pronin <apronin@chromium.org>
Cc: Andrey Pronin <apronin@chromium.org>
Cc: Duncan Laurie <dlaurie@chromium.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Alexander Steffen <Alexander.Steffen@infineon.com>
[swboyd@chromium.org: Replace boilerplate with SPDX tag, drop
suspended bit and remove ifdef checks in cr50.h, push tpm.h
include into cr50.c, migrate to functions exported from tpm_tis_spi.h]
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/char/tpm/Kconfig    |   9 +
 drivers/char/tpm/Makefile   |   1 +
 drivers/char/tpm/cr50_spi.c | 372 ++++++++++++++++++++++++++++++++++++
 3 files changed, 382 insertions(+)
 create mode 100644 drivers/char/tpm/cr50_spi.c

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 88a3c06fc153..1fb23f145ef6 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -114,6 +114,15 @@ config TCG_ATMEL
 	  will be accessible from within Linux.  To compile this driver 
 	  as a module, choose M here; the module will be called tpm_atmel.
 
+config TCG_CR50_SPI
+	tristate "Cr50 SPI Interface"
+	depends on TCG_TIS_SPI
+	---help---
+	  If you have a H1 secure module running Cr50 firmware on SPI bus,
+	  say Yes and it will be accessible from within Linux. To compile
+	  this driver as a module, choose M here; the module will be called
+	  cr50_spi.
+
 config TCG_INFINEON
 	tristate "Infineon Technologies TPM Interface"
 	depends on PNP
diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
index a01c4cab902a..4713e52ce1b0 100644
--- a/drivers/char/tpm/Makefile
+++ b/drivers/char/tpm/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_TCG_TIS_I2C_INFINEON) += tpm_i2c_infineon.o
 obj-$(CONFIG_TCG_TIS_I2C_NUVOTON) += tpm_i2c_nuvoton.o
 obj-$(CONFIG_TCG_NSC) += tpm_nsc.o
 obj-$(CONFIG_TCG_ATMEL) += tpm_atmel.o
+obj-$(CONFIG_TCG_CR50_SPI) += cr50_spi.o
 obj-$(CONFIG_TCG_INFINEON) += tpm_infineon.o
 obj-$(CONFIG_TCG_IBMVTPM) += tpm_ibmvtpm.o
 obj-$(CONFIG_TCG_TIS_ST33ZP24) += st33zp24/
diff --git a/drivers/char/tpm/cr50_spi.c b/drivers/char/tpm/cr50_spi.c
new file mode 100644
index 000000000000..a163864e9c63
--- /dev/null
+++ b/drivers/char/tpm/cr50_spi.c
@@ -0,0 +1,372 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2016 Google, Inc
+ *
+ * This device driver implements a TCG PTP FIFO interface over SPI for chips
+ * with Cr50 firmware.
+ * It is based on tpm_tis_spi driver by Peter Huewe and Christophe Ricard.
+ */
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pm.h>
+#include <linux/spi/spi.h>
+#include <linux/wait.h>
+
+#include "tpm_tis_core.h"
+#include "tpm_tis_spi.h"
+
+/*
+ * Cr50 timing constants:
+ * - can go to sleep not earlier than after CR50_SLEEP_DELAY_MSEC.
+ * - needs up to CR50_WAKE_START_DELAY_USEC to wake after sleep.
+ * - requires waiting for "ready" IRQ, if supported; or waiting for at least
+ *   CR50_NOIRQ_ACCESS_DELAY_MSEC between transactions, if IRQ is not supported.
+ * - waits for up to CR50_FLOW_CONTROL for flow control 'ready' indication.
+ */
+#define CR50_SLEEP_DELAY_MSEC			1000
+#define CR50_WAKE_START_DELAY_USEC		1000
+#define CR50_NOIRQ_ACCESS_DELAY			msecs_to_jiffies(2)
+#define CR50_READY_IRQ_TIMEOUT			msecs_to_jiffies(TPM2_TIMEOUT_A)
+#define CR50_FLOW_CONTROL			msecs_to_jiffies(TPM2_TIMEOUT_A)
+#define MAX_IRQ_CONFIRMATION_ATTEMPTS		3
+
+#define TPM_CR50_FW_VER(l)			(0x0f90 | ((l) << 12))
+#define TPM_CR50_MAX_FW_VER_LEN			64
+
+struct cr50_spi_phy {
+	struct tpm_tis_spi_phy spi_phy;
+
+	struct mutex time_track_mutex;
+	unsigned long last_access;
+	unsigned long wake_after;
+
+	unsigned long access_delay;
+
+	struct completion ready;
+
+	unsigned int irq_confirmation_attempt;
+	bool irq_needs_confirmation;
+	bool irq_confirmed;
+};
+
+static inline struct cr50_spi_phy *to_cr50_spi_phy(struct tpm_tis_spi_phy *phy)
+{
+	return container_of(phy, struct cr50_spi_phy, spi_phy);
+}
+
+/*
+ * The cr50 interrupt handler just signals waiting threads that the
+ * interrupt was asserted.  It does not do any processing triggered
+ * by interrupts but is instead used to avoid fixed delays.
+ */
+static irqreturn_t cr50_spi_irq_handler(int dummy, void *dev_id)
+{
+	struct cr50_spi_phy *cr50_phy = dev_id;
+
+	cr50_phy->irq_confirmed = true;
+	complete(&cr50_phy->ready);
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * Cr50 needs to have at least some delay between consecutive
+ * transactions. Make sure we wait.
+ */
+static void cr50_ensure_access_delay(struct cr50_spi_phy *phy)
+{
+	unsigned long allowed_access = phy->last_access + phy->access_delay;
+	unsigned long time_now = jiffies;
+	struct device *dev = &phy->spi_phy.spi_device->dev;
+
+	/*
+	 * Note: There is a small chance, if Cr50 is not accessed in a few days,
+	 * that time_in_range will not provide the correct result after the wrap
+	 * around for jiffies. In this case, we'll have an unneeded short delay,
+	 * which is fine.
+	 */
+	if (time_in_range_open(time_now, phy->last_access, allowed_access)) {
+		unsigned long remaining, timeout = allowed_access - time_now;
+
+		remaining = wait_for_completion_timeout(&phy->ready, timeout);
+		if (!remaining && phy->irq_confirmed)
+			dev_warn(dev, "Timeout waiting for TPM ready IRQ\n");
+	}
+
+	if (phy->irq_needs_confirmation) {
+		unsigned int attempt = ++phy->irq_confirmation_attempt;
+
+		if (phy->irq_confirmed) {
+			phy->irq_needs_confirmation = false;
+			phy->access_delay = CR50_READY_IRQ_TIMEOUT;
+			dev_info(dev, "TPM ready IRQ confirmed on attempt %u\n",
+				 attempt);
+		} else if (attempt > MAX_IRQ_CONFIRMATION_ATTEMPTS) {
+			phy->irq_needs_confirmation = false;
+			dev_warn(dev, "IRQ not confirmed - will use delays\n");
+		}
+	}
+}
+
+/*
+ * Cr50 might go to sleep if there is no SPI activity for some time and
+ * miss the first few bits/bytes on the bus. In such case, wake it up
+ * by asserting CS and give it time to start up.
+ */
+static bool cr50_needs_waking(struct cr50_spi_phy *phy)
+{
+	/*
+	 * Note: There is a small chance, if Cr50 is not accessed in a few days,
+	 * that time_in_range will not provide the correct result after the wrap
+	 * around for jiffies. In this case, we'll probably timeout or read
+	 * incorrect value from TPM_STS and just retry the operation.
+	 */
+	return !time_in_range_open(jiffies, phy->last_access, phy->wake_after);
+}
+
+static void cr50_wake_if_needed(struct cr50_spi_phy *cr50_phy)
+{
+	struct tpm_tis_spi_phy *phy = &cr50_phy->spi_phy;
+
+	if (cr50_needs_waking(cr50_phy)) {
+		/* Assert CS, wait 1 msec, deassert CS */
+		struct spi_transfer spi_cs_wake = { .delay_usecs = 1000 };
+
+		spi_sync_transfer(phy->spi_device, &spi_cs_wake, 1);
+		/* Wait for it to fully wake */
+		usleep_range(CR50_WAKE_START_DELAY_USEC,
+			     CR50_WAKE_START_DELAY_USEC * 2);
+	}
+
+	/* Reset the time when we need to wake Cr50 again */
+	cr50_phy->wake_after = jiffies + msecs_to_jiffies(CR50_SLEEP_DELAY_MSEC);
+}
+
+/*
+ * Flow control: clock the bus and wait for cr50 to set LSB before
+ * sending/receiving data. TCG PTP spec allows it to happen during
+ * the last byte of header, but cr50 never does that in practice,
+ * and earlier versions had a bug when it was set too early, so don't
+ * check for it during header transfer.
+ */
+static int cr50_spi_flow_control(struct tpm_tis_spi_phy *phy,
+				 struct spi_transfer *spi_xfer)
+{
+	struct device *dev = &phy->spi_device->dev;
+	unsigned long timeout = jiffies + CR50_FLOW_CONTROL;
+	struct spi_message m;
+	int ret;
+
+	spi_xfer->len = 1;
+
+	do {
+		spi_message_init(&m);
+		spi_message_add_tail(spi_xfer, &m);
+		ret = spi_sync_locked(phy->spi_device, &m);
+		if (ret < 0)
+			return ret;
+
+		if (time_after(jiffies, timeout)) {
+			dev_warn(dev, "Timeout during flow control\n");
+			return -EBUSY;
+		}
+	} while (!(phy->iobuf[0] & 0x01));
+
+	return 0;
+}
+
+static void cr50_spi_reinit_completion(struct tpm_tis_spi_phy *phy)
+{
+	struct cr50_spi_phy *cr50_phy = to_cr50_spi_phy(phy);
+	reinit_completion(&cr50_phy->ready);
+}
+
+static int tpm_tis_spi_cr50_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
+				     u8 *in, const u8 *out)
+{
+	struct tpm_tis_spi_phy *phy = to_tpm_tis_spi_phy(data);
+	struct cr50_spi_phy *cr50_phy = to_cr50_spi_phy(phy);
+	int ret;
+
+	mutex_lock(&cr50_phy->time_track_mutex);
+	/*
+	 * Do this outside of spi_bus_lock in case cr50 is not the
+	 * only device on that spi bus.
+	 */
+	cr50_ensure_access_delay(cr50_phy);
+	cr50_wake_if_needed(cr50_phy);
+
+	ret = tpm_tis_spi_transfer(data, addr, len, in, out);
+
+	cr50_phy->last_access = jiffies;
+	mutex_unlock(&cr50_phy->time_track_mutex);
+
+	return ret;
+}
+
+static int tpm_tis_spi_cr50_read_bytes(struct tpm_tis_data *data, u32 addr,
+				       u16 len, u8 *result)
+{
+	return tpm_tis_spi_cr50_transfer(data, addr, len, result, NULL);
+}
+
+static int tpm_tis_spi_cr50_write_bytes(struct tpm_tis_data *data, u32 addr,
+					u16 len, const u8 *value)
+{
+	return tpm_tis_spi_cr50_transfer(data, addr, len, NULL, value);
+}
+
+static const struct tpm_tis_phy_ops tpm_spi_cr50_phy_ops = {
+	.read_bytes = tpm_tis_spi_cr50_read_bytes,
+	.write_bytes = tpm_tis_spi_cr50_write_bytes,
+	.read16 = tpm_tis_spi_read16,
+	.read32 = tpm_tis_spi_read32,
+	.write32 = tpm_tis_spi_write32,
+};
+
+static void cr50_print_fw_version(struct tpm_tis_data *data)
+{
+	struct tpm_tis_spi_phy *phy = to_tpm_tis_spi_phy(data);
+	int i, len = 0;
+	char fw_ver[TPM_CR50_MAX_FW_VER_LEN + 1];
+	char fw_ver_block[4];
+
+	/*
+	 * Write anything to TPM_CR50_FW_VER to start from the beginning
+	 * of the version string
+	 */
+	tpm_tis_write8(data, TPM_CR50_FW_VER(data->locality), 0);
+
+	/* Read the string, 4 bytes at a time, until we get '\0' */
+	do {
+		tpm_tis_read_bytes(data, TPM_CR50_FW_VER(data->locality), 4,
+				   fw_ver_block);
+		for (i = 0; i < 4 && fw_ver_block[i]; ++len, ++i)
+			fw_ver[len] = fw_ver_block[i];
+	} while (i == 4 && len < TPM_CR50_MAX_FW_VER_LEN);
+	fw_ver[len] = '\0';
+
+	dev_info(&phy->spi_device->dev, "Cr50 firmware version: %s\n", fw_ver);
+}
+
+static int cr50_spi_probe(struct spi_device *spi)
+{
+	struct tpm_tis_spi_phy *phy;
+	struct cr50_spi_phy *cr50_phy;
+	int ret;
+	struct tpm_chip *chip;
+
+	cr50_phy = devm_kzalloc(&spi->dev, sizeof(*cr50_phy), GFP_KERNEL);
+	if (!cr50_phy)
+		return -ENOMEM;
+
+	phy = &cr50_phy->spi_phy;
+	phy->flow_control = cr50_spi_flow_control;
+	phy->pre_transfer = cr50_spi_reinit_completion;
+
+	cr50_phy->access_delay = CR50_NOIRQ_ACCESS_DELAY;
+
+	mutex_init(&cr50_phy->time_track_mutex);
+	cr50_phy->wake_after = jiffies;
+	cr50_phy->last_access = jiffies;
+
+	init_completion(&cr50_phy->ready);
+	if (spi->irq > 0) {
+		ret = devm_request_irq(&spi->dev, spi->irq, cr50_spi_irq_handler,
+				       IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+				       "cr50_spi", cr50_phy);
+		if (ret < 0) {
+			if (ret == -EPROBE_DEFER)
+				return ret;
+			dev_warn(&spi->dev, "Requesting IRQ %d failed: %d\n",
+				 spi->irq, ret);
+			/*
+			 * This is not fatal, the driver will fall back to
+			 * delays automatically, since ready will never
+			 * be completed without a registered irq handler.
+			 * So, just fall through.
+			 */
+		} else {
+			/*
+			 * IRQ requested, let's verify that it is actually
+			 * triggered, before relying on it.
+			 */
+			cr50_phy->irq_needs_confirmation = true;
+		}
+	} else {
+		dev_warn(&spi->dev,
+			 "No IRQ - will use delays between transactions.\n");
+	}
+
+	ret = tpm_tis_spi_init(spi, phy, -1, &tpm_spi_cr50_phy_ops);
+	if (ret)
+		return ret;
+
+	cr50_print_fw_version(&phy->priv);
+
+	chip = dev_get_drvdata(&spi->dev);
+	chip->flags |= TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED;
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int cr50_spi_resume(struct device *dev)
+{
+	struct tpm_chip *chip = dev_get_drvdata(dev);
+	struct tpm_tis_data *data = dev_get_drvdata(&chip->dev);
+	struct tpm_tis_spi_phy *phy = to_tpm_tis_spi_phy(data);
+	struct cr50_spi_phy *cr50_phy = to_cr50_spi_phy(phy);
+
+	/*
+	 * Jiffies not increased during suspend, so we need to reset
+	 * the time to wake Cr50 after resume.
+	 */
+	cr50_phy->wake_after = jiffies;
+
+	return tpm_tis_resume(dev);
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(cr50_spi_pm, tpm_pm_suspend, cr50_spi_resume);
+
+static int cr50_spi_remove(struct spi_device *dev)
+{
+	struct tpm_chip *chip = spi_get_drvdata(dev);
+
+	tpm_chip_unregister(chip);
+	tpm_tis_remove(chip);
+	return 0;
+}
+
+static const struct spi_device_id cr50_spi_id[] = {
+	{ "cr50", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, cr50_spi_id);
+
+#ifdef CONFIG_OF
+static const struct of_device_id of_cr50_spi_match[] = {
+	{ .compatible = "google,cr50", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, of_cr50_spi_match);
+#endif
+
+static struct spi_driver cr50_spi_driver = {
+	.driver = {
+		.name = "cr50_spi",
+		.pm = &cr50_spi_pm,
+		.of_match_table = of_match_ptr(of_cr50_spi_match),
+	},
+	.probe = cr50_spi_probe,
+	.remove = cr50_spi_remove,
+	.id_table = cr50_spi_id,
+};
+module_spi_driver(cr50_spi_driver);
+
+MODULE_DESCRIPTION("Cr50 TCG PTP FIFO SPI driver");
+MODULE_LICENSE("GPL v2");
-- 
Sent by a computer through tubes

