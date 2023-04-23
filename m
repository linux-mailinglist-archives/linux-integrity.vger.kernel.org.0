Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3784F6EBDD7
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Apr 2023 10:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjDWICS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 23 Apr 2023 04:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjDWICR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 23 Apr 2023 04:02:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E146CC
        for <linux-integrity@vger.kernel.org>; Sun, 23 Apr 2023 01:02:13 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pqUff-0002l7-W2; Sun, 23 Apr 2023 10:02:08 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pqUfe-00DCU5-LB; Sun, 23 Apr 2023 10:02:06 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pqUfd-00FVst-V2; Sun, 23 Apr 2023 10:02:05 +0200
Date:   Sun, 23 Apr 2023 10:02:05 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 0/3] tpm: Convert to platform remove callback returning
 void
Message-ID: <20230423080205.3jeyqjaacfmo3eej@pengutronix.de>
References: <20230320080607.306495-1-u.kleine-koenig@pengutronix.de>
 <20230417060533.guw7kqfbf4t3dytr@pengutronix.de>
 <f8e9ef81082ecdde4e73e27e33ad8648bb70ab9a.camel@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7ehhmyaykftyzkq4"
Content-Disposition: inline
In-Reply-To: <f8e9ef81082ecdde4e73e27e33ad8648bb70ab9a.camel@kernel.org>
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


--7ehhmyaykftyzkq4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Jarkko,

On Sun, Apr 23, 2023 at 09:13:57AM +0300, Jarkko Sakkinen wrote:
> On Mon, 2023-04-17 at 08:05 +0200, Uwe Kleine-K=F6nig wrote:
> > Hello,
> >=20
> > On Mon, Mar 20, 2023 at 09:06:04AM +0100, Uwe Kleine-K=F6nig wrote:
> > > this series adapts the platform drivers below drivers/char/tpm to use=
 the
> > > .remove_new() callback. Compared to the traditional .remove() callback
> > > .remove_new() returns no value. This is a good thing because the driv=
er core
> > > doesn't (and cannot) cope for errors during remove. The only effect o=
f a
> > > non-zero return value in .remove() is that the driver core emits a wa=
rning. The
> > > device is removed anyhow and an early return from .remove() usually y=
ields a
> > > resource leak.
> > >=20
> > > The drivers converted here returned zero in their remove callback, to=
 the
> > > transformation was easy.
> >=20
> > who is responsible to pick up this patch set (or express their concerns
> > when not applying it)?
> >=20
> > There is (for now) no coordination necessary, the final conversion of
> > platform_driver's remove callback is still far away. So applying it via
> > it's usual repo would be great.
>=20
> Please check https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux=
-tpmdd.git/

Looking at the topmost three commits in your next branch (i.e.
0760dc1b2f58fe741bddb6a0030720dfd6ac4689) it looks fine to me.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--7ehhmyaykftyzkq4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmRE5fwACgkQj4D7WH0S
/k7JTQgAnuwxK8akss4S52XeX005xNFz+mnSQe3Lp8Iscw1RLr/wDBQrqrOORLZO
2tIcWkug8zLxuHLUtvRndDmw8kJ49+ZBgAU1Z6UwW4aa0AkNIoxs7d68YvqNvi6v
4lzN/eD+LB5rkJcCD2Z1Cqr2tERvHVKeoqdfD89siZigcDtaMnK6KGa8EPNmlUQm
3NqFkLP4TcWE9HcBsDNg93fW+ngEE7bVX2x8wY9rWADB+TQju/cpx2YgMoU3Mtzf
N+dydjsoPha4hpDZ+zgt/O/uU/YKm/Qsm24XrbLvSRwpP272da8btkcKNkM74/pE
Tamz3TRk/j2ScPMFouaRKIbC8vVB+Q==
=a5Cu
-----END PGP SIGNATURE-----

--7ehhmyaykftyzkq4--
