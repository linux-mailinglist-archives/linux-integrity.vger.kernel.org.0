Return-Path: <linux-integrity+bounces-768-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF84482CDFE
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Jan 2024 18:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5344F1F22483
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Jan 2024 17:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89665394;
	Sat, 13 Jan 2024 17:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzrPBAc+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4603528EF;
	Sat, 13 Jan 2024 17:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-5eefd0da5c0so78192467b3.2;
        Sat, 13 Jan 2024 09:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705167569; x=1705772369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqQ/ardrSPtiAEurpJ6hvz43acFrRMYxJ6zuOLP6ov8=;
        b=kzrPBAc+3vzskfy/lJuYG1Jtt2KCKnrdyH9Xm/ucAkmaC6rBUBDwGilLPpLBC9uuV8
         PPcfJbQVN0lXJOv6prYgjYNEnrq2oX+EBnovQrG6KjNn+xn6QnItnrTS4TiTEuKtAuJL
         rpy3PQtbnGTikKLT5lBn1y8yWvimdbryKvojr3oxJhdhIeqE9ViVOXi7n1lG88jF6rqC
         SqlOkHslGenqL+8nMvtOoDhgp5OsJZI0BPc3YyGC15AH8cXYiTEdy3zhXaTj2q/4P3Ib
         lbVgzhzLYQrE7gI3AfdqGe2FI9/McRJFVvPhvfQ5nY2SLT0NYeCPE19LhXwS4ClMzuBl
         H3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705167569; x=1705772369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jqQ/ardrSPtiAEurpJ6hvz43acFrRMYxJ6zuOLP6ov8=;
        b=M5vQbikfa8mojcq57OT5iQfrZoYZnEyfHbW9RVxKK4kZay/n2Y6OzJrlSXVrVacdZS
         7qE83Eda7hFeShgxqCnwE6zLD/SgO3g4ERn8z7qiarfSs4QVdEK4k375oit88qcrUfw7
         IDJ+mZnzGVLLBEQDZcJcGROKyBDsaoblo36Y8nnQZrgoN2/niTmPHkNRkYMDW6Ny7QCm
         ACGgUuD4pKEUijqv80TQZQh0wlO+f6/gaUnf537lSulAMNahncxfj1ZBkJDmi6b27JW5
         YkJVJfqbhMkPL1m3YR6qr1MybWE/y6n7DKkMIqOE33crDSn6clKD6ssjjJUwWD40HO0A
         eMFw==
X-Gm-Message-State: AOJu0YwQlFTX6cE5fQ7HY4KC3VLdz4evyFIzfYWBve0BTq5iTa2/qOaF
	6q5buIvqowPL/+ocwBZiHq5gJjBslfQO3stZqG8=
X-Google-Smtp-Source: AGHT+IG5R2SfW/IkTX2fJdaSYfCdOD7fKDYk+CKs1tj5ZGjxR3tbdh3Im04blDvG5D/Cryo9bsEfl4NQ+S0kVLJEXDo=
X-Received: by 2002:a0d:ea05:0:b0:5d7:1940:b398 with SMTP id
 t5-20020a0dea05000000b005d71940b398mr2956495ywe.100.1705167569648; Sat, 13
 Jan 2024 09:39:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8b49a64d5946792f01e75fab74076557ef4f7d60.1705135956.git.lukas@wunner.de>
In-Reply-To: <8b49a64d5946792f01e75fab74076557ef4f7d60.1705135956.git.lukas@wunner.de>
From: Bruno Thomsen <bruno.thomsen@gmail.com>
Date: Sat, 13 Jan 2024 18:39:13 +0100
Message-ID: <CAH+2xPCfJPdmttuLckRRZr20c9CpVHJmkpOymHvLOQyBMH86yQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: Fix TPM schema violations
To: Lukas Wunner <lukas@wunner.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, soc@kernel.org, 
	devicetree@vger.kernel.org, linux-integrity@vger.kernel.org, 
	Patrick Williams <patrick@stwcx.xyz>, Tao Ren <rentao.bupt@gmail.com>, 
	Eddie James <eajames@linux.ibm.com>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de, 
	Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com, Wes Huang <wes.huang@moxa.com>, 
	Fero JD Zhou <FeroJD.Zhou@moxa.com>, SZ Lin <sz.lin@moxa.com>, 
	Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Yannic Moog <Y.Moog@phytec.de>, 
	Alexander Bauer <a.bauer@phytec.de>, upstream@lists.phytec.de, 
	Teresa Remmet <T.Remmet@phytec.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Den l=C3=B8r. 13. jan. 2024 kl. 10.03 skrev Lukas Wunner <lukas@wunner.de>:
>
> Since commit 26c9d152ebf3 ("dt-bindings: tpm: Consolidate TCG TIS
> bindings"), several issues are reported by "make dtbs_check" for ARM
> devicetrees:
>
> The nodename needs to be "tpm@0" rather than "tpmdev@0" and the
> compatible property needs to contain the chip's name in addition to the
> generic "tcg,tpm_tis-spi" or "tcg,tpm-tis-i2c":
>
>   tpmdev@0: $nodename:0: 'tpmdev@0' does not match '^tpm(@[0-9a-f]+)?$'
>         from schema $id: http://devicetree.org/schemas/tpm/tcg,tpm_tis-sp=
i.yaml#
>
>   tpm@2e: compatible: 'oneOf' conditional failed, one must be fixed:
>         ['tcg,tpm-tis-i2c'] is too short
>         from schema $id: http://devicetree.org/schemas/tpm/tcg,tpm-tis-i2=
c.yaml#
>
> Fix these schema violations.
>
> Aspeed Facebook BMCs use an Infineon SLB9670:
> https://lore.kernel.org/all/ZZSmMJ%2F%2Fl972Qbxu@fedora/
> https://lore.kernel.org/all/ZZT4%2Fw2eVzMhtsPx@fedora/
> https://lore.kernel.org/all/ZZTS0p1hdAchIbKp@heinlein.vulture-banana.ts.n=
et/
>
> Aspeed Tacoma uses a Nuvoton NPCT75X per commit 39d8a73c53a2 ("ARM: dts:
> aspeed: tacoma: Add TPM").
>
> phyGATE-Tauri uses an Infineon SLB9670:
> https://lore.kernel.org/all/ab45c82485fa272f74adf560cbb58ee60cc42689.came=
l@phytec.de/
>
> A single schema violation remains in am335x-moxa-uc-2100-common.dtsi
> because it is unknown which chip is used on the board.  The devicetree's
> author has been asked for clarification but has not responded so far:
> https://lore.kernel.org/all/20231220090910.GA32182@wunner.de/
>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Patrick Williams <patrick@stwcx.xyz>
> Reviewed-by: Tao Ren <rentao.bupt@gmail.com>

Change in imx7d-flex-concentrator.dts looks good to me.

Reviewed-by: Bruno Thomsen <bruno.thomsen@gmail.com>

> ---
> The commit mentioned above, 26c9d152ebf3 ("dt-bindings: tpm: Consolidate
> TCG TIS bindings") landed in Linus' tree 8 hours ago.
>
> Because this consists only of fixes, I think it could be picked up and
> forwarded to Linus at any time, even outside the merge window.
>
> The Reviewed-by tags from Patrick and Tao were offered here:
> https://lore.kernel.org/all/ZZWB4wRiAyDtlLJM@heinlein.vulture-banana.ts.n=
et/
> https://lore.kernel.org/all/ZZWkhaiDFOGvcPQy@fedora/
>
>  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts   | 4 ++--
>  arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts    | 4 ++--
>  arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts           | 2 +-
>  arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi | 4 ++--
>  arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi          | 2 +-
>  arch/arm/boot/dts/nxp/imx/imx7d-flex-concentrator.dts        | 2 +-
>  arch/arm/boot/dts/ti/omap/am335x-moxa-uc-2100-common.dtsi    | 2 +-
>  7 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts b=
/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
> index e899de6..5be0e8f 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-bletchley.dts
> @@ -45,8 +45,8 @@
>                 num-chipselects =3D <1>;
>                 cs-gpios =3D <&gpio0 ASPEED_GPIO(Z, 0) GPIO_ACTIVE_LOW>;
>
> -               tpmdev@0 {
> -                       compatible =3D "tcg,tpm_tis-spi";
> +               tpm@0 {
> +                       compatible =3D "infineon,slb9670", "tcg,tpm_tis-s=
pi";
>                         spi-max-frequency =3D <33000000>;
>                         reg =3D <0>;
>                 };
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts b/=
arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
> index a677c82..5a8169b 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-wedge400.dts
> @@ -80,8 +80,8 @@
>                 gpio-miso =3D <&gpio ASPEED_GPIO(R, 5) GPIO_ACTIVE_HIGH>;
>                 num-chipselects =3D <1>;
>
> -               tpmdev@0 {
> -                       compatible =3D "tcg,tpm_tis-spi";
> +               tpm@0 {
> +                       compatible =3D "infineon,slb9670", "tcg,tpm_tis-s=
pi";
>                         spi-max-frequency =3D <33000000>;
>                         reg =3D <0>;
>                 };
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts b/arch/ar=
m/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts
> index 3f6010e..213023b 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-opp-tacoma.dts
> @@ -456,7 +456,7 @@
>         status =3D "okay";
>
>         tpm: tpm@2e {
> -               compatible =3D "tcg,tpm-tis-i2c";
> +               compatible =3D "nuvoton,npct75x", "tcg,tpm-tis-i2c";
>                 reg =3D <0x2e>;
>         };
>  };
> diff --git a/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi=
 b/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
> index 31590d3..00e5887 100644
> --- a/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
> +++ b/arch/arm/boot/dts/aspeed/ast2600-facebook-netbmc-common.dtsi
> @@ -35,8 +35,8 @@
>                 gpio-mosi =3D <&gpio0 ASPEED_GPIO(X, 4) GPIO_ACTIVE_HIGH>=
;
>                 gpio-miso =3D <&gpio0 ASPEED_GPIO(X, 5) GPIO_ACTIVE_HIGH>=
;
>
> -               tpmdev@0 {
> -                       compatible =3D "tcg,tpm_tis-spi";
> +               tpm@0 {
> +                       compatible =3D "infineon,slb9670", "tcg,tpm_tis-s=
pi";
>                         spi-max-frequency =3D <33000000>;
>                         reg =3D <0>;
>                 };
> diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi b/arch/a=
rm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi
> index 44cc4ff..d12fb44 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi
> +++ b/arch/arm/boot/dts/nxp/imx/imx6ull-phytec-tauri.dtsi
> @@ -116,7 +116,7 @@
>         tpm_tis: tpm@1 {
>                 pinctrl-names =3D "default";
>                 pinctrl-0 =3D <&pinctrl_tpm>;
> -               compatible =3D "tcg,tpm_tis-spi";
> +               compatible =3D "infineon,slb9670", "tcg,tpm_tis-spi";
>                 reg =3D <1>;
>                 spi-max-frequency =3D <20000000>;
>                 interrupt-parent =3D <&gpio5>;
> diff --git a/arch/arm/boot/dts/nxp/imx/imx7d-flex-concentrator.dts b/arch=
/arm/boot/dts/nxp/imx/imx7d-flex-concentrator.dts
> index 3a72384..9984b34 100644
> --- a/arch/arm/boot/dts/nxp/imx/imx7d-flex-concentrator.dts
> +++ b/arch/arm/boot/dts/nxp/imx/imx7d-flex-concentrator.dts
> @@ -130,7 +130,7 @@
>          * TCG specification - Section 6.4.1 Clocking:
>          * TPM shall support a SPI clock frequency range of 10-24 MHz.
>          */
> -       st33htph: tpm-tis@0 {
> +       st33htph: tpm@0 {
>                 compatible =3D "st,st33htpm-spi", "tcg,tpm_tis-spi";
>                 reg =3D <0>;
>                 spi-max-frequency =3D <24000000>;
> diff --git a/arch/arm/boot/dts/ti/omap/am335x-moxa-uc-2100-common.dtsi b/=
arch/arm/boot/dts/ti/omap/am335x-moxa-uc-2100-common.dtsi
> index b8730aa..a59331a 100644
> --- a/arch/arm/boot/dts/ti/omap/am335x-moxa-uc-2100-common.dtsi
> +++ b/arch/arm/boot/dts/ti/omap/am335x-moxa-uc-2100-common.dtsi
> @@ -217,7 +217,7 @@
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&spi1_pins>;
>
> -       tpm_spi_tis@0 {
> +       tpm@0 {
>                 compatible =3D "tcg,tpm_tis-spi";
>                 reg =3D <0>;
>                 spi-max-frequency =3D <500000>;
> --
> 2.40.1
>

