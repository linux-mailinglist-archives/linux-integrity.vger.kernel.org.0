Return-Path: <linux-integrity+bounces-5928-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 248F6A93398
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Apr 2025 09:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A02FB19E518D
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Apr 2025 07:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBD1269838;
	Fri, 18 Apr 2025 07:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fHt+zKUH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907F526A08F
	for <linux-integrity@vger.kernel.org>; Fri, 18 Apr 2025 07:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744962056; cv=none; b=rvMFjXdFyDRIJxChJOGfLd/7+X2fPGkAtoxm4l0SCtXF3Ma7J5XMT/Z5pXv8MCKthr7B8KgXhYUzDoWMDQ99LQxfd4vkX+mAsQCkCTC6JXQiY/qu/Eu9PGS/Hy2Spr642jeyVfPcg3AAu7jDTzYu7nuGC3kIwMO4Cn3F9kAHxNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744962056; c=relaxed/simple;
	bh=DCbZzSSzK5J5K8EjuW/T/It7HcLzCrosViqmRrAxcDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYwhtSCa20HRpX4fKcfZ/83v86Rz5Df/QkP4CTtDeskpn9MStCwzR3k6MHlYYSY1KA50lkX+3karg7zRR3zNSE2sQAePDTgAL/X9sEtHfxQIFTSPdQyfIe32W9yETjYVLnEW/Db91JJIsUxYjNa/aZgiPGGyJE8jQlCL5yEvwXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fHt+zKUH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744962053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5U3XpV/CK06BzDowrEdMCxWwiNqlbcO+Z4oINkEbeuE=;
	b=fHt+zKUHJukXA/YGuh7kQPuAzZGcCfu/KNJKKa6AEuyyuRiBBnq4clqL/fsm6miXHwo+DP
	5l1dV0STI6sxNOmVgRwuhzmiQeggTEGnUta3OH5J7lFQcex5lUFSqZ820HzRjHxDhcNR9Q
	PvGcSZ5GNOHiXm9tnHrqjrizXpLqwK0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-nLuEatHzOmSecP1Tc5jYuw-1; Fri,
 18 Apr 2025 03:40:48 -0400
X-MC-Unique: nLuEatHzOmSecP1Tc5jYuw-1
X-Mimecast-MFC-AGG-ID: nLuEatHzOmSecP1Tc5jYuw_1744962045
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B2C3619560BC;
	Fri, 18 Apr 2025 07:40:44 +0000 (UTC)
Received: from localhost (unknown [10.72.112.33])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C2A2918001EA;
	Fri, 18 Apr 2025 07:40:42 +0000 (UTC)
Date: Fri, 18 Apr 2025 15:40:38 +0800
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
Subject: Re: [PATCH v12 5/9] ima: kexec: define functions to copy IMA log at
 soft boot
Message-ID: <aAIB9ga3wPWb5sC8@MiWiFi-R3L-srv>
References: <20250416021028.1403-1-chenste@linux.microsoft.com>
 <20250416021028.1403-6-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416021028.1403-6-chenste@linux.microsoft.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 04/15/25 at 07:10pm, steven chen wrote:
> From: Steven Chen <chenste@linux.microsoft.com>
> 
> The IMA log is currently copied to the new kernel during kexec 'load' 
> using ima_dump_measurement_list(). However, the log copied at kexec 
> 'load' may result in loss of IMA measurements that only occurred after
> kexec "load'. Setup the needed infrastructure to move the IMA log copy 
> from kexec 'load' to 'execute'.
> 
> Define a new IMA hook ima_update_kexec_buffer() as a stub function.
> It will be used to call ima_dump_measurement_list() during kexec 'execute'.
> 
> Implement ima_kexec_post_load() function to be invoked after the new 
> Kernel image has been loaded for kexec. ima_kexec_post_load() maps the 
> IMA buffer to a segment in the newly loaded Kernel.  It also registers 
> the reboot notifier_block to trigger ima_update_kexec_buffer() at 
> kexec 'execute'.
> 
> Set the priority of register_reboot_notifier to INT_MIN to ensure that the
> IMA log copy operation will happen at the end of the operation chain, so 
> that all the IMA measurement records extended into the TPM are copied
> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>
  ^^^

 The tag

> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Baoquan He <bhe@redhat.com> 
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  include/linux/ima.h                |  3 ++
>  security/integrity/ima/ima_kexec.c | 47 ++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)

Other than the tag, this looks good to me:

Acked-by: Baoquan He <bhe@redhat.com>

> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 0bae61a15b60..8e29cb4e6a01 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -32,6 +32,9 @@ static inline void ima_appraise_parse_cmdline(void) {}
>  
>  #ifdef CONFIG_IMA_KEXEC
>  extern void ima_add_kexec_buffer(struct kimage *image);
> +extern void ima_kexec_post_load(struct kimage *image);
> +#else
> +static inline void ima_kexec_post_load(struct kimage *image) {}
>  #endif
>  
>  #else
> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 7e0a19c3483f..e79f6caf895b 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -12,10 +12,14 @@
>  #include <linux/kexec.h>
>  #include <linux/of.h>
>  #include <linux/ima.h>
> +#include <linux/reboot.h>
> +#include <asm/page.h>
>  #include "ima.h"
>  
>  #ifdef CONFIG_IMA_KEXEC
> +static bool ima_kexec_update_registered;
>  static struct seq_file ima_kexec_file;
> +static void *ima_kexec_buffer;
>  
>  static void ima_free_kexec_file_buf(struct seq_file *sf)
>  {
> @@ -162,6 +166,49 @@ void ima_add_kexec_buffer(struct kimage *image)
>  	kexec_dprintk("kexec measurement buffer for the loaded kernel at 0x%lx.\n",
>  		      kbuf.mem);
>  }
> +
> +/*
> + * Called during kexec execute so that IMA can update the measurement list.
> + */
> +static int ima_update_kexec_buffer(struct notifier_block *self,
> +				   unsigned long action, void *data)
> +{
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block update_buffer_nb = {
> +	.notifier_call = ima_update_kexec_buffer,
> +	.priority = INT_MIN
> +};
> +
> +/*
> + * Create a mapping for the source pages that contain the IMA buffer
> + * so we can update it later.
> + */
> +void ima_kexec_post_load(struct kimage *image)
> +{
> +	if (ima_kexec_buffer) {
> +		kimage_unmap_segment(ima_kexec_buffer);
> +		ima_kexec_buffer = NULL;
> +	}
> +
> +	if (!image->ima_buffer_addr)
> +		return;
> +
> +	ima_kexec_buffer = kimage_map_segment(image,
> +					      image->ima_buffer_addr,
> +					      image->ima_buffer_size);
> +	if (!ima_kexec_buffer) {
> +		pr_err("Could not map measurements buffer.\n");
> +		return;
> +	}
> +
> +	if (!ima_kexec_update_registered) {
> +		register_reboot_notifier(&update_buffer_nb);
> +		ima_kexec_update_registered = true;
> +	}
> +}
> +
>  #endif /* IMA_KEXEC */
>  
>  /*
> -- 
> 2.43.0
> 


