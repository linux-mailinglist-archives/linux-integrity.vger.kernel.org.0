Return-Path: <linux-integrity+bounces-5331-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F7AA69E75
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Mar 2025 03:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4CA716666B
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Mar 2025 02:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916821EE7A3;
	Thu, 20 Mar 2025 02:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N3ccJmrU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966ED15B543
	for <linux-integrity@vger.kernel.org>; Thu, 20 Mar 2025 02:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742439176; cv=none; b=XxGlAl7vtlJ9HwvWzYaieY4ej9BcIHDZh5VZxA7bN2JUWgYiFmMXXPWo+0xzB7JvsKTuLYwg/s2Sz8fFFD7vX/0Glg6tifnf4r/RwENdzd07TQKtDZvADHiMSaL0WylRcf1zDNDSJgsjLCZIhnnuTMpDAt4GxBWmcjevdywxqzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742439176; c=relaxed/simple;
	bh=vg4+ggxmuzeKTljMhEG1Oo/JmSE8/6fLfiQV1X3qNsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AJ2CtmcCQJPxuyG5OyvjiWto02OwcYNtDCLIFgoGwWg6lbNkka3qBOdApTx8VYQlcy8IJ7S1lHr9gZDUX18VPgVWtxeQM8LXW2Tj1P9sOlpH4ASfLky/rnwf9K2ZbAsn3St9YMBS8lLcBURR7lfEAlMacNROFk/gxG7BXRwh76c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N3ccJmrU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742439173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=llxsDGyF5OTS0kLxtrZq1xxBUU0ow8OofIklAK3fpNU=;
	b=N3ccJmrUh2Qv6PDYr1LkgrCeJNaj+nfS8IbXJVZV8WJczUgHZmvarH0oeF5hyU0gP8Bgjh
	YUdWeycoMUthhT7ppotbZ3XqXjWDZR5s+5LdktA+xs3xlkcEA9/v7PmAXKM3Gt6K/tUGiH
	mr18kvPDfpIaTdKRkzeRjQvF0B5ETMA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-BuMgurEROi-9O3Ip2yolXw-1; Wed,
 19 Mar 2025 22:52:49 -0400
X-MC-Unique: BuMgurEROi-9O3Ip2yolXw-1
X-Mimecast-MFC-AGG-ID: BuMgurEROi-9O3Ip2yolXw_1742439167
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74EC41800875;
	Thu, 20 Mar 2025 02:52:46 +0000 (UTC)
Received: from localhost (unknown [10.72.112.30])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E66BA180174E;
	Thu, 20 Mar 2025 02:52:42 +0000 (UTC)
Date: Thu, 20 Mar 2025 10:52:38 +0800
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
Subject: Re: [PATCH v10 7/8] ima: make the kexec extra memory configurable
Message-ID: <Z9uC9g+UaVAA/0tY@MiWiFi-R3L-srv>
References: <20250318010448.954-1-chenste@linux.microsoft.com>
 <20250318010448.954-8-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318010448.954-8-chenste@linux.microsoft.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 03/17/25 at 06:04pm, steven chen wrote:
> The extra memory allocated for carrying the IMA measurement list across
> kexec is hard-coded as half a PAGE.  Make it configurable.
> 
> Define a Kconfig option, IMA_KEXEC_EXTRA_MEMORY_KB, to configure the
> extra memory (in kb) to be allocated for IMA measurements added during
> kexec soft reboot.  Ensure the default value of the option is set such
> that extra half a page of memory for additional measurements is allocated
> for the additional measurements.
> 
> Update ima_add_kexec_buffer() function to allocate memory based on the
> Kconfig option value, rather than the currently hard-coded one.
> 
> Suggested-by: Stefan Berger <stefanb@linux.ibm.com>
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  security/integrity/ima/Kconfig     | 10 ++++++++++
>  security/integrity/ima/ima_kexec.c | 16 +++++++++++-----
>  2 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
> index 475c32615006..d73c96c3c1c9 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -321,4 +321,14 @@ config IMA_DISABLE_HTABLE
>  	help
>  	   This option disables htable to allow measurement of duplicate records.
>  
> +config IMA_KEXEC_EXTRA_MEMORY_KB
> +	int "Extra memory for IMA measurements added during kexec soft reboot"
> +	depends on IMA_KEXEC
> +	default 0

Is there range for this memory, e.g [0, max] and max will be a value
according to our current perception?

> +	help
> +	  IMA_KEXEC_EXTRA_MEMORY_KB determines the extra memory to be
> +	  allocated (in kb) for IMA measurements added during kexec soft reboot.
> +	  If set to the default value of 0, an extra half page of memory for those
> +	  additional measurements will be allocated.
> +
>  endif
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index c390c745f882..0f214e41dd33 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -131,6 +131,7 @@ void ima_add_kexec_buffer(struct kimage *image)
>  				  .buf_min = 0, .buf_max = ULONG_MAX,
>  				  .top_down = true };
>  	unsigned long binary_runtime_size;
> +	unsigned long extra_memory;
>  
>  	/* use more understandable variable names than defined in kbuf */
>  	size_t kexec_buffer_size = 0;
> @@ -138,15 +139,20 @@ void ima_add_kexec_buffer(struct kimage *image)
>  	int ret;
>  
>  	/*
> -	 * Reserve an extra half page of memory for additional measurements
> -	 * added during the kexec load.
> +	 * Reserve extra memory for measurements added during kexec.
>  	 */
> -	binary_runtime_size = ima_get_binary_runtime_size();
> +	if (CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB <= 0)
> +		extra_memory = PAGE_SIZE / 2;
> +	else
> +		extra_memory = CONFIG_IMA_KEXEC_EXTRA_MEMORY_KB * 1024;
> +
> +	binary_runtime_size = ima_get_binary_runtime_size() + extra_memory;
> +
>  	if (binary_runtime_size >= ULONG_MAX - PAGE_SIZE)
>  		kexec_segment_size = ULONG_MAX;
>  	else
> -		kexec_segment_size = ALIGN(ima_get_binary_runtime_size() +
> -					   PAGE_SIZE / 2, PAGE_SIZE);
> +		kexec_segment_size = ALIGN(binary_runtime_size, PAGE_SIZE);
> +
>  	if ((kexec_segment_size == ULONG_MAX) ||
>  	    ((kexec_segment_size >> PAGE_SHIFT) > totalram_pages() / 2)) {
>  		pr_err("Binary measurement list too large.\n");
> -- 
> 2.25.1
> 
> 


