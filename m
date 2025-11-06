Return-Path: <linux-integrity+bounces-7580-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6CEC38C95
	for <lists+linux-integrity@lfdr.de>; Thu, 06 Nov 2025 03:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 26127348D9E
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Nov 2025 02:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CC01E32D6;
	Thu,  6 Nov 2025 02:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPb0dlsU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3093942AB7
	for <linux-integrity@vger.kernel.org>; Thu,  6 Nov 2025 02:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762394651; cv=none; b=jdNIoZxuWvhDHnqKbZEnOKsRNtHGe7SZXZ3e36kB2sWeYUYb25oLc0WDowkTpBUDPsun33ZLV+wL6wWCGbcR7XMc92WcmGntot9CqDrInUNCjJOwQUCdeXjHriyG48pwfBqdBGUAgUQNt5TVgguXVegpMpEQ+Lm4hCRpbjwOXk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762394651; c=relaxed/simple;
	bh=MxFRIijbwwwqY7jae0mw/rt0oQh7LPw0Oxbj80saWag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBAj8HJWO58MiXrfSuCcZNGD4YkcgkKvqoWP9N1PfkJ4qnU/HvHkI111yjF/4yOGPIGK8HLkS8M/rLPwovK54GIh9zwApcYnN0ty1QmOqUVGBY17CszNbdXZtVygqN05bNXZ7zvLkv/oBryFYe+dLEnmRB7nK+C35QE4KpBmPsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LPb0dlsU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762394648;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bi1oZ9b9KICH6yCndcUItjcgOah5Ou2mXDzArlJhWmw=;
	b=LPb0dlsUGnu/0swv5KvptCz3sM8idj2bTMlIAjS7rzhUURLC2+JH+qg+kleVom1JwoAr6X
	7eLH08E8GvmRwaJDbJlueL41HRuviyTxxzN6VRIXYF2EatWC+ICdBK6LyCzGqpKFTiGwst
	OW74eASYdhwa7azpBpK3GA+pDx5C5+E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-fwnul_InMrG02t2eV_gtaQ-1; Wed,
 05 Nov 2025 21:04:04 -0500
X-MC-Unique: fwnul_InMrG02t2eV_gtaQ-1
X-Mimecast-MFC-AGG-ID: fwnul_InMrG02t2eV_gtaQ_1762394643
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E5BDE19560A2;
	Thu,  6 Nov 2025 02:04:02 +0000 (UTC)
Received: from localhost (unknown [10.72.112.190])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5D1E81956095;
	Thu,  6 Nov 2025 02:04:00 +0000 (UTC)
Date: Thu, 6 Nov 2025 10:03:56 +0800
From: Baoquan He <bhe@redhat.com>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, linux-integrity@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Alexander Graf <graf@amazon.com>,
	Steven Chen <chenste@linux.microsoft.com>
Subject: Re: [PATCH 2/2] kernel/kexec: Fix IMA when allocation happens in CMA
 area
Message-ID: <aQwCDMhidg+a2Jzt@MiWiFi-R3L-srv>
References: <20251105130922.13321-1-piliu@redhat.com>
 <20251105130922.13321-2-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105130922.13321-2-piliu@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Pingfan,

On 11/05/25 at 09:09pm, Pingfan Liu wrote:
> When I tested kexec with the latest kernel, I ran into the following warning:
> 
> [   40.712410] ------------[ cut here ]------------
> [   40.712576] WARNING: CPU: 2 PID: 1562 at kernel/kexec_core.c:1001 kimage_map_segment+0x144/0x198
> [...]
> [   40.816047] Call trace:
> [   40.818498]  kimage_map_segment+0x144/0x198 (P)
> [   40.823221]  ima_kexec_post_load+0x58/0xc0
> [   40.827246]  __do_sys_kexec_file_load+0x29c/0x368
> [...]
> [   40.855423] ---[ end trace 0000000000000000 ]---
> 
> This is caused by the fact that kexec allocates the destination directly
> in the CMA area. In that case, the CMA kernel address should be exported
> directly to the IMA component, instead of using the vmalloc'd address.
> 
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Alexander Graf <graf@amazon.com>
> Cc: Steven Chen <chenste@linux.microsoft.com>
> Cc: linux-integrity@vger.kernel.org
> To: kexec@lists.infradead.org
> ---
>  kernel/kexec_core.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 9a1966207041..abe40286a02c 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -967,6 +967,7 @@ void *kimage_map_segment(struct kimage *image, int idx)
>  	kimage_entry_t *ptr, entry;
>  	struct page **src_pages;
>  	unsigned int npages;
> +	struct page *cma;
>  	void *vaddr = NULL;
>  	int i;
>  
> @@ -974,6 +975,9 @@ void *kimage_map_segment(struct kimage *image, int idx)
>  	size = image->segment[idx].memsz;
>  	eaddr = addr + size;
>  
> +	cma = image->segment_cma[idx];

Thanks for your fix. But I totally can't get what you are doing. The idx
passed into kimage_map_segment() could index image->segment[], and can
index image->segment_cma[], could you reconsider and make the code more
reasonable?

> +	if (cma)
> +		return cma;
>  	/*
>  	 * Collect the source pages and map them in a contiguous VA range.
>  	 */
> @@ -1014,7 +1018,8 @@ void *kimage_map_segment(struct kimage *image, int idx)
>  
>  void kimage_unmap_segment(void *segment_buffer)
>  {
> -	vunmap(segment_buffer);
> +	if (is_vmalloc_addr(segment_buffer))
> +		vunmap(segment_buffer);
>  }
>  
>  struct kexec_load_limit {
> -- 
> 2.49.0
> 


