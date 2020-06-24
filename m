Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05E44209684
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Jun 2020 00:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390153AbgFXWob (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Jun 2020 18:44:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26979 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388739AbgFXWob (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Jun 2020 18:44:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593038669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OE1t8Xr5HwnE0lJYFyZdca+7hEd0faxBcLtJt1pqxE8=;
        b=LjvIMF7c76V7+6p++fPkPvB4Igb3rDOm4+280zZqC5k71VUcXU2Tut6lN23dAuFVEvQ91g
        AQEQ5Up66/dSskiZzsS00r/KN+GQQWT2ECUSGktTBi1BDbmcjDTasngccvbG5DS2JnwYnX
        YxXEYiFk3PMx7SHl0BUjjKuu91ndP+I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-RROwxQD1OCq6x5CtNUQ0MA-1; Wed, 24 Jun 2020 18:44:27 -0400
X-MC-Unique: RROwxQD1OCq6x5CtNUQ0MA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11CC818585A1;
        Wed, 24 Jun 2020 22:44:26 +0000 (UTC)
Received: from localhost (ovpn-116-62.gru2.redhat.com [10.97.116.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A69635D9E7;
        Wed, 24 Jun 2020 22:44:25 +0000 (UTC)
Date:   Wed, 24 Jun 2020 19:44:24 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com
Subject: Re: [PATCH v2] ima-evm-utils: skip test for discrete TPM 1.2 and
 exec'd as normal user
Message-ID: <20200624224424.GF2639@glitch>
References: <20200624223829.6216-1-bmeneg@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200624223829.6216-1-bmeneg@redhat.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="z0eOaCaDLjvTGF2l"
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

--z0eOaCaDLjvTGF2l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2020 at 07:38:29PM -0300, Bruno Meneguele wrote:
> boot_aggregate test make use of a software TPM 2.0 in case it doesn't fin=
d
> any /dev/tpm0 in the system or if the test is ran as a normal user. Howev=
er,
> when the system has a discrete TPM 1.2 and the user runs the test with a
> non-root user evmctl fails to return the software TPM 2.0 boot aggregate
> value because it tries to access TPM 1.2 the sysfs PCRs file and,
> consequently, the test fails. Thus TPM 2.0 log test is not supported on
> systems with a discrete TPM 1.2
>=20
> Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
> ---

Should've added the changelog note, but considering it doesn't make git
history, for those reviewing the patch:

v1->v2:
  - fixed a statement in commit log only.


>  tests/boot_aggregate.test | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/tests/boot_aggregate.test b/tests/boot_aggregate.test
> index fe0c9aa..43de67d 100755
> --- a/tests/boot_aggregate.test
> +++ b/tests/boot_aggregate.test
> @@ -23,6 +23,8 @@ export LD_LIBRARY_PATH=3D$LD_LIBRARY_PATH
>  . ./functions.sh
>  _require evmctl
>  TSSDIR=3D"$(dirname -- "$(which tssstartup)")"
> +PCRFILE=3D"/sys/class/tpm/tpm0/device/pcrs"
> +MISC_PCRFILE=3D"/sys/class/misc/tpm0/device/pcrs"
> =20
>  if [ "$(id -u)" =3D 0 ] && [ -c "/dev/tpm0" ]; then
>  =09ASCII_RUNTIME_MEASUREMENTS=3D"/sys/kernel/security/ima/ascii_runtime_=
measurements"
> @@ -133,6 +135,11 @@ check() {
> =20
>  # Start and initialize a software TPM as needed
>  if [ "$(id -u)" !=3D 0 ] || [ ! -c "/dev/tpm0" ]; then
> +=09if [ -f "$PCRFILE" ] || [ -f "$MISC_PCRFILE" ]; then
> +=09=09echo "${CYAN}SKIP: system has discrete TPM 1.2, sample TPM 2.0 eve=
nt log test not supported.${NORM}"
> +=09=09exit "$SKIP"
> +=09fi
> +
>  =09swtpm_start
>  =09error=3D$?
>  =09if [ $error -eq "$SKIP" ]; then
> --=20
> 2.26.2
>=20

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--z0eOaCaDLjvTGF2l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl7z10gACgkQYdRkFR+R
okNJ3gf9EKxGESI10uAfywAbzn4/tNnHr2Avuh+rLG/gTjP80kNA96yoEJsoYDZq
n5XYKwR4txeWGiMQDzueuMsSd/zSwUXnq/Z2PFNJLvvvJztA1pxgaFvwi8UHGoVm
N8VroAS9B2FwMsfN7rTly2qT9Z3ZjLWuRogwXPPbL2IBtTymnNu3mstaQvkhJJp6
CxbnC0vAFx8Hv99M/d1Aegy9gpdV3wh0asdu6NieZIUYd1Y0GgF6GkpW8UvR0yIB
Os11+IBzC0+8/8bJe26vSAvEfc7iTgvx4t8Pl/PZygYBmzWC0IhQE5yZQP8zDoab
+u31O+8/FeRqlszJjk3zRHqEYtfKsA==
=o/aI
-----END PGP SIGNATURE-----

--z0eOaCaDLjvTGF2l--

