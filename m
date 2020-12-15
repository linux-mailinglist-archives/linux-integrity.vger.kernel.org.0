Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23EC2DAE26
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Dec 2020 14:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbgLONjf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Dec 2020 08:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbgLONjZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Dec 2020 08:39:25 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E74DC061282;
        Tue, 15 Dec 2020 05:38:10 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id y19so39335428lfa.13;
        Tue, 15 Dec 2020 05:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l3rwgtx+k7bK/9dBR4Eu+0zKh7+91fkk0ZrYSZag/yU=;
        b=kHt3u4Revzv7Xvn5lOD0zme4cBX7WpulkbNUUAvgG7ZOraIqKvo+V4O/MDw4G/KyDl
         m5mpUVimtoVSADL47QyNxxisySs4XZ7ANW62q1uEvUcWLng4p3zR1BSFJVM3YgvKT5hu
         QhHlpUfz5O4JhUC3Q6IeqyYq2iIYhr/bLnJavmcPNCcbfjptfo8bNZYvKi97UjBccM3t
         Gi+zaRKiD8S8gDBimZArddRTp25yLcdVQwOP9Fd/FqML7iofdioEcsid19FG3wVeigEU
         KLj5GH+d1bUWRRaFzT9yeX5zPYLcRmsgGd/vlwSy2A45pogztbjcCRmICDebuuZuA8cw
         uRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l3rwgtx+k7bK/9dBR4Eu+0zKh7+91fkk0ZrYSZag/yU=;
        b=LiEpRNmGcnIKo4mDw7HFV8o11BNCULw0EITEJYhbJEhgqbNZ2uPhuOTl6JtZ7cabDG
         dApr6AWvpmSpFK7u0obupqUBt67Vqf3OUdLngsXSJuOGUCFdcSAnWOLdUB3BC/2Tdl5j
         Z26Y8nciwIIts6HSXYcDojPkElKpykipXptoQNHBD+R9Xcv4urBkLGPwR0w/dwTbjViq
         3CJ2w7BAUJZYzoy6oVZPEbulAxD5xc61o8IvZuqDlSYSHfecOfb9L1lm38ezTvfKWps6
         P0tSzD8ab+rqNuNKtJFJhkhfb/G8maYi4pe3XY+XTFaWtzr13bwuc4DZzvD3Q6JIlHg9
         /eeg==
X-Gm-Message-State: AOAM5300gd0hyFGleF8EZTMoCcHfdec3E8jadQ7zSrEty4R46DQUgUXP
        dduLWaP/413MN/jL3DQRIUI=
X-Google-Smtp-Source: ABdhPJyymFFz0RNoj3qwTVZD409RgrSTmwHzKoF2z7yvGDRCs/p53YRu6FpcVwZzie9VJ0I9ikuIxw==
X-Received: by 2002:ac2:454e:: with SMTP id j14mr11302225lfm.123.1608039488812;
        Tue, 15 Dec 2020 05:38:08 -0800 (PST)
Received: from localhost.localdomain (109-252-202-142.dynamic.spd-mgts.ru. [109.252.202.142])
        by smtp.gmail.com with ESMTPSA id u30sm209019lfc.238.2020.12.15.05.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 05:38:07 -0800 (PST)
From:   Sergey Temerkhanov <s.temerkhanov@gmail.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Sergey Temerkhanov <s.temerkhanov@gmail.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] tpm: Rework open/close/shutdown to avoid races
Date:   Tue, 15 Dec 2020 16:38:01 +0300
Message-Id: <20201215133801.546207-1-s.temerkhanov@gmail.com>
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
 drivers/char/tpm/tpm-chip.c  |  2 ++
 drivers/char/tpm/tpm-dev.c   | 20 +++++++++++++-------
 drivers/char/tpm/tpmrm-dev.c |  3 +++
 include/linux/tpm.h          |  6 ++++--
 4 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
