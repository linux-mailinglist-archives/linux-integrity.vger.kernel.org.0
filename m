Return-Path: <linux-integrity+bounces-6074-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EFFAA4490
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 09:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD5D7188A3AB
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 07:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4EB20E334;
	Wed, 30 Apr 2025 07:57:29 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189B4211A15;
	Wed, 30 Apr 2025 07:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745999849; cv=none; b=dfpvjCIs/LYnym9lrRhlndMGvyuqQ9ngQlEZ2Uxq6vp5ZuxO0Uk1v370M6RFRzKqMEEpKJcLv1fIu+eUP2eET95oEAeGi+J4l7ArYreHgEZ3vfIGr4zwezWcWuhFkssUcKtvXBJ10Yv3Fj88pQjDnG2+lOTupp8rt0KDPq/CJCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745999849; c=relaxed/simple;
	bh=Te/psvuoE4DPXalvViQ5WNlPpel1jC36ND+0Plf7xC8=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=tuCVUH4y1JgQpQd1O8fHWi5NiATSlgTmcMqvNIf61JEvA4IdYrFncnXWds6WmHUcy1uZUqfTk90CKLMUr4kfu8q7jG+c+uBnqX2CZZYBsmp7RN4fGz9MCujmeJ4hAOOEkaHWPbN0q+BZ7FXTe8m6H23ja2SyZQvhcBrI9t59UBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8CxaWra1xFoTu_KAA--.10311S3;
	Wed, 30 Apr 2025 15:57:14 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front1 (Coremail) with SMTP id qMiowMBxGcTU1xFoWd+fAA--.41512S2;
	Wed, 30 Apr 2025 15:57:10 +0800 (CST)
Subject: Re: [PATCH v8 4/5] tpm: Add a driver for Loongson TPM device
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, peterhuewe@gmx.de,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linux-crypto@vger.kernel.org, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
 pmenzel@molgen.mpg.de, Yinggang Gu <guyinggang@loongson.cn>,
 Huacai Chen <chenhuacai@loongson.cn>
References: <20250418093407.1335-1-zhaoqunqin@loongson.cn>
 <20250418093407.1335-5-zhaoqunqin@loongson.cn> <aAaVP8yG6rM436uw@kernel.org>
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
Message-ID: <78d06edd-2f53-47ae-5c9b-5ad26ad1ce41@loongson.cn>
Date: Wed, 30 Apr 2025 15:55:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aAaVP8yG6rM436uw@kernel.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMBxGcTU1xFoWd+fAA--.41512S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW3AFy7CrWxAF4Utw4DZryxJFc_yoW7uw4rpF
	WrCa1UCF4UJr1jk39IqrWDCF9Iv3s3Wry2kay7t34Uuryqy34rWryDGFy7Wa1xAr1kGr1I
	vFZ3CFWfuF15u3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
	I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
	0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Dl1DUUUUU==


