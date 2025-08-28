Return-Path: <linux-integrity+bounces-6945-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6E7B3A48A
	for <lists+linux-integrity@lfdr.de>; Thu, 28 Aug 2025 17:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43BE8685F41
	for <lists+linux-integrity@lfdr.de>; Thu, 28 Aug 2025 15:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396A822A7E0;
	Thu, 28 Aug 2025 15:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D5KPIw9J"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBBF21ADC5
	for <linux-integrity@vger.kernel.org>; Thu, 28 Aug 2025 15:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756395348; cv=none; b=uTxc/ZkkHqidg+5afby+0sO5bhl0/4XPJ7vTLoBOv8ouabQq2R/4JGbnxhJSVIS2plX4lII+zpRJ9h8JQOLhy6a00vkTdOYVuOUCqZbeIS01WTyYGfCnpXN8PNErH4e1ltUyA/A+hH7G1lSmvhvDD95eBTLWZrzIiO9+7iSGzXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756395348; c=relaxed/simple;
	bh=H92C1Yz01XyYSgf/OdIVa6XLNCPukCsdxoQCgUse4SU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+027v+pvmkBRZ0GxDkewPOuCfNBfJyfQA1Y+lmliMw++wYqnhDJZNoNkivA8yxRCb0o1tTiAsdyJ/E3lTC0LdV0AydfgaTJF+Xtqji2M8a6e0M+mcdLfjllUmVmXXXcXbgCN/5T3aebwlEktaowT5BQYCzAomcd+5iMc8uBvt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D5KPIw9J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756395345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7rv4pkaCteUar9oUYTAOPG7tykKS+LwZL1MhFGKy8pU=;
	b=D5KPIw9JGm71ltkGMZsZl0OSaQHmY7nRjMHi3hmN2KHe6LmVCf9mbect42ikdKHhCIhiQX
	A1iV1OXCEVumjiJarrsK9U+l8PneDTe94/YEVSzITGH6wpJhOdBa2swJzKijYPuo7ARWF9
	pJybVFTs5hL/33iQhNo991c/tMnHCfs=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-qYsZXPWEMge5-3slBgOoiQ-1; Thu, 28 Aug 2025 11:35:43 -0400
X-MC-Unique: qYsZXPWEMge5-3slBgOoiQ-1
X-Mimecast-MFC-AGG-ID: qYsZXPWEMge5-3slBgOoiQ_1756395343
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-71d60183b47so12127277b3.0
        for <linux-integrity@vger.kernel.org>; Thu, 28 Aug 2025 08:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756395343; x=1757000143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7rv4pkaCteUar9oUYTAOPG7tykKS+LwZL1MhFGKy8pU=;
        b=cpKDCWTsBnoVf5k1KC5d9/42/RjDXz5abp4JIXOyVgn7ftiNiG2Nyew5MWNGtq3AKr
         vUE6IAT4fSumYFh7upN23n4XnQpJe9B3RrBAXWXEWn1CEiUOSLI93jAKaVHb+cTGTYbn
         C0wISrRTfsleWCJ9FAydM9JpG7fkk1DLU17av4dOPDQ0b76WCsjx3rMjRdd9TjwNgaA5
         ItAL9p0nTspKcYK68JYxUWX5iTBG44U7kNL6wisZJ7WfYnVXZhkL521yJ7ym1vSrkVFn
         OFle3IyngvIT/vIBbcDB5x9oHZw4ZIWeCO3JJVEmBcQpNAvIYer0z67hVzT97m9iykgb
         +ecw==
X-Forwarded-Encrypted: i=1; AJvYcCV5MPi0OtS1gvfPLA3kI8rUPNb9c2Gjb0LLsrIuDZ8Y2vPlGog4jTHPFinrs3D2b3wmqW/jaJSOtwbmo/ScyrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvgeqKikeJ5GQZ1hPC3BIyoaNkvtZI2N2jVI8di2FxpKAycHN5
	sgljlSUZNnxKwJ1ODQocS2Lgvls/U1T3MABjgYMBsK90K9mST4KUczFG7Q2aYx/2ze7Qsb7eZvw
	b2Xyf9eH5ZOif6czDMAEmAw585gW/VqJFJjDpUlBI1+U5Fz3y/0F3KbGQ7aBk1Jt+Mrs0J/rOU7
	iaYIovu21JJlmtap7v760/qhdfBIcduFL1KIFJaLMS+mChwLVU0nbujXU=
