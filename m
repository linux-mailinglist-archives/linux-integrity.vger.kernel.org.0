Return-Path: <linux-integrity+bounces-7582-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E15C38EE0
	for <lists+linux-integrity@lfdr.de>; Thu, 06 Nov 2025 03:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59AEC3AF9FF
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Nov 2025 02:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD006347DD;
	Thu,  6 Nov 2025 02:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wr3dypEu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GcWflOZ6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EAF21C9F4
	for <linux-integrity@vger.kernel.org>; Thu,  6 Nov 2025 02:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762397870; cv=none; b=cTMcvEsAr3iZRiOCkyxmJn75BxabMabGW2XFLNHljcMajJ/JwrUOmVtGPBiFqtaM3VqpiaZOTFShglxZEFPH9B5URZbs6Pe9SMVrOz1HjZ30nJ95OVdyArGuTZ1Hd0+NvguyN7uNcfgMBRK+4VEuZNP2U/aEiRZfdbBGiS6gbDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762397870; c=relaxed/simple;
	bh=wkYz3boPTrd9hx+LQ3dHGOQJz+Rcj8w+Sye1S1tRc/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PHEbur5dbTvVruo+7HRipTSjsrXdquJTyzrn5c2px0bukNdGD1Q92EW0C4/xJNCvflDZgpDPHuoq9ATbA34c0vdOZgCgangEcmGbtjs0tQzjW+dIOOwbWxi7w+93gJU1htU8pJbTRcaCc820AmuWqTUox1gZqr0LSszh5momQD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wr3dypEu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GcWflOZ6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762397867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=slblRylilQ6M2X0WE8OcDYCIw0p06zXZrD4s6pa/lbc=;
	b=Wr3dypEu3DwXemgN//DzNwgfstJJm66bwJ/+A+AQdi8K0sDNiFsC3fDaEnrbBB9eQdCYJR
	OOw747WrXy3VREqLSpHN8WJE8aSuHlXyYo4jMehIcHLmkxqUb80MFh/No36E505KGbWKGX
	htMAK07Tcpl3kThJ6R0vRaQUv8IobXI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-22-iq9zrsToMjmmMz_q1RNnWw-1; Wed, 05 Nov 2025 21:57:46 -0500
X-MC-Unique: iq9zrsToMjmmMz_q1RNnWw-1
X-Mimecast-MFC-AGG-ID: iq9zrsToMjmmMz_q1RNnWw_1762397865
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b993eb2701bso457933a12.0
        for <linux-integrity@vger.kernel.org>; Wed, 05 Nov 2025 18:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762397865; x=1763002665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slblRylilQ6M2X0WE8OcDYCIw0p06zXZrD4s6pa/lbc=;
        b=GcWflOZ6w74LS/WJiD0hPxPxXkn24LEfGiJf3IhRqnqZ2pEMcLnC5aysREWNYSIXUF
         s6WPwl9bQnVvPqGKXNU6golrLI44Tr4mX2E6le6aoA6IOjl7/oyrsaxI1g30TjawAJ6+
         SStmZdkuqrWue5g/s5a8AocwPtyjg81krTSPSUFU5e3NUsREagzw1i0FsG2UTQ2CNpeJ
         CkvUg8t74RtHqyiKD4Enl2LuGDkxqQoGmj3qqdfaFgzBSbX3QwOlYgsshaud9kWN4nVy
         sPTBHRj51pXNimflz9FlQ47bHXuQOQ5qP9B+tbO+Jx5W5q/jZDFlRxiMv7fqmA8Sm5Gv
         F8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762397865; x=1763002665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=slblRylilQ6M2X0WE8OcDYCIw0p06zXZrD4s6pa/lbc=;
        b=u/oXXklJiaVoARRYgviJifiBob32tzqwtEcN0uz+AwmgSVdcGB47afSj7oAk/0zMzT
         JlTLqhG+XsQhlRzB4fxPtx/rVlxpRtrrM36/MBPLkFBtm8lZ+VkqmG8Z96fRod7jFbmF
         6Hnddb3w5r80j957rzOXyXvKOwSQW802F7lN7t0ip+hv1qSUrCr+Xg8ncp5U16QRMfdB
         r/h52qeL8mHvAe8RVOICUWYWvR/8XDgPgdG5GcXR29eyPrfysXxTDZg9+rDWEflKkY5R
         /Isb02OgTf4/0EYBhC0qSm0iS44OQ5gYUPdNG4Bz/7Ysa2q2ObgJgxqT2J/IpfZwL8Fo
         cHVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWPl/POgjpxqskrJO9cCrUGapbdgSpCI6QytUBNos/7r+034r330DuNk4Ce3wLutoff57iW1xgKSzpd9WncL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+B85+mjaD5ffIgsn4lR1knS1bh82xHUPhh6mO3b+gDI4718kP
	LY/oSqkg8d+9H0uPrPM6uAKQtia0Ydfp0Pv0SKJ3sJPyvoGMKQs1IM1Ul1h4qFNkyfNFCLFIXGo
	t+wcAsVjs2bxx4SeCQE+vydMnCOTAx5lw93hED5ACmxP7ZQ0/pZGgqsbQLA1rHQj7gnJk9r7Y4w
	hmdVZPRS1kP78S4XEiEchB8uMoH32QYttG/m5BQbobeP0w
