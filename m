Return-Path: <linux-integrity+bounces-5769-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66295A8455F
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 15:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC90D1B836B7
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 13:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B954328CF4E;
	Thu, 10 Apr 2025 13:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OZC7zY23"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E9628C5D8
	for <linux-integrity@vger.kernel.org>; Thu, 10 Apr 2025 13:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744293103; cv=none; b=N7mWh5ciD/9uDn22HnddVUBV2vLqn39cBRKNDJZZk17z12vHep5BhbFzUpCq2fANjlRA1sU0GIMBbAGKXSbBpZMqX6GZH2oiuw7vk7vdV5FVpfRvStJa41ckg5wZELbd8Wi1kAa5YgwKK1YMmKPcy3+wOu94bprrYizKCkW6LxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744293103; c=relaxed/simple;
	bh=BTUc9p0P7fj/IdeyhhIG8U1tRS0y26+L6mvGHy8buuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GmyJvmwLuOL+Sy7nJCHyvox0StoFSrQgdABGERoRvMiM7au/IBmnXO/lCj71lr5xobZwK45eic2k3Ya+CSBNqDL2lXF82e808iYDYh1GA7sNcOI8WPcEer+ZtuyvpfB9YA3W2rwJHAwWgnz9nMelsQ9WLjHxCuMwCiCrgUDiurA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OZC7zY23; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744293101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a/4sxX4zYlWzMuPRt3jzKJXuc3Oa7Ar74ewr3j43ie4=;
	b=OZC7zY23M7bWmd4fSItfRSaY0skSBw77YeySQcRmnXsw5S5sjfUvEbe2Y7tX0Xa/JeAc3j
	/6tJOZ1vYKAwaUV4bS12YSeieJkzq9kL07O4TSHAarG8/sOW2TYv4YXZboGpT0u8NiAoxH
	Ih8SkxI2AbgZGo1vhA/dsewo5EQxce4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-yd7RjOj5MiqsukX_I7IXJA-1; Thu, 10 Apr 2025 09:51:38 -0400
X-MC-Unique: yd7RjOj5MiqsukX_I7IXJA-1
X-Mimecast-MFC-AGG-ID: yd7RjOj5MiqsukX_I7IXJA_1744293097
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43941ad86d4so4980795e9.2
        for <linux-integrity@vger.kernel.org>; Thu, 10 Apr 2025 06:51:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744293096; x=1744897896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/4sxX4zYlWzMuPRt3jzKJXuc3Oa7Ar74ewr3j43ie4=;
        b=Kz1mGcG6dVeqhe46Jn/RPoWtHFp1B5gwODiIPmQgHUVVbDK329hYIYkLW/gJ2hsNlS
         /OSN9fmRm/jB8H65bzGZ0i2GisX75ISqvb0hIFMtkqPir7kyELFtZvi+0VstYkT1pEQp
         bmwjvutjbTR5E9G75VWjITiD1I0gsIkY3le1kmKOf9KayPtzbhCD1QTAuxqo3a8LfXmq
         hsTel9EZ9zNv2Dbobs2NympeF2Jan60ZkAS83x+MZbWod4WRG7bVSLQ7jGJpNyhWycCl
         klXSYRwcJXx43QAeIze7pwvHJbJKoXRn+BWdX8w5sPfIb6eBdlYMTeXJM7wsiG5V+F/8
         p62w==
X-Forwarded-Encrypted: i=1; AJvYcCUd1/qnSIPH4yHlJjqFiG7kR+j2bh2AyfL/d/81YlqJbA6CaLtlhOFyTeN5vUe/r27PQeVsZgOB9vhmtUYBhek=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtKLVFfho5TzLgKbso3hwWlb3k9MZA3inITpaYQSXbhhbKJs3U
	oOOzRZNXUnwvSlJybffV6i8PyqBQPYFca3a5lQbjrz8kPwi32sWF0Y0OeDpD5YdPLxdRY0mJ7w6
	m26QdKk2U/1d4JJgTXC8bMzy7odKG1GWhZqyzz73Ubloes75RftmiBe+gGIh4lZbhNA==
