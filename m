Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2878B42BB67
	for <lists+linux-integrity@lfdr.de>; Wed, 13 Oct 2021 11:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237139AbhJMJX6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 13 Oct 2021 05:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbhJMJX6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 13 Oct 2021 05:23:58 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F44C061570;
        Wed, 13 Oct 2021 02:21:55 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id k7so5927662wrd.13;
        Wed, 13 Oct 2021 02:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uNF3RaS9/sT6+odi9lPrDXDb6WsY4KBhg798xoiyr2U=;
        b=S4XDCjW/x/6OCUR8iwHWtZpbbNAmXo8e/Y6RlwvN7mTmo265/Fbzc8Viq+M8qYJIBP
         KlHrQolgEa/tRH8M1CzW4Rwlss4o4g/ZdiSukT6oU0dadX4/UQ15oVTi/Dp/gmSfYJmH
         ngDCFAtMdGNHAwi8qPK/qMMQ/TU1pKHa1fIIukZ/+Dr6BjzbvG9yYn3CKoeXdn3itQDl
         kAHYMjZdMKcEfdZLn2+KUVL7iY4rQfwVmyBM/JkqtN/ijjR5dMnJ5hUXqx+iCvrqpQiO
         bKrbusQVxnmZwBMOWcb1GgYW15jCMojBDRDWEe2LaHaHUzAIRSrobF8uQmj8ShbFHnyN
         Bh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uNF3RaS9/sT6+odi9lPrDXDb6WsY4KBhg798xoiyr2U=;
        b=geofRnYb5ne/jZa0JTlJY/+v7Z9D6s79AtQeIykqMtE13VGRzFXh4NFIdgsNbIPe8u
         2p6FSlobPXWyjnfsMtQGUB40oy9dLyGWYrIOHVRM0MjWgAB0C2l+VjCRg3JmfwZ8ZgFx
         K+UXqi5PJetCUlyPk7qv69xwYOHamgLAw1iCgFniOQIoBKHlG6oVTktbczSu1dO7p7sG
         2H40HpZvZm/jrhQpxRPYrgJmFDbeUx5w6tLhnJWfDhxC3xz/9xvl0QC37eejVkuuezEE
         S/HgCliar00RPhKontDOfe4Wakep1iVvDyC2L/Fbap63EVVrM/5QHXO1u08B9HwXEA25
         aWcA==
X-Gm-Message-State: AOAM5335APTG9WA4VD7oVk9j/9MdoRiiLxWZloBKkfYZFA57O+ZmD4pR
        0tgdCxKYdFgvbb/8Az+7fqvv6E0OCg4=
X-Google-Smtp-Source: ABdhPJzUG/lOcQzZFiCabW109RZ2NKZEzrsblv2fjahzzsvRyq7VSkw3eA/d2CbWrTUpCKNMmvHRDA==
X-Received: by 2002:a05:6000:1aca:: with SMTP id i10mr39125044wry.207.1634116913746;
        Wed, 13 Oct 2021 02:21:53 -0700 (PDT)
Received: from localhost.localdomain ([197.49.234.11])
        by smtp.gmail.com with ESMTPSA id z6sm7184636wmp.1.2021.10.13.02.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 02:21:53 -0700 (PDT)
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
To:     sohaib.amhmd@gmail.com
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] tpm/st33zp24: drop unneeded over-commenting
Date:   Wed, 13 Oct 2021 11:21:50 +0200
Message-Id: <20211013092151.11835-1-sohaib.amhmd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Remove parameter descriptions from all static functions.
Remove the comment altogether that does not tell what the function does.

Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
---
 drivers/char/tpm/st33zp24/st33zp24.c | 122 ++++-----------------------
 1 file changed, 17 insertions(+), 105 deletions(-)

