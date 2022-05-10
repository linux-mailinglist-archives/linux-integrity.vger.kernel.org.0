Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029F2521576
	for <lists+linux-integrity@lfdr.de>; Tue, 10 May 2022 14:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240111AbiEJMd3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 May 2022 08:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238445AbiEJMd2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 May 2022 08:33:28 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFBA2A3760;
        Tue, 10 May 2022 05:29:30 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 5E9151C0B95; Tue, 10 May 2022 14:29:28 +0200 (CEST)
Date:   Tue, 10 May 2022 14:29:27 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Evan Green <evgreen@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthew Garrett <mgarrett@aurora.tech>,
        Daniil Lunev <dlunev@google.com>, zohar@linux.ibm.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-integrity@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        rjw@rjwysocki.net, Gwendal Grignou <gwendal@chromium.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 08/10] PM: hibernate: Mix user key in encrypted hibernate
Message-ID: <20220510122927.GA19328@amd>
References: <20220504232102.469959-1-evgreen@chromium.org>
 <20220504161439.8.I87952411cf83f2199ff7a4cc8c828d357b8c8ce3@changeid>
 <20220506160820.GB1060@bug>
 <CAE=gft4nE6nYx9gRZuSL1v=8CjGsdtmx+GxPjmdD_hwJs5j-tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <CAE=gft4nE6nYx9gRZuSL1v=8CjGsdtmx+GxPjmdD_hwJs5j-tw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > One annoyance of the "preloading" scheme is that hibernate image memo=
ry
> > > is effectively double-allocated: first by the usermode process pulling
> > > encrypted contents off of disk and holding it, and second by the kern=
el
> > > in its giant allocation in prepare_image(). An interesting future
> > > optimization would be to allow the kernel to accept and store encrypt=
ed
> > > page data before the user key is available. This would remove the
> > > double allocation problem, as usermode could push the encrypted pages
> > > loaded from disk immediately without storing them. The kernel could d=
efer
> > > decryption of the data until the user key is available, while still
> > > knowing the correct page locations to store the encrypted data in.
> >
> > Um. Dunno. Won't you run out of memory? Hibernation images can be quite=
 big...
> >
>=20
> As you know, with the way the snapshot mechanism works, a hibernation
> image can be at most 50% of RAM. If the system was using more than

There used to be 50% of RAM limit, but it was removed.

Best regards,
								Pavel
							=09
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmJ6WqcACgkQMOfwapXb+vKwggCfU6LTG5MoZ6aeMEdfwivj1685
yUIAnR0jzeK1d2wmq0UYRYOrpRjaWwNn
=UpfY
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
