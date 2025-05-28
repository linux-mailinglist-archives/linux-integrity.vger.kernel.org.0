Return-Path: <linux-integrity+bounces-6321-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C88D7AC637A
	for <lists+linux-integrity@lfdr.de>; Wed, 28 May 2025 09:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05E6D7ADB38
	for <lists+linux-integrity@lfdr.de>; Wed, 28 May 2025 07:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046DD29408;
	Wed, 28 May 2025 07:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BW7tNCxZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D0B207DE2
	for <linux-integrity@vger.kernel.org>; Wed, 28 May 2025 07:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748419039; cv=none; b=qPmbdC7xpAV7+5+iIB1sIVA2EtnWDQpcCERSBebVeeF4hqXx1cphE3fENgNmIedK7+FFtv/T1ElFYhrFHBAekwUAhyWHKiidJDhlLQpqxmM37Uqb0wtI+daEImw5oyLxm29p1XxQHXOSCifTG5V8yWbif0czkYemyVJ7YVxm/MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748419039; c=relaxed/simple;
	bh=++Q4mKF98cD+c18CNdwprn8yWU8Z/zioCJe8t2w0Kb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwmkZg4lHtAh6fScfVUhgPFz7OVgp/rDgBMwhUlZ2JB568rElb8NGkdhdr88z7DZOnCV00Hd9bVHDX6Ib2PLYKpu7RmsJJLrwWRc1UPQKkBVly1xneuj9fCVfS9W4+txbllqTtRZv75G7dVGVqdWJ7zdA4YVQkWrODkWCLC4hcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BW7tNCxZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748419036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iar4upBixTl9NYOuefrehoa64+W7FsckxVPaK+xP0LI=;
	b=BW7tNCxZbZvfTNgqCGsiK6lioomgkViy+l6LJpDSKogVyXQv9bHFj+BMCtMjww2nisGWpS
	2/cGRVyqsErFYVYmVx2OGfvleSJmHtXc0+OrYepkmxvymhlwoRlgXJoAy7eqRjJKRbuiJd
	g3JvpnjRz3x0AX9ppGnk64r/KcKElcg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-NIZYMUffNTOjHn0FeUjdeQ-1; Wed, 28 May 2025 03:57:15 -0400
X-MC-Unique: NIZYMUffNTOjHn0FeUjdeQ-1
X-Mimecast-MFC-AGG-ID: NIZYMUffNTOjHn0FeUjdeQ_1748419034
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43eea5a5d80so26272535e9.1
        for <linux-integrity@vger.kernel.org>; Wed, 28 May 2025 00:57:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748419034; x=1749023834;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iar4upBixTl9NYOuefrehoa64+W7FsckxVPaK+xP0LI=;
        b=f+kUWbu2o8SODdyCvI3Z0Nc+eRlwjurMCFP3Bh7/WY00d2/gfNH9/fvr4i6opuZH4I
         uRDNu6oQ7YFlD3g5N/kaqB5I40DgiUsCAhfh1eD83unuYoB/LxoGGwrIwJXGJYd7MGAW
         gdRJb9fLNfn8JKoqC9d3niCECHybX/DerV3PKG7iTJj0A7gwijfPhUiH9ym/XYlvrLBV
         cxsjfgP3+85uhnNR//rU0z5ocRiqv7malQXxvqK0YVHMXoVaHdY4rsi1ykhuWTs8Shz1
         AXfNc+YVC7Wuy8Gyy2JQmhS3vFghXa8Coz2ZdxO3hSjG7H3b6pxw3LtNtLLb9OwIrSPt
         B8LQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmNLvU1X2ZnP/GurU0+i1tjrZW4vSIfDmf6LaYqhtDTpTFGQ6hLKGhzE2pQvJEbrrrFRmHrnXDD9Na+zQRNpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKsCOWKyRwY70Dm1a04r5own75C7jH/wJZZy14YFQ9uWi7pM8x
	NBhQYFjcVI+esOVheIIC69g6c5Ji/vvrRdHtA94tOZUKQxkR5qhSbWE+0+uNzpzGoJAydEayIEI
	wvOYYUR36uvashbC4k/F6LZSZIApJ0JYj1z9P9d62YWyttM6gEHaiJtYluXjVyyj4Z0UN+Q==
X-Gm-Gg: ASbGncuMtP6FFmMBdOYNJ9ayKvxr6yIYD0XjWDR09cGN4oV69aXw9LBx8npTH/62Xhw
	c52gfwqojGWBqkw2uW1uFyLkzicEZwBdzXfG36vTqf3yLrNOKLLbYviLyXKTHUmo8OLFMbnBRDQ
	ntlpUFcyOd/l9t0/YVB63KIm5w/6dZF+xZcX4ovu6Q9Zdi1RUUKkEnL4Zp7r93HIX/bS3Z3l51f
	dCpzz8s8dcXvifyjgWbZx3Wnl6WBjv8NnQ47EmUISOkaXedreMJKdwSGe7VDc13yLIQOTXQ4tBH
	cyZIZ4CPKzqC/+OEASNrhFsoKQWO9HtQN2f89JUEELzHsg2To83ZSWxGmkN8
