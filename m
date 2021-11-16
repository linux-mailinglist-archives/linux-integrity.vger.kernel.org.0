Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0009445388E
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Nov 2021 18:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238833AbhKPRdm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Nov 2021 12:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238754AbhKPRdl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Nov 2021 12:33:41 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C0EC061570
        for <linux-integrity@vger.kernel.org>; Tue, 16 Nov 2021 09:30:43 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mn2I5-0001Kc-CH; Tue, 16 Nov 2021 18:30:41 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mn2I4-000KR5-S8; Tue, 16 Nov 2021 18:30:40 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mn2I3-0007nu-VC; Tue, 16 Nov 2021 18:30:39 +0100
Date:   Tue, 16 Nov 2021 18:30:39 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] char: tpm: cr50_i2c: Drop if with an always false
 condition
Message-ID: <20211116173039.ilnj7pag7solqprd@pengutronix.de>
References: <20211112225308.1149304-1-u.kleine-koenig@pengutronix.de>
 <0c7eb1e97e73e2cd3182a98d8cf76c6a2e2e6578.camel@kernel.org>
 <20211113215340.cn5kyia7g6fcquh2@pengutronix.de>
 <671cac28ac30a1135030261948487922cfcd4d89.camel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fzxzau4yxxdfia7b"
Content-Disposition: inline
In-Reply-To: <671cac28ac30a1135030261948487922cfcd4d89.camel@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--fzxzau4yxxdfia7b
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 16, 2021 at 05:55:35PM +0200, Jarkko Sakkinen wrote:
> On Sat, 2021-11-13 at 22:53 +0100, Uwe Kleine-K=F6nig wrote:
> > Hello,
> >=20
> > On Sat, Nov 13, 2021 at 12:53:32PM +0200, Jarkko Sakkinen wrote:
> > > On Fri, 2021-11-12 at 23:53 +0100, Uwe Kleine-K=F6nig wrote:
> > > > tpm_cr50_i2c_remove() is only called after tpm_cr50_i2c_probe() ret=
urned
> > > > successfully. As i2c_get_clientdata() returns driver data for the
> > > > client's device and this was set in tpmm_chip_alloc() it won't retu=
rn
> > > > NULL.
> > >=20
> > > This does not make the check obsolete, e.g. it would catch a programm=
ing
> > > error elsewhere.
> > >=20
> > > > Simplify accordingly to prepare changing the prototype of the i2c r=
emove
> > > > callback to return void. Notice that already today returning an err=
or
> > > > code from the remove callback doesn't prevent removal.
> > >=20
> > > I don't understand what you are trying to say.
> >=20
> > The eventual goal is the following change:
> >=20
> > diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> > index 16119ac1aa97..c7069ebf5a66 100644
> > --- a/include/linux/i2c.h
> > +++ b/include/linux/i2c.h
> > @@ -273,7 +273,7 @@ struct i2c_driver {
> > =A0
> > =A0=A0=A0=A0=A0=A0=A0=A0/* Standard driver model interfaces */
> > =A0=A0=A0=A0=A0=A0=A0=A0int (*probe)(struct i2c_client *client, const s=
truct i2c_device_id *id);
> > -=A0=A0=A0=A0=A0=A0=A0int (*remove)(struct i2c_client *client);
> > +=A0=A0=A0=A0=A0=A0=A0void (*remove)(struct i2c_client *client);
> > =A0
> > =A0=A0=A0=A0=A0=A0=A0=A0/* New driver model interface to aid the seamle=
ss removal of the
> > =A0=A0=A0=A0=A0=A0=A0=A0 * current probe()'s, more commonly unused than=
 used second parameter.
> >=20
> > To prepare that I want to change all remove callbacks to unconditionally
> > return 0.
> >=20
> > The motivation for the above change is that returning an error from an
> > i2c (or spi or platform) remove callback doesn't prevent the device from
> > being removed. So the ability to return an int leads to wrong
> > expectations by driver authors.
> >=20
> > The only effect a non-zero return code has, is an error message from the
> > i2c core. So if you object to my suggested change, the minimal change I
> > want to convince you of is to replace
> >=20
> > =A0=A0=A0=A0=A0=A0=A0=A0return -ENODEV;
> >=20
> > by
> >=20
> > =A0=A0=A0=A0=A0=A0=A0=A0return 0;
> >=20
> > .
>=20
> Please then include it to a patch set, where this happens.

My plan is to do all the preparation before submitting the change to
struct i2c_driver such that in the end coordination is only needed for a
single patch. (As this patch should be easy to review and without side
effects it should only drop "return 0;" (or replace them by "return;",
depending on context) to make this easy to review/verify.

Note that the suggested change has already a benefit today because in
the error case (and without the change) you get two error messages.
Returning 0 suppresses the generic (and so less useful) one.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--fzxzau4yxxdfia7b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGT6r0ACgkQwfwUeK3K
7AnnKAf+Nj1jDLpiytiMpNisT10hMJbJTgxPvElWnNFDkVy2xwIoQbI+59FNj8h5
TKyS1RT3dlA+Ne0PzdjIsKMe6zQATs2KW8mPCyJTQFLv7wH1FKFXHXsnm6uoWeJ8
Virh1BGmugnXbip6daBc8Sy0+tAKDeUhujn7iabE5F0hxUK7bDrF0BgLuHLdpw7U
2bCGJGaVnOriM43efFFjwMgIB9DHXPwiziK8/9osV9i6CXa10sxVE9hAGW8amaY5
xiIcWX6jXSSTjwF5II18yLgnOuN5gg8LvJ2bZiiI/emMXeD6iMDFzBkqCiSiBPmy
+4gSJ5UpQYugLAxJG30XKPoReHp6yA==
=x6+E
-----END PGP SIGNATURE-----

--fzxzau4yxxdfia7b--
