Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62B253F3168
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Aug 2021 18:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhHTQUl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Aug 2021 12:20:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbhHTQUl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Aug 2021 12:20:41 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DDFC061575
        for <linux-integrity@vger.kernel.org>; Fri, 20 Aug 2021 09:20:02 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1mH7FQ-0003Zo-4a; Fri, 20 Aug 2021 18:20:00 +0200
Subject: Re: [PATCH 0/4] KEYS: trusted: Introduce support for NXP CAAM-based
 trusted keys
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     David Gstir <david@sigma-star.at>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>, keyrings@vger.kernel.org,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        linux-security-module@vger.kernel.org,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
        Richard Weinberger <richard@nod.at>,
        James Morris <jmorris@namei.org>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        David Howells <dhowells@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>,
        linux-integrity@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
References: <cover.9fc9298fd9d63553491871d043a18affc2dbc8a8.1626885907.git-series.a.fatoum@pengutronix.de>
 <CAJ+vNU23cXPmiqKcKH_WAgD-ea+=pEJzGK+q7zOy=v2o0XU7kA@mail.gmail.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <2b48a848-d70b-9c43-5ca0-9ab72622ed12@pengutronix.de>
Date:   Fri, 20 Aug 2021 18:19:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAJ+vNU23cXPmiqKcKH_WAgD-ea+=pEJzGK+q7zOy=v2o0XU7kA@mail.gmail.com>
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

Hello Tim,

