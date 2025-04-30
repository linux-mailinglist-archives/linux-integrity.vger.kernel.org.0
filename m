Return-Path: <linux-integrity+bounces-6087-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5666AA4697
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 11:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 896407A6405
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 09:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B15221292;
	Wed, 30 Apr 2025 09:12:10 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AD22206B1;
	Wed, 30 Apr 2025 09:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746004330; cv=none; b=SOP2ffU/nBnpTZa5gLGdVZJqhE+Pk/h7wR/DpEKSHUG8hx23aKZVXtXbgnCAVPa8esYpgVcyXdC5WtnWycS7Y3uUNEwnUs2ZYQtC2NyXNdLeTJwUgJySVPMa2U4BrMUQaMv3vBZkJtE0kS++KzjZ3xccGI4YoJmUbLz5S4g0DZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746004330; c=relaxed/simple;
	bh=Qk0DryjXIt3ss4um7MXcOMei15BeSthVbi80x1XAoCM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KY9EtUjBjPV+8tp06tiIIkcGKfNpfCWWD9PUdZbmyVx5HkpTkSvF+4JAbeF+LpfMgtqUhEKO2YRQYcTc5+645ULIPB7xWhOxBj4HDbpPIS63VkN/fxRmR5OChlQM7YIDVU8NuuERvekvokts7wXzlNqDabtLHs1fzGqwU1KahAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8Bx32tj6RFoAADLAA--.8960S3;
	Wed, 30 Apr 2025 17:12:03 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front1 (Coremail) with SMTP id qMiowMAxHsdb6RFocwSgAA--.44342S2;
	Wed, 30 Apr 2025 17:11:57 +0800 (CST)
Subject: Re: [PATCH v8 0/5] Add Loongson Security Engine chip driver
To: Lee Jones <lee@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, jarkko@kernel.org
Cc: davem@davemloft.net, peterhuewe@gmx.de, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-crypto@vger.kernel.org, jgg@ziepe.ca,
 linux-integrity@vger.kernel.org, pmenzel@molgen.mpg.de
References: <20250418093506.1349-1-zhaoqunqin@loongson.cn>
 <CAAhV-H608_ddH0g0gyFCZSTVxYHOBqLXrtGYxZ1eoXX6eCcEuA@mail.gmail.com>
 <75bb29fa-6d77-6f95-eec4-ee183190da17@loongson.cn>
 <aBHc2tT2-Duj3_-A@gondor.apana.org.au>
 <6b7385ce-d8ad-1be9-4503-55460f40fe72@loongson.cn>
 <CAAhV-H6ku=imPGqaFrey6hCMwXSL4Qsoif9Rv=Gko2R1CBtGmw@mail.gmail.com>
 <20250430085809.GD1567507@google.com>
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
Message-ID: <0f2a34ce-3e4b-7dda-4835-34bfd0ef60fc@loongson.cn>
Date: Wed, 30 Apr 2025 17:10:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20250430085809.GD1567507@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMAxHsdb6RFocwSgAA--.44342S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7tFy7Cr4rWrW8WrWfKrWrtFc_yoW8Wr1kpF
	47Jay2kF4Dtr4Fk3sFqr48AFyYy3s3tryFgr98Gas5Zas0vFyrAw4UGFWjkFWDZ3W8Jr1j
	vF48AayS9F15ZabCm3ZEXasCq-sJn29KB7ZKAUJUUUU3529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1D
	McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7
	I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWrXVW3AwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
	0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jFApnUUUUU=


在 2025/4/30 下午4:58, Lee Jones 写道:
> On Wed, 30 Apr 2025, Huacai Chen wrote:
>
>> On Wed, Apr 30, 2025 at 4:47 PM Qunqin Zhao <zhaoqunqin@loongson.cn> wrote:
>>>
>>> 在 2025/4/30 下午4:18, Herbert Xu 写道:
>>>> On Wed, Apr 30, 2025 at 04:14:40PM +0800, Qunqin Zhao wrote:
>>>>> Sorry to bother you, may i ask is it fine to move  the Security Engine base
>>>>> driver[Patch v8 1/5] to drivers/crypto ?
>>>>>
>>>>> The base driver uses MFD  interface  to register child device(tpm, rng) , as
>>>>> done in
>>>>>
>>>>> "drivers/iio/common/ssp_sensors/ssp_dev.c" and
>>>>> "drivers/firmware/xilinx/zynqmp.c".
>>>>>
>>>>> Thank you, and I look forward to hearing from you.
>>>> I don't mind at this point in time.  But if this driver were to
>>>> develop features way outside of the Crypto API in future then I
>>>> may change my mind.
>>> Hi, Herbert, thanks for your reply.
>>>
>>> In future it just add child platform devices  name(sm2, sm3, sm4) to
>>> "struct  mfd_cell engines".
>>>
>>>
>>> Hi, Huaci
>>>
>>> Let's go via Herbert's crypto tree for the base driver patch under
>>> drivers/crypto/loongson/,
>>>
>>> What do you think of it?
>> In my opinion drivers/mfd is better, because another user is in
>> drivers/char rather than drivers/crypto.
>>
>> But if moving to drivers/crypto is what Lee Jones wants, then everything is OK.
> You can move the driver, but then you must not reference or use the MFD API.

Then looks like i should move it back to drivers/mfd,  will do that in 
next revision.

Thank you very much for everyone's replies.

BR, Qunqin.

>


