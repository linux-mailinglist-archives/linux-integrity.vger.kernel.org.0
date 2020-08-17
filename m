Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6560D24722F
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Aug 2020 20:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730440AbgHQSkC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Aug 2020 14:40:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59071 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390984AbgHQSjc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Aug 2020 14:39:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597689569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zFIHa4iEZZVnZJjVtrBG1ovRW7mnpDRqS4yl/QNtM4g=;
        b=QbAeTTGh2JmFIFMyJDqiqrp8sCxOKmmL5io6PBbrGv3C91X7qchVwTeOnzECrWnIgYT/Yo
        YKBwuDrxKCpa1dlEWrxpIM3OAq0Tc+D9+IPjWjlOeYLYglhyz0jHJNddXt4r+vF8kr8vEQ
        DmTEb7pkyfKypJbY344Mr0zov2k5bn8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-n9F08lX1PEi90BeuayB71g-1; Mon, 17 Aug 2020 14:39:07 -0400
X-MC-Unique: n9F08lX1PEi90BeuayB71g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64FFC1868F80;
        Mon, 17 Aug 2020 18:39:06 +0000 (UTC)
Received: from localhost (ovpn-116-138.gru2.redhat.com [10.97.116.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EECB57849A;
        Mon, 17 Aug 2020 18:39:05 +0000 (UTC)
Date:   Mon, 17 Aug 2020 15:39:04 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>
Subject: Re: [PATCH ima-evm-utils 0/9] Docker based Travis CI builds
Message-ID: <20200817183904.GK4781@glitch>
References: <20200813182532.6931-1-pvorel@suse.cz>
MIME-Version: 1.0
In-Reply-To: <20200813182532.6931-1-pvorel@suse.cz>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bmeneg@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/rDaUNvWv5XYRSKj"
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

--/rDaUNvWv5XYRSKj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2020 at 08:25:23PM +0200, Petr Vorel wrote:
> Hi,
>=20
> we talked about Docker based Travis CI builds.
> Here they are [1]. Working on it revealed few bugs, that's why they're
> included.
>=20
> I've resent 2 commits ("man:" prefix).
>=20
> I haven't addressed Mimi's suggestion to replace ibmswtpm2 with libtmps/s=
wtpm [2].
>=20
> Kind regards,
> Petr
>=20
> [1] https://travis-ci.org/github/pevik/ima-evm-utils/builds/717681733
> [2] https://github.com/stefanberger/swtpm/wiki/Using-the-IBM-TSS-with-swt=
pm
>=20
> Petr Vorel (9):
>   configure: Fix tss2-esys check
>   man: Fix xmlcatalog path detection
>   man: Generate doc targets only when XSL found
>   install-swtpm.sh: Ignore certificate for download
>   install-swtpm.sh: Update ibmtpm to version 1637
>   Remove install-tpm2-tss.sh
>   autogen.sh: Cleanup
>   tests: Require cmp
>   travis: Switch to docker based builds
>=20
>  .travis.yml                    | 106 +++++++++++++++++++++++----------
>  Makefile.am                    |   4 ++
>  autogen.sh                     |  14 +----
>  build.sh                       |  97 ++++++++++++++++++++++++++++++
>  configure.ac                   |   7 ++-
>  m4/manpage-docbook-xsl.m4      |  38 +++++++++---
>  tests/install-swtpm.sh         |  10 ++--
>  tests/install-tpm2-tss.sh      |  19 ------
>  tests/sign_verify.test         |   9 ++-
>  travis/alpine.sh               |  50 ++++++++++++++++
>  travis/centos.sh               |   1 +
>  travis/debian.cross-compile.sh |  23 +++++++
>  travis/debian.i386.sh          |  11 ++++
>  travis/debian.sh               |  54 +++++++++++++++++
>  travis/fedora.sh               |  49 +++++++++++++++
>  travis/opensuse.sh             |   1 +
>  travis/tumbleweed.sh           |  45 ++++++++++++++
>  travis/ubuntu.sh               |   1 +
>  18 files changed, 457 insertions(+), 82 deletions(-)
>  create mode 100755 build.sh
>  delete mode 100755 tests/install-tpm2-tss.sh
>  create mode 100755 travis/alpine.sh
>  create mode 120000 travis/centos.sh
>  create mode 100755 travis/debian.cross-compile.sh
>  create mode 100755 travis/debian.i386.sh
>  create mode 100755 travis/debian.sh
>  create mode 100755 travis/fedora.sh
>  create mode 120000 travis/opensuse.sh
>  create mode 100755 travis/tumbleweed.sh
>  create mode 120000 travis/ubuntu.sh
>=20
> --=20
> 2.28.0
>=20

I've tested it in both Fedora and CentOS 8 (RHEL actually).

Reviewed-by: Bruno Meneguele <bmeneg@redhat.com>

Thanks Petr.

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--/rDaUNvWv5XYRSKj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl86zsgACgkQYdRkFR+R
okMO0wgAkkrmcCzFP6ruL66iwEJwqM1F2isW2mVhifBCl2ElsJc/77kiKM2JdrSU
7vsYMdkLisCTal8EVIPcBBDXg3AUZQAa8IyjuQSc+rkqUgmNE4PDTON3HDVtdWlt
VTtcl9lpZi7C31tLjJ+DSYqtRisi5uiSrbbYFg1aBJ7nY2KPXiKJEFwk5QZHRsoW
3AD2I5ulKxtuY7oB8JuAiSspHoU7AuNLidMS/XDfmHluJP5U299/5w2CC7QpCnRd
EcToB1LfqUJDIjIbuRyj0CJeIeP3lwDeYa9iVkuguJXUedKrJjOcAzjZUJNLP2OM
krO+padDFCAX4xCqPixaXhMKUb2EEQ==
=HEsc
-----END PGP SIGNATURE-----

--/rDaUNvWv5XYRSKj--

