Return-Path: <linux-integrity+bounces-5760-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 138D7A83F7A
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 11:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C61917211E
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Apr 2025 09:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD56726A0EB;
	Thu, 10 Apr 2025 09:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d15o3W+s"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C082571C2
	for <linux-integrity@vger.kernel.org>; Thu, 10 Apr 2025 09:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744278892; cv=none; b=pIW3a6A1VTPxB0GUUQWvd6BGiOYFcMEwMffxPvuOR8fqRRcfIhkU82ALAqrNiZWiwcR4552bNtFG6HdylpwytPvsuxX67yZ8UlCd7av1g3cO7UayCEiiVMPI8Nxbh9lKeYHn1Os8gs6gNWDW+9nt0HPjlE/xJ/tcmPUh+l2VrNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744278892; c=relaxed/simple;
	bh=e8pssY7zMOIxbmYX6eTCFTk3ZdlqMN7WT1Tmj47w+Bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bdusTZZCm6KtU+jU7hBx7oHsXs7KcoQrCfePKdXwXI2zdg3/V6QwgrQ7aoP/VX04hvVbvqdzEeAK3V4A+kDjXdGsBBbF0PFSJ2+XkgHc9ru+8CZELHMgImnKVQAJ2L+vAikOnKV9yOrqyDuxNJ3t9uDFacQe28o3u6FHgRiURWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d15o3W+s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744278890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FBjnDHe05jMrdyAmjlXqvilcIE/JjsVNiTKFB4wAT6A=;
	b=d15o3W+stNsYKXs++4sdstjmcASii/Wg3R1UVLE8qYjA/DKiA5K9z/L+m+gRqvvnGXW+oc
	ZTcjd+7EED8rXwZTxjVhmowgrsn3klwyIwOyALuUAd1RcGyI2GC8cTX2uMouuug6KKLimc
	xcVx5ArTaXK09CDgB/bBdrQ7DfFpFiI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-IMCN5vjAMv-jci4TsADYlw-1; Thu,
 10 Apr 2025 05:54:44 -0400
X-MC-Unique: IMCN5vjAMv-jci4TsADYlw-1
X-Mimecast-MFC-AGG-ID: IMCN5vjAMv-jci4TsADYlw_1744278882
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2C7A1180AF53;
	Thu, 10 Apr 2025 09:54:41 +0000 (UTC)
Received: from localhost (unknown [10.72.112.38])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 848791828AA5;
	Thu, 10 Apr 2025 09:54:38 +0000 (UTC)
Date: Thu, 10 Apr 2025 17:54:33 +0800
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
Subject: Re: [PATCH v11 8/9] ima: make the kexec extra memory configurable
Message-ID: <Z/eVWQw3z7yyzyxb@MiWiFi-R3L-srv>
References: <20250402124725.5601-1-chenste@linux.microsoft.com>
 <20250402124725.5601-9-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402124725.5601-9-chenste@linux.microsoft.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 04/02/25 at 05:47am, steven chen wrote:
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

Usually a new Kconfig item which accepts a range should define the range
boundary, otherwise it's not clear to people how large or how small it
can be set. For example, can I set it as value of 1<<40? We should at
least estimate a possible upper limit for it for other people's
reference. My personal opinion.

The rest looks good to me.


> +	help
> +	  IMA_KEXEC_EXTRA_MEMORY_KB determines the extra memory to be
> +	  allocated (in kb) for IMA measurements added during kexec soft reboot.
> +	  If set to the default value of 0, an extra half page of memory for those
> +	  additional measurements will be allocated.
> +
>  endif
...snip...


