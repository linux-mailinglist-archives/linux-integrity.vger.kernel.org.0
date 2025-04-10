Return-Path: <linux-integrity+bounces-5784-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B683A84C6B
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 20:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C31D4C67EC
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 18:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982AC28D85A;
	Thu, 10 Apr 2025 18:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sJT/EtBh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F176128CF4F;
	Thu, 10 Apr 2025 18:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744310980; cv=none; b=EOKiSM8No32OEgXcclNmrnS1fVY6CgS3u3cEAnbApnqQVHuJ6nC8h4S/gNcFC9rfI2EvwxoR9z4pIAeTal1UENJaJBKGInRiI/NxKlILGODuHQMQux9XFcU5WfVodpnvxTqjxqM7FQY66n2eYVFGKsJzCjlgQRF6kcgBwGYcK1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744310980; c=relaxed/simple;
	bh=05WIDChZBsf5hm61fmbbzmRk7VRBilZqMKD0K9anqV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dw0UeDD2Ol//fdoKPShfprTyvGKnOCapjokyj4I27LYG0iDv3IaA5BBP3Au8EmDOU4JXNYxYuxDjC56sI1yXgxRxMkCONmvz+qCbl9L2OGE7Xwm9QJsWMqtQw+QTtSapAp5sYL1w35C78lAs5mFu0o6H9IVW+HWqdoFuRLNcFsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sJT/EtBh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.70.201.233] (unknown [20.110.218.7])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6FE082113E91;
	Thu, 10 Apr 2025 11:49:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6FE082113E91
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744310978;
	bh=/ndaXbg+9v01LL+JaSf57t3QrfsbQ+JsySlifsbzGHw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sJT/EtBhK6kS9ZV0DuQvKzTSzMgAmh4uIVBXW9o3Qsow8w45ejI+kA5lHTo09ob1i
	 r131ZsQvexMDa4v+EQ8veAHhPotTwRSr5j5W6ck1zpgt3QfJA/51R9XShcL5cC/Jgy
	 tdC1djBy4E3RUno7NNDs8cLChbPzQAfGzLAUcjDY=
Message-ID: <692121f5-fc17-45b5-b4c0-c4393bb05bc4@linux.microsoft.com>
Date: Thu, 10 Apr 2025 11:49:34 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 8/9] ima: make the kexec extra memory configurable
To: Mimi Zohar <zohar@linux.ibm.com>, Baoquan He <bhe@redhat.com>,
 Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc: stefanb@linux.ibm.com, roberto.sassu@huaweicloud.com,
 roberto.sassu@huawei.com, eric.snowberg@oracle.com, ebiederm@xmission.com,
 paul@paul-moore.com, code@tyhicks.com, bauermann@kolabnow.com,
 linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 madvenka@linux.microsoft.com, James.Bottomley@hansenpartnership.com,
 vgoyal@redhat.com, dyoung@redhat.com
References: <20250402124725.5601-1-chenste@linux.microsoft.com>
 <20250402124725.5601-9-chenste@linux.microsoft.com>
 <Z/eVWQw3z7yyzyxb@MiWiFi-R3L-srv>
 <8b5e5495-4b11-4acc-8df1-fb94b2a34f0f@linux.microsoft.com>
 <8120a7b1eafaa5452981484671e841a7a7872877.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <8120a7b1eafaa5452981484671e841a7a7872877.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/10/2025 11:04 AM, Mimi Zohar wrote:
> On Thu, 2025-04-10 at 09:59 -0700, steven chen wrote:
>> On 4/10/2025 2:54 AM, Baoquan He wrote:
>>> On 04/02/25 at 05:47am, steven chen wrote:
>>>> The extra memory allocated for carrying the IMA measurement list across
>>>> kexec is hard-coded as half a PAGE.  Make it configurable.
>>>>
>>>> Define a Kconfig option, IMA_KEXEC_EXTRA_MEMORY_KB, to configure the
>>>> extra memory (in kb) to be allocated for IMA measurements added during
>>>> kexec soft reboot.  Ensure the default value of the option is set such
>>>> that extra half a page of memory for additional measurements is allocated
>>>> for the additional measurements.
>>>>
>>>> Update ima_add_kexec_buffer() function to allocate memory based on the
>>>> Kconfig option value, rather than the currently hard-coded one.
>>>>
>>>> Suggested-by: Stefan Berger <stefanb@linux.ibm.com>
>>>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>>>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>>>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>>>> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>>>> ---
>>>>    security/integrity/ima/Kconfig     | 10 ++++++++++
>>>>    security/integrity/ima/ima_kexec.c | 16 +++++++++++-----
>>>>    2 files changed, 21 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
>>>> index 475c32615006..d73c96c3c1c9 100644
>>>> --- a/security/integrity/ima/Kconfig
>>>> +++ b/security/integrity/ima/Kconfig
>>>> @@ -321,4 +321,14 @@ config IMA_DISABLE_HTABLE
>>>>    	help
>>>>    	   This option disables htable to allow measurement of duplicate records.
>>>>    
>>>> +config IMA_KEXEC_EXTRA_MEMORY_KB
>>>> +	int "Extra memory for IMA measurements added during kexec soft reboot"
>>>> +	depends on IMA_KEXEC
>>>> +	default 0
>>> Usually a new Kconfig item which accepts a range should define the range
>>> boundary, otherwise it's not clear to people how large or how small it
>>> can be set. For example, can I set it as value of 1<<40? We should at
>>> least estimate a possible upper limit for it for other people's
>>> reference. My personal opinion.
>> Hi Baoquan,
>>
>> How about I set range 2-40? Default set as 2, same as the fixed setting.
> 0, the current default, sets the "extra" memory to the existing "extra half a
> page of memory for the additional measurements".  For backwards compatibility,
> please do not change this.
>
> The requirement for a larger "extra" measurement is coming from Microsoft. If
> this isn't any longer a requirement, we could drop this patch.  Lakshmi, do you
> have any thoughts on this?
>
> thanks,
>
> Mimi

How about the range set as 0-40 and the default as 0?

We (Microsoft) are ok with 0 as the default.

Thanks

>>> The rest looks good to me.
>>>
>>>
>>>> +	help
>>>> +	  IMA_KEXEC_EXTRA_MEMORY_KB determines the extra memory to be
>>>> +	  allocated (in kb) for IMA measurements added during kexec soft reboot.
>>>> +	  If set to the default value of 0, an extra half page of memory for those
>>>> +	  additional measurements will be allocated.
>>>> +
>>>>    endif
>>> ...snip...
>>
>>


