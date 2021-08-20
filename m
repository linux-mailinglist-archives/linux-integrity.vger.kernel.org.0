Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01ED3F2CC7
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Aug 2021 15:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238510AbhHTNJB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Aug 2021 09:09:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24630 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238220AbhHTNJA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Aug 2021 09:09:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629464902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=83bfKRTZeq7qUnDrel6FGJ1XrDFKfUfJUtuqHb6cHDQ=;
        b=X03MyzYy6WRVtzzL79HmHOSMwCuDzgTyvyaqNp2au0Lx9kfd3GmJGolNML9XooAvYUaKeK
        x3VSloPGvNcsp48K424asd/Zz+ztV5KlseQXfz1rfV9OHJ2xJAJxwdPakvO2KdKd+Wts4p
        6TCqSdkFeZ7cRExmzqTlTEco5KJYD1g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-MCtojGdfO9GzsOermMKTXA-1; Fri, 20 Aug 2021 09:08:20 -0400
X-MC-Unique: MCtojGdfO9GzsOermMKTXA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7EA8FC7400;
        Fri, 20 Aug 2021 13:08:19 +0000 (UTC)
Received: from localhost (unknown [10.22.33.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1587B60C4A;
        Fri, 20 Aug 2021 13:08:18 +0000 (UTC)
Date:   Fri, 20 Aug 2021 10:08:17 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH ima-evm-utils v2] Use secure heap for private keys and
 passwords
Message-ID: <YR+pQabnJwsV9nUA@glitch>
References: <20210819021136.664597-1-vt@altlinux.org>
 <YR6iwRZ9GCK272Me@glitch>
 <20210819220445.vbytidpcm7tiou5l@altlinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BBIy9R7UsazbFS4l"
Content-Disposition: inline
In-Reply-To: <20210819220445.vbytidpcm7tiou5l@altlinux.org>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--BBIy9R7UsazbFS4l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 20, 2021 at 01:04:45AM +0300, Vitaly Chikunov wrote:
> Bruno,
>=20
> On Thu, Aug 19, 2021 at 03:28:17PM -0300, Bruno Meneguele wrote:
> > On Thu, Aug 19, 2021 at 05:11:36AM +0300, Vitaly Chikunov wrote:
> > > After CRYPTO_secure_malloc_init OpenSSL will store private keys in
> > > secure heap. This facility is only available since OpenSSL_1_1_0-pre1.
> > >=20
> > > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> > > ---
> > > Change from v1:
> > > - Do not use setfbuf to disable buffering as this is not proven to be
> > >   meaningful.
> > > - Use secure heap for passwords too as suggested by Mimi Zohar.
> > > - Fallback to OPENSSL_malloc for old OpenSSL as suggested by Mimi Zoh=
ar.
> > > - Simplify logic of calling CRYPTO_secure_malloc_init (call it always=
 on
> > >   OpenSSL init.)
> > > - Should be applied after Bruno Meneguele's "evmctl: fix memory leak =
in
> > >   get_password" patch v2.
> > >=20
> > >  src/evmctl.c | 143 ++++++++++++++++++++++++++++++++++++++++++-------=
--
> > >  1 file changed, 118 insertions(+), 25 deletions(-)
> > >=20
> > > diff --git a/src/evmctl.c b/src/evmctl.c
> > > index 5f7c2b8..a27e0b9 100644
> > > --- a/src/evmctl.c
> > > +++ b/src/evmctl.c
> > > @@ -59,6 +59,7 @@
> > >  #include <assert.h>
> > > =20
> > >  #include <openssl/asn1.h>
> > > +#include <openssl/crypto.h>
> > >  #include <openssl/sha.h>
> > >  #include <openssl/pem.h>
> > >  #include <openssl/hmac.h>
> > > @@ -165,6 +166,24 @@ struct tpm_bank_info {
> > >  static char *pcrfile[MAX_PCRFILE];
> > >  static unsigned npcrfile;
> > > =20
> > > +#if OPENSSL_VERSION_NUMBER <=3D 0x10100000
> > > +#warning Your OpenSSL version is too old to have OPENSSL_secure_mall=
oc, \
> > > +	falling back to use plain OPENSSL_malloc.
> > > +#define OPENSSL_secure_malloc	  OPENSSL_malloc
> > > +#define OPENSSL_secure_free	  OPENSSL_free
> > > +/*
> > > + * Secure heap memory automatically cleared on free, but
> > > + * OPENSSL_secure_clear_free will be used in case of fallback
> >=20
> > Shouldn't it be OPENSSL_clear_free instead of OPENSLL_secure_clear_free
> > in the setence above?
>=20
> No. I meant our code will use OPENSSL_secure_clear_free, so when there
> is no secure heap it will fallback to OPENSSL_clear_free (and not just
> to OPENSSL_free if we used OPENSSL_secure_free).
>=20
> Thanks,
>=20

Ah ok, I misread the sentence.
Thanks for the clarification.

It seems you'll send a new version of the patch, right?
Will review that as soon as it lands.

Many thanks.

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--BBIy9R7UsazbFS4l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAmEfqUEACgkQYdRkFR+R
okOMIQf9FYrx25bfjTW6ONdfFzUycYRmnaKx5plzqSrACVMTnw8NJf1Py3Seid9C
qggwBJ9Cq1SV7GhPtQozxrO9LDeDyT7nVYwAm+dLT6ZIU4tyHiNfssdqg4J7SkHY
9btVfAOqRto79wEVTKNmFaVswXppTKpJM+nwgpus9cmZ3ioF17miSp/W1K6KFhW2
yQSEDko6aNAzn8b+bJkzFMgz+XfLESyIlLOiVTdF8p/MOR/6/BnuzKQr7WRDeaJO
viK28Serm9WMQKpJ+KNmbbE1YhIDtXjkVDo6tIBYMheLl5ZZqu2wHnJGT107Lxfu
gZ8/fTiL1YJqYqXqg8N3PPvY0g+Brw==
=CR96
-----END PGP SIGNATURE-----

--BBIy9R7UsazbFS4l--

