Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7146F892F1
	for <lists+linux-integrity@lfdr.de>; Sun, 11 Aug 2019 19:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbfHKRp1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 11 Aug 2019 13:45:27 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38536 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbfHKRp1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 11 Aug 2019 13:45:27 -0400
Received: by mail-ed1-f66.google.com with SMTP id r12so66911857edo.5;
        Sun, 11 Aug 2019 10:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OkeSRQnN4oJ7aQxCKbRmPDsqrGLxx5oJbZpuRmRzFxE=;
        b=hDCw0RzgUcdGshA30IFBVJ0qwvIFt+P4f/s7LxZr/lxRRlmHje6fZiw1r8nLDNYBZf
         BLSMQioVCu/kIJMUZoSo8FZUBKlEX3NaQZtRaNpBB6RHzF7ddYeCQYweY/U/iMLJ4a6s
         V6NH1HEa9HldSxE0scrTfGYtkbpsbO0XBc0QprSibRitbzOmDAU5xBUOX8u4SJt82LCH
         tJj+Ct9Pwlqkc3W7Y+tMH2t9ivUiTnHaRPrUPTyR9XW/SpLp8bcFrK869tDOexBT+UwM
         9yISCbiIvgjy9zz3TRATd+SbcvcLDvPQRAmkxrxWorvWWCtxYZkdJlOQyzuLXMUkW89/
         nlNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OkeSRQnN4oJ7aQxCKbRmPDsqrGLxx5oJbZpuRmRzFxE=;
        b=FMgeNIOFOHzXD8cRYbZ7Swaiwb5vD3l4x0ANNQ+T9AWrTsXsu3qFT3FxtHvLf6U+PJ
         DrR7iSt13JDq3tp5ZdtBKjWue94IBFxG9ccrt+XfCY6cjIUOKSD4FSfpLkqdvGLHXI/B
         CL2SBsmBg1/eBR4saG+Np89T6vdXLGJzCAaIh2gQc+CFRMmsSL89JA0sdTGzYgVACtNu
         xqMMWSX8VFFVO8LS3O0/d431VTStPuy+SY+JUr89oeiyeIQncvXR5bqGLGpbO1pg+w84
         /EJtz53oZGgCJZiJOEa9iAnBiCwwDXU+R9gerOTiCc+mmsBgPdLsbrLzup/8By2jSx+W
         PdCQ==
X-Gm-Message-State: APjAAAW9R8J7+6GeSnnCDjDieZuBl/E8CWi24gCzXR+fXAJaGuAwEGMy
        CcJlxC8lLGQRsSk7iPyfTkw=
X-Google-Smtp-Source: APXvYqxnUEW3Zmsu5QV75FAahLBrsP0cq3QNr0G1kPvfaowEXw/nVeMOCkecD+DLBpUMkhTfFsoNvw==
X-Received: by 2002:a50:8858:: with SMTP id c24mr136498edc.253.1565545524996;
        Sun, 11 Aug 2019 10:45:24 -0700 (PDT)
Received: from localhost.localdomain ([188.187.105.131])
        by smtp.gmail.com with ESMTPSA id y4sm245868ejj.8.2019.08.11.10.45.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 11 Aug 2019 10:45:24 -0700 (PDT)
From:   ivan.lazeev@gmail.com
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vanya Lazeev <ivan.lazeev@gmail.com>
Subject: [PATCH] Fix fTPM on AMD Zen+ CPUs
Date:   Sun, 11 Aug 2019 20:45:05 +0300
Message-Id: <20190811174505.27019-1-ivan.lazeev@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Vanya Lazeev <ivan.lazeev@gmail.com>

The patch is an attempt to make fTPM on AMD Zen CPUs work.
Bug link: https://bugzilla.kernel.org/show_bug.cgi?id=195657

The problem seems to be that tpm_crb driver doesn't expect tpm command
and response memory regions to belong to different ACPI resources.

Tested on Asrock ITX motherboard with Ryzen 2600X CPU.
However, I don't have any other hardware to test the changes on and no
expertise to be sure that other TPMs won't break as a result.
Hopefully, the patch will be useful.

