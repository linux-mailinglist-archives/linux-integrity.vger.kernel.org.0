Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72AFE2215EE
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jul 2020 22:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgGOUSv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jul 2020 16:18:51 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21276 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726863AbgGOUSu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jul 2020 16:18:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594844329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=phrbhMhaBabv8zcLDvpxEIm8lLjGHbe+t3Kj2H5UaLE=;
        b=OIIke9+yQbjM4oSPDiVQMJhMQ98TPX0Y1Maw4q9p9G0osjMkCzB8Sh8MZLsjWQCPSCO7t2
        3+dILJQXuz08End4jxSGoH0nWUEYmB9Mf2Y8xUg43v8056FxlWJWoYP+GGJXBpwdXJOytc
        vvAFPN+aaw500mEX4Utz1bWV9Ze9aSA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-IukstKO-OCikptKgm-eH0A-1; Wed, 15 Jul 2020 16:18:44 -0400
X-MC-Unique: IukstKO-OCikptKgm-eH0A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9ABC1080;
        Wed, 15 Jul 2020 20:18:43 +0000 (UTC)
Received: from localhost (ovpn-116-38.gru2.redhat.com [10.97.116.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B4D77980F;
        Wed, 15 Jul 2020 20:18:43 +0000 (UTC)
Date:   Wed, 15 Jul 2020 17:18:42 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>
Subject: Re: [PATCH 6/6] ima-evm-utils: define a basic hash_info.h file
Message-ID: <20200715201842.GJ3720@glitch>
References: <1594088791-27370-1-git-send-email-zohar@linux.ibm.com>
 <1594088791-27370-7-git-send-email-zohar@linux.ibm.com>
 <20200715175829.GG3720@glitch>
 <1594841338.12900.330.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <1594841338.12900.330.camel@linux.ibm.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="P6YfpwaDcfcOCJkJ"
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

--P6YfpwaDcfcOCJkJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2020 at 03:28:58PM -0400, Mimi Zohar wrote:
> On Wed, 2020-07-15 at 14:58 -0300, Bruno Meneguele wrote:
> > Hi Mimi,
> >=20
> > On Mon, Jul 06, 2020 at 10:26:31PM -0400, Mimi Zohar wrote:
> > > Some older system kernel header packages don't necessarily include
> > > hash_info.h.
> > >=20
> > > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > > ---
> > >  src/Makefile.am   |  2 +-
> > >  src/hash_info.gen | 43 +++++++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 44 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/src/Makefile.am b/src/Makefile.am
> > > index 36652427a8ec..9bbff5034ef4 100644
> > > --- a/src/Makefile.am
> > > +++ b/src/Makefile.am
> > > @@ -34,5 +34,5 @@ endif
> > > =20
> > >  AM_CPPFLAGS =3D -I$(top_srcdir) -include config.h
> > > =20
> > > -CLEANFILES =3D hash_info.h
> > > +CLEANFILES =3D hash_info.h tmp_hash_info.h
> > >  DISTCLEANFILES =3D @DISTCLEANFILES@
> > > diff --git a/src/hash_info.gen b/src/hash_info.gen
> > > index 54532ca5b847..5f7a97fb3117 100755
> > > --- a/src/hash_info.gen
> > > +++ b/src/hash_info.gen
> > > @@ -18,11 +18,54 @@ KERNEL_HEADERS=3D$1
> > >  HASH_INFO_H=3Duapi/linux/hash_info.h
> > >  HASH_INFO=3D$KERNEL_HEADERS/include/$HASH_INFO_H
> > > =20
> > > +TMPHASHINFO=3D"./tmp_hash_info.h"
> > > +gen_hashinfo() {
> > > +cat << __EOF__ >$TMPHASHINFO
> > > +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> > > +/*
> > > + * Hash Info: Hash algorithms information
> > > + *
> > > + * Copyright (c) 2013 Dmitry Kasatkin <d.kasatkin@samsung.com>
> > > + *
> > > + * This program is free software; you can redistribute it and/or mod=
ify it
> > > + * under the terms of the GNU General Public License as published by=
 the Free
> > > + * Software Foundation; either version 2 of the License, or (at your=
 option)
> > > + * any later version.
> > > + *
> > > + */
> > > +
> > > +enum hash_algo {
> > > +=09HASH_ALGO_MD4,
> > > +=09HASH_ALGO_MD5,
> > > +=09HASH_ALGO_SHA1,
> > > +=09HASH_ALGO_RIPE_MD_160,
> > > +=09HASH_ALGO_SHA256,
> > > +=09HASH_ALGO_SHA384,
> > > +=09HASH_ALGO_SHA512,
> > > +=09HASH_ALGO_SHA224,
> > > +=09HASH_ALGO_RIPE_MD_128,
> > > +=09HASH_ALGO_RIPE_MD_256,
> > > +=09HASH_ALGO_RIPE_MD_320,
> > > +=09HASH_ALGO_WP_256,
> > > +=09HASH_ALGO_WP_384,
> > > +=09HASH_ALGO_WP_512,
> > > +=09HASH_ALGO_TGR_128,
> > > +=09HASH_ALGO_TGR_160,
> > > +=09HASH_ALGO_TGR_192,
> > > +=09HASH_ALGO_SM3_256,
> > > +=09HASH_ALGO__LAST
> > > +};
> > > +__EOF__
> >=20
> > Just a minor point on HASH_ALGO_SM3_256:
> >=20
> > The old kernels that didn't export hash_info.h uapi didn't support
> > HASH_ALGO_SM3_256 as well. Wouldn't it be better to also not include it
> > in the tmp_hash_info considering it'll be used only by those running
> > older kernels without SM3 support?
> >=20
> > Keeping it won't cause any issues though. So I'm fine with it either
> > way.
>=20
> I was debating which version to use, but couldn't decide.
>=20
> For distros that probably is true, but I'm not sure about embedded.
> =A0Commit=A0ceecb28d3b52 ("ima-evm-utils: add SM3 to pkey_hash_algo
> algorithm list") updated pkey_hash_algo[].
>=20
> As it doesn't hurt, let's just keep it.
>=20

That's fine with me.

Thanks.

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--P6YfpwaDcfcOCJkJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl8PZKIACgkQYdRkFR+R
okMOXAgAk4aDtt8YEf9uRGtXBJfnZyZyfPop+8v5rZIqt6/E6+hqpCU0t/8+rFaH
U9K7N2FxEvllNxbV4SMBBJzWv2lSHkLmflV8AOa7/JyqjYHicMhzMNCxxr/aZcK5
QW5wzLfezTCnJuajGqCngcZyX+DIZ9G0B7fomSrFa3wC1DybTzHqtBUuKI5GxSX/
AkPb5LlvdY4td6wWa7ls7jxmGtEjGC7mMhk2VhuQJTD6IMPIC/2FNdxXqvkoCS2D
TDc8VpW/TkNoFgs82cZTfMQGBCutLuzy235IZoN5zZ/HEKStsh4igFmyT8psjsAQ
UuqqqweyuE+1t1utAj0JUpNSqndB8A==
=ZWBX
-----END PGP SIGNATURE-----

--P6YfpwaDcfcOCJkJ--

