Return-Path: <linux-integrity+bounces-5364-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B89A0A6C084
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Mar 2025 17:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ECCA3A4E73
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Mar 2025 16:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273C622424E;
	Fri, 21 Mar 2025 16:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="N9QOP+Ix"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E3A22D4CD;
	Fri, 21 Mar 2025 16:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575609; cv=none; b=oyC6yFg/4LrWQtUjf+ljFhudibenw4npjBN3FIyomsagJ7pHfh303jhgBGvhQ0VqOdMojrRnHCILQ7pPLH6z4KUbFjQisoLHJt1ATx0DsblcWPasAtGVm6Tf9aEvZdQ/Yv0/ZfO5c/W0o5kuxbT6FbqpORvxlD9RcwZbxgMDkcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575609; c=relaxed/simple;
	bh=eEbvZnqrnx+iFFTjfr8LLlmdZJB48dPCOL4dCsjSVpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oB0zvO4lPYBTO+BmXMZQZ7qR+URUNhyJE0lbucsK5SJeMHIzr+WXwcG9MOm7mr645jhJ9MYUBo0mZqPQxznew9IQ6uCIUx6uY69BuiRJzEG8B7w7U5ajc+nX7zMCi7kSJOQpiU0MKPOJK79q52g/ThTewe8kzP4w+5wHbq2AgGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=N9QOP+Ix; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.17.64.97] (unknown [131.107.174.225])
	by linux.microsoft.com (Postfix) with ESMTPSA id E44CC202538A;
	Fri, 21 Mar 2025 09:46:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E44CC202538A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742575607;
	bh=nSvjsrtvsYH0Ut5RuXHshDg+2Of7/6QpJwrxhRT3jP0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N9QOP+IxLavnYNz3HjFdNVhXARehD6rMEeIKlMfzV30fLZ18gZbKafDdW6lpavtKj
	 9lCPhW7bRpf0k84LU5RZMQ+izAFR/wJqqLapseL5CO+fGtFaWf2Q8KZ4cRx9ZYESsb
	 iBKjV0fTVKuBXQZYXx4q+MftjeIboA0uvV+k59p8=
Message-ID: <c050bff0-6a0d-402b-884b-fe991cd30cf3@linux.microsoft.com>
Date: Fri, 21 Mar 2025 09:46:47 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 7/8] ima: make the kexec extra memory configurable
To: Baoquan He <bhe@redhat.com>
Cc: zohar@linux.ibm.com, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
 nramas@linux.microsoft.com, James.Bottomley@hansenpartnership.com,
 vgoyal@redhat.com, dyoung@redhat.com
References: <20250318010448.954-1-chenste@linux.microsoft.com>
 <20250318010448.954-8-chenste@linux.microsoft.com>
 <Z9uC9g+UaVAA/0tY@MiWiFi-R3L-srv>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <Z9uC9g+UaVAA/0tY@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/19/2025 7:52 PM, Baoquan He wrote:
> On 03/17/25 at 06:04pm, steven chen wrote:
>> The extra memory allocated for carrying the IMA measurement list across
>> kexec is hard-coded as half a PAGE.  Make it configurable.
>>
>> Define a Kconfig option, IMA_KEXEC_EXTRA_MEMORY_KB, to configure the
>> extra memory (in kb) to be allocated for IMA measurements added during
>> kexec soft reboot.  Ensure the default value of the option is set such
>> that extra half a page of memory for additional measurements is allocated
>> for the additional measurements.
>>
>> Update ima_add_kexec_buffer() function to allocate memory based on the
>> Kconfig option value, rather than the currently hard-coded one.
>>
>> Suggested-by: Stefan Berger <stefanb@linux.ibm.com>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>> ---
>>   security/integrity/ima/Kconfig     | 10 ++++++++++
>>   security/integrity/ima/ima_kexec.c | 16 +++++++++++-----
>>   2 files changed, 21 insertions(+), 5 deletions(-)
>>
>> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
>> index 475c32615006..d73c96c3c1c9 100644
>> --- a/security/integrity/ima/Kconfig
>> +++ b/security/integrity/ima/Kconfig
>> @@ -321,4 +321,14 @@ config IMA_DISABLE_HTABLE
>>   	help
>>   	   This option disables htable to allow measurement of duplicate records.
>>   
>> +config IMA_KEXEC_EXTRA_MEMORY_KB
>> +	int "Extra memory for IMA measurements added during kexec soft reboot"
>> +	depends on IMA_KEXEC
>> +	default 0
> Is there range for this memory, e.g [0, max] and max will be a value
> according to our current perception?

Hi Baoquan,

In the code below there is value check for this

  	if ((kexec_segment_size == ULONG_MAX) ||
  	    ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages() / 2)) {

Hi Mimi,

Could you provide any guidance if we need to set the range?

Thanks,

Steven

>> +	help
>> +	  IMA_KEXEC_EXTRA_MEMORY_KB determines the extra memory to be
>> +	  allocated (in kb) for IMA measurements added during kexec soft reboot.
>> +	  If set to the default value of 0, an extra half page of memory for those
>> +	  additional measurements will be allocated.
>> +
>>   endif
>> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
>> index c390c745f882..0f214e41dd33 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -131,6 +131,7 @@ void ima_add_kexec_buffer(struct kimage *image)
>>   				  .buf_min = 0, .buf_max = ULONG_MAX,
>>   				  .top_down = true };
>>   	unsigned long binary_runtime_size;
>> +	unsigned long extra_memory;
>>   
>>   	/* use more understandable variable names than defined in kbuf */
>>   	size_t kexec_buffer_size = 0;
>> @@ -138,15 +139,20 @@ void ima_add_kexec_buffer(struct kimage *image)
>>   	int ret;
>>   
>>   	/*
>> -	 * Reserve an extra half page of memory for additional measurements
>> -	 * added during the kexec load.
>> +	 * Reserve extra memory for measurements added during kexec.
>>   	 */
>> -	binary_runtime_size = ima_get_binary_runtime_size();
>> +	if (CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB <= 0)
>> +		extra_memory = PAGE_SIZE / 2;
>> +	else
>> +		extra_memory = CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB * 1024;
>> +
>> +	binary_runtime_size = ima_get_binary_runtime_size() + extra_memory;
>> +
>>   	if (binary_runtime_size >= ULONG_MAX - PAGE_SIZE)
>>   		kexec_segment_size = ULONG_MAX;
>>   	else
>> -		kexec_segment_size = ALIGN(ima_get_binary_runtime_size() +
>> -					   PAGE_SIZE / 2, PAGE_SIZE);
>> +		kexec_segment_size = ALIGN(binary_runtime_size, PAGE_SIZE);
>> +
>>   	if ((kexec_segment_size == ULONG_MAX) ||
>>   	    ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages() / 2)) {
>>   		pr_err("Binary measurement list too large.\n");
>> -- 
>> 2.25.1
>>
>>


