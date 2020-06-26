Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490C920B3DC
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Jun 2020 16:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgFZOqp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 26 Jun 2020 10:46:45 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30958 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727090AbgFZOqp (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 26 Jun 2020 10:46:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593182804;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9/4yQ9wzdMYlIWsH7godn+Od1tjRMVkquLG0kHXWsUc=;
        b=VJ5Tu3yKIRot2Wd8Oy3fzs2RfDHOpM5pj+hBTDhkw6ZCI0h7e+72awbSRbaampejAETOZn
        PyuJ3H0OraV8OQiGsEUJKkQn/Lq3i6lGDLejT0gUIu3NrVhGBdB2PPMaQ/PdvC9hxsbQe/
        YAbuijq0dSIuUJg74vP8TZko3/LHriU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-cCaW3d4sPHaV1pZ_8ts9ag-1; Fri, 26 Jun 2020 10:46:34 -0400
X-MC-Unique: cCaW3d4sPHaV1pZ_8ts9ag-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4894B804006;
        Fri, 26 Jun 2020 14:46:33 +0000 (UTC)
Received: from localhost (ovpn-116-153.gru2.redhat.com [10.97.116.153])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CDD331002395;
        Fri, 26 Jun 2020 14:46:32 +0000 (UTC)
Date:   Fri, 26 Jun 2020 11:46:31 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, erichte@linux.ibm.com, nayna@linux.ibm.com
Subject: Re: [PATCH v3 0/2] ima: make appraisal state runtime dependent on
 secure boot
Message-ID: <20200626144631.GC2702@glitch>
References: <20200623202640.4936-1-bmeneg@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200623202640.4936-1-bmeneg@redhat.com>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lCAWRPmW1mITcIfM"
Content-Disposition: inline
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

--lCAWRPmW1mITcIfM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Gentle ping for review.

I also forgot to add the changelog for the patch, please see below.

On Tue, Jun 23, 2020 at 05:26:38PM -0300, Bruno Meneguele wrote:
> To switch APPRAISE_BOOTPARAM and ARCH_POLICY dependency from compile time=
 to
> run time the secure boot checking code (specific to each arch) had to be
> slightly modified to include, in the PowerPC arch, the Trusted Boot state=
,
> which is also relevant to the arch policy choice and also required the
> ima_appraise to be enforced.=20
>=20
> With that I changed the checking order: instead of first check the
> arch_policy and then the secure/trusted boot state, now we first check th=
e
> boot state, set ima_appraise to be enforced and then the existence of arc=
h
> policy. In other words, whenever secure/trusted boot is enabled,
> (ima_appraise & IMA_APPRAISE_ENFORCE) =3D=3D true.
>=20
> I've tested these patches in a x86_64 platform with and without secure bo=
ot
> enabled and in a PowerPC without secure boot enabled:
>=20
> 1) with secure boot enabled (x86_64) and ima_policy=3Dappraise_tcb, the
> ima_appraise=3D options were completly ignored and the boot always failed=
 with
> "missing-hash" for /sbin/init, which is the expected result;
>=20
> 2) with secure boot enabled (x86_64), but no ima_policy:
>=20
> [    1.396111] ima: Allocated hash algorithm: sha256
> [    1.424025] ima: setting IMA appraisal to enforced
> [    1.424039] audit: type=3D1807 audit(1592927955.557:2): action=3Dmeasu=
re func=3DKEXEC_KERNEL_CHECK res=3D1
> [    1.424040] audit: type=3D1807 audit(1592927955.557:3): action=3Dmeasu=
re func=3DMODULE_CHECK res=3D1
>=20
> 3) with secure boot disabled (PowerPC and x86_64) and
> "ima_policy=3Dappraise_tcb ima_appraise=3Dfix", audit messages were trigg=
ered
> with "op=3Dappraisal_data cause=3Dmissing-hash" but the system worked fin=
e due
> to "fix".

Changelog:

v2:
  - pr_info() message prefix correction
v3:
  - extend secure boot arch checker to also consider trusted boot
  - enforce IMA appraisal when secure boot is effectively enabled (Nayna)
  - fix ima_appraise flag assignment by or'ing it (Mimi)

>=20
> Bruno Meneguele (2):
>   arch/ima: extend secure boot check to include trusted boot
>   ima: move APPRAISE_BOOTPARAM dependency on ARCH_POLICY to runtime
>=20
>  arch/powerpc/kernel/ima_arch.c      |  5 +++--
>  arch/s390/kernel/ima_arch.c         |  2 +-
>  arch/x86/kernel/ima_arch.c          |  4 ++--
>  include/linux/ima.h                 |  4 ++--
>  security/integrity/ima/Kconfig      |  2 +-
>  security/integrity/ima/ima_main.c   |  2 +-
>  security/integrity/ima/ima_policy.c | 20 ++++++++++++++------
>  7 files changed, 24 insertions(+), 15 deletions(-)
>=20
> --=20
> 2.26.2
>=20

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--lCAWRPmW1mITcIfM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl72CkcACgkQYdRkFR+R
okOBfAgAxpegp05PIswZixkunEPtvXqxm1Zxc0cVJOm6gsrj1kXj6RoQZBMdJYPb
EL3uajD23pHhZuTR9A3vPMcsHrEuB0PQsMtD3mfBjdf0QNvbOWT4uLqaDlMYeMTm
QFVcpxXjZ905/3f8dEsi0k6DqfGVj+OPIm/j2qauEMwvYvpNBo7z3UMrkm2RuZQW
BfVncYCPcDCT6ahedthkNjshBwK5WVZKJ7DaH92U+lNH7wF61AAPTPs/AanrXgpu
xT6lx/s0aZojzA7W+nhzC/6k7rhQJoZKxRX1wQYmtcxuabK85VHeWxRe1R+qfiNH
fcE9qfW+aG4xKC5ZSlsWbMVTzxZFwQ==
=HW86
-----END PGP SIGNATURE-----

--lCAWRPmW1mITcIfM--

