Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5AEC3F2FA9
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Aug 2021 17:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241088AbhHTPkr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Aug 2021 11:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241087AbhHTPkq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Aug 2021 11:40:46 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5226C061757
        for <linux-integrity@vger.kernel.org>; Fri, 20 Aug 2021 08:40:08 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id k14so9555410pga.13
        for <linux-integrity@vger.kernel.org>; Fri, 20 Aug 2021 08:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wlO9V7SW6IaHABLwjO77mIay7x3gK+WvBoJlACtqQcs=;
        b=MzBRXyj8R7rO3qa70MpA+P3PfcCaftOw9fTjTOSOjEwYSvywE2HHn4B7//MSzI9+Hb
         jtEje4snibiPQvD5QeY6B1a0hIvrq6ea4ImRq/fjDYxGcCgwujami7Zs5AvczNb/FmGn
         acXSOgZIjvetkAlkZm15Ba11Y7d8lE0JzjAWI/V8p4nhI5W1/Vgek4yALB5nFKB2zkW2
         +eP+wVJViLOABkEzVUZYDil3HkPvcC9s3DW7dUZo/WSIQo55pFWq+8lDtaSNfHwnnNqh
         2k+C9PJoqm9bfg3feQENeY2vURgzqCRN9UbkWwZRbXJmueIIho2XN+FTSkn+bPBg2kyc
         TG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wlO9V7SW6IaHABLwjO77mIay7x3gK+WvBoJlACtqQcs=;
        b=uYLeSwzeSZhe8FNKjK8sBq9JXi4oojTqTh1wKSdMpdRVd2ROU/GbiOoEE6jYN7418s
         WT1reuk1jlmVNEGeqOIjtykKIZ7HTTizbkHtIGdF5sqBj8ASf2YsKe8eSSZBru5/7G1k
         FJUlpX+S8mYd/EHibJ0KvrYwZnracJUNDFaZYw+POEfngcMJDPlb5aE/aQ86zxlWPfkA
         zKVvlb73kxrDQEA3Jc0md+OVZ91lIG5JhNiPHM9d3VM1DPCNA3bK7D9zR9NmPDYAsy/c
         gtwbDvxwlH2uH9XQ4pgd/YDgBxE1verKCZDtgnlJnVNBRmPcSXIUG1n/+aeVUDb0jGht
         uL7Q==
X-Gm-Message-State: AOAM533uoU7pIQ2DEzLCwsZfYUJ0iv2SCW63JqnvZdiEFmNQgFFhuzC0
        iMLnHj0GDbihvEhRwYfcnI+ajDMDF+UeWG9JKguoaA==
X-Google-Smtp-Source: ABdhPJx2PTg/DyIXqqVBBhfHjZXiCbmBKM4LXV6vrl2QyPYJ7q/0DG3yGYBSUd+N4MEXVRsjWyXPYViAK3nI8B31IbI=
X-Received: by 2002:a63:150e:: with SMTP id v14mr19464945pgl.126.1629474007964;
 Fri, 20 Aug 2021 08:40:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.9fc9298fd9d63553491871d043a18affc2dbc8a8.1626885907.git-series.a.fatoum@pengutronix.de>
In-Reply-To: <cover.9fc9298fd9d63553491871d043a18affc2dbc8a8.1626885907.git-series.a.fatoum@pengutronix.de>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Fri, 20 Aug 2021 08:39:56 -0700
Message-ID: <CAJ+vNU23cXPmiqKcKH_WAgD-ea+=pEJzGK+q7zOy=v2o0XU7kA@mail.gmail.com>
Subject: Re: [PATCH 0/4] KEYS: trusted: Introduce support for NXP CAAM-based
 trusted keys
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        James Bottomley <jejb@linux.ibm.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Eric Biggers <ebiggers@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jul 21, 2021 at 9:49 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrot=
e:
>
> Series applies on top of
> https://lore.kernel.org/linux-integrity/20210721160258.7024-1-a.fatoum@pe=
ngutronix.de/T/#u
>
> v2 -> v3:
>  - Split off first Kconfig preparation patch. It fixes a regression,
>    so sent that out, so it can be applied separately (Sumit)
>  - Split off second key import patch. I'll send that out separately
>    as it's a development aid and not required within the CAAM series
>  - add MAINTAINERS entry
>
> v1 -> v2:
>  - Added new commit to make trusted key Kconfig option independent
>    of TPM and added new Kconfig file for trusted keys
>  - Add new commit for importing existing key material
>  - Allow users to force use of kernel RNG (Jarkko)
>  - Enforce maximum keymod size (Horia)
>  - Use append_seq_(in|out)_ptr_intlen instead of append_seq_(in|out)_ptr
>    (Horia)
>  - Make blobifier handle private to CAAM glue code file (Horia)
>  - Extend trusted keys documentation for CAAM
>  - Rebased and updated original cover letter:
>
> The Cryptographic Acceleration and Assurance Module (CAAM) is an IP core
> built into many newer i.MX and QorIQ SoCs by NXP.
>
> Its blob mechanism can AES encrypt/decrypt user data using a unique
> never-disclosed device-specific key.
>
> There has been multiple discussions on how to represent this within the k=
ernel:
>
> The Cryptographic Acceleration and Assurance Module (CAAM) is an IP core
> built into many newer i.MX and QorIQ SoCs by NXP.
>
> Its blob mechanism can AES encrypt/decrypt user data using a unique
> never-disclosed device-specific key. There has been multiple
> discussions on how to represent this within the kernel:
>
>  - [RFC] crypto: caam - add red blobifier
>    Steffen implemented[1] a PoC sysfs driver to start a discussion on how=
 to
