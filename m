Return-Path: <linux-integrity+bounces-6298-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85871AC0D22
	for <lists+linux-integrity@lfdr.de>; Thu, 22 May 2025 15:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E4A44E5D58
	for <lists+linux-integrity@lfdr.de>; Thu, 22 May 2025 13:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77841F94D;
	Thu, 22 May 2025 13:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LAoZdNJd"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CDE7E1;
	Thu, 22 May 2025 13:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747921606; cv=none; b=lagWjqRsN7/Jk1zzVww19XeV1+XFn7nhhatg1P1l6Wdh30T9afbglqTqch+UJtICNFfa/8XCHxq2GjCCEg4pEwDygEV6jcv/lIgM7DQQ7NFk4dQvLJXgOEtTwOxBCi8tyVDZ/duZE0ZRUqnfC+2RttwBjkD825phYamhyFVxIes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747921606; c=relaxed/simple;
	bh=6n4oHSCwmcszP/Pvx81zU+SzSpJl4P/QrDy57P+fj0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sob7iV1RF3KY31GlLOAZ8woyZNgJmJGefY437PTgqohdJr8dl+qlfAkKLmx2/RR6qJCgasCFwzanq7br65M/Da7oE8Ot3FUYJbz28V+rhAUEvGLOHlTolE6MYu5qVcH5818Gd3YxLgkZsKevzmQZqeGQdMv9nLuLVBYSkzThzKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAoZdNJd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF9CC4CEE4;
	Thu, 22 May 2025 13:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747921605;
	bh=6n4oHSCwmcszP/Pvx81zU+SzSpJl4P/QrDy57P+fj0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LAoZdNJdbMA7katxxLi3eD0TxqovYFlXcgoUPUB7yMcNEbdfTpBAOC8SnLW/PFZ+T
	 JQ/gyVyoVTdwz6gZFoH+O4AklTQ+57HLZv0Xmw3jWGXYRAjkPs1HnHISiovBBrmofK
	 afWUmZIS8jxsSgjaUgwmNuvgHyJpSclPw1Jtv3yGKzsCkDLPcigFdqadfTx3qu8po2
	 R6ujOkhNX8iuZcH/iY99OIGciJmJ87USWepCTG/mP/y8iA/q89JJdzJ9hfCzytiZwR
	 v8kf1/viWnTfRb22Ba7Gmnc6zBkRL/fnUsSLjESMUbo9Z003ExL1pxyDI1/EDrB2u8
	 OpvrTJZB7tUoQ==
Date: Thu, 22 May 2025 14:46:39 +0100
From: Lee Jones <lee@kernel.org>
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, peterhuewe@gmx.de,
	jarkko@kernel.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-crypto@vger.kernel.org,
	jgg@ziepe.ca, linux-integrity@vger.kernel.org,
	pmenzel@molgen.mpg.de, Yinggang Gu <guyinggang@loongson.cn>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH v9 1/5] mfd: Add support for Loongson Security Engine
 chip controller
Message-ID: <20250522134639.GE1199143@google.com>
References: <20250506031947.11130-1-zhaoqunqin@loongson.cn>
 <20250506031947.11130-2-zhaoqunqin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250506031947.11130-2-zhaoqunqin@loongson.cn>

On Tue, 06 May 2025, Qunqin Zhao wrote:

> Loongson Security Engine chip supports RNG, SM2, SM3 and SM4 accelerator
> engines. This is the base driver for other specific engine drivers.
> 
> Co-developed-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
> v8: As explained in the cover letter, moved this driver form MFD to here.
>     Cleanned up coding style. Added some comments. Divided DMA memory
>     equally among all engines.
> 
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
>  drivers/mfd/Kconfig             |  11 ++
>  drivers/mfd/Makefile            |   2 +
>  drivers/mfd/loongson-se.c       | 235 ++++++++++++++++++++++++++++++++
>  include/linux/mfd/loongson-se.h |  52 +++++++
>  4 files changed, 300 insertions(+)
>  create mode 100644 drivers/mfd/loongson-se.c
>  create mode 100644 include/linux/mfd/loongson-se.h

