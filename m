Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90540207EE2
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jun 2020 23:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405165AbgFXVuX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Jun 2020 17:50:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58435 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404965AbgFXVuW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Jun 2020 17:50:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593035420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EADfs1ylZAHsiM8IjKqv95Uwk2ZbTva/38FSCFX0Y4Y=;
        b=UicxR0JIdlQTkMWG8YdMSEybAZHXne/nidKzFa7xww0UTUJa7n4AmCwA8YJlIw2fJUzvnU
        oztdeahukkL4ozob+fIvI0IfLonqPUwKcfHldSSdtAVUdkkZmOLoV3QiVU4TGc+YEovf9e
        /1A/78IU6YJ2uNqT515Emkgg5+FH3/k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-JDiVSOwfPXK8klyO4PRXhg-1; Wed, 24 Jun 2020 17:50:15 -0400
X-MC-Unique: JDiVSOwfPXK8klyO4PRXhg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B651880400D;
        Wed, 24 Jun 2020 21:50:13 +0000 (UTC)
Received: from localhost (ovpn-116-62.gru2.redhat.com [10.97.116.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E954160F8A;
        Wed, 24 Jun 2020 21:50:12 +0000 (UTC)
Date:   Wed, 24 Jun 2020 18:50:11 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Maurizio Drocco <maurizio.drocco@ibm.com>
Cc:     Silviu.Vlasceanu@huawei.com, dmitry.kasatkin@gmail.com,
        jejb@linux.ibm.com, jmorris@namei.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, mdrocco@linux.vnet.ibm.com,
        roberto.sassu@huawei.com, serge@hallyn.com, stefanb@linux.ibm.com,
        zohar@linux.ibm.com
Subject: Re: [PATCH v3] ima_evm_utils: extended calc_bootaggr to PCRs 8 - 9
Message-ID: <20200624215011.GC2639@glitch>
References: <20200624213345.GB2639@glitch>
 <20200624213558.4265-1-maurizio.drocco@ibm.com>
MIME-Version: 1.0
In-Reply-To: <20200624213558.4265-1-maurizio.drocco@ibm.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hOcCNbCCxyk/YU74"
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

--hOcCNbCCxyk/YU74
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2020 at 05:35:58PM -0400, Maurizio Drocco wrote:
> From: Maurizio <maurizio.drocco@ibm.com>
>=20
> cal_bootaggr should include PCRs 8-9 in non-SHA1 digests.
>=20
> Signed-off-by: Maurizio Drocco <maurizio.drocco@ibm.com>
> ---
> Changelog:
> v3:
> - Fixed patch description
> v2:
> - Always include PCRs 8 & 9 to non-sha1 hashes
> v1:
> - Include non-zero PCRs 8 & 9 to boot aggregates
>=20
>  src/evmctl.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/src/evmctl.c b/src/evmctl.c
> index 1d065ce..46b7092 100644
> --- a/src/evmctl.c
> +++ b/src/evmctl.c
> @@ -1930,6 +1930,16 @@ static void calc_bootaggr(struct tpm_bank_info *ba=
nk)
>  =09=09}
>  =09}
> =20
> +=09if (strcmp(bank->algo_name, "sha1") !=3D 0) {
> +=09=09for (i =3D 8; i < 10; i++) {
> +=09=09=09err =3D EVP_DigestUpdate(pctx, bank->pcr[i], bank->digest_size)=
;
> +=09=09=09if (!err) {
> +=09=09=09=09log_err("EVP_DigestUpdate() failed\n");
> +=09=09=09=09return;
> +=09=09=09}
> +=09=09}
> +=09}
> +
>  =09err =3D EVP_DigestFinal(pctx, bank->digest, &mdlen);
>  =09if (!err) {
>  =09=09log_err("EVP_DigestFinal() failed\n");
> @@ -1972,8 +1982,9 @@ static int append_bootaggr(char *bootaggr, struct t=
pm_bank_info *tpm_banks)
>  /*
>   * The IMA measurement list boot_aggregate is the link between the prebo=
ot
>   * event log and the IMA measurement list.  Read and calculate all the
> - * possible per TPM bank boot_aggregate digests based on the existing
> - * PCRs 0 - 7 to validate against the IMA boot_aggregate record.
> + * possible per TPM bank boot_aggregate digests based on the existing PC=
Rs
> + * 0 - 9 to validate against the IMA boot_aggregate record. If the diges=
t
> + * algorithm is SHA1, only PCRs 0 - 7 are considered to avoid ambiguity.
>   */
>  static int cmd_ima_bootaggr(struct command *cmd)
>  {
> --=20
> 2.17.1
>=20

Reviewed-by: Bruno Meneguele <bmeneg@redhat.com>

Thanks.

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--hOcCNbCCxyk/YU74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl7zypMACgkQYdRkFR+R
okOR8QgAqksSST2NxdrLiv6YuDGV9UrvTKoio+IEmlosYWxa/qXi2/oUvH3+zNG3
lnCxXjTkC1MDsyx2OInElaiJpdMdtUp/9J+1UBv3+tuBA3a0GmGKZd1+6rQNxDMG
1m8Saa0JjSD6H+iGuGydVSNkDr5g6IxIP3p6+ZiCEEh2qp4iwhiNS4OkUscdWcNF
YEOyE+XEkuaV5oywwo0Oz2Zv3Pb/etl2AoS80mGfAQDQhBXHVVQb5f6tHde11vFw
tnDpG8bDkzo2C7w6xiEmYcAuChJZp+/nxn4jSuitHz9XMZBYP79Rdage1mpSwxEA
4/u11ZssxGWuQjrUZ2wRsw4li8ykrg==
=ioxk
-----END PGP SIGNATURE-----

--hOcCNbCCxyk/YU74--

