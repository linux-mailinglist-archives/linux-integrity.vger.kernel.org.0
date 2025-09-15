Return-Path: <linux-integrity+bounces-7090-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5534AB58536
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Sep 2025 21:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B10881B20E0B
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Sep 2025 19:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208031C862F;
	Mon, 15 Sep 2025 19:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GVKWR5rq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE13E55A
	for <linux-integrity@vger.kernel.org>; Mon, 15 Sep 2025 19:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757963843; cv=none; b=NICQ27wCbp/6cpsSp9UPK401NptnClWCLJjeJqFSYIkIqauOWEQHiHZcggZnG8icrdt8mF/AoDge/ZN8QxG5P5gvdCv/AgHIWY1YsVNZjdi0RxeA5HItBcUHsOdgDjAPIkw05QLcidMDNT5ML7xVgzghJwBBGvDeeDerWuQv07c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757963843; c=relaxed/simple;
	bh=59lhxLbpXSEm64zKioCavCmgg1zMByFg/smPmonClVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qgB7LAv2iy3P8ibpoGHm7Pw5oo4M0qCJAh2L8SIPbcBwZ5HD7R9teNYqCx3hHPNpgPYCrBtBlIGQej0tkv2ceOMhoAN7BK0Y8HrRAhEPe+P3FtsbZpj0WCXQo+l71eXZGGF1RK41j+5T9mcZg5HFkS0WjNqvj+XbeLKz1iKxOoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GVKWR5rq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757963839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gvkjEyEuZT6BMuGf05F5q88P0vjvPmROrBLa6aUHAEM=;
	b=GVKWR5rq2j04H6nTcBKojshWeCJNtHu1etVsUbz5CHWVLOGUkBo8mJIuuNIT9Ubevw93xW
	hNcVyY9Aa7RPdfEYT0gK8o+ghgomRjr4KyrzhgzfRF96A2qIzc9DYP/47u0LjmOQiBWvIc
	/+8+J2xIfE3hzfCETFB6iJNXzFz5LHg=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-ojg3d3brNEyN2-eSKE70Ag-1; Mon, 15 Sep 2025 15:17:16 -0400
X-MC-Unique: ojg3d3brNEyN2-eSKE70Ag-1
X-Mimecast-MFC-AGG-ID: ojg3d3brNEyN2-eSKE70Ag_1757963836
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-733ff1a73dcso21924867b3.1
        for <linux-integrity@vger.kernel.org>; Mon, 15 Sep 2025 12:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757963836; x=1758568636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvkjEyEuZT6BMuGf05F5q88P0vjvPmROrBLa6aUHAEM=;
        b=vDmu0lBU2AS0A7GQR3LiQp19joRr+coCkJhsZ9rgscQue9nvItSyCzCjyJgAJjdeaj
         W81IV/+k43xKYusifQOmPJPZx/3J7/+pw6IDSnIO893dVSiCBfqDT6PdgIMOc8buhG5j
         SZw71uKr85d4q11vSSGJTyS2lKnrhjCL3Ie/NvGiK/7tMkrOnafPyjcE0YDPqcI+9ppX
         SuiZdfnbpu+cP5aWcTk8PdvDlneqmHSL4UTzUbKGAooFnyYil9HlU/WLf/RTAjTlqo9o
         tFWDyCvyxAY1nijVKbCxXM/guBdcVk/IkpBZDyyypSjrMHoEDjKIgj7URhvkeOMWOHLE
         X/CQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+PRLG/4psvBcfGMXEWmbtnkDsAQETyeOUL3CZk5lF/6pybqTT0w+1+AU7s9oBtGbr7c3KMPHBt5ywYFyvU2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyur5mpnTTT5Urwwcd/C784Hbc8IiJikNVIr7f2QlyybX5xhfSg
	+hpG6uf1lcXJQobrLmlXABAAmVOiAufMm0r+teJe/IMkFmtzKwacLHPRi0q4VD08YWdtfkukslN
	3fE+wqSNxi6mE7pKK+Auvt1Wwi7vxCfexIi7YNj7QRyxW/AMU/1Ni5Dtu0u9n5qyPHQl7VGcByU
	rpF0/JSefDSHVRXiegpNBQXC9w1mmZKB2mWO1Ef/iYQ9Cn7tKlIPP0
X-Gm-Gg: ASbGncufzJK3xWzJdsBW2PvBS1YQ/HgpoiOTP/TX1uTSuPg6DcyVs5VO2ah9Cste/YW
	/S0fH6ewQBFG6Wegx80TmvxkUxprB2u63V0P469kzq7lsYTvOGvvEaSgNjsxTF3v/ttoBNIys9h
	J85j/vuvJovzQ2JzFMoU0=
