Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0784473649
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jul 2019 20:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbfGXSEn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Jul 2019 14:04:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52622 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfGXSEn (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Jul 2019 14:04:43 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DA6BCC06513C;
        Wed, 24 Jul 2019 18:04:42 +0000 (UTC)
Received: from localhost (ovpn-116-76.gru2.redhat.com [10.97.116.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 450AA19C7F;
        Wed, 24 Jul 2019 18:04:42 +0000 (UTC)
Date:   Wed, 24 Jul 2019 15:04:40 -0300
From:   "Bruno E. O. Meneguele" <bmeneg@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
Subject: Re: ima-evm-utils:  library version
Message-ID: <20190724180440.GD3726@rhlt>
References: <1563972698.4245.21.camel@linux.ibm.com>
 <20190724172801.y64bs2byyuqfsezf@altlinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fOHHtNG4YXGJ0yqR"
Content-Disposition: inline
In-Reply-To: <20190724172801.y64bs2byyuqfsezf@altlinux.org>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 24 Jul 2019 18:04:42 +0000 (UTC)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--fOHHtNG4YXGJ0yqR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mimi,

On Wed, Jul 24, 2019 at 08:28:01PM +0300, Vitaly Chikunov wrote:
> Mimi,
>=20
> On Wed, Jul 24, 2019 at 08:51:38AM -0400, Mimi Zohar wrote:
> >=20
> > In preparing the ima-evm-utils v1.2 release, I noticed that the
> > library version was never updated. =A0It is still "0.0.0". =A0Should I =
set
> > it to something? =A0If so, what versioning scheme do you recommend -
> > using the libtool current[:revision[:age]], prepending the release
> > version on the .so, or suffixing the release version on the .so?
>=20
> libtool rules should be followed:
>=20
>   https://www.gnu.org/software/libtool/manual/html_node/Updating-version-=
info.html
>=20
> I think you should change 0.0.0 to 1.0.0 just before release. Since we are
> changed ABI of calc_keyid_v2 (RSA *key -> EVP_PKEY *pkey). (There is also
> changes to read_pub_pkey and get_filesize.)
>=20

Yep, I agree with that: libtool scheme for sure, thus the linker can
easily handle the dependency without the need for manual relinkage from
our users whenever possible, i.e. "current" and "age" getting increased
by 1 means the interface is backward compatible to the last release and
don't require a new linkage step of user's tool.

> > The other option is to leave the version as 0.0.0 and let the distro
> > package maintainers deal with it.
>=20
> I think you should update it properly.
>=20

Not every packager is aware of tool's internals/source code, and let
them face possible user crashes due to "invalid interface calls" is
pretty bad to the tool community itself.

> > Posting a patch that sets the library version would be most welcome.
>=20
> diff --git a/src/Makefile.am b/src/Makefile.am
> index 9c037e2..b794c50 100644
> --- a/src/Makefile.am
> +++ b/src/Makefile.am
> @@ -4,7 +4,7 @@ libimaevm_la_SOURCES =3D libimaevm.c
>  libimaevm_la_CPPFLAGS =3D $(AM_CPPFLAGS) $(LIBCRYPTO_CFLAGS)
>  # current[:revision[:age]]
>  # result: [current-age].age.revision
> -libimaevm_la_LDFLAGS =3D -version-info 0:0:0
> +libimaevm_la_LDFLAGS =3D -version-info 1:0:0
>  libimaevm_la_LIBADD =3D  $(LIBCRYPTO_LIBS)
>=20
> Thanks,

And I also agree with his patch, changing -version-info to 1:0:0,
bumping "current" number, since the interface was indeed changed since
v1.1 release of ima-evm-utils.

Thanks for catching that :))

--fOHHtNG4YXGJ0yqR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl04nbgACgkQYdRkFR+R
okM9kAf9F1n/9hHIxRfaEVZ9VyG7Rjf4NcpJWkxaO2fNd96qA6q02dTN6G60BkCc
0LzvnQzsurCC1GbDxaf8rE+Q930A9d5llHoiH5n33PsE/tTpSvga+sXCaH2H2xDu
S1ZACzF1NVcSDX7sKXSidMh7+MWvEXKcDLCUoUSQL3fBq+plefGp22zb8hWcGGqX
WmkVtu9IoGqTMjQ+m3TyZNxgN0q5KLaWuVaFwS7GFvx936/Ub4mx+Y+XBXNv5VjF
bC4YPvHQo2qbtrOVCD/2ffmJpJ2yzobb6b6gwj15RgEuGRfPQtE37afOIHLa2Ibj
DIbqu7BtjlIcMWXpBJVlxDNRUz/WXw==
=Di86
-----END PGP SIGNATURE-----

--fOHHtNG4YXGJ0yqR--