X-Gm-Gg: ASbGncuLAgkdlWnDsqDOeWZGoUThjpIJ/ufVaqaJr7pJBj3+zRf+XOE+Vg7TG5fIh0E
	ZC03cRfW8HObu8pOVj7LyzFUmjwXkqh2a+Irp0qrQY+ihKvcoiAx+fv4qhYdW0XrI2SwYdRfqeG
	ppQzj9TeNFSKba3QHpyRHXdA==
X-Received: by 2002:a05:690c:a91:b0:71a:1ed1:a1e0 with SMTP id 00721157ae682-71fdc40fd0amr270730457b3.42.1756395342753;
        Thu, 28 Aug 2025 08:35:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlg39DIq0LFdeJsQbXbHb74zvhwaN/Vzv0C4e9M2lfPjfMIpYEDET1BlsbtqB415jsUw+GVkVdDcdt3iogojU=
X-Received: by 2002:a05:690c:a91:b0:71a:1ed1:a1e0 with SMTP id
 00721157ae682-71fdc40fd0amr270729897b3.42.1756395342114; Thu, 28 Aug 2025
 08:35:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827022102.17731-1-daleksan@redhat.com> <e576d3a8-2693-4445-8cd0-997afb5e5dc2@molgen.mpg.de>
 <aK7-rTTqg--lM9if@kernel.org>
