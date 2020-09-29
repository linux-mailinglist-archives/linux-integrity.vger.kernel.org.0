Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66BD027DC1D
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Sep 2020 00:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgI2WdZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Sep 2020 18:33:25 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51274 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728142AbgI2WdY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Sep 2020 18:33:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 84F0D8EE19D;
        Tue, 29 Sep 2020 15:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1601418804;
        bh=x9u7BL+cuz8PPPXgS9xKcqN0TzaUQ46dQl/S+URAGoQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WZxrh25vnVq2I6usk7up7Yq/nckR7y00N+BflZcMxC1ViD7T9noNe3Hof1kcDoHTW
         cPP67k2t99bTbnoV+mIs1dhitPMV++J/yRaEHk+kUVdO6yxfov3YrcEvmTN2pJYlxF
         LVdKBJ2wqNRClfdhk0B2huaYYa/iT+D5jgktqfIo=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GGM7LrVeysbE; Tue, 29 Sep 2020 15:33:24 -0700 (PDT)
Received: from jarvis.int.hansenpartnership.com (jarvis.ext.hansenpartnership.com [153.66.160.226])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1738B8EE119;
        Tue, 29 Sep 2020 15:33:24 -0700 (PDT)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: [PATCH 2/4] tpm_tis: Fix interrupts for TIS TPMs without legacy cycles
Date:   Tue, 29 Sep 2020 15:32:14 -0700
Message-Id: <20200929223216.22584-3-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200929223216.22584-1-James.Bottomley@HansenPartnership.com>
References: <20200929223216.22584-1-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

If a TIS TPM doesn't have legacy cycles, any write to the interrupt
registers is ignored unless a locality is active.  This means even to
set up the interrupt vectors a locality must first be activated.  Fix
this by activating the 0 locality in the interrupt probe setup.

Since the TPM_EOI signalling also requires an active locality, the
interrupt routine cannot end an interrupt if the locality is released.
This can lead to a situation where the TPM goes command ready after
locality release and since the interrupt cannot be ended it refires
continuously.  Fix this by disabling all interrupts except locality
change when a locality is released (this only fires when a locality
becomes active, meaning the TPM_EOI should work).

Finally, since we now disable all status based interrupts in the
locality release, they must be re-enabled before waiting to check the
condition, so add interrupt enabling to the status wait.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm_tis_core.c | 125 ++++++++++++++++++++++++++------
 1 file changed, 101 insertions(+), 24 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index a9fa40714c64..02cc384fdaea 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -29,6 +29,46 @@
 
 static void tpm_tis_clkrun_enable(struct tpm_chip *chip, bool value);
 
