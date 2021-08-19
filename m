Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC4323F1FE4
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Aug 2021 20:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbhHSS26 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Aug 2021 14:28:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46010 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234161AbhHSS26 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Aug 2021 14:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629397701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gLOQAa7GeujIXWs5Ck2qU9LI189LUpFF8byt6aWlTOo=;
        b=ULy/aafHn1NiQj7nhaH210BMLcNFhA0SptAfHgk3qmzLGjQnPT3Zc2Cqef/eNCJ7st1RLM
        6bBsYz/BhYw7FjtmEL5aeSA+5gZ705yTsIhBnmQyRh8YfptQHuxoxyrLqu9vS0p+57aN65
        RB+7mx0T095+Y6RTIQi5Kwfm3LLl/mc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-OH9rZ-9aP4O4sC2TOf5G8A-1; Thu, 19 Aug 2021 14:28:19 -0400
X-MC-Unique: OH9rZ-9aP4O4sC2TOf5G8A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84FD81082920;
        Thu, 19 Aug 2021 18:28:18 +0000 (UTC)
Received: from localhost (unknown [10.22.17.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 120A31A26A;
        Thu, 19 Aug 2021 18:28:17 +0000 (UTC)
Date:   Thu, 19 Aug 2021 15:28:17 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH ima-evm-utils v2] Use secure heap for private keys and
 passwords
Message-ID: <YR6iwRZ9GCK272Me@glitch>
References: <20210819021136.664597-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ClSxjBmqr8zXZ4Ef"
Content-Disposition: inline
In-Reply-To: <20210819021136.664597-1-vt@altlinux.org>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--ClSxjBmqr8zXZ4Ef
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 19, 2021 at 05:11:36AM +0300, Vitaly Chikunov wrote:
> After CRYPTO_secure_malloc_init OpenSSL will store private keys in
> secure heap. This facility is only available since OpenSSL_1_1_0-pre1.
>=20
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
> Change from v1:
> - Do not use setfbuf to disable buffering as this is not proven to be
>   meaningful.
> - Use secure heap for passwords too as suggested by Mimi Zohar.
> - Fallback to OPENSSL_malloc for old OpenSSL as suggested by Mimi Zohar.
> - Simplify logic of calling CRYPTO_secure_malloc_init (call it always on
>   OpenSSL init.)
> - Should be applied after Bruno Meneguele's "evmctl: fix memory leak in
>   get_password" patch v2.
>=20
>  src/evmctl.c | 143 ++++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 118 insertions(+), 25 deletions(-)
>=20
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 5f7c2b8..a27e0b9 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -59,6 +59,7 @@
>  #include <assert.h>
> =20
>  #include <openssl/asn1.h>
> +#include <openssl/crypto.h>
>  #include <openssl/sha.h>
>  #include <openssl/pem.h>
>  #include <openssl/hmac.h>
> @@ -165,6 +166,24 @@ struct tpm_bank_info {
>  static char *pcrfile[MAX_PCRFILE];
>  static unsigned npcrfile;
> =20
> +#if OPENSSL_VERSION_NUMBER <=3D 0x10100000
> +#warning Your OpenSSL version is too old to have OPENSSL_secure_malloc, \
> +	falling back to use plain OPENSSL_malloc.
> +#define OPENSSL_secure_malloc	  OPENSSL_malloc
> +#define OPENSSL_secure_free	  OPENSSL_free
> +/*
> + * Secure heap memory automatically cleared on free, but
> + * OPENSSL_secure_clear_free will be used in case of fallback

Shouldn't it be OPENSSL_clear_free instead of OPENSLL_secure_clear_free
in the setence above?

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--ClSxjBmqr8zXZ4Ef
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAmEeosAACgkQYdRkFR+R
okM6JggAr7P70G0Efz9nDAaiUfkm2EX2n/kww41EWE7DON32kktUbSx7Q2PzvNDA
pSMlOCkrhmvTcj4f9CPw6Wl6WifOzPvnfNdBsnihm0Xzq9bhzqawlDrRfdx4puZg
ulPtzCdMF2jeRf8rBxujmVzXRIacNDMnZkUlYbO5GjCRuq3hjzPey5V4Yccv1b1q
AzjdG9jIFbC9sTX9vfgQr0eKWnJYfNNYybFoXSrzxQXhtqAMs5aiWX6Oc5/hdFcT
2DfcXaxXPE19Jzeq3Vr56ePF9zhYEhpsc4KcZ5D+2rCpkCxUQWMLwSlty6PwU6sy
C79+R7K3dJb+eKbsxibZK/ZNF151rg==
=Cwg0
-----END PGP SIGNATURE-----

--ClSxjBmqr8zXZ4Ef--

