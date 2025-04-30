Return-Path: <linux-integrity+bounces-6077-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6D0AA4500
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 10:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE501983D38
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 08:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD2021B9DB;
	Wed, 30 Apr 2025 08:16:44 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F36A21A928;
	Wed, 30 Apr 2025 08:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746001004; cv=none; b=sJTRT0uJPH8dPO9qA7jUNi2YhKfl5lekcNFPSBWVOJh9QT/RWsRVshF/EvfX+GtJGQ9m6xvHmIRk5GPMVsevgRCKdrzGYlnWhimBX6lm5LVsX45MkMYONxlbA2uVOX9wlKBlHYLExcfNqpQB9uxtXpN5MVrznGVM9qDBC7Nz5h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746001004; c=relaxed/simple;
	bh=H7YxKxpfejzggNL2H3p8dGBc255WrjVbcBJpn4FlNyQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uuD3hHLD2ug9Nqsxy1eO5pzC9SjYDeVsompQe1mqJg19pv3hJla5MNFaUgeageZttSl/Q3U0p5pxzgSEC+55cQ+2Jz7w93rk08uFidKWCwKpOKt5lBawtOXgk+7QlLpUh3RdOVXQW8WK4LdUHV2q2Uk9oLMDshUfiTrOMIaRwwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8DxC3Jk3BFoAvPKAA--.8628S3;
	Wed, 30 Apr 2025 16:16:36 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front1 (Coremail) with SMTP id qMiowMAxTsVf3BFoj+ifAA--.44671S2;
	Wed, 30 Apr 2025 16:16:34 +0800 (CST)
Subject: Re: [PATCH v8 0/5] Add Loongson Security Engine chip driver
To: herbert@gondor.apana.org.au
Cc: Huacai Chen <chenhuacai@kernel.org>, davem@davemloft.net,
 peterhuewe@gmx.de, jarkko@kernel.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-crypto@vger.kernel.org, jgg@ziepe.ca,
 linux-integrity@vger.kernel.org, pmenzel@molgen.mpg.de,
 Lee Jones <lee@kernel.org>
References: <20250418093506.1349-1-zhaoqunqin@loongson.cn>
 <CAAhV-H608_ddH0g0gyFCZSTVxYHOBqLXrtGYxZ1eoXX6eCcEuA@mail.gmail.com>
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
Message-ID: <75bb29fa-6d77-6f95-eec4-ee183190da17@loongson.cn>
Date: Wed, 30 Apr 2025 16:14:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H608_ddH0g0gyFCZSTVxYHOBqLXrtGYxZ1eoXX6eCcEuA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMAxTsVf3BFoj+ifAA--.44671S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxCF45tF4UurW8CF45KFWDKFX_yoW5KFWxpF
	45Cay5Cr4UJF47Cr93try8CFy5Z3s3Xr9rKa9rJw15Wr9xAa4xJrW7CFyUCFsrZryrGryI
	vFWkCa17u3W5AacCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
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


在 2025/4/20 下午3:17, Huacai Chen 写道:
> Hi, Qunqin,
>
> On Fri, Apr 18, 2025 at 5:33 PM Qunqin Zhao <zhaoqunqin@loongson.cn> wrote:
>> The Loongson Security Engine chip supports RNG, SM2, SM3 and SM4
>> accelerator engines. Each engine have its own DMA buffer provided
>> by the controller. The kernel cannot directly send commands to the
>> engine and must first send them to the controller, which will
>> forward them to the corresponding engine. Based on these engines,
>> TPM2 have been implemented in the chip, then let's treat TPM2 itself
>> as an engine.
>>
>> v8: Like Lee said, the base driver goes beyond MFD scope. Since these
>>      are all encryption related drivers and SM2, SM3, and SM4 drivers
>>      will be added to the crypto subsystem in the future, the base driver
>>      need to be changed when adding these drivers. Therefore, it may be
>>      more appropriate to place the base driver within the crypto subsystem.
> I don't know what Lee Jones exactly means. But I don't think this
> version is what he wants. You move the SE driver from drivers/mfd to
> drivers/crypto, but it is still a mfd driver because of "struct
> mfd_cell engines".

Hi, Herbert

Sorry to bother you, may i ask is it fine to move  the Security Engine 
base driver[Patch v8 1/5] to drivers/crypto ?

The base driver uses MFD  interface  to register child device(tpm, rng) 
, as done in

"drivers/iio/common/ssp_sensors/ssp_dev.c" and 
"drivers/firmware/xilinx/zynqmp.c".

Thank you, and I look forward to hearing from you.

BR, Qunqin.

>
> Huacai
>
>>      Removed complete callback in all drivers. Removed the concepts of
>>      "channel", "msg" and "request" as they may be confusing. Used the
>>      concepts of "egnine" and "command" may be better.
>>
>> v7: Addressed Huacai's comments.
>>
>> v6: mfd :MFD_LS6000SE -> MFD_LOONGSON_SE,  ls6000se.c -> loongson-se.c
>>
>>      crypto :CRYPTO_DEV_LS6000SE_RNG -> CRYPTO_DEV_LOONGSON_RNG,
>>      ls6000se-rng.c ->loongson-rng.c
>>
>>      tpm: TCG_LSSE -> TCG_LOONGSON, tpm_lsse.c ->tpm_loongson.c
>>
>> v5: Registered "ls6000se-rng" device in mfd driver.
>> v4: Please look at changelog in tpm and MAINTAINERS. No changes to mfd
>>      and crypto.
>> v3: Put the updates to the MAINTAINERS in a separate patch.
>>
>> Qunqin Zhao (5):
>>    crypto: loongson - Add Loongson Security Engine chip controller driver
>>    crypto: loongson - add Loongson RNG driver support
>>    MAINTAINERS: Add entry for Loongson crypto driver
>>    tpm: Add a driver for Loongson TPM device
>>    MAINTAINERS: Add tpm_loongson.c to LOONGSON CRYPTO DRIVER entry
>>
>>   MAINTAINERS                            |   7 +
>>   drivers/char/tpm/Kconfig               |   9 +
>>   drivers/char/tpm/Makefile              |   1 +
>>   drivers/char/tpm/tpm_loongson.c        |  78 ++++++++
>>   drivers/crypto/Kconfig                 |   1 +
>>   drivers/crypto/Makefile                |   1 +
>>   drivers/crypto/loongson/Kconfig        |  17 ++
>>   drivers/crypto/loongson/Makefile       |   3 +
>>   drivers/crypto/loongson/loongson-rng.c | 198 ++++++++++++++++++++
>>   drivers/crypto/loongson/loongson-se.c  | 239 +++++++++++++++++++++++++
>>   drivers/crypto/loongson/loongson-se.h  |  52 ++++++
>>   11 files changed, 606 insertions(+)
>>   create mode 100644 drivers/char/tpm/tpm_loongson.c
>>   create mode 100644 drivers/crypto/loongson/Kconfig
>>   create mode 100644 drivers/crypto/loongson/Makefile
>>   create mode 100644 drivers/crypto/loongson/loongson-rng.c
>>   create mode 100644 drivers/crypto/loongson/loongson-se.c
>>   create mode 100644 drivers/crypto/loongson/loongson-se.h
>>
>>
>> base-commit: 8ffd015db85fea3e15a77027fda6c02ced4d2444
>> --
>> 2.45.2
>>
>>


