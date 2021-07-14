Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0EEB3C7E96
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Jul 2021 08:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238003AbhGNGjz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Jul 2021 02:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237958AbhGNGjz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Jul 2021 02:39:55 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502EBC061574
        for <linux-integrity@vger.kernel.org>; Tue, 13 Jul 2021 23:37:04 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1m3YVv-0002gz-F1; Wed, 14 Jul 2021 08:36:59 +0200
Subject: Re: [PATCH v2 0/6] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        James Bottomley <jejb@linux.ibm.com>
Cc:     Jan Luebbe <j.luebbe@pengutronix.de>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        David Gstir <david@sigma-star.at>,
        Eric Biggers <ebiggers@kernel.org>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Richard Weinberger <richard@nod.at>,
        James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, kernel@pengutronix.de,
        linux-integrity@vger.kernel.org,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        "Serge E. Hallyn" <serge@hallyn.com>
References: <cover.1dfbb73645d917b3c76d01290804a3410bd9932e.1624364386.git-series.a.fatoum@pengutronix.de>
Message-ID: <6e6e0207-f137-e305-f9d7-3b8cd1ebe330@pengutronix.de>
Date:   Wed, 14 Jul 2021 08:36:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <cover.1dfbb73645d917b3c76d01290804a3410bd9932e.1624364386.git-series.a.fatoum@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Dear Trusted Keys and CAAM maintainers/reviewers,

On 22.06.21 14:37, Ahmad Fatoum wrote:
> The first three patches are new and are applicable regardless of this
> series, but the rest won't apply cleanly without them. I chose to
> include them this time, but I can split them up for v3 if that's
> preferred.
> 
> v1 -> v2:
>  - Added new commit to make trusted key Kconfig option independent
>    of TPM and added new Kconfig file and symbols for trusted keys
>  - Add new commit for importing existing key material (Jan)
>  - Allow users to force use of kernel RNG (Jarkko)
>  - Enforce maximum keymod size (Horia)
>  - Use append_seq_(in|out)_ptr_intlen instead of append_seq_(in|out)_ptr
>    (Horia)
>  - Make blobifier handle private to CAAM glue code file (Horia)
>  - Extend trusted keys documentation for CAAM
>  - Rebased on v5.12-rc7 and updated cover letter:
> 
> The Cryptographic Acceleration and Assurance Module (CAAM) is an IP core
> built into many newer i.MX and QorIQ SoCs by NXP.
> 
> Its blob mechanism can AES encrypt/decrypt user data using a unique
> never-disclosed device-specific key.
> 
> There has been multiple discussions on how to represent this within the kernel:
> 
> The Cryptographic Acceleration and Assurance Module (CAAM) is an IP core
> built into many newer i.MX and QorIQ SoCs by NXP.
> 
> Its blob mechanism can AES encrypt/decrypt user data using a unique
> never-disclosed device-specific key. There has been multiple
> discussions on how to represent this within the kernel:
> 
>  - [RFC] crypto: caam - add red blobifier
>    Steffen implemented[1] a PoC sysfs driver to start a discussion on how to
>    best integrate the blob mechanism.
>    Mimi suggested that it could be used to implement trusted keys.
>    Trusted keys back then were a TPM-only feature.
> 
>  - security/keys/secure_key: Adds the secure key support based on CAAM.
>    Udit added[2] a new "secure" key type with the CAAM as backend. The key
>    material stays within the kernel only.
>    Mimi and James agreed that this needs a generic interface, not specific
>    to CAAM. Mimi suggested trusted keys. Jan noted that this could serve as
>    basis for TEE-backed keys.
> 
>  - [RFC] drivers: crypto: caam: key: Add caam_tk key type
>    Franck added[3] a new "caam_tk" key type based on Udit's work. This time
>    it uses CAAM "black blobs" instead of "red blobs", so key material stays
>    within the CAAM and isn't exposed to kernel in plaintext.
>    James voiced the opinion that there should be just one user-facing generic
>    wrap/unwrap key type with multiple possible handlers.
>    David suggested trusted keys.
> 
>  - Introduce TEE based Trusted Keys support
>    Sumit reworked[4] trusted keys to support multiple possible backends with
>    one chosen at boot time and added a new TEE backend along with TPM.
>    This now sits in Jarkko's master branch to be sent out for v5.13
> 
> This patch series builds on top of Sumit's rework to have the CAAM as yet another
> trusted key backend.
> 
> The CAAM bits are based on Steffen's initial patch from 2015. His work had been
> used in the field for some years now, so I preferred not to deviate too much from it.
> 
> This series has been tested with dmcrypt[5] on an i.MX6DL.
> 
> Looking forward to your feedback.

Gentle Ping.

> Cheers,
> Ahmad
> 
>  [1]: https://lore.kernel.org/linux-crypto/1447082306-19946-2-git-send-email-s.trumtrar@pengutronix.de/
>  [2]: https://lore.kernel.org/linux-integrity/20180723111432.26830-1-udit.agarwal@nxp.com/
>  [3]: https://lore.kernel.org/lkml/1551456599-10603-2-git-send-email-franck.lenormand@nxp.com/
>  [4]: https://lore.kernel.org/lkml/1604419306-26105-1-git-send-email-sumit.garg@linaro.org/
>  [5]: https://lore.kernel.org/linux-integrity/20210122084321.24012-2-a.fatoum@pengutronix.de/
> 
> ---
> To: Jarkko Sakkinen <jarkko@kernel.org>
> To: "Horia Geantă" <horia.geanta@nxp.com>
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
> Ahmad Fatoum (6):
>   KEYS: trusted: allow use of TEE as backend without TCG_TPM support
>   KEYS: trusted: Allow import from existing key material for development
>   KEYS: trusted: allow users to use kernel RNG for key material
>   KEYS: trusted: allow trust sources to use kernel RNG for key material
>   crypto: caam - add in-kernel interface for blob generator
>   KEYS: trusted: Introduce support for NXP CAAM-based trusted keys
> 
>  Documentation/admin-guide/kernel-parameters.txt   |   8 +-
>  Documentation/security/keys/trusted-encrypted.rst |  74 ++++-
>  drivers/crypto/caam/Kconfig                       |   3 +-
>  drivers/crypto/caam/Makefile                      |   1 +-
>  drivers/crypto/caam/blob_gen.c                    | 230 +++++++++++++++-
>  include/keys/trusted-type.h                       |   2 +-
>  include/keys/trusted_caam.h                       |  11 +-
>  include/soc/fsl/caam-blob.h                       |  56 ++++-
>  security/keys/Kconfig                             |  14 +-
>  security/keys/trusted-keys/Kconfig                |  49 +++-
>  security/keys/trusted-keys/Makefile               |  10 +-
>  security/keys/trusted-keys/trusted_caam.c         |  74 +++++-
>  security/keys/trusted-keys/trusted_core.c         |  48 ++-
>  13 files changed, 554 insertions(+), 26 deletions(-)
>  create mode 100644 drivers/crypto/caam/blob_gen.c
>  create mode 100644 include/keys/trusted_caam.h
>  create mode 100644 include/soc/fsl/caam-blob.h
>  create mode 100644 security/keys/trusted-keys/Kconfig
>  create mode 100644 security/keys/trusted-keys/trusted_caam.c
> 
> base-commit: 13311e74253fe64329390df80bed3f07314ddd61
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