Signed-off-by: Vanya Lazeev <ivan.lazeev@gmail.com>
---
 drivers/char/tpm/tpm_crb.c | 146 ++++++++++++++++++++++++++++---------
 1 file changed, 110 insertions(+), 36 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index e59f1f91d..73e4b9105 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -91,7 +91,6 @@ enum crb_status {
 struct crb_priv {
 	u32 sm;
 	const char *hid;
-	void __iomem *iobase;
 	struct crb_regs_head __iomem *regs_h;
 	struct crb_regs_tail __iomem *regs_t;
 	u8 __iomem *cmd;
@@ -108,6 +107,13 @@ struct tpm2_crb_smc {
 	u32 smc_func_id;
 };
 
+struct crb_resource {
+	struct resource io_res;
+	void __iomem *iobase;
+
+	struct list_head link;
+};
+
 static bool crb_wait_for_reg_32(u32 __iomem *reg, u32 mask, u32 value,
 				unsigned long timeout)
 {
@@ -432,23 +438,69 @@ static const struct tpm_class_ops tpm_crb = {
 	.req_complete_val = CRB_DRV_STS_COMPLETE,
 };
 
+static void crb_free_resource_list(struct list_head *resources)
+{
+	struct list_head *position;
+
+	list_for_each(position, resources)
+		kfree(list_entry(position, struct crb_resource, link));
+}
+
+/**
+ * Checks if resource @io_res contains range with the specified @start and @size
+ * completely or, when @strict is false, at least it's beginning.
+ * Non-strict match is needed to work around broken BIOSes that return
+ * inconsistent values from ACPI regions vs registers.
+ */
+static inline bool crb_resource_contains(const struct resource *io_res,
+					 u64 start, u32 size, bool strict)
+{
+	return start >= io_res->start &&
+		(start + size - 1 <= io_res->end ||
+		 (!strict && start <= io_res->end));
+}
+
+static struct crb_resource *crb_containing_resource(
+		const struct list_head *resources,
+		u64 start, u32 size, bool strict)
+{
+	struct list_head *pos;
+
+	list_for_each(pos, resources) {
+		struct crb_resource *cres;
+
+		cres = list_entry(pos, struct crb_resource, link);
+		if (crb_resource_contains(&cres->io_res, start, size, strict))
+			return cres;
+	}
+
+	return NULL;
+}
+
 static int crb_check_resource(struct acpi_resource *ares, void *data)
 {
-	struct resource *io_res = data;
+	struct list_head *list = data;
+	struct crb_resource *cres;
 	struct resource_win win;
 	struct resource *res = &(win.res);
 
 	if (acpi_dev_resource_memory(ares, res) ||
 	    acpi_dev_resource_address_space(ares, &win)) {
-		*io_res = *res;
-		io_res->name = NULL;
+		cres = kzalloc(sizeof(*cres), GFP_KERNEL);
+		if (!cres)
+			return -ENOMEM;
+
+		cres->io_res = *res;
+		cres->io_res.name = NULL;
+
+		list_add_tail(&cres->link, list);
 	}
 
 	return 1;
 }
 
-static void __iomem *crb_map_res(struct device *dev, struct crb_priv *priv,
-				 struct resource *io_res, u64 start, u32 size)
+static void __iomem *crb_map_res(struct device *dev, struct crb_resource *cres,
+				 u64 start, u32 size)
 {
 	struct resource new_res = {
 		.start	= start,
@@ -460,10 +512,16 @@ static void __iomem *crb_map_res(struct device *dev, struct crb_priv *priv,
 	if (start != new_res.start)
 		return (void __iomem *) ERR_PTR(-EINVAL);
 
-	if (!resource_contains(io_res, &new_res))
+	if (!cres)
 		return devm_ioremap_resource(dev, &new_res);
 
-	return priv->iobase + (new_res.start - io_res->start);
+	if (!cres->iobase) {
+		cres->iobase = devm_ioremap_resource(dev, &cres->io_res);
+		if (IS_ERR(cres->iobase))
+			return cres->iobase;
+	}
+
+	return cres->iobase + (new_res.start - cres->io_res.start);
 }
 
 /*
@@ -490,9 +548,9 @@ static u64 crb_fixup_cmd_size(struct device *dev, struct resource *io_res,
 static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 		      struct acpi_table_tpm2 *buf)
 {
-	struct list_head resources;
-	struct resource io_res;
+	struct list_head acpi_resources, crb_resources;
 	struct device *dev = &device->dev;
+	struct crb_resource *cres;
 	u32 pa_high, pa_low;
 	u64 cmd_pa;
 	u32 cmd_size;
@@ -501,21 +559,30 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 	u32 rsp_size;
 	int ret;
 
-	INIT_LIST_HEAD(&resources);
-	ret = acpi_dev_get_resources(device, &resources, crb_check_resource,
-				     &io_res);
+	INIT_LIST_HEAD(&acpi_resources);
+	INIT_LIST_HEAD(&crb_resources);
+	ret = acpi_dev_get_resources(device, &acpi_resources,
+				     crb_check_resource, &crb_resources);
 	if (ret < 0)
-		return ret;
-	acpi_dev_free_resource_list(&resources);
+		goto out_free_crb_resources;
+
+	acpi_dev_free_resource_list(&acpi_resources);
 
-	if (resource_type(&io_res) != IORESOURCE_MEM) {
+	if (list_empty(&crb_resources)) {
 		dev_err(dev, FW_BUG "TPM2 ACPI table does not define a memory resource\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_free_crb_resources;
 	}
 
-	priv->iobase = devm_ioremap_resource(dev, &io_res);
-	if (IS_ERR(priv->iobase))
-		return PTR_ERR(priv->iobase);
+	cres = crb_containing_resource(&crb_resources, buf->control_address,
+				       sizeof(struct crb_regs_tail), true);
+
+	priv->regs_t = crb_map_res(dev, cres, buf->control_address,
+				   sizeof(struct crb_regs_tail));
+	if (IS_ERR(priv->regs_t)) {
+		ret = PTR_ERR(priv->regs_t);
+		goto out_free_crb_resources;
+	}
 
 	/* The ACPI IO region starts at the head area and continues to include
 	 * the control area, as one nice sane region except for some older
@@ -523,23 +590,17 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 	 */
 	if ((priv->sm == ACPI_TPM2_COMMAND_BUFFER) ||
 	    (priv->sm == ACPI_TPM2_MEMORY_MAPPED)) {
-		if (buf->control_address == io_res.start +
+		if (cres &&
+		    buf->control_address == cres->io_res.start +
 		    sizeof(*priv->regs_h))
-			priv->regs_h = priv->iobase;
+			priv->regs_h = cres->iobase;
 		else
 			dev_warn(dev, FW_BUG "Bad ACPI memory layout");
 	}
 
 	ret = __crb_request_locality(dev, priv, 0);
 	if (ret)
-		return ret;
-
-	priv->regs_t = crb_map_res(dev, priv, &io_res, buf->control_address,
-				   sizeof(struct crb_regs_tail));
-	if (IS_ERR(priv->regs_t)) {
-		ret = PTR_ERR(priv->regs_t);
-		goto out_relinquish_locality;
-	}
+		goto out_free_crb_resources;
 
 	/*
 	 * PTT HW bug w/a: wake up the device to access
@@ -552,13 +613,17 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 	pa_high = ioread32(&priv->regs_t->ctrl_cmd_pa_high);
 	pa_low  = ioread32(&priv->regs_t->ctrl_cmd_pa_low);
 	cmd_pa = ((u64)pa_high << 32) | pa_low;
-	cmd_size = crb_fixup_cmd_size(dev, &io_res, cmd_pa,
-				      ioread32(&priv->regs_t->ctrl_cmd_size));
+	cmd_size = ioread32(&priv->regs_t->ctrl_cmd_size);
+
+	cres = crb_containing_resource(&crb_resources, cmd_pa, cmd_size, false);
+	if (cres)
+		cmd_size = crb_fixup_cmd_size(dev, &cres->io_res,
+					      cmd_pa, cmd_size);
 
 	dev_dbg(dev, "cmd_hi = %X cmd_low = %X cmd_size %X\n",
 		pa_high, pa_low, cmd_size);
 
-	priv->cmd = crb_map_res(dev, priv, &io_res, cmd_pa, cmd_size);
+	priv->cmd = crb_map_res(dev, cres, cmd_pa, cmd_size);
 	if (IS_ERR(priv->cmd)) {
 		ret = PTR_ERR(priv->cmd);
 		goto out;
@@ -566,11 +631,16 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 
 	memcpy_fromio(&__rsp_pa, &priv->regs_t->ctrl_rsp_pa, 8);
 	rsp_pa = le64_to_cpu(__rsp_pa);
-	rsp_size = crb_fixup_cmd_size(dev, &io_res, rsp_pa,
-				      ioread32(&priv->regs_t->ctrl_rsp_size));
+	rsp_size = ioread32(&priv->regs_t->ctrl_rsp_size);
+
+	cres = crb_containing_resource(&crb_resources, rsp_pa,
+				       rsp_size, false);
+	if (cres)
+		rsp_size = crb_fixup_cmd_size(dev, &cres->io_res,
+					      rsp_pa, rsp_size);
 
 	if (cmd_pa != rsp_pa) {
-		priv->rsp = crb_map_res(dev, priv, &io_res, rsp_pa, rsp_size);
+		priv->rsp = crb_map_res(dev, cres, rsp_pa, rsp_size);
 		ret = PTR_ERR_OR_ZERO(priv->rsp);
 		goto out;
 	}
@@ -596,6 +666,10 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 
 	__crb_relinquish_locality(dev, priv, 0);
 
+out_free_crb_resources:
+
+	crb_free_resource_list(&crb_resources);
+
 	return ret;
 }
 
-- 
2.20.1

