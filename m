Return-Path: <linux-integrity+bounces-7598-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E70C3E81C
	for <lists+linux-integrity@lfdr.de>; Fri, 07 Nov 2025 06:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 572BA345A96
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Nov 2025 05:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DA416F0FE;
	Fri,  7 Nov 2025 05:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DArbjkgc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4067579DA
	for <linux-integrity@vger.kernel.org>; Fri,  7 Nov 2025 05:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762493156; cv=none; b=MSxYnEHHdgjQcCnGnibHW/0IXhLb4t5k/D4mVy9xkEWBiIxTk/R7nA6k6YaV7CfkBHhXKA9AWW19Rj1V8DlCuubWiMECjyJcnztbOXTskwWXl8KPaap2wFIR1oNQZfIl7gDwuxcZ7hpMiyKgS+IeQscUqaM4DX70Hw1Ikk9FbYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762493156; c=relaxed/simple;
	bh=FOIxSUOM7h3Hic7TDO2WM/pjYTkeJ8gT7KEAt/huqb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qALJO4WflV913M8tbINTAs7wv46hvU5B+8MvkGvmn7KK+SkmMVyhyZeNvQT02QfQTbDn7dvwefCJVxjbV9FpTF6f5VW07bEzzScoQxJVghLM2fwhosZlYg3a9o/yyRXFeavKcx6cQ+rQLbgPEqlchcwekCIzWrh8MT0qAJXsv8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DArbjkgc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762493154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xIpaacKZHnJUNIQ6uKG4gx1AM30s80yCIKhtIRTzyv0=;
	b=DArbjkgc2YyKn1WNfy79XsGHk3V/KAO+Yz+KGKNRW8eXURkZTZqJLD/TywklX1IrORYWeI
	14YCSJzSfrjMsQy4ffLIGfkGFuL4mBKNuJwJMXQUEyPwx6fWXdxe2j04V6+55bYktF1xkN
	AE3zOaD811izKjX/zXHEpSNUyoSterk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-Ga0bJ94AOjqLafsq0-eLSg-1; Fri,
 07 Nov 2025 00:25:51 -0500
X-MC-Unique: Ga0bJ94AOjqLafsq0-eLSg-1
X-Mimecast-MFC-AGG-ID: Ga0bJ94AOjqLafsq0-eLSg_1762493149
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 60FAD19560A7;
	Fri,  7 Nov 2025 05:25:48 +0000 (UTC)
Received: from localhost (unknown [10.72.112.190])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 839681945110;
	Fri,  7 Nov 2025 05:25:46 +0000 (UTC)
Date: Fri, 7 Nov 2025 13:25:41 +0800
From: Baoquan He <bhe@redhat.com>
To: Pingfan Liu <piliu@redhat.com>
Cc: kexec@lists.infradead.org, linux-integrity@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Alexander Graf <graf@amazon.com>,
	Steven Chen <chenste@linux.microsoft.com>, stable@vger.kernel.org
Subject: Re: [PATCHv2 2/2] kernel/kexec: Fix IMA when allocation happens in
 CMA area
Message-ID: <aQ2C1UyJoyyuC/ZK@MiWiFi-R3L-srv>
References: <20251106065904.10772-1-piliu@redhat.com>
 <20251106065904.10772-2-piliu@redhat.com>
 <aQxV2ULFzG/xrl7/@MiWiFi-R3L-srv>
 <CAF+s44TyM7sBVmGn7kn5Cw+Ygm02F93hchiSBN0Q_qR=oA+DLg@mail.gmail.com>
 <aQ1QiLGXWRsZbiYo@MiWiFi-R3L-srv>
 <CAF+s44TOt+EwGi9VDES9PC+VaGZoDCw6rbyRv_mnb0xbaLScbg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF+s44TOt+EwGi9VDES9PC+VaGZoDCw6rbyRv_mnb0xbaLScbg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 11/07/25 at 01:13pm, Pingfan Liu wrote:
> On Fri, Nov 7, 2025 at 9:51 AM Baoquan He <bhe@redhat.com> wrote:
> >
> > On 11/06/25 at 06:01pm, Pingfan Liu wrote:
> > > On Thu, Nov 6, 2025 at 4:01 PM Baoquan He <bhe@redhat.com> wrote:
> > > >
> > > > On 11/06/25 at 02:59pm, Pingfan Liu wrote:
> > > > > When I tested kexec with the latest kernel, I ran into the following warning:
> > > > >
> > > > > [   40.712410] ------------[ cut here ]------------
> > > > > [   40.712576] WARNING: CPU: 2 PID: 1562 at kernel/kexec_core.c:1001 kimage_map_segment+0x144/0x198
> > > > > [...]
> > > > > [   40.816047] Call trace:
> > > > > [   40.818498]  kimage_map_segment+0x144/0x198 (P)
> > > > > [   40.823221]  ima_kexec_post_load+0x58/0xc0
> > > > > [   40.827246]  __do_sys_kexec_file_load+0x29c/0x368
> > > > > [...]
> > > > > [   40.855423] ---[ end trace 0000000000000000 ]---
> > > > >
> > > > > This is caused by the fact that kexec allocates the destination directly
> > > > > in the CMA area. In that case, the CMA kernel address should be exported
> > > > > directly to the IMA component, instead of using the vmalloc'd address.
> > > >
> > > > Well, you didn't update the log accordingly.
> > > >
> > >
> > > I am not sure what you mean. Do you mean the earlier content which I
> > > replied to you?
> >
> > No. In v1, you return cma directly. But in v2, you return its direct
> > mapping address, isnt' it?
> >
> 
> Yes. But I think it is a fault in the code, which does not convey the
> expression in the commit log. Do you think I should rephrase the words
> "the CMA kernel address" as "the CMA kernel direct mapping address"?

That's fine to me.

> 
> > >
> > > > Do you know why cma area can't be mapped into vmalloc?
> > > >
> > > Should not the kernel direct mapping be used?
> >
> > When image->segment_cma[i] has value, image->ima_buffer_addr also
> > contains the physical address of the cma area, why cma physical address
> > can't be mapped into vmalloc and cause the failure and call trace?
> >
> 
> It could be done using the vmalloc approach, but it's unnecessary.
> IIUC, kimage_map_segment() was introduced to provide a contiguous
> virtual address for IMA access, since the IND_SRC pages are scattered
> throughout the kernel. However, in the CMA case, there is already a
> contiguous virtual address in the kernel direct mapping range.
> Normally, when we have a physical address, we simply use
> phys_to_virt() to get its corresponding kernel virtual address.

OK, I understand cma area is contiguous, and no need to map into
vmalloc. I am wondering why in the old code mapping cma addrss into 
vmalloc cause the warning which you said is a IMA problem. 


