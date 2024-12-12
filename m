Return-Path: <linux-integrity+bounces-4362-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 722929EE373
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Dec 2024 10:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DBBC280B40
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Dec 2024 09:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EA420C004;
	Thu, 12 Dec 2024 09:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vv5+Eues"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5985520E327
	for <linux-integrity@vger.kernel.org>; Thu, 12 Dec 2024 09:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733997090; cv=none; b=TzvwrbLkPKdGYr2McGYKU1BLDfA4CpzkkDTT7FvNyaXg30JnQ6BOTJZPisfhRRF+4OLwJElQdgKIhuGca1K6CdIGULczbGaup9Dp6whJZzGCfs24+k8U5CHFABOz3GHqMyHI2pKduDanyeA7wtg7asdI9DHrV2cpRkpDkr8F6P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733997090; c=relaxed/simple;
	bh=9Q4aeImRaRkIMOQNW+C4UpdgE4A5WQVIVSzvejiIlOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xtefgy4QLKnz6PIsPbHbckqPXxEN+ADw0wAEEU5J/cTBxM8MQ1F0su38mo4aW8Sn2fm8IBbTpl+8qi+JXk+LxowYQRrX1pEgkLJDaI6dlZwdSGUrFOWS6v3d/YymAP14+fvGzGjazPF6iWGGH72xjJ1FsCfgjnlX+dIPUes1bkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vv5+Eues; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733997087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1VOiqarubudKxipZ4sbCOrLtgNp7o+zRkyFk6UjJefg=;
	b=Vv5+EuesQ7ivQBJaRiFSiSUUCeaWteW7kTOJlHj6kRu/w/SH5q8HszEO8wd3HROaxtuEin
	iyRcP8T/Zn6d8PhN2WAZ/h1n+FJWplPtyFpQ2Q3ArGVN3ahV68ygI96wpe2/ZoPnkr5Rzp
	y8PqtfIg6HCOXVb7m252k7XhHbuKJ3o=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-bGJgOhBhObqI2_CLOZ-NCg-1; Thu, 12 Dec 2024 04:51:25 -0500
X-MC-Unique: bGJgOhBhObqI2_CLOZ-NCg-1
X-Mimecast-MFC-AGG-ID: bGJgOhBhObqI2_CLOZ-NCg
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3878ad4bf8cso283466f8f.1
        for <linux-integrity@vger.kernel.org>; Thu, 12 Dec 2024 01:51:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733997084; x=1734601884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VOiqarubudKxipZ4sbCOrLtgNp7o+zRkyFk6UjJefg=;
        b=MqBAPwgGj42rJZxaFyDbA1ERkfJBs2VEg+6tgbSYotb1fIacXK7mdCVUMGPdxXWRKg
         TGZhI3JkVvR+BT/zdTyPdBSR6PrAhoSyZKugA1OM6LBgqUrgE5egiFSyZ/rQ/9buuFSP
         DZZZ7D/xyRj9bG9qTrK7jKmmMSPGZl0CZtPqPlCd1mSYP8mriEffZnIY9Qw5V5pT9Qos
         KUTYv7CWRrHI0wW2MgaLqXLttz8x1AuHwbiYhiT4BuqVmvV1vbiAiuy3o4QRQgwvwcdY
         cZBdl8UD44ux3x/akTplY3I0MiVC4GF42aaMNW/JGjV6WknFMywWbjMLJGfogZw1NX6N
         VhRg==
X-Forwarded-Encrypted: i=1; AJvYcCVT4Wa0pVG/XZkYyrrUsGb+wzYIRNYR0NZtexyZVNGvlZMjCPscGYmluo04EeNrJskoDsw/f+/ui+e9o9Vz1h0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrX5O+hJXttCeUT+ky1bwJwDntdx+D14E9CrupY154ZGW3B/98
	/Ypn+caXTZHnjx0xe+/EvK7/U/hgZziYnTcQ8XMwE9wMq2qJj1dSDn1rpguOUZ3Ad1gBKnvlO9O
	+dYw2VPH1xOfzGsQqtmRn5GUGke14v42efab4fLTeLwEPW3NlYd6fRGZ8isviPqjoRw==
