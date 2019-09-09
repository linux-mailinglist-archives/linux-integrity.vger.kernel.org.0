Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD97AD561
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Sep 2019 11:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfIIJJx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 9 Sep 2019 05:09:53 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42377 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfIIJJx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 9 Sep 2019 05:09:53 -0400
Received: by mail-pf1-f196.google.com with SMTP id w22so8749043pfi.9;
        Mon, 09 Sep 2019 02:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U5NCtSQYid1u8C34eAEqP1Aq7f0r5wTbuSh3G4fErsg=;
        b=hLdJ4Pa8HA5IJO/Dalzmk8viU2XnTDLr6ibidCeKWstsBsWlg9SZrBbFTmwIvJrkOK
         3hVSsvYy0Vdx1VnAK7zfj7Dt9sRVkDhoJxhS2eak4S80ja1hfwbIsumTVoCtt419ENsE
         W2WUSTSNo3uzYC5Otnn0SfccrIcy7qVm9VqHbS2a492CeKPfAaxnoQRqLGAQ69sAIT+M
         ZLKms0ChcVW6WAKA1uEx0gZUQt5uiFH89uAun7luHj/XHBu/j/epXdzP3gjqZ4ad4415
         AKYQGckxR7/71o7gtDDQ34Ghb0HA1ThskT+a1vgodtRuSiViPLToQ36Zg5Byn8hhsgWs
         5LUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U5NCtSQYid1u8C34eAEqP1Aq7f0r5wTbuSh3G4fErsg=;
        b=AJ3uI/iYNkqXQtBtrzgvhArvIUb9SGYUO+utGp8x4TX4eWs3YC52uLMRIyb8VMYFiq
         6m0eEE+KcWYhsRCIwT1yLCHa40J4M77lyeLf11JCaFdd/r48dhZWxpir+S1z6Kr2jA6J
         SeXZUSefuvXFgC7og9hw79dWLNw+schlCoYhRXPhWHRT6KXUR9WSNx1nv4qvJ0L43K0i
         VyE2V1xTtn5M7q3ttBR7JOo3vQ4ujI56a0A38KbhBAyluhMa5LLp4+CpvIE7D+yRnm7C
         k4YpDUEXyP/ED8ooO9VKMPonv1cHm+YBZM/QuNP+uH1G12GXBply6JNYhKZHSSloFgp/
         TRdg==
X-Gm-Message-State: APjAAAVIKiXMwTLWDjRgZb6iGNCJGjLabmPtcIWEnUU13MMzq0o5fQh/
        Cj1SEqI442nzwMKJKxgYeZh8NZ8cCOM=
X-Google-Smtp-Source: APXvYqxEqt8hkjK1fOi3DC5vXYYjxVtlSq7gWu1J2oOdPulgj6r2wLlAwOu3jdgw13HfdVitXUdqMg==
X-Received: by 2002:a17:90a:db0e:: with SMTP id g14mr23729979pjv.54.1568020192535;
        Mon, 09 Sep 2019 02:09:52 -0700 (PDT)
Received: from localhost.localdomain ([175.203.71.146])
        by smtp.googlemail.com with ESMTPSA id s18sm19122962pfh.0.2019.09.09.02.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2019 02:09:52 -0700 (PDT)
From:   Seunghun Han <kkamagui@gmail.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        linux-integrity@vger.kernel.org (open list:TPM DEVICE DRIVER),
        linux-kernel@vger.kernel.org, Seunghun Han <kkamagui@gmail.com>
Subject: [PATCH v2 2/2] tpm: tpm_crb: enhance resource mapping mechanism for supporting AMD's fTPM
Date:   Mon,  9 Sep 2019 18:09:06 +0900
Message-Id: <20190909090906.28700-3-kkamagui@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190909090906.28700-1-kkamagui@gmail.com>
References: <20190909090906.28700-1-kkamagui@gmail.com>
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
Changes in v2: fix a warning of kbuild test robot. The link is below.
               https://lkml.org/lkml/2019/8/31/217

 drivers/char/tpm/tpm_crb.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 14f486c23af2..6b98a3a995b7 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -450,6 +450,27 @@ static int crb_check_resource(struct acpi_resource *ares, void *data)
 	return 1;
 }
 
+static void __iomem *crb_ioremap_resource(struct device *dev,
+					  const struct resource *res)
+{
+	int rc;
+	resource_size_t size = resource_size(res);
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

