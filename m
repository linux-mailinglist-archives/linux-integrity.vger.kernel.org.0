Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B62E4D6693
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Mar 2022 17:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349844AbiCKQlJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Mar 2022 11:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbiCKQlH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Mar 2022 11:41:07 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8C91B60B0;
        Fri, 11 Mar 2022 08:40:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0F5E9CE294C;
        Fri, 11 Mar 2022 16:40:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1125C340E9;
        Fri, 11 Mar 2022 16:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647016800;
        bh=xAQesJm2XzMSPjRWRkbuzP8E/HwIUyUXHhBDPK3AifM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GIgHtmezvcHnWsSoyna5wsVHeNlnY8NUR2uBCJpmWExIZN54hqRdQZRVEfFbZU9Qx
         Uer2HApzZ5RGFVu90IxueG7SDnZxkSP5ZXQJW0jDOCvHkF39QLn60EGNHfSM1R/UPJ
         zVmciQci8KZrDkK5HIfQbKnjQmRkQwuGKklbu5qnNUxYA3CWtYRYGAVXcy7IxzcRHU
         CL0+QdOZk/DhZGTIT8oG7YzIH5B6wgP+LswMjWfi293yvxGGOPooRTm5Vi0Axt4HDR
         OQKIlb1yXKWFOSF/EOenpTQ7xIoNKhnnMgwYLkGHkHqAej/ZfcguEp0uZ48z5bwzxo
         ATXGNGi3ZVdGg==
Message-ID: <286a9ec3aa052cc1ed61e7257af492325d8e7279.camel@kernel.org>
Subject: Re: [PATCH v11 0/4] integrity: support including firmware
 ".platform" keys at build time
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org
Cc:     dhowells@redhat.com, zohar@linux.ibm.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dimitri.ledkov@canonical.com,
        seth@forshee.me, rnsastry@linux.ibm.com,
        Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 11 Mar 2022 18:39:14 +0200
In-Reply-To: <20220310214450.676505-1-nayna@linux.ibm.com>
References: <20220310214450.676505-1-nayna@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2022-03-10 at 16:44 -0500, Nayna Jain wrote:
> Some firmware support secure boot by embedding static keys to verify the
> Linux kernel during boot. However, these firmware do not expose an
> interface for the kernel to load firmware keys onto the ".platform"
> keyring, preventing the kernel from verifying the kexec kernel image
> signature.
>=20
> This patchset exports load_certificate_list() and defines a new function
> load_builtin_platform_cert() to load compiled in certificates onto the
> ".platform" keyring.
>=20
> Changelog:
> v11:
> * Added a new patch to conditionally build extract-cert if
> PLATFORM_KEYRING is enabled.
>=20
> v10:
> * Fixed the externs warning for Patch 3.
>=20
> v9:
> * Rebased on Jarkko's repo -=20
> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git
>=20
> v8:
> * Includes Jarkko's feedback on patch description and removed Reported-by
> for Patch 1.
>=20
> v7:
> * Incldues Jarkko's feedback on patch description for Patch 1 and 3.
>=20
> v6:
> * Includes Jarkko's feedback:
> =C2=A0* Split Patch 2 into two.
> =C2=A0* Update Patch description.
>=20
> v5:
> * Renamed load_builtin_platform_cert() to load_platform_certificate_list(=
)
> and config INTEGRITY_PLATFORM_BUILTIN_KEYS to INTEGRITY_PLATFORM_KEYS, as
> suggested by Mimi Zohar.
>=20
> v4:
> * Split into two patches as per Mimi Zohar and Dimitri John Ledkov
> recommendation.
>=20
> v3:
> * Included Jarkko's feedback
> =C2=A0** updated patch description to include approach.
> =C2=A0** removed extern for function declaration in the .h file.
> * Included load_certificate_list() within #ifdef CONFIG_KEYS condition.
>=20
> v2:
> * Fixed the error reported by kernel test robot
> * Updated patch description based on Jarkko's feedback.
>=20
> Nayna Jain (4):
> =C2=A0 certs: export load_certificate_list() to be used outside certs/
> =C2=A0 integrity: make integrity_keyring_from_id() non-static
> =C2=A0 certs: conditionally build extract-cert if platform keyring is ena=
bled
> =C2=A0 integrity: support including firmware ".platform" keys at build ti=
me
>=20
> =C2=A0certs/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 9 ++++=
++--
> =C2=A0certs/blacklist.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 -
> =C2=A0certs/common.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0certs/common.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 9 ----=
----
> =C2=A0certs/system_keyring.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 1 -
> =C2=A0include/keys/system_keyring.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 ++++=
+
> =C2=A0security/integrity/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 10 ++++++++
> =C2=A0security/integrity/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 15 =
+++++++++++-
> =C2=A0security/integrity/digsig.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 2 +-
> =C2=A0security/integrity/integrity.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 9 ++++++++
> =C2=A0.../integrity/platform_certs/platform_cert.S=C2=A0 | 23 +++++++++++=
++++++++
> =C2=A0.../platform_certs/platform_keyring.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 23 +++++++++++++++++++
> =C2=A012 files changed, 94 insertions(+), 16 deletions(-)
> =C2=A0delete mode 100644 certs/common.h
> =C2=A0create mode 100644 security/integrity/platform_certs/platform_cert.=
S
>=20
>=20
> base-commit: fb5abce6b2bb5cb3d628aaa63fa821da8c4600f9

