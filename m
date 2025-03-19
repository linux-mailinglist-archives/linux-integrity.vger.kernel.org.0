Return-Path: <linux-integrity+bounces-5321-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B6EA68929
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Mar 2025 11:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CFE3189B682
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Mar 2025 10:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E461F4CBE;
	Wed, 19 Mar 2025 10:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kc6GxXNy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05689253337
	for <linux-integrity@vger.kernel.org>; Wed, 19 Mar 2025 10:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742379163; cv=none; b=fy+V7JB16Z/OGqV6txTpK+47eh+YTnw218f+TwZySj+ebO7wkvpzGpULfAGEs3zYC0nDKHlEjInUBaYUYNrtuOlXCQ3MJGMFvyN3gTXZL3n35PLxmwuZcD/F2bcx2IQttXf7ECak1QSlimUrMZZdwF6QIA1Nc9c6Xdb6TZuyxig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742379163; c=relaxed/simple;
	bh=wtmymb4r18DBwzgMiXb2ncem7nrBjLwTn9pNYeQCZXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUifRrVsCwCj7hGfj1s1TZxL34v2FlqJ8IPsNTadOuJf0xTTZqPlnCiln05+N3d51w2j9BKSHQvOdLKAO2Hb7xy0K/y/SPjVypxv2lwUcwvKbt3VU8us7dsVQSsHJ5lnh023cYsK2KRk4APLDYj7ivpya7umsJv67Fo3qO+7uHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kc6GxXNy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742379160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nyrQ69Ih495D1dgtb4loaIIF309AdjN+SDwQz13P988=;
	b=Kc6GxXNy5rY3WrASCdExRGjhENk0ySfxJ3JEiMj8EZBLTUxslB7rq9LtLnSTNaOo27/p5m
	trAFDyOWby69FB6iboZCbtmYspwULMK8cR6wF24TpCdYefEL4waUGRThyd9T4cjkOlaaGK
	k3jyCarTzOiq30H/3Y/DKJI18hUX6hc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-60-UQDTJZ7_ObixN70czgvFuw-1; Wed,
 19 Mar 2025 06:12:35 -0400
X-MC-Unique: UQDTJZ7_ObixN70czgvFuw-1
X-Mimecast-MFC-AGG-ID: UQDTJZ7_ObixN70czgvFuw_1742379153
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 136611809CA6;
	Wed, 19 Mar 2025 10:12:32 +0000 (UTC)
Received: from localhost (unknown [10.72.112.30])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1B1961955DCD;
	Wed, 19 Mar 2025 10:12:28 +0000 (UTC)
Date: Wed, 19 Mar 2025 18:12:23 +0800
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
Subject: Re: [PATCH v10 3/8] kexec: define functions to map and unmap segments
Message-ID: <Z9qYh0vkhvy+FhDt@MiWiFi-R3L-srv>
References: <20250318010448.954-1-chenste@linux.microsoft.com>
 <20250318010448.954-4-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318010448.954-4-chenste@linux.microsoft.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 03/17/25 at 06:04pm, steven chen wrote:
> Currently, the kernel behavior during kexec load is to fetch the IMA
> measurements log from TPM PCRs and store it in a buffer. When a kexec 
> reboot is triggered, this stored log buffer is carried over to the second
> kernel. However, the time gap between kexec load and kexec reboot can be
> very long. During this time window, new events extended into TPM PCRs miss
> the chance to be carried over to the second kernel. This results in a 
> mismatch between TPM PCR quotes and the actual IMA measurements list after
> kexec reboot, leading to remote attestation failure.
> 
> To solve this problem, the new design defers reading TPM PCRs content into
> the kexec buffer to the kexec reboot phase, while still allocating the
> necessary buffer at kexec load time because it is not appropriate to
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
> ---
>  include/linux/kexec.h |  6 +++++
>  kernel/kexec_core.c   | 54 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+)

The log is a little verbose, otherwise it looks good to me.

Acked-by: Baoquan He <bhe@redhat.com>

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


