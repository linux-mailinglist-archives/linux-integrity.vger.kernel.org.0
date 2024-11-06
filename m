Return-Path: <linux-integrity+bounces-4028-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A739BF0AD
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Nov 2024 15:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B9E91F212A9
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Nov 2024 14:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEA5202F74;
	Wed,  6 Nov 2024 14:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6N31rjG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0561DFE3A;
	Wed,  6 Nov 2024 14:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730904620; cv=none; b=g/WBvopmrEJsotJMsz/dZ31YnLvmbSBrZm3q9RwKRXOeC41chVVetbT5WPas5Zzx0KmIs4laup+RKjuTGH/2OcKo/94LSakY9aputHL+IRf3MbvArif5VLrnlo7eif3nR1iSoRHms3ttKJUTyMyJippNVGXOHh4jyRmwV/mAuqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730904620; c=relaxed/simple;
	bh=BTI8mCfd+F1+ZsSIhcKu394EogjHKK4f8R5thMR9/JU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bP2yTdst+AxWl2mwXVb+Tn5WJsSiKmO54PUFAyDWj7ETr1b9mFB+/RUq3rixQ2+cUJgixa9moPdwDM4Vj3UU84eFb2UwR+bd9kPyRpc/rZJu7U0/8VcR8eHLLfDXSLHdJX2Jb6AwsO6uoE1QtRITirnIFOJq1F2mi89R01t4EoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6N31rjG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB5DEC4CED4;
	Wed,  6 Nov 2024 14:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730904620;
	bh=BTI8mCfd+F1+ZsSIhcKu394EogjHKK4f8R5thMR9/JU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=W6N31rjGfOOb21AuwOjYbrLm1LsPNpwjx1H3nfjVrIa/eY7mJjUKcDyzu9iHdVWC4
	 OQiSvi9sfLoz8CCeWutkA6Vl38qRKH0t6KWAXubN49ONqKgkujyuj2bHZVrEPHYSJG
	 jXKAbrJCaKlmFMYd6KOChoO87KuW0FfaJ5uynGGvmfhenJqEIs4lGnEekq1PXSk0uN
	 sJZt5ERQLSo5ZVE4KOOvVce2XFdOZAAqh45V+K1m4SMpqCu4bmXpOJoBMZG1Yvs6Y7
	 ahoYq35DCasl60Q/33pGpWYabdZOx1slY/KGX0fL/1SwXl1Fm3EzE5IzAM03TBRx88
	 wPEdUshb3QWvA==
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e34339d41bso58179127b3.0;
        Wed, 06 Nov 2024 06:50:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUVVXphpOEhga3WJK6dBv9ANUxB+UrbYjD1nYg6+qsfB5z2HWfaX8ZplfbujjtN1x33+ny9wLbwv+16cRK7@vger.kernel.org, AJvYcCWg1NMd9CvyM4F9XWytWqWZz+xMRnNTQ+AtpYQBkjsIVDDMvGAnas7UcvyNpZ7BvvX6z8rakhaGVzWEcSp3vgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCzDbJmthrsI0SAV2T9qVJbuD805l6vdW+a2iEfzbcBwYE1qna
	t2uGXU9m2aysZI/LHa6KpCpM0pBBfQUtGrQ3pU55Rm8m6fHQoksp7y8HP5/aD2C7QyPWmdjWcTD
	2h0c+IMbpkyorDBkgl/KNqsbIMA==
X-Google-Smtp-Source: AGHT+IGQ+HcePls4B68fjLXm2WG2zUD3sxLkDlRwa73g9O74Ed7KDSK8zEDsTM92UO+3R5W3P/C8H8ih65XnTgWZQDo=
X-Received: by 2002:a05:690c:61c9:b0:6e3:31ee:23ab with SMTP id
 00721157ae682-6e9d899d1c2mr405335217b3.25.1730904619096; Wed, 06 Nov 2024
 06:50:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702161052.3563599-1-robh@kernel.org> <D2RSWMPFF8KK.X5HZZMHANQMO@iki.fi>
 <D2RT0J8KXY1H.3MEV7KGQXTWHW@iki.fi> <CAL_JsqJDX+uOSoPh6pTNEP0vBLwcP3bKmAW1wCr_0cVr5fsPcg@mail.gmail.com>
 <D2SSH5HSDHQS.2YJSB22W3MHQK@iki.fi>