General premise seems okay.

Couple of questions and styling / readability issues.

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 22b936310..c2f94b315 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -2369,6 +2369,17 @@ config MFD_INTEL_M10_BMC_PMCI
>  	  additional drivers must be enabled in order to use the functionality
>  	  of the device.
>  
> +config MFD_LOONGSON_SE
> +	tristate "Loongson Security Engine chip controller driver"
> +	depends on LOONGARCH && ACPI
> +	select MFD_CORE
> +	help
> +	  The Loongson Security Engine chip supports RNG, SM2, SM3 and
> +	  SM4 accelerator engines. Each engine have its own DMA buffer
> +	  provided by the controller. The kernel cannot directly send
> +	  commands to the engine and must first send them to the controller,
> +	  which will forward them to the corresponding engine.
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
> index 000000000..ce38d8221
> --- /dev/null
> +++ b/drivers/mfd/loongson-se.c
> @@ -0,0 +1,235 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Copyright (C) 2025 Loongson Technology Corporation Limited */

Author(s)?

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
> +struct loongson_se {
> +	void __iomem *base;
> +	spinlock_t dev_lock;
> +	struct completion cmd_completion;
> +
> +	void *dmam_base;
> +	int dmam_size;
> +
> +	struct mutex engine_init_lock;
> +	struct loongson_se_engine engines[SE_ENGINE_MAX];
> +};
> +
> +struct loongson_se_controller_cmd {
> +	u32 command_id;
> +	u32 info[7];
> +};
> +
> +static int loongson_se_poll(struct loongson_se *se, u32 int_bit)
> +{
> +	u32 status;
> +	int err;
> +
> +	spin_lock_irq(&se->dev_lock);
> +
> +	/* Notify the controller that the engine needs to be started */
> +	writel(int_bit, se->base + SE_L2SINT_SET);

Code that is squished together is difficult to read.

'\n'

> +	/* Polling until the controller has forwarded the engine command */
> +	err = readl_relaxed_poll_timeout_atomic(se->base + SE_L2SINT_STAT, status,
> +						!(status & int_bit), 1, 10000);

How long is that?  Why was that number chosen?

Please define the type, like:

LOONSON_ENGINE_CMD_TIMEOUT_MS 10000

... or whatever it is.

> +	spin_unlock_irq(&se->dev_lock);
> +
> +	return err;
> +}
> +
> +static int loongson_se_send_controller_cmd(struct loongson_se *se,
> +					   struct loongson_se_controller_cmd *cmd)
> +{
> +	u32 *send_cmd = (u32 *)cmd;
> +	int err, i;
> +
> +	for (i = 0; i < SE_SEND_CMD_REG_LEN; i++)
> +		writel(send_cmd[i], se->base + SE_SEND_CMD_REG + i * 4);

Is there any reason not to use regmap?

> +	err = loongson_se_poll(se, SE_INT_CONTROLLER);
> +	if (err)
> +		return err;
> +
> +	return wait_for_completion_interruptible(&se->cmd_completion);
> +}
> +
> +int loongson_se_send_engine_cmd(struct loongson_se_engine *engine)
> +{
> +	/* After engine initialization, the controller already knows
> +	 * where to obtain engine commands from. Now all we need to
> +	 * do is notify the controller that the engine needs to be started.
> +	 */

This is not a proper multi-line comment as per Coding Style.

> +	int err = loongson_se_poll(engine->se, BIT(engine->id));
> +
> +	if (err)
> +		return err;
> +
> +	return wait_for_completion_interruptible(&engine->completion);
> +}
> +EXPORT_SYMBOL_GPL(loongson_se_send_engine_cmd);
> +
> +struct loongson_se_engine *loongson_se_init_engine(struct device *dev, int id)

What calls this?  Whose 'dev' is that?

