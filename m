Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08BBF32F0BF
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Mar 2021 18:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbhCERI2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Mar 2021 12:08:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:45714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231314AbhCERIK (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Mar 2021 12:08:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A1DDD6508D;
        Fri,  5 Mar 2021 17:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614964090;
        bh=OFghfz4fo2Hwva9U3AMF+sYgUGekpzEUbPQx4W4l3Zg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YskqngIlpkxndSdlRCD/z6VczqHQPHeRNk5ObLL/ZiUlPkd4dsJAPk92UNw7bJCYx
         aPZ/Z/KBeiHfLsACxiLBZQhDCDOoy+tbonl8c7gYWn+aTu49zorr5zkz5blUSaqeoJ
         ZnvAPurYssw2c4OVWc/wJIHaHO/6FbBP/8UbmbRXKGQfyChEMO+c+3jiVJJ5iSrmgN
         IqHWGDLL+0shOVEjcD4w7ugigGYGfTbwfpQK/841HOAAGS7wO8tcUqZtEUM3qOhVow
         FL38jZ+Y0s36cs387mfQrSBLyR5BOsw+4jUfSzPdLNGpJInBa49biAdQlqH0hly/DO
         1S8reBY2Xu3hg==
Date:   Fri, 5 Mar 2021 19:07:49 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com, zohar@linux.ibm.com,
        linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v10 9/9] certs: Add support for using elliptic curve keys
 for signing modules
Message-ID: <YEJlZbujuFSaO+ms@kernel.org>
References: <20210305005203.3547587-1-stefanb@linux.vnet.ibm.com>
 <20210305005203.3547587-10-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305005203.3547587-10-stefanb@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Mar 04, 2021 at 07:52:03PM -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> This patch adds support for using elliptic curve keys for signing

"Add support

> modules. It uses a NIST P384 (secp384r1) key if the user chooses an
> elliptic curve key and will have ECDSA support built into the kernel.
> 
> Note: A developer choosing an ECDSA key for signing modules has to
> manually delete the signing key (rm certs/signing_key.*) when falling
> back to building an older version of a kernel that only supports RSA
> keys since otherwise ECDSA-signed modules will not be usable when that
> older kernel runs and the ECDSA key was still used for signing modules.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> 

Extra new line.

> ---

/Jarkko
> 
> v8->v9:
>  - Automatically select CONFIG_ECDSA for built-in ECDSA support
>  - Added help documentation
> 
> This patch builds on top Nayna's series for 'kernel build support for
> loading the kernel module signing key'.
> - https://lkml.org/lkml/2021/2/18/856
> ---
>  certs/Kconfig                         | 22 ++++++++++++++++++++++
>  certs/Makefile                        | 14 ++++++++++++++
>  crypto/asymmetric_keys/pkcs7_parser.c |  4 ++++
>  3 files changed, 40 insertions(+)
> 
> diff --git a/certs/Kconfig b/certs/Kconfig
> index 48675ad319db..919db43ce80b 100644
> --- a/certs/Kconfig
> +++ b/certs/Kconfig
> @@ -15,6 +15,28 @@ config MODULE_SIG_KEY
>           then the kernel will automatically generate the private key and
>           certificate as described in Documentation/admin-guide/module-signing.rst
>  
> +choice
> +	prompt "Type of module signing key to be generated"
> +	default MODULE_SIG_KEY_TYPE_RSA
> +	help
> +	 The type of module signing key type to generated. This option
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
> +	 Use an elliptic curve key (NIST P384) for module signing.
> +
> +endchoice
> +
>  config SYSTEM_TRUSTED_KEYRING
>  	bool "Provide system-wide ring of trusted keys"
>  	depends on KEYS
> diff --git a/certs/Makefile b/certs/Makefile
> index 3fe6b73786fa..c487d7021c54 100644
> --- a/certs/Makefile
> +++ b/certs/Makefile
> @@ -69,6 +69,18 @@ else
>  SIGNER = -signkey $(obj)/signing_key.key
>  endif # CONFIG_IMA_APPRAISE_MODSIG
>  
> +X509TEXT=$(shell openssl x509 -in $(CONFIG_MODULE_SIG_KEY) -text)
> +
> +# Support user changing key type
> +ifdef CONFIG_MODULE_SIG_KEY_TYPE_ECDSA
> +keytype_openssl = -newkey ec -pkeyopt ec_paramgen_curve:secp384r1
> +$(if $(findstring ecdsa-with-,$(X509TEXT)),,$(shell rm -f $(CONFIG_MODULE_SIG_KEY)))
> +endif
> +
> +ifdef CONFIG_MODULE_SIG_KEY_TYPE_RSA
> +$(if $(findstring rsaEncryption,$(X509TEXT)),,$(shell rm -f $(CONFIG_MODULE_SIG_KEY)))
> +endif
> +
>  $(obj)/signing_key.pem: $(obj)/x509.genkey
>  	@$(kecho) "###"
>  	@$(kecho) "### Now generating an X.509 key pair to be used for signing modules."
> @@ -86,12 +98,14 @@ ifeq ($(CONFIG_IMA_APPRAISE_MODSIG),y)
>  		-batch -x509 -config $(obj)/x509.genkey \
>  		-outform PEM -out $(CA_KEY) \
>  		-keyout $(CA_KEY) -extensions ca_ext \
> +		$(keytype_openssl) \
>  		$($(quiet)redirect_openssl)
>  endif # CONFIG_IMA_APPRAISE_MODSIG
>  	$(Q)openssl req -new -nodes -utf8 \
>  		-batch -config $(obj)/x509.genkey \
>  		-outform PEM -out $(obj)/signing_key.csr \
>  		-keyout $(obj)/signing_key.key -extensions myexts \
> +		$(keytype_openssl) \
>  		$($(quiet)redirect_openssl)
>  	$(Q)openssl x509 -req -days 36500 -in $(obj)/signing_key.csr \
>  		-outform PEM -out $(obj)/signing_key.crt $(SIGNER) \
> diff --git a/crypto/asymmetric_keys/pkcs7_parser.c b/crypto/asymmetric_keys/pkcs7_parser.c
> index 967329e0a07b..2546ec6a0505 100644
> --- a/crypto/asymmetric_keys/pkcs7_parser.c
> +++ b/crypto/asymmetric_keys/pkcs7_parser.c
> @@ -269,6 +269,10 @@ int pkcs7_sig_note_pkey_algo(void *context, size_t hdrlen,
>  		ctx->sinfo->sig->pkey_algo = "rsa";
>  		ctx->sinfo->sig->encoding = "pkcs1";
>  		break;
> +	case OID_id_ecdsa_with_sha256:
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
