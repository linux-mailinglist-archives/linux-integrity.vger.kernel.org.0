Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD12112D0B
	for <lists+linux-integrity@lfdr.de>; Wed,  4 Dec 2019 14:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbfLDN5R (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Dec 2019 08:57:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:52596 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727850AbfLDN5R (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Dec 2019 08:57:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7396EAD2B
        for <linux-integrity@vger.kernel.org>; Wed,  4 Dec 2019 13:57:15 +0000 (UTC)
Date:   Wed, 4 Dec 2019 14:57:15 +0100
From:   Matthias Gerstner <mgerstner@suse.de>
To:     linux-integrity@vger.kernel.org
Subject: Ramifications of INTEGRITY_PLATFORM_KEYRING
Message-ID: <20191204135715.GB11974@f195.suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

at SUSE we implemented an integration test for our enterprise kernels
that checks the functionality of various IMA/EVM related features like
IMA appraisal with digital signatures. To do this a custom CA
certificate is enrolled as a MOK certificate in the system. The
according public key is then loaded into the .ima kernel keyring to be
used for verification of security.ima signatures.

With a recent update we did from kernel version 4.12 to version 5.3 a
regression in this integration test was reported by our QA team. As it
turned out the reason is kernel option INTEGRITY_PLATFORM_KEYRING=3Dy,
which is the default setting our kernel engineers took over. With this
option enabled a couple of platform certificates are no longer loaded
into the .secondary_trusted_keys keyring but into the new .platform
keyring. And IMA only uses those keys to verify things like kexec any
more.

The certificate we enrolled as MOK in the system is now also part for
the .platform keyring, causing us to be unable to load the required
public key into the .ima keyring.

I was able to still get things to work by building my own custom kernel
with the custom CA being built into the kernel which is a lot of more
effort, however, and a scenario we can't easily support for our
customers.

I can understand the reasoning of that new option, that trusting
arbitrary platform certificates shipped with the hardware might not be a
good idea. I wonder, however, whether moving these certificates from
=2Esecondary_trusted_keys to .platform doesn't also affect other
components than just IMA?

I would be interested in your view on this and any advice.

Cheers

Matthias

--=20
Matthias Gerstner <matthias.gerstner@suse.de>
Dipl.-Wirtsch.-Inf. (FH), Security Engineer
https://www.suse.com/security
Phone: +49 911 740 53 290
GPG Key ID: 0x14C405C971923553

SUSE Software Solutions Germany GmbH
HRB 36809, AG N=FCrnberg
Gesch=E4ftsf=FChrer: Felix Imend=F6rffer

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE82oG1A8ab1eESZdjFMQFyXGSNVMFAl3nuzgACgkQFMQFyXGS
NVP6dg//eujTIxXlLctLYoNV/0kg0lmuNM/ZZdNU9C54KgD/A3hTVY17HNvUDbCL
r8fMCOlFu/EQsH4UjSjKmXIrBHFPE9tudQ23BjoORWv+pxZYq8D15bqEHetkKdQh
uAnVpwXO+l7K3qkQdSOUevRdrVdswIWBvq75AZxIyDBxT6T210uGJYrLkd+8qtJ5
GAfX0o1SLy9tm/OdbnCREIDrXlLyNOB+te95tXrWy42krE8qlgRSA2cSErGFWOmm
kSrS3Zft9pxDh+55RuzbLdPnavrvDyEgRptTMHKAXc3hivYllO0K+HDmrbVZK+HV
HUphVwGR6BRmTCJMgf/pBQAJy2/o9XV2XYHCKIrfW7w4WUvMdcsmlFU/0A6rV+dX
kyeBXBqIc71b5h/NljnBrJf0Tds3q66qW15HGRT6Cy9SmSb0fwiXFw06Rav/XI31
F5vC4Ybo4a+XGe1D253v03abitvcDzrFjPVes4CazFFR3JguAhGV/Fox/kmurTGF
DslyTsSkspy3jbNHaocC9jt2+dRIhBpI+gozjfEoYes9WgKgHWoYblm/XKqQtJM0
S6ICeXvZ8WZ956LijGn4PyHspObKFxVZONR82P82bPk8Se0UIpUQLbLEK8kTaiDJ
s+pYfgyxmRR02rEtwxMGkW9JalN3dRlSb+s7VSaynnT9N/7eaZY=
=479n
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--
