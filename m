Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53D7472B98
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Dec 2021 12:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236196AbhLMLhR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Dec 2021 06:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235446AbhLMLhQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Dec 2021 06:37:16 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CDFC061574
        for <linux-integrity@vger.kernel.org>; Mon, 13 Dec 2021 03:37:16 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1mwjdf-0006M4-FR; Mon, 13 Dec 2021 12:37:03 +0100
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [PATCH v4 5/5] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     kernel@pengutronix.de, David Gstir <david@sigma-star.at>,
        Tim Harvey <tharvey@gateworks.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>
References: <cover.8f40b6d1b93adc80aed2cac29a134f7a7fb5ee98.1633946449.git-series.a.fatoum@pengutronix.de>
 <a0f1d14af8ac8bae16dd29ad1073f7143ba28f26.1633946449.git-series.a.fatoum@pengutronix.de>
 <b9283c8a4b3b04c7ee9f525208cbb32d798d4439.camel@ew.tq-group.com>
Message-ID: <59f1f3e6-fcf1-794d-610c-674b826822bf@pengutronix.de>
Date:   Mon, 13 Dec 2021 12:36:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <b9283c8a4b3b04c7ee9f525208cbb32d798d4439.camel@ew.tq-group.com>
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

Hello Matthias,

On 13.12.21 12:00, Matthias Schiffer wrote:
> On Mon, 2021-10-11 at 12:02 +0200, Ahmad Fatoum wrote:
>> The Cryptographic Acceleration and Assurance Module (CAAM) is an IP
>> Reviewed-by: David Gstir <david@sigma-star.at>
>> Tested-By: Tim Harvey <tharvey@gateworks.com>
>> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> 
> 
> Tested-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

Thanks for testing! Should I add your Tested-by: to the whole series,
or only this patch here?

> It is unfortunate that this implementation is incompatible with the
> "secure keys" feature found in linux-imx, as that would allow upgrading
> from linux-imx to mainline kernels in the future without losing access
> to keys. I did not follow the discussion of previous versions of this
> patch series, but I assume there is some reason why this code is not
> aligned with the linux-imx implementation?

I don't use the vendor fork, so compatibility with it wasn't a criteria
for me. The format used in this series is very straight-forward:
Key modifier is kernel:trusted and blob is exactly what's returned by
the CAAM. What would you change to make it linux-imx compatible?

> Should the kernel emit some kind of warning if CAAM-based trusted keys
> are used, but the SoC has not been "closed" (if there is a nice way to
> detect that)? As the CAAM is using a common example key instead of the
> fused master key when HAB/secure boot are disabled, the kernel would
> basically be lying about the keys being trusted in this case.

For now, this is pointed out in the documentation. If you have a suggestion
on a specific condition we should check and issue a diagnostic on, I can
incorporate it. An exhaustive if WARN_ON(!secure()) is impossible, but
having some warning for unsuspecting users would indeed be nice.

Cheers,
Ahmad

