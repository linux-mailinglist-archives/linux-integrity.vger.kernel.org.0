Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1FB2AD55D
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Sep 2019 11:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389675AbfIIJJn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Sep 2019 05:09:43 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34603 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbfIIJJn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Sep 2019 05:09:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id n9so7471520pgc.1;
        Mon, 09 Sep 2019 02:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HS6kcBN/uYMkezRRdkaCixU4ecVlYVshjauFLwWbMW4=;
        b=qJFPb5ynx27laDy4+du2LlnjNmU4o8fiUKELF2qf3lX2FWdEtsqM1/m964FZvo8jTJ
         og7buWg1PhRmcH3kyhZFxDXVgZiL7oj2qxYfH/WAehE+V3GWf0ga7LdyEuflBtDSYlGJ
         dtYBIt6J23r/fj2WKWuOSRVDMgWY8L00KWD+0H2+qcw1rH8qGMaRYD0IEQ0nDhtYE24l
         ujO++wk/okxwdobLSI7LfuvG3N0xcslMbL2fMr9NwdynNy6XeXRbq+unXNRoSP/fliMU
         8D508iWmNeNnPC6vtlpiv/LRirNjqP5GiEmOiSqX1vLGyFptm/Rp7ixGjF6dC7O9XH7N
         EOXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HS6kcBN/uYMkezRRdkaCixU4ecVlYVshjauFLwWbMW4=;
        b=VXDjn3glrDcWsW44F5e8uCNY+/UC0q8GKtUyEjaWq7E/IW9R18RZ5dN2S5u4ILFeqZ
         ywOcssnFUkCB/Ho8L1kFASWFO6fRE3PpNbuPvbTCISGq5czPtivMdajOtH7YkFtZ7USK
         a04aC6AI0ZBHLxaxnG66wnnQVuq95pGv3eSjcvtbKJDQ/xXD38CckibIckx4deQKlqqA
         zn6XmXrRqzHH3MorRXGaObhSiPTiQOZsAqulvlp2T3S3TVqIdiEwQL51PZMPalpcMfMj
         ZaEcWoEDt/1pVkFQJYaFzTKserZaKfgMHCcv5VftBpxvxp9RtJm9P7ihSYwt5AzQ8tkO
         0Pkw==
X-Gm-Message-State: APjAAAW74Q4IKvIUP59r0Qx4+jxrtmnjYfDt6MQCt0RJIcdR2Rm/pPZp
        /e/7pejgPrFtGGdmZbgBB5A=
X-Google-Smtp-Source: APXvYqzvIULf+YMO9YaLtqNXQaCWuzi+kDVVUfAE6NyE8gtqi/jivHkUmL0PH+wRdCP++yZ4Bjb9tg==
X-Received: by 2002:a17:90a:dd42:: with SMTP id u2mr10479178pjv.116.1568020182088;
        Mon, 09 Sep 2019 02:09:42 -0700 (PDT)
Received: from localhost.localdomain ([175.203.71.146])
        by smtp.googlemail.com with ESMTPSA id s18sm19122962pfh.0.2019.09.09.02.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 02:09:41 -0700 (PDT)
From:   Seunghun Han <kkamagui@gmail.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        linux-integrity@vger.kernel.org (open list:TPM DEVICE DRIVER),
        linux-kernel@vger.kernel.org, Seunghun Han <kkamagui@gmail.com>
Subject: [PATCH v2 1/2] tpm: tpm_crb: enhance command and response buffer size calculation code
Date:   Mon,  9 Sep 2019 18:09:05 +0900
Message-Id: <20190909090906.28700-2-kkamagui@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190909090906.28700-1-kkamagui@gmail.com>
References: <20190909090906.28700-1-kkamagui@gmail.com>
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
Changes in v2: same as v1.

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

