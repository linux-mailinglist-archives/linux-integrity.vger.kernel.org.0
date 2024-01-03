Return-Path: <linux-integrity+bounces-637-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDF5823695
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jan 2024 21:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BA2D1F25A49
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jan 2024 20:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C561805A;
	Wed,  3 Jan 2024 20:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3TkPtcu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A665A1D53F;
	Wed,  3 Jan 2024 20:31:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE2E5C433C7;
	Wed,  3 Jan 2024 20:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704313879;
	bh=0edWOR9VwaMq71a+PaUWlI9hzQ8QNgaM82GsM+T+mtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T3TkPtcuasUWc6CK/Og1R2OcrlIeG1v+Gsgp45g4P5NOtTrfTAuNd2JSpClykypDc
	 q+W3ER06OzIzF5w/pj3BFJeXJXgWBCg+soqgu1+7zhiGj5z3uP0bGEc7gyYQKiplei
	 DJCbKGxrvXhuY9/oMjEhBGX/g/9W7mv4GzyqsTMa7CHSOVkj2xprGAfYVwemVkM1bi
	 grcA9IoWfhKlcOeLkEPtufqdCdQraX87aurTRlEfdcoqw0iAILVAq7eTUG/xOiXfzr
	 j+95i5cTE6EolvdBxnyB9oxGMAZTJ/Cqb8zfIiVWEB+DiMoj4CdChSy7I8dyFH4bP4
	 pR9G9A0+cKDyQ==
Received: (nullmailer pid 1681500 invoked by uid 1000);
	Wed, 03 Jan 2024 20:31:11 -0000
Date: Wed, 3 Jan 2024 13:31:11 -0700
From: Rob Herring <robh@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Lino Sanfilippo <LinoSanfilippo@gmx.de>, linux-integrity@vger.kernel.org, Nishanth Menon <nm@ti.com>, Jason Gunthorpe <jgg@ziepe.ca>, Nayna Jain <nayna@linux.ibm.com>, Jarkko Sakkinen <jarkko@kernel.org>, Francesco Dolcini <francesco@dolcini.it>, Conor Dooley <conor+dt@kernel.org>, Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>, Ninad Palsule <ninad@linux.ibm.com>, Alexander Steffen <Alexander.Steffen@infineon.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Peter Delevoryas <peter@pjd.dev>, devicetree@vger.kernel.org, Andrey Pronin <apronin@chromium.org>, Sasha Levin <sashal@kernel.org>, Amir Mizinski <amirmizi6@gmail.com>, Johannes Holland <Johannes.Holland@infineon.com>, Peter Huewe <peterhuewe@gmx.de>, Thirupathaiah Annapureddy <thiruan@microsoft.com>, Benoit HOUYERE <benoit.houyere@st.com>
Subject: Re: [PATCH v3 0/4] dt-bindings: tpm: Clean all the things
Message-ID: <170431383883.1680828.10023555019997153392.robh@kernel.org>
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


On Sun, 17 Dec 2023 11:13:30 +0100, Lukas Wunner wrote:
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
> 
>  .../bindings/security/tpm/google,cr50.txt     |  19 ----
>  .../bindings/security/tpm/ibmvtpm.txt         |  41 -------
>  .../bindings/security/tpm/st33zp24-i2c.txt    |  34 ------
>  .../bindings/security/tpm/st33zp24-spi.txt    |  32 ------
>  .../bindings/security/tpm/tpm-i2c.txt         |  26 -----
>  .../bindings/security/tpm/tpm_tis_mmio.txt    |  25 -----
>  .../bindings/security/tpm/tpm_tis_spi.txt     |  23 ----
>  .../devicetree/bindings/tpm/google,cr50.yaml  |  65 +++++++++++
>  .../devicetree/bindings/tpm/ibm,vtpm.yaml     | 104 ++++++++++++++++++
>  .../bindings/tpm/microsoft,ftpm.yaml          |  47 ++++++++
>  .../bindings/tpm/tcg,tpm-tis-i2c.yaml         |  90 +++++++++++++++
>  .../bindings/tpm/tcg,tpm-tis-mmio.yaml        |  49 +++++++++
>  .../bindings/tpm/tcg,tpm_tis-spi.yaml         |  75 +++++++++++++
>  .../devicetree/bindings/tpm/tpm-common.yaml   |  87 +++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  16 ---
>  15 files changed, 517 insertions(+), 216 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/security/tpm/google,cr50.txt
>  delete mode 100644 Documentation/devicetree/bindings/security/tpm/ibmvtpm.txt
>  delete mode 100644 Documentation/devicetree/bindings/security/tpm/st33zp24-i2c.txt
>  delete mode 100644 Documentation/devicetree/bindings/security/tpm/st33zp24-spi.txt
>  delete mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-i2c.txt
>  delete mode 100644 Documentation/devicetree/bindings/security/tpm/tpm_tis_mmio.txt
>  delete mode 100644 Documentation/devicetree/bindings/security/tpm/tpm_tis_spi.txt
>  create mode 100644 Documentation/devicetree/bindings/tpm/google,cr50.yaml
>  create mode 100644 Documentation/devicetree/bindings/tpm/ibm,vtpm.yaml
>  create mode 100644 Documentation/devicetree/bindings/tpm/microsoft,ftpm.yaml
>  create mode 100644 Documentation/devicetree/bindings/tpm/tcg,tpm-tis-i2c.yaml
>  create mode 100644 Documentation/devicetree/bindings/tpm/tcg,tpm-tis-mmio.yaml
>  create mode 100644 Documentation/devicetree/bindings/tpm/tcg,tpm_tis-spi.yaml
>  create mode 100644 Documentation/devicetree/bindings/tpm/tpm-common.yaml
> 
> --
> 2.40.1
> 
> 

Applied, thanks!


