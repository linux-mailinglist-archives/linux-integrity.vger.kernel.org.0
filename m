Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E8747EF0E
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Dec 2021 14:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238298AbhLXNOx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Dec 2021 08:14:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:36961 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230463AbhLXNOx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Dec 2021 08:14:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640351692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bxlEvALMK9lzn0nPdbICOgS36zyGodPPp1ZtECyg394=;
        b=N3T8DfpjWMxw190AjLn9L6EAWYXAVWbMMOZFbn0BTCcJvXyJZDJcHyxGPQwa8vVqk6NjaS
        5ag0BEga0WSnEmtGZ8y1RsORgo0Gwrh0ch5uxTqRpP3/b4y+IN5AwGOwFmeme6gMGneS/Y
        J77fszzN3vg5+DLyF0I/nBDaIDISj1E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-459-LqCCXgrnOFKugTBbvE3d6g-1; Fri, 24 Dec 2021 08:14:48 -0500
X-MC-Unique: LqCCXgrnOFKugTBbvE3d6g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB8B01006AA5;
        Fri, 24 Dec 2021 13:14:47 +0000 (UTC)
Received: from localhost (unknown [10.22.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 586E9519B7;
        Fri, 24 Dec 2021 13:14:47 +0000 (UTC)
Date:   Fri, 24 Dec 2021 10:14:46 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ima: silence measurement list hexdump during kexec
Message-ID: <YcXHxgP1w2Us72bS@glitch>
References: <20211222191623.376174-1-bmeneg@redhat.com>
 <31d71e1957e84d2440f41d43d2570b112e91a27b.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kki6z1n8KXFa6VqM"
Content-Disposition: inline
In-Reply-To: <31d71e1957e84d2440f41d43d2570b112e91a27b.camel@linux.ibm.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--kki6z1n8KXFa6VqM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 22, 2021 at 05:13:56PM -0500, Mimi Zohar wrote:
> Hi Bruno,
>=20
> On Wed, 2021-12-22 at 16:16 -0300, Bruno Meneguele wrote:
> > The measurement list is dumped during a soft reset (kexec) through the =
call
> > to "print_hex_dump(KERN_DEBUG, ...)", which ignores the DEBUG build fla=
g.
> > Instead, use "print_hex_dump_debug(...)", honoring the build flag.
> >=20
> > Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
>=20
> The patch description needs to at least explain why using
> print_hex_dump() isn't sufficent.   Look at how print_hex_dump() is
> defined.  Based on whether CONFIG_DYNAMIC_DEBUG is enabled, different
> functions are used.

Sending the v2 in a sec :)

Thanks Mimi

>=20
> Mimi
>=20
> > ---
> >  security/integrity/ima/ima_kexec.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/im=
a/ima_kexec.c
> > index f799cc278a9a..13753136f03f 100644
> > --- a/security/integrity/ima/ima_kexec.c
> > +++ b/security/integrity/ima/ima_kexec.c
> > @@ -61,9 +61,9 @@ static int ima_dump_measurement_list(unsigned long *b=
uffer_size, void **buffer,
> >  	}
> >  	memcpy(file.buf, &khdr, sizeof(khdr));
> > =20
> > -	print_hex_dump(KERN_DEBUG, "ima dump: ", DUMP_PREFIX_NONE,
> > -			16, 1, file.buf,
> > -			file.count < 100 ? file.count : 100, true);
> > +	print_hex_dump_debug("ima dump: ", DUMP_PREFIX_NONE, 16, 1,
> > +			     file.buf, file.count < 100 ? file.count : 100,
> > +			     true);
> > =20
> >  	*buffer_size =3D file.count;
> >  	*buffer =3D file.buf;
>=20
>=20

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--kki6z1n8KXFa6VqM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAmHFx8YACgkQYdRkFR+R
okPreQgAnqpFVqEElAwuWlt1HoxsbRlLag8dnhRrGaWr1tWQabQwgEgEcCw8KFXI
7KIpzscweZEKsMrBT8yu62PCnBN2DGZpXg4FuGS0f66pzhS5b+XN/2gZB0AfaPUm
R1oDOPGcMu73l0Y9cXaveWt3GdWFstFDFRTtBJK3SlmmrY6S6YmMSVAAQPb4nt5u
QtgfIU5biLpICpjATmfoCd5Ja/xf17Nv7F/8UP7IihVCL3qMVqeAj3rWGIQrITNy
hGK6U85n2Hc3ZCVhZOEf6M68guAnd04BHeDLjqPggFyhhF50BLTrJyAhj1awj7pm
S5QTNCcJOH2c5W8bPu4qdh27TQengA==
=9i6w
-----END PGP SIGNATURE-----

--kki6z1n8KXFa6VqM--

