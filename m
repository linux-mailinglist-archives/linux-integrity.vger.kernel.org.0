Return-Path: <linux-integrity+bounces-454-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 835A681365C
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Dec 2023 17:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B674C1C20D3F
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Dec 2023 16:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EC160B8B;
	Thu, 14 Dec 2023 16:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osr3FgHO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002D65FF07;
	Thu, 14 Dec 2023 16:35:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F85C433C8;
	Thu, 14 Dec 2023 16:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702571735;
	bh=xLP+CoYVRLf33dBZWy5D+JKVopjIGSKoYshwiIZs8WA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=osr3FgHOd4SxcHlgM+KOE3JV5uBYP9C8KxGaoG2GKSPe6NrSS8k4Otmqu4xV46Yas
	 waqEXYeDYaxMmJiZn/Ld0KbTKe1csyUB23OvBJMSRempX0Te7sC4TA3JrVvyJp5qar
	 EX642T5u02Fu+1kmlzxxE0xK5FczFoX5t6PD2QIUWiPXcXlYRUkyJOe1UAWR5vAftl
	 8tWrd1VeDeWfI+HH8oAycivpbskmMyPDLLF4okV29ou9JImHjNKXIExJWL11P+OtjW
	 UjjKb4KEtvajbahh8rfFn/MGo3ArVlhAFke2+6PTj58UqBfSR+owDpZhR3CcFz8ww1
	 NSSQ3uH/wi5xQ==
Date: Thu, 14 Dec 2023 16:35:27 +0000
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
Subject: Re: [PATCH v1 2/8] dt-bindings: tpm: Add schema for TIS I2C devices
Message-ID: <20231214-stopper-bounce-ca9002869293@spud>
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-3-ninad@linux.ibm.com>
 <20231212-amusement-elevation-28e42bcccc35@spud>
 <d8b5df1c-c732-4cf3-ae28-cc2017d3b0b6@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MMQ9s9pZoIm9/Al5"
Content-Disposition: inline
In-Reply-To: <d8b5df1c-c732-4cf3-ae28-cc2017d3b0b6@linux.ibm.com>


--MMQ9s9pZoIm9/Al5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 09:34:39AM -0600, Ninad Palsule wrote:
> Hello Conor,
>=20
> On 12/12/23 11:14, Conor Dooley wrote:
> > Hey,
> >=20
> > On Tue, Dec 12, 2023 at 10:39:58AM -0600, Ninad Palsule wrote:
> > > From: Johannes Holland <johannes.holland@infineon.com>
> > >=20
> > > Add a dt schema to support device tree bindings
> > "Add bindings for..."
> Fixed.
> >=20
> > > for the generic I2C
> > > physical layer. Refer to the TCG PC Client Platform TPM Profile (PTP)
> > > Specification for TPM 2.0 v1.04 Revision 14.
> > >=20
> > > This includes descriptions for the Nuvoton and Infineon devices.
> > >=20
> > > OpenBMC-Staging-Count: 3
> > I have no idea what this is, but it needs to be removed from the patch.
> Removed.
> >=20
> > > Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
> > > Signed-off-by: Joel Stanley <joel@jms.id.au>
> > > Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> > > ---
> > >   .../bindings/security/tpm/tpm-tis-i2c.yaml    | 50 ++++++++++++++++=
+++
> > >   1 file changed, 50 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/security/tpm/t=
pm-tis-i2c.yaml
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/security/tpm/tpm-tis-i=
2c.yaml b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
> > > new file mode 100644
> > > index 000000000000..de1e34065748
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
> > > @@ -0,0 +1,50 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/security/tpm/tpm-tis-i2c.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: I2C PTP based TPM Devices
> > > +
> > > +maintainers:
> > > +  - Johannes Holland <johannes.holland@infineon.com>
> > > +
> > > +description:
> > > +  Device Tree Bindings for I2C based Trusted Platform Module (TPM).
> > s/Device Tree Bindings for //. Doesn't dt_binding_check now complain if
> > you have this in a title or description?
> Fixed.
> >=20
> > > +properties:
> > > +  $nodename:
> > > +    pattern: "^tpm(@[0-9a-f]+)?$"
> > > +
> > > +  compatible:
> > > +    oneOf:
> > > +      - description: Infineon's Trusted Platform Module (TPM) (SLB96=
73).
> > > +        items:
> > > +          - const: infineon,slb9673
> > > +          - const: tcg,tpm-tis-i2c
> > > +      - description: Nuvoton's Trusted Platform Module (TPM) (NPCT75=
x).
> > > +        items:
> > > +          - const: nuvoton,npct75x
> > > +          - const: tcg,tpm-tis-i2c

Also, another thought - the bus is not usually encoded in the compatible
string, so it would be good to remove that.

> > > +      - const: tcg,tpm-tis-i2c
> > IMO this should be removed and this fallback should only be used in
> > combination with device specific compatibles, like you have here for the
> > infineon and nuvoton devices.
>=20
> As Guenter mentioned I need to keep it as tacoma board is just using this
> string.

No, that does not mean that you have to keep this in the binding. I know
Rob had some comments that might invalidate this binding entirely, but
if that does not happen then I think think that the tacoma devicetree
needs to have a device-specific compatible added for the tpm that it has.
You could of course retain the generic fallback compatible however.

--MMQ9s9pZoIm9/Al5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXsuzwAKCRB4tDGHoIJi
0iCVAQDk5mHO10tmO5WDzSu3wLDAmW2sRXfnlt57B2JKfnI6ugEA4cuH9pF3plY6
Hwto/5Zwn/wHNXZGd/jh0wVacJxniQo=
=N8sK
-----END PGP SIGNATURE-----

--MMQ9s9pZoIm9/Al5--