In-Reply-To: <aK7-rTTqg--lM9if@kernel.org>
From: Denis Aleksandrov <daleksan@redhat.com>
Date: Thu, 28 Aug 2025 11:35:31 -0400
X-Gm-Features: Ac12FXz3gt27c5pqeBDa1htJ7QFwm1F6V1CGzOdBdlCEvoxVknLq4JtW7GZHz7Q
Message-ID: <CAG+gbFd-Y=VO0c7zU8a9DtpAEHGDjhpwk_nsiBg5FHA1qVy4yg@mail.gmail.com>
Subject: Re: [PATCH v2] tpm: prevents local DOS via tpm/tpm0/ppi/*operations
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, peterhuewe@gmx.de, jgg@ziepe.ca, 
	linux-integrity@vger.kernel.org, Jan Stancek <jstancek@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 8:48=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> On Wed, Aug 27, 2025 at 07:55:23AM +0200, Paul Menzel wrote:
> > Dear Denis,
> >
> >
> > Thank you for your patch. In the summary, I=E2=80=99d use imperative mo=
od:
>
> +1
>

I can add this in a v3.

> >
> > tpm: Prevent local DOS =E2=80=A6
> >
> > Am 27.08.25 um 04:21 schrieb Denis Aleksandrov:
> > > Reads on tpm/tpm0/ppi/*operations can become very long on
> > > misconfigured systems. Reading the TPM is a blocking operation,
> > > thus a user could effectively trigger a DOS.
> > >
> > > Resolve this by caching the results and avoiding the blocking
> > > operations after the first read.
> >
> > If you could elaborate, how to test this, and in possible error cases, =
how
> > to debug this =E2=80=93 for example, how to disable the cache=E2=80=93,=
 that=E2=80=99d be great.
>
> +1
>

The issue is that this bug is not replicable on most systems, but the way t=
hat
I've been able to test it is by running the following:
$ time cat /sys/devices/pnp0/00:0a/tpm/tpm0/ppi/tcg_operations
and
$ time cat /sys/devices/pnp0/00:0a/tpm/tpm0/ppi/vs_operations
On a system that I know is experiencing the DOS symptom.

For debugging, I've been using an unpatched kernel and running the same
commands.

> >
> > >
> > > Reported-by: Jan Stancek <jstancek@redhat.com>
> > > Signed-off-by: Denis Aleksandrov <daleksan@redhat.com>

I'll make sure to add the Suggested-by tag in the future, and the v3.
Sorry about that.

> > > ---
> > >
> > > Changes in v2:
> > >   - Replaced file permission change with a caching mechanism as
> > >     suggested by Jarkko.
> > >
> > >   drivers/char/tpm/tpm_ppi.c | 88 ++++++++++++++++++++++++++++-------=
---
> > >   1 file changed, 65 insertions(+), 23 deletions(-)
> > >
> > > diff --git a/drivers/char/tpm/tpm_ppi.c b/drivers/char/tpm/tpm_ppi.c
> > > index d53fce1c9d6f..e0212893748e 100644
> > > --- a/drivers/char/tpm/tpm_ppi.c
> > > +++ b/drivers/char/tpm/tpm_ppi.c
> > > @@ -33,6 +33,21 @@ static const guid_t tpm_ppi_guid =3D
> > >     GUID_INIT(0x3DDDFAA6, 0x361B, 0x4EB4,
> > >               0xA4, 0x24, 0x8D, 0x10, 0x08, 0x9D, 0x16, 0x53);
> > > +static const char * const tpm_ppi_info[] =3D {
> > > +   "Not implemented",
> > > +   "BIOS only",
> > > +   "Blocked for OS by BIOS",
> >
> > Is this x86 specific? If not maybe use *system firmware*?
> >

This was the original implementation, but I can change the info message to
be more general. I can add it to the v3.

> > > +   "User required",
> > > +   "User not required",
> > > +};
> > > +
> > > +/* A spinlock to protect access to the cache from concurrent reads *=
/
> > > +static DEFINE_SPINLOCK(tpm_ppi_lock);
> > > +
> > > +static u32 ppi_operations_cache[PPI_VS_REQ_END + 1];
> > > +
> > > +static bool ppi_cache_populated;
> > > +
> > >   static bool tpm_ppi_req_has_parameter(u64 req)
> > >   {
> > >     return req =3D=3D 23;
> > > @@ -277,8 +292,7 @@ static ssize_t tpm_show_ppi_response(struct devic=
e *dev,
> > >     return status;
> > >   }
> > > -static ssize_t show_ppi_operations(acpi_handle dev_handle, char *buf=
, u32 start,
> > > -                              u32 end)
> > > +static ssize_t cache_ppi_operations(acpi_handle dev_handle, char *bu=
f)
> > >   {
> > >     int i;
> > >     u32 ret;
> > > @@ -286,34 +300,22 @@ static ssize_t show_ppi_operations(acpi_handle =
dev_handle, char *buf, u32 start,
> > >     union acpi_object *obj, tmp;
> > >     union acpi_object argv =3D ACPI_INIT_DSM_ARGV4(1, &tmp);
> > > -   static char *info[] =3D {
> > > -           "Not implemented",
> > > -           "BIOS only",
> > > -           "Blocked for OS by BIOS",
> > > -           "User required",
> > > -           "User not required",
> > > -   };
> > > -
> > >     if (!acpi_check_dsm(dev_handle, &tpm_ppi_guid, TPM_PPI_REVISION_I=
D_1,
> > >                         1 << TPM_PPI_FN_GETOPR))
> > >             return -EPERM;
> > >     tmp.integer.type =3D ACPI_TYPE_INTEGER;
> > > -   for (i =3D start; i <=3D end; i++) {
> > > +   for (i =3D 0; i <=3D PPI_VS_REQ_END; i++) {
> > >             tmp.integer.value =3D i;
> > >             obj =3D tpm_eval_dsm(dev_handle, TPM_PPI_FN_GETOPR,
> > >                                ACPI_TYPE_INTEGER, &argv,
> > >                                TPM_PPI_REVISION_ID_1);
> > > -           if (!obj) {
> > > +           if (!obj)
> > >                     return -ENOMEM;
> > > -           } else {
> > > -                   ret =3D obj->integer.value;
> > > -                   ACPI_FREE(obj);
> > > -           }
> > > -           if (ret > 0 && ret < ARRAY_SIZE(info))
> > > -                   len +=3D sysfs_emit_at(buf, len, "%d %d: %s\n",
> > > -                                        i, ret, info[ret]);
> > > +           ret =3D obj->integer.value;
> > > +           ppi_operations_cache[i] =3D ret;
> > > +           ACPI_FREE(obj);
> > >     }
> > >     return len;
> > > @@ -323,20 +325,60 @@ static ssize_t tpm_show_ppi_tcg_operations(stru=
ct device *dev,
> > >                                        struct device_attribute *attr,
> > >                                        char *buf)
> > >   {
> > > +   int i;
> > > +   ssize_t len =3D 0;
> > > +   u32 ret;
> > >     struct tpm_chip *chip =3D to_tpm_chip(dev);
> > > -   return show_ppi_operations(chip->acpi_dev_handle, buf, 0,
> > > -                              PPI_TPM_REQ_MAX);
> > > +   spin_lock(&tpm_ppi_lock);
> > > +   if (!ppi_cache_populated) {
> > > +           len =3D cache_ppi_operations(chip->acpi_dev_handle, buf);
> > > +
> > > +           if (len < 0)
> > > +                   return len;
> > > +
> > > +           ppi_cache_populated =3D true;
> > > +   }
> > > +
> > > +   for (i =3D 0; i <=3D PPI_TPM_REQ_MAX; i++) {
> > > +           ret =3D ppi_operations_cache[i];
> > > +           if (ret > 0 && ret < ARRAY_SIZE(tpm_ppi_info))

To the point of minimally changing the original code, I also noticed that t=
he
"Not Implemented" status never gets reported due to the above conditional.
Would it make sense to change "ret > 0" to "ret >=3D 0" for full reporting,=
 in
both tpm_show_tcg/vs_operations()?

Please let me know what your thoughts are about adding this to the v3.


> > > +                   len +=3D sysfs_emit_at(buf, len, "%d %d: %s\n",
> > > +                                                   i, ret, tpm_ppi_i=
nfo[ret]);
> > > +   }
> > > +   spin_unlock(&tpm_ppi_lock);
> > > +
> > > +   return len;
> > >   }
> > >   static ssize_t tpm_show_ppi_vs_operations(struct device *dev,
> > >                                       struct device_attribute *attr,
> > >                                       char *buf)
> > >   {
> > > +   int i;
> > > +   ssize_t len =3D 0;
> > > +   u32 ret;
> > >     struct tpm_chip *chip =3D to_tpm_chip(dev);
> > > -   return show_ppi_operations(chip->acpi_dev_handle, buf, PPI_VS_REQ=
_START,
> > > -                              PPI_VS_REQ_END);
> > > +   spin_lock(&tpm_ppi_lock);
> > > +   if (!ppi_cache_populated) {
> > > +           len =3D cache_ppi_operations(chip->acpi_dev_handle, buf);
> > > +
> > > +           if (len < 0)
> > > +                   return len;
> > > +
> > > +           ppi_cache_populated =3D true;
> > > +   }
> > > +
> > > +   for (i =3D PPI_VS_REQ_START; i <=3D PPI_VS_REQ_END; i++) {
> > > +           ret =3D ppi_operations_cache[i];
> > > +           if (ret > 0 && ret < ARRAY_SIZE(tpm_ppi_info))
> > > +                   len +=3D sysfs_emit_at(buf, len, "%d %d: %s\n",
> > > +                                                   i, ret, tpm_ppi_i=
nfo[ret]);
> > > +   }
> > > +   spin_unlock(&tpm_ppi_lock);
> > > +
> > > +   return len;
> > >   }
> > >   static DEVICE_ATTR(version, S_IRUGO, tpm_show_ppi_version, NULL);
> >
> > The diff looks good. Feel free to carry:
> >
> > Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>
> Could you look at the next patch as a sanity check for the issues that
> you addressed? I highly appreciate your great comments on details like
> the ones you put out, thank you.
>
> >
> >
> > Kind regards,
> >
> > Paul Menzel
>
> BR, Jarkko
>

Thank you all for your detailed reviews and suggestions. Once the
final review is made,
I'll make sure to make the proper corrections before sending in the v3.

Cheers,
Denis