> +{
> +	struct loongson_se *se = dev_get_drvdata(dev);
> +	struct loongson_se_engine *engine = &se->engines[id];
> +	struct loongson_se_controller_cmd cmd;
> +
> +	engine->se = se;
> +	engine->id = id;
> +	init_completion(&engine->completion);
> +
> +	/* Divide DMA memory equally among all engines */
> +	engine->buffer_size = se->dmam_size / SE_ENGINE_MAX;
> +	engine->buffer_off = (se->dmam_size / SE_ENGINE_MAX) * id;
> +	engine->data_buffer = se->dmam_base + engine->buffer_off;
> +
> +	/*
> +	 * There has no engine0, use its data buffer as command buffer for other
> +	 * engines. The DMA memory size is obtained from the ACPI table, which
> +	 * ensures that the data buffer size of engine0 is larger than the
> +	 * command buffer size of all engines.
> +	 */
> +	engine->command = se->dmam_base + id * (2 * SE_ENGINE_CMD_SIZE);

Why 2?

> +	engine->command_ret = engine->command + SE_ENGINE_CMD_SIZE;
> +
> +	mutex_lock(&se->engine_init_lock);

'\n'

> +	/* Tell the controller where to find engine command */
> +	cmd.command_id = SE_CMD_SET_ENGINE_CMDBUF;
> +	cmd.info[0] = id;
> +	cmd.info[1] = engine->command - se->dmam_base;
> +	cmd.info[2] = 2 * SE_ENGINE_CMD_SIZE;

'\n'

> +	if (loongson_se_send_controller_cmd(se, &cmd))
> +		engine = NULL;

'\n'

> +	mutex_unlock(&se->engine_init_lock);
> +
> +	return engine;
> +}
> +EXPORT_SYMBOL_GPL(loongson_se_init_engine);
> +
> +static irqreturn_t se_irq_handler(int irq, void *dev_id)
> +{
> +	struct loongson_se *se = dev_id;
> +	u32 int_status;
> +	int id;
> +
> +	spin_lock(&se->dev_lock);
> +
> +	int_status = readl(se->base + SE_S2LINT_STAT);

'\n'

> +	/* For controller */
> +	if (int_status & SE_INT_CONTROLLER) {
> +		complete(&se->cmd_completion);
> +		int_status &= ~SE_INT_CONTROLLER;
> +		writel(SE_INT_CONTROLLER, se->base + SE_S2LINT_CL);
> +	}

'\n'

> +	/* For engines */
> +	while (int_status) {
> +		id = __ffs(int_status);
> +		complete(&se->engines[id].completion);
> +		int_status &= ~BIT(id);
> +		writel(BIT(id), se->base + SE_S2LINT_CL);
> +	}
> +
> +	spin_unlock(&se->dev_lock);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int loongson_se_init(struct loongson_se *se, dma_addr_t addr, int size)
> +{
> +	struct loongson_se_controller_cmd cmd;
> +	int err;
> +
> +	cmd.command_id = SE_CMD_START;
> +	err = loongson_se_send_controller_cmd(se, &cmd);
> +	if (err)
> +		return err;
> +
> +	cmd.command_id = SE_CMD_SET_DMA;
> +	cmd.info[0] = lower_32_bits(addr);
> +	cmd.info[1] = upper_32_bits(addr);
> +	cmd.info[2] = size;
> +
> +	return loongson_se_send_controller_cmd(se, &cmd);
> +}
> +
> +static const struct mfd_cell engines[] = {
> +	{ .name = "loongson-rng" },
> +	{ .name = "loongson-tpm" },
> +};
> +
> +static int loongson_se_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct loongson_se *se;
> +	int nr_irq, irq, err;
> +	dma_addr_t paddr;
> +
> +	se = devm_kmalloc(dev, sizeof(*se), GFP_KERNEL);
> +	if (!se)
> +		return -ENOMEM;

'\n'

> +	dev_set_drvdata(dev, se);
> +	init_completion(&se->cmd_completion);
> +	spin_lock_init(&se->dev_lock);
> +	mutex_init(&se->engine_init_lock);
> +
> +	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +	if (device_property_read_u32(dev, "dmam_size", &se->dmam_size))
> +		return -ENODEV;

'\n'

> +	se->dmam_base = dmam_alloc_coherent(dev, se->dmam_size, &paddr, GFP_KERNEL);
> +	if (!se->dmam_base)
> +		return -ENOMEM;
> +
> +	se->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(se->base))
> +		return PTR_ERR(se->base);

