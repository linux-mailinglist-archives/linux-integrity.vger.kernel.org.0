Return-Path: <linux-integrity+bounces-2694-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DDF8D2EDC
	for <lists+linux-integrity@lfdr.de>; Wed, 29 May 2024 09:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAF0F28ADDD
	for <lists+linux-integrity@lfdr.de>; Wed, 29 May 2024 07:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B416C167DAA;
	Wed, 29 May 2024 07:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fMUXNKoM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A667169361
	for <linux-integrity@vger.kernel.org>; Wed, 29 May 2024 07:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716968836; cv=none; b=KpyhtI8fg6AoqQPoVFcF+kRkxJ27sYZhqdCEWllHRaijxOSjbTCaZT/qEYlFRImHdrBO3gNnyPMkweht0Wi+SArFdApjAx+PJXW/bX7/N8cE3nee3Li+MWk3uqAp/u2ewLUUUkZbgr/qEygGUnv3Az0cMhQk2m8+9lN/fIffq9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716968836; c=relaxed/simple;
	bh=X0yWnlnmQLutm9mVnyhuOMjWnh8aSQGJbdGguN9W8jU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mpGDIPMczr1+eXhtSSXdzt00RyTlC3bC/cqkpqa7teQvC1zQ5cs7BA9afJ4tUY7SoQPs7bXoBieH582YOrmzcVKzDyxbZW4eCSufMUFkVK374iJ2678QztyE/yuBOwrtrUIBRLzO5gSe82cfc6UPbe2A1/QiRcA2w+U4RdlM6CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fMUXNKoM; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a626776cc50so184294066b.3
        for <linux-integrity@vger.kernel.org>; Wed, 29 May 2024 00:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1716968833; x=1717573633; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=B60sIRNcgpPRysBC4X8m+j9lXdOHuT3jSKh0T6iUqdM=;
        b=fMUXNKoMwfCJkwFGtcTFIb0LgITD++obHHt5RjcbuZNECstpeMRrN30TgmnRoCRITJ
         xyP0NhvlhlYQn902j5fc76RkNN/os6pR1Zm7mG6WK3hEjJqhTNLT4ACQCsFyVmkGC9B4
         +8YZ2hF4/Mhyi7VBhl0fi3eb/sfIc4MLFJ2ELWnM1O9+xDclxh1Xgwq95F27MuQsH2fm
         pGaI+piWsw6/HNy7iXR3Qp7QB7pN385mM9SxCOwL+sbOY1Wk6fL+6LWfO8yepkQlx2Ih
         gQoOqQ7p1eH0SJZc5XCtOsP+RjC2PHmayLUD4TYroEHVm8ECkE7V8wQ9102+cvwi5lVk
         k//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716968833; x=1717573633;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B60sIRNcgpPRysBC4X8m+j9lXdOHuT3jSKh0T6iUqdM=;
        b=fW1963pCXSRET12QYxMCGTalgI6ElbpoZTraV5hA30hLymihkVJ2AXAIwwCNRIVSxb
         HS2fTWkUz7f3DQl8BSDi+E/80+rthOq+k3UzmKMW9PZB9e1Ugsb30ACHFlfU/oyVdpmN
         krNpKFN9UXc1r+m/e6KPdxZsEtFvbZTEoXiE0kYnomRwjm7qUfMzloasp4YLlfPbuXRw
         Pah0h3WXtcsZ8DAWrd2WRrBsHYH1rYQ4J5/n6s4Uu3M8JLcQdGVSE4onfIDBDTTItHa8
         HLrqyEccNvTDe1AlXR2TWflUJiueQSMMxCWmtYn13WO8nL/qaWr/9fltapyp2S1aN4U/
         3D1w==
X-Forwarded-Encrypted: i=1; AJvYcCWygwk7/69q4o2LpfhEl7zNvYliY77BpofYzqKXwENVX8EKERKMO3yaIlmMtMwccM0VaW3xgYicTtsdqea6iknmesf54FDMXfe6oAcye+Q4
X-Gm-Message-State: AOJu0YxYOnC9LppSvWG8D5XaKfm83jFvo/8/AiEAzn/Xk1nMiHzUIyVR
	J+2NaHUQ6owyW8H/BUABbR3DIcSw48miUGBZfQPt1EyW2V9JM1/g6S2Ak9mykA==
X-Google-Smtp-Source: AGHT+IGJsyXjFMQisjdK7VtrIVNt2iOAfmvhYHJEzmVPe91YbY8CDjH5PR3mkW+27Phebiklj18q8A==
X-Received: by 2002:a17:907:7e85:b0:a62:de58:b362 with SMTP id a640c23a62f3a-a62de58d30fmr623364566b.55.1716968832655;
        Wed, 29 May 2024 00:47:12 -0700 (PDT)
