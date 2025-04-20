Return-Path: <linux-integrity+bounces-5949-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47778A947F6
	for <lists+linux-integrity@lfdr.de>; Sun, 20 Apr 2025 15:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59CA717184E
	for <lists+linux-integrity@lfdr.de>; Sun, 20 Apr 2025 13:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019281E9B03;
	Sun, 20 Apr 2025 13:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pHx/vc/N"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C3C1E9905;
	Sun, 20 Apr 2025 13:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745154629; cv=none; b=SC1R/ROERJ4lhXLAw3ezc95bnIOHoCMG5W6SdKQdHQHvkAhYO8loxWAtaLrQ97SD7wVK2W1BsvZiSE3w5tygmtvE27/rANqqu7wIeRV8Q7tk/aLONWKLmOhv3D6mRYuP8+vg/JWfvzAiHVaTJIF2lfoyYr5xt0XuklKUoqLwan0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745154629; c=relaxed/simple;
	bh=zNNlBENvsCMoov/hDU2BXQexFpYKj/CEPuIGt83kohw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qpx3e5de93TkDWRPXhZFALrrTpqGuQM1VGSQqkh88ZohIRpL/0QJVHk0wJyhNRreEA5YOigOf0THtjpqQKX4MokaMY/wH1tKsA/0/7jzmjDff3cRMoBAioe5LmrRqN7n7th23h4TlV52mWSwyjtchozOO2x7fi5aAssexRmw5B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pHx/vc/N; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.70.200.26] (unknown [172.200.70.35])
	by linux.microsoft.com (Postfix) with ESMTPSA id DACD921165A5;
	Sun, 20 Apr 2025 06:10:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DACD921165A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745154627;
	bh=v8/kjfMBX5j8otcEjoEy9F00J/rSQ+ksJRgSx0LzXFY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pHx/vc/NZF4cnSWNIalzxFIb81vkZ06zt+dIWhi+JXx6jLz53S9tgyJir/YVKLwwf
	 iWeQDP1iuyZ+YGDvQFdV14T7ikZPiervu0iRYlmO7wFtxh5C5uZFCkgC/WUix0HTjn
	 EfXaB0QH27xlDR2BK3JPVWLxifSMYg3/yoqgs+A0=
Message-ID: <193deea5-c1b4-4189-a5a0-a3e29841225a@linux.microsoft.com>
Date: Sun, 20 Apr 2025 06:10:23 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 9/9] ima: measure kexec load and exec events as
 critical data
To: Baoquan He <bhe@redhat.com>
Cc: zohar@linux.ibm.com, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
 nramas@linux.microsoft.com, James.Bottomley@hansenpartnership.com,
 vgoyal@redhat.com, dyoung@redhat.com
References: <20250416021028.1403-1-chenste@linux.microsoft.com>
 <20250416021028.1403-10-chenste@linux.microsoft.com>
 <aAIWcwzuht+GCn29@MiWiFi-R3L-srv>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <aAIWcwzuht+GCn29@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/18/2025 2:08 AM, Baoquan He wrote:
> On 04/15/25 at 07:10pm, steven chen wrote:
>> From: Steven Chen <chenste@linux.microsoft.com>
>>
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
>> | grep  kexec_load | cut -d' ' -f 6 | xxd -r -p | sha256sum
>>
>>
>> To verify the 'kexec_execute' data hash:
>>
>> sudo cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements
>> | grep kexec_execute | cut -d' ' -f 6 | xxd -r -p | sha256sum
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>    ^^^^^
>> Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
>    ^^^^^
Hi Baoquan,

I will add Co-developed-by tag in next version.

Thanks,

Steven
>> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>> ---
>>   security/integrity/ima/ima.h       |  6 ++++++
>>   security/integrity/ima/ima_kexec.c | 21 +++++++++++++++++++++
>>   security/integrity/ima/ima_queue.c |  5 +++++
>>   3 files changed, 32 insertions(+)
> Acked-by: Baoquan He <bhe@redhat.com>
>
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
>> index d1c9d369ba08..38cb2500f4c3 100644
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
>> @@ -31,6 +33,24 @@ static void ima_free_kexec_file_buf(struct seq_file *sf)
>>   	sf->count = 0;
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
>> @@ -53,6 +73,7 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
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
>> +
>>   	ima_measurements_suspend();
>>   
>>   	return NOTIFY_DONE;
>> -- 
>> 2.43.0
>>


