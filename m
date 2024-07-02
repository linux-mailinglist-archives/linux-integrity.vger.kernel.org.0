Return-Path: <linux-integrity+bounces-2969-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2971F924C6B
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jul 2024 01:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABEBF1F2301E
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jul 2024 23:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C4317A59E;
	Tue,  2 Jul 2024 23:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMj5KbUB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C92915B10B;
	Tue,  2 Jul 2024 23:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719964327; cv=none; b=gVSRgj1sVGFGtFNGt5EybFCPCbVB3zCGmQE0HwA2z+URCfpclwN2VvxkZGzjOWrIm84d16wzrNLxJ3rUJcvVPpPTNqH7OJHK0W8zePo7Z6I5cB7dFaAUsfe8lh6st5Z7O0vyg4Qlk5kfWzSEHPxlp9FWEIeH8hQlzQMJqHrwi3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719964327; c=relaxed/simple;
	bh=di6qAu2kQhkxcbJTAU/oWcxdiRLFMwByuyu5nqwUzlo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oRER/08cRushAOc98tgMx3a6vAJYAH00rEk/3mlKem6dSow1K9otgw4nOXVM9gBxdMb4gg6tNHN04R9+hwKZ3g1Ezrqp4Zt3Aa/7SGTbUaKnEu1uS9NjaSGt+Ope0zB8zlscpzY4Ye1LDRetpZccC0D6APNmMALs8vMDcOOZs6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMj5KbUB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C31C116B1;
	Tue,  2 Jul 2024 23:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719964326;
	bh=di6qAu2kQhkxcbJTAU/oWcxdiRLFMwByuyu5nqwUzlo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=pMj5KbUBFRphWkLbthq19Na5kykNL5AyO4b5I2G2AmXXEztmbe2DSQP5Gsss4rQA6
	 7z59CreTbpVjDvoaXiQ7NsPnkgMCWRdV/ittCiN0/gYHmz/7OHf9wgvDFAt6dtVZ7O
	 hDB0AZ90Nbm2OrPdY0xYzSSkk2+sIYGlD34wTbn5GPha6SpwI6urdfSnN81P4onMfm
	 hvskKg1VhxdakmYGN/i6iIKNE3ROezJU7EV6W5Zn+U8cVFXxoAqjJR3gmrF+jSDtSL
	 X2CzK+UhGzqyM8MykVJIUzn0E1b1xjidTrHJacBY68Sde3ulhVat/zyVplqdXTgmGL
	 yjSvuYnrxoF4g==
