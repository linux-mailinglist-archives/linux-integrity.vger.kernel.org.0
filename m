Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776AB205B27
	for <lists+linux-integrity@lfdr.de>; Tue, 23 Jun 2020 20:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733224AbgFWSxM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Jun 2020 14:53:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58712 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733075AbgFWSxM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Jun 2020 14:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592938390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3nSi1zETIGlAkjRMSn7k5XllL026D0zQEnDLfZ6KCh4=;
        b=hJ+mJRlm1hUxIgorBb4lKwFcWQu3w9Xy8ulwX34LX+66XoTI8qD5B/JRwF/Oqa3JrYXErh
        EETwERLD7/2psF7/oZOGh8/h6Yq+h+qlgM/FvtYJnJ6mqT/k3XkwCJoCOW1AGklNoKiGGR
        DjL2DsIHQAapey9pXXj0KMMJL0QEhT0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-nhT-KQwFMOaBe6CR_NjNkQ-1; Tue, 23 Jun 2020 14:53:04 -0400
X-MC-Unique: nhT-KQwFMOaBe6CR_NjNkQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C6528031CB;
        Tue, 23 Jun 2020 18:53:02 +0000 (UTC)
Received: from localhost (ovpn-116-11.gru2.redhat.com [10.97.116.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B559060CD3;
        Tue, 23 Jun 2020 18:53:01 +0000 (UTC)
Date:   Tue, 23 Jun 2020 15:53:00 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Maurizio Drocco <maurizio.drocco@ibm.com>
Cc:     zohar@linux.ibm.com, Silviu.Vlasceanu@huawei.com,
        dmitry.kasatkin@gmail.com, jejb@linux.ibm.com, jmorris@namei.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, mdrocco@linux.vnet.ibm.com,
        roberto.sassu@huawei.com, serge@hallyn.com
Subject: Re: [PATCH v4] ima: extend boot_aggregate with kernel measurements
Message-ID: <20200623185300.GD4983@glitch>
References: <1592920990.5437.15.camel@linux.ibm.com>
 <20200623155732.105-1-maurizio.drocco@ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200623155732.105-1-maurizio.drocco@ibm.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8w3uRX/HFJGApMzv"
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

--8w3uRX/HFJGApMzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2020 at 11:57:32AM -0400, Maurizio Drocco wrote:
> Registers 8-9 are used to store measurements of the kernel and its
> command line (e.g., grub2 bootloader with tpm module enabled). IMA
> should include them in the boot aggregate. Registers 8-9 should be
> only included in non-SHA1 digests to avoid ambiguity.
>=20
> Signed-off-by: Maurizio Drocco <maurizio.drocco@ibm.com>
> ---
> Changelog:
> v4:
> - Reworded comments: PCRs 8 & 9 are always included in non-sha1 digests
> v3:
> - Limit including PCRs 8 & 9 to non-sha1 hashes
> v2:
> - Minor comment improvements
> v1:
> - Include non zero PCRs 8 & 9 in the boot_aggregate
>=20
>  security/integrity/ima/ima.h        |  2 +-
>  security/integrity/ima/ima_crypto.c | 15 ++++++++++++++-
>  2 files changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index df93ac258e01..9d94080bdad8 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -30,7 +30,7 @@
> =20
>  enum ima_show_type { IMA_SHOW_BINARY, IMA_SHOW_BINARY_NO_FIELD_LEN,
>  =09=09     IMA_SHOW_BINARY_OLD_STRING_FMT, IMA_SHOW_ASCII };
> -enum tpm_pcrs { TPM_PCR0 =3D 0, TPM_PCR8 =3D 8 };
> +enum tpm_pcrs { TPM_PCR0 =3D 0, TPM_PCR8 =3D 8, TPM_PCR10 =3D 10 };
> =20
>  /* digest size for IMA, fits SHA1 or MD5 */
>  #define IMA_DIGEST_SIZE=09=09SHA1_DIGEST_SIZE
> diff --git a/security/integrity/ima/ima_crypto.c b/security/integrity/ima=
/ima_crypto.c
> index 220b14920c37..011c3c76af86 100644
> --- a/security/integrity/ima/ima_crypto.c
> +++ b/security/integrity/ima/ima_crypto.c
> @@ -823,13 +823,26 @@ static int ima_calc_boot_aggregate_tfm(char *digest=
, u16 alg_id,
>  =09if (rc !=3D 0)
>  =09=09return rc;
> =20
> -=09/* cumulative sha1 over tpm registers 0-7 */
> +=09/* cumulative digest over TPM registers 0-7 */
>  =09for (i =3D TPM_PCR0; i < TPM_PCR8; i++) {
>  =09=09ima_pcrread(i, &d);
>  =09=09/* now accumulate with current aggregate */
>  =09=09rc =3D crypto_shash_update(shash, d.digest,
>  =09=09=09=09=09 crypto_shash_digestsize(tfm));
>  =09}
> +=09/*
> +=09 * Extend cumulative digest over TPM registers 8-9, which contain
> +=09 * measurement for the kernel command line (reg. 8) and image (reg. 9=
)
> +=09 * in a typical PCR allocation. Registers 8-9 are only included in
> +=09 * non-SHA1 boot_aggregate digests to avoid ambiguity.
> +=09 */
> +=09if (alg_id !=3D TPM_ALG_SHA1) {
> +=09=09for (i =3D TPM_PCR8; i < TPM_PCR10; i++) {
> +=09=09=09ima_pcrread(i, &d);
> +=09=09=09rc =3D crypto_shash_update(shash, d.digest,
> +=09=09=09=09=09=09crypto_shash_digestsize(tfm));
> +=09=09}
> +=09}
>  =09if (!rc)
>  =09=09crypto_shash_final(shash, digest);
>  =09return rc;
> --=20
> 2.17.1
>=20

Reviewed-by: Bruno Meneguele <bmeneg@redhat.com>

I've tested this patch with both TPM 1.2 and TPM 2.0 + ima-evm-utils
support patch. Everything seems fine.

Thanks.

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--8w3uRX/HFJGApMzv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl7yT4wACgkQYdRkFR+R
okN1EAgApl7aO6m1nHUaan+Iu9VccMELoK4mnHb3gCgwKZc16uXp1p+fxxwvIViJ
honMESymPNb6656OK5VYAAA7x9EXQIdd6vZDSpcFVy+0RMxBPxlPR3JGciQSWsnu
YqJcum3u2MPaRv0xmqrz7pCuHJ5fFVju5ouaS8oHrdpB9q3LsTgqL2L6mBd4qBoD
9PG68MQOTEUoArQ+IIXTn4lBFGPHl4wM/my5lsO6zAZ7MPmqtoJQwwWbb3Qr/DUn
IivKJlivRrnGkVFI4m6fcBYRshyVHmFii2RjVPUVrMdNpq3Je6CA8bdLxvQ6tw6m
Kjs+LH+RbK6w2wJ3L7CW8ZgxPG+tmQ==
=9sj9
-----END PGP SIGNATURE-----

--8w3uRX/HFJGApMzv--

