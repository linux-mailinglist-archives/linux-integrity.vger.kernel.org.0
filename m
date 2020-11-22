Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0873D2BC971
	for <lists+linux-integrity@lfdr.de>; Sun, 22 Nov 2020 22:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgKVVAf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 22 Nov 2020 16:00:35 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:42558 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727418AbgKVVAf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 22 Nov 2020 16:00:35 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 46B251C0BA9; Sun, 22 Nov 2020 22:00:32 +0100 (CET)
Date:   Sun, 22 Nov 2020 22:00:31 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com,
        tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH v6 0/8] IMA: support for measuring kernel integrity
 critical data
Message-ID: <20201122210031.GA26756@amd>
References: <20201119232611.30114-1-tusharsu@linux.microsoft.com>
 <20201120124657.GA31468@duo.ucw.cz>
 <aadf6e35-39bc-74d4-6ca3-d708860738a5@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <aadf6e35-39bc-74d4-6ca3-d708860738a5@linux.microsoft.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> >How is it supposed to be useful?
> >
> >I'm pretty sure there are critical data that are not measured by
> >proposed module... and that are written under normal circumstances.
> >
> The goal of this series is to introduce the IMA hook
> measure_critical_data() and the necessary policies to use it; and
> illustrate that use with one example (SELinux). It is not scalable to
> identify and update all the critical data sources to use the proposed
> module at once.
>=20
> A piecemeal approach to add more critical data measurement in subsequent
> patches would be easy to implement and review.

Basically every other data structure in kernel is "critical" by your
definition, and you can't really measure them all; some of them change
rather often. Going piecemeal does not really help here.

Example of critical data structure: page table entries for process I
own.

Best regards,
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl+60W8ACgkQMOfwapXb+vIcigCeMzGk7j6mjC+lCez6JgfwCYJI
Z1YAnihbhsor2KAe3Vx6iXF3suE279VG
=O8SH
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
