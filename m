Return-Path: <linux-integrity+bounces-5945-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3DE6A947DD
	for <lists+linux-integrity@lfdr.de>; Sun, 20 Apr 2025 14:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9AC23B1280
	for <lists+linux-integrity@lfdr.de>; Sun, 20 Apr 2025 12:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F411C1DE2C6;
	Sun, 20 Apr 2025 12:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="V4Np+vMs"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C02B262A6;
	Sun, 20 Apr 2025 12:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745152239; cv=none; b=ej4QO4NvnDU8CXiQYbBn4dTl3hD3/Ne7DJ1jD67TWWcY/KAD5UWEwhCPUAJJj/1ZCPGP/f8geXZESsQn9Z5nhMT0fU0YH9dNyeEpp9LTqE0E/yPPN4kQjIN9ComxfzR0PEE1M+v7pQuTB3dRDuLOekd4dTImgHsxgfVG8fpOxaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745152239; c=relaxed/simple;
	bh=5b5/FWnIrEzpCy0kn9VAxmzU7MFyxemO188s/rptvTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kpoIazUldV5PlOIffrzJCILO42umcV/DSzBLul69zKEpbu5SPjU3D5FdL4r/Qgsu3sufbZGL8Qit3F6ny0CiE2rUYN8q7/jx//MKHOuMSwhrS1VFv6a6ZM70VqbVKon0e3YQzOfpz50hj/05GL4N7Hf7Lkt0IjJV274OGDtgHcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=V4Np+vMs; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.70.200.26] (unknown [20.110.218.7])
	by linux.microsoft.com (Postfix) with ESMTPSA id C47DB2052525;
	Sun, 20 Apr 2025 05:30:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C47DB2052525
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1745152237;
	bh=QfQcgycMxq4nFFdzo1bb4Mu23pE71kIy82/gI3Q5HR8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V4Np+vMsDXuWmgqdQ24dSBKB/bda0EoaXO8SXIxFdLnBzuuvLGiSX/cekoo3Hwt1o
	 1dztDlj5ZtHUC6mkUaJwEeOWc//MQYrhn1kmFDTtX0EDpakTFURgS0JngBVI+clV2A
	 LBPBfKqpczgqlm1OR0izf5GVEK+quBc6jq6LbZEk=
Message-ID: <95d249ef-bfb3-431f-b633-8b3de383e067@linux.microsoft.com>
Date: Sun, 20 Apr 2025 05:30:33 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 3/9] kexec: define functions to map and unmap segments
To: Baoquan He <bhe@redhat.com>
Cc: zohar@linux.ibm.com, stefanb@linux.ibm.com,
 roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
 eric.snowberg@oracle.com, ebiederm@xmission.com, paul@paul-moore.com,
 code@tyhicks.com, bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
 kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
 nramas@linux.microsoft.com, James.Bottomley@hansenpartnership.com,
 vgoyal@redhat.com, dyoung@redhat.com
References: <20250416021028.1403-1-chenste@linux.microsoft.com>
 <20250416021028.1403-4-chenste@linux.microsoft.com>
 <aAHW4O9qAKzaoa+O@MiWiFi-R3L-srv>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <aAHW4O9qAKzaoa+O@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/17/2025 9:36 PM, Baoquan He wrote:
> On 04/15/25 at 07:10pm, steven chen wrote:
>> From: Steven Chen <chenste@linux.microsoft.com>
>   ^^^^^^
>> Implement kimage_map_segment() to enable IMA to map the measurement log
>> list to the kimage structure during the kexec 'load' stage. This function
>> gathers the source pages within the specified address range, and maps them
>> to a contiguous virtual address range.
>>
>> This is a preparation for later usage.
>>
>> Implement kimage_unmap_segment() for unmapping segments using vunmap().
>>
>> From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>    ^^^^^^
>> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
>    ^^^^^^^
>> Cc: Eric Biederman <ebiederm@xmission.com>
>> Cc: Baoquan He <bhe@redhat.com>
>> Cc: Vivek Goyal <vgoyal@redhat.com>
>> Cc: Dave Young <dyoung@redhat.com>
>> Signed-off-by: steven chen <chenste@linux.microsoft.com>
>    ^^^^^
>
> The signing on this patch is a little confusing. I can't see who is the
> real author, who is the co-author, between you and Tushar. You may need
> to refer to Documentation/process/5.Posting.rst to make that clear.

Hi Baoquan,

 From my understanding, if there is no change from the original author 
patch, need to add
 From tag and Signed-off-by tag; otherwise, if there are changes, 
Signed-off-by can be used.

Thanks,

Steven

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
>> 2.43.0
>>


