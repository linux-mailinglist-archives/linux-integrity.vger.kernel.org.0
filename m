Return-Path: <linux-integrity+bounces-4665-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B64EA211AE
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Jan 2025 19:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4C173A179F
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Jan 2025 18:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D931D9694;
	Tue, 28 Jan 2025 18:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cpoKuNWY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB0E1DE2CE;
	Tue, 28 Jan 2025 18:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738089307; cv=none; b=nKZU2eW+0gM9Q/1FnEw/rNu9AHjQYXVAZC0ZzHpe70YxuOr589HHeoU9R4s3WWc1AyOg5jBWUUkCHR9A2VhZRAPadHfzB/g52qpIusfKpImtNi6P6knKK+yn7vf8K3TOsSr9XZqtk4BJxa9sT6iYHmYGzwg18/XF1LeGbuoiPLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738089307; c=relaxed/simple;
	bh=MpLHH0f+1aIQxRv5t7PFqXCoIM68YpdIc8k2MwUnHn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rAAfM+o+nGiENkKWDUHpiMs6nIPZ2MMM1brRBkfhRXVtZmJbFNA7NxDv9ICOMGgHfVy8Dq0Y042cIz+mH4RcPHiARAduGWAJD9TOHcCi21OI2TDFX1u97dsSBferdZEN5jIBsdOWfyloFLVh+EBmzjrK/41xKVXgldQWweTDR8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cpoKuNWY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.17.64.116] (unknown [131.107.1.180])
	by linux.microsoft.com (Postfix) with ESMTPSA id B8F4D203718D;
	Tue, 28 Jan 2025 10:35:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B8F4D203718D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738089305;
	bh=O98YilHhGsrorg0Ph/Zdtym/83ubnAnbe2dgc3tJbnk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cpoKuNWY/ecy/gIGAhBV6L0O+hP5MslZFkmu2vaZ+Lq1HUKv0DOCOl3RCWKLhYz2h
	 oaYZ/654HF6PqnthLAQaoQKdUZHuxS0MTFY4PXQ+/E80vn4z8iS9uPIBXsDonNw5AZ
	 8WCKRLsbd20wTYhA/q9zDnYxd/AhDUPIUsAPCJ14=
Message-ID: <59f65539-2e52-47d7-8379-2c89d8a9743e@linux.microsoft.com>
Date: Tue, 28 Jan 2025 10:35:05 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] ima: measure kexec load and exec events as critical
 data
To: Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com,
 roberto.sassu@huaweicloud.com, petr@tesarici.cz, eric.snowberg@oracle.com,
 paul@paul-moore.com, code@tyhicks.com, nramas@linux.microsoft.com,
 James.Bottomley@HansenPartnership.com, madvenka@linux.microsoft.com
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250124225547.22684-1-chenste@linux.microsoft.com>
 <20250124225547.22684-8-chenste@linux.microsoft.com>
 <4efc1c73-6dc9-43ed-8143-74bb270f7fe7@linux.ibm.com>
 <19cd9b56-186c-4cc9-8d84-2b3d87591714@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <19cd9b56-186c-4cc9-8d84-2b3d87591714@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/28/2025 9:29 AM, Stefan Berger wrote:
>
>
> On 1/28/25 10:28 AM, Stefan Berger wrote:
>>
>>
>> On 1/24/25 5:55 PM, steven chen wrote:
>>> The amount of memory allocated at kexec load, even with the extra 
>>> memory
>>> allocated, might not be large enough for the entire measurement 
>>> list.  The
>>> indeterminate interval between kexec 'load' and 'execute' could 
>>> exacerbate
>>> this problem.
>>>
>>> Define two new IMA events, 'kexec_load' and 'kexec_execute', to be
>>> measured as critical data at kexec 'load' and 'execute' respectively.
>>> Report the allocated kexec segment size, IMA binary log size and the
>>> runtime measurements count as part of those events.
>>>
>>> These events, and the values reported through them, serve as markers in
>>> the IMA log to verify the IMA events are captured during kexec soft
>>> reboot.  The presence of a 'kexec_load' event in between the last two
>>> 'boot_aggregate' events in the IMA log implies this is a kexec soft
>>> reboot, and not a cold-boot. And the absence of 'kexec_execute' event
>>> after kexec soft reboot implies missing events in that window which
>>> results in inconsistency with TPM PCR quotes, necessitating a cold boot
>>> for a successful remote attestation.
>>>
>>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>>> Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>>> ---
>>>   security/integrity/ima/ima_kexec.c | 23 +++++++++++++++++++++++
>>>   1 file changed, 23 insertions(+)
>>>
>>> diff --git a/security/integrity/ima/ima_kexec.c 
>>> b/security/integrity/ ima/ima_kexec.c
>>> index c9c916f69ca7..d416ca0382cb 100644
>>> --- a/security/integrity/ima/ima_kexec.c
>>> +++ b/security/integrity/ima/ima_kexec.c
>>> @@ -17,6 +17,8 @@
>>>   #include "ima.h"
>>>   #ifdef CONFIG_IMA_KEXEC
>>> +#define IMA_KEXEC_EVENT_LEN 256
>>> +
>>>   static struct seq_file ima_kexec_file;
>>>   static void *ima_kexec_buffer;
>>>   static size_t kexec_segment_size;
>>> @@ -36,6 +38,24 @@ static void ima_free_kexec_file_buf(struct 
>>> seq_file *sf)
>>>       ima_reset_kexec_file(sf);
>>>   }
>>> +static void ima_measure_kexec_event(const char *event_name)
>>> +{
>>> +    char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
>>> +    size_t buf_size = 0;
>>> +    long len;
>>> +
>>> +    buf_size = ima_get_binary_runtime_size();
>>> +    len = atomic_long_read(&ima_htable.len);
>>> +
>>> +    scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
>>> + "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;"
>>> +            "ima_runtime_measurements_count=%ld;",
>>> +                kexec_segment_size, buf_size, len);
>>> +
>>> +    ima_measure_critical_data("ima_kexec", event_name, 
>>> ima_kexec_event,
>>> +                    strlen(ima_kexec_event), false, NULL, 0);
>>> +}
>>> +
>>>   static int ima_alloc_kexec_file_buf(size_t segment_size)
>>>   {
>>>       /*
>>> @@ -60,6 +80,7 @@ static int ima_alloc_kexec_file_buf(size_t 
>>> segment_size)
>>>   out:
>>>       ima_kexec_file.read_pos = 0;
>>>       ima_kexec_file.count = sizeof(struct ima_kexec_hdr); /* 
>>> reserved space */
>>> +    ima_measure_kexec_event("kexec_load");
>>>       return 0;
>>>   }
>>> @@ -206,6 +227,8 @@ static int ima_update_kexec_buffer(struct 
>>> notifier_block *self,
>>>       if (ret)
>>>           pr_err("Dump measurements failed. Error:%d\n", ret);
>>> +    else
>>> +        ima_measure_kexec_event("kexec_execute");
>
> The problem is that this here ^^^^ currently comes after this block:
>
>         ret = ima_dump_measurement_list(&buf_size, &buf,
>                                         kexec_segment_size);
>
>         if (ret)
>                 pr_err("Dump measurements failed. Error:%d\n", ret);
>         else
>                 ima_measure_kexec_event("kexec_execute");  <--- after 
> the dump
>
> It has to be done before so that whatever it adds to the measurement 
> list gets dumped as well. So this works for my testing:
>
> +       ima_measure_kexec_event("kexec_execute");
> +
>         ret = ima_dump_measurement_list(&buf_size, &buf,
>                                         kexec_segment_size);
>
>         if (ret)
>                 pr_err("Dump measurements failed. Error:%d\n", ret);
>
>
>>>       if (buf_size != 0)
>>>           memcpy(ima_kexec_buffer, buf, buf_size);
>>
>>
>> I have been doing kexec's (on ppc64 KVM) applying one patch after 
>> another in this series and then testing with this command:
>>
>> evmctl ima_measurement --ignore-violations /sys/kernel/security/ima/ 
>> binary_runtime_measurements
>>
>> Unfortunately it breaks at this patch. I am not sure what it is due to.
>>
>>
Thanks Stefan. Will update it in next release


