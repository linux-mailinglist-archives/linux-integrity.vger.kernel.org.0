Return-Path: <linux-integrity+bounces-8539-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGALGW95nGlfIAQAu9opvQ
	(envelope-from <linux-integrity+bounces-8539-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Feb 2026 16:59:43 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB18F179397
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Feb 2026 16:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9424303A3C3
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Feb 2026 15:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDDA3016F2;
	Mon, 23 Feb 2026 15:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JN3t+APY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ED32F363F;
	Mon, 23 Feb 2026 15:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862126; cv=none; b=qddIxgQrUEkoelAcmnz1JzKYo3UhpyWzvCdpDG63OWE2/dlL6yITb9c/0epz1GlWJJfeIjdfkBiqJYcHEPfWlfUtrzNgs+q4YX+7WGqtSqpNvLGlXcstZsDWP0E+lavLcSthQtxHsuwIsFX4ZkJPv9fyrC3bXgcGp8XgegWwiy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862126; c=relaxed/simple;
	bh=Ma/3uqBCY/oUPUsGcZ/PXNd8NktwdM+w2Ph3AWGp1Ls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W1mzM/vEe+DuiajCqbAipBiKKYMzGeFQFJyUp5octf81ZybZNWvklqKQlg8DeY9DDbqoWHmLA9Mts2qluELJjY08Lc++TPIaPpre9wKY7O/sYnpnqsUTpexTQZ8cnM15A2FPtzWUjFR+yS3qrB/pyMaCOuM/llWK8alvzFI8FGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JN3t+APY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F312C116C6;
	Mon, 23 Feb 2026 15:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771862126;
	bh=Ma/3uqBCY/oUPUsGcZ/PXNd8NktwdM+w2Ph3AWGp1Ls=;
	h=From:To:Cc:Subject:Date:From;
	b=JN3t+APYYN1dJ7kEXNH1Qu1AB2XL5ZPUNPEj28cqzrOnwVArreAdUJYhXoCZUqsQW
	 fP9Ta4gw21Shsp2DrRr8090B4bUstkKE2+AdZX+MBSd0f74+cOeUGBfPY8cHWyIArG
	 6wfJHXyJsclJuqhHuq8eAVHHzejdaT5WPQCixQisAtSv4bRpcp5Gna7vzLR98+wv9t
	 48U9obonP4vIowjistMzT/OM+XXRJ86WCrG1yPJhfEV10FefzO2DVlqCEx0r8wsqrR
	 7ARmP3iGlXhi1wMzff+ouzAcRaoCh3PZJdP3bsZJRwek4CVJHoiDrCVFOlawFxBaTL
	 f4Xh+3oIrW4GQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-integrity@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>
Subject: [PATCH v1] tpm_crb: Convert ACPI driver to a platform one
Date: Mon, 23 Feb 2026 16:55:21 +0100
Message-ID: <2706178.Lt9SDvczpP@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTE_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8539-lists,linux-integrity=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,rafael.j.wysocki:mid,intel.com:email]
X-Rspamd-Queue-Id: DB18F179397
X-Rspamd-Action: no action

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

In all cases in which a struct acpi_driver is used for binding a driver
to an ACPI device object, a corresponding platform device is created by
the ACPI core and that device is regarded as a proper representation of
underlying hardware.  Accordingly, a struct platform_driver should be
used by driver code to bind to that device.  There are multiple reasons
why drivers should not bind directly to ACPI device objects [1].

Overall, it is better to bind drivers to platform devices than to their
ACPI companions, so convert the tpm_crb ACPI driver to a platform one.

While this is not expected to alter functionality, it changes sysfs
layout and so it will be visible to user space.

Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/char/tpm/tpm_crb.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index 6c25305c256e..7d1377e8e616 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -15,6 +15,7 @@
 #include <linux/highmem.h>
 #include <linux/rculist.h>
 #include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #ifdef CONFIG_ARM64
 #include <linux/arm-smccc.h>
@@ -602,13 +603,13 @@ static u64 crb_fixup_cmd_size(struct device *dev, struct resource *io_res,
 	return io_res->end - start + 1;
 }
 
-static int crb_map_io(struct acpi_device *device, struct crb_priv *priv,
+static int crb_map_io(struct device *dev, struct crb_priv *priv,
 		      struct acpi_table_tpm2 *buf)
 {
+	struct acpi_device *device = ACPI_COMPANION(dev);
 	struct list_head acpi_resource_list;
 	struct resource iores_array[TPM_CRB_MAX_RESOURCES + 1] = { {0} };
 	void __iomem *iobase_array[TPM_CRB_MAX_RESOURCES] = {NULL};
-	struct device *dev = &device->dev;
 	struct resource *iores;
 	void __iomem **iobase_ptr;
 	int i;
@@ -782,12 +783,13 @@ static int crb_map_pluton(struct device *dev, struct crb_priv *priv,
 	return 0;
 }
 
-static int crb_acpi_add(struct acpi_device *device)
+static int crb_acpi_probe(struct platform_device *pdev)
 {
+	struct device *dev = &pdev->dev;
+	struct acpi_device *device = ACPI_COMPANION(dev);
 	struct acpi_table_tpm2 *buf;
 	struct crb_priv *priv;
 	struct tpm_chip *chip;
-	struct device *dev = &device->dev;
 	struct tpm2_crb_smc *crb_smc;
 	struct tpm2_crb_ffa *crb_ffa;
 	struct tpm2_crb_pluton *crb_pluton;
@@ -867,7 +869,7 @@ static int crb_acpi_add(struct acpi_device *device)
 	priv->sm = sm;
 	priv->hid = acpi_device_hid(device);
 
-	rc = crb_map_io(device, priv, buf);
+	rc = crb_map_io(dev, priv, buf);
 	if (rc)
 		goto out;
 
@@ -901,12 +903,9 @@ static int crb_acpi_add(struct acpi_device *device)
 	return rc;
 }
 
-static void crb_acpi_remove(struct acpi_device *device)
+static void crb_acpi_remove(struct platform_device *pdev)
 {
-	struct device *dev = &device->dev;
-	struct tpm_chip *chip = dev_get_drvdata(dev);
-
-	tpm_chip_unregister(chip);
+	tpm_chip_unregister(platform_get_drvdata(pdev));
 }
 
 static const struct dev_pm_ops crb_pm = {
@@ -919,19 +918,17 @@ static const struct acpi_device_id crb_device_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, crb_device_ids);
 
-static struct acpi_driver crb_acpi_driver = {
-	.name = "tpm_crb",
-	.ids = crb_device_ids,
-	.ops = {
-		.add = crb_acpi_add,
-		.remove = crb_acpi_remove,
-	},
-	.drv = {
+static struct platform_driver crb_acpi_driver = {
+	.probe = crb_acpi_probe,
+	.remove = crb_acpi_remove,
+	.driver = {
+		.name = "tpm_crb_acpi",
+		.acpi_match_table = crb_device_ids,
 		.pm = &crb_pm,
 	},
 };
 
-module_acpi_driver(crb_acpi_driver);
+module_platform_driver(crb_acpi_driver);
 MODULE_AUTHOR("Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>");
 MODULE_DESCRIPTION("TPM2 Driver");
 MODULE_VERSION("0.1");
-- 
2.51.0





