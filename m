Return-Path: <linux-integrity+bounces-5320-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33471A6866B
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Mar 2025 09:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EF49189E72B
	for <lists+linux-integrity@lfdr.de>; Wed, 19 Mar 2025 08:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14ECD2505AA;
	Wed, 19 Mar 2025 08:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VLQF/fvY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96576211484
	for <linux-integrity@vger.kernel.org>; Wed, 19 Mar 2025 08:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742371778; cv=none; b=Z66o85Vm9eLTiHX5/A3y2h5Ii+f3LOFerdkfmeLAtGCKe5pm2oUip8rc9uI/USyZ/jkKCulOf3CpvOINUKP8JbhdxZkNO2/X47oma9Gz9tnHAAxD+/ehvvvKQ0DwsU/8KjKy5Mdf8qg3yDv0EKIDZ2vnyp/BNUTgx5ryXEwJ6bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742371778; c=relaxed/simple;
	bh=/RyUaNE0UU+t49cR7Ub3ihRvxXSjG6lxTyyoBfxdah0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hh2V6upkeVkgBy6iSmPtx2S2cbpvjRG3UH/bQ4uKU15kjXdxOAbLV7nrV/mRU7h9F/EgjVZQbfAOdUK56+0SlESBg1hvNKv39kTLdHBLAmPSlbDjnB07j19jRXFVd5WsvSSfAgODntYmKmwpQ8Aawi0M51HEN7nQYzL9vs4wwH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VLQF/fvY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742371774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=da3J5jJT52UU43EbiSqWzdE0F7xr9cBU/xSV0I+jpPU=;
	b=VLQF/fvYaux5BczpCrL0JJszRKeNHWZDXPg0BvTjgzS0Wzvve8ytJaOCX5ejuthzLslg6J
	REx7NCRltBvpMK2Qa2zr9F54S3CieodaVCBJ+4dVyGaiJD0Y8+u1sx8uNKpGK20ioey54s
	6q1re+52hCMnsn7Lc6hZoOuFyCY0w/w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-dp3Ycc5PM42ogmmscQGWIA-1; Wed,
 19 Mar 2025 04:09:30 -0400
X-MC-Unique: dp3Ycc5PM42ogmmscQGWIA-1
X-Mimecast-MFC-AGG-ID: dp3Ycc5PM42ogmmscQGWIA_1742371767
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2AB01180025A;
	Wed, 19 Mar 2025 08:09:27 +0000 (UTC)
Received: from localhost (unknown [10.72.112.30])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 34FA31955BE1;
	Wed, 19 Mar 2025 08:09:23 +0000 (UTC)
Date: Wed, 19 Mar 2025 16:09:19 +0800
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
Subject: Re: [PATCH v10 2/8] ima: define and call ima_alloc_kexec_file_buf()
Message-ID: <Z9p7rwXqjB3vjCpj@MiWiFi-R3L-srv>
References: <20250318010448.954-1-chenste@linux.microsoft.com>
 <20250318010448.954-3-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318010448.954-3-chenste@linux.microsoft.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 03/17/25 at 06:04pm, steven chen wrote:
> Carrying the IMA measurement list across kexec requires allocating a
> buffer and copying the measurement records.  Separate allocating the
> buffer and copying the measurement records into separate functions in
> order to allocate the buffer at kexec 'load' and copy the measurements
> at kexec 'execute'.
> 
> This patch includes the following changes:
>  - Refactor ima_dump_measurement_list() to move the memory allocation
>    to a separate function ima_alloc_kexec_file_buf() which allocates
>    buffer of size 'kexec_segment_size' at kexec 'load'.
>  - Make the local variable ima_kexec_file in ima_dump_measurement_list()
>    a local static to the file, so that it can be accessed from 
>    ima_alloc_kexec_file_buf().
>  - Make necessary changes to the function ima_add_kexec_buffer() to call
>    the above two functions.

We may not need above details about code change because it's not so
difficult to get them from patch.

> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> ---
>  security/integrity/ima/ima_kexec.c | 67 +++++++++++++++++++++++++-----
>  1 file changed, 56 insertions(+), 11 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 8567619889d1..45170e283272 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -15,6 +15,48 @@
>  #include "ima.h"
>  
>  #ifdef CONFIG_IMA_KEXEC
> +static struct seq_file ima_kexec_file;
> +
> +static void ima_reset_kexec_file(struct seq_file *sf)
> +{
> +	sf->buf = NULL;
> +	sf->size = 0;
> +	sf->read_pos = 0;
> +	sf->count = 0;
> +}
> +
> +static void ima_free_kexec_file_buf(struct seq_file *sf)
> +{
> +	vfree(sf->buf);
> +	ima_reset_kexec_file(sf);
> +}
> +
> +static int ima_alloc_kexec_file_buf(size_t segment_size)
> +{
> +	/*
> +	 * kexec 'load' may be called multiple times.
> +	 * Free and realloc the buffer only if the segment_size is
> +	 * changed from the previous kexec 'load' call.
> +	 */
> +	if (ima_kexec_file.buf && ima_kexec_file.size == segment_size)
> +		goto out;
> +
> +	ima_free_kexec_file_buf(&ima_kexec_file);
> +
> +	/* segment size can't change between kexec load and execute */
> +	ima_kexec_file.buf = vmalloc(segment_size);
> +	if (!ima_kexec_file.buf)
> +		return -ENOMEM;
> +
> +	ima_kexec_file.size = segment_size;
> +
> +out:
> +	ima_kexec_file.read_pos = 0;
> +	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved space */
> +
> +	return 0;
> +}
> +
>  /*
>   * Copy the measurement list to the allocated memory
>   * compare the size of IMA measurement list with the size of the allocated memory
> @@ -26,23 +68,16 @@
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
> @@ -79,8 +114,6 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>  	*buffer_size = ima_kexec_file.count;
>  	*buffer = ima_kexec_file.buf;
>  out:
> -	if (ret == -EINVAL)
> -		vfree(ima_kexec_file.buf);
>  	return ret;
>  }
>  
> @@ -119,6 +152,12 @@ void ima_add_kexec_buffer(struct kimage *image)
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
> @@ -140,6 +179,12 @@ void ima_add_kexec_buffer(struct kimage *image)
>  	image->ima_buffer_size = kexec_segment_size;
>  	image->ima_buffer = kexec_buffer;
>  
> +	/*
> +	 * kexec owns kexec_buffer after kexec_add_buffer() is called
> +	 * and it will vfree() that buffer.
> +	 */
> +	ima_reset_kexec_file(&ima_kexec_file);

I can't see why we need call ima_reset_kexec_file() here. If we need
reuse the buffer, we will reset the needed fields at the end of
ima_alloc_kexec_file_buf(). Not sure if I miss anything.

static int ima_alloc_kexec_file_buf(size_t segment_size)
{
......
out:
        ima_kexec_file.read_pos = 0;
        ima_kexec_file.count = sizeof(struct ima_kexec_hdr);    /* reserved space */

        return 0;
}


