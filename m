Return-Path: <linux-integrity+bounces-5652-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAB5A7F35B
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Apr 2025 05:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC3A116944B
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Apr 2025 03:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4960725F963;
	Tue,  8 Apr 2025 03:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IOap76xC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5530C22258E
	for <linux-integrity@vger.kernel.org>; Tue,  8 Apr 2025 03:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744084495; cv=none; b=hcDrw4xIOutk1BPkDOuXhz+0hL40CGz511bHGdMOD9Z6ZNQXaz8RsKVhQa4rhOrjkzzWfAPVkJohSqeGWWW17NcTiDigP8e/XSt0evsBnuVSPJxhrUFTvS1KRejd6vfSia0ysMizQcEV0AiHDtWadRYOpMAs3tItIhgQeWFHS2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744084495; c=relaxed/simple;
	bh=qJ8WPadlWG5MEwR/E8+wnRntvn1EurCfWzwJKqoGTJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtBIRUQRYcaCuzrcYgJdwRVl3D81aqzk6fR2ETWCV7GwZtjHHajIrjdLWbhT3ClaHvHJ9yrFZaKtdY3XlC8YGGk828jKiJ7onvbKyLO20IjuAUILfG1Zne+8LlepqZQyhbkHBRwkxj5VUf8STABcPKq4SdgtAeBKI6wL9+zeaNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IOap76xC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744084492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mq0fN55bc1MQ2ebWlYUs6Z/lMBo/WZPMxJYJMP8sObI=;
	b=IOap76xCZ4n6TmksvKGwSFnoCRGpDloODeucsXyV9n5ZTGVyJP/wKQmjlLOuz9k9Ssp/Sy
	XqYGVmjtR0QWcNUl+Kf4q1dy7HVg/u9U60kNvKWYbkJb1asFLkwLfipIx2PCWkB1o9dSdL
	JWdL+Bsxjf4sFY3FrFvj5Al0nsXC2TA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-3FKLeLlaMZiHAllzx_iVPQ-1; Mon,
 07 Apr 2025 23:54:46 -0400
X-MC-Unique: 3FKLeLlaMZiHAllzx_iVPQ-1
X-Mimecast-MFC-AGG-ID: 3FKLeLlaMZiHAllzx_iVPQ_1744084484
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3E6EC1801A00;
	Tue,  8 Apr 2025 03:54:44 +0000 (UTC)
Received: from localhost (unknown [10.72.112.61])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2DCF7180B486;
	Tue,  8 Apr 2025 03:54:41 +0000 (UTC)
Date: Tue, 8 Apr 2025 11:54:32 +0800
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
Subject: Re: [PATCH v11 7/9] ima: verify if the segment size has changed
Message-ID: <Z/Sd+JdEbih7O48k@MiWiFi-R3L-srv>
References: <20250402124725.5601-1-chenste@linux.microsoft.com>
 <20250402124725.5601-8-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402124725.5601-8-chenste@linux.microsoft.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 04/02/25 at 05:47am, steven chen wrote:
> kexec 'load' may be called multiple times. Free and realloc the buffer
> only if the segment_size is changed from the previous kexec 'load' call.

This is a great example demonstrating how patch is nicely split. A
reasonable unit including reasonable code change and log.

Acked-by: Baoquan He <bhe@redhat.com>

> 
> Signed-off-by: steven chen <chenste@linux.microsoft.com>
> ---
>  security/integrity/ima/ima_kexec.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 5c3b3e0b2186..ed867734ee70 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -33,6 +33,14 @@ static void ima_free_kexec_file_buf(struct seq_file *sf)
>  
>  static int ima_alloc_kexec_file_buf(size_t segment_size)
>  {
> +	/*
> +	 * kexec 'load' may be called multiple times.
> +	 * Free and realloc the buffer only if the segment_size is
> +	 * changed from the previous kexec 'load' call.
> +	 */
> +	if (ima_kexec_file.buf && ima_kexec_file.size == segment_size)
> +		goto out;
> +
>  	ima_free_kexec_file_buf(&ima_kexec_file);
>  
>  	/* segment size can't change between kexec load and execute */
> @@ -41,6 +49,8 @@ static int ima_alloc_kexec_file_buf(size_t segment_size)
>  		return -ENOMEM;
>  
>  	ima_kexec_file.size = segment_size;
> +
> +out:
>  	ima_kexec_file.read_pos = 0;
>  	ima_kexec_file.count = sizeof(struct ima_kexec_hdr);	/* reserved space */
>  
> -- 
> 2.25.1
> 


