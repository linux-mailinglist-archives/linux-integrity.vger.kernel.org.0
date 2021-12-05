Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAEB5468899
	for <lists+linux-integrity@lfdr.de>; Sun,  5 Dec 2021 01:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhLEARB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 4 Dec 2021 19:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbhLEAQE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 4 Dec 2021 19:16:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1490C061751;
        Sat,  4 Dec 2021 16:12:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46FB860F4A;
        Sun,  5 Dec 2021 00:12:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F590C341C2;
        Sun,  5 Dec 2021 00:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638663156;
        bh=Q3FvNDDgM8imC21aPzaOnC+lsYvXc1b2ZGBV579IFwQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GRX1T78fi3d6dElxnu0+yQcfrNJG2jZQUcqwXFmnQ3NmVltdbEjHIALhAcI5QNnI7
         8BL99z6qNKHam4yKLAIUx8uJ9Gg5wqm6JJ5FUftuaKkH+EHSSlSzRz+Dn3+XTjYIw3
         sVeFN1s6ijL7QBJ/pFKfqQoc2ZY4AzR5l1rb9jUJPkv0t5ohlOzKDOFNtCjVdQFbYd
         +SKZo/ghfYw34Jbpmw70Sp48cCGOhQS1hLmOK6rvGexO821FVTV6aet9MM2v/YwAUG
         Y6NpX8p393kjAs7PW0TSuhfY3Lg7HdQ9IvCbbWZxh0Sa0oTCTlL4LqtyuMakPwscuY
         AzZw0e4tMt7tA==
Date:   Sun, 5 Dec 2021 02:12:32 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, kernel@pengutronix.de,
        Andreas Rammhold <andreas@rammhold.de>,
        Tim Harvey <tharvey@gateworks.com>,
        David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v4 1/5] KEYS: trusted: allow use of TEE as backend
 without TCG_TPM support
Message-ID: <YawD8Ey2x98vIMRt@iki.fi>
References: <cover.8f40b6d1b93adc80aed2cac29a134f7a7fb5ee98.1633946449.git-series.a.fatoum@pengutronix.de>
 <c36b3e3d4d215e790491e1a274a8993dd68e2a39.1633946449.git-series.a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c36b3e3d4d215e790491e1a274a8993dd68e2a39.1633946449.git-series.a.fatoum@pengutronix.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Oct 11, 2021 at 12:02:34PM +0200, Ahmad Fatoum wrote:
