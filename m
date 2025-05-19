Return-Path: <linux-integrity+bounces-6247-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A12FABB6D6
	for <lists+linux-integrity@lfdr.de>; Mon, 19 May 2025 10:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497E6162F3E
	for <lists+linux-integrity@lfdr.de>; Mon, 19 May 2025 08:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88F7269CE5;
	Mon, 19 May 2025 08:13:43 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E09D269885;
	Mon, 19 May 2025 08:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747642423; cv=none; b=cEEWrWyDYl1owx0rd/9D+6uQqbNFjmAbhYwcz8xbSPxzy1JGILdGqTA2d6my/NHAST8NynPJGQPYd4ZsX1ADUwtTWZ2dX9VGctOI75+QlDZSyihAY8Wt9qo4H2HnaY/PN2Irv7xcpMwj+WrB3KfRgGjG7s3jGkven9Ya2MuFGog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747642423; c=relaxed/simple;
	bh=hQJb+rSuN5NRKVmNVjXcsHsg8v8QYtvYq2QUlt01j/E=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Fdy4bbxg+4/9ntOOrGydlGtCsS+YD5iZVWDp40c/em7/+IMvnHwcZ6p0NHsJe+AMxejWOWKXgE3DTb1aFr+/+D4CtEqy9bLsYX2SMWtkPeQKTz5KXDuUI5I4Uu/MaDWFq49UVffyotiTvOWXZBQtwHcy4dDKbk9OxIv9Zcdpoc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8AxSWoy6CpozdfxAA--.28469S3;
	Mon, 19 May 2025 16:13:38 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front1 (Coremail) with SMTP id qMiowMBxXRsv6CpocNHgAA--.22895S2;
	Mon, 19 May 2025 16:13:37 +0800 (CST)
Subject: Re: [PATCH v9 2/5] crypto: loongson - add Loongson RNG driver support
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: lee@kernel.org, davem@davemloft.net, peterhuewe@gmx.de,
 jarkko@kernel.org, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linux-crypto@vger.kernel.org, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
 pmenzel@molgen.mpg.de, Yinggang Gu <guyinggang@loongson.cn>,
 Huacai Chen <chenhuacai@loongson.cn>
References: <20250506031947.11130-1-zhaoqunqin@loongson.cn>
 <20250506031947.11130-3-zhaoqunqin@loongson.cn>
 <aCrIL_ZXL-UtaLdJ@gondor.apana.org.au>
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
Message-ID: <96118a23-3e6c-c9d1-2135-bd7a22091f35@loongson.cn>
Date: Mon, 19 May 2025 16:13:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aCrIL_ZXL-UtaLdJ@gondor.apana.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMBxXRsv6CpocNHgAA--.22895S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrurWkKw15Jr4xZFW3Gr1fXwc_yoWDZFX_uF
	yIvF1kWr95AayfW343KFyxXF1jq3yagFy8W340y3s7Xw47Ja95ZF48Kr1Sva97XFyrur9x
	Wrs8XFWFkr1IgosvyTuYvTs0mTUanT9S1TB71UUUUj7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbDAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Cr1j6rxdM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMx
	k0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j5o7tUUUUU=


在 2025/5/19 下午1:57, Herbert Xu 写道:
> On Tue, May 06, 2025 at 11:19:44AM +0800, Qunqin Zhao wrote:
>> +static int loongson_rng_init(struct crypto_tfm *tfm)
>> +{
>> +	struct loongson_rng_ctx *ctx = crypto_tfm_ctx(tfm);
>> +	struct loongson_rng *rng;
>> +	int ret = -EBUSY;
>> +
>> +	mutex_lock(&rng_devices.lock);
>> +	list_for_each_entry(rng, &rng_devices.list, list) {
>> +		if (!rng->is_used) {
>> +			rng->is_used = true;
>> +			ctx->rng = rng;
>> +			ret = 0;
>> +			break;
>> +		}
>> +	}
>> +	mutex_unlock(&rng_devices.lock);
>> +
>> +	return ret;
>> +}
> This isn't right.  The number of TFMs in the system is unlimited.
> You should not pair each tfm with an individual hardwre device.
Then the HISI TRNG driver isn't a right demo?
>
> If you want to do load-balancing you could certainly pick a device
> per tfm, but each device must be able to support an unlimited number
> of tfms.

This can also avoid concurrent access to a device, otherwise i need to

add mutex_lock/unlock in generate and seed callback.

Thanks,

Qunqin.

>
> Cheers,


