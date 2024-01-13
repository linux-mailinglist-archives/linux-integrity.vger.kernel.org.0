Return-Path: <linux-integrity+bounces-772-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E613082CEBE
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Jan 2024 22:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51DE72828D5
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Jan 2024 21:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8525107B3;
	Sat, 13 Jan 2024 21:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DoHfSWR9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C46310796;
	Sat, 13 Jan 2024 21:17:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69C3C433C7;
	Sat, 13 Jan 2024 21:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705180663;
	bh=I7L2tY/u1kcRobIAAH7Fuhqt/+nLfFxHiF5sF+6hy+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DoHfSWR926G+9ZEsdoCBM5+bL2aMDSBepvmfI//XiyHGLxq5FG4tci4GuL0Xqq5qC
	 e5/GwREc1fEnYEW9afhWPSBofLSVGAlL4Qa3QCQ74pUQH/uS9K+cPFgTomTXlqJ5NZ
	 6O3rdVjmx6G+6FPkc0ygv5RQgHAx8DMH206OI07kgDz+emGV780+DG8qGN6QVf01Qu
	 YpR2Wo5k+N8F4mL3XJKsv3d1Bg3h3/B5lRd6qpaNhOE4hhIH6oBJ+dDXMt31m8+PhH
	 iwb8W8oURn6WFqrNGTnUYXFRwNUzqbweGOqD43/+7eGSdbqN+4N1jb+kjhoHbfS7qK
	 hId8TsazJ1WxQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 13 Jan 2024 23:17:39 +0200
Message-Id: <CYDW3GS1VGP4.2PUT4XW283L99@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Lukas Wunner" <lukas@wunner.de>, "Rob Herring" <robh@kernel.org>
Cc: <devicetree@vger.kernel.org>, <linux-integrity@vger.kernel.org>, "Peter
 Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>
Subject: Re: [PATCH v2 1/4] dt-bindings: tpm: Add compatible string
 atmel,attpm20p
X-Mailer: aerc 0.16.0
References: <cover.1705140898.git.lukas@wunner.de>
 <8886271d52025065eddf5915bb7778ab14362255.1705140898.git.lukas@wunner.de>
In-Reply-To: <8886271d52025065eddf5915bb7778ab14362255.1705140898.git.lukas@wunner.de>

On Sat Jan 13, 2024 at 7:10 PM EET, Lukas Wunner wrote:
> Commit 4f2a348aa365 ("arm64: dts: imx8mm-venice-gw73xx: add TPM device")
> added a devicetree node for the Trusted Platform Module on certain
> Gateworks boards.
>
> The commit only used the generic "tcg,tpm_tis-spi" compatible string,
> but public documentation shows that the chip is an ATTPM20P from Atmel
> (nowadays Microchip):
> https://trac.gateworks.com/wiki/tpm
>
> Add the chip to the supported compatible strings of the TPM TIS SPI
> schema.
>
> For reference, a datasheet is available at:
> https://ww1.microchip.com/downloads/en/DeviceDoc/ATTPM20P-Trusted-Platfor=
m-Module-TPM-2.0-SPI-Interface-Summary-Data-Sheet-DS40002082A.pdf
>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Tim Harvey <tharvey@gateworks.com>
> ---
>  Documentation/devicetree/bindings/tpm/tcg,tpm_tis-spi.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/tpm/tcg,tpm_tis-spi.yaml b=
/Documentation/devicetree/bindings/tpm/tcg,tpm_tis-spi.yaml
> index c3413b4..6cb2de7 100644
> --- a/Documentation/devicetree/bindings/tpm/tcg,tpm_tis-spi.yaml
> +++ b/Documentation/devicetree/bindings/tpm/tcg,tpm_tis-spi.yaml
> @@ -20,6 +20,7 @@ properties:
>    compatible:
>      items:
>        - enum:
> +          - atmel,attpm20p
>            - infineon,slb9670
>            - st,st33htpm-spi
>            - st,st33zp24-spi

You should to send the patch set with Rob Herring as CC for syncing
up. Please do it for future versions, if there is need for additional
versions.

Rob, 3 out of 4 patches are TPM patches. Do you mind if I take all
four patches once the patch set is ready or do you want to pick this
patch (assuming that you think it is correctly implemented ofc)?

BR, Jarkko

