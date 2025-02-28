Return-Path: <linux-integrity+bounces-5019-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB68AA49FEA
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Feb 2025 18:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3768169290
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Feb 2025 17:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAB31F4C9A;
	Fri, 28 Feb 2025 17:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i+QtIARl"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82801F4C96
	for <linux-integrity@vger.kernel.org>; Fri, 28 Feb 2025 17:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762490; cv=none; b=MBS46NfFAa9b1gd8Z5MNgce7AjUSs/71CVpyFHRVXQnRrchzrAiRTsPlfrOwYrSNbguGdFZDeSjEwdQXZg287/Y/hC6tm0wXtWPC2ioZ3kg8xrpFDL2z4l9w++NBcOGKRSGnpx9If1gVgRupNxS8m3mrbTxooym6HGf+0GgqCW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762490; c=relaxed/simple;
	bh=fD7myLE7ZbsP4UOrvsDMKLYCzpzMGkG8rvS6jnv0syU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pz4a22BEiW22tZtOEKWtU5NN1h903M0NgRj5FfN7dqOknbAK8tOmdhp5kEuJ+Vrme6AKvaYtnQE/LW2l+HH8BSo1m7t9QYJ5OPJEt4M2QRNMPvcU8GrN90xHCJffdm3p/xy5ad/t0tfT7i8EbDb1Vwq58nFGfa7l/94ByDwIgxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i+QtIARl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740762487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PCDQVqTr6hmhHqFxDWe5bIvKzwcioj+1kYTpxwIAaU4=;
	b=i+QtIARlpqJqXiAAS5gddm7MLIR9bUlpJlbCgtZYVwh7KVQa9pzQvtSGK9f2rqCfwQ8f79
	oUZ+AYVJUz/1c6SDAZ2JLuHWRt0X6l2QHRUBifLm20EzQooSsWakqBzeuECurpQHlAq3Ws
	Lyk7A4TNylS438rvd01Hztq+OS12684=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-KHdVqxRIMkC_f70wtaWv0A-1; Fri, 28 Feb 2025 12:08:05 -0500
X-MC-Unique: KHdVqxRIMkC_f70wtaWv0A-1
X-Mimecast-MFC-AGG-ID: KHdVqxRIMkC_f70wtaWv0A_1740762484
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-390e50c1d00so1652470f8f.1
        for <linux-integrity@vger.kernel.org>; Fri, 28 Feb 2025 09:08:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740762484; x=1741367284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PCDQVqTr6hmhHqFxDWe5bIvKzwcioj+1kYTpxwIAaU4=;
        b=CUk1+HpLRwiypnU1mB7/kkrWx8WhRd2ZKYp6bZ2s1ylRMutwf34tvZ/Ryis1VXx06c
         yKnUHG3XgV1ovfcm4xweDRMU+JKGvsDTSPEzkUzZgS0Og13ySgrx7wQPizb5EeXN0IcN
         3MUxHqEk73KC558+XtNunxtAZTWmkvy2jo5aKVG2VhgvVvRAhFjuZHw+BI8Rrw6JJO4o
         y7+pxNwLUNjM/bFEr9I+vQBX/Nzi0ymjSRpS9dBsImSvTqqW/KdRz4xkk0z/thdoCghr
         uo3oK5v6EWvMCPMvLqsnkCSpzj9KMcO4wvr5UDYAieFbWa9SOiXoyoO2IrOYYG3KzM1a
         ej9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6V0VZem1oxR/pMzcWHpYEprqqa1vqeTTe626WpjUXIdPaEKRUDu4rDk1wbv0gQyFxDlmIHjAif8AV043WW90=@vger.kernel.org
X-Gm-Message-State: AOJu0YynUr8ySgdF9zGnkgV3yvE5wTv3J0DPnoSddpe0IK2IzI8T7Wtq
	ZzefRjAi32uuqv152j8C0nUaPTWINnQ5vqf8hdK5eqLVOcxJKnuAV9ibZRNZlia2B53N1TNLqSl
	d/RkgN1S0AfhANCHSd8eFfWmQhFjTEsUQCQ9mBLiuI2g0+S12GSNH70fO/qbJqHm3Zw==
