Return-Path: <linux-integrity+bounces-5112-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7679CA4FE92
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 13:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EAB3188BA51
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 12:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6116D245013;
	Wed,  5 Mar 2025 12:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wuwu8N3+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0454E242914
	for <linux-integrity@vger.kernel.org>; Wed,  5 Mar 2025 12:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741177512; cv=none; b=HtTagwqx+a6f7jgabZy/Z84oxxG9R8uYXdguOh6eIm10TXazChcMnrV/+OUqngWtR13r9f8HPNLgRpAgbbjlhuSrnreZ4xqS/8/+N99yZuP+MJGO7MYlAfIMcWQyW0kqsRKW7SvlaehdfnYqygmiUjlxEZ/hIfUhFZnFhOSa1xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741177512; c=relaxed/simple;
	bh=Px/vxW2uPs3Z0ChG8nGEHjgU16iGwVKigCn31vAejIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BURINFd5MRpjlRoYBkwl+k7iwSmC0NWQ7G7FuFMDs2ZuYo+od03BZmjuTyTAGbB3ig+jeHaVMIQAbPRoXNdJGlEAajqTvg2Zhw8ZkXGvUR88Q0Ut9KdeQ2dujmCptQK1o5M+7lVsI6DZRts7vy2SevAw/69Vh6Ll72+UozcgLEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wuwu8N3+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741177509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nPD0UOTEO7BZdukD/bAEu6xyXvJzP0L9ZegfMly/jBo=;
	b=Wuwu8N3+rP1DIAci0zoZ6wcq5wHaVdWvCT8Ij37hg6KfOwr/k4KF6jJLkGJaWLjNkX6KyG
	fWu1cQ+rg6JXB5W/PmJD9QlLRQbfDINoJrzQSw2KGAScvid1IKXeNxLjg7eaNGl40g5Ph0
	5bXHAmEhPT5lPMSSJ/9HTxkc2+vs+BM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-Yx81Eq4iOCWRfZEs9r8sNg-1; Wed,
 05 Mar 2025 07:25:05 -0500
X-MC-Unique: Yx81Eq4iOCWRfZEs9r8sNg-1
X-Mimecast-MFC-AGG-ID: Yx81Eq4iOCWRfZEs9r8sNg_1741177503
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 142091800DB3;
	Wed,  5 Mar 2025 12:25:03 +0000 (UTC)
Received: from localhost (unknown [10.72.112.32])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D4A091954B32;
	Wed,  5 Mar 2025 12:25:00 +0000 (UTC)
Date: Wed, 5 Mar 2025 20:24:55 +0800
From: Baoquan He <bhe@redhat.com>
To: steven chen <chenste@linux.microsoft.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, zohar@linux.ibm.com,
	stefanb@linux.ibm.com, roberto.sassu@huaweicloud.com,
	roberto.sassu@huawei.com, eric.snowberg@oracle.com,
	ebiederm@xmission.com, paul@paul-moore.com, code@tyhicks.com,
	bauermann@kolabnow.com, linux-integrity@vger.kernel.org,
	kexec@lists.infradead.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, madvenka@linux.microsoft.com,
	nramas@linux.microsoft.com, James.Bottomley@hansenpartnership.com,
	vgoyal@redhat.com, dyoung@redhat.com
Subject: Re: [PATCH v9 2/7] kexec: define functions to map and unmap segments
Message-ID: <Z8hCl4piQ1Sfpi7h@MiWiFi-R3L-srv>
References: <20250304190351.96975-1-chenste@linux.microsoft.com>
 <20250304190351.96975-3-chenste@linux.microsoft.com>
 <Z8d9RvRWPOADOgsx@kernel.org>
 <97c27a30-a5ee-4825-ab7e-82dcddedd688@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97c27a30-a5ee-4825-ab7e-82dcddedd688@linux.microsoft.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 03/04/25 at 04:55pm, steven chen wrote:
> On 3/4/2025 2:23 PM, Jarkko Sakkinen wrote:
> > On Tue, Mar 04, 2025 at 11:03:46AM -0800, steven chen wrote:
> > > The content of memory segments carried over to the new kernel during the
> > > kexec systemcall can be changed at kexec 'execute' stage, but the size of
> > > the memory segments cannot be changed at kexec 'execute' stage.
> > > 
> > > To copy IMA measurement logs during the kexec operation, IMA needs to
> > > allocate memory at the kexec 'load' stage and map the segments to the
> > > kimage structure. The mapped address will then be used to copy IMA
> > > measurements during the kexec 'execute' stage.
> > > 
> > > Currently, the mechanism to map and unmap segments to the kimage
> > > structure is not available to subsystems outside of kexec.
> > How does IMA work with kexec without having this? Just interested
> > (and confused).
> Currently, all IMA-related operations during a soft reboot, such as memory
> allocation and IMA log list copy, are handled in the kexec 'load' stage, so
> the map/unmap mechanism is not required.
> 
> The new design separates these two operations into different stages: memory
> allocation remains in the kexec 'load' stage, while the IMA log list copy is
> moved to the kexec 'execute' stage. Therefore, the map/unmap mechanism is
> introduced.

I think the log can be improved. About the found problem and solution
part, we possible can describe them like below:

===
Currently, the kernel behaviour of kexec load is the IMA measurements
log is fetched from TPM PCRs and stored into buffer and hold. When
kexec reboot is triggered, the stored log buffer is carried over to the
2nd kernel. However, the time gap between kexec load and kexec reboot
could be very long. Then those new events extended into TPM PCRs during
the time window misses the chance to be carried over to 2nd kernel. This
results in mismatch between TPM PCR quotes and the actual IMA measurements
list after kexec reboot, which in turn results in remote attestation
failure.

