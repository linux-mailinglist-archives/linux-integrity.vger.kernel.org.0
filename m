Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76F42207EA6
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jun 2020 23:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404242AbgFXVd7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Jun 2020 17:33:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30475 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404228AbgFXVd7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Jun 2020 17:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593034437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y7EcaWcwOVxs7xfTz82JvfiUivSbvgvT6tEmCQl4GAs=;
        b=VtsxTZbZiT3ovV4jLQ4N511ZttDBiLP5eM7QC8C39d3z3VxQeUtvFillqPNiE1nT13GbiP
        zX9TFJnplYcONg2ZTcNfXXBAigzsd09l98nMrH7lnc2It7JjIMAaaKUAcGmQ3j+7xZ48u8
        6n8vbKekLjl6YPJmyph5jSg9G4rjHk8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-WoI1-yE6NoOYD6JWbB085g-1; Wed, 24 Jun 2020 17:33:49 -0400
X-MC-Unique: WoI1-yE6NoOYD6JWbB085g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 944FF193F563;
        Wed, 24 Jun 2020 21:33:47 +0000 (UTC)
Received: from localhost (ovpn-116-62.gru2.redhat.com [10.97.116.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C04E2B4AE;
        Wed, 24 Jun 2020 21:33:46 +0000 (UTC)
Date:   Wed, 24 Jun 2020 18:33:45 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Maurizio Drocco <maurizio.drocco@ibm.com>, zohar@linux.ibm.com,
        Silviu.Vlasceanu@huawei.com, dmitry.kasatkin@gmail.com,
        jejb@linux.ibm.com, jmorris@namei.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, mdrocco@linux.vnet.ibm.com,
        roberto.sassu@huawei.com, serge@hallyn.com
Subject: Re: [PATCH v2] ima_evm_utils: extended calc_bootaggr to PCRs 8 - 9
Message-ID: <20200624213345.GB2639@glitch>
References: <1592856871.4987.21.camel@linux.ibm.com>
 <20200623180122.209-1-maurizio.drocco@ibm.com>
 <20200623181357.GC4983@glitch>
 <92a0d170-8157-476b-8083-ae567b11f364@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <92a0d170-8157-476b-8083-ae567b11f364@linux.ibm.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bmeneg@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2020 at 05:17:52PM -0400, Stefan Berger wrote:
> On 6/23/20 2:13 PM, Bruno Meneguele wrote:
> > On Tue, Jun 23, 2020 at 02:01:22PM -0400, Maurizio Drocco wrote:
> > > From: Maurizio <maurizio.drocco@ibm.com>
> > >=20
> > > If PCRs 8 - 9 are set (i.e. not all-zeros), cal_bootaggr should inclu=
de
> > > them into the digest.
>=20
>=20
> Wouldn't you have to check for not all-zeros in your code?
>=20

boot_aggregate in kernel, after the following patch be applied:

https://lkml.org/lkml/2020/6/23/833

is calculated regardless PCR 8 & 9 being zero or not.
Thus evmctl is only reflecting the same behavior.

I think it would be worth changing the commit log here.

>=20
> =A0=A0 Stefan
>=20
>=20
> > >=20
> > > Signed-off-by: Maurizio Drocco <maurizio.drocco@ibm.com>
> > > ---
> > > Changelog:
> > > v2:
> > > - Always include PCRs 8 & 9 to non-sha1 hashes
> > > v1:
> > > - Include non-zero PCRs 8 & 9 to boot aggregates
> > >=20
> > >   src/evmctl.c | 15 +++++++++++++--
> > >   1 file changed, 13 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/src/evmctl.c b/src/evmctl.c
> > > index 1d065ce..46b7092 100644
> > > --- a/src/evmctl.c
> > > +++ b/src/evmctl.c
> > > @@ -1930,6 +1930,16 @@ static void calc_bootaggr(struct tpm_bank_info=
 *bank)
> > >   =09=09}
> > >   =09}
> > > +=09if (strcmp(bank->algo_name, "sha1") !=3D 0) {
> > > +=09=09for (i =3D 8; i < 10; i++) {
> > > +=09=09=09err =3D EVP_DigestUpdate(pctx, bank->pcr[i], bank->digest_s=
ize);
> > > +=09=09=09if (!err) {
> > > +=09=09=09=09log_err("EVP_DigestUpdate() failed\n");
> > > +=09=09=09=09return;
> > > +=09=09=09}
> > > +=09=09}
> > > +=09}
> > > +
> > >   =09err =3D EVP_DigestFinal(pctx, bank->digest, &mdlen);
> > >   =09if (!err) {
> > >   =09=09log_err("EVP_DigestFinal() failed\n");
> > > @@ -1972,8 +1982,9 @@ static int append_bootaggr(char *bootaggr, stru=
ct tpm_bank_info *tpm_banks)
> > >   /*
> > >    * The IMA measurement list boot_aggregate is the link between the =
preboot
> > >    * event log and the IMA measurement list.  Read and calculate all =
the
> > > - * possible per TPM bank boot_aggregate digests based on the existin=
g
> > > - * PCRs 0 - 7 to validate against the IMA boot_aggregate record.
> > > + * possible per TPM bank boot_aggregate digests based on the existin=
g PCRs
> > > + * 0 - 9 to validate against the IMA boot_aggregate record. If the d=
igest
> > > + * algorithm is SHA1, only PCRs 0 - 7 are considered to avoid ambigu=
ity.
> > >    */
> > >   static int cmd_ima_bootaggr(struct command *cmd)
> > >   {
> > > --=20
> > > 2.17.1
> > >=20
> > Reviewed-by: Bruno Meneguele <bmeneg@redhat.com>
> >=20
>=20

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl7zxrkACgkQYdRkFR+R
okPYcQgAm6LTqZtL5mRjNJGbAAZw84aOAtH2k6SpA7DctDptfHi4GqFGsUQlUm20
qoj6O72gsg8KEAg2PCBD+Say3QRN4Z688divjN90eCmgtcP2m56t1dFrDxDxX2cg
6eTznSJ+wJtBhBOgQnm+ZzfVr+mcqlDQm9KkCgeGa3e+20bp1RZlIv7riJr7WEpb
DikYbbv/rkixLrBKuwHylQiGw0VYs5n3tfCXd/EMPdlI1//QPzg8UT7m9TfB+sPS
sHdLa1AgFZYuvZ2Zy5gZ31cI0+nqc2oikOyX+tBYcAuGVNU2IhLq9x20Ro0K18NN
p0w6HJMC3pQK6zsZN2PZ9Om8qjGXCA==
=3iq3
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--