X-Received: by 2002:a05:600c:8283:b0:43d:45a:8fca with SMTP id 5b1f17b1804b1-44c94c2a4c6mr144954585e9.30.1748419034131;
        Wed, 28 May 2025 00:57:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMJo+Ct94cj0YyB7i6b94aZWFudVWZko8nkaONnu4gYPe+xjPHrearFkc8yOOEVQn4tCzDyQ==
X-Received: by 2002:a05:600c:8283:b0:43d:45a:8fca with SMTP id 5b1f17b1804b1-44c94c2a4c6mr144954225e9.30.1748419033483;
        Wed, 28 May 2025 00:57:13 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-35.retail.telecomitalia.it. [82.53.134.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450064add8bsm12831655e9.17.2025.05.28.00.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 00:57:12 -0700 (PDT)
Date: Wed, 28 May 2025 09:57:04 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: lee@kernel.org, herbert@gondor.apana.org.au, jarkko@kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, davem@davemloft.net, 
	linux-crypto@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org, 
	Yinggang Gu <guyinggang@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v10 4/5] tpm: Add a driver for Loongson TPM device
Message-ID: <7ifsmhpubkedbiivcnfrxlrhriti5ksb4lbgrdwhwfxtp5ledc@z2jf6sz4vdgd>
References: <20250528065944.4511-1-zhaoqunqin@loongson.cn>
 <20250528065944.4511-5-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250528065944.4511-5-zhaoqunqin@loongson.cn>