To solve this problem, the new design is to defer the reading TPM PCRs
content out into kexec buffer to kexec reboot phase. While still
allocating the necessary buffer at kexec load time because it's not
appropriate to allocate memory at kexec reboot moment.
===

It may still need be improved, just for your reference. You can change
and add more detail needed and add them into your log.

> 
> Please refer to "[PATCH v9 0/7] ima: kexec: measure events between kexec
> load and execute" for the reason why to add this.
> 
> Steven
> 
> > > Implement kimage_map_segment() to enable IMA to map measurement log list to
> > > the kimage structure during kexec 'load' stage.  This function takes a kimage
> > > pointer, a memory address, and a size, then gathers the
> > > source pages within the specified address range, creates an array of page
> > > pointers, and maps these to a contiguous virtual address range.  The
> > > function returns the start virtual address of this range if successful, or NULL on
> > > failure.
> > > 
> > > Implement kimage_unmap_segment() for unmapping segments
> > > using vunmap().
> > > 
> > > From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> > > Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> > > Cc: Eric Biederman <ebiederm@xmission.com>
> > > Cc: Baoquan He <bhe@redhat.com>
> > > Cc: Vivek Goyal <vgoyal@redhat.com>
> > > Cc: Dave Young <dyoung@redhat.com>
> > > Signed-off-by: steven chen <chenste@linux.microsoft.com>
> > > ---
> > >   include/linux/kexec.h |  6 +++++
> > >   kernel/kexec_core.c   | 54 +++++++++++++++++++++++++++++++++++++++++++
> > >   2 files changed, 60 insertions(+)
> > > 
> > > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > > index f0e9f8eda7a3..7d6b12f8b8d0 100644
> > > --- a/include/linux/kexec.h
> > > +++ b/include/linux/kexec.h
> > > @@ -467,13 +467,19 @@ extern bool kexec_file_dbg_print;
> > >   #define kexec_dprintk(fmt, arg...) \
> > >           do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0)
> > > +extern void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size);
> > > +extern void kimage_unmap_segment(void *buffer);
> > >   #else /* !CONFIG_KEXEC_CORE */
> > >   struct pt_regs;
> > >   struct task_struct;
> > > +struct kimage;
> > >   static inline void __crash_kexec(struct pt_regs *regs) { }
> > >   static inline void crash_kexec(struct pt_regs *regs) { }
> > >   static inline int kexec_should_crash(struct task_struct *p) { return 0; }
> > >   static inline int kexec_crash_loaded(void) { return 0; }
> > > +static inline void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size)
> > > +{ return NULL; }
> > > +static inline void kimage_unmap_segment(void *buffer) { }
> > >   #define kexec_in_progress false
> > >   #endif /* CONFIG_KEXEC_CORE */
> > > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > > index c0bdc1686154..63e4d16b6023 100644
> > > --- a/kernel/kexec_core.c
> > > +++ b/kernel/kexec_core.c
> > > @@ -867,6 +867,60 @@ int kimage_load_segment(struct kimage *image,
> > >   	return result;
> > >   }
> > > +void *kimage_map_segment(struct kimage *image,
> > > +			 unsigned long addr, unsigned long size)
> > > +{
> > > +	unsigned long eaddr = addr + size;
> > > +	unsigned long src_page_addr, dest_page_addr;
> > > +	unsigned int npages;
> > > +	struct page **src_pages;
> > > +	int i;
> > > +	kimage_entry_t *ptr, entry;
> > > +	void *vaddr = NULL;

When adding a new function, it's suggested to take the reverse xmas tree
style for local variable ordering usually.

> > > +
> > > +	/*
> > > +	 * Collect the source pages and map them in a contiguous VA range.
> > > +	 */
> > > +	npages = PFN_UP(eaddr) - PFN_DOWN(addr);
> > > +	src_pages = kmalloc_array(npages, sizeof(*src_pages), GFP_KERNEL);
> > > +	if (!src_pages) {
> > > +		pr_err("Could not allocate ima pages array.\n");
> > > +		return NULL;
> > > +	}
> > > +
> > > +	i = 0;
> > > +	for_each_kimage_entry(image, ptr, entry) {
> > > +		if (entry & IND_DESTINATION) {
> > > +			dest_page_addr = entry & PAGE_MASK;
> > > +		} else if (entry & IND_SOURCE) {
> > > +			if (dest_page_addr >= addr && dest_page_addr < eaddr) {
> > > +				src_page_addr = entry & PAGE_MASK;
> > > +				src_pages[i++] =
> > > +					virt_to_page(__va(src_page_addr));
> > > +				if (i == npages)
> > > +					break;
> > > +				dest_page_addr += PAGE_SIZE;
> > > +			}
> > > +		}
> > > +	}
> > > +
> > > +	/* Sanity check. */
> > > +	WARN_ON(i < npages);
> > > +
> > > +	vaddr = vmap(src_pages, npages, VM_MAP, PAGE_KERNEL);
> > > +	kfree(src_pages);
> > > +
> > > +	if (!vaddr)
> > > +		pr_err("Could not map ima buffer.\n");
> > > +
> > > +	return vaddr;
> > > +}
> > > +
> > > +void kimage_unmap_segment(void *segment_buffer)
> > > +{
> > > +	vunmap(segment_buffer);
> > > +}
> > > +
> > >   struct kexec_load_limit {
> > >   	/* Mutex protects the limit count. */
> > >   	struct mutex mutex;
> > > -- 
> > > 2.25.1
> > > 
> > > 
> > BR, Jarkko
> 
> 


