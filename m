Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A1C406E12
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Sep 2021 17:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbhIJPUg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Sep 2021 11:20:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23164 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234130AbhIJPUg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Sep 2021 11:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631287164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R/WLUlQqyDR/GRDK+JhI0WpZ/U0CyBU3CETSLIGHlH8=;
        b=a0qgFMVxqbyH3rXXOyBzPs3/C+AbTmilmXC/T9/QlAb/Z310BgApJtcqAVaYEeUbwLmFp8
        mcK9Zwa04KFaDTtalrPBXcykwkbsVBAM7qvRfO2xJONwflrkg2LhisTnpPIQQ4cOGtmn/b
        GgC6tkrsYhEeYglwcJe7xhYqxRlZmEU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-SSHBSypSOBiVp1x6p02gbg-1; Fri, 10 Sep 2021 11:19:22 -0400
X-MC-Unique: SSHBSypSOBiVp1x6p02gbg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0704801A92;
        Fri, 10 Sep 2021 15:19:21 +0000 (UTC)
Received: from localhost (unknown [10.22.33.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E59F5C1A1;
        Fri, 10 Sep 2021 15:19:20 +0000 (UTC)
Date:   Fri, 10 Sep 2021 12:19:19 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Simon.THOBY@viveris.fr, kgold@linux.ibm.com,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v5 ima-evm-utils 1/2] set default hash algorithm in
 configuration time
Message-ID: <YTt3d7XqAoHDrQlp@glitch>
References: <20210902192427.314337-1-bmeneg@redhat.com>
 <20210902192427.314337-2-bmeneg@redhat.com>
 <ab238b241d1328c3933681b8b939b5e5a9288aaf.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Z2z1Y4F5HW+JzpqO"
Content-Disposition: inline
In-Reply-To: <ab238b241d1328c3933681b8b939b5e5a9288aaf.camel@linux.ibm.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--Z2z1Y4F5HW+JzpqO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 09, 2021 at 05:03:41PM -0400, Mimi Zohar wrote:
> On Thu, 2021-09-02 at 16:24 -0300, Bruno Meneguele wrote:
> > +       AC_ARG_WITH([default_hash],
> > +               AS_HELP_STRING([--with-default-hash=3DALGORITHM], [spec=
ifies the default hash algorithm to be used]),
> > +               [HASH_ALGO=3D$withval],
> > +               [HASH_ALGO=3Dsha1])
> > +
> > +       AC_CHECK_HEADER([$HASH_INFO_HEADER],
> > +               [HAVE_HASH_INFO_HEADER=3Dyes],
> > +               [AC_MSG_WARN([$HASH_INFO_HEADER not found.])])
> > +
> > +       if test "x$HAVE_HASH_INFO_HEADER" =3D "x"; then
> > +               AC_MSG_RESULT([using $HASH_ALGO algorithm as default ha=
sh algorith])
> > +               AC_DEFINE_UNQUOTED(DEFAULT_HASH_ALGO, "$HASH_ALGO", [De=
fine default hash algorithm])
> > +       else
> > +               AC_PROG_SED()
> > +               AC_PROG_GREP()
> > +               $SED -n 's/HASH_ALGO_\(.*\),/\L\1\E/p' $HASH_INFO_HEADE=
R | $GREP -w -i $HASH_ALGO > /dev/null
>=20
> This does an a case insensitive test for the hash algorithm, but the
> code itself doesn't support upper case hash algorithms (e.g. SHA1,
> SHA256).
>=20

This case-insensitive is actually redundant here, since in the 'sed' I'm
already lowering the case with '\L\1\E'. Will remove it.

> thanks,
>=20
> Mimi
>=20
>=20
> > +               have_hash=3D$?
> > +
> > +               if test $have_hash -ne 0; then
> > +                       AC_MSG_ERROR([$HASH_ALGO algorithm specified, b=
ut not provided by the kernel], 1)
> > +               else
> > +                       AC_MSG_NOTICE([using $HASH_ALGO as default hash=
 algorithm])
> > +                       AC_DEFINE_UNQUOTED(DEFAULT_HASH_ALGO, "$HASH_AL=
GO", [Define default hash algorithm])
> > +               fi
>=20
>=20

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--Z2z1Y4F5HW+JzpqO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAmE7d3cACgkQYdRkFR+R
okN9jQgAqh/2pVKHICuVpj8Cy+0DT5oCTeWQ27meKfesJCOVUEp11QRrVLppf9RF
ntQI/yXbUIAfEUvwLho5DlvX+nwIlFR8SWlMmYubzUR6MFRYI4l+s2WdXK73FQu7
CQjV2l3J/vpiFmGAgx9L7ExDL4kFiMbOwEs75GQWEOnqxFa3Gz9CLcyQ0EHnkw4O
k1AENjBDj4JZ+a39j3pK0YrUX9O7VA7RhXDP6EAY3F+9BZCPTOm08B4nEmbR/h/0
PpQQQ+SAlxWBngEpMgzeCoDCxM/Hui6K37zMkyzxXJWkj95gIrcAl59R9IZ+6j6L
ZKPVbAdVjxTb/yDMtJzkoCvtqMBOwA==
=yyVb
-----END PGP SIGNATURE-----

--Z2z1Y4F5HW+JzpqO--

