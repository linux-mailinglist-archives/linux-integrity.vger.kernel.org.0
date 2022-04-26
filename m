Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3322E50F35A
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Apr 2022 10:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344529AbiDZIJa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 Apr 2022 04:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344532AbiDZIJ3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Apr 2022 04:09:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C806D43ECA
        for <linux-integrity@vger.kernel.org>; Tue, 26 Apr 2022 01:06:17 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1njGD7-0001eO-RG; Tue, 26 Apr 2022 10:06:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1njGD8-005Iqr-7Z; Tue, 26 Apr 2022 10:06:12 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1njGD5-005h3m-Kg; Tue, 26 Apr 2022 10:06:11 +0200
Date:   Tue, 26 Apr 2022 10:06:02 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>,
        linux-integrity@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] char: tpm: cr50_i2c: Suppress duplicated error message in
 .remove()
Message-ID: <20220426080602.wdquj6ra3vhufur4@pengutronix.de>
References: <20211112225308.1149304-1-u.kleine-koenig@pengutronix.de>
 <0c7eb1e97e73e2cd3182a98d8cf76c6a2e2e6578.camel@kernel.org>
 <20211113215340.cn5kyia7g6fcquh2@pengutronix.de>
 <671cac28ac30a1135030261948487922cfcd4d89.camel@kernel.org>
 <20211116173039.ilnj7pag7solqprd@pengutronix.de>
 <20220331132231.h2hbtxthcqsdxmil@pengutronix.de>
 <20220425191132.nm66acqichx4fmel@pengutronix.de>
 <cf3df097d436c9b54c710401783667b56931b9b8.camel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c7bx4gmgrq3zcrtl"
Content-Disposition: inline
In-Reply-To: <cf3df097d436c9b54c710401783667b56931b9b8.camel@kernel.org>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--c7bx4gmgrq3zcrtl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Returning an error value in an i2c remove callback results in an error
message being emitted by the i2c core, but otherwise it doesn't make a
difference. The device goes away anyhow and the devm cleanups are
called.

As tpm_cr50_i2c_remove() emits an error message already and the
additional error message by the i2c core doesn't add any useful
information, change the return value to zero to suppress this error
message.

Note that if i2c_clientdata is NULL, there is something really fishy.
Assuming no memory corruption happened (then all bets are lost anyhow),
tpm_cr50_i2c_remove() is only called after tpm_cr50_i2c_probe() returned
successfully. So there was a tpm chip registered before and after
tpm_cr50_i2c_remove() its privdata is freed but the associated character
device isn't removed. If after that happened userspace accesses the
character device it's likely that the freed memory is accessed. For that
reason the warning message is made a bit more frightening.

Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
---

