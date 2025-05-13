Return-Path: <linux-integrity+bounces-6184-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C80AEAB497D
	for <lists+linux-integrity@lfdr.de>; Tue, 13 May 2025 04:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68D8A19E635A
	for <lists+linux-integrity@lfdr.de>; Tue, 13 May 2025 02:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DA4A923;
	Tue, 13 May 2025 02:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KDUnaFP6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131071922FD
	for <linux-integrity@vger.kernel.org>; Tue, 13 May 2025 02:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747103147; cv=none; b=N66IxC67uvuUjS2d9kLcPxnn0cVoXjc5Fdzlsh5cAYV3byYvGXF99nV5km/+bbSjmYXgKQ3My/fGWtnFMVyy/B5kW7KbO+UhhNndng3R6cUFwFxMmpxkwbdURHfmVKB4hIV3p4WOTG+rTw6kV3UQCczpbRSIbfOtPqk4hhBUO8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747103147; c=relaxed/simple;
	bh=0sh163gF+PxcUY1J/bfW/DhYUxjGTqPg/dyisHzYQd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjlpW7M1nJhGrv4bkzEIRr0Yl7GcHzuCrtCDqVPWaZaOKswbw+rOaybcZVc/zu0pP3Wzbk9a3Cd1+bvcaw7UV+mtcxlGl2J+s+RjER6kpwyYsu2e9PyJG3ZNZpqhLnT767RYZ33zKDsWzkulDVw1giF3jQ7+fK1RVCY/rYdHcQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KDUnaFP6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747103142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9dgrXsZWA0vbbTnvHkNfRPIocb/HknSgCRHsF+qYBSQ=;
	b=KDUnaFP6uTaeTMmtgD8cYoqByP4DaUEvI4pbHnkO7hGz93BQxteO+DTjx9aS5Hb0CNRvq7
	VBW/ntFRlmajvttNgQLRG4pFBPQZBgV7WgZB7EghMSJRCkhEMaytJxYUPQCLEf6KSRZhdJ
	866rnKUYxJ5WtAgyCuxeXMuEQqXVlG4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-206-8D2PfANRNYa9xv62jUJf4g-1; Mon,
 12 May 2025 22:25:39 -0400
X-MC-Unique: 8D2PfANRNYa9xv62jUJf4g-1
X-Mimecast-MFC-AGG-ID: 8D2PfANRNYa9xv62jUJf4g_1747103136
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F27E71800258;
	Tue, 13 May 2025 02:25:35 +0000 (UTC)
Received: from localhost (unknown [10.72.112.8])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 972F01953B82;
	Tue, 13 May 2025 02:25:33 +0000 (UTC)
Date: Tue, 13 May 2025 10:25:26 +0800
From: Baoquan He <bhe@redhat.com>
To: steven chen <chenste@linux.microsoft.com>
Cc: zohar@linux.ibm.com, stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com, roberto.sassu@huawei.com,
	eric.snowberg@oracle.com, ebiederm@xmission.com,
	paul@paul-moore.com, code@tyhicks.com, bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org, kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	madvenka@linux.microsoft.com, nramas@linux.microsoft.com,
	James.Bottomley@hansenpartnership.com
Subject: Re: [PATCH] ima: Kdump kernel doesn't need IMA to do integrity
 measurement
Message-ID: <aCKtlthQWnq+xyat@MiWiFi-R3L-srv>
References: <20250502200337.6293-1-chenste@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250502200337.6293-1-chenste@linux.microsoft.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 05/02/25 at 01:03pm, steven chen wrote:
> From: Steven Chen <chenste@linux.microsoft.com>
> 
> Kdump kernel doesn't need IMA to do integrity measurement.
> Hence the measurement list in 1st kernel doesn't need to be copied to
> kdump kenrel.
> 
> Here skip allocating buffer for measurement list copying if loading
> kdump kernel. Then there won't be the later handling related to
> ima_kexec_buffer.
> 
> Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
> ---
>  security/integrity/ima/ima_kexec.c | 3 +++
>  1 file changed, 3 insertions(+)

I applied this patch on top of below IMA patchset, and did a test.
[PATCH v13 0/9] ima: kexec: measure events between kexec load and execute

When I loaded kdump kernel as below with '-d' specified:

/sbin/kexec -s -d -p --command-line=BOOT_IMAGE=(hd0,gpt2)/vmlinuz-6.15.0-rc6+ ro console=ttyS0,115200N81 irqpoll nr_cpus=1 reset_devices cgroup_disable=memory mce=off numa=off udev.children-max=2 panic=10 acpi_no_memhotplug transparent_hugepage=never nokaslr hest_disable novmcoredd cma=0 hugetlb_cma=0 pcie_ports=compat disable_cpu_apicid=0 --initrd=/boot/initramfs-6.15.0-rc6+kdump.img /boot/vmlinuz-6.15.0-rc6+

I can see that this patch works to skip copying measurement list to kdump
kernel as expected..

=====Without this patch===
[48522.060422] kexec_file: kernel: 000000006fbcb87f kernel_size: 0xe99200
[48522.067742] PEFILE: Unsigned PE binary
[48522.094849] ima: kexec measurement buffer for the loaded kernel at 0x6efff000.
[48522.102982] crash_core: Crash PT_LOAD ELF header. phdr=00000000cae5d7e6 vaddr=0xffff8da640100000, paddr=0x100000, sz=0x5af00000 e_phnum=67 p_offset=0x100000
......snip...
=====

=====With this patch applied====
[ 2101.704125] kexec_file: kernel: 0000000046d8985c kernel_size: 0xeab200
[ 2101.711436] PEFILE: Unsigned PE binary
[ 2101.734752] crash_core: Crash PT_LOAD ELF header. phdr=000000006fc83a51 vaddr=0xffff899480100000, paddr=0x100000, sz=0x5af00000 e_phnum=67 p_offset=0x100000
......snip...
=====> 

My only concern is the patch subject is not very sepcific, it better
relfect the exact action taken in this patch, like:

ima: do not copy measurement list to kdump kernel

Other than above concern, please feel free to add my:

Tested-by: Baoquan He <bhe@redhat.com>
Acked-by: Baoquan He <bhe@redhat.com>

> diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
> index 38cb2500f4c3..7362f68f2d8b 100644
> --- a/security/integrity/ima/ima_kexec.c
> +++ b/security/integrity/ima/ima_kexec.c
> @@ -146,6 +146,9 @@ void ima_add_kexec_buffer(struct kimage *image)
>  	void *kexec_buffer = NULL;
>  	int ret;
>  
> +	if (image->type == KEXEC_TYPE_CRASH)
> +		return;
> +
>  	/*
>  	 * Reserve extra memory for measurements added during kexec.
>  	 */
> -- 
> 2.43.0
> 


