Return-Path: <linux-integrity+bounces-5110-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B9FA4FE42
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 13:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60D863A24EF
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 12:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19322242925;
	Wed,  5 Mar 2025 12:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JSsj8oYs"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282B6205AA2
	for <linux-integrity@vger.kernel.org>; Wed,  5 Mar 2025 12:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741176529; cv=none; b=eS46e+RV0SyWBvudK5cZgNKOPeOWtioyv6kXkF7bPn217ve522Q/uf0YSVpRnB05leqbJZXGczrP6YPcsj19wGloy3/HeN6LV+PpwzfbJ8YF/P8obKC/ox5DNzSpXDZv57JPubS51Efs4rYDs24giuHJrMunof0wtbRPbUMIlp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741176529; c=relaxed/simple;
	bh=RnBsvBFj13o0T8GoA8yzpoxrZKvWr4mAnPtrkGC4hwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a4oMn6ZjPgimRmRxDJTC079fz5u5VKrfUj7DEtwp1qRqai8JQg+02yzJtZ3fbmCH2yTaZENIlGG2VwUbnvOMFSXfSZuZT3ws0ZBjKqDhUUk0VTnWx9ZdH2rAAjD5SNqnYe7tS3F6D7JSnpMiHRmjdxItzmd31F0VsKMqqCtgkjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JSsj8oYs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741176526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C3+9VTUUISYXrCUuqrTADiZyo+Fb1VZxKVXvolC/s0o=;
	b=JSsj8oYsnBOD45zxGrocBEoNGffo0h1nTfQsZyqlNjrzQ45IZ8w2XjCkgGDOUgIsuAzX+n
	D71yeTu9vp0v23cQgm8rUR9viXek3KTT7TMBKKb/a9rPBQZCuoYoGLwbvkamT4dfeLZaRr
	GdMgla/0+XLNQHoxu3a5TqJzT/NLy10=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-aiq_hWisNVq9z7UKcbSrZQ-1; Wed,
 05 Mar 2025 07:08:42 -0500
X-MC-Unique: aiq_hWisNVq9z7UKcbSrZQ-1
X-Mimecast-MFC-AGG-ID: aiq_hWisNVq9z7UKcbSrZQ_1741176520
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8299A1800267;
	Wed,  5 Mar 2025 12:08:39 +0000 (UTC)
Received: from localhost (unknown [10.72.112.32])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 554A01954B32;
	Wed,  5 Mar 2025 12:08:35 +0000 (UTC)
Date: Wed, 5 Mar 2025 20:08:26 +0800
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
Subject: Re: [PATCH v9 1/7] ima: copy only complete measurement records
 across kexec
Message-ID: <Z8g+uhZQ6totYLmp@MiWiFi-R3L-srv>
References: <20250304190351.96975-1-chenste@linux.microsoft.com>
 <20250304190351.96975-2-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304190351.96975-2-chenste@linux.microsoft.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 03/04/25 at 11:03am, steven chen wrote:
> Carrying the IMA measurement list across kexec requires allocating a
> buffer and copying the measurement records.  Separate allocating the
> buffer and copying the measurement records into separate functions in
> order to allocate the buffer at kexec 'load' and copy the measurements
> at kexec 'execute'.
> 
> This patch includes the following changes:

I don't know why one patch need include so many changes. From below log,
it should be split into separate patches. It may not need to make one
patch to reflect one change, we should at least split and wrap several
kind of changes to ease patch understanding and reviewing. My personal
opinion.

