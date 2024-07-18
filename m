Return-Path: <linux-integrity+bounces-3180-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D13DE934F7B
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jul 2024 16:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 619591F21242
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jul 2024 14:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9F1142E9F;
	Thu, 18 Jul 2024 14:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1lkiHvL"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0448D1428F2;
	Thu, 18 Jul 2024 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721314668; cv=none; b=H1g5WX/I1SX/kk0vWdLZYwkS4XnRvZHH1e5YVHtMsc9GEEwBI16Rebk9guz9HwqUaGptuy4DAeqXa9EEYLDMBA/LUlXcDvsMSNTtIYFAf3a/CBK/73ghN85PzpcxUlXHAPRJFR3S/O2WatZQ1LtnPqlRmMrVCc+xGrY/wAlaIxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721314668; c=relaxed/simple;
	bh=dOkeYWPGxwEBfu26Tj+pRBlDvvOlceNYIBvbM109sFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l+qcMI8UUnz5jbs4vFD6jBtsvKWM5V5NOXgBzOeJgO+vKTe/QeugMEVOmUEilm4CzE8a9hs2qSwZzXUsw6y9yJxRg78DP0A3XFKx5bcIe8OfLvw8JeHDiS9zLugLDI6PRjmHDxgMDesqwTHO/HVIjZLOU4MHyOzZjPBzjyIG5ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1lkiHvL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FEBFC4AF0F;
	Thu, 18 Jul 2024 14:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721314667;
	bh=dOkeYWPGxwEBfu26Tj+pRBlDvvOlceNYIBvbM109sFA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=u1lkiHvLzL016UKlAuO029FQD7tYjU2kB4KQiJRuIq3k9K1CvxsJuQ2EnyhBGHCXt
	 SlXDt4haDPqbGsGnZzosm4zcLFMh7JVp2QtSo8aMSXvwV23TNqMrbTls1kwPKFJlwj
	 Hbd5cmRn7lser/RAjT9jXHosYvf6JMqDAarlIIYmTWC9UcS+O59sfcr7hRLrRLUqsy
	 dcQtbqtYA0U3FHmYqIEhHawv9/C11cHXXXtw489tK9K5V5NEc9n2e+9JEFoMbbnMyX
	 LSJbjOKAjPfh/0BAc/D0BSOKIBnWzTMZrbaDbC01MBH7TMRjoilmH9QRxwoqvgpYbd
	 W2lMW3NtfctXw==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52ea2ce7abaso743948e87.0;
        Thu, 18 Jul 2024 07:57:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXlmjCi8v9rTlLegTrVha8FjIwN3nS8ZT1NWw2GJnIix/7AMEAe78NW21Lsk9Eccyn9E6auMP+5nQ0BKm8Nxa6nI3VVTNIv0C8kR+e1Eq4hBHgScApiFAFoKFZ+Wz/Wdaq6aBzs770yeKkIZ7fp
X-Gm-Message-State: AOJu0Yw4tOrcThuDRIhgxVyi8FSqAl4ugTHm0hMclAY+96XGMJ5OtbCR
	lgo3b88DXyvQIXW81RTL4pEVe2B1Hyo1Shq6L6NYw8VXoa6Z1SAO1a0Ps3q/l1wrfva+iH1G/rD
	JxwP73yuD6NV8UZL84rLDgIlZ6g==
X-Google-Smtp-Source: AGHT+IGz2Ng4W1rwVzqmoDmoEQl5W6pvWD7cdpRPX1alqN6E9vLw0Y7fhmxQUmQjjs3wsKtysQH2udmFXwUbBc2L17M=
X-Received: by 2002:a05:6512:3984:b0:52c:8c4d:f8d6 with SMTP id
 2adb3069b0e04-52ee54118b7mr3670486e87.45.1721314665678; Thu, 18 Jul 2024
 07:57:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702161052.3563599-1-robh@kernel.org> <D2RSWMPFF8KK.X5HZZMHANQMO@iki.fi>
 <D2RT0J8KXY1H.3MEV7KGQXTWHW@iki.fi>
