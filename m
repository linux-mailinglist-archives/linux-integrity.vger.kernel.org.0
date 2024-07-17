Return-Path: <linux-integrity+bounces-3162-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCFF933CD6
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2024 14:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB3AC1F22F24
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2024 12:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA5D17FAB0;
	Wed, 17 Jul 2024 12:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="odKRcUUn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60EF180048;
	Wed, 17 Jul 2024 12:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721218140; cv=pass; b=Iu9oiJleIOWrfao3EDIjXTcuVhBMQmHBOIRTQjixyYn+rMlcONgppBXJ6VbeXcXDHVVdb1gMLxU7ZHUckykWz+/7rnELaoCLpnm6icsvu7j5SBqmWEh4ucvJV0B3NEgKxvV7Aulms2RwrtrtihDp75F6aGHi97YZK3v6cqW5FG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721218140; c=relaxed/simple;
	bh=AOHpQLh9e8woC1aPRwP/sIRyj+J5g1Zil8jQ8EN7kM4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=SlPHWujPJRpKNU9jj9dn3b5jWjxd6Sh0JRaNINCDpsyeaPzxTKHYgtKnp5CgQ58J/2svLOyJGDc3GdfFRatmZ9qOECuZlWRCPVnZhmSaESKKelZYkt2Y4gRq++jRxYV22ZpLnR3cgwdvngKWTJlJT53wVJZo0ElBij6VtGlqxj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=odKRcUUn; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from localhost (83-245-197-232.elisa-laajakaista.fi [83.245.197.232])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sakkinen)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4WPF8j6Pywz49Q0P;
	Wed, 17 Jul 2024 15:08:53 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1721218135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vUJB++3RLCf9uyw4+5w1wcKT2OD9YhzRMiW7N0B96So=;
	b=odKRcUUnjEubUlMv+E73IZQ1hSUOhgmO5u5nxE2ZwPXOP82vBuPUl3qCGmSA3HRzrnJs12
	wrP/Imsw5Js9g9GBnnMVM4VYmxUs+KCbfVOEGOyBNDmgdgBSR8qs9NUbHw9xruVsvXTdyA
	62OgVPA0AGAHOj2m5QpJswhhyfKkCkB4Ml33YPx9nF4ERyphvB2vN3uPy5PfvrGaAIKBwK
	NVwspav7eLF4CW5zBOrey3JikkCaiuaNLzTuYMExOGYOZ5u+0yrIGmDZfm54ZSSH0Lugpo
	tJtPE0DsPDLCiIeY3f5jb0TZBnccX1MpgAwwiFycDJGlfWMSIQXo8L4c+d6Hzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1721218135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vUJB++3RLCf9uyw4+5w1wcKT2OD9YhzRMiW7N0B96So=;
	b=Jz6UcNG7ED+IEnIFMfUrljCQCP8arFwSllt0PdTx1e/nw/mc6G/DNv1IJlL7vhS1zNGn9c
	7rbpuKFvxzrMJXwjZ2HIuFQp8hjZC+W44suzD0jfTVL4Fo3sCLlf0kASbp3R1BUqZ5y8B0
	rYSWQwsJ9/qBiRaxZp7Wmruo3aUvS2m8U+xQQJx+1UXPN5iCmfHfqJaVirrYhydWUkrCfW
	kknqt8aNhS2EmsiR8TJuakFXAg5h/8DAlOQw6jx9i9Rlm4MBrsVCUPL9+KvmKqGVHU4I1X
	zBnqSnVJlLoIoqK4we75ZH35WaGSNXVVRZ1PohS3msp8pCxiIp3wIGJTvuUytA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1721218135; a=rsa-sha256;
	cv=none;
	b=A0njSlbmJoVwABoEaJw1vvLOeRPBr1d4RtL9TyMaEGH35TgFokb2WSDz9NHZl2wDGPZ/YB
	Jg95AhHHgtpbO/p7jEh3SzWvXUC+LDxLqU3krpRPtcLFzt0CtX9cVI/YQbhCHPhu2Diamn
	AqmA14Q5cPCha8UJ4LcqMSBvAjaPmNBp2hwY5OOLTKYSau/5ZT5T4Ob9eOT+idDUEq8UrX
	F0QndeDqE1QNLQIASD16cIsB+AUJsyQwrdhJhjqgcqwlWX2ucn++gxxPAhDBU8jxjL8pHy
	GWaxCibzJjyij/Xonq9800dML0mPSLKJhprqA2GU2bnMxOnr8FTHyS5RnueAWQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sakkinen smtp.mailfrom=jarkko.sakkinen@iki.fi
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Jul 2024 15:08:53 +0300
Message-Id: <D2RSWMPFF8KK.X5HZZMHANQMO@iki.fi>
Cc: <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] tpm: atmel: Drop PPC64 specific MMIO setup
From: "Jarkko Sakkinen" <jarkko.sakkinen@iki.fi>
To: "Rob Herring (Arm)" <robh@kernel.org>, "Peter Huewe"
 <peterhuewe@gmx.de>, "Jarkko Sakkinen" <jarkko@kernel.org>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>, "Christophe Leroy"
 <christophe.leroy@csgroup.eu>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
