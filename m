Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A99736CFA6
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Apr 2021 01:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236547AbhD0XrQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Apr 2021 19:47:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:58890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236015AbhD0XrP (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Apr 2021 19:47:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 336D9613F8;
        Tue, 27 Apr 2021 23:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619567191;
        bh=/4zboaigQcqYojznpGGzY09/dRMU6IDja/PWMwP5n+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y9iA/XRswGCDCKC50UbwA8lkm7lfebRYhGls2FTXo9CylIQZNfFg25xJwg+CEk30w
         soy4BsrPWTvRf6njOcMTGe1Ms3/L1RWyDhjVzbRpvl9bL+lrc5fZL84EUGF92Xtwvz
         +NI3j6/1khzFlEIihSje6VFwyhobBd1C+jGcf9qzOeZNVSkoUxfSiNGQyVl2Yir+Qt
         bVlau2kfmPkr8DEZmm6BioIX48TOZwDmuGqXlPEMxRspEmSIslMzqj3mVkOEU1xtat
         r26hiTZB+uZOqyvAGhrjOAcwBaw1LFjdkF0+oAB1T+YQ3bWX3CvKo2SJd9RYMiELfL
         0DdYqlWggKXng==
Date:   Wed, 28 Apr 2021 02:46:29 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     jeyu@kernel.org, keyrings@vger.kernel.org, dhowells@redhat.com,
        zohar@linux.ibm.com, nayna@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] certs: Add support for using elliptic curve keys
 for signing modules
Message-ID: <YIiiVVNWrtMqardm@kernel.org>
References: <20210421194319.1489291-1-stefanb@linux.ibm.com>
 <20210421194319.1489291-3-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421194319.1489291-3-stefanb@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Apr 21, 2021 at 03:43:19PM -0400, Stefan Berger wrote:
> Add support for using elliptic curve keys for signing modules. It uses
> a NIST P384 (secp384r1) key if the user chooses an elliptic curve key
> and will have ECDSA support built into the kernel.
> 
> Note: A developer choosing an ECDSA key for signing modules should still
> delete the signing key (rm certs/signing_key.*) when building an older
> version of a kernel that only supports RSA keys. Unless kbuild automati-
> cally detects and generates a new kernel module key, ECDSA-signed kernel
> modules will fail signature verification.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Looks good to me.

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko

> 
> ---
> v3:
>   - added missing OIDs for ECDSA signed hashes to pkcs7_sig_note_pkey_algo
>   - added recommendation to use string hash to Kconfig help text
> 
> v2:
>   - check for ECDSA key by id-ecPublicKey from output line
>     'Public Key Algorithm: id-ecPublicKey'.
> ---
>  certs/Kconfig                         | 26 ++++++++++++++++++++++++++
>  certs/Makefile                        |  9 +++++++++
>  crypto/asymmetric_keys/pkcs7_parser.c |  8 ++++++++
>  3 files changed, 43 insertions(+)
> 
> diff --git a/certs/Kconfig b/certs/Kconfig
> index 48675ad319db..d58f16c9f2d9 100644
> --- a/certs/Kconfig
> +++ b/certs/Kconfig
> @@ -15,6 +15,32 @@ config MODULE_SIG_KEY
>           then the kernel will automatically generate the private key and
>           certificate as described in Documentation/admin-guide/module-signing.rst
>  
> +choice
> +	prompt "Type of module signing key to be generated"
> +	default MODULE_SIG_KEY_TYPE_RSA
> +	help
> +	 The type of module signing key type to generate. This option
> +	 does not apply if a #PKCS11 URI is used.
> +
> +config MODULE_SIG_KEY_TYPE_RSA
> +	bool "RSA"
> +	depends on MODULE_SIG || IMA_APPRAISE_MODSIG
> +	help
> +	 Use an RSA key for module signing.
> +
> +config MODULE_SIG_KEY_TYPE_ECDSA
> +	bool "ECDSA"
> +	select CRYPTO_ECDSA
> +	depends on MODULE_SIG || IMA_APPRAISE_MODSIG
> +	help
> +	 Use an elliptic curve key (NIST P384) for module signing. Consider
> +	 using a strong hash like sha256 or sha384 for hashing modules.
> +
> +	 Note: Remove all ECDSA signing keys, e.g. certs/signing_key.pem,
> +	 when falling back to building Linux 5.11 and older kernels.
> +
> +endchoice
> +
>  config SYSTEM_TRUSTED_KEYRING
>  	bool "Provide system-wide ring of trusted keys"
>  	depends on KEYS
> diff --git a/certs/Makefile b/certs/Makefile
> index f64bc89ccbf1..c2fabc288550 100644
> --- a/certs/Makefile
> +++ b/certs/Makefile
> @@ -62,7 +62,15 @@ ifeq ($(CONFIG_MODULE_SIG_KEY),"certs/signing_key.pem")
>  
>  X509TEXT=$(shell openssl x509 -in $(CONFIG_MODULE_SIG_KEY) -text)
>  
> +# Support user changing key type
> +ifdef CONFIG_MODULE_SIG_KEY_TYPE_ECDSA
> +keytype_openssl = -newkey ec -pkeyopt ec_paramgen_curve:secp384r1
> +$(if $(findstring id-ecPublicKey,$(X509TEXT)),,$(shell rm -f $(CONFIG_MODULE_SIG_KEY)))
> +endif
> +
> +ifdef CONFIG_MODULE_SIG_KEY_TYPE_RSA
>  $(if $(findstring rsaEncryption,$(X509TEXT)),,$(shell rm -f $(CONFIG_MODULE_SIG_KEY)))
> +endif
>  
>  $(obj)/signing_key.pem: $(obj)/x509.genkey
>  	@$(kecho) "###"
> @@ -77,6 +85,7 @@ $(obj)/signing_key.pem: $(obj)/x509.genkey
>  		-batch -x509 -config $(obj)/x509.genkey \
>  		-outform PEM -out $(obj)/signing_key.pem \
>  		-keyout $(obj)/signing_key.pem \
> +		$(keytype_openssl) \
>  		$($(quiet)redirect_openssl)
>  	@$(kecho) "###"
>  	@$(kecho) "### Key pair generated."
> diff --git a/crypto/asymmetric_keys/pkcs7_parser.c b/crypto/asymmetric_keys/pkcs7_parser.c
> index 967329e0a07b..6592279d839a 100644
> --- a/crypto/asymmetric_keys/pkcs7_parser.c
> +++ b/crypto/asymmetric_keys/pkcs7_parser.c
> @@ -269,6 +269,14 @@ int pkcs7_sig_note_pkey_algo(void *context, size_t hdrlen,
>  		ctx->sinfo->sig->pkey_algo = "rsa";
>  		ctx->sinfo->sig->encoding = "pkcs1";
>  		break;
> +	case OID_id_ecdsa_with_sha1:
> +	case OID_id_ecdsa_with_sha224:
> +	case OID_id_ecdsa_with_sha256:
> +	case OID_id_ecdsa_with_sha384:
> +	case OID_id_ecdsa_with_sha512:
> +		ctx->sinfo->sig->pkey_algo = "ecdsa";
> +		ctx->sinfo->sig->encoding = "x962";
> +		break;
>  	default:
>  		printk("Unsupported pkey algo: %u\n", ctx->last_oid);
>  		return -ENOPKG;
> -- 
> 2.29.2
> 
> 
