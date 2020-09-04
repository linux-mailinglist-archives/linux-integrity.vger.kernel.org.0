Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5F625E128
	for <lists+linux-integrity@lfdr.de>; Fri,  4 Sep 2020 19:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgIDRr3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 4 Sep 2020 13:47:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28960 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726133AbgIDRr2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 4 Sep 2020 13:47:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599241646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z7daBZiriNkGEWysVjrSBcJJKttkbiqltSl3BOJC0PY=;
        b=B64wr5rMcsbrw9P2yWsnHJkCQjH1fhpHsjaSHPbzJBd7qevHGQO3XeepT8apvYhtzKuG6c
        DQ9XwkyziDxsqXwtZfbeIA2OkbNHI9NxGp/X/bygjNXeE+WHHnYh0HCRcNSz5RXqbfYGub
        Nmy3uDAGO/Q+qXdH/wMAgo/ZPyGnybc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-oFP3jgN5PA6q8sNFtEwdbQ-1; Fri, 04 Sep 2020 13:47:23 -0400
X-MC-Unique: oFP3jgN5PA6q8sNFtEwdbQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27B2018B9F41;
        Fri,  4 Sep 2020 17:47:22 +0000 (UTC)
Received: from localhost (ovpn-116-173.gru2.redhat.com [10.97.116.173])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 968E87E40A;
        Fri,  4 Sep 2020 17:47:21 +0000 (UTC)
Date:   Fri, 4 Sep 2020 14:47:20 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org
Subject: Re: [PATCH 3/4] ima: limit secure boot feedback scope for appraise
Message-ID: <20200904174720.GG2568@heredoc.io>
References: <20200817215233.95319-1-bmeneg@redhat.com>
 <20200817215233.95319-4-bmeneg@redhat.com>
 <25a0912802168cf104ffc7d8ac4f1b2ec12e054d.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <25a0912802168cf104ffc7d8ac4f1b2ec12e054d.camel@linux.ibm.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bmeneg@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="64j1qyTOoGvYcHb1"
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

--64j1qyTOoGvYcHb1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2020 at 04:11:22PM -0400, Mimi Zohar wrote:
> On Mon, 2020-08-17 at 18:52 -0300, Bruno Meneguele wrote:
> > Instead of print to kmsg any ima_appraise=3D option passed by the user =
in case
> > of secure boot being enabled, first check if the state was really chang=
ed
> > from its original "enforce" state, otherwise don't print anything.
>=20
> Please reword this patch description, removing "Instead of print to
> kmsg".
>=20

ack

> >=20
> > Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
> > ---
> >  security/integrity/ima/ima_appraise.c | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity=
/ima/ima_appraise.c
> > index 2193b51c2743..000df14f198a 100644
> > --- a/security/integrity/ima/ima_appraise.c
> > +++ b/security/integrity/ima/ima_appraise.c
> > @@ -19,11 +19,7 @@
> >  static int __init default_appraise_setup(char *str)
> >  {
> >  #ifdef CONFIG_IMA_APPRAISE_BOOTPARAM
> > -=09if (arch_ima_get_secureboot()) {
> > -=09=09pr_info("Secure boot enabled: ignoring ima_appraise=3D%s boot pa=
rameter option",
> > -=09=09=09str);
> > -=09=09return 1;
> > -=09}
> > +=09bool sb_state =3D arch_ima_get_secureboot();
> > =20
> >  =09if (strncmp(str, "off", 3) =3D=3D 0)
> >  =09=09ima_appraise =3D 0;
> > @@ -35,6 +31,16 @@ static int __init default_appraise_setup(char *str)
> >  =09=09ima_appraise =3D IMA_APPRAISE_ENFORCE;
> >  =09else
> >  =09=09pr_err("invalid \"%s\" appraise option", str);
> > +
> > +=09/* If appraisal state was changed, but secure boot is enabled,
> > +=09 * reset it to enforced */
> > +=09if (sb_state) {
> > +=09=09if (!is_ima_appraise_enabled()) {
> > +=09=09=09pr_info("Secure boot enabled: ignoring ima_appraise=3D%s opti=
on",
> > +=09=09=09=09str);
> > +=09=09=09ima_appraise =3D IMA_APPRAISE_ENFORCE;
> > +=09=09}
> > +=09}
>=20
> Instead of changing ima_appraise and then resetting it back to
> enforcing, how about using a temporary variable instead?  Maybe
> something like:
>=20
> if (!is_ima_appraise_enabled())
> =09pr_info( ...)
> else
>    ima_appraise =3D temporary value
>=20

Yes, indeed it would be nice to keep the default state unchanged. Only
thing is that 'is_ima_appraise_enabled()' directly checks 'ima_appraise &
IMA_APPRAISE_ENFORCE', changing to a temp var would require the if() to
check it directly.

I'm going to send a v2 with it changed.

Thanks.

> >  #endif
> >  =09return 1;
> >  }
>=20
>=20

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--64j1qyTOoGvYcHb1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl9SfagACgkQYdRkFR+R
okPDtAgAo+dFCTk/sgjpcy4bcxezWU8FcGuViqkbFz72xVfZA5gMnCf4o99aCl3r
MFDEl80E/n/fgkqqq9WG7EPIXyizdoAsxyURNvpMFWz/V9KRrw5K5ElwCVcnjAb8
/S/2kNP9Yx6zDEMzFyzQsNeRQBI7HlpQSY6L8XZ2ilz43wLKrVi2ZSsEVJULZK/l
sW9w9oCZnmPINqtroagWvbUHOELheIuCgQV7gjrFZoWDxJYNps6TRi70UVTBgvy4
fFT+uDpdUj6pk5pVI2m8Ke2rsTNETTvojswmDxHXpWys472RTqvbFmmzCpgKRgaH
7xQf172+/tc0Qg+IhNodDlFE0QckYA==
=IH38
-----END PGP SIGNATURE-----

--64j1qyTOoGvYcHb1--

