Return-Path: <linux-integrity+bounces-5630-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00572A7D6F9
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Apr 2025 09:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FECE16C01E
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Apr 2025 07:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5693D229B18;
	Mon,  7 Apr 2025 07:55:11 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FB2228CA9;
	Mon,  7 Apr 2025 07:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744012511; cv=none; b=r/bLFXZ1A1Ke9LJlDy/q2E8EjMGpbQ+V4AUHstmiHLRv2OhGW6uCH12gZAEq5CLVaRkjpmaRQnSwwiGS1LEch+hp0bSqIdOZZAyFUijZD3B3AWJdxwxQw21ZZCdW4dpwtSWbrMRddY5CMaVpHYNK536ZX/N4oj30FYEs9CXpMZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744012511; c=relaxed/simple;
	bh=dVEeFjTcsinY6Ueg76OZNVzDcDfKQE4Umm+Iwi+hWQ8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qbfROzmSrBH9aDpbQoZgNewMao0/1SyD73GSda8I20begtQvOVGmvbycE0d2L739pn/D/DcqPJVZoEWSEopG7CaUpGPpA5js1h6oZCThirFekmEEVhOYmld8+nSH2eeuK8NGoQflUDtrW11Db4yXz/EfDBbHBkGzDBhHsgsFXG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8Ax3eLShPNnJCm0AA--.63868S3;
	Mon, 07 Apr 2025 15:54:58 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front1 (Coremail) with SMTP id qMiowMBxGcTHhPNnVyVzAA--.31730S2;
	Mon, 07 Apr 2025 15:54:50 +0800 (CST)
Subject: Re: [PATCH v7 1/6] mfd: Add support for Loongson Security Module
To: Lee Jones <lee@kernel.org>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, peterhuewe@gmx.de,
 jarkko@kernel.org, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linux-crypto@vger.kernel.org, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
 pmenzel@molgen.mpg.de, Yinggang Gu <guyinggang@loongson.cn>,
 Huacai Chen <chenhuacai@loongson.cn>
References: <20250403024645.4427-1-zhaoqunqin@loongson.cn>
 <20250403024645.4427-2-zhaoqunqin@loongson.cn>
 <20250404160610.GJ372032@google.com>
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
Message-ID: <0b605547-91da-6329-7286-cb5b0c3973c2@loongson.cn>
Date: Mon, 7 Apr 2025 15:53:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250404160610.GJ372032@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMBxGcTHhPNnVyVzAA--.31730S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9fXoW3trWfAr18AF1fAw1Uur4xXwc_yoW8Wr1rto
	WfXFn7Xa18Jr1xAr48Zr9Yqr47Z34Ygr1Yya15ZwsrC3W5t3WjkF4rXw43WF45uFW5KF4U
	Ga43JrW09FW7Cws5l-sFpf9Il3svdjkaLaAFLSUrUUUUnb8apTn2vfkv8UJUUUU8wcxFpf
	9Il3svdxBIdaVrn0xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3
	UjIYCTnIWjp_UUUO87kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI
	8IcIk0rVWrJVCq3wAFIxvE14AKwVWUXVWUAwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Cr1j6rxdM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j5o7tUUU
	UU=


Hi, Lee