In-Reply-To: <D2SSH5HSDHQS.2YJSB22W3MHQK@iki.fi>
From: Rob Herring <robh@kernel.org>
Date: Wed, 6 Nov 2024 08:50:07 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLF+gs9e1TL1yi-xAZJRx4Kz7fOk=2wcF8kCqU3vyMWZA@mail.gmail.com>
Message-ID: <CAL_JsqLF+gs9e1TL1yi-xAZJRx4Kz7fOk=2wcF8kCqU3vyMWZA@mail.gmail.com>
Subject: Re: [PATCH] tpm: atmel: Drop PPC64 specific MMIO setup
To: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 11:01=E2=80=AFAM Jarkko Sakkinen <jarkko.sakkinen@i=
ki.fi> wrote:
>
> On Thu Jul 18, 2024 at 5:57 PM EEST, Rob Herring wrote:
> > On Wed, Jul 17, 2024 at 6:14=E2=80=AFAM Jarkko Sakkinen <jarkko.sakkine=
n@iki.fi> wrote:
> > >
> > > On Wed Jul 17, 2024 at 3:08 PM EEST, Jarkko Sakkinen wrote:
> > > > On Tue Jul 2, 2024 at 7:10 PM EEST, Rob Herring (Arm) wrote:
> > > > > The PPC64 specific MMIO setup open codes DT address functions rat=
her
> > > > > than using standard address parsing functions. The open-coded ver=
sion
> > > > > fails to handle any address translation and is not endian safe.
> > > > >
> > > > > I haven't found any evidence of what platform used this. The only=
 thing
> > > > > that turned up was a PPC405 platform, but that is 32-bit and PPC4=
05
> > > > > support is being removed as well. CONFIG_TCG_ATMEL is not enabled=
 for
