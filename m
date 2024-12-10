Return-Path: <linux-integrity+bounces-4327-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B219EB373
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Dec 2024 15:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C17AB1884A14
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Dec 2024 14:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5999B1A9B23;
	Tue, 10 Dec 2024 14:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q/8ASODn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D06E1BBBCA
	for <linux-integrity@vger.kernel.org>; Tue, 10 Dec 2024 14:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733841285; cv=none; b=HVGXl48B0b/FLota/cv0ZerWcxhdPZcyPhxYGU4tl6JsLKBo8k47Y7QrY1Z26SHd8OitxgvUqyjdqRqVgV8J2YwuEThtuXpCAFTD5G6yBCA+UQClolfMDKMVGQ9x5EGCZ/aeTrNHfQFCFQ54BmOVxvkOo5RouMv40TI+X4RWtPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733841285; c=relaxed/simple;
	bh=YV/Bg/GvqXh41XMQKcC78+GvpEsuDVEuBZeCJxhmFaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jg+Q0zPTxj6a8p3JC9TAxikxE3LWC8MzWzLPo2R6Sed3HmK5M4Eohhh1IJeyWvBBqY7BvQ4aCOe3rLGVKS4w47W1eTwcMGWMfvO3yt6fL7zPrzpqcqz9/yfNNUHVhOWyWL5Z+fcFfnEKfRt4VZspS/oerLcf6oMVt7FrjbS/zBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q/8ASODn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733841282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mDnBbe1BmERY/J1Wfq/4Vteahq+sGBYwUfN+slK2gHE=;
	b=Q/8ASODn9/XO0oXFGJZcw9b4j8ImxTlW9M8k7uSzO377wr6Dj9l8Hq7vdtzF9J8pDY3Ohu
	LCM7pPnHZ9uBKd601Wj4AXpdtwqqm/iLq5n+zYh90i484oSp2W/Cb3hg5s5XLtbgkYAjGd
	Gvz7Js98iHVWHS1bzN/7HiWBwDOZVz0=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-226-L_-PBh5CPF6J-0aGDKzlhw-1; Tue, 10 Dec 2024 09:34:41 -0500
X-MC-Unique: L_-PBh5CPF6J-0aGDKzlhw-1
X-Mimecast-MFC-AGG-ID: L_-PBh5CPF6J-0aGDKzlhw
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d87efed6c4so97072206d6.1
        for <linux-integrity@vger.kernel.org>; Tue, 10 Dec 2024 06:34:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733841280; x=1734446080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mDnBbe1BmERY/J1Wfq/4Vteahq+sGBYwUfN+slK2gHE=;
        b=eaTijnVra71crcqnKiiY7Rvdjj4NPx7WM0wCeJT143uwZuwV9j5MH3tzHTUgvuXoMW
         Hg+Qty2JgSM51/uf7uty2Vg/PPAfUkbfi/boJRFPtjgiX/r9vL2SNEV0lveZ2/9sakS0
         CLU2CeBeh+HVrRjh9AOV4ZSm0rTzJYAyu088/7nhGQBVYn6tT7m853vqjJKExfPHV30B
         Z8QEBxLAdyfPSftHyeuVNxXX6CHNvA0b7KrU8kbbFsQqzBtKsTYp+PmOSOg348bVsX7t
         2p16BM9MU57ReS8xWXCAkN3es65RYDyga4moCoG9YF7KESnGIGtaEDCtS2eiI/BcTZUh
         5A/A==
X-Forwarded-Encrypted: i=1; AJvYcCXpkfVzpypW7tqZl5VmoWNTcvhkw/7Dzh5UmB6Ale4dkCyz9FkndVnWNt35HV2mbLz21rEM2EcjR12eWioAjVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKlEDE3oosxWkW/pOKz5AzH04S5WgEQQo2qqc1+EXDVz6Omv6w
	QyQ1MgIFEA38uGHhPLx54QGm5YiDzNdgKk7SICKYCcEtqd+KMAzlbwBPAdbhSCDX81E4Jz59xow
	MwQHeQaZKy9aUc8NdA45W3trewyYX2vzwO5lfZRH7Jq6QfVEeFKzVZXWqOx+Sao7rdw==
