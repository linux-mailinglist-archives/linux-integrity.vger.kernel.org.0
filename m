Return-Path: <linux-integrity+bounces-863-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 949B0839A93
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jan 2024 21:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E0471F2A3AA
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jan 2024 20:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A165B443E;
	Tue, 23 Jan 2024 20:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="risDRtgS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8FC5392
	for <linux-integrity@vger.kernel.org>; Tue, 23 Jan 2024 20:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706043315; cv=none; b=IynF/pj/ln+fzQqsBbggeIiWJ9cCKV7Fndz8wfmQH2MkoCg2N/8J2HngCY4aiQRNZfP+aupS7j50AiJMmebEHqIzB2cA12tAAp3Lk9246NAg95sqmOissAfCbpAzWRxFg+JgDYYkqh4r7lqsN87jql5V3D+6eZwGDHEZU74XXm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706043315; c=relaxed/simple;
	bh=WB+YaraefYOD622p39VAyvM0Y3s6A+AaJ12jvwvZGgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c+0GGmaldWN03s6VgBvgQ8ToURmxySPBltKHgGIFzi3NbF5k08Xvzu02zsLcA34GHOmXhhkFqNx3ASelfF1IYGwIOUivpUmyQliU6LSPcSxWmds1Qa+PoNUPgvuZEX6vxMLpSnSV7ogXCkKcEYzILcRmnUVqe5+7rB7m7uhrFp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=risDRtgS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7728F20E34C3;
	Tue, 23 Jan 2024 12:55:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7728F20E34C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706043311;
	bh=fp/mOR6UlKwzcVLrxmAzd8xaNmbMcW4EzHgfg6PZazk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=risDRtgSLWE5mAGAWl7sLKBFqrFWvCzja2OETSS0czBtR2pPYZdQn7sUwEpT1v+rN
	 7sCWej0R1ftf0KHxE9giCXcF6jzb5SMrrF9Ry38qfANWpz9BZaJmVOrkovUNf+yqgm
	 ZVSflWzJVacnVM+DEkuP3fJ/9OJYXY3wdR/0IEr4=
Message-ID: <50f4e0ad-54ca-4727-abdc-5f3406ddb971@linux.microsoft.com>
Date: Tue, 23 Jan 2024 12:55:10 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] ima: suspend measurements during buffer copy at
 kexec execute
Content-Language: en-US
To: Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, noodles@fb.com,
 bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org
Cc: code@tyhicks.com, nramas@linux.microsoft.com, paul@paul-moore.com
References: <20240122183804.3293904-1-tusharsu@linux.microsoft.com>
 <20240122183804.3293904-6-tusharsu@linux.microsoft.com>
 <45afcefe-2e12-4e38-906b-cc7c1bc32dcc@linux.ibm.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <45afcefe-2e12-4e38-906b-cc7c1bc32dcc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/23/24 10:18, Stefan Berger wrote:
> 
> 
> On 1/22/24 13:38, Tushar Sugandhi wrote:
>> New measurements added to the IMA log while the log is being copied
>> during the kexec 'execute' may not get copied over.  This can cause the
>> measurement log to be out of sync with the IMA TPM PCR, which could
> 
> It could be out of sync with any PCR that IMA extends, most often only 
> the IMA TPM PCR.
> 
Agreed.  That's what I meant. But I can see my above wording could be 
misleading.
I will reword it to "This can cause the measurement log to be out of 
sync with the TPM PCRs that IMA extends, which could result in..."

>> result in breaking the integrity of the measurements after kexec soft
>> reboot.
>>
>> Implement and call the functions ima_measurements_suspend() and
>> ima_measurements_resume() from ima_update_kexec_buffer().
>>
>> Add a check in the ima_add_template_entry() function not to measure
>> events when 'suspend_ima_measurements' flag is set.
>>
>> This ensures the integrity of the IMA log while it is being copied over
>> to the new Kernel during kexec 'execute'.
>>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> 
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> 
Thanks for the tag. I will add it to this patch in the next iteration of 
the series.
Please let me know if you want it to be added to any other patches.