ÔÚ 2025/4/22 ÉÏÎç2:58, Jarkko Sakkinen Ð´µÀ:
> On Fri, Apr 18, 2025 at 05:34:06PM +0800, Qunqin Zhao wrote:
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
>> v8: In the send callback, it will wait until the TPM2 command is
>>      completed. So do not need to wait in the recv callback.
>>      Removed Jarkko's tag cause there are some changes in v8
>>
>> v7: Moved Kconfig entry between TCG_IBMVTPM and TCG_XEN.
>>      Added Jarkko's tag(a little change, should be fine).
>>
>> v6: Replace all "ls6000se" with "loongson"
>>      Prefix all with tpm_loongson instead of tpm_lsse.
>>      Removed Jarkko's tag cause there are some changes in v6
>>
>> v5: None
>> v4: Prefix all with tpm_lsse instead of tpm.
>>      Removed MODULE_AUTHOR fields.
>>
>> v3: Added reminder about Loongson security engine to git log.
>>
>>   drivers/char/tpm/Kconfig        |  9 ++++
>>   drivers/char/tpm/Makefile       |  1 +
>>   drivers/char/tpm/tpm_loongson.c | 78 +++++++++++++++++++++++++++++++++
>>   3 files changed, 88 insertions(+)
>>   create mode 100644 drivers/char/tpm/tpm_loongson.c
>>
>> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
>> index fe4f3a609..34302a875 100644
>> --- a/drivers/char/tpm/Kconfig
>> +++ b/drivers/char/tpm/Kconfig
>> @@ -189,6 +189,15 @@ config TCG_IBMVTPM
>>   	  will be accessible from within Linux.  To compile this driver
>>   	  as a module, choose M here; the module will be called tpm_ibmvtpm.
>>   
>> +config TCG_LOONGSON
>> +	tristate "Loongson TPM Interface"
>> +	depends on CRYPTO_DEV_LOONGSON_SE
>> +	help
>> +	  If you want to make Loongson TPM support available, say Yes and
>> +	  it will be accessible from within Linux. To compile this
>> +	  driver as a module, choose M here; the module will be called
>> +	  tpm_loongson.
>> +
>>   config TCG_XEN
>>   	tristate "XEN TPM Interface"
>>   	depends on TCG_TPM && XEN
>> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
>> index 2b004df8c..cb534b235 100644
>> --- a/drivers/char/tpm/Makefile
>> +++ b/drivers/char/tpm/Makefile
>> @@ -45,3 +45,4 @@ obj-$(CONFIG_TCG_CRB) += tpm_crb.o
>>   obj-$(CONFIG_TCG_ARM_CRB_FFA) += tpm_crb_ffa.o
>>   obj-$(CONFIG_TCG_VTPM_PROXY) += tpm_vtpm_proxy.o
>>   obj-$(CONFIG_TCG_FTPM_TEE) += tpm_ftpm_tee.o
>> +obj-$(CONFIG_TCG_LOONGSON) += tpm_loongson.o
>> diff --git a/drivers/char/tpm/tpm_loongson.c b/drivers/char/tpm/tpm_loongson.c
>> new file mode 100644
>> index 000000000..c4d69d28d
>> --- /dev/null
>> +++ b/drivers/char/tpm/tpm_loongson.c
>> @@ -0,0 +1,78 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2025 Loongson Technology Corporation Limited. */
>> +
>> +#include <linux/device.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/wait.h>
>> +
>> +#include "../../drivers/crypto/loongson/loongson-se.h"
>> +#include "tpm.h"
>> +
>> +struct tpm_loongson_cmd {
>> +	u32 cmd_id;
>> +	u32 data_off;
>> +	u32 data_len;
>> +	u32 pad[5];
>> +};
>> +
>> +static int tpm_loongson_recv(struct tpm_chip *chip, u8 *buf, size_t count)
>> +{
>> +	struct loongson_se_engine *tpm_engine = dev_get_drvdata(&chip->dev);
>> +	struct tpm_loongson_cmd *cmd_ret = tpm_engine->command_ret;
>> +
>> +	memcpy(buf, tpm_engine->data_buffer, cmd_ret->data_len);
>> +
>> +	return cmd_ret->data_len;
>> +}
>> +
>> +static int tpm_loongson_send(struct tpm_chip *chip, u8 *buf, size_t count)
>> +{
>> +	struct loongson_se_engine *tpm_engine = dev_get_drvdata(&chip->dev);
>> +	struct tpm_loongson_cmd *cmd = tpm_engine->command;
>> +
>> +	cmd->data_len = count;
>> +	memcpy(tpm_engine->data_buffer, buf, count);
>> +
>> +	return loongson_se_send_engine_cmd(tpm_engine);
>> +}
>> +
>> +static const struct tpm_class_ops tpm_loongson_ops = {
>> +	.flags = TPM_OPS_AUTO_STARTUP,
>> +	.recv = tpm_loongson_recv,
>> +	.send = tpm_loongson_send,
>> +};
>> +
>> +static int tpm_loongson_probe(struct platform_device *pdev)
>> +{
>> +	struct loongson_se_engine *tpm_engine;
>> +	struct device *dev = &pdev->dev;
>> +	struct tpm_loongson_cmd *cmd;
>> +	struct tpm_chip *chip;
>> +
>> +	tpm_engine = loongson_se_init_engine(dev->parent, SE_ENGINE_TPM);
>> +	if (!tpm_engine)
>> +		return -ENODEV;
>> +	cmd = tpm_engine->command;
>> +	cmd->cmd_id = SE_CMD_TPM;
>> +	cmd->data_off = tpm_engine->buffer_off;
>> +
>> +	chip = tpmm_chip_alloc(dev, &tpm_loongson_ops);
>> +	if (IS_ERR(chip))
>> +		return PTR_ERR(chip);
>> +	chip->flags = TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_IRQ;
>> +	dev_set_drvdata(&chip->dev, tpm_engine);
>> +
>> +	return tpm_chip_register(chip);
>> +}
>> +
>> +static struct platform_driver tpm_loongson_driver = {
>> +	.probe   = tpm_loongson_probe,
>> +	.driver  = {
>> +		.name  = "loongson-tpm",
>> +	},
>> +};
>> +module_platform_driver(tpm_loongson_driver);
>
> It's otherwise fine but this should be just "tpm_loongson" :-)
>
> +1 revision add
>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> as long as this is renamed.

Will rename.

Thanks for your reply,

BR, Qunqin.

>> +
>> +MODULE_ALIAS("platform:loongson-tpm");
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("Loongson TPM driver");
>> -- 
>> 2.45.2
>>
>>
> BR, Jarkko


