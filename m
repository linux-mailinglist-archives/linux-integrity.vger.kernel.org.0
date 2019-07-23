Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73B7C72106
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jul 2019 22:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbfGWUo5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Jul 2019 16:44:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59826 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbfGWUo4 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Jul 2019 16:44:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 71BC230C34E7;
        Tue, 23 Jul 2019 20:44:56 +0000 (UTC)
Received: from localhost (ovpn-116-53.gru2.redhat.com [10.97.116.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C83B35D9C5;
        Tue, 23 Jul 2019 20:44:55 +0000 (UTC)
Date:   Tue, 23 Jul 2019 17:44:53 -0300
From:   "Bruno E. O. Meneguele" <bmeneg@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>,
        Petr Vorel <pvorel@suse.cz>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH v3] ima-evm-utils: use tsspcrread to read the TPM 2.0 PCRs
Message-ID: <20190723204453.GF5993@rhlt>
References: <1563913626-28061-1-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xaMk4Io5JJdpkLEb"
Content-Disposition: inline
In-Reply-To: <1563913626-28061-1-git-send-email-zohar@linux.ibm.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 23 Jul 2019 20:44:56 +0000 (UTC)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--xaMk4Io5JJdpkLEb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2019 at 04:27:06PM -0400, Mimi Zohar wrote:
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
> Changelog v3:
> - Suggested by Vitaly, replace snprintf() & strdup() with asprintf().
>=20
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
>=20
>  configure.ac |  7 +++++++
>  src/evmctl.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++++-=
---
>  2 files changed, 60 insertions(+), 4 deletions(-)
>=20
> diff --git a/configure.ac b/configure.ac
> index 9beb4b6c2377..3fc63b367c91 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -7,6 +7,7 @@ AC_CONFIG_HEADERS([config.h])
>  AC_CONFIG_MACRO_DIR([m4])
> =20
>  AC_CANONICAL_HOST
> +AC_USE_SYSTEM_EXTENSIONS
> =20
>  # Checks for programs.
>  AC_PROG_CC
> @@ -29,6 +30,11 @@ AC_SUBST(KERNEL_HEADERS)
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
> @@ -71,4 +77,5 @@ echo
>  echo	"Configuration:"
>  echo	"          debug: $pkg_cv_enable_debug"
>  echo	"   openssl-conf: $enable_openssl_conf"
> +echo	"     tsspcrread: $TSSPCRREAD"
>  echo
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 9e0926f10404..3289061fe8d2 100644
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
> @@ -1402,6 +1400,43 @@ static int tpm_pcr_read(int idx, uint8_t *pcr, int=
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
> +		ret =3D asprintf(errmsg, "popen failed: %s", strerror(errno));
> +		if (ret =3D=3D -1)	/* the contents of errmsg is undefined */
> +			*errmsg =3D NULL;
> +		return -1;
> +	}
> +
> +	if (fgets(pcr, sizeof(pcr), fp) =3D=3D NULL) {
> +		ret =3D asprintf(errmsg, "tsspcrread failed: %s",
> +			       strerror(errno));
> +		if (ret =3D=3D -1)	/* the contents of errmsg is undefined */
> +			*errmsg =3D NULL;
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
> @@ -1658,8 +1693,22 @@ static int ima_measurement(const char *file)
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

Looks good to me.

thanks Mimi!

Reviewed-by: Bruno E. O. Meneguele <bmeneg@redhat.com>

--xaMk4Io5JJdpkLEb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl03ccUACgkQYdRkFR+R
okOjYwf/XoaXY3BMpNXej56m1fXMN73YVCHeA48Bgxaf10rj0bypP+rfexa4b8L7
aNTBDQw9NcKpNM2TwdiNCufXKWJPb/r1Vp+bL/IJUBO6Eca+tlaMlgy30ybrlsNz
o2/APMqV5RZehugkvc1GnHYr7bMe1TNe7JwZ3lXXpxafdmLJ5fVxwJ84DMidHqrZ
TzvyfBiTsMvzdMaZ2NbveKxFUoPqYsrsUCkoh2ww7tQNWAqG1DU7VYJR1Rk+Q1je
C2rNAtD+3XKzuMZ+64RK1wT6MjYvRzscQY2khhzQW0cPhjY9elJUvdJSXluMaPKi
96BzCTEn1K57SkHPAGnSMPeMT2ZOoA==
=vCl/
-----END PGP SIGNATURE-----

--xaMk4Io5JJdpkLEb--
