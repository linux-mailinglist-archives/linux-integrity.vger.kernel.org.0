Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8DF3E9656
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Aug 2021 18:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbhHKQvh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Aug 2021 12:51:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51563 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229484AbhHKQvh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Aug 2021 12:51:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628700672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=abTUaAsyi8YEJvhYw1U65/Ux0/D8/ZAOGpT1MvTpjo8=;
        b=CpmUCW1hfExePLQ26R67K1VwmZZS4pop+DKubuaSdq4rqs64bOWAM4attUeFc1meUG1VSA
        aS69Lsm0ehef7RUzZMvtmySLIyJFTvKplLkQDT441SGYu8B9qPO5iaoNlJFHbaZNMnzLf4
        y71oEZBr6uU56CMvaR0Wf87eI6dSshg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-xB15VZ8JOeSIkT8TECpZeg-1; Wed, 11 Aug 2021 12:51:10 -0400
X-MC-Unique: xB15VZ8JOeSIkT8TECpZeg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 76559801AEB;
        Wed, 11 Aug 2021 16:51:09 +0000 (UTC)
Received: from localhost (unknown [10.22.34.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C47E95C25A;
        Wed, 11 Aug 2021 16:51:08 +0000 (UTC)
Date:   Wed, 11 Aug 2021 13:51:07 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     vt@altlinux.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH ima-evm-utils] evmctl: fix memory leak in get_password
Message-ID: <YRP/+7XT25GbAEef@glitch>
References: <20210810202852.236354-1-bmeneg@redhat.com>
 <cf5349dc43b2e8efc709abcf8e1637b7da692bee.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ETNTZE9NvS0XRcA5"
Content-Disposition: inline
In-Reply-To: <cf5349dc43b2e8efc709abcf8e1637b7da692bee.camel@linux.ibm.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--ETNTZE9NvS0XRcA5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 11, 2021 at 10:52:00AM -0400, Mimi Zohar wrote:
> Hi Bruno,
>=20
> On Tue, 2021-08-10 at 17:28 -0300, Bruno Meneguele wrote:
> > The variable "password" is not freed nor returned in case get_password()
> > succeeds. Instead of using an intermediary variable ("pwd") for returni=
ng
> > the value, use the same "password" var. Issue found by Coverity scan to=
ol.
> >=20
> > src/evmctl.c:2565: leaked_storage: Variable "password" going out of sco=
pe
> >     leaks the storage it points to.
> >=20
> > Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
> > ---
> >  src/evmctl.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/src/evmctl.c b/src/evmctl.c
> > index 7a6f2021aa92..b49c7910a4a7 100644
> > --- a/src/evmctl.c
> > +++ b/src/evmctl.c
> > @@ -2601,8 +2601,9 @@ static struct option opts[] =3D {
> >  static char *get_password(void)
> >  {
> >  	struct termios flags, tmp_flags;
> > -	char *password, *pwd;
> > +	char *password;
> >  	int passlen =3D 64;
> > +	bool err =3D false;
> > =20
> >  	password =3D malloc(passlen);
> >  	if (!password) {
> > @@ -2622,16 +2623,24 @@ static char *get_password(void)
> >  	}
> > =20
> >  	printf("PEM password: ");
> > -	pwd =3D fgets(password, passlen, stdin);
> > +	if (fgets(password, passlen, stdin) =3D=3D NULL) {
> > +		perror("fgets");
> > +		/* we still need to restore the terminal */
> > +		err =3D true;
> > +	}
>=20
> From the fgets manpage:=20
>    fgets() returns s on success, and NULL on error
>    or  when  end  of  file
>    occurs while no characters have been read.=20
>=20

Yes, I was considering "end of file while no characters have been read"
as an invalid password. The error message is misleading though, which
can be fixed.

> >  	/* restore terminal */
> >  	if (tcsetattr(fileno(stdin), TCSANOW, &flags) !=3D 0) {
> >  		perror("tcsetattr");
> > +		err =3D true;
> > +	}
> > +
> > +	if (err) {
> >  		free(password);
> >  		return NULL;
> >  	}
> >=20
> > -	return pwd;
> > +	return password;
>=20
> Wouldn't a simpler fix be to test "pwd" here?
>         if (!pwd)
>                 free(password);
>         return pwd;
>=20

The problem is on success, when 'pwd' is actually not NULL.
With that, I can't free(password). I would need to asprintf(pwd, ...) or
strndup(password). Because of that, I thought it would be cleaner to
remove 'password' completely.

Your call ... :)

> thanks,
>=20
> Mimi
>=20
> >  }
> > =20
> >  int main(int argc, char *argv[])
>=20
>=20

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--ETNTZE9NvS0XRcA5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAmET//sACgkQYdRkFR+R
okMBuQf/ZojawY/E+vhp405c/oLw3cdWhgQBzuSOZdyZf5ieR2fJdPLZINW1HwfR
eRABVd1DIbd/+SKpOhIxPXNBjH7T/jhUeLC1Rh+25a2ZaIAhgPDr0n8g00xnoS+4
pNvNTffIp8c8jUKTp2rylTS42gqDUkmAH2vaZQopJEyIvomVle8OmcjQeMoRsmk6
L9v6dk7RMP7blH4qEMISc9YTxoEhJFeptuCMVN/+ioeIX3sJlyo/+KJ1tAn/4+jz
ngfqh2aRSs9ihQiNeUwUxlz0hvnYtrQhFPu4bXh4YGzH89w8hXxP5IsC8tyGEudR
PM+mVNIjZuNZrar7YJoMvoZrxPuhpw==
=Hqih
-----END PGP SIGNATURE-----

--ETNTZE9NvS0XRcA5--

