Return-Path: <linux-integrity+bounces-412-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C2F80F415
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Dec 2023 18:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B28CD1C20A96
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Dec 2023 17:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456327B3C7;
	Tue, 12 Dec 2023 17:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKjopVXe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8927A221;
	Tue, 12 Dec 2023 17:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D7CFC433C8;
	Tue, 12 Dec 2023 17:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702401004;
	bh=yjoopt9NEDUJBXYr+uh0GurA19bZL/znMFFec8DNFHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HKjopVXeO6JVxx8562Q1lAsjA3jLS9Lrq37LUVv/9vpA/h4L49qsljC4USp3nIwKv
	 wmp89DWIDumgmnSah7+tF4tfl/a9iZ7zkwZK5mcLWXS+lrQTEZ5X2aXuv9bwqT6fzH
	 y2/5Lybl5TsflSGLcFCIfaRXroO9XKBtVpZA+5x91ophu6Q13pvLRM4VfBE5+TW2Fn
	 bhlQstwmM50jkVhnlqPxT24RWqgS/ZlS33sPgFiFCJo+u50ZvA9SWyr9EYcu83sm/j
	 0jt35PpifPlW5KwJp7yaxVF4Wa4gu+oJuW4b4gzlmobPImpcV4Rzv0cE8TqtIQrj9y
	 yhBvAVAnrZzZw==
Date: Tue, 12 Dec 2023 17:09:57 +0000
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
Subject: Re: [PATCH v1 1/8] dt-bindings: arm: aspeed: add IBM system1-bmc
Message-ID: <20231212-thrower-ebook-d29a85a6ed96@spud>
References: <20231212164004.1683589-1-ninad@linux.ibm.com>
 <20231212164004.1683589-2-ninad@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="55umEabtpNwX1lRu"
Content-Disposition: inline
In-Reply-To: <20231212164004.1683589-2-ninad@linux.ibm.com>


--55umEabtpNwX1lRu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 10:39:57AM -0600, Ninad Palsule wrote:
> Document the new compatibles used on IBM system1-bmc
>=20
> Tested:
>     This board is tested using the simics simulator.

I don't see how this is relevant to dt-bindings patches.

>=20
> Signed-off-by: Ninad Palsule <ninad@linux.ibm.com>
> ---
>  Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml | 1 +
>  Documentation/devicetree/bindings/trivial-devices.yaml   | 2 ++

IMO these should be split into two patches.

Cheers,
Conor.

>  2 files changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml b/D=
ocumentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> index 6f7543463d89..ebebe14c42aa 100644
> --- a/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> +++ b/Documentation/devicetree/bindings/arm/aspeed/aspeed.yaml
> @@ -85,6 +85,7 @@ properties:
>                - facebook,yosemite4-bmc
>                - ibm,everest-bmc
>                - ibm,rainier-bmc
> +              - ibm,system1-bmc
>                - ibm,tacoma-bmc
>                - inventec,starscream-bmc
>                - inventec,transformer-bmc
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Doc=
umentation/devicetree/bindings/trivial-devices.yaml
> index 441b55723675..b12a60d2eb0f 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -135,6 +135,8 @@ properties:
>            - ibm,cffps1
>              # IBM Common Form Factor Power Supply Versions 2
>            - ibm,cffps2
> +            # Infineon barometric pressure and temperature sensor
> +          - infineon,dps310
>              # Infineon IR36021 digital POL buck controller
>            - infineon,ir36021
>              # Infineon IR38060 Voltage Regulator
> --=20
> 2.39.2
>=20

--55umEabtpNwX1lRu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXiT5AAKCRB4tDGHoIJi
0pd1AQCSwXdC8RYV745T9gVdIrlReCQJoSuD6J0vvr2NN2/3iAD+Mfx6pgKRXZWu
G9C1EwvFHJ7rMpBCulVDOhFTvdQLUAA=
=0EQF
-----END PGP SIGNATURE-----

--55umEabtpNwX1lRu--

