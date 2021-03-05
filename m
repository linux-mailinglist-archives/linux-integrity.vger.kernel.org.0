Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D01232F0B8
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Mar 2021 18:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhCERHv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Mar 2021 12:07:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:45620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhCERHe (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Mar 2021 12:07:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A72066508C;
        Fri,  5 Mar 2021 17:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614964054;
        bh=lCtBJCye9mh10oZoiO4G45gkEauRRo7iSbdH3hsiTvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tq0MHNrFP8a26ADUQtK0qa5oXiDV3ltq0FY7xD3MU0z78eE20P8nnNZGmzhXS/tvK
         x490hCRmWv/djvW1LwE0gwyo5IBPWtN6r+pyVuoxH/CVP+ddVxzqptI+M8MWdeHg2E
         NoMlQ0CTHy3s3L5ogd3RgbRdzTDJno5xxOhzRz5Hcn7rV64VEm3hEaYztvad3vNCSn
         gKz+tCMUTjprXGmUrEbbIzGsPQmRa2Bsk2Xy1CKB36Gy0wgonbgm6GRiz3F4JSiTt+
         UAn3Q6sDGyeVWvjIKwIhplqKBCUbNNkuuIpR+WamMem3RR/9gX2+pVlG+DRIINO2o0
         JX3NFrD5zRhlA==
Date:   Fri, 5 Mar 2021 19:07:13 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com, zohar@linux.ibm.com,
        linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v10 6/9] x509: Add support for parsing x509 certs with
 ECDSA keys
Message-ID: <YEJlQUC5pfIemTaI@kernel.org>
References: <20210305005203.3547587-1-stefanb@linux.vnet.ibm.com>
 <20210305005203.3547587-7-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305005203.3547587-7-stefanb@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Mar 04, 2021 at 07:52:00PM -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> This patch adds support for parsing of x509 certificates that contain

"Add support..." instead of "This patch adds"

> ECDSA keys, such as NIST P256, that have been signed by a CA using any
> of the current SHA hash algorithms.
> 
> Cc: David Howells <dhowells@redhat.com>
> Cc: keyrings@vger.kernel.org
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

/Jarkko

