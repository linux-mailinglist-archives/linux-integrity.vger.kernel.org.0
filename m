Return-Path: <linux-integrity+bounces-5683-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB05A8213D
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 11:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB51D4677ED
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 09:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9752528E9;
	Wed,  9 Apr 2025 09:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iKUE315f"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BDF22FAFD
	for <linux-integrity@vger.kernel.org>; Wed,  9 Apr 2025 09:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744191943; cv=none; b=tsbF4ocbvuNoODXzWIv9JKFxJLLvX0+JaFmj1yZgIf6P9/V5qvsMyhq12YqFBEIinuXXeTSA/+a3R/V+cE5nYyHeXL9TV1vnup4zni8qHpCd+qSrbkvMKZktVL3yYLO0DmXC+muCxiYgF1pwSm3LtyRlm67N/39KqSKDaAcKRlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744191943; c=relaxed/simple;
	bh=XjjUhTS9VJr1Zufc1xdYWqFTAUH4jrHIaqx6RaRNeG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I+/BMcxhxt5QAxjz76lDSKMfxdSJey4bJXp/1SBj7lcowdAYni9PizcS/lic8ux/bmM1jHMEuBJDB+hfmLiypQrmZsx5nF++GpEKmojBpbOxb2Z1K8ZANVmwyKY345C5WYOQW96v4e3aw7dkAyhH4gbra6z9et7eESUi/Lc3dok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iKUE315f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744191940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TKVfH0bP0xouirfCCs2OtGdx4KFsMNg0TzzFUxvnY5M=;
	b=iKUE315feBPg7rk2SuMHMA7NjN9c+IZrdml8qRs1I5mQV0trSJ1lJh5M2Icc1BFnGL43lt
	ip/1hLuKl/Z1FttMbX05e339gq139JgKgPFCYqxHGiX2PSmPFWzvaTr7MBX6CGp3YSrCkI
	pZ1plv60jj4gsvAZgSK8Mxp/+/S5ZGc=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-cSUs1bcKPvW6j3ssQqCg9w-1; Wed, 09 Apr 2025 05:45:39 -0400
X-MC-Unique: cSUs1bcKPvW6j3ssQqCg9w-1
X-Mimecast-MFC-AGG-ID: cSUs1bcKPvW6j3ssQqCg9w_1744191938
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e6df6f86c89so1007034276.0
        for <linux-integrity@vger.kernel.org>; Wed, 09 Apr 2025 02:45:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744191938; x=1744796738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKVfH0bP0xouirfCCs2OtGdx4KFsMNg0TzzFUxvnY5M=;
        b=Kx0/q1IRnSPBaG4x9yDFAucmbK+Vy4PclUjjhNqMsZl36N2rO9KHrIxR8qW23UUDSz
         IhVyb/ObRP+HaWTZF1bwSda3IlmZ6JID3777osPwrE7zp08YzSqbP68u+LgNwy4yI1Oo
         Nprq4F4zZq14nFc3vCNCSpKK24UUGlTqSe72098TCg69FEgEXn9uvwTu8XDVd0kTv4yt
         MvaeqV0v41ROiQquVUuq7vQlQvSJOYw/vOH19AKi+vhjakV12vxbaY+N5u0zis3YFkX5
         rMqivOd9ikTGw9uzzoATOJm68bUrYUWWYV15ttVDwIrVPnY6bQLkngAokfsEGl6B7pWR
         tNQw==
X-Forwarded-Encrypted: i=1; AJvYcCV6HJqRLuKzXi9Ig69XPkl0UjCXv8YkJRAJj0XoxEvQvkm9+2cWVU9vkoZ2uwbAw5Y4XFanCOEZ7swsR2iE/Q8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDzIeu7dXp2tDy2MDBm4QREcpMQUd6UGB8NplOoA1oyVbJp0eB
	qd9QqiDdkhHlQw6tpSzI/ZMQh8dj0o/aq9Fp9vB6HqJb0PtpBWkEnSHp6FYuUON9VlAYxA2KeR2
	g3fRk57F4Cc9QdgKM3HYTcZ0N9l6shVAgVowkVRrdXP+LSrpP7ztevruM1n8DqIlP7BQB19WyvK
	ospGMiaTy7t3t++SS8DGG8Bzvni9EGPf/iE9OY7/W5
X-Gm-Gg: ASbGncu7ymXKsos4nv8/mdIFzFZS0lyVHoD/gvVIyaeM/svzGSwtZPBAia4Qw+pjit5
	dVjgv2Wq7Zz13LMDj6EP4+Run/iNNqXCOZS3quLQI0U8txtiu/aq4UH6TdA9knHHNPTk=
X-Received: by 2002:a05:6902:228e:b0:e6b:7e33:b637 with SMTP id 3f1490d57ef6-e702e26d5a7mr3856601276.14.1744191938555;
        Wed, 09 Apr 2025 02:45:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHisCB7623SUDNdsp8qFrjYJi4J8Do54OWEhkmaIUaKl/L0t4PRuH343+79GsCY6oG9Gt8oA6rIXzIcnfJq5EU=
