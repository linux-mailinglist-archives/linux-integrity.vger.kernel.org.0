Return-Path: <linux-integrity+bounces-617-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A519822F00
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jan 2024 14:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 489B31F2462C
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Jan 2024 13:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435A219BD2;
	Wed,  3 Jan 2024 13:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSVmQcMS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A1C19BC0
	for <linux-integrity@vger.kernel.org>; Wed,  3 Jan 2024 13:57:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626D4C433C8;
	Wed,  3 Jan 2024 13:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704290223;
	bh=71d/ddA4v4iOxHJ9NGV6vKKB6gv1S41AOgej55V0gHQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=VSVmQcMSkfI7n3s2YGf4nzPg7T8LP9n3auQkTi4uPgFpnn5+zazIyt/23pbs9NAhW
	 xLWrtZgF4nmEJPTMa77F9LTawY6/AIaoZobE5Eqn8+zhzcwlqnwsAeUq8SRLRMNllO
	 3B5VTyHbk2iUmKryBVtH2heoZI4OKumCKmVFv4AhJugLZAQWsKkcAzAAHNyKMpQkdR
	 czRCr5BD2cqzK90xGxexgJpS4Z24CVnfQcI5Eo5Izff7VVMzxfmb9GqTHpvHPhFuSv
	 qMUsEH6UcBaHPBMQJ7gaSdGTE8Vb8W4NfyDuppOEjtnVriNGwipq17ne8DWqGqJmsa
	 FSHna6MKG7ZPQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Jan 2024 15:57:00 +0200
Message-Id: <CY54GMOIMYHU.3BTC0MFJZ4XAK@suppilovahvero>
Subject: Re: [PATCH] tpm_tis_spi: Add compatible string atmel,attpm20p
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Lukas Wunner" <lukas@wunner.de>,
 "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>, "Tim
 Harvey" <tharvey@gateworks.com>
Cc: <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.15.2
References: <188b88ffeeae958847370dcd1fb28fe708a2aeb7.1703323863.git.lukas@wunner.de> <CY54EBMTTLQ2.194Z8E1D2OZGF@suppilovahvero>
In-Reply-To: <CY54EBMTTLQ2.194Z8E1D2OZGF@suppilovahvero>

On Wed Jan 3, 2024 at 3:53 PM EET, Jarkko Sakkinen wrote:
> On Sat Dec 23, 2023 at 11:34 AM EET, Lukas Wunner wrote:
> > Commit 4f2a348aa365 ("arm64: dts: imx8mm-venice-gw73xx: add TPM device"=
)
> > added a devicetree node for the Trusted Platform Module on certain
> > Gateworks boards.
> >
> > The commit only used the generic "tcg,tpm_tis-spi" compatible string,
> > but public documentation shows that the chip is an ATTPM20P from Atmel
> > (nowadays Microchip):
> > https://trac.gateworks.com/wiki/tpm
> >
> > Add the chip to the supported compatible strings of the TPM TIS SPI
> > driver.
> >
> > For reference, a datasheet is available at:
> > https://ww1.microchip.com/downloads/en/DeviceDoc/ATTPM20P-Trusted-Platf=
orm-Module-TPM-2.0-SPI-Interface-Summary-Data-Sheet-DS40002082A.pdf
> >
> > Signed-off-by: Lukas Wunner <lukas@wunner.de>
> > Cc: Tim Harvey <tharvey@gateworks.com>
> > ---
> >  drivers/char/tpm/tpm_tis_spi_main.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm=
_tis_spi_main.c
> > index c5c3197ee29f..7d376a642807 100644
> > --- a/drivers/char/tpm/tpm_tis_spi_main.c
> > +++ b/drivers/char/tpm/tpm_tis_spi_main.c
> > @@ -327,6 +327,7 @@ static const struct spi_device_id tpm_tis_spi_id[] =
=3D {
> >  MODULE_DEVICE_TABLE(spi, tpm_tis_spi_id);
> > =20
> >  static const struct of_device_id of_tis_spi_match[] __maybe_unused =3D=
 {
> > +	{ .compatible =3D "atmel,attpm20p", .data =3D tpm_tis_spi_probe },
> >  	{ .compatible =3D "st,st33htpm-spi", .data =3D tpm_tis_spi_probe },
> >  	{ .compatible =3D "infineon,slb9670", .data =3D tpm_tis_spi_probe },
> >  	{ .compatible =3D "tcg,tpm_tis-spi", .data =3D tpm_tis_spi_probe },
>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@kernel.org>

Taking this back as checkpatch gives warning:

WARNING: DT compatible string "atmel,attpm20p" appears un-documented -- che=
ck ./Documentation/devicetree/bindings/
#36: FILE: drivers/char/tpm/tpm_tis_spi_main.c:330:
+	{ .compatible =3D "atmel,attpm20p", .data =3D tpm_tis_spi_probe },

BR, Jarkko