> > > > > any powerpc config and never was. The support was added in 2005 a=
nd
> > > > > hasn't been touched since.
> > > > >
> > > > > Rather than try to modernize and fix this code, just remove it.
> > > > >
> > > > > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > > > > ---
> > > > >  drivers/char/tpm/Kconfig     |   2 +-
> > > > >  drivers/char/tpm/tpm_atmel.c |  64 +++++++++++++++-
> > > > >  drivers/char/tpm/tpm_atmel.h | 140 -----------------------------=
------
> > > > >  3 files changed, 62 insertions(+), 144 deletions(-)
> > > > >  delete mode 100644 drivers/char/tpm/tpm_atmel.h
> > > > >
> > > > > diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> > > > > index e63a6a17793c..9b655e9fc7ab 100644
> > > > > --- a/drivers/char/tpm/Kconfig
> > > > > +++ b/drivers/char/tpm/Kconfig
> > > > > @@ -162,7 +162,7 @@ config TCG_NSC
> > > > >
> > > > >  config TCG_ATMEL
> > > > >     tristate "Atmel TPM Interface"
> > > > > -   depends on PPC64 || HAS_IOPORT_MAP
> > > > > +   depends on HAS_IOPORT_MAP
> > > > >     depends on HAS_IOPORT
> > > > >     help
> > > > >       If you have a TPM security chip from Atmel say Yes and it
> > > > > diff --git a/drivers/char/tpm/tpm_atmel.c b/drivers/char/tpm/tpm_=
atmel.c
> > > > > index 9fb2defa9dc4..622c4abe8cb3 100644
> > > > > --- a/drivers/char/tpm/tpm_atmel.c
> > > > > +++ b/drivers/char/tpm/tpm_atmel.c
> > > > > @@ -15,7 +15,67 @@
> > > > >   */
> > > > >
> > > > >  #include "tpm.h"
> > > > > -#include "tpm_atmel.h"
> > > > > +
> > > > > +struct tpm_atmel_priv {
> > > > > +   int region_size;
> > > > > +   int have_region;
> > > > > +   unsigned long base;
> > > > > +   void __iomem *iobase;
> > > > > +};
> > > > > +
> > > > > +#define atmel_getb(chip, offset) inb(atmel_get_priv(chip)->base =
+ offset)
> > > > > +#define atmel_putb(val, chip, offset) \
> > > > > +   outb(val, atmel_get_priv(chip)->base + offset)
> > > > > +#define atmel_request_region request_region
> > > > > +#define atmel_release_region release_region
> > > > > +/* Atmel definitions */
> > > > > +enum tpm_atmel_addr {
> > > > > +   TPM_ATMEL_BASE_ADDR_LO =3D 0x08,
> > > > > +   TPM_ATMEL_BASE_ADDR_HI =3D 0x09
> > > > > +};
> > > > > +
> > > > > +static inline int tpm_read_index(int base, int index)
> > > > > +{
> > > > > +   outb(index, base);
> > > > > +   return inb(base+1) & 0xFF;
> > > > > +}
> > > > > +
> > > > > +/* Verify this is a 1.1 Atmel TPM */
> > > > > +static int atmel_verify_tpm11(void)
> > > > > +{
> > > > > +
> > > > > +   /* verify that it is an Atmel part */
> > > > > +   if (tpm_read_index(TPM_ADDR, 4) !=3D 'A' ||
> > > > > +       tpm_read_index(TPM_ADDR, 5) !=3D 'T' ||
> > > > > +       tpm_read_index(TPM_ADDR, 6) !=3D 'M' ||
> > > > > +       tpm_read_index(TPM_ADDR, 7) !=3D 'L')
> > > > > +           return 1;
> > > > > +
> > > > > +   /* query chip for its version number */
> > > > > +   if (tpm_read_index(TPM_ADDR, 0x00) !=3D 1 ||
> > > > > +       tpm_read_index(TPM_ADDR, 0x01) !=3D 1)
> > > > > +           return 1;
> > > > > +
> > > > > +   /* This is an atmel supported part */
> > > > > +   return 0;
> > > > > +}
> > > > > +
> > > > > +/* Determine where to talk to device */
> > > > > +static void __iomem * atmel_get_base_addr(unsigned long *base, i=
nt *region_size)
> > > > > +{
> > > > > +   int lo, hi;
> > > > > +
> > > > > +   if (atmel_verify_tpm11() !=3D 0)
> > > > > +           return NULL;
> > > > > +
> > > > > +   lo =3D tpm_read_index(TPM_ADDR, TPM_ATMEL_BASE_ADDR_LO);
> > > > > +   hi =3D tpm_read_index(TPM_ADDR, TPM_ATMEL_BASE_ADDR_HI);
> > > > > +
> > > > > +   *base =3D (hi << 8) | lo;
> > > > > +   *region_size =3D 2;
> > > > > +
> > > > > +   return ioport_map(*base, *region_size);
> > > > > +}
> > > > >
> > > > >  /* write status bits */
> > > > >  enum tpm_atmel_write_status {
> > > > > @@ -142,7 +202,6 @@ static void atml_plat_remove(void)
> > > > >     tpm_chip_unregister(chip);
> > > > >     if (priv->have_region)
> > > > >             atmel_release_region(priv->base, priv->region_size);
> > > > > -   atmel_put_base_addr(priv->iobase);
> > > > >     platform_device_unregister(pdev);
> > > > >  }
> > > > >
> > > > > @@ -211,7 +270,6 @@ static int __init init_atmel(void)
> > > > >  err_unreg_dev:
> > > > >     platform_device_unregister(pdev);
> > > > >  err_rel_reg:
> > > > > -   atmel_put_base_addr(iobase);
> > > > >     if (have_region)
> > > > >             atmel_release_region(base,
> > > > >                                  region_size);
> > > > > diff --git a/drivers/char/tpm/tpm_atmel.h b/drivers/char/tpm/tpm_=
atmel.h
> > > > > deleted file mode 100644
> > > > > index 7ac3f69dcf0f..000000000000
> > > > > --- a/drivers/char/tpm/tpm_atmel.h
> > > > > +++ /dev/null
> > > > > @@ -1,140 +0,0 @@
> > > > > -/* SPDX-License-Identifier: GPL-2.0-only */
> > > > > -/*
> > > > > - * Copyright (C) 2005 IBM Corporation
> > > > > - *
> > > > > - * Authors:
> > > > > - * Kylene Hall <kjhall@us.ibm.com>
> > > > > - *
> > > > > - * Maintained by: <tpmdd-devel@lists.sourceforge.net>
> > > > > - *
> > > > > - * Device driver for TCG/TCPA TPM (trusted platform module).
> > > > > - * Specifications at www.trustedcomputinggroup.org
> > > > > - *
> > > > > - * These difference are required on power because the device mus=
t be
> > > > > - * discovered through the device tree and iomap must be used to =
get
> > > > > - * around the need for holes in the io_page_mask.  This does not=
 happen
> > > > > - * automatically because the tpm is not a normal pci device and =
lives
> > > > > - * under the root node.
> > > > > - */
> > > > > -
> > > > > -struct tpm_atmel_priv {
> > > > > -   int region_size;
> > > > > -   int have_region;
> > > > > -   unsigned long base;
> > > > > -   void __iomem *iobase;
> > > > > -};
> > > > > -
> > > > > -#ifdef CONFIG_PPC64
> > > > > -
> > > > > -#include <linux/of.h>
> > > > > -
> > > > > -#define atmel_getb(priv, offset) readb(priv->iobase + offset)
> > > > > -#define atmel_putb(val, priv, offset) writeb(val, priv->iobase +=
 offset)
