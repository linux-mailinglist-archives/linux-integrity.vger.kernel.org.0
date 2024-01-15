Return-Path: <linux-integrity+bounces-809-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B3E82E171
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jan 2024 21:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBE67B20CE8
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jan 2024 20:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38A619470;
	Mon, 15 Jan 2024 20:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Zudq/OQV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mi3ROXdw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A4618E10;
	Mon, 15 Jan 2024 20:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 2815B3200B25;
	Mon, 15 Jan 2024 15:18:04 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 15 Jan 2024 15:18:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1705349883; x=1705436283; bh=e+ykc0zOmp
	+y1Z7R5pTDfegBpM5HaaHl2YIznyofnRg=; b=Zudq/OQVUSbgUeJ7VgSexjEMis
	Yyoi7XQ5AQkOZE1cO8jcSwrnSNFqsmAPtyAEujvTEMJe2w4OU/8E0slEN17nm5hw
	TPVGSMoDPb8zXQFUu28DDfcA7iQFbfrCypppj1QkJaJbU0wcBrA2OzcxsiOziKQQ
	v4wz68j7Ett/UYRH4GEwJF6oGetGNJjrzfX7KSE6uY6GTzlCR9AR5nvDSTHUYRtg
	zUwIabO3NOLxRuzLYH+6HTqewDaKLAaVD0QW00vnsNU5H8nxeGTflkeKCU0ty92z
	8x3QOkYNK8UVKW3BQQb6rOmZwySIYAeWapxsGm9mVGndOqHmswh4tGT7n8Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705349883; x=1705436283; bh=e+ykc0zOmp+y1Z7R5pTDfegBpM5H
	aaHl2YIznyofnRg=; b=Mi3ROXdwiL6vOPVn/TnKU+QitRjS39TYAcKwetaXwmo3
	jC0XdgjlIriLJgI0Tm+TGRAXfaEaqfhuuMsKOFFQJLEtWwFHlsnu2ecajYIrXbdh
	SeWXyTwWm1WI0Dq1g5c673AAc5rp+0SWTTNc5pPGr5z8OmPWUURXOr8zN/3mW7NF
	t+19JpX4kU/KtjXxtPqjyhhJy/RQgxWp27uLeBbLXUAfYh52mwQ5B7LGre/w4BUC
	5GfGZqFl524OIPXAPybjQaEs03sCTgi5CTbQk84mMw+Nh5cdocJJD5DJy1S4GUj1
	LNSrbQktUKHs+fEnws+jle1ZjmpFKAkPyytZ85Pj0A==
X-ME-Sender: <xms:-pKlZSeNIxS12fwTkbr06DzcMtTKr4nYHLMiGJ65ir_vW9fuaMTB7g>
    <xme:-pKlZcM_3r0Rp4UiyUoX5xmyBCCF5qUhl68KBcTzJeKhPe5Br6vKBlJTWg3nlpH69
    a98kDFMvu2h5LoNC_s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejuddgudefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeeiiedtlefgtdfhheetheffudekffefteeiieevudfggfegieefteevgeev
    veduieenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgpdhkvghrnhgvlhdroh
    hrghdpghgrthgvfihorhhkshdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:-pKlZTiwDl7yupMOdwsgf6XD1WZQ0S6g-oq3h_Uiu2DhLaZJxuioZw>
    <xmx:-pKlZf_DFocOrvK91AFNmbCl_5XnYYHQyCukOHgurk9h0AykZwDQEw>
    <xmx:-pKlZetRIAag5BvUcMXdMOXCc8gn7mMRTTFc4FERKuYIyFOq2E-eqw>
    <xmx:-5KlZV8O6iaGGFVQ352rrsarpopTVEWvIJtE8_z7GpH_byhOocP9NA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 04AFCB6008D; Mon, 15 Jan 2024 15:18:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1374-gc37f3abe3d-fm-20240102.001-gc37f3abe
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8e138e54-22ba-43d3-898c-ab772039cd99@app.fastmail.com>
In-Reply-To: <682b50dc-a92a-4da5-ad06-631c5125ebc5@collabora.com>
References: 
 <e6d7768e2a257e0bd5948bcf168909b6c670851b.1705168605.git.lukas@wunner.de>
 <682b50dc-a92a-4da5-ad06-631c5125ebc5@collabora.com>
