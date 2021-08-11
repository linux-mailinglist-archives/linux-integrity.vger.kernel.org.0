Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632713E9715
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Aug 2021 19:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhHKRxP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Aug 2021 13:53:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36567 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229554AbhHKRxP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Aug 2021 13:53:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628704371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2x3W9CwJaYewtuY4CivlOFtECWZhtp2N0y+WtHsCSUg=;
        b=cpm0riDP4XIQCqvlSg0NrVPdXJWHOLWK8B8dwazul0NLpaLl89N5mL7NKrJDkAGQdGqdto
        GXTTDqJ/WK0Gv7O/yOjkpnt0dHlZhguhadhsJSpbxvzm6sptI3dr+mEFcPAj5Q0NSSz576
        fhmhYnHo9lIijh+KoeyB4G5NtsVD4kk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-MGU4vTDTM3Gij__4JFPvrQ-1; Wed, 11 Aug 2021 13:52:47 -0400
X-MC-Unique: MGU4vTDTM3Gij__4JFPvrQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A27DEC1A0;
        Wed, 11 Aug 2021 17:52:46 +0000 (UTC)
Received: from localhost (unknown [10.22.34.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A2E4D5D740;
        Wed, 11 Aug 2021 17:52:45 +0000 (UTC)
Date:   Wed, 11 Aug 2021 14:52:44 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     vt@altlinux.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH ima-evm-utils] evmctl: fix memory leak in get_password
Message-ID: <YRQObKMhN+3xuUaO@glitch>
References: <20210810202852.236354-1-bmeneg@redhat.com>
 <cf5349dc43b2e8efc709abcf8e1637b7da692bee.camel@linux.ibm.com>
 <YRP/+7XT25GbAEef@glitch>
 <1e261f41462aac5e9fbb6d9397f5f86a5379a803.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Fey1U4E/KSDKo2eL"
Content-Disposition: inline
In-Reply-To: <1e261f41462aac5e9fbb6d9397f5f86a5379a803.camel@linux.ibm.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--Fey1U4E/KSDKo2eL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 11, 2021 at 01:31:49PM -0400, Mimi Zohar wrote:
> On Wed, 2021-08-11 at 13:51 -0300, Bruno Meneguele wrote:
> > On Wed, Aug 11, 2021 at 10:52:00AM -0400, Mimi Zohar wrote:
> >=20
> > > >=20
> > > > -	return pwd;
> > > > +	return password;
> > >=20
> > > Wouldn't a simpler fix be to test "pwd" here?
> > >         if (!pwd)
> > >                 free(password);
> > >         return pwd;
> > >=20
> >=20
> > The problem is on success, when 'pwd' is actually not NULL.
> > With that, I can't free(password). I would need to asprintf(pwd, ...) or
> > strndup(password). Because of that, I thought it would be cleaner to
> > remove 'password' completely.
>=20
> I see.  So instead of "return pwd" as suggested above,
>=20
>         if (!pwd) {
>                 free(password);
>                 password =3D NULL;  <=3D=3D set or return NULL
>         }
>=20
>         return password;
>=20

Ack. Will send a v2 with this change.

Thanks Mimi.

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--Fey1U4E/KSDKo2eL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAmEUDmwACgkQYdRkFR+R
okNRWAf/Vn7iACx2JZv6cvCmVKs+W9k/lMYNtrYf7c7OX3nMFm57RRTUd65t2o6j
G+zYpd1EZQgXU0uRWv6f6Xtrkq+oSxe5w+vocDM/D+WedWWymaJrVtCrTtxH4TIn
xpfkdoFlpnRwTsk5xX9gFiCnx9nfayjQVEIHeb6c+HcR8k9XWQxT6uIFKLtw6DZZ
bwyjOKF2FcpZ4rnnlhoDvWI1LQ3NGtLCZoTf/fUTC2sezDEPN1zA/h/zt+g2QL4+
rWUITmoOSiel2Llhyaw+tqRG3XpMSGTgJBsZhdRtAdvEqhUcsZGC2etU+lvscib5
dV+loT5Fh9tSo6fH1Exzymt+gSS8qw==
=Eurk
-----END PGP SIGNATURE-----

--Fey1U4E/KSDKo2eL--