在 2025/4/5 上午12:06, Lee Jones 写道:
> On Thu, 03 Apr 2025, Qunqin Zhao wrote:
>
>> This driver supports Loongson Security Module, which provides the control
>> for it's hardware encryption acceleration child devices.
>>
>> Co-developed-by: Yinggang Gu <guyinggang@loongson.cn>
>> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
>> Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
>> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
>> ---
>> v7: Moved Kconfig entry between MFD_INTEL_M10_BMC_PMCI and MFD_QNAP_MCU.
>>
>>      Renamed se_enable_int_locked() to se_enable_int(), then moved the
>>      lock out of se_disable_int().
>>
>>      "se_send_genl_cmd" ---> "se_send_cmd".
>>      "struct lsse_ch" ---> "struct se_channel".
>>      
>> v6: Replace all "ls6000se" with "loongson"
>> v5: Registered "ls6000se-rng" device.
>> v3-v4: None
>>
>> v2: Removed "ls6000se-sdf" device, added "ls6000se-tpm" device.
>>      Passed dmamem size to SE firmware in se_init_hw() function.
>>
>>   drivers/mfd/Kconfig             |  10 +
>>   drivers/mfd/Makefile            |   2 +
>>   drivers/mfd/loongson-se.c       | 374 ++++++++++++++++++++++++++++++++
>>   include/linux/mfd/loongson-se.h |  75 +++++++
>>   4 files changed, 461 insertions(+)
>>   create mode 100644 drivers/mfd/loongson-se.c
>>   create mode 100644 include/linux/mfd/loongson-se.h
>>
...
>> diff --git a/drivers/mfd/loongson-se.c b/drivers/mfd/loongson-se.c
>> new file mode 100644
>> index 000000000..4f30695de
>> --- /dev/null
>> +++ b/drivers/mfd/loongson-se.c
>> @@ -0,0 +1,374 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/* Copyright (C) 2025 Loongson Technology Corporation Limited */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/delay.h>
>> +#include <linux/device.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/errno.h>
>> +#include <linux/init.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/iopoll.h>
>> +#include <linux/kernel.h>
>> +#include <linux/mfd/core.h>
>> +#include <linux/mfd/loongson-se.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +
>> +/*
>> + * The Loongson Security Module provides the control for hardware
>> + * encryption acceleration child devices. The SE framework is
>> + * shown as follows:
>> + *
>> + *                   +------------+
>> + *                   |    CPU     |
>> + *                   +------------+
>> + *			^	^
>> + *	            DMA |	| IRQ
>> + *			v	v
>> + *        +-----------------------------------+
>> + *        |     Loongson Security Module      |
>> + *        +-----------------------------------+
>> + *             ^                ^
>> + *    channel1 |       channel2 |
>> + *             v                v
>> + *        +-----------+    +----------+
>> + *        | sub-dev1  |    | sub-dev2 |  ..... Max sub-dev31
>> + *        +-----------+    +----------+
>> + *
>> + * The CPU cannot directly communicate with SE's sub devices,
>> + * but sends commands to SE, which processes the commands and
>> + * sends them to the corresponding sub devices.
>> + */
>> +
>> +struct loongson_se {
>> +	void __iomem *base;
>> +	u32 version;
>> +	spinlock_t dev_lock;
>> +	struct completion cmd_completion;
>> +
>> +	/* dma memory */
>> +	void *mem_base;
>> +	int mem_map_pages;
>> +	unsigned long *mem_map;
>> +
>> +	/* channel */
>> +	struct mutex ch_init_lock;
>> +	struct se_channel chs[SE_CH_MAX];
>> +};
>> +
>> +union se_request {
>> +	u32 info[8];
>> +	struct se_cmd {
>> +		u32 cmd;
>> +		u32 info[7];
>> +	} req;
>> +	struct se_res {
>> +		u32 cmd;
>> +		u32 cmd_ret;
>> +		u32 info[6];
>> +	} res;
>> +};
>> +
>> +static inline u32 se_readl(struct loongson_se *se, u32 off)
>> +{
>> +	return readl(se->base + off);
>> +}
>> +
>> +static inline void se_writel(struct loongson_se *se, u32 val, u32 off)
>> +{
>> +	writel(val, se->base + off);
>> +}
> Why are these being abstracted?  Just use readl/writel directly.
Ok
>
>> +static void se_enable_int(struct loongson_se *se, u32 int_bit)
>> +{
>> +	u32 tmp;
>> +
>> +	tmp = se_readl(se, SE_S2LINT_EN);
>> +	tmp |= int_bit;
>> +	se_writel(se, tmp, SE_S2LINT_EN);
>> +}
>> +
>> +static void se_disable_int(struct loongson_se *se, u32 int_bit)
>> +{
>> +	u32 tmp;
>> +
>> +	tmp = se_readl(se, SE_S2LINT_EN);
>> +	tmp &= ~(int_bit);
>> +	se_writel(se, tmp, SE_S2LINT_EN);
>> +}
>> +
>> +static int se_poll(struct loongson_se *se, u32 int_bit)
>> +{
>> +	u32 status;
>> +	int err;
>> +
>> +	spin_lock_irq(&se->dev_lock);
>> +
>> +	se_enable_int(se, int_bit);
>> +	se_writel(se, int_bit, SE_L2SINT_SET);
>> +	err = readl_relaxed_poll_timeout_atomic(se->base + SE_L2SINT_STAT, status,
>> +						!(status & int_bit), 1, 10000);
>> +
>> +	spin_unlock_irq(&se->dev_lock);
>> +
>> +	return err;
>> +}
>> +
>> +static int se_send_requeset(struct loongson_se *se, union se_request *req)
> What's a requeset?
Request looks confusing, would it be better to call it a command package?
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(req->info); i++)
>> +		se_writel(se, req->info[i], SE_DATA_S + i * 4);
>> +
>> +	return se_poll(se, SE_INT_SETUP);
>> +}
>> +
>> +/*
>> + * Called by SE's child device driver.
>> + * Send a request to the corresponding device.
>> + */
>> +int se_send_ch_requeset(struct se_channel *ch)
>> +{
>> +	return se_poll(ch->se, ch->int_bit);
>> +}
> More pointless abstraction.  Just export se_poll()?
Ok
>
>> +EXPORT_SYMBOL_GPL(se_send_ch_requeset);
>> +
>> +static int se_get_res(struct loongson_se *se, u32 cmd, union se_request *res)
> What are we getting here?  What is a 'res'?
Response  package from the device.
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(res->info); i++)
> for (int i = 0; ...
OK
>
>> +		res->info[i] = se_readl(se, SE_DATA_L + i * 4);
>> +
>> +	if (res->res.cmd != cmd)
>> +		return -EFAULT;
>> +
>> +	return 0;
>> +}
>> +
>> +static int se_send_cmd(struct loongson_se *se, union se_request *req)
>> +{
>> +	int err;
>> +
>> +	err = se_send_requeset(se, req);
>> +	if (err)
>> +		return err;
>> +
>> +	if (!wait_for_completion_timeout(&se->cmd_completion, HZ))
>> +		return -ETIME;
> -ETIMEDOUT
OK
>
>> +
>> +	return se_get_res(se, req->req.cmd, req);
>> +}
>> +
>> +static int se_set_msg(struct se_channel *ch)
>> +{
>> +	struct loongson_se *se = ch->se;
>> +	union se_request req;
>> +
>> +	req.req.cmd = SE_CMD_SETMSG;
>> +	req.req.info[0] = ch->id;
>> +	req.req.info[1] = ch->smsg - se->mem_base;
>> +	req.req.info[2] = ch->msg_size;
>> +
>> +	return se_send_cmd(se, &req);
>> +}
>> +
>> +static irqreturn_t se_irq(int irq, void *dev_id)
> se_irq_handler()
OK
>
>> +{
>> +	struct loongson_se *se = (struct loongson_se *)dev_id;
>> +	struct se_channel *ch;
>> +	unsigned long flag;
>> +	u32 int_status;
>> +	int id;
>> +
>> +	int_status = se_readl(se, SE_S2LINT_STAT);
>> +
>> +	spin_lock_irqsave(&se->dev_lock, flag);
>> +	se_disable_int(se, int_status);
>> +	spin_unlock_irqrestore(&se->dev_lock, flag);
>> +
>> +	if (int_status & SE_INT_SETUP) {
>> +		complete(&se->cmd_completion);
>> +		int_status &= ~SE_INT_SETUP;
>> +		se_writel(se, SE_INT_SETUP, SE_S2LINT_CL);
>> +	}
>> +
>> +	while (int_status) {
>> +		id = __ffs(int_status);
>> +
>> +		ch = &se->chs[id];
>> +		if (ch->complete)
>> +			ch->complete(ch);
>> +		int_status &= ~BIT(id);
>> +		se_writel(se, BIT(id), SE_S2LINT_CL);
>> +	}
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int se_init_hw(struct loongson_se *se, dma_addr_t addr, int size)
>> +{
>> +	union se_request req;
>> +	int err;
>> +
>> +	/* Start engine */
>> +	req.req.cmd = SE_CMD_START;
>> +	err = se_send_cmd(se, &req);
>> +	if (err)
>> +		return err;
>> +
>> +	/* Get Version */
>> +	req.req.cmd = SE_CMD_GETVER;
>> +	err = se_send_cmd(se, &req);
>> +	if (err)
>> +		return err;
>> +	se->version = req.res.info[0];
>> +
>> +	/* Setup dma memory */
> DMA
OK
>
>> +	req.req.cmd = SE_CMD_SETBUF;
>> +	req.req.info[0] = addr & 0xffffffff;
>> +	req.req.info[1] = addr >> 32;
> Define these magic numbers please.
OK
>
>> +	req.req.info[2] = size;
>> +
>> +	return se_send_cmd(se, &req);
>> +}
>> +
>> +/*
>> + * se_init_ch() - Init the channel used by child device.
>> + *
>> + * Allocate dma memory as agreed upon with SE on SE probe,
> DMA, throughout please.
OK
>
>> + * and register the callback function when the data processing
>> + * in this channel is completed.
>> + */
>> +struct se_channel *se_init_ch(struct device *dev, int id, int data_size, int msg_size,
> What's a "ch"?
Channel. Sorry for this confusing abbreviation.
>
>> +			      void *priv, void (*complete)(struct se_channel *se_ch))
> I'm not entirely sure what this device is or how it works, but this
> isn't really what MFD is for.  MFD has no knowledge of channel
> initialisation or completion call-backs or the like.  What you have here
> goes beyond scope.
DMA memory used by different sub devices should better be contiguous in 
physical addresses,

so a large block of DMA memory needs to be allocated first in probe 
function,

and then each sub device allocates a small block from this large block 
of DMA memory during channel initialization.

This is why i need a channel initialization function.


>> +{
>> +	struct loongson_se *se = dev_get_drvdata(dev);
>> +	struct se_channel *ch;
>> +	int data_first, data_nr;
>> +	int msg_first, msg_nr;
>> +
>> +	mutex_lock(&se->ch_init_lock);
>> +
>> +	ch = &se->chs[id];
>> +	ch->se = se;
>> +	ch->id = id;
>> +	ch->int_bit = BIT(id);
> This can be derived from ch->id, so you don't need to store it.
>
> Or you don't need 'id' - one of the two.
Will fix.
>> +
>> +	data_nr = round_up(data_size, PAGE_SIZE) / PAGE_SIZE;
>> +	data_first = bitmap_find_next_zero_area(se->mem_map, se->mem_map_pages,
>> +						0, data_nr, 0);
>> +	if (data_first >= se->mem_map_pages) {
>> +		ch = NULL;
>> +		goto out_unlock;
>> +	}
>> +
>> +	bitmap_set(se->mem_map, data_first, data_nr);
>> +	ch->off = data_first * PAGE_SIZE;
>> +	ch->data_buffer = se->mem_base + ch->off;
>> +	ch->data_size = data_size;
>> +
>> +	msg_nr = round_up(msg_size, PAGE_SIZE) / PAGE_SIZE;
>> +	msg_first = bitmap_find_next_zero_area(se->mem_map, se->mem_map_pages,
>> +					       0, msg_nr, 0);
>> +	if (msg_first >= se->mem_map_pages) {
>> +		ch = NULL;
>> +		goto out_unlock;
>> +	}
>> +
>> +	bitmap_set(se->mem_map, msg_first, msg_nr);
>> +	ch->smsg = se->mem_base + msg_first * PAGE_SIZE;
>> +	ch->rmsg = ch->smsg + msg_size / 2;
>> +	ch->msg_size = msg_size;
>> +	ch->complete = complete;
>> +	ch->priv = priv;
>> +	ch->version = se->version;
>> +
>> +	if (se_set_msg(ch))
>> +		ch = NULL;
>> +
>> +out_unlock:
>> +	mutex_unlock(&se->ch_init_lock);
>> +
>> +	return ch;
>> +}
>> +EXPORT_SYMBOL_GPL(se_init_ch);
>> +
>> +static const struct mfd_cell se_devs[] = {
>> +	{ .name = "loongson-rng" },
>> +	{ .name = "loongson-tpm" },
>> +};
>> +
>> +static int loongson_se_probe(struct platform_device *pdev)
> This function is totally unreadable.  I'm not even going to try, sorry.
>
This function is mainly responsible for allocating a DMA memory for all 
sub devices and registering interrupt handling functions.


>> +{
>> +	struct loongson_se *se;
>> +	struct device *dev = &pdev->dev;
>> +	int nr_irq, irq, err, size;
>> +	dma_addr_t paddr;
>> +
>> +	se = devm_kmalloc(dev, sizeof(*se), GFP_KERNEL);
>> +	if (!se)
>> +		return -ENOMEM;
>> +	dev_set_drvdata(dev, se);
>> +	init_completion(&se->cmd_completion);
>> +	spin_lock_init(&se->dev_lock);
>> +	mutex_init(&se->ch_init_lock);
>> +	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
>> +	if (device_property_read_u32(dev, "dmam_size", &size))
>> +		return -ENODEV;
>> +	size = roundup_pow_of_two(size);
>> +	se->mem_base = dmam_alloc_coherent(dev, size, &paddr, GFP_KERNEL);
>> +	if (!se->mem_base)
>> +		return -ENOMEM;
>> +	se->mem_map_pages = size / PAGE_SIZE;
>> +	se->mem_map = devm_bitmap_zalloc(dev, se->mem_map_pages, GFP_KERNEL);
>> +	if (!se->mem_map)
>> +		return -ENOMEM;
>> +
>> +	se->base = devm_platform_ioremap_resource(pdev, 0);
>> +	if (IS_ERR(se->base))
>> +		return PTR_ERR(se->base);
>> +
>> +	nr_irq = platform_irq_count(pdev);
>> +	if (nr_irq <= 0)
>> +		return -ENODEV;
>> +	while (nr_irq) {
>> +		irq = platform_get_irq(pdev, --nr_irq);
>> +		/* Use the same interrupt handler address.
>> +		 * Determine which irq it is accroding
>> +		 * SE_S2LINT_STAT register.
>> +		 */
>> +		err = devm_request_irq(dev, irq, se_irq, 0, "loongson-se", se);
>> +		if (err)
>> +			dev_err(dev, "failed to request irq: %d\n", irq);
>> +	}
>> +
>> +	err = se_init_hw(se, paddr, size);
>> +	if (err)
>> +		return err;
>> +
>> +	return devm_mfd_add_devices(dev, 0, se_devs, ARRAY_SIZE(se_devs),
>> +				    NULL, 0, NULL);
>> +}
>> +
>> +static const struct acpi_device_id loongson_se_acpi_match[] = {
>> +	{"LOON0011", 0},
> Spaces near the {}s
OK
>
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(acpi, loongson_se_acpi_match);
>> +
>> +static struct platform_driver loongson_se_driver = {
>> +	.probe   = loongson_se_probe,
>> +	.driver  = {
>> +		.name  = "loongson-se",
>> +		.acpi_match_table = loongson_se_acpi_match,
>> +	},
>> +};
>> +module_platform_driver(loongson_se_driver);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Yinggang Gu <guyinggang@loongson.cn>");
>> +MODULE_AUTHOR("Qunqin Zhao <zhaoqunqin@loongson.cn>");
>> +MODULE_DESCRIPTION("Loongson Security Module driver");
>> diff --git a/include/linux/mfd/loongson-se.h b/include/linux/mfd/loongson-se.h
>> new file mode 100644
>> index 000000000..f209b7043
>> --- /dev/null
>> +++ b/include/linux/mfd/loongson-se.h
>> @@ -0,0 +1,75 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +/* Copyright (C) 2025 Loongson Technology Corporation Limited */
>> +
>> +#ifndef __LOONGSON_SE_H__
>> +#define __LOONGSON_SE_H__
>> +
>> +#define SE_DATA_S			0x0
>> +#define SE_DATA_L			0x20
>> +#define SE_S2LINT_STAT			0x88
>> +#define SE_S2LINT_EN			0x8c
>> +#define SE_S2LINT_SET			0x90
>> +#define SE_S2LINT_CL			0x94
>> +#define SE_L2SINT_STAT			0x98
>> +#define SE_L2SINT_EN			0x9c
>> +#define SE_L2SINT_SET			0xa0
>> +#define SE_L2SINT_CL			0xa4
>> +
>> +/* INT bit definition */
>> +#define SE_INT_SETUP			BIT(0)
>> +#define SE_INT_TPM			BIT(5)
>> +
>> +#define SE_CMD_START			0x0
>> +#define SE_CMD_STOP			0x1
>> +#define SE_CMD_GETVER			0x2
>> +#define SE_CMD_SETBUF			0x3
>> +#define SE_CMD_SETMSG			0x4
>> +
>> +#define SE_CMD_RNG			0x100
>> +#define SE_CMD_SM2_SIGN			0x200
>> +#define SE_CMD_SM2_VSIGN		0x201
>> +#define SE_CMD_SM3_DIGEST		0x300
>> +#define SE_CMD_SM3_UPDATE		0x301
>> +#define SE_CMD_SM3_FINISH		0x302
>> +#define SE_CMD_SM4_ECB_ENCRY		0x400
>> +#define SE_CMD_SM4_ECB_DECRY		0x401
>> +#define SE_CMD_SM4_CBC_ENCRY		0x402
>> +#define SE_CMD_SM4_CBC_DECRY		0x403
>> +#define SE_CMD_SM4_CTR			0x404
>> +#define SE_CMD_TPM			0x500
>> +#define SE_CMD_ZUC_INIT_READ		0x600
>> +#define SE_CMD_ZUC_READ			0x601
>> +#define SE_CMD_SDF			0x700
>> +
>> +#define SE_CH_MAX			32
>> +#define SE_CH_RNG			1
>> +#define SE_CH_SM2			2
>> +#define SE_CH_SM3			3
>> +#define SE_CH_SM4			4
>> +#define SE_CH_TPM			5
>> +#define SE_CH_ZUC			6
>> +#define SE_CH_SDF			7
>> +
>> +struct se_channel {
>> +	struct loongson_se *se;
>> +	void *priv;
>> +	u32 version;
> What do you do with this information?
Will remove it.
>
>> +	u32 id;
>> +	u32 int_bit;
>> +
>> +	void *smsg;
>> +	void *rmsg;
>> +	int msg_size;
>> +
>> +	void *data_buffer;
>> +	int data_size;
>> +	u32 off;
> Most of these variables have terrible names.
>
> So either use proper nomenclature or document them.
OK.
>
>> +
>> +	void (*complete)(struct se_channel *se_ch);
> Non-subsystem-level call-backs are generally evil.
>
> You'd need to provide a very good reason as to why nothing else works.

How about remove the callback,  but define a "struct completion" in 
struct se_channel?

Thanks for your comments.

BR, Qunqin.

>
>> +};
>> +
>> +struct se_channel *se_init_ch(struct device *dev, int id, int data_size, int msg_size,
>> +			      void *priv, void (*complete)(struct se_channel *se_ch));
>> +int se_send_ch_requeset(struct se_channel *ch);
>> +
>> +#endif
>> -- 
>> 2.45.2
>>