X-Gm-Gg: ASbGncu6uksfD/EJmd88wEpo71aiD0ldnVOyYkuBc/WKQ9n278PZ+Kjb5ipPHDGcsks
	e/Ll5UOYtOt/8/xU867KcTTL52HDrOqMD1g9CCABJBfGAUFxBPlVIQNdRaJHALxQbJDWFfE9mCZ
	V8WxtKjeb/JgOohyUIQCIsvIXAHbOYV0QPhP2uyQTsftufHHXpSsGQbbwBpdxWEspnLYwCqHxpD
	aMBvPBdOBRgoy9YOWhMKkSPKhhQO3O6ACpBVsh4uG1IRFMFiwpuguyjJCDDMyoP8RaSns0Nc7EI
	/aaEd92mYZOthz3M0yU+ZWfujeocOk0+8u/5cqHF54rDhTLsILrhcmbCSsh4XA==
X-Received: by 2002:a05:600c:1d10:b0:43d:42b:e186 with SMTP id 5b1f17b1804b1-43f2d7bbe9dmr25367825e9.8.1744293096540;
        Thu, 10 Apr 2025 06:51:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBFkr3gV1YG3NMqGEsLFTmg6/59TSCe3mxGOyIVGTKktzJth53MhEnXCXkeFjtq7SaUo9uHw==
X-Received: by 2002:a05:600c:1d10:b0:43d:42b:e186 with SMTP id 5b1f17b1804b1-43f2d7bbe9dmr25367365e9.8.1744293096036;
        Thu, 10 Apr 2025 06:51:36 -0700 (PDT)
