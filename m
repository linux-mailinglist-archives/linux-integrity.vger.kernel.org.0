Return-Path: <linux-integrity+bounces-813-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3273882ECB6
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jan 2024 11:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 432731C22F20
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jan 2024 10:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7715F134D9;
	Tue, 16 Jan 2024 10:24:31 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B13134D5;
	Tue, 16 Jan 2024 10:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id F2BB730000868;
	Tue, 16 Jan 2024 11:24:23 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id E3127316BEB; Tue, 16 Jan 2024 11:24:23 +0100 (CET)
Date: Tue, 16 Jan 2024 11:24:23 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Olof Johansson <olof@lixom.net>, soc@kernel.org,
	devicetree@vger.kernel.org, linux-integrity@vger.kernel.org,
	Yannic Moog <Y.Moog@phytec.de>, Alexander Bauer <a.bauer@phytec.de>,
	upstream@lists.phytec.de, Teresa Remmet <T.Remmet@phytec.de>,
	Tim Harvey <tharvey@gateworks.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, Adam Ford <aford173@gmail.com>,
	Heiko Thiery <heiko.thiery@gmail.com>,
	Enric Balletbo i Serra <eballetbo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Hsin-Yi Wang <hsinyi@chromium.org>,
	Chen-Yu Tsai <wenst@chromium.org>,
	=?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado <nfraprado@collabora.com>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH] arm64: dts: Fix TPM schema violations
Message-ID: <20240116102423.GA27561@wunner.de>
References: <e6d7768e2a257e0bd5948bcf168909b6c670851b.1705168605.git.lukas@wunner.de>
 <682b50dc-a92a-4da5-ad06-631c5125ebc5@collabora.com>
 <8e138e54-22ba-43d3-898c-ab772039cd99@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e138e54-22ba-43d3-898c-ab772039cd99@app.fastmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Jan 15, 2024 at 09:17:41PM +0100, Arnd Bergmann wrote:
> > Il 13/01/24 19:06, Lukas Wunner ha scritto:
> > > Since commit 26c9d152ebf3 ("dt-bindings: tpm: Consolidate TCG TIS
> > > bindings"), several issues are reported by "make dtbs_check" for arm64
> > > devicetrees:
> > > 
> > > The compatible property needs to contain the chip's name in addition to
> > > the generic "tcg,tpm_tis-spi" and the nodename needs to be "tpm@0"
> > > rather than "cr50@0":
> > > 
> > >    tpm@1: compatible: ['tcg,tpm_tis-spi'] is too short
> > >          from schema $id: http://devicetree.org/schemas/tpm/tcg,tpm_tis-spi.yaml#
> > > 
> > >    cr50@0: $nodename:0: 'cr50@0' does not match '^tpm(@[0-9a-f]+)?$'
> > >          from schema $id: http://devicetree.org/schemas/tpm/google,cr50.yaml#
> > > 
> > > Fix these schema violations.
> 
> However, I got some conflicts trying to apply them on
> top of v6.7, so maybe check that and resend.

This patch needs to be applied on top of the soc-dt-6.8 tag,
not v6.7, because there were changes in your v6.8 pull request
which introduce a new TPM DT node in:

  arch/arm64/boot/dts/freescale/imx8mm-venice-gw72xx.dtsi
  arch/arm64/boot/dts/freescale/imx8mp-venice-gw72xx.dtsi

and modify an existing TPM DT node in:

  arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts

So if I'd base this patch on top of v6.7, it would be missing
the fixes for these three devicetrees and I'd have to submit
a separate patch with them.  Happy to do so if that's what
you want but basing on top of soc-dt-6.8 seemed more reasonable
to me as initial submission.

Thanks!

Lukas

