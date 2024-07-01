Return-Path: <linux-integrity+bounces-2946-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA2F91E307
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2024 16:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D561C28284E
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2024 14:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4AE16CD12;
	Mon,  1 Jul 2024 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="xqtyB4iJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7555F16CD15
	for <linux-integrity@vger.kernel.org>; Mon,  1 Jul 2024 14:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719845887; cv=none; b=QMzfN095Bc4ldKwTrOAGaoVdlLRBAnIFfNEmVN8gc7S1miTlusQ+ixt1QerN8yBRhhNORDA3IkTkAffBYu22butDB9Vy36jW97ikepnaAsI61BGASjwhnAD3br4lPBfNVlQ6Ce0aTk9tzZG8BkeJ3vtHlrZN/3ARmYHNOWgk+g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719845887; c=relaxed/simple;
	bh=me7GB/qzYY2N1RzwVTyLc9IHf4mKN9cNM78d8j/YZZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cEmgw/bMf4U5tCP3aHpTYdbXgJuWeUzBNo4WYbMv8DNU2m2fKmkvvH1N1d9CvN7C8gBnTCOHEpFw93F2pVQkhX5O2XJk/08IIhU3pG4Uyy5w86PewCrvIGLVpt44u6txxH8zElOT47VqF2ZibUOLbF4j4rsCIhLhCO4kp5rvoww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=xqtyB4iJ; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52cdd03d6aaso3605259e87.0
        for <linux-integrity@vger.kernel.org>; Mon, 01 Jul 2024 07:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1719845882; x=1720450682; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M0eCAnd9HifJY7HPfSdvf/yEb0qcotUbM44qnUJrkvo=;
        b=xqtyB4iJ1d+/3CNoRowi/OOZWZ1KPId1fpB8JFkHaFa6MgaTX7EQeXqPHhJ3g0f+O+
         /LcJ54+x5FWVt4d1xe9niSmGgkFMABpG38rzJn8Fe0mmTCFCaZcVSON3frb/4IGjj5o2
         etC2tCAjsHtFmZ5/7HAzuIeTTV9cDW1WP/TuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719845882; x=1720450682;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M0eCAnd9HifJY7HPfSdvf/yEb0qcotUbM44qnUJrkvo=;
        b=gckXwrnI9TR+xPT1UttbJpPZFDqPfkps7cSBBWT4FpirhKd8sF9sRs9HdFJJfsha2X
         Xof87wSm+N/gpnFfnH/zsVPKNfRLFmC2imSjyV0z+y3yD/M5lzD3F8RJsBIicDBP6rGV
         hYt/AtwQPA6braNBg7wlao2aeiG6O/kAJMedcIx4qn4wsEacyDF0XmZYFYdlm7HT2/iq
         I1qnfnzf3Z+W+Sqvj/t3/2F/QTitjU/PwfnoQIzdkbeksfrymgE1IG/TPkl7FRz6ITod
         CREOimDICs0q5uC9E95p3B7qZtcRFUhXcw9sJHODI6xHc5Wa4MdeLdS9lAN1ckWbwBEc
         S80Q==
X-Gm-Message-State: AOJu0YwltFXmAlqWwLW8fLksUfG3Uz5aE91p5IV8OytBMBgiWcNtszRG
	uZVQa1920yxpA69X6GlmX+i4egRWazXdBOfHZRaQ+bbtwhtdzYAKt3olT0RKH0E=
X-Google-Smtp-Source: AGHT+IHT/HNJBez6jALzVqd6XyVDvwHImDMDlTJN+7IE9MWGprbEyn/sO0aVEEYgBW1DCvn13ITnUQ==
X-Received: by 2002:a05:6512:b88:b0:52c:86eb:a2e6 with SMTP id 2adb3069b0e04-52e8264bcaamr4160162e87.4.1719845882376;
        Mon, 01 Jul 2024 07:58:02 -0700 (PDT)