X-Mailer: aerc 0.17.0
References: <20240702161052.3563599-1-robh@kernel.org>
In-Reply-To: <20240702161052.3563599-1-robh@kernel.org>

On Tue Jul 2, 2024 at 7:10 PM EEST, Rob Herring (Arm) wrote:
> The PPC64 specific MMIO setup open codes DT address functions rather
> than using standard address parsing functions. The open-coded version
> fails to handle any address translation and is not endian safe.
>
> I haven't found any evidence of what platform used this. The only thing
> that turned up was a PPC405 platform, but that is 32-bit and PPC405
> support is being removed as well. CONFIG_TCG_ATMEL is not enabled for
> any powerpc config and never was. The support was added in 2005 and
> hasn't been touched since.
>
> Rather than try to modernize and fix this code, just remove it.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/char/tpm/Kconfig     |   2 +-
>  drivers/char/tpm/tpm_atmel.c |  64 +++++++++++++++-
>  drivers/char/tpm/tpm_atmel.h | 140 -----------------------------------
>  3 files changed, 62 insertions(+), 144 deletions(-)
>  delete mode 100644 drivers/char/tpm/tpm_atmel.h
>
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index e63a6a17793c..9b655e9fc7ab 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -162,7 +162,7 @@ config TCG_NSC
> =20
>  config TCG_ATMEL
>  	tristate "Atmel TPM Interface"
> -	depends on PPC64 || HAS_IOPORT_MAP
> +	depends on HAS_IOPORT_MAP
>  	depends on HAS_IOPORT
>  	help
>  	  If you have a TPM security chip from Atmel say Yes and it=20
> diff --git a/drivers/char/tpm/tpm_atmel.c b/drivers/char/tpm/tpm_atmel.c
> index 9fb2defa9dc4..622c4abe8cb3 100644
> --- a/drivers/char/tpm/tpm_atmel.c
> +++ b/drivers/char/tpm/tpm_atmel.c
> @@ -15,7 +15,67 @@
>   */
> =20
>  #include "tpm.h"
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
> +	    tpm_read_index(TPM_ADDR, 5) !=3D 'T' ||
> +	    tpm_read_index(TPM_ADDR, 6) !=3D 'M' ||
> +	    tpm_read_index(TPM_ADDR, 7) !=3D 'L')
> +		return 1;
> +
> +	/* query chip for its version number */
> +	if (tpm_read_index(TPM_ADDR, 0x00) !=3D 1 ||
> +	    tpm_read_index(TPM_ADDR, 0x01) !=3D 1)
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
> =20
>  /* write status bits */
>  enum tpm_atmel_write_status {
> @@ -142,7 +202,6 @@ static void atml_plat_remove(void)
>  	tpm_chip_unregister(chip);
>  	if (priv->have_region)
>  		atmel_release_region(priv->base, priv->region_size);
> -	atmel_put_base_addr(priv->iobase);
>  	platform_device_unregister(pdev);
>  }
> =20
> @@ -211,7 +270,6 @@ static int __init init_atmel(void)
>  err_unreg_dev:
>  	platform_device_unregister(pdev);
>  err_rel_reg:
> -	atmel_put_base_addr(iobase);
>  	if (have_region)
>  		atmel_release_region(base,
>  				     region_size);
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
> - * around the need for holes in the io_page_mask.  This does not happen
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
> -		    ((unsigned long) reg[naddrc] << 32) | reg[naddrc + 1];
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
> -	    tpm_read_index(TPM_ADDR, 5) !=3D 'T' ||
> -	    tpm_read_index(TPM_ADDR, 6) !=3D 'M' ||
> -	    tpm_read_index(TPM_ADDR, 7) !=3D 'L')
> -		return 1;
> -
> -	/* query chip for its version number */
> -	if (tpm_read_index(TPM_ADDR, 0x00) !=3D 1 ||
> -	    tpm_read_index(TPM_ADDR, 0x01) !=3D 1)
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

Responding from holidays but:

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

[still away for couple of weeks]

BR, Jarkko


