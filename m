Return-Path: <linux-integrity+bounces-4720-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C44CA27CCC
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Feb 2025 21:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95FEC166822
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Feb 2025 20:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0023A219A67;
	Tue,  4 Feb 2025 20:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="b3Cx44XE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4472520A5DA;
	Tue,  4 Feb 2025 20:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738700886; cv=none; b=era8CuNKvhapK+NXnEgsEMKE4zIsvj08iCzJiTaYklCGZWZn+i/Ubc7JG8e6H1Dpzps1Z2zpkgnLviZRmvIBIcNXISuzZLHrgzUR36e+vbwCkB5PiQzzVZLd06kR5coHo5Z4tlA9a18YqcN264NIZMzXIpOrzptZSK7cL4AzoRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738700886; c=relaxed/simple;
	bh=IoRJFhKv/dqAt17nC9B0LKW2UsEDq8Ti3lmnPQiWALY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GIVySLSON8YfBXDgvV8I6Shf9JuQDDhwoqqlGvwAKty9ATlm1kbizSzD/R8rDkU3ZyPPD5nNChU196KzJ142yL9rkUpnnHIXMJIWg4Byz94ZWUCHuk9ld4CkqWLfWwBTFhsuwxseiqYFDeWVfdJwRPyNkNtIjj7l8JYHnARCapQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=b3Cx44XE; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.17.64.67] (unknown [131.107.1.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id 754F92054926;
	Tue,  4 Feb 2025 12:28:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 754F92054926
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738700884;
	bh=1bt0mVnS0Ir83ngsAvEIbbvQSkHpMuK7XU2Id29OusI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=b3Cx44XESQ7Fszl7nZpg8NVa77+6TTN/umnmM13Eo4MLXInKqDEjmJ0fXIz4B7EB1
	 cp6HHrvsS3AW/32LDzhiqR9RpE3O9e2k9zk6lHZ0vwuQ6vM/IirIBgcsjO6RQH18D4
	 2qH6muvI6TW5Bci2oOnOUSPTnGkdO5JQb6VIi1s8=
Message-ID: <aeef2ca5-2538-4487-a501-7eb2925d198b@linux.microsoft.com>
Date: Tue, 4 Feb 2025 12:28:03 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/7] ima: kexec: skip IMA segment validation after
 kexec soft reboot
To: Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@HansenPartnership.com
References: <20250203232033.64123-1-chenste@linux.microsoft.com>
 <20250203232033.64123-4-chenste@linux.microsoft.com>
 <00eeeb8b-cc28-42af-873f-3478cd22fb6e@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <00eeeb8b-cc28-42af-873f-3478cd22fb6e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/4/2025 11:39 AM, Stefan Berger wrote:
> On 2/3/25 6:20 PM, steven chen wrote:
>> kexec_calculate_store_digests() calculates and stores the digest of the
>> segment at kexec_file_load syscall where the IMA segment is also
>> allocated.  With this series, the IMA segment will be updated with the
>> measurement log at kexec excute stage when soft reboot is initiated.
>
> s/excute/execute
>
>> Therefore, it may fail digest verification in verify_sha256_digest()
>> after kexec soft reboot into the new kernel. Therefore, the digest
>> calculation/verification of the IMA segment needs to be skipped.
>>
>> Skip IMA segment from calculating and storing digest in function
>
> Skip the calculation and storing of the digest of the IMA segment in 
> kexec_calculate_store_digests() so that ...
>
>
>> kexec_calculate_store_digests() so that it is not added to the
>> 'purgatory_sha_regions'.
>>
>> Since verify_sha256_digest() only verifies 'purgatory_sha_regions',
>> no change is needed in verify_sha256_digest() in this context.
>>
>> With this change, the IMA segment is not included in the digest
>> calculation, storage, and verification.
>>
>> Author: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> > --->   include/linux/kexec.h              |  3 +++
>>   kernel/kexec_file.c                | 23 +++++++++++++++++++++++
>>   security/integrity/ima/ima_kexec.c |  3 +++
>>   3 files changed, 29 insertions(+)
>>
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index f8413ea5c8c8..f3246e881ac8 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -362,6 +362,9 @@ struct kimage {
>>         phys_addr_t ima_buffer_addr;
>>       size_t ima_buffer_size;
>> +
>> +    unsigned long ima_segment_index;
>> +    bool is_ima_segment_index_set;
>>   #endif
>>         /* Core ELF header buffer */
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index 3eedb8c226ad..a3370a0dce20 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -38,6 +38,22 @@ void set_kexec_sig_enforced(void)
>>   }
>>   #endif
>>   +#ifdef CONFIG_IMA_KEXEC
>> +static bool check_ima_segment_index(struct kimage *image, int i)
>> +{
>> +    if (image->is_ima_segment_index_set &&
>> +            i == image->ima_segment_index)
>
> The 'i =' should be indented under 'image->'.
>
> With these nits fixed:
>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>
>> +        return true;
>> +    else
>> +        return false;
>> +}
>> +#else
>> +static bool check_ima_segment_index(struct kimage *image, int i)
>> +{
>> +    return false;
>> +}
>> +#endif
>> +
>>   static int kexec_calculate_store_digests(struct kimage *image);
>>     /* Maximum size in bytes for kernel/initrd files. */
>> @@ -764,6 +780,13 @@ static int kexec_calculate_store_digests(struct 
>> kimage *image)
>>           if (ksegment->kbuf == pi->purgatory_buf)
>>               continue;
>>   +        /*
>> +         * Skip the segment if ima_segment_index is set and matches
>> +         * the current index
>> +         */
>> +        if (check_ima_segment_index(image, i))
>> +            continue;
>> +
>>           ret = crypto_shash_update(desc, ksegment->kbuf,
>>                         ksegment->bufsz);
>>           if (ret)
>> diff --git a/security/integrity/ima/ima_kexec.c 
>> b/security/integrity/ima/ima_kexec.c
>> index b60a902460e2..283860d20521 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -162,6 +162,7 @@ void ima_add_kexec_buffer(struct kimage *image)
>>       kbuf.buffer = kexec_buffer;
>>       kbuf.bufsz = kexec_buffer_size;
>>       kbuf.memsz = kexec_segment_size;
>> +    image->is_ima_segment_index_set = false;
>>       ret = kexec_add_buffer(&kbuf);
>>       if (ret) {
>>           pr_err("Error passing over kexec measurement buffer.\n");
>> @@ -172,6 +173,8 @@ void ima_add_kexec_buffer(struct kimage *image)
>>       image->ima_buffer_addr = kbuf.mem;
>>       image->ima_buffer_size = kexec_segment_size;
>>       image->ima_buffer = kexec_buffer;
>> +    image->ima_segment_index = image->nr_segments - 1;
>> +    image->is_ima_segment_index_set = true;
>>         /*
>>        * kexec owns kexec_buffer after kexec_add_buffer() is called

Hi Stefan, I will update in next release. Thanks!


