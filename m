Return-Path: <linux-integrity+bounces-5533-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF375A76FBE
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Mar 2025 22:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 090291886893
	for <lists+linux-integrity@lfdr.de>; Mon, 31 Mar 2025 20:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297F821B9E2;
	Mon, 31 Mar 2025 20:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xxfGtO9x"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B67421B9DC
	for <linux-integrity@vger.kernel.org>; Mon, 31 Mar 2025 20:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743454596; cv=none; b=Skm4AGLS0iw5cTeUJg+LjxXbc13E1dp4afJPdK1yncemjUGWLkBq0M+rUN9aywpmkEu9j79pgB7tZPQio2n03lkaRGJdnj0ayziUyztz/PwOzZkq/FBAuG0rGNrjjanMxwrjRIxZFifRJwk7pFrzW1r+GRao9yv7S99ryRPPRaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743454596; c=relaxed/simple;
	bh=0pByYo/m1oO08mHiQN3LGCDX1MTAfljCRfBH7G57rx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nw0+R3lgDdRie46RLm9JKp2u+u59yIaYoJ73oIw59jla/XwyjlenWBxZUTYX2MqiJtiZDxzqKoDXz2v+PF6pvaquyJSakgyOvdCWJpVU4n1fdC52z7SO4QUuOmchfSbSrvZ9CRDK3P6vhTbP8D/jWSWWlj9ZkadPNA/b6nnnhRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xxfGtO9x; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac2a089fbbdso871515166b.1
        for <linux-integrity@vger.kernel.org>; Mon, 31 Mar 2025 13:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743454592; x=1744059392; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMFZIJLHMLFfbbHCZUqErm/om6E3FaM9SCzxRtHFq/Q=;
        b=xxfGtO9xi1KNq5ufPnL9DmU2h6rZQ0Ease5F79TxqVlvu2KW8hQg8wftj/8iuZoM1g
         O7oeX3EVEb/zNzZN2yyyO1/UpCFnRG8l6B4IwKb2pssNSvnr2W7Y+KGUzZBIYAXgybKi
         eq28YkbBqG0JCukfSsv655rj0oCM4eetppWDiskWk2K46GDAnLoXkz6Dii6gZh+DVAYu
         j6B2JKw7HrMGL1oc1PceGgM6pfPazZbbiPuPGzBnFcENIX5MpZjH8vj/uSocuzYxqGmR
         08oG9dQgH2u2QtryNC4XUgMKxG3buSXc22JhTrwdoTgfxuxN75vM5kI70cWG006rTLYq
         +Mlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743454592; x=1744059392;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eMFZIJLHMLFfbbHCZUqErm/om6E3FaM9SCzxRtHFq/Q=;
        b=iE7saz8CQ75pY8FRG/ndujl+YD4jKYjbiH+K7HEkpISNH3PM376sVJi1AoDUT+NuL+
         Fl+XmyK9kmJIJIpc+ANlATBWgiZ8Dd+SNoXyj/tPWO2LncIvR04PiRo30ggLTBuFCaSd
         IgDLjmesEh4WFlosYi9p43th16LrHgePl8JrZHWbfVxqFYWmeIqv0ZMVu6mZN7qq+Q4Q
         9saM9ocqYWgXlVSTQdVTwyzRBaWzu586oRlmVmOvINHFqhy52ohHimlK+pRtlzJONZOt
         duk1z2JnDU8/G+qDzPoYsuegREo6RXlJQJ2IdezsdebP2HGUQPK/yvkwpLwjvk8b6gY+
         aZ+g==
X-Forwarded-Encrypted: i=1; AJvYcCV80+Kb5eGlpOMY82D3xOzUwpPk1OmRiadKWEehg52MqAXxrgSB7e83Xpwe1aWsPBfhtxJV4nDAyI/Y3vgOQ98=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhft+89MuO920+6gN5YjRsQvMp62f0cLYR00kRxcWJ/mBsthu1
	ZPB0DlFhbOkKTTPaFUxobVyzVClIOn/nO4WwkW52R38JfN3X6jwmKes+KwGBYHG+16kNWWl6omF
	XMdUqSJIWG7YDbNuyhjnVU1EILMh65qg2ggGa
