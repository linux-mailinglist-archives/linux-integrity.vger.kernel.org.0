Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8174974102
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jul 2019 23:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbfGXVqn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Jul 2019 17:46:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59604 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfGXVqn (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Jul 2019 17:46:43 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3620D4E92A;
        Wed, 24 Jul 2019 21:46:42 +0000 (UTC)
Received: from localhost (ovpn-116-76.gru2.redhat.com [10.97.116.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9558960497;
        Wed, 24 Jul 2019 21:46:41 +0000 (UTC)
Date:   Wed, 24 Jul 2019 18:46:39 -0300
From:   "Bruno E. O. Meneguele" <bmeneg@redhat.com>
To:     Vitaly Chikunov <vt@altlinux.org>
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] ima-evm-utils: Namespace some too generic function names
Message-ID: <20190724214639.GA28027@rhlt>
References: <20190724204204.25383-1-vt@altlinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <20190724204204.25383-1-vt@altlinux.org>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 24 Jul 2019 21:46:42 +0000 (UTC)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Vitaly,

On Wed, Jul 24, 2019 at 11:42:04PM +0300, Vitaly Chikunov wrote:
> Prefix `dump', `do_dump', and `params' with `ima_' to avoid colliding
> with other global symbols.
>=20
> `params' is prefixed with a #define trick to avoid change in half
> hundred places.
>=20

I understand your point and as a short-term fix I'm fine with that, but
IMO it would be better to actually rename the object in near future,
mainly to avoid possible confusions.

Perhaps we can use Mimi's suggestions of a patch to standardize all
return codes and also rework the naming with some convention.

Just thoughts... :)

> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>

Anyway.. thanks Vitaly!

Reviewed-by: Bruno E. O. Meneguele <bmeneg@redhat.com>
> ---
>=20
> I think all other exported functions (good example is verify_hash) should=
 be
> prefixed too.
>=20
>  src/evmctl.c    | 6 +++---
>  src/imaevm.h    | 9 ++++++---
>  src/libimaevm.c | 6 +++---
>  3 files changed, 12 insertions(+), 9 deletions(-)
>=20
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 3289061..b2e5af5 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -565,7 +565,7 @@ static int sign_evm(const char *file, const char *key)
>  		sig[1] =3D 3; /* immutable signature version */
> =20
>  	if (sigdump || params.verbose >=3D LOG_INFO)
> -		dump(sig, len);
> +		ima_dump(sig, len);
> =20
>  	if (xattr) {
>  		err =3D lsetxattr(file, xattr_evm, sig, len, 0);
> @@ -604,7 +604,7 @@ static int hash_ima(const char *file)
>  		log_info("hash: ");
> =20
>  	if (sigdump || params.verbose >=3D LOG_INFO)
> -		dump(hash, len);
> +		ima_dump(hash, len);
> =20
>  	if (xattr) {
>  		err =3D lsetxattr(file, xattr_ima, hash, len, 0);
> @@ -638,7 +638,7 @@ static int sign_ima(const char *file, const char *key)
>  	sig[0] =3D EVM_IMA_XATTR_DIGSIG;
> =20
>  	if (sigdump || params.verbose >=3D LOG_INFO)
> -		dump(sig, len);
> +		ima_dump(sig, len);
> =20
>  	if (sigfile)
>  		bin2file(file, "sig", sig, len);
> diff --git a/src/imaevm.h b/src/imaevm.h
> index 0414433..d00922c 100644
> --- a/src/imaevm.h
> +++ b/src/imaevm.h
> @@ -49,9 +49,12 @@
> =20
>  #include <openssl/rsa.h>
> =20
> +/* Namespace some internal symbols */
> +#define params		ima_params
> +
>  #ifdef USE_FPRINTF
>  #define do_log(level, fmt, args...)	({ if (level <=3D params.verbose) fp=
rintf(stderr, fmt, ##args); })
> -#define do_log_dump(level, p, len, cr)	({ if (level <=3D params.verbose)=
 do_dump(stderr, p, len, cr); })
> +#define do_log_dump(level, p, len, cr)	({ if (level <=3D params.verbose)=
 ima_do_dump(stderr, p, len, cr); })
>  #else
>  #define do_log(level, fmt, args...)	syslog(level, fmt, ##args)
>  #define do_log_dump(level, p, len, cr)
> @@ -206,8 +209,8 @@ struct RSA_ASN1_template {
> =20
>  extern struct libevm_params params;
> =20
> -void do_dump(FILE *fp, const void *ptr, int len, bool cr);
> -void dump(const void *ptr, int len);
> +void ima_do_dump(FILE *fp, const void *ptr, int len, bool cr);
> +void ima_dump(const void *ptr, int len);
>  int ima_calc_hash(const char *file, uint8_t *hash);
>  int get_hash_algo(const char *algo);
>  RSA *read_pub_key(const char *keyfile, int x509);
> diff --git a/src/libimaevm.c b/src/libimaevm.c
> index 2d99570..afa978f 100644
> --- a/src/libimaevm.c
> +++ b/src/libimaevm.c
> @@ -89,7 +89,7 @@ struct libevm_params params =3D {
> =20
>  static void __attribute__ ((constructor)) libinit(void);
> =20
> -void do_dump(FILE *fp, const void *ptr, int len, bool cr)
> +void ima_do_dump(FILE *fp, const void *ptr, int len, bool cr)
>  {
>  	int i;
>  	uint8_t *data =3D (uint8_t *) ptr;
> @@ -100,9 +100,9 @@ void do_dump(FILE *fp, const void *ptr, int len, bool=
 cr)
>  		fprintf(fp, "\n");
>  }
> =20
> -void dump(const void *ptr, int len)
> +void ima_dump(const void *ptr, int len)
>  {
> -	do_dump(stdout, ptr, len, true);
> +	ima_do_dump(stdout, ptr, len, true);
>  }
> =20
>  const char *get_hash_algo_by_id(int algo)
> --=20
> 2.11.0
>=20

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl040b8ACgkQYdRkFR+R
okNtzgf/anJEE0MiBJ7SpIpPYCgq4wSUHx6lQkg1EoF6L2NNIslUR6nQrcH4Ifdx
oAd3lyTaWacBGc3WlCnAj8/yiaL8QIOvyjswDkIcWJfje6QveY0m34DSlRBDmpFq
LpABS5jEHfdIZrTHz2uYCPPob1bIXlP/JcTlEQIrxWC7RIPQo3JKO/6cmJSJZTsD
YHjQajgg3A58Tqdm5kmWCPkIycNDCM3XYDYOzEVC5+X0bFOr2PsXz9Lvd2ZRmnD8
a0ddj5XQz0Z1NqqvCTCSxy+TEcP6tQ2VdoO6AaVoZXKOstV/0bDEjP86E3smThA2
G0BrpkgwKRCuiwGVDLG61djZUn4y3Q==
=/hN0
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