X-Received: by 2002:a05:6902:228e:b0:e6b:7e33:b637 with SMTP id
 3f1490d57ef6-e702e26d5a7mr3856573276.14.1744191938238; Wed, 09 Apr 2025
 02:45:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403100943.120738-1-sgarzare@redhat.com> <20250403100943.120738-4-sgarzare@redhat.com>
 <CAAH4kHYcRm1TpcgbtryJAtc6sjeh3hXzW7ApXY4WhcfZ3HEpVw@mail.gmail.com>
 <CAGxU2F4Zf7Khfqy5UjjPJ096kHHPjhFMN+oxvRTfG1knKca9gA@mail.gmail.com> <CAAH4kHZhsUoxNdJ0F3GeRPhC_JpB4suUA1z44bQ=RpGoR2oHkA@mail.gmail.com>
In-Reply-To: <CAAH4kHZhsUoxNdJ0F3GeRPhC_JpB4suUA1z44bQ=RpGoR2oHkA@mail.gmail.com>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 9 Apr 2025 11:45:27 +0200
X-Gm-Features: ATxdqUEHc0oIxvcOqNXD1IH1Pn8Q_A7cyhZV-Uk3hwANcZdEi5U4ok4pB4uuUD0
Message-ID: <CAGxU2F7NDvHPhyHbN+dBjVta2NLstyoV2SQ6VkwDTf2FiKLasA@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] tpm: add SNP SVSM vTPM driver
To: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-coco@lists.linux.dev, linux-integrity@vger.kernel.org, 
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Joerg Roedel <jroedel@suse.de>, 
	Claudio Carvalho <cclaudio@linux.ibm.com>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, linux-kernel@vger.kernel.org, 
	Dov Murik <dovmurik@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 4 Apr 2025 at 20:59, Dionna Amalie Glaze <dionnaglaze@google.com> w=
rote:
>
> On Fri, Apr 4, 2025 at 11:37=E2=80=AFAM Stefano Garzarella <sgarzare@redh=
at.com> wrote:
> >
> > On Fri, 4 Apr 2025 at 19:32, Dionna Amalie Glaze <dionnaglaze@google.co=
m> wrote:
> > >
> > > On Thu, Apr 3, 2025 at 3:10=E2=80=AFAM Stefano Garzarella <sgarzare@r=
edhat.com> wrote:
> > > >
> > > > From: Stefano Garzarella <sgarzare@redhat.com>
> > > >
> > > > Add driver for the vTPM defined by the AMD SVSM spec [1].
> > > >
> > > > The specification defines a protocol that a SEV-SNP guest OS can us=
e to
> > > > discover and talk to a vTPM emulated by the Secure VM Service Modul=
e (SVSM)
> > > > in the guest context, but at a more privileged level (VMPL0).
> > > >
> > > > The new tpm-svsm platform driver uses two functions exposed by x86/=
sev
> > > > to verify that the device is actually emulated by the platform and =
to
> > > > send commands and receive responses.
> > > >
> > > > The device cannot be hot-plugged/unplugged as it is emulated by the
> > > > platform, so we can use module_platform_driver_probe(). The probe
> > > > function will only check whether in the current runtime configurati=
on,
> > > > SVSM is present and provides a vTPM.
> > > >
> > > > This device does not support interrupts and sends responses to comm=
ands
> > > > synchronously. In order to have .recv() called just after .send() i=
n
> > > > tpm_try_transmit(), the .status() callback returns 0, and both
> > > > .req_complete_mask and .req_complete_val are set to 0.
> > > >
> > > > [1] "Secure VM Service Module for SEV-SNP Guests"
> > > >     Publication # 58019 Revision: 1.00
> > > >
> > > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > > ---
> > > > v6:
> > > > - removed the `locality` field (set to 0) and the FIXME comment [Ja=
rkko]
> > > > v5:
> > > > - removed cancel/status/req_* ops after rebase on master that cotai=
ns
> > > >   commit 980a573621ea ("tpm: Make chip->{status,cancel,req_canceled=
} opt")
> > > > v4:
> > > > - moved "asm" includes after the "linux" includes [Tom]
> > > > - allocated buffer separately [Tom/Jarkko/Jason]
> > > > v3:
> > > > - removed send_recv() ops and followed the ftpm driver implementing=
 .status,
