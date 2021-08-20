Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDE83F370E
	for <lists+linux-integrity@lfdr.de>; Sat, 21 Aug 2021 00:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbhHTWz4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Aug 2021 18:55:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21640 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229451AbhHTWzy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Aug 2021 18:55:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629500113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VWxJFSjxGLDigFHC7oqkzm5S5vUv3EJbMdx/TEgO2Ck=;
        b=CmnZD7kPFkuK19MMP0e2N+Q1YJPHbJlRk5WKe3QQ2FcRyHmGVBDoh393GMEFqADL5n9aWE
        Lf/MMtXVXiIo3/cPMotadvyZHX/Xz+1dwiLF5GiHiBSCDjaD6fDxVYA5PgJ/lGnpaLONOj
        kd7StRgPh1L92FVK6LjADKidXMrg8s0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592--WaJrk7UNv2l-fgSYiJC6A-1; Fri, 20 Aug 2021 18:55:09 -0400
X-MC-Unique: -WaJrk7UNv2l-fgSYiJC6A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 51CAD1853025;
        Fri, 20 Aug 2021 22:55:08 +0000 (UTC)
Received: from localhost (unknown [10.22.33.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA85160916;
        Fri, 20 Aug 2021 22:55:07 +0000 (UTC)
Date:   Fri, 20 Aug 2021 19:55:06 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     zohar@linux.ibm.com, Simon.THOBY@viveris.fr, kgold@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org
Subject: Re: [PATCH v3 ima-evm-utils 1/2] set default hash algorithm in
 configuration time
Message-ID: <YSAyyt3cvPYgk223@glitch>
References: <20210820224917.101053-1-bmeneg@redhat.com>
 <20210820224917.101053-2-bmeneg@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="aBoOsnz+NhI1CFQn"
Content-Disposition: inline
In-Reply-To: <20210820224917.101053-2-bmeneg@redhat.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--aBoOsnz+NhI1CFQn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 20, 2021 at 07:49:16PM -0300, Bruno Meneguele wrote:
> The default hash algorithm for evmctl is today hardcoded at libimaevm.c
> file. To facilitate different distributions and users to set their own
> default hash algorithm this patch adds the --with-default-hash=3D<algo> o=
ption
> to the configuration script.
>=20
> The algorithm chosen by the user will then be checked if is available in =
the
> kernel, otherwise IMA won't be able to verify files hashed by the user. F=
or
> that, the file exposed by the kernel crypto API (/proc/crypto) is filtered
> by an AWK script in order to check the algorithm's name and the module
> providing it. Initally, only "module: kernel" is accepted, following IMA's
> CONFIG_CRYPTO_SHA1/SHA256 dependency.
>=20
> Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
> ---
>  README                  |  2 +-
>  configure.ac            |  1 +
>  m4/default-hash-algo.m4 | 48 +++++++++++++++++++++++++++++++++++++++++
>  src/evmctl.c            |  4 ++--
>  src/imaevm.h            |  4 ++++
>  src/libimaevm.c         |  2 +-
>  6 files changed, 57 insertions(+), 4 deletions(-)
>  create mode 100644 m4/default-hash-algo.m4
>=20
> diff --git a/README b/README
> index 87cd3b5cd7da..4e35826cd982 100644
> --- a/README
> +++ b/README
> @@ -41,7 +41,7 @@ COMMANDS
>  OPTIONS
>  -------
> =20
> -  -a, --hashalgo     sha1 (default), sha224, sha256, sha384, sha512
> +  -a, --hashalgo     sha1, sha224, sha256, sha384, sha512
>    -s, --imasig       make IMA signature
>    -d, --imahash      make IMA hash
>    -f, --sigfile      store IMA signature in .sig file instead of xattr
> diff --git a/configure.ac b/configure.ac
> index a2d91b3db202..1c45f7f757ea 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -62,6 +62,7 @@ else
>  fi
> =20
>  EVMCTL_MANPAGE_DOCBOOK_XSL
> +AX_DEFAULT_HASH_ALGO
> =20
>  # for gcov
>  #CFLAGS=3D"$CFLAGS -Wall -fprofile-arcs -ftest-coverage"
> diff --git a/m4/default-hash-algo.m4 b/m4/default-hash-algo.m4
> new file mode 100644
> index 000000000000..14be44731ba6
> --- /dev/null
> +++ b/m4/default-hash-algo.m4
> @@ -0,0 +1,48 @@
> +dnl Copyright (c) 2021 Bruno Meneguele <bmeneg@redhat.com>
> +dnl Check hash algorithm availability in the kernel
> +dnl
> +dnl $1 =3D hash algorithm passed through --with-default-hash=3D<algo>
> +

^ this comment is useless here. At first I was keeping the AC_ARG_WITH()
outside the function and passing the result to that later.

I'm going to send a v4 removing this comment.

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--aBoOsnz+NhI1CFQn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAmEgMsoACgkQYdRkFR+R
okOmIQf+JAFpn+LV6uVypR1Xxv7q0So5X+qOmweAlUfGCuIVxUigNzgNAueA/WaQ
1I/nsPjcuy8Q3WpR+RIX9IeLK9lzNMkLB4NklSuzoPHfpesEQDbyHu+B9TIIx/aE
Cyefg1s9LQq84jAFoWs0l8KyNEjZoZPbTmzyrD0ol/EZsqyYYX7VvTSpSGG/khXq
ZH4/gelWruPnDC+LwdPIiwX29K3bLACXl6V1WubkHZIWQAGKBowwwz3YfHiP6DBm
PDBzQPEiTzR579pwmbajNa/9Fs3mLIfaW99QwKsZDndd/NVH4RDrKfbQvRzEIHZp
OJ7VKrer18mnDqzPcn+Vh81c1LHwJg==
=6sdZ
-----END PGP SIGNATURE-----

--aBoOsnz+NhI1CFQn--

