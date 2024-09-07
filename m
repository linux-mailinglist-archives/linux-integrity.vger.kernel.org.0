Return-Path: <linux-integrity+bounces-3495-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 975E59701EB
	for <lists+linux-integrity@lfdr.de>; Sat,  7 Sep 2024 13:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 556C82827F4
	for <lists+linux-integrity@lfdr.de>; Sat,  7 Sep 2024 11:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306641BC23;
	Sat,  7 Sep 2024 11:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJRHZImY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF80A55
	for <linux-integrity@vger.kernel.org>; Sat,  7 Sep 2024 11:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725708114; cv=none; b=aG3kdHHs85CikaZvl9YNW3vETa5mNOeurf7pGdf0q1ZBC9yVCIArR1W++H4J9mMCpg1ss5GCK0H7Ew4wgErI15U6ZBDIKHwvM+cGjbwsyVO425cmI4YyNYAVVEfCsawQqSsk3+d/1aFbrvNwhTfJhmCg7IYs7W5reaDZmbmvrGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725708114; c=relaxed/simple;
	bh=60suStfxL+kM5XhUX3F0+btputLsFpjZu6iwZFRShg0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=WIcLfj/9XenTLB48IoSzFtuzhmeojlaU8maz9C6QZwyxGTJFytAX0VezhL+Hnl9mBenwQ181LK08MjSthp+/G1ZzV4pHvsoj4k34mm5C/7kbiLSE3jMloOVnEviMnSOINHhHB2DVx/l8jzrL8dCz5fusrR2gXrqWgIDXhi/nuGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJRHZImY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B93C4CEC2;
	Sat,  7 Sep 2024 11:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725708113;
	bh=60suStfxL+kM5XhUX3F0+btputLsFpjZu6iwZFRShg0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=sJRHZImYsJG+vbSP4kilGJoqtTx23BZLIA2txyhMQesPzHi3Pxi3leLMxqoX83fE8
	 nhv9PpLsqqXxyjDK4gGn8SS3FRSvrKJxAPaP5v1U9CL9BogPADOFhu+LBqbCdV+wCR
	 NpBx+/cZotozD6jX0kQOht341VVDsyIr/l4qE1yy6RVz/j6h3PiL2r2P6+bge6z6LT
	 duuPJQAF6Q8oRoXSY+h8+9sVfDPxTdd22RILh4GAa8GjBCSwLcBlwnJfU+D4RvtL6d
	 d93jeld9K2+FEkfvuT0Ni7Roug3rs2wmBtgUtKfE5YQXomyMOrL9fSTFL/k5YQlHdk
	 kikiO65owZQXg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 07 Sep 2024 14:21:49 +0300
Message-Id: <D400GX0ZQ02G.35485EHQS4SG3@kernel.org>
Cc: "Jason Gunthorpe" <jgg@ziepe.ca>, "Nicolas Ferre"
 <nicolas.ferre@microchip.com>, "Alexandre Belloni"
 <alexandre.belloni@bootlin.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, =?utf-8?q?Ahelenia_Ziemia=C5=84ska?=
 <nabijaczleweli@nabijaczleweli.xyz>, <linux-integrity@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] tpm: Drop explicit initialization of struct
 i2c_device_id::driver_data to 0
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, "Peter
 Huewe" <peterhuewe@gmx.de>
X-Mailer: aerc 0.18.2
References: <20240906163325.321610-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20240906163325.321610-2-u.kleine-koenig@baylibre.com>

On Fri Sep 6, 2024 at 7:33 PM EEST, Uwe Kleine-K=C3=B6nig wrote:
> These drivers don't use the driver_data member of struct i2c_device_id,
> so don't explicitly initialize this member.
>
> This prepares putting driver_data in an anonymous union which requires
> either no initialization or named designators. But it's also a nice
> cleanup on its own.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

I think that works for me as a rationale.

> ---
>  drivers/char/tpm/st33zp24/i2c.c  | 2 +-
>  drivers/char/tpm/tpm_i2c_atmel.c | 2 +-
>  drivers/char/tpm/tpm_tis_i2c.c   | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/char/tpm/st33zp24/i2c.c b/drivers/char/tpm/st33zp24/=
i2c.c
> index 45ca33b3dcb2..81348487c125 100644
> --- a/drivers/char/tpm/st33zp24/i2c.c
> +++ b/drivers/char/tpm/st33zp24/i2c.c
> @@ -133,7 +133,7 @@ static void st33zp24_i2c_remove(struct i2c_client *cl=
ient)
>  }
> =20
>  static const struct i2c_device_id st33zp24_i2c_id[] =3D {
> -	{TPM_ST33_I2C, 0},
> +	{ TPM_ST33_I2C },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, st33zp24_i2c_id);
> diff --git a/drivers/char/tpm/tpm_i2c_atmel.c b/drivers/char/tpm/tpm_i2c_=
atmel.c
> index 301a95b3734f..d1d27fdfe523 100644
> --- a/drivers/char/tpm/tpm_i2c_atmel.c
> +++ b/drivers/char/tpm/tpm_i2c_atmel.c
> @@ -186,7 +186,7 @@ static void i2c_atmel_remove(struct i2c_client *clien=
t)
>  }
> =20
>  static const struct i2c_device_id i2c_atmel_id[] =3D {
> -	{I2C_DRIVER_NAME, 0},
> +	{ I2C_DRIVER_NAME },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, i2c_atmel_id);
> diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_i2=
c.c
> index 9511c0d50185..6cd07dd34507 100644
> --- a/drivers/char/tpm/tpm_tis_i2c.c
> +++ b/drivers/char/tpm/tpm_tis_i2c.c
> @@ -375,7 +375,7 @@ static void tpm_tis_i2c_remove(struct i2c_client *cli=
ent)
>  }
> =20
>  static const struct i2c_device_id tpm_tis_i2c_id[] =3D {
> -	{ "tpm_tis_i2c", 0 },
> +	{ "tpm_tis_i2c" },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(i2c, tpm_tis_i2c_id);
>
> base-commit: 9aaeb87ce1e966169a57f53a02ba05b30880ffb8

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

