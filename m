Return-Path: <linux-integrity+bounces-6327-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AB9AC65DF
	for <lists+linux-integrity@lfdr.de>; Wed, 28 May 2025 11:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AD114E1C33
	for <lists+linux-integrity@lfdr.de>; Wed, 28 May 2025 09:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1ADD27780E;
	Wed, 28 May 2025 09:25:38 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B261227816E;
	Wed, 28 May 2025 09:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748424338; cv=none; b=rbP6J4bOLx88tpYLz+bSJLzGB5qs2xZb/5aDMAkDvzNxem2t/NMIVtiyHju3pSu5XULCCnWsN2wWPX5PM/2cuse+uosPdZzg4lmPrDNgs+gDRSLs1zk7hbRSNL11Eyqm34u4RVrLAadzSUS8owY4E3mgjTDJjMwHNrbDBfH+IMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748424338; c=relaxed/simple;
	bh=WPpeY/zBkK9qBadSKYMZngbU/LDpStkIL2YVjLK9fEo=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=gn/SbIuiD2JYFp+1P7Uca/YUMfeZzUX4GCz9dvMvHNIAPy28hqmH7g1lkuPSTsZ2IV5Hs81zbtwcjL1tOXTE/a9hoqk4ngGrjEmYvowMwtW7IbcBboS/VTqDGyPdtXQZyTUR54kZYJXgX1zYwKwhH8pexyWAKqZgd0tqjOAnaFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8AxaeGM1jZoeeD_AA--.40694S3;
	Wed, 28 May 2025 17:25:32 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front1 (Coremail) with SMTP id qMiowMAxTsWH1jZoY6_3AA--.63172S2;
	Wed, 28 May 2025 17:25:29 +0800 (CST)
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
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
Message-ID: <ccb1927d-c06a-9fde-6cbb-652974464f4b@loongson.cn>
Date: Wed, 28 May 2025 17:24:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <gymx5tbghi55gm76ydtuzzd6r522expft36twwtvpkbgcl266a@zelnthnhu7kq>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMAxTsWH1jZoY6_3AA--.63172S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7tr1rXryUJFyfZr13WF1fXwc_yoW8WF1xp3
	47Way7Gay3Jr48tw1qqa1jyFZF9Fs5Aa1UCas5Xr9ay3s8trnIgF10qrsYgF47uw4xW34f
	XF45Z39xua4YvrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
	McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
	I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVW8ZVWrXwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
	0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4SoGDUUUU


在 2025/5/28 下午5:00, Stefano Garzarella 写道:
> On Wed, May 28, 2025 at 04:42:05PM +0800, Qunqin Zhao wrote:
>>
>> 在 2025/5/28 下午3:57, Stefano Garzarella 写道:
>>>> +    chip = tpmm_chip_alloc(dev, &tpm_loongson_ops);
>>>> +    if (IS_ERR(chip))
>>>> +        return PTR_ERR(chip);
>>>> +    chip->flags = TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_IRQ;
>>>
>>> Why setting TPM_CHIP_FLAG_IRQ?
>>
>> When tpm_engine completes  TPM_CC* command,
>>
>> the hardware will indeed trigger an interrupt to the kernel.
>
> IIUC that is hidden by loongson_se_send_engine_cmd(), that for this 
> driver is completely synchronous, no?
>
>>
>>>
>>> IIUC this driver is similar to ftpm and svsm where the send is 
>>> synchronous so having .status, .cancel, etc. set to 0 should be 
>>> enough to call .recv() just after send() in tpm_try_transmit(). See 
>>> commit 980a573621ea ("tpm: Make chip->{status,cancel,req_canceled} 
>>> opt")
>> The send callback would wait until the TPM_CC* command complete. We 
>> don't need a poll.
>
> Right, that's what I was saying too, send() is synchronous (as in ftpm 
> and svsm). The polling in tpm_try_transmit() is already skipped since 
> we are setting .status = 0, .req_complete_mask = 0, .req_complete_val 
> = 0, etc. so IMHO this is exactly the same of ftpm and svsm, so we 
> don't need to set TPM_CHIP_FLAG_IRQ.

I see,  but why not skip polling directly in "if (chip->flags & 
TPM_CHIP_FLAG_IRQ)"  instead of do while?

And TPM_CHIP_FLAG_IRQ flag can remind us this hardware is "IRQ" not "POLL".

Thanks,

Qunqin.

>
> Thanks,
> Stefano


