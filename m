Return-Path: <linux-integrity+bounces-616-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B63AE822EF3
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jan 2024 14:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 758031C2344E
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jan 2024 13:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C0019BC0;
	Wed,  3 Jan 2024 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuIBZmDw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3957719BB0
	for <linux-integrity@vger.kernel.org>; Wed,  3 Jan 2024 13:54:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85109C433C7;
	Wed,  3 Jan 2024 13:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704290042;
	bh=PBKZyK5TEdvzGMFXmD317eHIrXY4Faya8UJyaTKMKGw=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=IuIBZmDw/FTRq+38bUOGYrRLCJMDyQIw+qpw0TxNpo3+dnZXs51MQQqxOy5yafcV8
	 lFAQpa5Qoq1y5BE8E2ETlUDW3yNjlUhT7Y5NGnYsq44fhXt9Qz39250sh0LEkCZiu5
	 YXc6tpMjO58oKGBB4y9i+c5kL/RQXL5s6zJ6bBo4N/PMNpICF3moEnjRvmvR1wl3aw
	 7nZ8lF2gTLeNG9s0H0qRTUtPS+i9CYq3CcHrFKS/4pi8IkPfwh38MNztDrwdzCV6bm
	 DeTTTHYsG0lCXmlrCstnWrQN95YbB+p04UnO2U92z1tnD9rCGsWl6Ym5LI4Ifz/lUq
	 MQNUi48hZs2Tg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Jan 2024 15:53:59 +0200
Message-Id: <CY54EBMTTLQ2.194Z8E1D2OZGF@suppilovahvero>
To: "Lukas Wunner" <lukas@wunner.de>, "Peter Huewe" <peterhuewe@gmx.de>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "Tim Harvey" <tharvey@gateworks.com>
Cc: <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH] tpm_tis_spi: Add compatible string atmel,attpm20p
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.15.2
References: <188b88ffeeae958847370dcd1fb28fe708a2aeb7.1703323863.git.lukas@wunner.de>
In-Reply-To: <188b88ffeeae958847370dcd1fb28fe708a2aeb7.1703323863.git.lukas@wunner.de>

On Sat Dec 23, 2023 at 11:34 AM EET, Lukas Wunner wrote:
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
> driver.
>
> For reference, a datasheet is available at:
> https://ww1.microchip.com/downloads/en/DeviceDoc/ATTPM20P-Trusted-Platfor=
m-Module-TPM-2.0-SPI-Interface-Summary-Data-Sheet-DS40002082A.pdf
>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Tim Harvey <tharvey@gateworks.com>
> ---
>  drivers/char/tpm/tpm_tis_spi_main.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_t=
is_spi_main.c
> index c5c3197ee29f..7d376a642807 100644
> --- a/drivers/char/tpm/tpm_tis_spi_main.c
> +++ b/drivers/char/tpm/tpm_tis_spi_main.c
> @@ -327,6 +327,7 @@ static const struct spi_device_id tpm_tis_spi_id[] =
=3D {
>  MODULE_DEVICE_TABLE(spi, tpm_tis_spi_id);
> =20
>  static const struct of_device_id of_tis_spi_match[] __maybe_unused =3D {
> +	{ .compatible =3D "atmel,attpm20p", .data =3D tpm_tis_spi_probe },
>  	{ .compatible =3D "st,st33htpm-spi", .data =3D tpm_tis_spi_probe },
>  	{ .compatible =3D "infineon,slb9670", .data =3D tpm_tis_spi_probe },
>  	{ .compatible =3D "tcg,tpm_tis-spi", .data =3D tpm_tis_spi_probe },

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@kernel.org>

BR, Jarkko

