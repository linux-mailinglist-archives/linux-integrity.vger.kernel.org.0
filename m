Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3908266803
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Sep 2020 20:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbgIKSDX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Sep 2020 14:03:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59878 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725794AbgIKSDV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Sep 2020 14:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599847400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JWNZsM3ndiksz8eE9cLfUOCXmFnQ9mjaV8k7pJEZFmk=;
        b=MZ1wNXz+EQ8jEzIOsF7fa3XO1pt9C3PcxnJNbcfa5og7xg18hmoFiHecdJzkC3vC10aA0O
        3jXqiV2/Iz5/Kj9wENhvrn8NdQYU7suv67slea5yRhYW4ioxUJlgzOxuWQzfZNGrQVVeb2
        kvc/8RHVoxFzTBjKgxaibR59s3VOy/8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-o0Ob1UDVOWymE7g_A2uC-Q-1; Fri, 11 Sep 2020 14:03:15 -0400
X-MC-Unique: o0Ob1UDVOWymE7g_A2uC-Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F159710082EA;
        Fri, 11 Sep 2020 18:03:13 +0000 (UTC)
Received: from localhost (ovpn-116-54.gru2.redhat.com [10.97.116.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 57DFE27BD8;
        Fri, 11 Sep 2020 18:03:13 +0000 (UTC)
Date:   Fri, 11 Sep 2020 15:03:11 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] ima: limit secure boot feedback scope for appraise
Message-ID: <20200911180311.GI3635@heredoc.io>
References: <20200904194100.761848-4-bmeneg@redhat.com>
 <20200905012020.7024-1-bmeneg@redhat.com>
 <d5cc5da578dfcf00adb3c344316677ff1099b591.camel@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <d5cc5da578dfcf00adb3c344316677ff1099b591.camel@linux.ibm.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bmeneg@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/GPgYEyhnw15BExa"
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

--/GPgYEyhnw15BExa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2020 at 11:07:43AM -0400, Mimi Zohar wrote:
> Hi Bruno,
>=20
> On Fri, 2020-09-04 at 22:20 -0300, Bruno Meneguele wrote:
> > Only prompt the unknown/invalid appraisal option if secureboot is enabl=
ed and
> > if the current appraisal state is different from the original one.
> >=20
> > Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
>=20
> Thanks.  I tweaked this patch description and that of 4/4.  This patch
> set is in next-integrity-testing.  Please take a look.
>=20

Thanks Mimi! Just checked in the branch and they're fine.

> thanks,
>=20
> Mimi
>=20

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--/GPgYEyhnw15BExa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl9bu98ACgkQYdRkFR+R
okNZ+ggA05kIbmMuJJUTJaMjFU2oqmvblKt66qzm+f4wiE0nW+fR+FVroJqD9aFM
oOHmXtxd0KWygG3GA5Rt++tRXvGGtS9cebH3uHWZFNrz6X2hDqQH56XljANcvk5i
KoHO2swjF3lebddZ0xh4Tzk0DWacfxCMPTYEcmw9KU0oePEzruuZjYXZtkYmz1RX
lJoWket0ObT3CSoqvLvZVEUeRvcWg0bhkIoF1MXYFqNFz9sLr2qCw0n1fd9HQl8U
cWHN+2JJ+TzBRX/03EK5gpWFOTOc/erZeUuCG8mAyNCI6y6O6cuBDsh2kXYP7O35
VT7abvtK0sLrXlGShaLil/zs/+n6qA==
=N47Z
-----END PGP SIGNATURE-----

--/GPgYEyhnw15BExa--

