Return-Path: <linux-integrity+bounces-6306-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15569AC37F9
	for <lists+linux-integrity@lfdr.de>; Mon, 26 May 2025 04:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83DC51892968
	for <lists+linux-integrity@lfdr.de>; Mon, 26 May 2025 02:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736937260F;
	Mon, 26 May 2025 02:27:53 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E89A81741;
	Mon, 26 May 2025 02:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748226473; cv=none; b=C1U+W3AQhKpjwfL6BEFEbMzbHRNrGYVW3GOkMY9NF3nc0H+AAPtdUaUzbWkBPXJOm1ItqWzvtjq38xRy6zwb5hfxsxhQcRU5D4OKRjtnjSCeoOvLVP8a0O6EOoBAC2fuzFeWVkHpFTMuEriS7z01DI0Ik6LqBnPAx5nYSCJfrFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748226473; c=relaxed/simple;
	bh=GzCIxrSTTFTjZ59GGef0Q7fMKxM9QYneDXY/MpgKU48=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=B8Zg7rMMGcbVbcQfRwbD71AQGBSWSQ2ky1IPWbFwGzonAReMIGt20WKdi5MR9q83epI8EWowEeVQJIqs8lzpxDCgJxFTUW8FzbfYVZfWsqY5ZzeWWXRpoN4793P5S+KgrggmnwKN8bogAGP9bCWL6/+/xEfxFU557eMPMVMdZ+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8BxIK+b0TNoA1D8AA--.11387S3;
	Mon, 26 May 2025 10:27:39 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front1 (Coremail) with SMTP id qMiowMDxuhqW0TNorKvxAA--.25998S2;
	Mon, 26 May 2025 10:27:37 +0800 (CST)
Subject: Re: [PATCH v9 1/5] mfd: Add support for Loongson Security Engine chip
 controller
To: Lee Jones <lee@kernel.org>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, peterhuewe@gmx.de,
 jarkko@kernel.org, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linux-crypto@vger.kernel.org, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
 pmenzel@molgen.mpg.de, Yinggang Gu <guyinggang@loongson.cn>,
 Huacai Chen <chenhuacai@loongson.cn>
References: <20250506031947.11130-1-zhaoqunqin@loongson.cn>
 <20250506031947.11130-2-zhaoqunqin@loongson.cn>
 <20250522134639.GE1199143@google.com>
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
Message-ID: <80165218-1295-b028-f77c-6924d572434e@loongson.cn>
Date: Mon, 26 May 2025 10:26:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250522134639.GE1199143@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMDxuhqW0TNorKvxAA--.25998S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxKF18ArW3Kw4xuw45urWDWrX_yoWftFW5pF
	4UCay5Cr4DAr17CwnxXrZ8uFyav395Jry2ka9Fqa40yr9Fy3s2qry5KFyrurZ7ArsrGF1j
	vFWkGFZ3uF1rG3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j5o7tUUU
	UU=


