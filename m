Return-Path: <linux-integrity+bounces-7584-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3432EC394EE
	for <lists+linux-integrity@lfdr.de>; Thu, 06 Nov 2025 07:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28DB5188919C
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Nov 2025 06:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF6B264619;
	Thu,  6 Nov 2025 06:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gN9jbUhT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lD2feEks"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206752745C
	for <linux-integrity@vger.kernel.org>; Thu,  6 Nov 2025 06:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762412204; cv=none; b=tlQFTJ/i4czFl3q8E5j7bvHY4t0Da4MdvlZQP6Fco9z8JsZDvb2dcFFqEL76rt4bzgbE43QRwF4ylrfFOotoqk47pqXrJmLCrTX1QKpwFAnf4Q0dgUluYiL6IIXXCCKeUKI4UMUNhLRfhBb3E+hgfJMa5YrCVv+zdDBJ1njwp50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762412204; c=relaxed/simple;
	bh=gDZqYOCIth6O0bcbwk+V8t33y5xXJqbCn0M/YhiT7k8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nd8zm/oaXbdv2jykkkcbFUEuDu1zlc0z12df6F+CR0mnycaxa0vCU7sC3i6x89DxA4eG8ouZXvX4QjUKaIGqhZBsyG0oP/4cxDN/ha1uU/rHCdYuhm6U+Sie2WBEI1vdtKICsiwgzAps5QDCPlJt40OSPDkRSfH8znN5ZxYGSqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gN9jbUhT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lD2feEks; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762412201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5om+jgkF7lMNLCSif3n8iVPJleVZd8uHxQY35uUaYt4=;
	b=gN9jbUhTcWSanCaYniVKiSLS/il8Cc8CTr2PxIbHDFd8V1vbuy2ibzVjPePGoYQ97k9SzG
	c6ueOWDVLBoZZySURnke6uCP4TxWbE1xHmTvi8VNUEHWcJfb4oXoVjTIoOmvPsehabqREl
	4ajEusD5395V0j8x7wPzv/tyb1Xmcp4=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-buGSFfO9OlSTUWsAWN35kQ-1; Thu, 06 Nov 2025 01:56:39 -0500
X-MC-Unique: buGSFfO9OlSTUWsAWN35kQ-1
X-Mimecast-MFC-AGG-ID: buGSFfO9OlSTUWsAWN35kQ_1762412199
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b6cff817142so78967a12.1
        for <linux-integrity@vger.kernel.org>; Wed, 05 Nov 2025 22:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762412199; x=1763016999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5om+jgkF7lMNLCSif3n8iVPJleVZd8uHxQY35uUaYt4=;
        b=lD2feEksZN52otCl0XuktP9TNzRuYe+y5UDf21lVwTlL7Qy/ZL2AipTJwCEJItU7FP
         CklDdZ6d6bl2CDMblP1VZ2HqcOiJlLOX4cRe1A3AS0j6ozLAPr3n1gzeuN107nB4C0a+
         LZsSJNFkKUVNBulP3uIb7fJojZZKspK+8b9ow3vwgrmJg7VohZrUBxCM2P7O4E6IJHyH
         Y+UGn9H4rEZwFXV501ow5lmcWTQnxHJSUKdCwR7Zoi6L795UmbXMui/GiJ2QI864yubx
         ACJincZFtXxde3c9LdqNHVq16xY9RqVkAPfvYvl5JHiNPbuRkm9UHvrieZBMoDZ9ycLD
         ai8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762412199; x=1763016999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5om+jgkF7lMNLCSif3n8iVPJleVZd8uHxQY35uUaYt4=;
        b=oz97mXKS9J4BXsX5gu9FDlB0kDV/rX5KU+LdOrRX8UQoFBZQ/rB+rhxLRXp+Go36ju
         sfYJTSWipUU6TOq/CRb5O4YytMFUiju5G+hbh63V1kcA9xX/leVZlMlhrhwxMxY87R/b
         4q1EX4Qg/+htipfTVtu2wvLh6du/oAkvF/X7Vu1u/0Z2Rsw2zknjFXaTWdCP3mXnWkFL
         03uSpfN1PEJ2WiXmkZAtH/W9C6GVlfddHYeA8Ke8zRaeGE8goUA5f62/JNr5o4ofKdZf
         ATonHrbAYfrvr/NJeN/GBRPa1MVrn1GkymvIK60tguh6MpFUe88Bj46Bd4Ch/9S44O8E
         pluw==
X-Forwarded-Encrypted: i=1; AJvYcCUnPSwHFbN+/Aq/vfXh20l9+AFvXGfqZ3V6rI445s7xuw8olB42mUIqUfC3tcWzvvn/f4RnXA204kmJDpahnrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSkD2lQGR2cvHUsoinQJsztxRlq+SkJyGON+aUrb15qGyn/ojy
	auCgviuORx1afJAPm0w2OOXdRJqTqueil3UZBHE/6VTQpfBAlKw0L2tAdEtzFAY1qCjv/pMjUAb
	/Ci5fhuztX0k6bAkakcxgUrH6glvDR44cPVheAFY01orrBYM8uhg9G7i6HJk9Un/IO2klRYSWjC
	wWnYger4t1IsqO4ahTdCATd5aqZ2obE+YDvD6VyGTuoJCS
