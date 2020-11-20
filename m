Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AFFA2BAA6C
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Nov 2020 13:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgKTMrB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Nov 2020 07:47:01 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:36618 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbgKTMrB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Nov 2020 07:47:01 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id ECF241C0BBF; Fri, 20 Nov 2020 13:46:57 +0100 (CET)
Date:   Fri, 20 Nov 2020 13:46:57 +0100
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
Message-ID: <20201120124657.GA31468@duo.ucw.cz>
References: <20201119232611.30114-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <20201119232611.30114-1-tusharsu@linux.microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2020-11-19 15:26:03, Tushar Sugandhi wrote:
> Kernel integrity critical data can be defined as the in-memory kernel
> data which if accidentally or maliciously altered, can compromise the
> integrity of the system.

Is that an useful definition?

> There are several kernel subsystems that contain integrity critical
> data - e.g. LSMs like SELinux, or AppArmor; or device-mapper targets
> like dm-crypt, dm-verity etc. Examples of critical data could be kernel
> in-memory r/o structures, hash of the memory structures, or data that
> represents a linux kernel subsystem state.
>=20
> This patch set defines a new IMA hook namely ima_measure_critical_data()
> to measure the critical data. Kernel subsystems can use this
> functionality, to take advantage of IMA's measuring and quoting=20
> abilities - thus ultimately enabling remote attestation for the
> subsystem specific information stored in the kernel memory.

How is it supposed to be useful?

I'm pretty sure there are critical data that are not measured by
proposed module... and that are written under normal circumstances.

Best regards,

									Pavel

--=20
http://www.livejournal.com/~pavelmachek

--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCX7e6wQAKCRAw5/Bqldv6
8i6vAKC6FrLMFyZX0lHzJkX+8Mez8H3kogCeJ64mXaqCarNAouB4RShXr1Nthec=
=jlIk
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--
