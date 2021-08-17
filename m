Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE433EEE19
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Aug 2021 16:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239165AbhHQOHt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 Aug 2021 10:07:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59801 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229761AbhHQOHt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Aug 2021 10:07:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629209235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1Y4uRb8+UIbsHh5odVcmrdnYyZQDTY27DDb/LyKDgXE=;
        b=OvP493zGYCWK2+tkpyMuKZciLDpg5CUSQj7MWGxfRMFmOLd0sV+RtF+QjxqeUkHILiNxYK
        xex3KL0Pl7HVOuSTLIbPOszoNkmK7IPmKTv1VKd274oumE4rsouudUnjJHdBJqHtCR+Z5N
        t9PrS5oYmpsEUsAXt5u5EPVdpR+zApg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-j1LlqDu_NxeZjxUSuGjW3A-1; Tue, 17 Aug 2021 10:07:11 -0400
X-MC-Unique: j1LlqDu_NxeZjxUSuGjW3A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EBAD1008060;
        Tue, 17 Aug 2021 14:07:10 +0000 (UTC)
Received: from localhost (unknown [10.22.16.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ABF5C10013D7;
        Tue, 17 Aug 2021 14:07:09 +0000 (UTC)
Date:   Tue, 17 Aug 2021 11:07:08 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "kgold@linux.ibm.com" <kgold@linux.ibm.com>
Subject: Re: [PATCH v2 ima-evm-utils] libimaevm: make SHA-256 the default
 hash algorithm
Message-ID: <YRvCjLbcGAqxgALW@glitch>
References: <20210816205835.76183-1-bmeneg@redhat.com>
 <2fb236f1-2a10-02e4-f796-6865d3411c2f@viveris.fr>
 <ee5f3cc1b8917b2c67a68738a8eb3584c4661349.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Mmb0GC8A6T2rDNbK"
Content-Disposition: inline
In-Reply-To: <ee5f3cc1b8917b2c67a68738a8eb3584c4661349.camel@linux.ibm.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--Mmb0GC8A6T2rDNbK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 17, 2021 at 07:26:02AM -0400, Mimi Zohar wrote:
> On Tue, 2021-08-17 at 07:42 +0000, THOBY Simon wrote:
> > Hi Bruno,
> >=20
> > On 8/16/21 10:58 PM, Bruno Meneguele wrote:
> > > The SHA-1 algorithm is considered a weak hash algorithm and there has=
 been
> > > some movement within certain distros to drop its support completely o=
r at
> > > least drop it from the default behavior. ima-evm-utils uses it as the
> > > default algorithm in case the user doesn't explicitly ask for another
> > > through the --hashalgo/-a option. With that, make SHA-256 the default=
 hash
> > > algorithm instead.
> >=20
> > I'm really happy to see that patch!
> > I contributed to the patchset https://lore.kernel.org/linux-integrity/2=
0210816081056.24530-1-Simon.THOBY@viveris.fr/T/#m8372b2b55dc8e1517e37624829=
fc8cb4361baf4d
> > because I ran into exactly this issue of (hashing files with SHA1 becau=
se of
> > the "insecure" default of evmctl).
> > So I'm definitely in favor of switching the default hash to sha256.
> >=20

I asked about changing the default algorithm for ima-evm-utils with Mimi
right before you sent the patchset v1 to the list :) Then I left in a
3weeks vacation and when I was back you were already in the v6/v7 of
that :D that's awesome.

> > That said, considering that CONFIG_IMA (in the kernel) doesn't depend
> > on CONFIG_CRYPTO_SHA256, isn't there a risk that files hashes/signed wi=
th
> > this patch could break on a kernel where that option wasn't selected?
> > (I also don't know how frequent kernels without CONFIG_CRYPTO_SHA256
> > may be - given that CONFIG_ENCRYPTED_KEYS require SHA256, probably
> > not so much)
> > I guess this boils down to: "do we know of any distribution not selecti=
ng
> > CRYPTO_SHA256?". If we don't, then the backward compatibility impact sh=
ould
> > be nearly void. If we do, some decision must be taken.
> >=20

See my comments below...

> > >=20
> > > Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
> > > ---
> > > Changelog:
> > >   v1: add ima-evm-utils to the [PATCH] part of the subject
> > >=20
> > >  README          | 2 +-
> > >  src/evmctl.c    | 2 +-
> > >  src/libimaevm.c | 2 +-
> > >  3 files changed, 3 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/README b/README
> > > index 87cd3b5cd7da..0dc02f551673 100644
> > > --- a/README
> > > +++ b/README
> > > @@ -41,7 +41,7 @@ COMMANDS
> > >  OPTIONS
> > >  -------
> > > =20
> > > -  -a, --hashalgo     sha1 (default), sha224, sha256, sha384, sha512
> > > +  -a, --hashalgo     sha1, sha224, sha256 (default), sha384, sha512
> > >    -s, --imasig       make IMA signature
> > >    -d, --imahash      make IMA hash
> > >    -f, --sigfile      store IMA signature in .sig file instead of xat=
tr
> > > diff --git a/src/evmctl.c b/src/evmctl.c
> > > index a8065bbe124a..e0e55bc0b122 100644
> > > --- a/src/evmctl.c
> > > +++ b/src/evmctl.c
> > > @@ -2496,7 +2496,7 @@ static void usage(void)
> > > =20
> > >  	printf(
> > >  		"\n"
> > > -		"  -a, --hashalgo     sha1 (default), sha224, sha256, sha384, sha5=
12, streebog256, streebog512\n"
> > > +		"  -a, --hashalgo     sha1, sha224, sha256 (default), sha384, sha5=
12, streebog256, streebog512\n"
> > >  		"  -s, --imasig       make IMA signature\n"
> > >  		"  -d, --imahash      make IMA hash\n"
> > >  		"  -f, --sigfile      store IMA signature in .sig file instead of =
xattr\n"
> > > diff --git a/src/libimaevm.c b/src/libimaevm.c
> > > index 8e9615796153..f6c72b878d88 100644
> > > --- a/src/libimaevm.c
> > > +++ b/src/libimaevm.c
> > > @@ -88,7 +88,7 @@ static const char *const pkey_hash_algo_kern[PKEY_H=
ASH__LAST] =3D {
> > >  struct libimaevm_params imaevm_params =3D {
> > >  	.verbose =3D LOG_INFO,
> > >  	.x509 =3D 1,
> > > -	.hash_algo =3D "sha1",
> > > +	.hash_algo =3D "sha256",
> > >  };
> > > =20
> > >  static void __attribute__ ((constructor)) libinit(void);
> > >=20
> >=20
> > No comments on the code change, it looks alright to me.
>=20
> Agreed with Simon's comments above.
>=20

Yes, I also agree. At first glance I would say that every distro
nowadays have CONFIG_CRYPTO_SHA256 set, at least the major ones AFAICT
(where ima-evm-utils have CI enabled for) so I didn't really bother too
much.

> Currently the default hash algorithm may be modified by supplying "
> --hashalgo" on the command.  We also know that whatever default hash
> algorithm chosen now, will change in the future.  Instead of hard
> coding the default hash algorithm, does it make more sense to make it a
> build time config option (e.g. DEFAULT_HASH_ALGO)?=20
>=20

+1 for the approach. We can make the algorithm availability check in
configuration time instead of runtime, directly in evmctl source code,
by grepping /proc/crypto maybe (not sure if that's the easiest way)?


--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--Mmb0GC8A6T2rDNbK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAmEbwokACgkQYdRkFR+R
okO6Ywf9FXC7fEgUCVmn6Pw/F0ngOosKjoBVLMzLWu4LdUcmGF87X6vntX1PKGT3
t8YzNqi3jxxCXV8mnmO+l0GS8sLTwBAn4S7JDQV8jiqyZ5kw1P0Y0dKXzbllIOdB
dLacQU+fsVPgYdtoCQN2LJb0rdk2XKkwvC3r53JN9HfFUAfsrL3Sgsevbiay5kiJ
XqH3IJnf1eXmLFPUyyYwv3ZD88Gxs9afLYfORf3hlqph+ynB5rlWEjqHUXLQQvDX
fGqdbSLhI1oWsvLKXS3Gdldd9K0mvTka541z50A6Yh11XafCvSmUaE0w9Sj2Orpz
OsXnAwknGDNwBDxHm1FLaiSE+NbcBQ==
=dn2W
-----END PGP SIGNATURE-----

--Mmb0GC8A6T2rDNbK--

