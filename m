Return-Path: <linux-integrity+bounces-4664-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37917A211A5
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Jan 2025 19:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60CBB162336
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Jan 2025 18:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413D01DE2C3;
	Tue, 28 Jan 2025 18:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="e3HlQteR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92FA145B3E;
	Tue, 28 Jan 2025 18:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738089245; cv=none; b=kdRRuvmoPSdAdFMoOfA9BUj1aPRgPVNPI9s4RvUNuTl0BfIoC0qe4p835dFVNnet5zsErg8dbikgGoVRE9hAiDv0b/P7MDtVjvuMPSpUQWnqSUAzWICGN5eLE7DzbBYuL8diy2yuLZxNfOOkJWAm6o8rUnutuXxI7VmcENbs02g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738089245; c=relaxed/simple;
	bh=ydEh5DMlf3YH6VBVErCuzqWe9z1368wVXa8j9oximWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bp+y4a1/zgWS/qJSWeIR8XHrQS5d2f32TDTah3rSiwbP+euvc2ZOryX005Rq2hgyHGo8nQw0dNOAT3K1plq7QALLjAb0bne6vvarwbg7zq6UZfsDqT5+WanrOLKzAURP/i2MSW8D/UwieF7/W7R+XUFgJ559ko8YemL3PiPzgqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=e3HlQteR; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.17.64.116] (unknown [131.107.1.180])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0FD03203718B;
	Tue, 28 Jan 2025 10:34:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0FD03203718B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738089243;
	bh=SfuaaDeGkArsUO7EShjP3h42f4exQXJZBmRoJiX+1Ek=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e3HlQteRE2S+qzCQVXdFNBspbzHFJo4T/Y4d7ex8k8VCladxp96EmAJAp+VLoo9w3
	 ODtoXGbMU1mcQ4QUscp8rGl+1yoV5+wDM6SiV0vDEL/1XqM1MNrUrE8aWTsYAilwVH
	 XhkX4UQ4MOZawgPbLoxRrZkPdFkXDqFGm0esHtoc=
Message-ID: <eeeed6d2-7790-4f2a-8484-23b8d8e9f540@linux.microsoft.com>
Date: Tue, 28 Jan 2025 10:34:02 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/7] ima: make the kexec extra memory configurable
To: Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com,
 roberto.sassu@huaweicloud.com, petr@tesarici.cz, eric.snowberg@oracle.com,
 paul@paul-moore.com, code@tyhicks.com, nramas@linux.microsoft.com,
 James.Bottomley@HansenPartnership.com, madvenka@linux.microsoft.com
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250124225547.22684-1-chenste@linux.microsoft.com>
 <20250124225547.22684-7-chenste@linux.microsoft.com>
 <d127dad9-e392-49ef-af52-a7bcdaebe317@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <d127dad9-e392-49ef-af52-a7bcdaebe317@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/28/2025 7:18 AM, Stefan Berger wrote:
>
>
> On 1/24/25 5:55 PM, steven chen wrote:
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
>> From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Suggested-by: Stefan Berger <stefanb@linux.ibm.com>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>> ---
>>   security/integrity/ima/Kconfig     | 10 ++++++++++
>>   security/integrity/ima/ima_kexec.c | 16 ++++++++++------
>>   2 files changed, 20 insertions(+), 6 deletions(-)
>>
>> diff --git a/security/integrity/ima/Kconfig 
>> b/security/integrity/ima/Kconfig
>> index 475c32615006..7dd2ed8b2cdc 100644
>> --- a/security/integrity/ima/Kconfig
>> +++ b/security/integrity/ima/Kconfig
>> @@ -321,4 +321,14 @@ config IMA_DISABLE_HTABLE
>>       help
>>          This option disables htable to allow measurement of 
>> duplicate records.
>>   +config IMA_KEXEC_EXTRA_MEMORY_KB
>> +    int
>
> int "Extra memory for IMA measurements added during kexec soft reboot"
>
> Without the description I wasn't able to modify the value.
>
>> +    depends on IMA_KEXEC
>> +    default 0
>> +    help
>> +      IMA_KEXEC_EXTRA_MEMORY_KB determines the extra memory to be
>> +      allocated (in kb) for IMA measurements added during kexec soft 
>> reboot.
>> +      If set to the default value, an extra half a page of memory 
>> for those
>> +      additional measurements will be allocated.
>> +
>>   endif
>> diff --git a/security/integrity/ima/ima_kexec.c 
>> b/security/integrity/ima/ima_kexec.c
>> index d5f004cfeaec..c9c916f69ca7 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -128,22 +128,26 @@ void ima_add_kexec_buffer(struct kimage *image)
>>                     .buf_min = 0, .buf_max = ULONG_MAX,
>>                     .top_down = true };
>>       unsigned long binary_runtime_size;
>> -
>> +    unsigned long extra_size;
>>       /* use more understandable variable names than defined in kbuf */
>>       void *kexec_buffer = NULL;
>>       size_t kexec_buffer_size = 0;
>>       int ret;
>>         /*
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
> With the changes to Kconfig:
>
>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>
Thanks, will update in the next release


