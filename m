Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E844C2217D1
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Jul 2020 00:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgGOWeL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jul 2020 18:34:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22269 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726356AbgGOWeK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jul 2020 18:34:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594852449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d61MUL7QpAWnUav5BnCiYuk8Ume6rixQlfeLN3Ca2Dk=;
        b=Ind7Zmtibp6FjQO79kvCzzy7SQT0p6St63RM8GCNTq4zB6QUnv6Pa5IlQhu9ARFcB0imxc
        HwkNSCoiZnKh+T6+qfvplQd6Eu7QriZaWAGZPIckjIxxiTx7VGVfwaYFgNTQqqvhDyySkd
        HtgjUzEXlWtzfX2iKQDPF1hMSOMzdBw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-dBmeazu-PE2xWTuxNTBASw-1; Wed, 15 Jul 2020 18:34:01 -0400
X-MC-Unique: dBmeazu-PE2xWTuxNTBASw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0930E1083;
        Wed, 15 Jul 2020 22:34:00 +0000 (UTC)
Received: from localhost (ovpn-116-38.gru2.redhat.com [10.97.116.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9029319C58;
        Wed, 15 Jul 2020 22:33:59 +0000 (UTC)
Date:   Wed, 15 Jul 2020 19:33:58 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Vitaly Chikunov <vt@altlinux.org>
Subject: Re: [PATCH 3/3] ima-evm-utils: fix overflow on printing
 boot_aggregate
Message-ID: <20200715223358.GK3720@glitch>
References: <20200715213906.194041-1-bmeneg@redhat.com>
 <20200715213906.194041-4-bmeneg@redhat.com>
 <1594852207.12900.350.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <1594852207.12900.350.camel@linux.ibm.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/0P/MvzTfyTu5j9Q"
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

--/0P/MvzTfyTu5j9Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2020 at 06:30:07PM -0400, Mimi Zohar wrote:
> On Wed, 2020-07-15 at 18:39 -0300, Bruno Meneguele wrote:
> > diff --git a/src/evmctl.c b/src/evmctl.c
> > index 2f5bd52..2bd37c2 100644
> > --- a/src/evmctl.c
> > +++ b/src/evmctl.c
> > @@ -2252,7 +2252,8 @@ static int cmd_ima_bootaggr(struct command *cmd)
> >  =09=09bootaggr_len +=3D strlen(tpm_banks[i].algo_name) + 1;
> >  =09=09bootaggr_len +=3D (tpm_banks[i].digest_size * 2) + 1;
> >  =09}
> > -=09bootaggr =3D malloc(bootaggr_len);
> > +=09/* Make room for the leading \0 */
>=20
> ^Trailing null
>=20

hahah.. of course.

Thanks :)

> Mimi
>=20
> > +=09bootaggr =3D malloc(bootaggr_len + 1);
> > =20
> >  =09/*
> >  =09 * Calculate and convert the per TPM 2.0 PCR bank algorithm
>=20

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--/0P/MvzTfyTu5j9Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl8PhFYACgkQYdRkFR+R
okPcigf/X7UiavKFcyHvBvYMFD/tsvfBDDeTNVsI4hWl6IlRDCfxgqrWDr50lp7k
UCA3gVZruGAflGPqg/jzdqxHRxvzt/fireanRa1yuO1sdHMWPlyK1pobfnEqoGSm
UlfXoVUOcTjGv5mjT+K86pYdUd9+fkmbE103pojbVWdU9k0kvByQUTH28yWZ4VZr
lQ/5pHhAabU6OTokSjbPg/9KG9jWUNFbmrh/0ifhoQm0gPbB853Pe7CikXmCkvlj
lYgtAnn2w+zDdmqA8feAzKzUbr5dGkmQI8qeXIP4weJ+hO+YoLv7ezAnsiqyRCCW
iIHefaeCxRBUac+3Sc92UsrzKcboeQ==
=0s8D
-----END PGP SIGNATURE-----

--/0P/MvzTfyTu5j9Q--

