Return-Path: <linux-integrity+bounces-6153-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 482AFAAD36F
	for <lists+linux-integrity@lfdr.de>; Wed,  7 May 2025 04:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D915B7B4453
	for <lists+linux-integrity@lfdr.de>; Wed,  7 May 2025 02:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDDE4B1E5F;
	Wed,  7 May 2025 02:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IObWT5zk"
X-Original-To: linux-integrity@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7459C19C546
	for <linux-integrity@vger.kernel.org>; Wed,  7 May 2025 02:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746585728; cv=none; b=AKsugM+xbuPXkIKJxqIC9bxIQE7vxs3Uhf+s9zQJrrpF7eps9g59pQ42GTiWbuz/aG1Eh9tDg/Sxog9IymTJnjQ2V1MCad7cMwO1XBKnL/HaKZsELgYdm8E9nIHgsvtA55TJrAfOipFju/gXw6ZVc5BfFYBiCDeq5+POZMn4JSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746585728; c=relaxed/simple;
	bh=6etL97QEsqJN3YZrjYchxkPsyMZOXMw61jInfbT3Xw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rKx9Tp1OZBTdQfHVOtmkqd5RjSEPc1bXpoq911JzOhztbdqW88a4OVZOVU5H3I43jU49S6Sf/UUKf7fpMS7Mtzd3we+Pm3EV3IwOBJbohObLTxywfVbP0b2E+ev0b0dRRme2Uq9Y01NzSlfSOojm+sM825qnv1riAU3oUD9ukvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IObWT5zk; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <87e475ca-c4db-4fe4-94df-4e29f779a383@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746585713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jR9JKWCrpFIfn9jOgzBStj0mD3xOCH22odNml15ltfQ=;
	b=IObWT5zkKq5EkbWwVKTGdfdlbql9PSombG1SPX7hWaaxp/EZwXp2Nl3674HN9qu9nFmHVS
	RgIulIF+wOLmuBVb0Sv6jMyjKYDRkt7uDwC8waWe5ZIGzGz9EYnlcH9IWiJyaih6994gMd
	OrHpRZDB6IIrblHWYWCjsyBVZ6D71g8=
Date: Wed, 7 May 2025 10:41:46 +0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v9 5/5] MAINTAINERS: Add tpm_loongson.c to LOONGSON CRYPTO
 DRIVER entry
To: Qunqin Zhao <zhaoqunqin@loongson.cn>
Cc: lee@kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net,
 peterhuewe@gmx.de, jarkko@kernel.org, linux-kernel@vger.kernel.org,
 loongarch@lists.linux.dev, linux-crypto@vger.kernel.org, jgg@ziepe.ca,
 linux-integrity@vger.kernel.org, pmenzel@molgen.mpg.de,
 Huacai Chen <chenhuacai@loongson.cn>
References: <20250506032053.11147-1-zhaoqunqin@loongson.cn>
 <a03b4963-55aa-4a75-b795-1e8f0db7ec89@linux.dev>
 <00196f77-1060-fe67-3e6b-6721092207d6@loongson.cn>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yanteng Si <si.yanteng@linux.dev>
In-Reply-To: <00196f77-1060-fe67-3e6b-6721092207d6@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 5/6/25 8:14 PM, Qunqin Zhao 写道:
>
> 在 2025/5/6 下午5:03, Yanteng Si 写道:
>> 在 5/6/25 11:20 AM, Qunqin Zhao 写道:
>>> Changes to Loongson TPM driver would be best reviewed by the Loongson
>>> crypto driver maintainers.
>>>
>>> Signed-off-by: Qunqin Zhao <zhaoqunqin@loongson.cn>
>>> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
>>> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>>> ---
>>> v8-v9: None
>>> v7: Added tag from Jarkko and Huacai
>>> v6: "tpm_lsse.c" -> "tpm_loongson"
>>> v4-v5: None
>>>
>>>   MAINTAINERS | 1 +
>>>   1 file changed, 1 insertion(+)
>> I'm just curious. Why is this patch kept outside the tmp_loongson 
>> patch set?
>
> Hi, Yanteng. Thanks for your reply.
>
>
> When sending this patch, git send-email prompted "too many commands"
>
> and disconnected from the server. Then I sent this patch separately.
>
> Even after setting sendemail.smtpBatchSize to 100, I still have this 
> problem.

>
> Now I am trying to find  Loongson SMTP server administrator to solve it.

This is the best solution.


>
> Have you ever encountered this kind of problem?

This seems to be a feature of the Loongson mailbox. I've observed that Yang

Tiezhu also has a patch that is outside of the patch set. An interesting 
pattern

is that there are only five emails in one patch set.


Thanks,

Yanteng



>
>
> BR, Qunqin.
>
>>
>> <https://lore.kernel.org/loongarch/20250506031947.11130-1-zhaoqunqin@loongson.cn/T/#mf09225c286a8e2b92a677720afafb9e20be57a18> 
>>
>>
>> Thanks,
>> Yanteng
>