X-Gm-Gg: ASbGncvl++u7Bx3LO0R2RDINFZEDKylCCaoNiiDmoQaK0LIolfUpjjVMa4/KazM8Afu
	qK60mlQTUC1USoRw2P+VmhXBiep4O7KPg31UL1tMeFwi38RcHuPLtUpkMiuPnqf8NixHjvf+lzZ
	cW7JWVOSPa0kPvjqXEL4P98W/9
X-Google-Smtp-Source: AGHT+IH2OrHRiZFl4Zx4EeGDFhwP+R719BUvxihcuKGW5gBmsdKcrfpG95lRcFRV8Rgidgp6mcsdFS6maClNn4YgpQ8=
X-Received: by 2002:a17:907:868d:b0:ac7:4d51:a75f with SMTP id
 a640c23a62f3a-ac74d51bb38mr781558366b.2.1743454592001; Mon, 31 Mar 2025
 13:56:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331103900.92701-1-sgarzare@redhat.com> <20250331103900.92701-4-sgarzare@redhat.com>
 <Z-rSMi2uCvShLbLS@kernel.org>
In-Reply-To: <Z-rSMi2uCvShLbLS@kernel.org>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Mon, 31 Mar 2025 13:56:20 -0700
X-Gm-Features: AQ5f1JoPS4PMiTFlmKgvgRB6Wf13_tuys_dCoPVlhpi0HfXVLgVRwNBrhZzlmCU
Message-ID: <CAAH4kHY-Orjr_+rcYNemuWrAOOtyrCMD5s6KsOrkX740AARXiA@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] tpm: add SNP SVSM vTPM driver
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, linux-kernel@vger.kernel.org, 
	Jason Gunthorpe <jgg@ziepe.ca>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@alien8.de>, 
	linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, 
	Ingo Molnar <mingo@redhat.com>, linux-coco@lists.linux.dev, 
	Dov Murik <dovmurik@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Joerg Roedel <jroedel@suse.de>, x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>, 
	Claudio Carvalho <cclaudio@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 10:34=E2=80=AFAM Jarkko Sakkinen <jarkko@kernel.org=