在 2025/5/22 下午9:46, Lee Jones 写道:
> On Tue, 06 May 2025, Qunqin Zhao wrote:
>
>> Loongson Security Engine chip supports RNG, SM2, SM3 and SM4 accelerator
>> engines. This is the base driver for other specific engine drivers.
>>
>> Co-developed-by: Yinggang Gu <guyinggang@loongson.cn>
>> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
>> Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
>> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
>> ---
>> v8: As explained in the cover letter, moved this driver form MFD to here.
>>      Cleanned up coding style. Added some comments. Divided DMA memory
>>      equally among all engines.
>>
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
>>   drivers/mfd/Kconfig             |  11 ++
>>   drivers/mfd/Makefile            |   2 +
>>   drivers/mfd/loongson-se.c       | 235 ++++++++++++++++++++++++++++++++
>>   include/linux/mfd/loongson-se.h |  52 +++++++
>>   4 files changed, 300 insertions(+)
>>   create mode 100644 drivers/mfd/loongson-se.c
>>   create mode 100644 include/linux/mfd/loongson-se.h
> General premise seems okay.
>
> Couple of questions and styling / readability issues.
>
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index 22b936310..c2f94b315 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -2369,6 +2369,17 @@ config MFD_INTEL_M10_BMC_PMCI
>>   	  additional drivers must be enabled in order to use the functionality
>>   	  of the device.
>>   
>> +config MFD_LOONGSON_SE
>> +	tristate "Loongson Security Engine chip controller driver"
>> +	depends on LOONGARCH && ACPI
>> +	select MFD_CORE
>> +	help
>> +	  The Loongson Security Engine chip supports RNG, SM2, SM3 and
>> +	  SM4 accelerator engines. Each engine have its own DMA buffer
>> +	  provided by the controller. The kernel cannot directly send
>> +	  commands to the engine and must first send them to the controller,
>> +	  which will forward them to the corresponding engine.
>> +
>>   config MFD_QNAP_MCU
>>   	tristate "QNAP microcontroller unit core driver"
>>   	depends on SERIAL_DEV_BUS
>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>> index 948cbdf42..fc50601ca 100644
>> --- a/drivers/mfd/Makefile
>> +++ b/drivers/mfd/Makefile
>> @@ -290,3 +290,5 @@ obj-$(CONFIG_MFD_RSMU_I2C)	+= rsmu_i2c.o rsmu_core.o
>>   obj-$(CONFIG_MFD_RSMU_SPI)	+= rsmu_spi.o rsmu_core.o
>>   
>>   obj-$(CONFIG_MFD_UPBOARD_FPGA)	+= upboard-fpga.o
>> +
>> +obj-$(CONFIG_MFD_LOONGSON_SE)	+= loongson-se.o
>> diff --git a/drivers/mfd/loongson-se.c b/drivers/mfd/loongson-se.c
>> new file mode 100644
>> index 000000000..ce38d8221
>> --- /dev/null
>> +++ b/drivers/mfd/loongson-se.c
>> @@ -0,0 +1,235 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/* Copyright (C) 2025 Loongson Technology Corporation Limited */
> Author(s)?
Will add
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
>> +struct loongson_se {
>> +	void __iomem *base;
>> +	spinlock_t dev_lock;
>> +	struct completion cmd_completion;
>> +
>> +	void *dmam_base;
>> +	int dmam_size;
>> +
>> +	struct mutex engine_init_lock;
>> +	struct loongson_se_engine engines[SE_ENGINE_MAX];
>> +};
>> +
>> +struct loongson_se_controller_cmd {
>> +	u32 command_id;
>> +	u32 info[7];
>> +};
>> +
>> +static int loongson_se_poll(struct loongson_se *se, u32 int_bit)
>> +{
>> +	u32 status;
>> +	int err;
>> +
>> +	spin_lock_irq(&se->dev_lock);
>> +
>> +	/* Notify the controller that the engine needs to be started */
>> +	writel(int_bit, se->base + SE_L2SINT_SET);
> Code that is squished together is difficult to read.
>
> '\n'
All '\n' will fix
>> +	/* Polling until the controller has forwarded the engine command */
>> +	err = readl_relaxed_poll_timeout_atomic(se->base + SE_L2SINT_STAT, status,
>> +						!(status & int_bit), 1, 10000);
> How long is that?  Why was that number chosen?
In theory, the hardware will clear int_bit within 10ms.
> Please define the type, like:
>
> LOONSON_ENGINE_CMD_TIMEOUT_MS 10000

Will do this.  But  this should be us.

LOONSON_ENGINE_CMD_TIMEOUT_US 10000

>
> ... or whatever it is.
>
>> +	spin_unlock_irq(&se->dev_lock);
>> +
>> +	return err;
>> +}
>> +
>> +static int loongson_se_send_controller_cmd(struct loongson_se *se,
>> +					   struct loongson_se_controller_cmd *cmd)
>> +{
>> +	u32 *send_cmd = (u32 *)cmd;
>> +	int err, i;
>> +
>> +	for (i = 0; i < SE_SEND_CMD_REG_LEN; i++)
>> +		writel(send_cmd[i], se->base + SE_SEND_CMD_REG + i * 4);
> Is there any reason not to use regmap?

I'm not familiar with regmap, readl/writel is fine for me.

If regmap is necessary, I will try using it.

>> +	err = loongson_se_poll(se, SE_INT_CONTROLLER);
>> +	if (err)
>> +		return err;
>> +
>> +	return wait_for_completion_interruptible(&se->cmd_completion);
>> +}
>> +
>> +int loongson_se_send_engine_cmd(struct loongson_se_engine *engine)
>> +{
>> +	/* After engine initialization, the controller already knows
>> +	 * where to obtain engine commands from. Now all we need to
>> +	 * do is notify the controller that the engine needs to be started.
>> +	 */
> This is not a proper multi-line comment as per Coding Style.
Will fix
>
>> +	int err = loongson_se_poll(engine->se, BIT(engine->id));
>> +
>> +	if (err)
>> +		return err;
>> +
>> +	return wait_for_completion_interruptible(&engine->completion);
>> +}
>> +EXPORT_SYMBOL_GPL(loongson_se_send_engine_cmd);
>> +
>> +struct loongson_se_engine *loongson_se_init_engine(struct device *dev, int id)
> What calls this?  Whose 'dev' is that?

