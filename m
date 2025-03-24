Return-Path: <linux-integrity+bounces-5409-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1309CA6D8CA
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Mar 2025 12:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5A6C7A6701
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Mar 2025 11:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FE218FC80;
	Mon, 24 Mar 2025 11:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AN3M0QlX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B9C2C80
	for <linux-integrity@vger.kernel.org>; Mon, 24 Mar 2025 11:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742814069; cv=none; b=FN0T21jcvSrEmR5/eO8SCrJ1uzwjg/DYojRgJHNnuXlJtKRlNV3ntF8cqGuqQ4IuWAmJTfLLDbMm3FYmw9dUDp6ndCENkX5SFgu9H+n3njLmjbNIKGySpJztp5ZX9kGPKe+YSm0dEDbr9Tu0EfQyvQ555BaA/CjgWbS7Xgnmxcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742814069; c=relaxed/simple;
	bh=LDsJSlPtXgnODZ+ldr2KxIShTemz/tVXnReb9HkLtQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjriscD84wrC0h1C8F3rlS1Y5CePgGBofOB2XrHQtyU2veIV7qjxUY05rTFRS6RGlmQnojev80IBgwTrU75iwvwsjL0d57kbnCZV8oWMcUEW/asHlMYqTaA4gHymSXxugIIxDK+c4D6H30jQfZgGuVTMLOCiO35lpcprKsHGM6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AN3M0QlX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742814066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+PS69gZ7L0QPn+MJNrvH0ZaDSrgaKGsoM7m8BjefV88=;
	b=AN3M0QlXDNfhSoNzw4Il9YlZe4tTiwiGypkGd7gNQsWq8B/YAvFUd8Ya1FSAvxQMpoUGQ7
	I/airx1/33EvVydIm3Xj1vLjuQVYsxYWzPIc5bIeSqrl40hR2pUpGw9NaZBXMWO/9mUjfc
	hbqAoR75ZmLTyswgbNtV2ASm9D6RcBo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-uB3P39bgPWWtQdZfxMmeVA-1; Mon,
 24 Mar 2025 07:01:02 -0400
X-MC-Unique: uB3P39bgPWWtQdZfxMmeVA-1
X-Mimecast-MFC-AGG-ID: uB3P39bgPWWtQdZfxMmeVA_1742814060
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 09060196B370;
	Mon, 24 Mar 2025 11:01:00 +0000 (UTC)
Received: from localhost (unknown [10.72.112.24])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC52719560AD;
	Mon, 24 Mar 2025 11:00:56 +0000 (UTC)
Date: Mon, 24 Mar 2025 19:00:47 +0800
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
Subject: Re: [PATCH v10 6/8] ima: kexec: move IMA log copy from kexec load to
 execute
Message-ID: <Z+E7X6LuQ82q1i5V@MiWiFi-R3L-srv>
References: <20250318010448.954-1-chenste@linux.microsoft.com>
 <20250318010448.954-7-chenste@linux.microsoft.com>
 <Z9t4LVpE470DMBYU@MiWiFi-R3L-srv>
 <3d7b5e06-5166-46bb-89dc-a0b95ca7c767@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d7b5e06-5166-46bb-89dc-a0b95ca7c767@linux.microsoft.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 03/21/25 at 09:23am, steven chen wrote:
> On 3/19/2025 7:06 PM, Baoquan He wrote:
> > On 03/17/25 at 06:04pm, steven chen wrote:
> > ...snip...
> > > ---
> > >   kernel/kexec_file.c                | 10 ++++++
> > >   security/integrity/ima/ima_kexec.c | 51 ++++++++++++++++++------------
> > >   2 files changed, 40 insertions(+), 21 deletions(-)
> > > 
> > > diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> > > index 606132253c79..ab449b43aaee 100644
> > > --- a/kernel/kexec_file.c
> > > +++ b/kernel/kexec_file.c
> > > @@ -201,6 +201,13 @@ kimage_validate_signature(struct kimage *image)
> > >   }
> > >   #endif
> > > +static void kimage_file_post_load(struct kimage *image)
> > > +{
> > > +#ifdef CONFIG_IMA_KEXEC
> > > +	ima_kexec_post_load(image);
> > > +#endif
> > > +}
> > > +
> > >   /*
> > >    * In file mode list of segments is prepared by kernel. Copy relevant
> > >    * data from user space, do error checking, prepare segment list
> > > @@ -428,6 +435,9 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, int, initrd_fd,
> > >   	kimage_terminate(image);
> > > +	if (!(flags & KEXEC_FILE_ON_CRASH))
> > > +		kimage_file_post_load(image);
> > machine_kexec_post_load() is called by both kexec_load and kexec_file_load,
> > we should use it to do things post load, but not introducing another
> > kimage_file_post_load().
> 
> Hi Baoquan,
> 
> Could you give me more detail about this?

I mean machine_kexec_post_load() is the place where post load operations
are done, including kexec_load and kexec_file_load. There's no need to
specifically introduce a kimage_file_post_load() to do post load
operaton for kexec_file_load.


