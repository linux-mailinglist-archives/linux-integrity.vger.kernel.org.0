Return-Path: <linux-integrity+bounces-5649-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD52AA7F2E3
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Apr 2025 04:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DF5B189917B
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Apr 2025 02:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD622528E9;
	Tue,  8 Apr 2025 02:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VeGSOw4f"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D6625F7A9
	for <linux-integrity@vger.kernel.org>; Tue,  8 Apr 2025 02:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744081120; cv=none; b=sdpnfEAT42Tcn3mBdexGfrhAq67V8fjPFsD60poJ/738IzrfZjmYJGDryqeauo4lV+rPo0eeJShKqORCUZ9wj/8J6uqrvRgJOXMXeEa6RpY5vl30Nu2JBScH17UJId2N40F4JqxPFKSqXXe+djVkqwlhAIbyT+fWHlc1V3s5u2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744081120; c=relaxed/simple;
	bh=7JUffUBNK5M/+Y/oT2ouv6ujQQPH6yKbolK49qymFSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIhuxcm8u1Ccd6QaP4/ald0IsbnDhz4K/h03RsI7zK1uG+wn/CpjL3yc7+lNjEGdDwNlcHkhWWethcBsi20PKqtoD0zydpciVCj28ybQamkYihS8mFpJkGPOBIUboEsWS9lZGEjtC+9rK7bG6hKjyUTdrDUkTbyUs2ReJXhFE/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VeGSOw4f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744081116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kaJaXSVbP57MvATcjgNBp7/OlnZPTiwF4HxV8S9Zb0k=;
	b=VeGSOw4fYH+Bie3vm8tKjUxXMMuk7RH8puzMjIopOmjvld3yWYdZEj0QIDLaJvOD/2Thib
	IeXmv9GibdHYz8HcHX3l9fkDLCiCBJC+I+7AaVdCEEnQsAL6o1ABzJ+euj0zY8qFTqSNLN
	/8cH/hb0ZasqhHAxyCWQlPWhcIlez/8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-mIpEH9ViNumXuntP7aeqvQ-1; Mon,
 07 Apr 2025 22:58:32 -0400
X-MC-Unique: mIpEH9ViNumXuntP7aeqvQ-1
X-Mimecast-MFC-AGG-ID: mIpEH9ViNumXuntP7aeqvQ_1744081110
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 869991955DC6;
	Tue,  8 Apr 2025 02:58:29 +0000 (UTC)
Received: from localhost (unknown [10.72.112.61])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 982FB1801752;
	Tue,  8 Apr 2025 02:58:26 +0000 (UTC)
Date: Tue, 8 Apr 2025 10:58:21 +0800
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
Subject: Re: [PATCH v11 2/9] ima: define and call ima_alloc_kexec_file_buf()
Message-ID: <Z/SQzacXBH5lP4pt@MiWiFi-R3L-srv>
References: <20250402124725.5601-1-chenste@linux.microsoft.com>
 <20250402124725.5601-3-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402124725.5601-3-chenste@linux.microsoft.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 04/02/25 at 05:47am, steven chen wrote:
> In the current implementation, the ima_dump_measurement_list() API is 
> called during the kexec "load" phase, where a buffer is allocated and 
> the measurement records are copied. Due to this, new events added after
> kexec load but before kexec execute are not carried over to the new kernel
> during kexec operation
> 
> To allow the buffer allocation and population to be separated into distinct
> steps, make the function local seq_file "ima_kexec_file" to a file variable.
> 
> Carrying the IMA measurement list across kexec requires allocating a
> buffer and copying the measurement records.  Separate allocating the
> buffer and copying the measurement records into separate functions in
> order to allocate the buffer at kexec 'load' and copy the measurements
> at kexec 'execute'.
> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> ---
>  security/integrity/ima/ima_kexec.c | 46 +++++++++++++++++++++++-------
>  1 file changed, 35 insertions(+), 11 deletions(-)

LGTM,

Acked-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 650beb74346c..b12ac3619b8f 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -15,26 +15,46 @@
>  #include "ima.h"
>  
>  #ifdef CONFIG_IMA_KEXEC
> +static struct seq_file ima_kexec_file;
> +
> +static void ima_free_kexec_file_buf(struct seq_file *sf)
> +{
> +	vfree(sf->buf);
> +	sf->buf = NULL;
> +	sf->size = 0;
> +	sf->read_pos = 0;
> +	sf->count = 0;
> +}
> +
> +static int ima_alloc_kexec_file_buf(size_t segment_size)
> +{
> +	ima_free_kexec_file_buf(&ima_kexec_file);
> +
> +	/* segment size can't change between kexec load and execute */
> +	ima_kexec_file.buf = vmalloc(segment_size);
> +	if (!ima_kexec_file.buf)
> +		return -ENOMEM;
> +
> +	ima_kexec_file.size = segment_size;
> +	ima_kexec_file.read_pos = 0;
> +	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved space */
> +
> +	return 0;
> +}
> +
>  static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>  				     unsigned long segment_size)
>  {
> -	struct seq_file ima_kexec_file;
>  	struct ima_queue_entry *qe;
>  	struct ima_kexec_hdr khdr;
>  	int ret = 0;
>  
>  	/* segment size can't change between kexec load and execute */
> -	ima_kexec_file.buf = vmalloc(segment_size);
>  	if (!ima_kexec_file.buf) {
> -		ret = -ENOMEM;
> -		goto out;
> +		pr_err("Kexec file buf not allocated\n");
> +		return -EINVAL;
>  	}
>  
> -	ima_kexec_file.file = NULL;
> -	ima_kexec_file.size = segment_size;
> -	ima_kexec_file.read_pos = 0;
> -	ima_kexec_file.count = sizeof(khdr);	/* reserved space */
> -
>  	memset(&khdr, 0, sizeof(khdr));
>  	khdr.version = 1;
>  	/* This is an append-only list, no need to hold the RCU read lock */
> @@ -71,8 +91,6 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>  	*buffer_size = ima_kexec_file.count;
>  	*buffer = ima_kexec_file.buf;
>  out:
> -	if (ret == -EINVAL)
> -		vfree(ima_kexec_file.buf);
>  	return ret;
>  }
>  
> @@ -111,6 +129,12 @@ void ima_add_kexec_buffer(struct kimage *image)
>  		return;
>  	}
>  
> +	ret = ima_alloc_kexec_file_buf(kexec_segment_size);
> +	if (ret < 0) {
> +		pr_err("Not enough memory for the kexec measurement buffer.\n");
> +		return;
> +	}
> +
>  	ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
>  				  kexec_segment_size);
>  	if (!kexec_buffer) {
> -- 
> 2.25.1
> 


