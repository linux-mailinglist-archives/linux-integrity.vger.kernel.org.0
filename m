Return-Path: <linux-integrity+bounces-771-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 393F782CE3E
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Jan 2024 20:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB9451F2222B
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Jan 2024 19:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40BB1611E;
	Sat, 13 Jan 2024 19:13:57 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC5D63A6;
	Sat, 13 Jan 2024 19:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860cd7.versanet.de ([94.134.12.215] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rOjRp-00068M-HN; Sat, 13 Jan 2024 20:13:37 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
 soc@kernel.org, devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
 Lukas Wunner <lukas@wunner.de>
Cc: Yannic Moog <Y.Moog@phytec.de>, Alexander Bauer <a.bauer@phytec.de>,
 upstream@lists.phytec.de, Teresa Remmet <T.Remmet@phytec.de>,
 Tim Harvey <tharvey@gateworks.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
 Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com,
 Adam Ford <aford173@gmail.com>, Heiko Thiery <heiko.thiery@gmail.com>,
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Hsin-Yi Wang <hsinyi@chromium.org>, Chen-Yu Tsai <wenst@chromium.org>,
 Nicolas Prado <nfraprado@collabora.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] arm64: dts: Fix TPM schema violations
Date: Sat, 13 Jan 2024 20:13:35 +0100
Message-ID: <11865970.MucGe3eQFb@diego>
In-Reply-To:
 <e6d7768e2a257e0bd5948bcf168909b6c670851b.1705168605.git.lukas@wunner.de>
References:
 <e6d7768e2a257e0bd5948bcf168909b6c670851b.1705168605.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Lukas,

Am Samstag, 13. Januar 2024, 19:06:56 CET schrieb Lukas Wunner:
> Since commit 26c9d152ebf3 ("dt-bindings: tpm: Consolidate TCG TIS
> bindings"), several issues are reported by "make dtbs_check" for arm64
> devicetrees:
> 
> The compatible property needs to contain the chip's name in addition to
> the generic "tcg,tpm_tis-spi" and the nodename needs to be "tpm@0"
> rather than "cr50@0":
> 
>   tpm@1: compatible: ['tcg,tpm_tis-spi'] is too short
>         from schema $id: http://devicetree.org/schemas/tpm/tcg,tpm_tis-spi.yaml#
> 
>   cr50@0: $nodename:0: 'cr50@0' does not match '^tpm(@[0-9a-f]+)?$'
>         from schema $id: http://devicetree.org/schemas/tpm/google,cr50.yaml#
> 
> Fix these schema violations.
> 
> phyGATE-Tauri uses an Infineon SLB9670:
> https://lore.kernel.org/all/ab45c82485fa272f74adf560cbb58ee60cc42689.camel@phytec.de/
> 
> Gateworks Venice uses an Atmel ATTPM20P:
> https://trac.gateworks.com/wiki/tpm
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> ---
> The commit mentioned above, 26c9d152ebf3 ("dt-bindings: tpm: Consolidate
> TCG TIS bindings") landed in Linus' tree yesterday.
> 
> Because this consists only of fixes, I think it could be picked up and
> forwarded to Linus at any time, even outside the merge window.
> 
> The issues reported for imx8m*-venice-gw7*xx.dts* devicetrees will not
> go away until Jarrko picks up this amendment patch for the dt-bindings:
> https://lore.kernel.org/all/8886271d52025065eddf5915bb7778ab14362255.1705140898.git.lukas@wunner.de/
> 
>  arch/arm64/boot/dts/freescale/imx8mm-phygate-tauri-l.dts    | 2 +-
>  arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi     | 2 +-
>  arch/arm64/boot/dts/freescale/imx8mm-venice-gw73xx.dtsi     | 2 +-
>  arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts         | 2 +-
>  arch/arm64/boot/dts/freescale/imx8mp-venice-gw72xx.dtsi     | 2 +-
>  arch/arm64/boot/dts/freescale/imx8mp-venice-gw73xx.dtsi     | 2 +-
>  arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts      | 2 +-
>  arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts | 2 +-
>  arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi              | 2 +-
>  arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi            | 2 +-
>  arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts             | 2 +-
>  arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi        | 2 +-

you might want to split this per sub-architecture perhaps (freescale,
mediatek, rockchip) as such dts changes normally go through the trees
of the subarchitecture maintainers.


For the rockchip-parts itself, I'm also fine with them going through
somewhere else - gru devices are pretty much "finished" by now,
so for the rockchip changes
Acked-by: Heiko Stuebner <heiko@sntech.de>


Heiko



