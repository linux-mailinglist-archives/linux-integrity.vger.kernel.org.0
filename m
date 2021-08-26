Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936533F8917
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Aug 2021 15:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242729AbhHZNgp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 26 Aug 2021 09:36:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22306 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242644AbhHZNgo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Aug 2021 09:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629984957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FNJXjENmiJP8VP1mC2nn5kzqRMzER0E25H1qNDEi8eM=;
        b=PGWPBlnXJ8t80ZMFHhp39+y9KrYiBFKvfoeMw971/V5FyQWGjIgrJU1sEeyFJMv7x94/0L
        JQHTFLjRTyoCTpc791KOT8LcztL5L1trBQ33vQR3rPg+ITTAmqG/b3giQ8m5qA3ySQ5E3O
        Bgy0BHfiebsmpmDx3zyBHJqdSip92o0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-q1NYaNtgPxm-xLkGMwUTOw-1; Thu, 26 Aug 2021 09:35:55 -0400
X-MC-Unique: q1NYaNtgPxm-xLkGMwUTOw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8FB892502;
        Thu, 26 Aug 2021 13:35:53 +0000 (UTC)
Received: from localhost (unknown [10.22.8.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2B40F60C04;
        Thu, 26 Aug 2021 13:35:52 +0000 (UTC)
Date:   Thu, 26 Aug 2021 10:35:52 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Simon.THOBY@viveris.fr, kgold@linux.ibm.com,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 ima-evm-utils 1/2] set default hash algorithm in
 configuration time
Message-ID: <YSeYuNglsE3XWBSA@glitch>
References: <20210820230001.102249-1-bmeneg@redhat.com>
 <20210820230001.102249-2-bmeneg@redhat.com>
 <3ea0519200137128c67556b9c627a4849ddfbd24.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="loU+pg6pQEqg2kR1"
Content-Disposition: inline
In-Reply-To: <3ea0519200137128c67556b9c627a4849ddfbd24.camel@linux.ibm.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--loU+pg6pQEqg2kR1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 25, 2021 at 05:43:50PM -0400, Mimi Zohar wrote:
> Hi Bruno,
>=20
> On Fri, 2021-08-20 at 20:00 -0300, Bruno Meneguele wrote:
> > The default hash algorithm for evmctl is today hardcoded libimaevm.c fi=
le.
> > To facilitate different distributions and users to set their own default
> > hash algorithm this patch adds the --with-default-hash=3D<algo> option =
to the
> > configuration script.
> >=20
> > The algorithm chosen by the user will then be checked if is available i=
n the
> > kernel, otherwise IMA won't be able to verify files hashed by the user.=
 For
> > that, the file exposed by the kernel crypto API (/proc/crypto) is filte=
red
> > by an AWK script in order to check the algorithm's name and the module
> > providing it. Initally, only "module: kernel" is accepted, following IM=
A's
> > CONFIG_CRYPTO_SHA1/SHA256 dependency.
>=20
> There's a difference between preventing an evmctl user from
> unintentionally using an unsupported algorithm and the distro, or
> whoever is building the package, defining the wrong default hash
> algorithm.
>=20
> My preference would be to allow any hash algorithm defined in
> hash_info.h (kernel_headers package) as the default.
>=20

Good point. Considering we already depend on the kernel-headers pkg and
we also allow the user to specify a custom path for headers, it's indeed
better to keep the consistency.

I'll prepare a v5 using the kernel-headers instead of /proc/crypto.

> thanks,
>=20
> Mimi
>=20

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--loU+pg6pQEqg2kR1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAmEnmLcACgkQYdRkFR+R
okMsRQf3Zd80jdgSn0IxlblPzseLiEFBZCtKMF+dV5EplT8qQedVuQEcNECl29qg
KChq2MLIDLKAznYNhg2gVImaBKz4lV2teaIlyH2aA2UkO3uIL+SjD6yz/0Tb0IQW
zGMisl6RTii3CXGu2r2lQuns3okNJQjppEXYcJ+xE6lS9sEnBIhYTSGlBxmtZ2xw
+LQdAwPzv9jbmkNu7POa5+aQdYkUYCfCJC7MAVgdXOCxzJZGYgkQMXaNk8GrxYiD
TilqyNJf5jA8pgIOdmNG+O0/lXbpJgaDCZ90HcGj33qQZMrgx7Q3UfniUQMXvVW8
k0dKQZtKSaxHqNJ536+9HSFdYtI/
=h45h
-----END PGP SIGNATURE-----

--loU+pg6pQEqg2kR1--

