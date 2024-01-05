Return-Path: <linux-integrity+bounces-671-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B30825B36
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jan 2024 20:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50227B23209
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Jan 2024 19:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D0B35F09;
	Fri,  5 Jan 2024 19:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gO2OaLNC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD93E35EF7
	for <linux-integrity@vger.kernel.org>; Fri,  5 Jan 2024 19:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id D249A20ACF29;
	Fri,  5 Jan 2024 11:50:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D249A20ACF29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1704484259;
	bh=Ql4Awcr9cJ6en22RzD+jHkpP0ibJROvhwbc9bt1K8pk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gO2OaLNCtWWy1nnG/3fhPaCRUgIkpL9T4IN95OCptxklMH14CiTqEC/ghmOV5iJv0
	 4jIVPzYCl43LiX+MzT7UU5ljJGP1clUCwFre7UoqFbdkMrQUzZ4W5SFVNwDagEJHOl
	 xTZFuTxQhRIcj5hcOwNgmSKr6iIvHv3LA7G53gmA=
Message-ID: <7ed7dccf-8482-4285-b21e-d518cb20d9e9@linux.microsoft.com>
Date: Fri, 5 Jan 2024 11:50:58 -0800
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
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <c174d4d7d3ab646f0e0ebf5aa1dd6894f22dbc02.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/20/23 12:44, Mimi Zohar wrote:
> On Fri, 2023-12-15 at 17:07 -0800, Tushar Sugandhi wrote:
>> If the new measurements are added to the IMA log while it is being
>> being copied to the kexec buffer during kexec 'execute', it can miss
>> copying those new measurements to the kexec buffer, and the buffer can go
>> out of sync with TPM PCRs.  This could result in breaking the integrity
>> of the measurements after the kexec soft reboot to the new Kernel.
>>
>> Add a check in the ima_add_template_entry() function not to measure
>> events and return from the function early when 'suspend_ima_measurements'
>> flag is set.
>>
>> This ensures the consistency of the IMA measurement list while copying
>> them to the kexec buffer.  When the 'suspend_ima_measurements' flag is
>> set, any new measurements will be ignored until the flag is unset.  This
>> allows the buffer to be safely copied without worrying about concurrent
>> modifications to the measurement list.  This is crucial for maintaining
>> the integrity of the measurements during a kexec soft reboot.
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> ---
>>   security/integrity/ima/ima_queue.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
>> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
>> index cb9abc02a304..5946a26a2849 100644
>> --- a/security/integrity/ima/ima_queue.c
>> +++ b/security/integrity/ima/ima_queue.c
>> @@ -195,6 +195,19 @@ int ima_add_template_entry(struct ima_template_entry *entry, int violation,
>>   		}
>>   	}
>>   
>> +	/*
>> +	 * suspend_ima_measurements will be set if the system is
>> +	 * undergoing kexec soft boot to a new kernel.
>> +	 * suspending measurements in this short window ensures the
>> +	 * consistency of the IMA measurement list during copying
>> +	 * of the kexec buffer.
>> +	 */
>> +	if (atomic_read(&suspend_ima_measurements)) {
>> +		audit_cause = "measurements_suspended";
>> +		audit_info = 0;
>> +		goto out;
>> +	}
>> +
>>   	result = ima_add_digest_entry(entry,
>>   				      !IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE));
>>   	if (result < 0) {
> 
> I assume you meant to include the suspend/resume code in "ima: kexec:
> move ima log copy from kexec load to execute"  in this patch.
> 

Sure, I can move the suspend/resume code from Patch 2/7 of this series
to this patch (5/7).

Earlier I introduced the suspend/resume functionality in patch 2 because
it was used in the functions in that patch.

But shifting it hear will make the patches cleaner.

~Tushar

