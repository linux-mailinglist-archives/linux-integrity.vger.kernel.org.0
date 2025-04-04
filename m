Return-Path: <linux-integrity+bounces-5609-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47BD6A7C13F
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Apr 2025 18:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E215B17D2A8
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Apr 2025 16:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C035204874;
	Fri,  4 Apr 2025 16:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VBOBk67E"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F432046A3;
	Fri,  4 Apr 2025 16:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743782779; cv=none; b=bfQ6TGrmd0pY2hFVhahygw9xvcvwtfyTr4jBNdFQqM7UPZ2vlOxK14cd5yFjfgfMtbytTV5xT7xx63OJFXu1XJXheuXHhAeM2/3HQWsIHsKbTJyp5GwHE03GX2eiUbKAI80j0Uz0KFsp0p6nzCdZ5IYi40kUkO8ZXxrb3D7pfa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743782779; c=relaxed/simple;
	bh=EcuQkb2h3NTd5HWHburtRuD8tbNo0XyhAoQFzooXZuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1s4BnX+8ZvvNU1+NLzTPup8nAajXZwGBx6WgL+PpELKGkMm0n5ioplnmV55/JfUcQzxiQa9zh0V/HCxoZVlp6WAfUd7bBHcEfSUzPhnyUsnnVsvAhtekWEMljRYYTKw2+YebRLrZ4O9YJIcDGSy7kPUb/HpDhkW5Ffm567L/L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VBOBk67E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31813C4CEDD;
	Fri,  4 Apr 2025 16:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743782775;
	bh=EcuQkb2h3NTd5HWHburtRuD8tbNo0XyhAoQFzooXZuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VBOBk67EGy/rQ+JmNC18X11GtOI49ltRiHJrF8tOgQ8GL4kZ1sqdzJZmQSCJlbXa9
	 fz93kJudNL67AiPvjthKMJRjDcLae7ya5m1QQEhzLzbS9SGEOeTHYmvBgqPRbwK6Gp
	 Vz/bHrjs5+jNhXpN5zdiCQoHE1ENTUTN1s5kpAEGAOYYyru1W4IE87vZjcnoBOFq/P
	 tjnI+3g1dn978XMU7O3YwqQ7jmvqXq4GjD/hCrUonJiuJL1dSl4ZYl+GiwGl3/ijCu
	 LZJuomAUajomLQBqqf6ONnINltN6YQRUB3mqGMYgHtHNVwEkInpcWDWO4fV2Nvj7Mr
	 HLCjowZsBqkjg==
Date: Fri, 4 Apr 2025 17:06:10 +0100
From: Lee Jones <lee@kernel.org>
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, peterhuewe@gmx.de,
	jarkko@kernel.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-crypto@vger.kernel.org,
	jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	pmenzel@molgen.mpg.de, Yinggang Gu <guyinggang@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v7 1/6] mfd: Add support for Loongson Security Module
Message-ID: <20250404160610.GJ372032@google.com>
References: <20250403024645.4427-1-zhaoqunqin@loongson.cn>
 <20250403024645.4427-2-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250403024645.4427-2-zhaoqunqin@loongson.cn>

On Thu, 03 Apr 2025, Qunqin Zhao wrote:

