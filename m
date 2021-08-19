Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5901D3F1FE3
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Aug 2021 20:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbhHSS2d (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Aug 2021 14:28:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40298 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233971AbhHSS23 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Aug 2021 14:28:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629397672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d9MNxT3E+bD6pm+uJnNqefG1uGPBTmSjG2n2YsRHJbY=;
        b=FqkTSUdH2HsaKkNpBgNaNd/gs3OtT8EbfVWiNYpXWEvEEFzSWLqKI4dP/AKE/21UzO2e95
        DKTWCAIAnvALkIFkQyxrzV32SzRlFRV8xO4k0ciBRKQvzT8H5c+oqDabM77cGDiRKT/uWj
        aT4xbynRM9Ip9/GPWBkR4GoNG6FRLA8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-8lcdHXsqNdi8Uh7eIqQJyA-1; Thu, 19 Aug 2021 14:27:50 -0400
X-MC-Unique: 8lcdHXsqNdi8Uh7eIqQJyA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8E0C1082920;
        Thu, 19 Aug 2021 18:27:48 +0000 (UTC)
Received: from localhost (unknown [10.22.17.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E9B760938;
        Thu, 19 Aug 2021 18:27:47 +0000 (UTC)
Date:   Thu, 19 Aug 2021 15:27:46 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH ima-evm-utils v2] Use secure heap for private keys and
 passwords
Message-ID: <YR6iotDjqKTsPOPw@glitch>
References: <20210819021136.664597-1-vt@altlinux.org>
 <600a9f93ca6e74621833cd9452a9dfd7b5a8d55a.camel@linux.ibm.com>
 <20210819181225.vo7dmtm3z5mnwmlh@altlinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gjbQcsFvl4RHpbCm"
Content-Disposition: inline
In-Reply-To: <20210819181225.vo7dmtm3z5mnwmlh@altlinux.org>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--gjbQcsFvl4RHpbCm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 19, 2021 at 09:12:25PM +0300, Vitaly Chikunov wrote:
> Mimi,
>=20
> On Thu, Aug 19, 2021 at 02:06:03PM -0400, Mimi Zohar wrote:
> > On Thu, 2021-08-19 at 05:11 +0300, Vitaly Chikunov wrote:
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
> >=20
> > Not sure why it isn't applying with/without Bruno's v2 patch.
>=20
> It should be over next-testing + (manually git am'ed) Bruno's patch:
>=20
>   db25fcd 2021-08-19 03:20:48 +0300 Use secure heap for private keys and =
passwords (Vitaly Chikunov)
>   d37ea6d 2021-08-16 12:15:59 -0300 evmctl: fix memory leak in get_passwo=
rd (Bruno Meneguele)
>   b1818c1 2021-08-03 16:40:08 -0400 Create alternative tpm2_pcr_read() th=
at uses IBM TSS (Ken Goldman) (origin/next-testing)
>=20
> >=20
> > >=20
> > >  src/evmctl.c | 143 ++++++++++++++++++++++++++++++++++++++++++-------=
--
> > >  1 file changed, 118 insertions(+), 25 deletions(-)
> > >=20
> > > diff --git a/src/evmctl.c b/src/evmctl.c
> >=20
> > > @@ -188,7 +207,9 @@ static int bin2file(const char *file, const char =
*ext, const unsigned char *data
> > >  	return err;
> > >  }
> > >=20
> > > -static unsigned char *file2bin(const char *file, const char *ext, in=
t *size)
> > > +/* Return data in OpenSSL secure heap if 'secure' is true. */
> > > +static unsigned char *file2bin(const char *file, const char *ext, in=
t *size,
> > > +			       int secure)
> > >  {
> > >  	FILE *fp;
> > >  	size_t len;
> > > @@ -215,7 +236,10 @@ static unsigned char *file2bin(const char *file,=
 const char *ext, int *size)
> > >  	}
> > >  	len =3D stats.st_size;
> > >=20
> > > -	data =3D malloc(len);
> > > +	if (secure)
> > > +		data =3D OPENSSL_secure_malloc(len);
> > > +	else
> > > +		data =3D malloc(len);
> >=20
> > Without being able to apply the patch, it's hard to tell if there
> > should be a preparatory patch that first replaces malloc() with
> > OPENSSL_malloc(), and other similar changes.
>=20
> There is no OPENSSL_malloc use and I don't see why it should be.
>=20

Keeping the OPENSSL_* calls as a meaning of "secure calls" while keeping
the standard C library calls for "non-secure" seems indeed cleaner.

> Thanks,
>=20
> >=20
> > thanks,
> >=20
> > Mimi
> >=20
> > >  	if (!data) {
> > >  		log_err("Failed to malloc %zu bytes: %s\n", len, name);
> > >  		fclose(fp);
>=20

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--gjbQcsFvl4RHpbCm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAmEeoqIACgkQYdRkFR+R
okNCmwgA1YYCUn3X7uYt0V9NyWBdqIUinDXzESX8N9aUfoCwVsYO1kWxa+DWPHOk
Ds5hbP4Fh0KtmK1E4zuy281codBNAqCErEgmdWf7QN7sRF/D+X9PRSxXY8CjbaXd
Rrw30Dtl+8dlKLxNAw7CVzgi5KD8tKW4+N2KmLRPFGiI7BkHFEW68wvbR8+GaeiF
heRs6q7VGJCs7uw4eizkLUxFgUAHncZM4XwDUhbCHjZEhYgBg9Lf2cz9jYTTXqjW
NJfRwwDUEOnH5gWry8q12BmVMhssT6D7/bwv9idT4jMbr9vO/4P/3S0yZEtrflxL
q96Nu2xBGEmrLJdNIkZoSe6vzv3ZnQ==
=u1NK
-----END PGP SIGNATURE-----

--gjbQcsFvl4RHpbCm--