Date: Mon, 15 Jan 2024 21:17:41 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>,
 "Lukas Wunner" <lukas@wunner.de>, "Olof Johansson" <olof@lixom.net>,
 soc@kernel.org, devicetree@vger.kernel.org, linux-integrity@vger.kernel.org
Cc: "Yannic Moog" <Y.Moog@phytec.de>, "Alexander Bauer" <a.bauer@phytec.de>,
 upstream@lists.phytec.de, "Teresa Remmet" <T.Remmet@phytec.de>,
 "Tim Harvey" <tharvey@gateworks.com>, "Shawn Guo" <shawnguo@kernel.org>,
 "Sascha Hauer" <s.hauer@pengutronix.de>,
 "Pengutronix Kernel Team" <kernel@pengutronix.de>,
 "Fabio Estevam" <festevam@gmail.com>, "NXP Linux Team" <linux-imx@nxp.com>,
 "Adam Ford" <aford173@gmail.com>, "Heiko Thiery" <heiko.thiery@gmail.com>,
 "Enric Balletbo i Serra" <eballetbo@kernel.org>,
 "Matthias Brugger" <matthias.bgg@gmail.com>,
 "Hsin-Yi Wang" <hsinyi@chromium.org>, "Chen-Yu Tsai" <wenst@chromium.org>,
 =?UTF-8?Q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>,
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 "Rob Herring" <robh+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
 "Conor Dooley" <conor+dt@kernel.org>
Subject: Re: [PATCH] arm64: dts: Fix TPM schema violations
Content-Type: text/plain

On Mon, Jan 15, 2024, at 09:41, AngeloGioacchino Del Regno wrote:
> Il 13/01/24 19:06, Lukas Wunner ha scritto:
>> Since commit 26c9d152ebf3 ("dt-bindings: tpm: Consolidate TCG TIS
>> bindings"), several issues are reported by "make dtbs_check" for arm64
>> devicetrees:
>> 
>> The compatible property needs to contain the chip's name in addition to
>> the generic "tcg,tpm_tis-spi" and the nodename needs to be "tpm@0"
>> rather than "cr50@0":
>> 
>>    tpm@1: compatible: ['tcg,tpm_tis-spi'] is too short
>>          from schema $id: http://devicetree.org/schemas/tpm/tcg,tpm_tis-spi.yaml#
>> 
>>    cr50@0: $nodename:0: 'cr50@0' does not match '^tpm(@[0-9a-f]+)?$'
>>          from schema $id: http://devicetree.org/schemas/tpm/google,cr50.yaml#
>> 
>> Fix these schema violations.
>> 
>> phyGATE-Tauri uses an Infineon SLB9670:
>> https://lore.kernel.org/all/ab45c82485fa272f74adf560cbb58ee60cc42689.camel@phytec.de/
>> 
>> Gateworks Venice uses an Atmel ATTPM20P:
>> https://trac.gateworks.com/wiki/tpm
>> 
>> Signed-off-by: Lukas Wunner <lukas@wunner.de>
>
> For MediaTek:
> Reviewed-by: AngeloGioacchino Del Regno 
> <angelogioacchino.delregno@collabora.com>
>
> ...but I think you should split this per-SoC.
>
> Anyway, if Arnd wants to take this patch directly I'm also totally fine 
> with that.

I would prefer to apply the combined patches:
if you end up with a series of patches that all have
identical commit texts, it's better to combine them
as that gives a more readable git history.

However, I got some conflicts trying to apply them on
top of v6.7, so maybe check that and resend.

       Arnd

