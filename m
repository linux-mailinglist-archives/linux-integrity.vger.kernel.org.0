Return-Path: <linux-integrity+bounces-4973-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB20A401CF
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2025 22:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36CDF167F75
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2025 21:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A1C253B73;
	Fri, 21 Feb 2025 21:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VIxqpjej"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8352505BD;
	Fri, 21 Feb 2025 21:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740172207; cv=none; b=P/rPUe3swjX40r6M1AuZ8A/eNotZAh55k2JQ2eJV5at5FwtaNnlSAGkzwYCZR8A6CpAi538y48Uvygb1FY8XpAlTYTbnOgAi7AiyyglMZ8R7cS2bO3oZv25AmzC3xQPxl2aVCZw0Sz8y8IUL6Mx5wBKiv9ngKsLiKQPykAbQE/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740172207; c=relaxed/simple;
	bh=WTpcEnrAfQeUkKdrqVzvIfHmXroYmr4UzluSMK6NQ2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ImsTbJ/NWvE/V574LXkHKNMlOThFfvtsAeyre9BJR3Whjd5j6okODONeLmDjXVEMIIaWSoVjNT7V1ZIUEeIZGZLDY/5dE3FykPQtZu87A0mB1r9SIA1HLLCHKyV4tvNiT/LfPU+NzsjJ8Juq1Z5GzCgUr60PuqAhT2ebqMHmzLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VIxqpjej; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.17.64.59] (unknown [131.107.8.59])
	by linux.microsoft.com (Postfix) with ESMTPSA id A64022053679;
	Fri, 21 Feb 2025 13:10:05 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A64022053679
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740172206;
	bh=0lziOMlEQrQGXDNHLwwuurA3vZdazKZBrZ/C9W/SZGI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VIxqpjej/OSCHR0ZVlCRJfVuJEX+zyZGmdXuTGtc1kP3oPNhC1FEG99PJyxGUstA5
	 oN8r/pRyJtT2u2tnzk7FsP3EuVI3zupdoA1Fy2QZ1/YX5lmPBmcQTOftCRMvSqO8VW
	 NYJ5nOEogIpGUB8LdfY8OMe6IcTCP+p3b+HnvW1s=
Message-ID: <7903ffe0-75f9-49f8-b638-9a4964897676@linux.microsoft.com>
Date: Fri, 21 Feb 2025 13:10:04 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 7/7] ima: measure kexec load and exec events as
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
References: <20250218225502.747963-1-chenste@linux.microsoft.com>
 <20250218225502.747963-8-chenste@linux.microsoft.com>
 <436c898a39a9bdaa2ab24fc111b50d3c885aa028.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <436c898a39a9bdaa2ab24fc111b50d3c885aa028.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/20/2025 4:46 PM, Mimi Zohar wrote:
> On Tue, 2025-02-18 at 14:55 -0800, steven chen wrote:
>> The amount of memory allocated at kexec load, even with the extra memory
>> allocated, might not be large enough for the entire measurement list.  The
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
>> reboot.  The presence of a 'kexec_load' event in between the last two
>> 'boot_aggregate' events in the IMA log implies this is a kexec soft
>> reboot, and not a cold-boot. And the absence of 'kexec_execute' event
>> after kexec soft reboot implies missing events in that window which
>> results in inconsistency with TPM PCR quotes, necessitating a cold boot
>> for a successful remote attestation.
>>
>> The 'kexec_load' event IMA log can be found using the following command:
>> sudo cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements |
>>     grep kexec_load
>>
>> The 'kexec_load' event IMA log can be found using the following command:
> -> kexec_execute
>
>> sudo cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements |
>>     grep kexec_execute
> These critical data events are displayed as hex encoded ascii in the
> ascii_runtime_measurement_list.  Verifying the critical data hash requires calculating the
> hash of the decoded ascii string.  For example:
>
> sudo cat /sys/kernel/security/integrity/ima/ascii_runtime_measurements | grep  kexec_load
> | cut -d' ' -f 6 | xxd -r -p | sha256sum
>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>> ---
>>   security/integrity/ima/ima.h       |  6 ++++++
>>   security/integrity/ima/ima_kexec.c | 21 +++++++++++++++++++++
>>   security/integrity/ima/ima_queue.c |  5 +++++
>>   3 files changed, 32 insertions(+)
>>
>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>> index 4428fcf42167..1452c98242a4 100644
>> --- a/security/integrity/ima/ima.h
>> +++ b/security/integrity/ima/ima.h
>> @@ -240,6 +240,12 @@ void ima_post_key_create_or_update(struct key *keyring, struct key
>> *key,
>>   				   unsigned long flags, bool create);
>>   #endif
>>   
>> +#ifdef CONFIG_IMA_KEXEC
>> +void ima_measure_kexec_event(const char *event_name);
>> +#else
>> +static inline void ima_measure_kexec_event(const char *event_name) {}
>> +#endif
>> +
>>   /*
>>    * The default binary_runtime_measurements list format is defined as the
>>    * platform native format.  The canonical format is defined as little-endian.
>> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
>> index 6c8c203ad81e..8d0782e51ffa 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -17,6 +17,8 @@
>>   #include "ima.h"
>>   
>>   #ifdef CONFIG_IMA_KEXEC
>> +#define IMA_KEXEC_EVENT_LEN 256
>> +
>>   static struct seq_file ima_kexec_file;
>>   static void *ima_kexec_buffer;
>>   static size_t kexec_segment_size;
>> @@ -36,6 +38,24 @@ static void ima_free_kexec_file_buf(struct seq_file *sf)
>>   	ima_reset_kexec_file(sf);
>>   }
>>   
>> +void ima_measure_kexec_event(const char *event_name)
>> +{
>> +	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
>> +	size_t buf_size = 0;
>> +	long len;
>> +
>> +	buf_size = ima_get_binary_runtime_size();
>> +	len = atomic_long_read(&ima_htable.len);
>> +
>> +	scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
>> +		  "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;"
>> +		 "ima_runtime_measurements_count=%ld;",
>> +		 kexec_segment_size, buf_size, len);
>> +
>> +	ima_measure_critical_data("ima_kexec", event_name, ima_kexec_event,
>> +				  strlen(ima_kexec_event), false, NULL, 0);
> As previously mentioned, scnprintf() returns the length.  No need to use strlen() here.
>
> Mimi
>
>> +}
>> +
>>   static int ima_alloc_kexec_file_buf(size_t segment_size)
>>   {
>>   	/*
>> @@ -58,6 +78,7 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
>>   out:
>>   	ima_kexec_file.read_pos = 0;
>>   	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved space */
>> +	ima_measure_kexec_event("kexec_load");
>>   
>>   	return 0;
>>   }
>> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
>> index 3dfd178d4292..6afb46989cf6 100644
>> --- a/security/integrity/ima/ima_queue.c
>> +++ b/security/integrity/ima/ima_queue.c
>> @@ -241,6 +241,11 @@ static int ima_reboot_notifier(struct notifier_block *nb,
>>   			       unsigned long action,
>>   			       void *data)
>>   {
>> +#ifdef CONFIG_IMA_KEXEC
>> +	if (action == SYS_RESTART && data && !strcmp(data, "kexec reboot"))
>> +		ima_measure_kexec_event("kexec_execute");
>> +#endif
>> +
>>   	ima_measurements_suspend();
>>   
>>   	return NOTIFY_DONE;

Thanks, I will update in next version


