Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7659670C27
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Jul 2019 23:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfGVVzP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Jul 2019 17:55:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44682 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726212AbfGVVzO (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Jul 2019 17:55:14 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2145830BD1B9;
        Mon, 22 Jul 2019 21:55:14 +0000 (UTC)
Received: from localhost (ovpn-116-44.gru2.redhat.com [10.97.116.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9770C100033F;
        Mon, 22 Jul 2019 21:55:13 +0000 (UTC)
Date:   Mon, 22 Jul 2019 18:55:12 -0300
From:   "Bruno E. O. Meneguele" <bmeneg@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>,
        Petr Vorel <pvorel@suse.cz>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH v1] ima-evm-utils: use tsspcrread to read the TPM 2.0 PCRs
Message-ID: <20190722215512.GE27614@glitch>
References: <1563830080-31069-1-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J4XPiPrVK1ev6Sgr"
Content-Disposition: inline
In-Reply-To: <1563830080-31069-1-git-send-email-zohar@linux.ibm.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 22 Jul 2019 21:55:14 +0000 (UTC)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--J4XPiPrVK1ev6Sgr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mirian,

On Mon, Jul 22, 2019 at 05:14:40PM -0400, Mimi Zohar wrote:
> The kernel does not expose the crypto agile TPM 2.0 PCR banks to
> userspace like it exposes PCRs for TPM 1.2.  As a result, a userspace
> application is required to read PCRs.
>=20
> This patch adds tsspcrread support for reading the TPM 2.0 PCRs.
> tsspcrread is one application included in the ibmtss package.
>=20
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
> Changelog v1:
> - Based on Vitaly's review, test the popen "cmd"  return code.  Use
> pclose to determine if the result of the popen command succeeded or
> failed.  Removed the now unneeded checking for spaces.
> - Dynamically allocated the error msg and other changes based on
> Vitaly's review.
> - Based on Bruno's review, reverted the return code change.  At some
> point, we'll need to re-visit the return codes in general.
>=20
>  configure.ac    |  3 +++
>  src/Makefile.am |  3 +++
>  src/evmctl.c    | 48 ++++++++++++++++++++++++++++++++++++++++++++----
>  3 files changed, 50 insertions(+), 4 deletions(-)
>=20
> diff --git a/configure.ac b/configure.ac
> index 9beb4b6c2377..40fea93fef2f 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -28,6 +28,8 @@ PKG_CHECK_MODULES(LIBCRYPTO, [libcrypto >=3D 0.9.8 ])
>  AC_SUBST(KERNEL_HEADERS)
>  AC_CHECK_HEADER(unistd.h)
>  AC_CHECK_HEADERS(openssl/conf.h)
> +AC_SEARCH_LIBS(TSS_Transmit, ibmtss, [have_ibmtss=3Dyes], [have_ibmtss=
=3Dno])
> +AM_CONDITIONAL([CONFIG_IBMTSS], [test "x$have_ibmtss" =3D "xyes"])
> =20
>  AC_CHECK_HEADERS(sys/xattr.h, , [AC_MSG_ERROR([sys/xattr.h header not fo=
und. You need the c-library development package.])])
>  AC_CHECK_HEADERS(keyutils.h, , [AC_MSG_ERROR([keyutils.h header not foun=
d. You need the libkeyutils development package.])])
> @@ -71,4 +73,5 @@ echo
>  echo	"Configuration:"
>  echo	"          debug: $pkg_cv_enable_debug"
>  echo	"   openssl-conf: $enable_openssl_conf"
> +echo	"         ibmtss: $have_ibmtss"
>  echo
> diff --git a/src/Makefile.am b/src/Makefile.am
> index 9c037e21dc4f..f0990fb01210 100644
> --- a/src/Makefile.am
> +++ b/src/Makefile.am
> @@ -21,6 +21,9 @@ evmctl_SOURCES =3D evmctl.c
>  evmctl_CPPFLAGS =3D $(AM_CPPFLAGS) $(LIBCRYPTO_CFLAGS)
>  evmctl_LDFLAGS =3D $(LDFLAGS_READLINE)
>  evmctl_LDADD =3D  $(LIBCRYPTO_LIBS) -lkeyutils libimaevm.la
> +if CONFIG_IBMTSS
> +evmctl_CFLAGS =3D -DIBMTSS
> +endif
> =20
>  AM_CPPFLAGS =3D -I$(top_srcdir) -include config.h
> =20
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 9e0926f10404..f726b2186678 100644
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
> @@ -1402,6 +1400,32 @@ static int tpm_pcr_read(int idx, uint8_t *pcr, int=
 len)
>  	return result;
>  }
> =20
> +#ifdef IBMTSS
> +static int tpm_pcr_read2(int idx, uint8_t *hwpcr, int len, char **errmsg)
> +{
> +	FILE *fp;
> +	char pcr[100];	/* may contain an error */
> +	char cmd[36];
> +	int ret;
> +
> +	sprintf(cmd, "tsspcrread -halg sha1 -ha %d -ns", idx);
> +	fp =3D popen(cmd, "r");
> +	if (!fp)
> +		return -1;

If popen() call fails, **errmsg won't be allocated and will crash in
ima_measurement() when it make use of errmsg within if(err), see below.

> +
> +	fgets(pcr, sizeof(pcr), fp);
> +
> +	/* get the popen "cmd" return code */
> +	ret =3D pclose(fp);
> +	if (!ret)
> +		hex2bin(hwpcr, pcr, SHA_DIGEST_LENGTH);
> +	else
> +		*errmsg =3D strdup(pcr);

*errmsg is allocated only in case popen runs fine.

> +
> +	return ret;
> +}
> +#endif
> +
>  #define TCG_EVENT_NAME_LEN_MAX	255
> =20
>  struct template_entry {
> @@ -1658,8 +1682,24 @@ static int ima_measurement(const char *file)
>  		log_info("PCRAgg %.2d: ", i);
>  		log_dump(pcr[i], SHA_DIGEST_LENGTH);
> =20
> -		if (tpm_pcr_read(i, hwpcr, sizeof(hwpcr)))
> +		if (tpm_pcr_read(i, hwpcr, sizeof(hwpcr))) {
> +#ifdef IBMTSS
> +			char *errmsg =3D NULL;
> +
> +			err =3D tpm_pcr_read2(i, hwpcr, sizeof(hwpcr), &errmsg);
> +			if (err) {
> +				errmsg[strlen(errmsg) - 1] =3D 0;

crash here: errmsg wasn't initialized within tpm_pcr_read2().

> +
> +				log_info("Failed to read either TPM 1.2 or TPM 2.0 PCRs.\n (%s)\n", =
errmsg);
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

--J4XPiPrVK1ev6Sgr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl02ML8ACgkQYdRkFR+R
okOLjAf+PIbt8paTigz/NryTRilWUSalncq5HMBv1TH2hTriwIsyYy1DpdmP0XKT
dSSox+zuJuiVzVFxWKLojicqPmZE2OIMl4cIDrRyjMgNhsby5mk7/xCDrcVKzP6p
tSpw6vMFKzwhegBwbRLFHXflJhqQI8MtCYL89ne7amvNhpy9kjRtkEB3ngkdgf82
4EadEC+5rFa5jkvi64DB6aRYhx5usp/aKAwVXr6B7NqExpS9P50VfkBdGZppwtOr
xTunF/qG30xs3tGCPDbWWFyXSEt93sAkl8iDoq61d2CWwGfWloF/JwamRnpB5b+P
ip/ErqlawNQwfsUo8nNLjXuFra94Mg==
=tgRJ
-----END PGP SIGNATURE-----

--J4XPiPrVK1ev6Sgr--
