Return-Path: <linux-integrity+bounces-7597-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DEBC3E7D5
	for <lists+linux-integrity@lfdr.de>; Fri, 07 Nov 2025 06:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 01F2E34A6DC
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Nov 2025 05:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E5624A05D;
	Fri,  7 Nov 2025 05:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g34hhla2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="V94tihce"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390E41D5CC7
	for <linux-integrity@vger.kernel.org>; Fri,  7 Nov 2025 05:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762492405; cv=none; b=hk5NGGZtlJZFOip017dobEvwYECnPZ3yPhjnxPF7gE6ll5F96Ca+2yu2giR59M2DWVcHigZali0LigBSAOBJN+JsnQWgkmgTaT8IEYaX2t19SNnYlrUp2irbX26aQ0RrjR3SfunrBtmb8Inm83+wyFyWmv/rTYNN8kFzBxRUZdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762492405; c=relaxed/simple;
	bh=ZIsBTYWUFLGXTK0AUGZHEEBgJ8apuFFsuOBJhtVbjQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/m/Wy0T8wNzNs0/LxDF/FUOCHXFvo2+Kl1oCC/D5HbJvEmiXdOYbjI/rhcP7vXEPQ0eXP36AHDJvxD1+iud4nMIf/Tzg48tf4zDw0RMqS0sJDtnzrgkyHMpT6RaEKvjAO9HltuRgnr0tAJ6vTlSleHwZLy5g/uZnNhgc6SkMyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g34hhla2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=V94tihce; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762492403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W0ktgKXX1tu61oIJx16zbrm1RqzWRTsWJeEX4fpPY8s=;
	b=g34hhla2IFCePzYXOqdObBfAOP7GEtbr3cNO5ZQA20upanAUQuPdrIh5knYUiaN1PXq3NT
	gHuATqwu02UP267sOEu0kldB481hcDHXKKvp3CqRtOejEqbiVEcpCSXqD5p7s2YQMdH+P5
	J1teSRGxFiYqCeplLy6RS8A3Kpdw0Tg=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-FA04qLOYO3yUiSRA-uKL0A-1; Fri, 07 Nov 2025 00:13:21 -0500
X-MC-Unique: FA04qLOYO3yUiSRA-uKL0A-1
X-Mimecast-MFC-AGG-ID: FA04qLOYO3yUiSRA-uKL0A_1762492401
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-272b7bdf41fso7795585ad.0
        for <linux-integrity@vger.kernel.org>; Thu, 06 Nov 2025 21:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762492401; x=1763097201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W0ktgKXX1tu61oIJx16zbrm1RqzWRTsWJeEX4fpPY8s=;
        b=V94tihcet5vJoMEHp4SpgjO+8hfCB1RQJHxdmSWbBgno8H6dBxsIgcdkSHlT1vz9g4
         h8tsm73AV8iW0kKNh8yophMJ0OnSVnri0RtQ4cpZcrwlRKaf1MtweNk2bpANn7BwEbFt
         00PpV38oeK2ATeJ5N6KB7soJkIyvNsfFbo5w1x7JOs7o4NU0uURRidwrDHlNxTdcUSZh
         uQUx4lRUsTL4P61sbi0coefkYofriEL++6Xv5K1AMuvNQrh5YiEDt75qcKXNawTIeX+D
         9E+iWfYuGZaPgbtXQuyN0wnRzk4zVc5l0tbt3NM8wTvNLd8v3jMoIJ8vMZccqBvEnuS6
         JBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762492401; x=1763097201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W0ktgKXX1tu61oIJx16zbrm1RqzWRTsWJeEX4fpPY8s=;
        b=jQu6XmWzaIM6HZgcYkm0MfVW88HY91vsZWuE/vIHOwnaFNaD02iCNFWzGF98o8+1nV
         NQggryOy+gAhkveDvFt7KHBSgwau3MxJ9dx4nP4UhMPdna25V9wGTCRp06CKqsjWnwLr
         k7U2QbEYI+/EHNxeSDhKVzXzhx3EOh1SeH8Q+nfiuWp9w85Anc1Mtdp9mhhR+aZHWEbD
         XXZJw/YEYC5Q5oANQCKBaeYDJ/vq7oC2MnoYOoNk6YnR2uFmT1jloECla7B5uUCRxPIC
         qRtMv8GWZ6hWbROZrvQLZb9AmQHp4D6S6FphUEGwY62RarPJTPYbAidnjiM0Yuet33Jr
         8VWQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2Fc/KY7yOWhspXyNrE29sAfboIAi1lrZRm62zi7t1ko5/DCGyQzTi/cyJWC9NcQ667HXDJ9ovk1iBidyGkP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM3PElugi2BJp2aQfRj/fpgq0g500CUzAyHtx+TohCezhanOWO
	mHNdt53QVmX7THdwk9sC6YZ9a5GzKSfy7rlZMqrFO+cpd5GwQw09D7sPqjMQey2JRgNMf8PiQYs
	q2z5nLVJ8GYW4/cwz5md/5ACiEng97eDDYrsT2cDDJYeqGV1DSMyJ3z1yMxqEl/zIqifzxRFwuN
	RuXgR0/5UC/3jCWqKDYY2+Et0XFlz+Desjpmf2b8GnEYUB