>> ---
>> To: Jonathan Corbet <corbet@lwn.net>
>> To: David Howells <dhowells@redhat.com>
>> To: Jarkko Sakkinen <jarkko@kernel.org>
>> To: James Bottomley <jejb@linux.ibm.com>
>> To: Mimi Zohar <zohar@linux.ibm.com>
>> Cc: James Morris <jmorris@namei.org>
>> Cc: "Serge E. Hallyn" <serge@hallyn.com>
>> Cc: "Horia Geantă" <horia.geanta@nxp.com>
>> Cc: Aymen Sghaier <aymen.sghaier@nxp.com>
>> Cc: Herbert Xu <herbert@gondor.apana.org.au>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Udit Agarwal <udit.agarwal@nxp.com>
>> Cc: Eric Biggers <ebiggers@kernel.org>
>> Cc: Jan Luebbe <j.luebbe@pengutronix.de>
>> Cc: David Gstir <david@sigma-star.at>
>> Cc: Richard Weinberger <richard@nod.at>
>> Cc: Franck LENORMAND <franck.lenormand@nxp.com>
>> Cc: Sumit Garg <sumit.garg@linaro.org>
>> Cc: keyrings@vger.kernel.org
>> Cc: linux-crypto@vger.kernel.org
>> Cc: linux-doc@vger.kernel.org
>> Cc: linux-integrity@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-security-module@vger.kernel.org
>> ---
>>  Documentation/admin-guide/kernel-parameters.txt   |  1 +-
>>  Documentation/security/keys/trusted-encrypted.rst | 42 ++++++++-
>>  MAINTAINERS                                       |  9 ++-
>>  include/keys/trusted_caam.h                       | 11 ++-
>>  security/keys/trusted-keys/Kconfig                | 11 +-
>>  security/keys/trusted-keys/Makefile               |  2 +-
>>  security/keys/trusted-keys/trusted_caam.c         | 74
>> ++++++++++++++++-
>>  security/keys/trusted-keys/trusted_core.c         |  6 +-
>>  8 files changed, 152 insertions(+), 4 deletions(-)
>>  create mode 100644 include/keys/trusted_caam.h
>>  create mode 100644 security/keys/trusted-keys/trusted_caam.c
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt
>> b/Documentation/admin-guide/kernel-parameters.txt
>> index d5969452f063..0ed1165e0f55 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -5767,6 +5767,7 @@
>>  			sources:
>>  			- "tpm"
>>  			- "tee"
>> +			- "caam"
>>  			If not specified then it defaults to iterating
>> through
>>  			the trust source list starting with TPM and
>> assigns the
>>  			first trust source as a backend which is
>> initialized
>> diff --git a/Documentation/security/keys/trusted-encrypted.rst
>> b/Documentation/security/keys/trusted-encrypted.rst
>> index 1d4b4b8f12f0..ad66573ca6fd 100644
>> --- a/Documentation/security/keys/trusted-encrypted.rst
>> +++ b/Documentation/security/keys/trusted-encrypted.rst
>> @@ -35,6 +35,13 @@ safe.
>>           Rooted to Hardware Unique Key (HUK) which is generally
>> burnt in on-chip
>>           fuses and is accessible to TEE only.
>>  
>> +     (3) CAAM (Cryptographic Acceleration and Assurance Module: IP
>> on NXP SoCs)
>> +
>> +         When High Assurance Boot (HAB) is enabled and the CAAM is
>> in secure
>> +         mode, trust is rooted to the OTPMK, a never-disclosed 256-
>> bit key
>> +         randomly generated and fused into each SoC at manufacturing
>> time.
>> +         Otherwise, a common fixed test key is used instead.
>> +
>>    *  Execution isolation
>>  
>>       (1) TPM
>> @@ -46,6 +53,10 @@ safe.
>>           Customizable set of operations running in isolated
>> execution
>>           environment verified via Secure/Trusted boot process.
>>  
>> +     (3) CAAM
>> +
>> +         Fixed set of operations running in isolated execution
>> environment.
>> +
>>    * Optional binding to platform integrity state
>>  
>>       (1) TPM
>> @@ -63,6 +74,11 @@ safe.
>>           Relies on Secure/Trusted boot process for platform
>> integrity. It can
>>           be extended with TEE based measured boot process.
>>  
>> +     (3) CAAM
>> +
>> +         Relies on the High Assurance Boot (HAB) mechanism of NXP
>> SoCs
>> +         for platform integrity.
>> +
>>    *  Interfaces and APIs
>>  
>>       (1) TPM
>> @@ -74,10 +90,13 @@ safe.
>>           TEEs have well-documented, standardized client interface
>> and APIs. For
>>           more details refer to ``Documentation/staging/tee.rst``.
>>  
>> +     (3) CAAM
>> +
>> +         Interface is specific to silicon vendor.
>>  
>>    *  Threat model
>>  
>> -     The strength and appropriateness of a particular TPM or TEE for
>> a given
>> +     The strength and appropriateness of a particular trust source
>> for a given
>>       purpose must be assessed when using them to protect security-
>> relevant data.
>>  
>>  
>> @@ -104,8 +123,14 @@ selected trust source:
>>       from platform specific hardware RNG or a software based Fortuna
>> CSPRNG
>>       which can be seeded via multiple entropy sources.
>>  
>> +  *  CAAM: Kernel RNG
>> +
>> +     The normal kernel random number generator is used. To seed it
>> from the
>> +     CAAM HWRNG, enable CRYPTO_DEV_FSL_CAAM_RNG_API and ensure the
>> device
>> +     can be probed.
>> +
>>  Optionally, users may specify ``trusted.kernel_rng=1`` on the kernel
>> -command-line to override the used RNG with the kernel's random
>> number pool.
>> +command-line to force use of the kernel's random number pool.
>>  
>>  Encrypted Keys
>>  --------------
>> @@ -192,6 +217,19 @@ Usage::
>>  specific to TEE device implementation.  The key length for new keys
>> is always
>>  in bytes. Trusted Keys can be 32 - 128 bytes (256 - 1024 bits).
>>  
>> +Trusted Keys usage: CAAM
>> +------------------------
>> +
>> +Usage::
>> +
>> +    keyctl add trusted name "new keylen" ring
>> +    keyctl add trusted name "load hex_blob" ring
>> +    keyctl print keyid
>> +
>> +"keyctl print" returns an ASCII hex copy of the sealed key, which is
>> in format
>> +specific to CAAM device implementation.  The key length for new keys
>> is always
>> +in bytes. Trusted Keys can be 32 - 128 bytes (256 - 1024 bits).
>> +
>>  Encrypted Keys usage
>>  --------------------
>>  
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index a4a0c2baaf27..2c6514759222 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -10364,6 +10364,15 @@ S:	Supported
>>  F:	include/keys/trusted_tee.h
>>  F:	security/keys/trusted-keys/trusted_tee.c
>>  
>> +KEYS-TRUSTED-CAAM
>> +M:	Ahmad Fatoum <a.fatoum@pengutronix.de>
>> +R:	Pengutronix Kernel Team <kernel@pengutronix.de>
>> +L:	linux-integrity@vger.kernel.org
>> +L:	keyrings@vger.kernel.org
>> +S:	Supported
>> +F:	include/keys/trusted_caam.h
>> +F:	security/keys/trusted-keys/trusted_caam.c
>> +
>>  KEYS/KEYRINGS
>>  M:	David Howells <dhowells@redhat.com>
>>  M:	Jarkko Sakkinen <jarkko@kernel.org>
>> diff --git a/include/keys/trusted_caam.h
>> b/include/keys/trusted_caam.h
>> new file mode 100644
>> index 000000000000..2fba0996b0b0
>> --- /dev/null
>> +++ b/include/keys/trusted_caam.h
>> @@ -0,0 +1,11 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*
>> + * Copyright (C) 2021 Pengutronix, Ahmad Fatoum <
>> kernel@pengutronix.de>
>> + */
>> +
>> +#ifndef __CAAM_TRUSTED_KEY_H
>> +#define __CAAM_TRUSTED_KEY_H
>> +
>> +extern struct trusted_key_ops caam_trusted_key_ops;
>> +
>> +#endif
>> diff --git a/security/keys/trusted-keys/Kconfig
>> b/security/keys/trusted-keys/Kconfig
>> index fc4abd581abb..dbfdd8536468 100644
>> --- a/security/keys/trusted-keys/Kconfig
>> +++ b/security/keys/trusted-keys/Kconfig
>> @@ -24,6 +24,15 @@ config TRUSTED_KEYS_TEE
>>  	  Enable use of the Trusted Execution Environment (TEE) as
>> trusted
>>  	  key backend.
>>  
>> -if !TRUSTED_KEYS_TPM && !TRUSTED_KEYS_TEE
>> +config TRUSTED_KEYS_CAAM
>> +	bool "CAAM-based trusted keys"
>> +	depends on CRYPTO_DEV_FSL_CAAM_JR >= TRUSTED_KEYS
>> +	select CRYPTO_DEV_FSL_CAAM_BLOB_GEN
>> +	default y
>> +	help
>> +	  Enable use of NXP's Cryptographic Accelerator and Assurance
>> Module
>> +	  (CAAM) as trusted key backend.
>> +
>> +if !TRUSTED_KEYS_TPM && !TRUSTED_KEYS_TEE && !TRUSTED_KEYS_CAAM
>>  comment "No trust source selected!"
>>  endif
>> diff --git a/security/keys/trusted-keys/Makefile
>> b/security/keys/trusted-keys/Makefile
>> index 2e2371eae4d5..735aa0bc08ef 100644
>> --- a/security/keys/trusted-keys/Makefile
>> +++ b/security/keys/trusted-keys/Makefile
>> @@ -12,3 +12,5 @@ trusted-$(CONFIG_TRUSTED_KEYS_TPM) +=
>> trusted_tpm2.o
>>  trusted-$(CONFIG_TRUSTED_KEYS_TPM) += tpm2key.asn1.o
>>  
>>  trusted-$(CONFIG_TRUSTED_KEYS_TEE) += trusted_tee.o
>> +
>> +trusted-$(CONFIG_TRUSTED_KEYS_CAAM) += trusted_caam.o
>> diff --git a/security/keys/trusted-keys/trusted_caam.c
>> b/security/keys/trusted-keys/trusted_caam.c
>> new file mode 100644
>> index 000000000000..01adfd18adda
>> --- /dev/null
>> +++ b/security/keys/trusted-keys/trusted_caam.c
>> @@ -0,0 +1,74 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2021 Pengutronix, Ahmad Fatoum <
>> kernel@pengutronix.de>
>> + */
>> +
>> +#include <keys/trusted_caam.h>
>> +#include <keys/trusted-type.h>
>> +#include <linux/build_bug.h>
>> +#include <linux/key-type.h>
>> +#include <soc/fsl/caam-blob.h>
>> +
>> +static struct caam_blob_priv *blobifier;
>> +
>> +#define KEYMOD "kernel:trusted"
>> +
>> +static_assert(MAX_KEY_SIZE + CAAM_BLOB_OVERHEAD <=
>> CAAM_BLOB_MAX_LEN);
>> +static_assert(MAX_BLOB_SIZE <= CAAM_BLOB_MAX_LEN);
>> +
>> +static int trusted_caam_seal(struct trusted_key_payload *p, char
>> *datablob)
>> +{
>> +	int length = p->key_len + CAAM_BLOB_OVERHEAD;
>> +	int ret;
>> +
>> +	ret = caam_encap_blob(blobifier, KEYMOD, p->key, p->blob,
>> length);
>> +	if (ret)
>> +		return ret;
>> +
>> +	p->blob_len = length;
>> +	return 0;
>> +}
>> +
>> +static int trusted_caam_unseal(struct trusted_key_payload *p, char
>> *datablob)
>> +{
>> +	int length = p->blob_len;
>> +	int ret;
>> +
>> +	ret = caam_decap_blob(blobifier, KEYMOD, p->blob, p->key,
>> length);
>> +	if (ret)
>> +		return ret;
>> +
>> +	p->key_len = length - CAAM_BLOB_OVERHEAD;
>> +	return 0;
>> +}
>> +
>> +static int trusted_caam_init(void)
>> +{
>> +	int ret;
>> +
>> +	blobifier = caam_blob_gen_init();
>> +	if (IS_ERR(blobifier)) {
>> +		pr_err("Job Ring Device allocation for transform
>> failed\n");
>> +		return PTR_ERR(blobifier);
>> +	}
>> +
>> +	ret = register_key_type(&key_type_trusted);
>> +	if (ret)
>> +		caam_blob_gen_exit(blobifier);
>> +
>> +	return ret;
>> +}
>> +
>> +static void trusted_caam_exit(void)
>> +{
>> +	unregister_key_type(&key_type_trusted);
>> +	caam_blob_gen_exit(blobifier);
>> +}
>> +
>> +struct trusted_key_ops caam_trusted_key_ops = {
>> +	.migratable = 0, /* non-migratable */
>> +	.init = trusted_caam_init,
>> +	.seal = trusted_caam_seal,
>> +	.unseal = trusted_caam_unseal,
>> +	.exit = trusted_caam_exit,
>> +};
>> diff --git a/security/keys/trusted-keys/trusted_core.c
>> b/security/keys/trusted-keys/trusted_core.c
>> index d2b7626cde8b..305e44651180 100644
>> --- a/security/keys/trusted-keys/trusted_core.c
>> +++ b/security/keys/trusted-keys/trusted_core.c
>> @@ -9,6 +9,7 @@
>>  #include <keys/user-type.h>
>>  #include <keys/trusted-type.h>
>>  #include <keys/trusted_tee.h>
>> +#include <keys/trusted_caam.h>
>>  #include <keys/trusted_tpm.h>
>>  #include <linux/capability.h>
>>  #include <linux/err.h>
>> @@ -29,7 +30,7 @@ MODULE_PARM_DESC(kernel_rng, "Generate key material
>> from kernel RNG");
>>  
>>  static char *trusted_key_source;
>>  module_param_named(source, trusted_key_source, charp, 0);
>> -MODULE_PARM_DESC(source, "Select trusted keys source (tpm or tee)");
>> +MODULE_PARM_DESC(source, "Select trusted keys source (tpm, tee or
>> caam)");
>>  
>>  static const struct trusted_key_source trusted_key_sources[] = {
>>  #if defined(CONFIG_TRUSTED_KEYS_TPM)
>> @@ -38,6 +39,9 @@ static const struct trusted_key_source
>> trusted_key_sources[] = {
>>  #if defined(CONFIG_TRUSTED_KEYS_TEE)
>>  	{ "tee", &trusted_key_tee_ops },
>>  #endif
>> +#if defined(CONFIG_TRUSTED_KEYS_CAAM)
>> +	{ "caam", &caam_trusted_key_ops },
>> +#endif
>>  };
>>  
>>  DEFINE_STATIC_CALL_NULL(trusted_key_init,
>> *trusted_key_sources[0].ops->init);
> 
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
