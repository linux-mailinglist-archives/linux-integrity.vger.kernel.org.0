Return-Path: <linux-integrity+bounces-5248-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 126FEA5D859
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Mar 2025 09:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 944FE3AC575
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Mar 2025 08:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9202356A1;
	Wed, 12 Mar 2025 08:38:59 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1CC1DE3A4;
	Wed, 12 Mar 2025 08:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741768739; cv=none; b=VnKNt62WCUqQzriZOMf5AiXsYfwi+v9YlaFz4dEIpPLDaG6MhNxPfh52RJWloEGLg8c2fiGIJZnrNofo+rJMCPBcCXVv0UwJd9SOpOnO7tiJrO0kXF0pgB06skYqFMyY5f8iE8s9/t8RbT+qmdDinqub+AfgeGnSjPk2uuOZVF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741768739; c=relaxed/simple;
	bh=U33hEvHJjZLQGk9HJu8MWoqd1bx3vlt2f9SlenNSOKg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=J77HLuDAoLOiSFG6N1pX5KEcQ/DA4uuavOfeZJsnhRXT8p04YDisYO7jz624bmV5H7ee/t5MbDtNd1ZyMaw70p/aB1KyHVCgAv5dE0nyv2cORLIYDbP+1Qrk9vUaT/WY360nEuOYRw6F7uZmevmendSMu5sck6KCzD/9s96casY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8CxqmoXSNFnrymTAA--.54647S3;
	Wed, 12 Mar 2025 16:38:47 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front1 (Coremail) with SMTP id qMiowMDxesQTSNFnu51FAA--.16811S2;
	Wed, 12 Mar 2025 16:38:46 +0800 (CST)
Subject: Re: [PATCH v4 1/6] mfd: Add support for Loongson Security Module
To: Lee Jones <lee@kernel.org>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, peterhuewe@gmx.de,
 jarkko@kernel.org, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linux-crypto@vger.kernel.org, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
 pmenzel@molgen.mpg.de, Yinggang Gu <guyinggang@loongson.cn>
References: <20250226030358.15924-1-zhaoqunqin@loongson.cn>
 <20250226030358.15924-2-zhaoqunqin@loongson.cn>
 <20250307200031.GG8350@google.com>
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
Message-ID: <5a3c49e7-3f80-25fe-6f08-a3a6ddc496d0@loongson.cn>
Date: Wed, 12 Mar 2025 16:38:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250307200031.GG8350@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMDxesQTSNFnu51FAA--.16811S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxWFWrZr1kZFWfWFy5JF43urX_yoW5XF1fpa
	yDJFyrCF48Jw42ka13W3WUuFy5Ga92grW3KFy7Wa4xuF9xZa47JrZ0kFy7GrZ7Jr1xXry2
	gF95Za45CF1YyacCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
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


在 2025/3/12 下午4:08, Lee Jones 写道:
> On Wed, 26 Feb 2025, Qunqin Zhao wrote:
>
>> This driver supports Loongson Security Module, which provides the control
>> for it's hardware encryption acceleration child devices.
>>
>> Co-developed-by: Yinggang Gu <guyinggang@loongson.cn>
>> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
>> Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
>> ---
>> v3-v4: None
>>
>> v2: Removed "ls6000se-sdf" device, added "ls6000se-tpm" device.
>>      Passed dmamem size to SE firmware in se_init_hw() function.
>>
>>   drivers/mfd/Kconfig          |  10 +
>>   drivers/mfd/Makefile         |   2 +
>>   drivers/mfd/ls6000se.c       | 374 +++++++++++++++++++++++++++++++++++
>>   include/linux/mfd/ls6000se.h |  75 +++++++
>>   4 files changed, 461 insertions(+)
>>   create mode 100644 drivers/mfd/ls6000se.c
>>   create mode 100644 include/linux/mfd/ls6000se.h
>>
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index d44c69bb3d..318fb113c1 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -2439,5 +2439,15 @@ config MFD_UPBOARD_FPGA
>>   	  To compile this driver as a module, choose M here: the module will be
>>   	  called upboard-fpga.
>>   
>> +config MFD_LS6000SE
>> +	tristate "Loongson Security Module Interface"
>> +	depends on LOONGARCH && ACPI
>> +	select MFD_CORE
>> +	help
>> +	  The Loongson security module provides the control for hardware
>> +	  encryption acceleration devices. Each device uses at least one
>> +	  channel to interact with security module, and each channel may
>> +	  have its own buffer provided by security module.
>> +
>>   endmenu
>>   endif
>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>> index 9220eaf7cf..9556de7715 100644
>> --- a/drivers/mfd/Makefile
>> +++ b/drivers/mfd/Makefile
>> @@ -294,3 +294,5 @@ obj-$(CONFIG_MFD_RSMU_I2C)	+= rsmu_i2c.o rsmu_core.o
>>   obj-$(CONFIG_MFD_RSMU_SPI)	+= rsmu_spi.o rsmu_core.o
>>   
>>   obj-$(CONFIG_MFD_UPBOARD_FPGA)	+= upboard-fpga.o
>> +
>> +obj-$(CONFIG_MFD_LS6000SE)	+= ls6000se.o
>> diff --git a/drivers/mfd/ls6000se.c b/drivers/mfd/ls6000se.c
>> new file mode 100644
>> index 0000000000..24d76c2ffc
>> --- /dev/null
>> +++ b/drivers/mfd/ls6000se.c
> [...]
>
>> +static const struct mfd_cell se_devs[] = {
>> +	{ .name = "ls6000se-sdf" },
>> +	{ .name = "ls6000se-tpm" },
>> +};
> Where are the drivers for these devices?  I don't see them anywhere.
>
> I do see ls6000se-rng.  How is that registered?

Oh.... I made a slip of the pen and wrote that  "ls6000se-sdf" not  
"ls6000se-rng".  Will fix it in next version.

Driver for "ls6000se-tpm" is [PATCH v4 5/6].

Thanks for your comments.

BR, Qunqin.

>


