Return-Path: <linux-integrity+bounces-6787-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0261DB1EE60
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Aug 2025 20:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B14423B3F0B
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Aug 2025 18:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6756E1E1A33;
	Fri,  8 Aug 2025 18:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OjSZYVl+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E801DA3D
	for <linux-integrity@vger.kernel.org>; Fri,  8 Aug 2025 18:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754677938; cv=none; b=EWRz4XgzYi17rithaXu7BFJZ3Sxg8cxRBO3o0XWF+0zJWZtDwTP/TDWVnloWBtRBy10zLK4EpN5BF/QYeuUeh7X+fCBdocu9aLYeI/5gPUU6FcmliFJ3/1xwMo98Zt7XjCkSNvaJR2fyFFFKmEWkEZoFXH5Ec9J/8NayeoCJz60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754677938; c=relaxed/simple;
	bh=1sBkBv2JSJwPy5/yx1Qzp9+Vs119uU18uu3/qZjuZ6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i43BlqiI95DkZT6AmwjfhsmtyNnbovE2YepGZ95Y3TgCjeLDX+oLkPKkdg55h1GFC3Om8JIlmQZozhsKylysp28jCO3ksOpBXJ1ra/IR9DqSIoT5RH6q19wpDD0tgcm9DGorAqIRHzdgUH+SZ2hukFGiy+JSMr8DqTePRGDkjRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OjSZYVl+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754677935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zgG5v91IC+h9Qh6j+aVM27VlbcIM9DWdAjhCTJxxeWs=;
	b=OjSZYVl+BCFq8pBlXGj7pbzobXHER+QF7SuDDoq1HdBFtcIniaVjzIf2A1CRaOP307g/oo
	BjapSNuMKk22Ddng5OCxJfdfRUu0GTRHhHeNDKuHa3H+7UXIjFdY4NrdF97eoAUSjkcZXO
	NsYo84rjQMyNrCKuWtogkFJ0qmNA3v0=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-DFUUYBmCNOaWoz1IOBFAvA-1; Fri, 08 Aug 2025 14:32:14 -0400
X-MC-Unique: DFUUYBmCNOaWoz1IOBFAvA-1
X-Mimecast-MFC-AGG-ID: DFUUYBmCNOaWoz1IOBFAvA_1754677934
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-713e879bd7cso35769587b3.0
        for <linux-integrity@vger.kernel.org>; Fri, 08 Aug 2025 11:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754677934; x=1755282734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgG5v91IC+h9Qh6j+aVM27VlbcIM9DWdAjhCTJxxeWs=;
        b=kgpTjy/7S4W/dzR50Z1JwwlYA2FYTbhpCJWW7uDiuFL/Tw1TlTzKNUmIaJbeI5jTGY
         VdyhbZ+m7CQsydB6gX9gTavMXtC+js78jbKydx9NGhkdcVTCvyj2vswSA61qufDHzRhc
         RLgbLWCmHYAUlVoAQXNpK26GmeNpPceNeT6u5eEZUW+PVceN3NbxSBMmOdE0R2m/Vb/6
         x9KndpaSgZjURNM1dJe9CMWxOFQ21CUGpjcLAUorhemCFcG6/Goo4GzuwaljqZCGxjCb
         ZU4n48F35fl3QtEC/5Zs82lUE/wkVA8XFKgIjnzcLfg3L/jGQf3PtFGDmeEJxg3J1zVc
         9RAw==
X-Forwarded-Encrypted: i=1; AJvYcCXi3tF3c4ExFRa8+y7JBnMynWIEhWxAWdyHCQk5qOherBSTX7e1TgtGDwOc6rltew/+gRUZBR0bpncXbS+mj08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1GwEQtU1ER7NV8Qji59xrS6FARXQS4oS81dPIxmEPCvnVDp78
	9FmFL6mmJIarol7yxVo+d0O6X5N+NAi/tww3MWGLfFK5bjj3mmSEZSd+fQDtLQ7O7cWwwDl40bI
	wmXdYtCRPh5+umEtN6bFS64Zcqp7KXSIlhvTi2Op4s2ciu+s72RMvOJGCm6HrD98eybV5O/2UBb
	6knCAQLI8LbSks1rZgy3yeBHeS5ntu4oUY1duSDJa40eT3
X-Gm-Gg: ASbGncsTpv91sve/WJdp6UUO066m8Zq6QTDc5p4m5ycrwXcXD3NHATz+AHmaIluhasX
	sC6M/qYqd5yy17wrb0FgNDrfXynEEFzULqLMzISq9SS4g+QI0qZPyj4K0QlxZeHES6tEsWm3o8U
	nx9r7lskjkytx95uwLskw/
X-Received: by 2002:a0d:e502:0:b0:71b:f19a:8851 with SMTP id 00721157ae682-71bf19a91a3mr40240597b3.36.1754677933664;
        Fri, 08 Aug 2025 11:32:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHtZQ1cO6S7GJpjmt/FUcJKNP6ODHpvJjwsSGpFe8T+ftyH+MbgfsJT28OcYWzjWNPXMURrLpDgl9f8YSJsBc=