Child device driver would call this, like "loongson-tpm" and "loongson-rng".

   "dev" is  the device we probed in "loongson_se_probe".

>
>> +{
>> +	struct loongson_se *se = dev_get_drvdata(dev);
>> +	struct loongson_se_engine *engine = &se->engines[id];
>> +	struct loongson_se_controller_cmd cmd;
>> +
>> +	engine->se = se;
>> +	engine->id = id;
>> +	init_completion(&engine->completion);
>> +
>> +	/* Divide DMA memory equally among all engines */
>> +	engine->buffer_size = se->dmam_size / SE_ENGINE_MAX;
>> +	engine->buffer_off = (se->dmam_size / SE_ENGINE_MAX) * id;
>> +	engine->data_buffer = se->dmam_base + engine->buffer_off;
>> +
>> +	/*
>> +	 * There has no engine0, use its data buffer as command buffer for other
>> +	 * engines. The DMA memory size is obtained from the ACPI table, which
>> +	 * ensures that the data buffer size of engine0 is larger than the
>> +	 * command buffer size of all engines.
>> +	 */
>> +	engine->command = se->dmam_base + id * (2 * SE_ENGINE_CMD_SIZE);
> Why 2?
One for engine->command, another for engine->command_ret.
>> +	engine->command_ret = engine->command + SE_ENGINE_CMD_SIZE;
>> +
>> +	mutex_lock(&se->engine_init_lock);
>
....
>> +	while (nr_irq) {
>> +		irq = platform_get_irq(pdev, --nr_irq);
> Do the decrement separately at the end of the statement, not hidden here.
>
> Or, probably better still, use a for() loop.
Will use a for() loop
>
>> +		err = devm_request_irq(dev, irq, se_irq_handler, 0, "loongson-se", se);
>> +		if (err)
>> +			dev_err(dev, "failed to request irq: %d\n", irq);
> IRQ
Will fix
>
>> +	}
>> +
>> +	err = loongson_se_init(se, paddr, se->dmam_size);
>> +	if (err)
>> +		return err;
>> +
>> +	return devm_mfd_add_devices(dev, 0, engines, ARRAY_SIZE(engines), NULL, 0, NULL);
> Why 0?
Next revision:

return devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE, engines, ARRAY_SIZE(engines), NULL, 0, NULL);

>
>> +}
>> +
>> +static const struct acpi_device_id loongson_se_acpi_match[] = {
>> +	{"LOON0011", 0},
> There should be spaces after the '{' and before the '}'.
Sorry, Will fix
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
>> +MODULE_DESCRIPTION("Loongson Security Engine chip controller driver");
>> diff --git a/include/linux/mfd/loongson-se.h b/include/linux/mfd/loongson-se.h
>> new file mode 100644
>> index 000000000..f962d6143
>> --- /dev/null
>> +++ b/include/linux/mfd/loongson-se.h
>> @@ -0,0 +1,52 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +/* Copyright (C) 2025 Loongson Technology Corporation Limited */
>> +
>> +#ifndef __LOONGSON_SE_H__
>> +#define __LOONGSON_SE_H__
> __MFD_*
Will fix
>
>> +#define SE_SEND_CMD_REG			0x0
>> +#define SE_SEND_CMD_REG_LEN		0x8
>> +/* controller command id */
> Uppercase char to start comments.
>
> "ID"

Will fix


Thanks,

Qunqin.


