Return-Path: <linux-integrity+bounces-417-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F39B80F5CA
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Dec 2023 19:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 332121C20AAF
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Dec 2023 18:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFE17F560;
	Tue, 12 Dec 2023 18:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hilZNWnT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89CF210FB;
	Tue, 12 Dec 2023 18:51:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E49BC433C8;
	Tue, 12 Dec 2023 18:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702407101;
	bh=dsv616JxuKXa+9HnLUwoLHTRzosx3BRQ5em0FE7Wdi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hilZNWnTPGBcJppGAc3Ra51k1swo6WEjxlJvulR/NT7rAMgcsyZn/2mMdOXAo8k2u
	 d6JquEwEOgdE3xHIK+puKGbF64+jG7CZeXdRpV5WtchLQMfpJKfQ3mGPTtq+hzrAKO
	 W+FWYIRRljOLiGZxqCMYL5Zd9V6ZHihWLlCXNBW+fa87m8A34i2/iNEGp5EM2NxC7k
	 ozA4yFqRi1JD7wgbWcVyyNufsWwsJcTuboXLSChed8W4MpcxY90j39R2KR/y+Yb+pB
	 L7qKpIQC2bYh2RuqSpBwZo31nX3CkwmY8kXhtC108ejoPasGyN7GhtiGN9v07SvhfO
	 4NnphCQGRzcCA==
Date: Tue, 12 Dec 2023 18:51:32 +0000
From: Conor Dooley <conor@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Ninad Palsule <ninad@linux.ibm.com>, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au, peterhuewe@gmx.de,
	jarkko@kernel.org, jgg@ziepe.ca, keescook@chromium.org,
	tony.luck@intel.com, gpiccoli@igalia.com,
	johannes.holland@infineon.com, broonie@kernel.org,
	patrick.rudolph@9elements.com, vincent@vtremblay.dev,
	peteryin.openbmc@gmail.com, lakshmiy@us.ibm.com,
	bhelgaas@google.com, naresh.solanki@9elements.com,
	alexander.stein@ew.tq-group.com, festevam@denx.de,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-hardening@vger.kernel.org,
	geissonator@yahoo.com
Subject: Re: [PATCH v1 7/8] tpm: tis-i2c: Add more compatible strings
Message-ID: <20231212-mouth-choice-40a83caa34ec@spud>
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-8-ninad@linux.ibm.com>
 <20231212-avid-grill-dbead068fac8@spud>
 <73381bb0-7fa7-4a9e-88df-ab0063058e26@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="V9Oj+WVlG5N/W7nM"
Content-Disposition: inline
In-Reply-To: <73381bb0-7fa7-4a9e-88df-ab0063058e26@roeck-us.net>


--V9Oj+WVlG5N/W7nM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 10:00:39AM -0800, Guenter Roeck wrote:
> On Tue, Dec 12, 2023 at 05:15:51PM +0000, Conor Dooley wrote:
> > On Tue, Dec 12, 2023 at 10:40:03AM -0600, Ninad Palsule wrote:
> > > From: Joel Stanley <joel@jms.id.au>
> > >=20
> > > The NPCT75x TPM is TIS compatible. It has an I2C and SPI interface.
> > >=20
> > > https://www.nuvoton.com/products/cloud-computing/security/trusted-pla=
tform-module-tpm/
> > >=20
> > > Add a compatible string for it, and the generic compatible.
> > >=20
> > > OpenBMC-Staging-Count: 3
> >=20
> > Delete this from every patch that it appears from.
> >=20
> > > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > > Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > Link: https://lore.kernel.org/r/20220928043957.2636877-4-joel@jms.id.=
au
> > > Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> > > ---
> > >  drivers/char/tpm/tpm_tis_i2c.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_ti=
s_i2c.c
> > > index a897402cc36a..9511c0d50185 100644
> > > --- a/drivers/char/tpm/tpm_tis_i2c.c
> > > +++ b/drivers/char/tpm/tpm_tis_i2c.c
> > > @@ -383,6 +383,8 @@ MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_id);
> > >  #ifdef CONFIG_OF
> > >  static const struct of_device_id of_tis_i2c_match[] =3D {
> > >  	{ .compatible =3D "infineon,slb9673", },
> > > +	{ .compatible =3D "nuvoton,npct75x", },
> > > +	{ .compatible =3D "tcg,tpm-tis-i2c", },
> >=20
> > What's the point of the generic compatible if you are adding the device
> > specific ones to the driver anyway?
> >=20
>=20
> $ git grep infineon,slb9673
> Documentation/devicetree/bindings/trivial-devices.yaml:          - infine=
on,slb9673

Hmm, this would then need to be moved into the new schema, out of
trivial devices.

> drivers/char/tpm/tpm_tis_i2c.c: { .compatible =3D "infineon,slb9673", },
> $ git grep nuvoton,npct75x
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:            compatibl=
e =3D "nuvoton,npct75x", "tcg,tpm-tis-i2c";
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts:            compatibl=
e =3D "nuvoton,npct75x", "tcg,tpm-tis-i2c";
> $ git grep tcg,tpm-tis-i2c
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-bonnell.dts:            compatibl=
e =3D "nuvoton,npct75x", "tcg,tpm-tis-i2c";
> arch/arm/boot/dts/aspeed/aspeed-bmc-ibm-everest.dts:            compatibl=
e =3D "nuvoton,npct75x", "tcg,tpm-tis-i2c";
> arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts:             compatibl=
e =3D "tcg,tpm-tis-i2c";

pog, undocumented compatibles.

> It looks like at least the generic entry is needed, given that it is quite
> likely that there is hardware out there using it. Other than that, this
> makes me wonder: Is there some official guideline describing if and when
> to use (only) generic devicetree compatible entries and when specific ones
> may / should / have to be used ? I suspect the answer to your question mi=
ght
> simply be "because we did not know better", and it might be helpful to be
> able to say "please see XXX for details".

To me using generic compatibles is okay when there is another mechanism
to identify the device. This patch would make more sense if the addition
of nuvoton,npct75x was omitted and the dt-binding had

properties:
  compatible:
    items:
      - enum:
          - infineon,slb9673
          - nuvoton,npct75x
      - const: tcg,tpm-tis-i2c

And whenever new i2c tpms showed up the device specific compatible was
added to the bindings and the driver had only* the generic compatible
static const struct of_device_id of_tis_i2c_match[] =3D {
	{ .compatible =3D "infineon,slb9673", },
	{ .compatible =3D "tcg,tpm-tis-i2c", },
};

* well, and the existing one since that cannot be removed.

--V9Oj+WVlG5N/W7nM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXirtAAKCRB4tDGHoIJi
0pVCAP9eEmViq9zfDvETMM5iORAPbi28FpIFeXMWyuql8hUi6AEA94t1EPXiXh8e
thK7zLOAbzpr0XigoTjBCCrT5zJs5wI=
=bTRp
-----END PGP SIGNATURE-----

--V9Oj+WVlG5N/W7nM--

