Return-Path: <linux-integrity+bounces-5114-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B98CA4FEC4
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 13:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3D9D7A804F
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 12:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BEF244190;
	Wed,  5 Mar 2025 12:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LFoh+lbZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF3F245039
	for <linux-integrity@vger.kernel.org>; Wed,  5 Mar 2025 12:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741178251; cv=none; b=GPBtZGeNJFJo0rISpyhSpUk8K0icbn6BDJel4PyUDmt3fWYf5gyBOAV9vb3VOzSVY92y5zE4g37+Ko5iHTgTaeCvLugtEp8OvbwYpiXl5tu99RjObPlUEtokqK7A/AqbKaJ1iqpJpF098Kuw9X6/v8oCpWBvY/okeZYZzFN0j5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741178251; c=relaxed/simple;
	bh=OtJFU5RFSF/iU9HnbJIYxncMmtViUwvZNHatBwiB638=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIBXpjN1fAAmZ72t6cA1pY1NZPfm2M9tAsHgJIRH9gajvaTnzhfcETHDFhWldpDFGSryUIyNPX5ucUsTz8fr7Kzkh34B4TSBSjSPK91Dw7rLUj2vhjxOS++sc//eBs7ms4hDFFOMKJqzASYVkzScONR+7N3ArOpOR6BrqlIcutY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LFoh+lbZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741178247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EZduhyNOp254MaPFfXIPaYa8kRm3c1WjabQs6DC6fI0=;
	b=LFoh+lbZI+e0hxhg3SWswjQyRkX/N055JjRpXIukizWHdmIZYQ/9oHSIKyU3cqr8IsSPpt
	YqYT4CLw5gZ+Z1gi4fEiDJAmbfBN1Si3uo/iPQG5J2+VrJaaPmFB7WljeYt9JBJY2muzbC
	qrZ4IdfIDuBw+x/jtvTYeu3wFsYPW4A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-149-ibpPt9VsO-iXHgqmpj8QAg-1; Wed,
 05 Mar 2025 07:37:24 -0500
X-MC-Unique: ibpPt9VsO-iXHgqmpj8QAg-1
X-Mimecast-MFC-AGG-ID: ibpPt9VsO-iXHgqmpj8QAg_1741178242
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 77EDD19560A2;
	Wed,  5 Mar 2025 12:37:21 +0000 (UTC)
Received: from localhost (unknown [10.72.112.32])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 46AD2193EFD8;
	Wed,  5 Mar 2025 12:37:18 +0000 (UTC)
Date: Wed, 5 Mar 2025 20:37:13 +0800
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
Subject: Re: [PATCH v9 3/7] ima: kexec: skip IMA segment validation after
 kexec soft reboot
Message-ID: <Z8hFeYKVraybzy10@MiWiFi-R3L-srv>
References: <20250304190351.96975-1-chenste@linux.microsoft.com>
 <20250304190351.96975-4-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304190351.96975-4-chenste@linux.microsoft.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 03/04/25 at 11:03am, steven chen wrote:
> The kexec_calculate_store_digests() function calculates and stores the
> digest of the segment during the kexec_file_load syscall, where the 
> IMA segment is also allocated.
> 
> With this series, the IMA segment will be updated with the measurement 
> log at the kexec execute stage when a soft reboot is initiated. 
> Therefore, the digests should be updated for the IMA segment in the 
> normal case.
> 
> The content of memory segments carried over to the new kernel during the
> kexec systemcall can be changed at kexec 'execute' stage, but the size
> and the location of the memory segments cannot be changed at kexec
> 'execute' stage.
> 
> However, during the kexec execute stage, if kexec_calculate_store_digests()
> API is call to update the digest, it does not reuse the same memory segment
         ~ called
> allocated during the kexec 'load' stage and the new memory segment required
> cannot be transferred/mapped to the new kernel.
> 
> As a result, digest verification will fail in verify_sha256_digest() 
> after a kexec soft reboot into the new kernel. Therefore, the digest
> calculation/verification of the IMA segment needs to be skipped.
> 
> To address this, skip the calculation and storage of the digest for the
> IMA segment in kexec_calculate_store_digests() so that it is not added 
> to the purgatory_sha_regions.
> 
> Since verify_sha256_digest() only verifies 'purgatory_sha_regions',
> no change is needed in verify_sha256_digest() in this context.
> 
> With this change, the IMA segment is not included in the digest
> calculation, storage, and verification.
> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Baoquan He <bhe@redhat.com> 
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  include/linux/kexec.h              |  3 +++
>  kernel/kexec_file.c                | 22 ++++++++++++++++++++++
>  security/integrity/ima/ima_kexec.c |  3 +++
>  3 files changed, 28 insertions(+)

Other than the nit, LGTM.

> 
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 7d6b12f8b8d0..107e726f2ef3 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -362,6 +362,9 @@ struct kimage {
>  
>  	phys_addr_t ima_buffer_addr;
>  	size_t ima_buffer_size;
> +
> +	unsigned long ima_segment_index;
> +	bool is_ima_segment_index_set;
>  #endif
>  
>  	/* Core ELF header buffer */
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 3eedb8c226ad..606132253c79 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -38,6 +38,21 @@ void set_kexec_sig_enforced(void)
>  }
>  #endif
>  
> +#ifdef CONFIG_IMA_KEXEC
> +static bool check_ima_segment_index(struct kimage *image, int i)
> +{
> +	if (image->is_ima_segment_index_set && i == image->ima_segment_index)
> +		return true;
> +	else
> +		return false;
> +}
> +#else
> +static bool check_ima_segment_index(struct kimage *image, int i)
> +{
> +	return false;
> +}
> +#endif
> +
>  static int kexec_calculate_store_digests(struct kimage *image);
>  
>  /* Maximum size in bytes for kernel/initrd files. */
> @@ -764,6 +779,13 @@ static int kexec_calculate_store_digests(struct kimage *image)
>  		if (ksegment->kbuf == pi->purgatory_buf)
>  			continue;
>  
> +		/*
> +		 * Skip the segment if ima_segment_index is set and matches
> +		 * the current index
> +		 */
> +		if (check_ima_segment_index(image, i))
> +			continue;
> +
>  		ret = crypto_shash_update(desc, ksegment->kbuf,
>  					  ksegment->bufsz);
>  		if (ret)
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 6195df128482..0465beca8867 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -169,6 +169,7 @@ void ima_add_kexec_buffer(struct kimage *image)
>  	kbuf.buffer = kexec_buffer;
>  	kbuf.bufsz = kexec_buffer_size;
>  	kbuf.memsz = kexec_segment_size;
> +	image->is_ima_segment_index_set = false;
>  	ret = kexec_add_buffer(&kbuf);
>  	if (ret) {
>  		pr_err("Error passing over kexec measurement buffer.\n");
> @@ -179,6 +180,8 @@ void ima_add_kexec_buffer(struct kimage *image)
>  	image->ima_buffer_addr = kbuf.mem;
>  	image->ima_buffer_size = kexec_segment_size;
>  	image->ima_buffer = kexec_buffer;
> +	image->ima_segment_index = image->nr_segments - 1;
> +	image->is_ima_segment_index_set = true;
>  
>  	/*
>  	 * kexec owns kexec_buffer after kexec_add_buffer() is called
> -- 
> 2.25.1
> 