X-Gm-Gg: ASbGncuCUieRI974EByz+H1z/aJKFQSTcbBKwnz+R1Tp8ACZ16Yty7qMVdk/x3sJstu
	WTu9VM5zq1IND2Npc0AiNh6VfsLb+EtubBe4ZfII97ezgl/xvA0wRcjkSBfgmIyQX8qnF8P40yv
	lfJoH7sIrqOlp/uFX/nKgel5JfAwVQWOygaeqilT2t4+0SbrkdBz412c9uVE7tdzEQfLmQNK9WO
	bhOlJcdKC4dr4T5vv45jrwWFMmDVCYHxIXMWgd3VxWtcM03s6uUDJiIyUGyLA9nEy80OM7ioMrh
	xRyCc8JMyUl/LD7Nwuu0SyoXsX8XdO56
X-Received: by 2002:a05:6000:710:b0:382:3c7b:9ae with SMTP id ffacd0b85a97d-3878768e6abmr2310594f8f.16.1733997084493;
        Thu, 12 Dec 2024 01:51:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJfWlCNsUJo9EYCvkaq2u2Qir+SrZQpE5Q3wXv1k6TrB8FxTiQMvWpSTTGv1jF4wat+Iv6oA==
X-Received: by 2002:a05:6000:710:b0:382:3c7b:9ae with SMTP id ffacd0b85a97d-3878768e6abmr2310548f8f.16.1733997083800;
        Thu, 12 Dec 2024 01:51:23 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-185-21.business.telecomitalia.it. [87.12.185.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362557c608sm11422145e9.16.2024.12.12.01.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 01:51:23 -0800 (PST)
Date: Thu, 12 Dec 2024 10:51:18 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Claudio Carvalho <cclaudio@linux.ibm.com>, Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-coco@lists.linux.dev, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Huewe <peterhuewe@gmx.de>, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-integrity@vger.kernel.org, x86@kernel.org, 
	Joerg Roedel <jroedel@suse.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jarkko Sakkinen <jarkko@kernel.org>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Dov Murik <dovmurik@linux.ibm.com>, 
	Oliver Steffen <osteffen@redhat.com>
Subject: Re: [PATCH 1/3] tpm: add generic platform device
Message-ID: <zzi3fvbo2rnb2d76soseuekwaqe22ifnrhhjplqhvw6x26lbb4@nmcqylrenzyj>
References: <20241210143423.101774-1-sgarzare@redhat.com>
 <20241210143423.101774-2-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241210143423.101774-2-sgarzare@redhat.com>

On Tue, Dec 10, 2024 at 03:34:21PM +0100, Stefano Garzarella wrote:
>From: James Bottomley <James.Bottomley@HansenPartnership.com>
>
>This is primarily designed to support an enlightened driver for the
>AMD svsm based vTPM, but it could be used by any platform which
>communicates with a TPM device.  The platform must fill in struct
>tpm_platform_ops as the platform_data and set the device name to "tpm"
>to have the binding by name work correctly.  The sole sendrcv
>function is designed to do a single buffer request/response conforming
>to the MSSIM protocol.  For the svsm vTPM case, this protocol is
>transmitted directly to the SVSM, but it could be massaged for other
>function type platform interfaces.
>
>Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
>Signed-off-by: Claudio Carvalho <cclaudio@linux.ibm.com>
>[SG] changed references/links to TCG TPM repo
>Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>---
> include/linux/tpm_platform.h    |  90 ++++++++++++++++++++
> drivers/char/tpm/tpm_platform.c | 141 ++++++++++++++++++++++++++++++++
> drivers/char/tpm/Kconfig        |   7 ++
> drivers/char/tpm/Makefile       |   1 +
> 4 files changed, 239 insertions(+)
> create mode 100644 include/linux/tpm_platform.h
> create mode 100644 drivers/char/tpm/tpm_platform.c
>
>diff --git a/include/linux/tpm_platform.h b/include/linux/tpm_platform.h
>new file mode 100644
>index 000000000000..95c17a75d59d
>--- /dev/null
>+++ b/include/linux/tpm_platform.h
>@@ -0,0 +1,90 @@
>+/* SPDX-License-Identifier: GPL-2.0-only */
>+/*
>+ * Copyright (C) 2023 James.Bottomley@HansenPartnership.com
>+ *
>+ * Interface specification for platforms wishing to activate the
>+ * platform tpm device.  The device must be a platform device created
>+ * with the name "tpm" and it must populate platform_data with struct
>+ * tpm_platform_ops
>+ */
>+
>+/*
>+ * The current MSSIM TPM commands we support.  The complete list is
>+ * in the TcpTpmProtocol header:
>+ *
>+ * https://github.com/TrustedComputingGroup/TPM/blob/main/TPMCmd/Simulator/include/TpmTcpProtocol.h
>+ */
>+
>+#define TPM_SEND_COMMAND		8
>+#define TPM_SIGNAL_CANCEL_ON		9
>+#define TPM_SIGNAL_CANCEL_OFF		10
>+/*
>+ * Any platform specific commands should be placed here and should start
>+ * at 0x8000 to avoid clashes with the MSSIM protocol.  They should follow
>+ * the same self describing buffer format below
>+ */
>+
>+#define TPM_PLATFORM_MAX_BUFFER		4096 /* max req/resp buffer size */
>+
>+/**
>+ * struct tpm_platform_ops - the share platform operations
>+ *
>+ * @sendrcv:	Send a TPM command using the MSSIM protocol.
>+ *
>+ * The MSSIM protocol is designed for a network, so the buffers are
>+ * self describing.  The minimum buffer size is sizeof(u32).  Every
>+ * MSSIM command defines its own transport buffer and the command is
>+ * sent in the first u32 array.  The only modification we make is that
>+ * the MSSIM uses network order and we use the endianness of the
>+ * architecture.  The response to every command (in the same buffer)
>+ * is a u32 size preceded array.  Most of the MSSIM commands simply
>+ * return zero here because they have no defined response.
>+ *
>+ * The only command with a defined request/response size is TPM_SEND_COMMAND
>+ * The definition is in the structures below
>+ */
>+struct tpm_platform_ops {
>+	int (*sendrcv)(u8 *buffer);
>+};
>+
>+/**
>+ * struct tpm_send_cmd_req - Structure for a TPM_SEND_COMMAND
>+ *
>+ * @cmd:	The command (must be TPM_SEND_COMMAND)
>+ * @locality:	The locality
>+ * @inbuf_size:	The size of the input buffer following
>+ * @inbuf:	A buffer of size inbuf_size
>+ *
>+ * Note that MSSIM expects @inbuf_size to be equal to the size of the
>+ * specific TPM command, otherwise an TPM_RC_COMMAND_SIZE error is
>+ * returned.
>+ */
>+struct tpm_send_cmd_req {
>+	u32	cmd;
>+	u8	locality;
>+	u32	inbuf_size;
>+	u8	inbuf[];
>+} __packed;
>+
>+/**
>+ * struct tpm_req - generic request header for single word command
>+ *
>+ * @cmd:	The command to send
>+ */
>+struct tpm_req {
>+	u32	cmd;
>+} __packed;
>+
>+/**
>+ * struct tpm_resp - generic response header
>+ *
>+ * @size:	The response size (zero if nothing follows)
>+ *
>+ * Note: most MSSIM commands simply return zero here with no indication
>+ * of success or failure.
>+ */
>+
>+struct tpm_resp {
>+	s32	size;
>+} __packed;
>+
>diff --git a/drivers/char/tpm/tpm_platform.c b/drivers/char/tpm/tpm_platform.c
>new file mode 100644
>index 000000000000..b53d74344d61
>--- /dev/null
>+++ b/drivers/char/tpm/tpm_platform.c
>@@ -0,0 +1,141 @@
>+// SPDX-License-Identifier: GPL-2.0-only
>+/*
>+ * Platform based TPM emulator
>+ *
>+ * Copyright (C) 2023 James.Bottomley@HansenPartnership.com
>+ *
>+ * Designed to handle a simple function request/response single buffer
>+ * TPM or vTPM rooted in the platform.  This device driver uses the
>+ * MSSIM protocol from the official TCG reference implementation
>+ *
>+ * https://github.com/TrustedComputingGroup/TPM
>+ *
>+ * to communicate between the driver and the platform.  This is rich
>+ * enough to allow platform operations like cancellation The platform
>+ * should not act on platform commands like power on/off and reset
>+ * which can disrupt the TPM guarantees.
>+ *
>+ * This driver is designed to be single threaded (one call in to the
>+ * platform TPM at any one time).  The threading guarantees are
>+ * provided by the chip mutex.
>+ */
>+
>+#include <linux/module.h>
>+#include <linux/kernel.h>
>+#include <linux/platform_device.h>
>+#include <linux/tpm_platform.h>
>+
>+#include "tpm.h"
>+
>+static struct tpm_platform_ops *pops;
>+
>+static u8 *buffer;
>+/*
>+ * FIXME: before implementing locality we need to agree what it means
>+ * to the platform
>+ */
>+static u8 locality;
>+
>+static int tpm_platform_send(struct tpm_chip *chip, u8 *buf, size_t len)
>+{
>+	int ret;
>+	struct tpm_send_cmd_req *req = (struct tpm_send_cmd_req *)buffer;
>+
>+	if (len > TPM_PLATFORM_MAX_BUFFER - sizeof(*req))
>+		return -EINVAL;
>+	req->cmd = TPM_SEND_COMMAND;
>+	req->locality = locality;
>+	req->inbuf_size = len;
>+	memcpy(req->inbuf, buf, len);
>+
>+	ret = pops->sendrcv(buffer);
>+	if (ret)
>+		return ret;
>+
>+	return 0;
>+}
>+
>+static int tpm_platform_recv(struct tpm_chip *chip, u8 *buf, size_t len)
>+{
>+	struct tpm_resp *resp = (struct tpm_resp *)buffer;
>+
>+	if (resp->size < 0)
>+		return resp->size;

While reviewing Oliver's work for the driver in edk2[1], I noticed that
there wasn't this check and asked to add it, but talking to him and
looking in the code/spec, we realized that it's strange that
tpm_resp.size field is signed.

 From SVSM spec it looks like it can't be negative:

     Table 17: TPM_SEND_COMMAND Response Structure

     Byte     Size        Meaning
     Offset   (Bytes)
     0x000    4           Response size (in bytes)
     0x004    Variable    Variable Response

And also Coconut SVSM remap it to the `responseSize` of the TCG TPM
implementation which is unsigned:

     LIB_EXPORT void _plat__RunCommand(
         uint32_t        requestSize,   // IN: command buffer size
         unsigned char*  request,       // IN: command buffer
         uint32_t*       responseSize,  // IN/OUT: response buffer size
         unsigned char** response       // IN/OUT: response buffer
     )

@James, @Claudio, @Tom, should we use u32 for tpm_resp.size?

Thanks,
Stefano

[1] https://github.com/tianocore/edk2/pull/6527#discussion_r1880204144

>+
>+	if (len < resp->size)
>+		return -E2BIG;
>+
>+	if (resp->size > TPM_PLATFORM_MAX_BUFFER - sizeof(*resp))
>+		return -EINVAL;  // Invalid response from the platform TPM
>+
>+	memcpy(buf, buffer + sizeof(*resp), resp->size);
>+
>+	return resp->size;
>+}
>+
>+static struct tpm_class_ops tpm_chip_ops = {
>+	.flags = TPM_OPS_AUTO_STARTUP,
>+	.send = tpm_platform_send,
>+	.recv = tpm_platform_recv,
>+};
>+
>+static struct platform_driver tpm_platform_driver = {
>+	.driver = {
>+		.name = "tpm",
>+	},
>+};
>+
>+static int __init tpm_platform_probe(struct platform_device *pdev)
>+{
>+	struct device *dev = &pdev->dev;
>+	struct tpm_chip *chip;
>+	int err;
>+
>+	if (!dev->platform_data)
>+		return -ENODEV;
>+
>+	/*
>+	 * in theory platform matching should mean this is always
>+	 * true, but just in case anyone tries force binding
>+	 */
>+	if (strcmp(pdev->name, tpm_platform_driver.driver.name) != 0)
>+		return -ENODEV;
>+
>+	if (!buffer)
>+		buffer = kmalloc(TPM_PLATFORM_MAX_BUFFER, GFP_KERNEL);
>+
>+	if (!buffer)
>+		return -ENOMEM;
>+
>+	pops = dev->platform_data;
>+
>+	chip = tpmm_chip_alloc(dev, &tpm_chip_ops);
>+	if (IS_ERR(chip))
>+		return PTR_ERR(chip);
>+
>+	/*
>+	 * Setting TPM_CHIP_FLAG_IRQ guarantees that ->recv will be
>+	 * called straight after ->send and means we don't need to
>+	 * implement any other chip ops.
>+	 */
>+	chip->flags |= TPM_CHIP_FLAG_IRQ;
>+	err = tpm2_probe(chip);
>+	if (err)
>+		return err;
>+
>+	err = tpm_chip_register(chip);
>+	if (err)
>+		return err;
>+
>+	dev_info(dev, "TPM %s platform device\n",
>+		 (chip->flags & TPM_CHIP_FLAG_TPM2) ? "2.0" : "1.2");
>+
>+	return 0;
>+}
>+
>+module_platform_driver_probe(tpm_platform_driver, tpm_platform_probe);
>+
>+MODULE_AUTHOR("James Bottomley <James.Bottomley@HansenPartnership.com>");
>+MODULE_LICENSE("GPL");
>+MODULE_DESCRIPTION("Platform TPM Driver");
>+MODULE_ALIAS("platform:tpm");
>diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
>index 0fc9a510e059..b162f59305ef 100644
>--- a/drivers/char/tpm/Kconfig
>+++ b/drivers/char/tpm/Kconfig
>@@ -225,5 +225,12 @@ config TCG_FTPM_TEE
> 	help
> 	  This driver proxies for firmware TPM running in TEE.
>
>+config TCG_PLATFORM
>+	tristate "Platform TPM Device"
>+	help
>+	  This driver requires a platform implementation to provide the
>+	  TPM function.  It will not bind if the implementation is not
>+	  present.
>+
> source "drivers/char/tpm/st33zp24/Kconfig"
> endif # TCG_TPM
>diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
>index 9bb142c75243..4b2c04e23bd3 100644
>--- a/drivers/char/tpm/Makefile
>+++ b/drivers/char/tpm/Makefile
>@@ -44,3 +44,4 @@ obj-$(CONFIG_TCG_XEN) += xen-tpmfront.o
> obj-$(CONFIG_TCG_CRB) += tpm_crb.o
> obj-$(CONFIG_TCG_VTPM_PROXY) += tpm_vtpm_proxy.o
> obj-$(CONFIG_TCG_FTPM_TEE) += tpm_ftpm_tee.o
>+obj-$(CONFIG_TCG_PLATFORM) += tpm_platform.o
>-- 
>2.47.1
>


