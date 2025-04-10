Return-Path: <linux-integrity+bounces-5771-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3FBA845EC
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 16:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9006189D6AA
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 14:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FE128C5C3;
	Thu, 10 Apr 2025 14:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="STHC8Vd7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FA728A41B;
	Thu, 10 Apr 2025 14:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744294313; cv=none; b=DxWUZa7A3Wz9xts/kmqxVnfqVFbKdf3OoOJqcapbdQQ3uui92WkbFUKZTpMNZurPC3yoUrYLoe5MMENLkbmCLTAjKsRZ42+D3Hqf06LKVHecV9JYL0YpY5KH+2FAW5wBCWWlXnjTUMUKEszmy296Kgzfyu8Nxg7nN4CbBd5egGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744294313; c=relaxed/simple;
	bh=EvFKfky52vbvM+wEEGE8NveTZMqOTVIS8k3QKbbtTZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N5gcS9TIpte91+o62/ktLVQjF0ijYk/xKQcVRe3zn4WqNKEOFeZx1pHEo7ae6L33otR1XpY1KbLvBlukUNfheYnWXn1eBpqmiNY+8JOSCOMOoHRreSsL6y0aEPgCDlXiHAUJvoE8dT9tRjF+6IK4lyc3ZtAAGTohO7uj+hTaf9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=STHC8Vd7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.70.200.180] (unknown [20.1.194.235])
	by linux.microsoft.com (Postfix) with ESMTPSA id 08FA62114D81;
	Thu, 10 Apr 2025 07:11:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 08FA62114D81
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744294310;
	bh=BWbmMbT74Sn7SqaSDZAyAFKEL0RW1KrKKLxHKERd89Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=STHC8Vd7L34139AsmAyauJpLmZYgvBtIRXy/VamhTZgHJvxW/gIalruqNdVHSTXQB
	 vQWTNgyRHU8fwPKdVhRWubSzYL4iRWCx2ULcGRFgEimMvmVCqWuATr7BF0eHfuDBa4
	 c1bqXcyCOYoZ43yTOLlQkqcQJW/sJXQnd/qQpMRQ=
Message-ID: <1e176b0c-13a2-42bd-8879-b22f459a04de@linux.microsoft.com>
Date: Thu, 10 Apr 2025 07:11:47 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 3/9] kexec: define functions to map and unmap segments
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
 <20250402124725.5601-4-chenste@linux.microsoft.com>
 <Z/STl3Jjt4/gMQHL@MiWiFi-R3L-srv>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <Z/STl3Jjt4/gMQHL@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/7/2025 8:10 PM, Baoquan He wrote:
> On 04/02/25 at 05:47am, steven chen wrote:
>> Currently, the kernel behavior during kexec load is to fetch the IMA
>> measurements logs and store logs in kernel memory. When a kexec reboot is
>> triggered, these stored logs in the kernel memory are carried over to the
>> second kernel. However, the time gap between kexec load and kexec reboot
>> can be very long. During this time window, new events extended into TPM
>> PCRs miss the chance to be carried over to the second kernel. This results
>> in a mismatch between TPM PCR quotes and the actual IMA measurements list
>> after kexec reboot, leading to remote attestation failure.
>>
>> To solve this problem, the new design defers reading the IMA measurements
>> logs into the kexec buffer to the kexec reboot phase, while still allocating
>> the necessary buffer at kexec load time because it is not appropriate to
>> allocate memory at the kexec reboot moment.
>>
>> The content of memory segments carried over to the new kernel during the
>> kexec system call can be changed at the kexec 'execute' stage, but the size
>> of the memory segments cannot be changed at the kexec 'execute' stage.
>>
>> To copy IMA measurement logs during the kexec operation, IMA allocates
>> memory at the kexec 'load' stage and map the segments to the kimage
>> structure. The mapped address will then be used to copy IMA measurements
>> during the kexec 'execute' stage.
>>
>> Currently, the mechanism to map and unmap segments to the kimage structure
>> is not available to subsystems outside of kexec.
> There's no need to describe the plan of the whole series. From my point
> of view, the first few patches are prepared for later change. We can
> just mention this, and briefly tell what it's doing if it's complicated.
> For log of this patch, I would go with:
>
> ====
> Implement kimage_map_segment() to enable IMA to map the measurement log
> list to the kimage structure during the kexec 'load' stage. This function
> gathers the source pages within the specified address range, and maps them
> to a contiguous virtual address range.
>
> This is a preparation for later usage.
> ====
>
> Other than this, the code change looks good to me.

Hi Baoquan,

