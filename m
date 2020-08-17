Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6816924721A
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Aug 2020 20:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731046AbgHQSiX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Aug 2020 14:38:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46959 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730862AbgHQSiR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Aug 2020 14:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597689494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KgoKOjJ+F5R8G53y23ZDMWjhERGu+EU8qlL6INfC8c0=;
        b=ch+9ha55I4xAlsgFPvybkXrPv6CttKn/KvUn9hhEdbG1RP/q4HIs0nobhZLtrjBn6evc7v
        vyrxJMU97y3GhvVL0J+kChsXmgmRyCBHoMvEc1+kcXgj87Zqdl9Emn7fODR3h5iGqnhxXI
        1djpDleLDHcjmv98KTMOLI9mlhi6uUs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-ENpgvRLBPYGu7AA8w3EBBQ-1; Mon, 17 Aug 2020 14:38:09 -0400
X-MC-Unique: ENpgvRLBPYGu7AA8w3EBBQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2A7F1015DD4;
        Mon, 17 Aug 2020 18:38:08 +0000 (UTC)
Received: from localhost (ovpn-116-138.gru2.redhat.com [10.97.116.138])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 41A50756AB;
        Mon, 17 Aug 2020 18:38:08 +0000 (UTC)
Date:   Mon, 17 Aug 2020 15:38:06 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>
Subject: Re: [PATCH ima-evm-utils 9/9] travis: Switch to docker based builds
Message-ID: <20200817183806.GJ4781@glitch>
References: <20200813182532.6931-1-pvorel@suse.cz>
 <20200813182532.6931-10-pvorel@suse.cz>
 <20200817080451.GA21486@dell5510>
MIME-Version: 1.0
In-Reply-To: <20200817080451.GA21486@dell5510>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bmeneg@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wRtZRu2mMGBZ6YQ7"
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

--wRtZRu2mMGBZ6YQ7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2020 at 10:04:51AM +0200, Petr Vorel wrote:
> Hi Mimi,
>=20
> I'm sorry I left debugging code in travis/fedora.sh.
>=20
> > --- /dev/null
> > +++ b/travis/fedora.sh
> > @@ -0,0 +1,49 @@
> > +#!/bin/sh
> > +# Copyright (c) 2020 Petr Vorel <pvorel@suse.cz>
> > +set -e
> > +
> > +if [ -z "$CC" ]; then
> > +=09echo "missing \$CC!" >&2
> > +=09exit 1
> > +fi
> > +
> > +case "$TSS" in
> > +ibmtss) TSS=3D"tss2-devel";;

Unfortunately tss2 is only shipped for ppc64 today on CentOS. But there
are plans to enable it to all other supported arches soon.

> > +tpm2-tss) TSS=3D"tpm2-tss-devel";;
> > +'') echo "Missing TSS!" >&2; exit 1;;
> > +*) echo "Unsupported TSS: '$TSS'!" >&2; exit 1;;
> > +esac
> > +
> > +# ibmswtpm2 requires gcc
> > +[ "$CC" =3D "gcc" ] || CC=3D"gcc $CC"
> > +
> > +yum -y install \
> > +=09$CC $TSS \
> > +=09asciidoc \
> > +=09attr \
> > +=09autoconf \
> > +=09automake \
> > +=09diffutils \
> > +=09docbook-xsl \
> > +=09gzip \
> > +=09keyutils-libs-devel \
> > +=09libattr-devel \
> > +=09libtool \
> > +=09libxslt \
> > +=09make \
> > +=09openssl \
> > +=09openssl-devel \
> > +=09pkg-config \
> > +=09procps \
> > +=09sudo \
> > +=09vim-common \
> > +=09wget \
> > +=09which
> > +
> > +yum -y install docbook5-style-xsl || true
>=20
> These lines below needs to be removed.

+1

> > +
> > +# FIXME: debug
> > +echo "find /tss2_esys.h"
> > +find /usr/ 2>/dev/null |grep /tss2_esys.h || true
> > +echo "cat /usr/include/tss2/tss2_esys.h"
> > +cat /usr/include/tss2/tss2_esys.h || true
>=20
> Kind regards,
> Petr
>=20

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--wRtZRu2mMGBZ6YQ7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl86zo4ACgkQYdRkFR+R
okN8dwgAnzLZJzIssOyP4pZtTQ+vXplnC7NIwRZMW64E4TKRvFP/Q9LRVRkWhJkx
QgdpPb/v8tz+jqEYloaybi7DejzjnJrbc8fwMSNJ3p2fJg5gIOU/nZxBeVcLdVZ5
BGyEheiK/9fQWiG11SVSmvd9CwTzHUUzO5hRgrWXc60F+kiCzDBJI/kWjqzi9Roy
ttbn/9bXYh5QSEWi8IG4ojEQ5wKBSJKlf13ucjN1mjmAboLmkl8QGEzPGNJWGU6+
eRPDTj39TC4VS0jDJhUNILcKVnPGRDBWgQcH1GLIgOs69cfa4pejFCjfQnDUYDVt
fCz+o5G1lRlp6ziQiiwzab5LK3aKuQ==
=1rah
-----END PGP SIGNATURE-----

--wRtZRu2mMGBZ6YQ7--

