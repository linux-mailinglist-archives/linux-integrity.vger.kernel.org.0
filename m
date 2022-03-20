Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8054E1DC7
	for <lists+linux-integrity@lfdr.de>; Sun, 20 Mar 2022 22:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243716AbiCTVCd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 20 Mar 2022 17:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbiCTVCc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 20 Mar 2022 17:02:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A70610E06C;
        Sun, 20 Mar 2022 14:01:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF9376120E;
        Sun, 20 Mar 2022 21:01:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11773C340E9;
        Sun, 20 Mar 2022 21:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647810063;
        bh=QkcuWtvqI1Q66ovVqgPxGTb0hK/D8TPonQFWbPcoTf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GAQVx9UifFRIj2eKn6LDYXWXtndTiid3dn2V7S4gjL+GLoVI3kSb+QN1J+e2xnBTH
         sff82e2DEpCqKwE/kVsLJ7Zcs18DWtjyNVXULBYXIOgO4zgz/E/DdGR5CzAJe+kGV0
         thrIjyPwKxmc4wy1NxG+Oe0wfrBC+a/qDcrOUBBaSSeKkh72OXc5t9sLKeZJgddg39
         mMmuuTxZ3IvtEOeM06b4sGVs+eZe8faA6RL39CXSr9daC/UAhSQdUQtI2fFsuDRfEr
         e9I6hjKjwu01+VUWzZ/OdoKT6KIQxU2SUMZbYzHOX16e0klnn5kt3vjHkcRcV8C3bV
         cBqtPQZf5KVqA==
Date:   Sun, 20 Mar 2022 23:02:03 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>, kernel@pengutronix.de,
        David Gstir <david@sigma-star.at>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v6 4/4] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
Message-ID: <YjeWSx84ev7u/YAi@iki.fi>
References: <20220316164335.1720255-1-a.fatoum@pengutronix.de>
 <20220316164335.1720255-5-a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220316164335.1720255-5-a.fatoum@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Mar 16, 2022 at 05:43:35PM +0100, Ahmad Fatoum wrote:
> The Cryptographic Acceleration and Assurance Module (CAAM) is an IP core
> built into many newer i.MX and QorIQ SoCs by NXP.
> 
> The CAAM does crypto acceleration, hardware number generation and
> has a blob mechanism for encapsulation/decapsulation of sensitive material.
> 
> This blob mechanism depends on a device specific random 256-bit One Time
> Programmable Master Key that is fused in each SoC at manufacturing
> time. This key is unreadable and can only be used by the CAAM for AES
> encryption/decryption of user data.
> 
> This makes it a suitable backend (source) for kernel trusted keys.
> 
> Previous commits generalized trusted keys to support multiple backends
> and added an API to access the CAAM blob mechanism. Based on these,
> provide the necessary glue to use the CAAM for trusted keys.
> 
> Reviewed-by: David Gstir <david@sigma-star.at>
> Reviewed-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> Tested-By: Tim Harvey <tharvey@gateworks.com>
> Tested-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Tested-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
> v5 -> v6:
>   - Rename caam_trusted_key_ops to trusted_key_caam_ops for symmetry
>     with other trust sources (Pankaj)
>   - collected Pankaj's Reviewed-by
> v4 -> v5:
>   - Collected Reviewed-by's and Tested-by's
>   - Changed modifier to SECURE_KEY for compatibility with linux-imx
>     (Matthias)
> v3 -> v4:
>   - Collected Acked-by's, Reviewed-by's and Tested-by
> v2 -> v3:
>  - add MAINTAINERS entry
> v1 -> v2:
>  - Extend trusted keys documentation for CAAM
> 
> To: Jonathan Corbet <corbet@lwn.net>
> To: David Howells <dhowells@redhat.com>
> To: Jarkko Sakkinen <jarkko@kernel.org>
> To: James Bottomley <jejb@linux.ibm.com>
> To: Mimi Zohar <zohar@linux.ibm.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: "Horia Geantă" <horia.geanta@nxp.com>
> Cc: Aymen Sghaier <aymen.sghaier@nxp.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: Jan Luebbe <j.luebbe@pengutronix.de>
> Cc: David Gstir <david@sigma-star.at>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Franck LENORMAND <franck.lenormand@nxp.com>
> Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: keyrings@vger.kernel.org
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-integrity@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> ---
>  .../admin-guide/kernel-parameters.txt         |  1 +
>  .../security/keys/trusted-encrypted.rst       | 40 +++++++++-
>  MAINTAINERS                                   |  9 +++
>  include/keys/trusted_caam.h                   | 11 +++
>  security/keys/trusted-keys/Kconfig            | 11 ++-
>  security/keys/trusted-keys/Makefile           |  2 +
>  security/keys/trusted-keys/trusted_caam.c     | 74 +++++++++++++++++++
>  security/keys/trusted-keys/trusted_core.c     |  6 +-
>  8 files changed, 151 insertions(+), 3 deletions(-)
>  create mode 100644 include/keys/trusted_caam.h
>  create mode 100644 security/keys/trusted-keys/trusted_caam.c
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 844c883ca9d8..9e7ef4c6585d 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -5875,6 +5875,7 @@
>  			sources:
>  			- "tpm"
>  			- "tee"
> +			- "caam"
>  			If not specified then it defaults to iterating through
>  			the trust source list starting with TPM and assigns the
>  			first trust source as a backend which is initialized
> diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
> index 99cf34d7c025..ed60c48cb692 100644
> --- a/Documentation/security/keys/trusted-encrypted.rst
> +++ b/Documentation/security/keys/trusted-encrypted.rst
> @@ -35,6 +35,13 @@ safe.
>           Rooted to Hardware Unique Key (HUK) which is generally burnt in on-chip
>           fuses and is accessible to TEE only.
>  
> +     (3) CAAM (Cryptographic Acceleration and Assurance Module: IP on NXP SoCs)
> +
> +         When High Assurance Boot (HAB) is enabled and the CAAM is in secure
> +         mode, trust is rooted to the OTPMK, a never-disclosed 256-bit key
> +         randomly generated and fused into each SoC at manufacturing time.
> +         Otherwise, a common fixed test key is used instead.
> +
>    *  Execution isolation
>  
>       (1) TPM
> @@ -46,6 +53,10 @@ safe.
>           Customizable set of operations running in isolated execution
>           environment verified via Secure/Trusted boot process.
>  
> +     (3) CAAM
> +
> +         Fixed set of operations running in isolated execution environment.
> +
>    * Optional binding to platform integrity state
>  
>       (1) TPM
> @@ -63,6 +74,11 @@ safe.
>           Relies on Secure/Trusted boot process for platform integrity. It can
>           be extended with TEE based measured boot process.
>  
> +     (3) CAAM
> +
> +         Relies on the High Assurance Boot (HAB) mechanism of NXP SoCs
> +         for platform integrity.
> +
>    *  Interfaces and APIs
>  
>       (1) TPM
> @@ -74,10 +90,13 @@ safe.
>           TEEs have well-documented, standardized client interface and APIs. For
>           more details refer to ``Documentation/staging/tee.rst``.
>  
> +     (3) CAAM
> +
> +         Interface is specific to silicon vendor.
>  
>    *  Threat model
>  
> -     The strength and appropriateness of a particular TPM or TEE for a given
> +     The strength and appropriateness of a particular trust source for a given
>       purpose must be assessed when using them to protect security-relevant data.
>  
>  
> @@ -104,6 +123,12 @@ selected trust source:
>       from platform specific hardware RNG or a software based Fortuna CSPRNG
>       which can be seeded via multiple entropy sources.
>  
> +  *  CAAM: Kernel RNG
> +
> +     The normal kernel random number generator is used. To seed it from the
> +     CAAM HWRNG, enable CRYPTO_DEV_FSL_CAAM_RNG_API and ensure the device
> +     is probed.
> +
>  Users may override this by specifying ``trusted.rng=kernel`` on the kernel
>  command-line to override the used RNG with the kernel's random number pool.
>  
> @@ -192,6 +217,19 @@ Usage::
>  specific to TEE device implementation.  The key length for new keys is always
>  in bytes. Trusted Keys can be 32 - 128 bytes (256 - 1024 bits).
>  
> +Trusted Keys usage: CAAM
> +------------------------
> +
> +Usage::
> +
> +    keyctl add trusted name "new keylen" ring
> +    keyctl add trusted name "load hex_blob" ring
> +    keyctl print keyid
> +
> +"keyctl print" returns an ASCII hex copy of the sealed key, which is in format
> +specific to CAAM device implementation.  The key length for new keys is always
> +in bytes. Trusted Keys can be 32 - 128 bytes (256 - 1024 bits).
> +
>  Encrypted Keys usage
>  --------------------
>  
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 05fd080b82f3..f13382a14967 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10647,6 +10647,15 @@ S:	Supported
>  F:	include/keys/trusted_tee.h
>  F:	security/keys/trusted-keys/trusted_tee.c
>  
> +KEYS-TRUSTED-CAAM
> +M:	Ahmad Fatoum <a.fatoum@pengutronix.de>
> +R:	Pengutronix Kernel Team <kernel@pengutronix.de>
> +L:	linux-integrity@vger.kernel.org
> +L:	keyrings@vger.kernel.org
> +S:	Maintained
> +F:	include/keys/trusted_caam.h
> +F:	security/keys/trusted-keys/trusted_caam.c
> +
>  KEYS/KEYRINGS
>  M:	David Howells <dhowells@redhat.com>
>  M:	Jarkko Sakkinen <jarkko@kernel.org>

Documentation and MAINTAINERS updates must be separate patches.

BR, Jarkko