Thanks for your comments. Will update in next version.

Steven

>> Implement kimage_map_segment() to enable IMA to map the measurement log
>> list to the kimage structure during the kexec 'load' stage. This function
>> takes a kimage pointer, a memory address, and a size, then gathers the
>> source pages within the specified address range, creates an array of page
>> pointers, and maps these to a contiguous virtual address range. The
>> function returns the start virtual address of this range if successful,
>> or NULL on failure.
>>
>> Implement kimage_unmap_segment() for unmapping segments using vunmap().
>>
>> From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>> Cc: Eric Biederman <ebiederm@xmission.com>
>> Cc: Baoquan He <bhe@redhat.com>
>> Cc: Vivek Goyal <vgoyal@redhat.com>
>> Cc: Dave Young <dyoung@redhat.com>
>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>> Acked-by: Baoquan He <bhe@redhat.com>
>> ---
>>   include/linux/kexec.h |  6 +++++
>>   kernel/kexec_core.c   | 54 +++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 60 insertions(+)
>>
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index f0e9f8eda7a3..7d6b12f8b8d0 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -467,13 +467,19 @@ extern bool kexec_file_dbg_print;
>>   #define kexec_dprintk(fmt, arg...) \
>>           do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0)
>>   
>> +extern void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size);
>> +extern void kimage_unmap_segment(void *buffer);
>>   #else /* !CONFIG_KEXEC_CORE */
>>   struct pt_regs;
>>   struct task_struct;
>> +struct kimage;
>>   static inline void __crash_kexec(struct pt_regs *regs) { }
>>   static inline void crash_kexec(struct pt_regs *regs) { }
>>   static inline int kexec_should_crash(struct task_struct *p) { return 0; }
>>   static inline int kexec_crash_loaded(void) { return 0; }
>> +static inline void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size)
>> +{ return NULL; }
>> +static inline void kimage_unmap_segment(void *buffer) { }
>>   #define kexec_in_progress false
>>   #endif /* CONFIG_KEXEC_CORE */
>>   
>> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
>> index c0bdc1686154..a5e378e1dc7f 100644
>> --- a/kernel/kexec_core.c
>> +++ b/kernel/kexec_core.c
>> @@ -867,6 +867,60 @@ int kimage_load_segment(struct kimage *image,
>>   	return result;
>>   }
>>   
>> +void *kimage_map_segment(struct kimage *image,
>> +			 unsigned long addr, unsigned long size)
>> +{
>> +	unsigned long src_page_addr, dest_page_addr = 0;
>> +	unsigned long eaddr = addr + size;
>> +	kimage_entry_t *ptr, entry;
>> +	struct page **src_pages;
>> +	unsigned int npages;
>> +	void *vaddr = NULL;
>> +	int i;
>> +
>> +	/*
>> +	 * Collect the source pages and map them in a contiguous VA range.
>> +	 */
>> +	npages = PFN_UP(eaddr) - PFN_DOWN(addr);
>> +	src_pages = kmalloc_array(npages, sizeof(*src_pages), GFP_KERNEL);
>> +	if (!src_pages) {
>> +		pr_err("Could not allocate ima pages array.\n");
>> +		return NULL;
>> +	}
>> +
>> +	i = 0;
>> +	for_each_kimage_entry(image, ptr, entry) {
>> +		if (entry & IND_DESTINATION) {
>> +			dest_page_addr = entry & PAGE_MASK;
>> +		} else if (entry & IND_SOURCE) {
>> +			if (dest_page_addr >= addr && dest_page_addr < eaddr) {
>> +				src_page_addr = entry & PAGE_MASK;
>> +				src_pages[i++] =
>> +					virt_to_page(__va(src_page_addr));
>> +				if (i == npages)
>> +					break;
>> +				dest_page_addr += PAGE_SIZE;
>> +			}
>> +		}
>> +	}
>> +
>> +	/* Sanity check. */
>> +	WARN_ON(i < npages);
>> +
>> +	vaddr = vmap(src_pages, npages, VM_MAP, PAGE_KERNEL);
>> +	kfree(src_pages);
>> +
>> +	if (!vaddr)
>> +		pr_err("Could not map ima buffer.\n");
>> +
>> +	return vaddr;
>> +}
>> +
>> +void kimage_unmap_segment(void *segment_buffer)
>> +{
>> +	vunmap(segment_buffer);
>> +}
>> +
>>   struct kexec_load_limit {
>>   	/* Mutex protects the limit count. */
>>   	struct mutex mutex;
>> -- 
>> 2.25.1
>>


