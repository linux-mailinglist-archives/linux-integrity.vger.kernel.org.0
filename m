Return-Path: <linux-integrity+bounces-4754-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E5DA2CC81
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Feb 2025 20:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65A6718872B8
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Feb 2025 19:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF8E1A3141;
	Fri,  7 Feb 2025 19:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oDjtXD08"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E98318DB0E;
	Fri,  7 Feb 2025 19:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738956289; cv=none; b=Owb3+yoNK85Q6TnOx2bljlv3NBJ/P5HdUtU6NUtsX1cCNPQL2Dg0/2tu/LRAwBaWQDcnVmw4ny5jQYvc7/9CgIYRSIKs83mVYKb9muVpUbz7q7Pm6I8FjKZyk1XcDud3ShPiJIK7Im79P6hdNcSPK34kVtwb907p1lqL146M1DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738956289; c=relaxed/simple;
	bh=e01kz4cB1I17ePVMISIl77htfT3iTia1eMGA07YuSV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ys5BW3Lxhk3AUJtUqDv7BLy+Jc2bj3IWpvn+fB6ZuWazecVQs2+12APySDtEPNy1nkdIv9j1i0JSMcCuUdOnJa7Cdo+3coVcbrBuW2EmqPtOMsUnpryqt9cJrNjJRaNjeo36STpuZ4hGM3FR3o/v+bFbTDJbY1n0XdYli4vq8wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oDjtXD08; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.17.64.61] (unknown [131.107.8.61])
	by linux.microsoft.com (Postfix) with ESMTPSA id 764502107307;
	Fri,  7 Feb 2025 11:24:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 764502107307
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738956287;
	bh=zt9HgV3CYEF4IgU9rUZoB8RGyFAs8v6Kh6vMoUBGx0A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oDjtXD08Lqb8ELFrQ7DgfZeT1+6Pmg2K01dpPAHVQTg9B3ponljVlqzBwlf8Wf4SN
	 dcmXUAQLF+ePAWCawIJ0evruE3iRvUJNza1rjhQ4HtK5Y9vIxZKQwi91zNQLoit4G7
	 5GLarvKTqn2ENCC7wHTCYNMZC9YE7xv6rw8uqVL8=
Message-ID: <b9a4089e-d97a-4977-a73a-bb0ccd02672e@linux.microsoft.com>
Date: Fri, 7 Feb 2025 11:24:47 -0800
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

Thanks, Stefan, I will update it in next version