+static void enable_interrupt(struct tpm_chip *chip, u8 mask)
+{
+	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
+	u32 intmask;
+
+	/* Take control of the TPM's interrupt hardware and shut it off */
+	tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
+
+	intmask |= mask | TPM_GLOBAL_INT_ENABLE;
+
+	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
+}
+
+static void disable_interrupt(struct tpm_chip *chip, u8 mask)
+{
+	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
+	u32 intmask;
+
+	/* Take control of the TPM's interrupt hardware and shut it off */
+	tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
+
+	intmask &= ~mask;
+
+	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
+}
+
+static void enable_stat_interrupt(struct tpm_chip *chip, u8 stat)
+{
+	u32 mask = 0;
+
+	if (stat & TPM_STS_COMMAND_READY)
+		mask |= TPM_INTF_CMD_READY_INT;
+	if (stat & TPM_STS_VALID)
+		mask |= TPM_INTF_STS_VALID_INT;
+	if (stat & TPM_STS_DATA_AVAIL)
+		mask |= TPM_INTF_DATA_AVAIL_INT;
+
+	enable_interrupt(chip, mask);
+}
+
 static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8 mask,
 					bool check_cancel, bool *canceled)
 {
@@ -65,11 +105,14 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8 mask,
 		timeout = stop - jiffies;
 		if ((long)timeout <= 0)
 			return -ETIME;
+		enable_stat_interrupt(chip, mask);
 		rc = wait_event_interruptible_timeout(*queue,
 			wait_for_tpm_stat_cond(chip, mask, check_cancel,
 					       &canceled),
 			timeout);
 		if (rc > 0) {
+			if (rc == 1)
+				dev_err(&chip->dev, "Lost Interrupt waiting for TPM stat\n");
 			if (canceled)
 				return -ECANCELED;
 			return 0;
@@ -137,6 +180,28 @@ static bool check_locality(struct tpm_chip *chip, int l)
 static int release_locality(struct tpm_chip *chip, int l)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
+	u32 int_status;
+	int rc;
+
+	/*
+	 * Note that once we relinquish the locality, all writes to
+	 * the interrupt registers become ineffective meaning we can't
+	 * do a TPM_EOI.  This means we must disable every interrupt
+	 * except the locality change one to avoid interrupt
+	 * storms.
+	 */
+	disable_interrupt(chip, TPM_INTF_CMD_READY_INT
+			  | TPM_INTF_STS_VALID_INT
+			  | TPM_INTF_DATA_AVAIL_INT);
+
+	rc = tpm_tis_read32(priv, TPM_INT_STATUS(priv->locality), &int_status);
+	if (rc < 0)
+		return rc;
+
+	/* Clear all pending */
+	rc = tpm_tis_write32(priv, TPM_INT_STATUS(priv->locality), int_status);
+	if (rc < 0)
+		return rc;
 
 	tpm_tis_write8(priv, TPM_ACCESS(l), TPM_ACCESS_ACTIVE_LOCALITY);
 
@@ -163,12 +228,17 @@ static int request_locality(struct tpm_chip *chip, int l)
 		timeout = stop - jiffies;
 		if ((long)timeout <= 0)
 			return -1;
+
 		rc = wait_event_interruptible_timeout(priv->int_queue,
 						      (check_locality
 						       (chip, l)),
 						      timeout);
-		if (rc > 0)
+		if (rc > 1)
+			return l;
+		if (rc == 1) {
+			dev_info(&chip->dev, "Lost Interrupt waiting for locality\n");
 			return l;
+		}
 		if (rc == -ERESTARTSYS && freezing(current)) {
 			clear_thread_flag(TIF_SIGPENDING);
 			goto again;
@@ -464,6 +534,10 @@ static int tpm_tis_send(struct tpm_chip *chip, u8 *buf, size_t len)
 	irq = priv->irq;
 	priv->irq = 0;
 	chip->flags &= ~TPM_CHIP_FLAG_IRQ;
+	enable_interrupt(chip, TPM_INTF_CMD_READY_INT
+			 | TPM_INTF_LOCALITY_CHANGE_INT
+			 | TPM_INTF_DATA_AVAIL_INT
+			 | TPM_INTF_STS_VALID_INT);
 	rc = tpm_tis_send_main(chip, buf, len);
 	priv->irq = irq;
 	chip->flags |= TPM_CHIP_FLAG_IRQ;
@@ -718,7 +792,7 @@ static int tpm_tis_gen_interrupt(struct tpm_chip *chip)
  * irq is seen then leave the chip setup for IRQ operation, otherwise reverse
  * everything and leave in polling mode. Returns 0 on success.
  */
-static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
+static int tpm_tis_probe_irq_single(struct tpm_chip *chip,
 				    int flags, int irq)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
@@ -752,9 +826,11 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
 	if (rc < 0)
 		return rc;
 
-	/* Turn on */
-	rc = tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality),
-			     intmask | TPM_GLOBAL_INT_ENABLE);
+	/*
+	 * Turn on.  The locality change interrupt is the only one
+	 * always enabled
+	 */
+	enable_interrupt(chip, TPM_INTF_LOCALITY_CHANGE_INT);
 	if (rc < 0)
 		return rc;
 
@@ -786,7 +862,7 @@ static int tpm_tis_probe_irq_single(struct tpm_chip *chip, u32 intmask,
  * do not have ACPI/etc. We typically expect the interrupt to be declared if
  * present.
  */
-static void tpm_tis_probe_irq(struct tpm_chip *chip, u32 intmask)
+static void tpm_tis_probe_irq(struct tpm_chip *chip)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
 	u8 original_int_vec;
@@ -800,11 +876,9 @@ static void tpm_tis_probe_irq(struct tpm_chip *chip, u32 intmask)
 	if (!original_int_vec) {
 		if (IS_ENABLED(CONFIG_X86))
 			for (i = 3; i <= 15; i++)
-				if (!tpm_tis_probe_irq_single(chip, intmask, 0,
-							      i))
+				if (!tpm_tis_probe_irq_single(chip, 0, i))
 					return;
-	} else if (!tpm_tis_probe_irq_single(chip, intmask, 0,
-					     original_int_vec))
+	} else if (!tpm_tis_probe_irq_single(chip, 0, original_int_vec))
 		return;
 }
 
@@ -1029,8 +1103,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 		}
 
 		if (irq) {
-			tpm_tis_probe_irq_single(chip, intmask, IRQF_SHARED,
-						 irq);
+			tpm_tis_probe_irq_single(chip, IRQF_SHARED, irq);
 			if (!(chip->flags & TPM_CHIP_FLAG_IRQ)) {
 				dev_err(&chip->dev, FW_BUG
 					"TPM interrupt not working, polling instead\n");
@@ -1038,7 +1111,7 @@ int tpm_tis_core_init(struct device *dev, struct tpm_tis_data *priv, int irq,
 				disable_interrupts(chip);
 			}
 		} else {
-			tpm_tis_probe_irq(chip, intmask);
+			tpm_tis_probe_irq(chip);
 		}
 	}
 
@@ -1064,12 +1137,23 @@ EXPORT_SYMBOL_GPL(tpm_tis_core_init);
 static void tpm_tis_reenable_interrupts(struct tpm_chip *chip)
 {
 	struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);
-	u32 intmask;
 	int rc;
 
 	if (chip->ops->clk_enable != NULL)
 		chip->ops->clk_enable(chip, true);
 
+	/*
+	 * must have the locality before we can enable interrupts, so
+	 * poll for the locality being ready
+	 */
+	chip->flags &= ~TPM_CHIP_FLAG_IRQ;
+	if (request_locality(chip, 0) != 0) {
+		dev_err(&chip->dev, "Failed to enable interrupts after suspend\n");
+		goto out;
+	}
+	chip->flags |= TPM_CHIP_FLAG_IRQ;
+
+
 	/* reenable interrupts that device may have lost or
 	 * BIOS/firmware may have disabled
 	 */
@@ -1077,17 +1161,10 @@ static void tpm_tis_reenable_interrupts(struct tpm_chip *chip)
 	if (rc < 0)
 		goto out;
 
-	rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
-	if (rc < 0)
-		goto out;
-
-	intmask |= TPM_INTF_CMD_READY_INT
-	    | TPM_INTF_LOCALITY_CHANGE_INT | TPM_INTF_DATA_AVAIL_INT
-	    | TPM_INTF_STS_VALID_INT | TPM_GLOBAL_INT_ENABLE;
+	enable_interrupt(chip, TPM_INTF_LOCALITY_CHANGE_INT);
 
-	tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);
-
-out:
+ out:
+	release_locality(chip, 0);
 	if (chip->ops->clk_enable != NULL)
 		chip->ops->clk_enable(chip, false);
 
-- 
2.28.0

