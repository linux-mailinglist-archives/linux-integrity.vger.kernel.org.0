Return-Path: <linux-integrity+bounces-550-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F24E81A3AF
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Dec 2023 17:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE50728509B
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Dec 2023 16:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA6741741;
	Wed, 20 Dec 2023 16:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Km2+rwaW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE71E41235;
	Wed, 20 Dec 2023 16:04:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D8E4C433C7;
	Wed, 20 Dec 2023 16:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703088265;
	bh=Tw/CWv3wsBXLf5wTwYGu+AlsT1wG73VHXtrGfN8SJLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Km2+rwaW3W2h3jhOCBgER/1ZoVIYNZJvDpObmb8o5TebWwMef8flrUq4qjaKNXn/x
	 uvoOvxCYTD7xn+V57ZvrauMNuvLzRPqi0zNIw8qDgenUUgUFBYf1VxtVcnacuz7d0Q
	 GPlH6QSQbn0WHax1BVx7PAgUOxg76RKvl4zz08elVuOn6rlewYc0Wt5T3J36kWMXaP
	 sLfD0LwXkOUq0RMkhRjTRTo+ZVAhC0tztmSHs9gEeJ1xbCB6dy+DrDepgWWSCbipm0
	 sS5BcBlkBjyApmL4TM3g4QJVKu+Np4aE7+RAxZHStATnLiLV3CzhfZRv2OrSsV+ZRa
	 W2QGmzc2xhFtg==
Received: (nullmailer pid 296150 invoked by uid 1000);
	Wed, 20 Dec 2023 16:04:22 -0000
Date: Wed, 20 Dec 2023 10:04:22 -0600
From: Rob Herring <robh@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Jarkko Sakkinen <jarkko@kernel.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, devicetree@vger.kernel.org, linux-integrity@vger.kernel.org, Lino Sanfilippo <LinoSanfilippo@gmx.de>, Nayna Jain <nayna@linux.ibm.com>, Thirupathaiah Annapureddy <thiruan@microsoft.com>, Sasha Levin <sashal@kernel.org>, Andrey Pronin <apronin@chromium.org>, Alexander Steffen <Alexander.Steffen@infineon.com>, Johannes Holland <Johannes.Holland@infineon.com>, Amir Mizinski <amirmizi6@gmail.com>, Benoit HOUYERE <benoit.houyere@st.com>, Peter Delevoryas <peter@pjd.dev>, Ninad Palsule <ninad@linux.ibm.com>, Guenter Roeck <linux@roeck-us.net>, Francesco Dolcini <francesco@dolcini.it>, Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v3 0/4] dt-bindings: tpm: Clean all the things
Message-ID: <20231220160422.GA282877-robh@kernel.org>
References: <cover.1702806810.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1702806810.git.lukas@wunner.de>

On Sun, Dec 17, 2023 at 11:13:30AM +0100, Lukas Wunner wrote:
> TPM dt-bindings cleanup, take three.
> 
> The existing devicetrees in arch/arm and arch/arm64 contain a few
> violations of the schemas contained herein.  E.g. the nodename is
> not "tpm@..." but "tpmdev@..." in some cases.  I've got patches
> lined up to fix these issues and will submit them separately.
> 
> Changes v2 -> v3:
> * [PATCH 1/4]:
>   * Drop clock-frequency property from tcg,tpm-tis-i2c.yaml.
>     It doesn't exist at the peripheral level, only at the
>     controller level.  Document maximum clock frequency for
>     infineon,slb9635tt and infineon,slb9645tt in textual form
>     (as was previously done in trivial-devices.yaml).
>   * Document reset-gpios property as used by:
>     arch/arm64/boot/dts/freescale/imx8mp-beacon-kit.dts
> 
> * [PATCH 2/4]:
>   * Introduce new schema specifically for google,cr50 (Rob).
>     Note that I can't use "oneOf" for SPI and I²C properties
>     because a node with only a "reg" property is a valid SPI
>     and I²C node and would match both subschemas.
>     So "anyOf" it is.
> 
> * [PATCH 4/4]:
>   * Use "const" instead of "enum" for singleton compatible string.
> 
> Link to v2:
> https://lore.kernel.org/linux-devicetree/cover.1701093036.git.lukas@wunner.de/
> 
> 
> Lukas Wunner (4):
>   dt-bindings: tpm: Consolidate TCG TIS bindings
>   dt-bindings: tpm: Convert Google Cr50 bindings to DT schema
>   dt-bindings: tpm: Convert IBM vTPM bindings to DT schema
>   dt-bindings: tpm: Document Microsoft fTPM bindings

Reviewed-by: Rob Herring <robh@kernel.org>

Great to have this done finally! Thanks for picking it up. If the TPM 
maintainers don't pick it up for 6.8, I will.

Rob

