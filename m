Return-Path: <linux-integrity+bounces-5650-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA035A7F315
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Apr 2025 05:10:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EF03174E1E
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Apr 2025 03:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765A71B0405;
	Tue,  8 Apr 2025 03:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SegpSM50"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759201C6B4
	for <linux-integrity@vger.kernel.org>; Tue,  8 Apr 2025 03:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744081852; cv=none; b=RaJVsUUo653n0zi6Pe68gpi+Xa7XapV1tWoIlBAtbdSo8AwIMQWdPVaFQe5RPr3IQ3NbNCTNv2jug3P9ykobZp7oMbVoec5V+vWZ4/VzL16hm4FEAKQFWTsfr8+561anYBKC7oBJyRMrRLIjONqnxUe9h9OrgpXjNI2BzXXr/AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744081852; c=relaxed/simple;
	bh=iZqz7CGPGjigJFJ9W9twq7dMICwPe5Dj9JKUVaktwzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4GP/4AWpsLJEpTqrQCYdIIUO8mvBdRBJHC8xoCgqqUznxNL4M/ofgR/WEuvhKnfNX8ggoEB0Xfm7pqggIl72OeLds4tGTipd5ad/j/Za/wogiR08w0teEal/shnC/1YUBw2MpNr5yVhCmPrjavBxsy+bdVZ5oxEJhNPMU8uPxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SegpSM50; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744081849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iDSuBu09MfYTuLF6BoI40PiBItHbiQT0HtRAOVT0XIs=;
	b=SegpSM50LBTXODsS0WQYwrkQCbqCUVAJvrlG26ZFE8/iBk8oTU0PLRZfEPCDVPIGOSi5hM
	Vo+hqXqLxWSUT9OxWsayIQtj/HtjOopF0qLgxKe9bpyHz6OhJAESRtGTKlDuIQhO0QjBF0
	hB2/3QaInIjDlmilu2g4c+kl4GK7jVk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-d7lE_cTFNF2pL-skmWl5Jw-1; Mon,
 07 Apr 2025 23:10:47 -0400
X-MC-Unique: d7lE_cTFNF2pL-skmWl5Jw-1
X-Mimecast-MFC-AGG-ID: d7lE_cTFNF2pL-skmWl5Jw_1744081825
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CD07C19560BE;
	Tue,  8 Apr 2025 03:10:23 +0000 (UTC)
Received: from localhost (unknown [10.72.112.61])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2EB0319560AD;
	Tue,  8 Apr 2025 03:10:19 +0000 (UTC)
Date: Tue, 8 Apr 2025 11:10:15 +0800
From: Baoquan He <bhe@redhat.com>
To: steven chen <chenste@linux.microsoft.com>
Cc: zohar@linux.ibm.com, stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
	eric.snowberg@oracle.com, ebiederm@xmission.com,
	paul@paul-moore.com, code@tyhicks.com, bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
	James.Bottomley@hansenpartnership.com, vgoyal@redhat.com,
	dyoung@redhat.com
Subject: Re: [PATCH v11 3/9] kexec: define functions to map and unmap segments
Message-ID: <Z/STl3Jjt4/gMQHL@MiWiFi-R3L-srv>
References: <20250402124725.5601-1-chenste@linux.microsoft.com>
 <20250402124725.5601-4-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402124725.5601-4-chenste@linux.microsoft.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 04/02/25 at 05:47am, steven chen wrote:
> Currently, the kernel behavior during kexec load is to fetch the IMA
> measurements logs and store logs in kernel memory. When a kexec reboot is
> triggered, these stored logs in the kernel memory are carried over to the
> second kernel. However, the time gap between kexec load and kexec reboot
> can be very long. During this time window, new events extended into TPM 
> PCRs miss the chance to be carried over to the second kernel. This results 
> in a mismatch between TPM PCR quotes and the actual IMA measurements list
> after kexec reboot, leading to remote attestation failure.
> 
> To solve this problem, the new design defers reading the IMA measurements
> logs into the kexec buffer to the kexec reboot phase, while still allocating
> the necessary buffer at kexec load time because it is not appropriate to 
> allocate memory at the kexec reboot moment.
> 
> The content of memory segments carried over to the new kernel during the
> kexec system call can be changed at the kexec 'execute' stage, but the size
> of the memory segments cannot be changed at the kexec 'execute' stage.
> 
> To copy IMA measurement logs during the kexec operation, IMA allocates 
> memory at the kexec 'load' stage and map the segments to the kimage 
> structure. The mapped address will then be used to copy IMA measurements 
> during the kexec 'execute' stage.
> 
> Currently, the mechanism to map and unmap segments to the kimage structure
> is not available to subsystems outside of kexec.

