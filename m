Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C61E30A599
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Feb 2021 11:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbhBAKkc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 1 Feb 2021 05:40:32 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:46948 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233296AbhBAKjw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 1 Feb 2021 05:39:52 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UNYB3r1_1612175940;
Received: from B-455UMD6M-2027.local(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0UNYB3r1_1612175940)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 01 Feb 2021 18:39:01 +0800
Subject: Re: [PATCH v6 2/4] x509: Detect sm2 keys by their parameters OID
To:     Stefan Berger <stefanb@linux.ibm.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        David Howells <dhowells@redhat.com>
References: <20210131233301.1301787-1-stefanb@linux.ibm.com>
 <20210131233301.1301787-3-stefanb@linux.ibm.com>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <75a8ff37-3c23-6cf1-f844-cf692eb8adfc@linux.alibaba.com>
Date:   Mon, 1 Feb 2021 18:39:00 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210131233301.1301787-3-stefanb@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2/1/21 7:32 AM, Stefan Berger wrote:
> Detect whether a key is an sm2 type of key by its OID in the parameters
> array rather than assuming that everything under OID_id_ecPublicKey
> is sm2, which is not the case.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: keyrings@vger.kernel.org
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
> index 4462ed2c18cd..d4982e42c0d2 100644
> --- a/include/linux/oid_registry.h
> +++ b/include/linux/oid_registry.h
> @@ -117,6 +117,7 @@ enum OID {
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

Great job, I'm just curious why we need to add a new function, this 
seems unnecessary, if possible, please add

Reviewed-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>

Best regards,
Tianjia
