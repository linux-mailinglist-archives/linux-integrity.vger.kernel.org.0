Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0AC44F297
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Nov 2021 11:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhKMK41 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 13 Nov 2021 05:56:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:45518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231735AbhKMK41 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 13 Nov 2021 05:56:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 946D060F36;
        Sat, 13 Nov 2021 10:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636800815;
        bh=mg2YX7954Pv721oe0cBvoSH5NJc9TPiXRttBENbQlaw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CT/ORTIYoJgeJO3iuz2lyn/+XS4nR6nqPorurMmaKcKAt498uglz4iUlA2cDh0F6W
         Sn06d5DNF+MDMoblch+PQMwvdWgfuaMbGO4zprTgv7L8bjaJWlLnb0/z5j8jN8kywS
         NtT3QahhFfSfLKCelpGwjMwIdCg/OH0Eg303AZngNFCnpItSalGfXjnBnWsqDU09oW
         tczUvpQMQR57w65b4raOGDPSBtDJjgm9gMGqfFSO2cFu1Z1KpQAulvyXhuXZoDDdCs
         QvUlGofGnJScvmFzxKl9TJxEDSyVR8wF6wW4n6WHDVqA1HGEOXuj6PLxC3UKRwhLjm
         8RpJuzXqZ4aqg==
Message-ID: <0c7eb1e97e73e2cd3182a98d8cf76c6a2e2e6578.camel@kernel.org>
Subject: Re: [PATCH] char: tpm: cr50_i2c: Drop if with an always false
 condition
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Peter Huewe <peterhuewe@gmx.de>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Date:   Sat, 13 Nov 2021 12:53:32 +0200
In-Reply-To: <20211112225308.1149304-1-u.kleine-koenig@pengutronix.de>
References: <20211112225308.1149304-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-11-12 at 23:53 +0100, Uwe Kleine-K=C3=B6nig wrote:
> tpm_cr50_i2c_remove() is only called after tpm_cr50_i2c_probe() returned
> successfully. As i2c_get_clientdata() returns driver data for the
> client's device and this was set in tpmm_chip_alloc() it won't return
> NULL.

This does not make the check obsolete, e.g. it would catch a programming
error elsewhere.

> Simplify accordingly to prepare changing the prototype of the i2c remove
> callback to return void. Notice that already today returning an error
> code from the remove callback doesn't prevent removal.

I don't understand what you are trying to say.

>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
> =C2=A0drivers/char/tpm/tpm_tis_i2c_cr50.c | 6 ------
> =C2=A01 file changed, 6 deletions(-)
>=20
> diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_t=
is_i2c_cr50.c
> index c89278103703..622cdf622ddc 100644
> --- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
> +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> @@ -751,12 +751,6 @@ static int tpm_cr50_i2c_probe(struct i2c_client *cli=
ent)
> =C2=A0static int tpm_cr50_i2c_remove(struct i2c_client *client)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct tpm_chip *chip =3D=
 i2c_get_clientdata(client);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct device *dev =3D &client=
->dev;
> -
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!chip) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0dev_err(dev, "Could not get client data at remove\n");
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return -ENODEV;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpm_chip_unregister(chip)=
;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tpm_cr50_release_locality=
(chip, true);


/Jarkko