X-Gm-Gg: ASbGncsep1x/+7mfr6Elm6E91QFw6PNu9GD7XZpX6DIPxM8Z+HtAFhPnjkksoAIwYXi
	pk4KtuEYnTkiIMtq7ITgmO/lEwI1EcpdXHF3WEu4F6//c7cMx0yYhrMi0AxFcaWgXTdoHpRb+an
	PhsjnwcFsIfGhYebF+i+IhwF5u1AuLTyInSYustx3LwYNXZ6XCDMdgrohX7BlPtI8BCHGXOEk0D
	QyIW1IN/3q+BjoCG3Ng7+EzjLNxdELzUXq+GtbUsmb/Yu9fceR+rO6rOoI3SKc3Sw5yCqRCHw+j
	zWV4RrugOOdrHN434mj9
X-Received: by 2002:a05:6000:1f8b:b0:38c:5cd0:ecf3 with SMTP id ffacd0b85a97d-390ec7c8e6amr5632222f8f.11.1740762483976;
        Fri, 28 Feb 2025 09:08:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEi3+55T3gLjFA7+VRsA+/+pw6DGiNP5lywvegd/8noBWWF1sFz3oYBCHvDQEOy4ijFyvRJyQ==
X-Received: by 2002:a05:6000:1f8b:b0:38c:5cd0:ecf3 with SMTP id ffacd0b85a97d-390ec7c8e6amr5632102f8f.11.1740762483303;
        Fri, 28 Feb 2025 09:08:03 -0800 (PST)
