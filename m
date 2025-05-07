Return-Path: <linux-integrity+bounces-6152-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5501AAD2D5
	for <lists+linux-integrity@lfdr.de>; Wed,  7 May 2025 03:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC02298552A
	for <lists+linux-integrity@lfdr.de>; Wed,  7 May 2025 01:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA6761494DB;
	Wed,  7 May 2025 01:35:47 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8362E13AD38;
	Wed,  7 May 2025 01:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746581747; cv=none; b=tGB5C/QZtjanPFBKOCZYmRU+CwT3cuIelwEVvGn1A04PrRStTdQ/wKHLj7ffmE1/nTA9BUjJU5cJbGEykEOoewVfB6Qi7N6s6ZKCBWhSV5Wnd7vhwm46UUYsI+sgFi2a0zFj3ELs6iN8M0VkhrAWNYlr3LmGbrDsW8QDmKUY2sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746581747; c=relaxed/simple;
	bh=zgD0KtQ6+c4Xt135Y5OUFoybXsZd/9SqcHvNmny7ARQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hJXv2hcSzaJxvZWsvReGUDfuD4Biz+xw4lEEOYCZlcw+vjo5d5goR9iX0Us2LmUa3xtAfLbNCLIN0poxEwjNSsouk4Y5N4ynO9ztOaYcUhTo4rMa6ryM1/2awnyo9+cEgOeJ57WqR67SKBwToyzRPS56kEKfVy/NxxBs8kkoQpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8Axz3PruBpoE4_XAA--.25331S3;
	Wed, 07 May 2025 09:35:39 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front1 (Coremail) with SMTP id qMiowMAxTsXduBpoXMO4AA--.49926S2;
	Wed, 07 May 2025 09:35:28 +0800 (CST)
Subject: Re: [PATCH v9 4/5] tpm: Add a driver for Loongson TPM device
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: lee@kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net,
 peterhuewe@gmx.de, jarkko@kernel.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-crypto@vger.kernel.org, jgg@ziepe.ca,
 linux-integrity@vger.kernel.org, pmenzel@molgen.mpg.de,
 Yinggang Gu <guyinggang@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>
References: <20250506031947.11130-1-zhaoqunqin@loongson.cn>
 <20250506031947.11130-5-zhaoqunqin@loongson.cn>
 <2nuadbg5awe6gvagxg7t5ewvxsbmiq4qrcrycvnrmt2etzq2ke@6oyzavctwrma>
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
Message-ID: <0b148f09-d20d-b6be-d31b-6c8a553658c9@loongson.cn>
Date: Wed, 7 May 2025 09:33:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2nuadbg5awe6gvagxg7t5ewvxsbmiq4qrcrycvnrmt2etzq2ke@6oyzavctwrma>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMAxTsXduBpoXMO4AA--.49926S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7uw4DJr43GF43AFyfWrW3urX_yoW8Xw4DpF
	WfCa1UGFs8Kr18CwsrJrWfZry3ZrZ5XFWDXFWDA347Crn8Awn5J34UZr4vv3WDAF48Gw1I
	vFWI9rWF93Z8uFgCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
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


在 2025/5/6 下午10:13, Stefano Garzarella 写道:
> On Tue, May 06, 2025 at 11:19:46AM +0800, Qunqin Zhao wrote:
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
>> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>> ---
>> v9: "tpm_loongson_driver" --> "tpm_loongson"
>>    "depends on CRYPTO_DEV_LOONGSON_SE" --> "depends on MFD_LOONGSON_SE"
>>
...
>> +static int tpm_loongson_recv(struct tpm_chip *chip, u8 *buf, size_t 
>> count)
>> +{
>> +    struct loongson_se_engine *tpm_engine = 
>> dev_get_drvdata(&chip->dev);
>> +    struct tpm_loongson_cmd *cmd_ret = tpm_engine->command_ret;
>> +
>> +    memcpy(buf, tpm_engine->data_buffer, cmd_ret->data_len);
>
> Should we limit the memcpy to `count`?
>
> I mean, can happen that `count` is less than `cmd_ret->data_len`?

Hi, Stefan, thanks for your comment.

Firmware ensures "cmd_ret->data_len" will be less than TPM_BUFSIZE,  so 
this would never happen.

BR, Qunqin.

>
> Thanks,
> Stefano