Received: from [10.156.60.236] (ip-037-024-206-209.um08.pools.vodafone-ip.de. [37.24.206.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cda1c32sm688999966b.190.2024.05.29.00.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 May 2024 00:47:12 -0700 (PDT)
Message-ID: <365c120f-dfb0-4155-b83f-e0b8d4ead486@suse.com>
Date: Wed, 29 May 2024 09:47:11 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Ping: [PATCH] tpm_tis: don't flush never initialized work
From: Jan Beulich <jbeulich@suse.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-integrity@vger.kernel.org
References: <908e5878-61f9-7a75-129f-ac236fbc8b0a@suse.com>
 <CVIQPE7W60RN.2QQ8DLCMFV4CW@suppilovahvero>
 <9a1e2ac0-54a8-b88b-3953-22624da5d4b2@suse.com>
Content-Language: en-US
Autocrypt: addr=jbeulich@suse.com; keydata=
 xsDiBFk3nEQRBADAEaSw6zC/EJkiwGPXbWtPxl2xCdSoeepS07jW8UgcHNurfHvUzogEq5xk
 hu507c3BarVjyWCJOylMNR98Yd8VqD9UfmX0Hb8/BrA+Hl6/DB/eqGptrf4BSRwcZQM32aZK
 7Pj2XbGWIUrZrd70x1eAP9QE3P79Y2oLrsCgbZJfEwCgvz9JjGmQqQkRiTVzlZVCJYcyGGsD
 /0tbFCzD2h20ahe8rC1gbb3K3qk+LpBtvjBu1RY9drYk0NymiGbJWZgab6t1jM7sk2vuf0Py
 O9Hf9XBmK0uE9IgMaiCpc32XV9oASz6UJebwkX+zF2jG5I1BfnO9g7KlotcA/v5ClMjgo6Gl
 MDY4HxoSRu3i1cqqSDtVlt+AOVBJBACrZcnHAUSuCXBPy0jOlBhxPqRWv6ND4c9PH1xjQ3NP
 nxJuMBS8rnNg22uyfAgmBKNLpLgAGVRMZGaGoJObGf72s6TeIqKJo/LtggAS9qAUiuKVnygo
 3wjfkS9A3DRO+SpU7JqWdsveeIQyeyEJ/8PTowmSQLakF+3fote9ybzd880fSmFuIEJldWxp
 Y2ggPGpiZXVsaWNoQHN1c2UuY29tPsJgBBMRAgAgBQJZN5xEAhsDBgsJCAcDAgQVAggDBBYC
 AwECHgECF4AACgkQoDSui/t3IH4J+wCfQ5jHdEjCRHj23O/5ttg9r9OIruwAn3103WUITZee
 e7Sbg12UgcQ5lv7SzsFNBFk3nEQQCACCuTjCjFOUdi5Nm244F+78kLghRcin/awv+IrTcIWF
 hUpSs1Y91iQQ7KItirz5uwCPlwejSJDQJLIS+QtJHaXDXeV6NI0Uef1hP20+y8qydDiVkv6l
 IreXjTb7DvksRgJNvCkWtYnlS3mYvQ9NzS9PhyALWbXnH6sIJd2O9lKS1Mrfq+y0IXCP10eS
 FFGg+Av3IQeFatkJAyju0PPthyTqxSI4lZYuJVPknzgaeuJv/2NccrPvmeDg6Coe7ZIeQ8Yj
 t0ARxu2xytAkkLCel1Lz1WLmwLstV30g80nkgZf/wr+/BXJW/oIvRlonUkxv+IbBM3dX2OV8
 AmRv1ySWPTP7AAMFB/9PQK/VtlNUJvg8GXj9ootzrteGfVZVVT4XBJkfwBcpC/XcPzldjv+3
 HYudvpdNK3lLujXeA5fLOH+Z/G9WBc5pFVSMocI71I8bT8lIAzreg0WvkWg5V2WZsUMlnDL9
 mpwIGFhlbM3gfDMs7MPMu8YQRFVdUvtSpaAs8OFfGQ0ia3LGZcjA6Ik2+xcqscEJzNH+qh8V
 m5jjp28yZgaqTaRbg3M/+MTbMpicpZuqF4rnB0AQD12/3BNWDR6bmh+EkYSMcEIpQmBM51qM
 EKYTQGybRCjpnKHGOxG0rfFY1085mBDZCH5Kx0cl0HVJuQKC+dV2ZY5AqjcKwAxpE75MLFkr
 wkkEGBECAAkFAlk3nEQCGwwACgkQoDSui/t3IH7nnwCfcJWUDUFKdCsBH/E5d+0ZnMQi+G0A
 nAuWpQkjM1ASeQwSHEeAWPgskBQL
In-Reply-To: <9a1e2ac0-54a8-b88b-3953-22624da5d4b2@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14.09.2023 17:29, Jan Beulich wrote:
> On 14.09.2023 17:19, Jarkko Sakkinen wrote:
>> On Thu Sep 14, 2023 at 5:28 PM EEST, Jan Beulich wrote:
>>> tpm_tis_core_init() may fail before tpm_tis_probe_irq_single() is
>>> called, in which case tpm_tis_remove() unconditionally calling
>>> flush_work() is triggering a warning for .func still being NULL.
>>>
>>> Fixes: 481c2d14627d ("tpm,tpm_tis: Disable interrupts after 1000 unhandled IRQs")
>>> Signed-off-by: Jan Beulich <jbeulich@suse.com>
>>> ---
>>> An alternative would be to move INIT_WORK(), but where to put it is far
>>> more difficult to tell for an outsider than simply making the flush call
>>> conditional.
>>>
>>> --- a/drivers/char/tpm/tpm_tis_core.c
>>> +++ b/drivers/char/tpm/tpm_tis_core.c
>>> @@ -1022,7 +1022,8 @@ void tpm_tis_remove(struct tpm_chip *chi
>>>  		interrupt = 0;
>>>  
>>>  	tpm_tis_write32(priv, reg, ~TPM_GLOBAL_INT_ENABLE & interrupt);
>>> -	flush_work(&priv->free_irq_work);
>>> +	if (priv->free_irq_work.func)
>>> +		flush_work(&priv->free_irq_work);
>>>  
>>>  	tpm_tis_clkrun_enable(chip, false);
>>>  
>>
>> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>>
>> Jan, I'm about to leave to vacation but will be back after next week.
>>
>> Do you think that the fix can hold up unti that?
> 
> There's no rush from my pov, as I have helped myself.

Has this possibly fallen through the cracks?

Jan

