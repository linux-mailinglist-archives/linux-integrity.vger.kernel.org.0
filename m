Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFB82CEC01
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Dec 2020 11:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbgLDKSu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Dec 2020 05:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729682AbgLDKSu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Dec 2020 05:18:50 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4889EC061A4F;
        Fri,  4 Dec 2020 02:18:10 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id s30so6938962lfc.4;
        Fri, 04 Dec 2020 02:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fpREM1iONSIivj3vBU1UqjMUx3XnOXDpVZWqy3WEdAU=;
        b=a82t6DWrlYstcyAmchZ8JUT1LhrXOi+vjQFdHlp1w0jVsEsm0mUyZziEcaVi+VLG8F
         WErJS7TdaI/JirmKhmA9sYqnQIGtOT/q8kwtn4cSe5bUNaaiv7iO5WJW3yYvO/hLb8Pr
         iwWvKoyK5pPCuL9J32fw4eivXtF1eVfP5P4fbo4nfMZbKds/KfeQJetWqUVpFuBNARaS
         l8itkTctxwImXp7qCEuSkd9qQsrE2Y8E99C1jkOfEu2bjiUfBr9MTQNlWFgpmt5Tj1DN
         lVMSu26t7fsG19AI7myNwvx0usePjTLto5Eg2qypnCIlu7ji/RlWVl5+4N0L6O7uUOF3
         68YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fpREM1iONSIivj3vBU1UqjMUx3XnOXDpVZWqy3WEdAU=;
        b=Z/4Ex047Hs2mFilMOFWn5HXcGCgqeN6oP5ghEgnprD7Ucyyd2mob+jqmVuHosoQYx6
         K9kGBGkU7/lwYEBxlVuDJpJricuZSHTZdhm+JVbuj9h0jXq0Wa2Vf8kGFYXJh8FDVsX0
         wAucZsRfeejVoWuZFm3uV4yIq6iu1DeRekUghAam4fH40fkpf7AAILaDv96e6XxzNP97
         6Tlt0TMnCVzuT8EJ4ugvfAkSHmJwajkCyBPGnHcOHY4uy30AeYhpp73qndT1GrywPsJN
         taCslzmA60qQHoPhSDoVR+jHjlMRsjJYstNM5AD51ZTA0/jSz2YG47ohlcufFIDY5cm0
         8dSg==
X-Gm-Message-State: AOAM531qrwHz6jBSyKX1SLJDxESBVjrKE79pM9x+dbHpRQsneZbvqgoC
        fowShPpESulmIa3Xj8RshFOangLO1G1ypmG0
X-Google-Smtp-Source: ABdhPJziB0QMbz6XMXDnWKEUtlPnEhPI0gGs5cmlSkmeD+54yUB6ZJxg+3xYY9cybZZCCdt51MlrDw==
X-Received: by 2002:a19:c1c4:: with SMTP id r187mr3268233lff.518.1607077088839;
        Fri, 04 Dec 2020 02:18:08 -0800 (PST)
Received: from localhost.localdomain (109-252-202-142.dynamic.spd-mgts.ru. [109.252.202.142])
        by smtp.gmail.com with ESMTPSA id l18sm1544845ljj.60.2020.12.04.02.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 02:18:08 -0800 (PST)
From:   Sergey Temerkhanov <s.temerkhanov@gmail.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Temerkhanov <s.temerkhanov@gmail.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][RFC] tpm: Rework open/close/shutdown to avoid races
Date:   Fri,  4 Dec 2020 13:18:05 +0300
Message-Id: <20201204101805.27374-1-s.temerkhanov@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Avoid race condition at shutdown by shutting downn the TPM 2.0
devices synchronously. This eliminates the condition when the
shutdown sequence sets chip->ops to NULL leading to the following:

[ 1586.593561][ T8669] tpm2_del_space+0x28/0x73
[ 1586.598718][ T8669] tpmrm_release+0x27/0x33wq
[ 1586.603774][ T8669] __fput+0x109/0x1d
[ 1586.608380][ T8669] task_work_run+0x7c/0x90
[ 1586.613414][ T8669] prepare_exit_to_usermode+0xb8/0x128
[ 1586.619522][ T8669] entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1586.626068][ T8669] RIP: 0033:0x4cb4bb

Signed-off-by: Sergey Temerkhanov <s.temerkhanov@gmail.com>
---
 drivers/char/tpm/tpm-chip.c  | 27 ---------------------------
 drivers/char/tpm/tpm-dev.c   | 11 ++++++-----
 drivers/char/tpm/tpmrm-dev.c |  7 +++++++
 include/linux/tpm.h          |  2 +-
 4 files changed, 14 insertions(+), 33 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index 1838039b0333..ede7f4790c5e 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -282,32 +282,6 @@ static void tpm_devs_release(struct device *dev)
 	put_device(&chip->dev);
 }
 
-/**
- * tpm_class_shutdown() - prepare the TPM device for loss of power.
- * @dev: device to which the chip is associated.
- *
- * Issues a TPM2_Shutdown command prior to loss of power, as required by the
- * TPM 2.0 spec. Then, calls bus- and device- specific shutdown code.
- *
- * Return: always 0 (i.e. success)
- */
-static int tpm_class_shutdown(struct device *dev)
-{
-	struct tpm_chip *chip = container_of(dev, struct tpm_chip, dev);
-
-	down_write(&chip->ops_sem);
-	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
-		if (!tpm_chip_start(chip)) {
-			tpm2_shutdown(chip, TPM2_SU_CLEAR);
-			tpm_chip_stop(chip);
-		}
-	}
-	chip->ops = NULL;
-	up_write(&chip->ops_sem);
-
-	return 0;
-}
-
 /**
  * tpm_chip_alloc() - allocate a new struct tpm_chip instance
  * @pdev: device to which the chip is associated
@@ -347,7 +321,6 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
 	device_initialize(&chip->devs);
 
 	chip->dev.class = tpm_class;
-	chip->dev.class->shutdown_pre = tpm_class_shutdown;
 	chip->dev.release = tpm_dev_release;
 	chip->dev.parent = pdev;
 	chip->dev.groups = chip->groups;
diff --git a/drivers/char/tpm/tpm-dev.c b/drivers/char/tpm/tpm-dev.c
index e2c0baa69fef..e04f3d47c64e 100644
--- a/drivers/char/tpm/tpm-dev.c
+++ b/drivers/char/tpm/tpm-dev.c
@@ -23,9 +23,9 @@ static int tpm_open(struct inode *inode, struct file *file)
 	chip = container_of(inode->i_cdev, struct tpm_chip, cdev);
 
 	/* It's assured that the chip will be opened just once,
-	 * by the check of is_open variable, which is protected
-	 * by driver_lock. */
-	if (test_and_set_bit(0, &chip->is_open)) {
+	 * by the check of is_open variable
+	 */
+	if (atomic_fetch_or(1, &chip->is_open)) {
 		dev_dbg(&chip->dev, "Another process owns this TPM\n");
 		return -EBUSY;
 	}
@@ -39,7 +39,7 @@ static int tpm_open(struct inode *inode, struct file *file)
 	return 0;
 
  out:
-	clear_bit(0, &chip->is_open);
+	atomic_set(&chip->is_open, 0);
 	return -ENOMEM;
 }
 
@@ -49,9 +49,10 @@ static int tpm_open(struct inode *inode, struct file *file)
 static int tpm_release(struct inode *inode, struct file *file)
 {
 	struct file_priv *priv = file->private_data;
+	struct tpm_chip *chip = priv->chip;
 
 	tpm_common_release(file, priv);
-	clear_bit(0, &priv->chip->is_open);
+	atomic_set(&chip->is_open, 0);
 	kfree(priv);
 
 	return 0;
diff --git a/drivers/char/tpm/tpmrm-dev.c b/drivers/char/tpm/tpmrm-dev.c
index eef0fb06ea83..ec83ca8105b8 100644
--- a/drivers/char/tpm/tpmrm-dev.c
+++ b/drivers/char/tpm/tpmrm-dev.c
@@ -27,6 +27,8 @@ static int tpmrm_open(struct inode *inode, struct file *file)
 		return -ENOMEM;
 	}
 
+	atomic_inc(&chip->is_open);
+
 	tpm_common_open(file, chip, &priv->priv, &priv->space);
 
 	return 0;
@@ -39,6 +41,11 @@ static int tpmrm_release(struct inode *inode, struct file *file)
 
 	tpm_common_release(file, fpriv);
 	tpm2_del_space(fpriv->chip, &priv->space);
+
+	if (!atomic_dec_return(&fpriv->chip->is_open)) {
+		tpm2_shutdown(fpriv->chip, TPM2_SU_CLEAR);
+		tpm_chip_stop(fpriv->chip);
+	}
 	kfree(priv);
 
 	return 0;
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 77fdc988c610..26e070198a15 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -126,7 +126,7 @@ struct tpm_chip {
 	unsigned int flags;
 
 	int dev_num;		/* /dev/tpm# */
-	unsigned long is_open;	/* only one allowed */
+	atomic_t is_open;	/* only one allowed */
 
 	char hwrng_name[64];
 	struct hwrng hwrng;
-- 
2.25.1

