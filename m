Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C85543B7997
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Jun 2021 22:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbhF2U7J (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Jun 2021 16:59:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:51064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235651AbhF2U7J (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Jun 2021 16:59:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18FE161CF6;
        Tue, 29 Jun 2021 20:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625000201;
        bh=yBfh3Dr6ayoNKO8uOCbZQ8sDl3yzNQCa0IUNmAuTwj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Spnc9wxG8XbesBC/Gt6Idn3ylKzwYeAJGaqYHjdMuFFb23hoTNiDAJHAbB3+p2C1k
         W4KctGavE0/yrSTvoFE0tcMbD/gUzxgGDDbr9tTStNebxraHw7NQgCPe3czGkm/xlR
         hu1POPRiO2nWBqeZ6LMrlqujhbaKRUskgxg71u6rERODkoNb7uUudD/wTNurZ6oA6a
         t6W/utt+V697FIRJ+2PAgLCAJcGabBjmg0Raz4CYX1sH6mSAl+v0znhsnx1lT17D7s
         VWWpdiz4/OGLROrstEcV5mlK1AKLDHyZCdDHoz54zrw79NeuKh9QNza68WRN2QZt83
         p+CIODzcqPALA==
Date:   Tue, 29 Jun 2021 23:56:39 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     jeyu@kernel.org, keyrings@vger.kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, zohar@linux.ibm.com, nayna@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v7 2/2] certs: Add support for using elliptic curve keys
 for signing modules
Message-ID: <20210629205639.dghpegknwgdqamxp@kernel.org>
References: <20210628214304.4165769-1-stefanb@linux.vnet.ibm.com>
 <20210628214304.4165769-3-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628214304.4165769-3-stefanb@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jun 28, 2021 at 05:43:04PM -0400, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
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
> Cc: David Howells <dhowells@redhat.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---

When you change the patches, you should remove all reviewed-by etc.
tags. Also, move Cc-tags before your sob.

/Jarkko

>  certs/Kconfig                         | 26 ++++++++++++++++++++++++++
>  certs/Makefile                        | 13 +++++++++++++
>  crypto/asymmetric_keys/pkcs7_parser.c |  8 ++++++++
>  3 files changed, 47 insertions(+)
> 
> diff --git a/certs/Kconfig b/certs/Kconfig
> index f4e61116f94e..916cbb1af928 100644
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
> +	depends on MODULE_SIG || (IMA_APPRAISE_MODSIG && MODULES)
> +	help
> +	 Use an RSA key for module signing.
> +
> +config MODULE_SIG_KEY_TYPE_ECDSA
> +	bool "ECDSA"
> +	select CRYPTO_ECDSA
> +	depends on MODULE_SIG || (IMA_APPRAISE_MODSIG && MODULES)
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
> index f9344e52ecda..279433783b10 100644
> --- a/certs/Makefile
> +++ b/certs/Makefile
> @@ -66,9 +66,21 @@ ifeq ($(CONFIG_MODULE_SIG_KEY),"certs/signing_key.pem")
>  
>  ifeq ($(openssl_available),yes)
>  X509TEXT=$(shell openssl x509 -in "certs/signing_key.pem" -text 2>/dev/null)
> +endif
>  
> +# Support user changing key type
> +ifdef CONFIG_MODULE_SIG_KEY_TYPE_ECDSA
> +keytype_openssl = -newkey ec -pkeyopt ec_paramgen_curve:secp384r1
> +ifeq ($(openssl_available),yes)
> +$(if $(findstring id-ecPublicKey,$(X509TEXT)),,$(shell rm -f "certs/signing_key.pem"))
> +endif
> +endif # CONFIG_MODULE_SIG_KEY_TYPE_ECDSA
> +
> +ifdef CONFIG_MODULE_SIG_KEY_TYPE_RSA
> +ifeq ($(openssl_available),yes)
>  $(if $(findstring rsaEncryption,$(X509TEXT)),,$(shell rm -f "certs/signing_key.pem"))
>  endif
> +endif # CONFIG_MODULE_SIG_KEY_TYPE_RSA
>  
>  $(obj)/signing_key.pem: $(obj)/x509.genkey
>  	@$(kecho) "###"
> @@ -83,6 +95,7 @@ $(obj)/signing_key.pem: $(obj)/x509.genkey
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
> 2.31.1
> 
> 