X-Received: by 2002:a05:690c:6c08:b0:724:a06b:cb30 with SMTP id 00721157ae682-7306472561dmr110379737b3.31.1757963835491;
        Mon, 15 Sep 2025 12:17:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOF3BTa3keZ5HSSeIjHhju4fAFRKXyCozjm9UtlvYCq5CpEqcM5m/Lv2OF6ZuIVFbcEqU9c43wcQShn9kxa9o=
X-Received: by 2002:a05:690c:6c08:b0:724:a06b:cb30 with SMTP id
 00721157ae682-7306472561dmr110379397b3.31.1757963834633; Mon, 15 Sep 2025
 12:17:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902142429.14041-2-daleksan@redhat.com> <aMhdcOZxpqgckC78@kernel.org>
In-Reply-To: <aMhdcOZxpqgckC78@kernel.org>
From: Denis Aleksandrov <daleksan@redhat.com>
Date: Mon, 15 Sep 2025 15:17:03 -0400
X-Gm-Features: Ac12FXwj3DW5624vF_RNF7EUi39vXiwCTN6Lp-uJ__d_j1_99EPTqvX8S23qNGY
Message-ID: <CAG+gbFfJ+dFLw2Xh7oYpWTh_8JEhvRk3_+v96sQa0fiten06jw@mail.gmail.com>
Subject: Re: [PATCH v4] tpm: Prevent local DOS via tpm/tpm0/ppi/*operations
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org, 
	Jan Stancek <jstancek@redhat.com>, Paul Menzel <pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 2:39=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Tue, Sep 02, 2025 at 10:24:30AM -0400, Denis Aleksandrov wrote:
> > Reads on tpm/tpm0/ppi/*operations can become very long on
> > misconfigured systems. Reading the TPM is a blocking operation,
> > thus a user could effectively trigger a DOS.
> >
> > Resolve this by caching the results and avoiding the blocking
> > operations after the first read.
> >
> > Reported-by: Jan Stancek <jstancek@redhat.com>
> > Signed-off-by: Denis Aleksandrov <daleksan@redhat.com>
> > Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
> > Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > ---
> >
> > Changes in v4:
> >       - Removes empty lines.
> >       - Reorders vars to reverse christmas tree.
> >
> >  drivers/char/tpm/tpm_ppi.c | 85 +++++++++++++++++++++++++++-----------
> >  1 file changed, 62 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
> > index d53fce1c9d6f..df34b215440d 100644
> > --- a/drivers/char/tpm/tpm_ppi.c
> > +++ b/drivers/char/tpm/tpm_ppi.c
> > @@ -33,6 +33,20 @@ static const guid_t tpm_ppi_guid =3D
> >       GUID_INIT(0x3DDDFAA6, 0x361B, 0x4EB4,
> >                 0xA4, 0x24, 0x8D, 0x10, 0x08, 0x9D, 0x16, 0x53);
> >
> > +static const char * const tpm_ppi_info[] =3D {
> > +     "Not implemented",
> > +     "BIOS only",
> > +     "Blocked for OS by system firmware",
> > +     "User required",
> > +     "User not required",
> > +};
> > +
> > +/* A spinlock to protect access to the cache from concurrent reads */
> > +static DEFINE_SPINLOCK(tpm_ppi_lock);
> > +
> > +static u32 ppi_operations_cache[PPI_VS_REQ_END + 1];
> > +static bool ppi_cache_populated;
> > +
> >  static bool tpm_ppi_req_has_parameter(u64 req)
> >  {
> >       return req =3D=3D 23;
> > @@ -277,8 +291,7 @@ static ssize_t tpm_show_ppi_response(struct device =
*dev,
> >       return status;
> >  }
> >
> > -static ssize_t show_ppi_operations(acpi_handle dev_handle, char *buf, =
u32 start,
> > -                                u32 end)
> > +static ssize_t cache_ppi_operations(acpi_handle dev_handle, char *buf)
> >  {
> >       int i;
> >       u32 ret;
> > @@ -286,34 +299,22 @@ static ssize_t show_ppi_operations(acpi_handle de=
v_handle, char *buf, u32 start,
> >       union acpi_object *obj, tmp;
> >       union acpi_object argv =3D ACPI_INIT_DSM_ARGV4(1, &tmp);
> >
> > -     static char *info[] =3D {
> > -             "Not implemented",
> > -             "BIOS only",
> > -             "Blocked for OS by BIOS",
> > -             "User required",
> > -             "User not required",
> > -     };
> > -
> >       if (!acpi_check_dsm(dev_handle, &tpm_ppi_guid, TPM_PPI_REVISION_I=
D_1,
> >                           1 << TPM_PPI_FN_GETOPR))
> >               return -EPERM;
> >
> >       tmp.integer.type =3D ACPI_TYPE_INTEGER;
> > -     for (i =3D start; i <=3D end; i++) {
> > +     for (i =3D 0; i <=3D PPI_VS_REQ_END; i++) {
> >               tmp.integer.value =3D i;
> >               obj =3D tpm_eval_dsm(dev_handle, TPM_PPI_FN_GETOPR,
> >                                  ACPI_TYPE_INTEGER, &argv,
> >                                  TPM_PPI_REVISION_ID_1);
> > -             if (!obj) {
> > +             if (!obj)
> >                       return -ENOMEM;
> > -             } else {
> > -                     ret =3D obj->integer.value;
> > -                     ACPI_FREE(obj);
> > -             }
> >
> > -             if (ret > 0 && ret < ARRAY_SIZE(info))
> > -                     len +=3D sysfs_emit_at(buf, len, "%d %d: %s\n",
> > -                                          i, ret, info[ret]);
> > +             ret =3D obj->integer.value;
> > +             ppi_operations_cache[i] =3D ret;
> > +             ACPI_FREE(obj);
> >       }
> >
> >       return len;
> > @@ -324,9 +325,28 @@ static ssize_t tpm_show_ppi_tcg_operations(struct =
device *dev,
> >                                          char *buf)
> >  {
> >       struct tpm_chip *chip =3D to_tpm_chip(dev);
> > +     ssize_t len =3D 0;
> > +     u32 ret;
> > +     int i;
> > +
> > +     spin_lock(&tpm_ppi_lock);
> > +     if (!ppi_cache_populated) {
> > +             len =3D cache_ppi_operations(chip->acpi_dev_handle, buf);
> > +             if (len < 0)
> > +                     return len;
> >
> > -     return show_ppi_operations(chip->acpi_dev_handle, buf, 0,
> > -                                PPI_TPM_REQ_MAX);
> > +             ppi_cache_populated =3D true;
> > +     }
> > +
> > +     for (i =3D 0; i <=3D PPI_TPM_REQ_MAX; i++) {
> > +             ret =3D ppi_operations_cache[i];
> > +             if (ret >=3D 0 && ret < ARRAY_SIZE(tpm_ppi_info))
> > +                     len +=3D sysfs_emit_at(buf, len, "%d %d: %s\n",
> > +                                                     i, ret, tpm_ppi_i=
nfo[ret]);
> > +     }
> > +     spin_unlock(&tpm_ppi_lock);
> > +
> > +     return len;
> >  }
> >
> >  static ssize_t tpm_show_ppi_vs_operations(struct device *dev,
> > @@ -334,9 +354,28 @@ static ssize_t tpm_show_ppi_vs_operations(struct d=
evice *dev,
> >                                         char *buf)
> >  {
> >       struct tpm_chip *chip =3D to_tpm_chip(dev);
> > +     ssize_t len =3D 0;
> > +     u32 ret;
> > +     int i;
> >
> > -     return show_ppi_operations(chip->acpi_dev_handle, buf, PPI_VS_REQ=
_START,
> > -                                PPI_VS_REQ_END);
> > +     spin_lock(&tpm_ppi_lock);
> > +     if (!ppi_cache_populated) {
> > +             len =3D cache_ppi_operations(chip->acpi_dev_handle, buf);
> > +             if (len < 0)
> > +                     return len;
> > +
> > +             ppi_cache_populated =3D true;
> > +     }
> > +
> > +     for (i =3D PPI_VS_REQ_START; i <=3D PPI_VS_REQ_END; i++) {
> > +             ret =3D ppi_operations_cache[i];
> > +             if (ret >=3D 0 && ret < ARRAY_SIZE(tpm_ppi_info))
> > +                     len +=3D sysfs_emit_at(buf, len, "%d %d: %s\n",
> > +                                                     i, ret, tpm_ppi_i=
nfo[ret]);
> > +     }
> > +     spin_unlock(&tpm_ppi_lock);
> > +
> > +     return len;
> >  }
> >
> >  static DEVICE_ATTR(version, S_IRUGO, tpm_show_ppi_version, NULL);
> > --
> > 2.48.1
> >
>
> I don't know how I messed up the patch in my Git but now it is good
> (I think):
>
> https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/co=
mmit/?h=3Dnext
>
> Please check before I move forward with the PR.

The commit looks good, besides my mistake of not freeing the lock upon an e=
rror.
I was just curious if we should follow Paul's recommendation about separati=
ng
the previously mentioned changes into another patch. I'm okay with moving
forward with the current changes without breaking it up into another patch.

I'll send over a v5 shortly. The only changes I will introduce to the
existing patch
is proper lock management.

>
> BR, Jarkko
>

Thanks,
Denis


