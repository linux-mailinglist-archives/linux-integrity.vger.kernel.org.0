Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58E74229B13
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Jul 2020 17:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgGVPM0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Jul 2020 11:12:26 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60498 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726717AbgGVPM0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Jul 2020 11:12:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595430745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kDaBPTsjO40EnLoHk3vS2gC5XJcSktRsVlh5DF8fVHU=;
        b=HUFTS+fyrvaZ/leIPzRNEyP+fEwUrYMIyXLyPyIHeZ5rwCmjtjdpq63HZdlNPd6ed8PXxh
        mf0Hvl86IZ+/B5XVv1ss7sDIxdgZha6NpjUWg4Rxrh817cZ1Xmv8/Dg9NNszl4stfavq/i
        5l3UxCw+aW2sEeZthEJ/N5G+UKb/Ejs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-6J4AV0XhPgyXu0rzyF-KMA-1; Wed, 22 Jul 2020 11:12:21 -0400
X-MC-Unique: 6J4AV0XhPgyXu0rzyF-KMA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 78809106B242;
        Wed, 22 Jul 2020 15:12:19 +0000 (UTC)
Received: from localhost (ovpn-116-110.gru2.redhat.com [10.97.116.110])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B9F75C1BB;
        Wed, 22 Jul 2020 15:12:18 +0000 (UTC)
Date:   Wed, 22 Jul 2020 12:12:17 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        Petr Vorel <pvorel@suse.cz>, Vitaly Chikunov <vt@altlinux.org>
Subject: Re: ima-evm-utils: version 1.3 released
Message-ID: <20200722151217.GC3821@glitch>
References: <1595379262.5311.31.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <1595379262.5311.31.camel@linux.ibm.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="96YOpH+ONegL0A3E"
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

--96YOpH+ONegL0A3E
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2020 at 08:54:22PM -0400, Mimi Zohar wrote:
> The last ima-evm-utils release v1.2.1 was last July, a year ago, way
> too long ago. =A0Going forward I really would like to have more frequent
> releases. =A0New to v1.3 is ima-evm-utils regression tests, support for
> re-calculating the per TPM 2.0 bank template data digest, and much
> more. =A0For the details refer to the ChangeLog.
>=20
> I'd like to take this opportunity to thank you for your contributions,
> reviews, and testing!
>=20
> thanks,
>=20
> Mimi
>=20

Thanks Mimi!

I'm going to update it in Fedora Rawhide soon :)

https://bugzilla.redhat.com/show_bug.cgi?id=3D1859421

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--96YOpH+ONegL0A3E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl8YV1EACgkQYdRkFR+R
okPYlAgAyd/U/u8Uu/fbTDPACkunZ2T25oDX4kko76DovshhLa8ISDRr5esHO+7q
rinA9K8nCWMSlcaiGUY7KhS4hxIXeJ89gACOwThEmBIqpoxFkLU2DE8C44ZHotGF
UFCCOsIRityRyftlS4Dq5abM30yxuS8s3oBc8IxhQdj+XmpHtYgIQP/Rd5R0WqT1
5vqgpfH1FvRe23fXhBaP0AN7hd4s3IPUiqvouwT5a6UppTzi3PjEBm79qGRbf5DK
3LE68Cq/oqe13BBz55LeCl89e9zHhNp/tj1woq+96qvEQVe8jEHKuqETnMmEtjuo
BZtW6QAFifATNgh681oFsp8s9TtOGg==
=UrUc
-----END PGP SIGNATURE-----

--96YOpH+ONegL0A3E--

