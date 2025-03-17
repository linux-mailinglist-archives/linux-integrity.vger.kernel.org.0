Return-Path: <linux-integrity+bounces-5294-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA4AA65C7E
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Mar 2025 19:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8E7A1894C63
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Mar 2025 18:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D08A1B4232;
	Mon, 17 Mar 2025 18:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BByOTodA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51FDEED6;
	Mon, 17 Mar 2025 18:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235990; cv=none; b=lW6DVpjhjgzBHyNBENHLZ94MeQuLqLhZvTJ6kN8/D/BKYs1lSgzF/ZYr9YKvz/iM9Ow7x/LFbcSL84jvTd1c5rs2rlWutqrIUvV3NeFRdXvNp7WcMrtsFczU1IW/7edmxJm/CpwUR1MEQEggfPD1YdhJ+n/8W/m4tZzaGbxbGhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235990; c=relaxed/simple;
	bh=+++DQafxWKb80y1XK+8h/f8b+FTVjPzib9hddsHz5uw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m3+bLAGrRjZ9RsrEtcVLjZ6VfrYQNtnZ6/bbo+SoQEUJn4IfH+n9YOv7/l1Ku1EttYGS5zkVQSzMeAgmhILubs3EygYyL6UJcv0HFNIAAtenmGyU+gIm+U265+3q3v/t67BL5G8yCClo2Lh5hazPFDjNd5Mwp54fKaU0iTImPQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BByOTodA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.17.64.108] (unknown [131.107.147.236])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0A1392033446;
	Mon, 17 Mar 2025 11:26:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0A1392033446
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742235988;
	bh=qp2xI3QTzUgxM5S5rM6E+Zs1aGPEVZUMHtXpZqPzgJc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BByOTodA2rsY66J+N49CcTYDbbdQti49s8SiLd+O0iAQ/vkj9vEDbkudszCWMlzAv
	 REYofXu+RdkvOhLCXd8vJdqNR8M0UDacd78xKnx917rsICHJnLBgyiPkFi3MvbcVo1
	 j+Leqq9h3DNiQ/nogyjoxpsr/Sk8M3XJCpuimjkc=
Message-ID: <30eea6c2-cc42-4836-ad70-ccae99b3afda@linux.microsoft.com>
Date: Mon, 17 Mar 2025 11:26:27 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 2/7] kexec: define functions to map and unmap segments
To: Baoquan He <bhe@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, zohar@linux.ibm.com,
 stefanb@linux.ibm.com, roberto.sassu@huaweicloud.com,
 roberto.sassu@huawei.com, eric.snowberg@oracle.com, ebiederm@xmission.com,
 paul@paul-moore.com, code@tyhicks.com, bauermann@kolabnow.com,
 linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
 James.Bottomley@hansenpartnership.com, vgoyal@redhat.com, dyoung@redhat.com
References: <20250304190351.96975-1-chenste@linux.microsoft.com>
 <20250304190351.96975-3-chenste@linux.microsoft.com>
 <Z8d9RvRWPOADOgsx@kernel.org>
 <97c27a30-a5ee-4825-ab7e-82dcddedd688@linux.microsoft.com>
 <Z8hCl4piQ1Sfpi7h@MiWiFi-R3L-srv>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <Z8hCl4piQ1Sfpi7h@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/5/2025 4:24 AM, Baoquan He wrote:
> On 03/04/25 at 04:55pm, steven chen wrote:
>> On 3/4/2025 2:23 PM, Jarkko Sakkinen wrote:
>>> On Tue, Mar 04, 2025 at 11:03:46AM -0800, steven chen wrote:
>>>> The content of memory segments carried over to the new kernel during the
>>>> kexec systemcall can be changed at kexec 'execute' stage, but the size of
>>>> the memory segments cannot be changed at kexec 'execute' stage.
>>>>
>>>> To copy IMA measurement logs during the kexec operation, IMA needs to
>>>> allocate memory at the kexec 'load' stage and map the segments to the
>>>> kimage structure. The mapped address will then be used to copy IMA
>>>> measurements during the kexec 'execute' stage.
>>>>
>>>> Currently, the mechanism to map and unmap segments to the kimage
>>>> structure is not available to subsystems outside of kexec.
>>> How does IMA work with kexec without having this? Just interested
>>> (and confused).
>> Currently, all IMA-related operations during a soft reboot, such as memory
>> allocation and IMA log list copy, are handled in the kexec 'load' stage, so
>> the map/unmap mechanism is not required.
>>
>> The new design separates these two operations into different stages: memory
>> allocation remains in the kexec 'load' stage, while the IMA log list copy is
>> moved to the kexec 'execute' stage. Therefore, the map/unmap mechanism is
>> introduced.
> I think the log can be improved. About the found problem and solution
> part, we possible can describe them like below:
>
> ===
> Currently, the kernel behaviour of kexec load is the IMA measurements
> log is fetched from TPM PCRs and stored into buffer and hold. When
> kexec reboot is triggered, the stored log buffer is carried over to the
> 2nd kernel. However, the time gap between kexec load and kexec reboot
> could be very long. Then those new events extended into TPM PCRs during
> the time window misses the chance to be carried over to 2nd kernel. This
> results in mismatch between TPM PCR quotes and the actual IMA measurements
> list after kexec reboot, which in turn results in remote attestation
> failure.
>
> To solve this problem, the new design is to defer the reading TPM PCRs
> content out into kexec buffer to kexec reboot phase. While still
> allocating the necessary buffer at kexec load time because it's not
> appropriate to allocate memory at kexec reboot moment.
> ===
>
> It may still need be improved, just for your reference. You can change
> and add more detail needed and add them into your log.
>
>> Please refer to "[PATCH v9 0/7] ima: kexec: measure events between kexec
>> load and execute" for the reason why to add this.
>>
>> Steven
>>
>>>> Implement kimage_map_segment() to enable IMA to map measurement log list to
>>>> the kimage structure during kexec 'load' stage.  This function takes a kimage
>>>> pointer, a memory address, and a size, then gathers the
>>>> source pages within the specified address range, creates an array of page
>>>> pointers, and maps these to a contiguous virtual address range.  The
>>>> function returns the start virtual address of this range if successful, or NULL on
>>>> failure.
>>>>
>>>> Implement kimage_unmap_segment() for unmapping segments
>>>> using vunmap().
>>>>
>>>> From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>>>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>>>> Cc: Eric Biederman <ebiederm@xmission.com>
>>>> Cc: Baoquan He <bhe@redhat.com>
>>>> Cc: Vivek Goyal <vgoyal@redhat.com>
>>>> Cc: Dave Young <dyoung@redhat.com>
>>>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>>>> ---
>>>>    include/linux/kexec.h |  6 +++++
>>>>    kernel/kexec_core.c   | 54 +++++++++++++++++++++++++++++++++++++++++++
>>>>    2 files changed, 60 insertions(+)
>>>>
>>>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>>>> index f0e9f8eda7a3..7d6b12f8b8d0 100644
>>>> --- a/include/linux/kexec.h
>>>> +++ b/include/linux/kexec.h
>>>> @@ -467,13 +467,19 @@ extern bool kexec_file_dbg_print;
>>>>    #define kexec_dprintk(fmt, arg...) \
>>>>            do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0)
>>>> +extern void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size);
>>>> +extern void kimage_unmap_segment(void *buffer);
>>>>    #else /* !CONFIG_KEXEC_CORE */
>>>>    struct pt_regs;
>>>>    struct task_struct;
>>>> +struct kimage;
>>>>    static inline void __crash_kexec(struct pt_regs *regs) { }
>>>>    static inline void crash_kexec(struct pt_regs *regs) { }
>>>>    static inline int kexec_should_crash(struct task_struct *p) { return 0; }
>>>>    static inline int kexec_crash_loaded(void) { return 0; }
>>>> +static inline void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size)
>>>> +{ return NULL; }
>>>> +static inline void kimage_unmap_segment(void *buffer) { }
>>>>    #define kexec_in_progress false
>>>>    #endif /* CONFIG_KEXEC_CORE */
>>>> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
>>>> index c0bdc1686154..63e4d16b6023 100644
>>>> --- a/kernel/kexec_core.c
>>>> +++ b/kernel/kexec_core.c
>>>> @@ -867,6 +867,60 @@ int kimage_load_segment(struct kimage *image,
>>>>    	return result;
>>>>    }
>>>> +void *kimage_map_segment(struct kimage *image,
>>>> +			 unsigned long addr, unsigned long size)
>>>> +{
>>>> +	unsigned long eaddr = addr + size;
>>>> +	unsigned long src_page_addr, dest_page_addr;
>>>> +	unsigned int npages;
>>>> +	struct page **src_pages;
>>>> +	int i;
>>>> +	kimage_entry_t *ptr, entry;
>>>> +	void *vaddr = NULL;
> When adding a new function, it's suggested to take the reverse xmas tree
> style for local variable ordering usually.
>
>>>> +
>>>> +	/*
>>>> +	 * Collect the source pages and map them in a contiguous VA range.
>>>> +	 */
>>>> +	npages = PFN_UP(eaddr) - PFN_DOWN(addr);
>>>> +	src_pages = kmalloc_array(npages, sizeof(*src_pages), GFP_KERNEL);
>>>> +	if (!src_pages) {
>>>> +		pr_err("Could not allocate ima pages array.\n");
>>>> +		return NULL;
>>>> +	}
>>>> +
>>>> +	i = 0;
>>>> +	for_each_kimage_entry(image, ptr, entry) {
>>>> +		if (entry & IND_DESTINATION) {
>>>> +			dest_page_addr = entry & PAGE_MASK;
>>>> +		} else if (entry & IND_SOURCE) {
>>>> +			if (dest_page_addr >= addr && dest_page_addr < eaddr) {
>>>> +				src_page_addr = entry & PAGE_MASK;
>>>> +				src_pages[i++] =
>>>> +					virt_to_page(__va(src_page_addr));
>>>> +				if (i == npages)
>>>> +					break;
>>>> +				dest_page_addr += PAGE_SIZE;
>>>> +			}
>>>> +		}
>>>> +	}
>>>> +
>>>> +	/* Sanity check. */
>>>> +	WARN_ON(i < npages);
>>>> +
>>>> +	vaddr = vmap(src_pages, npages, VM_MAP, PAGE_KERNEL);
>>>> +	kfree(src_pages);
>>>> +
>>>> +	if (!vaddr)
>>>> +		pr_err("Could not map ima buffer.\n");
>>>> +
>>>> +	return vaddr;
>>>> +}
>>>> +
>>>> +void kimage_unmap_segment(void *segment_buffer)
>>>> +{
>>>> +	vunmap(segment_buffer);
>>>> +}
>>>> +
>>>>    struct kexec_load_limit {
>>>>    	/* Mutex protects the limit count. */
>>>>    	struct mutex mutex;
>>>> -- 
>>>> 2.25.1
>>>>
>>>>
>>> BR, Jarkko
>>
Hi Baoquan,

Thanks for your comments. I will update it in next version.

Steven


