Return-Path: <linux-integrity+bounces-414-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45E9880F435
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Dec 2023 18:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A846DB20E6C
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Dec 2023 17:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689997B3D3;
	Tue, 12 Dec 2023 17:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDVWYAz6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EEC7B3C1;
	Tue, 12 Dec 2023 17:15:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 403B3C433C9;
	Tue, 12 Dec 2023 17:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702401359;
	bh=VXQhagqDGb9vAh1nRc7GzOZY2WN4Caui/rFTeDa4cko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TDVWYAz6eO+Y1M2LDd/np6T4h5hGeO0w73YW0SOmy8G4+7kKFRMH0f3fsGmxVRqFT
	 LnNiOkMZJuEQjjQSjehHrvC5Rzm8REtMRExbqV91CA06WgeA/hTFgJfu5JduqRI0S0
	 Rj7GoizXSMggJMReaz3jh4pXeIDkHvZ85cwxB7Pbd09B/4zfd6BgOHK8ZfC1vdZIWn
	 QnWa/lMRIzgQj+Ig7GiieaB3j5UePPw+WzwiEdZ7Kp2mPWDMY/66fTcJYXn+SQ89Ka
	 S4T8pFHh61+PSqbaC9Vh8lE/Aupq69ZXKXh4RWuyDT2Z9+pbFg3jDFY1nnH+q9+hbe
	 Wp31YanBsWVuQ==
Date: Tue, 12 Dec 2023 17:15:51 +0000
From: Conor Dooley <conor@kernel.org>
To: Ninad Palsule <ninad@linux.ibm.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, joel@jms.id.au, andrew@codeconstruct.com.au,
	peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
	keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
	johannes.holland@infineon.com, linux@roeck-us.net,
	broonie@kernel.org, patrick.rudolph@9elements.com,
	vincent@vtremblay.dev, peteryin.openbmc@gmail.com,
	lakshmiy@us.ibm.com, bhelgaas@google.com,
	naresh.solanki@9elements.com, alexander.stein@ew.tq-group.com,
	festevam@denx.de, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-hardening@vger.kernel.org, geissonator@yahoo.com
Subject: Re: [PATCH v1 7/8] tpm: tis-i2c: Add more compatible strings
Message-ID: <20231212-avid-grill-dbead068fac8@spud>
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-8-ninad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Truf82TN7Drb/wPF"
Content-Disposition: inline
In-Reply-To: <20231212164004.1683589-8-ninad@linux.ibm.com>


--Truf82TN7Drb/wPF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 10:40:03AM -0600, Ninad Palsule wrote:
> From: Joel Stanley <joel@jms.id.au>
>=20
> The NPCT75x TPM is TIS compatible. It has an I2C and SPI interface.
>=20
> https://www.nuvoton.com/products/cloud-computing/security/trusted-platfor=
m-module-tpm/
>=20
> Add a compatible string for it, and the generic compatible.
>=20
> OpenBMC-Staging-Count: 3

Delete this from every patch that it appears from.

> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> Link: https://lore.kernel.org/r/20220928043957.2636877-4-joel@jms.id.au
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>  drivers/char/tpm/tpm_tis_i2c.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2=
c.c
> index a897402cc36a..9511c0d50185 100644
> --- a/drivers/char/tpm/tpm_tis_i2c.c
> +++ b/drivers/char/tpm/tpm_tis_i2c.c
> @@ -383,6 +383,8 @@ MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_id);
>  #ifdef CONFIG_OF
>  static const struct of_device_id of_tis_i2c_match[] =3D {
>  	{ .compatible =3D "infineon,slb9673", },
> +	{ .compatible =3D "nuvoton,npct75x", },
> +	{ .compatible =3D "tcg,tpm-tis-i2c", },

What's the point of the generic compatible if you are adding the device
specific ones to the driver anyway?

Thanks,
Conor.

>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, of_tis_i2c_match);
> --=20
> 2.39.2
>=20

--Truf82TN7Drb/wPF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXiVRwAKCRB4tDGHoIJi
0moFAP9qCekg1FNgRigBOa03OCo2ImwKVNMJNUYY0hON1Ul2NQD/fRm6HnP66ToK
uVCHCdKv0uV6qfN1BFts+lYjExWXRQs=
=MJ72
-----END PGP SIGNATURE-----

--Truf82TN7Drb/wPF--