index ddaeceb7e109..e94148b8e180 100644
--- a/drivers/char/tpm/tpm-chip.c
+++ b/drivers/char/tpm/tpm-chip.c
@@ -295,6 +295,7 @@ static int tpm_class_shutdown(struct device *dev)
 {
 	struct tpm_chip *chip = container_of(dev, struct tpm_chip, dev);
 
+	wait_event_idle(chip->waitq, !atomic_read(&chip->refcount));
 	down_write(&chip->ops_sem);
 	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
 		if (!tpm_chip_start(chip)) {
@@ -330,6 +331,7 @@ struct tpm_chip *tpm_chip_alloc(struct device *pdev,
 
 	mutex_init(&chip->tpm_mutex);
 	init_rwsem(&chip->ops_sem);
+	init_waitqueue_head(&chip->waitq);
 
 	chip->ops = ops;
 
diff --git a/drivers/char/tpm/tpm-dev.c b/drivers/char/tpm/tpm-dev.c
index e2c0baa69fef..8558f0f7382c 100644
--- a/drivers/char/tpm/tpm-dev.c
+++ b/drivers/char/tpm/tpm-dev.c
@@ -19,27 +19,32 @@ static int tpm_open(struct inode *inode, struct file *file)
 {
 	struct tpm_chip *chip;
 	struct file_priv *priv;
+	int ret = 0;
 
 	chip = container_of(inode->i_cdev, struct tpm_chip, cdev);
 
 	/* It's assured that the chip will be opened just once,
-	 * by the check of is_open variable, which is protected
-	 * by driver_lock. */
-	if (test_and_set_bit(0, &chip->is_open)) {
+	 * by the check of the chip reference count.
+	 */
+	if (atomic_fetch_inc(&chip->refcount)) {
 		dev_dbg(&chip->dev, "Another process owns this TPM\n");
-		return -EBUSY;
+		ret = -EBUSY;
+		goto out;
 	}
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (priv == NULL)
+	if (priv == NULL) {
+		ret = -ENOMEM;
 		goto out;
+	}
 
 	tpm_common_open(file, chip, priv, NULL);
 
 	return 0;
 
  out:
-	clear_bit(0, &chip->is_open);
+	atomic_dec(&chip->refcount);
+	wake_up_all(&chip->waitq);
 	return -ENOMEM;
 }
 
@@ -51,7 +56,8 @@ static int tpm_release(struct inode *inode, struct file *file)
 	struct file_priv *priv = file->private_data;
 
 	tpm_common_release(file, priv);
-	clear_bit(0, &priv->chip->is_open);
+	atomic_dec(&priv->chip->refcount);
+	wake_up_all(&priv->chip->waitq);
 	kfree(priv);
 
 	return 0;
diff --git a/drivers/char/tpm/tpmrm-dev.c b/drivers/char/tpm/tpmrm-dev.c
index eef0fb06ea83..fb3cb7b03814 100644
--- a/drivers/char/tpm/tpmrm-dev.c
+++ b/drivers/char/tpm/tpmrm-dev.c
@@ -28,6 +28,7 @@ static int tpmrm_open(struct inode *inode, struct file *file)
 	}
 
 	tpm_common_open(file, chip, &priv->priv, &priv->space);
+	atomic_inc(&chip->refcount);
 
 	return 0;
 }
@@ -39,6 +40,8 @@ static int tpmrm_release(struct inode *inode, struct file *file)
 
 	tpm_common_release(file, fpriv);
 	tpm2_del_space(fpriv->chip, &priv->space);
+	atomic_dec(&fpriv->chip->refcount);
+	wake_up_all(&fpriv->chip->waitq);
 	kfree(priv);
 
 	return 0;
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 8f4ff39f51e7..0c8842783823 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -22,6 +22,7 @@
 #include <linux/cdev.h>
 #include <linux/fs.h>
 #include <linux/highmem.h>
+#include <linux/atomic.h>
 #include <crypto/hash_info.h>
 
 #define TPM_DIGEST_SIZE 20	/* Max TPM v1.2 PCR size */
@@ -128,8 +129,9 @@ struct tpm_chip {
 
 	unsigned int flags;
 
-	int dev_num;		/* /dev/tpm# */
-	unsigned long is_open;	/* only one allowed */
+	int dev_num;		 /* /dev/tpm# */
+	atomic_t refcount;	 /* /dev/tmp# can only be opened once */
+	wait_queue_head_t waitq; /* Wait queue for synchronous ops */
 
 	char hwrng_name[64];
 	struct hwrng hwrng;
-- 
2.25.1

