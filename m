Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 637ACA348C
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Aug 2019 11:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbfH3J5I (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Aug 2019 05:57:08 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44162 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfH3J5I (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Aug 2019 05:57:08 -0400
Received: by mail-pg1-f193.google.com with SMTP id i18so3288044pgl.11;
        Fri, 30 Aug 2019 02:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fy06+AemNIV2gCe3GVN+rRCnIQVGYZ4AUqkeTUjjHyw=;
        b=NuCttfCZy0ZS1kR7cSkGFdVOY98JlEfbLJXoVFGhP+U7MR1Ff2SR1k2G6OLcZlGkot
         goeVOJdxdjAKqO2nBzkCuoP2Cxl3mpB4kQj0MOreMFi36z7ufj/6YiRK+iMhQNkuYM/L
         w6O+OfqYEYbsaYUpu36Az6hTJwYKrMN4hhTh3pRjVSZNrdDz1XcAigXCw5/XKotAmUjg
         62mGuAn5SLfHBbmHE/leeeWeoWf2c9qYO5AvBOCF0XU4mVp7j1P3sFqC4bIvwupzOgtn
         eC0mWTFBFtMe3mHNP+ySrkz/4eQVM1gz6/URwDuc0Goal8j9iav8ejXkqxmMeZqivoWZ
         jVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fy06+AemNIV2gCe3GVN+rRCnIQVGYZ4AUqkeTUjjHyw=;
        b=GqzTlPGq3d2P+znL4pgyrgiwIuOaAUtI89uW8gu7J8zjG/rcigGFkv3NNtxBo36UhR
         rg7kA2qWgmV9/fFTTjs2HUI9XllGl/sc6/HBm3CrDOgCBfaoO4fQv8U3pLpEo66q2YLc
         fwREKSOEPioWFMY6KikwgKWwaplEenA+fX9/93z5kzzx++GOSxECIO8Znalh1CxhkKce
         c+XV9al4IsNiEZH+TA9LHcfLHXZLXjhFPOXSOCYe/T61hP3kKDAqLzLOyRT4krEpKuMc
         lGnqEtw6CfzbTnrBnEAYAw0jQxXgV0UOdIeRLVgGOCMvqC3CZ+4pZRWTIJg60CopgRlo
         SKSQ==
X-Gm-Message-State: APjAAAXdgzHjeYDxzSH4rkBsYwYgwkPADwcY17VsSVJigfk3fVFQ8XNN
        J5J66mtPdIWHnCQhCqKPteQ=
X-Google-Smtp-Source: APXvYqwE6swxiaYetHF650SEUEqiqNIW0JpPSu/0ZgIq+LbjwJNbop9b7jYNzfAi69ZtkIWT74lmZQ==
X-Received: by 2002:a62:52d0:: with SMTP id g199mr442074pfb.120.1567159027247;
        Fri, 30 Aug 2019 02:57:07 -0700 (PDT)
Received: from localhost.localdomain ([175.203.71.146])
        by smtp.googlemail.com with ESMTPSA id k64sm8329447pge.65.2019.08.30.02.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 02:57:06 -0700 (PDT)
From:   Seunghun Han <kkamagui@gmail.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        linux-integrity@vger.kernel.org (open list:TPM DEVICE DRIVER),
        linux-kernel@vger.kernel.org, Seunghun Han <kkamagui@gmail.com>
Subject: [PATCH 2/2] tpm: tpm_crb: enhance resource mapping mechanism for supporting AMD's fTPM
Date:   Fri, 30 Aug 2019 18:56:39 +0900
Message-Id: <20190830095639.4562-3-kkamagui@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190830095639.4562-1-kkamagui@gmail.com>
References: <20190830095639.4562-1-kkamagui@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

I got an AMD system which had a Ryzen Threadripper 1950X and MSI
mainboard, and I had a problem with AMD's fTPM. My machine showed an error
message below, and the fTPM didn't work because of it.

[  5.732084] tpm_crb MSFT0101:00: can't request region for resource
             [mem 0x79b4f000-0x79b4ffff]
[  5.732089] tpm_crb: probe of MSFT0101:00 failed with error -16

When I saw the iomem, I found two fTPM regions were in the ACPI NVS area. 
The regions are below.

79a39000-79b6afff : ACPI Non-volatile Storage
  79b4b000-79b4bfff : MSFT0101:00
  79b4f000-79b4ffff : MSFT0101:00

After analyzing this issue, I found that crb_map_io() function called
devm_ioremap_resource() and it failed. The ACPI NVS didn't allow the TPM
CRB driver to assign a resource in it because a busy bit was set to
the ACPI NVS area.

To support AMD's fTPM, I added a function to check intersects between
the TPM region and ACPI NVS before it mapped the region. If some
intersects are detected, the function just calls devm_ioremap() for
a workaround. If there is no intersect, it calls devm_ioremap_resource().

Signed-off-by: Seunghun Han <kkamagui@gmail.com>
---
 drivers/char/tpm/tpm_crb.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 14f486c23af2..7b60cd594b92 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -450,6 +450,27 @@ static int crb_check_resource(struct acpi_resource *ares, void *data)
 	return 1;
 }
 
+static void __iomem *crb_ioremap_resource(struct device *dev,
+					  const struct resource *res)
+{
+	int rc;
+	resource_size_t size = res->end - res->start;
+
+	/* Broken BIOS assigns command and response buffers in ACPI NVS region.
+	 * Check intersections between a resource and ACPI NVS for W/A.
+	 */
+	rc = region_intersects(res->start, size, IORESOURCE_MEM |
+			       IORESOURCE_BUSY, IORES_DESC_ACPI_NV_STORAGE);
+	if (rc != REGION_DISJOINT) {
+		dev_err(dev,
+			FW_BUG "Resource overlaps with a ACPI NVS. %pr\n",
+			res);
+		return devm_ioremap(dev, res->start, size);
+	}
+
+	return devm_ioremap_resource(dev, res);
+}
+
 static void __iomem *crb_map_res(struct device *dev, struct crb_priv *priv,
 				 struct resource *io_res, u64 start, u32 size)
 {
@@ -464,7 +485,7 @@ static void __iomem *crb_map_res(struct device *dev, struct crb_priv *priv,
 		return (void __iomem *) ERR_PTR(-EINVAL);
 
 	if (!resource_contains(io_res, &new_res))
-		return devm_ioremap_resource(dev, &new_res);
+		return crb_ioremap_resource(dev, &new_res);
 
 	return priv->iobase + (new_res.start - io_res->start);
 }
@@ -536,7 +557,7 @@ static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
 		goto out_early;
 	}
 
-	priv->iobase = devm_ioremap_resource(dev, &io_res);
+	priv->iobase = crb_ioremap_resource(dev, &io_res);
 	if (IS_ERR(priv->iobase)) {
 		ret = PTR_ERR(priv->iobase);
 		goto out_early;
-- 
2.21.0

