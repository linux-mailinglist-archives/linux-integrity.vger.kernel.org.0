Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D452487E67
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jan 2022 22:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiAGVnL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Jan 2022 16:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiAGVnK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Jan 2022 16:43:10 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05924C061574
        for <linux-integrity@vger.kernel.org>; Fri,  7 Jan 2022 13:43:09 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n5x0o-0008Qd-Hz; Fri, 07 Jan 2022 22:43:02 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n5x0n-0092Mc-MD; Fri, 07 Jan 2022 22:43:00 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n5x0m-0001p3-I7; Fri, 07 Jan 2022 22:43:00 +0100
Date:   Fri, 7 Jan 2022 22:42:57 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-spi@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        Peter Huewe <peterhuewe@gmx.de>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3] tpm: st33zp24: Make st33zp24_remove() a void function
Message-ID: <20220107214257.2v3ts5owkslpcyfz@pengutronix.de>
References: <20220104231103.227924-1-u.kleine-koenig@pengutronix.de>
 <YdgnuvGIq1DcLlJT@iki.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="amuswljdwla2qcca"
Content-Disposition: inline
In-Reply-To: <YdgnuvGIq1DcLlJT@iki.fi>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--amuswljdwla2qcca
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 07, 2022 at 01:44:58PM +0200, Jarkko Sakkinen wrote:
> On Wed, Jan 05, 2022 at 12:11:03AM +0100, Uwe Kleine-K=F6nig wrote:
> > Up to now st33zp24_remove() returns zero unconditionally. Make it return
> > no value instead which makes it easier to see in the callers that there=
 is
> > no error to handle.
> >=20
> > Also the return value of i2c and spi remove callbacks is ignored anyway.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> This patch does not improve functinality in any possible way, and neither
> does it fix any bug.

There is no bug, but getting rid of

	ret =3D st33zp24_remove(chip);
	if (ret)
		return ret;

in a function that shouldn't return a value !=3D 0 is a good thing. And
given that I want to do

	-static int st33zp24_spi_remove(struct spi_device *dev)
	+static void st33zp24_spi_remove(struct spi_device *dev)
	 {
	 	struct tpm_chip *chip =3D spi_get_drvdata(dev);

		st33zp24_remove(chip);
	-
	-	return 0
	 }

soon, this is much nicer than

	-static int st33zp24_spi_remove(struct spi_device *dev)
	+static void st33zp24_spi_remove(struct spi_device *dev)
	 {
	 	struct tpm_chip *chip =3D spi_get_drvdata(dev);
		int ret;

		ret =3D st33zp24_remove(chip);
		if (ret)
	-		return ret
	+		dev_err(&dev->dev, "Ignoring error ...\n");
	-
	-	return 0;
	 }

Now adding that st33zp24_remove always returns 0, I think this is really
a worthwhile change.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--amuswljdwla2qcca
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHYs94ACgkQwfwUeK3K
7Al+JggAhCXizJ/aWnARDazYkL6PqIta3/nBlthUgL2F57dfV+kBiLEJapa0q1I9
RFGLjTpApvs9OujJ+iCzhtShEcbIB1oW8voEfvxkQPiJWOOXQGNC0iMDegc22AXO
b9s1FtUvC7JY8YnpSitVdkfeXYm++cbCEN3w5xl8vZuoTI4No00c6+V2t+IW/4YO
KYlqUgM21XfihzPFBgt2Jaq6EuxqlTjcbEYWbx8KsqKmnT4bNMGRCkoltcvYnqQR
56OH/AKuR/LD0EtDnu3U8JmPoqXsG+FLeyT+MsA7MD9ZReDIyiPWE7zLIABqjoZy
34tqCu47O52TYbsSDeeDMNMkm7a/+Q==
=3jms
-----END PGP SIGNATURE-----

--amuswljdwla2qcca--
