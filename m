Return-Path: <linux-integrity+bounces-5772-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EBBA84602
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 16:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECBCF4E6EB0
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 14:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A3228C5C6;
	Thu, 10 Apr 2025 14:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qoOOUASs"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9206528150E;
	Thu, 10 Apr 2025 14:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744294378; cv=none; b=POYsfwi04u46KzAxBO+vrrhNbCSu6CNtVvYXcp8+VksSs/rphcc61gjg+uOag9uVivZOyr+vxx2VhT2PXZqqwcoufVbnek5A8A8o7MLZpoLPAxyeHAVhJix4Y6kyCHrIab523omVOzCwxXuNjaWLMezcGxdLS5xiJfTzX/EZRHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744294378; c=relaxed/simple;
	bh=3/bgB5C2BHe4bEP/tG3DFZKcagEkLx6lMc7ChQklokE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q+EQE/iH8edbVyC1doZ7Kve/SKtbkN2LPbtMU0A/a7ghFcfFePw+i0i/n3zJ7TduGwjlXwgD9uugnD44ec+VbW3H+gMWWcna9cMgzrNsG/cVPuI4m8FGPPSAkxnycbxV/6SB2c+SEehd0ju0ckf5doIQrrgvOApmcj7Z/zP3N/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qoOOUASs; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.70.200.180] (unknown [172.200.70.13])
	by linux.microsoft.com (Postfix) with ESMTPSA id 276CB2114DA2;
	Thu, 10 Apr 2025 07:12:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 276CB2114DA2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744294376;
	bh=C9hmvXOD3mAOoIBtseago9OcifE2EsVmqtEJE9y1I6Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qoOOUASsp0EGHLa9GVXzDMANwEmYLl92l+NSSukqJScuIUzacXicVvHDwlhiYkOcd
	 5V6lTM92Fu0/s8enFv+HPdVbzF1t6hRBAXtRm4H7CyHvqG9reHZ8ANVjeBdClFxN1G
	 YYaREpYyh4cKLIYK4CIeu3IxdMjJE/BzpIcQjrCw=
Message-ID: <7b27f207-15a0-40f0-8238-b363bb887679@linux.microsoft.com>
Date: Thu, 10 Apr 2025 07:12:52 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 4/9] ima: kexec: skip IMA segment validation after
 kexec soft reboot
To: Baoquan He <bhe@redhat.com>
Cc: zohar@linux.ibm.com, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
 nramas@linux.microsoft.com, James.Bottomley@hansenpartnership.com,
 vgoyal@redhat.com, dyoung@redhat.com
References: <20250402124725.5601-1-chenste@linux.microsoft.com>
 <20250402124725.5601-5-chenste@linux.microsoft.com>
 <Z/SVY1j1C7P0rZGI@MiWiFi-R3L-srv>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <Z/SVY1j1C7P0rZGI@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/7/2025 8:17 PM, Baoquan He wrote:
> On 04/02/25 at 05:47am, steven chen wrote:
>> The kexec_calculate_store_digests() function calculates and stores the
>> digest of the segment during the kexec_file_load syscall, where the
>> IMA segment is also allocated.
>>
>> With this series, the IMA segment will be updated with the measurement
>> log at the kexec execute stage when a soft reboot is initiated.
>> Therefore, the digests should be updated for the IMA segment in the
>> normal case.
>>
>> The content of memory segments carried over to the new kernel during the
>> kexec systemcall can be changed at kexec 'execute' stage, but the size
>> and the location of the memory segments cannot be changed at kexec
>> 'execute' stage.
>>
>> However, during the kexec execute stage, if kexec_calculate_store_digests()
>> API is called to update the digest, it does not reuse the same memory
>> segment allocated during the kexec 'load' stage and the new memory segment
>> required cannot be transferred/mapped to the new kernel.
>>
>> As a result, digest verification will fail in verify_sha256_digest()
>> after a kexec soft reboot into the new kernel. Therefore, the digest
>> calculation/verification of the IMA segment needs to be skipped.
>>
>> To address this, skip the calculation and storage of the digest for the
>> IMA segment in kexec_calculate_store_digests() so that it is not added
>> to the purgatory_sha_regions.
>>
>> Since verify_sha256_digest() only verifies 'purgatory_sha_regions',
>> no change is needed in verify_sha256_digest() in this context.
>>
>> With this change, the IMA segment is not included in the digest
>> calculation, storage, and verification.
> I would write the patch log like:
>
> ======
> Currently, the function kexec_calculate_store_digests() calculates and
> stores the digest of the segment during the kexec_file_load syscall,
> where the  IMA segment is also allocated.
>
> Later, the IMA segment will be updated with the measurement log at the
> kexec execute stage when a kexec reboot is initiated. Therefore, the
> digests should be updated for the IMA segment in the  normal case. The
> problem is that the content of memory segments carried over to the new
> kernel during the kexec systemcall can be changed at kexec 'execute'
> stage, but the size and the location of the memory segments cannot be
> changed at kexec 'execute' stage.
>
> To address this, skip the calculation and storage of the digest for the
> IMA segment in kexec_calculate_store_digests() so that it is not added
> to the purgatory_sha_regions.
>
> With this change, the IMA segment is not included in the digest
> calculation, storage, and verification.
> ======