~Tushar
>> ---
>>   security/integrity/ima/ima.h       |  2 ++
>>   security/integrity/ima/ima_kexec.c |  7 +++++++
>>   security/integrity/ima/ima_queue.c | 32 ++++++++++++++++++++++++++++++
>>   3 files changed, 41 insertions(+)
>>
>> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
>> index c29db699c996..49a6047dd8eb 100644
>> --- a/security/integrity/ima/ima.h
>> +++ b/security/integrity/ima/ima.h
>> @@ -161,6 +161,8 @@ bool ima_template_has_modsig(const struct 
>> ima_template_desc *ima_template);
>>   int ima_restore_measurement_entry(struct ima_template_entry *entry);
>>   int ima_restore_measurement_list(loff_t bufsize, void *buf);
>>   int ima_measurements_show(struct seq_file *m, void *v);
>> +void ima_measurements_suspend(void);
>> +void ima_measurements_resume(void);
>>   unsigned long ima_get_binary_runtime_size(void);
>>   int ima_init_template(void);
>>   void ima_init_template_list(void);
>> diff --git a/security/integrity/ima/ima_kexec.c 
>> b/security/integrity/ima/ima_kexec.c
>> index 25150bfc7129..f26b5b342d84 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -179,6 +179,7 @@ static int ima_update_kexec_buffer(struct 
>> notifier_block *self,
>>       void *buf = NULL;
>>       size_t buf_size;
>>       int ret = NOTIFY_OK;
>> +    bool resume = false;
>>       if (!kexec_in_progress) {
>>           pr_info("%s: No kexec in progress.\n", __func__);
>> @@ -190,12 +191,15 @@ static int ima_update_kexec_buffer(struct 
>> notifier_block *self,
>>           return ret;
>>       }
>> +    ima_measurements_suspend();
>> +
>>       ret = ima_dump_measurement_list(&buf_size, &buf,
>>                       kexec_segment_size);
>>       if (!buf) {
>>           pr_err("%s: Dump measurements failed. Error:%d\n",
>>                  __func__, ret);
>> +        resume = true;
>>           goto out;
>>       }
>>       memcpy(ima_kexec_buffer, buf, buf_size);
>> @@ -203,6 +207,9 @@ static int ima_update_kexec_buffer(struct 
>> notifier_block *self,
>>       kimage_unmap_segment(ima_kexec_buffer);
>>       ima_kexec_buffer = NULL;
>> +    if (resume)
>> +        ima_measurements_resume();
>> +
>>       return ret;
>>   }
>> diff --git a/security/integrity/ima/ima_queue.c 
>> b/security/integrity/ima/ima_queue.c
>> index 532da87ce519..5946a26a2849 100644
>> --- a/security/integrity/ima/ima_queue.c
>> +++ b/security/integrity/ima/ima_queue.c
>> @@ -44,6 +44,11 @@ struct ima_h_table ima_htable = {
>>    */
>>   static DEFINE_MUTEX(ima_extend_list_mutex);
>> +/*
>> + * Used internally by the kernel to suspend-resume ima measurements.
>> + */
>> +static atomic_t suspend_ima_measurements;
>> +
>>   /* lookup up the digest value in the hash table, and return the 
>> entry */
>>   static struct ima_queue_entry *ima_lookup_digest_entry(u8 
>> *digest_value,
>>                                  int pcr)
>> @@ -148,6 +153,20 @@ static int ima_pcr_extend(struct tpm_digest 
>> *digests_arg, int pcr)
>>       return result;
>>   }
>> +void ima_measurements_suspend(void)
>> +{
>> +    mutex_lock(&ima_extend_list_mutex);
>> +    atomic_set(&suspend_ima_measurements, 1);
>> +    mutex_unlock(&ima_extend_list_mutex);
>> +}
>> +
>> +void ima_measurements_resume(void)
>> +{
>> +    mutex_lock(&ima_extend_list_mutex);
>> +    atomic_set(&suspend_ima_measurements, 0);
>> +    mutex_unlock(&ima_extend_list_mutex);
>> +}
>> +
>>   /*
>>    * Add template entry to the measurement list and hash table, and
>>    * extend the pcr.
>> @@ -176,6 +195,19 @@ int ima_add_template_entry(struct 
>> ima_template_entry *entry, int violation,
>>           }
>>       }
>> +    /*
>> +     * suspend_ima_measurements will be set if the system is
>> +     * undergoing kexec soft boot to a new kernel.
>> +     * suspending measurements in this short window ensures the
>> +     * consistency of the IMA measurement list during copying
>> +     * of the kexec buffer.
>> +     */
>> +    if (atomic_read(&suspend_ima_measurements)) {
>> +        audit_cause = "measurements_suspended";
>> +        audit_info = 0;
>> +        goto out;
>> +    }
>> +
>>       result = ima_add_digest_entry(entry,
>>                         !IS_ENABLED(CONFIG_IMA_DISABLE_HTABLE));
>>       if (result < 0) {

