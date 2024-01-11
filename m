Return-Path: <linux-integrity+bounces-743-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEB782B4AD
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jan 2024 19:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E06902815A1
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jan 2024 18:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189E454BC1;
	Thu, 11 Jan 2024 18:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RkX1TdGn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B654354BC0
	for <linux-integrity@vger.kernel.org>; Thu, 11 Jan 2024 18:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 36D8020B3CC1;
	Thu, 11 Jan 2024 10:17:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 36D8020B3CC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1704997076;
	bh=seE6BYr+cMuO0qFfh44sOOBr4O2KLpUiZvXYO2myDXA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RkX1TdGnmCwd7Fpw3cOxfW2QLaLgHaAQKdt6LgNOXvic6KI2SMQX89U/qSUDFbYVv
	 OahNZFv0VCmlcHbGGKzQU8As5/owEkkx6+3yGHXwndeQE+1Z4d0G08oLrwulfF2Azi
	 WqZfT/uSoTWoQgXvI8S0DJluLdrDH9zXlQPcVmu8=
Message-ID: <97681564-5930-4604-b8b9-b208873fc05f@linux.microsoft.com>
Date: Thu, 11 Jan 2024 10:17:48 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] ima: suspend measurements during buffer copy at
 kexec execute
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, roberto.sassu@huaweicloud.com,
 roberto.sassu@huawei.com, eric.snowberg@oracle.com, stefanb@linux.ibm.com,
 ebiederm@xmission.com, noodles@fb.com, bauermann@kolabnow.com,
 linux-integrity@vger.kernel.org, kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231216010729.2904751-1-tusharsu@linux.microsoft.com>
 <20231216010729.2904751-6-tusharsu@linux.microsoft.com>
 <c174d4d7d3ab646f0e0ebf5aa1dd6894f22dbc02.camel@linux.ibm.com>
 <7ed7dccf-8482-4285-b21e-d518cb20d9e9@linux.microsoft.com>
 <10d5bc81db27c21613dacace9bedad345705dcea.camel@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <10d5bc81db27c21613dacace9bedad345705dcea.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/11/24 09:30, Mimi Zohar wrote:
> On Fri, 2024-01-05 at 11:50 -0800, Tushar Sugandhi wrote:
>>
>> On 12/20/23 12:44, Mimi Zohar wrote:
>>> On Fri, 2023-12-15 at 17:07 -0800, Tushar Sugandhi wrote:
>>>> If the new measurements are added to the IMA log while it is being
>>>> being copied to the kexec buffer during kexec 'execute', it can miss
>>>> copying those new measurements to the kexec buffer, and the buffer can go
>>>> out of sync with TPM PCRs.  This could result in breaking the integrity
>>>> of the measurements after the kexec soft reboot to the new Kernel.
>>>>
>>>> Add a check in the ima_add_template_entry() function not to measure
>>>> events and return from the function early when 'suspend_ima_measurements'
>>>> flag is set.
>>>>
>>>> This ensures the consistency of the IMA measurement list while copying
>>>> them to the kexec buffer.  When the 'suspend_ima_measurements' flag is
>>>> set, any new measurements will be ignored until the flag is unset.  This
>>>> allows the buffer to be safely copied without worrying about concurrent
>>>> modifications to the measurement list.  This is crucial for maintaining
>>>> the integrity of the measurements during a kexec soft reboot.
>>>>
>>>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>>>> ---
>>>>    security/integrity/ima/ima_queue.c | 13 +++++++++++++
>>>>    1 file changed, 13 insertions(+)
>>>>
>>>> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
>>>> index cb9abc02a304..5946a26a2849 100644
>>>> --- a/security/integrity/ima/ima_queue.c
>>>> +++ b/security/integrity/ima/ima_queue.c
>>>> @@ -195,6 +195,19 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
>>>>    		}
>>>>    	}
>>>>    
>>>> +	/*
>>>> +	 * suspend_ima_measurements will be set if the system is
>>>> +	 * undergoing kexec soft boot to a new kernel.
>>>> +	 * suspending measurements in this short window ensures the
>>>> +	 * consistency of the IMA measurement list during copying
>>>> +	 * of the kexec buffer.
>>>> +	 */
>>>> +	if (atomic_read(&suspend_ima_measurements)) {
>>>> +		audit_cause = "measurements_suspended";
>>>> +		audit_info = 0;
>>>> +		goto out;
>>>> +	}
>>>> +
>>>>    	result = ima_add_digest_entry(entry,
>>>>    				      !IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE));
>>>>    	if (result < 0) {
>>>
>>> I assume you meant to include the suspend/resume code in "ima: kexec:
>>> move ima log copy from kexec load to execute"  in this patch.
>>>
>>
>> Sure, I can move the suspend/resume code from Patch 2/7 of this series
>> to this patch (5/7).
>>
>> Earlier I introduced the suspend/resume functionality in patch 2 because
>> it was used in the functions in that patch.
>>
>> But shifting it hear will make the patches cleaner.
> 
> Just a reminder this isn't the only issued mentioned in 2/7.  Please refer to it
> for the other comments (e.g. make not including/verifying the IMA segment hash a
> separate patch).
> 
> Before reposting, please remember to test after applying each patch in the patch
> set to ensure that the measurement list is properly carried across kexec.

Yes, I had read your responses on patch 2/7.
I have been meaning to respond to you on 2/7, but I kept getting 
distracted by some other work-items on my plate. Really sorry :(

I will respond to your comments on 2/7 by end of the day, and 
incorporate the feedback before reposting.