> This driver supports Loongson Security Module, which provides the control
> for it's hardware encryption acceleration child devices.
> 
> Co-developed-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
> v7: Moved Kconfig entry between MFD_INTEL_M10_BMC_PMCI and MFD_QNAP_MCU.
> 
>     Renamed se_enable_int_locked() to se_enable_int(), then moved the
>     lock out of se_disable_int().
> 
>     "se_send_genl_cmd" ---> "se_send_cmd".
>     "struct lsse_ch" ---> "struct se_channel".
>     
> v6: Replace all "ls6000se" with "loongson"
> v5: Registered "ls6000se-rng" device.
> v3-v4: None
> 
> v2: Removed "ls6000se-sdf" device, added "ls6000se-tpm" device.
>     Passed dmamem size to SE firmware in se_init_hw() function.
> 
>  drivers/mfd/Kconfig             |  10 +
>  drivers/mfd/Makefile            |   2 +
>  drivers/mfd/loongson-se.c       | 374 ++++++++++++++++++++++++++++++++
>  include/linux/mfd/loongson-se.h |  75 +++++++
>  4 files changed, 461 insertions(+)
>  create mode 100644 drivers/mfd/loongson-se.c
>  create mode 100644 include/linux/mfd/loongson-se.h
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 22b936310..66889f2a9 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -2369,6 +2369,16 @@ config MFD_INTEL_M10_BMC_PMCI
>  	  additional drivers must be enabled in order to use the functionality
>  	  of the device.
>  
> +config MFD_LOONGSON_SE
> +	tristate "Loongson Security Module Interface"
> +	depends on LOONGARCH && ACPI
> +	select MFD_CORE
> +	help
> +	  The Loongson security module provides the control for hardware
> +	  encryption acceleration devices. Each device uses at least one
> +	  channel to interact with security module, and each channel may
> +	  have its own buffer provided by security module.
> +
>  config MFD_QNAP_MCU
>  	tristate "QNAP microcontroller unit core driver"
>  	depends on SERIAL_DEV_BUS
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 948cbdf42..fc50601ca 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -290,3 +290,5 @@ obj-$(CONFIG_MFD_RSMU_I2C)	+= rsmu_i2c.o rsmu_core.o
>  obj-$(CONFIG_MFD_RSMU_SPI)	+= rsmu_spi.o rsmu_core.o
>  
>  obj-$(CONFIG_MFD_UPBOARD_FPGA)	+= upboard-fpga.o
> +
> +obj-$(CONFIG_MFD_LOONGSON_SE)	+= loongson-se.o
> diff --git a/drivers/mfd/loongson-se.c b/drivers/mfd/loongson-se.c
> new file mode 100644
> index 000000000..4f30695de
> --- /dev/null
> +++ b/drivers/mfd/loongson-se.c
> @@ -0,0 +1,374 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Copyright (C) 2025 Loongson Technology Corporation Limited */
> +
> +#include <linux/acpi.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/errno.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/iopoll.h>
> +#include <linux/kernel.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/loongson-se.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +/*
> + * The Loongson Security Module provides the control for hardware
> + * encryption acceleration child devices. The SE framework is
> + * shown as follows:
> + *
> + *                   +------------+
> + *                   |    CPU     |
> + *                   +------------+
> + *			^	^
> + *	            DMA |	| IRQ
> + *			v	v
> + *        +-----------------------------------+
> + *        |     Loongson Security Module      |
> + *        +-----------------------------------+
> + *             ^                ^
> + *    channel1 |       channel2 |
> + *             v                v
> + *        +-----------+    +----------+
> + *        | sub-dev1  |    | sub-dev2 |  ..... Max sub-dev31
> + *        +-----------+    +----------+
> + *
> + * The CPU cannot directly communicate with SE's sub devices,
> + * but sends commands to SE, which processes the commands and
> + * sends them to the corresponding sub devices.
> + */
> +
> +struct loongson_se {
> +	void __iomem *base;
> +	u32 version;
> +	spinlock_t dev_lock;
> +	struct completion cmd_completion;
> +
> +	/* dma memory */
> +	void *mem_base;
> +	int mem_map_pages;
> +	unsigned long *mem_map;
> +
> +	/* channel */
> +	struct mutex ch_init_lock;
> +	struct se_channel chs[SE_CH_MAX];
> +};
> +
> +union se_request {
> +	u32 info[8];
> +	struct se_cmd {
> +		u32 cmd;
> +		u32 info[7];
> +	} req;
> +	struct se_res {
> +		u32 cmd;
> +		u32 cmd_ret;
> +		u32 info[6];
> +	} res;
> +};
> +
> +static inline u32 se_readl(struct loongson_se *se, u32 off)
> +{
> +	return readl(se->base + off);
> +}
> +
> +static inline void se_writel(struct loongson_se *se, u32 val, u32 off)
> +{
> +	writel(val, se->base + off);
> +}

Why are these being abstracted?  Just use readl/writel directly.

> +static void se_enable_int(struct loongson_se *se, u32 int_bit)
> +{
> +	u32 tmp;
> +
> +	tmp = se_readl(se, SE_S2LINT_EN);
> +	tmp |= int_bit;
> +	se_writel(se, tmp, SE_S2LINT_EN);
> +}
> +
> +static void se_disable_int(struct loongson_se *se, u32 int_bit)
> +{
> +	u32 tmp;
> +
> +	tmp = se_readl(se, SE_S2LINT_EN);
> +	tmp &= ~(int_bit);
> +	se_writel(se, tmp, SE_S2LINT_EN);
> +}
> +
> +static int se_poll(struct loongson_se *se, u32 int_bit)
> +{
> +	u32 status;
> +	int err;
> +
> +	spin_lock_irq(&se->dev_lock);
> +
> +	se_enable_int(se, int_bit);
> +	se_writel(se, int_bit, SE_L2SINT_SET);
> +	err = readl_relaxed_poll_timeout_atomic(se->base + SE_L2SINT_STAT, status,
> +						!(status & int_bit), 1, 10000);
> +
> +	spin_unlock_irq(&se->dev_lock);
> +
> +	return err;
> +}
> +
> +static int se_send_requeset(struct loongson_se *se, union se_request *req)