diff --git a/drivers/char/tpm/st33zp24/st33zp24.c b/drivers/char/tpm/st33zp24/st33zp24.c
index 4ec10ab5e576..ce9efb73c144 100644
--- a/drivers/char/tpm/st33zp24/st33zp24.c
+++ b/drivers/char/tpm/st33zp24/st33zp24.c
@@ -61,9 +61,7 @@ enum tis_defaults {
 };
 
 /*
- * clear_interruption clear the pending interrupt.
- * @param: tpm_dev, the tpm device device.
- * @return: the interrupt status value.
+ * clear the pending interrupt.
  */
 static u8 clear_interruption(struct st33zp24_dev *tpm_dev)
 {
@@ -72,12 +70,10 @@ static u8 clear_interruption(struct st33zp24_dev *tpm_dev)
 	tpm_dev->ops->recv(tpm_dev->phy_id, TPM_INT_STATUS, &interrupt, 1);
 	tpm_dev->ops->send(tpm_dev->phy_id, TPM_INT_STATUS, &interrupt, 1);
 	return interrupt;
-} /* clear_interruption() */
+}
 
 /*
- * st33zp24_cancel, cancel the current command execution or
- * set STS to COMMAND READY.
- * @param: chip, the tpm_chip description as specified in driver/char/tpm/tpm.h
+ * cancel the current command execution or set STS to COMMAND READY.
  */
 static void st33zp24_cancel(struct tpm_chip *chip)
 {
@@ -86,12 +82,10 @@ static void st33zp24_cancel(struct tpm_chip *chip)
 
 	data = TPM_STS_COMMAND_READY;
 	tpm_dev->ops->send(tpm_dev->phy_id, TPM_STS, &data, 1);
-} /* st33zp24_cancel() */
+}
 
 /*
- * st33zp24_status return the TPM_STS register
- * @param: chip, the tpm chip description
- * @return: the TPM_STS register value.
+ * return the TPM_STS register
  */
 static u8 st33zp24_status(struct tpm_chip *chip)
 {
@@ -100,12 +94,10 @@ static u8 st33zp24_status(struct tpm_chip *chip)
 
 	tpm_dev->ops->recv(tpm_dev->phy_id, TPM_STS, &data, 1);
 	return data;
-} /* st33zp24_status() */
+}
 
 /*
- * check_locality if the locality is active
- * @param: chip, the tpm chip description
- * @return: true if LOCALITY0 is active, otherwise false
+ * if the locality is active
  */
 static bool check_locality(struct tpm_chip *chip)
 {
@@ -120,13 +112,8 @@ static bool check_locality(struct tpm_chip *chip)
 		return true;
 
 	return false;
-} /* check_locality() */
+}
 
-/*
- * request_locality request the TPM locality
- * @param: chip, the chip description
- * @return: the active locality or negative value.
- */
 static int request_locality(struct tpm_chip *chip)
 {
 	struct st33zp24_dev *tpm_dev = dev_get_drvdata(&chip->dev);
@@ -153,12 +140,8 @@ static int request_locality(struct tpm_chip *chip)
 
 	/* could not get locality */
 	return -EACCES;
-} /* request_locality() */
+}
 
-/*
- * release_locality release the active locality
- * @param: chip, the tpm chip description.
- */
 static void release_locality(struct tpm_chip *chip)
 {
 	struct st33zp24_dev *tpm_dev = dev_get_drvdata(&chip->dev);
@@ -171,8 +154,6 @@ static void release_locality(struct tpm_chip *chip)
 
 /*
  * get_burstcount return the burstcount value
- * @param: chip, the chip description
- * return: the burstcount or negative value.
  */
 static int get_burstcount(struct tpm_chip *chip)
 {
@@ -200,18 +181,8 @@ static int get_burstcount(struct tpm_chip *chip)
 		msleep(TPM_TIMEOUT);
 	} while (time_before(jiffies, stop));
 	return -EBUSY;
-} /* get_burstcount() */
-
+}
 
-/*
- * wait_for_tpm_stat_cond
- * @param: chip, chip description
- * @param: mask, expected mask value
- * @param: check_cancel, does the command expected to be canceled ?
- * @param: canceled, did we received a cancel request ?
- * @return: true if status == mask or if the command is canceled.
- * false in other cases.
- */
 static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8 mask,
 				bool check_cancel, bool *canceled)
 {
@@ -228,13 +199,7 @@ static bool wait_for_tpm_stat_cond(struct tpm_chip *chip, u8 mask,
 }
 
 /*
- * wait_for_stat wait for a TPM_STS value
- * @param: chip, the tpm chip description
- * @param: mask, the value mask to wait
- * @param: timeout, the timeout
- * @param: queue, the wait queue.
- * @param: check_cancel, does the command can be cancelled ?
- * @return: the tpm status, 0 if success, -ETIME if timeout is reached.
+ * wait for a TPM_STS value
  */
 static int wait_for_stat(struct tpm_chip *chip, u8 mask, unsigned long timeout,
 			wait_queue_head_t *queue, bool check_cancel)
@@ -292,15 +257,8 @@ static int wait_for_stat(struct tpm_chip *chip, u8 mask, unsigned long timeout,
 	}
 
 	return -ETIME;
-} /* wait_for_stat() */
+}
 
-/*
- * recv_data receive data
- * @param: chip, the tpm chip description
- * @param: buf, the buffer where the data are received
- * @param: count, the number of data to receive
- * @return: the number of bytes read from TPM FIFO.
- */
 static int recv_data(struct tpm_chip *chip, u8 *buf, size_t count)
 {
 	struct st33zp24_dev *tpm_dev = dev_get_drvdata(&chip->dev);
@@ -325,12 +283,6 @@ static int recv_data(struct tpm_chip *chip, u8 *buf, size_t count)
 	return size;
 }
 
