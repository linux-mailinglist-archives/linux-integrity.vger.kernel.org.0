Return-Path: <linux-integrity+bounces-6336-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D16AC75CA
	for <lists+linux-integrity@lfdr.de>; Thu, 29 May 2025 04:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 620534E79AF
	for <lists+linux-integrity@lfdr.de>; Thu, 29 May 2025 02:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63ABB244186;
	Thu, 29 May 2025 02:17:13 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FB4242D74;
	Thu, 29 May 2025 02:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748485033; cv=none; b=hf/BylIZec8EUF3doJpotMgnJ6B+ci2fay7IUKvzFZS3LKRlCjz1oj6EWaP+lDFE1pE3GaTMFZZfP1mpZeuHQpHYrfnUtnXiZVnjHig+klJu/R7Jk8GaxQzxsH4f3WnvIiJu0An1sQjuzVl1Mnopcj+t1UmitGtXKDxkLbRXx4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748485033; c=relaxed/simple;
	bh=BXnpxy5x+WlgemioBql8EwhnNFniZqjZLbYpZqfqrmY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=j/MHGqe4KtcOyOSP+5Bt60FPbmSi+RACsKTU1BiNqLzRdxhQ79d9v7QG7Ud3UvPPZ5QMDQqS/c+4SNqkAbmg3zr+yxSgdFw6J/RvWeaTrUBUOX6HBGkIK3dQQF0tx5mIRJHFr7dHswW/9fO6WWKNnIbNLJ0HbYDz8auoVOtrRh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8BxrnKjwzdoZzQBAQ--.21261S3;
	Thu, 29 May 2025 10:17:07 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front1 (Coremail) with SMTP id qMiowMCxasSewzdoE2L5AA--.61626S2;
	Thu, 29 May 2025 10:17:04 +0800 (CST)
Subject: Re: [PATCH v10 4/5] tpm: Add a driver for Loongson TPM device
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: lee@kernel.org, herbert@gondor.apana.org.au, jarkko@kernel.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 davem@davemloft.net, linux-crypto@vger.kernel.org, peterhuewe@gmx.de,
 jgg@ziepe.ca, linux-integrity@vger.kernel.org,
 Yinggang Gu <guyinggang@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>
References: <20250528065944.4511-1-zhaoqunqin@loongson.cn>
 <20250528065944.4511-5-zhaoqunqin@loongson.cn>
 <7ifsmhpubkedbiivcnfrxlrhriti5ksb4lbgrdwhwfxtp5ledc@z2jf6sz4vdgd>
 <afaeb91a-afb4-428a-2c17-3ea5f098da22@loongson.cn>
 <gymx5tbghi55gm76ydtuzzd6r522expft36twwtvpkbgcl266a@zelnthnhu7kq>
 <ccb1927d-c06a-9fde-6cbb-652974464f4b@loongson.cn>
 <cfaf2fbb-5c6a-9f85-fdc9-325d82fb7821@loongson.cn>
 <45xqguhrecn57cwc66hfws4eeqrb6rlijvh2z35e56ogojc2q4@pnlrgx57353b>
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
Message-ID: <7a0c5eae-f6c7-f2dc-9356-5419c7df4f6a@loongson.cn>
Date: Thu, 29 May 2025 10:16:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <45xqguhrecn57cwc66hfws4eeqrb6rlijvh2z35e56ogojc2q4@pnlrgx57353b>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMCxasSewzdoE2L5AA--.61626S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cr4UWFyrtF4fGFW8WrWkXwc_yoW5Jr1rpr
	y7W3W7GFWDJr48tr1qqw4jyFZFkF4kAw45ZryrXr93J34qyrnaqF1UtrsY9rZF9r4xJ34x
	XF4Yv3y3Wa45ZrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0c
	Ia020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
	WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	CYjI0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48J
	MxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
	IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8_gA5UUUU
	U==


在 2025/5/28 下午5:53, Stefano Garzarella 写道:
> On Wed, May 28, 2025 at 05:34:49PM +0800, Qunqin Zhao wrote:
>>
>> 在 2025/5/28 下午5:24, Qunqin Zhao 写道:
>>>
>>> 在 2025/5/28 下午5:00, Stefano Garzarella 写道:
>>>> On Wed, May 28, 2025 at 04:42:05PM +0800, Qunqin Zhao wrote:
>>>>>
>>>>> 在 2025/5/28 下午3:57, Stefano Garzarella 写道:
>>>>>>> +    chip = tpmm_chip_alloc(dev, &tpm_loongson_ops);
>>>>>>> +    if (IS_ERR(chip))
>>>>>>> +        return PTR_ERR(chip);
>>>>>>> +    chip->flags = TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_IRQ;
>>>>>>
>>>>>> Why setting TPM_CHIP_FLAG_IRQ?
>>>>>
>>>>> When tpm_engine completes  TPM_CC* command,
>>>>>
>>>>> the hardware will indeed trigger an interrupt to the kernel.
>>>>
>>>> IIUC that is hidden by loongson_se_send_engine_cmd(), that for this 
>>>> driver is completely synchronous, no?
>>>>
>>>>>
>>>>>>
>>>>>> IIUC this driver is similar to ftpm and svsm where the send is 
>>>>>> synchronous so having .status, .cancel, etc. set to 0 should be 
>>>>>> enough to call .recv() just after send() in tpm_try_transmit(). 
>>>>>> See commit 980a573621ea ("tpm: Make 
>>>>>> chip->{status,cancel,req_canceled} opt")
>>>>> The send callback would wait until the TPM_CC* command complete. 
>>>>> We don't need a poll.
>>>>
>>>> Right, that's what I was saying too, send() is synchronous (as in 
>>>> ftpm and svsm). The polling in tpm_try_transmit() is already 
>>>> skipped since we are setting .status = 0, .req_complete_mask = 0, 
>>>> .req_complete_val = 0, etc. so IMHO this is exactly the same of 
>>>> ftpm and svsm, so we don't need to set TPM_CHIP_FLAG_IRQ.
>>>
>>> I see,  but why not skip polling directly in "if (chip->flags & 
>>> TPM_CHIP_FLAG_IRQ)"  instead of do while?
>>
>> I mean, why not skip polling directly in "if (chip->flags & 
>> TPM_CHIP_FLAG_IRQ)"?
>>
>> And In my opinion, TPM_CHIP_FLAG_SYNC and TPM_CHIP_FLAG_IRQ are 
>> essentially the same, only with different names.
>
> When TPM_CHIP_FLAG_SYNC is defined, the .recv() is not invoked and 
> .send() will send the command and retrieve the response. For some 
> driver like ftpm this will save an extra copy/buffer.

I need to copy the data to the DMA data buffer. So my suggestion is to 
let the vendor specific driver  decide whether to use the SYNC or IRQ flag.

IRQ flag is fine for me.

Thanks,

Qunqin.

>
> Stefano


