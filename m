Return-Path: <linux-integrity+bounces-7671-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 32503C83505
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Nov 2025 05:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 234873496FE
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Nov 2025 04:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE47223DD6;
	Tue, 25 Nov 2025 04:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CImSIAG6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tPSeuw0C"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF61E27F4CE
	for <linux-integrity@vger.kernel.org>; Tue, 25 Nov 2025 04:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764043838; cv=none; b=hnPQ0jmnOGXJpfEwZy28E2/GOE49zR/9q2cKPY6NpAOhiZnOiFTKoNF0uWPJ8juLZp3MnMjOnC/d1Cj4tMe5LlQpd7ZP+oPAFlHSUB63bUdUzTqWv2MXGlkjs1TmfcEu4l61Ft1i/6fy8r+Cu1Lvyb1mxXQlx6ZGKoJ0O3i6Rxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764043838; c=relaxed/simple;
	bh=9YYWZrw2E0QMAD9tvplw/ACL4yWRSThe2gJsD4evs+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eGrxM5fPR6bbjwcrwNz5cKEGCeVPIk4ZQW7v6rSyKKreN4fPVyPcKxZ6O7IwuBuqhUsHMOvJKnNcP4g0qRE1SihyuRTSYhA1vtkET/K6TiMgnmgcdk9pcNBXkTVk0gZPYJ1ln8l5DgPWlqeZpAkhJf6cp1b5pWivOYkYZ1AF0uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CImSIAG6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tPSeuw0C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764043833;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yK36ADvRnvn7Z88J1V2Eb5Oki0HN2SsGScGiByHtlSA=;
	b=CImSIAG6dH66UfLTAIleoqHCQMPMIxLdWumzYoPiau+BvKyknWWgg6FR0a1/+k8zZ4FxEB
	vZCLvyCO8TBnbhcVbQfAR7Km/jVr/MPQ15C+YiIBmE0auAkWmzlXhPh8IoMFTWhblCA9wr
	ujH6lP47o5+3n5QnyiUILXqtM965XW4=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-PHTl5-QSPd6Y416feT1fgA-1; Mon, 24 Nov 2025 23:10:31 -0500
X-MC-Unique: PHTl5-QSPd6Y416feT1fgA-1
X-Mimecast-MFC-AGG-ID: PHTl5-QSPd6Y416feT1fgA_1764043830
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b9d73d57328so5268879a12.1
        for <linux-integrity@vger.kernel.org>; Mon, 24 Nov 2025 20:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764043830; x=1764648630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yK36ADvRnvn7Z88J1V2Eb5Oki0HN2SsGScGiByHtlSA=;
        b=tPSeuw0CgQtXtQCIdVJbP7XS+/Kmo+317jQpBT2QdiGZFRKyL69lRfVEXFlzgIIqji
         ZsclyKzcdBPOKoQ5VNa73uC/+QoIouq+pmYyKZia/BAruPjG+HYilYoloL0Ir6iL4peL
         S6jUEuSUzDfBWxMLlWhsE9XPaQ1X0rw0JhNAIlYQ0fjsgfmlD1q4DlWW4jwk+cF1dGLK
         NmiJwHyxYO1OVoOB1pJNwTpnbUc6X5vnWcvJEEEc6flflCg1smWFtVgnfC7DSHA5yHjy
         gwr8ToDR//7hX6WZBvfkEbSKmT41edK6WLAw3ZVfJAjDi05lZPO2EMAnKVSbMlYLcYxh
         gIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764043830; x=1764648630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yK36ADvRnvn7Z88J1V2Eb5Oki0HN2SsGScGiByHtlSA=;
        b=YFpiIu4YX5sDi25uVMfJvcbdlvJnFsWdpguocxKiQNCGv/LMO8dkooBxL+u6hzsgWz
         kHaLuHxntI0r6AtqUiRnrIiXbIlAnwrP6ySXzOcXLedM8+MGltJu9FRHZ0+EE8HJW1Bi
         /aptpsEDldBcrWks1kmBmVfhTwypboa07RUTsGqYRITjgHxr1vLxwmJ4jF4rlrmtVscL
         IUkTkrESIG9lWtsAiLzyCaG/gwVCURnYASXfLKU6DEx98DGqORNUg5xuGG9sr8QpGzRG
         +gcRI1pNvCUQ05hAnqFQf02hsr87eCgd/uoPqb7VHcyuMhmGb0My9ymcqbpTaMFSxcTU
         HCuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuJghxApCM/EGZZYlN0hWdAovBb29TqS2HpeOjv6guJstzK0v64WLG68FGaRsTl/cM7s8i74j/U4zsXb81CN8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2tzjtJLNl143B9PdZbQn+ToOTMGvFSf0C2BEtSh9roUa0yFwV
	+/Q8PggTOxaDrnnhaZ0LE9eHPY5GbS9EADWyMMRYOjaQqL+lJYIlnBfV3YyBYZPJZOGvUG2PXuO
	1eMx/eMtbPAUrK70MDPPkF33myQf6Zu7iN6WWOqNRNnxYKMvtthG4yUO6f5SFUF6KyAXXYqRY5M
	sogWL75VO5/QKRf0G9Vu0YPZurg+1RGRFxzCz3FX5GJgkL
