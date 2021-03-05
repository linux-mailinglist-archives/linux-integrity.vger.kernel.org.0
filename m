Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6EB32F0F4
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Mar 2021 18:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhCERRA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Mar 2021 12:17:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:47280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229589AbhCERQi (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Mar 2021 12:16:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1892650AB;
        Fri,  5 Mar 2021 17:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614964598;
        bh=+Gb5g3MfCrcc26NGCLLuspANACPs6Pfj+Bgg/wKdCaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c3txESaI2URJuTTYiOXCVfTZrxV3UQRRMBcXGvhOyaNq2DnTGfMoc/T22N42OTYVR
         ytclvmmC0BM8inW7blAA/QGVGqNprQqUeYIdS0lF70eJr/ZipjM9YLSUmWTOAsDZlu
         djccdDBiXXX6fqFdqXehcpzKO1ZhuKMn0s1T1NIOQLrWNNPC1kO5Bomo+ZDQG9GW3h
         IrYFDQl7E5B4gXAT5/Xw1fb0exIKhY4Dw5oO/0wJxG9vrCRaDhYXufTrqboyIAMpar
         bAx/4iQZykVd5vSXfaE4qDj5ktgA14MM8KKxy4oDn89UktREi9g9OlzNMCgVB4Ae53
         7CHVIdmiYLJUw==
Date:   Fri, 5 Mar 2021 19:16:16 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com, zohar@linux.ibm.com,
        linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: Re: [PATCH v10 5/9] x509: Detect sm2 keys by their parameters OID
Message-ID: <YEJnYOvFnWr7YcJK@kernel.org>
References: <20210305005203.3547587-1-stefanb@linux.vnet.ibm.com>
 <20210305005203.3547587-6-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305005203.3547587-6-stefanb@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Mar 04, 2021 at 07:51:59PM -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Detect whether a key is an sm2 type of key by its OID in the parameters
> array rather than assuming that everything under OID_id_ecPublicKey
> is sm2, which is not the case.
> 
> Cc: David Howells <dhowells@redhat.com>
> Cc: keyrings@vger.kernel.org
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Reviewed-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  crypto/asymmetric_keys/x509_cert_parser.c | 12 +++++++++++-
>  include/linux/oid_registry.h              |  1 +
>  lib/oid_registry.c                        | 13 +++++++++++++
>  3 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
> index 52c9b455fc7d..1621ceaf5c95 100644
> --- a/crypto/asymmetric_keys/x509_cert_parser.c
> +++ b/crypto/asymmetric_keys/x509_cert_parser.c
> @@ -459,6 +459,7 @@ int x509_extract_key_data(void *context, size_t hdrlen,
>  			  const void *value, size_t vlen)
>  {
>  	struct x509_parse_context *ctx = context;
> +	enum OID oid;

enum is not a real type, and it is hard to recall how much it allocates
from stack. I would replace this with plain int.

>  
>  	ctx->key_algo = ctx->last_oid;
>  	switch (ctx->last_oid) {
> @@ -470,7 +471,16 @@ int x509_extract_key_data(void *context, size_t hdrlen,
>  		ctx->cert->pub->pkey_algo = "ecrdsa";
>  		break;
>  	case OID_id_ecPublicKey:
> -		ctx->cert->pub->pkey_algo = "sm2";
> +		if (parse_OID(ctx->params, ctx->params_size, &oid) != 0)
> +			return -EBADMSG;
> +
> +		switch (oid) {
> +		case OID_sm2:
> +			ctx->cert->pub->pkey_algo = "sm2";
> +			break;
> +		default:
> +			return -ENOPKG;
> +		}
>  		break;
>  	default:
>  		return -ENOPKG;
> diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
> index b504e2f36b25..f32d91895e4d 100644
> --- a/include/linux/oid_registry.h
> +++ b/include/linux/oid_registry.h
> @@ -121,6 +121,7 @@ enum OID {
>  };
>  
>  extern enum OID look_up_OID(const void *data, size_t datasize);
> +extern int parse_OID(const void *data, size_t datasize, enum OID *oid);
>  extern int sprint_oid(const void *, size_t, char *, size_t);
>  extern int sprint_OID(enum OID, char *, size_t);
>  
> diff --git a/lib/oid_registry.c b/lib/oid_registry.c
> index f7ad43f28579..508e0b34b5f0 100644
> --- a/lib/oid_registry.c
> +++ b/lib/oid_registry.c
> @@ -11,6 +11,7 @@
>  #include <linux/kernel.h>
>  #include <linux/errno.h>
>  #include <linux/bug.h>
> +#include <linux/asn1.h>
>  #include "oid_registry_data.c"
>  
>  MODULE_DESCRIPTION("OID Registry");
> @@ -92,6 +93,18 @@ enum OID look_up_OID(const void *data, size_t datasize)
>  }
>  EXPORT_SYMBOL_GPL(look_up_OID);
>  
> +int parse_OID(const void *data, size_t datasize, enum OID *oid)

An exported function without kdoc.

> +{
> +	const unsigned char *v = data;
> +
> +	if (datasize < 2 || v[0] != ASN1_OID || v[1] != datasize - 2)
> +		return -EBADMSG;

'1' and '2' are magic numbers unless you either have constants defining
them, or at least an inline comment with explanation.

> +
> +	*oid = look_up_OID(data + 2, datasize - 2);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(parse_OID);
> +
>  /*
>   * sprint_OID - Print an Object Identifier into a buffer
>   * @data: The encoded OID to print
> -- 
> 2.29.2
> 
> 

/Jarkko
