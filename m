Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C88F99CAD6
	for <lists+linux-integrity@lfdr.de>; Mon, 26 Aug 2019 09:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729941AbfHZHoN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Aug 2019 03:44:13 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39331 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbfHZHoM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Aug 2019 03:44:12 -0400
Received: by mail-pg1-f194.google.com with SMTP id u17so10076640pgi.6;
        Mon, 26 Aug 2019 00:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=585IXWVt6xNyJ0Q/dtfIKZTuL2RaY57uYTI+DFMs4EQ=;
        b=jyyULK8dc03cP+jhSF7f9NSi9ySYQ5nedZb3+BIccmvvcz2zt34jKLse1fdlTYO7GM
         9BbiqSvvr8l7x80mMYJH+rmN2Wo+cwIYOPBqzerlS1ncG1ww+Od/198O9ffx14viIrjV
         R7LV7KucDgtqBBy+WOZ1G8atRI6pOS+72aSLplk7gYyMPU4YrakiwCszV7xue18U4SLH
         css20hSeKRPAcpkMs3n7kQUT7YF9RbvRTM+QpAB5fwH+SzTUCGH/2EuuIdC/saYUPz+9
         xG9Oj4QhYH1LJ8d0MxxeL5qpTFEmn5SFoHYrMdTsixU29ms9POQtdm0XWwksAEsjgKx9
         Rumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=585IXWVt6xNyJ0Q/dtfIKZTuL2RaY57uYTI+DFMs4EQ=;
        b=d745aHVhnk3wKXHikleqHb6iheEV6FpoRlpV134vhBao7ZnpFUcQ9E7WKDDREE2fV4
         K+k/Z2ZkTsG3gP8Y0kll4sI7Pkm0gWn3R2vqJ3DrdeBTZfdxTq/s6qJc6fw0ih0kP79M
         j+XwuwzHmaxz1jSgF57+7nlvYG2tnCWwFchKAzLLifToqhbCsDx8EpurXe0O7qQB5JiL
         hVQZmObQTSdg6OG5i+jj/wfbekL7ByGfRq/CUNzxLrVakIeAEB6UATqZAd2X8xgyqeYP
         OYDWbqxjHl0Swx7eyneiBnl7XtezhS3IJej7Z4JFnJ4ABiF/TWespZ0z1rnA+GINTKnn
         DMeA==
X-Gm-Message-State: APjAAAXoemAzyVeeP14KB/ih63OYnlpqUcYaEcmYNFkQN7RVPq64ojR+
        e/u7+gqnJFGc4MpUfYakL54=
X-Google-Smtp-Source: APXvYqxOs1ABJL68Zmg3CdnBarmtBpxNBoCXyNOYp2NusIeT+oonQgf1bsZ0u7Vjqua5Ps/gVmikHg==
X-Received: by 2002:a17:90b:289:: with SMTP id az9mr18853832pjb.5.1566805451474;
        Mon, 26 Aug 2019 00:44:11 -0700 (PDT)
Received: from localhost.localdomain ([175.203.71.146])
        by smtp.googlemail.com with ESMTPSA id h17sm12144510pfo.24.2019.08.26.00.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 00:44:10 -0700 (PDT)
From:   Seunghun Han <kkamagui@gmail.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        linux-integrity@vger.kernel.org (open list:TPM DEVICE DRIVER),
        linux-kernel@vger.kernel.org, Seunghun Han <kkamagui@gmail.com>
Subject: [PATCH] tpm: tpm_crb: Fix an improper buffer size calculation bug
Date:   Mon, 26 Aug 2019 16:44:00 +0900
Message-Id: <20190826074400.54794-1-kkamagui@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

I'm Seunghun Han and work at the Affiliated Institute of ETRI. I found
a bug related to improper buffer size calculation in crb_fixup_cmd_size
function.

When the TPM CRB regions are two or more, the crb_map_io function calls
crb_fixup_cmd_size twice to calculate command buffer size and response
buffer size. The purpose of crb_fixup_cmd_size function is to trust
the ACPI region information.

