Return-Path: <linux-integrity+bounces-413-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 970E480F42F
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Dec 2023 18:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 521EB281D57
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Dec 2023 17:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD5A7B3D5;
	Tue, 12 Dec 2023 17:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YaQxsfHF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00F37B3CE;
	Tue, 12 Dec 2023 17:14:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE9EC433C7;
	Tue, 12 Dec 2023 17:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702401274;
	bh=Zcj0fXIYj05PfXAXJRRaba5K0+vOckPktiL630dMYgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YaQxsfHFiB42qftcR6JIjgF6HOa9mFE3f99F0/2J8URfdFND6pZ217M2SLq7InFZN
	 oEFXu+Lf/wQ7YSvLx1w5Q9jzNBY/Qc1WVKretbOmlcoLt/Swv1ld9vz/dalKNU5pLm
	 9wIhqZnctSuPaMCfLkR+9uHaZDlOXJG9EvVhYP2OSGpSfmb47zwx4z2ebcCcSucmB9
	 48ntdXs609bTUl4lCqHP3vA13xXAsU2dALDh2vvOolorLHqJNKS+P1hcp9UVsSeuO9
	 K+8KE1iKh3+/3phhUlltwDyg+gKlHq8nTyD7OdMOGm2gHZ8Wiviu8N6UG2cwp1JY9S
	 EwD7Iz17sNZyw==
Date: Tue, 12 Dec 2023 17:14:26 +0000
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
Message-ID: <20231212-amusement-elevation-28e42bcccc35@spud>
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-3-ninad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2PG9iIB6csIKhjsS"
Content-Disposition: inline
In-Reply-To: <20231212164004.1683589-3-ninad@linux.ibm.com>


--2PG9iIB6csIKhjsS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Tue, Dec 12, 2023 at 10:39:58AM -0600, Ninad Palsule wrote:
> From: Johannes Holland <johannes.holland@infineon.com>
>=20
> Add a dt schema to support device tree bindings

"Add bindings for..."

> for the generic I2C
> physical layer. Refer to the TCG PC Client Platform TPM Profile (PTP)
> Specification for TPM 2.0 v1.04 Revision 14.
>=20
> This includes descriptions for the Nuvoton and Infineon devices.
>=20

> OpenBMC-Staging-Count: 3

I have no idea what this is, but it needs to be removed from the patch.

> Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>  .../bindings/security/tpm/tpm-tis-i2c.yaml    | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-ti=
s-i2c.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.y=
aml b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
> new file mode 100644
> index 000000000000..de1e34065748
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/security/tpm/tpm-tis-i2c.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: I2C PTP based TPM Devices
> +
> +maintainers:
> +  - Johannes Holland <johannes.holland@infineon.com>
> +
> +description:
> +  Device Tree Bindings for I2C based Trusted Platform Module (TPM).

s/Device Tree Bindings for //. Doesn't dt_binding_check now complain if
you have this in a title or description?

> +properties:
> +  $nodename:
> +    pattern: "^tpm(@[0-9a-f]+)?$"
> +
> +  compatible:
> +    oneOf:
> +      - description: Infineon's Trusted Platform Module (TPM) (SLB9673).
> +        items:
> +          - const: infineon,slb9673
> +          - const: tcg,tpm-tis-i2c
> +      - description: Nuvoton's Trusted Platform Module (TPM) (NPCT75x).
> +        items:
> +          - const: nuvoton,npct75x
> +          - const: tcg,tpm-tis-i2c

> +      - const: tcg,tpm-tis-i2c

IMO this should be removed and this fallback should only be used in
combination with device specific compatibles, like you have here for the
infineon and nuvoton devices.

Cheers,
Conor.

> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      tpm@2e {
> +        compatible =3D "nuvoton,npct75x", "tcg,tpm-tis-i2c";
> +        reg =3D <0x2e>;
> +      };
> +    };
> +...
> --=20
> 2.39.2
>=20

--2PG9iIB6csIKhjsS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXiU8gAKCRB4tDGHoIJi
0rfJAP4nZ5EnLrc7JoF/x1QncshpSRifSSj5EXGcysTDO4Sr+wEAwPGS175s6OHs
QOXCdCmeYeUbjJsKyPpDYvec+54oKgg=
=kpn3
-----END PGP SIGNATURE-----

--2PG9iIB6csIKhjsS--

