Return-Path: <linux-integrity+bounces-4755-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC743A2CC88
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Feb 2025 20:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C66531886D14
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Feb 2025 19:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9EB1A3142;
	Fri,  7 Feb 2025 19:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="A1xWaKB3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E1919D072;
	Fri,  7 Feb 2025 19:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738956406; cv=none; b=H51MnA6LPsWuNGARt4VRTTg8AsQBgy35PxsdmHwdUnZrOBwF0NDZrInFOfF30u7QZoSZDi/kFjd3B8sc8sL5b+H5ins+XSDdIRoLoqjFVZvtZffN/R1ajtMhk1wIjwJSxv6nF84MTl0uwmjh6Tg+EnvaBc+TmXaIp1whWIRmUWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738956406; c=relaxed/simple;
	bh=k0Zde3ZCoKnNvkcAgebFE1C8C65rYcxrWiIZbEaOWDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CSdaT6cl5eGvqgig+rx31FIM2OL6krTljTeIdwpP5dgHB5qKiYGK0MAeJum4S1NLtl45ywCwbD14yXCHovHil3grHM9bj3JSrcizomXjjw64vwvEKFINvpwlro+8RpE6y0fKAPIipNOg64xjv80pwx4HfokkeagfMGxbmZdCtOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=A1xWaKB3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.17.64.61] (unknown [131.107.8.61])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5C0222107303;
	Fri,  7 Feb 2025 11:26:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5C0222107303
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738956403;
	bh=bCF9KTGATV07tkTcQHYttgvePnMruMM0SaW9KUYhyWk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=A1xWaKB3sPBOuKnzR+J7xb/jHr9BG4z4xks8EZD/eSp0Zxg8MMXkQYlOffSa75eJj
	 pZMXYw1o6gNaeR8HpOvw0I56iSAso+PFdDhAlIuOCP+xfNcUcpF1fcAHN2GerYoN+H
	 eFI8cYlRYpqtLtwTWq5CmSMWfXRSsdLm/oncwKS8=
Message-ID: <f1591776-d2bd-4e7b-b308-220b0edd93d3@linux.microsoft.com>
Date: Fri, 7 Feb 2025 11:26:43 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/7] ima: measure kexec load and exec events as
 critical data
To: Stefan Berger <stefanb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@HansenPartnership.com
References: <20250203232033.64123-1-chenste@linux.microsoft.com>
 <20250203232033.64123-9-chenste@linux.microsoft.com>
 <3a4053664cde06622e1f9a9d8e3a5aab80b9beb7.camel@linux.ibm.com>
 <b2b3fa5d3d20284f790ce74bb97da2b9795a0e0e.camel@linux.ibm.com>
 <8ca0bdd9-7cae-4adf-b4c0-eebf057d4c5b@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <8ca0bdd9-7cae-4adf-b4c0-eebf057d4c5b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/7/2025 9:48 AM, Stefan Berger wrote:
>
>
> On 2/7/25 12:06 PM, Mimi Zohar wrote:
>> On Fri, 2025-02-07 at 10:16 -0500, Mimi Zohar wrote:
>>> On Mon, 2025-02-03 at 15:20 -0800, steven chen wrote:
>>>> The amount of memory allocated at kexec load, even with the extra 
>>>> memory
>>>> allocated, might not be large enough for the entire measurement 
>>>> list.  The
>>>> indeterminate interval between kexec 'load' and 'execute' could 
>>>> exacerbate
>>>> this problem.
>>>>
>>>> Define two new IMA events, 'kexec_load' and 'kexec_execute', to be
>>>> measured as critical data at kexec 'load' and 'execute' respectively.
>>>> Report the allocated kexec segment size, IMA binary log size and the
>>>> runtime measurements count as part of those events.
>>>>
>>>> These events, and the values reported through them, serve as 
>>>> markers in
>>>> the IMA log to verify the IMA events are captured during kexec soft
>>>> reboot.  The presence of a 'kexec_load' event in between the last two
>>>> 'boot_aggregate' events in the IMA log implies this is a kexec soft
>>>> reboot, and not a cold-boot. And the absence of 'kexec_execute' event
>>>> after kexec soft reboot implies missing events in that window which
>>>> results in inconsistency with TPM PCR quotes, necessitating a cold 
>>>> boot
>>>> for a successful remote attestation.
>>>
>>> As a reminder, please include directions for verifying the buffer 
>>> data hash against
>>> the buffer data.  The directions would be similar to those in commit 
>>> 6b4da8c0e7f
>>> ("IMA: Define a new template field buf").
>>>
>>>>
>>>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>>>> Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>>>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>>>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>>>> ---
>>>>   security/integrity/ima/ima_kexec.c | 23 +++++++++++++++++++++++
>>>>   1 file changed, 23 insertions(+)
>>>>
>>>> diff --git a/security/integrity/ima/ima_kexec.c
>>>> b/security/integrity/ima/ima_kexec.c
>>>> index c9c916f69ca7..0342ddfa9342 100644
>>>> --- a/security/integrity/ima/ima_kexec.c
>>>> +++ b/security/integrity/ima/ima_kexec.c
>>>> @@ -17,6 +17,8 @@
>>>>   #include "ima.h"
>>>>     #ifdef CONFIG_IMA_KEXEC
>>>> +#define IMA_KEXEC_EVENT_LEN 256
>>>> +
>>>>   static struct seq_file ima_kexec_file;
>>>>   static void *ima_kexec_buffer;
>>>>   static size_t kexec_segment_size;
>>>> @@ -36,6 +38,24 @@ static void ima_free_kexec_file_buf(struct 
>>>> seq_file *sf)
>>>>       ima_reset_kexec_file(sf);
>>>>   }
>>>>   +static void ima_measure_kexec_event(const char *event_name)
>>>> +{
>>>> +    char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
>>>> +    size_t buf_size = 0;
>>>> +    long len;
>>>> +
>>>> +    buf_size = ima_get_binary_runtime_size();
>>>> +    len = atomic_long_read(&ima_htable.len);
>>>> +
>>>> +    scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
>>>> + "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;"
>>>> +            "ima_runtime_measurements_count=%ld;",
>>>> +                kexec_segment_size, buf_size, len);
>>>
>>>  From scripts/checkpatch.pl, "Alignment should match open parenthesis".
>>>
>>>> +
>>>> +    ima_measure_critical_data("ima_kexec", event_name, 
>>>> ima_kexec_event,
>>>> +                    strlen(ima_kexec_event), false, NULL,
>>>> 0);
>>>
>>>  From the kernel-doc scnprintf(), returns the number of bytes.  
>>> There should be no
>>> need to calculate it using strlen().
>>>
>>>> +}
>>>> +
>>>>   static int ima_alloc_kexec_file_buf(size_t segment_size)
>>>>   {
>>>>       /*
>>>> @@ -60,6 +80,7 @@ static int ima_alloc_kexec_file_buf(size_t 
>>>> segment_size)
>>>>   out:
>>>>       ima_kexec_file.read_pos = 0;
>>>>       ima_kexec_file.count = sizeof(struct ima_kexec_hdr);    /* 
>>>> reserved
>>>> space
>>>> */
>>>> +    ima_measure_kexec_event("kexec_load");
>>>>         return 0;
>>>>   }
>>>> @@ -201,6 +222,8 @@ static int ima_update_kexec_buffer(struct 
>>>> notifier_block
>>>> *self,
>>>>           return ret;
>>>>       }
>>>>   +    ima_measure_kexec_event("kexec_execute");
>>>> +
>>>>       ret = ima_dump_measurement_list(&buf_size, &buf,
>>>>                       kexec_segment_size);
>>>
>>> After fixing up and applying this patch set to 6.14.0-rc1, I'm not 
>>> seeing the
>>> "kexec_execute".  Even after changing the default extra memory, I'm 
>>> still not
>>> seeing
>>> the measurement.
>>
>> FYI, after reverting commit 254ef9541d68 ("ima: Suspend PCR extends 
>> and log appends
>> when rebooting"), I'm seeing the "kexec_execute" measurement.
>
> I would try sth. like this:
> static int ima_reboot_notifier(struct notifier_block *nb,
>                    unsigned long action,
>                    void *data)
> {
>     if (action == SYS_RESTART && data && !strcmp(data, "kexec reboot"))
>         ima_measure_kexec_event("kexec_execute");
>>
>> Mimi
>>
>>
Thanks, will fix this in 6.14.0-rc1 in next version


