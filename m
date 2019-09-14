Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7282AB2C63
	for <lists+linux-integrity@lfdr.de>; Sat, 14 Sep 2019 19:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbfINRYY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 14 Sep 2019 13:24:24 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36620 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbfINRYY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 14 Sep 2019 13:24:24 -0400
Received: by mail-ed1-f66.google.com with SMTP id f2so23281751edw.3;
        Sat, 14 Sep 2019 10:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uDU/jUOs9/dlBx87qV1GT/UJJGErBJ44iUk7lwzgTq8=;
        b=aWDftd+YAJRmgwczJtC8D0xrDP3aovGLTIypiOZWbG0PggHrnHrflEboplQgv6Zff/
         KOQ3XDlaxJ4a3/oyk0splgdN5DGPzGU/TUqMyFhIsKWiJoLze46WcPWuPW70sF2adGf3
         Wpx0oTBvC0Sd6t5iyjrvdsGzl7pxj0PbBbqUSyqvTYorXT2zfkD9pUTDY1kZoQjW+jNa
         FBGeiGHQJNoOFNfHQl+/8d9VU+xD+h0iepSyCNpxJ0dpS4E3PZ3FDEzdVOuaK5llNvpq
         khFaYIaULeG91r1iBYqCQ6v8bKbFWS+g0kzPiKpT65LAd85UQ9g99vA1dnw49fP9C5GN
         RRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uDU/jUOs9/dlBx87qV1GT/UJJGErBJ44iUk7lwzgTq8=;
        b=bvMi7XPbOji4OE/C6i3zmnVNSn8Pt43RtgpK89EUjRdX/0zUmu8mOelleGr6PifJ4p
         Aar+jyLGN46gxbHMgERFf3PEgbjDUiXiZBK1FAR0QSeI87RZ7Hu9KCgWJsw2bB12MkXX
         jRv+q8uORi88YjBVi+8X4TbNtyOVJ+EA8+Jqo5VU3ePNJdL0S/EUa8qZOdQELg629Ocb
         6b8yMU43Tb0NOAXG0fnrtrmloFmtW+yN8PQ9Q3GvJoleViTlkuE0335iqlKebR41AR7X
         96UEXKPS0GymGOpyDAY4MrA2j0AZ/q/nuXhsibTAVw0egoXrXWJJkpFAt2EFCN5JSHjP
         afVQ==
X-Gm-Message-State: APjAAAWrgjdt2wlTzEky5LuSZ1eY/ZNnOajSczPfF1JpkHraBVBAMq//
        XXceUBOgcxly9mwtrB925Ls=
X-Google-Smtp-Source: APXvYqwEaZSCZVt71KxpovtHer6jC4x7c6xWxQPFp6wSMYqpwN0B2cXNP/pQHSJD9Ln/iVHdRwZllA==
X-Received: by 2002:a50:9384:: with SMTP id o4mr8337217eda.8.1568481860109;
        Sat, 14 Sep 2019 10:24:20 -0700 (PDT)
Received: from hv-1.home ([188.187.106.181])
        by smtp.gmail.com with ESMTPSA id h6sm5216186ede.35.2019.09.14.10.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2019 10:24:19 -0700 (PDT)
From:   ivan.lazeev@gmail.com
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivan Lazeev <ivan.lazeev@gmail.com>
Subject: [PATCH v4] tpm_crb: fix fTPM on AMD Zen+ CPUs
Date:   Sat, 14 Sep 2019 20:17:44 +0300
Message-Id: <20190914171743.22786-1-ivan.lazeev@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Ivan Lazeev <ivan.lazeev@gmail.com>

Bug link: https://bugzilla.kernel.org/show_bug.cgi?id=195657

cmd/rsp buffers are expected to be in the same ACPI region.
For Zen+ CPUs BIOS's might report two different regions, some of
them also report region sizes inconsistent with values from TPM
registers.

Memory configuration on ASRock x470 ITX:

db0a0000-dc59efff : Reserved
	dc57e000-dc57efff : MSFT0101:00
	dc582000-dc582fff : MSFT0101:00

Work around the issue by storing ACPI regions declared for the
device in a list of struct crb_resource. Each entry holds a
copy of the correcponding ACPI resourse (iores field) and a pointer
to a possibly allocated with devm_ioremap_resource memory region
(iobase field). This data was previously held for a single resource
in struct crb_priv (iobase field) and local variable io_res in
crb_map_io function. The list is used to find corresponding
region for each buffer with crb_containing_resource, make
the buffer size consistent with it's length and map it at most
once, storing the pointer to allocated resource in iobase field
of the entry.

Signed-off-by: Ivan Lazeev <ivan.lazeev@gmail.com>
---

Changes in v3:
	- make crb_containing_resource search for address only,
	  because buffer sizes aren't trusted anyway
	- improve commit message

Changes in v4:
	- rename struct crb_resource fields (style change)
	- improve commit message

I believe that storing the data in a in list of
struct crb_resource makes tracking of the resource allocation
state explicit, aiding clarity.
Whilst everything that worked before seems not to be broken,
there is a possibility of allocating with crb_map_resource a resource
that is not from ACPI table, and state of such resource is not
tracked in the current solution. It might be good to track allocation
of all resources, not just ones declared by ACPI, for complete
correctness. However, as I see it now, it will complicate the
code a bit more. Do you think the change should be made, or
such situation is completely hypothetical?

 drivers/char/tpm/tpm_crb.c | 137 +++++++++++++++++++++++++++----------
 1 file changed, 101 insertions(+), 36 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index e59f1f91d7f3..b301f7fc4a73 100644
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
@@ -108,6 +107,12 @@ struct tpm2_crb_smc {
 	u32 smc_func_id;
 };
 
