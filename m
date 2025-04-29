Return-Path: <linux-integrity+bounces-6064-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 034B6AA3AC8
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 00:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62FF61BC3F9A
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Apr 2025 22:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956261E1E04;
	Tue, 29 Apr 2025 22:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="svT14qQv"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C33221FAE;
	Tue, 29 Apr 2025 22:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745964025; cv=none; b=GsUKBfHdtPEAHqT+KK+zxyE8AnaM4K74NT/Tgzv7rZUG9Oh3LwRrVkvWYPAqhEnMeMB7MfzeNWtoVl/iSTnDfqXrsYFSiZg7O0GCs1kRu6frIyEi4yAwO5bl4cXlIBq1OLQitvYpPEkLssTbTNOBAJ1dsZZEfHmddDMr80S4iYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745964025; c=relaxed/simple;
	bh=d3/Z6QPw0Cs9yNszPaQ5V2DD+FjaBrRTlSPNyNV0saA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TS6kkhyPRwH/aObFf+sBgB7foBMndIfJc3DBKHR5P7tdZucsj8CD149qZoZe40Bn8rEkrSzm/gm8Rl+m+wjCNgtm6cgzt/uyGNG/P96kRCZrmGBSKJaouVy2OVy4njKen9WRQwOIQ+ZwJgM7sjzNqp4fVducSxLQ0fSse3E6NsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=svT14qQv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.70.192.100] (unknown [172.172.34.115])
	by linux.microsoft.com (Postfix) with ESMTPSA id A055E21130A6;
	Tue, 29 Apr 2025 15:00:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A055E21130A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745964023;
	bh=GabYpzt6hKuuPORocEKZwZwL8u9mqEx7Hx0RkHPtTMs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=svT14qQvKRJ+l9WXAAjQjViQEabtZkIL7a6+9A2SiWIcaEE6oG3llA8Tle9Zg52/h
	 mHL3oJsLKd+sYJYbDmLs/UAIfZO8ZSMyLetId+kOWFvupS0DrO0gferMEeKH4bCI7+
	 4yLD9JSgsZHeObJHz6NRTySun/KqlZUUftz9U0cs=
Message-ID: <2b352e35-5795-40da-bba6-c03347cfc5be@linux.microsoft.com>
Date: Tue, 29 Apr 2025 15:00:20 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 8/9] ima: make the kexec extra memory configurable
To: Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@HansenPartnership.com, bhe@redhat.com, vgoyal@redhat.com,
 dyoung@redhat.com
References: <20250421222516.9830-1-chenste@linux.microsoft.com>
 <20250421222516.9830-9-chenste@linux.microsoft.com>
 <f9652da1-78a5-443c-9893-41d76007a974@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <f9652da1-78a5-443c-9893-41d76007a974@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/29/2025 12:06 PM, Stefan Berger wrote:
>
>
> On 4/21/25 6:25 PM, steven chen wrote:
>> From: Steven Chen <chenste@linux.microsoft.com>
>>
>> The extra memory allocated for carrying the IMA measurement list across
>> kexec is hard-coded as half a PAGE.  Make it configurable.
>>
>> Define a Kconfig option, IMA_KEXEC_EXTRA_MEMORY_KB, to configure the
>> extra memory (in kb) to be allocated for IMA measurements added during
>> kexec soft reboot.  Ensure the default value of the option is set such
>> that extra half a page of memory for additional measurements is 
>> allocated
>> for the additional measurements.
>>
>> Update ima_add_kexec_buffer() function to allocate memory based on the
>> Kconfig option value, rather than the currently hard-coded one.
>>
>> Suggested-by: Stefan Berger <stefanb@linux.ibm.com>
>> Co-developed-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>> Acked-by: Baoquan He <bhe@redhat.com>
>> ---
>>   security/integrity/ima/Kconfig     | 11 +++++++++++
>>   security/integrity/ima/ima_kexec.c | 16 +++++++++++-----
>>   2 files changed, 22 insertions(+), 5 deletions(-)
>>
>> diff --git a/security/integrity/ima/Kconfig 
>> b/security/integrity/ima/Kconfig
>> index 475c32615006..976e75f9b9ba 100644
>> --- a/security/integrity/ima/Kconfig
>> +++ b/security/integrity/ima/Kconfig
>> @@ -321,4 +321,15 @@ config IMA_DISABLE_HTABLE
>>       help
>>          This option disables htable to allow measurement of 
>> duplicate records.
>>   +config IMA_KEXEC_EXTRA_MEMORY_KB
>> +    int "Extra memory for IMA measurements added during kexec soft 
>> reboot"
>> +    range 0 40
>> +    depends on IMA_KEXEC
>> +    default 0
>> +    help
>> +      IMA_KEXEC_EXTRA_MEMORY_KB determines the extra memory to be
>> +      allocated (in kb) for IMA measurements added during kexec soft 
>> reboot.
>> +      If set to the default value of 0, an extra half page of memory 
>> for those
>> +      additional measurements will be allocated.
>
> If you have an IMA policy taking quite a few measurements and you are 
> fast after reboot to log in to initiate the 'kexec load' (While system 
> is still starting up), the system may end up with loss of measurements 
> very easily if the default is 0 and pages are small. -> Set the 
> default to the max? Also, would we expect distros to all go through 
> the new config option and choose 40 or will they likely leave it at 0?
>
Hi Stefan,

Could you please check the comments of version V11 on this default value?

https://lore.kernel.org/all/20250402124725.5601-1-chenste@linux.microsoft.com/

Thanks,

Steven

>> +
>>   endif
>> diff --git a/security/integrity/ima/ima_kexec.c 
>> b/security/integrity/ima/ima_kexec.c
>> index ed867734ee70..d1c9d369ba08 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -118,6 +118,7 @@ void ima_add_kexec_buffer(struct kimage *image)
>>                     .buf_min = 0, .buf_max = ULONG_MAX,
>>                     .top_down = true };
>>       unsigned long binary_runtime_size;
>> +    unsigned long extra_memory;
>>         /* use more understandable variable names than defined in 
>> kbuf */
>>       size_t kexec_buffer_size = 0;
>> @@ -125,15 +126,20 @@ void ima_add_kexec_buffer(struct kimage *image)
>>       int ret;
>>         /*
>> -     * Reserve an extra half page of memory for additional measurements
>> -     * added during the kexec load.
>> +     * Reserve extra memory for measurements added during kexec.
>>        */
>> -    binary_runtime_size = ima_get_binary_runtime_size();
>> +    if (CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB <= 0)
>> +        extra_memory = PAGE_SIZE / 2;
>> +    else
>> +        extra_memory = CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB * 1024;
>> +
>> +    binary_runtime_size = ima_get_binary_runtime_size() + extra_memory;
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



