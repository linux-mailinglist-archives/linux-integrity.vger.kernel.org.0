Return-Path: <linux-integrity+bounces-6324-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41010AC64AB
	for <lists+linux-integrity@lfdr.de>; Wed, 28 May 2025 10:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A3869E652A
	for <lists+linux-integrity@lfdr.de>; Wed, 28 May 2025 08:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842032741A6;
	Wed, 28 May 2025 08:43:18 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F711F0992;
	Wed, 28 May 2025 08:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748421798; cv=none; b=GrUJn16wkQjFMU0p7Wq2vzLh6go5C3veKIyp0u4bJ0ytCGiGIHKbXrlGL7KUMR8Y2F7sjZ4o+vkcbb42QLhA8jjVACNDKL5VjgEKfoxDLWZNfRahV1ESCORYg2qBfdZzlT8gTxEIg0u1gAvE87dhzyron16eL4F2gb7RxI7wDKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748421798; c=relaxed/simple;
	bh=MxnGdClLFWl1jY7LIi7McbBUXxSTG4DC87SB7p2eWgQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=lY3nA3Mp8Ag9XYsCAoZvyt0+opDoRItqrUE1uIpmZEtN3fl08DO0r1ZRzIC49/E1REJw4Uojg+fsTw5QS6h+tAK3PS4t+1fHj/jhbHBKJ+abEONXNQGanArFrfB3Lu4E5mAB1+wpOpPR1FoZHYr9FURphtp3QaUjIQ9M/LXix5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8AxnOKdzDZokNP_AA--.49136S3;
	Wed, 28 May 2025 16:43:09 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front1 (Coremail) with SMTP id qMiowMCxLBuWzDZonpz3AA--.26840S2;
	Wed, 28 May 2025 16:43:04 +0800 (CST)
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
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
Message-ID: <afaeb91a-afb4-428a-2c17-3ea5f098da22@loongson.cn>
Date: Wed, 28 May 2025 16:42:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7ifsmhpubkedbiivcnfrxlrhriti5ksb4lbgrdwhwfxtp5ledc@z2jf6sz4vdgd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMCxLBuWzDZonpz3AA--.26840S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoW7XF13Cr1kXF18CF17KFy8JFc_yoWDtrX_Ka
	y5WF1rua4UCr4DJa1DCr4fuF17K3y2qF1IyayUtrWIyryDJan5AFs5J395Kr1fGa18CrZ8
	Cr9Ig3Z3Zw13XosvyTuYvTs0mTUanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbDAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
	oVCq3wAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa02
	0Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1l
	Yx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI
	0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
	W8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jFApnUUUUU=


在 2025/5/28 下午3:57, Stefano Garzarella 写道:
>> +    chip = tpmm_chip_alloc(dev, &tpm_loongson_ops);
>> +    if (IS_ERR(chip))
>> +        return PTR_ERR(chip);
>> +    chip->flags = TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_IRQ;
>
> Why setting TPM_CHIP_FLAG_IRQ?

When tpm_engine completes  TPM_CC* command,

the hardware will indeed trigger an interrupt to the kernel.

>
> IIUC this driver is similar to ftpm and svsm where the send is 
> synchronous so having .status, .cancel, etc. set to 0 should be enough 
> to call .recv() just after send() in tpm_try_transmit(). See commit 
> 980a573621ea ("tpm: Make chip->{status,cancel,req_canceled} opt")
The send callback would wait until the TPM_CC* command complete. We 
don't need a poll.

Thanks,

Qunqin.

>
> BTW, I think I should touch also this driver in the next version of my 
> series that I'll send after the merge window:
> https://lore.kernel.org/linux-integrity/20250514134630.137621-1-sgarzare@redhat.com/ 
>
>
> The rest LGTM!
>
> Thanks,
> Stefano


