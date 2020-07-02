Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17812212CD5
	for <lists+linux-integrity@lfdr.de>; Thu,  2 Jul 2020 21:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgGBTNO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 Jul 2020 15:13:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35115 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725915AbgGBTNN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 Jul 2020 15:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593717191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FzBxpCXjYpYykVqIIHvJqM6p4BizB/f7pG6TYVbhSrc=;
        b=g1YAyIt97+wNTH50gF3VaUtzKeXAZyJDsjcbj37HxTwAFDudgPHkPzinYKzgkGgtgVhzFd
        EoM5CDGixaO9TwJy9zyHrqtT/uO92ygl8imaw1CD73jhOmL6H9czORTyI74UvwslabN8sM
        RiiWjnd3lcnkqK7IiGENJH479T3cOq4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-agXmqbaCMZaa2Q3O-dcvyA-1; Thu, 02 Jul 2020 15:12:58 -0400
X-MC-Unique: agXmqbaCMZaa2Q3O-dcvyA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52D8980B70D;
        Thu,  2 Jul 2020 19:12:52 +0000 (UTC)
Received: from localhost (ovpn-116-143.gru2.redhat.com [10.97.116.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E627A79258;
        Thu,  2 Jul 2020 19:12:51 +0000 (UTC)
Date:   Thu, 2 Jul 2020 16:12:50 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        erichte@linux.ibm.com, nayna@linux.ibm.com
Subject: Re: [PATCH v3 2/2] ima: move APPRAISE_BOOTPARAM dependency on
 ARCH_POLICY to runtime
Message-ID: <20200702191250.GB3669@glitch>
References: <20200623202640.4936-1-bmeneg@redhat.com>
 <20200623202640.4936-3-bmeneg@redhat.com>
 <1593204023.27152.476.camel@linux.ibm.com>
 <20200629234744.GA2756@glitch>
 <1593514848.5085.82.camel@linux.ibm.com>
 <20200630170043.GE2944@glitch>
MIME-Version: 1.0
In-Reply-To: <20200630170043.GE2944@glitch>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bmeneg@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2020 at 02:00:43PM -0300, Bruno Meneguele wrote:
> On Tue, Jun 30, 2020 at 07:00:48AM -0400, Mimi Zohar wrote:
> > On Mon, 2020-06-29 at 20:47 -0300, Bruno Meneguele wrote:
> >=20
> > >=20
> > > > I'm not if the "secure_boot" flag is available prior to calling
> > > > default_appraise_setup(), but if it is, you could modify the test
> > > > there to also check if the system is booted in secure boot mode (eg=
.
> > > > IS_ENABLED(CONFIG_IMA_APPRAISE_BOOTPARAM) &&
> > > > !arch_ima_get_secureboot())
> > > >=20
> > >=20
> > > Well pointed. I built a custom x86 kernel with some workaround to get
> > > this flag status within default_appraise_setup() and as a result the
> > > flag is was correctly available.=20
> > >=20
> > > Considering the nature of this flag (platform's firmware (in all
> > > arches?)) can we trust that every arch supporting secure/trusted boot
> > > will have it available in the __setup() call time?
> >=20
> > Calling=A0default_appraise_setup() could be deferred.
> >=20
>=20
> Hmmm.. ok, I'm going to investigate it further.
> Didn't really know that.
>=20

After some research on powerpc, x86 and s390 (the only users of arch
policies) codes it's clear that, no matter what, the secure boot flag
will be available even before the kernel cmdline is actually
copied/saved in kernel's memory.

Both powerpc and x86 populate it through setup_arch() call in
init/main.c:kernel_start(), where some early_params are handled, but
nothing about normal (non-early) __setup() params. s390 is a bit deeper
where it gets the flag, right down its boot code, even before
start_kernel().

With that said, it's safe checking it directly from
default_appraise_setup(). I'm going to prepare a v4, test it and post it
tomorrow.=20

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl7+MbIACgkQYdRkFR+R
okOE9wgAtlCT2xp0XdlQd9PXMOlQZrofYigVUIMXsGtC0ln+HzCr87RDqf6ZGir4
z0TApF2+fb6SvtW654EDJiXQM8WalA++rsuXSzW47jPUuwkrvyHoaykHDKVbwm8h
WoYoylK8wMNo/sjO6m+78O3j3qnE0vESewUimHf5PIv8ihFS2FwNY7B6oO0P2ygu
YHpIg93bZfkSxUSWe/XA+0OvbMlsC7cS5PVEl/Cf81HR5G6knavZe9jFpGPY7rNi
QxhJQAyDfSUmZNnIQWdWn+SBKQSxsILJ9sylvDtprR8fD13fknuERlyRHjMCg83E
I04QUaw5LwbE9GhpXn0zSr/13JfuJg==
=sFZi
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--

