Return-Path: <linux-integrity+bounces-672-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A5B825B7E
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jan 2024 21:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D18E1F2281E
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jan 2024 20:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9A73608B;
	Fri,  5 Jan 2024 20:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NylGFNP1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB7C3608A
	for <linux-integrity@vger.kernel.org>; Fri,  5 Jan 2024 20:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3002920ACF28;
	Fri,  5 Jan 2024 12:20:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3002920ACF28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1704486032;
	bh=Jng59x8KZZzeeKQplCW4Mnyyjjv+JKhOVrV66k6VW20=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NylGFNP1gdVXY97xo9R3nBgGfCVDcGECUYt/azKYbEkf7ePEKLvaPlks7Hc4YdjxT
	 w0ATGMkoBy9Iap8+TEPoaZShTqzAHtrZn8y0LSf1fO3uO7JnzhtNnA1c4km55YFUc/
	 e1NCtdxDwm+h5T64l3nvvz5K2CYNKHQWVcJvl/5A=
Message-ID: <b78bbf3f-da39-47a6-aac3-581c8d2827a0@linux.microsoft.com>
Date: Fri, 5 Jan 2024 12:20:31 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] ima: configure memory to log events between kexec
 load and execute
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huaweicloud.com,
 roberto.sassu@huawei.com, eric.snowberg@oracle.com, stefanb@linux.ibm.com,
 ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
 linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
 <20231216010729.2904751-7-tusharsu@linux.microsoft.com>
 <fbe6aa7577875b23a9913a39f858f06f1d2aa903.camel@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <fbe6aa7577875b23a9913a39f858f06f1d2aa903.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/20/23 12:15, Mimi Zohar wrote:
> Hi Tushar,
> 
> The Subject line should include the word "extra".   The use of the
> extra memory isn't limited to the measurements between the kexec load
> and exec.  Additional records could be added as a result of the kexec
> load itself.  Let's simplify the title to "ima: make the kexec extra
> memory configurable".
> 
> Please remove any references to measurements between kexec load and
> execute.
> 
Thanks Mimi. I will make these changes.

> On Fri, 2023-12-15 at 17:07 -0800, Tushar Sugandhi wrote:
>> IMA currently allocates half a PAGE_SIZE for the extra events that would
>> be measured between kexec 'load' and 'execute'.  Depending on the IMA
>> policy and the system state, that memory may not be sufficient to hold
>> the extra IMA events measured after kexec 'load'.  The memory
>> requirements vary from system to system and they should be configurable.
> 
> The extra memory allocated for carrying the IMA measurement list across
> kexec is hardcoded as a half a PAGE.   Make it configurable.
> 
Will do.
>> Define a Kconfig option, IMA_KEXEC_EXTRA_MEMORY_KB, to configure the
>> extra memory (in kb) to be allocated for IMA measurements added in the
>> window from kexec 'load' to kexec 'execute'.
> 
>> Update ima_add_kexec_buffer() function to allocate memory based on the
>> Kconfig option value, rather than the currently hardcoded one.
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> ---
>>   security/integrity/ima/Kconfig     |  9 +++++++++
>>   security/integrity/ima/ima_kexec.c | 13 ++++++++-----
>>   2 files changed, 17 insertions(+), 5 deletions(-)
>>
>> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
>> index 60a511c6b583..8792b7aab768 100644
>> --- a/security/integrity/ima/Kconfig
>> +++ b/security/integrity/ima/Kconfig
>> @@ -338,3 +338,12 @@ config IMA_DISABLE_HTABLE
>>   	default n
>>   	help
>>   	   This option disables htable to allow measurement of duplicate records.
>> +
>> +config IMA_KEXEC_EXTRA_MEMORY_KB
>> +	int
>> +	depends on IMA && IMA_KEXEC
>> +	default 64
> 
> Since this isn't optional, the default should remain as a half page.
> Since a page is architecture specific, the default will need to be arch
>   specific.
> 
> thanks,
> 
> Mimih
> 
It was a feedback from Stefan in the V2 of this series to convert it 
from number of PAGES to KB.[1]

But I can revert it to number of pages again.

Also, making the default value as a fraction (1/2 page) feels weird for 
a CONFIG variable.

Is it ok to make the default value as one page rather than half page?

[1]
https://lore.kernel.org/all/15a12e79-2e90-28f7-ffa3-ff470c673099@linux.ibm.com/
 >>> +config IMA_KEXEC_EXTRA_PAGES
 >>> +    int
 >>> +    depends on IMA && IMA_KEXEC
 >>> +    default 16
 >>> +    help
 >>> +      IMA_KEXEC_EXTRA_PAGES determines the number of extra
 >>> +      pages to be allocated for IMA measurements added in the
 >>> +      window from kexec 'load' to kexec 'execute'.
 >>
 >>
 >> On ppc64 a page is 64kb. I would ask for additional kb here.
 >>
 >>
 > Not sure I understand.  Do you mean I should make the default value of
 > the config IMA_KEXEC_EXTRA_PAGES 64 or something?


No, what I mean is you should ask the user for how many extra kilobytes
(kb) to allocate - not ask for pages.


     Stefan

>> +	help
>> +	  IMA_KEXEC_EXTRA_MEMORY_KB determines the extra memory to be
>> +	  allocated (in kb) for IMA measurements added in the window
>> +	  from kexec 'load' to kexec 'execute'.
>> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
>> index 55bd5362262e..063da9c834a0 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -128,15 +128,18 @@ void ima_add_kexec_buffer(struct kimage *image)
>>   	int ret;
>>   
>>   	/*
>> -	 * Reserve an extra half page of memory for additional measurements
>> -	 * added during the kexec load.
>> +	 * Reserve extra memory for measurements added in the window from
>> +	 * kexec 'load' to kexec 'execute'.
>>   	 */
>> -	binary_runtime_size = ima_get_binary_runtime_size();
>> +	binary_runtime_size = ima_get_binary_runtime_size() +
>> +			      sizeof(struct ima_kexec_hdr) +
>> +			      (CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB * 1024);
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
> 

