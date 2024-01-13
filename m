Return-Path: <linux-integrity+bounces-773-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2498582CEDB
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Jan 2024 22:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEC981F22052
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Jan 2024 21:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E977016436;
	Sat, 13 Jan 2024 21:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fhz7AQMn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40A71642A;
	Sat, 13 Jan 2024 21:55:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA95C433C7;
	Sat, 13 Jan 2024 21:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705182901;
	bh=3Mgyn8tgABjgqcCRkhZbG3x9eEHC4OuPXrxLGYGGglM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fhz7AQMnGa8KjIGiPuSjduiGD+mwQtFpI5zz5m/QIvmoVEHu8OyTTWn9dnaKnJ9G7
	 3OcUTyQiapgnBXDTUtUZXsOGZJH44O3JOTid4vuVCG/CXO2K/zV/eYbv6bk0zPJWFS
	 0S127ncX0GzdsCoyi/2y2K2G71nAPZpcwI9owsK54FDsPa+4TFLEOOIr6IZYhc74wo
	 zd0EnvuOvlXEp5r5VhDzPq656CAcv41hKWydWpYl1zmmoiVK7Ir5c8/EHDbbtAH+uk
	 Fwln5lFBZVCI7zxrFIZtclxPb4mnTja2aBral/Uu5TMQx381+kxKvBQkmi6T0XTDXz
	 8/sgONXJFVNig==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 13 Jan 2024 23:54:57 +0200
Message-Id: <CYDWW0Z5CLLS.1XM7MBDWPLR39@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Lukas Wunner" <lukas@wunner.de>
Cc: <devicetree@vger.kernel.org>, <linux-integrity@vger.kernel.org>, "Peter
 Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>
Subject: Re: [PATCH v2 3/4] tpm_tis: Add compatible string atmel,at97sc3204
X-Mailer: aerc 0.16.0
References: <cover.1705140898.git.lukas@wunner.de>
 <805eb0868e047bde452144a51e48ce1bc2cac45b.1705140898.git.lukas@wunner.de>
In-Reply-To: <805eb0868e047bde452144a51e48ce1bc2cac45b.1705140898.git.lukas@wunner.de>

On Sat Jan 13, 2024 at 7:10 PM EET, Lukas Wunner wrote:
> Commit 420d439849ca ("tpm_tis: Allow tpm_tis to be bound using DT")
> added the fallback compatible "tcg,tpm-tis-mmio" to the TPM TIS driver,
> but not the chip-specific "atmel,at97sc3204".  However it did document
> it as a valid compatible string.
>
> Add it to tis_of_platform_match[] for consistency.
>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> ---
>  drivers/char/tpm/tpm_tis.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
> index 2c52b79..14652aa 100644
> --- a/drivers/char/tpm/tpm_tis.c
> +++ b/drivers/char/tpm/tpm_tis.c
> @@ -347,6 +347,7 @@ static void tpm_tis_plat_remove(struct platform_devic=
e *pdev)
> =20
>  #ifdef CONFIG_OF
>  static const struct of_device_id tis_of_platform_match[] =3D {
> +	{.compatible =3D "atmel,at97sc3204"},
>  	{.compatible =3D "tcg,tpm-tis-mmio"},
>  	{},
>  };

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

