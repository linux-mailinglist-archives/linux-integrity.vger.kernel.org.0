Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42B22C92CA
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Oct 2019 22:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfJBUM1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Oct 2019 16:12:27 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39508 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfJBUM1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Oct 2019 16:12:27 -0400
Received: by mail-ed1-f65.google.com with SMTP id a15so342162edt.6;
        Wed, 02 Oct 2019 13:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2H3HAqwDFWRcPD+cE3nIWN6ioCzViE4G6EmxoI/3rbg=;
        b=NLgEld46iI9TGxODpxVcj1PFeDdX14rJbJBnKaKPQNu07YZ3qryaLCJSQW+3t4pzSh
         GNKpT4JEeMBeT+9jTPSdHlABHZm6Wfs14/ka1ThZYgiP8bUYzBlrCCX5ZAHSJuqoDR9U
         qaZ0aNGm424up7AtYCrSAJUvTuQdITq6WCVBVPqdP42fTrKzqpacq+ZsVBSwJAdlV6zQ
         GWEyGMjZSd0YMX7b4ZLIWm/eteAD42lTdBP+bMmircndM7mNfT2D1CXEEPq/kya+KoXW
         Fs8FZsfod8PTU9oES2iZC5FnVLWu8vqu9oeuWdQ9CmkMsG0DVS7yRS86OzOn2ROq/U8R
         5PTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2H3HAqwDFWRcPD+cE3nIWN6ioCzViE4G6EmxoI/3rbg=;
        b=eVe099paRngFQE/Gu9qb42+tq2VJ0x5+T7aDrBerWVTQIndlifgrEZCRZ5Gc9Ky6ZI
         gE//pZHP73qNoDuLxuNZ8RWuftu5QPASmrKG1k+M/cy62aHvSHSpc35hdSqmk2S9lDY+
         vqNTf+JIRdviJZ7zvj4+p47t7yuoZ+H/Mrenlpp884geLo2q6sx+IRNnmHeHfQC6kye8
         b1s+lj2zURRxWvknx9jNBJSHUT3bG15YeQsOn8QyuELpftIkpxqzA/531EQ3+uhrNZeA
         wN7i5QrOypy1s0virIq9UGl6k2bWk0nMEDxxY/XtQo1b46azkh+KrVf/HkykneOiYkNR
         0Muw==
X-Gm-Message-State: APjAAAXx16g8ExPXj/hB4MPz4A5RKEjOVgt7w6Xk2j/xPs4O+C0JkOxr
        9pGYFjMLL7eP9xLuuNR9Uu0=
X-Google-Smtp-Source: APXvYqzbhK+Wwgvox6BolNZMZV7+3VG9sdq0SHKAiys2WHInK1fsI/WIEfl3+2sYihol+8Fd/Ux+Cg==
X-Received: by 2002:a50:acc1:: with SMTP id x59mr5868337edc.278.1570047144079;
        Wed, 02 Oct 2019 13:12:24 -0700 (PDT)
Received: from hv-1.home ([188.187.50.94])
        by smtp.gmail.com with ESMTPSA id r18sm30338edx.94.2019.10.02.13.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 13:12:23 -0700 (PDT)
From:   ivan.lazeev@gmail.com
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vanya Lazeev <ivan.lazeev@gmail.com>
Subject: [PATCH v6] tpm_crb: fix fTPM on AMD Zen+ CPUs
Date:   Wed,  2 Oct 2019 23:12:12 +0300
Message-Id: <20191002201212.32395-1-ivan.lazeev@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Vanya Lazeev <ivan.lazeev@gmail.com>

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
device in a fixed array and adding an array for pointers to
corresponding possibly allocated resources in crb_map_io function.
This data was previously held for a single resource
in struct crb_priv (iobase field) and local variable io_res in
crb_map_io function. ACPI resources array is used to find index of
corresponding region for each buffer and make the buffer size
consistent with region's length. Array of pointers to allocated
resources is used to map the region at most once.