What's a requeset?
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(req->info); i++)
> +		se_writel(se, req->info[i], SE_DATA_S + i * 4);
> +
> +	return se_poll(se, SE_INT_SETUP);
> +}
> +
> +/*
> + * Called by SE's child device driver.
> + * Send a request to the corresponding device.
> + */
> +int se_send_ch_requeset(struct se_channel *ch)
> +{
> +	return se_poll(ch->se, ch->int_bit);
> +}

More pointless abstraction.  Just export se_poll()?

> +EXPORT_SYMBOL_GPL(se_send_ch_requeset);
> +
> +static int se_get_res(struct loongson_se *se, u32 cmd, union se_request *res)

What are we getting here?  What is a 'res'?

> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(res->info); i++)

for (int i = 0; ...

> +		res->info[i] = se_readl(se, SE_DATA_L + i * 4);
> +
> +	if (res->res.cmd != cmd)
> +		return -EFAULT;
> +
> +	return 0;
> +}
> +
> +static int se_send_cmd(struct loongson_se *se, union se_request *req)
> +{
> +	int err;
> +
> +	err = se_send_requeset(se, req);
> +	if (err)
> +		return err;
> +
> +	if (!wait_for_completion_timeout(&se->cmd_completion, HZ))
> +		return -ETIME;

-ETIMEDOUT

> +
> +	return se_get_res(se, req->req.cmd, req);
> +}
> +
> +static int se_set_msg(struct se_channel *ch)
> +{
> +	struct loongson_se *se = ch->se;
> +	union se_request req;
> +
> +	req.req.cmd = SE_CMD_SETMSG;
> +	req.req.info[0] = ch->id;
> +	req.req.info[1] = ch->smsg - se->mem_base;
> +	req.req.info[2] = ch->msg_size;
> +
> +	return se_send_cmd(se, &req);
> +}
> +
> +static irqreturn_t se_irq(int irq, void *dev_id)

se_irq_handler()

