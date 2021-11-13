Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3C044F597
	for <lists+linux-integrity@lfdr.de>; Sat, 13 Nov 2021 22:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbhKMV4t (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 13 Nov 2021 16:56:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbhKMV4s (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 13 Nov 2021 16:56:48 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A29C061766
        for <linux-integrity@vger.kernel.org>; Sat, 13 Nov 2021 13:53:55 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mm0y6-0002BA-Bq; Sat, 13 Nov 2021 22:53:50 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mm0y5-000Cik-DU; Sat, 13 Nov 2021 22:53:48 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mm0y3-0007im-Ec; Sat, 13 Nov 2021 22:53:47 +0100
Date:   Sat, 13 Nov 2021 22:53:40 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] char: tpm: cr50_i2c: Drop if with an always false
 condition
Message-ID: <20211113215340.cn5kyia7g6fcquh2@pengutronix.de>
References: <20211112225308.1149304-1-u.kleine-koenig@pengutronix.de>
 <0c7eb1e97e73e2cd3182a98d8cf76c6a2e2e6578.camel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7bq6l2ndujozayro"
Content-Disposition: inline
In-Reply-To: <0c7eb1e97e73e2cd3182a98d8cf76c6a2e2e6578.camel@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--7bq6l2ndujozayro
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sat, Nov 13, 2021 at 12:53:32PM +0200, Jarkko Sakkinen wrote:
> On Fri, 2021-11-12 at 23:53 +0100, Uwe Kleine-K=F6nig wrote:
> > tpm_cr50_i2c_remove() is only called after tpm_cr50_i2c_probe() returned
> > successfully. As i2c_get_clientdata() returns driver data for the
> > client's device and this was set in tpmm_chip_alloc() it won't return
> > NULL.
>=20
> This does not make the check obsolete, e.g. it would catch a programming
> error elsewhere.
>=20
> > Simplify accordingly to prepare changing the prototype of the i2c remove
> > callback to return void. Notice that already today returning an error
> > code from the remove callback doesn't prevent removal.
>=20
> I don't understand what you are trying to say.

The eventual goal is the following change:

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 16119ac1aa97..c7069ebf5a66 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -273,7 +273,7 @@ struct i2c_driver {
=20
 	/* Standard driver model interfaces */
 	int (*probe)(struct i2c_client *client, const struct i2c_device_id *id);
-	int (*remove)(struct i2c_client *client);
+	void (*remove)(struct i2c_client *client);
=20
 	/* New driver model interface to aid the seamless removal of the
 	 * current probe()'s, more commonly unused than used second parameter.

To prepare that I want to change all remove callbacks to unconditionally
return 0.

The motivation for the above change is that returning an error from an
i2c (or spi or platform) remove callback doesn't prevent the device from
being removed. So the ability to return an int leads to wrong
expectations by driver authors.

The only effect a non-zero return code has, is an error message from the
i2c core. So if you object to my suggested change, the minimal change I
want to convince you of is to replace

	return -ENODEV;

by

	return 0;

=2E

Best regards
Uwe

> > diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm=
_tis_i2c_cr50.c
> > index c89278103703..622cdf622ddc 100644
> > --- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
> > +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> > @@ -751,12 +751,6 @@ static int tpm_cr50_i2c_probe(struct i2c_client *c=
lient)
> > =A0static int tpm_cr50_i2c_remove(struct i2c_client *client)
> > =A0{
> > =A0=A0=A0=A0=A0=A0=A0=A0struct tpm_chip *chip =3D i2c_get_clientdata(cl=
ient);
> > -=A0=A0=A0=A0=A0=A0=A0struct device *dev =3D &client->dev;
> > -
> > -=A0=A0=A0=A0=A0=A0=A0if (!chip) {
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0dev_err(dev, "Could not g=
et client data at remove\n");
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -ENODEV;
> > -=A0=A0=A0=A0=A0=A0=A0}
> > =A0
> > =A0=A0=A0=A0=A0=A0=A0=A0tpm_chip_unregister(chip);
> > =A0=A0=A0=A0=A0=A0=A0=A0tpm_cr50_release_locality(chip, true);

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7bq6l2ndujozayro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGQM+EACgkQwfwUeK3K
7Al2+gf/XeqeH1yzC564+pMKTPLyihLT6/NSsR1fwGAQlhMLHK0HkuK1LcxyGfnF
Up0v0fNJToE8YJzETvN+hL6YfBQC1cd7+BAvGxDb05wDn45pf2pVXNwo4gedyap6
iDjYpeQm30h3IH4wTMinceb0/ezUx622HnvQwEggOjdGCEESEqLL7WTYySVZyAVe
EgkyV5FTLh/z+Tqa8tcxeeVZFiesocJ9ASSsh02qOHoLxM66Z6wmq6D5BSqdLraN
Ux1k9v2C8z3poGOHvFZxGHvSGzVAhusZqN6JBlLOw3uNXutriQ8mG+auvapGH7Op
3yDBTXQlRochalDu5GOVAKlJ6jtn6g==
=mOBs
-----END PGP SIGNATURE-----

--7bq6l2ndujozayro--