X-Gm-Gg: ASbGncsAGV/B5rev9qomFV/KHwl5QC42qNJa075BXMUoPYmNMD8EUq66e1PAKiSIQG5
	txMCb+jQUArlI37I7VXTKbcMzECMLj9lAtMPS326sO+ZgoyrMFqwK7oUQ1zZA5gXzqSE10gw70U
	AV1PE9BOmLGVL6ASc47wfnGbc3Aga//9sxKBZVMvrM7weaI7fPjX9Hgi3c2o/KKaznjD8=
X-Received: by 2002:a05:7300:3c9d:b0:2a4:3592:c604 with SMTP id 5a478bee46e88-2a94174e0a3mr968017eec.21.1764043830405;
        Mon, 24 Nov 2025 20:10:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgUoue+m7hDF3DbmgObHkl//DmmrJWlhnJcpAhd/7zU+XNPQQveIwUfL2CdEABUBwK3fALWag5I+mmEpqWE4g=
X-Received: by 2002:a05:7300:3c9d:b0:2a4:3592:c604 with SMTP id
 5a478bee46e88-2a94174e0a3mr967995eec.21.1764043829940; Mon, 24 Nov 2025
 20:10:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106065904.10772-1-piliu@redhat.com> <20251124141620.eaef984836fe2edc7acf9179@linux-foundation.org>
In-Reply-To: <20251124141620.eaef984836fe2edc7acf9179@linux-foundation.org>
From: Pingfan Liu <piliu@redhat.com>
Date: Tue, 25 Nov 2025 12:10:18 +0800
X-Gm-Features: AWmQ_bls9hRXbIMq8va3xXzXthhHZlNlk1j_k-sv8prZCGat9H5AAgW6u60PH-U
Message-ID: <CAF+s44SPQe9XCopTJcCN-FOfdupc9ZYrj3C+Q3CKfRKFFUYgNg@mail.gmail.com>
Subject: Re: [PATCHv2 1/2] kernel/kexec: Change the prototype of kimage_map_segment()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kexec@lists.infradead.org, linux-integrity@vger.kernel.org, 
	Baoquan He <bhe@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Alexander Graf <graf@amazon.com>, 
	Steven Chen <chenste@linux.microsoft.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 25, 2025 at 6:16=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Thu,  6 Nov 2025 14:59:03 +0800 Pingfan Liu <piliu@redhat.com> wrote:
>
> > The kexec segment index will be required to extract the corresponding
> > information for that segment in kimage_map_segment(). Additionally,
> > kexec_segment already holds the kexec relocation destination address an=
d
> > size. Therefore, the prototype of kimage_map_segment() can be changed.
>
> Could we please have some reviewer input on thee two patches?
>
> Thanks.
>
> (Pingfan, please cc linux-kernel on patches - it's where people go to
> find emails on lists which they aren't suscribed to)
>
OK, I will cc linux-kernel for the future kexec patches

For this series, it can also be found on
https://lore.kernel.org/linux-integrity/20251106065904.10772-1-piliu@redhat=
.com/

Thanks,

Pingfan

> (akpm goes off and subscribes to kexec@)
>
> > Fixes: 07d24902977e ("kexec: enable CMA based contiguous allocation")
> > Signed-off-by: Pingfan Liu <piliu@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Mimi Zohar <zohar@linux.ibm.com>
> > Cc: Roberto Sassu <roberto.sassu@huawei.com>
> > Cc: Alexander Graf <graf@amazon.com>
> > Cc: Steven Chen <chenste@linux.microsoft.com>
> > Cc: <stable@vger.kernel.org>
> > To: kexec@lists.infradead.org
> > To: linux-integrity@vger.kernel.org
> > ---
> >  include/linux/kexec.h              | 4 ++--
> >  kernel/kexec_core.c                | 9 ++++++---
> >  security/integrity/ima/ima_kexec.c | 4 +---
> >  3 files changed, 9 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> > index ff7e231b0485..8a22bc9b8c6c 100644
> > --- a/include/linux/kexec.h
> > +++ b/include/linux/kexec.h
> > @@ -530,7 +530,7 @@ extern bool kexec_file_dbg_print;
> >  #define kexec_dprintk(fmt, arg...) \
> >          do { if (kexec_file_dbg_print) pr_info(fmt, ##arg); } while (0=
)
> >
> > -extern void *kimage_map_segment(struct kimage *image, unsigned long ad=
dr, unsigned long size);
> > +extern void *kimage_map_segment(struct kimage *image, int idx);
> >  extern void kimage_unmap_segment(void *buffer);
> >  #else /* !CONFIG_KEXEC_CORE */
> >  struct pt_regs;
> > @@ -540,7 +540,7 @@ static inline void __crash_kexec(struct pt_regs *re=
gs) { }
> >  static inline void crash_kexec(struct pt_regs *regs) { }
> >  static inline int kexec_should_crash(struct task_struct *p) { return 0=
; }
> >  static inline int kexec_crash_loaded(void) { return 0; }
> > -static inline void *kimage_map_segment(struct kimage *image, unsigned =
long addr, unsigned long size)
> > +static inline void *kimage_map_segment(struct kimage *image, int idx)
> >  { return NULL; }
> >  static inline void kimage_unmap_segment(void *buffer) { }
> >  #define kexec_in_progress false
> > diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> > index fa00b239c5d9..9a1966207041 100644
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -960,17 +960,20 @@ int kimage_load_segment(struct kimage *image, int=
 idx)
> >       return result;
> >  }
> >
> > -void *kimage_map_segment(struct kimage *image,
> > -                      unsigned long addr, unsigned long size)
> > +void *kimage_map_segment(struct kimage *image, int idx)
> >  {
> > +     unsigned long addr, size, eaddr;
> >       unsigned long src_page_addr, dest_page_addr =3D 0;
> > -     unsigned long eaddr =3D addr + size;
> >       kimage_entry_t *ptr, entry;
> >       struct page **src_pages;
> >       unsigned int npages;
> >       void *vaddr =3D NULL;
> >       int i;
> >
> > +     addr =3D image->segment[idx].mem;
> > +     size =3D image->segment[idx].memsz;
> > +     eaddr =3D addr + size;
> > +
> >       /*
> >        * Collect the source pages and map them in a contiguous VA range=
.
> >        */
> > diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/im=
a/ima_kexec.c
> > index 7362f68f2d8b..5beb69edd12f 100644
> > --- a/security/integrity/ima/ima_kexec.c
> > +++ b/security/integrity/ima/ima_kexec.c
> > @@ -250,9 +250,7 @@ void ima_kexec_post_load(struct kimage *image)
> >       if (!image->ima_buffer_addr)
> >               return;
> >
> > -     ima_kexec_buffer =3D kimage_map_segment(image,
> > -                                           image->ima_buffer_addr,
> > -                                           image->ima_buffer_size);
> > +     ima_kexec_buffer =3D kimage_map_segment(image, image->ima_segment=
_index);
> >       if (!ima_kexec_buffer) {
> >               pr_err("Could not map measurements buffer.\n");
> >               return;
> > --
> > 2.49.0
>


