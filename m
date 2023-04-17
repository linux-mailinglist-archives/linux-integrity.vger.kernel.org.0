Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DCB6E3F5B
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Apr 2023 08:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjDQGFl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Apr 2023 02:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjDQGFk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Apr 2023 02:05:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581862116
        for <linux-integrity@vger.kernel.org>; Sun, 16 Apr 2023 23:05:39 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1poHzc-0003GG-MO; Mon, 17 Apr 2023 08:05:36 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1poHzb-00BnvD-M6; Mon, 17 Apr 2023 08:05:35 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1poHzb-00Domi-0m; Mon, 17 Apr 2023 08:05:35 +0200
Date:   Mon, 17 Apr 2023 08:05:33 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 0/3] tpm: Convert to platform remove callback returning
 void
Message-ID: <20230417060533.guw7kqfbf4t3dytr@pengutronix.de>
References: <20230320080607.306495-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hyy5k7vlodgu366z"
Content-Disposition: inline
In-Reply-To: <20230320080607.306495-1-u.kleine-koenig@pengutronix.de>
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


--hyy5k7vlodgu366z
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Mar 20, 2023 at 09:06:04AM +0100, Uwe Kleine-K=F6nig wrote:
> this series adapts the platform drivers below drivers/char/tpm to use the
> .remove_new() callback. Compared to the traditional .remove() callback
> .remove_new() returns no value. This is a good thing because the driver c=
ore
> doesn't (and cannot) cope for errors during remove. The only effect of a
> non-zero return value in .remove() is that the driver core emits a warnin=
g. The
> device is removed anyhow and an early return from .remove() usually yield=
s a
> resource leak.
>=20
> The drivers converted here returned zero in their remove callback, to the
> transformation was easy.

who is responsible to pick up this patch set (or express their concerns
when not applying it)?

There is (for now) no coordination necessary, the final conversion of
platform_driver's remove callback is still far away. So applying it via
it's usual repo would be great.

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--hyy5k7vlodgu366z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmQ84awACgkQj4D7WH0S
/k4zeQf+Ns2SN3nbVWOiXDD21pHJ5RA4ajhu/1ypNUabeyb8Op6RezM+IjJlVDAb
oKCCuEtJjZpr6URA5CLo7cFvEqbseFHr0RQpZwFRazbxLcP9CIDnjWBxB5D6VDI9
Tv+8zhCXjyjnOrvJT4YazvC6Zbmmomt5Cw3cQNLaro46RbE1GvMO+ElqaA5GFCTd
voeFKfuSsQRgtSKLSeUNqsplQaKeW/bQPI+mNNa95QirnfAE/cFXjuuTVOcNdwz+
+RzO6jkuHBME9bt5Qy++bvkEtQmFf8rXUigXDD4tkuA0v0gjoEcJNGtsoTOATGtQ
5BuKS2d5lj4DBSn9qRakcdaBkB21LA==
=36el
-----END PGP SIGNATURE-----

--hyy5k7vlodgu366z--