Received: from stex1.redhat.com ([5.179.147.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7d69sm5911935f8f.60.2025.02.28.09.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 09:07:59 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	x86@kernel.org,
	Dov Murik <dovmurik@linux.ibm.com>,
	linux-coco@lists.linux.dev,
	Dionna Glaze <dionnaglaze@google.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Ingo Molnar <mingo@redhat.com>,
	Joerg Roedel <jroedel@suse.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [RFC PATCH v2 5/6] tpm: add SNP SVSM vTPM driver
Date: Fri, 28 Feb 2025 18:07:19 +0100
Message-ID: <20250228170720.144739-6-sgarzare@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228170720.144739-1-sgarzare@redhat.com>
References: <20250228170720.144739-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add driver for the vTPM defined by the AMD SVSM spec [1].

The specification defines a protocol that a SEV-SNP guest OS can use to
discover and talk to a vTPM emulated by the Secure VM Service Module (SVSM)
in the guest context, but at a more privileged level (VMPL0).

The new tpm-svsm platform driver uses two functions exposed by x86/sev
to verify that the device is actually emulated by the platform and to
send commands and receive responses.

The vTPM is emulated through the TCG reference implementation, so this
driver leverages tpm_tcgsim.h to fill commands and parse responses.

The device cannot be hot-plugged/unplugged as it is emulated by the
platform, so we can use module_platform_driver_probe(). The probe
function will only check whether in the current runtime configuration,
SVSM is present and provides a vTPM.

[1] "Secure VM Service Module for SEV-SNP Guests"
    Publication # 58019 Revision: 1.00
    https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/char/tpm/tpm_svsm.c | 120 ++++++++++++++++++++++++++++++++++++
 drivers/char/tpm/Kconfig    |  10 +++
 drivers/char/tpm/Makefile   |   1 +
 3 files changed, 131 insertions(+)
 create mode 100644 drivers/char/tpm/tpm_svsm.c

diff --git a/drivers/char/tpm/tpm_svsm.c b/drivers/char/tpm/tpm_svsm.c
new file mode 100644
index 000000000000..1c34133990c5
--- /dev/null
+++ b/drivers/char/tpm/tpm_svsm.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ *
+ * Driver for the vTPM defined by the AMD SVSM spec [1].
+ *
+ * The specification defines a protocol that a SEV-SNP guest OS can use to
+ * discover and talk to a vTPM emulated by the Secure VM Service Module (SVSM)
+ * in the guest context, but at a more privileged level (usually VMPL0).
+ *
+ * The vTPM is emulated through the TCG reference implementation, so this
+ * driver leverages tpm_tcgsim.h to fill commands and parse responses.
+ *
+ * [1] "Secure VM Service Module for SEV-SNP Guests"
+ *     Publication # 58019 Revision: 1.00
+ *     https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
+ */
+
+#include <asm/sev.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/tpm_tcgsim.h>
+
+#include "tpm.h"
+
+struct tpm_svsm_priv {
+	u8 buffer[TPM_TCGSIM_MAX_BUFFER];
+	u8 locality;
+};
+
+static int tpm_svsm_send_recv(struct tpm_chip *chip, u8 *buf, size_t buf_len,
+			      size_t to_send)
+{
+	struct tpm_svsm_priv *priv = dev_get_drvdata(&chip->dev);
+	int ret;
+
+	ret = tpm_tcgsim_fill_send_cmd((struct tpm_send_cmd_req *)priv->buffer,
+				       priv->locality, buf, to_send);
+	if (ret)
+		return ret;
+
+	ret = snp_svsm_vtpm_send_command(priv->buffer);
+	if (ret)
+		return ret;
+
+	return tpm_tcgsim_parse_send_cmd((struct tpm_send_cmd_resp *)priv->buffer,
+					 buf, buf_len);
+}
+
+static struct tpm_class_ops tpm_chip_ops = {
+	.flags = TPM_OPS_AUTO_STARTUP,
+	.send_recv = tpm_svsm_send_recv,
+};
+
+static int __init tpm_svsm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct tpm_svsm_priv *priv;
+	struct tpm_chip *chip;
+	int err;
+
+	if (!snp_svsm_vtpm_probe())
+		return -ENODEV;
+
+	priv = devm_kmalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	/*
+	 * FIXME: before implementing locality we need to agree what it means
+	 * for the SNP SVSM vTPM
+	 */
+	priv->locality = 0;
+
+	chip = tpmm_chip_alloc(dev, &tpm_chip_ops);
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	dev_set_drvdata(&chip->dev, priv);
+
+	err = tpm2_probe(chip);
+	if (err)
+		return err;
+
+	err = tpm_chip_register(chip);
+	if (err)
+		return err;
+
+	dev_info(dev, "SNP SVSM vTPM %s device\n",
+		 (chip->flags & TPM_CHIP_FLAG_TPM2) ? "2.0" : "1.2");
+
+	return 0;
+}
+
+static void __exit tpm_svsm_remove(struct platform_device *pdev)
+{
+	struct tpm_chip *chip = platform_get_drvdata(pdev);
+
+	tpm_chip_unregister(chip);
+}
+
+/*
+ * tpm_svsm_remove() lives in .exit.text. For drivers registered via
+ * module_platform_driver_probe() this is ok because they cannot get unbound
+ * at runtime. So mark the driver struct with __refdata to prevent modpost
+ * triggering a section mismatch warning.
+ */
+static struct platform_driver tpm_svsm_driver __refdata = {
+	.remove = __exit_p(tpm_svsm_remove),
+	.driver = {
+		.name = "tpm-svsm",
+	},
+};
+
+module_platform_driver_probe(tpm_svsm_driver, tpm_svsm_probe);
+
+MODULE_DESCRIPTION("SNP SVSM vTPM Driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:tpm-svsm");
diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 0fc9a510e059..fc3f1d10d31d 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -225,5 +225,15 @@ config TCG_FTPM_TEE
 	help
 	  This driver proxies for firmware TPM running in TEE.
 
+config TCG_SVSM
+	tristate "SNP SVSM vTPM interface"
+	depends on AMD_MEM_ENCRYPT
+	help
+	  This is a driver for the AMD SVSM vTPM protocol that a SEV-SNP guest
+	  OS can use to discover and talk to a vTPM emulated by the Secure VM
+	  Service Module (SVSM) in the guest context, but at a more privileged
+	  level (usually VMPL0).  To compile this driver as a module, choose M
+	  here; the module will be called tpm_svsm.
+
 source "drivers/char/tpm/st33zp24/Kconfig"
 endif # TCG_TPM
diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
index 9bb142c75243..52d9d80a0f56 100644
--- a/drivers/char/tpm/Makefile
+++ b/drivers/char/tpm/Makefile
@@ -44,3 +44,4 @@ obj-$(CONFIG_TCG_XEN) += xen-tpmfront.o
 obj-$(CONFIG_TCG_CRB) += tpm_crb.o
 obj-$(CONFIG_TCG_VTPM_PROXY) += tpm_vtpm_proxy.o
 obj-$(CONFIG_TCG_FTPM_TEE) += tpm_ftpm_tee.o
+obj-$(CONFIG_TCG_SVSM) += tpm_svsm.o
-- 
2.48.1