On 20.08.21 17:39, Tim Harvey wrote:
> On Wed, Jul 21, 2021 at 9:49 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>>
>> Series applies on top of
>> https://lore.kernel.org/linux-integrity/20210721160258.7024-1-a.fatoum@pengutronix.de/T/#u
>>
>> v2 -> v3:
>>  - Split off first Kconfig preparation patch. It fixes a regression,
>>    so sent that out, so it can be applied separately (Sumit)
>>  - Split off second key import patch. I'll send that out separately
>>    as it's a development aid and not required within the CAAM series
>>  - add MAINTAINERS entry
>>
>> v1 -> v2:
>>  - Added new commit to make trusted key Kconfig option independent
>>    of TPM and added new Kconfig file for trusted keys
>>  - Add new commit for importing existing key material
>>  - Allow users to force use of kernel RNG (Jarkko)
>>  - Enforce maximum keymod size (Horia)
>>  - Use append_seq_(in|out)_ptr_intlen instead of append_seq_(in|out)_ptr
>>    (Horia)
>>  - Make blobifier handle private to CAAM glue code file (Horia)
>>  - Extend trusted keys documentation for CAAM
>>  - Rebased and updated original cover letter:
>>
>> The Cryptographic Acceleration and Assurance Module (CAAM) is an IP core
>> built into many newer i.MX and QorIQ SoCs by NXP.
>>
>> Its blob mechanism can AES encrypt/decrypt user data using a unique
>> never-disclosed device-specific key.
>>
>> There has been multiple discussions on how to represent this within the kernel:
>>
>> The Cryptographic Acceleration and Assurance Module (CAAM) is an IP core
>> built into many newer i.MX and QorIQ SoCs by NXP.
>>
>> Its blob mechanism can AES encrypt/decrypt user data using a unique
>> never-disclosed device-specific key. There has been multiple
>> discussions on how to represent this within the kernel:
>>
>>  - [RFC] crypto: caam - add red blobifier
>>    Steffen implemented[1] a PoC sysfs driver to start a discussion on how to
>>    best integrate the blob mechanism.
>>    Mimi suggested that it could be used to implement trusted keys.
>>    Trusted keys back then were a TPM-only feature.
>>
>>  - security/keys/secure_key: Adds the secure key support based on CAAM.
>>    Udit added[2] a new "secure" key type with the CAAM as backend. The key
>>    material stays within the kernel only.
>>    Mimi and James agreed that this needs a generic interface, not specific
>>    to CAAM. Mimi suggested trusted keys. Jan noted that this could serve as
>>    basis for TEE-backed keys.
>>
>>  - [RFC] drivers: crypto: caam: key: Add caam_tk key type
>>    Franck added[3] a new "caam_tk" key type based on Udit's work. This time
>>    it uses CAAM "black blobs" instead of "red blobs", so key material stays
>>    within the CAAM and isn't exposed to kernel in plaintext.
>>    James voiced the opinion that there should be just one user-facing generic
>>    wrap/unwrap key type with multiple possible handlers.
>>    David suggested trusted keys.
>>
>>  - Introduce TEE based Trusted Keys support
>>    Sumit reworked[4] trusted keys to support multiple possible backends with
>>    one chosen at boot time and added a new TEE backend along with TPM.
>>    This now sits in Jarkko's master branch to be sent out for v5.13
>>
>> This patch series builds on top of Sumit's rework to have the CAAM as yet another
>> trusted key backend.
>>
>> The CAAM bits are based on Steffen's initial patch from 2015. His work had been
>> used in the field for some years now, so I preferred not to deviate too much from it.
>>
>> This series has been tested with dmcrypt[5] on an i.MX6DL.
>>
>> Looking forward to your feedback.
>>
>> Cheers,
>> Ahmad
>>
>>  [1]: https://lore.kernel.org/linux-crypto/1447082306-19946-2-git-send-email-s.trumtrar@pengutronix.de/
>>  [2]: https://lore.kernel.org/linux-integrity/20180723111432.26830-1-udit.agarwal@nxp.com/
>>  [3]: https://lore.kernel.org/lkml/1551456599-10603-2-git-send-email-franck.lenormand@nxp.com/
>>  [4]: https://lore.kernel.org/lkml/1604419306-26105-1-git-send-email-sumit.garg@linaro.org/
>>  [5]: https://lore.kernel.org/linux-integrity/20210122084321.24012-2-a.fatoum@pengutronix.de/
>>
>> ---
>> To: Jarkko Sakkinen <jarkko@kernel.org>
>> To: "Horia Geantă" <horia.geanta@nxp.com>
>> To: Mimi Zohar <zohar@linux.ibm.com>
>> To: Aymen Sghaier <aymen.sghaier@nxp.com>
>> To: Herbert Xu <herbert@gondor.apana.org.au>
>> To: "David S. Miller" <davem@davemloft.net>
>> To: James Bottomley <jejb@linux.ibm.com>
>> Cc: David Howells <dhowells@redhat.com>
>> Cc: James Morris <jmorris@namei.org>
>> Cc: "Serge E. Hallyn" <serge@hallyn.com>
>> Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
>> Cc: Udit Agarwal <udit.agarwal@nxp.com>
>> Cc: Jan Luebbe <j.luebbe@pengutronix.de>
>> Cc: David Gstir <david@sigma-star.at>
>> Cc: Eric Biggers <ebiggers@kernel.org>
>> Cc: Richard Weinberger <richard@nod.at>
>> Cc: Franck LENORMAND <franck.lenormand@nxp.com>
>> Cc: Sumit Garg <sumit.garg@linaro.org>
>> Cc: linux-integrity@vger.kernel.org
>> Cc: keyrings@vger.kernel.org
>> Cc: linux-crypto@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-security-module@vger.kernel.org
>>
>> Ahmad Fatoum (4):
>>   KEYS: trusted: allow users to use kernel RNG for key material
>>   KEYS: trusted: allow trust sources to use kernel RNG for key material
>>   crypto: caam - add in-kernel interface for blob generator
>>   KEYS: trusted: Introduce support for NXP CAAM-based trusted keys
>>
>>  Documentation/admin-guide/kernel-parameters.txt   |   8 +-
>>  Documentation/security/keys/trusted-encrypted.rst |  60 +++-
>>  MAINTAINERS                                       |   9 +-
>>  drivers/crypto/caam/Kconfig                       |   3 +-
>>  drivers/crypto/caam/Makefile                      |   1 +-
>>  drivers/crypto/caam/blob_gen.c                    | 230 +++++++++++++++-
>>  include/keys/trusted-type.h                       |   2 +-
>>  include/keys/trusted_caam.h                       |  11 +-
>>  include/soc/fsl/caam-blob.h                       |  56 ++++-
>>  security/keys/trusted-keys/Kconfig                |  11 +-
>>  security/keys/trusted-keys/Makefile               |   2 +-
>>  security/keys/trusted-keys/trusted_caam.c         |  74 +++++-
>>  security/keys/trusted-keys/trusted_core.c         |  23 +-
>>  13 files changed, 477 insertions(+), 13 deletions(-)
>>  create mode 100644 drivers/crypto/caam/blob_gen.c
>>  create mode 100644 include/keys/trusted_caam.h
>>  create mode 100644 include/soc/fsl/caam-blob.h
>>  create mode 100644 security/keys/trusted-keys/trusted_caam.c
>>
>> base-commit: 97408d81ed533b953326c580ff2c3f1948b3fcee
>> --
>> git-series 0.9.1
> 
> Ahmad,
> 
> Thanks for your work!
> 
> I've been asked to integrate the capability of using CAAM to
> blob/deblob data to an older 5.4 kernel such as NXP's downstream
> vendor kernel does [1] and I'm trying to understand how your series
> works. I'm not at all familiar with the Linux Key Management API's or
> trusted keys. Can you provide an example of how this can be used for
> such a thing?

Here's an example with dm-crypt:

  https://lore.kernel.org/linux-integrity/5d44e50e-4309-830b-79f6-f5d888b1ef69@pengutronix.de/

dm-crypt is a bit special at the moment, because it has direct support for
trusted keys. For interfacing with other parts of the kernel like ecryptfs
or EVM, you have to create encrypted keys rooted to the trusted keys and use
those. The kernel documentation has an example:

  https://www.kernel.org/doc/html/v5.13/security/keys/trusted-encrypted.html

If you backport this series, you can include the typo fix spotted by David.

I'll send out a revised series, but given that a regression fix I want to
rebase on hasn't been picked up for 3 weeks now, I am not in a hurry.

Cheers,
Ahmad

> 
> Best regards,
> 
> Tim
> [1] https://source.codeaurora.org/external/imxsupport/imx_sec_apps/tree/demo-caam-blobs/README.txt
> 
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
