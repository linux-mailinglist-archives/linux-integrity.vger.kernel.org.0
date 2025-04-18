Return-Path: <linux-integrity+bounces-5924-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A8ECA930D1
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Apr 2025 05:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5A00173759
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Apr 2025 03:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F722267F45;
	Fri, 18 Apr 2025 03:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TWwts1m9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48E27E0FF
	for <linux-integrity@vger.kernel.org>; Fri, 18 Apr 2025 03:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744947042; cv=none; b=np1w/rPc9Tj92fjeNaIJHqGz8jh9e7NhDtexkhAwvK7NrRLZeZPV+LarA1V33ojgqi5JlyYachinwTCgQQ3Wxdhb5fvtdTeJ1J1haOxOOg9J5PXQwrVzKWPX4Vv0Y86GdYc3PnoRq2zvmUrxAM+scsWs+xd55YWLSiDSuLMZk6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744947042; c=relaxed/simple;
	bh=q9ITA69y44BPFoM6d1viEjhR7yw9U9I7tW2KwgQ3i34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=meQ/T2NDp81rFPH0hlRdtglzhIEuW7qfJJFIoZFSj2Ot/1yLUC1qPwYXp5WL4sS62n+T0O6mrHsvij1uvD9PdpN0NpwlrlPqFWRzPp3DXlu8E6IlBo7DGDiyHcfxqPf55X0pFkVM6LtBxEy20qYY+isCqzEcDdIqJ9B3a5svO+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TWwts1m9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744947037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w9jU+Dda1PsZ40rgWEcGbvLsKjnyo8h4BHDeBqrNr3A=;
	b=TWwts1m9tm5bu7b7FSx2OTaV3s9JdoN2dOqDLsSethc28vdFaI5Q0KDvATPoKjwOqObMaC
	Tbs9UOlVtGGn9Tc7tUh9FwrdJiY6OQD1XHSVt/aUmbb+wX7vP2WZjgmRy6cHf2vNHla4ZX
	DZL3oqFvK7+srkqm83ckCSoU5grQhQo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-cB5k-wf9NOyOLoWEw41P6w-1; Thu,
 17 Apr 2025 23:30:34 -0400
X-MC-Unique: cB5k-wf9NOyOLoWEw41P6w-1
X-Mimecast-MFC-AGG-ID: cB5k-wf9NOyOLoWEw41P6w_1744947031
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7BBC41956095;
	Fri, 18 Apr 2025 03:30:30 +0000 (UTC)
Received: from localhost (unknown [10.72.112.106])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C495318001EA;
	Fri, 18 Apr 2025 03:30:27 +0000 (UTC)
Date: Fri, 18 Apr 2025 11:30:23 +0800
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
Subject: Re: [PATCH v12 1/9] ima: rename variable the seq_file "file" to
 "ima_kexec_file"
Message-ID: <aAHHTz6Zx5hzQYq0@MiWiFi-R3L-srv>
References: <20250416021028.1403-1-chenste@linux.microsoft.com>
 <20250416021028.1403-2-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416021028.1403-2-chenste@linux.microsoft.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 04/15/25 at 07:10pm, steven chen wrote:
> From: Steven Chen <chenste@linux.microsoft.com>
> 
> Before making the function local seq_file "file" variable file static
> global, rename it to "ima_kexec_file".
> 
> Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
> ---
>  security/integrity/ima/ima_kexec.c | 31 +++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)

Acked-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 9d45f4d26f73..650beb74346c 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -18,30 +18,30 @@
>  static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
>  				     unsigned long segment_size)
>  {
> +	struct seq_file ima_kexec_file;
>  	struct ima_queue_entry *qe;
> -	struct seq_file file;
>  	struct ima_kexec_hdr khdr;
>  	int ret = 0;
>  
>  	/* segment size can't change between kexec load and execute */
> -	file.buf = vmalloc(segment_size);
> -	if (!file.buf) {
> +	ima_kexec_file.buf = vmalloc(segment_size);
> +	if (!ima_kexec_file.buf) {
>  		ret = -ENOMEM;
>  		goto out;
>  	}
>  
> -	file.file = NULL;
> -	file.size = segment_size;
> -	file.read_pos = 0;
> -	file.count = sizeof(khdr);	/* reserved space */
> +	ima_kexec_file.file = NULL;
> +	ima_kexec_file.size = segment_size;
> +	ima_kexec_file.read_pos = 0;
> +	ima_kexec_file.count = sizeof(khdr);	/* reserved space */
>  
>  	memset(&khdr, 0, sizeof(khdr));
>  	khdr.version = 1;
>  	/* This is an append-only list, no need to hold the RCU read lock */
>  	list_for_each_entry_rcu(qe, &ima_measurements, later, true) {
> -		if (file.count < file.size) {
> +		if (ima_kexec_file.count < ima_kexec_file.size) {
>  			khdr.count++;
> -			ima_measurements_show(&file, qe);
> +			ima_measurements_show(&ima_kexec_file, qe);
>  		} else {
>  			ret = -EINVAL;
>  			break;
> @@ -55,23 +55,24 @@ static int ima_dump_measurement_list(unsigned long *buffer_size, void **buffer,
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
>  out:
>  	if (ret == -EINVAL)
> -		vfree(file.buf);
> +		vfree(ima_kexec_file.buf);
>  	return ret;
>  }
>  
> -- 
> 2.43.0
> 


