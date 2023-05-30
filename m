Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7833D715300
	for <lists+linux-integrity@lfdr.de>; Tue, 30 May 2023 03:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjE3Bjw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 May 2023 21:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjE3Bjv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 May 2023 21:39:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F78D9;
        Mon, 29 May 2023 18:39:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C4D2628E2;
        Tue, 30 May 2023 01:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38849C433EF;
        Tue, 30 May 2023 01:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685410788;
        bh=Fc2RpQel+qFTuy8pAbXgl1N/NoGp11aHR8zxbS1/fzs=;
        h=From:To:Cc:Subject:Date:From;
        b=axYUFodp8nl3/X+l5R/JV70OISdLXtY8c6vptkG0y1k5D1oySZWdSp7FrD7u3eYA9
         a8jXDCciKA22Z+OaithlS/EDeqVeHZm+iEwUGvAxqaMPsUsIC9zLFU3zjvlJGRII52
         bm04xsjs23C9qttFGTPgMXOEmCuw5wp/yPzXo12IBiZCsXOeU5tYX1RXFDJZxqKRQC
         makGZ+wygan3Lb7nArHGPR/wQfLnH9fI+8wQUlS7mXuPLDIOXQSge9sFKgXJC/54U+
         8bmn0GO1o9EASbVWa0rCoioTyxe3qi0zllBWof2HZK0T1fSs6UIQwhMmR/Nnt4qu6c
         7FN4gf94kXiNQ==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-integrity@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>,
        stable@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH RFC] tpm: tpm_vtpm_proxy: fix a race condition in the locality change
Date:   Tue, 30 May 2023 04:39:41 +0300
Message-Id: <20230530013942.232590-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>

The driver has three issues (in priority order) in the locality change:

1. Because of mutex_unlock(&proxy_dev->buf_lock) in-between write and read
   operations in the locality change, another thread can send a TPM command
   in-between.
2. The driver uses __user pointer and copy_to_user() and
   copy_from_user() with a kernel address during the locality change.
3. For invalid locality change request from user space, the driver
   sets errno to EFAULT, while for invalid input data EINVAL should
   be used.

Address this by:

1. Introduce __vtpm_proxy_read_unlocked(),  __vtpm_proxy_write_unlocked()
   and __vtpm_proxy_read_write_locked().
2. Make locality change atomic by calling __vtpm_proxy_read_write_locked(),
   instead of tpm_transmit_cmd().

Cc: stable@vger.kernel.org
Fixes: be4c9acfe297 ("tpm: vtpm_proxy: Implement request_locality function.")
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>
---
NOTE: I did not have test env available, when I wrote this. Thus, it has
an RFC tag for the moment.
 drivers/char/tpm/tpm_vtpm_proxy.c | 162 ++++++++++++++----------------
 1 file changed, 73 insertions(+), 89 deletions(-)

diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
index 30e953988cab..8f43a82e5590 100644
--- a/drivers/char/tpm/tpm_vtpm_proxy.c
+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
@@ -38,7 +38,6 @@ struct proxy_dev {
 #define STATE_OPENED_FLAG        BIT(0)
 #define STATE_WAIT_RESPONSE_FLAG BIT(1)  /* waiting for emulator response */
 #define STATE_REGISTERED_FLAG	 BIT(2)
-#define STATE_DRIVER_COMMAND     BIT(3)  /* sending a driver specific command */
 
 	size_t req_len;              /* length of queued TPM request */
 	size_t resp_len;             /* length of queued TPM response */
@@ -58,106 +57,112 @@ static void vtpm_proxy_delete_device(struct proxy_dev *proxy_dev);
  * Functions related to 'server side'
  */
 
-/**
- * vtpm_proxy_fops_read - Read TPM commands on 'server side'
- *
- * @filp: file pointer
- * @buf: read buffer
- * @count: number of bytes to read
- * @off: offset
- *
- * Return:
- *	Number of bytes read or negative error code
- */
-static ssize_t vtpm_proxy_fops_read(struct file *filp, char __user *buf,
-				    size_t count, loff_t *off)
+static ssize_t __vtpm_proxy_read_unlocked(struct proxy_dev *proxy_dev, char __user *buf,
+					  size_t count)
 {
-	struct proxy_dev *proxy_dev = filp->private_data;
 	size_t len;
-	int sig, rc;
-
-	sig = wait_event_interruptible(proxy_dev->wq,
-		proxy_dev->req_len != 0 ||
-		!(proxy_dev->state & STATE_OPENED_FLAG));
-	if (sig)
-		return -EINTR;
-
-	mutex_lock(&proxy_dev->buf_lock);
+	int rc;
 
-	if (!(proxy_dev->state & STATE_OPENED_FLAG)) {
-		mutex_unlock(&proxy_dev->buf_lock);
+	if (!(proxy_dev->state & STATE_OPENED_FLAG))
 		return -EPIPE;
-	}
 
 	len = proxy_dev->req_len;
 
 	if (count < len || len > sizeof(proxy_dev->buffer)) {
-		mutex_unlock(&proxy_dev->buf_lock);
 		pr_debug("Invalid size in recv: count=%zd, req_len=%zd\n",
 			 count, len);
 		return -EIO;
 	}
 
-	rc = copy_to_user(buf, proxy_dev->buffer, len);
+	if (buf)
+		rc = copy_to_user(buf, proxy_dev->buffer, len);
+
 	memset(proxy_dev->buffer, 0, len);
 	proxy_dev->req_len = 0;
 
 	if (!rc)
 		proxy_dev->state |= STATE_WAIT_RESPONSE_FLAG;
 
-	mutex_unlock(&proxy_dev->buf_lock);
-
 	if (rc)
 		return -EFAULT;
 
 	return len;
 }
 
-/**
- * vtpm_proxy_fops_write - Write TPM responses on 'server side'
- *
- * @filp: file pointer
- * @buf: write buffer
- * @count: number of bytes to write
- * @off: offset
- *
- * Return:
- *	Number of bytes read or negative error value
- */
-static ssize_t vtpm_proxy_fops_write(struct file *filp, const char __user *buf,
-				     size_t count, loff_t *off)
+static ssize_t __vtpm_proxy_write_unlocked(struct proxy_dev *proxy_dev, const char __user *buf,
+					   size_t count)
 {
-	struct proxy_dev *proxy_dev = filp->private_data;
-
-	mutex_lock(&proxy_dev->buf_lock);
-
-	if (!(proxy_dev->state & STATE_OPENED_FLAG)) {
-		mutex_unlock(&proxy_dev->buf_lock);
+	if (!(proxy_dev->state & STATE_OPENED_FLAG))
 		return -EPIPE;
-	}
 
 	if (count > sizeof(proxy_dev->buffer) ||
-	    !(proxy_dev->state & STATE_WAIT_RESPONSE_FLAG)) {
-		mutex_unlock(&proxy_dev->buf_lock);
+	    !(proxy_dev->state & STATE_WAIT_RESPONSE_FLAG))
 		return -EIO;
-	}
 
 	proxy_dev->state &= ~STATE_WAIT_RESPONSE_FLAG;
 
 	proxy_dev->req_len = 0;
 
-	if (copy_from_user(proxy_dev->buffer, buf, count)) {
-		mutex_unlock(&proxy_dev->buf_lock);
+	if (buf && copy_from_user(proxy_dev->buffer, buf, count))
 		return -EFAULT;
-	}
 
 	proxy_dev->resp_len = count;
+	return count;
+}
 
