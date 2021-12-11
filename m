Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23FA747119A
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Dec 2021 06:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbhLKFJu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 11 Dec 2021 00:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhLKFJt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 11 Dec 2021 00:09:49 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A303CC061714;
        Fri, 10 Dec 2021 21:06:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 96197CE2BB6;
        Sat, 11 Dec 2021 05:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41984C004DD;
        Sat, 11 Dec 2021 05:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639199169;
        bh=5LQRaJvTEC5+N58Bwnrobrcf8rrZm/ZrofvhCuxPv+M=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ej7OWVUyCpJCW8QuGF5RGnZk/HwUjGnaYxdrkXmdgmc3JO6wyY3OjFRVGdP7PdbJL
         X8D8NUTs4kGWG3wkQSke/90rdFxXsVarIV5s2nmOsYMfrVY/XYrzz+D8Ue1mRvV9lz
         vr+YYVndoXsY4F5b69c0q2ZU4ABkWin51x+Kx3yyxAafR8xG+MnB2x5Ft0stoVdC1s
         N6GwUxWuSqRNmHSyjdV3SfkI4n5KJh5fUxMMm/b6rae5PnjwofBiGRJcbKr2X77v6L
         hqxBSX8bFzqEX91q0TRD7VSSU5ZNhrh0mf/eIyEB51FC8yGdrnR44p7Bqdw4bJhxSh
         SjOc7UQvFgSjQ==
Message-ID: <d0dbaa48d39079322826bc5e5783db635bf6dc03.camel@kernel.org>
Subject: Re: [PATCH v3] char: tpm: cr50: Set TPM_FIRMWARE_POWER_MANAGED
 based on device property
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Rob Barnes <robbarnes@google.com>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 11 Dec 2021 07:06:05 +0200
In-Reply-To: <20211206120311.2844838-1-robbarnes@google.com>
References: <Yaut12SfSYPGcs6S@iki.fi>
         <20211206120311.2844838-1-robbarnes@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-12-06 at 12:03 +0000, Rob Barnes wrote:
> Set TPM_FIRMWARE_POWER_MANAGED flag based on 'firmware-power-managed'
> ACPI DSD property. For the CR50 TPM, this flag defaults to true when
> the property is unset.
>=20
> When this flag is set to false, the CR50 TPM driver will always send
> a shutdown command whenever the system suspends.
>=20
> Signed-off-by: Rob Barnes <robbarnes@google.com>
> ---
>  drivers/char/tpm/tpm_tis_i2c_cr50.c | 16 +++++++++++++++-
>  drivers/char/tpm/tpm_tis_spi_cr50.c | 16 +++++++++++++++-
>  2 files changed, 30 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_t=
is_i2c_cr50.c
> index c89278103703..f6c0affbb456 100644
> --- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
> +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> @@ -628,6 +628,19 @@ static bool tpm_cr50_i2c_req_canceled(struct tpm_chi=
p *chip, u8 status)
>  	return status =3D=3D TPM_STS_COMMAND_READY;
>  }
> =20
> +static bool tpm_cr50_i2c_is_firmware_power_managed(struct device *dev)
> +{
> +	u8 val;
> +	int ret;
> +
> +	/* This flag should default true when the device property is not presen=
t */
> +	ret =3D device_property_read_u8(dev, "firmware-power-managed", &val);
> +	if (ret)
> +		return true;
> +
> +	return val;
> +}
> +
>  static const struct tpm_class_ops cr50_i2c =3D {
>  	.flags =3D TPM_OPS_AUTO_STARTUP,
>  	.status =3D &tpm_cr50_i2c_tis_status,
> @@ -686,7 +699,8 @@ static int tpm_cr50_i2c_probe(struct i2c_client *clie=
nt)
> =20
>  	/* cr50 is a TPM 2.0 chip */
>  	chip->flags |=3D TPM_CHIP_FLAG_TPM2;
> -	chip->flags |=3D TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED;
> +	if (tpm_cr50_i2c_is_firmware_power_managed(dev))
> +		chip->flags |=3D TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED;
> =20
>  	/* Default timeouts */
>  	chip->timeout_a =3D msecs_to_jiffies(TIS_SHORT_TIMEOUT);
> diff --git a/drivers/char/tpm/tpm_tis_spi_cr50.c b/drivers/char/tpm/tpm_t=
is_spi_cr50.c
> index dae98dbeeeac..7bf123d3c537 100644
> --- a/drivers/char/tpm/tpm_tis_spi_cr50.c
> +++ b/drivers/char/tpm/tpm_tis_spi_cr50.c
> @@ -185,6 +185,19 @@ static int cr50_spi_flow_control(struct tpm_tis_spi_=
phy *phy,
>  	return 0;
>  }
> =20
> +static bool tpm_cr50_spi_is_firmware_power_managed(struct device *dev)
> +{
> +	u8 val;
> +	int ret;
> +
> +	/* This flag should default true when the device property is not presen=
t */
> +	ret =3D device_property_read_u8(dev, "firmware-power-managed", &val);
> +	if (ret)
> +		return true;
> +
> +	return val;
> +}
> +
>  static int tpm_tis_spi_cr50_transfer(struct tpm_tis_data *data, u32 addr=
, u16 len,
>  				     u8 *in, const u8 *out)
>  {
> @@ -309,7 +322,8 @@ int cr50_spi_probe(struct spi_device *spi)
>  	cr50_print_fw_version(&phy->priv);
> =20
>  	chip =3D dev_get_drvdata(&spi->dev);
> -	chip->flags |=3D TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED;
> +	if (tpm_cr50_spi_is_firmware_power_managed(&spi->dev))
> +		chip->flags |=3D TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED;
> =20
>  	return 0;
>  }

Thank you.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

I applied this to my tree, and it should be visible in linux-next soon.

/Jarkko
