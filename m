Return-Path: <linux-integrity+bounces-5615-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EA7A7C35C
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Apr 2025 20:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A40A7A8F29
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Apr 2025 18:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02B721C9E0;
	Fri,  4 Apr 2025 18:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pG8w3F7s"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B7F1B4242
	for <linux-integrity@vger.kernel.org>; Fri,  4 Apr 2025 18:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743793151; cv=none; b=ZiG1Byd9x0xvhoNvINbE7yTAhh9Qa0WUvnLUVsrO0cf9apNHgwaJyalKOf6LTk79CqqDM67Z/Fo96c33P2IpnqS0zlUvUgD2fmPynAmqw73xiAk6DHxQ0wd7N+Gf38BsXGlU/2hR9ARONalm00B2QlMUSdGMrMMDp17+IABVQvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743793151; c=relaxed/simple;
	bh=Akp8TP4w548YBYZdc4wbMePm744tCLFwdjDQVOlgw6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i/1kSfnpzhEmxp1NPon7CvLeuxf2+CZTDqXKUmzceg/OR8uc27GTRv/BjY/NhM9Pj3aROeUlR/9i1Jr79otMk7jg3hzyiu4xO2MXFW7O3ODZJZJuLC3yl1uv7peWeMd6nusc/MIakD8HGaW6Yyqlx7UNJkAh7fX++z9m61Nq2kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pG8w3F7s; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac25d2b2354so422961866b.1
        for <linux-integrity@vger.kernel.org>; Fri, 04 Apr 2025 11:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743793147; x=1744397947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fd2VmCaaJDc5tXmdk0MdBa4CIzTq2IXZ7VVk4lrC7Pg=;
        b=pG8w3F7spPNLaZf1zNcYVymfWxaffYFU378Qc4bR0XDHdDYKqy9D8h2Crk26+h9zMB
         fIV2AyUnOMrmpSUbCOO1ZajXRLJhIYNzuOZfet4Ci3gJRyqPm5VCOj7pRu+6xVS0461B
         EbSg9+5ssiO+O4sQHWCjcJBUXlGGCY2iC0PJGC+LyyBZsVIsII+24r1cKlJ1U55b+cup
         txvWtb1DadzTJk5v3T0dEizp1xY7r7QsC5KivPMaTmvqOCfady4ShfTVb5eyd8XFTzUy
         fD7jGLQMpmLN6a9LV3Wwu2fXtQNttZrzi0kYsRXJsodStZmToXimwLixiNX5QzRPeSLx
         Um1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743793147; x=1744397947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fd2VmCaaJDc5tXmdk0MdBa4CIzTq2IXZ7VVk4lrC7Pg=;
        b=Mfffd/bYdHp4QnREuZ6EHxs9Sfdy2aOQ3oCb+iKF0o225x1TVCZzp5lR2F31ouuhSI
         ShXPfJvC4FeIpRIxDHAMkQUqcKTYolkSwG3YpXHvPrYw7/9Xiqfrl86pC+1U/jzX8ANW
         ZOBVbw91CcQV0LF+yGq9MKLFOhL2ytXq1W681rnuHQN9XdF/PQM1TZzJIxkghGKNAb4b
         aNwwEyrww2lvWGUnzV4s5pvJUBrrPZkAhq4kUxZvTZRUgQYEaR6GmHJyh77e4UxUTtYE
         gkYKUHiicIbTTb3rHZqXhTkga0o8XRCI/2ASt2CWGp23EmaGu/ABwcoplSJEwp7eZkEV
         k2BA==
X-Forwarded-Encrypted: i=1; AJvYcCWoKUB1xxfwPtOqMtoQEpU2Qi3nEi1Xm1usV3d9yYQ882S0awNtIEJ9quXpCGpaFFOUjdGe9HOZbo1EW5EPbcM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8eM3+AUfvLsTC19Z21OGyMAavP0h4OS9vMh2USSyNxxcB6qW+
	yot3EOHCYgiB2ypXObBLVvmLvhSh+ObIZshwVIyOxDFgfd1lY1CL4/tCprOn1rhthr0ytcdsaXs
	Ci23LTnXXUwgD+tz8poFnOGhCNWEA0PZOSHkV
X-Gm-Gg: ASbGnct7aojyk3e6p7XUu4Qn2aEp8BiRL/WjY+56MyDym+RkhKxL60cU1pF7pH+E8VX
	jJ6rUm1KRKmmFvVsqumUnQvomgD7XU4UufceT5lXKcd8FJACd+VkbMTQMQ+MkYnWlJ7AitW7azO
	YjpI+smzImZNk5Lgp6cuswic/ueg==
