Return-Path: <linux-integrity+bounces-5365-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2DCA6C08B
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Mar 2025 17:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E8181671E3
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Mar 2025 16:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2269922B59D;
	Fri, 21 Mar 2025 16:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IvJA4DLM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931A01E7C0B;
	Fri, 21 Mar 2025 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742575743; cv=none; b=CM3FsRaNfrKxCtN+X/89PNCBUzDAyUxOAli7MkYmiC07ugWJTwQc2E1I8nirpLvEfNqaclEBLYCzUT1D3gfiN1tol0b3NhiORqim0cSSQglK1C1CpHSOQ3YIudiAKma+MxS5G7C7f0Y1IlG7wf56ss1ezx7fRw8Rd37x6ywPQlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742575743; c=relaxed/simple;
	bh=Jbefc2fy+6DSTbygMu6+1efbepZO0Okur+3ITUsewdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nje6VTXI9aS11U99Bc3my0NuXvCDV3jhuoExZA1shH8MyIPngkmlO4mPWBR80wTeQ73m5XOK5HXfD8xAUHCcGk3m5BhbPFbExq8WuwPjCBUvFFR3XlwJiHeKf0EfCR84rcHk8v5zRGYG6JdqlBamtw8i5zRYV9jxCXsJtU36m7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IvJA4DLM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.17.64.97] (unknown [131.107.174.225])
	by linux.microsoft.com (Postfix) with ESMTPSA id 08ABD202538B;
	Fri, 21 Mar 2025 09:49:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 08ABD202538B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742575741;
	bh=EDq6dkjdVz/tPxpcBKVvaAVpNAoxeUkWXPEwHqJnTOc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IvJA4DLMQDjLEBNN5Nhuv+QYitK6B8t83wGQvVjWhT1X6P/Fvlq+E2Xk2q5aoW9Dm
	 TmbtrjGdXmLx6HnR5qwD4vrrWd1J/eHWsSFZcW+NLcHbK97JhYZMrLGH/hDO8Ti3wc
	 tjmCqBSfFKm/+fce2lTr7QQ8v5yOsmJcpZdqo8fE=
Message-ID: <11de6e57-f307-4382-877e-566b5a4e855e@linux.microsoft.com>
Date: Fri, 21 Mar 2025 09:49:01 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 8/8] ima: measure kexec load and exec events as
 critical data
To: Mimi Zohar <zohar@linux.ibm.com>, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@HansenPartnership.com, bhe@redhat.com, vgoyal@redhat.com,
 dyoung@redhat.com
References: <20250318010448.954-1-chenste@linux.microsoft.com>
 <20250318010448.954-9-chenste@linux.microsoft.com>
 <b61fda41ec01e1fea80a8c09f2259df6821d620e.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <b61fda41ec01e1fea80a8c09f2259df6821d620e.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/19/2025 7:59 PM, Mimi Zohar wrote:
> On Mon, 2025-03-17 at 18:04 -0700, steven chen wrote:
>> The amount of memory allocated at kexec load, even with the extra memory
>> allocated, might not be large enough for the entire measurement list.  The
>> indeterminate interval between kexec 'load' and 'execute' could exacerbate
>> this problem.
>>
>> Define two new IMA events, 'kexec_load' and 'kexec_execute', to be
>> measured as critical data at kexec 'load' and 'execute' respectively.
>> Report the allocated kexec segment size, IMA binary log size and the
>> runtime measurements count as part of those events.
>>
>> These events, and the values reported through them, serve as markers in
>> the IMA log to verify the IMA events are captured during kexec soft
>> reboot.  The presence of a 'kexec_load' event in between the last two
>> 'boot_aggregate' events in the IMA log implies this is a kexec soft
>> reboot, and not a cold-boot. And the absence of 'kexec_execute' event
>> after kexec soft reboot implies missing events in that window which
>> results in inconsistency with TPM PCR quotes, necessitating a cold boot
>> for a successful remote attestation.
>>
>> These critical data events are displayed as hex encoded ascii in the
>> ascii_runtime_measurement_list.  Verifying the critical data hash requires
>> calculating the hash of the decoded ascii string.
>>
>> For example, to verify the 'kexec_load' data hash:
>>
>> sudo cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements
>>> grep  kexec_load | cut -d' ' -f 6 | xxd -r -p | sha256sum
>>
>> To verify the 'kexec_execute' data hash:
>>
>> sudo cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements
>>> grep kexec_execute | cut -d' ' -f 6 | xxd -r -p | sha256sum
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   security/integrity/ima/ima.h       |  6 ++++++
>>   security/integrity/ima/ima_kexec.c | 21 +++++++++++++++++++++
>>   security/integrity/ima/ima_queue.c |  5 +++++
>>   3 files changed, 32 insertions(+)
>>
>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>> index 24d09ea91b87..34815baf5e21 100644
>> --- a/security/integrity/ima/ima.h
>> +++ b/security/integrity/ima/ima.h
>> @@ -240,6 +240,12 @@ void ima_post_key_create_or_update(struct key *keyring, struct key *key,
>>   				   unsigned long flags, bool create);
>>   #endif
>>   
>> +#ifdef CONFIG_IMA_KEXEC
>> +void ima_measure_kexec_event(const char *event_name);
>> +#else
>> +static inline void ima_measure_kexec_event(const char *event_name) {}
>> +#endif
>> +
>>   /*
>>    * The default binary_runtime_measurements list format is defined as the
>>    * platform native format.  The canonical format is defined as little-endian.
>> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
>> index 0f214e41dd33..43223eb99046 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -17,6 +17,8 @@
>>   #include "ima.h"
>>   
>>   #ifdef CONFIG_IMA_KEXEC
>> +#define IMA_KEXEC_EVENT_LEN 256
>> +
>>   static bool ima_kexec_update_registered;
>>   static struct seq_file ima_kexec_file;
>>   static size_t kexec_segment_size;
>> @@ -36,6 +38,24 @@ static void ima_free_kexec_file_buf(struct seq_file *sf)
>>   	ima_reset_kexec_file(sf);
>>   }
>>   
>> +void ima_measure_kexec_event(const char *event_name)
>> +{
>> +	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
>> +	size_t buf_size = 0;
>> +	long len;
>> +	int n;
>> +
>> +	buf_size = ima_get_binary_runtime_size();
>> +	len = atomic_long_read(&ima_htable.len);
>> +
>> +	n = scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
>> +		      "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;"
>> +		      "ima_runtime_measurements_count=%ld;",
>> +		      kexec_segment_size, buf_size, len);
>> +
>> +	ima_measure_critical_data("ima_kexec", event_name, ima_kexec_event, n, false, NULL, 0);
>> +}
>> +
>>   static int ima_alloc_kexec_file_buf(size_t segment_size)
>>   {
>>   	/*
>> @@ -58,6 +78,7 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
>>   out:
>>   	ima_kexec_file.read_pos = 0;
>>   	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved space */
>> +	ima_measure_kexec_event("kexec_load");
>>   
>>   	return 0;
>>   }
>> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
>> index 83d53824aa98..590637e81ad1 100644
>> --- a/security/integrity/ima/ima_queue.c
>> +++ b/security/integrity/ima/ima_queue.c
>> @@ -241,6 +241,11 @@ static int ima_reboot_notifier(struct notifier_block *nb,
>>   			       unsigned long action,
>>   			       void *data)
>>   {
>> +#ifdef CONFIG_IMA_KEXEC
>> +	if (action == SYS_RESTART && data && !strcmp(data, "kexec reboot"))
>> +		ima_measure_kexec_event("kexec_execute");
>> +#endif
> After a kexec execute, the measurement list does not verify properly and the
> "kexec_execute" critical data does not appear in the measurement list.  This
> makes me think the critical data IS being extended into the TPM, but the
> measurement list is being copied before the "kexec_execute" critical data is
> called.
>
> This actually makes sense since the reboot notifier ima_update_kexec_buffer()
> priority is higher than ima_reboot_notifier().
>
> INT_MIN: runs the callback late
> INT_MAX: runs the callback early
>
> Either reverse the callback priorities or revert moving the "kexec_execute"
> critical data to ima_reboot_notifier().
>
> thanks,
>
> Mimi

Hi Mimi,

I will reverse the callback priority.

Thanks,

Steven

>> +
>>   	ima_measurements_suspend();
>>   
>>   	return NOTIFY_DONE;



