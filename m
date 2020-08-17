Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580E9246863
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Aug 2020 16:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgHQObh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Aug 2020 10:31:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33706 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728849AbgHQObh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Aug 2020 10:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597674695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mxgabpDEFYNht1MiJtKJMyP7n1c8XeUJ7wKYseTKexo=;
        b=FkocTtEtGE8IkiMMEXB7bgUOSjDJWh59+PSlLJ2qNTPDO38ZR4rh6279P2XKmoe/K5of1F
        /VtMCjA+CyT964qu3XXm5BFqHQrYHgKRSmxOhyAMW/4LpELTKfD7J+OZ77vKOUVBME56pz
        JO/KBP2kBdJthV8aRtFSlEu42zS6KV0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-v4T9_47sMCG3ZjexfYeFEw-1; Mon, 17 Aug 2020 10:31:25 -0400
X-MC-Unique: v4T9_47sMCG3ZjexfYeFEw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6ADF9100CF76;
        Mon, 17 Aug 2020 14:31:22 +0000 (UTC)
Received: from localhost (ovpn-116-138.gru2.redhat.com [10.97.116.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 001987A3BD;
        Mon, 17 Aug 2020 14:31:21 +0000 (UTC)
Date:   Mon, 17 Aug 2020 11:31:20 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>
Subject: Re: [ima-evm-utils][PATCH] Install the swtpm package, if available
Message-ID: <20200817143120.GB4781@glitch>
References: <20200816193627.73935-1-zohar@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200816193627.73935-1-zohar@linux.ibm.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bmeneg@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 16, 2020 at 03:36:27PM -0400, Mimi Zohar wrote:
> The "boot_aggregate.test" requires either a hardware or software TPM.
> Support using the swtpm, if packaged for the distro, in addition to
> tpm_server.
>=20
> Note: Some travis/<distro>.sh scripts are links to other scripts.
> Don't fail the build of the linked script if the swtpm package doesn't
> exist.
>=20
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  .travis.yml               |  2 +-
>  tests/boot_aggregate.test | 40 ++++++++++++++++++++++++++++-----------
>  travis/fedora.sh          |  1 +
>  3 files changed, 31 insertions(+), 12 deletions(-)
>=20
> diff --git a/.travis.yml b/.travis.yml
> index 849fcb6ba822..9bea5d19bd0e 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -75,4 +75,4 @@ before_install:
>  script:
>      - INSTALL=3D"${DISTRO%%:*}"
>      - INSTALL=3D"${INSTALL%%/*}"
> -    - docker run -t ima-evm-utils /bin/sh -c "cd travis && if [ \"$VARIA=
NT\" ]; then ARCH=3D\"$ARCH\" ./$INSTALL.$VARIANT.sh; fi && ARCH=3D\"$ARCH\=
" CC=3D\"$CC\" TSS=3D\"$TSS\" ./$INSTALL.sh && if [ ! \"$VARIANT\" ]; then =
which tpm_server || ../tests/install-swtpm.sh; fi && CC=3D\"$CC\" VARIANT=
=3D\"$VARIANT\" ../build.sh"
> +    - docker run -t ima-evm-utils /bin/sh -c "cd travis && if [ \"$VARIA=
NT\" ]; then ARCH=3D\"$ARCH\" ./$INSTALL.$VARIANT.sh; fi && ARCH=3D\"$ARCH\=
" CC=3D\"$CC\" TSS=3D\"$TSS\" ./$INSTALL.sh && if [ ! \"$VARIANT\" ]; then =
which tpm_server || which swtpm || ../tests/install-swtpm.sh; fi && CC=3D\"=
$CC\" VARIANT=3D\"$VARIANT\" ../build.sh"
> diff --git a/tests/boot_aggregate.test b/tests/boot_aggregate.test
> index 43de67de1468..ce310b6ae5b4 100755
> --- a/tests/boot_aggregate.test
> +++ b/tests/boot_aggregate.test
> @@ -33,6 +33,10 @@ else
>  =09ASCII_RUNTIME_MEASUREMENTS=3D"./sample-ascii_runtime_measurements-pcr=
s-8-9"
>  =09export TPM_INTERFACE_TYPE=3D"socsim"
>  =09export TPM_COMMAND_PORT=3D2321
> +=09export TPM_PLATFORM_PORT=3D2322
> +=09export TPM_SERVER_NAME=3D"localhost"
> +=09export TPM_SERVER_TYPE=3D"raw"
> +
>  fi
> =20
>  # Only stop this test's software TPM.  Preferred method: "tsstpmcmd -sto=
p"
> @@ -48,22 +52,36 @@ cleanup() {
> =20
>  # Try to start a software TPM if needed.
>  swtpm_start() {
> -=09local swtpm
> +=09local swtpm swtpm1
> =20
>  =09swtpm=3D"$(which tpm_server)"
> -=09if [ -z "${swtpm}" ]; then
> -=09=09echo "${CYAN}SKIP: Softare TPM (tpm_server) not found${NORM}"
> +=09swtpm1=3D"$(which swtpm)"
> +=09if [ -z "${swtpm}" ] && [ -z "${swptm1}" ]; then
> +=09=09echo "${CYAN}SKIP: Softare TPM (tpm_server and swtpm) not found${N=
ORM}"
>  =09=09return "$SKIP"
>  =09fi
> =20
> -=09pgrep tpm_server
> -=09if [ $? -eq 0 ]; then
> -=09=09echo "INFO: Software TPM (tpm_server) already running"
> -=09=09return 114
> -=09else
> -=09=09echo "INFO: Starting software TPM: ${swtpm}"
> -=09=09${swtpm} > /dev/null 2>&1 &
> -=09=09SWTPM_PPID=3D$!
> +=09if [ ! -z "${swtpm1}" ]; then
> +=09=09pgrep swtpm1
> +=09=09if [ $? -eq 0 ]; then
> +=09=09=09echo "INFO: Software TPM (swtpm) already running"
> +=09=09=09return 114
> +=09=09else
> +=09=09=09echo "INFO: Starting software TPM: ${swtpm1}"
> +=09=09=09mkdir ./myvtpm
> +=09=09=09${swtpm1} socket --tpmstate dir=3D./myvtpm --tpm2 --ctrl type=
=3Dtcp,port=3D2322 --server type=3Dtcp,port=3D2321 --flags not-need-init > =
/dev/null 2>&1 &
> +=09=09=09SWTPM_PPID=3D$!
> +=09=09fi
> +=09elif [ ! -z "${swtpm}" ]; then
> +=09=09pgrep swtpm
> +=09=09if [ $? -eq 0 ]; then
> +=09=09=09echo "INFO: Software TPM (tpm_server) already running"
> +=09=09=09return 114
> +=09=09else
> +=09=09=09echo "INFO: Starting software TPM: ${swtpm}"
> +=09=09=09${swtpm} > /dev/null 2>&1 &
> +=09=09=09SWTPM_PPID=3D$!
> +=09=09fi
>  =09fi
>  =09return 0
>  }
> diff --git a/travis/fedora.sh b/travis/fedora.sh
> index d3459e408d81..f9ee9bed7bc1 100755
> --- a/travis/fedora.sh
> +++ b/travis/fedora.sh
> @@ -41,6 +41,7 @@ yum -y install \
>  =09which
> =20
>  yum -y install docbook5-style-xsl || true
> +yum -y install swtpm || true
> =20

just fyi..

centos:7 doesn't has swtpm while centos:{latest,8} does.
Should we consider getting it built manually? I can take a look on it if
desirable.

>  # FIXME: debug
>  echo "find /tss2_esys.h"
> --=20
> 2.18.4
>=20

With "swptm1" fixed:

Acked-by: Bruno Meneguele <bmeneg@redhat.com>

Thanks Mimi.

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl86lLgACgkQYdRkFR+R
okOqGAf/SUppt5VddcD7j28AD5/KsbwQwj1Qiws62al8Y22kHmhWY4Nz5T2zV/QV
zNNhGjpnIOdiyMA28gbszZqUOpQMR56adKwk/P11jjfGnYd4ZHQB9dCad/ro7dTU
1QXaRMWUWar6mHryj8RrluQNTWmvG4v/BxJn5musvLF+pXZpKJaJRginB+6DHIMB
2HH8jLXIHB0icNDil1m/lG6s50JLJZYvo8eRKVdM8F72+G9KHuLbysxHqHV9JhZV
LGfemDyNAqz98cD3UQQMnwOLj2UrzAoVKZl+q+MYJ3b75WoIf9K2Q7ZIxJmB8iiT
Al6FNOHb45LbthRLtqHnfMYm3jU0GQ==
=2/j+
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--