+struct crb_resource {
+	struct resource iores;
+	void __iomem *iobase;
+	struct list_head list;
+};
+
 static bool crb_wait_for_reg_32(u32 __iomem *reg, u32 mask, u32 value,
 				unsigned long timeout)
 {
@@ -432,23 +437,57 @@ static const struct tpm_class_ops tpm_crb = {
 	.req_complete_val = CRB_DRV_STS_COMPLETE,
 };
 
+static void crb_free_resource_list(struct list_head *resources)
+{
+	struct crb_resource *cres, *tmp;
+
+	list_for_each_entry_safe(cres, tmp, resources, list)
+		kfree(cres);
+}
+
+static inline bool crb_resource_contains(const struct resource *io_res,
+					 u64 address)
+{
+	return address >= io_res->start && address <= io_res->end;
+}
+
+static struct crb_resource *crb_containing_resource(
+		const struct list_head *resources, u64 start)
+{
+	struct crb_resource *cres;
+
+	list_for_each_entry(cres, resources, list) {
+		if (crb_resource_contains(&cres->iores, start))
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
+		cres->iores = *res;
+		cres->iores.name = NULL;
+
+		list_add_tail(&cres->list, list);
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
@@ -460,10 +499,16 @@ static void __iomem *crb_map_res(struct device *dev, struct crb_priv *priv,
 	if (start != new_res.start)
 		return (void __iomem *) ERR_PTR(-EINVAL);
 
-	if (!resource_contains(io_res, &new_res))
+	if (!cres)
 		return devm_ioremap_resource(dev, &new_res);
 
-	return priv->iobase + (new_res.start - io_res->start);
+	if (!cres->iobase) {
+		cres->iobase = devm_ioremap_resource(dev, &cres->iores);
+		if (IS_ERR(cres->iobase))
+			return cres->iobase;
+	}
+
+	return cres->iobase + (new_res.start - cres->iores.start);
 }
 
 /*
@@ -490,9 +535,9 @@ static u64 crb_fixup_cmd_size(struct device *dev, struct resource *io_res,
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
@@ -501,21 +546,34 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
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
 
-	if (resource_type(&io_res) != IORESOURCE_MEM) {
+	acpi_dev_free_resource_list(&acpi_resources);
+
+	if (list_empty(&crb_resources)) {
 		dev_err(dev, FW_BUG "TPM2 ACPI table does not define a memory resource\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto out_free_crb_resources;
 	}
 
-	priv->iobase = devm_ioremap_resource(dev, &io_res);
-	if (IS_ERR(priv->iobase))
-		return PTR_ERR(priv->iobase);
+	cres = crb_containing_resource(&crb_resources, buf->control_address);
+
+	if (cres &&
+	    !crb_resource_contains(&cres->iores, buf->control_address +
+	    sizeof(struct crb_regs_tail) - 1))
+		cres = NULL;
+
+	priv->regs_t = crb_map_res(dev, cres, buf->control_address,
+				   sizeof(struct crb_regs_tail));
+	if (IS_ERR(priv->regs_t)) {
+		ret = PTR_ERR(priv->regs_t);
+		goto out_free_crb_resources;
+	}
 
 	/* The ACPI IO region starts at the head area and continues to include
 	 * the control area, as one nice sane region except for some older
@@ -523,23 +581,17 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 	 */
 	if ((priv->sm == ACPI_TPM2_COMMAND_BUFFER) ||
 	    (priv->sm == ACPI_TPM2_MEMORY_MAPPED)) {
-		if (buf->control_address == io_res.start +
+		if (cres &&
+		    buf->control_address == cres->iores.start +
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
@@ -552,13 +604,17 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 	pa_high = ioread32(&priv->regs_t->ctrl_cmd_pa_high);
 	pa_low  = ioread32(&priv->regs_t->ctrl_cmd_pa_low);
 	cmd_pa = ((u64)pa_high << 32) | pa_low;
-	cmd_size = crb_fixup_cmd_size(dev, &io_res, cmd_pa,
-				      ioread32(&priv->regs_t->ctrl_cmd_size));
+	cmd_size = ioread32(&priv->regs_t->ctrl_cmd_size);
+
+	cres = crb_containing_resource(&crb_resources, cmd_pa);
+	if (cres)
+		cmd_size = crb_fixup_cmd_size(dev, &cres->iores,
+					      cmd_pa, cmd_size);
 
 	dev_dbg(dev, "cmd_hi = %X cmd_low = %X cmd_size %X\n",
 		pa_high, pa_low, cmd_size);
 
-	priv->cmd = crb_map_res(dev, priv, &io_res, cmd_pa, cmd_size);
+	priv->cmd = crb_map_res(dev, cres, cmd_pa, cmd_size);
 	if (IS_ERR(priv->cmd)) {
 		ret = PTR_ERR(priv->cmd);
 		goto out;
@@ -566,11 +622,16 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 
 	memcpy_fromio(&__rsp_pa, &priv->regs_t->ctrl_rsp_pa, 8);
 	rsp_pa = le64_to_cpu(__rsp_pa);
-	rsp_size = crb_fixup_cmd_size(dev, &io_res, rsp_pa,
-				      ioread32(&priv->regs_t->ctrl_rsp_size));
+	rsp_size = ioread32(&priv->regs_t->ctrl_rsp_size);
+
+	cres = crb_containing_resource(&crb_resources, rsp_pa);
+
+	if (cres)
+		rsp_size = crb_fixup_cmd_size(dev, &cres->iores,
+					      rsp_pa, rsp_size);
 
 	if (cmd_pa != rsp_pa) {
-		priv->rsp = crb_map_res(dev, priv, &io_res, rsp_pa, rsp_size);
+		priv->rsp = crb_map_res(dev, cres, rsp_pa, rsp_size);
 		ret = PTR_ERR_OR_ZERO(priv->rsp);
 		goto out;
 	}
@@ -596,6 +657,10 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 
 	__crb_relinquish_locality(dev, priv, 0);
 
+out_free_crb_resources:
+
+	crb_free_resource_list(&crb_resources);
+
 	return ret;
 }
 
-- 
2.20.1

