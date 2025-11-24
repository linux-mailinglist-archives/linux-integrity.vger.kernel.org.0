Return-Path: <linux-integrity+bounces-7669-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 402A2C82A2C
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Nov 2025 23:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E35F14E1189
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Nov 2025 22:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70FF31A3160;
	Mon, 24 Nov 2025 22:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="U3kJ8b5N"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350E238D;
	Mon, 24 Nov 2025 22:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764022583; cv=none; b=MLDYFR7yD2mY3o9TF/Wk2mfVLUGOmvd7cDY+6KGFYiirx3v2oaGdiSp73IcLz6SpdriPRKgWf+s91pIW4uimbFugUEiN+cpYmGD3yELksi82U9zJvSdPRW8TGQLbVnQjqt2NRfF3DfpjDEL6COp08aU2hDCUSUVwV7r26wgEXkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764022583; c=relaxed/simple;
	bh=GOp5yKMHo3eVqVHkrd/G0zl12EV/VQsYrfuHXNZh7kw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=a8D6SW7/71nbwlCBbdYl1gTiIsAMGsDrmcbykZM6qamiGnbqJXjF/JRpiOlIY/E4rghV1hnrRux8JfdogR2ZjPKNkmIBFvvfZUbMcqO2PWPQh+S8cvVPOC8xYa+xK/eA8Tu1mhVgT3KWmGmjFEZOnbF3AUicCQa8iiyGGUTUIPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=U3kJ8b5N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D140C4CEF1;
	Mon, 24 Nov 2025 22:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1764022581;
	bh=GOp5yKMHo3eVqVHkrd/G0zl12EV/VQsYrfuHXNZh7kw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U3kJ8b5NBNgEEd9LwD3J5j7xvNlg6icnkz9UTERPiTHQbfDUqBzNaYwZRCBzYEzQ6
	 tEnjHRl3aTn3d5PHcT+RXVM0jF11hvwHNtPa9C4lmwkYHS/LzYbKg8n7PsvmDjvk6m
	 fuixOeQ4QvOLSYTI8rmM4wkrCvlj4b9gly9K+UGU=
Date: Mon, 24 Nov 2025 14:16:20 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, linux-integrity@vger.kernel.org, Baoquan He
 <bhe@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>, Alexander Graf <graf@amazon.com>, Steven Chen
 <chenste@linux.microsoft.com>, stable@vger.kernel.org
Subject: Re: [PATCHv2 1/2] kernel/kexec: Change the prototype of
 kimage_map_segment()
Message-Id: <20251124141620.eaef984836fe2edc7acf9179@linux-foundation.org>
In-Reply-To: <20251106065904.10772-1-piliu@redhat.com>
References: <20251106065904.10772-1-piliu@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Nov 2025 14:59:03 +0800 Pingfan Liu <piliu@redhat.com> wrote:

> The kexec segment index will be required to extract the corresponding
> information for that segment in kimage_map_segment(). Additionally,
> kexec_segment already holds the kexec relocation destination address and
> size. Therefore, the prototype of kimage_map_segment() can be changed.

Could we please have some reviewer input on thee two patches?

Thanks.

(Pingfan, please cc linux-kernel on patches - it's where people go to
find emails on lists which they aren't suscribed to)

(akpm goes off and subscribes to kexec@)

> Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Cc: Roberto Sassu <roberto.sassu@huawei.com>
> Cc: Alexander Graf <graf@amazon.com>
> Cc: Steven Chen <chenste@linux.microsoft.com>
> Cc: <stable@vger.kernel.org>
> To: kexec@lists.infradead.org
> To: linux-integrity@vger.kernel.org
> ---
>  include/linux/kexec.h              | 4 ++--
>  kernel/kexec_core.c                | 9 ++++++---
>  security/integrity/ima/ima_kexec.c | 4 +---
>  3 files changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index ff7e231b0485..8a22bc9b8c6c 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -530,7 +530,7 @@ extern bool kexec_file_dbg_print;
>  #define kexec_dprintk(fmt, arg...) \
>          do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0)
>  
> -extern void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size);
> +extern void *kimage_map_segment(struct kimage *image, int idx);
>  extern void kimage_unmap_segment(void *buffer);
>  #else /* !CONFIG_KEXEC_CORE */
>  struct pt_regs;
> @@ -540,7 +540,7 @@ static inline void __crash_kexec(struct pt_regs *regs) { }
>  static inline void crash_kexec(struct pt_regs *regs) { }
>  static inline int kexec_should_crash(struct task_struct *p) { return 0; }
>  static inline int kexec_crash_loaded(void) { return 0; }
> -static inline void *kimage_map_segment(struct kimage *image, unsigned long addr, unsigned long size)
> +static inline void *kimage_map_segment(struct kimage *image, int idx)
>  { return NULL; }
>  static inline void kimage_unmap_segment(void *buffer) { }
>  #define kexec_in_progress false
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index fa00b239c5d9..9a1966207041 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -960,17 +960,20 @@ int kimage_load_segment(struct kimage *image, int idx)
>  	return result;
>  }
>  
> -void *kimage_map_segment(struct kimage *image,
> -			 unsigned long addr, unsigned long size)
> +void *kimage_map_segment(struct kimage *image, int idx)
>  {
> +	unsigned long addr, size, eaddr;
>  	unsigned long src_page_addr, dest_page_addr = 0;
> -	unsigned long eaddr = addr + size;
>  	kimage_entry_t *ptr, entry;
>  	struct page **src_pages;
>  	unsigned int npages;
>  	void *vaddr = NULL;
>  	int i;
>  
> +	addr = image->segment[idx].mem;
> +	size = image->segment[idx].memsz;
> +	eaddr = addr + size;
> +
>  	/*
>  	 * Collect the source pages and map them in a contiguous VA range.
>  	 */
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 7362f68f2d8b..5beb69edd12f 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -250,9 +250,7 @@ void ima_kexec_post_load(struct kimage *image)
>  	if (!image->ima_buffer_addr)
>  		return;
>  
> -	ima_kexec_buffer = kimage_map_segment(image,
> -					      image->ima_buffer_addr,
> -					      image->ima_buffer_size);
> +	ima_kexec_buffer = kimage_map_segment(image, image->ima_segment_index);
>  	if (!ima_kexec_buffer) {
>  		pr_err("Could not map measurements buffer.\n");
>  		return;
> -- 
> 2.49.0