-/*
- * tpm_ioserirq_handler the serirq irq handler
- * @param: irq, the tpm chip description
- * @param: dev_id, the description of the chip
- * @return: the status of the handler.
- */
 static irqreturn_t tpm_ioserirq_handler(int irq, void *dev_id)
 {
 	struct tpm_chip *chip = dev_id;
@@ -341,16 +293,10 @@ static irqreturn_t tpm_ioserirq_handler(int irq, void *dev_id)
 	disable_irq_nosync(tpm_dev->irq);
 
 	return IRQ_HANDLED;
-} /* tpm_ioserirq_handler() */
+}
 
 /*
- * st33zp24_send send TPM commands through the I2C bus.
- *
- * @param: chip, the tpm_chip description as specified in driver/char/tpm/tpm.h
- * @param: buf,	the buffer to send.
- * @param: count, the number of bytes to send.
- * @return: In case of success the number of bytes sent.
- *			In other case, a < 0 value describing the issue.
+ * send TPM commands through the I2C bus.
  */
 static int st33zp24_send(struct tpm_chip *chip, unsigned char *buf,
 			 size_t len)
@@ -431,14 +377,6 @@ static int st33zp24_send(struct tpm_chip *chip, unsigned char *buf,
 	return ret;
 }
 
-/*
- * st33zp24_recv received TPM response through TPM phy.
- * @param: chip, the tpm_chip description as specified in driver/char/tpm/tpm.h.
- * @param: buf,	the buffer to store datas.
- * @param: count, the number of bytes to send.
- * @return: In case of success the number of bytes received.
- *	    In other case, a < 0 value describing the issue.
- */
 static int st33zp24_recv(struct tpm_chip *chip, unsigned char *buf,
 			    size_t count)
 {
@@ -478,12 +416,6 @@ static int st33zp24_recv(struct tpm_chip *chip, unsigned char *buf,
 	return size;
 }
 
-/*
- * st33zp24_req_canceled
- * @param: chip, the tpm_chip description as specified in driver/char/tpm/tpm.h.
- * @param: status, the TPM status.
- * @return: Does TPM ready to compute a new command ? true.
- */
 static bool st33zp24_req_canceled(struct tpm_chip *chip, u8 status)
 {
 	return (status == TPM_STS_COMMAND_READY);
@@ -501,11 +433,7 @@ static const struct tpm_class_ops st33zp24_tpm = {
 };
 
 /*
- * st33zp24_probe initialize the TPM device
- * @param: client, the i2c_client description (TPM I2C description).
- * @param: id, the i2c_device_id struct.
- * @return: 0 in case of success.
- *	 -1 in other case.
+ * initialize the TPM device
  */
 int st33zp24_probe(void *phy_id, const struct st33zp24_phy_ops *ops,
 		   struct device *dev, int irq, int io_lpcpd)
@@ -583,11 +511,6 @@ int st33zp24_probe(void *phy_id, const struct st33zp24_phy_ops *ops,
 }
 EXPORT_SYMBOL(st33zp24_probe);
 
-/*
- * st33zp24_remove remove the TPM device
- * @param: tpm_data, the tpm phy.
- * @return: 0 in case of success.
- */
 int st33zp24_remove(struct tpm_chip *chip)
 {
 	tpm_chip_unregister(chip);
@@ -596,12 +519,6 @@ int st33zp24_remove(struct tpm_chip *chip)
 EXPORT_SYMBOL(st33zp24_remove);
 
 #ifdef CONFIG_PM_SLEEP
-/*
- * st33zp24_pm_suspend suspend the TPM device
- * @param: tpm_data, the tpm phy.
- * @param: mesg, the power management message.
- * @return: 0 in case of success.
- */
 int st33zp24_pm_suspend(struct device *dev)
 {
 	struct tpm_chip *chip = dev_get_drvdata(dev);
@@ -615,14 +532,9 @@ int st33zp24_pm_suspend(struct device *dev)
 		ret = tpm_pm_suspend(dev);
 
 	return ret;
-} /* st33zp24_pm_suspend() */
+}
 EXPORT_SYMBOL(st33zp24_pm_suspend);
 
-/*
- * st33zp24_pm_resume resume the TPM device
- * @param: tpm_data, the tpm phy.
- * @return: 0 in case of success.
- */
 int st33zp24_pm_resume(struct device *dev)
 {
 	struct tpm_chip *chip = dev_get_drvdata(dev);
@@ -640,7 +552,7 @@ int st33zp24_pm_resume(struct device *dev)
 			tpm1_do_selftest(chip);
 	}
 	return ret;
-} /* st33zp24_pm_resume() */
+}
 EXPORT_SYMBOL(st33zp24_pm_resume);
 #endif
 
-- 
2.25.1

