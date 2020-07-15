Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23AB2221471
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jul 2020 20:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgGOSny (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jul 2020 14:43:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45019 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726465AbgGOSny (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jul 2020 14:43:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594838632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i89hkqVgWL1V+wl6F7LIocJU5+Gjef2AacgijnEO3/s=;
        b=TH5JRCh5iRJnL4r74Q7wPeoTHVzzsESYLcS0d6M/6hxkozg+ti4vnpPuXjH8MT/JAvYMYd
        863ie+y4cnHk9DBxCrexRjIMRBAHpt0eRJuK1gMKn8nOPJFVLqZSPa2GNwuKzhO6cQYj2z
        ca0dAMAsroHoPUBJuGE3/vtDpiQ9+Sg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-j71MnmlrOfaK0ZOzI2D7CA-1; Wed, 15 Jul 2020 14:43:30 -0400
X-MC-Unique: j71MnmlrOfaK0ZOzI2D7CA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F5F5800C64;
        Wed, 15 Jul 2020 18:43:29 +0000 (UTC)
Received: from localhost (ovpn-116-38.gru2.redhat.com [10.97.116.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 333E1757DF;
        Wed, 15 Jul 2020 18:43:29 +0000 (UTC)
Date:   Wed, 15 Jul 2020 15:43:27 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>
Subject: Re: [PATCH v2 2/8] ima_evm_utils: support extending TPM 2.0 banks
 w/original SHA1 padded digest
Message-ID: <20200715184327.GH3720@glitch>
References: <1594396859-9232-1-git-send-email-zohar@linux.ibm.com>
 <1594396859-9232-3-git-send-email-zohar@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <1594396859-9232-3-git-send-email-zohar@linux.ibm.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KscVNZbUup0vZz0f"
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

--KscVNZbUup0vZz0f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mimi,

On Fri, Jul 10, 2020 at 12:00:53PM -0400, Mimi Zohar wrote:
> Initially the sha1 digest, including violations, was padded with zeroes
> before being extended into the other TPM banks.  Support walking the
> IMA measurement list, calculating the per TPM bank SHA1 padded
> digest(s).
>=20
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  src/evmctl.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++-------=
------
>  1 file changed, 58 insertions(+), 15 deletions(-)
>=20
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 0e489e2c7ba6..814aa6b75571 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -1613,6 +1613,10 @@ static struct tpm_bank_info *init_tpm_banks(int *n=
um_banks)
>  =09return banks;
>  }
> =20
> +/*
> + * Compare the calculated TPM PCR banks against the PCR values read.
> + * On failure to match any TPM bank, fail comparison.
> + */
>  static int compare_tpm_banks(int num_banks, struct tpm_bank_info *bank,
>  =09=09=09     struct tpm_bank_info *tpm_bank)
>  {
> @@ -1632,14 +1636,15 @@ static int compare_tpm_banks(int num_banks, struc=
t tpm_bank_info *bank,
>  =09=09=09log_info("%s: TPM PCR-%d: ", tpm_bank[i].algo_name, j);
>  =09=09=09log_dump(tpm_bank[i].pcr[j], tpm_bank[i].digest_size);
> =20
> -=09=09=09ret =3D memcmp(bank[i].pcr[j], tpm_bank[i].pcr[j],
> -=09=09=09=09     bank[i].digest_size);
> -=09=09=09if (!ret)
> +=09=09=09if (memcmp(bank[i].pcr[j], tpm_bank[i].pcr[j],
> +=09=09=09=09     bank[i].digest_size) =3D=3D 0) {
>  =09=09=09=09log_info("%s PCR-%d: succeed\n",
>  =09=09=09=09=09 bank[i].algo_name, j);
> -=09=09=09else
> +=09=09=09} else {
> +=09=09=09=09ret =3D 1;
>  =09=09=09=09log_info("%s: PCRAgg %d does not match TPM PCR-%d\n",
>  =09=09=09=09=09 bank[i].algo_name, j, j);
> +=09=09=09}
>  =09=09}
>  =09}
>  =09return ret;
> @@ -1695,10 +1700,7 @@ static int extend_tpm_bank(EVP_MD_CTX *pctx, const=
 EVP_MD *md,
>  =09=09goto out;
>  =09}
> =20
> -=09if (validate && !memcmp(entry->header.digest, zero, SHA_DIGEST_LENGTH=
))
> -=09=09err =3D EVP_DigestUpdate(pctx, fox, bank->digest_size);

'fox' is not being used in the code anymore. It could be totally removed
afaics.

diff --git a/src/evmctl.c b/src/evmctl.c
index 90a3eeb..ae513b0 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1425,7 +1425,6 @@ struct template_entry {
 };

 static uint8_t zero[MAX_DIGEST_SIZE];
-static uint8_t fox[MAX_DIGEST_SIZE];

 static int validate =3D 0;
 static int verify =3D 0;
@@ -1886,7 +1885,6 @@ static int ima_measurement(const char *file)

        errno =3D 0;
        memset(zero, 0, MAX_DIGEST_SIZE);
-       memset(fox, 0xff, MAX_DIGEST_SIZE);

        pseudo_padded_banks =3D init_tpm_banks(&num_banks);
        pseudo_banks =3D init_tpm_banks(&num_banks);


--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--KscVNZbUup0vZz0f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl8PTk8ACgkQYdRkFR+R
okPtUAgAoMI2lcEHUMSg0Ip9QPOA7Y/YA0fBgDHCQaJAPyaY8W86+iFdtBx3GFPO
OdBoyW6Ou3MRWr940y1UIGryEZKd/MvbyHhHWywPi03JTYgXF0SguKl2l0eEXfmI
3ulAjiwVxieacdeQBjX4nmpAegkSRZO2IoCAM5ZtHY+SC8oYDcxHA2Q0DSsyhScR
QHcQETU2i3Djrk4K+0PQnaO3AB3BKm3uudGheoTvYB6wN9hgFAxuH1NAsw1klxuL
CHyy6GJ3wsgPbcdD7Xl+C2WuCF1nIpOt9+gjVgVxzzVM7of4sPJa+q1d3Be5IPcZ
n/+9YmK0lN8eyX85ry3w6XP4exp6UA==
=NKh9
-----END PGP SIGNATURE-----

--KscVNZbUup0vZz0f--

