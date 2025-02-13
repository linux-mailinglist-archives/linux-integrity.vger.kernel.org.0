Return-Path: <linux-integrity+bounces-4809-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A21D7A33670
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Feb 2025 04:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50ACE167D7D
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Feb 2025 03:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C988F204C1F;
	Thu, 13 Feb 2025 03:56:09 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F574A29;
	Thu, 13 Feb 2025 03:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739418969; cv=none; b=lJ244/c1tz5Yp5ucJn+OpSzpZ8OPb74HRPJrdAwUGTBiFrpsSG/Z1nn0ZTp1vQDc6ZmQYpsBKlVGOiK6XmD3EnOrBhIBf8n0wve3LN0KKnpAsSQ77NgdKZI4TRSeoV4bYKsKKXZbTwXBoiikzOzMSIAxMEaxY0Xg894wk93X0Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739418969; c=relaxed/simple;
	bh=azYpgLA8z3kcFfFC5gdpaTzFk4QeSlBrWzku2tNrj7Y=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=LbXalEMVc9kf0GDegkArLVBDvi1/DfhtcBCM4N5vwR7LlOOZiB4+cdG3tlfhuY/57H7Dyhw63wclMwyiUDwJ9FBzSrZuM2MVQ92pQz2/QL+Uyu+EO27DGaevX0BORMe+xQZrELVL2S5LcvoYikqmm3QX/MHtDmdMTEwJAJraEvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8AxjmtKba1nKclzAA--.4753S3;
	Thu, 13 Feb 2025 11:55:54 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front1 (Coremail) with SMTP id qMiowMDxesQ+ba1nBzYPAA--.2422S2;
	Thu, 13 Feb 2025 11:55:44 +0800 (CST)
Subject: Re: [PATCH v2 3/3] tpm: Add a driver for Loongson TPM device
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: lee@kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net,
 peterhuewe@gmx.de, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linux-crypto@vger.kernel.org, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
 Yinggang Gu <guyinggang@loongson.cn>
References: <20250212033113.15137-1-zhaoqunqin@loongson.cn>
 <20250212033113.15137-4-zhaoqunqin@loongson.cn> <Z60SfDaWnbgddUnA@kernel.org>
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
Message-ID: <c825cd7b-a255-d296-baa0-c1a746cb1bce@loongson.cn>
Date: Thu, 13 Feb 2025 11:56:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z60SfDaWnbgddUnA@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMDxesQ+ba1nBzYPAA--.2422S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxtr15urWfXw4furyDZF4DKFX_yoW7tF1xpF
	4kCan8CF4UJrW7t39Iqr4DuF9xX34vqFy2krW7tasxZr90v3s5ur4DKFy5uFZ3Zr1kGF1I
	vFWS9r43uF1Yk3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
	McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
	I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
	0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jFApnUUUUU=


在 2025/2/13 上午5:28, Jarkko Sakkinen 写道:
> On Wed, Feb 12, 2025 at 11:31:13AM +0800, Qunqin Zhao wrote:
>> TPM2.0 is implemented in Loongson security engine. This is the driver
> TPM 2.0 or just TPM2 (either is fine with me). Quick reminder what
> Loongson security engine (I could not know that and it would be nice
> to have that in git log).

Looks like just TPM2 is better.

Some explanations about Loongson security engine will be added to git log.

>
>> for it.
>>
>> Co-developed-by: Yinggang Gu <guyinggang@loongson.cn>
>> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
>> Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
>> ---
>>   MAINTAINERS                 |   1 +
>>   drivers/char/tpm/Kconfig    |   9 ++++
>>   drivers/char/tpm/Makefile   |   1 +
>>   drivers/char/tpm/tpm_lsse.c | 104 ++++++++++++++++++++++++++++++++++++
>>   4 files changed, 115 insertions(+)
>>   create mode 100644 drivers/char/tpm/tpm_lsse.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 6493d58436..6aad0f08ad 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -13484,6 +13484,7 @@ LOONGSON CRYPTO DRIVER
>>   M:	Qunqin Zhao <zhaoqunqin@loongson.com>
>>   L:	linux-crypto@vger.kernel.org
>>   S:	Maintained
>> +F:	drivers/char/tpm/tpm_lsse.c
>>   F:	drivers/crypto/loongson/
>>   
>>   LOONGSON-2 APB DMA DRIVER
> Probably MAINTAINERS update should be a separate patch.

Some  MAINTAINERS updates are not  separated form the driver patch.  
Like the submit of "drivers/mfd/max7714*".

So it seems whether the updates to MAINTAINERS  are separated or not is OK.

BR, Qunqin.

>> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
>> index 0fc9a510e0..56d0417065 100644
>> --- a/drivers/char/tpm/Kconfig
>> +++ b/drivers/char/tpm/Kconfig
>> @@ -225,5 +225,14 @@ config TCG_FTPM_TEE
>>   	help
>>   	  This driver proxies for firmware TPM running in TEE.
>>   
>> +config TCG_LSSE
>> +	tristate "Loongson TPM Interface"
>> +	depends on MFD_LS6000SE
>> +	help
>> +	  If you want to make Loongson TPM support available, say Yes and
>> +	  it will be accessible from within Linux. To compile this
>> +	  driver as a module, choose M here; the module will be called
>> +	  tpm_lsse.
>> +
>>   source "drivers/char/tpm/st33zp24/Kconfig"
>>   endif # TCG_TPM
>> diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
>> index 9bb142c752..bf2280352d 100644
>> --- a/drivers/char/tpm/Makefile
>> +++ b/drivers/char/tpm/Makefile
>> @@ -44,3 +44,4 @@ obj-$(CONFIG_TCG_XEN) += xen-tpmfront.o
>>   obj-$(CONFIG_TCG_CRB) += tpm_crb.o
>>   obj-$(CONFIG_TCG_VTPM_PROXY) += tpm_vtpm_proxy.o
>>   obj-$(CONFIG_TCG_FTPM_TEE) += tpm_ftpm_tee.o
>> +obj-$(CONFIG_TCG_LSSE) += tpm_lsse.o
>> diff --git a/drivers/char/tpm/tpm_lsse.c b/drivers/char/tpm/tpm_lsse.c
>> new file mode 100644
>> index 0000000000..3fd2d9bac8
>> --- /dev/null
>> +++ b/drivers/char/tpm/tpm_lsse.c
>> @@ -0,0 +1,104 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/* Copyright (c) 2025 Loongson Technology Corporation Limited. */
>> +
>> +#include <linux/device.h>
>> +#include <linux/mfd/ls6000se.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/wait.h>
>> +
>> +#include "tpm.h"
>> +
>> +struct tpm_msg {
>> +	u32 cmd;
>> +	u32 data_off;
>> +	u32 data_len;
>> +	u32 info[5];
>> +};
>> +
>> +struct tpm_dev {
>> +	struct lsse_ch *se_ch;
>> +	struct completion tpm_completion;
>> +};
>> +
>> +static void tpm_complete(struct lsse_ch *ch)
>> +{
>> +	struct tpm_dev *td = ch->priv;
>> +
>> +	complete(&td->tpm_completion);
>> +}
>> +
>> +static int tpm_ls_recv(struct tpm_chip *chip, u8 *buf, size_t count)
>> +{
>> +	struct tpm_dev *td = dev_get_drvdata(&chip->dev);
>> +	struct tpm_msg *rmsg;
>> +	int sig;
>> +
>> +	sig = wait_for_completion_interruptible(&td->tpm_completion);
>> +	if (sig)
>> +		return sig;
>> +
>> +	rmsg = td->se_ch->rmsg;
>> +	memcpy(buf, td->se_ch->data_buffer, rmsg->data_len);
>> +
>> +	return rmsg->data_len;
>> +}
>> +
>> +static int tpm_ls_send(struct tpm_chip *chip, u8 *buf, size_t count)
>> +{
>> +	struct tpm_dev *td = dev_get_drvdata(&chip->dev);
>> +	struct tpm_msg *smsg = td->se_ch->smsg;
>> +
>> +	memcpy(td->se_ch->data_buffer, buf, count);
>> +	smsg->data_len = count;
>> +
>> +	return se_send_ch_requeset(td->se_ch);
>> +}
>> +
>> +static const struct tpm_class_ops lsse_tpm_ops = {
>> +	.flags = TPM_OPS_AUTO_STARTUP,
>> +	.recv = tpm_ls_recv,
>> +	.send = tpm_ls_send,
>> +};
>> +
>> +static int lsse_tpm_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct tpm_chip *chip;
>> +	struct tpm_msg *smsg;
>> +	struct tpm_dev *td;
>> +
>> +	td = devm_kzalloc(dev, sizeof(struct tpm_dev), GFP_KERNEL);
>> +	if (!td)
>> +		return -ENOMEM;
>> +
>> +	init_completion(&td->tpm_completion);
>> +	td->se_ch = se_init_ch(dev->parent, SE_CH_TPM, PAGE_SIZE,
>> +			       2 * sizeof(struct tpm_msg), td, tpm_complete);
>> +	if (!td->se_ch)
>> +		return -ENODEV;
>> +	smsg = td->se_ch->smsg;
>> +	smsg->cmd = SE_CMD_TPM;
>> +	smsg->data_off = td->se_ch->off;
>> +
>> +	chip = tpmm_chip_alloc(dev, &lsse_tpm_ops);
>> +	if (IS_ERR(chip))
>> +		return PTR_ERR(chip);
>> +	chip->flags = TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_IRQ;
>> +	dev_set_drvdata(&chip->dev, td);
>> +
>> +	return tpm_chip_register(chip);
>> +}
>> +
>> +static struct platform_driver lsse_tpm_driver = {
>> +	.probe   = lsse_tpm_probe,
>> +	.driver  = {
>> +		.name  = "ls6000se-tpm",
>> +	},
>> +};
>> +module_platform_driver(lsse_tpm_driver);
>> +
>> +MODULE_ALIAS("platform:ls6000se-tpm");
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Yinggang Gu <guyinggang@loongson.cn>");
>> +MODULE_AUTHOR("Qunqin Zhao <zhaoqunqin@loongson.cn>");
>> +MODULE_DESCRIPTION("Loongson TPM driver");
>> -- 
>> 2.43.0
>>
> BR, Jarkko


