Return-Path: <linux-integrity+bounces-57-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3346D7ED625
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Nov 2023 22:38:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1CF3280F0E
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Nov 2023 21:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A5B3C471;
	Wed, 15 Nov 2023 21:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vAYHeNK+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93E418657
	for <linux-integrity@vger.kernel.org>; Wed, 15 Nov 2023 21:37:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD8EC433C7;
	Wed, 15 Nov 2023 21:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700084278;
	bh=AmCgzmB7jjz+T45RrytzAofEx2AMRRYYB6hhglefLRg=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=vAYHeNK+27nLlK6csqDqimKGiMbHfw6gqr5RfG1F+2FyF2QETyLVwaii0D83vzB42
	 PtVQOhRSWwe1LhVH7u07nXv9W8GW4TF9LiqzLCIMSpupPxvJuKJCTG7MtdFaU2w0bH
	 CiTfFjX08v5IMmdM59s8dNC91keCn04H8Dj82yZNVDUuxAHKayzrhCkTdRQUvg7j7n
	 pZDkQxAugC/D4TZ8O77V/MRcvxLZTPVhILsYWZlmt/YwqZsmsprA4HaMGac1GulYKs
	 HDG6vPoCuSrsZm4gG3m7gXB7dW7Ow11Ck1iPLUoB0OYeu+WltkuYahWhTyX/EdfkBB
	 aOiCAPDdZM6tw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 15 Nov 2023 23:37:55 +0200
Message-Id: <CWZPKU58PWLS.1B1N297O1D9CY@kernel.org>
Cc: <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH] tpm: nuvoton: Use i2c_get_match_data()
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Rob Herring" <robh@kernel.org>, "Peter Huewe" <peterhuewe@gmx.de>,
 "Jason Gunthorpe" <jgg@ziepe.ca>
X-Mailer: aerc 0.15.2
References: <20231115210215.3743873-1-robh@kernel.org>
In-Reply-To: <20231115210215.3743873-1-robh@kernel.org>

On Wed Nov 15, 2023 at 11:02 PM EET, Rob Herring wrote:
> Use preferred i2c_get_match_data() instead of of_match_device() to
> get the driver match data. With this, adjust the includes to explicitly
> include the correct headers.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/char/tpm/tpm_i2c_nuvoton.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_i2c_nuvoton.c b/drivers/char/tpm/tpm_i2=
c_nuvoton.c
> index d7be03c41098..5490f7e0fa43 100644
> --- a/drivers/char/tpm/tpm_i2c_nuvoton.c
> +++ b/drivers/char/tpm/tpm_i2c_nuvoton.c
> @@ -19,7 +19,8 @@
>  #include <linux/interrupt.h>
>  #include <linux/wait.h>
>  #include <linux/i2c.h>
> -#include <linux/of_device.h>
> +#include <linux/of.h>
> +#include <linux/property.h>
>  #include "tpm.h"
> =20
>  /* I2C interface offsets */
> @@ -524,7 +525,6 @@ static int get_vid(struct i2c_client *client, u32 *re=
s)
> =20
>  static int i2c_nuvoton_probe(struct i2c_client *client)
>  {
> -	const struct i2c_device_id *id =3D i2c_client_get_device_id(client);
>  	int rc;
>  	struct tpm_chip *chip;
>  	struct device *dev =3D &client->dev;
> @@ -546,15 +546,8 @@ static int i2c_nuvoton_probe(struct i2c_client *clie=
nt)
>  	if (!priv)
>  		return -ENOMEM;
> =20
> -	if (dev->of_node) {
> -		const struct of_device_id *of_id;
> -
> -		of_id =3D of_match_device(dev->driver->of_match_table, dev);
> -		if (of_id && of_id->data =3D=3D OF_IS_TPM2)
> -			chip->flags |=3D TPM_CHIP_FLAG_TPM2;
> -	} else
> -		if (id->driver_data =3D=3D I2C_IS_TPM2)
> -			chip->flags |=3D TPM_CHIP_FLAG_TPM2;
> +	if (i2c_get_match_data(client))
> +		chip->flags |=3D TPM_CHIP_FLAG_TPM2;
> =20
>  	init_waitqueue_head(&priv->read_queue);
> =20

OK, apologies for having to do a resend. I'll pick this, thanks!

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

