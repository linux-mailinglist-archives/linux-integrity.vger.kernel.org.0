Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BAF758623
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Jul 2023 22:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjGRUfK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Jul 2023 16:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGRUfJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Jul 2023 16:35:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD19BD
        for <linux-integrity@vger.kernel.org>; Tue, 18 Jul 2023 13:35:08 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLrPO-0008IY-At; Tue, 18 Jul 2023 22:34:58 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLrPJ-000S0O-Mn; Tue, 18 Jul 2023 22:34:53 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLrPI-005wAR-OG; Tue, 18 Jul 2023 22:34:52 +0200
Date:   Tue, 18 Jul 2023 22:34:49 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Peter Senna Tschudin <peter.senna@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        kernel@pengutronix.de, linux-integrity@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] tpm: Switch i2c drivers back to use .probe()
Message-ID: <20230718203449.dsnrbzcdsoogbqp2@pengutronix.de>
References: <20230525202424.630260-1-u.kleine-koenig@pengutronix.de>
 <CT8AVI0MBB8R.U6HPYA37GZTK@suppilovahvero>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qnxb4qgisxlixxr3"
Content-Disposition: inline
In-Reply-To: <CT8AVI0MBB8R.U6HPYA37GZTK@suppilovahvero>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--qnxb4qgisxlixxr3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Jun 09, 2023 at 08:36:40PM +0300, Jarkko Sakkinen wrote:
> On Thu May 25, 2023 at 11:24 PM EEST, Uwe Kleine-K=F6nig wrote:
> > After commit b8a1a4cd5a98 ("i2c: Provide a temporary .probe_new()
> > call-back type"), all drivers being converted to .probe_new() and then
> > 03c835f498b5 ("i2c: Switch .probe() to not take an id parameter")
> > convert back to (the new) .probe() to be able to eventually drop
> > .probe_new() from struct i2c_driver.
> >
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/char/tpm/st33zp24/i2c.c     | 2 +-
> >  drivers/char/tpm/tpm_i2c_atmel.c    | 2 +-
> >  drivers/char/tpm/tpm_i2c_infineon.c | 2 +-
> >  drivers/char/tpm/tpm_i2c_nuvoton.c  | 2 +-
> >  drivers/char/tpm/tpm_tis_i2c.c      | 2 +-
> >  drivers/char/tpm/tpm_tis_i2c_cr50.c | 2 +-
> >  6 files changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/char/tpm/st33zp24/i2c.c b/drivers/char/tpm/st33zp2=
4/i2c.c
> > index 2d28f55ef490..661574bb0acf 100644
> > --- a/drivers/char/tpm/st33zp24/i2c.c
> > +++ b/drivers/char/tpm/st33zp24/i2c.c
> > @@ -160,7 +160,7 @@ static struct i2c_driver st33zp24_i2c_driver =3D {
> >  		.of_match_table =3D of_match_ptr(of_st33zp24_i2c_match),
> >  		.acpi_match_table =3D ACPI_PTR(st33zp24_i2c_acpi_match),
> >  	},
> > -	.probe_new =3D st33zp24_i2c_probe,
> > +	.probe =3D st33zp24_i2c_probe,
> >  	.remove =3D st33zp24_i2c_remove,
> >  	.id_table =3D st33zp24_i2c_id
> >  };
> > diff --git a/drivers/char/tpm/tpm_i2c_atmel.c b/drivers/char/tpm/tpm_i2=
c_atmel.c
> > index 8f77154e0550..301a95b3734f 100644
> > --- a/drivers/char/tpm/tpm_i2c_atmel.c
> > +++ b/drivers/char/tpm/tpm_i2c_atmel.c
> > @@ -203,7 +203,7 @@ static SIMPLE_DEV_PM_OPS(i2c_atmel_pm_ops, tpm_pm_s=
uspend, tpm_pm_resume);
> > =20
> >  static struct i2c_driver i2c_atmel_driver =3D {
> >  	.id_table =3D i2c_atmel_id,
> > -	.probe_new =3D i2c_atmel_probe,
> > +	.probe =3D i2c_atmel_probe,
> >  	.remove =3D i2c_atmel_remove,
> >  	.driver =3D {
> >  		.name =3D I2C_DRIVER_NAME,
> > diff --git a/drivers/char/tpm/tpm_i2c_infineon.c b/drivers/char/tpm/tpm=
_i2c_infineon.c
> > index 7cdaff52a96d..81d8a78dc655 100644
> > --- a/drivers/char/tpm/tpm_i2c_infineon.c
> > +++ b/drivers/char/tpm/tpm_i2c_infineon.c
> > @@ -716,7 +716,7 @@ static void tpm_tis_i2c_remove(struct i2c_client *c=
lient)
> > =20
> >  static struct i2c_driver tpm_tis_i2c_driver =3D {
> >  	.id_table =3D tpm_tis_i2c_table,
> > -	.probe_new =3D tpm_tis_i2c_probe,
> > +	.probe =3D tpm_tis_i2c_probe,
> >  	.remove =3D tpm_tis_i2c_remove,
> >  	.driver =3D {
> >  		   .name =3D "tpm_i2c_infineon",
> > diff --git a/drivers/char/tpm/tpm_i2c_nuvoton.c b/drivers/char/tpm/tpm_=
i2c_nuvoton.c
> > index a026e98add50..d7be03c41098 100644
> > --- a/drivers/char/tpm/tpm_i2c_nuvoton.c
> > +++ b/drivers/char/tpm/tpm_i2c_nuvoton.c
> > @@ -650,7 +650,7 @@ static SIMPLE_DEV_PM_OPS(i2c_nuvoton_pm_ops, tpm_pm=
_suspend, tpm_pm_resume);
> > =20
> >  static struct i2c_driver i2c_nuvoton_driver =3D {
> >  	.id_table =3D i2c_nuvoton_id,
> > -	.probe_new =3D i2c_nuvoton_probe,
> > +	.probe =3D i2c_nuvoton_probe,
> >  	.remove =3D i2c_nuvoton_remove,
> >  	.driver =3D {
> >  		.name =3D "tpm_i2c_nuvoton",
> > diff --git a/drivers/char/tpm/tpm_tis_i2c.c b/drivers/char/tpm/tpm_tis_=
i2c.c
> > index c8c34adc14c0..11b4196b7136 100644
> > --- a/drivers/char/tpm/tpm_tis_i2c.c
> > +++ b/drivers/char/tpm/tpm_tis_i2c.c
> > @@ -379,7 +379,7 @@ static struct i2c_driver tpm_tis_i2c_driver =3D {
> >  		.pm =3D &tpm_tis_pm,
> >  		.of_match_table =3D of_match_ptr(of_tis_i2c_match),
> >  	},
> > -	.probe_new =3D tpm_tis_i2c_probe,
> > +	.probe =3D tpm_tis_i2c_probe,
> >  	.remove =3D tpm_tis_i2c_remove,
> >  	.id_table =3D tpm_tis_i2c_id,
> >  };
> > diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm=
_tis_i2c_cr50.c
> > index 376ae18a04eb..e70abd69e1ae 100644
> > --- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
> > +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> > @@ -779,7 +779,7 @@ static void tpm_cr50_i2c_remove(struct i2c_client *=
client)
> >  static SIMPLE_DEV_PM_OPS(cr50_i2c_pm, tpm_pm_suspend, tpm_pm_resume);
> > =20
> >  static struct i2c_driver cr50_i2c_driver =3D {
> > -	.probe_new =3D tpm_cr50_i2c_probe,
> > +	.probe =3D tpm_cr50_i2c_probe,
> >  	.remove =3D tpm_cr50_i2c_remove,
> >  	.driver =3D {
> >  		.name =3D "cr50_i2c",
> > --=20
> > 2.39.2
>=20
>=20
> Thanks, applied!

This was was in next up to next-20230717, it's not included in
next-20230718 any more. The branch pulled into next from=20

	git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git#next

changed from 0ec1b5bea32bce719ebdab253462f9c9cb0aca3e to
481c2d14627de8ecbb54dd125466e4b4a5069b47. This is a rebase to v6.5-rc2
dropping some more patches:

	$ git log --oneline 481c2d14627de8ecbb54dd125466e4b4a5069b47...0ec1b5bea32=
bce719ebdab253462f9c9cb0aca3e --cherry-pick --right-only
	5a29fb0d959a tpm: make all 'class' structures const
	17222dfebab1 tpm: remove redundant variable len
	dfd6ecc2066c tpm_tis: Resend command to recover from data transfer errors
	8458b36c647c tpm_tis: Use responseRetry to recover from data transfer erro=
rs
	a5dd583aa98b tpm_tis: Move CRC check to generic send routine
	126f3df1f03c tpm_tis: Explicitly check for error code
	dfba6d4ad558 tpm: Switch i2c drivers back to use .probe()
	bed72785706c tpm_tis-spi: Add hardware wait polling
	2afb9c102761 integrity: Enforce digitalSignature usage in the ima and evm =
keyrings
	0d8f1c250285 KEYS: DigitalSignature link restriction
	41e4e488742e KEYS: Replace all non-returning strlcpy with strscpy
	e2e51b64f0c8 security: keys: perform capable check only on privileged oper=
ations

These all apply just fine on top of next-20230718, so I wonder what made
you drop them. Can you please reapply at least dfba6d4ad558?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--qnxb4qgisxlixxr3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmS292gACgkQj4D7WH0S
/k40QAgAtK8ktJ6VtxT4jWnJXCK2uEJvbyNwG9WYNB1Qtwuf8HlptAGC6vFDWoL5
CNNXu6NXGxyNPIym6ibRQDfRJfgdMXW0fGDwfk6tNmEMDRr0goUn6QdhGWery2P3
IUAZOWWdRp4pwsdUmaw5XJgbQxZil6/CwvXv14OykZY9w+NhdG087uYcuKmjSXkR
PS1NHEm5nRDkr7E34m6DCr4uF4RvNeGAgYZw3l9AGfRgZTHx72qOdM9Cp6f1Glrx
OxBXYrdkYYPuMxY4/V287gCjkoFW9MsNG0Z0gcLHrz4zZCtKLQd73Is/hPJ4dC5h
anmT/sCNXxnD27STCpXSX+8+rLFV2A==
=0wMR
-----END PGP SIGNATURE-----

--qnxb4qgisxlixxr3--
