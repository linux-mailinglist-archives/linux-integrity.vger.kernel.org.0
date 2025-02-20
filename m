Return-Path: <linux-integrity+bounces-4925-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9286AA3D81B
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 12:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 748FA176CA9
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 11:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC5C1DE2C6;
	Thu, 20 Feb 2025 11:16:08 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21AD1E3DCF;
	Thu, 20 Feb 2025 11:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050168; cv=none; b=SdIdoRm2t57+0RncEAhfXOj5sGmeZw6RAIKlwf0LcF0yIVFDU2v+HmZQuUjSaWI+rSE4Mohmv7GECUiMLAjmL6WIKtQpHDzwfsuysntrku1SAP3HcC4eEsZ+IzN7tbmCCTyA7SmUaMcEIKdoIeYet11Hz2dYwMCjTSiT2ZoQIYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050168; c=relaxed/simple;
	bh=tmGgvBNAnq61lJyHREpltjLswH1cV6NcConZTvqEWJ0=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ZKnzDDMZZuFBuCW5ln4Ii7dBmW1H+h4bvr0C1Xyn9EdtpIiieHjx1I7s35dOCFfcmKLR9vI1pT2TgzjoocOroJLGjopvv5a0xlP3Gu0thxcE8Y46AYuinobapnEPsY0Cam93zN1sr63z/CJJ8gWUPlSEgW4o870rcTsZxGQ/gjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8Bx12nzDrdnczh8AA--.17704S3;
	Thu, 20 Feb 2025 19:16:03 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front1 (Coremail) with SMTP id qMiowMBxm8TwDrdnwzEeAA--.6689S2;
	Thu, 20 Feb 2025 19:16:02 +0800 (CST)
Subject: Re: [PATCH V3 2/6] MAINTAINERS: Add maintainer for Loongson Security
 Module driver
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: lee@kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net,
 peterhuewe@gmx.de, jarkko@kernel.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-crypto@vger.kernel.org, jgg@ziepe.ca,
 linux-integrity@vger.kernel.org
References: <20250219073214.16866-1-zhaoqunqin@loongson.cn>
 <20250219073214.16866-3-zhaoqunqin@loongson.cn>
 <82eadd04-26ed-4560-9a9d-2a55ab72a84b@molgen.mpg.de>
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
Message-ID: <57261bdc-412d-1f0b-4847-3fd0d4828c55@loongson.cn>
Date: Thu, 20 Feb 2025 19:16:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <82eadd04-26ed-4560-9a9d-2a55ab72a84b@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMBxm8TwDrdnwzEeAA--.6689S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7tr13Kw1xGFy7KryDZFykXrc_yoW8Ar4DpF
	1kAanxCr97Kw4Ikws7Ga4Yka45Z3s7Cr17JFnFga4kuasFyw1qqF4j9F1q9FnrXF48Wr4x
	try2yr45uF4UuacCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
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


在 2025/2/19 下午3:48, Paul Menzel 写道:
> Dear Qunqin,
>
>
> Thank you for your patch, and for wanting to maintain this code. Two 
> minor things should you resend:
>
> I found it quite useful to have the maintainer name in the 
> summary/title as often only the `git log --oneline` output is used in 
> change-logs. I suggest:
>
> MAINTAINERS: Add Qunqin Zhao for new Loongson Security Module driver

Hi, Paul,  thanks for your comments.

I took a look at the git log of MAINTAINERS file.  It is rare to put the 
maintainer's name on the title when adding a new entry.

The usual practice should be "Add entry for Loongson Security Module 
driver".

>
> Am 19.02.25 um 08:32 schrieb Qunqin Zhao:
>> This patch adds an entry for Loongson Security Module driver in the list
>> of Maintainers.
>
> Maintainers could be spelled lowercase.

OK.

BR, Qunqin.

>
>> Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
>> ---
>>   MAINTAINERS | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 5583df569c..cd6c029398 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -13494,6 +13494,13 @@ S:    Maintained
>>   F: Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml
>>   F:    drivers/i2c/busses/i2c-ls2x.c
>>   +LOONGSON SECURITY MODULE DRIVER
>> +M:    Qunqin Zhao <zhaoqunqin@loongson.cn>
>> +L:    loongarch@lists.linux.dev
>> +S:    Maintained
>> +F:    drivers/mfd/ls6000se.c
>> +F:    include/linux/mfd/ls6000se.h
>> +
>>   LOONGSON-2 SOC SERIES CLOCK DRIVER
>>   M:    Yinbo Zhu <zhuyinbo@loongson.cn>
>>   L:    linux-clk@vger.kernel.org
>
>
> Kind regards,
>
> Paul