On Wed, May 28, 2025 at 02:59:43PM +0800, Qunqin Zhao wrote:
>Loongson Security Engine supports random number generation, hash,
>symmetric encryption and asymmetric encryption. Based on these
>encryption functions, TPM2 have been implemented in the Loongson
>Security Engine firmware. This driver is responsible for copying data
>into the memory visible to the firmware and receiving data from the
>firmware.
>
>Co-developed-by: Yinggang Gu <guyinggang@loongson.cn>
>Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
>Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
>Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
>---
>v10: Added error check in send and recv callbak
>
>v9: "tpm_loongson_driver" --> "tpm_loongson"
>    "depends on CRYPTO_DEV_LOONGSON_SE" --> "depends on MFD_LOONGSON_SE"
>
>v8: In the send callback, it will wait until the TPM2 command is
>    completed. So do not need to wait in the recv callback.
>    Removed Jarkko's tag cause there are some changes in v8
>
>v7: Moved Kconfig entry between TCG_IBMVTPM and TCG_XEN.
>    Added Jarkko's tag(a little change, should be fine).
>
>v6: Replace all "ls6000se" with "loongson"
>    Prefix all with tpm_loongson instead of tpm_lsse.
>    Removed Jarkko's tag cause there are some changes in v6
>
>v5: None
>v4: Prefix all with tpm_lsse instead of tpm.
>    Removed MODULE_AUTHOR fields.
>
>v3: Added reminder about Loongson security engine to git log.
>
> drivers/char/tpm/Kconfig        |  9 ++++
> drivers/char/tpm/Makefile       |  1 +
> drivers/char/tpm/tpm_loongson.c | 84 +++++++++++++++++++++++++++++++++
> 3 files changed, 94 insertions(+)
> create mode 100644 drivers/char/tpm/tpm_loongson.c
>
>diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
>index dddd702b2..ba3924eb1 100644
>--- a/drivers/char/tpm/Kconfig
>+++ b/drivers/char/tpm/Kconfig
>@@ -189,6 +189,15 @@ config TCG_IBMVTPM
> 	  will be accessible from within Linux.  To compile this driver
> 	  as a module, choose M here; the module will be called tpm_ibmvtpm.
>
>+config TCG_LOONGSON
>+	tristate "Loongson TPM Interface"
>+	depends on MFD_LOONGSON_SE
>+	help
>+	  If you want to make Loongson TPM support available, say Yes and
>+	  it will be accessible from within Linux. To compile this
>+	  driver as a module, choose M here; the module will be called
>+	  tpm_loongson.
>+
> config TCG_XEN
> 	tristate "XEN TPM Interface"
> 	depends on TCG_TPM && XEN
>diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
>index 9de1b3ea3..5b5cdc0d3 100644
>--- a/drivers/char/tpm/Makefile
>+++ b/drivers/char/tpm/Makefile
>@@ -46,3 +46,4 @@ obj-$(CONFIG_TCG_ARM_CRB_FFA) += tpm_crb_ffa.o
> obj-$(CONFIG_TCG_VTPM_PROXY) += tpm_vtpm_proxy.o
> obj-$(CONFIG_TCG_FTPM_TEE) += tpm_ftpm_tee.o
> obj-$(CONFIG_TCG_SVSM) += tpm_svsm.o
>+obj-$(CONFIG_TCG_LOONGSON) += tpm_loongson.o
>diff --git a/drivers/char/tpm/tpm_loongson.c b/drivers/char/tpm/tpm_loongson.c
>new file mode 100644
>index 000000000..5cbdb37f8
>--- /dev/null
>+++ b/drivers/char/tpm/tpm_loongson.c
>@@ -0,0 +1,84 @@
>+// SPDX-License-Identifier: GPL-2.0
>+/* Copyright (c) 2025 Loongson Technology Corporation Limited. */
>+
>+#include <linux/device.h>
>+#include <linux/mfd/loongson-se.h>
>+#include <linux/platform_device.h>
>+#include <linux/wait.h>
>+
>+#include "tpm.h"
>+
>+struct tpm_loongson_cmd {
>+	u32 cmd_id;
>+	u32 data_off;
>+	u32 data_len;
>+	u32 pad[5];
>+};
>+
>+static int tpm_loongson_recv(struct tpm_chip *chip, u8 *buf, size_t count)
>+{
>+	struct loongson_se_engine *tpm_engine = dev_get_drvdata(&chip->dev);
>+	struct tpm_loongson_cmd *cmd_ret = tpm_engine->command_ret;
>+
>+	if (cmd_ret->data_len > count)
>+		return -EIO;
>+
>+	memcpy(buf, tpm_engine->data_buffer, cmd_ret->data_len);
>+
>+	return cmd_ret->data_len;
>+}
>+
>+static int tpm_loongson_send(struct tpm_chip *chip, u8 *buf, size_t count)
>+{
>+	struct loongson_se_engine *tpm_engine = dev_get_drvdata(&chip->dev);
>+	struct tpm_loongson_cmd *cmd = tpm_engine->command;
>+
>+	if (count > tpm_engine->buffer_size)
>+		return -E2BIG;
>+
>+	cmd->data_len = count;
>+	memcpy(tpm_engine->data_buffer, buf, count);
>+
>+	return loongson_se_send_engine_cmd(tpm_engine);
>+}
>+
>+static const struct tpm_class_ops tpm_loongson_ops = {
>+	.flags = TPM_OPS_AUTO_STARTUP,
>+	.recv = tpm_loongson_recv,
>+	.send = tpm_loongson_send,
>+};
>+
>+static int tpm_loongson_probe(struct platform_device *pdev)
>+{
>+	struct loongson_se_engine *tpm_engine;
>+	struct device *dev = &pdev->dev;
>+	struct tpm_loongson_cmd *cmd;
>+	struct tpm_chip *chip;
>+
>+	tpm_engine = loongson_se_init_engine(dev->parent, SE_ENGINE_TPM);
>+	if (!tpm_engine)
>+		return -ENODEV;
>+	cmd = tpm_engine->command;
>+	cmd->cmd_id = SE_CMD_TPM;
>+	cmd->data_off = tpm_engine->buffer_off;
>+
>+	chip = tpmm_chip_alloc(dev, &tpm_loongson_ops);
>+	if (IS_ERR(chip))
>+		return PTR_ERR(chip);
>+	chip->flags = TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_IRQ;

Why setting TPM_CHIP_FLAG_IRQ?

IIUC this driver is similar to ftpm and svsm where the send is 
synchronous so having .status, .cancel, etc. set to 0 should be enough 
to call .recv() just after send() in tpm_try_transmit(). See commit 
980a573621ea ("tpm: Make chip->{status,cancel,req_canceled} opt")

BTW, I think I should touch also this driver in the next version of my 
series that I'll send after the merge window:
https://lore.kernel.org/linux-integrity/20250514134630.137621-1-sgarzare@redhat.com/

The rest LGTM!

Thanks,
Stefano

>+	dev_set_drvdata(&chip->dev, tpm_engine);
>+
>+	return tpm_chip_register(chip);
>+}
>+
>+static struct platform_driver tpm_loongson = {
>+	.probe   = tpm_loongson_probe,
>+	.driver  = {
>+		.name  = "loongson-tpm",
>+	},
>+};
>+module_platform_driver(tpm_loongson);
>+
>+MODULE_ALIAS("platform:loongson-tpm");
>+MODULE_LICENSE("GPL");
>+MODULE_DESCRIPTION("Loongson TPM driver");
>-- 
>2.45.2
>
>