X-Gm-Gg: ASbGncskINgNAn+9/H1D0x/dw8TEYtws3NqoNuSeRV036fyF2dHdbroRzhVOvklUFB7
	VyJnmBeD3VVoDUiMcQrOkPkFNr6tbjT3hgsci0zsOF0kwzqbw6P8H4MLThoSZFQg8zT5ivOGBFx
	7xqkt8YAtcu7kqN9gXw2c5O99uJEUqtpRh7SZxfHZzwUyVb7sXz3vbmpLlWkLFYisyqvc6vb7a6
	a7vK1KUrgQW6AB/EOpah0dfpFxTdKBmzXJEMQc871I4X0lE+B1pONb9Hh0TMXM+AYfH20JyEYZf
	obUH9arMlPl+iFIM7RlMaOcxdLRLKYc=
X-Received: by 2002:a05:6214:1c4b:b0:6cb:edd7:ac32 with SMTP id 6a1803df08f44-6d8e7118b40mr276775476d6.12.1733841280302;
        Tue, 10 Dec 2024 06:34:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEd9Xhzi92yMy9pvFO8lvm7KNjYH3fF75o4ZDwOrQBpyHy5E2nWLC7J0gQUJoL3IfKFPJkFLA==
X-Received: by 2002:a05:6214:1c4b:b0:6cb:edd7:ac32 with SMTP id 6a1803df08f44-6d8e7118b40mr276774916d6.12.1733841279791;
        Tue, 10 Dec 2024 06:34:39 -0800 (PST)
