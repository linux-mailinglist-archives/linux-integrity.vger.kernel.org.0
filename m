Return-Path: <linux-integrity+bounces-5270-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E45A5F018
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Mar 2025 10:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 020CC188B1A9
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Mar 2025 09:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABACE261389;
	Thu, 13 Mar 2025 09:59:18 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2608714900B;
	Thu, 13 Mar 2025 09:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741859958; cv=none; b=D9Z4viSqwZB2y1PFj9v8zbRplhbA4okYCS+IKhepoPxr7beds9r+owMVYltGE/H8cA2aC3Iku7WHo+g/SAjl/eagdB6euBmdi6dKOZH1vuvMqLbtC7ST8kARIVfoBUVhRq9ssg7JN+bcH0N8lfyQ9/jdfc9Aoc+++0d7nNRG8W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741859958; c=relaxed/simple;
	bh=WjRjfxpFxzqgg5E0INrZzM956AAlPjFd6i9LRa6N/58=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=rYg03kkjtVj5bMg9DQwxTbQ9i65nSQ8PyyOAB2IsHgkLNPjwNPVmjf9tTpQA8Bn8EdSmoftt2GXDJuVvI22GgwS1hEMa0pIhgSgO3O6tC0lwC4iErb2RZCueNsnu9RI4PeBXfr9DeB2ya/q4RNE/C7fuSC9k4e0Uvg+V6EJzbG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8Axz3NvrNJnW8uUAA--.56211S3;
	Thu, 13 Mar 2025 17:59:11 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front1 (Coremail) with SMTP id qMiowMBxrMZqrNJnNlJIAA--.19194S2;
	Thu, 13 Mar 2025 17:59:09 +0800 (CST)
Subject: Re: [PATCH v5 0/6] Drivers for Loongson security engine
To: Huacai Chen <chenhuacai@kernel.org>
Cc: lee@kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net,
 peterhuewe@gmx.de, jarkko@kernel.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-crypto@vger.kernel.org, jgg@ziepe.ca,
 linux-integrity@vger.kernel.org, pmenzel@molgen.mpg.de
References: <20250313090508.21252-1-zhaoqunqin@loongson.cn>
 <CAAhV-H5f1k4_bVybMcK9QXhaVxLOM=b_8n0sA+0r=gyCP4YQRA@mail.gmail.com>
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
Message-ID: <d77a36a3-3b74-76a9-38de-1a40ffb58374@loongson.cn>
Date: Thu, 13 Mar 2025 17:59:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAAhV-H5f1k4_bVybMcK9QXhaVxLOM=b_8n0sA+0r=gyCP4YQRA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMBxrMZqrNJnNlJIAA--.19194S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxGFykGF47WrWUuryxXw4xGrX_yoW5GFy8pF
	45AFyrCFWUJF47G34ftFyUCFy5Xas3Xry3Ka9Fqw13Wr9xAa47J3y7CFy7CFZrAr1fGryI
	vFZ3Cr45CF1Yy3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
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
	0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI
	42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU8Dl1DUUUU
	U==


在 2025/3/13 下午5:26, Huacai Chen 写道:
> You haven't seen my comments in previous version?
>
> https://lore.kernel.org/loongarch/CAAhV-H5xyRrF1_=E7rLM3dHeYAEBdMufYQvgoxAq6+d6s5U4Eg@mail.gmail.com/

I am very sorry that I didn't notice your reply.

I don't think it is necessary to change the driver file name. But if you 
insist, I will do the change below  in  next revision .

"MFD_LS6000SE -> MFD_LOONGSON_SE,  ls6000se.c -> loongson-se.c
CRYPTO_DEV_LS6000SE_RNG -> CRYPTO_DEV_LOONGSON_RNG, ls6000se-rng.c 
->loongson-rng.c
TCG_LSSE -> TCG_LOONGSON, tpm_lsse.c ->tpm_loongson.c"


BR, Qunqin.

>
> Huacai
>
> On Thu, Mar 13, 2025 at 5:05 PM Qunqin Zhao <zhaoqunqin@loongson.cn> wrote:
>> Loongson security engine supports random number generation, hash,
>> symmetric encryption and asymmetric encryption. Based on these
>> encryption functions, TPM2 have been implemented in it.
>>
>> mfd is the baser driver, crypto and tpm are users.
>>
>> v5: Registered "ls6000se-rng" device in mfd driver.
>> v4: Please look at changelog in tpm and MAINTAINERS. No changes to mfd
>>      and crypto.
>> v3: Put the updates to the MAINTAINERS in a separate patch.
>> v2: Removed misc driver. Added tpm driver.
>>
>> Qunqin Zhao (6):
>>    mfd: Add support for Loongson Security Module
>>    MAINTAINERS: Add entry for Loongson Security Module driver
>>    crypto: loongson - add Loongson RNG driver support
>>    MAINTAINERS: Add entry for Loongson RNG driver
>>    tpm: Add a driver for Loongson TPM device
>>    MAINTAINERS: Add tpm_lsse.c to LOONGSON CRYPTO DRIVER entry
>>
>>   MAINTAINERS                            |  14 +
>>   drivers/char/tpm/Kconfig               |   9 +
>>   drivers/char/tpm/Makefile              |   1 +
>>   drivers/char/tpm/tpm_lsse.c            | 103 +++++++
>>   drivers/crypto/Kconfig                 |   1 +
>>   drivers/crypto/Makefile                |   1 +
>>   drivers/crypto/loongson/Kconfig        |   6 +
>>   drivers/crypto/loongson/Makefile       |   2 +
>>   drivers/crypto/loongson/ls6000se-rng.c | 190 +++++++++++++
>>   drivers/mfd/Kconfig                    |  10 +
>>   drivers/mfd/Makefile                   |   2 +
>>   drivers/mfd/ls6000se.c                 | 374 +++++++++++++++++++++++++
>>   include/linux/mfd/ls6000se.h           |  75 +++++
>>   13 files changed, 788 insertions(+)
>>   create mode 100644 drivers/char/tpm/tpm_lsse.c
>>   create mode 100644 drivers/crypto/loongson/Kconfig
>>   create mode 100644 drivers/crypto/loongson/Makefile
>>   create mode 100644 drivers/crypto/loongson/ls6000se-rng.c
>>   create mode 100644 drivers/mfd/ls6000se.c
>>   create mode 100644 include/linux/mfd/ls6000se.h
>>
>>
>> base-commit: 6a8f122c5f073c8610c32636663f2512514b1270
>> --
>> 2.43.0
>>
>>


