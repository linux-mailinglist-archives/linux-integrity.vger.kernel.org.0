Return-Path: <linux-integrity+bounces-7600-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB744C3F0CA
	for <lists+linux-integrity@lfdr.de>; Fri, 07 Nov 2025 10:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89D093AF675
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Nov 2025 09:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8DB2D5A07;
	Fri,  7 Nov 2025 09:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KRLTF2Ps"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A4230CD83
	for <linux-integrity@vger.kernel.org>; Fri,  7 Nov 2025 09:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762506020; cv=none; b=ZkDCl0bvSQG0MsvyxDTrW+W2BoqXicvUFjw3VCe51Evs9Cit7VB1ITp47UuZpVTXvT4xdIh6bl9uEybftzVZMmlImaU0amZQzg8fRfrGdxrkGYBjImuGkrxqEzS1SVbxlatUwy1o7d2NMav65dSFImLaJcjqlqji874YLzaxQwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762506020; c=relaxed/simple;
	bh=e9N6b1Inlr1RF79Gfe+7RY+AXNzKP+6dLRvgI9lyvZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YLyCoq/gmP1yp0VKXZz6hKy5hKsFnSdu/aN0bdSyiKUQWedivn0A8gGVsn3JQNoLJZR1PH3f8Bzro5m4eulCxaZ0RscEYgPGJJWDCXvf5IjAYSo6im0ejD/gdgdkbz6AaDp4IapsMs+kP3ol986U3BgdkKZ+oGdlDNB4qHf76kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KRLTF2Ps; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762506017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B6dH6qOvbZpXTox5E2tyza7Bx3lGotIR3uin2/BJTrM=;
	b=KRLTF2PsYWjBKSYi0azbxMvrlM7GtXujIbpdXcIwDKhbjXBbcPliJ/ND15HH5xkofvahGe
	uJYEidQ+J/IcqCu2OZ9Pei2q+QRTTKsztzN5KEzpq9TSxsAezi8/NipYSFxG2GvMpz5aEb
	MmmWZJSi7hiMZRPPbRMT6oHwYSsd9o0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-CKQqWQZWNgyT974p0nweZA-1; Fri,
 07 Nov 2025 04:00:16 -0500
X-MC-Unique: CKQqWQZWNgyT974p0nweZA-1
X-Mimecast-MFC-AGG-ID: CKQqWQZWNgyT974p0nweZA_1762506014
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 203D01956067;
	Fri,  7 Nov 2025 09:00:14 +0000 (UTC)
Received: from localhost (unknown [10.72.112.81])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DC0993001E83;
	Fri,  7 Nov 2025 09:00:11 +0000 (UTC)
Date: Fri, 7 Nov 2025 17:00:09 +0800
From: Pingfan Liu <piliu@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, linux-integrity@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Alexander Graf <graf@amazon.com>,
	Steven Chen <chenste@linux.microsoft.com>, stable@vger.kernel.org
Subject: Re: [PATCHv2 2/2] kernel/kexec: Fix IMA when allocation happens in
 CMA area
Message-ID: <aQ21GVR1pEjzWvw1@fedora>
References: <20251106065904.10772-1-piliu@redhat.com>
 <20251106065904.10772-2-piliu@redhat.com>
 <aQxV2ULFzG/xrl7/@MiWiFi-R3L-srv>
 <CAF+s44TyM7sBVmGn7kn5Cw+Ygm02F93hchiSBN0Q_qR=oA+DLg@mail.gmail.com>
 <aQ1QiLGXWRsZbiYo@MiWiFi-R3L-srv>
 <CAF+s44TOt+EwGi9VDES9PC+VaGZoDCw6rbyRv_mnb0xbaLScbg@mail.gmail.com>
 <aQ2C1UyJoyyuC/ZK@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQ2C1UyJoyyuC/ZK@MiWiFi-R3L-srv>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On Fri, Nov 07, 2025 at 01:25:41PM +0800, Baoquan He wrote:
> On 11/07/25 at 01:13pm, Pingfan Liu wrote:
> > On Fri, Nov 7, 2025 at 9:51 AM Baoquan He <bhe@redhat.com> wrote:
> > >
> > > On 11/06/25 at 06:01pm, Pingfan Liu wrote:
> > > > On Thu, Nov 6, 2025 at 4:01 PM Baoquan He <bhe@redhat.com> wrote:
> > > > >
> > > > > On 11/06/25 at 02:59pm, Pingfan Liu wrote:
> > > > > > When I tested kexec with the latest kernel, I ran into the following warning:
> > > > > >
> > > > > > [   40.712410] ------------[ cut here ]------------
> > > > > > [   40.712576] WARNING: CPU: 2 PID: 1562 at kernel/kexec_core.c:1001 kimage_map_segment+0x144/0x198
> > > > > > [...]
> > > > > > [   40.816047] Call trace:
> > > > > > [   40.818498]  kimage_map_segment+0x144/0x198 (P)
> > > > > > [   40.823221]  ima_kexec_post_load+0x58/0xc0
> > > > > > [   40.827246]  __do_sys_kexec_file_load+0x29c/0x368
> > > > > > [...]
> > > > > > [   40.855423] ---[ end trace 0000000000000000 ]---
> > > > > >
> > > > > > This is caused by the fact that kexec allocates the destination directly
> > > > > > in the CMA area. In that case, the CMA kernel address should be exported
> > > > > > directly to the IMA component, instead of using the vmalloc'd address.
> > > > >
> > > > > Well, you didn't update the log accordingly.
> > > > >
> > > >
> > > > I am not sure what you mean. Do you mean the earlier content which I
> > > > replied to you?
> > >
> > > No. In v1, you return cma directly. But in v2, you return its direct
> > > mapping address, isnt' it?
> > >
> > 
> > Yes. But I think it is a fault in the code, which does not convey the
> > expression in the commit log. Do you think I should rephrase the words
> > "the CMA kernel address" as "the CMA kernel direct mapping address"?
> 
> That's fine to me.
> 
> > 
> > > >
> > > > > Do you know why cma area can't be mapped into vmalloc?
> > > > >
> > > > Should not the kernel direct mapping be used?
> > >
> > > When image->segment_cma[i] has value, image->ima_buffer_addr also
> > > contains the physical address of the cma area, why cma physical address
> > > can't be mapped into vmalloc and cause the failure and call trace?
> > >
> > 
> > It could be done using the vmalloc approach, but it's unnecessary.
> > IIUC, kimage_map_segment() was introduced to provide a contiguous
> > virtual address for IMA access, since the IND_SRC pages are scattered
> > throughout the kernel. However, in the CMA case, there is already a
> > contiguous virtual address in the kernel direct mapping range.
> > Normally, when we have a physical address, we simply use
> > phys_to_virt() to get its corresponding kernel virtual address.
> 
> OK, I understand cma area is contiguous, and no need to map into
> vmalloc. I am wondering why in the old code mapping cma addrss into 
> vmalloc cause the warning which you said is a IMA problem. 
> 

It doesn't go that far. The old code doesn't map CMA into vmalloc'd
area.

void *kimage_map_segment(struct kimage *image, int idx)
{
	...
        for_each_kimage_entry(image, ptr, entry) {
                if (entry & IND_DESTINATION) {
                        dest_page_addr = entry & PAGE_MASK;
                } else if (entry & IND_SOURCE) {
                        if (dest_page_addr >= addr && dest_page_addr < eaddr) {
                                src_page_addr = entry & PAGE_MASK;
                                src_pages[i++] =
                                        virt_to_page(__va(src_page_addr));
                                if (i == npages)
                                        break;
                                dest_page_addr += PAGE_SIZE;
                        }
                }
        }

        /* Sanity check. */
        WARN_ON(i < npages);     //--> This is the warning thrown by kernel

        vaddr = vmap(src_pages, npages, VM_MAP, PAGE_KERNEL);
        kfree(src_pages);

        if (!vaddr)
                pr_err("Could not map ima buffer.\n");

        return vaddr;
}

When CMA is used, there is no IND_SOURCE, so we have i=0 < npages.
Now, I see how my words ("In that case, the CMA kernel address should be
exported directly to the IMA component, instead of using the vmalloc'd
address.") confused you. As for "instead of using the vmalloc'd
address", I meant to mention "vmap()" approach.


Best Regards,

Pingfan


