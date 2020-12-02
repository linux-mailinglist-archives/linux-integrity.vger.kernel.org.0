Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E572CBB25
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Dec 2020 11:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgLBK5H (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Dec 2020 05:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgLBK5H (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Dec 2020 05:57:07 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232EDC0613CF;
        Wed,  2 Dec 2020 02:56:27 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: aratiu)
        with ESMTPSA id AA5B01F44E49
From:   Adrian Ratiu <adrian.ratiu@collabora.com>
To:     linux-integrity@vger.kernel.org
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Duncan Laurie <dlaurie@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Helen Koike <helen.koike@collabora.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH v4] char: tpm: add i2c driver for cr50
Date:   Wed,  2 Dec 2020 12:58:05 +0200
Message-Id: <20201202105805.132183-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: "dlaurie@chromium.org" <dlaurie@chromium.org>

Add TPM 2.0 compatible I2C interface for chips with cr50 firmware.

The firmware running on the currently supported H1 MCU requires a
special driver to handle its specific protocol, and this makes it
unsuitable to use tpm_tis_core_* and instead it must implement the
underlying TPM protocol similar to the other I2C TPM drivers.

- All 4 bytes of status register must be read/written at once.
- FIFO and burst count is limited to 63 and must be drained by AP.
- Provides an interrupt to indicate when read response data is ready
and when the TPM is finished processing write data.

This driver is based on the existing infineon I2C TPM driver, which
most closely matches the cr50 i2c protocol behavior.

Cc: Helen Koike <helen.koike@collabora.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Ezequiel Garcia <ezequiel@collabora.com>
Signed-off-by: Duncan Laurie <dlaurie@chromium.org>
[swboyd@chromium.org: Depend on i2c even if it's a module, replace
boilier plate with SPDX tag, drop asm/byteorder.h include, simplify
return from probe]
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
Changes in v4:
  - Replace force_release enum with defines (Jarkko)

Changes in v3:
  - Misc small fixes (typos/renamings, comments, default values)
  - Moved i2c_write memcpy before lock to minimize critical section (Helen)
  - Dropped priv->locality because it stored a constant value (Helen)
  - Many kdoc, function name and style fixes in general (Jarkko)
  - Kept the force release enum instead of defines or bool (Ezequiel)

Changes in v2:
  - Various small fixes all over (reorder includes, MAX_BUFSIZE, comments, etc)
  - Reworked return values of i2c_wait_tpm_ready() to fix timeout mis-handling
so ret == 0 now means success, the wait period jiffies is ignored because that
number is meaningless and return a proper timeout error in case jiffies == 0.
  - Make i2c default to 1 message per transfer (requested by Helen)
  - Move -EIO error reporting to transfer function to cleanup transfer() itself
and its R/W callers
  - Remove magic value hardcodings and introduce enum force_release.

Applies on next-20201201, tested on Chromebook EVE.
---
 drivers/char/tpm/Kconfig            |  10 +
 drivers/char/tpm/Makefile           |   2 +
 drivers/char/tpm/tpm_tis_i2c_cr50.c | 767 ++++++++++++++++++++++++++++
 3 files changed, 779 insertions(+)
 create mode 100644 drivers/char/tpm/tpm_tis_i2c_cr50.c

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index a18c314da211..4308f9ca7a43 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -86,6 +86,16 @@ config TCG_TIS_SYNQUACER
 	  To compile this driver as a module, choose  M here;
 	  the module will be called tpm_tis_synquacer.
 
+config TCG_TIS_I2C_CR50
+	tristate "TPM Interface Specification 2.0 Interface (I2C - CR50)"
+	depends on I2C
+	select TCG_CR50
+	help
+	  This is a driver for the Google cr50 I2C TPM interface which is a
+	  custom microcontroller and requires a custom i2c protocol interface
+	  to handle the limitations of the hardware.  To compile this driver
+	  as a module, choose M here; the module will be called tcg_tis_i2c_cr50.
+
 config TCG_TIS_I2C_ATMEL
 	tristate "TPM Interface Specification 1.2 Interface (I2C - Atmel)"
 	depends on I2C
diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
index 84db4fb3a9c9..66d39ea6bd10 100644
--- a/drivers/char/tpm/Makefile
+++ b/drivers/char/tpm/Makefile
@@ -27,6 +27,8 @@ obj-$(CONFIG_TCG_TIS_SPI) += tpm_tis_spi.o
 tpm_tis_spi-y := tpm_tis_spi_main.o
 tpm_tis_spi-$(CONFIG_TCG_TIS_SPI_CR50) += tpm_tis_spi_cr50.o
 
+obj-$(CONFIG_TCG_TIS_I2C_CR50) += tpm_tis_i2c_cr50.o
+
 obj-$(CONFIG_TCG_TIS_I2C_ATMEL) += tpm_i2c_atmel.o
 obj-$(CONFIG_TCG_TIS_I2C_INFINEON) += tpm_i2c_infineon.o
 obj-$(CONFIG_TCG_TIS_I2C_NUVOTON) += tpm_i2c_nuvoton.o
diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis_i2c_cr50.c
new file mode 100644
index 000000000000..a374853a3b4b
--- /dev/null
+++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
@@ -0,0 +1,767 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2016 Google Inc.
+ *
+ * Based on Linux Kernel TPM driver by
+ * Peter Huewe <peter.huewe@infineon.com>
+ * Copyright (C) 2011 Infineon Technologies
+ *
+ * cr50 is a firmware for H1 secure modules that requires special
+ * handling for the I2C interface.
+ *
+ * - Use an interrupt for transaction status instead of hardcoded delays.
+ * - Must use write+wait+read read protocol.
+ * - All 4 bytes of status register must be read/written at once.
+ * - Burst count max is 63 bytes, and burst count behaves slightly differently
+ *   than other I2C TPMs.
+ * - When reading from FIFO the full burstcnt must be read instead of just
+ *   reading header and determining the remainder.
+ */
+
+#include <linux/acpi.h>
+#include <linux/completion.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/pm.h>
+#include <linux/slab.h>
+#include <linux/wait.h>
+
+#include "tpm_tis_core.h"
+
+#define TPM_CR50_MAX_BUFSIZE		64
+#define TPM_CR50_TIMEOUT_SHORT_MS	2	/* Short timeout during transactions */
+#define TPM_CR50_TIMEOUT_NOIRQ_MS	20	/* Timeout for TPM ready without IRQ */
+#define TPM_CR50_I2C_DID_VID		0x00281ae0L /* Device and vendor ID reg value */
+#define TPM_CR50_I2C_MAX_RETRIES	3	/* Max retries due to I2C errors */
+#define TPM_CR50_I2C_RETRY_DELAY_LO	55	/* Min usecs between retries on I2C */
+#define TPM_CR50_I2C_RETRY_DELAY_HI	65	/* Max usecs between retries on I2C */
+
+#define TPM_I2C_ACCESS(l)	(0x0000 | ((l) << 4))
+#define TPM_I2C_STS(l)		(0x0001 | ((l) << 4))
+#define TPM_I2C_DATA_FIFO(l)	(0x0005 | ((l) << 4))
+#define TPM_I2C_DID_VID(l)	(0x0006 | ((l) << 4))
+
+#define TPM_I2C_CR50_NO_FORCE	0
+#define TPM_I2C_CR50_FORCE	1
+
+/**
+ * struct tpm_i2c_cr50_priv_data - Driver private data.
+ * @irq: Irq number used for this chip. 
+ *       If irq <= 0, then a fixed timeout is used instead of waiting for irq.
+ * @tpm_ready: Struct used by irq handler to signal R/W readiness.
+ * @buf: Buffer used for i2c writes, with i2c address prepended to content.
+ */
+struct tpm_i2c_cr50_priv_data {
+	int irq;
+	struct completion tpm_ready;
+	u8 buf[TPM_CR50_MAX_BUFSIZE];
+};
+
+/**
+ * tpm_cr50_i2c_int_handler() - cr50 interrupt handler.
+ * @dummy: Unused parameter.
+ * @dev_id: TPM chip information.
+ *
+ * The cr50 interrupt handler signals waiting threads that the
+ * interrupt has been asserted. It does not do any interrupt triggered
+ * processing but is instead used to avoid fixed delays.
+ */
+static irqreturn_t tpm_cr50_i2c_int_handler(int dummy, void *dev_id)
+{
+	struct tpm_chip *chip = dev_id;
+	struct tpm_i2c_cr50_priv_data *priv = dev_get_drvdata(&chip->dev);
+
+	complete(&priv->tpm_ready);
+
+	return IRQ_HANDLED;
+}
+
+/**
+ * tpm_cr50_i2c_wait_tpm_ready() - Wait for tpm to signal ready.
+ * @chip: TPM chip information.
+ *
+ * Wait for completion interrupt if available, otherwise use a fixed
+ * delay for the TPM to be ready.
+ *
+ * Return: 0 for success or timeout error number.
+ */
+static int tpm_cr50_i2c_wait_tpm_ready(struct tpm_chip *chip)
+{
+	struct tpm_i2c_cr50_priv_data *priv = dev_get_drvdata(&chip->dev);
+
+	/* Use a safe fixed delay if interrupt is not supported */
+	if (priv->irq <= 0) {
+		msleep(TPM_CR50_TIMEOUT_NOIRQ_MS);
+		return 0;
+	}
+
+	/* Wait for interrupt to indicate TPM is ready to respond */
+	if (!wait_for_completion_timeout(&priv->tpm_ready,
+					 msecs_to_jiffies(chip->timeout_a))) {
+		dev_warn(&chip->dev, "Timeout waiting for TPM ready\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+/**
+ * tpm_cr50_i2c_enable_tpm_irq() - Enable TPM irq.
+ * @chip: TPM chip information.
+ */
+static void tpm_cr50_i2c_enable_tpm_irq(struct tpm_chip *chip)
+{
+	struct tpm_i2c_cr50_priv_data *priv = dev_get_drvdata(&chip->dev);
+
+	if (priv->irq > 0) {
+		reinit_completion(&priv->tpm_ready);
+		enable_irq(priv->irq);
+	}
+}
+
+/**
+ * tpm_cr50_i2c_disable_tpm_irq() - Disable TPM irq.
+ * @chip: TPM chip information.
+ */
+static void tpm_cr50_i2c_disable_tpm_irq(struct tpm_chip *chip)
+{
+	struct tpm_i2c_cr50_priv_data *priv = dev_get_drvdata(&chip->dev);
+
+	if (priv->irq > 0)
+		disable_irq(priv->irq);
+}
+
+/**
+ * tpm_cr50_i2c_transfer_message() - Transfer a message over i2c.
+ * @dev: Device information.
+ * @adapter: I2C adapter.
+ * @msg:Mmessage to transfer.
+ *
+ * Call unlocked i2c transfer routine with the provided parameters and
+ * retry in case of bus errors.
+ *
+ * Return: 0 on success, otherwise negative errno.
+ */
+static int tpm_cr50_i2c_transfer_message(struct device *dev,
+					 struct i2c_adapter *adapter,
+					 struct i2c_msg *msg)
+{
+	int rc;
+	unsigned int try;
+
+	for (try = 0; try < TPM_CR50_I2C_MAX_RETRIES; try++) {
+		rc = __i2c_transfer(adapter, msg, 1);
+		if (rc == 1)
+			return 0; /* Successfully transferred the message */
+		if (try)
+			dev_warn(dev, "i2c transfer failed (attempt %d/%d): %d\n",
+				 try + 1, TPM_CR50_I2C_MAX_RETRIES, rc);
+		usleep_range(TPM_CR50_I2C_RETRY_DELAY_LO,
+			     TPM_CR50_I2C_RETRY_DELAY_HI);
+	}
+
+	return -EIO; /* No i2c message transferred */
+}
+
+/**
+ * tpm_cr50_i2c_read() - Read from TPM register.
+ * @chip: TPM chip information.
+ * @addr: Register address to read from.
+ * @buffer: Read destination, provided by caller.
+ * @len: Number of bytes to read.
+ *
+ * Sends the register address byte to the TPM, then waits until TPM
+ * is ready via interrupt signal or timeout expiration, then 'len'
+ * bytes are read from TPM response into the provided 'buffer'.
+ *
+ * Return: 0 for success or negative error number.
+ */
+static int tpm_cr50_i2c_read(struct tpm_chip *chip, u8 addr, u8 *buffer, size_t len)
+{
+	struct i2c_client *client = to_i2c_client(chip->dev.parent);
+	struct i2c_msg msg_reg_addr = {
+		.addr = client->addr,
+		.len = 1,
+		.buf = &addr
+	};
+	struct i2c_msg msg_response = {
+		.addr = client->addr,
+		.flags = I2C_M_RD,
+		.len = len,
+		.buf = buffer
+	};
+	int rc;
+
+	i2c_lock_bus(client->adapter, I2C_LOCK_SEGMENT);
+
+	/* Prepare for completion interrupt */
+	tpm_cr50_i2c_enable_tpm_irq(chip);
+
+	/* Send the register address byte to the TPM */
+	rc = tpm_cr50_i2c_transfer_message(&chip->dev, client->adapter,
+					   &msg_reg_addr);
+	if (rc < 0)
+		goto out;
+
+	/* Wait for TPM to be ready with response data */
+	rc = tpm_cr50_i2c_wait_tpm_ready(chip);
+	if (rc < 0)
+		goto out;
+
+	/* Read response data from the TPM */
+	rc = tpm_cr50_i2c_transfer_message(&chip->dev, client->adapter,
+					   &msg_response);
+
+out:
+	tpm_cr50_i2c_disable_tpm_irq(chip);
+	i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
+
+	if (rc < 0)
+		return rc;
+
+	return 0;
+}
+
+/**
+ * tpm_cr50_i2c_write()- Write to TPM register.
+ * @chip: TPM chip information.
+ * @addr: Register address to write to.
+ * @buffer: Data to write.
+ * @len: Number of bytes to write.
+ *
+ * The provided address is prepended to the data in 'buffer', the
+ * cobined address+data is sent to the TPM, then wait for TPM to
+ * indicate it is done writing.
+ *
+ * Return: 0 for success or negative error number.
+ */
+static int tpm_cr50_i2c_write(struct tpm_chip *chip, u8 addr, u8 *buffer,
+			      size_t len)
+{
+	struct tpm_i2c_cr50_priv_data *priv = dev_get_drvdata(&chip->dev);
+	struct i2c_client *client = to_i2c_client(chip->dev.parent);
+	struct i2c_msg msg = {
+		.addr = client->addr,
+		.len = len + 1,
+		.buf = priv->buf
+	};
+	int rc;
+
+	if (len > TPM_CR50_MAX_BUFSIZE - 1)
+		return -EINVAL;
+
+	/* Prepend the 'register address' to the buffer */
+	priv->buf[0] = addr;
+	memcpy(priv->buf + 1, buffer, len);
+
+	i2c_lock_bus(client->adapter, I2C_LOCK_SEGMENT);
+
+	/* Prepare for completion interrupt */
+	tpm_cr50_i2c_enable_tpm_irq(chip);
+
+	/* Send write request buffer with address */
+	rc = tpm_cr50_i2c_transfer_message(&chip->dev, client->adapter, &msg);
+	if (rc < 0)
+		goto out;
+
+	/* Wait for TPM to be ready, ignore timeout */
+	tpm_cr50_i2c_wait_tpm_ready(chip);
+
+out:
+	tpm_cr50_i2c_disable_tpm_irq(chip);
+	i2c_unlock_bus(client->adapter, I2C_LOCK_SEGMENT);
+
+	if (rc < 0)
+		return rc;
+
+	return 0;
+}
+
+/**
+ * tpm_cr50_check_locality() - Verify TPM locality 0 is active.
+ * @chip: TPM chip information.
+ *
+ * Return: 0 for success or negative error number.
+ */
+static int tpm_cr50_check_locality(struct tpm_chip *chip)
+{
+	u8 mask = TPM_ACCESS_VALID | TPM_ACCESS_ACTIVE_LOCALITY;
+	u8 buf;
+	int rc;
+
+	rc = tpm_cr50_i2c_read(chip, TPM_I2C_ACCESS(0), &buf, sizeof(buf));
+	if (rc < 0)
+		return rc;
+
+	if ((buf & mask) == mask)
+		return 0;
+
+	return -EIO;
+}
+
+/**
+ * tpm_cr50_release_locality() - Release TPM locality.
+ * @chip: TPM chip information.
+ * @force: flag to force release if set.
+ */
+static void tpm_cr50_release_locality(struct tpm_chip *chip, bool force)
+{
+	u8 mask = TPM_ACCESS_VALID | TPM_ACCESS_REQUEST_PENDING;
+	u8 addr = TPM_I2C_ACCESS(0);
+	u8 buf;
+
+	if (tpm_cr50_i2c_read(chip, addr, &buf, sizeof(buf)) < 0)
+		return;
+
+	if (force || (buf & mask) == mask) {
+		buf = TPM_ACCESS_ACTIVE_LOCALITY;
+		tpm_cr50_i2c_write(chip, addr, &buf, sizeof(buf));
+	}
+}
+
+/**
+ * tpm_cr50_request_locality() - Request TPM locality 0.
+ * @chip: TPM chip information.
+ *
+ * Return: 0 for success or negative error number.
+ */
+static int tpm_cr50_request_locality(struct tpm_chip *chip)
+{
+	u8 buf = TPM_ACCESS_REQUEST_USE;
+	unsigned long stop;
+	int rc;
+
+	if (!tpm_cr50_check_locality(chip))
+		return 0;
+
+	rc = tpm_cr50_i2c_write(chip, TPM_I2C_ACCESS(0), &buf, sizeof(buf));
+	if (rc < 0)
+		return rc;
+
+	stop = jiffies + chip->timeout_a;
+	do {
+		if (!tpm_cr50_check_locality(chip)) {
+			return 0;
+		}
+		msleep(TPM_CR50_TIMEOUT_SHORT_MS);
+	} while (time_before(jiffies, stop));
+
+	return -ETIMEDOUT;
+}
+
+/**
+ * tpm_cr50_i2c_tis_status() - Read cr50 tis status.
+ * @chip: TPM chip information.
+ *
+ * cr50 requires all 4 bytes of status register to be read.
+ *
+ * Return: TPM status byte.
+ */
+static u8 tpm_cr50_i2c_tis_status(struct tpm_chip *chip)
+{
+	u8 buf[4];
+
+	if (tpm_cr50_i2c_read(chip, TPM_I2C_STS(0), buf, sizeof(buf)) < 0)
+		return 0;
+
+	return buf[0];
+}
+
+/**
+ * tpm_cr50_i2c_tis_set_ready() - Set status register to ready.
+ * @chip: TPM chip information.
+ *
+ * cr50 requires all 4 bytes of status register to be written.
+ */
+static void tpm_cr50_i2c_tis_set_ready(struct tpm_chip *chip)
+{
+	u8 buf[4] = { TPM_STS_COMMAND_READY };
+
+	tpm_cr50_i2c_write(chip, TPM_I2C_STS(0), buf, sizeof(buf));
+	msleep(TPM_CR50_TIMEOUT_SHORT_MS);
+}
+
+/**
+ * tpm_cr50_i2c_get_burst_and_status() - Get burst count and status.
+ * @chip: TPM chip information.
+ * @mask: Status mask.
+ * @burst: Return value for burst.
+ * @status: Return value for status.
+ *
+ * cr50 uses bytes 3:2 of status register for burst count and
+ * all 4 bytes must be read.
+ *
+ * Return: 0 for success or negative error number.
+ */
+static int tpm_cr50_i2c_get_burst_and_status(struct tpm_chip *chip, u8 mask,
+					     size_t *burst, u32 *status)
+{
+	unsigned long stop;
+	u8 buf[4];
+
+	*status = 0;
+
+	/* wait for burstcount */
+	stop = jiffies + chip->timeout_b;
+
+	do {
+		if (tpm_cr50_i2c_read(chip, TPM_I2C_STS(0), buf, sizeof(buf)) < 0) {
+			msleep(TPM_CR50_TIMEOUT_SHORT_MS);
+			continue;
+		}
+
+		*status = *buf;
+		*burst = le16_to_cpup((__le16 *)(buf + 1));
+
+		if ((*status & mask) == mask &&
+		    *burst > 0 && *burst <= TPM_CR50_MAX_BUFSIZE - 1)
+			return 0;
+
+		msleep(TPM_CR50_TIMEOUT_SHORT_MS);
+	} while (time_before(jiffies, stop));
+
+	dev_err(&chip->dev, "Timeout reading burst and status\n");
+	return -ETIMEDOUT;
+}
+
+/**
+ * tpm_cr50_i2c_tis_recv() - TPM reception callback.
+ * @chip: TPM chip information.
+ * @buf: Reception buffer.
+ * @buf_len: Buffer length to read.
+ *
+ * Return: Number of read bytes for success, otherwise negative errno.
+ */
+static int tpm_cr50_i2c_tis_recv(struct tpm_chip *chip, u8 *buf, size_t buf_len)
+{
+	int rc;
+	size_t burstcnt, cur, len, expected;
+	u8 addr = TPM_I2C_DATA_FIFO(0);
+	u8 mask = TPM_STS_VALID | TPM_STS_DATA_AVAIL;
+	u32 status;
+
+	if (buf_len < TPM_HEADER_SIZE)
+		return -EINVAL;
+
+	rc = tpm_cr50_i2c_get_burst_and_status(chip, mask, &burstcnt, &status);
+	if (rc < 0)
+		goto out_err;
+
+	if (burstcnt > buf_len || burstcnt < TPM_HEADER_SIZE) {
+		dev_err(&chip->dev,
+			"Unexpected burstcnt: %zu (max=%zu, min=%d)\n",
+			burstcnt, buf_len, TPM_HEADER_SIZE);
+		rc = -EIO;
+		goto out_err;
+	}
+
+	/* Read first chunk of burstcnt bytes */
+	rc = tpm_cr50_i2c_read(chip, addr, buf, burstcnt);
+	if (rc < 0) {
+		dev_err(&chip->dev, "Read of first chunk failed\n");
+		goto out_err;
+	}
+
+	/* Determine expected data in the return buffer */
+	expected = be32_to_cpup((__be32 *)(buf + 2));
+	if (expected > buf_len) {
+		dev_err(&chip->dev, "Buffer too small to receive i2c data\n");
+		goto out_err;
+	}
+
+	/* Now read the rest of the data */
+	cur = burstcnt;
+	while (cur < expected) {
+		/* Read updated burst count and check status */
+		rc = tpm_cr50_i2c_get_burst_and_status(chip, mask, &burstcnt, &status);
+		if (rc < 0)
+			goto out_err;
+
+		len = min_t(size_t, burstcnt, expected - cur);
+		rc = tpm_cr50_i2c_read(chip, addr, buf + cur, len);
+		if (rc < 0) {
+			dev_err(&chip->dev, "Read failed\n");
+			goto out_err;
+		}
+
+		cur += len;
+	}
+
+	/* Ensure TPM is done reading data */
+	rc = tpm_cr50_i2c_get_burst_and_status(chip, TPM_STS_VALID, &burstcnt, &status);
+	if (rc < 0)
+		goto out_err;
+	if (status & TPM_STS_DATA_AVAIL) {
+		dev_err(&chip->dev, "Data still available\n");
+		rc = -EIO;
+		goto out_err;
+	}
+
+	tpm_cr50_release_locality(chip, TPM_I2C_CR50_NO_FORCE);
+	return cur;
+
+out_err:
+	/* Abort current transaction if still pending */
+	if (tpm_cr50_i2c_tis_status(chip) & TPM_STS_COMMAND_READY)
+		tpm_cr50_i2c_tis_set_ready(chip);
+
+	tpm_cr50_release_locality(chip, TPM_I2C_CR50_NO_FORCE);
+	return rc;
+}
+
+/**
+ * tpm_cr50_i2c_tis_send() - TPM transmission callback.
+ * @chip: TPM chip information.
+ * @buf: Buffer to send.
+ * @len: Buffer length.
+ *
+ * Return: 0 for success or negative error number.
+ */
+static int tpm_cr50_i2c_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
+{
+	size_t burstcnt, limit, sent = 0;
+	int rc;
+	u32 status;
+	unsigned long stop;
+	u8 tpm_go[4] = { TPM_STS_GO };
+
+	rc = tpm_cr50_request_locality(chip);
+	if (rc < 0)
+		return rc;
+
+	/* Wait until TPM is ready for a command */
+	stop = jiffies + chip->timeout_b;
+	while (!(tpm_cr50_i2c_tis_status(chip) & TPM_STS_COMMAND_READY)) {
+		if (time_after(jiffies, stop)) {
+			rc = -ETIMEDOUT;
+			goto out_err;
+		}
+
+		tpm_cr50_i2c_tis_set_ready(chip);
+	}
+
+	while (len > 0) {
+		u8 mask = TPM_STS_VALID;
+
+		/* Wait for data if this is not the first chunk */
+		if (sent > 0)
+			mask |= TPM_STS_DATA_EXPECT;
+
+		/* Read burst count and check status */
+		rc = tpm_cr50_i2c_get_burst_and_status(chip, mask, &burstcnt, &status);
+		if (rc < 0)
+			goto out_err;
+
+		/*
+		 * Use burstcnt - 1 to account for the address byte
+		 * that is inserted by tpm_cr50_i2c_write()
+		 */
+		limit = min_t(size_t, burstcnt - 1, len);
+		rc = tpm_cr50_i2c_write(chip, TPM_I2C_DATA_FIFO(0), &buf[sent], limit);
+		if (rc < 0) {
+			dev_err(&chip->dev, "Write failed\n");
+			goto out_err;
+		}
+
+		sent += limit;
+		len -= limit;
+	}
+
+	/* Ensure TPM is not expecting more data */
+	rc = tpm_cr50_i2c_get_burst_and_status(chip, TPM_STS_VALID, &burstcnt, &status);
+	if (rc < 0)
+		goto out_err;
+	if (status & TPM_STS_DATA_EXPECT) {
+		dev_err(&chip->dev, "Data still expected\n");
+		rc = -EIO;
+		goto out_err;
+	}
+
+	/* Start the TPM command */
+	rc = tpm_cr50_i2c_write(chip, TPM_I2C_STS(0), tpm_go,
+			    sizeof(tpm_go));
+	if (rc < 0) {
+		dev_err(&chip->dev, "Start command failed\n");
+		goto out_err;
+	}
+	return 0;
+
+out_err:
+	/* Abort current transaction if still pending */
+	if (tpm_cr50_i2c_tis_status(chip) & TPM_STS_COMMAND_READY)
+		tpm_cr50_i2c_tis_set_ready(chip);
+
+	tpm_cr50_release_locality(chip, TPM_I2C_CR50_NO_FORCE);
+	return rc;
+}
+
+/**
+ * tpm_cr50_i2c_req_canceled() - Callback to notify a request cancel.
+ * @chip: TPM chip information.
+ * @status: Status given by the cancel callback.
+ *
+ * Return: True if command is ready, False otherwise.
+ */
+static bool tpm_cr50_i2c_req_canceled(struct tpm_chip *chip, u8 status)
+{
+	return (status == TPM_STS_COMMAND_READY);
+}
+
+static const struct tpm_class_ops cr50_i2c = {
+	.flags = TPM_OPS_AUTO_STARTUP,
+	.status = &tpm_cr50_i2c_tis_status,
+	.recv = &tpm_cr50_i2c_tis_recv,
+	.send = &tpm_cr50_i2c_tis_send,
+	.cancel = &tpm_cr50_i2c_tis_set_ready,
+	.req_complete_mask = TPM_STS_DATA_AVAIL | TPM_STS_VALID,
+	.req_complete_val = TPM_STS_DATA_AVAIL | TPM_STS_VALID,
+	.req_canceled = &tpm_cr50_i2c_req_canceled,
+};
+
+static const struct i2c_device_id cr50_i2c_table[] = {
+	{"cr50_i2c", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, cr50_i2c_table);
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id cr50_i2c_acpi_id[] = {
+	{ "GOOG0005", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, cr50_i2c_acpi_id);
+#endif
+
+#ifdef CONFIG_OF
+static const struct of_device_id of_cr50_i2c_match[] = {
+	{ .compatible = "google,cr50", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, of_cr50_i2c_match);
+#endif
+
+/**
+ * tpm_cr50_i2c_probe() - Driver probe function.
+ * @client: I2C client information.
+ * @id: I2C device id.
+ *
+ * Return: 0 for success or negative error number.
+ */
+static int tpm_cr50_i2c_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct tpm_chip *chip;
+	struct tpm_i2c_cr50_priv_data *priv;
+	u8 buf[4];
+	u32 vendor;
+	int rc;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -ENODEV;
+
+	chip = tpmm_chip_alloc(dev, &cr50_i2c);
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	/* cr50 is a TPM 2.0 chip */
+	chip->flags |= TPM_CHIP_FLAG_TPM2;
+	chip->flags |= TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED;
+
+	/* Default timeouts */
+	chip->timeout_a = msecs_to_jiffies(TIS_SHORT_TIMEOUT);
+	chip->timeout_b = msecs_to_jiffies(TIS_LONG_TIMEOUT);
+	chip->timeout_c = msecs_to_jiffies(TIS_SHORT_TIMEOUT);
+	chip->timeout_d = msecs_to_jiffies(TIS_SHORT_TIMEOUT);
+
+	dev_set_drvdata(&chip->dev, priv);
+	init_completion(&priv->tpm_ready);
+
+	if (client->irq > 0) {
+		rc = devm_request_irq(dev, client->irq, tpm_cr50_i2c_int_handler,
+				      IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+				      dev->driver->name, chip);
+		if (rc < 0) {
+			dev_err(dev, "Failed to probe IRQ %d\n", client->irq);
+			return rc;
+		}
+
+		disable_irq(client->irq);
+		priv->irq = client->irq;
+	} else {
+		dev_warn(dev, "No IRQ, will use %ums delay for TPM ready\n",
+			 TPM_CR50_TIMEOUT_NOIRQ_MS);
+	}
+
+	rc = tpm_cr50_request_locality(chip);
+	if (rc < 0) {
+		dev_err(dev, "Could not request locality\n");
+		return rc;
+	}
+
+	/* Read four bytes from DID_VID register */
+	rc = tpm_cr50_i2c_read(chip, TPM_I2C_DID_VID(0), buf, sizeof(buf));
+	if (rc < 0) {
+		dev_err(dev, "Could not read vendor id\n");
+		tpm_cr50_release_locality(chip, TPM_I2C_CR50_FORCE);
+		return rc;
+	}
+
+	vendor = le32_to_cpup((__le32 *)buf);
+	if (vendor != TPM_CR50_I2C_DID_VID) {
+		dev_err(dev, "Vendor ID did not match! ID was %08x\n", vendor);
+		tpm_cr50_release_locality(chip, TPM_I2C_CR50_FORCE);
+		return -ENODEV;
+	}
+
+	dev_info(dev, "cr50 TPM 2.0 (i2c 0x%02x irq %d id 0x%x)\n",
+		 client->addr, client->irq, vendor >> 16);
+
+	return tpm_chip_register(chip);
+}
+
+/**
+ * tpm_cr50_i2c_remove() - Driver remove function.
+ * @client: I2C client information.
+ *
+ * Return: 0 for success or negative error number.
+ */
+static int tpm_cr50_i2c_remove(struct i2c_client *client)
+{
+	struct tpm_chip *chip = i2c_get_clientdata(client);
+	struct device *dev = &client->dev;
+
+	if (!chip) {
+		dev_err(dev, "Could not get client data at remove\n");
+		return -ENODEV;
+	}
+
+	tpm_chip_unregister(chip);
+	tpm_cr50_release_locality(chip, TPM_I2C_CR50_FORCE);
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(cr50_i2c_pm, tpm_pm_suspend, tpm_pm_resume);
+
+static struct i2c_driver cr50_i2c_driver = {
+	.id_table = cr50_i2c_table,
+	.probe = tpm_cr50_i2c_probe,
+	.remove = tpm_cr50_i2c_remove,
+	.driver = {
+		.name = "cr50_i2c",
+		.pm = &cr50_i2c_pm,
+		.acpi_match_table = ACPI_PTR(cr50_i2c_acpi_id),
+		.of_match_table = of_match_ptr(of_cr50_i2c_match),
+	},
+};
+
+module_i2c_driver(cr50_i2c_driver);
+
+MODULE_DESCRIPTION("cr50 TPM I2C Driver");
+MODULE_LICENSE("GPL");
-- 
2.29.2

