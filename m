Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D671A71928
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jul 2019 15:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390151AbfGWN1R (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Jul 2019 09:27:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39296 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390137AbfGWN1R (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Jul 2019 09:27:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2CF72C057F2E;
        Tue, 23 Jul 2019 13:27:16 +0000 (UTC)
Received: from localhost (ovpn-116-44.gru2.redhat.com [10.97.116.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7F3FE5C22D;
        Tue, 23 Jul 2019 13:27:15 +0000 (UTC)
Date:   Tue, 23 Jul 2019 10:27:13 -0300
From:   "Bruno E. O. Meneguele" <bmeneg@redhat.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        Vitaly Chikunov <vt@altlinux.org>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH v1] ima-evm-utils: use tsspcrread to read the TPM 2.0 PCRs
Message-ID: <20190723132713.GF27614@glitch>
References: <1563830080-31069-1-git-send-email-zohar@linux.ibm.com>
 <20190723071545.GA26973@x230>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="twz1s1Hj1O0rHoT0"
Content-Disposition: inline
In-Reply-To: <20190723071545.GA26973@x230>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Tue, 23 Jul 2019 13:27:16 +0000 (UTC)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--twz1s1Hj1O0rHoT0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 23, 2019 at 09:15:45AM +0200, Petr Vorel wrote:
> Hi Mimi,
>=20
> others commented C code, thus I'll comment autotools checks.
>=20
> > The kernel does not expose the crypto agile TPM 2.0 PCR banks to
> > userspace like it exposes PCRs for TPM 1.2.  As a result, a userspace
> > application is required to read PCRs.
> OT: anyone aware why TPM 2.0 does not expose PCR banks to userspace via s=
ysfs?
>=20
> > This patch adds tsspcrread support for reading the TPM 2.0 PCRs.
> > tsspcrread is one application included in the ibmtss package.
>=20
> > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>=20
> > ---
> > Changelog v1:
> > - Based on Vitaly's review, test the popen "cmd"  return code.  Use
> > pclose to determine if the result of the popen command succeeded or
> > failed.  Removed the now unneeded checking for spaces.
> > - Dynamically allocated the error msg and other changes based on
> > Vitaly's review.
> > - Based on Bruno's review, reverted the return code change.  At some
> > point, we'll need to re-visit the return codes in general.
>=20
> >  configure.ac    |  3 +++
> >  src/Makefile.am |  3 +++
> >  src/evmctl.c    | 48 ++++++++++++++++++++++++++++++++++++++++++++----
> >  3 files changed, 50 insertions(+), 4 deletions(-)
>=20
> > diff --git a/configure.ac b/configure.ac
> > index 9beb4b6c2377..40fea93fef2f 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -28,6 +28,8 @@ PKG_CHECK_MODULES(LIBCRYPTO, [libcrypto >=3D 0.9.8 ])
> >  AC_SUBST(KERNEL_HEADERS)
> >  AC_CHECK_HEADER(unistd.h)
> >  AC_CHECK_HEADERS(openssl/conf.h)
> > +AC_SEARCH_LIBS(TSS_Transmit, ibmtss, [have_ibmtss=3Dyes], [have_ibmtss=
=3Dno])
> On some distros (at least openSUSE [1] and Debian [2], the library is cal=
led libtss.so
> (which distro is calling it libibmtss.so?) therefore this should work for=
 both:
> AC_SEARCH_LIBS(TSS_Transmit, [ibmtss tss], [have_ibmtss=3Dyes], [have_ibm=
tss=3Dno])
>=20

Fedora's ibmtss package [1] uses it as libibmtss, while libtss-* are
libs provided by tpm2-tss package [2].

[1] https://src.fedoraproject.org/rpms/tss2/blob/master/f/tss2.spec#_85
[2] https://src.fedoraproject.org/rpms/tpm2-tss/blob/master/f/tpm2-tss.spec=
#_67

> > +AM_CONDITIONAL([CONFIG_IBMTSS], [test "x$have_ibmtss" =3D "xyes"])
>=20
> >  AC_CHECK_HEADERS(sys/xattr.h, , [AC_MSG_ERROR([sys/xattr.h header not =
found. You need the c-library development package.])])
> >  AC_CHECK_HEADERS(keyutils.h, , [AC_MSG_ERROR([keyutils.h header not fo=
und. You need the libkeyutils development package.])])
> > @@ -71,4 +73,5 @@ echo
> >  echo	"Configuration:"
> >  echo	"          debug: $pkg_cv_enable_debug"
> >  echo	"   openssl-conf: $enable_openssl_conf"
> > +echo	"         ibmtss: $have_ibmtss"
> >  echo
> > diff --git a/src/Makefile.am b/src/Makefile.am
> > index 9c037e21dc4f..f0990fb01210 100644
> > --- a/src/Makefile.am
> > +++ b/src/Makefile.am
> > @@ -21,6 +21,9 @@ evmctl_SOURCES =3D evmctl.c
> >  evmctl_CPPFLAGS =3D $(AM_CPPFLAGS) $(LIBCRYPTO_CFLAGS)
> >  evmctl_LDFLAGS =3D $(LDFLAGS_READLINE)
> >  evmctl_LDADD =3D  $(LIBCRYPTO_LIBS) -lkeyutils libimaevm.la
> > +if CONFIG_IBMTSS
> > +evmctl_CFLAGS =3D -DIBMTSS
> > +endif
> You can also use definition from config.h instead of passing it.
>=20
> AC_SEARCH_LIBS(TSS_Transmit, [ibmtss tss],
> 	[have_ibmtss=3Dyes
> 	AC_DEFINE(HAVE_IBMTSS, 1, [Define to 1 if you have libibmtss installed])=
],
> 	[have_ibmtss=3Dno])
>=20
> Then you don't need to pass -DIBMTSS, use HAVE_IBMTSS from config.h inste=
ad.
>=20
> >  AM_CPPFLAGS =3D -I$(top_srcdir) -include config.h
>=20
> > diff --git a/src/evmctl.c b/src/evmctl.c
> > index 9e0926f10404..f726b2186678 100644
> > --- a/src/evmctl.c
> > +++ b/src/evmctl.c
> > @@ -1383,10 +1383,8 @@ static int tpm_pcr_read(int idx, uint8_t *pcr, i=
nt len)
> >  	if (!fp)
> >  		fp =3D fopen(misc_pcrs, "r");
>=20
> > -	if (!fp) {
> > -		log_err("Unable to open %s or %s\n", pcrs, misc_pcrs);
> > +	if (!fp)
> >  		return -1;
> > -	}
>=20
> >  	for (;;) {
> >  		p =3D fgets(buf, sizeof(buf), fp);
> > @@ -1402,6 +1400,32 @@ static int tpm_pcr_read(int idx, uint8_t *pcr, i=
nt len)
> >  	return result;
> >  }
>=20
> > +#ifdef IBMTSS
> > +static int tpm_pcr_read2(int idx, uint8_t *hwpcr, int len, char **errm=
sg)
> > +{
> > +	FILE *fp;
> > +	char pcr[100];	/* may contain an error */
> > +	char cmd[36];
> > +	int ret;
> > +
> > +	sprintf(cmd, "tsspcrread -halg sha1 -ha %d -ns", idx);
>=20
> Did I get it right, that in the end we don't use libibmtss, but tsspcrrea=
d.
> So wouldn't be safer to detect it with AC_CHECK_PROGS macro?
> See proposed diff.
>=20

+1

> > +	fp =3D popen(cmd, "r");
> > +	if (!fp)
> > +		return -1;
> > +
> > +	fgets(pcr, sizeof(pcr), fp);
> > +
> > +	/* get the popen "cmd" return code */
> > +	ret =3D pclose(fp);
> > +	if (!ret)
> > +		hex2bin(hwpcr, pcr, SHA_DIGEST_LENGTH);
> > +	else
> > +		*errmsg =3D strdup(pcr);
> > +
> > +	return ret;
> > +}
> > +#endif
> > +
> >  #define TCG_EVENT_NAME_LEN_MAX	255
>=20
> >  struct template_entry {
> > @@ -1658,8 +1682,24 @@ static int ima_measurement(const char *file)
> >  		log_info("PCRAgg %.2d: ", i);
> >  		log_dump(pcr[i], SHA_DIGEST_LENGTH);
>=20
> > -		if (tpm_pcr_read(i, hwpcr, sizeof(hwpcr)))
> > +		if (tpm_pcr_read(i, hwpcr, sizeof(hwpcr))) {
> > +#ifdef IBMTSS
> > +			char *errmsg =3D NULL;
> > +
> > +			err =3D tpm_pcr_read2(i, hwpcr, sizeof(hwpcr), &errmsg);
> > +			if (err) {
> > +				errmsg[strlen(errmsg) - 1] =3D 0;
> > +
> > +				log_info("Failed to read either TPM 1.2 or TPM 2.0 PCRs.\n (%s)\n"=
, errmsg);
> > +				free(errmsg);
> > +				exit(1);
> > +			}
> > +#else
> > +			log_info("Failed to read TPM 1.2 PCRs.\n");
> >  			exit(1);
> > +#endif
> > +		}
> > +
> >  		log_info("HW PCR-%d: ", i);
> >  		log_dump(hwpcr, sizeof(hwpcr));
>=20
> [1] https://packages.debian.org/sid/amd64/libtss0/filelist
> [2] https://build.opensuse.org/package/view_file/security/tss2/tss2.spec?=
expand=3D1
>=20
>=20
> Kind regards,
> Petr
>=20
> Proposed diff:
>=20
> diff --git configure.ac configure.ac
> index 40fea93..09b111c 100644
> --- configure.ac
> +++ configure.ac
> @@ -28,8 +28,11 @@ PKG_CHECK_MODULES(LIBCRYPTO, [libcrypto >=3D 0.9.8 ])
>  AC_SUBST(KERNEL_HEADERS)
>  AC_CHECK_HEADER(unistd.h)
>  AC_CHECK_HEADERS(openssl/conf.h)
> -AC_SEARCH_LIBS(TSS_Transmit, ibmtss, [have_ibmtss=3Dyes], [have_ibmtss=
=3Dno])
> -AM_CONDITIONAL([CONFIG_IBMTSS], [test "x$have_ibmtss" =3D "xyes"])
> +
> +AC_CHECK_PROG(TSSPCRREAD, [tsspcrread], yes, no)
> +if test "x$TSSPCRREAD" =3D "xyes"; then
> +	AC_DEFINE(HAVE_TSSPCRREAD, 1, [Define to 1 if you have tsspcrread binar=
y installed])],
> +fi
> =20
>  AC_CHECK_HEADERS(sys/xattr.h, , [AC_MSG_ERROR([sys/xattr.h header not fo=
und. You need the c-library development package.])])
>  AC_CHECK_HEADERS(keyutils.h, , [AC_MSG_ERROR([keyutils.h header not foun=
d. You need the libkeyutils development package.])])
> @@ -73,5 +76,5 @@ echo
>  echo	"Configuration:"
>  echo	"          debug: $pkg_cv_enable_debug"
>  echo	"   openssl-conf: $enable_openssl_conf"
> -echo	"         ibmtss: $have_ibmtss"
> +echo	"     tsspcrread: $TSSPCRREAD"
>  echo
> diff --git src/Makefile.am src/Makefile.am
> index f0990fb..9c037e2 100644
> --- src/Makefile.am
> +++ src/Makefile.am
> @@ -21,9 +21,6 @@ evmctl_SOURCES =3D evmctl.c
>  evmctl_CPPFLAGS =3D $(AM_CPPFLAGS) $(LIBCRYPTO_CFLAGS)
>  evmctl_LDFLAGS =3D $(LDFLAGS_READLINE)
>  evmctl_LDADD =3D  $(LIBCRYPTO_LIBS) -lkeyutils libimaevm.la
> -if CONFIG_IBMTSS
> -evmctl_CFLAGS =3D -DIBMTSS
> -endif
> =20
>  AM_CPPFLAGS =3D -I$(top_srcdir) -include config.h
> =20
> diff --git src/evmctl.c src/evmctl.c
> index f726b21..f5268ac 100644
> --- src/evmctl.c
> +++ src/evmctl.c
> @@ -1400,7 +1400,7 @@ static int tpm_pcr_read(int idx, uint8_t *pcr, int =
len)
>  	return result;
>  }
> =20
> -#ifdef IBMTSS
> +#ifdef HAVE_TSSPCRREAD
>  static int tpm_pcr_read2(int idx, uint8_t *hwpcr, int len, char **errmsg)
>  {
>  	FILE *fp;
> @@ -1683,7 +1683,7 @@ static int ima_measurement(const char *file)
>  		log_dump(pcr[i], SHA_DIGEST_LENGTH);
> =20
>  		if (tpm_pcr_read(i, hwpcr, sizeof(hwpcr))) {
> -#ifdef IBMTSS
> +#ifdef HAVE_TSSPCRREAD
>  			char *errmsg =3D NULL;
> =20
>  			err =3D tpm_pcr_read2(i, hwpcr, sizeof(hwpcr), &errmsg);

--twz1s1Hj1O0rHoT0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl03CysACgkQYdRkFR+R
okP2IAf/cdg2GQATDSl8s6/5wTJTii3Lrzo60Y6v9J6+Wdy54dMDxxRFmi62PI3M
kSzF1+LI5HxvGFp8PqH5aTy+PO9XH4xylCiFAUS0K63Cg3PCnFU2dryIawpIwTRz
cHnMlH/UOcm4FOiESHSP+E8DZPfiNeyozh+OY4yT5tfSiwFG34HdsBR8drj4U/7O
lwqtcvNpW379tpTTvZE0A8uqLwDJJwg3iwoYF/1k/dutHhRt7ZqEb2x/Db7WOTh6
NrfieMS+CbyASQSI5XUgDi77FzQnoqhsEUeCsJtZ2nAnXEDulG/LYLRpA2X20VSq
zjI2fZu+aBWPQzJlss97FGSL1JI/1A==
=UHXN
-----END PGP SIGNATURE-----

--twz1s1Hj1O0rHoT0--
