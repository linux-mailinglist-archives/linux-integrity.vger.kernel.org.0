Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA00EA348A
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Aug 2019 11:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfH3J5F (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Aug 2019 05:57:05 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40751 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfH3J5F (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Aug 2019 05:57:05 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10so3301599pgj.7;
        Fri, 30 Aug 2019 02:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zfu2xUE4Jx/6REa+NXkYINqVo6biV5W15PMsvGC/FkI=;
        b=l+KhvFJMpIKUS6qHYO70lYlttYtg17b9VbDZsoJYGQwb50qZVXUCUJ+mSalJuyOqma
         hgcEhTKLWkokR5TXGggfL+mU4YXtgyzI7U2P/s/LTIgsyJ73WWICBp4NB3SnCmIkuCdR
         4LguXGpwmzCMmh1BSrYYWhwA350WHMf0K0yJrCCN5yHlf/MTuDpsXNrTw4fbMNWqnnA6
         ANf1S0YO7snn2CH1mUBpWi1ublem5OZwgci5qcmChdIEMPB+8fODERxwmVunkxVDqvFs
         6yQJ8ZNRyeN6X7Irzst7kV17oNUmnBtRqtAHup9PGigQDVQRfYeR+HOkxqX/a+fe08+2
         9lcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zfu2xUE4Jx/6REa+NXkYINqVo6biV5W15PMsvGC/FkI=;
        b=itet9ZacEw66pQe/3h1LVXK3qDp3qMAaQFeuP8WEiUFfkEZROTYVW1LurBeANYzvkD
         8jCA2GX9zuyP8rII9qGIoThzDl6SzfXWrXqKt+CXGNtsMo0f6LGITun73I+KdnBD6dzX
         n/EjVzctqB786s/HZrRnIMRrQQRr4OqWzQZoS1mkzLX5Jgh5M8j5/MYyOc5GwcRzcrOt
         tTsoiIr3dmIDdDw4sL4ioSv/y90kdi5BYONv6+v5c4gMuCKoTkA+fg+r018bWHXn+yfb
         J3o0Jx3y2t2Sm7Z3TUgHQdg/vM6DtrtgIC+zjjW4CXOWyeigw+lOLOQe3zQr/MoA8Bx5
         bMMA==
X-Gm-Message-State: APjAAAWG2b2IX8VzOis/46himSO/J60INLmk+OCwbuEPIxb/ZJkIGdSG
        b7YMr0vXBcW961jauOWg9zM=
X-Google-Smtp-Source: APXvYqzyWc0t0rMB0T6hFCw7Dj7mBC1oFZ/Zy4IJxfTu5WtDjARxkr1YHFQSuBpHYHyPED/6sVfmbQ==
X-Received: by 2002:a62:38d7:: with SMTP id f206mr17255098pfa.102.1567159023866;
        Fri, 30 Aug 2019 02:57:03 -0700 (PDT)
Received: from localhost.localdomain ([175.203.71.146])
        by smtp.googlemail.com with ESMTPSA id k64sm8329447pge.65.2019.08.30.02.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 02:57:03 -0700 (PDT)
From:   Seunghun Han <kkamagui@gmail.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        linux-integrity@vger.kernel.org (open list:TPM DEVICE DRIVER),
        linux-kernel@vger.kernel.org, Seunghun Han <kkamagui@gmail.com>
Subject: [PATCH 1/2] tpm: tpm_crb: enhance command and response buffer size calculation code
Date:   Fri, 30 Aug 2019 18:56:38 +0900
Message-Id: <20190830095639.4562-2-kkamagui@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190830095639.4562-1-kkamagui@gmail.com>
References: <20190830095639.4562-1-kkamagui@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The purpose of crb_fixup_cmd_size() function is to work around broken
BIOSes and get the trustable size between the ACPI region and register.
When the TPM has a command buffer and response buffer independently,
the crb_map_io() function calls crb_fixup_cmd_size() twice to calculate
each buffer size.  However, the current implementation of it considers
one of two buffers.

To support independent command and response buffers, I changed
crb_check_resource() function for storing ACPI TPB regions to a list.
I also changed crb_fixup_cmd_size() to use the list for calculating each
buffer size.

Signed-off-by: Seunghun Han <kkamagui@gmail.com>
---
 drivers/char/tpm/tpm_crb.c | 44 +++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index e59f1f91d7f3..14f486c23af2 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -442,6 +442,9 @@ static int crb_check_resource(struct acpi_resource *ares, void *data)
 	    acpi_dev_resource_address_space(ares, &win)) {
 		*io_res = *res;
 		io_res->name = NULL;
+
+		/* Add this TPM CRB resource to the list */
+		return 0;
 	}
 
 	return 1;
@@ -471,7 +474,7 @@ static void __iomem *crb_map_res(struct device *dev, struct crb_priv *priv,
  * region vs the registers. Trust the ACPI region. Such broken systems
  * probably cannot send large TPM commands since the buffer will be truncated.
  */
-static u64 crb_fixup_cmd_size(struct device *dev, struct resource *io_res,
+static u64 __crb_fixup_cmd_size(struct device *dev, struct resource *io_res,
 			      u64 start, u64 size)
 {
 	if (io_res->start > start || io_res->end < start)
@@ -487,6 +490,26 @@ static u64 crb_fixup_cmd_size(struct device *dev, struct resource *io_res,
 	return io_res->end - start + 1;
 }
 
+static u64 crb_fixup_cmd_size(struct device *dev, struct list_head *resources,
+			      u64 start, u64 size)
+{
+	struct resource_entry *pos;
+	struct resource *cur_res;
+	u64 ret = size;
+
+	/* Check all TPM CRB resources with the start and size values */
+	resource_list_for_each_entry(pos, resources) {
+		cur_res = pos->res;
+
+		ret = __crb_fixup_cmd_size(dev, cur_res, start, size);
+		/* Broken BIOS is detected. Trust the ACPI region. */
+		if (ret < size)
+			break;
+	}
+
+	return ret;
+}
+
 static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 		      struct acpi_table_tpm2 *buf)
 {
@@ -506,16 +529,18 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 				     &io_res);
 	if (ret < 0)
 		return ret;
-	acpi_dev_free_resource_list(&resources);
 
 	if (resource_type(&io_res) != IORESOURCE_MEM) {
 		dev_err(dev, FW_BUG "TPM2 ACPI table does not define a memory resource\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_early;
 	}
 
 	priv->iobase = devm_ioremap_resource(dev, &io_res);
-	if (IS_ERR(priv->iobase))
-		return PTR_ERR(priv->iobase);
+	if (IS_ERR(priv->iobase)) {
+		ret = PTR_ERR(priv->iobase);
+		goto out_early;
+	}
 
 	/* The ACPI IO region starts at the head area and continues to include
 	 * the control area, as one nice sane region except for some older
@@ -532,7 +557,7 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 
 	ret = __crb_request_locality(dev, priv, 0);
 	if (ret)
-		return ret;
+		goto out_early;
 
 	priv->regs_t = crb_map_res(dev, priv, &io_res, buf->control_address,
 				   sizeof(struct crb_regs_tail));
@@ -552,7 +577,7 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 	pa_high = ioread32(&priv->regs_t->ctrl_cmd_pa_high);
 	pa_low  = ioread32(&priv->regs_t->ctrl_cmd_pa_low);
 	cmd_pa = ((u64)pa_high << 32) | pa_low;
-	cmd_size = crb_fixup_cmd_size(dev, &io_res, cmd_pa,
+	cmd_size = crb_fixup_cmd_size(dev, &resources, cmd_pa,
 				      ioread32(&priv->regs_t->ctrl_cmd_size));
 
 	dev_dbg(dev, "cmd_hi = %X cmd_low = %X cmd_size %X\n",
@@ -566,7 +591,7 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 
 	memcpy_fromio(&__rsp_pa, &priv->regs_t->ctrl_rsp_pa, 8);
 	rsp_pa = le64_to_cpu(__rsp_pa);
-	rsp_size = crb_fixup_cmd_size(dev, &io_res, rsp_pa,
+	rsp_size = crb_fixup_cmd_size(dev, &resources, rsp_pa,
 				      ioread32(&priv->regs_t->ctrl_rsp_size));
 
 	if (cmd_pa != rsp_pa) {
@@ -596,6 +621,9 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 
 	__crb_relinquish_locality(dev, priv, 0);
 
+out_early:
+	acpi_dev_free_resource_list(&resources);
+
 	return ret;
 }
 
-- 
2.21.0

