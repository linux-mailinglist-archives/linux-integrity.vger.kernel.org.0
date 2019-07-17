Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 660FF6C2AE
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2019 23:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfGQVij (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jul 2019 17:38:39 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36574 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfGQVij (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jul 2019 17:38:39 -0400
Received: by mail-pg1-f194.google.com with SMTP id l21so11786748pgm.3
        for <linux-integrity@vger.kernel.org>; Wed, 17 Jul 2019 14:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:to:cc:from:user-agent:date;
        bh=vqm6FmYVMCMbj653BlwIW56fUVEkPV5mCQ6faXZj74s=;
        b=R2LjRwg3x6xLuJMH17/bg6t0nA/+BfmUCGcYX7oARiR8DrNToGgk5iwEDr5gpRzcGF
         AmlrTC2vLVQOSbdNRviefwVnV9np5Cd4TMbH4Vc4eliYa3gg2JyMhKDJPOgxDcp5s3no
         6H3NUg52biL30IILFLLWHVROchLL2BU8HCL7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:to:cc:from
         :user-agent:date;
        bh=vqm6FmYVMCMbj653BlwIW56fUVEkPV5mCQ6faXZj74s=;
        b=CHd4dJ19ewucSLU4XdP5/6FZTwTNko3jtSI1MN+H1c+4cCwpDVi+bHnws6pqVBWV3q
         4cERgbX98jYzqeNBpsNNZYcf1K/7+PHEr0TktS4fcmX6AbiQgCP0RIVCFd8m/eDyahn9
         RCWgFdlJyaSZ8r/jZoyJh96eH02W7z3F8PM8EeUKoPFXP+QHQvSe57ekH/SegMXIkzym
         m+rZ67ZeVR2TArHp+km1dzK2s9D3EC2G4agZhuCZT5BAgubZd/J/CE1yMhXQwA0g5Lkg
         oMsoeqBEAftB5YxIvHz75HjK9veIDfzAQrT2gaU7Wa+zSzDwF9WKK6mPv5FvqZfgXzaF
         2tFA==
X-Gm-Message-State: APjAAAU0fx6xhSH4x15EM4Kd9vuKNBuNQEgG1UsShlshKx9jwnz1Wqk0
        iwzVwbXKsUiK/Ccck654G8gJhg==
X-Google-Smtp-Source: APXvYqwYhz4U6+27P/zTusiNUrzuIiSVmrXfeERFwW+Tv1lAyrfMhP2yylPVHoUfIPv6cXl51rq/Lg==
X-Received: by 2002:a63:c006:: with SMTP id h6mr10098140pgg.290.1563399518264;
        Wed, 17 Jul 2019 14:38:38 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id i14sm43423909pfk.0.2019.07.17.14.38.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 17 Jul 2019 14:38:37 -0700 (PDT)
Message-ID: <5d2f955d.1c69fb81.35877.7018@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5d2f7daf.1c69fb81.c0b13.c3d4@mx.google.com>
References: <20190716224518.62556-1-swboyd@chromium.org> <20190716224518.62556-6-swboyd@chromium.org> <f824e3ab-ae2f-8c2f-549a-16569b10966e@infineon.com> <5d2f7daf.1c69fb81.c0b13.c3d4@mx.google.com>
Subject: Re: [PATCH v2 5/6] tpm: add driver for cr50 on SPI
To:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Cc:     Andrey Pronin <apronin@chromium.org>, linux-kernel@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org,
        Duncan Laurie <dlaurie@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Wed, 17 Jul 2019 14:38:36 -0700
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Quoting Stephen Boyd (2019-07-17 12:57:34)
> Quoting Alexander Steffen (2019-07-17 05:00:06)
> >=20
> > Can't the code be shared more explicitly, e.g. by cr50_spi wrapping=20
> > tpm_tis_spi, so that it can intercept the calls, execute the additional=
=20
> > actions (like waking up the device), but then let tpm_tis_spi do the=20
> > common work?
> >=20
>=20
> I suppose the read{16,32} and write32 functions could be reused. I'm not
> sure how great it will be if we combine these two drivers, but I can
> give it a try today and see how it looks.
>=20

Here's the patch. I haven't tested it besides compile testing.

----8<----
diff --git a/drivers/char/tpm/tpm_tis_spi.c b/drivers/char/tpm/tpm_tis_spi.c
index 19513e622053..12f4026c3620 100644
--- a/drivers/char/tpm/tpm_tis_spi.c
+++ b/drivers/char/tpm/tpm_tis_spi.c
@@ -34,14 +34,54 @@
 #include <linux/of_irq.h>
 #include <linux/of_gpio.h>
 #include <linux/tpm.h>
+#include "cr50.h"
 #include "tpm.h"
 #include "tpm_tis_core.h"
=20
 #define MAX_SPI_FRAMESIZE 64
=20
+/*
+ * Cr50 timing constants:
+ * - can go to sleep not earlier than after CR50_SLEEP_DELAY_MSEC.
+ * - needs up to CR50_WAKE_START_DELAY_USEC to wake after sleep.
+ * - requires waiting for "ready" IRQ, if supported; or waiting for at lea=
st
+ *   CR50_NOIRQ_ACCESS_DELAY_MSEC between transactions, if IRQ is not supp=
orted.
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
+#define TIS_IS_CR50				1
+
+static unsigned short rng_quality =3D 1022;
+module_param(rng_quality, ushort, 0644);
+MODULE_PARM_DESC(rng_quality,
+		 "Estimation of true entropy, in bits per 1024 bits.");
+
+
 struct tpm_tis_spi_phy {
 	struct tpm_tis_data priv;
 	struct spi_device *spi_device;
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
+	bool is_cr50;
+
 	u8 *iobuf;
 };
=20
@@ -50,6 +90,127 @@ static inline struct tpm_tis_spi_phy *to_tpm_tis_spi_ph=
y(struct tpm_tis_data *da
 	return container_of(data, struct tpm_tis_spi_phy, priv);
 }
=20
+/*
+ * The cr50 interrupt handler just signals waiting threads that the
+ * interrupt was asserted.  It does not do any processing triggered
+ * by interrupts but is instead used to avoid fixed delays.
+ */
+static irqreturn_t cr50_spi_irq_handler(int dummy, void *dev_id)
+{
+	struct tpm_tis_spi_phy *phy =3D dev_id;
+
+	phy->irq_confirmed =3D true;
+	complete(&phy->ready);
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * Cr50 needs to have at least some delay between consecutive
+ * transactions. Make sure we wait.
+ */
+static void cr50_ensure_access_delay(struct tpm_tis_spi_phy *phy)
+{
+	unsigned long allowed_access =3D phy->last_access + phy->access_delay;
+	unsigned long time_now =3D jiffies;
+	struct device *dev =3D &phy->spi_device->dev;
+
+	/*
+	 * Note: There is a small chance, if Cr50 is not accessed in a few days,
+	 * that time_in_range will not provide the correct result after the wrap
+	 * around for jiffies. In this case, we'll have an unneeded short delay,
+	 * which is fine.
+	 */
+	if (time_in_range_open(time_now, phy->last_access, allowed_access)) {
+		unsigned long remaining, timeout =3D allowed_access - time_now;
+
+		remaining =3D wait_for_completion_timeout(&phy->ready, timeout);
+		if (!remaining && phy->irq_confirmed)
+			dev_warn(dev, "Timeout waiting for TPM ready IRQ\n");
+	}
+
+	if (phy->irq_needs_confirmation) {
+		unsigned int attempt =3D ++phy->irq_confirmation_attempt;
+
+		if (phy->irq_confirmed) {
+			phy->irq_needs_confirmation =3D false;
+			phy->access_delay =3D CR50_READY_IRQ_TIMEOUT;
+			dev_info(dev, "TPM ready IRQ confirmed on attempt %u\n",
+				 attempt);
+		} else if (attempt > MAX_IRQ_CONFIRMATION_ATTEMPTS) {
+			phy->irq_needs_confirmation =3D false;
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
+static bool cr50_needs_waking(struct tpm_tis_spi_phy *phy)
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
+static void cr50_wake_if_needed(struct tpm_tis_spi_phy *phy)
+{
+	if (cr50_needs_waking(phy)) {
+		/* Assert CS, wait 1 msec, deassert CS */
+		struct spi_transfer spi_cs_wake =3D { .delay_usecs =3D 1000 };
+
+		spi_sync_transfer(phy->spi_device, &spi_cs_wake, 1);
+		/* Wait for it to fully wake */
+		usleep_range(CR50_WAKE_START_DELAY_USEC,
+			     CR50_WAKE_START_DELAY_USEC * 2);
+	}
+	/* Reset the time when we need to wake Cr50 again */
+	phy->wake_after =3D jiffies + msecs_to_jiffies(CR50_SLEEP_DELAY_MSEC);
+
+}
+
+/*
+ * Flow control: clock the bus and wait for cr50 to set LSB before
+ * sending/receiving data. TCG PTP spec allows it to happen during
+ * the last byte of header, but cr50 never does that in practice,
+ * and earlier versions had a bug when it was set too early, so don't
+ * check for it during header transfer.
+ */
+static int cr50_spi_flow_control(struct tpm_tis_spi_phy *phy)
+{
+	struct device *dev =3D &phy->spi_device->dev;
+	unsigned long timeout =3D jiffies + CR50_FLOW_CONTROL;
+	struct spi_message m;
+	int ret;
+	struct spi_transfer spi_xfer =3D {
+		.rx_buf =3D phy->iobuf,
+		.len =3D 1,
+		.cs_change =3D 1,
+	};
+
+	do {
+		spi_message_init(&m);
+		spi_message_add_tail(&spi_xfer, &m);
+		ret =3D spi_sync_locked(phy->spi_device, &m);
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
 static int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 l=
en,
 				u8 *in, const u8 *out)
 {
@@ -60,6 +221,12 @@ static int tpm_tis_spi_transfer(struct tpm_tis_data *da=
ta, u32 addr, u16 len,
 	struct spi_transfer spi_xfer;
 	u8 transfer_len;
=20
+	mutex_lock(&phy->time_track_mutex);
+	if (phy->is_cr50) {
+		cr50_ensure_access_delay(phy);
+		cr50_wake_if_needed(phy);
+	}
+
 	spi_bus_lock(phy->spi_device->master);
=20
 	while (len) {
@@ -82,7 +249,11 @@ static int tpm_tis_spi_transfer(struct tpm_tis_data *da=
ta, u32 addr, u16 len,
 		if (ret < 0)
 			goto exit;
=20
-		if ((phy->iobuf[3] & 0x01) =3D=3D 0) {
+		if (phy->is_cr50) {
+			ret =3D cr50_spi_flow_control(phy);
+			if (ret < 0)
+				goto exit;
+		} else if ((phy->iobuf[3] & 0x01) =3D=3D 0) {
 			// handle SPI wait states
 			phy->iobuf[0] =3D 0;
=20
@@ -117,6 +288,7 @@ static int tpm_tis_spi_transfer(struct tpm_tis_data *da=
ta, u32 addr, u16 len,
=20
 		spi_message_init(&m);
 		spi_message_add_tail(&spi_xfer, &m);
+		reinit_completion(&phy->ready);
 		ret =3D spi_sync_locked(phy->spi_device, &m);
 		if (ret < 0)
 			goto exit;
@@ -131,6 +303,8 @@ static int tpm_tis_spi_transfer(struct tpm_tis_data *da=
ta, u32 addr, u16 len,
=20
 exit:
 	spi_bus_unlock(phy->spi_device->master);
+	phy->last_access =3D jiffies;
+	mutex_lock(&phy->time_track_mutex);
 	return ret;
 }
=20
@@ -192,10 +366,37 @@ static const struct tpm_tis_phy_ops tpm_spi_phy_ops =
=3D {
 	.write32 =3D tpm_tis_spi_write32,
 };
=20
+static void cr50_print_fw_version(struct tpm_tis_spi_phy *phy)
+{
+	int i, len =3D 0;
+	char fw_ver[TPM_CR50_MAX_FW_VER_LEN + 1];
+	char fw_ver_block[4];
+	struct tpm_tis_data *data =3D &phy->priv;
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
+		for (i =3D 0; i < 4 && fw_ver_block[i]; ++len, ++i)
+			fw_ver[len] =3D fw_ver_block[i];
+	} while (i =3D=3D 4 && len < TPM_CR50_MAX_FW_VER_LEN);
+	fw_ver[len] =3D '\0';
+
+	dev_info(&phy->spi_device->dev, "Cr50 firmware version: %s\n", fw_ver);
+}
+
 static int tpm_tis_spi_probe(struct spi_device *dev)
 {
 	struct tpm_tis_spi_phy *phy;
-	int irq;
+	int ret, irq =3D -1;
+	struct device_node *np =3D dev->dev.of_node;
+	const struct spi_device_id *spi_dev_id =3D spi_get_device_id(dev);
=20
 	phy =3D devm_kzalloc(&dev->dev, sizeof(struct tpm_tis_spi_phy),
 			   GFP_KERNEL);
@@ -208,17 +409,94 @@ static int tpm_tis_spi_probe(struct spi_device *dev)
 	if (!phy->iobuf)
 		return -ENOMEM;
=20
-	/* If the SPI device has an IRQ then use that */
-	if (dev->irq > 0)
+	phy->is_cr50 =3D of_device_is_compatible(np, "google,cr50") ||
+		       (spi_dev_id && spi_dev_id->driver_data =3D=3D TIS_IS_CR50);
+
+	if (phy->is_cr50) {
+		phy->access_delay =3D CR50_NOIRQ_ACCESS_DELAY;
+
+		mutex_init(&phy->time_track_mutex);
+		phy->wake_after =3D jiffies;
+		phy->last_access =3D jiffies;
+
+		init_completion(&phy->ready);
+		if (dev->irq > 0) {
+			ret =3D devm_request_irq(&dev->dev, dev->irq, cr50_spi_irq_handler,
+					       IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+					       "cr50_spi", phy);
+			if (ret < 0) {
+				if (ret =3D=3D -EPROBE_DEFER)
+					return ret;
+				dev_warn(&dev->dev, "Requesting IRQ %d failed: %d\n",
+					 dev->irq, ret);
+				/*
+				 * This is not fatal, the driver will fall back to
+				 * delays automatically, since ready will never
+				 * be completed without a registered irq handler.
+				 * So, just fall through.
+				 */
+			} else {
+				/*
+				 * IRQ requested, let's verify that it is actually
+				 * triggered, before relying on it.
+				 */
+				phy->irq_needs_confirmation =3D true;
+			}
+		} else {
+			dev_warn(&dev->dev,
+				 "No IRQ - will use delays between transactions.\n");
+		}
+
+		phy->priv.rng_quality =3D rng_quality;
+	} else if (dev->irq > 0) {
+		/* If the SPI device has an IRQ then use that */
 		irq =3D dev->irq;
-	else
-		irq =3D -1;
+	}
=20
-	return tpm_tis_core_init(&dev->dev, &phy->priv, irq, &tpm_spi_phy_ops,
+	ret =3D tpm_tis_core_init(&dev->dev, &phy->priv, irq, &tpm_spi_phy_ops,
 				 NULL);
+
+	if (!ret && phy->is_cr50)
+		cr50_print_fw_version(phy);
+
+	return ret;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int tpm_tis_spi_pm_suspend(struct device *dev)
+{
+	struct tpm_chip *chip =3D dev_get_drvdata(dev);
+	struct tpm_tis_data *data =3D dev_get_drvdata(&chip->dev);
+	struct tpm_tis_spi_phy *phy =3D to_tpm_tis_spi_phy(data);
+
+	if (phy->is_cr50)
+		return cr50_suspend(dev);
+
+	return tpm_pm_suspend(dev);
+}
+
+static int tpm_tis_spi_pm_resume(struct device *dev)
+{
+	struct tpm_chip *chip =3D dev_get_drvdata(dev);
+	struct tpm_tis_data *data =3D dev_get_drvdata(&chip->dev);
+	struct tpm_tis_spi_phy *phy =3D to_tpm_tis_spi_phy(data);
+
+	if (phy->is_cr50) {
+		/*
+		 * Jiffies not increased during suspend, so we need to reset
+		 * the time to wake Cr50 after resume.
+		 */
+		phy->wake_after =3D jiffies;
+
+		return cr50_resume(dev);
+	}
+
+	return tpm_tis_resume(dev);
 }
+#endif
=20
-static SIMPLE_DEV_PM_OPS(tpm_tis_pm, tpm_pm_suspend, tpm_tis_resume);
+static SIMPLE_DEV_PM_OPS(tpm_tis_pm,
+			 tpm_tis_spi_pm_suspend, tpm_tis_spi_pm_resume);
=20
 static int tpm_tis_spi_remove(struct spi_device *dev)
 {
@@ -230,12 +508,14 @@ static int tpm_tis_spi_remove(struct spi_device *dev)
 }
=20
 static const struct spi_device_id tpm_tis_spi_id[] =3D {
+	{"cr50", TIS_IS_CR50},
 	{"tpm_tis_spi", 0},
 	{}
 };
 MODULE_DEVICE_TABLE(spi, tpm_tis_spi_id);
=20
 static const struct of_device_id of_tis_spi_match[] =3D {
+	{ .compatible =3D "google,cr50", },
 	{ .compatible =3D "st,st33htpm-spi", },
 	{ .compatible =3D "infineon,slb9670", },
 	{ .compatible =3D "tcg,tpm_tis-spi", },