>  - Refactor ima_dump_measurement_list() to move the memory allocation
>    to a separate function ima_alloc_kexec_file_buf() which allocates
>    buffer of size 'kexec_segment_size' at kexec 'load'.
>  - Make the local variable ima_kexec_file in ima_dump_measurement_list()
>    a local static to the file, so that it can be accessed from 
>    ima_alloc_kexec_file_buf(). Compare actual memory required to ensure 
>    there is enough memory for the entire measurement record.
>  - Copy only complete measurement records.
>  - Make necessary changes to the function ima_add_kexec_buffer() to call
>    the above two functions.
>  - Compared the memory size allocated with memory size of the entire 
>    measurement record. Copy only complete measurement records if there 
>    is enough memory. If there is not enough memory, it will not copy
>    any IMA measurement records, and this situation will result in a 
>    failure of remote attestation.
> 
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> ---
>  security/integrity/ima/ima.h       |   1 +
>  security/integrity/ima/ima_kexec.c | 105 ++++++++++++++++++++++-------
>  security/integrity/ima/ima_queue.c |   4 +-
>  3 files changed, 83 insertions(+), 27 deletions(-)
> 
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index 24d09ea91b87..4428fcf42167 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -274,6 +274,7 @@ bool ima_template_has_modsig(const struct ima_template_desc *ima_template);
>  int ima_restore_measurement_entry(struct ima_template_entry *entry);
>  int ima_restore_measurement_list(loff_t bufsize, void *buf);
>  int ima_measurements_show(struct seq_file *m, void *v);
> +int ima_get_binary_runtime_entry_size(struct ima_template_entry *entry);
>  unsigned long ima_get_binary_runtime_size(void);
>  int ima_init_template(void);
>  void ima_init_template_list(void);
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 9d45f4d26f73..6195df128482 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -15,63 +15,106 @@
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
> +/*
> + * Copy the measurement list to the allocated memory
> + * compare the size of IMA measurement list with the size of the allocated memory
> + *    if the size of the allocated memory is not less than the size of IMA measurement list
> + *        copy the measurement list to the allocated memory.
> + *    else return error
> + */
>  static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>  				     unsigned long segment_size)
>  {
>  	struct ima_queue_entry *qe;
> -	struct seq_file file;
>  	struct ima_kexec_hdr khdr;
>  	int ret = 0;
> +	size_t entry_size = 0;
>  
> -	/* segment size can't change between kexec load and execute */
> -	file.buf = vmalloc(segment_size);
> -	if (!file.buf) {
> -		ret = -ENOMEM;
> -		goto out;
> +	if (!ima_kexec_file.buf) {
> +		pr_err("Kexec file buf not allocated\n");
> +		return -EINVAL;
>  	}
>  
> -	file.file = NULL;
> -	file.size = segment_size;
> -	file.read_pos = 0;
> -	file.count = sizeof(khdr);	/* reserved space */
> -
>  	memset(&khdr, 0, sizeof(khdr));
>  	khdr.version = 1;
>  	/* This is an append-only list, no need to hold the RCU read lock */
>  	list_for_each_entry_rcu(qe, &ima_measurements, later, true) {
> -		if (file.count < file.size) {
> +		entry_size += ima_get_binary_runtime_entry_size(qe->entry);
> +		if (entry_size <= segment_size) {
>  			khdr.count++;
> -			ima_measurements_show(&file, qe);
> +			ima_measurements_show(&ima_kexec_file, qe);
>  		} else {
>  			ret = -EINVAL;
> +			pr_err("IMA log file is too big for Kexec buf\n");
>  			break;
>  		}
>  	}
>  
>  	if (ret < 0)
>  		goto out;
> -
>  	/*
>  	 * fill in reserved space with some buffer details
>  	 * (eg. version, buffer size, number of measurements)
>  	 */
> -	khdr.buffer_size = file.count;
> +	khdr.buffer_size = ima_kexec_file.count;
>  	if (ima_canonical_fmt) {
>  		khdr.version = cpu_to_le16(khdr.version);
>  		khdr.count = cpu_to_le64(khdr.count);
>  		khdr.buffer_size = cpu_to_le64(khdr.buffer_size);
>  	}
> -	memcpy(file.buf, &khdr, sizeof(khdr));
> +	memcpy(ima_kexec_file.buf, &khdr, sizeof(khdr));
>  
>  	print_hex_dump_debug("ima dump: ", DUMP_PREFIX_NONE, 16, 1,
> -			     file.buf, file.count < 100 ? file.count : 100,
> +			     ima_kexec_file.buf, ima_kexec_file.count < 100 ?
> +			     ima_kexec_file.count : 100,
>  			     true);
>  
> -	*buffer_size = file.count;
> -	*buffer = file.buf;
> +	*buffer_size = ima_kexec_file.count;
> +	*buffer = ima_kexec_file.buf;
> +
>  out:
> -	if (ret == -EINVAL)
> -		vfree(file.buf);
>  	return ret;
>  }
>  
> @@ -90,7 +133,7 @@ void ima_add_kexec_buffer(struct kimage *image)
>  
>  	/* use more understandable variable names than defined in kbuf */
>  	void *kexec_buffer = NULL;
> -	size_t kexec_buffer_size;
> +	size_t kexec_buffer_size = 0;
>  	size_t kexec_segment_size;
>  	int ret;
>  
> @@ -110,13 +153,19 @@ void ima_add_kexec_buffer(struct kimage *image)
>  		return;
>  	}
>  
> -	ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
> -				  kexec_segment_size);
> -	if (!kexec_buffer) {
> +	ret = ima_alloc_kexec_file_buf(kexec_segment_size);
> +	if (ret < 0) {
>  		pr_err("Not enough memory for the kexec measurement buffer.\n");
>  		return;
>  	}
>  
> +	ret = ima_dump_measurement_list(&kexec_buffer_size, &kexec_buffer,
> +					kexec_segment_size);
> +	if (ret < 0) {
> +		pr_err("Failed to dump IMA measurements. Error:%d.\n", ret);
> +		return;
> +	}
> +
>  	kbuf.buffer = kexec_buffer;
>  	kbuf.bufsz = kexec_buffer_size;
>  	kbuf.memsz = kexec_segment_size;
> @@ -131,6 +180,12 @@ void ima_add_kexec_buffer(struct kimage *image)
>  	image->ima_buffer_size = kexec_segment_size;
>  	image->ima_buffer = kexec_buffer;
>  
> +	/*
> +	 * kexec owns kexec_buffer after kexec_add_buffer() is called
> +	 * and it will vfree() that buffer.
> +	 */
> +	ima_reset_kexec_file(&ima_kexec_file);
> +
>  	kexec_dprintk("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
>  		      kbuf.mem);
>  }
> diff --git a/security/integrity/ima/ima_queue.c b/security/integrity/ima/ima_queue.c
> index 83d53824aa98..3dfd178d4292 100644
> --- a/security/integrity/ima/ima_queue.c
> +++ b/security/integrity/ima/ima_queue.c
> @@ -78,7 +78,7 @@ static struct ima_queue_entry *ima_lookup_digest_entry(u8 *digest_value,
>   * binary_runtime_measurement list entry, which contains a
>   * couple of variable length fields (e.g template name and data).
>   */
> -static int get_binary_runtime_size(struct ima_template_entry *entry)
> +int ima_get_binary_runtime_entry_size(struct ima_template_entry *entry)
>  {
>  	int size = 0;
>  
> @@ -122,7 +122,7 @@ static int ima_add_digest_entry(struct ima_template_entry *entry,
>  	if (binary_runtime_size != ULONG_MAX) {
>  		int size;
>  
> -		size = get_binary_runtime_size(entry);
> +		size = ima_get_binary_runtime_entry_size(entry);
>  		binary_runtime_size = (binary_runtime_size < ULONG_MAX - size) ?
>  		     binary_runtime_size + size : ULONG_MAX;
>  	}
> -- 
> 2.25.1
> 