X-Gm-Gg: ASbGnctbn0FD5RVL2vClJTRDR1skVSVRjCnx4PTJ5Hd+D8123FedglMw7C5/vv0Mn34
	j4ka5OTNoErX59GhX/dTEKJDt1rrhw3gy0rvbqE6YSCT7XoD2gu5HOosvKQv9UZU1AsS9s4btcn
	lIbCaGZmzwPtMPgb/4vRIv8cawxCJdfJDxENGom0XwNInDYWg8h6I0enZy
X-Received: by 2002:a05:6a20:7348:b0:34f:2070:89d5 with SMTP id adf61e73a8af0-34f837ed94fmr7077084637.11.1762397865001;
        Wed, 05 Nov 2025 18:57:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEe8uHe7goyRuu8m6/4rwiFnDugjzDE8LKo86uWxHT6jkeAMOKp4BgF/oU3hKo1Dh0MXAF9xYKE+VPVLVKvYqo=
X-Received: by 2002:a05:6a20:7348:b0:34f:2070:89d5 with SMTP id
 adf61e73a8af0-34f837ed94fmr7077066637.11.1762397864670; Wed, 05 Nov 2025
 18:57:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105130922.13321-1-piliu@redhat.com> <20251105130922.13321-2-piliu@redhat.com>
 <20251105161432.98eb69f87f30627a9067e78e@linux-foundation.org>
In-Reply-To: <20251105161432.98eb69f87f30627a9067e78e@linux-foundation.org>
From: Pingfan Liu <piliu@redhat.com>
Date: Thu, 6 Nov 2025 10:57:33 +0800
X-Gm-Features: AWmQ_bl1CsW5GOjYsR7a93ovnjO_qIEghN_IGpbfoju6yo-L0_Cfu3T_kBreRDQ
Message-ID: <CAF+s44Qoai54qUDqmVQoqWspneuuYF=SLYezoew_EHb_0By77w@mail.gmail.com>
Subject: Re: [PATCH 2/2] kernel/kexec: Fix IMA when allocation happens in CMA area
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kexec@lists.infradead.org, linux-integrity@vger.kernel.org, 
	Baoquan He <bhe@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Alexander Graf <graf@amazon.com>, 
	Steven Chen <chenste@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Thanks for your help, but on second thought, I think the Fixes commit is wr=
ong.

On Thu, Nov 6, 2025 at 8:14=E2=80=AFAM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Wed,  5 Nov 2025 21:09:22 +0800 Pingfan Liu <piliu@redhat.com> wrote:
>
> > When I tested kexec with the latest kernel, I ran into the following wa=
rning:
> >
> > [   40.712410] ------------[ cut here ]------------
> > [   40.712576] WARNING: CPU: 2 PID: 1562 at kernel/kexec_core.c:1001 ki=
mage_map_segment+0x144/0x198
> > [...]
> > [   40.816047] Call trace:
> > [   40.818498]  kimage_map_segment+0x144/0x198 (P)
> > [   40.823221]  ima_kexec_post_load+0x58/0xc0
> > [   40.827246]  __do_sys_kexec_file_load+0x29c/0x368
> > [...]
> > [   40.855423] ---[ end trace 0000000000000000 ]---
> >
> > This is caused by the fact that kexec allocates the destination directl=
y
> > in the CMA area. In that case, the CMA kernel address should be exporte=
d
> > directly to the IMA component, instead of using the vmalloc'd address.
>
> This is something we should backport into tearlier kernels.
>
> > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Alexander Graf <graf@amazon.com>
> > Cc: Steven Chen <chenste@linux.microsoft.com>
> > Cc: linux-integrity@vger.kernel.org
> > To: kexec@lists.infradead.org
>
> So I'm thinking we should add
>
> Fixes: 0091d9241ea2 ("kexec: define functions to map and unmap segments")
Should be:
Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")

Because 07d24902977e came after 0091d9241ea2 and introduced this issue.

Thanks,

Pingfan

> Cc: <stable@vger.kernel.org>
>
> yes?
>


