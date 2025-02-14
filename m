Return-Path: <linux-integrity+bounces-4829-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8DEA3538B
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Feb 2025 02:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C042916CDE8
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Feb 2025 01:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE553595C;
	Fri, 14 Feb 2025 01:12:07 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E072746B;
	Fri, 14 Feb 2025 01:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739495527; cv=none; b=GzaOIZsL7HeiaROogdYwJ8LRnJxRSd4rClKQmuWzieeo6LqHUC6RfDOYP9/4EtebfZSZQmuXgZPbXer9wJH+zpjknQiz2artZkWqH/V1qPoKdGLhuWDqNOBu2aWaX9idZ8UpW2tQD0w57oqByUTufrF/1/9NxVuehE+k8Ztj90U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739495527; c=relaxed/simple;
	bh=EzldPKqL3LAA14BzaUNue2LoVJXYI+QCGXKPYLf8IpE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RX2DhGSm96zrdfxF8P/iodvGM/owGmRZq0GIl5+AYraYsNyfb1MMp1xue0ynPzaSEyaZ82mRDuXhiGpZBCcnBVR9LqH62oM+bQpZS3Sytl0VlnMfl93GtTd36cWAlrLlUaxbgMVHA2MU/Xy5aei4+0sEGW6Y3t/H846N2jUWSkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8DxvnNbmK5nn+N0AA--.39658S3;
	Fri, 14 Feb 2025 09:11:55 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front1 (Coremail) with SMTP id qMiowMBxGcRPmK5ndCgRAA--.1798S2;
	Fri, 14 Feb 2025 09:11:46 +0800 (CST)
Subject: Re: [PATCH v2 3/3] tpm: Add a driver for Loongson TPM device
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: lee@kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net,
 peterhuewe@gmx.de, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linux-crypto@vger.kernel.org, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
 Yinggang Gu <guyinggang@loongson.cn>
References: <20250212033113.15137-1-zhaoqunqin@loongson.cn>
 <20250212033113.15137-4-zhaoqunqin@loongson.cn> <Z60SfDaWnbgddUnA@kernel.org>
 <c825cd7b-a255-d296-baa0-c1a746cb1bce@loongson.cn>
 <Z65tuC722nnuhWEO@kernel.org>
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
Message-ID: <0c7982a4-a8bd-77fd-86b3-ed2d2451ed0a@loongson.cn>
Date: Fri, 14 Feb 2025 09:12:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z65tuC722nnuhWEO@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMBxGcRPmK5ndCgRAA--.1798S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7KF4kuFWfKrWkGw18tFyrAFc_yoW8GrW5pr
	1kAFn5Cry7Gr47K3sIq3y5CrnYq3s2qF9rur9rtw1qqr90ya43Jr1UtF1UCrs8Xr1rGrW0
	qrZayr43Ka1Yv3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
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


在 2025/2/14 上午6:10, Jarkko Sakkinen 写道:
>>>> for it.
>>>>
>>>> Co-developed-by: Yinggang Gu <guyinggang@loongson.cn>
>>>> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
>>>> Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
>>>> ---
>>>>    MAINTAINERS                 |   1 +
>>>>    drivers/char/tpm/Kconfig    |   9 ++++
>>>>    drivers/char/tpm/Makefile   |   1 +
>>>>    drivers/char/tpm/tpm_lsse.c | 104 ++++++++++++++++++++++++++++++++++++
>>>>    4 files changed, 115 insertions(+)
>>>>    create mode 100644 drivers/char/tpm/tpm_lsse.c
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 6493d58436..6aad0f08ad 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -13484,6 +13484,7 @@ LOONGSON CRYPTO DRIVER
>>>>    M:	Qunqin Zhao <zhaoqunqin@loongson.com>
>>>>    L:	linux-crypto@vger.kernel.org
>>>>    S:	Maintained
>>>> +F:	drivers/char/tpm/tpm_lsse.c
>>>>    F:	drivers/crypto/loongson/
>>>>    LOONGSON-2 APB DMA DRIVER
>>> Probably MAINTAINERS update should be a separate patch.
>> Some  MAINTAINERS updates are not  separated form the driver patch.  Like
>> the submit of "drivers/mfd/max7714*".
>>
>> So it seems whether the updates to MAINTAINERS  are separated or not is OK.
> I'd prefer them separated from code changes. They are separate tasks
> per se.

OK, thanks.

BR, Qunqin.

>
> BR, Jarkko