In-Reply-To: <D2RT0J8KXY1H.3MEV7KGQXTWHW@iki.fi>
From: Rob Herring <robh@kernel.org>
Date: Thu, 18 Jul 2024 08:57:32 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJDX+uOSoPh6pTNEP0vBLwcP3bKmAW1wCr_0cVr5fsPcg@mail.gmail.com>
Message-ID: <CAL_JsqJDX+uOSoPh6pTNEP0vBLwcP3bKmAW1wCr_0cVr5fsPcg@mail.gmail.com>
Subject: Re: [PATCH] tpm: atmel: Drop PPC64 specific MMIO setup
To: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 6:14=E2=80=AFAM Jarkko Sakkinen <jarkko.sakkinen@ik=
i.fi> wrote:
>
> On Wed Jul 17, 2024 at 3:08 PM EEST, Jarkko Sakkinen wrote:
> > On Tue Jul 2, 2024 at 7:10 PM EEST, Rob Herring (Arm) wrote:
> > > The PPC64 specific MMIO setup open codes DT address functions rather
> > > than using standard address parsing functions. The open-coded version
> > > fails to handle any address translation and is not endian safe.
> > >
> > > I haven't found any evidence of what platform used this. The only thi=
ng
> > > that turned up was a PPC405 platform, but that is 32-bit and PPC405
> > > support is being removed as well. CONFIG_TCG_ATMEL is not enabled for
> > > any powerpc config and never was. The support was added in 2005 and
> > > hasn't been touched since.
> > >
> > > Rather than try to modernize and fix this code, just remove it.
> > >
> > > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > > ---
> > >  drivers/char/tpm/Kconfig     |   2 +-
> > >  drivers/char/tpm/tpm_atmel.c |  64 +++++++++++++++-
> > >  drivers/char/tpm/tpm_atmel.h | 140 ---------------------------------=
--
> > >  3 files changed, 62 insertions(+), 144 deletions(-)
> > >  delete mode 100644 drivers/char/tpm/tpm_atmel.h
> > >
> > > diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> > > index e63a6a17793c..9b655e9fc7ab 100644
> > > --- a/drivers/char/tpm/Kconfig
> > > +++ b/drivers/char/tpm/Kconfig
> > > @@ -162,7 +162,7 @@ config TCG_NSC
> > >
> > >  config TCG_ATMEL
> > >     tristate "Atmel TPM Interface"
> > > -   depends on PPC64 || HAS_IOPORT_MAP
> > > +   depends on HAS_IOPORT_MAP
> > >     depends on HAS_IOPORT
> > >     help
> > >       If you have a TPM security chip from Atmel say Yes and it
> > > diff --git a/drivers/char/tpm/tpm_atmel.c b/drivers/char/tpm/tpm_atme=
l.c
> > > index 9fb2defa9dc4..622c4abe8cb3 100644
> > > --- a/drivers/char/tpm/tpm_atmel.c
> > > +++ b/drivers/char/tpm/tpm_atmel.c
> > > @@ -15,7 +15,67 @@
> > >   */
> > >
> > >  #include "tpm.h"
> > > -#include "tpm_atmel.h"
> > > +
> > > +struct tpm_atmel_priv {
> > > +   int region_size;
> > > +   int have_region;
> > > +   unsigned long base;
> > > +   void __iomem *iobase;
> > > +};
> > > +
> > > +#define atmel_getb(chip, offset) inb(atmel_get_priv(chip)->base + of=
fset)
> > > +#define atmel_putb(val, chip, offset) \
> > > +   outb(val, atmel_get_priv(chip)->base + offset)
> > > +#define atmel_request_region request_region
> > > +#define atmel_release_region release_region
> > > +/* Atmel definitions */
> > > +enum tpm_atmel_addr {
> > > +   TPM_ATMEL_BASE_ADDR_LO =3D 0x08,
> > > +   TPM_ATMEL_BASE_ADDR_HI =3D 0x09
> > > +};
> > > +
> > > +static inline int tpm_read_index(int base, int index)
> > > +{
> > > +   outb(index, base);
> > > +   return inb(base+1) & 0xFF;
> > > +}
> > > +
> > > +/* Verify this is a 1.1 Atmel TPM */
> > > +static int atmel_verify_tpm11(void)
> > > +{
> > > +
> > > +   /* verify that it is an Atmel part */
> > > +   if (tpm_read_index(TPM_ADDR, 4) !=3D 'A' ||
> > > +       tpm_read_index(TPM_ADDR, 5) !=3D 'T' ||
> > > +       tpm_read_index(TPM_ADDR, 6) !=3D 'M' ||
> > > +       tpm_read_index(TPM_ADDR, 7) !=3D 'L')
> > > +           return 1;
> > > +
> > > +   /* query chip for its version number */
> > > +   if (tpm_read_index(TPM_ADDR, 0x00) !=3D 1 ||
> > > +       tpm_read_index(TPM_ADDR, 0x01) !=3D 1)
> > > +           return 1;
> > > +
> > > +   /* This is an atmel supported part */
> > > +   return 0;
> > > +}
> > > +
> > > +/* Determine where to talk to device */
> > > +static void __iomem * atmel_get_base_addr(unsigned long *base, int *=
region_size)
> > > +{
> > > +   int lo, hi;
> > > +
> > > +   if (atmel_verify_tpm11() !=3D 0)
> > > +           return NULL;
> > > +
> > > +   lo =3D tpm_read_index(TPM_ADDR, TPM_ATMEL_BASE_ADDR_LO);
> > > +   hi =3D tpm_read_index(TPM_ADDR, TPM_ATMEL_BASE_ADDR_HI);
> > > +
> > > +   *base =3D (hi << 8) | lo;
> > > +   *region_size =3D 2;
> > > +
> > > +   return ioport_map(*base, *region_size);
> > > +}
> > >
> > >  /* write status bits */
> > >  enum tpm_atmel_write_status {
> > > @@ -142,7 +202,6 @@ static void atml_plat_remove(void)
> > >     tpm_chip_unregister(chip);
> > >     if (priv->have_region)
> > >             atmel_release_region(priv->base, priv->region_size);
> > > -   atmel_put_base_addr(priv->iobase);
> > >     platform_device_unregister(pdev);
> > >  }
> > >
> > > @@ -211,7 +270,6 @@ static int __init init_atmel(void)
> > >  err_unreg_dev:
> > >     platform_device_unregister(pdev);
> > >  err_rel_reg:
> > > -   atmel_put_base_addr(iobase);
> > >     if (have_region)
> > >             atmel_release_region(base,
> > >                                  region_size);
> > > diff --git a/drivers/char/tpm/tpm_atmel.h b/drivers/char/tpm/tpm_atme=
l.h
> > > deleted file mode 100644
> > > index 7ac3f69dcf0f..000000000000
> > > --- a/drivers/char/tpm/tpm_atmel.h
> > > +++ /dev/null
> > > @@ -1,140 +0,0 @@
> > > -/* SPDX-License-Identifier: GPL-2.0-only */
> > > -/*
> > > - * Copyright (C) 2005 IBM Corporation
> > > - *
> > > - * Authors:
> > > - * Kylene Hall <kjhall@us.ibm.com>
> > > - *
> > > - * Maintained by: <tpmdd-devel@lists.sourceforge.net>
> > > - *
> > > - * Device driver for TCG/TCPA TPM (trusted platform module).
> > > - * Specifications at www.trustedcomputinggroup.org
> > > - *
> > > - * These difference are required on power because the device must be
> > > - * discovered through the device tree and iomap must be used to get
> > > - * around the need for holes in the io_page_mask.  This does not hap=
pen
> > > - * automatically because the tpm is not a normal pci device and live=
s
> > > - * under the root node.
> > > - */
> > > -
> > > -struct tpm_atmel_priv {
> > > -   int region_size;
> > > -   int have_region;
> > > -   unsigned long base;
> > > -   void __iomem *iobase;
> > > -};
> > > -
> > > -#ifdef CONFIG_PPC64
> > > -
> > > -#include <linux/of.h>
> > > -
> > > -#define atmel_getb(priv, offset) readb(priv->iobase + offset)
> > > -#define atmel_putb(val, priv, offset) writeb(val, priv->iobase + off=
set)
> > > -#define atmel_request_region request_mem_region
> > > -#define atmel_release_region release_mem_region
> > > -
> > > -static inline void atmel_put_base_addr(void __iomem *iobase)
> > > -{
> > > -   iounmap(iobase);
> > > -}
> > > -
> > > -static void __iomem * atmel_get_base_addr(unsigned long *base, int *=
region_size)
> > > -{
> > > -   struct device_node *dn;
> > > -   unsigned long address, size;
> > > -   const unsigned int *reg;
> > > -   int reglen;
> > > -   int naddrc;
> > > -   int nsizec;
> > > -
> > > -   dn =3D of_find_node_by_name(NULL, "tpm");
> > > -
> > > -   if (!dn)
> > > -           return NULL;
> > > -
> > > -   if (!of_device_is_compatible(dn, "AT97SC3201")) {
> > > -           of_node_put(dn);
> > > -           return NULL;
> > > -   }
> > > -
> > > -   reg =3D of_get_property(dn, "reg", &reglen);
> > > -   naddrc =3D of_n_addr_cells(dn);
> > > -   nsizec =3D of_n_size_cells(dn);
> > > -
> > > -   of_node_put(dn);
> > > -
> > > -
> > > -   if (naddrc =3D=3D 2)
> > > -           address =3D ((unsigned long) reg[0] << 32) | reg[1];
> > > -   else
> > > -           address =3D reg[0];
> > > -
> > > -   if (nsizec =3D=3D 2)
> > > -           size =3D
> > > -               ((unsigned long) reg[naddrc] << 32) | reg[naddrc + 1]=
;
> > > -   else
> > > -           size =3D reg[naddrc];
> > > -
> > > -   *base =3D address;
> > > -   *region_size =3D size;
> > > -   return ioremap(*base, *region_size);
> > > -}
> > > -#else
> > > -#define atmel_getb(chip, offset) inb(atmel_get_priv(chip)->base + of=
fset)
> > > -#define atmel_putb(val, chip, offset) \
> > > -   outb(val, atmel_get_priv(chip)->base + offset)
> > > -#define atmel_request_region request_region
> > > -#define atmel_release_region release_region
> > > -/* Atmel definitions */
> > > -enum tpm_atmel_addr {
> > > -   TPM_ATMEL_BASE_ADDR_LO =3D 0x08,
> > > -   TPM_ATMEL_BASE_ADDR_HI =3D 0x09
> > > -};
> > > -
> > > -static inline int tpm_read_index(int base, int index)
> > > -{
> > > -   outb(index, base);
> > > -   return inb(base+1) & 0xFF;
> > > -}
> > > -
> > > -/* Verify this is a 1.1 Atmel TPM */
> > > -static int atmel_verify_tpm11(void)
> > > -{
> > > -
> > > -   /* verify that it is an Atmel part */
> > > -   if (tpm_read_index(TPM_ADDR, 4) !=3D 'A' ||
> > > -       tpm_read_index(TPM_ADDR, 5) !=3D 'T' ||
> > > -       tpm_read_index(TPM_ADDR, 6) !=3D 'M' ||
> > > -       tpm_read_index(TPM_ADDR, 7) !=3D 'L')
> > > -           return 1;
> > > -
> > > -   /* query chip for its version number */
> > > -   if (tpm_read_index(TPM_ADDR, 0x00) !=3D 1 ||
> > > -       tpm_read_index(TPM_ADDR, 0x01) !=3D 1)
> > > -           return 1;
> > > -
> > > -   /* This is an atmel supported part */
> > > -   return 0;
> > > -}
> > > -
> > > -static inline void atmel_put_base_addr(void __iomem *iobase)
> > > -{
> > > -}
> > > -
> > > -/* Determine where to talk to device */
> > > -static void __iomem * atmel_get_base_addr(unsigned long *base, int *=
region_size)
> > > -{
> > > -   int lo, hi;
> > > -
> > > -   if (atmel_verify_tpm11() !=3D 0)
> > > -           return NULL;
> > > -
> > > -   lo =3D tpm_read_index(TPM_ADDR, TPM_ATMEL_BASE_ADDR_LO);
> > > -   hi =3D tpm_read_index(TPM_ADDR, TPM_ATMEL_BASE_ADDR_HI);
> > > -
> > > -   *base =3D (hi << 8) | lo;
> > > -   *region_size =3D 2;
> > > -
> > > -   return ioport_map(*base, *region_size);
> > > -}
> > > -#endif
> >
> > Responding from holidays but:
> >
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> >
> > [still away for couple of weeks]
>
> I got these in with checkpatch.pl --strict:
>
> CHECK: Macro argument 'offset' may be better as '(offset)' to avoid prece=
dence issues
> #59: FILE: drivers/char/tpm/tpm_atmel.c:26:
> +#define atmel_getb(chip, offset) inb(atmel_get_priv(chip)->base + offset=
)
>
> CHECK: Macro argument 'offset' may be better as '(offset)' to avoid prece=
dence issues
> #60: FILE: drivers/char/tpm/tpm_atmel.c:27:
> +#define atmel_putb(val, chip, offset) \
> +       outb(val, atmel_get_priv(chip)->base + offset)
>
> CHECK: spaces preferred around that '+' (ctx:VxV)
> #73: FILE: drivers/char/tpm/tpm_atmel.c:40:
> +       return inb(base+1) & 0xFF;
>                       ^
>
> CHECK: Blank lines aren't necessary after an open brace '{'
> #79: FILE: drivers/char/tpm/tpm_atmel.c:46:
> +{
> +
>
> Can you address them and I'll tag the next version, once I've
> revisited checkpatch. Otherwise, nothing against the code change.

Those all existed before because I just moved what was left of the
header contents into the .c file. Fixing them seems like a separate
change to me. I can just leave the header in place and avoid the
warnings if you prefer. Otherwise, those warnings are the least of the
clean-up this driver needs. For starters, I would make those defines
static inlines instead.

Rob