>    best integrate the blob mechanism.
>    Mimi suggested that it could be used to implement trusted keys.
>    Trusted keys back then were a TPM-only feature.
>
>  - security/keys/secure_key: Adds the secure key support based on CAAM.
>    Udit added[2] a new "secure" key type with the CAAM as backend. The ke=
y
>    material stays within the kernel only.
>    Mimi and James agreed that this needs a generic interface, not specifi=
c
>    to CAAM. Mimi suggested trusted keys. Jan noted that this could serve =
as
>    basis for TEE-backed keys.
>
>  - [RFC] drivers: crypto: caam: key: Add caam_tk key type
>    Franck added[3] a new "caam_tk" key type based on Udit's work. This ti=
me
>    it uses CAAM "black blobs" instead of "red blobs", so key material sta=
ys
>    within the CAAM and isn't exposed to kernel in plaintext.
>    James voiced the opinion that there should be just one user-facing gen=
eric
>    wrap/unwrap key type with multiple possible handlers.
>    David suggested trusted keys.
>
>  - Introduce TEE based Trusted Keys support
>    Sumit reworked[4] trusted keys to support multiple possible backends w=
ith
>    one chosen at boot time and added a new TEE backend along with TPM.
>    This now sits in Jarkko's master branch to be sent out for v5.13
>
> This patch series builds on top of Sumit's rework to have the CAAM as yet=
 another
> trusted key backend.
>
> The CAAM bits are based on Steffen's initial patch from 2015. His work ha=
d been
> used in the field for some years now, so I preferred not to deviate too m=
uch from it.
>
> This series has been tested with dmcrypt[5] on an i.MX6DL.
>
> Looking forward to your feedback.
>
> Cheers,
> Ahmad
>
>  [1]: https://lore.kernel.org/linux-crypto/1447082306-19946-2-git-send-em=
ail-s.trumtrar@pengutronix.de/
>  [2]: https://lore.kernel.org/linux-integrity/20180723111432.26830-1-udit=
.agarwal@nxp.com/
>  [3]: https://lore.kernel.org/lkml/1551456599-10603-2-git-send-email-fran=
ck.lenormand@nxp.com/
>  [4]: https://lore.kernel.org/lkml/1604419306-26105-1-git-send-email-sumi=
t.garg@linaro.org/
>  [5]: https://lore.kernel.org/linux-integrity/20210122084321.24012-2-a.fa=
toum@pengutronix.de/
>
> ---
> To: Jarkko Sakkinen <jarkko@kernel.org>
> To: "Horia Geant=C4=83" <horia.geanta@nxp.com>
> To: Mimi Zohar <zohar@linux.ibm.com>
> To: Aymen Sghaier <aymen.sghaier@nxp.com>
> To: Herbert Xu <herbert@gondor.apana.org.au>
> To: "David S. Miller" <davem@davemloft.net>
> To: James Bottomley <jejb@linux.ibm.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Cc: Udit Agarwal <udit.agarwal@nxp.com>
> Cc: Jan Luebbe <j.luebbe@pengutronix.de>
> Cc: David Gstir <david@sigma-star.at>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Franck LENORMAND <franck.lenormand@nxp.com>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: linux-integrity@vger.kernel.org
> Cc: keyrings@vger.kernel.org
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
>
> Ahmad Fatoum (4):
>   KEYS: trusted: allow users to use kernel RNG for key material
>   KEYS: trusted: allow trust sources to use kernel RNG for key material
>   crypto: caam - add in-kernel interface for blob generator
>   KEYS: trusted: Introduce support for NXP CAAM-based trusted keys
>
>  Documentation/admin-guide/kernel-parameters.txt   |   8 +-
>  Documentation/security/keys/trusted-encrypted.rst |  60 +++-
>  MAINTAINERS                                       |   9 +-
>  drivers/crypto/caam/Kconfig                       |   3 +-
>  drivers/crypto/caam/Makefile                      |   1 +-
>  drivers/crypto/caam/blob_gen.c                    | 230 +++++++++++++++-
>  include/keys/trusted-type.h                       |   2 +-
>  include/keys/trusted_caam.h                       |  11 +-
>  include/soc/fsl/caam-blob.h                       |  56 ++++-
>  security/keys/trusted-keys/Kconfig                |  11 +-
>  security/keys/trusted-keys/Makefile               |   2 +-
>  security/keys/trusted-keys/trusted_caam.c         |  74 +++++-
>  security/keys/trusted-keys/trusted_core.c         |  23 +-
>  13 files changed, 477 insertions(+), 13 deletions(-)
>  create mode 100644 drivers/crypto/caam/blob_gen.c
>  create mode 100644 include/keys/trusted_caam.h
>  create mode 100644 include/soc/fsl/caam-blob.h
>  create mode 100644 security/keys/trusted-keys/trusted_caam.c
>
> base-commit: 97408d81ed533b953326c580ff2c3f1948b3fcee
> --
> git-series 0.9.1

Ahmad,

Thanks for your work!

I've been asked to integrate the capability of using CAAM to
blob/deblob data to an older 5.4 kernel such as NXP's downstream
vendor kernel does [1] and I'm trying to understand how your series
works. I'm not at all familiar with the Linux Key Management API's or
trusted keys. Can you provide an example of how this can be used for
such a thing?

Best regards,

Tim
[1] https://source.codeaurora.org/external/imxsupport/imx_sec_apps/tree/dem=
o-caam-blobs/README.txt