Received: from stex1.redhat.com (host-79-53-30-213.retail.telecomitalia.it. [79.53.30.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d8938a761sm4932483f8f.51.2025.04.10.06.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 06:51:35 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Borislav Petkov <bp@alien8.de>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Joerg Roedel <jroedel@suse.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	linux-kernel@vger.kernel.org,
	Dov Murik <dovmurik@linux.ibm.com>,
	linux-integrity@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	x86@kernel.org,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-coco@lists.linux.dev,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v7 3/4] tpm: add SNP SVSM vTPM driver
Date: Thu, 10 Apr 2025 15:51:15 +0200
Message-ID: <20250410135118.133240-4-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250410135118.133240-1-sgarzare@redhat.com>
References: <20250410135118.133240-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

Add driver for the vTPM defined by the AMD SVSM spec [1].

The specification defines a protocol that a SEV-SNP guest OS can use to
discover and talk to a vTPM emulated by the Secure VM Service Module (SVSM)
in the guest context, but at a more privileged level (VMPL0).

The new tpm-svsm platform driver uses API exposed by x86/sev to send
commands and receive responses.

The device cannot be hot-plugged/unplugged as it is emulated by the
platform, so we can use module_platform_driver_probe(). The device will
be registered by the platform only when it's available, so the probe
function just needs to setup the tpm_chip.

This device does not support interrupts and sends responses to commands
synchronously.
In order to have .recv() called just after .send() in tpm_try_transmit(),
the .status() callback is not implemented as recently supported by
commit 980a573621ea ("tpm: Make chip->{status,cancel,req_canceled} opt").

[1] "Secure VM Service Module for SEV-SNP Guests"
    Publication # 58019 Revision: 1.00

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v7:
- added Jarkko's R-b
- avoided to call snp_svsm_vtpm_probe() since the device will be
  registered by SEV core only if the device is detected [Borislav]
- updated commit description
v6:
- removed the `locality` field (set to 0) and the FIXME comment [Jarkko]
v5:
- removed cancel/status/req_* ops after rebase on master that cotains
  commit 980a573621ea ("tpm: Make chip->{status,cancel,req_canceled} opt")
v4:
- moved "asm" includes after the "linux" includes [Tom]
- allocated buffer separately [Tom/Jarkko/Jason]
v3:
- removed send_recv() ops and followed the ftpm driver implementing .status,
  .req_complete_mask, .req_complete_val, etc. [Jarkko]
- removed link to the spec because those URLs are unstable [Borislav]
---
 drivers/char/tpm/tpm_svsm.c | 125 ++++++++++++++++++++++++++++++++++++
 drivers/char/tpm/Kconfig    |  10 +++
 drivers/char/tpm/Makefile   |   1 +
 3 files changed, 136 insertions(+)
 create mode 100644 drivers/char/tpm/tpm_svsm.c

diff --git a/drivers/char/tpm/tpm_svsm.c b/drivers/char/tpm/tpm_svsm.c
new file mode 100644
index 000000000000..4280edf427d6
--- /dev/null
+++ b/drivers/char/tpm/tpm_svsm.c
@@ -0,0 +1,125 @@
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
+ * [1] "Secure VM Service Module for SEV-SNP Guests"
+ *     Publication # 58019 Revision: 1.00
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/tpm_svsm.h>
+
+#include <asm/sev.h>
+
+#include "tpm.h"
+
+struct tpm_svsm_priv {
+	void *buffer;
+};
+
+static int tpm_svsm_send(struct tpm_chip *chip, u8 *buf, size_t len)
+{
+	struct tpm_svsm_priv *priv = dev_get_drvdata(&chip->dev);
+	int ret;
+
+	ret = svsm_vtpm_cmd_request_fill(priv->buffer, 0, buf, len);
+	if (ret)
+		return ret;
+
+	/*
+	 * The SVSM call uses the same buffer for the command and for the
+	 * response, so after this call, the buffer will contain the response
+	 * that can be used by .recv() op.
+	 */
+	return snp_svsm_vtpm_send_command(priv->buffer);
+}
+
+static int tpm_svsm_recv(struct tpm_chip *chip, u8 *buf, size_t len)
+{
+	struct tpm_svsm_priv *priv = dev_get_drvdata(&chip->dev);
+
+	/*
+	 * The internal buffer contains the response after we send the command
+	 * to SVSM.
+	 */
+	return svsm_vtpm_cmd_response_parse(priv->buffer, buf, len);
+}
+
+static struct tpm_class_ops tpm_chip_ops = {
+	.flags = TPM_OPS_AUTO_STARTUP,
+	.recv = tpm_svsm_recv,
+	.send = tpm_svsm_send,
+};
+
+static int __init tpm_svsm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct tpm_svsm_priv *priv;
+	struct tpm_chip *chip;
+	int err;
+
+	priv = devm_kmalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	/*
+	 * The maximum buffer supported is one page (see SVSM_VTPM_MAX_BUFFER
+	 * in tpm_svsm.h).
+	 */
+	priv->buffer = (void *)devm_get_free_pages(dev, GFP_KERNEL, 0);
+	if (!priv->buffer)
+		return -ENOMEM;
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
index fe4f3a609934..dddd702b2454 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -234,5 +234,15 @@ config TCG_FTPM_TEE
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
index 2b004df8c04b..9de1b3ea34a9 100644
--- a/drivers/char/tpm/Makefile
+++ b/drivers/char/tpm/Makefile
@@ -45,3 +45,4 @@ obj-$(CONFIG_TCG_CRB) += tpm_crb.o
 obj-$(CONFIG_TCG_ARM_CRB_FFA) += tpm_crb_ffa.o
 obj-$(CONFIG_TCG_VTPM_PROXY) += tpm_vtpm_proxy.o
 obj-$(CONFIG_TCG_FTPM_TEE) += tpm_ftpm_tee.o
+obj-$(CONFIG_TCG_SVSM) += tpm_svsm.o
-- 
2.49.0