> With recent rework, trusted keys are no longer limited to TPM as trust
> source. The Kconfig symbol is unchanged however leading to a few issues:
> 
>   - TCG_TPM is required, even if only TEE is to be used
>   - Enabling TCG_TPM, but excluding it from available trusted sources
>     is not possible
>   - TEE=m && TRUSTED_KEYS=y will lead to TEE support being silently
>     dropped, which is not the best user experience
> 
> Remedy these issues by introducing two new boolean Kconfig symbols:
> TRUSTED_KEYS_TPM and TRUSTED_KEYS_TEE with the appropriate
> dependencies.
> 
> Any code depending on the TPM trusted key backend or symbols exported
> by it will now need to explicitly state that it
> 
>   depends on TRUSTED_KEYS && TRUSTED_KEYS_TPM
> 
> The latter to ensure the dependency is built and the former to ensure
> it's reachable for module builds. This currently only affects
> CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE, so it's fixed up here as well.
> 
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> Tested-By: Andreas Rammhold <andreas@rammhold.de>
> Tested-By: Tim Harvey <tharvey@gateworks.com>
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
> v3 -> v4:
>   - rebased on top of Andreas' regression fix and pulled it back
>     into series
> 
> v2 -> v3:
>   - factored this patch out as a fix for backporting
> 
> v1 -> v2:
>   - Move rest of TPM-related selects from TRUSTED_KEYS to
>     TRUSTED_KEYS_TPM (Sumit)
>   - Remove left-over line in Makefile (Sumit)
>   - added Fixes: tag
>   - adjust commit message to reference the regression reported
>     by Andreas
>   - have ASYMMETRIC_TPM_KEY_SUBTYPE depend on TRUSTED_KEYS_TPM,
>     because it references global symbols that are exported
>     by the trusted key TPM backend.
> 
> [1]: https://lore.kernel.org/linux-integrity/f8285eb0135ba30c9d846cf9dd395d1f5f8b1efc.1624364386.git-series.a.fatoum@pengutronix.de/
> [2]: https://lore.kernel.org/linux-integrity/20210719091335.vwfebcpkf4pag3wm@wrt/T/#t
> 
> To: Jarkko Sakkinen <jarkko@kernel.org>
> To: James Morris <jmorris@namei.org>
> To: "Serge E. Hallyn" <serge@hallyn.com>
> To: James Bottomley <jejb@linux.ibm.com>
> To: Mimi Zohar <zohar@linux.ibm.com>
> To: Sumit Garg <sumit.garg@linaro.org>
> To: David Howells <dhowells@redhat.com>
> To: Herbert Xu <herbert@gondor.apana.org.au>
> To: "David S. Miller" <davem@davemloft.net>
> Cc: David Gstir <david@sigma-star.at>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: keyrings@vger.kernel.org
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> Cc: linux-integrity@vger.kernel.org
> ---
>  crypto/asymmetric_keys/Kconfig            |  2 +-
>  security/keys/Kconfig                     | 18 +++++----------
>  security/keys/trusted-keys/Kconfig        | 29 ++++++++++++++++++++++++-
>  security/keys/trusted-keys/Makefile       |  8 +++----
>  security/keys/trusted-keys/trusted_core.c |  4 +--
>  5 files changed, 43 insertions(+), 18 deletions(-)
>  create mode 100644 security/keys/trusted-keys/Kconfig
> 
> diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
> index 1f1f004dc757..8886eddbf881 100644
> --- a/crypto/asymmetric_keys/Kconfig
> +++ b/crypto/asymmetric_keys/Kconfig
> @@ -25,7 +25,7 @@ config ASYMMETRIC_PUBLIC_KEY_SUBTYPE
>  config ASYMMETRIC_TPM_KEY_SUBTYPE
>  	tristate "Asymmetric TPM backed private key subtype"
>  	depends on TCG_TPM
> -	depends on TRUSTED_KEYS
> +	depends on TRUSTED_KEYS && TRUSTED_KEYS_TPM
>  	select CRYPTO_HMAC
>  	select CRYPTO_SHA1
>  	select CRYPTO_HASH_INFO
> diff --git a/security/keys/Kconfig b/security/keys/Kconfig
> index 64b81abd087e..9ec302962fe2 100644
> --- a/security/keys/Kconfig
> +++ b/security/keys/Kconfig
> @@ -70,23 +70,19 @@ config BIG_KEYS
>  
>  config TRUSTED_KEYS
>  	tristate "TRUSTED KEYS"
> -	depends on KEYS && TCG_TPM
> -	select CRYPTO
> -	select CRYPTO_HMAC
> -	select CRYPTO_SHA1
> -	select CRYPTO_HASH_INFO
> -	select ASN1_ENCODER
> -	select OID_REGISTRY
> -	select ASN1
> +	depends on KEYS
>  	help
>  	  This option provides support for creating, sealing, and unsealing
>  	  keys in the kernel. Trusted keys are random number symmetric keys,
> -	  generated and RSA-sealed by the TPM. The TPM only unseals the keys,
> -	  if the boot PCRs and other criteria match.  Userspace will only ever
> -	  see encrypted blobs.
> +	  generated and sealed by a trust source selected at kernel boot-time.
> +	  Userspace will only ever see encrypted blobs.
>  
>  	  If you are unsure as to whether this is required, answer N.
>  
> +if TRUSTED_KEYS
> +source "security/keys/trusted-keys/Kconfig"
> +endif
> +
>  config ENCRYPTED_KEYS
>  	tristate "ENCRYPTED KEYS"
>  	depends on KEYS
> diff --git a/security/keys/trusted-keys/Kconfig b/security/keys/trusted-keys/Kconfig
> new file mode 100644
> index 000000000000..fc4abd581abb
> --- /dev/null
> +++ b/security/keys/trusted-keys/Kconfig
> @@ -0,0 +1,29 @@
> +config TRUSTED_KEYS_TPM
> +	bool "TPM-based trusted keys"
> +	depends on TCG_TPM >= TRUSTED_KEYS
> +	default y
> +	select CRYPTO
> +	select CRYPTO_HMAC
> +	select CRYPTO_SHA1
> +	select CRYPTO_HASH_INFO
> +	select ASN1_ENCODER
> +	select OID_REGISTRY
> +	select ASN1
> +	help
> +	  Enable use of the Trusted Platform Module (TPM) as trusted key
> +	  backend. Trusted keys are random number symmetric keys,
> +	  which will be generated and RSA-sealed by the TPM.
> +	  The TPM only unseals the keys, if the boot PCRs and other
> +	  criteria match.
> +
> +config TRUSTED_KEYS_TEE
> +	bool "TEE-based trusted keys"
> +	depends on TEE >= TRUSTED_KEYS
> +	default y
> +	help
> +	  Enable use of the Trusted Execution Environment (TEE) as trusted
> +	  key backend.
> +
> +if !TRUSTED_KEYS_TPM && !TRUSTED_KEYS_TEE
> +comment "No trust source selected!"
> +endif
> diff --git a/security/keys/trusted-keys/Makefile b/security/keys/trusted-keys/Makefile
> index feb8b6c3cc79..2e2371eae4d5 100644
> --- a/security/keys/trusted-keys/Makefile
> +++ b/security/keys/trusted-keys/Makefile
> @@ -5,10 +5,10 @@
>  
>  obj-$(CONFIG_TRUSTED_KEYS) += trusted.o
>  trusted-y += trusted_core.o
> -trusted-y += trusted_tpm1.o
> +trusted-$(CONFIG_TRUSTED_KEYS_TPM) += trusted_tpm1.o
>  
>  $(obj)/trusted_tpm2.o: $(obj)/tpm2key.asn1.h
> -trusted-y += trusted_tpm2.o
> -trusted-y += tpm2key.asn1.o
> +trusted-$(CONFIG_TRUSTED_KEYS_TPM) += trusted_tpm2.o
> +trusted-$(CONFIG_TRUSTED_KEYS_TPM) += tpm2key.asn1.o
>  
> -trusted-$(CONFIG_TEE) += trusted_tee.o
> +trusted-$(CONFIG_TRUSTED_KEYS_TEE) += trusted_tee.o
> diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
> index 5b35f1b87644..8cab69e5d0da 100644
> --- a/security/keys/trusted-keys/trusted_core.c
> +++ b/security/keys/trusted-keys/trusted_core.c
> @@ -27,10 +27,10 @@ module_param_named(source, trusted_key_source, charp, 0);
>  MODULE_PARM_DESC(source, "Select trusted keys source (tpm or tee)");
>  
>  static const struct trusted_key_source trusted_key_sources[] = {
> -#if IS_REACHABLE(CONFIG_TCG_TPM)
> +#if defined(CONFIG_TRUSTED_KEYS_TPM)
>  	{ "tpm", &trusted_key_tpm_ops },
>  #endif
> -#if IS_REACHABLE(CONFIG_TEE)
> +#if defined(CONFIG_TRUSTED_KEYS_TEE)
>  	{ "tee", &trusted_key_tee_ops },
>  #endif
>  };
> -- 
> git-series 0.9.1

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko
