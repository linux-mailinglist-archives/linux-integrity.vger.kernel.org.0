Return-Path: <linux-integrity+bounces-6736-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BDEB12962
	for <lists+linux-integrity@lfdr.de>; Sat, 26 Jul 2025 09:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5803E1C829F4
	for <lists+linux-integrity@lfdr.de>; Sat, 26 Jul 2025 07:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3A9200132;
	Sat, 26 Jul 2025 07:05:57 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0C12E36F9;
	Sat, 26 Jul 2025 07:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753513557; cv=none; b=fg4JQu5QcBiW40FwE1+i7Jf82MvtL2NhB+H0Akcq2LYWnm/OENGuMxj/4cnY0KU6chnLz2DpPM0kQFTuzeshHVLHBTnHVzLLndhTHiNcOX2YIW01qJNGBLqIb5/w+CKE3R4VZCVk6Wx3LBit7UNLN1keKBZ7EJ1aqggRASB4jGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753513557; c=relaxed/simple;
	bh=iMLOG1TLsp617YE0ZKwoqjSE4WMgddafpxWT/XuYUAw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Ra9q0l4pBradNwgxSeuy97Wc1OTH28P+6zCVSRELmXV8unUlXqv2E/lgstfzH9D615XPIf82IX9EWVPorzsdxVb0M8Is9r3crEwo+2TLqX2ci86jLD+AiWWiCplRza92k0O+oSSS6kp5FdDRoVtOMatmBkJbZKo+/XGr4JRbK98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8CxNHBIfoRoymcyAQ--.35492S3;
	Sat, 26 Jul 2025 15:05:44 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front1 (Coremail) with SMTP id qMiowJCxrsNEfoRo8IcnAA--.23180S2;
	Sat, 26 Jul 2025 15:05:43 +0800 (CST)
Subject: Re: [PATCH v12 3/4] tpm: Add a driver for Loongson TPM device
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: lee@kernel.org, herbert@gondor.apana.org.au, jarkko@kernel.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 davem@davemloft.net, linux-crypto@vger.kernel.org, peterhuewe@gmx.de,
 jgg@ziepe.ca, linux-integrity@vger.kernel.org,
 Yinggang Gu <guyinggang@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>
References: <20250705072045.1067-1-zhaoqunqin@loongson.cn>
 <20250705072045.1067-4-zhaoqunqin@loongson.cn>
 <4uhbqaq6obk626r6dk27opaksuwezizx5bpq4eacqjogrdk6as@sinmwzhfjrsn>
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
Message-ID: <322d4564-b188-64b9-13b3-7a91d3887643@loongson.cn>
Date: Sat, 26 Jul 2025 15:05:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4uhbqaq6obk626r6dk27opaksuwezizx5bpq4eacqjogrdk6as@sinmwzhfjrsn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowJCxrsNEfoRo8IcnAA--.23180S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW3XF1rWr4kWw1UtF4ktFW7WrX_yoWfJrW7pF
	Z5AayUCrW5Jr18Grs8trW5ZFy3ZryrJa4DKan7Xa47AF1qyw1FgryUXrnFgr47Ar4kGr1j
	qrWkWrs7uF15urXCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
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


在 2025/7/7 下午5:48, Stefano Garzarella 写道:
> On Sat, Jul 05, 2025 at 03:20:44PM +0800, Qunqin Zhao wrote:
>> Loongson Security Engine supports random number generation, hash,
>> symmetric encryption and asymmetric encryption. Based on these
>> encryption functions, TPM2 have been implemented in the Loongson
>> Security Engine firmware. This driver is responsible for copying data
>> into the memory visible to the firmware and receiving data from the
>> firmware.
>>
>> Co-developed-by: Yinggang Gu <guyinggang@loongson.cn>
>> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
>> Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
>> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
>> ---
>> drivers/char/tpm/Kconfig        |  9 ++++
>> drivers/char/tpm/Makefile       |  1 +
>> drivers/char/tpm/tpm_loongson.c | 84 +++++++++++++++++++++++++++++++++
>> 3 files changed, 94 insertions(+)
>> create mode 100644 drivers/char/tpm/tpm_loongson.c
>
> TPM_CHIP_FLAG_SYNC support is now merged in linux-tpmdd/next tree, so 
> IMHO this driver can also set it and implement a synchronous send() in 
> this way (untested):
>
> diff --git a/drivers/char/tpm/tpm_loongson.c 
> b/drivers/char/tpm/tpm_loongson.c

Thank you very much, but I prefer send()+recv().

Qunqin.

> index a4ec23639911..0e8eb8cee13c 100644
> --- a/drivers/char/tpm/tpm_loongson.c
> +++ b/drivers/char/tpm/tpm_loongson.c
> @@ -15,36 +15,35 @@ struct tpm_loongson_cmd {
>      u32 pad[5];
>  };
>
> -static int tpm_loongson_recv(struct tpm_chip *chip, u8 *buf, size_t 
> count)
> +static int tpm_loongson_send(struct tpm_chip *chip, u8 *buf, size_t 
> bufsiz,
> +                 size_t cmd_len)
>  {
>      struct loongson_se_engine *tpm_engine = dev_get_drvdata(&chip->dev);
> -    struct tpm_loongson_cmd *cmd_ret = tpm_engine->command_ret;
> -
> -    if (cmd_ret->data_len > count)
> -        return -EIO;
> +    struct tpm_loongson_cmd *cmd = tpm_engine->command;
> +    struct tpm_loongson_cmd *cmd_ret;
> +    int ret;
>
> -    memcpy(buf, tpm_engine->data_buffer, cmd_ret->data_len);
> +    if (cmd_len > tpm_engine->buffer_size)
> +        return -E2BIG;
>
> -    return cmd_ret->data_len;
> -}
> +    cmd->data_len = cmd_len;
> +    memcpy(tpm_engine->data_buffer, buf, cmd_len);
>
> -static int tpm_loongson_send(struct tpm_chip *chip, u8 *buf, size_t 
> count)
> -{
> -    struct loongson_se_engine *tpm_engine = dev_get_drvdata(&chip->dev);
> -    struct tpm_loongson_cmd *cmd = tpm_engine->command;
> +    ret = loongson_se_send_engine_cmd(tpm_engine);
> +    if (ret)
> +        return ret;
>
> -    if (count > tpm_engine->buffer_size)
> -        return -E2BIG;
> +    cmd_ret = tpm_engine->command_ret;
> +    if (cmd_ret->data_len > bufsiz)
> +        return -EIO;
>
> -    cmd->data_len = count;
> -    memcpy(tpm_engine->data_buffer, buf, count);
> +    memcpy(buf, tpm_engine->data_buffer, cmd_ret->data_len);
>
> -    return loongson_se_send_engine_cmd(tpm_engine);
> +    return cmd_ret->data_len;
>  }
>
>  static const struct tpm_class_ops tpm_loongson_ops = {
>      .flags = TPM_OPS_AUTO_STARTUP,
> -    .recv = tpm_loongson_recv,
>      .send = tpm_loongson_send,
>  };
>
> @@ -65,7 +64,7 @@ static int tpm_loongson_probe(struct platform_device 
> *pdev)
>      chip = tpmm_chip_alloc(dev, &tpm_loongson_ops);
>      if (IS_ERR(chip))
>          return PTR_ERR(chip);
> -    chip->flags = TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_IRQ;
> +    chip->flags = TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_SYNC;
>      dev_set_drvdata(&chip->dev, tpm_engine);
>
>      return tpm_chip_register(chip);
>
> Thanks,
> Stefano
>
>>
>> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
>> index dddd702b2..ba3924eb1 100644
>> --- a/drivers/char/tpm/Kconfig
>> +++ b/drivers/char/tpm/Kconfig
>> @@ -189,6 +189,15 @@ config TCG_IBMVTPM
>>       will be accessible from within Linux.  To compile this driver
>>       as a module, choose M here; the module will be called tpm_ibmvtpm.
>>
>> +config TCG_LOONGSON
>> +    tristate "Loongson TPM Interface"
>> +    depends on MFD_LOONGSON_SE
>> +    help
>> +      If you want to make Loongson TPM support available, say Yes and
>> +      it will be accessible from within Linux. To compile this
>> +      driver as a module, choose M here; the module will be called
>> +      tpm_loongson.
>> +
>> config TCG_XEN
>>     tristate "XEN TPM Interface"
>>     depends on TCG_TPM && XEN
>> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
>> index 9de1b3ea3..5b5cdc0d3 100644
>> --- a/drivers/char/tpm/Makefile
>> +++ b/drivers/char/tpm/Makefile
>> @@ -46,3 +46,4 @@ obj-$(CONFIG_TCG_ARM_CRB_FFA) += tpm_crb_ffa.o
>> obj-$(CONFIG_TCG_VTPM_PROXY) += tpm_vtpm_proxy.o
>> obj-$(CONFIG_TCG_FTPM_TEE) += tpm_ftpm_tee.o
>> obj-$(CONFIG_TCG_SVSM) += tpm_svsm.o
>> +obj-$(CONFIG_TCG_LOONGSON) += tpm_loongson.o
>> diff --git a/drivers/char/tpm/tpm_loongson.c 
>> b/drivers/char/tpm/tpm_loongson.c
>> new file mode 100644
>> index 000000000..a4ec23639
>> --- /dev/null
>> +++ b/drivers/char/tpm/tpm_loongson.c
>> @@ -0,0 +1,84 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2025 Loongson Technology Corporation Limited. */
>> +
>> +#include <linux/device.h>
>> +#include <linux/mfd/loongson-se.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/wait.h>
>> +
>> +#include "tpm.h"
>> +
>> +struct tpm_loongson_cmd {
>> +    u32 cmd_id;
>> +    u32 data_off;
>> +    u32 data_len;
>> +    u32 pad[5];
>> +};
>> +
>> +static int tpm_loongson_recv(struct tpm_chip *chip, u8 *buf, size_t 
>> count)
>> +{
>> +    struct loongson_se_engine *tpm_engine = 
>> dev_get_drvdata(&chip->dev);
>> +    struct tpm_loongson_cmd *cmd_ret = tpm_engine->command_ret;
>> +
>> +    if (cmd_ret->data_len > count)
>> +        return -EIO;
>> +
>> +    memcpy(buf, tpm_engine->data_buffer, cmd_ret->data_len);
>> +
>> +    return cmd_ret->data_len;
>> +}
>> +
>> +static int tpm_loongson_send(struct tpm_chip *chip, u8 *buf, size_t 
>> count)
>> +{
>> +    struct loongson_se_engine *tpm_engine = 
>> dev_get_drvdata(&chip->dev);
>> +    struct tpm_loongson_cmd *cmd = tpm_engine->command;
>> +
>> +    if (count > tpm_engine->buffer_size)
>> +        return -E2BIG;
>> +
>> +    cmd->data_len = count;
>> +    memcpy(tpm_engine->data_buffer, buf, count);
>> +
>> +    return loongson_se_send_engine_cmd(tpm_engine);
>> +}
>> +
>> +static const struct tpm_class_ops tpm_loongson_ops = {
>> +    .flags = TPM_OPS_AUTO_STARTUP,
>> +    .recv = tpm_loongson_recv,
>> +    .send = tpm_loongson_send,
>> +};
>> +
>> +static int tpm_loongson_probe(struct platform_device *pdev)
>> +{
>> +    struct loongson_se_engine *tpm_engine;
>> +    struct device *dev = &pdev->dev;
>> +    struct tpm_loongson_cmd *cmd;
>> +    struct tpm_chip *chip;
>> +
>> +    tpm_engine = loongson_se_init_engine(dev->parent, SE_ENGINE_TPM);
>> +    if (!tpm_engine)
>> +        return -ENODEV;
>> +    cmd = tpm_engine->command;
>> +    cmd->cmd_id = SE_CMD_TPM;
>> +    cmd->data_off = tpm_engine->buffer_off;
>> +
>> +    chip = tpmm_chip_alloc(dev, &tpm_loongson_ops);
>> +    if (IS_ERR(chip))
>> +        return PTR_ERR(chip);
>> +    chip->flags = TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_IRQ;
>> +    dev_set_drvdata(&chip->dev, tpm_engine);
>> +
>> +    return tpm_chip_register(chip);
>> +}
>> +
>> +static struct platform_driver tpm_loongson = {
>> +    .probe   = tpm_loongson_probe,
>> +    .driver  = {
>> +        .name  = "tpm_loongson",
>> +    },
>> +};
>> +module_platform_driver(tpm_loongson);
>> +
>> +MODULE_ALIAS("platform:tpm_loongson");
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("Loongson TPM driver");
>> -- 
>> 2.45.2
>>
>>


