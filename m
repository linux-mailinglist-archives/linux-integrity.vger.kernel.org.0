Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42F1371C18
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jul 2019 17:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfGWPsC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Jul 2019 11:48:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44254 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731528AbfGWPsB (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Jul 2019 11:48:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F416985360;
        Tue, 23 Jul 2019 15:48:00 +0000 (UTC)
Received: from localhost (ovpn-116-91.gru2.redhat.com [10.97.116.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6D24E5D721;
        Tue, 23 Jul 2019 15:48:00 +0000 (UTC)
Date:   Tue, 23 Jul 2019 12:47:59 -0300
From:   "Bruno E. O. Meneguele" <bmeneg@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>,
        Petr Vorel <pvorel@suse.cz>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH v2] ima-evm-utils: use tsspcrread to read the TPM 2.0 PCRs
Message-ID: <20190723154759.GB16649@glitch>
References: <1563893743-4586-1-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i0/AhcQY5QxfSsSZ"
Content-Disposition: inline
In-Reply-To: <1563893743-4586-1-git-send-email-zohar@linux.ibm.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Tue, 23 Jul 2019 15:48:01 +0000 (UTC)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--i0/AhcQY5QxfSsSZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mirian,

On Tue, Jul 23, 2019 at 10:55:43AM -0400, Mimi Zohar wrote:
> The kernel does not expose the crypto agile TPM 2.0 PCR banks to
> userspace like it exposes PCRs for TPM 1.2.  As a result, a userspace
> application is required to read PCRs.
>=20
> This patch adds tsspcrread support for reading the TPM 2.0 PCRs.
> tsspcrread is one application included in the ibmtss package.
>=20
> Sample error messages:
> Failed to read PCRs: (tsspcrread failed: No such file or directory)
> Failed to read PCRs: (TSS_Dev_Open: Error opening /dev/tpmrm0)
>=20
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
> Changelog v2:
> - Fix "errmsg" not always being initialized within tpm_pcr_read2().
>   Reported by Bruno.
> - Shortened error msg length.
> - Renamed tpm_pcr_read2() to tpm2_pcr_read().
> - Included Petr Vorel's autotool change, which looks for tsspcrread,
>   rather than the tss library.
>=20
> Changelog v1:
> - Based on Vitaly's review, test the popen "cmd"  return code.  Use
> pclose to determine if the result of the popen command succeeded or
> failed.  Removed the now unneeded checking for spaces.
> - Dynamically allocated the error msg and other changes based on
> Vitaly's review.
> - Based on Bruno's review, reverted the return code change.  At some
> point, we'll need to re-visit the return codes in general.
>=20
>  configure.ac |  6 ++++++
>  src/evmctl.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++----
>  2 files changed, 57 insertions(+), 4 deletions(-)
>=20
> diff --git a/configure.ac b/configure.ac
> index 9beb4b6c2377..09b111c4ca4a 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -29,6 +29,11 @@ AC_SUBST(KERNEL_HEADERS)
>  AC_CHECK_HEADER(unistd.h)
>  AC_CHECK_HEADERS(openssl/conf.h)
> =20
> +AC_CHECK_PROG(TSSPCRREAD, [tsspcrread], yes, no)
> +if test "x$TSSPCRREAD" =3D "xyes"; then
> +	AC_DEFINE(HAVE_TSSPCRREAD, 1, [Define to 1 if you have tsspcrread binar=
y installed])],
> +fi
> +
>  AC_CHECK_HEADERS(sys/xattr.h, , [AC_MSG_ERROR([sys/xattr.h header not fo=
und. You need the c-library development package.])])
>  AC_CHECK_HEADERS(keyutils.h, , [AC_MSG_ERROR([keyutils.h header not foun=
d. You need the libkeyutils development package.])])
> =20
> @@ -71,4 +76,5 @@ echo
>  echo	"Configuration:"
>  echo	"          debug: $pkg_cv_enable_debug"
>  echo	"   openssl-conf: $enable_openssl_conf"
> +echo	"     tsspcrread: $TSSPCRREAD"
>  echo
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 9e0926f10404..9a2bfad928d1 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -1383,10 +1383,8 @@ static int tpm_pcr_read(int idx, uint8_t *pcr, int=
 len)
>  	if (!fp)
>  		fp =3D fopen(misc_pcrs, "r");
> =20
> -	if (!fp) {
> -		log_err("Unable to open %s or %s\n", pcrs, misc_pcrs);
> +	if (!fp)
>  		return -1;
> -	}
> =20
>  	for (;;) {
>  		p =3D fgets(buf, sizeof(buf), fp);
> @@ -1402,6 +1400,41 @@ static int tpm_pcr_read(int idx, uint8_t *pcr, int=
 len)
>  	return result;
>  }
> =20
> +#ifdef HAVE_TSSPCRREAD
> +static int tpm2_pcr_read(int idx, uint8_t *hwpcr, int len, char **errmsg)
> +{
> +	FILE *fp;
> +	char pcr[100];	/* may contain an error */
> +	char cmd[50];
> +	int ret;
> +
> +	sprintf(cmd, "tsspcrread -halg sha1 -ha %d -ns 2> /dev/null", idx);
> +	fp =3D popen(cmd, "r");
> +	if (!fp) {
> +		snprintf(pcr, sizeof(pcr), "popen failed: %s", strerror(errno));
> +		*errmsg =3D strdup("popen failed:");

Should it have been=20

*errmsg =3D strdup(pcr);

?

> +		return -1;
> +	}
> +
> +	if (fgets(pcr, sizeof(pcr), fp) =3D=3D NULL) {
> +		snprintf(pcr, sizeof(pcr), "tsspcrread failed: %s",
> +			 strerror(errno));
> +		*errmsg =3D strdup(pcr);
> +		ret =3D pclose(fp);
> +		return -1;
> +	}
> +
> +	/* get the popen "cmd" return code */
> +	ret =3D pclose(fp);
> +	if (!ret)
> +		hex2bin(hwpcr, pcr, SHA_DIGEST_LENGTH);
> +	else
> +		*errmsg =3D strndup(pcr, strlen(pcr) - 1); /* remove newline */
> +
> +	return ret;
> +}
> +#endif
> +
>  #define TCG_EVENT_NAME_LEN_MAX	255
> =20
>  struct template_entry {
> @@ -1658,8 +1691,22 @@ static int ima_measurement(const char *file)
>  		log_info("PCRAgg %.2d: ", i);
>  		log_dump(pcr[i], SHA_DIGEST_LENGTH);
> =20
> -		if (tpm_pcr_read(i, hwpcr, sizeof(hwpcr)))
> +		if (tpm_pcr_read(i, hwpcr, sizeof(hwpcr))) {
> +#ifdef HAVE_TSSPCRREAD
> +			char *errmsg =3D NULL;
> +
> +			err =3D tpm2_pcr_read(i, hwpcr, sizeof(hwpcr), &errmsg);
> +			if (err) {
> +				log_info("Failed to read PCRs: (%s)\n", errmsg);
> +				free(errmsg);
> +				exit(1);
> +			}
> +#else
> +			log_info("Failed to read TPM 1.2 PCRs.\n");
>  			exit(1);
> +#endif
> +		}
> +
>  		log_info("HW PCR-%d: ", i);
>  		log_dump(hwpcr, sizeof(hwpcr));
> =20
> --=20
> 2.7.5
>=20

--i0/AhcQY5QxfSsSZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl03LC8ACgkQYdRkFR+R
okMmswf9HvInRMinYzUG9+kiReD4smXWm1+hOqvGD8Ggwn9/jRfEhgibeXzAQEA3
QTThlpj1bh3DnicCu0cE/eimQAu0HbI4SQEwrkAjmDcFwroCvIOni0k1YIuZQ4W3
CoVWV1iG+6FnwXcCmb0LOtY59s5M3qmCrtFxdWAmc6OIojep6bANkyno1x6QsM4b
Dh4hOAxBEGXXtX8d1/zwaQhdfkjbfbuKdxNXUcPSO9pdlpJM6KZFc1D4FdzsGRB+
2lGpkpYvAgVwFQZ/fgpemzpb76XrQs2CXiahGp9+q2QLNJn6GyArY6OmJWYSeZEI
+4tVxzGA5tt246I7y60JlYjZ5c+/Bg==
=UaNr
-----END PGP SIGNATURE-----

--i0/AhcQY5QxfSsSZ--
