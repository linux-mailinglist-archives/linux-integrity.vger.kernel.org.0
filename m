Return-Path: <linux-integrity+bounces-4671-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 021D4A2237B
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Jan 2025 18:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DACF37A1EDA
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Jan 2025 17:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299861E0DD0;
	Wed, 29 Jan 2025 17:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZrgeFQrq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47AE190661;
	Wed, 29 Jan 2025 17:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738173516; cv=none; b=Lz37ZdNQDLgm8NADKrVdb+INDlTxm9IcPZ9wFr6SsvYyxb+uGWidqYYxQEScWlZdYumYbJlGP0vCHSzL6Pe7cmdrQRXXmvTPQwE9WjlNcn3mWGFbKdkdmXyptTD+Zbl3OUvRBM0Q2WeWgMkp5gnYZmZYW7roqZPbjhN1zSZ2TiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738173516; c=relaxed/simple;
	bh=8xGh50OkPIQTLDP9gaG7cqIHeiecFwaWhFj7d59rlMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JEDI4rP3hr8EdoCILK30GqSi5onEH0KuUxvgUEa2vBDEEI8E0p2U9JxbST8juUAu12xP8WkvCFO6YIqPBHE8eUiRG0B70BnILAemdwVAHqUCnKjfcU+HmyxSw6E09Zx1+XIKUAx61rYDMVEv6AdCRXyqYv4bcbYfqp1DFY9Y+Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZrgeFQrq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.17.64.118] (unknown [131.107.1.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id D67E02037174;
	Wed, 29 Jan 2025 09:58:33 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D67E02037174
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738173514;
	bh=uRSQTrMFEFDm2zsBktN/wmD1BfYmyTblYMj8j8PqD2U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZrgeFQrqCXeYWNNY77CxMlSyVGM0q02Rzm2yrX2VrT8T8pTkoQDHtma7jyQkgm7iy
	 Y2Hd1Mg12s/B0HXsRrQHcR7nayo8ie91WlsexMfid0DGaPHjxfjUjh8L6hkKiUEn5W
	 srcOdvPpwhR2wOMSQ9X4E2NSCCzTm6YLKwtkBZm8=
Message-ID: <0bc207f9-2392-4cb0-ad5b-479033997612@linux.microsoft.com>
Date: Wed, 29 Jan 2025 09:58:33 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/7] ima: kexec: skip IMA segment validation after
 kexec soft reboot
To: Stefan Berger <stefanb@linux.ibm.com>, zohar@linux.ibm.com,
 roberto.sassu@huaweicloud.com, petr@tesarici.cz, eric.snowberg@oracle.com,
 paul@paul-moore.com, code@tyhicks.com, nramas@linux.microsoft.com,
 James.Bottomley@HansenPartnership.com, madvenka@linux.microsoft.com
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250124225547.22684-1-chenste@linux.microsoft.com>
 <20250124225547.22684-4-chenste@linux.microsoft.com>
 <35dcea8e-6418-4c60-b4ab-8e6c26721715@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <35dcea8e-6418-4c60-b4ab-8e6c26721715@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/28/2025 7:23 AM, Stefan Berger wrote:
>
>
> On 1/24/25 5:55 PM, steven chen wrote:
>> kexec_calculate_store_digests() calculates and stores the digest of the
>> segment at kexec_file_load syscall where the IMA segment is also
>> allocated.  With this series, the IMA segment will be updated with the
>> measurement log at kexec soft reboot.  Therefore, it may fail digest
>
> ... log at kexec execute stage when the soft reboot is initiated.
>
>> verification in verify_sha256_digest() after kexec soft reboot into the
> > new Kernel.  Therefore, the digest calculation/verification of the IMA
>
> kernel
>
>> segment needs to be skipped.
>>
>> Skip IMA segment from calculating and storing digest in function
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
>> ---
>>   include/linux/kexec.h              |  3 +++
>>   kernel/kexec_file.c                | 10 ++++++++++
>>   security/integrity/ima/ima_kexec.c |  3 +++
>>   3 files changed, 16 insertions(+)
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
> >   #endif>
>>       /* Core ELF header buffer */
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index 3eedb8c226ad..4ff3ba0f3e8e 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -764,6 +764,16 @@ static int kexec_calculate_store_digests(struct 
>> kimage *image)
>>           if (ksegment->kbuf == pi->purgatory_buf)
>>               continue;
>>   +#ifdef CONFIG_IMA_KEXEC
>> +        /*
>> +         * Skip the segment if ima_segment_index is set and matches
>> +         * the current index
>> +         */
>> +        if (image->is_ima_segment_index_set &&
>> +            i == image->ima_segment_index)
>> +            continue;
>> +#endif
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
>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

Thanks. Will update in next release.


