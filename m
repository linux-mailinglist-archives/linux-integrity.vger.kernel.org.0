Return-Path: <linux-integrity+bounces-3116-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C3E931E3D
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 03:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4367AB21A7A
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2024 01:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E143187F;
	Tue, 16 Jul 2024 01:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="itbrRJox"
X-Original-To: linux-integrity@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A758E79E0
	for <linux-integrity@vger.kernel.org>; Tue, 16 Jul 2024 01:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721091872; cv=none; b=YvT+XJjbIcvvdCt+KYY0Pa3QCMDH3MY0RENg1aK1wWHHU92029VNN4R/azV09u35yjKkv5vbdwxy8fTcFI0KG/3YCr0cTSnu8KX6aoe3Mn4WpE7GVEPis6tYAZpbaUCgT63e0bkgfdp436i2Dadq6cy2YIdgLEKsfB2SvU1eilc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721091872; c=relaxed/simple;
	bh=DxVL674DykXj38h1XVGpn0hsaGmd4nf0QTNzrbjYn8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kKsgzAVH0tiGxV57ZXdgM5DM77O2C//Fa1ovbqdhqD0+JaKJJQiGU4vCsOKBi+7+Wo69Z6izXs06zEl9R1cIpQ2x/zQJrgbxCYVmx7rdV8nG9BzPb9g8Iad84rzCmS7POg0uDgLVmQj4CIivdJ/KXuKha5nLNr99eAuNf5IfQLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=itbrRJox; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: jarkko@kernel.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721091867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rrsdvOcbnZj3fLM/P3nqd13De7FARkH+xOOXrXATVM0=;
	b=itbrRJoxtO+pLwhn2iCH2bPN8FYFO9ODrSsOjdtfC8sPOGXa2S0CGR745jKwKFlH46Bf7s
	8FPVMAmvHtIeGiKJcN7LS/QuOgmwi5BC1W0/qhlvkFXrNkkQDcq3CJB+TVm9sRuSx0iwN7
	P2FkeEmQc5ApsAYkJUkOqhKVS4kEhNY=
X-Envelope-To: peterhuewe@gmx.de
X-Envelope-To: jgg@ziepe.ca
X-Envelope-To: linux-integrity@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: gehao@kylinos.cn
Message-ID: <593e3ae7-1f8c-218a-a5ce-3d90e3008999@linux.dev>
Date: Tue, 16 Jul 2024 09:04:08 +0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] tpm: Move dereference after NULL check in
 tpm_buf_check_hmac_response
To: Jarkko Sakkinen <jarkko@kernel.org>, peterhuewe@gmx.de, jgg@ziepe.ca
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
 Hao Ge <gehao@kylinos.cn>
References: <20240709023337.102509-1-hao.ge@linux.dev>
 <D2Q2Q4R8BZ4Q.2QZF7NM3RE9B8@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Ge <hao.ge@linux.dev>
In-Reply-To: <D2Q2Q4R8BZ4Q.2QZF7NM3RE9B8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Jarkko

Have a nice day.

On 7/15/24 19:25, Jarkko Sakkinen wrote:
> On Tue Jul 9, 2024 at 5:33 AM EEST, Hao Ge wrote:
>> From: Hao Ge <gehao@kylinos.cn>
>>
>> We shouldn't dereference "auth" until after we have checked that it is
>> non-NULL.
>>
>> Fixes: 7ca110f2679b ("tpm: Address !chip->auth in tpm_buf_append_hmac_session*()")
>> Signed-off-by: Hao Ge <gehao@kylinos.cn>
> Also lacking:
>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-integrity/3b1755a9-b12f-42fc-b26d-de2fe4e13ec2@stanley.mountain/T/#u

Regarding this version, I don't think I should add these.

I send this patch on July 9th, 2024.

The following email was sent on July 13th, 2024.

https://lore.kernel.org/linux-integrity/3b1755a9-b12f-42fc-b26d-de2fe4e13ec2@stanley.mountain/T/#u

I think these should be included in the subsequent versions (if any).

>
> What is happening here is that my commit exposed pre-existing bug to
> static analysis but it did not introduce a new regression. I missed
> from your patch how did you ended up to your conclusions.
>
> Please *do not* ignore the sources next time. Either explain how the bug
> was found or provide the reporting source. You are essentially taking
> credit and also blame from the work that you did not accomplish
> yourself, which is both wrong and dishonest.
>
> BR, Jarkko

OK,got it,I'll pay more attention to such details in the future.

I would like to clarify that I did not taking credit and dishonest.

As stated earlier, the timeline indicates that my patch preceded his email.

Before submitting my patch, I conducted a thorough search to ensure that 
there were no related submissions,

  in order to avoid any duplication of effort and wastage of everyone's 
time.

I didn't expect to have wasted everyone's time because of commit message 
, and I sincerely apologize for that.


Thanks

BR

Hao




