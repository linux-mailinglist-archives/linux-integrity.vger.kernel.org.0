Return-Path: <linux-integrity+bounces-7102-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 346E3B59949
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Sep 2025 16:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E492D7A6BD2
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Sep 2025 14:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE17B335BAF;
	Tue, 16 Sep 2025 14:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T3Plx3Jh"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59E3315D42
	for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 14:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032036; cv=none; b=TOox9aO0D7AIpXFI6yPwcFQECyop5PMZOCmIj9tGE1rlou9KrI5+D2pYm1FjITVCYwKbTneB8Sr+oYq6ZxUN7hXq85O7rCOjBeFyR4oKMYsdsMEoZJVTDv9j4H40oU/umzaYZI5bbdYv5/XnTq9NeeVkqvpgsfff4V8if2OLc8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032036; c=relaxed/simple;
	bh=n/6fzc95T7MyWsWIgeMjX3J/pUB3DM3756dPZYZz3t8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TZELC/6ZZYp86wcvJfIyhLRfVaHPCFRekDUr5XOovZtjNh4TobKyTzk1Oi18MLgKpgalqzjdKU7oip2nu6D99ypnoOE+oDkI4mfRfA3oVwCFix3ywLA6pePPz6MCmNt229Jk4xD5t2/KmQFefDOysP+CKYW7Tk2a0CtGNBJ8n+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T3Plx3Jh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758032033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CdEymD+tbprymtBMiWfrW5CkWOk383odet+/56kgsQY=;
	b=T3Plx3JhyPJxV6YRX8+AdcSlBPulnJNOTAHMBt3RQFME3OPd7I87eAh7xrDuKZ5gJ8hJOJ
	CFqGpw0agJRZp9jk49C62ca91TQQrW/tYbUwAn9E49k6KS1j6gnpS2/Kz8qUVUiMaTc1+e
	zaRtIG6tkXVnxmrs11EfRxJE0lgNGB8=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-SKjk3DOhMcKZZA_nV84PlA-1; Tue, 16 Sep 2025 10:13:52 -0400
X-MC-Unique: SKjk3DOhMcKZZA_nV84PlA-1
X-Mimecast-MFC-AGG-ID: SKjk3DOhMcKZZA_nV84PlA_1758032032
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-71d60183b47so49779667b3.0
        for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 07:13:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758032032; x=1758636832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CdEymD+tbprymtBMiWfrW5CkWOk383odet+/56kgsQY=;
        b=RXrqR4cMq4920YBJuddIJc5gdU70JxAK3YG0tHjxvUQq91Olwyl8TdNSRvmqoTsttX
         iyl5X51w5vnzFzAKCchoRHvQggxxOr2UaVclFRd6YoYcT+jjm5w/alCArNfJnbtZz8NF
         Kmew2bEHhmBxcVGhj1wuLnRLuxFYF9oAfad8OY43Qu7gtMzopju0qAxH+UIWeP4awwWP
         rBiupyZFh85DhivsKrGYd18rRU8VoGbTej3E1sszSS7c4GO81iZwRTeSsSSKHkeyJcXd
         vodda/zV9zmVvbiQHh0Pe8fzCvQZ0J8phVvgyIOPSfZdcAZ2OGX19pWWRzZr2sSi/4yg
         JQDw==
X-Forwarded-Encrypted: i=1; AJvYcCUreeJE2GpTuqQ/XO9kT/TvjY/iPkggTrh2M0Aa2F7XBpK7MY7SWnv/aYk+7jFYNhofEKHw3fYwu3v4Cp8WlQs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1/yNdNqo1ZCKrh8O0AZtraQUfWPGou9Hy3J50fagIIphVrSSG
	LjcFnW7QBgHIT3ZVKN0MGHhgPADnPLMTakUZqJKJC0TwllWazO9ZkJLnxJLbsYkiGEc3bkUFPNx
	ZfW0uhA5rO2Het73reX/zCpWO1ZfDlj80Vclj/n1F67BXbnmYsdF8OuxV8y757SGJluhF2n6aa+
	6fr+CvYFMBy2f9RjCJz31HJbvtkNOzxqcmf6Ynm7DfV1PosrtWDiifuv0=
X-Gm-Gg: ASbGnctbdOqhne3/m+Pfl6RTXhjGnIEuwyVeLmsOrAOGuxbTfR4/CDGLMkUK8S2t9ii
	UdHWV7as1M86mrk3g44cw8Kxi1X3DR6z9gx5B1Nd+vpys+pxFlQ+r0FSiByj3vz6qKlNRfvt6bA
	u85jS1h/LIomCV1MSK4C1c
X-Received: by 2002:a05:690c:62ca:b0:734:c88d:4b2c with SMTP id 00721157ae682-734c88d5486mr58600917b3.45.1758032031644;
        Tue, 16 Sep 2025 07:13:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDbkH04UfACC84Mm/2CNmNFCZMkAKwIcvTDnkIxf4mK1TzJxxkdTFbDyq7Xl6Blxc3z/fC4sY3RimZ1r3sEJA=
X-Received: by 2002:a05:690c:62ca:b0:734:c88d:4b2c with SMTP id
 00721157ae682-734c88d5486mr58600387b3.45.1758032030917; Tue, 16 Sep 2025
 07:13:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915210829.6661-1-daleksan@redhat.com> <aMjFyifxCSIBW3pc@kernel.org>
In-Reply-To: <aMjFyifxCSIBW3pc@kernel.org>
From: Denis Aleksandrov <daleksan@redhat.com>
Date: Tue, 16 Sep 2025 10:13:39 -0400
X-Gm-Features: AS18NWDihcSu5q59HDuH1xkb7oGGDyPsglbp2lsTyW2oX4AA6N5NDRyDC4_ypCY
Message-ID: <CAG+gbFfsx6PHBVXgJb+yRWoip=GzFPtQJwqS4AM-KKPmAEUV_g@mail.gmail.com>
Subject: Re: [PATCH v5] tpm: Prevent local DOS via tpm/tpm0/ppi/*operations
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org, 
	Jan Stancek <jstancek@redhat.com>, Paul Menzel <pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 10:05=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org=
> wrote:
>
> On Mon, Sep 15, 2025 at 05:08:29PM -0400, Denis Aleksandrov wrote:
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
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> >
> > Changes in v5:
> >       - Unlocks the tpm_ppi_lock if cache_ppi_operations() returns and
> >         error.
> >
> >  drivers/char/tpm/tpm_ppi.c | 89 ++++++++++++++++++++++++++++----------
> >  1 file changed, 66 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
> > index d53fce1c9d6f..47655407fea5 100644
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
> > @@ -324,9 +325,30 @@ static ssize_t tpm_show_ppi_tcg_operations(struct =
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
> > +             if (len < 0) {
> > +                     spin_unlock(&tpm_ppi_lock);
> > +                     return len;
> > +             }
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
> > @@ -334,9 +356,30 @@ static ssize_t tpm_show_ppi_vs_operations(struct d=
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
> > +             if (len < 0) {
> > +                     spin_unlock(&tpm_ppi_lock);
> > +                     return len;
> > +             }
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
> Thank you. 'next' has been updated.

Great, thank you for your patience. I'm excited to see the patch upstream :=
)

>
> BR, Jarkko
>

Cheers,
Denis