X-Received: by 2002:a0d:e502:0:b0:71b:f19a:8851 with SMTP id
 00721157ae682-71bf19a91a3mr40240397b3.36.1754677933244; Fri, 08 Aug 2025
 11:32:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702202851.33344-1-daleksan@redhat.com> <aGW2wabMXtdBEQxR@kernel.org>
 <CAG+gbFfKLCQND-TT8DEZ09T=Nhb39_CJfM5imv341Pen03bHjw@mail.gmail.com> <CAG+gbFfLP1Y=HgRfzjhT4uJ121keQ0ZKo=4saB3uqnZYyoV8JA@mail.gmail.com>
In-Reply-To: <CAG+gbFfLP1Y=HgRfzjhT4uJ121keQ0ZKo=4saB3uqnZYyoV8JA@mail.gmail.com>
From: Denis Aleksandrov <daleksan@redhat.com>
Date: Fri, 8 Aug 2025 14:32:02 -0400
X-Gm-Features: Ac12FXxCqvZ84YiVVjMeH0w_k6wBn1YSHG7h8ihKbEMEbBEYdOxkUoN1BX20AEs
Message-ID: <CAG+gbFcgfZALHCAxaMmWkNQX2sKgkc-HBJrYXdmehsqLidG_tA@mail.gmail.com>
Subject: Re: [PATCH] tpm: prevents local DOS via tpm/tpm0/ppi/*operations
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org, 
	Jan Stancek <jstancek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping.

Just checking in on this patch.
It has received a "Reviewed-by" tag, and I was wondering if there is
anything else needed from my side for it to be picked up.

Thanks,
Denis

On Thu, Jul 3, 2025 at 8:00=E2=80=AFAM Denis Aleksandrov <daleksan@redhat.c=
om> wrote:
>
> Hi Jarkko,
>
> Thank you for the review. I'll add your Reviewed-by tag to my local commi=
t.
> Please let me know if you would like me to send a v2 version of the
> patch with your tag included.
>
> Best,
> Denis
>
>
> On Thu, Jul 3, 2025 at 7:56=E2=80=AFAM Denis Aleksandrov <daleksan@redhat=
.com> wrote:
> >
> > Hi Jarkko,
> >
> > Thank you for the review. I'll add your Reviewed-by tag to my local com=
mit.
> > Please let me know if you would like me to send a v2 version of the pat=
ch with your tag included.
> >
> > Best,
> > Denis
> >
> > On Wed, Jul 2, 2025 at 6:46=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.o=
rg> wrote:
> >>
> >> On Wed, Jul 02, 2025 at 04:28:51PM -0400, Denis Aleksandrov wrote:
> >> > This bug is not seen on most machines. Reads on tpm/tpm0/ppi/*operat=
ions
> >> > can become very long on misconfigured systems. Reading the TPM is a
> >> > blocking operation, thus a user could effectively trigger a DOS.
> >> >
> >> > Resolve this by restricting unprivileged user from reading the
> >> > above-mentioned device files.
> >>
> >> I suppose we can do this. I'm going to holiday for one week next
> >> week so I'll hold for additional feedback for that period and
> >> apply this if nothing comes up.
> >>
> >> There's no use case for unprivileged user, or app that stops
> >> working because of this. If you cut hairs, with patch shifting
> >> uapi you have to we always prepared that tree falls down
> >> somewhere but I'm willing to take risk with this :-)
> >>
> >>
> >> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> >>
> >> >
> >> > Reported-by: Jan Stancek <jstancek@redhat.com>
> >> > Signed-off-by: Denis Aleksandrov <daleksan@redhat.com>
> >> > ---
> >> >
> >> > Running scripts/checkpatch.pl suggested that the permissions be
> >> > changed to octal format. What do the maintainers think of this?
> >> > The rest of the permissions in the file are macros.
> >> >
> >> > Lastly, this bug was reproduced and the fix was tested accordingly.
> >> >
> >> >  drivers/char/tpm/tpm_ppi.c | 4 ++--
> >> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
> >> > index bc7b1b4501b3..ac6e0aee566e 100644
> >> > --- a/drivers/char/tpm/tpm_ppi.c
> >> > +++ b/drivers/char/tpm/tpm_ppi.c
> >> > @@ -347,8 +347,8 @@ static DEVICE_ATTR(request, S_IRUGO | S_IWUSR | =
S_IWGRP,
> >> >  static DEVICE_ATTR(transition_action, S_IRUGO,
> >> >                  tpm_show_ppi_transition_action, NULL);
> >> >  static DEVICE_ATTR(response, S_IRUGO, tpm_show_ppi_response, NULL);
> >> > -static DEVICE_ATTR(tcg_operations, S_IRUGO, tpm_show_ppi_tcg_operat=
ions, NULL);
> >> > -static DEVICE_ATTR(vs_operations, S_IRUGO, tpm_show_ppi_vs_operatio=
ns, NULL);
> >> > +static DEVICE_ATTR(tcg_operations, S_IRUSR | S_IRGRP, tpm_show_ppi_=
tcg_operations, NULL);
> >> > +static DEVICE_ATTR(vs_operations, S_IRUSR | S_IRGRP, tpm_show_ppi_v=
s_operations, NULL);
> >> >
> >> >  static struct attribute *ppi_attrs[] =3D {
> >> >       &dev_attr_version.attr,
> >> > --
> >> > 2.48.1
> >> >
> >>
> >> BR, Jarkko
> >>


