Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE9A47EF46
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Dec 2021 14:57:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352820AbhLXN5M (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Dec 2021 08:57:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43264 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352819AbhLXN5L (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Dec 2021 08:57:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640354230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qTmPWkzIZC5aWPRjLdnf4zJKYHz2Hk/mR4QZBXXyBeQ=;
        b=B609GfbgvqlG5uNbHMGlpzIzD0SFsqljiFSxDO4YC4HZphO127kqJfj6ajw28l9db3eNQ2
        bIz4lzYdFTFLbC6D8td6SHgTDkS8NWQH62vBI6kHUheyWC+AWJdL0yH6hciSoP2tBTZH8+
        CDqNKGRJ69YA9GJisa1OqsPEixQevf8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-494-ecoo1U9FPkuI3E4jabJtJQ-1; Fri, 24 Dec 2021 08:57:07 -0500
X-MC-Unique: ecoo1U9FPkuI3E4jabJtJQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48B701023F4D;
        Fri, 24 Dec 2021 13:57:06 +0000 (UTC)
Received: from localhost (unknown [10.22.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D7FDD5BD35;
        Fri, 24 Dec 2021 13:57:05 +0000 (UTC)
Date:   Fri, 24 Dec 2021 10:57:04 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ima: silence measurement list hexdump during kexec
Message-ID: <YcXRsLxFsMCQeYJ6@glitch>
References: <20211224131454.45577-1-bmeneg@redhat.com>
 <c3a1c7afed5962da2bf89d347fa5eea5fea40daf.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wr48hpfUzuL4NGwl"
Content-Disposition: inline
In-Reply-To: <c3a1c7afed5962da2bf89d347fa5eea5fea40daf.camel@linux.ibm.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--wr48hpfUzuL4NGwl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mimi,

On Fri, Dec 24, 2021 at 08:28:01AM -0500, Mimi Zohar wrote:
> Hi Bruno,
>=20
> On Fri, 2021-12-24 at 10:14 -0300, Bruno Meneguele wrote:
> > The measurement list is dumped during a soft reset (kexec) through the =
call
> > to print_hex_dump(KERN_DEBUG, ...), printing to the system log ignoring=
 both
> > DEBUG build flag and CONFIG_DYNAMIC_DEBUG option.
>=20
> Before upstreaming this patch, the reason for the config options "being
> ignored", if that is really what is happening, needs to be understood
> and documented here in the patch description.

I don't see why the code would intentionally ignore the option,
considering that CONFIG_DYNAMIC_DEBUG basically give the user the
ability to enable/disable pr_debug/printk(KERN_DEBUG) calls during
runtime. Maybe I shouldn't use the word "ignoring" in the description,
would it make things clearer?

>=20
> thanks,
>=20
> Mimi
>=20
> >=20
> > To honor the above conditions the macro print_hex_dump_debug() should be
> > used instead, thus depending on the enabled option/flag the output is g=
iven
> > by a different function call or even silenced.
> >=20
> > Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
>=20

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--wr48hpfUzuL4NGwl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAmHF0bAACgkQYdRkFR+R
okN/mQgAoczefwSZW9duV1llX85yUc6FDLKgNuqfQ3A0Ntz8wXw6sQ19WLkpXs0P
OivxILmNWtFR/voP2p/m5P8FfhE6aPtqQO7GZDkLlGx0ytDEVQqLEhBmwkSsoE4V
IIq7zJUmlV6/1p7aUZkmMnOGsItbY2gOt7kLThBh6kCVokJj+kW48KopPAywqw5P
Hrs+VvGYLCxKumOh1vC6mkldn7W97YWJ5a0by2C/XTPbZHA4I3Q6ef2dgdo9P/xp
DzgQ9KRI7x/6TSADXteQzpNEORUEYCl+IBoDvKtjlW+Rv9vIa3zl4ftzA3rWUBkm
uW2fM56+9lKxJ70fgm70Jy+agX+qzg==
=5je9
-----END PGP SIGNATURE-----

--wr48hpfUzuL4NGwl--

