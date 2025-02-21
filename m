Return-Path: <linux-integrity+bounces-4972-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EA4A401D7
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2025 22:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0FB23BAFD4
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2025 21:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 309D7253F0C;
	Fri, 21 Feb 2025 21:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WeswjTuN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94030253F07;
	Fri, 21 Feb 2025 21:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740172001; cv=none; b=EGVQMuLIDr8ecWBZ0MOi1N3HS8fAPc5Y3Hf9tYaHE9efCd2/YTavguiQ/+WIdmcMUKKXQaQb2Nc/rqRByjJUepSay0V4RIx26bHM29QAfdN1fl0yGhek9H4prqWkDsofPR4ainYRtXCz1yi4dPt4dHR4Yl1wzfmK0TcRSNM8miI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740172001; c=relaxed/simple;
	bh=FVB5odcTnl6iIyoZpZrtPi71Db2uyEV+wlrjkdu/XdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=USkUpY6j3CFetwA/flQb+9nl9Ds45GTWf3EbLDiJL8o2AgyDRK11JrJHgGTyl4iv8e+ShvR2IOfX/MT83Fd4qj5Zfpb2PgdRa5PZ3R319GEoyJxPHyfNTlx+8QvqBLo/v7WnviBYq1XYHWheb9c0s8CqlE8Q3o43pzJbpOhfkJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WeswjTuN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.17.64.59] (unknown [131.107.8.59])
	by linux.microsoft.com (Postfix) with ESMTPSA id E71A0205367B;
	Fri, 21 Feb 2025 13:06:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E71A0205367B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740171999;
	bh=FUlp7EisKMHoz+xilvHRinAU2TQZ+x4bdo9N281fpHY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WeswjTuNzlG4W7eElUmgmU2MU266rObyW3PfV6HWjdXePbZxpzFDg8EiYGFrOooe5
	 vuf/vXW9Ail2ZrGQXDQnlcXLJGMjzb3XCnLtB4jBljRm+aVg4EXQOxcOR8DNiyEEGy
	 1+NvYn0GNnuKEqXZY41l+Z4rocZqtw5AooSP98Ps=
Message-ID: <a8814f0f-3613-4efd-afb2-655a5c0c9f38@linux.microsoft.com>
Date: Fri, 21 Feb 2025 13:06:37 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/7] ima: kexec: skip IMA segment validation after
 kexec soft reboot
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
 <20250218225502.747963-4-chenste@linux.microsoft.com>
 <1883119129dbeeabad1f5239f042a7b920feef0f.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <1883119129dbeeabad1f5239f042a7b920feef0f.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/21/2025 7:41 AM, Mimi Zohar wrote:
> On Tue, 2025-02-18 at 14:54 -0800, steven chen wrote:
>> kexec_calculate_store_digests() calculates and stores the digest of the
>> segment at kexec_file_load syscall where the IMA segment is also
>> allocated.  With this series, the IMA segment will be updated with the
>> measurement log at kexec execute stage when soft reboot is initiated.
>> Therefore, it may fail digest verification in verify_sha256_digest()
>> after kexec soft reboot into the new kernel. Therefore, the digest
>> calculation/verification of the IMA segment needs to be skipped.
>>
>> Skip the calculating and storing digest of the IMA segment in
>> kexec_calculate_store_digests() so that it is not added to the
>> 'purgatory_sha_regions'.
>>
>> Since verify_sha256_digest() only verifies 'purgatory_sha_regions',
>> no change is needed in verify_sha256_digest() in this context.
>>
>> With this change, the IMA segment is not included in the digest
>> calculation, storage, and verification.
> Basically you're saying because the hash verification will fail, don't include
> the IMA buffer.  What's missing is the reason for not caring whether the IMA
> hash is included or not.
>
> I understand this is the best we can do without making some major kexec changes.
>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> After updating the patch description,
>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
>
>> ---
>>   include/linux/kexec.h              |  3 +++
>>   kernel/kexec_file.c                | 22 ++++++++++++++++++++++
>>   security/integrity/ima/ima_kexec.c |  3 +++
>>   3 files changed, 28 insertions(+)
>>
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index 4dbf806bccef..bd554ced9fb2 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -362,6 +362,9 @@ struct kimage {
>>   
>>   	phys_addr_t ima_buffer_addr;
>>   	size_t ima_buffer_size;
>> +
>> +	unsigned long ima_segment_index;
>> +	bool is_ima_segment_index_set;
>>   #endif
>>   
>>   	/* Core ELF header buffer */
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index 3eedb8c226ad..606132253c79 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -38,6 +38,21 @@ void set_kexec_sig_enforced(void)
>>   }
>>   #endif
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
>>   static int kexec_calculate_store_digests(struct kimage *image);
>>   
>>   /* Maximum size in bytes for kernel/initrd files. */
>> @@ -764,6 +779,13 @@ static int kexec_calculate_store_digests(struct kimage
>> *image)
>>   		if (ksegment->kbuf == pi->purgatory_buf)
>>   			continue;
>>   
>> +		/*
>> +		 * Skip the segment if ima_segment_index is set and matches
>> +		 * the current index
>> +		 */
>> +		if (check_ima_segment_index(image, i))
>> +			continue;
>> +
>>   		ret = crypto_shash_update(desc, ksegment->kbuf,
>>   					  ksegment->bufsz);
>>   		if (ret)
>> diff --git a/security/integrity/ima/ima_kexec.c
>> b/security/integrity/ima/ima_kexec.c
>> index 89088f1fa989..704676fa6615 100644
>> --- a/security/integrity/ima/ima_kexec.c
>> +++ b/security/integrity/ima/ima_kexec.c
>> @@ -160,6 +160,7 @@ void ima_add_kexec_buffer(struct kimage *image)
>>   	kbuf.buffer = kexec_buffer;
>>   	kbuf.bufsz = kexec_buffer_size;
>>   	kbuf.memsz = kexec_segment_size;
>> +	image->is_ima_segment_index_set = false;
>>   	ret = kexec_add_buffer(&kbuf);
>>   	if (ret) {
>>   		pr_err("Error passing over kexec measurement buffer.\n");
>> @@ -170,6 +171,8 @@ void ima_add_kexec_buffer(struct kimage *image)
>>   	image->ima_buffer_addr = kbuf.mem;
>>   	image->ima_buffer_size = kexec_segment_size;
>>   	image->ima_buffer = kexec_buffer;
>> +	image->ima_segment_index = image->nr_segments - 1;
>> +	image->is_ima_segment_index_set = true;
>>   
>>   	/*
>>   	 * kexec owns kexec_buffer after kexec_add_buffer() is called

Thanks, Mimi. I will update in next version.


