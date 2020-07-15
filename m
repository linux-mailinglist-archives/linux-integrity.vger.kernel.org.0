Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175882213D8
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jul 2020 19:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgGOR6r (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jul 2020 13:58:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58922 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725861AbgGOR6r (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jul 2020 13:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594835925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XKXIzFLVY5trhCImGyR7UYr06iPeeq+jKXev7ABWDRA=;
        b=bXAmoJrSr9cGTXyLBESkin4yAHkH9BZiaAErV1El1eqZLhQpshcJZ86pf1GytJVbJTOMr7
        /4MOKNbLXapoGH9xcq1kI+po/Z3tXvj8FjXeO7kT1e0Y/BKj3kl9UKERytrdfvKrEwe0pv
        FDX+PqMAlsU+KH2/7tamJwCLAnZisHc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-caOpOX_2OQ-WHeeGQ8LXTw-1; Wed, 15 Jul 2020 13:58:32 -0400
X-MC-Unique: caOpOX_2OQ-WHeeGQ8LXTw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABCAC18FF692;
        Wed, 15 Jul 2020 17:58:31 +0000 (UTC)
Received: from localhost (ovpn-116-38.gru2.redhat.com [10.97.116.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D9646FDD1;
        Wed, 15 Jul 2020 17:58:31 +0000 (UTC)
Date:   Wed, 15 Jul 2020 14:58:29 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>
Subject: Re: [PATCH 6/6] ima-evm-utils: define a basic hash_info.h file
Message-ID: <20200715175829.GG3720@glitch>
References: <1594088791-27370-1-git-send-email-zohar@linux.ibm.com>
 <1594088791-27370-7-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <1594088791-27370-7-git-send-email-zohar@linux.ibm.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IuhbYIxU28t+Kd57"
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

--IuhbYIxU28t+Kd57
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mimi,

On Mon, Jul 06, 2020 at 10:26:31PM -0400, Mimi Zohar wrote:
> Some older system kernel header packages don't necessarily include
> hash_info.h.
>=20
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  src/Makefile.am   |  2 +-
>  src/hash_info.gen | 43 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 44 insertions(+), 1 deletion(-)
>=20
> diff --git a/src/Makefile.am b/src/Makefile.am
> index 36652427a8ec..9bbff5034ef4 100644
> --- a/src/Makefile.am
> +++ b/src/Makefile.am
> @@ -34,5 +34,5 @@ endif
> =20
>  AM_CPPFLAGS =3D -I$(top_srcdir) -include config.h
> =20
> -CLEANFILES =3D hash_info.h
> +CLEANFILES =3D hash_info.h tmp_hash_info.h
>  DISTCLEANFILES =3D @DISTCLEANFILES@
> diff --git a/src/hash_info.gen b/src/hash_info.gen
> index 54532ca5b847..5f7a97fb3117 100755
> --- a/src/hash_info.gen
> +++ b/src/hash_info.gen
> @@ -18,11 +18,54 @@ KERNEL_HEADERS=3D$1
>  HASH_INFO_H=3Duapi/linux/hash_info.h
>  HASH_INFO=3D$KERNEL_HEADERS/include/$HASH_INFO_H
> =20
> +TMPHASHINFO=3D"./tmp_hash_info.h"
> +gen_hashinfo() {
> +cat << __EOF__ >$TMPHASHINFO
> +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> +/*
> + * Hash Info: Hash algorithms information
> + *
> + * Copyright (c) 2013 Dmitry Kasatkin <d.kasatkin@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify =
it
> + * under the terms of the GNU General Public License as published by the=
 Free
> + * Software Foundation; either version 2 of the License, or (at your opt=
ion)
> + * any later version.
> + *
> + */
> +
> +enum hash_algo {
> +=09HASH_ALGO_MD4,
> +=09HASH_ALGO_MD5,
> +=09HASH_ALGO_SHA1,
> +=09HASH_ALGO_RIPE_MD_160,
> +=09HASH_ALGO_SHA256,
> +=09HASH_ALGO_SHA384,
> +=09HASH_ALGO_SHA512,
> +=09HASH_ALGO_SHA224,
> +=09HASH_ALGO_RIPE_MD_128,
> +=09HASH_ALGO_RIPE_MD_256,
> +=09HASH_ALGO_RIPE_MD_320,
> +=09HASH_ALGO_WP_256,
> +=09HASH_ALGO_WP_384,
> +=09HASH_ALGO_WP_512,
> +=09HASH_ALGO_TGR_128,
> +=09HASH_ALGO_TGR_160,
> +=09HASH_ALGO_TGR_192,
> +=09HASH_ALGO_SM3_256,
> +=09HASH_ALGO__LAST
> +};
> +__EOF__

Just a minor point on HASH_ALGO_SM3_256:

The old kernels that didn't export hash_info.h uapi didn't support
HASH_ALGO_SM3_256 as well. Wouldn't it be better to also not include it
in the tmp_hash_info considering it'll be used only by those running
older kernels without SM3 support?

Keeping it won't cause any issues though. So I'm fine with it either
way.

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--IuhbYIxU28t+Kd57
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl8PQ8UACgkQYdRkFR+R
okMcHgf+Ioz40mf+1enk+c+Njo2QmWCl632B34Owj6DoVno7XT25gmORDPO/mqnz
GJA7gzGuJVc4U8qieWMfZJSQ5bWrumpbxvWdWCvFDT0lnj5A0v71nIqjPXqT1hZj
ZxvNwK5iRouOHsP3nxLdEcfOeNWG2118XLb7fZprVuWUuck2VcqHn86+0VL2wCDJ
lODWwVDIBsU9vSIFKYpkLp2GJTZnGzSavhFranBtc7BvNHom+eq2OODxZeVtH3Fw
+lfElnyM8oqgzxsVk0bd4/R67vhWlMpSRGaHjwUyJmhxwtIZwoU5Id0Cp2YOpqfB
4XRgRZ4jHbCvt/yi81vQYVXuXAM/wQ==
=pTZy
-----END PGP SIGNATURE-----

--IuhbYIxU28t+Kd57--

