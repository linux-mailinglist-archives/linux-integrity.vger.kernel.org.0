Return-Path: <linux-integrity+bounces-7581-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C58D9C38E0E
	for <lists+linux-integrity@lfdr.de>; Thu, 06 Nov 2025 03:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F2063A58ED
	for <lists+linux-integrity@lfdr.de>; Thu,  6 Nov 2025 02:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FF981724;
	Thu,  6 Nov 2025 02:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iJ1mZUXx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JA6RS9AX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353318F54
	for <linux-integrity@vger.kernel.org>; Thu,  6 Nov 2025 02:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762396415; cv=none; b=lQcMNMKbyZrATkS5cR3xg6lRy29TxfWRBxsqUhQS2EHF7sT6Ng7iZB3V8mxq8s0Ah7DQVbxc3rzSCQyfqhDBTd+YP/z6uAU9uROZ3XtmsGszLa92V+KpWGggiEMfCTd04dU4KWuVgA2CEibQrj30KCfbu1/1yP+p23xJdyucVdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762396415; c=relaxed/simple;
	bh=1MPhxeVTa3ttWNWqvvfMFg97jOkmRNjk+eyZtRxsUU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=osg8Wwe0OQ4UWaaJdnEwid/aPebtoxVD0bZCeHSqSBBOeR+cfcRnFaLjyA86AsaxFVu5mZREgf12vUdMEelhNb+eH8U5J1NlNxz3zpMruBvjbvbuhtusCtmd8l7Hgj2C3RQRx1z/wlTAjMzCM6b8pqlYDCPb35+F0RxSMwaY66k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iJ1mZUXx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JA6RS9AX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762396412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yKO0jQM7c+UeOx9mMhDNDpMYJPkI1D9+LEqkYZlqE/I=;
	b=iJ1mZUXxZjd974+fiuTZO9YjzAKkPyKQ+wkre/pDmZ+zvaCsmszgKRBejRb3z8RsTdK7hG
	VE2++333IvbY5JqF1W1cEU0nqm8/ftSyTL6ijCwljXfzPIITk3I6nBLPvKh9pSks4hVcPH
	Y0WCR42KCx9ETZ7DOL0NIJoHko0ak9o=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-le464zImMeK2_xDqPNSttw-1; Wed, 05 Nov 2025 21:33:30 -0500
X-MC-Unique: le464zImMeK2_xDqPNSttw-1
X-Mimecast-MFC-AGG-ID: le464zImMeK2_xDqPNSttw_1762396409
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b6097ca315bso967634a12.3
        for <linux-integrity@vger.kernel.org>; Wed, 05 Nov 2025 18:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762396409; x=1763001209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKO0jQM7c+UeOx9mMhDNDpMYJPkI1D9+LEqkYZlqE/I=;
        b=JA6RS9AXvN17ez+RVx3ybhbhFdnRGAeS1+TqPRws8GXFsTIwpAkso32//+GgELtie7
         o/sTBelKt9O1fP7CTNTa+B4R58oewbjJCWeNuW7N8bqLB5Wq8U2ZiWOM14QNrTdRCLMe
         e5Dw+QvgBKFTTQSRbKmXTi98tiIqEzH18DTLEVbdlKu2APExNtw5/ElnWa45eLNGT6WR
         zjA+NSAhETCR2UClB6ZXzoVYRuuZz3I9KyzZba7U/0nlhYwZZSN/FYF8OYY2sts2lGM0
         HaoEstW3mGssp244Wvf5M7EJu2MLZa34T1JtZa7NmNHvhpUjYAhiN73FFDNzVy8f0n5E
         Y80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762396409; x=1763001209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yKO0jQM7c+UeOx9mMhDNDpMYJPkI1D9+LEqkYZlqE/I=;
        b=fhfA0Y7eGCV6J784nhrU/xxTDzozLJI8gIoPSuU805bRvqbVWwyqvEGhD+IVI+/Sft
         VZez2Mm7k2us+QJzK6UwzafiA1aQeBujIiZw+IdUyzt4g1I06lMDoo99yDURnm4GOGhB
         rd7y7Lh/eGJ7/DWLnKD0vdcBbGoN3SsMuCFfYYE3WyxWsBZ9/nsoLKkpDQBWYSS0Bnw3
         ys0wf8panN9eBbydU9aLtnrw+qx0CfckXT6kDtm0PRHeYr1GnlK0E2ctBOHNN1LUgrn3
         JRGwqpGWls6DWNBOSwDCfZ9Mx9oXgZhzQDkgpOR6oDV0vViMetv2d2AI0cqz6rT6s0Ri
         IRAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8WDCSLUek4XGeNLuSCeN6laDon6LIytuBs8DUXeH4yC0+Cs0d079Nk33FLQqfJjPmJrF6w901eqRAIwCPDCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8nr1U17vteLxe5h7aP2i5Dvh6cMcVaop9vDtg/CweXymV09kB
	f1AZZReLZAnjO0IxE+J4Ds/aDg0XcMgbQr3d4ZftfcBBq5rtpwHQFRJ7mUylJprPIqUk9quBPTF
	XZn1BWqA4xSRr9Qqd38r2LaFU4QtsR8XkWJ8o8111cQ6YsgiemUOeHpTGzCcIIJhhszWMgdobP2
	3jIYUeUOQewmo9xCOxWp/U4w1a4R2i02kXB5rtC1QvKXMK
