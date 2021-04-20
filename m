Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C548365ABB
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Apr 2021 16:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbhDTOEB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 20 Apr 2021 10:04:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:38682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232304AbhDTOEA (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 20 Apr 2021 10:04:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F251613B6;
        Tue, 20 Apr 2021 14:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618927408;
        bh=hCrOPJTY3Fd4qxmAG0UmOelLAoekKGpQd0q0vXVkEWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L4ZXbHvT9TAnR/8F9ABzSzhPq3pKkSvD1ElRUnbnkC7PPkxsDwYJGak3627J4c0Kn
         RJwh5uIxQuxcf0BadYm88AHaC3gX6p/QLJ9kpvllm4D3ZywAe7+m93D0u54jkneY/g
         Sq0qSFn1K5VZqMt2Du2Tb8AUt1WepS2wugw/frkU7OoNepyZu9GShYLG3xZ2ayfp4j
         e8JkEk8Wu+jE1tMAumHTG6eXZl++VkgUXH+64wAY8b8Kq1PsA/aeVj1rxpPOzkEbEu
         IbXfoeAIgeqN5X3RMeqLQSiUemRX5l55GjWsAXg6VMo2Eq2KjBSsYljCDAVEyQY2JK
         itGj94ogWH9Xg==
Date:   Tue, 20 Apr 2021 16:03:21 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     keyrings@vger.kernel.org, dhowells@redhat.com, zohar@linux.ibm.com,
        jarkko@kernel.org, nayna@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] certs: Add support for using elliptic curve keys
 for signing modules
Message-ID: <YH7fKUjJoynyPkHt@gunter>
References: <20210408152403.1189121-1-stefanb@linux.ibm.com>
 <20210408152403.1189121-3-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210408152403.1189121-3-stefanb@linux.ibm.com>
X-OS:   Linux gunter 5.11.12-1-default x86_64
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

+++ Stefan Berger [08/04/21 11:24 -0400]:
>Add support for using elliptic curve keys for signing modules. It uses
>a NIST P384 (secp384r1) key if the user chooses an elliptic curve key
>and will have ECDSA support built into the kernel.
>
>Note: A developer choosing an ECDSA key for signing modules should still
>delete the signing key (rm certs/signing_key.*) when building an older
>version of a kernel that only supports RSA keys. Unless kbuild automati-
>cally detects and generates a new kernel module key, ECDSA-signed kernel
>modules will fail signature verification.
>
>Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>
>---
>v2:
>  - check for ECDSA key by id-ecPublicKey from output line
>    'Public Key Algorithm: id-ecPublicKey'.
>---
> certs/Kconfig                         | 25 +++++++++++++++++++++++++
> certs/Makefile                        |  9 +++++++++
> crypto/asymmetric_keys/pkcs7_parser.c |  4 ++++
> 3 files changed, 38 insertions(+)
>
>diff --git a/certs/Kconfig b/certs/Kconfig
>index 48675ad319db..6f8337874ae0 100644
>--- a/certs/Kconfig
>+++ b/certs/Kconfig
>@@ -15,6 +15,31 @@ config MODULE_SIG_KEY
>          then the kernel will automatically generate the private key and
>          certificate as described in Documentation/admin-guide/module-signing.rst
>
>+choice
>+	prompt "Type of module signing key to be generated"
>+	default MODULE_SIG_KEY_TYPE_RSA
>+	help
>+	 The type of module signing key type to generate. This option
>+	 does not apply if a #PKCS11 URI is used.
>+
>+config MODULE_SIG_KEY_TYPE_RSA
>+	bool "RSA"
>+	depends on MODULE_SIG || IMA_APPRAISE_MODSIG
>+	help
>+	 Use an RSA key for module signing.
>+
>+config MODULE_SIG_KEY_TYPE_ECDSA
>+	bool "ECDSA"
>+	select CRYPTO_ECDSA
>+	depends on MODULE_SIG || IMA_APPRAISE_MODSIG
>+	help
>+	 Use an elliptic curve key (NIST P384) for module signing.
>+
>+	 Note: Remove all ECDSA signing keys, e.g. certs/signing_key.pem,
>+	 when falling back to building Linux 5.11 and older kernels.
>+
>+endchoice
>+
> config SYSTEM_TRUSTED_KEYRING
> 	bool "Provide system-wide ring of trusted keys"
> 	depends on KEYS
>diff --git a/certs/Makefile b/certs/Makefile
>index f64bc89ccbf1..c2fabc288550 100644
>--- a/certs/Makefile
>+++ b/certs/Makefile
>@@ -62,7 +62,15 @@ ifeq ($(CONFIG_MODULE_SIG_KEY),"certs/signing_key.pem")
>
> X509TEXT=$(shell openssl x509 -in $(CONFIG_MODULE_SIG_KEY) -text)
>
>+# Support user changing key type
>+ifdef CONFIG_MODULE_SIG_KEY_TYPE_ECDSA
>+keytype_openssl = -newkey ec -pkeyopt ec_paramgen_curve:secp384r1
>+$(if $(findstring id-ecPublicKey,$(X509TEXT)),,$(shell rm -f $(CONFIG_MODULE_SIG_KEY)))
>+endif
>+
>+ifdef CONFIG_MODULE_SIG_KEY_TYPE_RSA
> $(if $(findstring rsaEncryption,$(X509TEXT)),,$(shell rm -f $(CONFIG_MODULE_SIG_KEY)))
>+endif
>
> $(obj)/signing_key.pem: $(obj)/x509.genkey
> 	@$(kecho) "###"
>@@ -77,6 +85,7 @@ $(obj)/signing_key.pem: $(obj)/x509.genkey
> 		-batch -x509 -config $(obj)/x509.genkey \
> 		-outform PEM -out $(obj)/signing_key.pem \
> 		-keyout $(obj)/signing_key.pem \
>+		$(keytype_openssl) \
> 		$($(quiet)redirect_openssl)
> 	@$(kecho) "###"
> 	@$(kecho) "### Key pair generated."
>diff --git a/crypto/asymmetric_keys/pkcs7_parser.c b/crypto/asymmetric_keys/pkcs7_parser.c
>index 967329e0a07b..2546ec6a0505 100644
>--- a/crypto/asymmetric_keys/pkcs7_parser.c
>+++ b/crypto/asymmetric_keys/pkcs7_parser.c
>@@ -269,6 +269,10 @@ int pkcs7_sig_note_pkey_algo(void *context, size_t hdrlen,
> 		ctx->sinfo->sig->pkey_algo = "rsa";
> 		ctx->sinfo->sig->encoding = "pkcs1";
> 		break;
>+	case OID_id_ecdsa_with_sha256:
>+		ctx->sinfo->sig->pkey_algo = "ecdsa";
>+		ctx->sinfo->sig->encoding = "x962";
>+		break;

Hi Stefan,

Does CONFIG_MODULE_SIG_KEY_TYPE_ECDSA have a dependency on MODULE_SIG_SHA256?
By default, MODULE_SIG_SHA1 is selected when CONFIG_MODULE_SIG is enabled.
I was doing some quick testing and found that when I enabled
MODULE_SIG_KEY_TYPE_ECDSA I get a "Unsupported pkey algo: 5" error on
module load, which goes away after fixing my config and selecting
MODULE_SIG_SHA256.

Thanks,

Jessica