Received: from step1.redhat.com (host-87-12-25-244.business.telecomitalia.it. [87.12.25.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da9fd1f2sm60439976d6.81.2024.12.10.06.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 06:34:35 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: linux-coco@lists.linux.dev
Cc: Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-integrity@vger.kernel.org,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	x86@kernel.org,
	Joerg Roedel <jroedel@suse.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Dov Murik <dovmurik@linux.ibm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 1/3] tpm: add generic platform device
Date: Tue, 10 Dec 2024 15:34:21 +0100
Message-ID: <20241210143423.101774-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210143423.101774-1-sgarzare@redhat.com>
References: <20241210143423.101774-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Bottomley <James.Bottomley@HansenPartnership.com>

This is primarily designed to support an enlightened driver for the
AMD svsm based vTPM, but it could be used by any platform which
communicates with a TPM device.  The platform must fill in struct
tpm_platform_ops as the platform_data and set the device name to "tpm"
to have the binding by name work correctly.  The sole sendrcv
function is designed to do a single buffer request/response conforming
to the MSSIM protocol.  For the svsm vTPM case, this protocol is
transmitted directly to the SVSM, but it could be massaged for other
function type platform interfaces.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
[SG] changed references/links to TCG TPM repo
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/linux/tpm_platform.h    |  90 ++++++++++++++++++++
 drivers/char/tpm/tpm_platform.c | 141 ++++++++++++++++++++++++++++++++
 drivers/char/tpm/Kconfig        |   7 ++
 drivers/char/tpm/Makefile       |   1 +
 4 files changed, 239 insertions(+)
 create mode 100644 include/linux/tpm_platform.h
 create mode 100644 drivers/char/tpm/tpm_platform.c

diff --git a/include/linux/tpm_platform.h b/include/linux/tpm_platform.h
new file mode 100644
index 000000000000..95c17a75d59d
--- /dev/null
+++ b/include/linux/tpm_platform.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2023 James.Bottomley@HansenPartnership.com
+ *
+ * Interface specification for platforms wishing to activate the
+ * platform tpm device.  The device must be a platform device created
+ * with the name "tpm" and it must populate platform_data with struct
+ * tpm_platform_ops
+ */
+
+/*
+ * The current MSSIM TPM commands we support.  The complete list is
+ * in the TcpTpmProtocol header:
+ *
+ * https://github.com/TrustedComputingGroup/TPM/blob/main/TPMCmd/Simulator/include/TpmTcpProtocol.h
+ */
+
+#define TPM_SEND_COMMAND		8
+#define TPM_SIGNAL_CANCEL_ON		9
+#define TPM_SIGNAL_CANCEL_OFF		10
+/*
+ * Any platform specific commands should be placed here and should start
+ * at 0x8000 to avoid clashes with the MSSIM protocol.  They should follow
+ * the same self describing buffer format below
+ */
+
+#define TPM_PLATFORM_MAX_BUFFER		4096 /* max req/resp buffer size */
+
+/**
+ * struct tpm_platform_ops - the share platform operations
+ *
+ * @sendrcv:	Send a TPM command using the MSSIM protocol.
+ *
+ * The MSSIM protocol is designed for a network, so the buffers are
+ * self describing.  The minimum buffer size is sizeof(u32).  Every
+ * MSSIM command defines its own transport buffer and the command is
+ * sent in the first u32 array.  The only modification we make is that
+ * the MSSIM uses network order and we use the endianness of the
+ * architecture.  The response to every command (in the same buffer)
+ * is a u32 size preceded array.  Most of the MSSIM commands simply
+ * return zero here because they have no defined response.
+ *
+ * The only command with a defined request/response size is TPM_SEND_COMMAND
+ * The definition is in the structures below
+ */
+struct tpm_platform_ops {
+	int (*sendrcv)(u8 *buffer);
+};
+
+/**
+ * struct tpm_send_cmd_req - Structure for a TPM_SEND_COMMAND
+ *
+ * @cmd:	The command (must be TPM_SEND_COMMAND)
+ * @locality:	The locality
+ * @inbuf_size:	The size of the input buffer following
+ * @inbuf:	A buffer of size inbuf_size
+ *
+ * Note that MSSIM expects @inbuf_size to be equal to the size of the
+ * specific TPM command, otherwise an TPM_RC_COMMAND_SIZE error is
+ * returned.
+ */
+struct tpm_send_cmd_req {
+	u32	cmd;
+	u8	locality;
+	u32	inbuf_size;
+	u8	inbuf[];
+} __packed;
+
+/**
+ * struct tpm_req - generic request header for single word command
+ *
+ * @cmd:	The command to send
+ */
+struct tpm_req {
+	u32	cmd;
+} __packed;
+
+/**
+ * struct tpm_resp - generic response header
+ *
+ * @size:	The response size (zero if nothing follows)
+ *
+ * Note: most MSSIM commands simply return zero here with no indication
+ * of success or failure.
+ */
+
+struct tpm_resp {
+	s32	size;
+} __packed;
+
diff --git a/drivers/char/tpm/tpm_platform.c b/drivers/char/tpm/tpm_platform.c
new file mode 100644
index 000000000000..b53d74344d61
--- /dev/null
+++ b/drivers/char/tpm/tpm_platform.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Platform based TPM emulator
+ *
+ * Copyright (C) 2023 James.Bottomley@HansenPartnership.com
+ *
+ * Designed to handle a simple function request/response single buffer
+ * TPM or vTPM rooted in the platform.  This device driver uses the
+ * MSSIM protocol from the official TCG reference implementation
+ *
+ * https://github.com/TrustedComputingGroup/TPM
+ *
+ * to communicate between the driver and the platform.  This is rich
+ * enough to allow platform operations like cancellation The platform
+ * should not act on platform commands like power on/off and reset
+ * which can disrupt the TPM guarantees.
+ *
+ * This driver is designed to be single threaded (one call in to the
+ * platform TPM at any one time).  The threading guarantees are
+ * provided by the chip mutex.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/tpm_platform.h>
+
+#include "tpm.h"
+
+static struct tpm_platform_ops *pops;
+
+static u8 *buffer;
+/*
+ * FIXME: before implementing locality we need to agree what it means
+ * to the platform
+ */
+static u8 locality;
+
+static int tpm_platform_send(struct tpm_chip *chip, u8 *buf, size_t len)
+{
+	int ret;
+	struct tpm_send_cmd_req *req = (struct tpm_send_cmd_req *)buffer;
+
+	if (len > TPM_PLATFORM_MAX_BUFFER - sizeof(*req))
+		return -EINVAL;
+	req->cmd = TPM_SEND_COMMAND;
+	req->locality = locality;
+	req->inbuf_size = len;
+	memcpy(req->inbuf, buf, len);
+
+	ret = pops->sendrcv(buffer);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int tpm_platform_recv(struct tpm_chip *chip, u8 *buf, size_t len)
+{
+	struct tpm_resp *resp = (struct tpm_resp *)buffer;
+
+	if (resp->size < 0)
+		return resp->size;
+
+	if (len < resp->size)
+		return -E2BIG;
+
+	if (resp->size > TPM_PLATFORM_MAX_BUFFER - sizeof(*resp))
+		return -EINVAL;  // Invalid response from the platform TPM
+
+	memcpy(buf, buffer + sizeof(*resp), resp->size);
+
+	return resp->size;
+}
+
+static struct tpm_class_ops tpm_chip_ops = {
+	.flags = TPM_OPS_AUTO_STARTUP,
+	.send = tpm_platform_send,
+	.recv = tpm_platform_recv,
+};
+
+static struct platform_driver tpm_platform_driver = {
+	.driver = {
+		.name = "tpm",
+	},
+};
+
+static int __init tpm_platform_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct tpm_chip *chip;
+	int err;
+
+	if (!dev->platform_data)
+		return -ENODEV;
+
+	/*
+	 * in theory platform matching should mean this is always
+	 * true, but just in case anyone tries force binding
+	 */
+	if (strcmp(pdev->name, tpm_platform_driver.driver.name) != 0)
+		return -ENODEV;
+
+	if (!buffer)
+		buffer = kmalloc(TPM_PLATFORM_MAX_BUFFER, GFP_KERNEL);
+
+	if (!buffer)
+		return -ENOMEM;
+
+	pops = dev->platform_data;
+
+	chip = tpmm_chip_alloc(dev, &tpm_chip_ops);
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	/*
+	 * Setting TPM_CHIP_FLAG_IRQ guarantees that ->recv will be
+	 * called straight after ->send and means we don't need to
+	 * implement any other chip ops.
+	 */
+	chip->flags |= TPM_CHIP_FLAG_IRQ;
+	err = tpm2_probe(chip);
+	if (err)
+		return err;
+
+	err = tpm_chip_register(chip);
+	if (err)
+		return err;
+
+	dev_info(dev, "TPM %s platform device\n",
+		 (chip->flags & TPM_CHIP_FLAG_TPM2) ? "2.0" : "1.2");
+
+	return 0;
+}
+
+module_platform_driver_probe(tpm_platform_driver, tpm_platform_probe);
+
+MODULE_AUTHOR("James Bottomley <James.Bottomley@HansenPartnership.com>");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Platform TPM Driver");
+MODULE_ALIAS("platform:tpm");
diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 0fc9a510e059..b162f59305ef 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -225,5 +225,12 @@ config TCG_FTPM_TEE
 	help
 	  This driver proxies for firmware TPM running in TEE.
 
+config TCG_PLATFORM
+	tristate "Platform TPM Device"
+	help
+	  This driver requires a platform implementation to provide the
+	  TPM function.  It will not bind if the implementation is not
+	  present.
+
 source "drivers/char/tpm/st33zp24/Kconfig"
 endif # TCG_TPM
diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
index 9bb142c75243..4b2c04e23bd3 100644
--- a/drivers/char/tpm/Makefile
+++ b/drivers/char/tpm/Makefile
@@ -44,3 +44,4 @@ obj-$(CONFIG_TCG_XEN) += xen-tpmfront.o
 obj-$(CONFIG_TCG_CRB) += tpm_crb.o
 obj-$(CONFIG_TCG_VTPM_PROXY) += tpm_vtpm_proxy.o
 obj-$(CONFIG_TCG_FTPM_TEE) += tpm_ftpm_tee.o
+obj-$(CONFIG_TCG_PLATFORM) += tpm_platform.o
-- 
2.47.1