However, the function compares only io_res argument with start and size
arguments.  It means the io_res argument is one of command buffer and
response buffer regions. It also means the other region is not calculated
correctly by the function because io_res argument doesn't cover all TPM
CRB regions.

To fix this bug, I change crb_check_resource function for storing all TPB
CRB regions to a list and use the list to calculate command buffer size
and response buffer size correctly.

Signed-off-by: Seunghun Han <kkamagui@gmail.com>
---
 drivers/char/tpm/tpm_crb.c | 50 ++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index e59f1f91d7f3..b0e94e02e5eb 100644
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
@@ -471,20 +474,30 @@ static void __iomem *crb_map_res(struct device *dev, struct crb_priv *priv,
  * region vs the registers. Trust the ACPI region. Such broken systems
  * probably cannot send large TPM commands since the buffer will be truncated.
  */
-static u64 crb_fixup_cmd_size(struct device *dev, struct resource *io_res,
+static u64 crb_fixup_cmd_size(struct device *dev, struct list_head *resources,
 			      u64 start, u64 size)
 {
-	if (io_res->start > start || io_res->end < start)
-		return size;
+	struct resource_entry *pos;
+	struct resource *cur_res;
+
+	/* Check all TPM CRB resources with the start and size values */
+	resource_list_for_each_entry(pos, resources) {
+		cur_res = pos->res;
+
+		if (cur_res->start > start || cur_res->end < start)
+			continue;
 
-	if (start + size - 1 <= io_res->end)
-		return size;
+		if (start + size - 1 <= cur_res->end)
+			return size;
 
-	dev_err(dev,
-		FW_BUG "ACPI region does not cover the entire command/response buffer. %pr vs %llx %llx\n",
-		io_res, start, size);
+		dev_err(dev,
+			FW_BUG "ACPI region does not cover the entire command/response buffer. %pr vs %llx %llx\n",
+			cur_res, start, size);
+
+		return cur_res->end - start + 1;
+	}
 
-	return io_res->end - start + 1;
+	return size;
 }
 
 static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
@@ -506,16 +519,18 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
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
@@ -532,7 +547,7 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 
 	ret = __crb_request_locality(dev, priv, 0);
 	if (ret)
-		return ret;
+		goto out_early;
 
 	priv->regs_t = crb_map_res(dev, priv, &io_res, buf->control_address,
 				   sizeof(struct crb_regs_tail));
@@ -552,7 +567,7 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 	pa_high = ioread32(&priv->regs_t->ctrl_cmd_pa_high);
 	pa_low  = ioread32(&priv->regs_t->ctrl_cmd_pa_low);
 	cmd_pa = ((u64)pa_high << 32) | pa_low;
-	cmd_size = crb_fixup_cmd_size(dev, &io_res, cmd_pa,
+	cmd_size = crb_fixup_cmd_size(dev, &resources, cmd_pa,
 				      ioread32(&priv->regs_t->ctrl_cmd_size));
 
 	dev_dbg(dev, "cmd_hi = %X cmd_low = %X cmd_size %X\n",
@@ -566,7 +581,7 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 
 	memcpy_fromio(&__rsp_pa, &priv->regs_t->ctrl_rsp_pa, 8);
 	rsp_pa = le64_to_cpu(__rsp_pa);
-	rsp_size = crb_fixup_cmd_size(dev, &io_res, rsp_pa,
+	rsp_size = crb_fixup_cmd_size(dev, &resources, rsp_pa,
 				      ioread32(&priv->regs_t->ctrl_rsp_size));
 
 	if (cmd_pa != rsp_pa) {
@@ -596,6 +611,9 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 
 	__crb_relinquish_locality(dev, priv, 0);
 
+out_early:
+	acpi_dev_free_resource_list(&resources);
+
 	return ret;
 }
 
-- 
2.21.0