+static ssize_t __vtpm_proxy_read_write_unlocked(struct proxy_dev *proxy_dev, char __user *buf,
+						size_t count)
+{
+	ssize_t rc;
+
+	do {
+		rc = __vtpm_proxy_write_unlocked(proxy_dev, buf, count);
+		if (rc < 0)
+			break;
+		rc = __vtpm_proxy_read_unlocked(proxy_dev, buf, rc);
+	} while (0);
+
+	return rc;
+}
+
+/*
+ * See struct file_operations.
+ */
+static ssize_t vtpm_proxy_fops_read(struct file *filp, char __user *buf,
+				    size_t count, loff_t *off)
+{
+	struct proxy_dev *proxy_dev = filp->private_data;
+	ssize_t rc;
+	int sig;
+
+	sig = wait_event_interruptible(proxy_dev->wq,
+		proxy_dev->req_len != 0 ||
+		!(proxy_dev->state & STATE_OPENED_FLAG));
+	if (sig)
+		return -EINTR;
+
+	mutex_lock(&proxy_dev->buf_lock);
+	rc = __vtpm_proxy_read_unlocked(proxy_dev, buf, count);
 	mutex_unlock(&proxy_dev->buf_lock);
 
+	return rc;
+}
+
+/*
+ * See struct file_operations.
+ */
+static ssize_t vtpm_proxy_fops_write(struct file *filp, const char __user *buf,
+				     size_t count, loff_t *off)
+{
+	struct proxy_dev *proxy_dev = filp->private_data;
+	int rc;
+
+	mutex_lock(&proxy_dev->buf_lock);
+	rc = __vtpm_proxy_write_unlocked(proxy_dev, buf, count);
+	mutex_unlock(&proxy_dev->buf_lock);
 	wake_up_interruptible(&proxy_dev->wq);
 
-	return count;
+	return rc;
 }
 
 /*
@@ -295,28 +300,6 @@ static int vtpm_proxy_tpm_op_recv(struct tpm_chip *chip, u8 *buf, size_t count)
 	return len;
 }
 
-static int vtpm_proxy_is_driver_command(struct tpm_chip *chip,
-					u8 *buf, size_t count)
-{
-	struct tpm_header *hdr = (struct tpm_header *)buf;
-
-	if (count < sizeof(struct tpm_header))
-		return 0;
-
-	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
-		switch (be32_to_cpu(hdr->ordinal)) {
-		case TPM2_CC_SET_LOCALITY:
-			return 1;
-		}
-	} else {
-		switch (be32_to_cpu(hdr->ordinal)) {
-		case TPM_ORD_SET_LOCALITY:
-			return 1;
-		}
-	}
-	return 0;
-}
-
 /*
  * Called when core TPM driver forwards TPM requests to 'server side'.
  *
@@ -330,6 +313,7 @@ static int vtpm_proxy_is_driver_command(struct tpm_chip *chip,
 static int vtpm_proxy_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t count)
 {
 	struct proxy_dev *proxy_dev = dev_get_drvdata(&chip->dev);
+	unsigned int ord = ((struct tpm_header *)buf)->ordinal;
 
 	if (count > sizeof(proxy_dev->buffer)) {
 		dev_err(&chip->dev,
@@ -338,9 +322,11 @@ static int vtpm_proxy_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t count)
 		return -EIO;
 	}
 
-	if (!(proxy_dev->state & STATE_DRIVER_COMMAND) &&
-	    vtpm_proxy_is_driver_command(chip, buf, count))
-		return -EFAULT;
+	if ((chip->flags & TPM_CHIP_FLAG_TPM2) && ord == TPM2_CC_SET_LOCALITY)
+		return -EINVAL;
+
+	if (ord == TPM_ORD_SET_LOCALITY)
+		return -EINVAL;
 
 	mutex_lock(&proxy_dev->buf_lock);
 
@@ -409,12 +395,10 @@ static int vtpm_proxy_request_locality(struct tpm_chip *chip, int locality)
 		return rc;
 	tpm_buf_append_u8(&buf, locality);
 
-	proxy_dev->state |= STATE_DRIVER_COMMAND;
-
-	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting to set locality");
-
-	proxy_dev->state &= ~STATE_DRIVER_COMMAND;
-
+	mutex_lock(&proxy_dev->buf_lock);
+	memcpy(proxy_dev->buffer, buf.data, tpm_buf_length(&buf));
+	rc = __vtpm_proxy_read_write_unlocked(proxy_dev, NULL, tpm_buf_length(&buf));
+	mutex_unlock(&proxy_dev->buf_lock);
 	if (rc < 0) {
 		locality = rc;
 		goto out;
-- 
2.39.2

