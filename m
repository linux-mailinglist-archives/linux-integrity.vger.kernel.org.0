Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D593E2215E8
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jul 2020 22:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgGOURN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jul 2020 16:17:13 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56396 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725881AbgGOURN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jul 2020 16:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594844232;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/ECQpcS75PonDZ7fp90ndKSKSNb5liLIZ+aQ+E0rkQk=;
        b=DoS4qAc9xoAusLC+WJcv4A9wWD+RVWgnkLAWEF2JTWwYbvMld83TMm6qNltBQeVqWNWpYw
        TXrY15Xq/2Iv6RGKnQ5wX6VO85ZP99xLMgNP7q6ftav/Iqc73EeyEyj2SWAPFf9uwKEgA9
        OXMVstJJ160YjsnQDfgB32deb8RXUbw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-5HYPn9YANtCYGq4OPAYIeQ-1; Wed, 15 Jul 2020 16:17:07 -0400
X-MC-Unique: 5HYPn9YANtCYGq4OPAYIeQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5140110059AC;
        Wed, 15 Jul 2020 20:17:06 +0000 (UTC)
Received: from localhost (ovpn-116-38.gru2.redhat.com [10.97.116.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC8E5710A1;
        Wed, 15 Jul 2020 20:17:05 +0000 (UTC)
Date:   Wed, 15 Jul 2020 17:17:04 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, Petr Vorel <pvorel@suse.cz>
Subject: Re: [PATCH v2 2/8] ima_evm_utils: support extending TPM 2.0 banks
 w/original SHA1 padded digest
Message-ID: <20200715201704.GI3720@glitch>
References: <1594396859-9232-1-git-send-email-zohar@linux.ibm.com>
 <1594396859-9232-3-git-send-email-zohar@linux.ibm.com>
 <20200715184327.GH3720@glitch>
 <1594842468.12900.339.camel@linux.ibm.com>
 <1594843863.12900.344.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <1594843863.12900.344.camel@linux.ibm.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="1E1Oui4vdubnXi3o"
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

--1E1Oui4vdubnXi3o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2020 at 04:11:03PM -0400, Mimi Zohar wrote:
> On Wed, 2020-07-15 at 15:47 -0400, Mimi Zohar wrote:
> > Hi Bruno,
> >=20
> > On Wed, 2020-07-15 at 15:43 -0300, Bruno Meneguele wrote:
> > <snip>
> >=20
> > If this patch was in next-testing, I could simply update it. =A0Please
> > send a new patch to remove fox.
>=20
> Oh, it is in next-testing.  I'll fix it up.
>=20

Yes :)

Thanks.

> thanks!
>=20
> Mimi
>=20

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--1E1Oui4vdubnXi3o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl8PZEAACgkQYdRkFR+R
okMdJAf/dUrrkfHzimrZyA27P1a2txfkpsNe/kNCD/a0OLxDOOR0Tra/vcyN3q9M
NsJ/uBVtf8Hahvbud7c3COAyEsnzoyAeFLIyevppmf8lAFQ0pI5mmWCvUsyzobxw
AukNO2XdKTDuSQT4K9VGorHPgmMP9lIo8CakyKnEHpapfEy8/SOAAuQS970+iefn
vWRpZiL7aRVcb0JT9r+h73J3rC28ciPiDmxA1gIqFjXQfcOcXWBd5w38QO/yBjoT
Bek+y9JGxHAiB7fX4BYFg+pJ/cWv15j+sxj2MxUGlcq7bA44hTx7TJzynsPqZV8t
qzXSBKRFt5MgUTdjb9xwHXTy7lx7cw==
=zUn7
-----END PGP SIGNATURE-----

--1E1Oui4vdubnXi3o--