X-Gm-Gg: ASbGncs7+hB/bnbbmjZjBaYGeQfErVPcokF5Oin6VD4i2AvAQ50HGpybCLVKNXUP34R
	yuh32wVHaIKRHJBEoKg9l3Zk+cywSMHalrYDOYqXr1GLYvjdhYRKF6OfztW3xj5QfMSn77SAys/
	RRXDy4diVqxzpLmdN2Wq/cJiFD8tqsSzd39zIPYCeFVkG0KgOoYxd04AuY
X-Received: by 2002:a05:6a20:7fa6:b0:341:1dc6:aea with SMTP id adf61e73a8af0-34f80c9ec3fmr7522569637.0.1762396409327;
        Wed, 05 Nov 2025 18:33:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJiJnwI3+a6JpU1049glaBP/bHDR83VsC+UC84UXCO/uIZ9yubYNrF9cD7W/tL+0bV0yMl7bp3nZqx31DthMo=
X-Received: by 2002:a05:6a20:7fa6:b0:341:1dc6:aea with SMTP id
 adf61e73a8af0-34f80c9ec3fmr7522543637.0.1762396408945; Wed, 05 Nov 2025
 18:33:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105130922.13321-1-piliu@redhat.com> <20251105130922.13321-2-piliu@redhat.com>
 <aQwCDMhidg+a2Jzt@MiWiFi-R3L-srv>
In-Reply-To: <aQwCDMhidg+a2Jzt@MiWiFi-R3L-srv>
From: Pingfan Liu <piliu@redhat.com>
Date: Thu, 6 Nov 2025 10:33:17 +0800
X-Gm-Features: AWmQ_bmryauOB9ZCZ0k0YycHU0cpkpY0xr2TTfmcbnK7K9r18U3Qc4Rj3H82sZM
Message-ID: <CAF+s44StrV1USH4ZLQ6DRobXA=hXOs6EVkmeeeTsK-koWsV_KQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] kernel/kexec: Fix IMA when allocation happens in CMA area
To: Baoquan He <bhe@redhat.com>
Cc: kexec@lists.infradead.org, linux-integrity@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Alexander Graf <graf@amazon.com>, 
	Steven Chen <chenste@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Baoquan,

Thanks for your review. Please see the comment below.

On Thu, Nov 6, 2025 at 10:04=E2=80=AFAM Baoquan He <bhe@redhat.com> wrote:
>
> Hi Pingfan,
>
> On 11/05/25 at 09:09pm, Pingfan Liu wrote:
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
> >
> > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Alexander Graf <graf@amazon.com>
> > Cc: Steven Chen <chenste@linux.microsoft.com>
> > Cc: linux-integrity@vger.kernel.org
> > To: kexec@lists.infradead.org
> > ---
> >  kernel/kexec_core.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > index 9a1966207041..abe40286a02c 100644
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -967,6 +967,7 @@ void *kimage_map_segment(struct kimage *image, int =
idx)
> >       kimage_entry_t *ptr, entry;
> >       struct page **src_pages;
> >       unsigned int npages;
> > +     struct page *cma;
> >       void *vaddr =3D NULL;
> >       int i;
> >
> > @@ -974,6 +975,9 @@ void *kimage_map_segment(struct kimage *image, int =
idx)
> >       size =3D image->segment[idx].memsz;
> >       eaddr =3D addr + size;
> >
> > +     cma =3D image->segment_cma[idx];
>
> Thanks for your fix. But I totally can't get what you are doing. The idx
> passed into kimage_map_segment() could index image->segment[], and can
> index image->segment_cma[], could you reconsider and make the code more
> reasonable?
>

Since idx can index both image->segment[] and segment_cma[], the
behavior differs based on whether segment_cma[idx] is NULL:

- If segment_cma[idx] is not NULL, it points directly to the final
target location, eliminating the need for data copying that
traditional kexec relocation requires.
- If segment_cma[idx] is NULL, the segment relies on the traditional
kexec relocation code to copy its data.


Thanks,

Pingfan


> > +     if (cma)
> > +             return cma;
> >       /*
> >        * Collect the source pages and map them in a contiguous VA range=
.
> >        */
> > @@ -1014,7 +1018,8 @@ void *kimage_map_segment(struct kimage *image, in=
t idx)
> >
> >  void kimage_unmap_segment(void *segment_buffer)
> >  {
> > -     vunmap(segment_buffer);
> > +     if (is_vmalloc_addr(segment_buffer))
> > +             vunmap(segment_buffer);
> >  }
> >
> >  struct kexec_load_limit {
> > --
> > 2.49.0
> >
>


