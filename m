Return-Path: <linux-integrity+bounces-49-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B7C7EB991
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Nov 2023 23:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C97221C2074F
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Nov 2023 22:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AC826AC1;
	Tue, 14 Nov 2023 22:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LwA9DjbZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6AB26AC0
	for <linux-integrity@vger.kernel.org>; Tue, 14 Nov 2023 22:48:22 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 249AFD0
	for <linux-integrity@vger.kernel.org>; Tue, 14 Nov 2023 14:48:21 -0800 (PST)
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 82D4F20B74C2;
	Tue, 14 Nov 2023 14:48:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 82D4F20B74C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1700002100;
	bh=FkvFDL4hESySoL/7fU6eGKHYDbwpb0zJYt81Mi6Cve8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LwA9DjbZ2ei//rqT1aU2RL8eFHW1ZSwsvzfPCFOm9Bpll1PuHPECVLi6YOg9KHNXB
	 SvT4Tm5o7dmOpv66uuEisb6Ly1f9qYlByVcQC413jL484AonGvMemjYXgA6V1fKXnP
	 QXEt5gpSj9HCwssajwWIwdqb4ZWAhb+WKrULMYpo=
Message-ID: <5812e854-78db-4d68-a8a7-8dc033bded69@linux.microsoft.com>
Date: Tue, 14 Nov 2023 14:48:20 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/7] ima: record log size at kexec load and execute
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, ebiederm@xmission.com, noodles@fb.com,
 bauermann@kolabnow.com, kexec@lists.infradead.org,
 linux-integrity@vger.kernel.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20231005182602.634615-1-tusharsu@linux.microsoft.com>
 <20231005182602.634615-8-tusharsu@linux.microsoft.com>
 <2b95e8b9ebe10a24c7cb6fc90cb2d1342a157ed5.camel@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <2b95e8b9ebe10a24c7cb6fc90cb2d1342a157ed5.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/27/23 07:56, Mimi Zohar wrote:
> Hi Tushar,
> 
> On Thu, 2023-10-05 at 11:26 -0700, Tushar Sugandhi wrote:
>> The window between kexec 'load' and 'execute' could be arbitrarily long.
>> Even with the large chunk of memory allocated at kexec 'load', it may
>> run out which would result in missing events in IMA log after the system
>> soft reboots to the new Kernel.  This would result in IMA measurements
>> getting out of sync with the TPM PCR quotes which would result in remote
>> attestation failing for that system.  There is currently no way for the
>> new Kernel to know if the IMA log TPM PCR quote out of sync problem is
>> because of the missing measurements during kexec.
>>
>> Define two new IMA events, 'kexec_load' and 'kexec_execute', to be
>> measured at kexec 'load' and 'execute' respectively.
>>
>> IMA measures 'boot_aggregate' as the first event when the system boots -
>> either cold boot or kexec soft boot.  In case when the system goes
>> through multiple soft reboots, the number of 'boot_aggregate' events in
>> IMA log corresponds to total number of boots (cold boot plus multiple
>> kexec soft reboots).  With this change, there would be additional
>> 'kexec_load' and 'kexec_execute' events in between the two
>> 'boot_aggregate' events.  In rare cases, when the system runs out of
>> memory during kexec soft reboot, 'kexec_execute' won't be copied since
>> its one of the very last event measured just before kexec soft reboot.
>> The absence of the event 'kexec_execute' in between the two
>> boot_aggregate' events would signal the attestation service that the IMA
>> log on the system is out of sync with TPM PCR quotes and the system needs
>> to be cold booted for the remote attestation to succeed again.
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> 
> Adding a new type of critical data is fine.  The patch description
> should describe the reason for it.  Please update the Subject line and
> the patch description accordingly.
> 
Thanks.  I described the reasons in the code comment below, because I 
thought it is important enough to stay with the code to give context. 
But I can move it from the code comment to a patch description.
>> ---
>>   security/integrity/ima/ima_kexec.c | 35 +++++++++++++++++++++++++++++-
>>   1 file changed, 34 insertions(+), 1 deletion(-)
>>
>> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
>> index 6cd5f46a7208..0f9c424fe808 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -17,6 +17,8 @@
>>   #include "ima.h"
>>   
>>   #ifdef CONFIG_IMA_KEXEC
>> +#define IMA_KEXEC_EVENT_LEN 128
>> +
>>   struct seq_file ima_kexec_file;
>>   struct ima_kexec_hdr ima_khdr;
>>   static void *ima_kexec_buffer;
>> @@ -34,6 +36,8 @@ void ima_clear_kexec_file(void)
>>   
>>   static int ima_alloc_kexec_buf(size_t kexec_segment_size)
>>   {
>> +	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
>> +
>>   	if ((kexec_segment_size == 0) ||
>>   	    (kexec_segment_size == ULONG_MAX) ||
>>   	    ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages() / 2)) {
>> @@ -64,6 +68,12 @@ static int ima_alloc_kexec_buf(size_t kexec_segment_size)
>>   	memset(&ima_khdr, 0, sizeof(ima_khdr));
>>   	ima_khdr.version = 1;
>>   
>> +	scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
>> +		  "kexec_segment_size=%lu;", kexec_segment_size);
>> +
>> +	ima_measure_critical_data("ima_kexec", "kexec_load", ima_kexec_event,
>> +				  strlen(ima_kexec_event), false, NULL, 0);
>> +
>>   	return 0;
>>   }
>>   
>> @@ -198,6 +208,7 @@ void ima_add_kexec_buffer(struct kimage *image)
>>   static int ima_update_kexec_buffer(struct notifier_block *self,
>>   				   unsigned long action, void *data)
>>   {
>> +	char ima_kexec_event[IMA_KEXEC_EVENT_LEN];
>>   	void *buf = NULL;
>>   	size_t buf_size;
>>   	bool resume = false;
>> @@ -213,9 +224,31 @@ static int ima_update_kexec_buffer(struct notifier_block *self,
>>   		return NOTIFY_OK;
>>   	}
>>   
>> +	buf_size = ima_get_binary_runtime_size();
>> +	scnprintf(ima_kexec_event, IMA_KEXEC_EVENT_LEN,
>> +		  "kexec_segment_size=%lu;ima_binary_runtime_size=%lu;",
>> +		  kexec_segment_size, buf_size);
>> +
>> +	/*
>> +	 * This is one of the very last events measured by IMA before kexec
>> +	 * soft rebooting into the new Kernal.
>> +	 * This event can be used as a marker after the system soft reboots
>> +	 * to the new Kernel to check if there was sufficient memory allocated
>> +	 * at kexec 'load' to capture the events measured between the window
>> +	 * of kexec 'load' and 'execute'.
>> +	 * This event needs to be present in the IMA log, in between the two
>> +	 * 'boot_aggregate' events that are logged for the previous boot and
>> +	 * the current soft reboot. If it is not present after the system soft
>> +	 * reboots into the new Kernel, it would mean the IMA log is not
>> +	 * consistent with the TPM PCR quotes, and the system needs to be
>> +	 * cold-booted for the attestation to succeed again.
>> +	 */
> 
> Comments like this don't belong in the code.  Please refer to section
> "8) Commenting" of Documentation/process/coding-style.rst.
Will do.

~Tushar
> 
>> +	ima_measure_critical_data("ima_kexec", "kexec_execute",
>> +				  ima_kexec_event, strlen(ima_kexec_event),
>> +				  false, NULL, 0);
>> +
>>   	ima_measurements_suspend();
>>   
>> -	buf_size = ima_get_binary_runtime_size();
>>   	ret = ima_dump_measurement_list(&buf_size, &buf,
>>   					kexec_segment_size);
>>   