There's no need to describe the plan of the whole series. From my point
of view, the first few patches are prepared for later change. We can
just mention this, and briefly tell what it's doing if it's complicated.
For log of this patch, I would go with:

====
Implement kimage_map_segment() to enable IMA to map the measurement log 
list to the kimage structure during the kexec 'load' stage. This function
gathers the source pages within the specified address range, and maps them
to a contiguous virtual address range.

This is a preparation for later usage.
====

Other than this, the code change looks good to me.

> 
> Implement kimage_map_segment() to enable IMA to map the measurement log 
> list to the kimage structure during the kexec 'load' stage. This function
> takes a kimage pointer, a memory address, and a size, then gathers the
> source pages within the specified address range, creates an array of page
> pointers, and maps these to a contiguous virtual address range. The
> function returns the start virtual address of this range if successful, 
> or NULL on failure.
> 
> Implement kimage_unmap_segment() for unmapping segments using vunmap().
> 
> From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Baoquan He <bhe@redhat.com> 
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> ---
>  include/linux/kexec.h |  6 +++++
>  kernel/kexec_core.c   | 54 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index f0e9f8eda7a3..7d6b12f8b8d0 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -467,13 +467,19 @@ extern bool kexec_file_dbg_print;
>  #define kexec_dprintk(fmt, arg...) \
>          do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0)
>  
> +extern void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size);
> +extern void kimage_unmap_segment(void *buffer);
>  #else /* !CONFIG_KEXEC_CORE */
>  struct pt_regs;
>  struct task_struct;
> +struct kimage;
>  static inline void __crash_kexec(struct pt_regs *regs) { }
>  static inline void crash_kexec(struct pt_regs *regs) { }
>  static inline int kexec_should_crash(struct task_struct *p) { return 0; }
>  static inline int kexec_crash_loaded(void) { return 0; }
> +static inline void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size)
> +{ return NULL; }
> +static inline void kimage_unmap_segment(void *buffer) { }
>  #define kexec_in_progress false
>  #endif /* CONFIG_KEXEC_CORE */
>  
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index c0bdc1686154..a5e378e1dc7f 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -867,6 +867,60 @@ int kimage_load_segment(struct kimage *image,
>  	return result;
>  }
>  
> +void *kimage_map_segment(struct kimage *image,
> +			 unsigned long addr, unsigned long size)
> +{
> +	unsigned long src_page_addr, dest_page_addr = 0;
> +	unsigned long eaddr = addr + size;
> +	kimage_entry_t *ptr, entry;
> +	struct page **src_pages;
> +	unsigned int npages;
> +	void *vaddr = NULL;
> +	int i;
> +
> +	/*
> +	 * Collect the source pages and map them in a contiguous VA range.
> +	 */
> +	npages = PFN_UP(eaddr) - PFN_DOWN(addr);
> +	src_pages = kmalloc_array(npages, sizeof(*src_pages), GFP_KERNEL);
> +	if (!src_pages) {
> +		pr_err("Could not allocate ima pages array.\n");
> +		return NULL;
> +	}
> +
> +	i = 0;
> +	for_each_kimage_entry(image, ptr, entry) {
> +		if (entry & IND_DESTINATION) {
> +			dest_page_addr = entry & PAGE_MASK;
> +		} else if (entry & IND_SOURCE) {
> +			if (dest_page_addr >= addr && dest_page_addr < eaddr) {
> +				src_page_addr = entry & PAGE_MASK;
> +				src_pages[i++] =
> +					virt_to_page(__va(src_page_addr));
> +				if (i == npages)
> +					break;
> +				dest_page_addr += PAGE_SIZE;
> +			}
> +		}
> +	}
> +
> +	/* Sanity check. */
> +	WARN_ON(i < npages);
> +
> +	vaddr = vmap(src_pages, npages, VM_MAP, PAGE_KERNEL);
> +	kfree(src_pages);
> +
> +	if (!vaddr)
> +		pr_err("Could not map ima buffer.\n");
> +
> +	return vaddr;
> +}
> +
> +void kimage_unmap_segment(void *segment_buffer)
> +{
> +	vunmap(segment_buffer);
> +}
> +
>  struct kexec_load_limit {
>  	/* Mutex protects the limit count. */
>  	struct mutex mutex;
> -- 
> 2.25.1
> 


