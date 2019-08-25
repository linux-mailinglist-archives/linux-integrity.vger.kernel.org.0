Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44BB69C535
	for <lists+linux-integrity@lfdr.de>; Sun, 25 Aug 2019 19:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbfHYRku (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 25 Aug 2019 13:40:50 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42859 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbfHYRku (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 25 Aug 2019 13:40:50 -0400
Received: by mail-pg1-f193.google.com with SMTP id p3so8952442pgb.9;
        Sun, 25 Aug 2019 10:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dOvUMurfJFq6S6ww2ZvFjgYeG6Gln9RatjWV5vv9/QU=;
        b=iMH1YFIqryTyDrpUvSpziBn1c3W5L634SuQefINChM+gLfZtuMlen1BGmtAwzwlnvD
         dVRfrhqc77hCPlQbcqMRELxQdM81bb9NxLvxOCo7FMz9DcJBNSrHHV1772snOUuN7ixp
         VY5/HRCXhCeZK6pFXuo6BxXlL3p32zvMSLQiRfetqeno7lN21g8nixdG3ikHpyp0n2Ix
         yzhjuz8ZPW2grGXzfkUUQy1EAXs/PRoV1s9mSegJzdpfDv32FyKYl3twPy2BjZ1z1Zpk
         XSnpgfM3QFp6mVNx94+SE1BjYZrflNnLCUf7FIY4lTConCQunDJyA9jWNko6fzrtnJIY
         rg4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dOvUMurfJFq6S6ww2ZvFjgYeG6Gln9RatjWV5vv9/QU=;
        b=NykjmZ54VnuGccXwjivKKl58hUFgitwzSDamy/90AQhBJPSSwXeJspFL1TPDfSQn/r
         PQ2C7iVJ6OgOD8xwLBb41KX4ol0DGSpNhKz+amJqpnaOhAwO4eNPXtbWtECSU5bpFc64
         O0JBE4A1mdCFEhA+2vxsQASOo28/zXqOZvq5CmDQfLV1MqurnJHh2uXWK7fKsXWyjO6X
         2FP8fia4UCQrT1eWuqMz4z3Ed9rUu0zCUBbFlp2H+9wFDFkHOZoncQRb4eKV8ThGkn3k
         02TqTSXk0MAi2nmmNbJ0qmiaQd9Ng7Rnz8TDIINuloaJCdeQOZHL1Gw0XmnMtY+wOX/Z
         S/Hw==
X-Gm-Message-State: APjAAAV29xbM2Ha0pQYBqruSurDVYo/iEKmP1/OaIVyVkzGG9iYL280l
        PQ11R9i5CNWuzyB6JHYqNP0=
X-Google-Smtp-Source: APXvYqwoAyZajc7bKmMWLnisN3C3fCQNOuFX9sLkgi6o7ll3Bi4NheuwCrhKqlL4AnqhJg0mpC3REA==
X-Received: by 2002:aa7:9a12:: with SMTP id w18mr3276556pfj.110.1566754849153;
        Sun, 25 Aug 2019 10:40:49 -0700 (PDT)
Received: from localhost.localdomain ([220.89.248.39])
        by smtp.googlemail.com with ESMTPSA id e13sm9091735pff.181.2019.08.25.10.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2019 10:40:48 -0700 (PDT)
From:   Seunghun Han <kkamagui@gmail.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, Seunghun Han <kkamagui@gmail.com>
Subject: [PATCH] tpm: tpm_crb: Add an AMD fTPM support feature
Date:   Mon, 26 Aug 2019 02:40:19 +0900
Message-Id: <20190825174019.5977-1-kkamagui@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

I'm Seunghun Han and work at the Affiliated Institute of ETRI. I got an AMD
system which had a Ryzen Threadripper 1950X and MSI mainboard, and I had
a problem with AMD's fTPM. My machine showed an error message below, and
the fTPM didn't work because of it.

[    5.732084] tpm_crb MSFT0101:00: can't request region for resource
               [mem 0x79b4f000-0x79b4ffff]
[    5.732089] tpm_crb: probe of MSFT0101:00 failed with error -16

When I saw the iomem areas and found two TPM CRB regions were in the ACPI
NVS area.  The iomem regions are below.

79a39000-79b6afff : ACPI Non-volatile Storage
  79b4b000-79b4bfff : MSFT0101:00
  79b4f000-79b4ffff : MSFT0101:00

After analyzing this issue, I found out that a busy bit was set to the ACPI
NVS area, and the current Linux kernel allowed nothing to be assigned in
it. I also found that the kernel couldn't calculate the sizes of command
and response buffers correctly when the TPM regions were two or more.

To support AMD's fTPM, I removed the busy bit from the ACPI NVS area
so that AMD's fTPM regions could be assigned in it. I also fixed the bug
that did not calculate the sizes of command and response buffer correctly.

Signed-off-by: Seunghun Han <kkamagui@gmail.com>
---
 arch/x86/kernel/e820.c     |  2 +-
 drivers/char/tpm/tpm_crb.c | 50 ++++++++++++++++++++++++++------------
 2 files changed, 35 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 7da2bcd2b8eb..79a99249b46f 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -1085,11 +1085,11 @@ static bool __init do_mark_busy(enum e820_type type, struct resource *res)
 	case E820_TYPE_RESERVED:
 	case E820_TYPE_PRAM:
 	case E820_TYPE_PMEM:
+	case E820_TYPE_NVS:
 		return false;
 	case E820_TYPE_RESERVED_KERN:
 	case E820_TYPE_RAM:
 	case E820_TYPE_ACPI:
-	case E820_TYPE_NVS:
 	case E820_TYPE_UNUSABLE:
 	default:
 		return true;
diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index e59f1f91d7f3..d970a2289def 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -442,6 +442,9 @@ static int crb_check_resource(struct acpi_resource *ares, void *data)
 	    acpi_dev_resource_address_space(ares, &win)) {
 		*io_res = *res;
 		io_res->name = NULL;
+
+		/* Add this TPM CRB resource to the list. */
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
+	/* Check all TPM CRB resources with the start and size values. */
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