> 
> ---
> 
> v7->v8:
>  - do not detect key algo using parse_OID() in public_key.c but set
>    pkey_algo to the key type 'ecdsa-nist-p192/256' when parsing cert
> ---
>  crypto/asymmetric_keys/public_key.c       |  4 ++-
>  crypto/asymmetric_keys/x509_cert_parser.c | 34 ++++++++++++++++++++++-
>  crypto/asymmetric_keys/x509_public_key.c  |  4 ++-
>  include/linux/oid_registry.h              |  2 ++
>  4 files changed, 41 insertions(+), 3 deletions(-)
> 
> diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
> index 788a4ba1e2e7..4fefb219bfdc 100644
> --- a/crypto/asymmetric_keys/public_key.c
> +++ b/crypto/asymmetric_keys/public_key.c
> @@ -14,6 +14,7 @@
>  #include <linux/slab.h>
>  #include <linux/seq_file.h>
>  #include <linux/scatterlist.h>
> +#include <linux/asn1.h>
>  #include <keys/asymmetric-subtype.h>
>  #include <crypto/public_key.h>
>  #include <crypto/akcipher.h>
> @@ -85,7 +86,8 @@ int software_key_determine_akcipher(const char *encoding,
>  		return n >= CRYPTO_MAX_ALG_NAME ? -EINVAL : 0;
>  	}
>  
> -	if (strcmp(encoding, "raw") == 0) {
> +	if (strcmp(encoding, "raw") == 0 ||
> +	    strcmp(encoding, "x962") == 0) {
>  		strcpy(alg_name, pkey->pkey_algo);
>  		return 0;
>  	}
> diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
> index 1621ceaf5c95..f5d547c6dfb5 100644
> --- a/crypto/asymmetric_keys/x509_cert_parser.c
> +++ b/crypto/asymmetric_keys/x509_cert_parser.c
> @@ -227,6 +227,26 @@ int x509_note_pkey_algo(void *context, size_t hdrlen,
>  		ctx->cert->sig->hash_algo = "sha224";
>  		goto rsa_pkcs1;
>  
> +	case OID_id_ecdsa_with_sha1:
> +		ctx->cert->sig->hash_algo = "sha1";
> +		goto ecdsa;
> +
> +	case OID_id_ecdsa_with_sha224:
> +		ctx->cert->sig->hash_algo = "sha224";
> +		goto ecdsa;
> +
> +	case OID_id_ecdsa_with_sha256:
> +		ctx->cert->sig->hash_algo = "sha256";
> +		goto ecdsa;
> +
> +	case OID_id_ecdsa_with_sha384:
> +		ctx->cert->sig->hash_algo = "sha384";
> +		goto ecdsa;
> +
> +	case OID_id_ecdsa_with_sha512:
> +		ctx->cert->sig->hash_algo = "sha512";
> +		goto ecdsa;
> +
>  	case OID_gost2012Signature256:
>  		ctx->cert->sig->hash_algo = "streebog256";
>  		goto ecrdsa;
> @@ -255,6 +275,11 @@ int x509_note_pkey_algo(void *context, size_t hdrlen,
>  	ctx->cert->sig->encoding = "raw";
>  	ctx->algo_oid = ctx->last_oid;
>  	return 0;
> +ecdsa:
> +	ctx->cert->sig->pkey_algo = "ecdsa";
> +	ctx->cert->sig->encoding = "x962";
> +	ctx->algo_oid = ctx->last_oid;
> +	return 0;
>  }
>  
>  /*
> @@ -276,7 +301,8 @@ int x509_note_signature(void *context, size_t hdrlen,
>  
>  	if (strcmp(ctx->cert->sig->pkey_algo, "rsa") == 0 ||
>  	    strcmp(ctx->cert->sig->pkey_algo, "ecrdsa") == 0 ||
> -	    strcmp(ctx->cert->sig->pkey_algo, "sm2") == 0) {
> +	    strcmp(ctx->cert->sig->pkey_algo, "sm2") == 0 ||
> +	    strcmp(ctx->cert->sig->pkey_algo, "ecdsa") == 0) {
>  		/* Discard the BIT STRING metadata */
>  		if (vlen < 1 || *(const u8 *)value != 0)
>  			return -EBADMSG;
> @@ -478,6 +504,12 @@ int x509_extract_key_data(void *context, size_t hdrlen,
>  		case OID_sm2:
>  			ctx->cert->pub->pkey_algo = "sm2";
>  			break;
> +		case OID_id_prime192v1:
> +			ctx->cert->pub->pkey_algo = "ecdsa-nist-p192";
> +			break;
> +		case OID_id_prime256v1:
> +			ctx->cert->pub->pkey_algo = "ecdsa-nist-p256";
> +			break;
>  		default:
>  			return -ENOPKG;
>  		}
> diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric_keys/x509_public_key.c
> index ae450eb8be14..3d45161b271a 100644
> --- a/crypto/asymmetric_keys/x509_public_key.c
> +++ b/crypto/asymmetric_keys/x509_public_key.c
> @@ -129,7 +129,9 @@ int x509_check_for_self_signed(struct x509_certificate *cert)
>  	}
>  
>  	ret = -EKEYREJECTED;
> -	if (strcmp(cert->pub->pkey_algo, cert->sig->pkey_algo) != 0)
> +	if (strcmp(cert->pub->pkey_algo, cert->sig->pkey_algo) != 0 &&
> +	    (strncmp(cert->pub->pkey_algo, "ecdsa-", 6) != 0 ||
> +	     strcmp(cert->sig->pkey_algo, "ecdsa") != 0))
>  		goto out;
>  
>  	ret = public_key_verify_signature(cert->pub, cert->sig);
> diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
> index f32d91895e4d..3583908cf1ca 100644
> --- a/include/linux/oid_registry.h
> +++ b/include/linux/oid_registry.h
> @@ -20,6 +20,8 @@ enum OID {
>  	OID_id_dsa_with_sha1,		/* 1.2.840.10030.4.3 */
>  	OID_id_dsa,			/* 1.2.840.10040.4.1 */
>  	OID_id_ecPublicKey,		/* 1.2.840.10045.2.1 */
> +	OID_id_prime192v1,		/* 1.2.840.10045.3.1.1 */
> +	OID_id_prime256v1,		/* 1.2.840.10045.3.1.7 */
>  	OID_id_ecdsa_with_sha1,		/* 1.2.840.10045.4.1 */
>  	OID_id_ecdsa_with_sha224,	/* 1.2.840.10045.4.3.1 */
>  	OID_id_ecdsa_with_sha256,	/* 1.2.840.10045.4.3.2 */
> -- 
> 2.29.2
> 
> 
