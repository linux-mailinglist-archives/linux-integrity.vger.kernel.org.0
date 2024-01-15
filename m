Return-Path: <linux-integrity+bounces-778-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3252082D528
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jan 2024 09:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D674F281B16
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jan 2024 08:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DAF23A7;
	Mon, 15 Jan 2024 08:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="yLQ0h/T9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8552563;
	Mon, 15 Jan 2024 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705308092;
	bh=C3rT1/ddNThmU1OTPQTOVjH0MXuCDiqlLPyDw+7f5lw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=yLQ0h/T9YjM33CfzM7ECMQ2MDC69fQg37HD0pvwsL/tJ3fLbfNOMP3JTJG7+eiHyG
	 uW9YPNkH1nyOATKBxyHtj5JB+B7iiMQHTucpBL71YSwsgv6viecr9FWGN3Hm9lcI+k
	 NSsiFXCTof3XQPjt+Zz2lDg2JzLqWx5qapNSnI+YwD+Kyv0jYcPSfhvoVqUMu6TWZ2
	 YoOhhRI03yEX+AntGcJsnkB8riw8n+sfGwj6B/UWDP3Vmi426el+tAAMgpyMaatRU+
	 qxf9f01taD7sz6szS2iqhVzzpFsfEWJKea3o9i9FU+6CeZ0D6Non2FvU58XIPOVSBN
	 tlZpwCftk8lvg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E7D3D37813E0;
	Mon, 15 Jan 2024 08:41:30 +0000 (UTC)
Message-ID: <682b50dc-a92a-4da5-ad06-631c5125ebc5@collabora.com>
Date: Mon, 15 Jan 2024 09:41:29 +0100
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: Fix TPM schema violations
To: Lukas Wunner <lukas@wunner.de>, Arnd Bergmann <arnd@arndb.de>,
 Olof Johansson <olof@lixom.net>, soc@kernel.org, devicetree@vger.kernel.org,
 linux-integrity@vger.kernel.org
Cc: Yannic Moog <Y.Moog@phytec.de>, Alexander Bauer <a.bauer@phytec.de>,
 upstream@lists.phytec.de, Teresa Remmet <T.Remmet@phytec.de>,
 Tim Harvey <tharvey@gateworks.com>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, kernel@pengutronix.de,
 Fabio Estevam <festevam@gmail.com>, linux-imx@nxp.com,
 Adam Ford <aford173@gmail.com>, Heiko Thiery <heiko.thiery@gmail.com>,
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Hsin-Yi Wang
 <hsinyi@chromium.org>, Chen-Yu Tsai <wenst@chromium.org>,
 Nicolas Prado <nfraprado@collabora.com>, Heiko Stuebner <heiko@sntech.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
References: <e6d7768e2a257e0bd5948bcf168909b6c670851b.1705168605.git.lukas@wunner.de>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <e6d7768e2a257e0bd5948bcf168909b6c670851b.1705168605.git.lukas@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 13/01/24 19:06, Lukas Wunner ha scritto:
> Since commit 26c9d152ebf3 ("dt-bindings: tpm: Consolidate TCG TIS
> bindings"), several issues are reported by "make dtbs_check" for arm64
> devicetrees:
> 
> The compatible property needs to contain the chip's name in addition to
> the generic "tcg,tpm_tis-spi" and the nodename needs to be "tpm@0"
> rather than "cr50@0":
> 
>    tpm@1: compatible: ['tcg,tpm_tis-spi'] is too short
>          from schema $id: http://devicetree.org/schemas/tpm/tcg,tpm_tis-spi.yaml#
> 
>    cr50@0: $nodename:0: 'cr50@0' does not match '^tpm(@[0-9a-f]+)?$'
>          from schema $id: http://devicetree.org/schemas/tpm/google,cr50.yaml#
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

For MediaTek:
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

...but I think you should split this per-SoC.

Anyway, if Arnd wants to take this patch directly I'm also totally fine with that.

Cheers,
Angelo


