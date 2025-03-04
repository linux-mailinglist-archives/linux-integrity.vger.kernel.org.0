Return-Path: <linux-integrity+bounces-5085-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9955AA4F024
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 23:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5BBE7A90C9
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Mar 2025 22:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AFD25D523;
	Tue,  4 Mar 2025 22:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXlroVFN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7499B3597E;
	Tue,  4 Mar 2025 22:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741126987; cv=none; b=YvNnIoaI+gxJOECno4Axw3KNSqkLOgzgD3TsgL3hr4199tCiSYlx+pRF/CIHlUrWziDy/cj+6JFlJrwQ4aGRGE/4ExT8bWhZ7qrOKhVlHCXmOTAJZOhW1QUb47RZC/GWh1jP13VhQGXVFQ5/KDkygG/+k13/kW75/F1HSvtHpi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741126987; c=relaxed/simple;
	bh=EDaTlL8s7EFTKV867gVON4AEWAHqBXSc9SoE/eEN/qU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKX0thEYP7kWKhiO+dL3bwuYzlsDmyWqtF/HEgBfhUz9TIxoRg7EiItteTfhDOD/GP2eReaBDb2x3QfmWILO9w+DtlEo00TQau/3Sacfk81fJ5pjfZxSjTyhUhSJC/jgXxjm+m8VkOjLi2aDduvONYpcYxlL8kUTvBkaXK9nxr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXlroVFN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86B7C4CEE5;
	Tue,  4 Mar 2025 22:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741126987;
	bh=EDaTlL8s7EFTKV867gVON4AEWAHqBXSc9SoE/eEN/qU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QXlroVFNmbNpIfl+8c8IoweltYy9n1VHi8GYmTF3jMAjnINtqhc/TBQwWJCOHwj5q
	 TZb5JTA4lXEYIUO9bVrLimmEN7vbT0T5nfXxb9hQb9tEi0mAwBlgIUYs2yLXWvcmf7
	 C65ZP+HV3CQCW/CZAyeopoFnAbk84kqgJKU+PU4IJFTYc06oOocfGSr1AounpZ6tlW
	 eHROW6ZlbxDOhsPL7tV/PwSKu5Y13b+QNuDMBNzARuSXo6HrOCM8F0ZJ7VkIAkhk09
	 2tj1exuNOTBxF6p6GDNwxPA2ShDRQfndbGom1nCDpSpPnYNjjvJWir37zXTXem/bG0
	 SmGzVBGlTbQrw==
Date: Wed, 5 Mar 2025 00:23:02 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: steven chen <chenste@linux.microsoft.com>
Cc: zohar@linux.ibm.com, stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
	eric.snowberg@oracle.com, ebiederm@xmission.com,
	paul@paul-moore.com, code@tyhicks.com, bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
	James.Bottomley@hansenpartnership.com, bhe@redhat.com,
	vgoyal@redhat.com, dyoung@redhat.com
Subject: Re: [PATCH v9 2/7] kexec: define functions to map and unmap segments
Message-ID: <Z8d9RvRWPOADOgsx@kernel.org>
References: <20250304190351.96975-1-chenste@linux.microsoft.com>
 <20250304190351.96975-3-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304190351.96975-3-chenste@linux.microsoft.com>

On Tue, Mar 04, 2025 at 11:03:46AM -0800, steven chen wrote:
> The content of memory segments carried over to the new kernel during the 
> kexec systemcall can be changed at kexec 'execute' stage, but the size of
> the memory segments cannot be changed at kexec 'execute' stage.
> 
> To copy IMA measurement logs during the kexec operation, IMA needs to 
> allocate memory at the kexec 'load' stage and map the segments to the 
> kimage structure. The mapped address will then be used to copy IMA 
> measurements during the kexec 'execute' stage.
> 
> Currently, the mechanism to map and unmap segments to the kimage 
> structure is not available to subsystems outside of kexec.

How does IMA work with kexec without having this? Just interested
(and confused). 

> 
> Implement kimage_map_segment() to enable IMA to map measurement log list to 
> the kimage structure during kexec 'load' stage.  This function takes a kimage 
> pointer, a memory address, and a size, then gathers the
> source pages within the specified address range, creates an array of page
> pointers, and maps these to a contiguous virtual address range.  The
> function returns the start virtual address of this range if successful, or NULL on
> failure.
> 
> Implement kimage_unmap_segment() for unmapping segments
> using vunmap().
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
> index c0bdc1686154..63e4d16b6023 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -867,6 +867,60 @@ int kimage_load_segment(struct kimage *image,
>  	return result;
>  }
>  
> +void *kimage_map_segment(struct kimage *image,
> +			 unsigned long addr, unsigned long size)
> +{
> +	unsigned long eaddr = addr + size;
> +	unsigned long src_page_addr, dest_page_addr;
> +	unsigned int npages;
> +	struct page **src_pages;
> +	int i;
> +	kimage_entry_t *ptr, entry;
> +	void *vaddr = NULL;
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
> 

BR, Jarkko

