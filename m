Return-Path: <linux-integrity+bounces-6249-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A7FABB7DC
	for <lists+linux-integrity@lfdr.de>; Mon, 19 May 2025 10:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CB6D3AFA54
	for <lists+linux-integrity@lfdr.de>; Mon, 19 May 2025 08:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AC4269D15;
	Mon, 19 May 2025 08:50:18 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D342698AF;
	Mon, 19 May 2025 08:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747644618; cv=none; b=l1aW7va7Ia5m906u0IeeaSIxrvKK4VdajWqGdft5bnDqUwMmdadLHA6PRrRX8m/Sq9ua8EEzTmOLxlFDv0VQq3YQlH5oo+piCIr8kaL9SK58Q4QjAOaAjj70IiMVovmVlQgSgSBwBL5op/+9ZOao5641ek8lTzHyA7Ytj8AhLso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747644618; c=relaxed/simple;
	bh=3/aKAxEYGjMiRNH1CNkgSZ1LCzghaLEQ1Gs3l8ksbeM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=k9OjcXVtYWpZovBRukwxe73S69+xlJ667g7q+/2rfJESAcHh1BuMzTKFACbU+PXbxAiW2vRJv2Ny4LtuNgT78bWFxAGnWXWt548P9Q9XRz8Pw+3z4ixHp3u7w+CYDjnmfC8+YE0K9fyabyEdEIhbgK56P2IEVEIQWdhdYTAUOgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.20.42.164])
	by gateway (Coremail) with SMTP id _____8AxGHHC8Cpo6uHxAA--.63S3;
	Mon, 19 May 2025 16:50:10 +0800 (CST)
Received: from [10.20.42.164] (unknown [10.20.42.164])
	by front1 (Coremail) with SMTP id qMiowMDxesS+8Cpoa+LgAA--.57455S2;
	Mon, 19 May 2025 16:50:08 +0800 (CST)
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
 <96118a23-3e6c-c9d1-2135-bd7a22091f35@loongson.cn>
 <aCrqPnwr7lMJNOnL@gondor.apana.org.au>
From: Qunqin Zhao <zhaoqunqin@loongson.cn>
Message-ID: <9d70efaf-1d68-f8e5-d9a6-cd312fc99529@loongson.cn>
Date: Mon, 19 May 2025 16:49:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aCrqPnwr7lMJNOnL@gondor.apana.org.au>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:qMiowMDxesS+8Cpoa+LgAA--.57455S2
X-CM-SenderInfo: 52kd01pxqtx0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUUm0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x02
	67AKxVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
	I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2
	jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62
	AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxAqzxv262kKe7AKxVWUAVWUtwCF54CYxVCY
	1x0262kKe7AKxVWUAVWUtwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVW8ZV
	WrXwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
	1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6x
	IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
	x4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvj
	DU0xZFpf9x07jOb18UUUUU=


ÔÚ 2025/5/19 ÏÂÎç4:22, Herbert Xu Ð´µÀ:
> On Mon, May 19, 2025 at 04:13:14PM +0800, Qunqin Zhao wrote:
>> Then the HISI TRNG driver isn't a right demo?
> Yes the hisi trng looks wrong too.
>
>> This can also avoid concurrent access to a device, otherwise i need to
>>
>> add mutex_lock/unlock in generate and seed callback.
> Randomly failing the tfm allocation is not a solution to resource
> control :)

Is it fine waiting in init-callback until someone calls exit-callback?

Thanks,

Qunqin.

>
> Cheers,