On Tue, Apr 26, 2022 at 07:35:29AM +0300, Jarkko Sakkinen wrote:
> On Mon, 2022-04-25 at 21:11 +0200, Uwe Kleine-K=F6nig wrote:
> > Hello,
> >=20
> > On Thu, Mar 31, 2022 at 03:22:31PM +0200, Uwe Kleine-K=F6nig wrote:
> > > On Tue, Nov 16, 2021 at 06:30:39PM +0100, Uwe Kleine-K=F6nig wrote:
> > > > On Tue, Nov 16, 2021 at 05:55:35PM +0200, Jarkko Sakkinen wrote:
> > > > > On Sat, 2021-11-13 at 22:53 +0100, Uwe Kleine-K=F6nig wrote:
> > > > > > Hello,
> > > > > >=20
> > > > > > On Sat, Nov 13, 2021 at 12:53:32PM +0200, Jarkko Sakkinen wrote:
> > > > > > > On Fri, 2021-11-12 at 23:53 +0100, Uwe Kleine-K=F6nig wrote:
> > > > > > > > tpm_cr50_i2c_remove() is only called after tpm_cr50_i2c_pro=
be() returned
> > > > > > > > successfully. As i2c_get_clientdata() returns driver data f=
or the
> > > > > > > > client's device and this was set in tpmm_chip_alloc() it wo=
n't return
> > > > > > > > NULL.
> > > > > > >=20
> > > > > > > This does not make the check obsolete, e.g. it would catch a =
programming
> > > > > > > error elsewhere.
> > > > > > >=20
> > > > > > > > Simplify accordingly to prepare changing the prototype of t=
he i2c remove
> > > > > > > > callback to return void. Notice that already today returnin=
g an error
> > > > > > > > code from the remove callback doesn't prevent removal.
> > > > > > >=20
> > > > > > > I don't understand what you are trying to say.
> > > > > >=20
> > > > > > The eventual goal is the following change:
> > > > > >=20
> > > > > > diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> > > > > > index 16119ac1aa97..c7069ebf5a66 100644
> > > > > > --- a/include/linux/i2c.h
> > > > > > +++ b/include/linux/i2c.h
> > > > > > @@ -273,7 +273,7 @@ struct i2c_driver {
> > > > > > =A0
> > > > > > =A0=A0=A0=A0=A0=A0=A0=A0/* Standard driver model interfaces */
> > > > > > =A0=A0=A0=A0=A0=A0=A0=A0int (*probe)(struct i2c_client *client,=
 const struct i2c_device_id *id);
> > > > > > -=A0=A0=A0=A0=A0=A0=A0int (*remove)(struct i2c_client *client);
> > > > > > +=A0=A0=A0=A0=A0=A0=A0void (*remove)(struct i2c_client *client);
> > > > > > =A0
> > > > > > =A0=A0=A0=A0=A0=A0=A0=A0/* New driver model interface to aid th=
e seamless removal of the
> > > > > > =A0=A0=A0=A0=A0=A0=A0=A0 * current probe()'s, more commonly unu=
sed than used second parameter.
> > > > > >=20
> > > > > > To prepare that I want to change all remove callbacks to uncond=
itionally
> > > > > > return 0.
> > > > > >=20
> > > > > > The motivation for the above change is that returning an error =
=66rom an
> > > > > > i2c (or spi or platform) remove callback doesn't prevent the de=
vice from
> > > > > > being removed. So the ability to return an int leads to wrong
> > > > > > expectations by driver authors.
> > > > > >=20
> > > > > > The only effect a non-zero return code has, is an error message=
 from the
> > > > > > i2c core. So if you object to my suggested change, the minimal =
change I
> > > > > > want to convince you of is to replace
> > > > > >=20
> > > > > > =A0=A0=A0=A0=A0=A0=A0=A0return -ENODEV;
> > > > > >=20
> > > > > > by
> > > > > >=20
> > > > > > =A0=A0=A0=A0=A0=A0=A0=A0return 0;
> > > > > >=20
> > > > > > .
> > > > >=20
> > > > > Please then include it to a patch set, where this happens.
> > > >=20
> > > > My plan is to do all the preparation before submitting the change to
> > > > struct i2c_driver such that in the end coordination is only needed =
for a
> > > > single patch. (As this patch should be easy to review and without s=
ide
> > > > effects it should only drop "return 0;" (or replace them by "return=
;",
> > > > depending on context) to make this easy to review/verify.
> > > >=20
> > > > Note that the suggested change has already a benefit today because =
in
> > > > the error case (and without the change) you get two error messages.
> > > > Returning 0 suppresses the generic (and so less useful) one.
>=20
> Even if chip is expected not to be NULL, a sanity check costs nothing.
> As already said, this should be reviewed in the context of the callback
> change.

I don't agree. This callback change is a very big change affecting most
i2c drivers. A quick heuristic: This affects more than 1200 drivers:

	$ git grep 'static struct i2c_driver' | wc -l
	1227

If such a patch contains hunks like:

		if (!chip) {
			dev_err(dev, "Could not get client data at remove\n");
	-		return -ENODEV;
	+		return;
		}

this makes the review process needlessly complicated and the change
isn't a noop. So in my eyes changing the return value to zero should be
done in a patch before the callback change.

There is no win on delaying the tpm_tis_i2c_cr50 change as a) there is a
benefit already today (no duplicated error message) and b) keeping this
patch in a series together with the callback patch (and maybe even more
similar patches) results in an effort to keep it updated and the need
for coordination before the callback patch goes in. Also if such a
driver specific patch results in a discussion as this one, this delays
the callback change and then there is a real chance that the callback
change needs to be rebased and reverified.

So this is the chance to apply this patch without timing pressure via
its normal maintainer tree.

As you insist on keeping the if block, here comes a patch suggestion
that allows me to not having to care for a driver specific patch in the
quest to change the i2c remove callback and still keep the "sanity"
check.

Best regards
Uwe

 drivers/char/tpm/tpm_tis_i2c_cr50.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_tis=
_i2c_cr50.c
index f6c0affbb456..bf608b6af339 100644
--- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
+++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
@@ -768,8 +768,8 @@ static int tpm_cr50_i2c_remove(struct i2c_client *clien=
t)
 	struct device *dev =3D &client->dev;
=20
 	if (!chip) {
-		dev_err(dev, "Could not get client data at remove\n");
-		return -ENODEV;
+		dev_crit(dev, "Could not get client data at remove, memory corruption ah=
ead\n");
+		return 0;
 	}
=20
 	tpm_chip_unregister(chip);
--=20
2.35.1

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--c7bx4gmgrq3zcrtl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmJnp+cACgkQwfwUeK3K
7AnSFggAjYl5GGtlaIDIcVyZlVAQchMriL8eLk26ZeYhMFX5uK4/LwY+Zc13vez3
vkWRb4uSeh21vVflkdZT19FY+FuDOf8yjXQinDxe7j5EXMp6x9oiCy3r/8U8Q540
PPnyNvXcTBkM9sin+msQfTRrYAsjiDGuSvF1i9qXt1JzYCpnzy8J5rZm0f1QaFFu
Vs0Mlb/nXDmYMkvTtO+XbOq5QgWUFqu4ZiVLZEk58qZsWZA3cymIPzyJLTV1ubdC
DpM8LxLK3veN96eGEZqwNZoZVu5SOnkgXdndO2gK0KvyyDNuUhbzYcSFxs6DfmaL
Y+mvJ1+0OLR/KPtQwq9wn4RhYYceXw==
=C1qH
-----END PGP SIGNATURE-----

--c7bx4gmgrq3zcrtl--