Hi Baoquan,

I will update it in next version.

Thanks for your comments.

Steven

>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Cc: Eric Biederman <ebiederm@xmission.com>
>> Cc: Baoquan He <bhe@redhat.com>
>> Cc: Vivek Goyal <vgoyal@redhat.com>
>> Cc: Dave Young <dyoung@redhat.com>
>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>> Acked-by: Baoquan He <bhe@redhat.com>
>> ---
>>   include/linux/kexec.h              |  3 +++
>>   kernel/kexec_file.c                | 22 ++++++++++++++++++++++
>>   security/integrity/ima/ima_kexec.c |  3 +++
>>   3 files changed, 28 insertions(+)
>>
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index 7d6b12f8b8d0..107e726f2ef3 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -362,6 +362,9 @@ struct kimage {
>>   
>>   	phys_addr_t ima_buffer_addr;
>>   	size_t ima_buffer_size;
>> +
>> +	unsigned long ima_segment_index;
>> +	bool is_ima_segment_index_set;
>>   #endif
>>   
>>   	/* Core ELF header buffer */
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index 3eedb8c226ad..606132253c79 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -38,6 +38,21 @@ void set_kexec_sig_enforced(void)
>>   }
>>   #endif
>>   
>> +#ifdef CONFIG_IMA_KEXEC
>> +static bool check_ima_segment_index(struct kimage *image, int i)
>> +{
>> +	if (image->is_ima_segment_index_set && i == image->ima_segment_index)
>> +		return true;
>> +	else
>> +		return false;
>> +}
>> +#else
>> +static bool check_ima_segment_index(struct kimage *image, int i)
>> +{
>> +	return false;
>> +}
>> +#endif
>> +
>>   static int kexec_calculate_store_digests(struct kimage *image);
>>   
>>   /* Maximum size in bytes for kernel/initrd files. */
>> @@ -764,6 +779,13 @@ static int kexec_calculate_store_digests(struct kimage *image)
>>   		if (ksegment->kbuf == pi->purgatory_buf)
>>   			continue;
>>   
>> +		/*
>> +		 * Skip the segment if ima_segment_index is set and matches
>> +		 * the current index
>> +		 */
>> +		if (check_ima_segment_index(image, i))
>> +			continue;
>> +
>>   		ret = crypto_shash_update(desc, ksegment->kbuf,
>>   					  ksegment->bufsz);
>>   		if (ret)
>> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
>> index b12ac3619b8f..7e0a19c3483f 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -145,6 +145,7 @@ void ima_add_kexec_buffer(struct kimage *image)
>>   	kbuf.buffer = kexec_buffer;
>>   	kbuf.bufsz = kexec_buffer_size;
>>   	kbuf.memsz = kexec_segment_size;
>> +	image->is_ima_segment_index_set = false;
>>   	ret = kexec_add_buffer(&kbuf);
>>   	if (ret) {
>>   		pr_err("Error passing over kexec measurement buffer.\n");
>> @@ -155,6 +156,8 @@ void ima_add_kexec_buffer(struct kimage *image)
>>   	image->ima_buffer_addr = kbuf.mem;
>>   	image->ima_buffer_size = kexec_segment_size;
>>   	image->ima_buffer = kexec_buffer;
>> +	image->ima_segment_index = image->nr_segments - 1;
>> +	image->is_ima_segment_index_set = true;
>>   
>>   	kexec_dprintk("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
>>   		      kbuf.mem);
>> -- 
>> 2.25.1
>>


