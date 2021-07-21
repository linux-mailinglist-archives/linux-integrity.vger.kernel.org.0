Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 151953D17D7
	for <lists+linux-integrity@lfdr.de>; Wed, 21 Jul 2021 22:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhGUTg6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 21 Jul 2021 15:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232533AbhGUTg6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 21 Jul 2021 15:36:58 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474B3C061757
        for <linux-integrity@vger.kernel.org>; Wed, 21 Jul 2021 13:17:33 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id l6so2059546wmq.0
        for <linux-integrity@vger.kernel.org>; Wed, 21 Jul 2021 13:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rammhold-de.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RzWGiaagIa+Q7L2PhhLkZOLjGFlmYMVy3i21G4oii0o=;
        b=hg9bf8bp9/+oVytTPNZGNsGpXsfhP+ltQcQdOeOos2S+DC/+obEuyCd+EksdGKgcNr
         qhNFia8tV4FqlF7A8TqgO9XYoKpVEkKU2tRCxLc7wFViPR8ptgVyscc9u7PpRegocJ1o
         V1WtAw+qHxrdToqhCz1RYE2WN3JuJboxvzWLaJC7AP8NA9fLYeOLmhDL4wc5zBdOvd3X
         OqUqlh2JG34l9mI5DcappLDSv23u0dlBPcIeqiKzo2Uwe/m145vJC8lOAucKyMLwpQdc
         N5z0H+wnrbS+daMOjH7VzrwgqjNrWK88O8XtP2Vt4MIr4qZkmyjPBmC86O2AAeVvsIwR
         IqKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RzWGiaagIa+Q7L2PhhLkZOLjGFlmYMVy3i21G4oii0o=;
        b=H0tWn7qLFNVrOQswNma+PWkFnSwXbthDUIV0B+2R7xysUf3l0tDAFGdqvGKobPdq1I
         H+0Ih3qZp24Z6leKnZriM44kkqw8VJkA7g45kOTnSDzmIZsvFl9HYsj4M5qtRuIt28WC
         S3Jr7J8ZUpprJ2iHNCWWC5p+zLIpYnvjrJGbdOMWGcpK3OH9SMs213mbCCMmfeo6i8oF
         4LFAICIkx++XZn02VDBdrP5NYkAWdCaSUNqQQEaFS0iB2riunzHWdu9IoS41D3JVLlFY
         F8sSKNIZxgLrKZFLiWrAqKnGT021npUxHkJGGget7RludeZDKjS0HBKBDoZhjn2lZYyM
         qe1w==
X-Gm-Message-State: AOAM532y4HY3HLl7S13mz3ijLRcoEL+YnM9Sx6eCPie3Il/lnkeuPdid
        Db33cgviJJ5jJsmBi+EN8GQJwQ==
X-Google-Smtp-Source: ABdhPJyLmFvWnbZv8MzcPJRWHhABrM7/gVLkhAvmGtqmhfzW4ZIBsFWlIsrc4dsI50VxqrB1aEks7Q==
X-Received: by 2002:a1c:f414:: with SMTP id z20mr5920081wma.94.1626898651823;
        Wed, 21 Jul 2021 13:17:31 -0700 (PDT)
Received: from localhost ([2a00:e67:5c9:a:74ac:453c:5f76:676a])
        by smtp.gmail.com with ESMTPSA id s4sm26200835wmh.41.2021.07.21.13.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 13:17:31 -0700 (PDT)
Date:   Wed, 21 Jul 2021 22:17:30 +0200
From:   Andreas Rammhold <andreas@rammhold.de>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, kernel@pengutronix.de,
        Andreas Rammhold <andreas@rammhold.de>,
        David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v2] KEYS: trusted: fix use as module when CONFIG_TCG_TPM=m
Message-ID: <20210721201730.ht75blv5pd7qgyep@wrt>
References: <20210721160258.7024-1-a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210721160258.7024-1-a.fatoum@pengutronix.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 18:02 21.07.21, Ahmad Fatoum wrote:
> Since commit 5d0682be3189 ("KEYS: trusted: Add generic trusted keys
> framework"), trusted.ko built with CONFIG_TCG_TPM=CONFIG_TRUSTED_KEYS=m
> will not register the TPM trusted key type at runtime.
> 
> This is because, after that rework, CONFIG_DEPENDENCY of the TPM
> and TEE backends were checked with #ifdef, but that's only true
> when they're built-in.
> 
> Fix this by introducing two new boolean Kconfig symbols:
> TRUSTED_KEYS_TPM and TRUSTED_KEYS_TEE with the appropriate
> dependencies and use them to check which backends are available.
> 
> This also has a positive effect on user experience:
> 
>  - It's now possible to use TEE trusted keys without CONFIG_TCG_TPM
>  - It's now possible to enable CONFIG_TCG_TPM, but exclude TPM from
>    available trust sources
>  - TEE=m && TRUSTED_KEYS=y no longer leads to TEE support
>    being silently dropped
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
> Reported-by: Andreas Rammhold <andreas@rammhold.de>
> Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
> 
> (Implicit) v1 was as a preparatory patch for CAAM trusted keys[1] with the
> goal of fixing the Kconfig inflexibility after the TEE trusted key rework.
> 
> Unbeknownst to me, it also fixes a regression, which was later
> reported by Andreas[2] along with a patch.
> 
> I split out the fix from the CAAM series and adjusted the commit
> message to explain the regression.
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
>  security/keys/Kconfig                     | 18 ++++++--------
>  security/keys/trusted-keys/Kconfig        | 29 +++++++++++++++++++++++
>  security/keys/trusted-keys/Makefile       |  8 +++----
>  security/keys/trusted-keys/trusted_core.c |  4 ++--
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
> index 000000000000..c163cfeedff6
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
> +	  backend. Trusted keys are are random number symmetric keys,
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
> index d5c891d8d353..8cab69e5d0da 100644
> --- a/security/keys/trusted-keys/trusted_core.c
> +++ b/security/keys/trusted-keys/trusted_core.c
> @@ -27,10 +27,10 @@ module_param_named(source, trusted_key_source, charp, 0);
>  MODULE_PARM_DESC(source, "Select trusted keys source (tpm or tee)");
>  
>  static const struct trusted_key_source trusted_key_sources[] = {
> -#if defined(CONFIG_TCG_TPM)
> +#if defined(CONFIG_TRUSTED_KEYS_TPM)
>  	{ "tpm", &trusted_key_tpm_ops },
>  #endif
> -#if defined(CONFIG_TEE)
> +#if defined(CONFIG_TRUSTED_KEYS_TEE)
>  	{ "tee", &trusted_key_tee_ops },
>  #endif
>  };
> -- 
> 2.30.2
> 

Works like a charm here. The key type was registered even thought I
built the kernel with CONFIG_TRUSTED_KEYS=m.

I've not actually tested if that key type works (as I've not progressed
that far in my toy project just yet).

Feel free to add my Test-By.

Tested-By: Andreas Rammhold <andreas@rammhold.de>
