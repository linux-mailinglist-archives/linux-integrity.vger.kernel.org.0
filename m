Return-Path: <linux-integrity+bounces-5651-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E363A7F320
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Apr 2025 05:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C05C3ABEFB
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Apr 2025 03:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80E0253B47;
	Tue,  8 Apr 2025 03:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ec/z5D1O"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5151B3927
	for <linux-integrity@vger.kernel.org>; Tue,  8 Apr 2025 03:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744082298; cv=none; b=XIrpE53mvTGE7547AXoFce2N8gvWqmGOhxrC5daAiRW2S1BBfCkPVaX3dEUHM0JiJYqNQVDQXGy4e2Sud0w3/2HLYIfwKg6kbps1qrj/NVi/+lCiZkVMQI1vtflfQHHSRhUazgMvQQ4QKsv/IftVNZLSV5GWwX3VGuP1ynLBd3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744082298; c=relaxed/simple;
	bh=Y4A9gmRyx+sHzRRPq9DIE+RWZg2MLVTOc6sduDq5MR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkTfboUvbR5AIbd+q66IMsqtFqnQsgkUb49aYkzWvXA9+Z4vRWqi26YWPpu54ahu5rqLq2Za6TGo5xMlL0lly8/x3mQahtWdCzfvW6LRL7e6JOxyR39vTBgOIEluGS8akzNmsL62UqNMund/jKAzcPMqYBatB4WlZvy5JsZ2ab8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ec/z5D1O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744082295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/3QHJqw7QjuOJT2v2ybOfd35jlW4gSpJQ6mV3BXsjyM=;
	b=ec/z5D1OfZ8O9WzvvrGTpq9J2mhax/ni6XF1WsVbJgdEFxeFU0fn8aZX+whtmAbCuGLw1a
	8P9vvzzPZbJpdKCDsD/f/W54djrYUNrUk2T1pVa0AwRcplzkb3ahGitzcN7m5X7/VjCnQq
	inFFOUmvYDy63X9nc/H9fxnXGiQZ8B4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-AWIpHe-hPfqeQRJIIPUO2A-1; Mon,
 07 Apr 2025 23:18:10 -0400
X-MC-Unique: AWIpHe-hPfqeQRJIIPUO2A-1
X-Mimecast-MFC-AGG-ID: AWIpHe-hPfqeQRJIIPUO2A_1744082288
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 876C61809CA5;
	Tue,  8 Apr 2025 03:18:07 +0000 (UTC)
Received: from localhost (unknown [10.72.112.61])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74396180174E;
	Tue,  8 Apr 2025 03:18:05 +0000 (UTC)
Date: Tue, 8 Apr 2025 11:17:55 +0800
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
Subject: Re: [PATCH v11 4/9] ima: kexec: skip IMA segment validation after
 kexec soft reboot
Message-ID: <Z/SVY1j1C7P0rZGI@MiWiFi-R3L-srv>
References: <20250402124725.5601-1-chenste@linux.microsoft.com>
 <20250402124725.5601-5-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402124725.5601-5-chenste@linux.microsoft.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 04/02/25 at 05:47am, steven chen wrote:
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

I would write the patch log like:

======
Currently, the function kexec_calculate_store_digests() calculates and
stores the digest of the segment during the kexec_file_load syscall,
where the  IMA segment is also allocated.

Later, the IMA segment will be updated with the measurement log at the
kexec execute stage when a kexec reboot is initiated. Therefore, the
digests should be updated for the IMA segment in the  normal case. The
problem is that the content of memory segments carried over to the new
kernel during the kexec systemcall can be changed at kexec 'execute'
stage, but the size and the location of the memory segments cannot be
changed at kexec 'execute' stage.

To address this, skip the calculation and storage of the digest for the
IMA segment in kexec_calculate_store_digests() so that it is not added 
to the purgatory_sha_regions.

With this change, the IMA segment is not included in the digest
calculation, storage, and verification.
======

> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Baoquan He <bhe@redhat.com> 
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> ---
>  include/linux/kexec.h              |  3 +++
>  kernel/kexec_file.c                | 22 ++++++++++++++++++++++
>  security/integrity/ima/ima_kexec.c |  3 +++
>  3 files changed, 28 insertions(+)
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
> index b12ac3619b8f..7e0a19c3483f 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -145,6 +145,7 @@ void ima_add_kexec_buffer(struct kimage *image)
>  	kbuf.buffer = kexec_buffer;
>  	kbuf.bufsz = kexec_buffer_size;
>  	kbuf.memsz = kexec_segment_size;
> +	image->is_ima_segment_index_set = false;
>  	ret = kexec_add_buffer(&kbuf);
>  	if (ret) {
>  		pr_err("Error passing over kexec measurement buffer.\n");
> @@ -155,6 +156,8 @@ void ima_add_kexec_buffer(struct kimage *image)
>  	image->ima_buffer_addr = kbuf.mem;
>  	image->ima_buffer_size = kexec_segment_size;
>  	image->ima_buffer = kexec_buffer;
> +	image->ima_segment_index = image->nr_segments - 1;
> +	image->is_ima_segment_index_set = true;
>  
>  	kexec_dprintk("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
>  		      kbuf.mem);
> -- 
> 2.25.1
> 


