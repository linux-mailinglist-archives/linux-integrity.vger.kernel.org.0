Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA018708ED
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Jul 2019 20:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbfGVSws (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Jul 2019 14:52:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50826 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727821AbfGVSwr (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Jul 2019 14:52:47 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 93DC430842B5;
        Mon, 22 Jul 2019 18:52:47 +0000 (UTC)
Received: from localhost (ovpn-116-44.gru2.redhat.com [10.97.116.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2271760497;
        Mon, 22 Jul 2019 18:52:46 +0000 (UTC)
Date:   Mon, 22 Jul 2019 15:52:45 -0300
From:   "Bruno E. O. Meneguele" <bmeneg@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Subject: Re: [PATCH] ima-evm-utils: use tsspcrread to read the TPM 2.0 PCRs
Message-ID: <20190722185245.GB27614@glitch>
References: <1563802368-8460-1-git-send-email-zohar@linux.ibm.com>
 <20190722155835.yaxtxlse4nufmbxq@altlinux.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Content-Disposition: inline
In-Reply-To: <20190722155835.yaxtxlse4nufmbxq@altlinux.org>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 22 Jul 2019 18:52:47 +0000 (UTC)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mirian,

On Mon, Jul 22, 2019 at 06:58:35PM +0300, Vitaly Chikunov wrote:
> Mimi,
>=20
> On Mon, Jul 22, 2019 at 09:32:48AM -0400, Mimi Zohar wrote:
> > The kernel does not expose the crypto agile TPM 2.0 PCR banks to
> > userspace like it exposes PCRs for TPM 1.2.  As a result, a userspace
> > application is required to read PCRs.
> >=20
> > This patch adds tsspcrread support for reading the TPM 2.0 PCRs.
> > tsspcrread is one application included in the ibmtss package.
> >=20
> > Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> > ---
> >  configure.ac    |  3 +++
> >  src/Makefile.am |  3 +++
> >  src/evmctl.c    | 53 ++++++++++++++++++++++++++++++++++++++++++++++++-=
----
> >  3 files changed, 54 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/src/evmctl.c b/src/evmctl.c
> > index 9e0926f10404..cbb9397be138 100644
> > --- a/src/evmctl.c
> > +++ b/src/evmctl.c
> > @@ -1402,6 +1400,38 @@ static int tpm_pcr_read(int idx, uint8_t *pcr, i=
nt len)
> >  	return result;
> >  }
> > =20
> > +#ifdef IBMTSS
> > +static int tpm_pcr_read2(int idx, uint8_t *hwpcr, int len, char **errm=
sg)
> > +{
> > +	FILE *fp;
> > +	char pcr[100];	/* may contain an error */
> > +	char cmd[36];
> > +	int ret =3D 0;
> > +	int i;
> > +
> > +	sprintf(cmd, "tsspcrread -halg sha1 -ha %d -ns", idx);
> > +	fp =3D popen(cmd, "r");
> > +	if (!fp)
> > +		return -1;
> > +
> > +	fgets(pcr, 100, fp);
>=20
> Should it be sizeof(pcr)?
>=20
> I don't know convention of `tsspcrread' but maybe fgets() return value
> should be checked too in case of error of executing `tsspcrread' or
> error inside of `tsspcrread' (like pcr read error).
>=20
> > +
> > +	/* pcr might contain an error message */
> > +	for (i =3D 0; i < strlen(pcr) - 1 && !ret; i++) {
> > +		if (isspace(pcr[i]))
> > +			ret =3D -1;
>=20
> Probably `strlen(pcr)' should be without `- 1'.
>=20
> > +	}
> > +
> > +	if (!ret)
> > +		hex2bin(hwpcr, pcr, SHA_DIGEST_LENGTH);
> > +	else
> > +		*errmsg =3D pcr;
>=20
> pcr isn't static nor malloc'ed.
>=20
> > +
> > +	pclose(fp);
> > +	return ret;
> > +}
> > +#endif
> > +
> >  #define TCG_EVENT_NAME_LEN_MAX	255
> > =20
> >  struct template_entry {
> > @@ -1658,8 +1688,21 @@ static int ima_measurement(const char *file)
> >  		log_info("PCRAgg %.2d: ", i);
> >  		log_dump(pcr[i], SHA_DIGEST_LENGTH);
> > =20
> > -		if (tpm_pcr_read(i, hwpcr, sizeof(hwpcr)))
> > -			exit(1);
> > +		if (tpm_pcr_read(i, hwpcr, sizeof(hwpcr))) {
> > +#ifdef IBMTSS
> > +			char *errmsg =3D NULL;
> > +
> > +			err =3D tpm_pcr_read2(i, hwpcr, sizeof(hwpcr), &errmsg);
> > +			if (err) {
> > +				log_info("Failed to read either TPM 1.2 or TPM 2.0 PCRs.\n\t %s", =
errmsg);
> > +				exit(-1);

                                ^^^^^^^^

> > +			}
> > +#else
> > +			log_info("Failed to read TPM 1.2 PCRs.\n");
> > +			exit(-1);

                        ^^^^^^^^

> > +#endif
> > +		}
> > +
> >  		log_info("HW PCR-%d: ", i);
> >  		log_dump(hwpcr, sizeof(hwpcr));
> > =20
> > --=20
> > 2.7.5

Besides to what Vitaly have pointed...

exit(1) has been the standard exit code in case of failure, wouldn't
that be better to keep it instead of change it to -1? (points
highlighted above)

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl02BfsACgkQYdRkFR+R
okO8QwgAvdkISuOKooNP7KqqBkcVYVVJgWzNQ15Fgz6YZTelOG905Lq6JeWUU8Lu
neaYGDJbR14LHhIdnLTVAhYAcO8qqQ5TdZ11bdwrb4LyzbHyGlUaFwS8h+NfNPML
WHA8iVUQIS+REgdg/kICZj6caW/hk6RppufHnG1rMrrTiaAK3s8V+dCVnQtisCVl
UvBfGaAAhCC1QowxV4SKWMUMXC9uPQ3l8XEAlw0RlXL4kvc3z9t6sY30ruYTNKFc
0PEJr9A6cEdrvR3qnRs0xh4eE6NkZs5f3IsOtYN1iX9Audu5wneDQ3rYpcOCYhcM
A/dQOR5N7JYeOoJlJaBu8TuhxBkI6A==
=Ct4t
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