> wrote:
>
> On Mon, Mar 31, 2025 at 12:38:56PM +0200, Stefano Garzarella wrote:
> > From: Stefano Garzarella <sgarzare@redhat.com>
> >
> > Add driver for the vTPM defined by the AMD SVSM spec [1].
> >
> > The specification defines a protocol that a SEV-SNP guest OS can use to
> > discover and talk to a vTPM emulated by the Secure VM Service Module (S=
VSM)
> > in the guest context, but at a more privileged level (VMPL0).
> >
> > The new tpm-svsm platform driver uses two functions exposed by x86/sev
> > to verify that the device is actually emulated by the platform and to
> > send commands and receive responses.
> >
> > The device cannot be hot-plugged/unplugged as it is emulated by the
> > platform, so we can use module_platform_driver_probe(). The probe
> > function will only check whether in the current runtime configuration,
> > SVSM is present and provides a vTPM.
> >
> > This device does not support interrupts and sends responses to commands
> > synchronously. In order to have .recv() called just after .send() in
> > tpm_try_transmit(), the .status() callback returns 0, and both
> > .req_complete_mask and .req_complete_val are set to 0.
> >
> > [1] "Secure VM Service Module for SEV-SNP Guests"
> >     Publication # 58019 Revision: 1.00
> >
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> > v5:
> > - removed cancel/status/req_* ops after rebase on master that cotains
> >   commit 980a573621ea ("tpm: Make chip->{status,cancel,req_canceled} op=
t")
> > v4:
> > - moved "asm" includes after the "linux" includes [Tom]
> > - allocated buffer separately [Tom/Jarkko/Jason]
> > v3:
> > - removed send_recv() ops and followed the ftpm driver implementing .st=
atus,
> >   .req_complete_mask, .req_complete_val, etc. [Jarkko]
> > - removed link to the spec because those URLs are unstable [Borislav]
> > ---
> >  drivers/char/tpm/tpm_svsm.c | 135 ++++++++++++++++++++++++++++++++++++
> >  drivers/char/tpm/Kconfig    |  10 +++
> >  drivers/char/tpm/Makefile   |   1 +
> >  3 files changed, 146 insertions(+)
> >  create mode 100644 drivers/char/tpm/tpm_svsm.c
> >
> > diff --git a/drivers/char/tpm/tpm_svsm.c b/drivers/char/tpm/tpm_svsm.c
> > new file mode 100644
> > index 000000000000..04c532421ff2
> > --- /dev/null
> > +++ b/drivers/char/tpm/tpm_svsm.c
> > @@ -0,0 +1,135 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
> > + *
> > + * Driver for the vTPM defined by the AMD SVSM spec [1].
> > + *
> > + * The specification defines a protocol that a SEV-SNP guest OS can us=
e to
> > + * discover and talk to a vTPM emulated by the Secure VM Service Modul=
e (SVSM)
> > + * in the guest context, but at a more privileged level (usually VMPL0=
).
> > + *
> > + * [1] "Secure VM Service Module for SEV-SNP Guests"
> > + *     Publication # 58019 Revision: 1.00
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/tpm_svsm.h>
> > +
> > +#include <asm/sev.h>
> > +
> > +#include "tpm.h"
> > +
> > +struct tpm_svsm_priv {
> > +     void *buffer;
> > +     u8 locality;
> > +};
> > +
> > +static int tpm_svsm_send(struct tpm_chip *chip, u8 *buf, size_t len)
> > +{
> > +     struct tpm_svsm_priv *priv =3D dev_get_drvdata(&chip->dev);
> > +     int ret;
> > +
> > +     ret =3D svsm_vtpm_cmd_request_fill(priv->buffer, priv->locality, =
buf, len);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /*
> > +      * The SVSM call uses the same buffer for the command and for the
> > +      * response, so after this call, the buffer will contain the resp=
onse
> > +      * that can be used by .recv() op.
> > +      */
> > +     return snp_svsm_vtpm_send_command(priv->buffer);
> > +}
> > +
> > +static int tpm_svsm_recv(struct tpm_chip *chip, u8 *buf, size_t len)
> > +{
> > +     struct tpm_svsm_priv *priv =3D dev_get_drvdata(&chip->dev);
> > +
> > +     /*
> > +      * The internal buffer contains the response after we send the co=
mmand
> > +      * to SVSM.
> > +      */
> > +     return svsm_vtpm_cmd_response_parse(priv->buffer, buf, len);
> > +}
> > +
> > +static struct tpm_class_ops tpm_chip_ops =3D {
> > +     .flags =3D TPM_OPS_AUTO_STARTUP,
> > +     .recv =3D tpm_svsm_recv,
> > +     .send =3D tpm_svsm_send,
> > +};
> > +
> > +static int __init tpm_svsm_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev =3D &pdev->dev;
> > +     struct tpm_svsm_priv *priv;
> > +     struct tpm_chip *chip;
> > +     int err;
> > +
> > +     if (!snp_svsm_vtpm_probe())
> > +             return -ENODEV;
> > +
> > +     priv =3D devm_kmalloc(dev, sizeof(*priv), GFP_KERNEL);
> > +     if (!priv)
> > +             return -ENOMEM;
> > +
> > +     /*
> > +      * The maximum buffer supported is one page (see SVSM_VTPM_MAX_BU=
FFER
> > +      * in tpm_svsm.h).
> > +      */
> > +     priv->buffer =3D (void *)devm_get_free_pages(dev, GFP_KERNEL, 0);
> > +     if (!priv->buffer)
> > +             return -ENOMEM;
> > +
> > +     /*
> > +      * FIXME: before implementing locality we need to agree what it m=
eans
> > +      * for the SNP SVSM vTPM
> > +      */
> > +     priv->locality =3D 0;
>
> I don't think we want FIXME's to mainline. Instead, don't declare the
> field at all if you don't use it. Just pass zero to *_request_fill().
>
> Maybe "not have the field" is even a better reminder than a random fixme
> comment?
>
> > +
> > +     chip =3D tpmm_chip_alloc(dev, &tpm_chip_ops);
> > +     if (IS_ERR(chip))
> > +             return PTR_ERR(chip);
> > +
> > +     dev_set_drvdata(&chip->dev, priv);
> > +
> > +     err =3D tpm2_probe(chip);
> > +     if (err)
> > +             return err;
> > +
> > +     err =3D tpm_chip_register(chip);
> > +     if (err)
> > +             return err;
> > +
> > +     dev_info(dev, "SNP SVSM vTPM %s device\n",
> > +              (chip->flags & TPM_CHIP_FLAG_TPM2) ? "2.0" : "1.2");
> > +
> > +     return 0;
> > +}
> > +
> > +static void __exit tpm_svsm_remove(struct platform_device *pdev)
> > +{
> > +     struct tpm_chip *chip =3D platform_get_drvdata(pdev);
> > +
> > +     tpm_chip_unregister(chip);
> > +}
> > +
> > +/*
> > + * tpm_svsm_remove() lives in .exit.text. For drivers registered via
> > + * module_platform_driver_probe() this is ok because they cannot get u=
nbound
> > + * at runtime. So mark the driver struct with __refdata to prevent mod=
post
> > + * triggering a section mismatch warning.
> > + */
> > +static struct platform_driver tpm_svsm_driver __refdata =3D {
> > +     .remove =3D __exit_p(tpm_svsm_remove),
> > +     .driver =3D {
> > +             .name =3D "tpm-svsm",
> > +     },
> > +};
> > +
> > +module_platform_driver_probe(tpm_svsm_driver, tpm_svsm_probe);

