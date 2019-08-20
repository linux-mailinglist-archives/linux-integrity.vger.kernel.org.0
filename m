Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD8989640F
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Aug 2019 17:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbfHTPTl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Aug 2019 11:19:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48518 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730538AbfHTPTl (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Aug 2019 11:19:41 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0E772811BF;
        Tue, 20 Aug 2019 15:19:41 +0000 (UTC)
Received: from localhost (ovpn-116-54.gru2.redhat.com [10.97.116.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 952894126;
        Tue, 20 Aug 2019 15:19:40 +0000 (UTC)
Date:   Tue, 20 Aug 2019 12:19:39 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] ima-evm-utils: Enable large-file support
Message-ID: <20190820151939.GC7410@rhlt>
References: <20190819202507.27735-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WfZ7S8PLGjBY9Voh"
Content-Disposition: inline
In-Reply-To: <20190819202507.27735-1-vt@altlinux.org>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Tue, 20 Aug 2019 15:19:41 +0000 (UTC)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Vitaly,

On Mon, Aug 19, 2019 at 11:25:07PM +0300, Vitaly Chikunov wrote:
> Some architectures require special measures to access large files (LFS).
> Add `AC_SYS_LARGEFILE' to `configure.ac' to handle this.
>=20
> It seems that ABI is not changed with this.
>=20
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
>  configure.ac | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/configure.ac b/configure.ac
> index 3f21ba4..02bd6f8 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -8,6 +8,7 @@ AC_CONFIG_MACRO_DIR([m4])
> =20
>  AC_CANONICAL_HOST
>  AC_USE_SYSTEM_EXTENSIONS
> +AC_SYS_LARGEFILE
> =20

Should we also add AC_FUNC_FSEEKO?

I can't see any use of fseek or ftell in the code, but if we are
enabling AC_SYS_LARGEFILE by default we also should check for
AC_FUNC_FSEEKO in order to allow the use of fseeko/ftello whenever
needed.

>  # Checks for programs.
>  AC_PROG_CC
> --=20
> 2.11.0
>=20

--WfZ7S8PLGjBY9Voh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl1cD4oACgkQYdRkFR+R
okO6fQgAz1rUnzcGsTL1IKFsrdtbP1A75Nywyr96DAgKgfR+IJNUx8CM/q0IYHzm
y0XMpWbNus3z3R+w8nTQdQ3cwC4yhu6TRN44USbnnBZM8P1vRBxAYhZObEZTjt0q
Q7NFFdsFbq19dQte9EmCGc7cDOyZtPn3Blq8cZaSgu0JScJLVPy15fpiHTSWyvOT
/ZcWiOjkksJR6K4Yn86eO/qgO60PPXDzQGV5frZHhY4wOFmwIPX+F2q9Wt613O1W
jwxx1BE1fPEBcPloBih+KOyKbA1du9nKB0KEBx5nGY6blxC5m64vTCjIa3bL51TM
U/t7+8Y9dcOfiscTaC4yulpPEdEJFQ==
=b/TJ
-----END PGP SIGNATURE-----

--WfZ7S8PLGjBY9Voh--
