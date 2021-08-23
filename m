Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09E53F501C
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Aug 2021 20:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhHWSKI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 Aug 2021 14:10:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45394 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229837AbhHWSKG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Aug 2021 14:10:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629742163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cQoZ489elLwkY+jDgTpXtLoufWppSD8lq/ciN4Lj2kA=;
        b=GxOtA3c7OP3BhMuHZk0K4C85X66b/8UxvXIcGvAz/XvXNGjlBG6344rlPELmupAallqYZe
        765RLDKE9rMIe1jRtj9OanjAYPOHKHXQVHOUO0MD/Ub03xYzWdU1ZfdEJCoCLb6JRKz/nR
        6zzn0vhFLwLfCaTckzKpB1lJ+15KlQ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-F7hr0B9YPu2IzjzvrdNsnw-1; Mon, 23 Aug 2021 14:09:21 -0400
X-MC-Unique: F7hr0B9YPu2IzjzvrdNsnw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 08E7393920;
        Mon, 23 Aug 2021 18:09:20 +0000 (UTC)
Received: from localhost (unknown [10.22.17.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8ECCB10016F5;
        Mon, 23 Aug 2021 18:09:19 +0000 (UTC)
Date:   Mon, 23 Aug 2021 15:09:18 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH ima-evm-utils v3] Use secure heap for private keys and
 passwords
Message-ID: <YSPkTiTAo8rswaGZ@glitch>
References: <20210822001055.1772873-1-vt@altlinux.org>
 <YSOhBXD/FUIa9QLz@glitch>
 <20210823165937.n4rrmx2dwgje6sca@altlinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d6U4keMCvX4AkFum"
Content-Disposition: inline
In-Reply-To: <20210823165937.n4rrmx2dwgje6sca@altlinux.org>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--d6U4keMCvX4AkFum
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 23, 2021 at 07:59:37PM +0300, Vitaly Chikunov wrote:
> Bruno,
>=20
> On Mon, Aug 23, 2021 at 10:22:13AM -0300, Bruno Meneguele wrote:
> > On Sun, Aug 22, 2021 at 03:10:55AM +0300, Vitaly Chikunov wrote:
> > > After CRYPTO_secure_malloc_init OpenSSL will store private keys in
> > > secure heap. This facility is only available since OpenSSL_1_1_0-pre1.
> > >=20
> > > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> > > ---
> > >  src/evmctl.c | 148 +++++++++++++++++++++++++++++++++++++++++--------=
--
> > >  1 file changed, 121 insertions(+), 27 deletions(-)
> > >=20
> > > diff --git a/src/evmctl.c b/src/evmctl.c
> > > index 5f7c2b8..cebe9ec 100644
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
> > > + * to plain OPENSSL_malloc.
> > > + */
> > > +#define OPENSSL_secure_clear_free OPENSSL_clear_free
> > > +#define OPENSSL_clear_free(ptr, num)		\
> > > +	do {					\
> > > +		OPENSSL_cleanse(ptr, num);	\
> > > +		OPENSSL_free(ptr);		\
> > > +	} while (0)
> > > +#endif
> > > +
> > >  static int bin2file(const char *file, const char *ext, const unsigne=
d char *data, int len)
> > >  {
> > >  	FILE *fp;
> > > @@ -188,7 +207,9 @@ static int bin2file(const char *file, const char =
*ext, const unsigned char *data
> > >  	return err;
> > >  }
> > > =20
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
> > > =20
> > > -	data =3D malloc(len);
> > > +	if (secure)
> > > +		data =3D OPENSSL_secure_malloc(len);
> > > +	else
> > > +		data =3D malloc(len);
> > >  	if (!data) {
> > >  		log_err("Failed to malloc %zu bytes: %s\n", len, name);
> > >  		fclose(fp);
> > > @@ -224,7 +248,10 @@ static unsigned char *file2bin(const char *file,=
 const char *ext, int *size)
> > >  	if (fread(data, len, 1, fp) !=3D 1) {
> > >  		log_err("Failed to fread %zu bytes: %s\n", len, name);
> > >  		fclose(fp);
> > > -		free(data);
> > > +		if (secure)
> > > +			OPENSSL_secure_clear_free(data, len);
> > > +		else
> > > +			free(data);
> > >  		return NULL;
> > >  	}
> > >  	fclose(fp);
> > > @@ -872,7 +899,7 @@ static int verify_ima(const char *file)
> > >  	int len;
> > > =20
> > >  	if (sigfile) {
> > > -		void *tmp =3D file2bin(file, "sig", &len);
> > > +		void *tmp =3D file2bin(file, "sig", &len, 0);
> > > =20
> > >  		if (!tmp) {
> > >  			log_err("Failed reading: %s\n", file);
> > > @@ -1001,7 +1028,7 @@ static int cmd_import(struct command *cmd)
> > > =20
> > >  		if (!pkey)
> > >  			return 1;
> > > -		pub =3D file2bin(inkey, NULL, &len);
> > > +		pub =3D file2bin(inkey, NULL, &len, 0);
> > >  		if (!pub) {
> > >  			EVP_PKEY_free(pkey);
> > >  			return 1;
> > > @@ -1040,9 +1067,9 @@ static int setxattr_ima(const char *file, char =
*sig_file)
> > >  	int len, err;
> > > =20
> > >  	if (sig_file)
> > > -		sig =3D file2bin(sig_file, NULL, &len);
> > > +		sig =3D file2bin(sig_file, NULL, &len, 0);
> > >  	else
> > > -		sig =3D file2bin(file, "sig", &len);
> > > +		sig =3D file2bin(file, "sig", &len, 0);
> > >  	if (!sig)
> > >  		return 0;
> > > =20
> > > @@ -1082,9 +1109,9 @@ static int calc_evm_hmac(const char *file, cons=
t char *keyfile, unsigned char *h
> > >  	unsigned int mdlen;
> > >  	char **xattrname;
> > >  	unsigned char xattr_value[1024];
> > > -	unsigned char *key;
> > > +	unsigned char *key; /* @secure heap */
> > >  	int keylen;
> > > -	unsigned char evmkey[MAX_KEY_SIZE];
> > > +	unsigned char *evmkey; /* @secure heap */
> > >  	char list[1024];
> > >  	ssize_t list_size;
> > >  	struct h_misc_64 hmac_misc;
> > > @@ -1096,21 +1123,30 @@ static int calc_evm_hmac(const char *file, co=
nst char *keyfile, unsigned char *h
> > >  	pctx =3D HMAC_CTX_new();
> > >  #endif
> > > =20
> > > -	key =3D file2bin(keyfile, NULL, &keylen);
> > > +	key =3D file2bin(keyfile, NULL, &keylen, 1);
> > >  	if (!key) {
> > >  		log_err("Failed to read a key: %s\n", keyfile);
> > >  		return -1;
> > >  	}
> > > =20
> > > -	if (keylen > sizeof(evmkey)) {
> > > +	evmkey =3D OPENSSL_secure_malloc(MAX_KEY_SIZE);
> > > +	if (!evmkey) {
> > > +		log_err("Failed to allocate %d bytes\n", MAX_KEY_SIZE);
> > > +		goto out;
> > > +	}
> > > +
> > > +	if (keylen > MAX_KEY_SIZE) {
> > >  		log_err("key is too long: %d\n", keylen);
> > >  		goto out;
> > >  	}
> > > =20
> > >  	/* EVM key is 128 bytes */
> > >  	memcpy(evmkey, key, keylen);
> > > -	if (keylen < sizeof(evmkey))
> > > -		memset(evmkey + keylen, 0, sizeof(evmkey) - keylen);
> > > +	if (keylen < MAX_KEY_SIZE)
> > > +		memset(evmkey + keylen, 0, MAX_KEY_SIZE - keylen);
> > > +
> > > +	/* Shorten lifetime of key data. */
> > > +	OPENSSL_cleanse(key, keylen);
> > > =20
> > >  	if (lstat(file, &st)) {
> > >  		log_err("Failed to stat: %s\n", file);
> > > @@ -1147,12 +1183,15 @@ static int calc_evm_hmac(const char *file, co=
nst char *keyfile, unsigned char *h
> > >  		goto out;
> > >  	}
> > > =20
> > > -	err =3D !HMAC_Init_ex(pctx, evmkey, sizeof(evmkey), md, NULL);
> > > +	err =3D !HMAC_Init_ex(pctx, evmkey, MAX_KEY_SIZE, md, NULL);
> > >  	if (err) {
> > >  		log_err("HMAC_Init() failed\n");
> > >  		goto out;
> > >  	}
> > > =20
> > > +	/* Shorten lifetime of evmkey data. */
> > > +	OPENSSL_cleanse(evmkey, MAX_KEY_SIZE);
> > > +
> > >  	for (xattrname =3D evm_config_xattrnames; *xattrname !=3D NULL; xat=
trname++) {
> > >  		err =3D lgetxattr(file, *xattrname, xattr_value, sizeof(xattr_valu=
e));
> > >  		if (err < 0) {
> > > @@ -1222,7 +1261,9 @@ out_ctx_cleanup:
> > >  	HMAC_CTX_free(pctx);
> > >  #endif
> > >  out:
> > > -	free(key);
> > > +	if (evmkey)
> > > +		OPENSSL_secure_clear_free(evmkey, MAX_KEY_SIZE);
> > > +	OPENSSL_secure_clear_free(key, keylen);
> >=20
> > Minor thing: considering you already OPENSSL_cleanse() both evmkey and
> > key, is it necessary to call OPENSSL_secure_clear_free() instead of only
> > OPENSSL_secure_free()?
>=20
> There is already comment to explain this - it's to shorten key lifetime
> on one execution path. Note there is possible `goto out` before
> OPENSSL_cleanse calls.
>=20
> Thanks,
>=20

Got it!

Thanks.

> >=20
> > But like I said, that's a minor thing :)
> >=20
> > Reviewed-by: Bruno Meneguele <bmeneg@redhat.com>
> >=20
> > --=20
> > bmeneg=20
> > PGP Key: http://bmeneg.com/pubkey.txt
>=20
>=20

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--d6U4keMCvX4AkFum
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAmEj5E4ACgkQYdRkFR+R
okNbaAf/e+IFTcHE9laljR0WlB54e/NYwEwEJfjOj1c/Hn3bmkeZUMKUXxxPx+hZ
sDWc8o7gDAMHzUvoBxInpKgUp9zQvn/CnbSyskumfg7K/MoanWMIWnXfKYX7Aekv
WruDWyy/3SJQ3dZ+UUYncMcGvJeljZE+ILWlPvJbLYFBmf4mSfYu4Aw849UpaF/O
GRKGqpEhl1q9PnlT+ajU8VER0bwr8FuNGCqH5yjmU58uhDBrJaerYdVyK++83EG8
mRV14pUG7Sb5XDxH8Lxb1r+aUYKxmwkjDCcQjo6uj/CX1NfYCtptyVYsvuoh2EU8
WmmR89Lism1atGs376kQroI72mfaMA==
=mIZf
-----END PGP SIGNATURE-----

--d6U4keMCvX4AkFum--

