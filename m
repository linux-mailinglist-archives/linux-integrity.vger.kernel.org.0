Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92FC497986
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Aug 2019 14:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbfHUMfZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Aug 2019 08:35:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57842 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbfHUMfZ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Aug 2019 08:35:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 98D4030917AC;
        Wed, 21 Aug 2019 12:35:25 +0000 (UTC)
Received: from localhost (ovpn-116-63.gru2.redhat.com [10.97.116.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 26E235D9E1;
        Wed, 21 Aug 2019 12:35:24 +0000 (UTC)
Date:   Wed, 21 Aug 2019 09:35:23 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] ima-evm-utils: Enable large-file support
Message-ID: <20190821123523.GA9599@rhlt>
References: <20190819202507.27735-1-vt@altlinux.org>
 <20190820151939.GC7410@rhlt>
 <20190820194236.tgyhdlw5kgygcnsu@altlinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <20190820194236.tgyhdlw5kgygcnsu@altlinux.org>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 21 Aug 2019 12:35:25 +0000 (UTC)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2019 at 10:42:36PM +0300, Vitaly Chikunov wrote:
> Bruno,
>=20
> On Tue, Aug 20, 2019 at 12:19:39PM -0300, Bruno Meneguele wrote:
> > On Mon, Aug 19, 2019 at 11:25:07PM +0300, Vitaly Chikunov wrote:
> > > Some architectures require special measures to access large files (LF=
S).
> > > Add `AC_SYS_LARGEFILE' to `configure.ac' to handle this.
> > >=20
> > > It seems that ABI is not changed with this.
> > >=20
> > > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> > > ---
> > >  configure.ac | 1 +
> > >  1 file changed, 1 insertion(+)
> > >=20
> > > diff --git a/configure.ac b/configure.ac
> > > index 3f21ba4..02bd6f8 100644
> > > --- a/configure.ac
> > > +++ b/configure.ac
> > > @@ -8,6 +8,7 @@ AC_CONFIG_MACRO_DIR([m4])
> > > =20
> > >  AC_CANONICAL_HOST
> > >  AC_USE_SYSTEM_EXTENSIONS
> > > +AC_SYS_LARGEFILE
> > > =20
> >=20
> > Should we also add AC_FUNC_FSEEKO?
> >=20
> > I can't see any use of fseek or ftell in the code, but if we are
> > enabling AC_SYS_LARGEFILE by default we also should check for
> > AC_FUNC_FSEEKO in order to allow the use of fseeko/ftello whenever
> > needed.
>=20
> I thought about AC_FUNC_FSEEKO, but we don't use fseeko/ftello, so it
> didn't look useful.
>=20
> Thanks,
>=20

That's fine by me :)

Just was wondering if we should consider now that for possible use in
future. But indeed, that'll be useful only if we would use
fseeko/ftello.

Thanks.

Reviewed-by: Bruno Meneguele <bmeneg@redhat.com>

>=20
> >=20
> > >  # Checks for programs.
> > >  AC_PROG_CC
> > > --=20
> > > 2.11.0
> > >=20
>=20
>=20

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl1dOosACgkQYdRkFR+R
okOVfQf/aw44u5l8NCS9urZagTCSWfJ8bHZSkHnoDzpwQBJcGSPJb/qYi+JfA/+E
XDPOmJolzbtpNJTAGnoFBmlfXCQ392fUitl9IpLINIt665PjOFfCNZRmTTal18F9
9+nrOKy7FzEJsIPPsq5kjcZIgmkQ9rriHPfti2jMXuoNkDiAJfK8Xxqdy8103IW/
9SBrA1o07AfJpYndeg96HTWLOLkfBvhdlDZnTALhNzpouILK6qgtwiRTZGIo4eGR
HfwHwCxFBbZd9NpyVhL3neVX7yj3fseqz22QL6S6ex9vgr3k72H8CYSmYQQtsYOP
YSxkpb6n/i7KUZoJEw2LTW47pBXnww==
=edcB
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