Message-ID: <e72dba1639fd6b68bb2fd392910ac8a61b99d65d.camel@kernel.org>
Subject: Re: [PATCH] tpm: atmel: Drop PPC64 specific MMIO setup
From: Jarkko Sakkinen <jarkko@kernel.org>
To: "Rob Herring (Arm)" <robh@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Date: Wed, 03 Jul 2024 02:52:02 +0300
In-Reply-To: <20240702161052.3563599-1-robh@kernel.org>
References: <20240702161052.3563599-1-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-02 at 10:10 -0600, Rob Herring (Arm) wrote:
> The PPC64 specific MMIO setup open codes DT address functions rather
> than using standard address parsing functions. The open-coded version
> fails to handle any address translation and is not endian safe.
>=20
> I haven't found any evidence of what platform used this. The only thing
> that turned up was a PPC405 platform, but that is 32-bit and PPC405
> support is being removed as well. CONFIG_TCG_ATMEL is not enabled for
> any powerpc config and never was. The support was added in 2005 and
> hasn't been touched since.
>=20
> Rather than try to modernize and fix this code, just remove it.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
> =C2=A0drivers/char/tpm/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> =C2=A0drivers/char/tpm/tpm_atmel.c |=C2=A0 64 +++++++++++++++-
> =C2=A0drivers/char/tpm/tpm_atmel.h | 140 --------------------------------=
---
> =C2=A03 files changed, 62 insertions(+), 144 deletions(-)
> =C2=A0delete mode 100644 drivers/char/tpm/tpm_atmel.h
>=20
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index e63a6a17793c..9b655e9fc7ab 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -162,7 +162,7 @@ config TCG_NSC
> =C2=A0
> =C2=A0config TCG_ATMEL
> =C2=A0	tristate "Atmel TPM Interface"
> -	depends on PPC64 || HAS_IOPORT_MAP
> +	depends on HAS_IOPORT_MAP
> =C2=A0	depends on HAS_IOPORT
> =C2=A0	help
> =C2=A0	=C2=A0 If you have a TPM security chip from Atmel say Yes and it=
=20
> diff --git a/drivers/char/tpm/tpm_atmel.c b/drivers/char/tpm/tpm_atmel.c
> index 9fb2defa9dc4..622c4abe8cb3 100644
> --- a/drivers/char/tpm/tpm_atmel.c
> +++ b/drivers/char/tpm/tpm_atmel.c
> @@ -15,7 +15,67 @@
> =C2=A0 */
> =C2=A0
> =C2=A0#include "tpm.h"
> -#include "tpm_atmel.h"
> +
> +struct tpm_atmel_priv {
> +	int region_size;
> +	int have_region;
> +	unsigned long base;
> +	void __iomem *iobase;
> +};
> +
> +#define atmel_getb(chip, offset) inb(atmel_get_priv(chip)->base + offset=
)
> +#define atmel_putb(val, chip, offset) \
> +	outb(val, atmel_get_priv(chip)->base + offset)
> +#define atmel_request_region request_region
> +#define atmel_release_region release_region
> +/* Atmel definitions */
> +enum tpm_atmel_addr {
> +	TPM_ATMEL_BASE_ADDR_LO =3D 0x08,
> +	TPM_ATMEL_BASE_ADDR_HI =3D 0x09
> +};
> +
> +static inline int tpm_read_index(int base, int index)
> +{
> +	outb(index, base);
> +	return inb(base+1) & 0xFF;
> +}
> +
> +/* Verify this is a 1.1 Atmel TPM */
> +static int atmel_verify_tpm11(void)
> +{
> +
> +	/* verify that it is an Atmel part */
> +	if (tpm_read_index(TPM_ADDR, 4) !=3D 'A' ||
> +	=C2=A0=C2=A0=C2=A0 tpm_read_index(TPM_ADDR, 5) !=3D 'T' ||
> +	=C2=A0=C2=A0=C2=A0 tpm_read_index(TPM_ADDR, 6) !=3D 'M' ||
> +	=C2=A0=C2=A0=C2=A0 tpm_read_index(TPM_ADDR, 7) !=3D 'L')
> +		return 1;
> +
> +	/* query chip for its version number */
> +	if (tpm_read_index(TPM_ADDR, 0x00) !=3D 1 ||
> +	=C2=A0=C2=A0=C2=A0 tpm_read_index(TPM_ADDR, 0x01) !=3D 1)
> +		return 1;
> +
> +	/* This is an atmel supported part */
> +	return 0;
> +}
> +
> +/* Determine where to talk to device */
> +static void __iomem * atmel_get_base_addr(unsigned long *base, int *regi=
on_size)
> +{
> +	int lo, hi;
> +
> +	if (atmel_verify_tpm11() !=3D 0)
> +		return NULL;
> +
> +	lo =3D tpm_read_index(TPM_ADDR, TPM_ATMEL_BASE_ADDR_LO);
> +	hi =3D tpm_read_index(TPM_ADDR, TPM_ATMEL_BASE_ADDR_HI);
> +
> +	*base =3D (hi << 8) | lo;
> +	*region_size =3D 2;
> +
> +	return ioport_map(*base, *region_size);
> +}
> =C2=A0
> =C2=A0/* write status bits */
> =C2=A0enum tpm_atmel_write_status {
> @@ -142,7 +202,6 @@ static void atml_plat_remove(void)
> =C2=A0	tpm_chip_unregister(chip);
> =C2=A0	if (priv->have_region)
> =C2=A0		atmel_release_region(priv->base, priv->region_size);
> -	atmel_put_base_addr(priv->iobase);
> =C2=A0	platform_device_unregister(pdev);
> =C2=A0}
> =C2=A0
> @@ -211,7 +270,6 @@ static int __init init_atmel(void)
> =C2=A0err_unreg_dev:
> =C2=A0	platform_device_unregister(pdev);
> =C2=A0err_rel_reg:
> -	atmel_put_base_addr(iobase);
> =C2=A0	if (have_region)
> =C2=A0		atmel_release_region(base,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 region_size);
> diff --git a/drivers/char/tpm/tpm_atmel.h b/drivers/char/tpm/tpm_atmel.h
> deleted file mode 100644
> index 7ac3f69dcf0f..000000000000
> --- a/drivers/char/tpm/tpm_atmel.h
> +++ /dev/null
> @@ -1,140 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0-only */
> -/*
> - * Copyright (C) 2005 IBM Corporation
> - *
> - * Authors:
> - * Kylene Hall <kjhall@us.ibm.com>
> - *
> - * Maintained by: <tpmdd-devel@lists.sourceforge.net>
> - *
> - * Device driver for TCG/TCPA TPM (trusted platform module).
> - * Specifications at www.trustedcomputinggroup.org
> - *
> - * These difference are required on power because the device must be
> - * discovered through the device tree and iomap must be used to get
> - * around the need for holes in the io_page_mask.=C2=A0 This does not ha=
ppen
> - * automatically because the tpm is not a normal pci device and lives
> - * under the root node.
> - */
> -
> -struct tpm_atmel_priv {
> -	int region_size;
> -	int have_region;
> -	unsigned long base;
> -	void __iomem *iobase;
> -};
> -
> -#ifdef CONFIG_PPC64
> -
> -#include <linux/of.h>
> -
> -#define atmel_getb(priv, offset) readb(priv->iobase + offset)
> -#define atmel_putb(val, priv, offset) writeb(val, priv->iobase + offset)
> -#define atmel_request_region request_mem_region
> -#define atmel_release_region release_mem_region
> -
> -static inline void atmel_put_base_addr(void __iomem *iobase)
> -{
> -	iounmap(iobase);
> -}
> -
> -static void __iomem * atmel_get_base_addr(unsigned long *base, int *regi=
on_size)
> -{
> -	struct device_node *dn;
> -	unsigned long address, size;
> -	const unsigned int *reg;
> -	int reglen;
> -	int naddrc;
> -	int nsizec;
> -
> -	dn =3D of_find_node_by_name(NULL, "tpm");
> -
> -	if (!dn)
> -		return NULL;
> -
> -	if (!of_device_is_compatible(dn, "AT97SC3201")) {
> -		of_node_put(dn);
> -		return NULL;
> -	}
> -
> -	reg =3D of_get_property(dn, "reg", &reglen);
> -	naddrc =3D of_n_addr_cells(dn);
> -	nsizec =3D of_n_size_cells(dn);
> -
> -	of_node_put(dn);
> -
> -
> -	if (naddrc =3D=3D 2)
> -		address =3D ((unsigned long) reg[0] << 32) | reg[1];
> -	else
> -		address =3D reg[0];
> -
> -	if (nsizec =3D=3D 2)
> -		size =3D
> -		=C2=A0=C2=A0=C2=A0 ((unsigned long) reg[naddrc] << 32) | reg[naddrc + =
1];
> -	else
> -		size =3D reg[naddrc];
> -
> -	*base =3D address;
> -	*region_size =3D size;
> -	return ioremap(*base, *region_size);
> -}
> -#else
> -#define atmel_getb(chip, offset) inb(atmel_get_priv(chip)->base + offset=
)
> -#define atmel_putb(val, chip, offset) \
> -	outb(val, atmel_get_priv(chip)->base + offset)
> -#define atmel_request_region request_region
> -#define atmel_release_region release_region
> -/* Atmel definitions */
> -enum tpm_atmel_addr {
> -	TPM_ATMEL_BASE_ADDR_LO =3D 0x08,
> -	TPM_ATMEL_BASE_ADDR_HI =3D 0x09
> -};
> -
> -static inline int tpm_read_index(int base, int index)
> -{
> -	outb(index, base);
> -	return inb(base+1) & 0xFF;
> -}
> -
> -/* Verify this is a 1.1 Atmel TPM */
> -static int atmel_verify_tpm11(void)
> -{
> -
> -	/* verify that it is an Atmel part */
> -	if (tpm_read_index(TPM_ADDR, 4) !=3D 'A' ||
> -	=C2=A0=C2=A0=C2=A0 tpm_read_index(TPM_ADDR, 5) !=3D 'T' ||
> -	=C2=A0=C2=A0=C2=A0 tpm_read_index(TPM_ADDR, 6) !=3D 'M' ||
> -	=C2=A0=C2=A0=C2=A0 tpm_read_index(TPM_ADDR, 7) !=3D 'L')
> -		return 1;
> -
> -	/* query chip for its version number */
> -	if (tpm_read_index(TPM_ADDR, 0x00) !=3D 1 ||
> -	=C2=A0=C2=A0=C2=A0 tpm_read_index(TPM_ADDR, 0x01) !=3D 1)
> -		return 1;
> -
> -	/* This is an atmel supported part */
> -	return 0;
> -}
> -
> -static inline void atmel_put_base_addr(void __iomem *iobase)
> -{
> -}
> -
> -/* Determine where to talk to device */
> -static void __iomem * atmel_get_base_addr(unsigned long *base, int *regi=
on_size)
> -{
> -	int lo, hi;
> -
> -	if (atmel_verify_tpm11() !=3D 0)
> -		return NULL;
> -
> -	lo =3D tpm_read_index(TPM_ADDR, TPM_ATMEL_BASE_ADDR_LO);
> -	hi =3D tpm_read_index(TPM_ADDR, TPM_ATMEL_BASE_ADDR_HI);
> -
> -	*base =3D (hi << 8) | lo;
> -	*region_size =3D 2;
> -
> -	return ioport_map(*base, *region_size);
> -}
> -#endif


Acknowledging that I noticed this but won't test
before week 31, when I'm back from holiday.

BR, Jarkko