I tuned tags. Nayna, Mimi is this how it should be:

commit f38ebfc7469c4924087dab2203479ee9bb6911ac (HEAD -> master, origin/nex=
t, origin/master, origin/HEAD, next)
Author: Nayna Jain <nayna@linux.ibm.com>
Date:   Thu Mar 10 16:44:50 2022 -0500

    integrity: support including firmware ".platform" keys at build time
   =20
    Allow firmware keys to be embedded in the Linux kernel and loaded onto
    the ".platform" keyring on boot.
   =20
    The firmware keys can be specified in a file as a list of PEM encoded
    certificates using new config INTEGRITY_PLATFORM_KEYS. The certificates
    are embedded in the image by converting the PEM-formatted certificates
    into DER(binary) and generating
    security/integrity/platform_certs/platform_certificate_list file at
    build time. On boot, the embedded certs from the image are loaded onto
    the ".platform" keyring at late_initcall(), ensuring the platform keyri=
ng
    exists before loading the keys.
   =20
    Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
    Tested-by: Mimi Zohar <zohar@linux.ibm.com>
    Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
    Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

commit 233bb42918e71f143e6f31d99763348768eb1619
Author: Nayna Jain <nayna@linux.ibm.com>
Date:   Thu Mar 10 16:44:49 2022 -0500

    certs: conditionally build extract-cert if platform keyring is enabled
   =20
    extract-cert is used outside certs/ by INTEGRITY_PLATFORM_KEYRING.
    Also build extract-cert if INTEGRITY_PLATFORM_KEYRING is enabled.
   =20
    Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
    Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
    Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

commit 5e1a41f1c2ee838af6ac39d1cdd4ed0f509186a1
Author: Nayna Jain <nayna@linux.ibm.com>
Date:   Thu Mar 10 16:44:48 2022 -0500

    integrity: make integrity_keyring_from_id() non-static
   =20
    Make integrity_keyring_from_id() non-static so that it is accessible
    by other files in security/integrity.
   =20
    Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
    Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
    Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
    Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

commit 05489d362bde0f25c4e921d15cad4492d22147ae
Author: Nayna Jain <nayna@linux.ibm.com>
Date:   Thu Mar 10 16:44:47 2022 -0500

    certs: export load_certificate_list() to be used outside certs/
   =20
    load_certificate_list() parses certificates embedded in the kernel
    image to load them onto the keyring.
   =20
    Commit "2565ca7f5ec1 (certs: Move load_system_certificate_list to a com=
mon
    function)" made load_certificate_list() a common function in the certs/
    directory. Export load_certificate_list() outside certs/ to be used by
    load_platform_certificate_list() for loading compiled in platform keys
    onto the .platform keyring at boot time.
   =20
    Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
    Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
    Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
    Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