> +{
> +	struct loongson_se *se = (struct loongson_se *)dev_id;
> +	struct se_channel *ch;
> +	unsigned long flag;
> +	u32 int_status;
> +	int id;
> +
> +	int_status = se_readl(se, SE_S2LINT_STAT);
> +
> +	spin_lock_irqsave(&se->dev_lock, flag);
> +	se_disable_int(se, int_status);
> +	spin_unlock_irqrestore(&se->dev_lock, flag);
> +
> +	if (int_status & SE_INT_SETUP) {
> +		complete(&se->cmd_completion);
> +		int_status &= ~SE_INT_SETUP;
> +		se_writel(se, SE_INT_SETUP, SE_S2LINT_CL);
> +	}
> +
> +	while (int_status) {
> +		id = __ffs(int_status);
> +
> +		ch = &se->chs[id];
> +		if (ch->complete)
> +			ch->complete(ch);
> +		int_status &= ~BIT(id);
> +		se_writel(se, BIT(id), SE_S2LINT_CL);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int se_init_hw(struct loongson_se *se, dma_addr_t addr, int size)
> +{
> +	union se_request req;
> +	int err;
> +
> +	/* Start engine */
> +	req.req.cmd = SE_CMD_START;
> +	err = se_send_cmd(se, &req);
> +	if (err)
> +		return err;
> +
> +	/* Get Version */
> +	req.req.cmd = SE_CMD_GETVER;
> +	err = se_send_cmd(se, &req);
> +	if (err)
> +		return err;
> +	se->version = req.res.info[0];
> +
> +	/* Setup dma memory */

DMA

> +	req.req.cmd = SE_CMD_SETBUF;
> +	req.req.info[0] = addr & 0xffffffff;
> +	req.req.info[1] = addr >> 32;

Define these magic numbers please.

> +	req.req.info[2] = size;
> +
> +	return se_send_cmd(se, &req);
> +}
> +
> +/*
> + * se_init_ch() - Init the channel used by child device.
> + *
> + * Allocate dma memory as agreed upon with SE on SE probe,

DMA, throughout please.

> + * and register the callback function when the data processing
> + * in this channel is completed.
> + */
> +struct se_channel *se_init_ch(struct device *dev, int id, int data_size, int msg_size,

What's a "ch"?

> +			      void *priv, void (*complete)(struct se_channel *se_ch))

I'm not entirely sure what this device is or how it works, but this
isn't really what MFD is for.  MFD has no knowledge of channel
initialisation or completion call-backs or the like.  What you have here
goes beyond scope.

> +{
> +	struct loongson_se *se = dev_get_drvdata(dev);
> +	struct se_channel *ch;
> +	int data_first, data_nr;
> +	int msg_first, msg_nr;
> +
> +	mutex_lock(&se->ch_init_lock);
> +
> +	ch = &se->chs[id];
> +	ch->se = se;
> +	ch->id = id;
> +	ch->int_bit = BIT(id);

This can be derived from ch->id, so you don't need to store it.

Or you don't need 'id' - one of the two.

> +
> +	data_nr = round_up(data_size, PAGE_SIZE) / PAGE_SIZE;
> +	data_first = bitmap_find_next_zero_area(se->mem_map, se->mem_map_pages,
> +						0, data_nr, 0);
> +	if (data_first >= se->mem_map_pages) {
> +		ch = NULL;
> +		goto out_unlock;
> +	}
> +
> +	bitmap_set(se->mem_map, data_first, data_nr);
> +	ch->off = data_first * PAGE_SIZE;
> +	ch->data_buffer = se->mem_base + ch->off;
> +	ch->data_size = data_size;
> +
> +	msg_nr = round_up(msg_size, PAGE_SIZE) / PAGE_SIZE;
> +	msg_first = bitmap_find_next_zero_area(se->mem_map, se->mem_map_pages,
> +					       0, msg_nr, 0);
> +	if (msg_first >= se->mem_map_pages) {
> +		ch = NULL;
> +		goto out_unlock;
> +	}
> +
> +	bitmap_set(se->mem_map, msg_first, msg_nr);
> +	ch->smsg = se->mem_base + msg_first * PAGE_SIZE;
> +	ch->rmsg = ch->smsg + msg_size / 2;
> +	ch->msg_size = msg_size;
> +	ch->complete = complete;
> +	ch->priv = priv;
> +	ch->version = se->version;
> +
> +	if (se_set_msg(ch))
> +		ch = NULL;
> +
> +out_unlock:
> +	mutex_unlock(&se->ch_init_lock);
> +
> +	return ch;
> +}
> +EXPORT_SYMBOL_GPL(se_init_ch);
> +
> +static const struct mfd_cell se_devs[] = {
> +	{ .name = "loongson-rng" },
> +	{ .name = "loongson-tpm" },
> +};
> +
> +static int loongson_se_probe(struct platform_device *pdev)

This function is totally unreadable.  I'm not even going to try, sorry.

> +{
> +	struct loongson_se *se;
> +	struct device *dev = &pdev->dev;
> +	int nr_irq, irq, err, size;
> +	dma_addr_t paddr;
> +
> +	se = devm_kmalloc(dev, sizeof(*se), GFP_KERNEL);
> +	if (!se)
> +		return -ENOMEM;
> +	dev_set_drvdata(dev, se);
> +	init_completion(&se->cmd_completion);
> +	spin_lock_init(&se->dev_lock);
> +	mutex_init(&se->ch_init_lock);
> +	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +	if (device_property_read_u32(dev, "dmam_size", &size))
> +		return -ENODEV;
> +	size = roundup_pow_of_two(size);
> +	se->mem_base = dmam_alloc_coherent(dev, size, &paddr, GFP_KERNEL);
> +	if (!se->mem_base)
> +		return -ENOMEM;
> +	se->mem_map_pages = size / PAGE_SIZE;
> +	se->mem_map = devm_bitmap_zalloc(dev, se->mem_map_pages, GFP_KERNEL);
> +	if (!se->mem_map)
> +		return -ENOMEM;
> +
> +	se->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(se->base))
> +		return PTR_ERR(se->base);
> +
> +	nr_irq = platform_irq_count(pdev);
> +	if (nr_irq <= 0)
> +		return -ENODEV;
> +	while (nr_irq) {
> +		irq = platform_get_irq(pdev, --nr_irq);
> +		/* Use the same interrupt handler address.
> +		 * Determine which irq it is accroding
> +		 * SE_S2LINT_STAT register.
> +		 */
> +		err = devm_request_irq(dev, irq, se_irq, 0, "loongson-se", se);
> +		if (err)
> +			dev_err(dev, "failed to request irq: %d\n", irq);
> +	}
> +
> +	err = se_init_hw(se, paddr, size);
> +	if (err)
> +		return err;
> +
> +	return devm_mfd_add_devices(dev, 0, se_devs, ARRAY_SIZE(se_devs),
> +				    NULL, 0, NULL);
> +}
> +
> +static const struct acpi_device_id loongson_se_acpi_match[] = {
> +	{"LOON0011", 0},

Spaces near the {}s

> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, loongson_se_acpi_match);
> +
> +static struct platform_driver loongson_se_driver = {
> +	.probe   = loongson_se_probe,
> +	.driver  = {
> +		.name  = "loongson-se",
> +		.acpi_match_table = loongson_se_acpi_match,
> +	},
> +};
> +module_platform_driver(loongson_se_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Yinggang Gu <guyinggang@loongson.cn>");
> +MODULE_AUTHOR("Qunqin Zhao <zhaoqunqin@loongson.cn>");
> +MODULE_DESCRIPTION("Loongson Security Module driver");
> diff --git a/include/linux/mfd/loongson-se.h b/include/linux/mfd/loongson-se.h
> new file mode 100644
> index 000000000..f209b7043
> --- /dev/null
> +++ b/include/linux/mfd/loongson-se.h
> @@ -0,0 +1,75 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/* Copyright (C) 2025 Loongson Technology Corporation Limited */
> +
> +#ifndef __LOONGSON_SE_H__
> +#define __LOONGSON_SE_H__
> +
> +#define SE_DATA_S			0x0
> +#define SE_DATA_L			0x20
> +#define SE_S2LINT_STAT			0x88
> +#define SE_S2LINT_EN			0x8c
> +#define SE_S2LINT_SET			0x90
> +#define SE_S2LINT_CL			0x94
> +#define SE_L2SINT_STAT			0x98
> +#define SE_L2SINT_EN			0x9c
> +#define SE_L2SINT_SET			0xa0
> +#define SE_L2SINT_CL			0xa4
> +
> +/* INT bit definition */
> +#define SE_INT_SETUP			BIT(0)
> +#define SE_INT_TPM			BIT(5)
> +
> +#define SE_CMD_START			0x0
> +#define SE_CMD_STOP			0x1
> +#define SE_CMD_GETVER			0x2
> +#define SE_CMD_SETBUF			0x3
> +#define SE_CMD_SETMSG			0x4
> +
> +#define SE_CMD_RNG			0x100
> +#define SE_CMD_SM2_SIGN			0x200
> +#define SE_CMD_SM2_VSIGN		0x201
> +#define SE_CMD_SM3_DIGEST		0x300
> +#define SE_CMD_SM3_UPDATE		0x301
> +#define SE_CMD_SM3_FINISH		0x302
> +#define SE_CMD_SM4_ECB_ENCRY		0x400
> +#define SE_CMD_SM4_ECB_DECRY		0x401
> +#define SE_CMD_SM4_CBC_ENCRY		0x402
> +#define SE_CMD_SM4_CBC_DECRY		0x403
> +#define SE_CMD_SM4_CTR			0x404
> +#define SE_CMD_TPM			0x500
> +#define SE_CMD_ZUC_INIT_READ		0x600
> +#define SE_CMD_ZUC_READ			0x601
> +#define SE_CMD_SDF			0x700
> +
> +#define SE_CH_MAX			32
> +#define SE_CH_RNG			1
> +#define SE_CH_SM2			2
> +#define SE_CH_SM3			3
> +#define SE_CH_SM4			4
> +#define SE_CH_TPM			5
> +#define SE_CH_ZUC			6
> +#define SE_CH_SDF			7
> +
> +struct se_channel {
> +	struct loongson_se *se;
> +	void *priv;
> +	u32 version;

What do you do with this information?

> +	u32 id;
> +	u32 int_bit;
> +
> +	void *smsg;
> +	void *rmsg;
> +	int msg_size;
> +
> +	void *data_buffer;
> +	int data_size;
> +	u32 off;

Most of these variables have terrible names.

So either use proper nomenclature or document them.

> +
> +	void (*complete)(struct se_channel *se_ch);

Non-subsystem-level call-backs are generally evil.

You'd need to provide a very good reason as to why nothing else works.

> +};
> +
> +struct se_channel *se_init_ch(struct device *dev, int id, int data_size, int msg_size,
> +			      void *priv, void (*complete)(struct se_channel *se_ch));
> +int se_send_ch_requeset(struct se_channel *ch);
> +
> +#endif
> -- 
> 2.45.2
> 

-- 
Lee Jones [李琼斯]