Received: from ?IPV6:2a01:cb05:949d:5800:e3ef:2d7a:4131:71f? (2a01cb05949d5800e3ef2d7a4131071f.ipv6.abo.wanadoo.fr. [2a01:cb05:949d:5800:e3ef:2d7a:4131:71f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b098b4dsm158473245e9.29.2024.07.01.07.58.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 07:58:02 -0700 (PDT)
Message-ID: <d7429218-7b48-4201-8ad9-63728e188be5@smile.fr>
Date: Mon, 1 Jul 2024 16:58:00 +0200
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] integrity: wait for completion of i2c initialization using
 late_initcall_sync()
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 serge@hallyn.com, jmorris@namei.org, paul@paul-moore.com,
 eric.snowberg@oracle.com, dmitry.kasatkin@gmail.com,
 roberto.sassu@huawei.com, zohar@linux.ibm.com,
 Romain Naour <romain.naour@skf.com>
References: <20240701133814.641662-1-romain.naour@smile.fr>
 <c090cd3c-f4c6-4923-a9fa-b54768ca2a26@molgen.mpg.de>
Content-Language: fr
From: Romain Naour <romain.naour@smile.fr>
In-Reply-To: <c090cd3c-f4c6-4923-a9fa-b54768ca2a26@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello Paul,

Le 01/07/2024 à 15:53, Paul Menzel a écrit :
> Dear Romain,
> 
> 
> Thank you for your patch.
> 
> Am 01.07.24 um 15:38 schrieb Romain Naour:
>> From: Romain Naour <romain.naour@skf.com>
>>
>> It has been reported that on some plateforms the ima and evm
> 
> platforms
> 
>> initialization were performed too early during initcall initialization
>> process and misses TPM chip detection [1] [2].
>>
>> Indeed, ima may uses a TPM chip but requires to wait for bus
>> interface (spi or i2c) and TPM driver initialization.
>>
>> [    0.166261] ima: No TPM chip found, activating TPM-bypass!
>> ...
>> [    0.166322] evm: Initialising EVM extended attributes:
>> ...
>> [    0.182571] ti-sci 44083000.system-controller: ABI: 3.1 (firmware rev
>> 0x0009 '9.2.4--v09.02.04 (Kool Koala)')
>> [    0.281540] omap_i2c 42120000.i2c: bus 0 rev0.12 at 400 kHz
>> [    0.282314] omap_i2c 2000000.i2c: bus 4 rev0.12 at 400 kHz
>> [    0.282972] omap_i2c 2010000.i2c: bus 5 rev0.12 at 400 kHz
>> [    0.335177] tpm_tis_i2c 2-002e: 2.0 TPM (device-id 0x1C, rev-id 22)
>> [    0.471596] omap_i2c 2020000.i2c: bus 2 rev0.12 at 100 kHz
>> [    0.472310] omap_i2c 2030000.i2c: bus 6 rev0.12 at 400 kHz
>> [    0.472951] omap_i2c 2040000.i2c: bus 3 rev0.12 at 100 kHz
>> [    0.473596] omap_i2c 2050000.i2c: bus 7 rev0.12 at 400 kHz
>> [    0.474274] omap_i2c 2060000.i2c: bus 1 rev0.12 at 100 kHz
>>
>> The ima stack was expecting to start after the TPM device (hence the
>> comment) using late_initcall() but fail to do so on such plateforms:
> 
> platforms

I'll fix, thanks!

> 
>>
>>    late_initcall(init_ima);    /* Start IMA after the TPM is available */
>>
>> Using late_initcall_sync() variant allows to really wait for i2c
>> initialization completion.
>>
>> [    0.285986] omap_i2c 42120000.i2c: bus 0 rev0.12 at 400 kHz
>> [    0.286706] omap_i2c 2000000.i2c: bus 4 rev0.12 at 400 kHz
>> [    0.287382] omap_i2c 2010000.i2c: bus 5 rev0.12 at 400 kHz
>> [    0.331503] tpm_tis_i2c 2-002e: 2.0 TPM (device-id 0x1C, rev-id 22)
>> [    0.677185] omap_i2c 2020000.i2c: bus 2 rev0.12 at 100 kHz
>> [    0.677904] omap_i2c 2030000.i2c: bus 6 rev0.12 at 400 kHz
>> [    0.678557] omap_i2c 2040000.i2c: bus 3 rev0.12 at 100 kHz
>> [    0.679167] omap_i2c 2050000.i2c: bus 7 rev0.12 at 400 kHz
>> [    0.679792] omap_i2c 2060000.i2c: bus 1 rev0.12 at 100 kHz
>> ...
>> [    3.062788] ima: Allocated hash algorithm: sha256
>> ...
>> [    3.318975] ima: No architecture policies found
>> [    3.323536] evm: Initialising EVM extended attributes:
>> [    3.328662] evm: security.selinux (disabled)
>> [    3.332919] evm: security.SMACK64 (disabled)
>> [    3.337177] evm: security.SMACK64EXEC (disabled)
>> [    3.341781] evm: security.SMACK64TRANSMUTE (disabled)
>> [    3.346819] evm: security.SMACK64MMAP (disabled)
>> [    3.351422] evm: security.apparmor (disabled)
>> [    3.355764] evm: security.ima
>> [    3.358721] evm: security.capability
>> [    3.362285] evm: HMAC attrs: 0x1
>>
>> [1]
>> https://lore.kernel.org/linux-integrity/9b98d912-ba78-402c-a5c8-154bef8794f7@smile.fr/
>> [2]
>> https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1375425/tda4vm-ima-vs-tpm-builtin-driver-boot-order
>>
>> Signed-off-by: Romain Naour <romain.naour@skf.com>
> 
> Should this get a Fixes: tag and be also applied to the stable series?

The current behavior can be reproduced on any released kernel (at least since
6.1). But I'm not sure if it should be backported to stable kernels since it
delays the ima/evm initialization at runtime.

> 
>> ---
>>   security/integrity/evm/evm_main.c | 2 +-
>>   security/integrity/ima/ima_main.c | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/security/integrity/evm/evm_main.c
>> b/security/integrity/evm/evm_main.c
>> index 62fe66dd53ce..316f8d140825 100644
>> --- a/security/integrity/evm/evm_main.c
>> +++ b/security/integrity/evm/evm_main.c
>> @@ -1180,4 +1180,4 @@ DEFINE_LSM(evm) = {
>>       .blobs = &evm_blob_sizes,
>>   };
>>   -late_initcall(init_evm);
>> +late_initcall_sync(init_evm);    /* Start EVM after IMA */
>> diff --git a/security/integrity/ima/ima_main.c
>> b/security/integrity/ima/ima_main.c
>> index f04f43af651c..0aa7cd9aabfa 100644
>> --- a/security/integrity/ima/ima_main.c
>> +++ b/security/integrity/ima/ima_main.c
>> @@ -1220,4 +1220,4 @@ DEFINE_LSM(ima) = {
>>       .blobs = &ima_blob_sizes,
>>   };
>>   -late_initcall(init_ima);    /* Start IMA after the TPM is available */
>> +late_initcall_sync(init_ima);    /* Start IMA after the TPM is available */
> 
> Looks good to me.

Thanks for the review!

Best regards,
Romain


> 
> 
> Kind regards,
> 
> Paul