Signed-off-by: Ivan Lazeev <ivan.lazeev@gmail.com>
---
Changes in v6:
	- got rid of new structures
	- open coded helper functions
	- removed incorrect FW_BUG

 drivers/char/tpm/tpm_crb.c | 126 +++++++++++++++++++++++++++----------
 1 file changed, 93 insertions(+), 33 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index e59f1f91d7f3..8177406aecd6 100644
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
@@ -434,21 +434,27 @@ static const struct tpm_class_ops tpm_crb = {
 
 static int crb_check_resource(struct acpi_resource *ares, void *data)
 {
-	struct resource *io_res = data;
+	struct resource **iores_range = data;
 	struct resource_win win;
 	struct resource *res = &(win.res);
 
 	if (acpi_dev_resource_memory(ares, res) ||
 	    acpi_dev_resource_address_space(ares, &win)) {
-		*io_res = *res;
-		io_res->name = NULL;
+		if (iores_range[0] == iores_range[1])
+			iores_range[0] = NULL;
+
+		if (iores_range[0]) {
+			*iores_range[0] = *res;
+			iores_range[0]->name = NULL;
+			iores_range[0] += 1;
+		}
 	}
 
 	return 1;
 }
 
-static void __iomem *crb_map_res(struct device *dev, struct crb_priv *priv,
-				 struct resource *io_res, u64 start, u32 size)
+static void __iomem *crb_map_res(struct device *dev, struct resource *iores,
+				 void __iomem **iobase_ptr, u64 start, u32 size)
 {
 	struct resource new_res = {
 		.start	= start,
@@ -460,10 +466,16 @@ static void __iomem *crb_map_res(struct device *dev, struct crb_priv *priv,
 	if (start != new_res.start)
 		return (void __iomem *) ERR_PTR(-EINVAL);
 
-	if (!resource_contains(io_res, &new_res))
+	if (!iores)
 		return devm_ioremap_resource(dev, &new_res);
 
-	return priv->iobase + (new_res.start - io_res->start);
+	if (!*iobase_ptr) {
+		*iobase_ptr = devm_ioremap_resource(dev, iores);
+		if (IS_ERR(*iobase_ptr))
+			return *iobase_ptr;
+	}
+
+	return *iobase_ptr + (new_res.start - iores->start);
 }
 
 /*
@@ -490,9 +502,17 @@ static u64 crb_fixup_cmd_size(struct device *dev, struct resource *io_res,
 static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 		      struct acpi_table_tpm2 *buf)
 {
-	struct list_head resources;
-	struct resource io_res;
+	struct list_head acpi_resource_list;
+	struct resource iores_array[TPM_CRB_MAX_RESOURCES];
+	void __iomem *iobase_array[TPM_CRB_MAX_RESOURCES] = {0};
+	struct resource *iores_range[] = {
+		iores_array,
+		iores_array + TPM_CRB_MAX_RESOURCES
+	};
 	struct device *dev = &device->dev;
+	struct resource *iores;
+	void __iomem **iobase_ptr;
+	int num_resources, i;
 	u32 pa_high, pa_low;
 	u64 cmd_pa;
 	u32 cmd_size;
@@ -501,21 +521,40 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 	u32 rsp_size;
 	int ret;
 
-	INIT_LIST_HEAD(&resources);
-	ret = acpi_dev_get_resources(device, &resources, crb_check_resource,
-				     &io_res);
+	INIT_LIST_HEAD(&acpi_resource_list);
+	ret = acpi_dev_get_resources(device, &acpi_resource_list,
+				     crb_check_resource, iores_range);
 	if (ret < 0)
 		return ret;
-	acpi_dev_free_resource_list(&resources);
+	acpi_dev_free_resource_list(&acpi_resource_list);
 
-	if (resource_type(&io_res) != IORESOURCE_MEM) {
+	if (iores_range[0] == iores_array) {
 		dev_err(dev, FW_BUG "TPM2 ACPI table does not define a memory resource\n");
 		return -EINVAL;
+	} else if (!iores_range[0]) {
+		dev_warn(dev, "TPM2 ACPI table defines too many memory resources\n");
+		iores_range[0] = iores_range[1];
 	}
 
-	priv->iobase = devm_ioremap_resource(dev, &io_res);
-	if (IS_ERR(priv->iobase))
-		return PTR_ERR(priv->iobase);
+	num_resources = iores_range[0] - iores_array;
+
+	iores = NULL;
+	iobase_ptr = NULL;
+	for (i = 0; i < num_resources; ++i) {
+		if (buf->control_address >= iores_array[i].start &&
+		    buf->control_address + sizeof(struct crb_regs_tail) - 1 <=
+		    iores_array[i].end) {
+			iores = iores_array + i;
+			iobase_ptr = iobase_array + i;
+			break;
+		}
+	}
+
+	priv->regs_t = crb_map_res(dev, iores, iobase_ptr, buf->control_address,
+				   sizeof(struct crb_regs_tail));
+
+	if (IS_ERR(priv->regs_t))
+		return PTR_ERR(priv->regs_t);
 
 	/* The ACPI IO region starts at the head area and continues to include
 	 * the control area, as one nice sane region except for some older
@@ -523,9 +562,10 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 	 */
 	if ((priv->sm == ACPI_TPM2_COMMAND_BUFFER) ||
 	    (priv->sm == ACPI_TPM2_MEMORY_MAPPED)) {
-		if (buf->control_address == io_res.start +
+		if (iores &&
+		    buf->control_address == iores->start +
 		    sizeof(*priv->regs_h))
-			priv->regs_h = priv->iobase;
+			priv->regs_h = *iobase_ptr;
 		else
 			dev_warn(dev, FW_BUG "Bad ACPI memory layout");
 	}
@@ -534,13 +574,6 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
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
@@ -552,13 +585,26 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 	pa_high = ioread32(&priv->regs_t->ctrl_cmd_pa_high);
 	pa_low  = ioread32(&priv->regs_t->ctrl_cmd_pa_low);
 	cmd_pa = ((u64)pa_high << 32) | pa_low;
-	cmd_size = crb_fixup_cmd_size(dev, &io_res, cmd_pa,
-				      ioread32(&priv->regs_t->ctrl_cmd_size));
+	cmd_size = ioread32(&priv->regs_t->ctrl_cmd_size);
+
+	iores = NULL;
+	iobase_ptr = NULL;
+	for (i = 0; i < num_resources; ++i) {
+		if (cmd_pa >= iores_array[i].start &&
+		    cmd_pa <= iores_array[i].end) {
+			iores = iores_array + i;
+			iobase_ptr = iobase_array + i;
+			break;
+		}
+	}
+
+	if (iores)
+		cmd_size = crb_fixup_cmd_size(dev, iores, cmd_pa, cmd_size);
 
 	dev_dbg(dev, "cmd_hi = %X cmd_low = %X cmd_size %X\n",
 		pa_high, pa_low, cmd_size);
 
-	priv->cmd = crb_map_res(dev, priv, &io_res, cmd_pa, cmd_size);
+	priv->cmd = crb_map_res(dev, iores, iobase_ptr,	cmd_pa, cmd_size);
 	if (IS_ERR(priv->cmd)) {
 		ret = PTR_ERR(priv->cmd);
 		goto out;
@@ -566,11 +612,25 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 
 	memcpy_fromio(&__rsp_pa, &priv->regs_t->ctrl_rsp_pa, 8);
 	rsp_pa = le64_to_cpu(__rsp_pa);
-	rsp_size = crb_fixup_cmd_size(dev, &io_res, rsp_pa,
-				      ioread32(&priv->regs_t->ctrl_rsp_size));
+	rsp_size = ioread32(&priv->regs_t->ctrl_rsp_size);
+
+	iores = NULL;
+	iobase_ptr = NULL;
+	for (i = 0; i < num_resources; ++i) {
+		if (rsp_pa >= iores_array[i].start &&
+		    rsp_pa <= iores_array[i].end) {
+			iores = iores_array + i;
+			iobase_ptr = iobase_array + i;
+			break;
+		}
+	}
+
+	if (iores)
+		rsp_size = crb_fixup_cmd_size(dev, iores, rsp_pa, rsp_size);
 
 	if (cmd_pa != rsp_pa) {
-		priv->rsp = crb_map_res(dev, priv, &io_res, rsp_pa, rsp_size);
+		priv->rsp = crb_map_res(dev, iores, iobase_ptr,
+					rsp_pa, rsp_size);
 		ret = PTR_ERR_OR_ZERO(priv->rsp);
 		goto out;
 	}
-- 
2.20.1