'\n'

> +	writel(SE_INT_ALL, se->base + SE_S2LINT_EN);
> +
> +	nr_irq = platform_irq_count(pdev);
> +	if (nr_irq <= 0)
> +		return -ENODEV;

'\n'

> +	while (nr_irq) {
> +		irq = platform_get_irq(pdev, --nr_irq);

Do the decrement separately at the end of the statement, not hidden here.

Or, probably better still, use a for() loop.

> +		err = devm_request_irq(dev, irq, se_irq_handler, 0, "loongson-se", se);
> +		if (err)
> +			dev_err(dev, "failed to request irq: %d\n", irq);

IRQ

> +	}
> +
> +	err = loongson_se_init(se, paddr, se->dmam_size);
> +	if (err)
> +		return err;
> +
> +	return devm_mfd_add_devices(dev, 0, engines, ARRAY_SIZE(engines), NULL, 0, NULL);

Why 0?

> +}
> +
> +static const struct acpi_device_id loongson_se_acpi_match[] = {
> +	{"LOON0011", 0},

There should be spaces after the '{' and before the '}'.

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
> +MODULE_DESCRIPTION("Loongson Security Engine chip controller driver");
> diff --git a/include/linux/mfd/loongson-se.h b/include/linux/mfd/loongson-se.h
> new file mode 100644
> index 000000000..f962d6143
> --- /dev/null
> +++ b/include/linux/mfd/loongson-se.h
> @@ -0,0 +1,52 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/* Copyright (C) 2025 Loongson Technology Corporation Limited */
> +
> +#ifndef __LOONGSON_SE_H__
> +#define __LOONGSON_SE_H__

__MFD_*

> +#define SE_SEND_CMD_REG			0x0
> +#define SE_SEND_CMD_REG_LEN		0x8
> +/* controller command id */

Uppercase char to start comments.

"ID"

> +#define SE_CMD_START			0x0
> +#define SE_CMD_SET_DMA			0x3
> +#define SE_CMD_SET_ENGINE_CMDBUF	0x4
> +
> +#define SE_S2LINT_STAT			0x88
> +#define SE_S2LINT_EN			0x8c
> +#define SE_S2LINT_CL			0x94
> +#define SE_L2SINT_STAT			0x98
> +#define SE_L2SINT_SET			0xa0
> +
> +#define SE_INT_ALL			0xffffffff
> +#define SE_INT_CONTROLLER		BIT(0)
> +
> +#define SE_ENGINE_MAX			16
> +#define SE_ENGINE_RNG			1
> +#define SE_CMD_RNG			0x100
> +
> +#define SE_ENGINE_TPM			5
> +#define SE_CMD_TPM			0x500
> +
> +#define SE_ENGINE_CMD_SIZE		32
> +
> +struct loongson_se_engine {
> +	struct loongson_se *se;
> +	int id;
> +
> +	/* Command buffer */
> +	void *command;
> +	void *command_ret;
> +
> +	void *data_buffer;
> +	uint buffer_size;
> +	/* Data buffer offset to DMA base */
> +	uint buffer_off;
> +
> +	struct completion completion;
> +
> +};
> +
> +struct loongson_se_engine *loongson_se_init_engine(struct device *dev, int id);
> +int loongson_se_send_engine_cmd(struct loongson_se_engine *engine);
> +
> +#endif
> -- 
> 2.45.2
> 

-- 
Lee Jones [李琼斯]

