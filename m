Return-Path: <linux-integrity+bounces-7602-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEEEC3F2E7
	for <lists+linux-integrity@lfdr.de>; Fri, 07 Nov 2025 10:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6833934CEC5
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Nov 2025 09:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0EC3019CD;
	Fri,  7 Nov 2025 09:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MamJMQe/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A963043C0
	for <linux-integrity@vger.kernel.org>; Fri,  7 Nov 2025 09:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762508069; cv=none; b=TGsGYnyL4+HLmBi2to24/up4iCRZt/MKBuhpN+sRjyN27gCUJxoaFfDl1di85B5OlOtKq3rmwm8DptsfdgquGB56Kq3M8pgB9ZE3CSJmZdkdFGBwNHmJ3C7LPb5MVlKcC+MyssfVDD4jmecoiA1IY8B5GUm95UhEMAbFKHYpa/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762508069; c=relaxed/simple;
	bh=jONhB0lm/GT3rsq3Vq5lYaB+YtGIFgri0uxw1CbltP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oZubXc6zy5cpJuWksOa59TSMCppIPXuekUotsWPU/8LINU0H48uQJYlgttC8PkfhfRCfVs01Iem4tPR1khoPU5pdKke080aevsXJojxBbbJf49k8yyuy8LpXK84JFOQzUSjswF8jW2nJV6un4aLdtjka8SUMfSOpS1X3jG7BRHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MamJMQe/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762508066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZOsWva3fGpX5t38JbJQnotyoTQSLPIQg5IlEqD9ldoU=;
	b=MamJMQe/ujDbdL+A7ITS0otgJTmTVZyUPCVvfxSqajKpXgpnVZflhhsNjL1x87iE1IbeCj
	bMXh/uaPVByhc8mIbBYLZ/Ta0f1/wCig0Z9rC7T2GcRGpq4bszM+Jirw/zcDY0z04TiotB
	YuhxhverK76DKY0pi+ka+7R9DaPsJrw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-QQajzvzhO2Kq7C04dCd4KA-1; Fri,
 07 Nov 2025 04:34:23 -0500
X-MC-Unique: QQajzvzhO2Kq7C04dCd4KA-1
X-Mimecast-MFC-AGG-ID: QQajzvzhO2Kq7C04dCd4KA_1762508062
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E343180035F;
	Fri,  7 Nov 2025 09:34:21 +0000 (UTC)
Received: from localhost (unknown [10.72.112.190])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D2A1D19560A7;
	Fri,  7 Nov 2025 09:34:19 +0000 (UTC)
Date: Fri, 7 Nov 2025 17:34:15 +0800
From: Baoquan He <bhe@redhat.com>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, linux-integrity@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Alexander Graf <graf@amazon.com>,
	Steven Chen <chenste@linux.microsoft.com>, stable@vger.kernel.org
Subject: Re: [PATCHv2 2/2] kernel/kexec: Fix IMA when allocation happens in
 CMA area
Message-ID: <aQ29F90I5FIgxmyr@MiWiFi-R3L-srv>
References: <20251106065904.10772-1-piliu@redhat.com>
 <20251106065904.10772-2-piliu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106065904.10772-2-piliu@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 11/06/25 at 02:59pm, Pingfan Liu wrote:
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
> Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Alexander Graf <graf@amazon.com>
> Cc: Steven Chen <chenste@linux.microsoft.com>
> Cc: linux-integrity@vger.kernel.org
> Cc: <stable@vger.kernel.org>
> To: kexec@lists.infradead.org
> ---
> v1 -> v2:
> return page_address(page) instead of *page
> 
>  kernel/kexec_core.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index 9a1966207041..332204204e53 100644
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
> +	if (cma)
> +		return page_address(cma);

This judgement can be put above the addr/size/eaddr assignment lines?

If you agree, maybe you can update the patch log by adding more details
to explain the root cause so that people can understand it easier.

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


