Return-Path: <linux-integrity+bounces-5322-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FD2A6893C
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Mar 2025 11:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F4EC18991AF
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Mar 2025 10:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837B8253F1B;
	Wed, 19 Mar 2025 10:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NOdYDETQ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436F5253B50
	for <linux-integrity@vger.kernel.org>; Wed, 19 Mar 2025 10:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742379401; cv=none; b=DgRO5J7fzUnZMr7BXW/PIAggVYN32vonA8ih8NMAQUp0PCjll7XTIoOA8l/zbKGV+TLSGQQA7xaesFggJIxRGeh+xWAbAp4df71kYMq0paTjObZrAKtWvLY3ncvB29YEhDvk9ESqmSUVsmZ5LneZ46+ThSdE09iwLiKKNMjrt/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742379401; c=relaxed/simple;
	bh=UCaVgJy/DNw1vtpwVDODnIzZxVUiK38/IMUe0FvmJec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WoKajxcz/bcuQJvXuOxprZrFjLxOO1HdtfksJ3AhfrhmTfMVc/gEx9DlQ2gI2B35+0Rvsazw4LwUZPjYNUUyu41ZRsfXn/QxZPzSwA+aCh5soHi4GvVfKqkm7zfIHJy9SGKCfwUN/V5S19NlBy/ctMyoYq4l+NT9bEeUpvcO9Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NOdYDETQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742379397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dp8VU/SCWRwVp8kB15++yu9BYimqEEC2BvbtYj7rnoo=;
	b=NOdYDETQSeuVEUgJIkdcCRmr365aQOTl9kXP35Zvo/Hj4nULV6SWIUpg95RVe2AasCBtkC
	Ll5X7HKfBe0SdCsr1mgzYR4UAkEL9fuBfYs1RDOkQkCrJ74joK44/JUXA9fY/IsAIZmaCJ
	7uQtf7ZUJ8oeRxxe/abCRAEV9EBZ8e8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-463-sEFPcyY_MxyO6Atw7jxUSg-1; Wed,
 19 Mar 2025 06:16:33 -0400
X-MC-Unique: sEFPcyY_MxyO6Atw7jxUSg-1
X-Mimecast-MFC-AGG-ID: sEFPcyY_MxyO6Atw7jxUSg_1742379391
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C8E941809CA3;
	Wed, 19 Mar 2025 10:16:30 +0000 (UTC)
Received: from localhost (unknown [10.72.112.30])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC6021800946;
	Wed, 19 Mar 2025 10:16:28 +0000 (UTC)
Date: Wed, 19 Mar 2025 18:16:23 +0800
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
Subject: Re: [PATCH v10 4/8] ima: kexec: skip IMA segment validation after
 kexec soft reboot
Message-ID: <Z9qZd/d9h6d4bTHH@MiWiFi-R3L-srv>
References: <20250318010448.954-1-chenste@linux.microsoft.com>
 <20250318010448.954-5-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318010448.954-5-chenste@linux.microsoft.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 03/17/25 at 06:04pm, steven chen wrote:
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
> API is called to update the digest, it does not reuse the same memory
> segment allocated during the kexec 'load' stage and the new memory segment
> required cannot be transferred/mapped to the new kernel.
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

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

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
> index 45170e283272..34020b1513b0 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -168,6 +168,7 @@ void ima_add_kexec_buffer(struct kimage *image)
>  	kbuf.buffer = kexec_buffer;
>  	kbuf.bufsz = kexec_buffer_size;
>  	kbuf.memsz = kexec_segment_size;
> +	image->is_ima_segment_index_set = false;
>  	ret = kexec_add_buffer(&kbuf);
>  	if (ret) {
>  		pr_err("Error passing over kexec measurement buffer.\n");
> @@ -178,6 +179,8 @@ void ima_add_kexec_buffer(struct kimage *image)
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


