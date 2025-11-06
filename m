Return-Path: <linux-integrity+bounces-7583-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D2EC38F48
	for <lists+linux-integrity@lfdr.de>; Thu, 06 Nov 2025 04:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 910A31A23926
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Nov 2025 03:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128312BE059;
	Thu,  6 Nov 2025 03:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLsFEy5n"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211578834
	for <linux-integrity@vger.kernel.org>; Thu,  6 Nov 2025 03:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762399331; cv=none; b=MrlsiIfbO42fpByeCvxHtcVEnrCqOLd88JC7HCwuhnsrYBwj3kMkcvKYgQoQYBlgIYCLh5l6FmFyNl5YYDhaDpYJLr4eoU7qY357qQcWOtekNYMTKdKdElr4G4mdDjHtfX9sMBSlrVIwqS0cNt1NawlpfhMxieZ7UyYh3w5rUHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762399331; c=relaxed/simple;
	bh=O38N4sUk/AEMivEXYB5Em6LMlITJb1yd9CiGqmV9h2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nqovW8lAzZxACKjhsdNSm10gAwWtG/Fh2CPCsbyT9p83UTQjkKgOGeOVJBjoi84FMrzV/Itkuh4SaSJzp59V4kJEWHagHLiAuCeMF0SoH0Q1ToXAA40oh8Qoz4miziPSJshFrxFC4c6MyVJztQYSgCbwI7RoiwEzFOQOvBWwP1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gLsFEy5n; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762399328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+rv33evyCdtZ/WOHyRrPfVlUnSklHK0ydY8JP6rULH8=;
	b=gLsFEy5nExj6zbWRgGCL0LjDPGAMORivV0JkmdLED32WTAze7zRSdeI7WJiAXfzN8Gxtmq
	GC7yOLruGItMGwANze8MKpCDffUcwUpSTVs00OMhJ+yS1BzdeEI7wI9DuX6XkrgX5chmek
	HayXuoncEbhaAPf5v337zd2wO23Aymw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-8TnxEnnfP1ut28_PEjFtyg-1; Wed,
 05 Nov 2025 22:22:03 -0500
X-MC-Unique: 8TnxEnnfP1ut28_PEjFtyg-1
X-Mimecast-MFC-AGG-ID: 8TnxEnnfP1ut28_PEjFtyg_1762399322
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 44AC919560B2;
	Thu,  6 Nov 2025 03:22:01 +0000 (UTC)
Received: from localhost (unknown [10.72.112.190])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E67DA1956095;
	Thu,  6 Nov 2025 03:21:58 +0000 (UTC)
Date: Thu, 6 Nov 2025 11:21:54 +0800
From: Baoquan He <bhe@redhat.com>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, linux-integrity@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Alexander Graf <graf@amazon.com>,
	Steven Chen <chenste@linux.microsoft.com>
Subject: Re: [PATCH 2/2] kernel/kexec: Fix IMA when allocation happens in CMA
 area
Message-ID: <aQwUUh3noWGXaite@MiWiFi-R3L-srv>
References: <20251105130922.13321-1-piliu@redhat.com>
 <20251105130922.13321-2-piliu@redhat.com>
 <aQwCDMhidg+a2Jzt@MiWiFi-R3L-srv>
 <CAF+s44StrV1USH4ZLQ6DRobXA=hXOs6EVkmeeeTsK-koWsV_KQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF+s44StrV1USH4ZLQ6DRobXA=hXOs6EVkmeeeTsK-koWsV_KQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 11/06/25 at 10:33am, Pingfan Liu wrote:
> Hi Baoquan,
> 
> Thanks for your review. Please see the comment below.
> 
> On Thu, Nov 6, 2025 at 10:04 AM Baoquan He <bhe@redhat.com> wrote:
> >
> > Hi Pingfan,
> >
> > On 11/05/25 at 09:09pm, Pingfan Liu wrote:
> > > When I tested kexec with the latest kernel, I ran into the following warning:
> > >
> > > [   40.712410] ------------[ cut here ]------------
> > > [   40.712576] WARNING: CPU: 2 PID: 1562 at kernel/kexec_core.c:1001 kimage_map_segment+0x144/0x198
> > > [...]
> > > [   40.816047] Call trace:
> > > [   40.818498]  kimage_map_segment+0x144/0x198 (P)
> > > [   40.823221]  ima_kexec_post_load+0x58/0xc0
> > > [   40.827246]  __do_sys_kexec_file_load+0x29c/0x368
> > > [...]
> > > [   40.855423] ---[ end trace 0000000000000000 ]---
> > >
> > > This is caused by the fact that kexec allocates the destination directly
> > > in the CMA area. In that case, the CMA kernel address should be exported
> > > directly to the IMA component, instead of using the vmalloc'd address.
> > >
> > > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: Baoquan He <bhe@redhat.com>
> > > Cc: Alexander Graf <graf@amazon.com>
> > > Cc: Steven Chen <chenste@linux.microsoft.com>
> > > Cc: linux-integrity@vger.kernel.org
> > > To: kexec@lists.infradead.org
> > > ---
> > >  kernel/kexec_core.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > > index 9a1966207041..abe40286a02c 100644
> > > --- a/kernel/kexec_core.c
> > > +++ b/kernel/kexec_core.c
> > > @@ -967,6 +967,7 @@ void *kimage_map_segment(struct kimage *image, int idx)
> > >       kimage_entry_t *ptr, entry;
> > >       struct page **src_pages;
> > >       unsigned int npages;
> > > +     struct page *cma;
> > >       void *vaddr = NULL;
> > >       int i;
> > >
> > > @@ -974,6 +975,9 @@ void *kimage_map_segment(struct kimage *image, int idx)
> > >       size = image->segment[idx].memsz;
> > >       eaddr = addr + size;
> > >
> > > +     cma = image->segment_cma[idx];
> >
> > Thanks for your fix. But I totally can't get what you are doing. The idx
> > passed into kimage_map_segment() could index image->segment[], and can
> > index image->segment_cma[], could you reconsider and make the code more
> > reasonable?
> >
> 
> Since idx can index both image->segment[] and segment_cma[], the
> behavior differs based on whether segment_cma[idx] is NULL:
> 
> - If segment_cma[idx] is not NULL, it points directly to the final
> target location, eliminating the need for data copying that
> traditional kexec relocation requires.
> - If segment_cma[idx] is NULL, the segment relies on the traditional
> kexec relocation code to copy its data.

I see, thanks. While image->segment_cma[idx] records the struct page of
the relevant cma area, but not virtual address. Is it OK for IMA later
to update? ima_kexec_buffer is supposed to be a virtual address,
wondering how IMA behaved in this case.


