Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 704AA32E310
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Mar 2021 08:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbhCEHjM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Mar 2021 02:39:12 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:55838 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229446AbhCEHjL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Mar 2021 02:39:11 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UQWlSZB_1614929947;
Received: from B-455UMD6M-2027.local(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UQWlSZB_1614929947)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 05 Mar 2021 15:39:08 +0800
Subject: Re: [PATCH v10 5/9] x509: Detect sm2 keys by their parameters OID
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com, zohar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
References: <20210305005203.3547587-1-stefanb@linux.vnet.ibm.com>
 <20210305005203.3547587-6-stefanb@linux.vnet.ibm.com>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <ea02d751-ec82-8df6-475b-bd3e7ded3e0e@linux.alibaba.com>
Date:   Fri, 5 Mar 2021 15:39:07 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210305005203.3547587-6-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 3/5/21 8:51 AM, Stefan Berger wrote:
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
>   crypto/asymmetric_keys/x509_cert_parser.c | 12 +++++++++++-
>   include/linux/oid_registry.h              |  1 +
>   lib/oid_registry.c                        | 13 +++++++++++++
>   3 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
> index 52c9b455fc7d..1621ceaf5c95 100644
> --- a/crypto/asymmetric_keys/x509_cert_parser.c
> +++ b/crypto/asymmetric_keys/x509_cert_parser.c
> @@ -459,6 +459,7 @@ int x509_extract_key_data(void *context, size_t hdrlen,
>   			  const void *value, size_t vlen)
>   {
>   	struct x509_parse_context *ctx = context;
> +	enum OID oid;
>   
>   	ctx->key_algo = ctx->last_oid;
>   	switch (ctx->last_oid) {
> @@ -470,7 +471,16 @@ int x509_extract_key_data(void *context, size_t hdrlen,
>   		ctx->cert->pub->pkey_algo = "ecrdsa";
>   		break;
>   	case OID_id_ecPublicKey:
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
>   		break;
>   	default:
>   		return -ENOPKG;
> diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
> index b504e2f36b25..f32d91895e4d 100644
> --- a/include/linux/oid_registry.h
> +++ b/include/linux/oid_registry.h
> @@ -121,6 +121,7 @@ enum OID {
>   };
>   
>   extern enum OID look_up_OID(const void *data, size_t datasize);
> +extern int parse_OID(const void *data, size_t datasize, enum OID *oid);
>   extern int sprint_oid(const void *, size_t, char *, size_t);
>   extern int sprint_OID(enum OID, char *, size_t);
>   
> diff --git a/lib/oid_registry.c b/lib/oid_registry.c
> index f7ad43f28579..508e0b34b5f0 100644
> --- a/lib/oid_registry.c
> +++ b/lib/oid_registry.c
> @@ -11,6 +11,7 @@
>   #include <linux/kernel.h>
>   #include <linux/errno.h>
>   #include <linux/bug.h>
> +#include <linux/asn1.h>
>   #include "oid_registry_data.c"
>   
>   MODULE_DESCRIPTION("OID Registry");
> @@ -92,6 +93,18 @@ enum OID look_up_OID(const void *data, size_t datasize)
>   }
>   EXPORT_SYMBOL_GPL(look_up_OID);
>   
> +int parse_OID(const void *data, size_t datasize, enum OID *oid)
> +{
> +	const unsigned char *v = data;
> +
> +	if (datasize < 2 || v[0] != ASN1_OID || v[1] != datasize - 2)
> +		return -EBADMSG;
> +
> +	*oid = look_up_OID(data + 2, datasize - 2);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(parse_OID);
> +
>   /*
>    * sprint_OID - Print an Object Identifier into a buffer
>    * @data: The encoded OID to print
> 

Tested-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

Best regards,
Tianjia
