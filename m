Return-Path: <linux-integrity+bounces-7596-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D14C3E2A2
	for <lists+linux-integrity@lfdr.de>; Fri, 07 Nov 2025 02:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B46E188C6C4
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Nov 2025 01:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7547F25DD1E;
	Fri,  7 Nov 2025 01:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C1o4Loo8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF5B1DE8AE
	for <linux-integrity@vger.kernel.org>; Fri,  7 Nov 2025 01:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762480281; cv=none; b=VCZUL23OfCl7epQVhUn3StDLyqB46+669OJdxtfUMVFUdroANPcw/ejz7t6d4UedgKcnaUEbbBZQs5QHO93GW7KmQvL9c8TZYxCObSLzsfriS4tKonipmCagr+bCZ73ta+e7z0Xn+KfIN1Q7OOq0Jb1VoGvCjOUTXIQBiKb+Hx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762480281; c=relaxed/simple;
	bh=/XhvkqcfSrI8xxCWAmjwnsjk18iUp94t6qVbkIk1hFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHlJRPBeWFtxJ3Jcj/cBw/+i6nFphIYYrrexHS4s6kvSWwDLf3Q5Hi/0xOo53fupBrPZE9C14sSohRTonYG/9FVnU4n3MB0Ijhas2INIHkG9V5apenryxHHMIe6Mgwd/AOK6heqwSuqogTsfwGixd3kHmJR6wEaBHWu24Z599C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C1o4Loo8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762480278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dOE3+WNCmO2l7emNZOVxTGcMy/4xRS0btLplCRQG9Sg=;
	b=C1o4Loo8MxJPGNh3lJvJen+Z+9dIZWBowXwcs2vTzAYNYIL4whCNHeO8Ny3bSYQCfYG7EJ
	fPKo8a6ADKqWBF+zTi3FNbAiCeP3PCI12msw5CAyqezMKhQp9hnBX3dGKv0Vjb+nfozv3q
	dzb9v782hollQBLICTEGY4/qEDRDvMQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-CZ1givntP2GQytu_CEziNw-1; Thu,
 06 Nov 2025 20:51:13 -0500
X-MC-Unique: CZ1givntP2GQytu_CEziNw-1
X-Mimecast-MFC-AGG-ID: CZ1givntP2GQytu_CEziNw_1762480271
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 80CD81800358;
	Fri,  7 Nov 2025 01:51:11 +0000 (UTC)
Received: from localhost (unknown [10.72.112.190])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3DC881945110;
	Fri,  7 Nov 2025 01:51:08 +0000 (UTC)
Date: Fri, 7 Nov 2025 09:51:04 +0800
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
Message-ID: <aQ1QiLGXWRsZbiYo@MiWiFi-R3L-srv>
References: <20251106065904.10772-1-piliu@redhat.com>
 <20251106065904.10772-2-piliu@redhat.com>
 <aQxV2ULFzG/xrl7/@MiWiFi-R3L-srv>
 <CAF+s44TyM7sBVmGn7kn5Cw+Ygm02F93hchiSBN0Q_qR=oA+DLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF+s44TyM7sBVmGn7kn5Cw+Ygm02F93hchiSBN0Q_qR=oA+DLg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 11/06/25 at 06:01pm, Pingfan Liu wrote:
> On Thu, Nov 6, 2025 at 4:01 PM Baoquan He <bhe@redhat.com> wrote:
> >
> > On 11/06/25 at 02:59pm, Pingfan Liu wrote:
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
> >
> > Well, you didn't update the log accordingly.
> >
> 
> I am not sure what you mean. Do you mean the earlier content which I
> replied to you?

No. In v1, you return cma directly. But in v2, you return its direct
mapping address, isnt' it?

> 
> > Do you know why cma area can't be mapped into vmalloc?
> >
> Should not the kernel direct mapping be used?

When image->segment_cma[i] has value, image->ima_buffer_addr also
contains the physical address of the cma area, why cma physical address
can't be mapped into vmalloc and cause the failure and call trace?


