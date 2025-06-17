Return-Path: <linux-integrity+bounces-6459-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4D9ADC729
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Jun 2025 11:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8707A18997FF
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Jun 2025 09:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EE52E7F00;
	Tue, 17 Jun 2025 09:50:26 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101A62BFC67;
	Tue, 17 Jun 2025 09:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750153826; cv=none; b=bNzm4RLaUTng/qLzRsk3wfQIIrs7qC3kdwj8rM3R5skkxiQg90xjbnl9dU4mE7uon6QrIo/BrdYcc+MZ3j31M6Wz90AjJyZHzoihW8JLgtmPWQOz9Gl1dWA/SX+TbHGTZ9YUrjfM5IOt18YGT89Jw+ri8tKL4/vv6S8oZmxeZYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750153826; c=relaxed/simple;
	bh=5GsdevIxGH4DwmsS8ehE6KbJIaaZA2uhhha9UifZLhk=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uJ5L/KY6sTSlIks7KRqod7M3zzo2CSDsbAEUQs/mQm3KnYzwD6pH0nWd69twft4EGxumLW5aiNYjPklMhU9kK6K7YYvrvegSoy82BMFbVyiBRaN2LDZTTYhBy9idL/g4S+p9Yfaww7KuZRfSjx5pTdobzOIsQN7tjUBv1uHabdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8Cx_eJcOlFoZk4YAQ--.15430S3;
	Tue, 17 Jun 2025 17:50:20 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front1 (Coremail) with SMTP id qMiowMBxnhtYOlFoqyoeAQ--.32990S2;
	Tue, 17 Jun 2025 17:50:18 +0800 (CST)
Subject: Re: [PATCH v10 2/5] crypto: loongson - add Loongson RNG driver
 support
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: lee@kernel.org, jarkko@kernel.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, davem@davemloft.net,
 linux-crypto@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
 linux-integrity@vger.kernel.org, Yinggang Gu <guyinggang@loongson.cn>,
 Huacai Chen <chenhuacai@loongson.cn>
References: <20250528065944.4511-1-zhaoqunqin@loongson.cn>
 <20250528065944.4511-3-zhaoqunqin@loongson.cn>
 <aElLJY9MnkEQx935@gondor.apana.org.au>
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
Message-ID: <4efdb35f-dfb0-c44f-b3ec-7ca98717820c@loongson.cn>
Date: Tue, 17 Jun 2025 17:49:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aElLJY9MnkEQx935@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMBxnhtYOlFoqyoeAQ--.32990S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrZr4rKw45ZFW8tFyrtr1kJFc_yoW3JFXEqa
	n2v3s8ur97CF4rX34akr4rWry8GFW3tFZ2grykZayxtw4fXa98uF48ur1a9F4qgryfCr93
	urn8G39Yqr1UWosvyTuYvTs0mTUanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbDxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0
	oVCq3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa02
	0Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1l
	Yx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI
	0SjxkI62AI1cAE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
	W8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcpBTUUUUU


在 2025/6/11 下午5:23, Herbert Xu 写道:
> On Wed, May 28, 2025 at 02:59:41PM +0800, Qunqin Zhao wrote:
>> +	if (!rng_devices.is_init) {
>> +		ret = crypto_register_rng(&loongson_rng_alg);
>> +		if (ret) {
>> +			dev_err(&pdev->dev, "failed to register crypto(%d)\n", ret);
>> +			return ret;
>> +		}
>> +		INIT_LIST_HEAD(&rng_devices.list);
>> +		mutex_init(&rng_devices.lock);
>> +		rng_devices.is_init = true;
>> +	}
> This doesn't look right.  What stops two devices from both entering
> this code path when is_init == false?

Will use __MUTEX_INITIALIZER  macro to statically initialize 
rng_devices. lock,

and then use this lock to stop two devices form both entering this code 
path.


Thanks,

Qunqin

>
> Cheers,


