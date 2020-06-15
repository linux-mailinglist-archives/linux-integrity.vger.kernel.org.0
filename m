Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCF421FA0DE
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jun 2020 22:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbgFOUBd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Jun 2020 16:01:33 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24480 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728773AbgFOUBc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Jun 2020 16:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592251290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9Fp83YphQ9Iu4uCkVKF8Cj5cUrYo5JzJegzbAXaqdDA=;
        b=Ryx0dwBY1a/80vSGi3gQFnZvkWubck64qjsO4jXRVSHfxaM+9Bv02jWuzNtFosGgf7V1g1
        DT0UWL6VKUkrFmVM4XRlxQDzHoVKzxw4PvEiW9eIcXF2oT5grQb+JIch7m1zNV6oeth2Qo
        7SdoqokzruBSlFILr7N+JrMEN8N2MNo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-J7OhP2O-MZK68j4k1574Cg-1; Mon, 15 Jun 2020 16:01:25 -0400
X-MC-Unique: J7OhP2O-MZK68j4k1574Cg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6675B8B8761;
        Mon, 15 Jun 2020 20:01:23 +0000 (UTC)
Received: from localhost (ovpn-116-67.gru2.redhat.com [10.97.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 05FA07FE87;
        Mon, 15 Jun 2020 20:01:22 +0000 (UTC)
Date:   Mon, 15 Jun 2020 17:01:21 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, ltp@lists.linux.it,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Petr Cervinka <pcervinka@suse.com>,
        Cyril Hrubis <chrubis@suse.cz>,
        linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>
Subject: Re: [LTP v2 1/1] ima_tpm.sh: Fix for calculating boot aggregate
Message-ID: <20200615200121.GG129694@glitch>
References: <20200527071434.28574-1-pvorel@suse.cz>
 <1590601280.16219.1.camel@linux.ibm.com>
 <20200528140747.GA8401@dell5510>
 <1590679145.4457.39.camel@linux.ibm.com>
 <20200528160527.GA27243@dell5510>
 <20200615194134.GF129694@glitch>
MIME-Version: 1.0
In-Reply-To: <20200615194134.GF129694@glitch>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YH9Qf6Fh2G5kB/85"
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

--YH9Qf6Fh2G5kB/85
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2020 at 04:41:34PM -0300, Bruno Meneguele wrote:
> On Thu, May 28, 2020 at 06:05:27PM +0200, Petr Vorel wrote:
> > Hi Mimi,
> > ...
> > > > > With just this change, the ima_tpm.sh test is failing. =A0I assum=
e it is
> > > > > failing because it is reading the SHA1 TPM bank, not the SHA256 b=
ank
> > > > > to calculate the boot_aggregate hash.
> > > > First question: is it correct to take sha256? Because on my test be=
low it's
> > > > reading sha1, because that's the content of /sys/kernel/security/im=
a/ascii_runtime_measurements
> >=20
> > > > I thought just kernel commit: 6f1a1d103b48 ima: ("Switch to ima_has=
h_algo for
> > > > boot aggregate") from current linux-integrity tree is needed, but I=
 tested it on
> > > > b59fda449cf0 ("ima: Set again build_ima_appraise variable") (i.e. h=
aving all
> > > > Robeto's ima patches,  missing just last 2 commits from next-integr=
ity head).
> > > > What is needed to get your setup?  > > > > > This isn't a configura=
tion problem, but an issue of reading PCRs and
> > > calculating the TPM bank appropriate boot_aggregate. =A0If you're
> > > calculating a sha256 boot_aggregate, then the test needs to read and
> > > calculate the boot_aggregate by reading the SHA256 TPM bank.
> > OK, I tested it on TPM 1.2 (no TPM 2.0 available atm).
> > I guess you have TPM 2.0, that's why I didn't spot this issue.
> >=20
> > To sum that: my patch is required for any system without physical TPM w=
ith with
> > kernel with b59fda449cf0 + it also works for TPM 1.2 (regardless kernel
> > version), because TPM 1.2 supports sha1 only boot aggregate.
> >=20
> > But testing on kernel with b59fda449cf0 with TPM 2.0 is not only broken=
 with
> > this patch, but also on current version in master, right? As you have
> > sha256:3fd5dc717f886ff7182526efc5edc3abb179a5aac1ab589c8ec888398233ae5 =
anyway.
> > So this patch would help at least testing on VM without vTPM.
> >=20
>=20
> If we consider to delay this change until we have the ima-evm-utils
> released with the ima_boot_aggregate + make this test dependent on
> both ima-evm-utils and tsspcrread, would it be worth to SKIP the test in
> case a TPM2.0 sha256 bank is detected instead of FAIL? Thus we could
> have the test fixed for TPM1.2 && no-TPM cases until we get the full
> support for multiple banks?
>=20
> > ...
> > > > > The ima-evm-utils next-testing branch has code to calculate the
> > > > > boot_aggregate based on multiple banks.
> > > > I see, 696bf0b ("ima-evm-utils: calculate the digests for multiple =
TPM banks")
> > > > I wonder whether it's reasonable trying to port that to ima_boot_ag=
gregate.c or
> > > > just depend on evmctl. External dependencies are sometimes complica=
ted, but for
> > > > IMA I incline to just require evmctl.
> >=20
> > > Unlike TPM 1.2, the TPM 2.0 device driver doesn't export the TPM PCRs=
.
> > > =A0Not only would you have a dependency on ima-evm-utils, but also on=
 a
> > > userspace application(s) for reading the TPM PCRs. =A0That dependency
> > > exists whether you're using evmctl to calculate the boot_aggregate or
> > > doing it yourself.
> > Hm, things get complicated.
> > Yep I remember your patch to skip verifying TPM 2.0 PCR values
> > https://patchwork.ozlabs.org/project/ltp/patch/1558041162.3971.2.camel@=
linux.ibm.com/
> > At least thanks to Jerry Snitselaar since v5.6 we have
> > /sys/class/tpm/tpm*/tpm_version_major. We could check this (+ try also
> > /sys/class/tpm/tpm0/device/description for older kernels).
> >=20
> > BTW on my system there is also /sys/class/tpm/tpm0/ppi/version, which h=
as 1.2,
> > not sure if it indicate TPM 1.2, but I wouldn't rely on that.
> >=20
>=20
> IIUC 'tpm_version_major' should be the only safe reference of the actual
> TCG spec version being implemented by the hw TPM, in a sysfs standard
> output.
>=20
> > ...
> > > > > There's also a new test to verify the boot_aggregate.
> >=20
> > > > > $ VERBOSE=3D1 make check TESTS=3Dboog_aggregate.test
                                       ^^^^
=09=09=09=09       boot

That's the issue :).

> > > > BTW I got some errors
> > > > ...
> > > > make  check-TESTS
> > > > make[2]: Entering directory '/home/foo/ima-evm-utils/tests'
> > > > make[3]: Entering directory '/home/foo/ima-evm-utils/tests'
> > > > make[4]: Entering directory '/home/foo/ima-evm-utils/tests'
> > > > make[4]: Nothing to be done for 'boog_aggregate.log'.
> > > > make[4]: Leaving directory '/home/foo/ima-evm-utils/tests'
> > > > fatal: making test-suite.log: failed to create boog_aggregate.trs
> > > > fatal: making test-suite.log: failed to create boog_aggregate.log
> > > > make[3]: *** [Makefile:516: test-suite.log] Error 1
> > > > make[3]: Leaving directory '/home/foo/ima-evm-utils/tests'
> > > > make[2]: *** [Makefile:625: check-TESTS] Error 2
> > > > make[2]: Leaving directory '/home/foo/ima-evm-utils/tests'
> > > > make[1]: *** [Makefile:692: check-am] Error 2
> > > > make[1]: Leaving directory '/home/foo/ima-evm-utils/tests'
> > > > make: *** [Makefile:514: check-recursive] Error 1
> >=20
> > > [Cc'ing Vitaly]
> >=20
> > > The boot_aggregate.trs and boot_aggregate.log files are being created
> > > in the tests/ directory. =A0Is that directory read-only?
> > Yes, drwxr-xr-x. Testing on fresh clone and issue persists.
> >=20
>=20
> Yes, same thing here.. but didn't really check the reason for that. Will
> take a time later to see what's happening.
>=20
> > > > > Both need some review and testing before being released.
> > > > Any estimation when code is released?
> >=20
> > > Probably not before the next open window, but definitely before it is
> > > released.
> > Thanks for info.
> >=20
>=20
> --=20
> bmeneg=20
> PGP Key: http://bmeneg.com/pubkey.txt



--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--YH9Qf6Fh2G5kB/85
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl7n05EACgkQYdRkFR+R
okM3RAgAzscBmkyoWf16HvUXf7A4NIt1uUsC8w5emjZw50st8s1xZgKDCydvrFsc
XnwF9UH3Sh7+r/ZMHUZ1N7HeFqOgxitqC3XZEBQVq6Ph5wZv1PaT72Lhna5LLXEt
MgfYQovvM8GxbUv7wTDsK59vFc/1MOaygxwL6zwG0/bwg8IkKyptRlgrsrwEYUXM
Z2HVIXAvUff0FysXGPJnmVBcxpzQi0lTs4hd9fciy75Jf7bJQt3Dz9aOYmaZ8b5x
fG5w8xM7ZsW4kab6j1FWzFlsXiDrIBPoA8RZEIAiroBJWhwhs+bKDbCRWZWkq+Ei
Ih4AXYlcMT7VN8YKFep6XgFpW/dzXA==
=o6OR
-----END PGP SIGNATURE-----

--YH9Qf6Fh2G5kB/85--

