Return-Path: <linux-integrity+bounces-749-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F1182B63E
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jan 2024 21:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F6A02889AE
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jan 2024 20:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7695A5810E;
	Thu, 11 Jan 2024 20:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ATNX2wP9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DDD5810C
	for <linux-integrity@vger.kernel.org>; Thu, 11 Jan 2024 20:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5D58D20B3CC1;
	Thu, 11 Jan 2024 12:52:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5D58D20B3CC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1705006363;
	bh=U07oEfekVzDj2Hd+ToSATINRRHXIoJTAZMkZ474ONcE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ATNX2wP9sCU6UMS744ITvfdCNZWesi+PZ/ZUhFfT+hmPVwO91G5sGKHAgYdbkqmAL
	 FGeX4kbGjhsjYhYZt6WvG4L6XfBWyzX9AiVevmLvxf9zmDgYGjK/j9HxYxpAWrzQKe
	 QF4QjA5kh4ShPVpHa40Ta9EiXNN2d9zI9XrlFsCs=
Message-ID: <af09bb62-a637-4e30-884a-9ce1a5bf030c@linux.microsoft.com>
Date: Thu, 11 Jan 2024 12:52:43 -0800
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
To: Stefan Berger <stefanb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, noodles@fb.com,
 bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
 <20231216010729.2904751-7-tusharsu@linux.microsoft.com>
 <fbe6aa7577875b23a9913a39f858f06f1d2aa903.camel@linux.ibm.com>
 <b78bbf3f-da39-47a6-aac3-581c8d2827a0@linux.microsoft.com>
 <3e8cb0bd77a2b73613b19febb2b3121ef0ea8255.camel@linux.ibm.com>
 <0df62e0e-a9d5-434c-866c-936cafeed480@linux.microsoft.com>
 <a7c5feb3-b9ef-45c1-bd1c-2bf0e4b7d0c5@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <a7c5feb3-b9ef-45c1-bd1c-2bf0e4b7d0c5@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/11/24 11:20, Stefan Berger wrote:
> 
> 
> On 1/11/24 13:13, Tushar Sugandhi wrote:
>>
>>
>> On 1/7/24 09:00, Mimi Zohar wrote:
>>> On Fri, 2024-01-05 at 12:20 -0800, Tushar Sugandhi wrote:
>>>>>> diff --git a/security/integrity/ima/Kconfig 
>>>>>> b/security/integrity/ima/Kconfig
>>>>>> index 60a511c6b583..8792b7aab768 100644
>>>>>> --- a/security/integrity/ima/Kconfig
>>>>>> +++ b/security/integrity/ima/Kconfig
>>>>>> @@ -338,3 +338,12 @@ config IMA_DISABLE_HTABLE
>>>>>>       default n
>>>>>>       help
>>>>>>          This option disables htable to allow measurement of 
>>>>>> duplicate records.
>>>>>> +
>>>>>> +config IMA_KEXEC_EXTRA_MEMORY_KB
>>>>>> +    int
>>>>>> +    depends on IMA && IMA_KEXEC
>>>>>> +    default 64
>>>>>
>>>>> Since this isn't optional, the default should remain as a half page.
>>>>> Since a page is architecture specific, the default will need to be 
>>>>> arch
>>>>>    specific
>>>>>
>>>> It was a feedback from Stefan in the V2 of this series to convert it
>>>> from number of PAGES to KB.[1]
>>>>
>>>> But I can revert it to number of pages again.
>>>>
>>>> Also, making the default value as a fraction (1/2 page) feels weird for
>>>> a CONFIG variable.
>>>>
>>>> Is it ok to make the default value as one page rather than half page?
>>>
>>> The point is not whether the extra memory is specified in terms of 
>>> pages or KB.
>>> For backwards compatibility the existing default should be the same as
>>> previously.  This means the default needs to be architecture specific.b
>>> $ uname -m; getconf PAGESIZE
>>> x86_64
>>> 4096
>>> $ uname -m; getconf PAGESIZE
>>> ppc64le
>>> 65536
>>>
>>> For example:
>>>
>>> default 32 if PPC_64K_PAGES
>>> default 2
>>>
>> Ok. Thanks for the clarification.
>>
>>
>> Do we want to support only 64K or 4K as possible PAGE_SIZE values?
>> I spot checked a few architectures, there are scenarios where PAGE_SIZE
>> could be 8K, 16K, 128K, 256K etc. And of course mega pages with
>> PAGE_SIZE IN MBs (details below).
> 
> I would let the user specify the number of kilobytes to reserve and from 
> this you can conclude the page numbers:
> 
> needed_pages = KBs_TO_RESERVE / PAGE_SIZE
> if (KBs_TO_RESERVER % PAGE_SIZE)
>      needed_pages++;
> 
>     Stefan
Thanks Stefan.

But the issue here is about the default value,
not the user specified value.

Mimi is suggesting to keep the default value half-a-page,
to maintain backwards compatibility.

If we go with the KBs approach -
half-a-page translates to different KBs on different architectures.
And setting the right default value in KBs which would translate to
the desired half-a-page, on a given arch, inside the Kconfig seems
fragile (as I mentioned in the context of Option A in my previous
response.

And if we go with num_pages approach -
putting a fractional value (0.5) as a default in Kconfig seems to be non
trivial too.

Translating num_pages to KBs is trivial in code, but I think its
orthogonal to this conversation, since its about setting the desired 
arch specific default value in Kconfig.


Option A:
---------
config IMA_KEXEC_EXTRA_MEMORY_KB
     int
     depends on IMA && IMA_KEXEC
     default 128 if PAGE_SIZE_256KB
     default 32 if PPC_64K_PAGES || PAGE_SIZE_64KB || PARISC_PAGE_SIZE_16KB
     default 16 if PAGE_SIZE_32KB
     default 8 if PAGE_SIZE_16KB || ARC_PAGE_SIZE_16K || 
PARISC_PAGE_SIZE_16KB
     default 4 if PAGE_SIZE_8KB || ARC_PAGE_SIZE_8K
     default 2
       IMA_KEXEC_EXTRA_MEMORY_KB determines the number of extra
       memory (in KB) to be allocated for IMA measurements added
       during kexec soft-reboot.

Option B:
--------
config IMA_KEXEC_EXTRA_PAGES
     int
     depends on IMA && IMA_KEXEC
     default 1
     help
       IMA_KEXEC_EXTRA_PAGES determines the number of extra
       pages to be allocated for IMA measurements added during
       kexec soft-reboot.

~Tushar

