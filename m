Return-Path: <linux-integrity+bounces-1234-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F38855AE0
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Feb 2024 07:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E6CF1F28B6E
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Feb 2024 06:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC62E610E;
	Thu, 15 Feb 2024 06:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WjitGxee"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E859475
	for <linux-integrity@vger.kernel.org>; Thu, 15 Feb 2024 06:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707980263; cv=none; b=NKcV3H005Uxubeq/J1XOkTFod+E27ynG97pvx64alQyAj1Cd+CIBy/aVfuAXajl+JCBsjw/rsRCLjMNWcfLIsmgtu3aH0yNaRPKA1Q0/+pcNcl4yjJ+ObSDxPjiEsg87ZdxZ2erqaRw+vR7WuCkguZwlXW2BUl/qjm4+cAvcazQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707980263; c=relaxed/simple;
	bh=wEeARzqLgVJhTUCTabMDPqxYtRN+HLMqCwrzr0f51N0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hkPRzMbyiuLzr0BereGU3E6JUvlFqKbpWsBykWe1ckYxrlGV4eB473IpB+km4xfASq4MS1MdiS1scmijwItjx3CrKdIvUSiEHhCIgZB2UC170BsawC0Af9oEvKH5Pr/COZ6G8QYAFFmwVndyimsDoIIoEXVZFT7vgH7++K5lK78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WjitGxee; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id CF46D20B2000;
	Wed, 14 Feb 2024 22:57:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CF46D20B2000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1707980262;
	bh=FQyYhigzXHz5a23leRzlzUBIp1BTtLBJq4YQ7x7fQ+k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WjitGxeepX5L+andlmfM9xc1FkM2YIU7q61m0XdL5KK00IjyGPUcNrRBhaOqn4mZL
	 zdB6JW1dTbxThTGyFMH5FwcRfkYcYZ0K5Dftjd5gslzA4ZnL88BGoBwdeCw1tcK6xS
	 tbb1PBuxZAF6+AbQCwilkL16SQbKKE16/h6UaEVE=
Message-ID: <b6895788-01cb-4f09-9d75-0f8ac64d5409@linux.microsoft.com>
Date: Wed, 14 Feb 2024 22:57:41 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/8] ima: measure kexec load and exec events as
 critical data
Content-Language: en-US
To: Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, noodles@fb.com,
 bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20240214153827.1087657-1-tusharsu@linux.microsoft.com>
 <20240214153827.1087657-9-tusharsu@linux.microsoft.com>
 <803ac44d-1d08-46f3-a41c-01f113a21c11@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <803ac44d-1d08-46f3-a41c-01f113a21c11@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2/14/24 13:00, Stefan Berger wrote:
> 
> 
> On 2/14/24 10:38, Tushar Sugandhi wrote:
>> The amount of memory allocated at kexec load, even with the extra memory
>> allocated, might not be large enough for the entire measurement list.  
>> The
>> indeterminate interval between kexec 'load' and 'execute' could 
>> exacerbate
>> this problem.
>>
>> Define two new IMA events, 'kexec_load' and 'kexec_execute', to be
>> measured as critical data at kexec 'load' and 'execute' respectively.
>> Report the allocated kexec segment size, IMA binary log size and the
>> runtime measurements count as part of those events.
>>
>> These events, and the values reported through them, serve as markers in
>> the IMA log to verify the IMA events are captured during kexec soft
>> reboot.  The presence of a 'kexec_load' event in between the last two
>> 'boot_aggregate' events in the IMA log implies this is a kexec soft
>> reboot, and not a cold-boot.  And the absence of 'kexec_execute' event
>> after kexec soft reboot implies missing events in that window which
>> results in inconsistency with TPM PCR quotes, necessitating a cold boot
>> for a successful remote attestation.
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> ---
>>   security/integrity/ima/ima_kexec.c | 34 +++++++++++++++++++++++++++++-
>>   1 file changed, 33 insertions(+), 1 deletion(-)
>>
>> diff --git a/security/integrity/ima/ima_kexec.c 
>> b/security/integrity/ima/ima_kexec.c
>> index 50903d4ce880..31495a043959 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -17,6 +17,8 @@
>>   #include "ima.h"
>>   #ifdef CONFIG_IMA_KEXEC
>> +#define IMA_KEXEC_EVENT_LEN 256
>> +
>>   static struct seq_file ima_kexec_file;
>>   static void *ima_kexec_buffer;
>>   static size_t kexec_segment_size;
>> @@ -38,6 +40,10 @@ static void ima_free_kexec_file_buf(struct seq_file 
>> *sf)
>>   static int ima_alloc_kexec_file_buf(size_t segment_size)
>>   {
>> +    char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
>> +    size_t buf_size;
>> +    long len;
>> +
>>       /*
>>        * kexec 'load' may be called multiple times.
>>        * Free and realloc the buffer only if the segment_size is
>> @@ -47,7 +53,7 @@ static int ima_alloc_kexec_file_buf(size_t 
>> segment_size)
>>           ima_kexec_file.size == segment_size &&
>>           ima_kexec_file.read_pos == 0 &&
>>           ima_kexec_file.count == sizeof(struct ima_kexec_hdr))
>> -        return 0;
>> +        goto out;
>>       ima_free_kexec_file_buf(&ima_kexec_file);
>> @@ -60,6 +66,18 @@ static int ima_alloc_kexec_file_buf(size_t 
>> segment_size)
>>       ima_kexec_file.read_pos = 0;
>>       ima_kexec_file.count = sizeof(struct ima_kexec_hdr);    /* 
>> reserved space */
>> +out:
>> +    buf_size = ima_get_binary_runtime_size();
>> +    len = atomic_long_read(&ima_htable.len);
>> +
>> +    scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
>> +          "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;"
>> +          "ima_runtime_measurements_count=%ld;",
>> +          segment_size, buf_size, len);
>> +
>> +    ima_measure_critical_data("ima_kexec", "kexec_load", 
>> ima_kexec_event,
>> +                  strlen(ima_kexec_event), false, NULL, 0);
>> +
>>       return 0;
>>   }
>> @@ -186,10 +204,12 @@ void ima_add_kexec_buffer(struct kimage *image)
>>   static int ima_update_kexec_buffer(struct notifier_block *self,
>>                      unsigned long action, void *data)
>>   {
>> +    char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
>>       void *buf = NULL;
>>       size_t buf_size;
>>       int ret = NOTIFY_OK;
>>       bool resume = false;
>> +    long len;
>>       if (!kexec_in_progress) {
>>           pr_info("%s: No kexec in progress.\n", __func__);
>> @@ -201,6 +221,18 @@ static int ima_update_kexec_buffer(struct 
>> notifier_block *self,
>>           return ret;
>>       }
>> +    buf_size = ima_get_binary_runtime_size();
>> +    len = atomic_long_read(&ima_htable.len);
>> +
>> +    scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
>> +          "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;"
>> +          "ima_runtime_measurements_count=%ld;",
>> +          kexec_segment_size, buf_size, len);
>> +
>> +    ima_measure_critical_data("ima_kexec", "kexec_execute",
>> +                  ima_kexec_event, strlen(ima_kexec_event),
>> +                  false, NULL, 0);
>> +
>>       ima_measurements_suspend();
>>       ret = ima_dump_measurement_list(&buf_size, &buf,
> 
> It's twice the same code almost in the same file. You could move it into 
> a function.
Fair enough. Will do.

~Tushar