> > > > > -#define atmel_request_region request_mem_region
> > > > > -#define atmel_release_region release_mem_region
> > > > > -
> > > > > -static inline void atmel_put_base_addr(void __iomem *iobase)
> > > > > -{
> > > > > -   iounmap(iobase);
> > > > > -}
> > > > > -
> > > > > -static void __iomem * atmel_get_base_addr(unsigned long *base, i=
nt *region_size)
> > > > > -{
> > > > > -   struct device_node *dn;
> > > > > -   unsigned long address, size;
> > > > > -   const unsigned int *reg;
> > > > > -   int reglen;
> > > > > -   int naddrc;
> > > > > -   int nsizec;
> > > > > -
> > > > > -   dn =3D of_find_node_by_name(NULL, "tpm");
> > > > > -
> > > > > -   if (!dn)
> > > > > -           return NULL;
> > > > > -
> > > > > -   if (!of_device_is_compatible(dn, "AT97SC3201")) {
> > > > > -           of_node_put(dn);
> > > > > -           return NULL;
> > > > > -   }
> > > > > -
> > > > > -   reg =3D of_get_property(dn, "reg", &reglen);
> > > > > -   naddrc =3D of_n_addr_cells(dn);
> > > > > -   nsizec =3D of_n_size_cells(dn);
> > > > > -
> > > > > -   of_node_put(dn);
> > > > > -
> > > > > -
> > > > > -   if (naddrc =3D=3D 2)
> > > > > -           address =3D ((unsigned long) reg[0] << 32) | reg[1];
> > > > > -   else
> > > > > -           address =3D reg[0];
> > > > > -
> > > > > -   if (nsizec =3D=3D 2)
> > > > > -           size =3D
> > > > > -               ((unsigned long) reg[naddrc] << 32) | reg[naddrc =
+ 1];
> > > > > -   else
> > > > > -           size =3D reg[naddrc];
> > > > > -
> > > > > -   *base =3D address;
> > > > > -   *region_size =3D size;
> > > > > -   return ioremap(*base, *region_size);
> > > > > -}
> > > > > -#else
> > > > > -#define atmel_getb(chip, offset) inb(atmel_get_priv(chip)->base =
+ offset)
> > > > > -#define atmel_putb(val, chip, offset) \
> > > > > -   outb(val, atmel_get_priv(chip)->base + offset)
> > > > > -#define atmel_request_region request_region
> > > > > -#define atmel_release_region release_region
> > > > > -/* Atmel definitions */
> > > > > -enum tpm_atmel_addr {
> > > > > -   TPM_ATMEL_BASE_ADDR_LO =3D 0x08,
> > > > > -   TPM_ATMEL_BASE_ADDR_HI =3D 0x09
> > > > > -};
> > > > > -
> > > > > -static inline int tpm_read_index(int base, int index)
> > > > > -{
> > > > > -   outb(index, base);
> > > > > -   return inb(base+1) & 0xFF;
> > > > > -}
> > > > > -
> > > > > -/* Verify this is a 1.1 Atmel TPM */
> > > > > -static int atmel_verify_tpm11(void)
> > > > > -{
> > > > > -
> > > > > -   /* verify that it is an Atmel part */
> > > > > -   if (tpm_read_index(TPM_ADDR, 4) !=3D 'A' ||
> > > > > -       tpm_read_index(TPM_ADDR, 5) !=3D 'T' ||
> > > > > -       tpm_read_index(TPM_ADDR, 6) !=3D 'M' ||
> > > > > -       tpm_read_index(TPM_ADDR, 7) !=3D 'L')
> > > > > -           return 1;
> > > > > -
> > > > > -   /* query chip for its version number */
> > > > > -   if (tpm_read_index(TPM_ADDR, 0x00) !=3D 1 ||
> > > > > -       tpm_read_index(TPM_ADDR, 0x01) !=3D 1)
> > > > > -           return 1;
> > > > > -
> > > > > -   /* This is an atmel supported part */
> > > > > -   return 0;
> > > > > -}
> > > > > -
> > > > > -static inline void atmel_put_base_addr(void __iomem *iobase)
> > > > > -{
> > > > > -}
> > > > > -
> > > > > -/* Determine where to talk to device */
> > > > > -static void __iomem * atmel_get_base_addr(unsigned long *base, i=
nt *region_size)
> > > > > -{
> > > > > -   int lo, hi;
> > > > > -
> > > > > -   if (atmel_verify_tpm11() !=3D 0)
> > > > > -           return NULL;
> > > > > -
> > > > > -   lo =3D tpm_read_index(TPM_ADDR, TPM_ATMEL_BASE_ADDR_LO);
> > > > > -   hi =3D tpm_read_index(TPM_ADDR, TPM_ATMEL_BASE_ADDR_HI);
> > > > > -
> > > > > -   *base =3D (hi << 8) | lo;
> > > > > -   *region_size =3D 2;
> > > > > -
> > > > > -   return ioport_map(*base, *region_size);
> > > > > -}
> > > > > -#endif
> > > >
> > > > Responding from holidays but:
> > > >
> > > > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > >
> > > > [still away for couple of weeks]
> > >
> > > I got these in with checkpatch.pl --strict:
> > >
> > > CHECK: Macro argument 'offset' may be better as '(offset)' to avoid p=
recedence issues
> > > #59: FILE: drivers/char/tpm/tpm_atmel.c:26:
> > > +#define atmel_getb(chip, offset) inb(atmel_get_priv(chip)->base + of=
fset)
> > >
> > > CHECK: Macro argument 'offset' may be better as '(offset)' to avoid p=
recedence issues
> > > #60: FILE: drivers/char/tpm/tpm_atmel.c:27:
> > > +#define atmel_putb(val, chip, offset) \
> > > +       outb(val, atmel_get_priv(chip)->base + offset)
> > >
> > > CHECK: spaces preferred around that '+' (ctx:VxV)
> > > #73: FILE: drivers/char/tpm/tpm_atmel.c:40:
> > > +       return inb(base+1) & 0xFF;
> > >                       ^
> > >
> > > CHECK: Blank lines aren't necessary after an open brace '{'
> > > #79: FILE: drivers/char/tpm/tpm_atmel.c:46:
> > > +{
> > > +
> > >
> > > Can you address them and I'll tag the next version, once I've
> > > revisited checkpatch. Otherwise, nothing against the code change.
> >
> > Those all existed before because I just moved what was left of the
> > header contents into the .c file. Fixing them seems like a separate
> > change to me. I can just leave the header in place and avoid the
> > warnings if you prefer. Otherwise, those warnings are the least of the
> > clean-up this driver needs. For starters, I would make those defines
> > static inlines instead.
>
> Ah, ok sorry. It was fairly mechanical check as I'm just quickly
> going critical stuff from holidays.
>
> I'm back after next week, so I'd really like to hold with this
> up until that and prepare when I'm back a patch set, which includes
> a supplemental patch fixing those issues (if you don't mind).

Whatever happened to this? Can you please apply my patch if you don't
have the time for further rework.

Rob

