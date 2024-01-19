Return-Path: <linux-integrity+bounces-838-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44207833047
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jan 2024 22:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1C0228648D
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jan 2024 21:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6FE5813B;
	Fri, 19 Jan 2024 21:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNYAMaJl"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EB757888;
	Fri, 19 Jan 2024 21:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705699777; cv=none; b=lK1j1nvlZqXgEi2CXcKF3OGWANRKE2MwI31Tdf+PecyO13IrqB4bAShbScbADAo28p78SYPMZFw4ApmVlp3rBRE+xFzFh0ofckAIwWPJqFopGwtxEtzW8IA/vY7WIkWWH0YYdFw3VIy+esx459bBY07hoLB4idrKxTedHwcCkKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705699777; c=relaxed/simple;
	bh=YikW7lhYlahvCq9SPWKKoDVb1qi/8r2rATHPjPXCZAQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=jaARc2BgTOWyW3SiGDLrx0hAKoRMI1/ZPW0elzEwMv2cA3A9qmhM0MSRSVs4IO7miP4F0ivybhXd8mnABQ4I0dnEdTdr6kNs7KRxAhqtVR0GzBIZoFiO87HKb947W6pHVlkpIJvN54k6NlNmHQKcP2Mw30N9hyg5uUOsV43UffU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNYAMaJl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8B0C433F1;
	Fri, 19 Jan 2024 21:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705699777;
	bh=YikW7lhYlahvCq9SPWKKoDVb1qi/8r2rATHPjPXCZAQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=fNYAMaJl87g8brAWEF9ciyIBUcHtvs+vNA4qzwim3dguV/orb/OBUZp00U7SoCxUS
	 Gq/JFsR2adfGHwGVFweokxA4BS5crfs5qNXwDXMm6bG4hp58xZ1w7IFTdb0ilGt09s
	 cnnYoRngpfscpVBQBkxLyWPDEmH6HFzvZl4izchJCwb0U0YaJgGRiRTGhcfHWw6pGs
	 dLBIC9JuTsbZM0AUWoXAAPoPLgcl3w6ML8EAT/dbNNPVe0DdYVSTl3GfX6U7koc2Pn
	 3FxZN4zDq+yPMRGZMBvxERLaU1+Wcr9Q8CiVjplLfXFN5W9uHyrx/+3wLPYdwCqMv7
	 wTOMS0htw5nZQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Jan 2024 21:29:33 +0000
Message-Id: <CYJ03UKAG12Z.1BIINI4G2A47G@seitikki>
Cc: <linux-spi@vger.kernel.org>, <kernel@pengutronix.de>, "Peter Huewe"
 <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH 27/33] tpm_tis_spi: Follow renaming of SPI "master" to
 "controller"
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 "Mark Brown" <broonie@kernel.org>, "Geert Uytterhoeven"
 <geert+renesas@glider.be>
X-Mailer: aerc 0.15.2
References: <cover.1705348269.git.u.kleine-koenig@pengutronix.de>
 <31f11901f6329a1de0299903d43c16439948bd46.1705348270.git.u.kleine-koenig@pengutronix.de>
In-Reply-To: <31f11901f6329a1de0299903d43c16439948bd46.1705348270.git.u.kleine-koenig@pengutronix.de>

On Mon Jan 15, 2024 at 8:13 PM UTC, Uwe Kleine-K=C3=B6nig wrote:
> In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
> some functions and struct members were renamed. To not break all drivers
> compatibility macros were provided.
>
> To be able to remove these compatibility macros push the renaming into
> this driver.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/char/tpm/tpm_tis_spi_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_t=
is_spi_main.c
> index c5c3197ee29f..c647de7b3709 100644
> --- a/drivers/char/tpm/tpm_tis_spi_main.c
> +++ b/drivers/char/tpm/tpm_tis_spi_main.c
> @@ -146,7 +146,7 @@ static int tpm_tis_spi_transfer_full(struct tpm_tis_d=
ata *data, u32 addr,
>  	struct spi_transfer spi_xfer;
>  	u8 transfer_len;
> =20
> -	spi_bus_lock(phy->spi_device->master);
> +	spi_bus_lock(phy->spi_device->controller);
> =20
>  	while (len) {
>  		transfer_len =3D min_t(u16, len, MAX_SPI_FRAMESIZE);
> @@ -210,7 +210,7 @@ static int tpm_tis_spi_transfer_full(struct tpm_tis_d=
ata *data, u32 addr,
>  		spi_sync_locked(phy->spi_device, &m);
>  	}
> =20
> -	spi_bus_unlock(phy->spi_device->master);
> +	spi_bus_unlock(phy->spi_device->controller);
>  	return ret;
>  }
> =20


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