> > > >   .req_complete_mask, .req_complete_val, etc. [Jarkko]
> > > > - removed link to the spec because those URLs are unstable [Borisla=
v]
> > > > ---
> > > >  drivers/char/tpm/tpm_svsm.c | 128 ++++++++++++++++++++++++++++++++=
++++
> > > >  drivers/char/tpm/Kconfig    |  10 +++
> > > >  drivers/char/tpm/Makefile   |   1 +
> > > >  3 files changed, 139 insertions(+)
> > > >  create mode 100644 drivers/char/tpm/tpm_svsm.c
> > > >
> > > > diff --git a/drivers/char/tpm/tpm_svsm.c b/drivers/char/tpm/tpm_svs=
m.c
> > > > new file mode 100644
> > > > index 000000000000..b9242c9eab87
> > > > --- /dev/null
> > > > +++ b/drivers/char/tpm/tpm_svsm.c
> > > > @@ -0,0 +1,128 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > +/*
> > > > + * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
> > > > + *
> > > > + * Driver for the vTPM defined by the AMD SVSM spec [1].
> > > > + *
> > > > + * The specification defines a protocol that a SEV-SNP guest OS ca=
n use to
> > > > + * discover and talk to a vTPM emulated by the Secure VM Service M=
odule (SVSM)
> > > > + * in the guest context, but at a more privileged level (usually V=
MPL0).
> > > > + *
> > > > + * [1] "Secure VM Service Module for SEV-SNP Guests"
> > > > + *     Publication # 58019 Revision: 1.00
> > > > + */
> > > > +
> > > > +#include <linux/module.h>
> > > > +#include <linux/kernel.h>
> > > > +#include <linux/platform_device.h>
> > > > +#include <linux/tpm_svsm.h>
> > > > +
> > > > +#include <asm/sev.h>
> > > > +
> > > > +#include "tpm.h"
> > > > +
> > > > +struct tpm_svsm_priv {
> > > > +       void *buffer;
> > > > +};
> > > > +
> > > > +static int tpm_svsm_send(struct tpm_chip *chip, u8 *buf, size_t le=
n)
> > > > +{
> > > > +       struct tpm_svsm_priv *priv =3D dev_get_drvdata(&chip->dev);
> > > > +       int ret;
> > > > +
> > > > +       ret =3D svsm_vtpm_cmd_request_fill(priv->buffer, 0, buf, le=
n);
> > > > +       if (ret)
> > > > +               return ret;
> > > > +
> > > > +       /*
> > > > +        * The SVSM call uses the same buffer for the command and f=
or the
> > > > +        * response, so after this call, the buffer will contain th=
e response
> > > > +        * that can be used by .recv() op.
> > > > +        */
> > > > +       return snp_svsm_vtpm_send_command(priv->buffer);
> > > > +}
> > > > +
> > > > +static int tpm_svsm_recv(struct tpm_chip *chip, u8 *buf, size_t le=
n)
> > > > +{
> > > > +       struct tpm_svsm_priv *priv =3D dev_get_drvdata(&chip->dev);
> > > > +
> > > > +       /*
> > > > +        * The internal buffer contains the response after we send =
the command
> > > > +        * to SVSM.
> > > > +        */
> > > > +       return svsm_vtpm_cmd_response_parse(priv->buffer, buf, len)=
;
> > > > +}
> > > > +
> > > > +static struct tpm_class_ops tpm_chip_ops =3D {
> > > > +       .flags =3D TPM_OPS_AUTO_STARTUP,
> > > > +       .recv =3D tpm_svsm_recv,
> > > > +       .send =3D tpm_svsm_send,
> > > > +};
> > > > +
> > > > +static int __init tpm_svsm_probe(struct platform_device *pdev)
> > > > +{
> > > > +       struct device *dev =3D &pdev->dev;
> > > > +       struct tpm_svsm_priv *priv;
> > > > +       struct tpm_chip *chip;
> > > > +       int err;
> > > > +
> > > > +       if (!snp_svsm_vtpm_probe())
> > > > +               return -ENODEV;
> > > > +
> > > > +       priv =3D devm_kmalloc(dev, sizeof(*priv), GFP_KERNEL);
> > > > +       if (!priv)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       /*
> > > > +        * The maximum buffer supported is one page (see SVSM_VTPM_=
MAX_BUFFER
> > > > +        * in tpm_svsm.h).
> > > > +        */
> > > > +       priv->buffer =3D (void *)devm_get_free_pages(dev, GFP_KERNE=
L, 0);
> > > > +       if (!priv->buffer)
> > > > +               return -ENOMEM;
> > > > +
> > > > +       chip =3D tpmm_chip_alloc(dev, &tpm_chip_ops);
> > > > +       if (IS_ERR(chip))
> > > > +               return PTR_ERR(chip);
> > > > +
> > > > +       dev_set_drvdata(&chip->dev, priv);
> > > > +
> > > > +       err =3D tpm2_probe(chip);
> > >
> > > Our testing is showing that tpm2_probe is hitting a null pointer dere=
f
> > > in tpm_transmit.
> >
> > Next time, please share a backtrace.
>
> Right, my bad.
> >
> > BTW I suspect you're not using Linus' tree, so be sure to backport
> > also commit 980a573621ea ("tpm: Make
> > chip->{status,cancel,req_canceled} opt").
> >
> > Without that, you will have a null ptr dereference since .status() is
> > NULL from v5 of this series (as specified in the changelog).
>
> Thanks, I missed that detail. Will report back.

I'm preparing v7, is your issue solved or do we need to investigate
better before sending a v7?

Thanks,
Stefano


