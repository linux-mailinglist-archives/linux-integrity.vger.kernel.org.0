Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F020716F0F
	for <lists+linux-integrity@lfdr.de>; Tue, 30 May 2023 22:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjE3UuR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 30 May 2023 16:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjE3UuM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 30 May 2023 16:50:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D565FEC;
        Tue, 30 May 2023 13:50:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F995602E2;
        Tue, 30 May 2023 20:50:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28501C433D2;
        Tue, 30 May 2023 20:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685479807;
        bh=eSe4k0GdqCWzcoai33dkHcs/AUteRh6wSrOhKZwSjXA=;
        h=From:To:Cc:Subject:Date:From;
        b=oNwdRsyDs+uiAsWL6jP5bKhLas9kNKzsI1nn26JyySpI+sV0U7//F7jHbgS2fRe0j
         YpO4YYiOt2ACaAPFLibCR9EDzBg0oj26YEHCPr8Z9ZG5kRpmeUIZVmfSFl8sBlrRBY
         J6suioUK8jQyQL97LBMtgBo02riAlIqTTPEqxQmgtFl1Rsfxy6cmyB74Ft/yPlDTHa
         5blPOeOHdOxTkt74Eps8ADWwaNEV+Cz06otIKf6UDHFLGZE4pq2q1Op5UDFLsJiO4U
         I9xRILu5k53CDnaYpUHOXXMTOYWPYaT39ghz63QZ/6uRy1E+0LIjZZASkQbV6Yd9ny
         ZH/XFCmHhmDTA==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-integrity@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Alejandro Cabrera <alejandro.cabreraaldaya@tuni.fi>,
        Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>,
        stable@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: factor out the user space mm from tpm_vtpm_set_locality()
Date:   Tue, 30 May 2023 23:50:01 +0300
Message-Id: <20230530205001.1302975-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>

vtpm_proxy_fops_set_locality() causes kernel buffers to be passed to
copy_from_user() and copy_to_user().

Factor out the crippled code away with help of an internal API for
managing struct proxy_dev instances.

Link: https://lore.kernel.org/all/20230530020133.235765-1-jarkko@kernel.org/
Cc: stable@vger.kernel.org # v4.14+
Fixes: be4c9acfe297 ("tpm: vtpm_proxy: Implement request_locality function.")
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@tuni.fi>
---
I've tested this on RISC-V QEMU and have not noticed issues so far, and
thus dropped the RFC tag. I've been looking into the code a lot lately
as I'm building a boot time support for it, which will allow to e.g.
test IMA without a physical TPM.	
 drivers/char/tpm/tpm_vtpm_proxy.c | 168 ++++++++++++++++--------------
 1 file changed, 87 insertions(+), 81 deletions(-)

diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
index 30e953988cab..83496742cc19 100644
--- a/drivers/char/tpm/tpm_vtpm_proxy.c
+++ b/drivers/char/tpm/tpm_vtpm_proxy.c
@@ -38,7 +38,6 @@ struct proxy_dev {
 #define STATE_OPENED_FLAG        BIT(0)
 #define STATE_WAIT_RESPONSE_FLAG BIT(1)  /* waiting for emulator response */
 #define STATE_REGISTERED_FLAG	 BIT(2)
-#define STATE_DRIVER_COMMAND     BIT(3)  /* sending a driver specific command */
 
 	size_t req_len;              /* length of queued TPM request */
 	size_t resp_len;             /* length of queued TPM response */
@@ -58,6 +57,53 @@ static void vtpm_proxy_delete_device(struct proxy_dev *proxy_dev);
  * Functions related to 'server side'
  */
 
+static ssize_t __vtpm_proxy_copy_from(struct proxy_dev *proxy_dev, u8 *buf, size_t count)
+{
+	size_t len = proxy_dev->req_len;
+
+	if (!(proxy_dev->state & STATE_OPENED_FLAG))
+		return -EPIPE;
+
+	if (count < len || len > sizeof(proxy_dev->buffer)) {
+		pr_debug("Invalid size in recv: count=%zd, req_len=%zd\n", count, len);
+		return -EIO;
+	}
+
+	memcpy(buf, proxy_dev->buffer, len);
+	memset(proxy_dev->buffer, 0, len);
+	proxy_dev->req_len = 0;
+	proxy_dev->state |= STATE_WAIT_RESPONSE_FLAG;
+
+	return len;
+}
+
+static ssize_t __vtpm_proxy_copy_to(struct proxy_dev *proxy_dev, const u8 *buf, size_t count)
+{
+	if (!(proxy_dev->state & STATE_OPENED_FLAG))
+		return -EPIPE;
+
+	if (count > sizeof(proxy_dev->buffer) || !(proxy_dev->state & STATE_WAIT_RESPONSE_FLAG))
+		return -EIO;
+
+	proxy_dev->state &= ~STATE_WAIT_RESPONSE_FLAG;
+	proxy_dev->req_len = 0;
+	proxy_dev->resp_len = count;
+	memcpy(proxy_dev->buffer, buf, count);
+
+	return count;
+}
+
+static int vtpm_proxy_wait_for(struct proxy_dev *proxy_dev)
+{
+	if (wait_event_interruptible(
+		proxy_dev->wq,
+		proxy_dev->req_len != 0 || !(proxy_dev->state & STATE_OPENED_FLAG)))
+		return -EINTR;
+
+	return 0;
+}
+
+
 /**
  * vtpm_proxy_fops_read - Read TPM commands on 'server side'
  *
@@ -73,44 +119,26 @@ static ssize_t vtpm_proxy_fops_read(struct file *filp, char __user *buf,
 				    size_t count, loff_t *off)
 {
 	struct proxy_dev *proxy_dev = filp->private_data;
-	size_t len;
-	int sig, rc;
+	u8 *kernel_buf;
+	ssize_t rc;
 
-	sig = wait_event_interruptible(proxy_dev->wq,
-		proxy_dev->req_len != 0 ||
-		!(proxy_dev->state & STATE_OPENED_FLAG));
-	if (sig)
-		return -EINTR;
-
-	mutex_lock(&proxy_dev->buf_lock);
-
-	if (!(proxy_dev->state & STATE_OPENED_FLAG)) {
-		mutex_unlock(&proxy_dev->buf_lock);
-		return -EPIPE;
-	}
-
-	len = proxy_dev->req_len;
-
-	if (count < len || len > sizeof(proxy_dev->buffer)) {
-		mutex_unlock(&proxy_dev->buf_lock);
-		pr_debug("Invalid size in recv: count=%zd, req_len=%zd\n",
-			 count, len);
-		return -EIO;
-	}
-
-	rc = copy_to_user(buf, proxy_dev->buffer, len);
-	memset(proxy_dev->buffer, 0, len);
-	proxy_dev->req_len = 0;
+	rc = vtpm_proxy_wait_for(proxy_dev);
+	if (rc)
+		return rc;
 
-	if (!rc)
-		proxy_dev->state |= STATE_WAIT_RESPONSE_FLAG;
+	kernel_buf = kzalloc(sizeof(proxy_dev->buffer), GFP_KERNEL);
+	if (!kernel_buf)
+		return -ENOMEM;
 
+	mutex_lock(&proxy_dev->buf_lock);
+	rc = __vtpm_proxy_copy_from(proxy_dev, buf, count);
 	mutex_unlock(&proxy_dev->buf_lock);
 
-	if (rc)
-		return -EFAULT;
+	if (!rc && copy_to_user(buf, kernel_buf, count))
+		rc = -EFAULT;
 
-	return len;
+	kfree(kernel_buf);
+	return rc;
 }
 
 /**
@@ -128,36 +156,26 @@ static ssize_t vtpm_proxy_fops_write(struct file *filp, const char __user *buf,
 				     size_t count, loff_t *off)
 {
 	struct proxy_dev *proxy_dev = filp->private_data;
+	u8 *kernel_buf;
+	int rc;
 
-	mutex_lock(&proxy_dev->buf_lock);
-
-	if (!(proxy_dev->state & STATE_OPENED_FLAG)) {
-		mutex_unlock(&proxy_dev->buf_lock);
-		return -EPIPE;
-	}
-
-	if (count > sizeof(proxy_dev->buffer) ||
-	    !(proxy_dev->state & STATE_WAIT_RESPONSE_FLAG)) {
-		mutex_unlock(&proxy_dev->buf_lock);
-		return -EIO;
-	}
-
-	proxy_dev->state &= ~STATE_WAIT_RESPONSE_FLAG;
-
-	proxy_dev->req_len = 0;
+	kernel_buf = kzalloc(sizeof(proxy_dev->buffer), GFP_KERNEL);
+	if (!kernel_buf)
+		return -ENOMEM;
 
-	if (copy_from_user(proxy_dev->buffer, buf, count)) {
-		mutex_unlock(&proxy_dev->buf_lock);
+	if (copy_from_user(kernel_buf, buf, count)) {
+		kfree(kernel_buf);
 		return -EFAULT;
 	}
 
-	proxy_dev->resp_len = count;
-
+	mutex_lock(&proxy_dev->buf_lock);
+	rc = __vtpm_proxy_copy_to(proxy_dev, kernel_buf, count);
 	mutex_unlock(&proxy_dev->buf_lock);
 
 	wake_up_interruptible(&proxy_dev->wq);
+	kfree(kernel_buf);
 
-	return count;
+	return rc;
 }
 
 /*
@@ -295,28 +313,6 @@ static int vtpm_proxy_tpm_op_recv(struct tpm_chip *chip, u8 *buf, size_t count)
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
@@ -330,6 +326,7 @@ static int vtpm_proxy_is_driver_command(struct tpm_chip *chip,
 static int vtpm_proxy_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t count)
 {
 	struct proxy_dev *proxy_dev = dev_get_drvdata(&chip->dev);
+	unsigned int ord = ((struct tpm_header *)buf)->ordinal;
 
 	if (count > sizeof(proxy_dev->buffer)) {
 		dev_err(&chip->dev,
@@ -338,8 +335,10 @@ static int vtpm_proxy_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t count)
 		return -EIO;
 	}
 
-	if (!(proxy_dev->state & STATE_DRIVER_COMMAND) &&
-	    vtpm_proxy_is_driver_command(chip, buf, count))
+	if ((chip->flags & TPM_CHIP_FLAG_TPM2) && ord == TPM2_CC_SET_LOCALITY)
+		return -EFAULT;
+
+	if (ord == TPM_ORD_SET_LOCALITY)
 		return -EFAULT;
 
 	mutex_lock(&proxy_dev->buf_lock);
@@ -407,13 +406,20 @@ static int vtpm_proxy_request_locality(struct tpm_chip *chip, int locality)
 				  TPM_ORD_SET_LOCALITY);
 	if (rc)
 		return rc;
+
 	tpm_buf_append_u8(&buf, locality);
 
-	proxy_dev->state |= STATE_DRIVER_COMMAND;
+	mutex_lock(&proxy_dev->buf_lock);
+	rc = __vtpm_proxy_copy_to(proxy_dev, buf.data, tpm_buf_length(&buf));
+	mutex_unlock(&proxy_dev->buf_lock);
 
-	rc = tpm_transmit_cmd(chip, &buf, 0, "attempting to set locality");
+	rc = vtpm_proxy_wait_for(proxy_dev);
+	if (rc)
+		return rc;
 
-	proxy_dev->state &= ~STATE_DRIVER_COMMAND;
+	mutex_lock(&proxy_dev->buf_lock);
+	rc = __vtpm_proxy_copy_from(proxy_dev, buf.data, tpm_buf_length(&buf));
+	mutex_unlock(&proxy_dev->buf_lock);
 
 	if (rc < 0) {
 		locality = rc;
-- 
2.39.2