X-Google-Smtp-Source: AGHT+IHqCOEoVg/cVEabRgMbyepnPj+9o+omnNnoFUpz0K2+9E+TojQ8uIMehRo28tc0RIsdXVGT4xli6xdYcJ/v1sE=
X-Received: by 2002:a17:907:968d:b0:ac7:9817:60aa with SMTP id
 a640c23a62f3a-ac7d6c9fefamr255269966b.2.1743793146895; Fri, 04 Apr 2025
 11:59:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403100943.120738-1-sgarzare@redhat.com> <20250403100943.120738-4-sgarzare@redhat.com>
 <CAAH4kHYcRm1TpcgbtryJAtc6sjeh3hXzW7ApXY4WhcfZ3HEpVw@mail.gmail.com> <CAGxU2F4Zf7Khfqy5UjjPJ096kHHPjhFMN+oxvRTfG1knKca9gA@mail.gmail.com>
In-Reply-To: <CAGxU2F4Zf7Khfqy5UjjPJ096kHHPjhFMN+oxvRTfG1knKca9gA@mail.gmail.com>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Fri, 4 Apr 2025 11:58:54 -0700
X-Gm-Features: ATxdqUGgbFUW9C8F8OO_2JG0wrtdd1BxQD8N08wZ94rnrpOaYv3GcerIOUR9g-k
Message-ID: <CAAH4kHZhsUoxNdJ0F3GeRPhC_JpB4suUA1z44bQ=RpGoR2oHkA@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] tpm: add SNP SVSM vTPM driver
To: Stefano Garzarella <sgarzare@redhat.com>
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

On Fri, Apr 4, 2025 at 11:37=E2=80=AFAM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Fri, 4 Apr 2025 at 19:32, Dionna Amalie Glaze <dionnaglaze@google.com>=
 wrote:
> >
> > On Thu, Apr 3, 2025 at 3:10=E2=80=AFAM Stefano Garzarella <sgarzare@red=
hat.com> wrote:
> > >
> > > From: Stefano Garzarella <sgarzare@redhat.com>
> > >
> > > Add driver for the vTPM defined by the AMD SVSM spec [1].
> > >
> > > The specification defines a protocol that a SEV-SNP guest OS can use =
to
> > > discover and talk to a vTPM emulated by the Secure VM Service Module =
(SVSM)
> > > in the guest context, but at a more privileged level (VMPL0).
> > >
> > > The new tpm-svsm platform driver uses two functions exposed by x86/se=
v
> > > to verify that the device is actually emulated by the platform and to
> > > send commands and receive responses.
> > >
> > > The device cannot be hot-plugged/unplugged as it is emulated by the
> > > platform, so we can use module_platform_driver_probe(). The probe
> > > function will only check whether in the current runtime configuration=
,
> > > SVSM is present and provides a vTPM.
> > >
> > > This device does not support interrupts and sends responses to comman=
ds
> > > synchronously. In order to have .recv() called just after .send() in
> > > tpm_try_transmit(), the .status() callback returns 0, and both
> > > .req_complete_mask and .req_complete_val are set to 0.
> > >
> > > [1] "Secure VM Service Module for SEV-SNP Guests"
> > >     Publication # 58019 Revision: 1.00
> > >
> > > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > > ---
> > > v6:
> > > - removed the `locality` field (set to 0) and the FIXME comment [Jark=
ko]
> > > v5:
> > > - removed cancel/status/req_* ops after rebase on master that cotains
> > >   commit 980a573621ea ("tpm: Make chip->{status,cancel,req_canceled} =
opt")
> > > v4:
> > > - moved "asm" includes after the "linux" includes [Tom]
> > > - allocated buffer separately [Tom/Jarkko/Jason]
> > > v3:
> > > - removed send_recv() ops and followed the ftpm driver implementing .=
status,
> > >   .req_complete_mask, .req_complete_val, etc. [Jarkko]
> > > - removed link to the spec because those URLs are unstable [Borislav]
> > > ---
> > >  drivers/char/tpm/tpm_svsm.c | 128 ++++++++++++++++++++++++++++++++++=
++
> > >  drivers/char/tpm/Kconfig    |  10 +++
> > >  drivers/char/tpm/Makefile   |   1 +
> > >  3 files changed, 139 insertions(+)
> > >  create mode 100644 drivers/char/tpm/tpm_svsm.c
> > >
> > > diff --git a/drivers/char/tpm/tpm_svsm.c b/drivers/char/tpm/tpm_svsm.=
c
> > > new file mode 100644
> > > index 000000000000..b9242c9eab87
> > > --- /dev/null
> > > +++ b/drivers/char/tpm/tpm_svsm.c
> > > @@ -0,0 +1,128 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
> > > + *
> > > + * Driver for the vTPM defined by the AMD SVSM spec [1].
> > > + *
> > > + * The specification defines a protocol that a SEV-SNP guest OS can =
use to
> > > + * discover and talk to a vTPM emulated by the Secure VM Service Mod=
ule (SVSM)
> > > + * in the guest context, but at a more privileged level (usually VMP=
L0).
> > > + *
> > > + * [1] "Secure VM Service Module for SEV-SNP Guests"
> > > + *     Publication # 58019 Revision: 1.00
> > > + */
> > > +
> > > +#include <linux/module.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/tpm_svsm.h>
> > > +
> > > +#include <asm/sev.h>
> > > +
> > > +#include "tpm.h"
> > > +
> > > +struct tpm_svsm_priv {
> > > +       void *buffer;
> > > +};
> > > +
> > > +static int tpm_svsm_send(struct tpm_chip *chip, u8 *buf, size_t len)
> > > +{
> > > +       struct tpm_svsm_priv *priv =3D dev_get_drvdata(&chip->dev);
> > > +       int ret;
> > > +
> > > +       ret =3D svsm_vtpm_cmd_request_fill(priv->buffer, 0, buf, len)=
;
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       /*
> > > +        * The SVSM call uses the same buffer for the command and for=
 the
> > > +        * response, so after this call, the buffer will contain the =
response
> > > +        * that can be used by .recv() op.
> > > +        */
> > > +       return snp_svsm_vtpm_send_command(priv->buffer);
> > > +}
> > > +
> > > +static int tpm_svsm_recv(struct tpm_chip *chip, u8 *buf, size_t len)
> > > +{
> > > +       struct tpm_svsm_priv *priv =3D dev_get_drvdata(&chip->dev);
> > > +
> > > +       /*
> > > +        * The internal buffer contains the response after we send th=
e command
> > > +        * to SVSM.
> > > +        */
> > > +       return svsm_vtpm_cmd_response_parse(priv->buffer, buf, len);
> > > +}
> > > +
> > > +static struct tpm_class_ops tpm_chip_ops =3D {
> > > +       .flags =3D TPM_OPS_AUTO_STARTUP,
> > > +       .recv =3D tpm_svsm_recv,
> > > +       .send =3D tpm_svsm_send,
> > > +};
> > > +
> > > +static int __init tpm_svsm_probe(struct platform_device *pdev)
> > > +{
> > > +       struct device *dev =3D &pdev->dev;
> > > +       struct tpm_svsm_priv *priv;
> > > +       struct tpm_chip *chip;
> > > +       int err;
> > > +
> > > +       if (!snp_svsm_vtpm_probe())
> > > +               return -ENODEV;
> > > +
> > > +       priv =3D devm_kmalloc(dev, sizeof(*priv), GFP_KERNEL);
> > > +       if (!priv)
> > > +               return -ENOMEM;
> > > +
> > > +       /*
> > > +        * The maximum buffer supported is one page (see SVSM_VTPM_MA=
X_BUFFER
> > > +        * in tpm_svsm.h).
> > > +        */
> > > +       priv->buffer =3D (void *)devm_get_free_pages(dev, GFP_KERNEL,=
 0);
> > > +       if (!priv->buffer)
> > > +               return -ENOMEM;
> > > +
> > > +       chip =3D tpmm_chip_alloc(dev, &tpm_chip_ops);
> > > +       if (IS_ERR(chip))
> > > +               return PTR_ERR(chip);
> > > +
> > > +       dev_set_drvdata(&chip->dev, priv);
> > > +
> > > +       err =3D tpm2_probe(chip);
> >
> > Our testing is showing that tpm2_probe is hitting a null pointer deref
> > in tpm_transmit.
>
> Next time, please share a backtrace.

Right, my bad.
>
> BTW I suspect you're not using Linus' tree, so be sure to backport
> also commit 980a573621ea ("tpm: Make
> chip->{status,cancel,req_canceled} opt").
>
> Without that, you will have a null ptr dereference since .status() is
> NULL from v5 of this series (as specified in the changelog).

Thanks, I missed that detail. Will report back.
>
> Stefano

>


--
-Dionna Glaze, PhD, CISSP, CCSP (she/her)

