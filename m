Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2483DBE7FD
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Sep 2019 00:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfIYWBt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Sep 2019 18:01:49 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39063 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfIYV5E (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Sep 2019 17:57:04 -0400
Received: by mail-ed1-f66.google.com with SMTP id a15so126105edt.6;
        Wed, 25 Sep 2019 14:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oQZeaHgtYh0dD0KrAMF75weGYKIwWi478Xo02rJo9NM=;
        b=M6p59jXoKzYA17xImqRlpAb8+4jCreGabZtES2pHk/F58g0JCpDtQunI1mvZVgLnaG
         2IzQZtwwuJpg13P7tVfki4yKnkpRtRDwh5TWYqgKjvBn9xdGH6t1wYx+fF8T0Wtrhmb6
         Dlr1IR+Kg0hPd9s2vdIH1NkJLgox2VwADBxofEIi8GBoti9wnnAqLR2EvxbpW7hFElWj
         SlNYwXLdlZPN+IeKMzirdZL2+klAZYYN4bAPKPrs1DrX5eDjnJKSmgeTnVCkkdLFv9RG
         4JCB01xMLrnjEyLWb38eqb8LECxhYSLbGd06tTkclMJf6lNup8MJ5jKYAoxb9tQ3T2kT
         GPkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oQZeaHgtYh0dD0KrAMF75weGYKIwWi478Xo02rJo9NM=;
        b=UD18zjbIy+xdWA6baR1lAkeJ8qT+bTAajfaUM6g11M8WsVyM4gex6T7CiTAmCXgQK2
         GfyOxrgNq6O4ijJNH+UlhcGAXVmp/PAQOLUjFksgdNz7iR2sUnLqEyRqzlp8lLxfOItr
         KzQLoWXPtYPyJaEi6HKSAorvH0BOOxZW9njXP6ZS34JtetMAyhvundwfN2VSnnbDBWwa
         2AC+z3EoYMh0aBxllahf2kfnQrEcxoaX2uhap1DGuhfpUjoQMxUZDAHTYlaS/jXIo/sq
         L086wWZjDU0r6BgptLzQe7kMBMJZuywflotjcGLk4LDlDemjQwuaQe142IIMWMNgdF+E
         rfkg==
X-Gm-Message-State: APjAAAV6ZuukZDt1/gZYhslozmVw718LFvYHOyAMOrYJ5NfSQoojgDlZ
        fPfKRatOk2y0dtwzORQD/tQ=
X-Google-Smtp-Source: APXvYqw2VpUlnvQ+wx3TkAuOYVDS4hAWOnzWYW9ExgQ9wXevhlKU6csobaOMSAoogfsRvmo71L4/Xw==
X-Received: by 2002:a05:6402:1583:: with SMTP id c3mr189150edv.286.1569448620358;
        Wed, 25 Sep 2019 14:57:00 -0700 (PDT)
Received: from hv-1.home ([188.187.26.81])
        by smtp.gmail.com with ESMTPSA id g17sm3972ejb.80.2019.09.25.14.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 14:56:59 -0700 (PDT)
From:   ivan.lazeev@gmail.com
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivan Lazeev <ivan.lazeev@gmail.com>
Subject: [PATCH v5] tpm_crb: fix fTPM on AMD Zen+ CPUs
Date:   Thu, 26 Sep 2019 00:56:46 +0300
Message-Id: <20190925215646.24844-1-ivan.lazeev@gmail.com>
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
device in struct crb_resources. It contains fixed arrays of
copies of ACPI resourses (iores field) and pointers
to a possibly allocated with devm_ioremap_resource memory region
(iobase field), along with number of entries (num field).
This data was previously held for a single resource
in struct crb_priv (iobase field) and local variable io_res in
crb_map_io function. ACPI resources array is used to find index of
corresponding region for each buffer with crb_containing_res_idx,
make the buffer size consistent with region's length and map it at
most once, storing pointer to the allocated resource in iobase
array at the same index.

Signed-off-by: Ivan Lazeev <ivan.lazeev@gmail.com>
---

Changes in v5:
	- prefix new symbols with tpm_crb_
	- get rid of dynamic allocation in ACPI walker

 drivers/char/tpm/tpm_crb.c | 129 +++++++++++++++++++++++++++----------
 1 file changed, 96 insertions(+), 33 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index e59f1f91d7f3..3c2485c71260 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -22,6 +22,7 @@
 #include "tpm.h"
 
 #define ACPI_SIG_TPM2 "TPM2"
+#define TPM_CRB_MAX_RESOURCES 3
 
 static const guid_t crb_acpi_start_guid =
 	GUID_INIT(0x6BBF6CAB, 0x5463, 0x4714,
@@ -91,7 +92,6 @@ enum crb_status {
 struct crb_priv {
 	u32 sm;
 	const char *hid;
-	void __iomem *iobase;
 	struct crb_regs_head __iomem *regs_h;
 	struct crb_regs_tail __iomem *regs_t;
 	u8 __iomem *cmd;
@@ -108,6 +108,12 @@ struct tpm2_crb_smc {
 	u32 smc_func_id;
 };
 
+struct tpm_crb_resources {
+	struct resource iores[TPM_CRB_MAX_RESOURCES];
+	void __iomem *iobase[TPM_CRB_MAX_RESOURCES];
+	int num;
+};
+
 static bool crb_wait_for_reg_32(u32 __iomem *reg, u32 mask, u32 value,
 				unsigned long timeout)
 {
@@ -432,38 +438,75 @@ static const struct tpm_class_ops tpm_crb = {
 	.req_complete_val = CRB_DRV_STS_COMPLETE,
 };
 
+static bool tpm_crb_resource_contains(struct resource *iores,
+				      u64 address)
+{
+	return address >= iores->start && address <= iores->end;
+}
+
+static int tpm_crb_containing_res_idx(struct tpm_crb_resources *resources,
+				      u64 address)
+{
+	int res_idx;
+
+	for (res_idx = 0; res_idx < resources->num; ++res_idx) {
+		if (tpm_crb_resource_contains(&resources->iores[res_idx],
+					      address))
+			return res_idx;
+	}
+
+	return -1;
+}
+
 static int crb_check_resource(struct acpi_resource *ares, void *data)
 {
-	struct resource *io_res = data;
+	struct tpm_crb_resources *resources = data;
 	struct resource_win win;
 	struct resource *res = &(win.res);
 
 	if (acpi_dev_resource_memory(ares, res) ||
 	    acpi_dev_resource_address_space(ares, &win)) {
-		*io_res = *res;
-		io_res->name = NULL;
+		if (resources->num < TPM_CRB_MAX_RESOURCES) {
+			resources->iores[resources->num] = *res;
+			resources->iores[resources->num].name = NULL;
+		}
+		resources->num += 1;
 	}
 
 	return 1;
 }
 
-static void __iomem *crb_map_res(struct device *dev, struct crb_priv *priv,
-				 struct resource *io_res, u64 start, u32 size)
+static void __iomem *crb_map_res(struct device *dev,
+				 struct tpm_crb_resources *resources,
+				 int res_idx,
+				 u64 start, u32 size)
 {
 	struct resource new_res = {
 		.start	= start,
 		.end	= start + size - 1,
 		.flags	= IORESOURCE_MEM,
 	};
+	struct resource *iores;
+	void __iomem *iobase;
 
 	/* Detect a 64 bit address on a 32 bit system */
 	if (start != new_res.start)
 		return (void __iomem *) ERR_PTR(-EINVAL);
 
-	if (!resource_contains(io_res, &new_res))
+	if (res_idx < 0)
 		return devm_ioremap_resource(dev, &new_res);
 
-	return priv->iobase + (new_res.start - io_res->start);
+	iores = &resources->iores[res_idx];
+	iobase = resources->iobase[res_idx];
+	if (!iobase) {
+		iobase = devm_ioremap_resource(dev, iores);
+		if (IS_ERR(iobase))
+			return iobase;
+
+		resources->iobase[res_idx] = iobase;
+	}
+
+	return iobase + (new_res.start - iores->start);
 }
 
 /*
@@ -490,9 +533,10 @@ static u64 crb_fixup_cmd_size(struct device *dev, struct resource *io_res,
 static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 		      struct acpi_table_tpm2 *buf)
 {
-	struct list_head resources;
-	struct resource io_res;
+	struct list_head acpi_resources;
 	struct device *dev = &device->dev;
+	struct tpm_crb_resources resources;
+	int res_idx;
 	u32 pa_high, pa_low;
 	u64 cmd_pa;
 	u32 cmd_size;
@@ -501,21 +545,36 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 	u32 rsp_size;
 	int ret;
 
-	INIT_LIST_HEAD(&resources);
-	ret = acpi_dev_get_resources(device, &resources, crb_check_resource,
-				     &io_res);
+	INIT_LIST_HEAD(&acpi_resources);
+	memset(&resources, 0, sizeof(resources));
+	ret = acpi_dev_get_resources(device, &acpi_resources,
+				     crb_check_resource, &resources);
 	if (ret < 0)
 		return ret;
-	acpi_dev_free_resource_list(&resources);
+	acpi_dev_free_resource_list(&acpi_resources);
 
-	if (resource_type(&io_res) != IORESOURCE_MEM) {
+	if (resources.num == 0) {
 		dev_err(dev, FW_BUG "TPM2 ACPI table does not define a memory resource\n");
 		return -EINVAL;
+	} else if (resources.num > TPM_CRB_MAX_RESOURCES) {
+		dev_warn(dev, FW_BUG "TPM2 ACPI table defines too many memory resources\n");
+		resources.num = TPM_CRB_MAX_RESOURCES;
 	}
 
-	priv->iobase = devm_ioremap_resource(dev, &io_res);
-	if (IS_ERR(priv->iobase))
-		return PTR_ERR(priv->iobase);
+	res_idx = tpm_crb_containing_res_idx(&resources, buf->control_address);
+
+	if (res_idx >= 0 &&
+	    !tpm_crb_resource_contains(&resources.iores[res_idx],
+				       buf->control_address +
+				       sizeof(struct crb_regs_tail) - 1))
+		res_idx = -1;
+
+	priv->regs_t = crb_map_res(dev, &resources, res_idx,
+				   buf->control_address,
+				   sizeof(struct crb_regs_tail));
+
+	if (IS_ERR(priv->regs_t))
+		return PTR_ERR(priv->regs_t);
 
 	/* The ACPI IO region starts at the head area and continues to include
 	 * the control area, as one nice sane region except for some older
@@ -523,9 +582,10 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 	 */
 	if ((priv->sm == ACPI_TPM2_COMMAND_BUFFER) ||
 	    (priv->sm == ACPI_TPM2_MEMORY_MAPPED)) {
-		if (buf->control_address == io_res.start +
+		if (res_idx >= 0 &&
+		    buf->control_address == resources.iores[res_idx].start +
 		    sizeof(*priv->regs_h))
-			priv->regs_h = priv->iobase;
+			priv->regs_h = resources.iobase[res_idx];
 		else
 			dev_warn(dev, FW_BUG "Bad ACPI memory layout");
 	}
@@ -534,13 +594,6 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 	if (ret)
 		return ret;
 
-	priv->regs_t = crb_map_res(dev, priv, &io_res, buf->control_address,
-				   sizeof(struct crb_regs_tail));
-	if (IS_ERR(priv->regs_t)) {
-		ret = PTR_ERR(priv->regs_t);
-		goto out_relinquish_locality;
-	}
-
 	/*
 	 * PTT HW bug w/a: wake up the device to access
 	 * possibly not retained registers.
@@ -552,13 +605,17 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 	pa_high = ioread32(&priv->regs_t->ctrl_cmd_pa_high);
 	pa_low  = ioread32(&priv->regs_t->ctrl_cmd_pa_low);
 	cmd_pa = ((u64)pa_high << 32) | pa_low;
-	cmd_size = crb_fixup_cmd_size(dev, &io_res, cmd_pa,
-				      ioread32(&priv->regs_t->ctrl_cmd_size));
+	cmd_size = ioread32(&priv->regs_t->ctrl_cmd_size);
+
+	res_idx = tpm_crb_containing_res_idx(&resources, cmd_pa);
+	if (res_idx >= 0)
+		cmd_size = crb_fixup_cmd_size(dev, &resources.iores[res_idx],
+					      cmd_pa, cmd_size);
 
 	dev_dbg(dev, "cmd_hi = %X cmd_low = %X cmd_size %X\n",
 		pa_high, pa_low, cmd_size);
 
-	priv->cmd = crb_map_res(dev, priv, &io_res, cmd_pa, cmd_size);
+	priv->cmd = crb_map_res(dev, &resources, res_idx, cmd_pa, cmd_size);
 	if (IS_ERR(priv->cmd)) {
 		ret = PTR_ERR(priv->cmd);
 		goto out;
@@ -566,11 +623,17 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 
 	memcpy_fromio(&__rsp_pa, &priv->regs_t->ctrl_rsp_pa, 8);
 	rsp_pa = le64_to_cpu(__rsp_pa);
-	rsp_size = crb_fixup_cmd_size(dev, &io_res, rsp_pa,
-				      ioread32(&priv->regs_t->ctrl_rsp_size));
+	rsp_size = ioread32(&priv->regs_t->ctrl_rsp_size);
+
+	res_idx = tpm_crb_containing_res_idx(&resources, rsp_pa);
+
+	if (res_idx >= 0)
+		rsp_size = crb_fixup_cmd_size(dev, &resources.iores[res_idx],
+					      rsp_pa, rsp_size);
 
 	if (cmd_pa != rsp_pa) {
-		priv->rsp = crb_map_res(dev, priv, &io_res, rsp_pa, rsp_size);
+		priv->rsp = crb_map_res(dev, &resources, res_idx,
+					rsp_pa, rsp_size);
 		ret = PTR_ERR_OR_ZERO(priv->rsp);
 		goto out;
 	}
-- 
2.20.1

