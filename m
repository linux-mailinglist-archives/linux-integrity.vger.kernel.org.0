Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C47E4EDA6A
	for <lists+linux-integrity@lfdr.de>; Thu, 31 Mar 2022 15:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236769AbiCaNYX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 31 Mar 2022 09:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235041AbiCaNYX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 31 Mar 2022 09:24:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076AF1EA2AB
        for <linux-integrity@vger.kernel.org>; Thu, 31 Mar 2022 06:22:36 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nZukz-0000QD-7y; Thu, 31 Mar 2022 15:22:33 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nZukz-0007dr-Hc; Thu, 31 Mar 2022 15:22:32 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nZukx-000FOr-8T; Thu, 31 Mar 2022 15:22:31 +0200
Date:   Thu, 31 Mar 2022 15:22:31 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] char: tpm: cr50_i2c: Drop if with an always false
 condition
Message-ID: <20220331132231.h2hbtxthcqsdxmil@pengutronix.de>
References: <20211112225308.1149304-1-u.kleine-koenig@pengutronix.de>
 <0c7eb1e97e73e2cd3182a98d8cf76c6a2e2e6578.camel@kernel.org>
 <20211113215340.cn5kyia7g6fcquh2@pengutronix.de>
 <671cac28ac30a1135030261948487922cfcd4d89.camel@kernel.org>
 <20211116173039.ilnj7pag7solqprd@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jwuucdekxnfeozc3"
Content-Disposition: inline
In-Reply-To: <20211116173039.ilnj7pag7solqprd@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--jwuucdekxnfeozc3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 16, 2021 at 06:30:39PM +0100, Uwe Kleine-K=F6nig wrote:
> On Tue, Nov 16, 2021 at 05:55:35PM +0200, Jarkko Sakkinen wrote:
> > On Sat, 2021-11-13 at 22:53 +0100, Uwe Kleine-K=F6nig wrote:
> > > Hello,
> > >=20
> > > On Sat, Nov 13, 2021 at 12:53:32PM +0200, Jarkko Sakkinen wrote:
> > > > On Fri, 2021-11-12 at 23:53 +0100, Uwe Kleine-K=F6nig wrote:
> > > > > tpm_cr50_i2c_remove() is only called after tpm_cr50_i2c_probe() r=
eturned
> > > > > successfully. As i2c_get_clientdata() returns driver data for the
> > > > > client's device and this was set in tpmm_chip_alloc() it won't re=
turn
> > > > > NULL.
> > > >=20
> > > > This does not make the check obsolete, e.g. it would catch a progra=
mming
> > > > error elsewhere.
> > > >=20
> > > > > Simplify accordingly to prepare changing the prototype of the i2c=
 remove
> > > > > callback to return void. Notice that already today returning an e=
rror
> > > > > code from the remove callback doesn't prevent removal.
> > > >=20
> > > > I don't understand what you are trying to say.
> > >=20
> > > The eventual goal is the following change:
> > >=20
> > > diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> > > index 16119ac1aa97..c7069ebf5a66 100644
> > > --- a/include/linux/i2c.h
> > > +++ b/include/linux/i2c.h
> > > @@ -273,7 +273,7 @@ struct i2c_driver {
> > > =A0
> > > =A0=A0=A0=A0=A0=A0=A0=A0/* Standard driver model interfaces */
> > > =A0=A0=A0=A0=A0=A0=A0=A0int (*probe)(struct i2c_client *client, const=
 struct i2c_device_id *id);
> > > -=A0=A0=A0=A0=A0=A0=A0int (*remove)(struct i2c_client *client);
> > > +=A0=A0=A0=A0=A0=A0=A0void (*remove)(struct i2c_client *client);
> > > =A0
> > > =A0=A0=A0=A0=A0=A0=A0=A0/* New driver model interface to aid the seam=
less removal of the
> > > =A0=A0=A0=A0=A0=A0=A0=A0 * current probe()'s, more commonly unused th=
an used second parameter.
> > >=20
> > > To prepare that I want to change all remove callbacks to unconditiona=
lly
> > > return 0.
> > >=20
> > > The motivation for the above change is that returning an error from an
> > > i2c (or spi or platform) remove callback doesn't prevent the device f=
rom
> > > being removed. So the ability to return an int leads to wrong
> > > expectations by driver authors.
> > >=20
> > > The only effect a non-zero return code has, is an error message from =
the
> > > i2c core. So if you object to my suggested change, the minimal change=
 I
> > > want to convince you of is to replace
> > >=20
> > > =A0=A0=A0=A0=A0=A0=A0=A0return -ENODEV;
> > >=20
> > > by
> > >=20
> > > =A0=A0=A0=A0=A0=A0=A0=A0return 0;
> > >=20
> > > .
> >=20
> > Please then include it to a patch set, where this happens.
>=20
> My plan is to do all the preparation before submitting the change to
> struct i2c_driver such that in the end coordination is only needed for a
> single patch. (As this patch should be easy to review and without side
> effects it should only drop "return 0;" (or replace them by "return;",
> depending on context) to make this easy to review/verify.
>=20
> Note that the suggested change has already a benefit today because in
> the error case (and without the change) you get two error messages.
> Returning 0 suppresses the generic (and so less useful) one.

Either this was not convincing or this patch fell through the cracks.
Whatever it was, nobody replied and the patch isn't applied either.

Would you please (re)consider this patch?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jwuucdekxnfeozc3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmJFqxQACgkQwfwUeK3K
7Amw2Qf+MPpBDwgzYIGVnb8kISAYjeaaykl+xvhFq45DqaCsCOAJK2jD7h7ATNVn
96anWdkCFTtTuClbb4XYqGx9eHon26FNeeqFRQLhxmWGGi8gaOMQDtibwnqb+Xgk
CbY8d39dPKRdShP56eC+9ObBgQo9NQX/w/RRMJLxtLQQcK8Y2IF8uoaVNShVovrn
Rqce7sdASu9m8HuDyOJDNf/TW+k4Pe3Y4mxsmozw5al3mboh3FKP0INicqMIH0yc
h6sXnaOxQ/q6iAsoYROmsSPxUavNhlaAPgYdc8NC757RHq7OCRYpYOCbEkecv+UX
GFhLMA5KMg7BOPh6QxaVtJinRE/iTQ==
=hTJq
-----END PGP SIGNATURE-----

--jwuucdekxnfeozc3--
