Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F84B2C11BB
	for <lists+linux-integrity@lfdr.de>; Mon, 23 Nov 2020 18:20:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733178AbgKWRSE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 Nov 2020 12:18:04 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:55268 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729378AbgKWRSD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Nov 2020 12:18:03 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 23EAC1C0B9D; Mon, 23 Nov 2020 18:18:01 +0100 (CET)
Date:   Mon, 23 Nov 2020 18:18:00 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        stephen.smalley.work@gmail.com, casey@schaufler-ca.com,
        agk@redhat.com, snitzer@redhat.com, gmazyland@gmail.com,
        paul@paul-moore.com, tyhicks@linux.microsoft.com,
        sashal@kernel.org, jmorris@namei.org, nramas@linux.microsoft.com,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH v6 0/8] IMA: support for measuring kernel integrity
 critical data
Message-ID: <20201123171800.GA6407@duo.ucw.cz>
References: <20201119232611.30114-1-tusharsu@linux.microsoft.com>
 <20201120124657.GA31468@duo.ucw.cz>
 <aadf6e35-39bc-74d4-6ca3-d708860738a5@linux.microsoft.com>
 <20201122210031.GA26756@amd>
 <d82ad1cac36e948c904300548c64244c145589ee.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <d82ad1cac36e948c904300548c64244c145589ee.camel@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > >How is it supposed to be useful?
> > > >
> > > >I'm pretty sure there are critical data that are not measured by
> > > >proposed module... and that are written under normal circumstances.
> > > >
> > > The goal of this series is to introduce the IMA hook
> > > measure_critical_data() and the necessary policies to use it; and
> > > illustrate that use with one example (SELinux). It is not scalable to
> > > identify and update all the critical data sources to use the proposed
> > > module at once.
> > >=20
> > > A piecemeal approach to add more critical data measurement in subsequ=
ent
> > > patches would be easy to implement and review.
> >=20
> > Basically every other data structure in kernel is "critical" by your
> > definition, and you can't really measure them all; some of them change
> > rather often. Going piecemeal does not really help here.
>=20
> Agreed, measuring data structures that change is not really applicable.
> However, measuring data structures that once initialized don't change,
> does make sense (similar concept to __ro_after_init).  The attestation
> server doesn't need to know anything about the measurement, other than
> more than a single measurement is indicative of a problem.

So, why not simply measure everything that is ro_after_init?

But... I really fail to see how this is useful. It is trivial to
"backdoor" kernel w/o modifying anything that is
ro_after_init. (Example: page tables).

								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX7vuyAAKCRAw5/Bqldv6
8l0NAKCno5uLV1J+u9T4SaYxmY8EkH/yQQCeJ/9tVl7wyA/jWR7tMN6Lj6pfIx8=
=FwxO
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
