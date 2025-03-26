Return-Path: <linux-integrity+bounces-5454-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D273A7267C
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 23:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03CB917AD4E
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Mar 2025 22:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9261A0BF1;
	Wed, 26 Mar 2025 22:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sKgV6M9w"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B65149C41;
	Wed, 26 Mar 2025 22:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743029220; cv=none; b=F7jWyz9067Qisg3/GLDyq1B8Hf7AqCEL7N4qokuMJCiPx7w5V2IRDTJ9g0Nnrri5UMm3SlD61PcaBXZqC01j4fx03u7wsSD+BU1DtAvIRLS1Sxt6mhk24A2lbzWO2HInC+ef3qzcWnFO4bHLBlMK4dM6DSE6FPQHAhD+XQFYN9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743029220; c=relaxed/simple;
	bh=7P3UYO+P9hGo9sz9SOt5vSKtq1wCmqOzSFvHPDcbymk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sKo0xzU1k1nfUKMRllQkj8MWudvMgCH7imq7qeZW1KNioB2ySc0hKkPsJXqOvqYTGRHkKYJYC+AeHWehp5xslKmYUaASkkx5b24PWxd30bSnXkp3C2/N2ANJ0PxT6r/2jEFDnpBivFIgw6DohYPZbh9c4KYNFaHrUtRN5HJGzxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sKgV6M9w; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.17.64.132] (unknown [131.107.147.132])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0EFD4210235E;
	Wed, 26 Mar 2025 15:46:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0EFD4210235E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1743029217;
	bh=WpQRiPMWre5w+oBe5t52C7npv5APr1INrJO/mypsiTE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sKgV6M9wLQw9WiOTCQUm1nhq24BoZZcDn4uhQq9k6apxualjEFDdcPOgCFCoz572i
	 ciFXzhFzDl/Cyy2JIVFr2Z9s8ffkrWtdsNDF/CSiODCu6HqGrq3dMBIDm8fz/T4P+j
	 snRRve0tkABnzrVk+X1KBYQKlJSd7CM9tW3yEt/w=
Message-ID: <2d2ea573-1ddd-44b4-8ba3-4ae86313d63f@linux.microsoft.com>
Date: Wed, 26 Mar 2025 15:46:55 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 6/8] ima: kexec: move IMA log copy from kexec load to
 execute
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
 <20250318010448.954-7-chenste@linux.microsoft.com>
 <Z9t4LVpE470DMBYU@MiWiFi-R3L-srv>
 <3d7b5e06-5166-46bb-89dc-a0b95ca7c767@linux.microsoft.com>
 <Z+E7X6LuQ82q1i5V@MiWiFi-R3L-srv>
 <6583378c-55ee-4192-a95f-ebaf3f708bbb@linux.microsoft.com>
 <Z+NmLtn0vojVYJ3H@MiWiFi-R3L-srv>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <Z+NmLtn0vojVYJ3H@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/25/2025 7:27 PM, Baoquan He wrote:
> On 03/25/25 at 03:27pm, steven chen wrote:
>> On 3/24/2025 4:00 AM, Baoquan He wrote:
>>> On 03/21/25 at 09:23am, steven chen wrote:
>>>> On 3/19/2025 7:06 PM, Baoquan He wrote:
>>>>> On 03/17/25 at 06:04pm, steven chen wrote:
>>>>> ...snip...
>>>>>> ---
>>>>>>     kernel/kexec_file.c                | 10 ++++++
>>>>>>     security/integrity/ima/ima_kexec.c | 51 ++++++++++++++++++------------
>>>>>>     2 files changed, 40 insertions(+), 21 deletions(-)
>>>>>>
>>>>>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>>>>>> index 606132253c79..ab449b43aaee 100644
>>>>>> --- a/kernel/kexec_file.c
>>>>>> +++ b/kernel/kexec_file.c
>>>>>> @@ -201,6 +201,13 @@ kimage_validate_signature(struct kimage *image)
>>>>>>     }
>>>>>>     #endif
>>>>>> +static void kimage_file_post_load(struct kimage *image)
>>>>>> +{
>>>>>> +#ifdef CONFIG_IMA_KEXEC
>>>>>> +	ima_kexec_post_load(image);
>>>>>> +#endif
>>>>>> +}
>>>>>> +
>>>>>>     /*
>>>>>>      * In file mode list of segments is prepared by kernel. Copy relevant
>>>>>>      * data from user space, do error checking, prepare segment list
>>>>>> @@ -428,6 +435,9 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
>>>>>>     	kimage_terminate(image);
>>>>>> +	if (!(flags & KEXEC_FILE_ON_CRASH))
>>>>>> +		kimage_file_post_load(image);
>>>>> machine_kexec_post_load() is called by both kexec_load and kexec_file_load,
>>>>> we should use it to do things post load, but not introducing another
>>>>> kimage_file_post_load().
>>>> Hi Baoquan,
>>>>
>>>> Could you give me more detail about this?
>>> I mean machine_kexec_post_load() is the place where post load operations
>>> are done, including kexec_load and kexec_file_load. There's no need to
>>> specifically introduce a kimage_file_post_load() to do post load
>>> operaton for kexec_file_load.
>> Hi Baoquan,
>>
>> Updating the machine_kexec_post_load() API to carry flags would indeed
>> require changes to multiple files. This approach involves the condition
>> check if (!(flags & KEXEC_FILE_ON_CRASH)) and ensuring that the flags are
>> properly passed and handled across the relevant file
>>
>> if just adding a API kimage_file_post_load() here, it is much easy and
>> clean, right?
> Hmm, it's easier, while maybe not good. We should not repeatedly
> introduce similar things into codes. Here, it's similar as
> what kexec_apply_relocations() and arch_kexec_apply_relocations() are
> doing.
>
> int machine_kexec_post_load(struct kimage *image)
> {
> #ifdef CONFIG_IMA_KEXEC
>          ima_kexec_post_load(image);
> #endif
> 	return arch_machine_kexec_post_load();
> }
>
> Then a generic arch_machine_kexec_post_load(struct kimage *image)
> {return 0;} version, and a arm64 specific version.
>
> Is it OK to you?

Hi Baoquan,

Thanks for your suggestion. I will update in the next version.

Steven