I might be unclear on how I should be testing this, but I do see
/dev/tpm0 and /dev/tpmrm0 when I build with CONFIG_TCG_SVSM=3Dy, but I
don't see the event log in securityfs. What am I missing?

> > +
> > +MODULE_DESCRIPTION("SNP SVSM vTPM Driver");
> > +MODULE_LICENSE("GPL");
> > +MODULE_ALIAS("platform:tpm-svsm");
> > diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> > index fe4f3a609934..dddd702b2454 100644
> > --- a/drivers/char/tpm/Kconfig
> > +++ b/drivers/char/tpm/Kconfig
> > @@ -234,5 +234,15 @@ config TCG_FTPM_TEE
> >       help
> >         This driver proxies for firmware TPM running in TEE.
> >
> > +config TCG_SVSM
> > +     tristate "SNP SVSM vTPM interface"
> > +     depends on AMD_MEM_ENCRYPT
> > +     help
> > +       This is a driver for the AMD SVSM vTPM protocol that a SEV-SNP =
guest
> > +       OS can use to discover and talk to a vTPM emulated by the Secur=
e VM
> > +       Service Module (SVSM) in the guest context, but at a more privi=
leged
> > +       level (usually VMPL0).  To compile this driver as a module, cho=
ose M
> > +       here; the module will be called tpm_svsm.
> > +
> >  source "drivers/char/tpm/st33zp24/Kconfig"
> >  endif # TCG_TPM
> > diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
> > index 2b004df8c04b..9de1b3ea34a9 100644
> > --- a/drivers/char/tpm/Makefile
> > +++ b/drivers/char/tpm/Makefile
> > @@ -45,3 +45,4 @@ obj-$(CONFIG_TCG_CRB) +=3D tpm_crb.o
> >  obj-$(CONFIG_TCG_ARM_CRB_FFA) +=3D tpm_crb_ffa.o
> >  obj-$(CONFIG_TCG_VTPM_PROXY) +=3D tpm_vtpm_proxy.o
> >  obj-$(CONFIG_TCG_FTPM_TEE) +=3D tpm_ftpm_tee.o
> > +obj-$(CONFIG_TCG_SVSM) +=3D tpm_svsm.o
> > --
> > 2.49.0
> >
>
> BR, Jarkko



--=20
-Dionna Glaze, PhD, CISSP, CCSP (she/her)

