Return-Path: <linux-integrity+bounces-864-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A89C4839AEE
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jan 2024 22:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02D6EB21021
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jan 2024 21:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DFE32C1AE;
	Tue, 23 Jan 2024 21:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="j5idd6wZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC79E2C1BC
	for <linux-integrity@vger.kernel.org>; Tue, 23 Jan 2024 21:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706044786; cv=none; b=Or8PS+D2i/0awQIv2HzbEZ52iqpTF9vl21aph4C6uZBWT7yPPVy+7Nxd4j3ckvvgoHjljL4Ld18FjuUNFVbrtOojRg5hc6mogATssM+ztihfqW/cpWf4Mbeze/P6kC1hP5buRXGiIL4Lo/WfUfK9LpCBK9eLv+ZpcL4s16m0kqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706044786; c=relaxed/simple;
	bh=SMdu+8UA8TNsjvsM/NKqMESVDrVFTRv7HE/FK0fp5/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n1/+syG7ehCMIycO1aiqybqGLMVQbZT4USfjbGkF803LoyqbXV2eepntQFr++j8sgNmZKCFIEo5FgET5L/wZqMkwCQysVnSqxf25rdF1lc5v7wdIiQ7XREZkjBljqC1vV+5x96STO4kz6teGx4v6h7aHzJmc7mnNkOv6TVe946o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=j5idd6wZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5D75220E34C8;
	Tue, 23 Jan 2024 13:19:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5D75220E34C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706044784;
	bh=FhCAZ0J8Nyw2j0kmJdDbRBVbbMuhK1dHP+qsDzSwWj0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j5idd6wZyVRV5F2+PzanmZ+g9aHrVf6yeh+Q1K39JJ1xzbYn592CCnAvsa6rSP/+5
	 wR1NwHfJjYEOp72Z+MqZPAb93XjD2WTawJOBm91/tsSUFW+RnLVxNAZL6dKr2oR9Kj
	 5HF+FOjY8/EbrXcA4SQ5YvuNKMrnZIPz0cUK3xng=
Message-ID: <022986e8-07f5-4d3d-8a60-f06dbae31ae8@linux.microsoft.com>
Date: Tue, 23 Jan 2024 13:19:44 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] ima: make the kexec extra memory configurable
Content-Language: en-US
To: Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, noodles@fb.com,
 bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20240122183804.3293904-1-tusharsu@linux.microsoft.com>
 <20240122183804.3293904-7-tusharsu@linux.microsoft.com>
 <bdf8c31a-59db-4568-ad7b-e2b3f36c3836@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <bdf8c31a-59db-4568-ad7b-e2b3f36c3836@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thanks again Stefan for taking a look.

On 1/23/24 11:02, Stefan Berger wrote:
> 
> 
> On 1/22/24 13:38, Tushar Sugandhi wrote:
>> The extra memory allocated for carrying the IMA measurement list across
>> kexec is hardcoded as half a PAGE.  Make it configurable.
>>
>> Define a Kconfig option, IMA_KEXEC_EXTRA_MEMORY_KB, to configure the
>> extra memory (in kb) to be allocated for IMA measurements added during
>> kexec soft reboot.  Ensure the default value of the option is set such
>> that extra half a page of memory for additional measurements is allocated
>> to maintain backwards compatibility.
>>
>> Update ima_add_kexec_buffer() function to allocate memory based on the
>> Kconfig option value, rather than the currently hardcoded one.
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> ---
>>   security/integrity/ima/Kconfig     | 11 +++++++++++
>>   security/integrity/ima/ima_kexec.c | 15 ++++++++++-----
>>   2 files changed, 21 insertions(+), 5 deletions(-)
>>
>> diff --git a/security/integrity/ima/Kconfig 
>> b/security/integrity/ima/Kconfig
>> index 60a511c6b583..fc103288852b 100644
>> --- a/security/integrity/ima/Kconfig
>> +++ b/security/integrity/ima/Kconfig
>> @@ -338,3 +338,14 @@ config IMA_DISABLE_HTABLE
>>       default n
>>       help
>>          This option disables htable to allow measurement of duplicate 
>> records.
>> +
>> +config IMA_KEXEC_EXTRA_MEMORY_KB
>> +    int
>> +    depends on IMA && IMA_KEXEC
>> +    default 0
>> +    help
>> +      IMA_KEXEC_EXTRA_MEMORY_KB determines the extra memory to be
>> +      allocated (in kb) for IMA measurements added during kexec soft 
>> reboot.
>> +      If set to the default value, an extra half page of memory for
>> +      additional measurements will be allocated to maintain backwards
>> +      compatibility.
> 
> Is there really an issue with 'backwards compatibility' that the user 
> needs to know about ? From looking at the code it seems more important 
> that a bit of additional memory is reserved now to fit the kexec 'load' 
> and 'exec' critical data events but that's not 'backwards compatibility'.
> 
I was contemplating how to put the right description in place 
considering the conversation we had in v3 of this series[1].
Without that context[1] default 0 could be equally confusing to the end 
user.  With the phrase 'backwards compatibility', I was trying to 
address the potential confusion around the default value 0 in the config 
- that it represents half-a-page as default. And that particular value 
choice ( half-a-page) is for backwards compatibility.
You are right, I the user shouldn't care about it.  But I had to start 
somewhere so that we can have this discussion on this thread. :)