X-Gm-Gg: ASbGncs5jQdMLByEwXOiVP9OGjJWKZjNeo2SKEL/Pjn48r34tkQfexHgIR59XxdK2zl
	Q/hDE/H6MNrTwvOQMcw2YsCCzMTgfJJS/GOWHTq7If5d0sCyF6Q8cU5Dzr1Qv2EO8RnK9HYN0pr
	JQ1abAF+4JnFGDWKamA0foNpJrTwMXacibgqDua/B+D2HuO8djjRjJIX9x
X-Received: by 2002:a17:902:d508:b0:295:9965:7021 with SMTP id d9443c01a7336-297c03daf18mr24625175ad.22.1762492400768;
        Thu, 06 Nov 2025 21:13:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8T6T7vG/XmMg85Jq0G+1OqwDe9Xy/LR4JGrW/6HDZoTaLUVg2B414cy7egtEHVPNipGuVTrL6XbjU/2zIHgM=
X-Received: by 2002:a17:902:d508:b0:295:9965:7021 with SMTP id
 d9443c01a7336-297c03daf18mr24624875ad.22.1762492400245; Thu, 06 Nov 2025
 21:13:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106065904.10772-1-piliu@redhat.com> <20251106065904.10772-2-piliu@redhat.com>
 <aQxV2ULFzG/xrl7/@MiWiFi-R3L-srv> <CAF+s44TyM7sBVmGn7kn5Cw+Ygm02F93hchiSBN0Q_qR=oA+DLg@mail.gmail.com>
 <aQ1QiLGXWRsZbiYo@MiWiFi-R3L-srv>
In-Reply-To: <aQ1QiLGXWRsZbiYo@MiWiFi-R3L-srv>
From: Pingfan Liu <piliu@redhat.com>
Date: Fri, 7 Nov 2025 13:13:08 +0800
X-Gm-Features: AWmQ_bmGo8t7MYMvGxRXRnitDpV3IZ3fxlMGNwTpftxWFt9y83Ffevv1Zkj9yTs
Message-ID: <CAF+s44TOt+EwGi9VDES9PC+VaGZoDCw6rbyRv_mnb0xbaLScbg@mail.gmail.com>
Subject: Re: [PATCHv2 2/2] kernel/kexec: Fix IMA when allocation happens in
 CMA area
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, linux-integrity@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Alexander Graf <graf@amazon.com>, 
	Steven Chen <chenste@linux.microsoft.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 7, 2025 at 9:51=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
>
> On 11/06/25 at 06:01pm, Pingfan Liu wrote:
> > On Thu, Nov 6, 2025 at 4:01=E2=80=AFPM Baoquan He <bhe@redhat.com> wrot=
e:
> > >
> > > On 11/06/25 at 02:59pm, Pingfan Liu wrote:
> > > > When I tested kexec with the latest kernel, I ran into the followin=
g warning:
> > > >
> > > > [   40.712410] ------------[ cut here ]------------
> > > > [   40.712576] WARNING: CPU: 2 PID: 1562 at kernel/kexec_core.c:100=
1 kimage_map_segment+0x144/0x198
> > > > [...]
> > > > [   40.816047] Call trace:
> > > > [   40.818498]  kimage_map_segment+0x144/0x198 (P)
> > > > [   40.823221]  ima_kexec_post_load+0x58/0xc0
> > > > [   40.827246]  __do_sys_kexec_file_load+0x29c/0x368
> > > > [...]
> > > > [   40.855423] ---[ end trace 0000000000000000 ]---
> > > >
> > > > This is caused by the fact that kexec allocates the destination dir=
ectly
> > > > in the CMA area. In that case, the CMA kernel address should be exp=
orted
> > > > directly to the IMA component, instead of using the vmalloc'd addre=
ss.
> > >
> > > Well, you didn't update the log accordingly.
> > >
> >
> > I am not sure what you mean. Do you mean the earlier content which I
> > replied to you?
>
> No. In v1, you return cma directly. But in v2, you return its direct
> mapping address, isnt' it?
>

Yes. But I think it is a fault in the code, which does not convey the
expression in the commit log. Do you think I should rephrase the words
"the CMA kernel address" as "the CMA kernel direct mapping address"?

> >
> > > Do you know why cma area can't be mapped into vmalloc?
> > >
> > Should not the kernel direct mapping be used?
>
> When image->segment_cma[i] has value, image->ima_buffer_addr also
> contains the physical address of the cma area, why cma physical address
> can't be mapped into vmalloc and cause the failure and call trace?
>

It could be done using the vmalloc approach, but it's unnecessary.
IIUC, kimage_map_segment() was introduced to provide a contiguous
virtual address for IMA access, since the IND_SRC pages are scattered
throughout the kernel. However, in the CMA case, there is already a
contiguous virtual address in the kernel direct mapping range.
Normally, when we have a physical address, we simply use
phys_to_virt() to get its corresponding kernel virtual address.

Thanks,

Pingfan


