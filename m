Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4C8D9923
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Oct 2019 20:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390961AbfJPS2d (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 16 Oct 2019 14:28:33 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51024 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390895AbfJPS2d (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 Oct 2019 14:28:33 -0400
Received: by mail-wm1-f67.google.com with SMTP id 5so4005528wmg.0;
        Wed, 16 Oct 2019 11:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rWuJPd9boTIX1O7shUbeHC/cca4oDppQItIevlnS2VU=;
        b=NA21KMliRd0OnaeaAByVQc4l8szMHMhcT9d5n2C96Lbz+AqcbLj6wJnaS+M37P/Q1K
         NVuYKZjb4zpJaQTdP1VE9XVZZuDBsdvlv1DpPbq+cNy1SARx2BZrlN+hYU9cRjWa0uwZ
         HH0RSzLIjrmDVlDRcsKsHN0/BUDW6yo2j452En41WjvWDKPEqsR9fWTazAHqaHIqoD3x
         5c/r3qLWGjDV+ABGXhGjf0f6WQfx/ZKPfVYuwx7k4W2F/Bz7QWwcwTLKeOIqn+/GnNZX
         ebKaCQ+nBsxx2+v4qD7nVo1JEmaNhDhVQN7xOQoCpyxeUPFE2ryz8atgXG8dBOtpPF+L
         RfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rWuJPd9boTIX1O7shUbeHC/cca4oDppQItIevlnS2VU=;
        b=i4T7zg2s8qqcu+5snmZ1qaEP6Xnrkw9jtRzDHD9Icp2KQp8rjfl6c1bkhCvfySf8rB
         /3nLvPlt7tot4jztDWOwGO5WN3e0aIK/HMctZlTXGTK31nhP27sRAvWc9vb18Bi2Yd4h
         t2gc3WGucMZ4NV69Nrs201pDF6caEVZO/sJSj9QnemOouu3XmXzM0pThYfX2o/MCxbMA
         +cyE+J156F4r2xjzuDnEZQAOgqLKZrvsZ9BttOjHN+XIqpr2cyGkMzLF+w8KkeFAbzgf
         Ss1PCtd+zbXkrWbVasHfBrUuWHZtQ4/6td80swZ3T2d25NAyxIUMdyvQFoZUCHi8/iyW
         c7nA==
X-Gm-Message-State: APjAAAXZexVC0tRj0PiYMFpOptkGhfmcwKXS5IfmIeE2P64QmMdIx/XE
        5NHqmStidbSLZLmVOMTL9lc=
X-Google-Smtp-Source: APXvYqxzoCQtrw5rgFxGuvNQGyITDYKN6vU8Dyyn+vuo2WFj0F74eMjithWDoBl5TItEYQR7jF+ibg==
X-Received: by 2002:a7b:c44f:: with SMTP id l15mr4630678wmi.121.1571250508334;
        Wed, 16 Oct 2019 11:28:28 -0700 (PDT)
Received: from hv-1.home ([188.187.106.129])
        by smtp.gmail.com with ESMTPSA id u10sm2800755wmm.0.2019.10.16.11.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2019 11:28:27 -0700 (PDT)
From:   ivan.lazeev@gmail.com
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivan Lazeev <ivan.lazeev@gmail.com>
Subject: [PATCH v8] tpm_crb: fix fTPM on AMD Zen+ CPUs
Date:   Wed, 16 Oct 2019 21:28:14 +0300
Message-Id: <20191016182814.18350-1-ivan.lazeev@gmail.com>
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
Changelog:
v8:
	- fix sparse warning

v7:
	- use terminator entry in iores_array

v6:
	- get rid of new structures
	- open code helper functions
	- remove incorrect FW_BUG

v5:
	- prefix new symbols with tpm_crb_
	- get rid of dynamic allocation in ACPI walker

v4:
	- rename struct crb_resource fields (style change)
	- improve commit message

v3:
	- make crb_containing_resource search for address only,
	  because buffer sizes aren't trusted anyway
	- improve commit message

v2:
	- use list_for_each_safe

 drivers/char/tpm/tpm_crb.c | 123 +++++++++++++++++++++++++++----------
 1 file changed, 90 insertions(+), 33 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index e59f1f91d7f3..a9dcf31eadd2 100644
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
+	struct resource *iores_array = data;
 	struct resource_win win;
 	struct resource *res = &(win.res);
+	int i;
 
 	if (acpi_dev_resource_memory(ares, res) ||
 	    acpi_dev_resource_address_space(ares, &win)) {
-		*io_res = *res;
-		io_res->name = NULL;
+		for (i = 0; i < TPM_CRB_MAX_RESOURCES + 1; ++i) {
+			if (resource_type(iores_array + i) != IORESOURCE_MEM) {
+				iores_array[i] = *res;
+				iores_array[i].name = NULL;
+				break;
+			}
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
@@ -490,9 +502,13 @@ static u64 crb_fixup_cmd_size(struct device *dev, struct resource *io_res,
 static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 		      struct acpi_table_tpm2 *buf)
 {
-	struct list_head resources;
-	struct resource io_res;
+	struct list_head acpi_resource_list;
+	struct resource iores_array[TPM_CRB_MAX_RESOURCES + 1] = { {0} };
+	void __iomem *iobase_array[TPM_CRB_MAX_RESOURCES] = {NULL};
 	struct device *dev = &device->dev;
+	struct resource *iores;
+	void __iomem **iobase_ptr;
+	int i;
 	u32 pa_high, pa_low;
 	u64 cmd_pa;
 	u32 cmd_size;
@@ -501,21 +517,41 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 	u32 rsp_size;
 	int ret;
 
-	INIT_LIST_HEAD(&resources);
-	ret = acpi_dev_get_resources(device, &resources, crb_check_resource,
-				     &io_res);
+	INIT_LIST_HEAD(&acpi_resource_list);
+	ret = acpi_dev_get_resources(device, &acpi_resource_list,
+				     crb_check_resource, iores_array);
 	if (ret < 0)
 		return ret;
-	acpi_dev_free_resource_list(&resources);
+	acpi_dev_free_resource_list(&acpi_resource_list);
 
-	if (resource_type(&io_res) != IORESOURCE_MEM) {
+	if (resource_type(iores_array) != IORESOURCE_MEM) {
 		dev_err(dev, FW_BUG "TPM2 ACPI table does not define a memory resource\n");
 		return -EINVAL;
+	} else if (resource_type(iores_array + TPM_CRB_MAX_RESOURCES) ==
+		IORESOURCE_MEM) {
+		dev_warn(dev, "TPM2 ACPI table defines too many memory resources\n");
+		memset(iores_array + TPM_CRB_MAX_RESOURCES,
+		       0, sizeof(*iores_array));
+		iores_array[TPM_CRB_MAX_RESOURCES].flags = 0;
 	}
 
-	priv->iobase = devm_ioremap_resource(dev, &io_res);
-	if (IS_ERR(priv->iobase))
-		return PTR_ERR(priv->iobase);
+	iores = NULL;
+	iobase_ptr = NULL;
+	for (i = 0; resource_type(iores_array + i) == IORESOURCE_MEM; ++i) {
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
@@ -523,9 +559,10 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
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
@@ -534,13 +571,6 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
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
@@ -552,13 +582,26 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 	pa_high = ioread32(&priv->regs_t->ctrl_cmd_pa_high);
 	pa_low  = ioread32(&priv->regs_t->ctrl_cmd_pa_low);
 	cmd_pa = ((u64)pa_high << 32) | pa_low;
-	cmd_size = crb_fixup_cmd_size(dev, &io_res, cmd_pa,
-				      ioread32(&priv->regs_t->ctrl_cmd_size));
+	cmd_size = ioread32(&priv->regs_t->ctrl_cmd_size);
+
+	iores = NULL;
+	iobase_ptr = NULL;
+	for (i = 0; iores_array[i].end; ++i) {
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
@@ -566,11 +609,25 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 
 	memcpy_fromio(&__rsp_pa, &priv->regs_t->ctrl_rsp_pa, 8);
 	rsp_pa = le64_to_cpu(__rsp_pa);
-	rsp_size = crb_fixup_cmd_size(dev, &io_res, rsp_pa,
-				      ioread32(&priv->regs_t->ctrl_rsp_size));
+	rsp_size = ioread32(&priv->regs_t->ctrl_rsp_size);
+
+	iores = NULL;
+	iobase_ptr = NULL;
+	for (i = 0; resource_type(iores_array + i) == IORESOURCE_MEM; ++i) {
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