Let me know how this description looks after removing the phrase 
'backwards compatibility':

" IMA_KEXEC_EXTRA_MEMORY_KB determines the extra memory to be
   allocated (in kb) for IMA measurements added during kexec soft reboot.
   If set to the default value, an extra half a page of memory for those
   additional measurements will be allocated."

Lastly, do you want me to add suggested-by and/or reviewed-by tag to 
this patch? Let me know. I will be happy to do so.

Thanks,
Tushar

---
[1] Subject: Re: [PATCH v3 6/7] ima: configure memory to log events 
between kexec load and execute
https://lore.kernel.org/all/a09613f2-0d9f-41a3-b78d-b1b1fd35614c@linux.microsoft.com/

On 1/12/24 09:44, Mimi Zohar wrote:
 > On Thu, 2024-01-11 at 12:52 -0800, Tushar Sugandhi wrote:
 > [...]
 >> If we go with the KBs approach -
 >>
 >> half-a-page translates to different KBs on different architectures.
 >> And setting the right default value in KBs which would translate to
 >> the desired half-a-page, on a given arch, inside the Kconfig seems
 >> fragile (as I mentioned in the context of Option A in my previous
 >> response.
 >
 > How about setting the default value to 0, indicating not to change 
the current
 > half page default.  Any other value would be KBs, as Stefan suggested.
 >
Thanks.
That's way more elegant than the other alternatives.
It's definitely doable in KConfig and handle the default in code
appropriately.

It may cause some confusion in the documentation of the config param.
But it would be a wording issue, and we can work on it.


> Also mention this as a guidance on either how kexec load+exec need to be 
> used or as a hint that it may potentially require a lot of memory? :
> 
> The amount of extra memory that is necessary to carry all measurements 
> across a kexec depends on memory requirements of the measurements taken 
> between the kexec 'load' and 'exec' stages. The more measurements are 
> taken, the more extra memory is required. Large amounts of extra memory 
> can be avoided by running kexec 'load' and 'exec' in short sequence.
> 
>> diff --git a/security/integrity/ima/ima_kexec.c 
>> b/security/integrity/ima/ima_kexec.c
>> index f26b5b342d84..c126aa6494e9 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -121,6 +121,7 @@ void ima_add_kexec_buffer(struct kimage *image)
>>                     .buf_min = 0, .buf_max = ULONG_MAX,
>>                     .top_down = true };
>>       unsigned long binary_runtime_size;
>> +    unsigned long extra_size;
>>       /* use more understandable variable names than defined in kbuf */
>>       void *kexec_buffer = NULL;
>> @@ -128,15 +129,19 @@ void ima_add_kexec_buffer(struct kimage *image)
>>       int ret;
>>       /*
>> -     * Reserve an extra half page of memory for additional measurements
>> -     * added during the kexec load.
>> +     * Reserve extra memory for measurements added during kexec.
>>        */
>> -    binary_runtime_size = ima_get_binary_runtime_size();
>> +    if (CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB <= 0)
>> +        extra_size = PAGE_SIZE / 2;
>> +    else
>> +        extra_size = CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB * 1024;
>> +    binary_runtime_size = ima_get_binary_runtime_size() + extra_size;
>> +
>>       if (binary_runtime_size >= ULONG_MAX - PAGE_SIZE)
>>           kexec_segment_size = ULONG_MAX;
>>       else
>> -        kexec_segment_size = ALIGN(ima_get_binary_runtime_size() +
>> -                       PAGE_SIZE / 2, PAGE_SIZE);
>> +        kexec_segment_size = ALIGN(binary_runtime_size, PAGE_SIZE);
>> +
>>       if ((kexec_segment_size == ULONG_MAX) ||
>>           ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages() / 2)) {
>>           pr_err("Binary measurement list too large.\n");
> 
> Code LGTM