X-Gm-Gg: ASbGncuknQTFVoLaZqX/SJFpLVzuf8pf/xdq7EF9QacQtp34X32Ic5pRO2TS2sNGvqF
	rfhrPl9ZenAYtYTLLKgXaeZCyNzrqe7jSG+44dwiQXJS6c/LApg22B6+nQ4dxNs/AQEui0Sqez2
	u8/FTR1GLfGUZrwxT64nHerK1+qY5w2LXUonVgSzz6J6UW1y4rEtQ3RVIQ
X-Received: by 2002:a05:6a20:9186:b0:34e:e0ba:7c1 with SMTP id adf61e73a8af0-34f839e0371mr7539085637.6.1762412198851;
        Wed, 05 Nov 2025 22:56:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwXf06EEtGqGt59eNE630eIQryoAHY3nsXO3Hk+QYKm+lQdENUtVhqE0eUA9haxSSEpTHDrv5myNmqIZbmVw4=
X-Received: by 2002:a05:6a20:9186:b0:34e:e0ba:7c1 with SMTP id
 adf61e73a8af0-34f839e0371mr7539064637.6.1762412198513; Wed, 05 Nov 2025
 22:56:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105130922.13321-1-piliu@redhat.com> <20251105130922.13321-2-piliu@redhat.com>
 <aQwCDMhidg+a2Jzt@MiWiFi-R3L-srv> <CAF+s44StrV1USH4ZLQ6DRobXA=hXOs6EVkmeeeTsK-koWsV_KQ@mail.gmail.com>
 <aQwUUh3noWGXaite@MiWiFi-R3L-srv>
In-Reply-To: <aQwUUh3noWGXaite@MiWiFi-R3L-srv>
From: Pingfan Liu <piliu@redhat.com>
Date: Thu, 6 Nov 2025 14:56:27 +0800
X-Gm-Features: AWmQ_bmDJKbpbWUjPVU7pY3OEsXiayXePeKuaPXhcc9NBNJcotJApHoGGTl8gVw
Message-ID: <CAF+s44QzxjPpWkBLrO1WpORy+QTj2=mFRJFeuPsGvp9K=hfKJQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] kernel/kexec: Fix IMA when allocation happens in CMA area
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, linux-integrity@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Alexander Graf <graf@amazon.com>, 
	Steven Chen <chenste@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 6, 2025 at 11:22=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
>
> On 11/06/25 at 10:33am, Pingfan Liu wrote:
> > Hi Baoquan,
> >
> > Thanks for your review. Please see the comment below.
> >
> > On Thu, Nov 6, 2025 at 10:04=E2=80=AFAM Baoquan He <bhe@redhat.com> wro=
te:
> > >
> > > Hi Pingfan,
> > >
> > > On 11/05/25 at 09:09pm, Pingfan Liu wrote:
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
> > > >
> > > > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > Cc: Baoquan He <bhe@redhat.com>
> > > > Cc: Alexander Graf <graf@amazon.com>
> > > > Cc: Steven Chen <chenste@linux.microsoft.com>
> > > > Cc: linux-integrity@vger.kernel.org
> > > > To: kexec@lists.infradead.org
> > > > ---
> > > >  kernel/kexec_core.c | 7 ++++++-
> > > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > > > index 9a1966207041..abe40286a02c 100644
> > > > --- a/kernel/kexec_core.c
> > > > +++ b/kernel/kexec_core.c
> > > > @@ -967,6 +967,7 @@ void *kimage_map_segment(struct kimage *image, =
int idx)
> > > >       kimage_entry_t *ptr, entry;
> > > >       struct page **src_pages;
> > > >       unsigned int npages;
> > > > +     struct page *cma;
> > > >       void *vaddr =3D NULL;
> > > >       int i;
> > > >
> > > > @@ -974,6 +975,9 @@ void *kimage_map_segment(struct kimage *image, =
int idx)
> > > >       size =3D image->segment[idx].memsz;
> > > >       eaddr =3D addr + size;
> > > >
> > > > +     cma =3D image->segment_cma[idx];
> > >
> > > Thanks for your fix. But I totally can't get what you are doing. The =
idx
> > > passed into kimage_map_segment() could index image->segment[], and ca=
n
> > > index image->segment_cma[], could you reconsider and make the code mo=
re
> > > reasonable?
> > >
> >
> > Since idx can index both image->segment[] and segment_cma[], the
> > behavior differs based on whether segment_cma[idx] is NULL:
> >
> > - If segment_cma[idx] is not NULL, it points directly to the final
> > target location, eliminating the need for data copying that
> > traditional kexec relocation requires.
> > - If segment_cma[idx] is NULL, the segment relies on the traditional
> > kexec relocation code to copy its data.
>
> I see, thanks. While image->segment_cma[idx] records the struct page of
> the relevant cma area, but not virtual address. Is it OK for IMA later

Oops. It requires page_address(page) to convert the address. I will
send out V2 to fix it.

Thanks,

Pingfan


