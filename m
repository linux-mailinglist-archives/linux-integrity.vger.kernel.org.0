Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E811D1FD64D
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jun 2020 22:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgFQUpN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Jun 2020 16:45:13 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43843 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726496AbgFQUpN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Jun 2020 16:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592426710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4UszkC96Ue6UJvJMImuxq64bJybIiNVd2D/vB+9eg98=;
        b=NNeAMRWFbH/zIYfsUC2fl3szt5ocpwUmdT1LIWXc4HNai73br++xZFbM58lwZ6V577aaAD
        AhCX7LTED5oQmalay6xaQhcsxpg9ljj0tQVNJ6wbbWMlvxk3BmLVfZ9kO3yO0XDguXcaNT
        J8BXsquvLNZs63C2q0rRr3Ic4xOMH0Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-CH4e0J7LNA6ohRRiFRjddg-1; Wed, 17 Jun 2020 16:45:03 -0400
X-MC-Unique: CH4e0J7LNA6ohRRiFRjddg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9380A0BD7;
        Wed, 17 Jun 2020 20:45:01 +0000 (UTC)
Received: from localhost (ovpn-116-72.gru2.redhat.com [10.97.116.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 39E7919D9E;
        Wed, 17 Jun 2020 20:45:01 +0000 (UTC)
Date:   Wed, 17 Jun 2020 17:45:00 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        ltp@lists.linux.it, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Petr Cervinka <pcervinka@suse.com>,
        Cyril Hrubis <chrubis@suse.cz>,
        linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>,
        Maurizio Drocco <maurizio.drocco@ibm.com>
Subject: Re: [LTP v2 1/1] ima_tpm.sh: Fix for calculating boot aggregate
Message-ID: <20200617204500.GB40831@glitch>
References: <20200527071434.28574-1-pvorel@suse.cz>
 <1590601280.16219.1.camel@linux.ibm.com>
 <20200528140747.GA8401@dell5510>
 <1590679145.4457.39.camel@linux.ibm.com>
 <20200528160527.GA27243@dell5510>
 <20200615194134.GF129694@glitch>
 <1592252491.11061.181.camel@linux.ibm.com>
 <20200617012148.hhpvxqov2py7fvvc@cantor>
MIME-Version: 1.0
In-Reply-To: <20200617012148.hhpvxqov2py7fvvc@cantor>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2020 at 06:21:48PM -0700, Jerry Snitselaar wrote:
> On Mon Jun 15 20, Mimi Zohar wrote:
> > On Mon, 2020-06-15 at 16:41 -0300, Bruno Meneguele wrote:
> > > On Thu, May 28, 2020 at 06:05:27PM +0200, Petr Vorel wrote:
> > > > Hi Mimi,
> > > > ...
> > > > > > > With just this change, the ima_tpm.sh test is failing. =A0I a=
ssume it is
> > > > > > > failing because it is reading the SHA1 TPM bank, not the SHA2=
56 bank
> > > > > > > to calculate the boot_aggregate hash.
> > > > > > First question: is it correct to take sha256? Because on my tes=
t below it's
> > > > > > reading sha1, because that's the content of /sys/kernel/securit=
y/ima/ascii_runtime_measurements
> > > >
> > > > > > I thought just kernel commit: 6f1a1d103b48 ima: ("Switch to ima=
_hash_algo for
> > > > > > boot aggregate") from current linux-integrity tree is needed, b=
ut I tested it on
> > > > > > b59fda449cf0 ("ima: Set again build_ima_appraise variable") (i.=
e. having all
> > > > > > Robeto's ima patches,  missing just last 2 commits from next-in=
tegrity head).
> > > > > > What is needed to get your setup?
> > > >
> > > > > This isn't a configuration problem, but an issue of reading PCRs =
and
> > > > > calculating the TPM bank appropriate boot_aggregate. =A0If you're
> > > > > calculating a sha256 boot_aggregate, then the test needs to read =
and
> > > > > calculate the boot_aggregate by reading the SHA256 TPM bank.
> > > > OK, I tested it on TPM 1.2 (no TPM 2.0 available atm).
> > > > I guess you have TPM 2.0, that's why I didn't spot this issue.
> > > >
> > > > To sum that: my patch is required for any system without physical T=
PM with with
> > > > kernel with b59fda449cf0 + it also works for TPM 1.2 (regardless ke=
rnel
> > > > version), because TPM 1.2 supports sha1 only boot aggregate.
> > > >
> > > > But testing on kernel with b59fda449cf0 with TPM 2.0 is not only br=
oken with
> > > > this patch, but also on current version in master, right? As you ha=
ve
> > > > sha256:3fd5dc717f886ff7182526efc5edc3abb179a5aac1ab589c8ec888398233=
ae5 anyway.
> > > > So this patch would help at least testing on VM without vTPM.
> > > >
> > >=20
> > > If we consider to delay this change until we have the ima-evm-utils
> > > released with the ima_boot_aggregate + make this test dependent on
> > > both ima-evm-utils and tsspcrread, would it be worth to SKIP the test=
 in
> > > case a TPM2.0 sha256 bank is detected instead of FAIL? Thus we could
> > > have the test fixed for TPM1.2 && no-TPM cases until we get the full
> > > support for multiple banks?
> >=20
> > As long as we're dealing with the "boot_aggregate", Maurizio just
> > posted a kernel patch for including PCR 8 & 9 in the boot_aggregate.
> > =A0The existing IMA LTP "boot_aggregate" test is going to need to
> > support this change.
> >=20
> > I'd appreciate if someone could send me a TPM event log, the PCRs, and
> > the associated IMA ascii_runtime_measurements "boot_aggregate" from a
> > system with a discrete TPM 2.0 with PCRs 8 & 9 events.
> >=20

Maybe Maurizio already have it at hand?
I can try to setup a system with grub2+tpm to get the log with pcr 8 and
9 filled.

> > >=20
> > > > ...
> > > > > > > The ima-evm-utils next-testing branch has code to calculate t=
he
> > > > > > > boot_aggregate based on multiple banks.
> > > > > > I see, 696bf0b ("ima-evm-utils: calculate the digests for multi=
ple TPM banks")
> > > > > > I wonder whether it's reasonable trying to port that to ima_boo=
t_aggregate.c or
> > > > > > just depend on evmctl. External dependencies are sometimes comp=
licated, but for
> > > > > > IMA I incline to just require evmctl.
> > > >
> > > > > Unlike TPM 1.2, the TPM 2.0 device driver doesn't export the TPM =
PCRs.
> > > > > =A0Not only would you have a dependency on ima-evm-utils, but als=
o on a
> > > > > userspace application(s) for reading the TPM PCRs. =A0That depend=
ency
> > > > > exists whether you're using evmctl to calculate the boot_aggregat=
e or
> > > > > doing it yourself.
> > > > Hm, things get complicated.
> > > > Yep I remember your patch to skip verifying TPM 2.0 PCR values
> > > > https://patchwork.ozlabs.org/project/ltp/patch/1558041162.3971.2.ca=
mel@linux.ibm.com/
> > > > At least thanks to Jerry Snitselaar since v5.6 we have
> > > > /sys/class/tpm/tpm*/tpm_version_major. We could check this (+ try a=
lso
> > > > /sys/class/tpm/tpm0/device/description for older kernels).
> > > >
> > > > BTW on my system there is also /sys/class/tpm/tpm0/ppi/version, whi=
ch has 1.2,
> > > > not sure if it indicate TPM 1.2, but I wouldn't rely on that.
> > > >

Missed this last paragraph.. but /sys/class/tpm/tpm0/ppi/version has
relation to the Physical Presence Interface version, which is the
communication interface between firmware and OS afaik, and doesn't
points to the TPM version: TPM2.0 may have PPI version 1.2 or 1.3.

> > >=20
> > > IIUC 'tpm_version_major' should be the only safe reference of the act=
ual
> > > TCG spec version being implemented by the hw TPM, in a sysfs standard
> > > output.
> >=20
> > That was only upstreamed in linux-v5.6. =A0Has it been backported?
> >=20

Hmm, well pointed.=20

>=20
> Not that I know of. Since it isn't using chip->ops and only
> looks at chip->flags it could probably be backported, but I'd
> have to take a look at it.
>=20
> > The PCRs are not exported for TPM 2.0, unfortunately, making
> > regression tests dependent on a userspace app. =A0The existing LTP
> > ima_tpm.sh test looks for the PCRs in either
> > /sys/class/tpm/tpm0/device/pcrs or /sys/class/misc/tpm0/device/pcrs.
> > =A0Perhaps piggyback on the pseudo PCR file to test for TPM 1.2.
> >=20
> > >=20
> > > > ...
> > > > > > > There's also a new test to verify the boot_aggregate.
> > > >
> > > > > > > $ VERBOSE=3D1 make check TESTS=3Dboog_aggregate.test
> > > > > > BTW I got some errors
> > > > > > ...
> > > > > > make  check-TESTS
> > > > > > make[2]: Entering directory '/home/foo/ima-evm-utils/tests'
> > > > > > make[3]: Entering directory '/home/foo/ima-evm-utils/tests'
> > > > > > make[4]: Entering directory '/home/foo/ima-evm-utils/tests'
> > > > > > make[4]: Nothing to be done for 'boog_aggregate.log'.
> > > > > > make[4]: Leaving directory '/home/foo/ima-evm-utils/tests'
> > > > > > fatal: making test-suite.log: failed to create boog_aggregate.t=
rs
> > > > > > fatal: making test-suite.log: failed to create boog_aggregate.l=
og
> > > > > > make[3]: *** [Makefile:516: test-suite.log] Error 1
> > > > > > make[3]: Leaving directory '/home/foo/ima-evm-utils/tests'
> > > > > > make[2]: *** [Makefile:625: check-TESTS] Error 2
> > > > > > make[2]: Leaving directory '/home/foo/ima-evm-utils/tests'
> > > > > > make[1]: *** [Makefile:692: check-am] Error 2
> > > > > > make[1]: Leaving directory '/home/foo/ima-evm-utils/tests'
> > > > > > make: *** [Makefile:514: check-recursive] Error 1
> > > >
> > > > > [Cc'ing Vitaly]
> > > >
> > > > > The boot_aggregate.trs and boot_aggregate.log files are being cre=
ated
> > > > > in the tests/ directory. =A0Is that directory read-only?
> > > > Yes, drwxr-xr-x. Testing on fresh clone and issue persists.
> > > >
> > >=20
> > > Yes, same thing here.. but didn't really check the reason for that. W=
ill
> > > take a time later to see what's happening.
> >=20
> > Thanks, much appreciated. =A0I'm not seeing that here.
> >=20
> > Mimi
> >=20
>=20

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl7qgMsACgkQYdRkFR+R
okPKcgf8D93sgeHMpkPQXsPODX717VzCgg51hXtxg1idbxNJXF08oWMnBgngOG27
LamgCtep2ogLJz3e2M1Wo2mVDt+1/V/NGe1vaa4RKKwE9aXHZ7C3US7boMIVd9nw
KJnl/37qingvQ65+6oF59SR6Cx8F1imEhsieWMtOly12wVSzB4Vsk6/nWx5haCPh
0YmLk+I6gUXLl6JIIW//OiWW8urEFNtlIPLxNb+OAwbCB4fiX4ZjfFW2RzsizAzn
97qg9eyp+5AKaB00QkvgKLPXcJc3hBuMguvP7Igkr7mpMyPPpo/8anklAL2gj6UJ
XKYC77lt7/6fWRFxpc+veesLz+ko8w==
=vDc6
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--

