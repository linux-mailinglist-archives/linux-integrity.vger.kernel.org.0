Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B689C32C90E
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Mar 2021 02:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353104AbhCDBCN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 3 Mar 2021 20:02:13 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20640 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1388903AbhCDAMW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Mar 2021 19:12:22 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 123NiF7E187060;
        Wed, 3 Mar 2021 18:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=9hmufHBx8zEm/lSY8SP5hpZIAwhMnmA4N+Y9juxescc=;
 b=ndGszCqaTZThXbYE1yudxey01QJ3extFyMAhKY9vvbjzwn9o3X0yGhGuPlncqJp0Ng4g
 C9w3LBP0VxlDpqFVOOYxcWQjB3sYv53APMpzK7e1GZR1z5C0PNy31lxP0dnYB2LpPuaK
 9pOsek4ANiPN65o0I5X+ebFQCGgNM9kAt3SWVzmXW4r0Ryfb1sPu2AYcR3SWj4anI4WZ
 gxRf32psbmVnphSwzvaX/uGJZMWdbXGrcBAq4mW4Dw0DvE9j+++GMfvTpN4nh+XI6CDb
 FvcsEhewXrz28SW44VV+rcmRiR+kA4iiT9zHwEBxKzMYNRhxfZpPuUAwwxgM6hN4N6+f VA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 372mcx80yd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Mar 2021 18:46:15 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 123NjJeQ193130;
        Wed, 3 Mar 2021 18:46:14 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com with ESMTP id 372mcx80xw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Mar 2021 18:46:14 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 123Nh1JL010430;
        Wed, 3 Mar 2021 23:46:13 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma01dal.us.ibm.com with ESMTP id 371qmunegh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Mar 2021 23:46:13 +0000
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 123NkDes26739058
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Mar 2021 23:46:13 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DA49AE05F;
        Wed,  3 Mar 2021 23:46:13 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D2EE6AE062;
        Wed,  3 Mar 2021 23:46:12 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  3 Mar 2021 23:46:12 +0000 (GMT)
Subject: Re: [PATCH v9 2/9] x509: Detect sm2 keys by their parameters OID
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        "open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>
References: <20210225160802.2478700-1-stefanb@linux.vnet.ibm.com>
 <20210225160802.2478700-3-stefanb@linux.vnet.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <048e22c7-45e3-022c-cd5b-a6bc127958d3@linux.ibm.com>
Date:   Wed, 3 Mar 2021 18:46:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210225160802.2478700-3-stefanb@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-03_07:2021-03-03,2021-03-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 mlxscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103030169
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Tianjia,

    can you say whether SM2 support works for you before and after 
applying this patch? I cannot verify it with an sm2 key I have created 
using a sequence of commands like this:

 > modprobe sm2_generic
 > id=$(keyctl newring test @u)
 > keyctl padd asymmetric "" $id < sm2.der
add_key: Key was rejected by service
 > keyctl padd asymmetric "" $id < eckeys/cert-prime192v1-0.der
88506426

The sm2 key is reject but the pime192v1 key works just fine. SM2 support 
neither worked for me before nor after this patch here. The difference 
is that before it returned 'add_key: Package not installed'.

This is my sm2 cert:

 > base64 < sm2.der
MIIBbzCCARWgAwIBAgIUfqwndeAy7reymWLwvCHOgYPU2YUwCgYIKoZIzj0EAwIwDTELMAkGA1UE
AwwCbWUwHhcNMjEwMTI0MTgwNjQ3WhcNMjIwMTI0MTgwNjQ3WjANMQswCQYDVQQDDAJtZTBZMBMG
ByqGSM49AgEGCCqBHM9VAYItA0IABEtiMaczdk46MEugmOsY/u+puf5qoi7JdLd/w3VpdixvDd26
vrxLKL7lCTVn5w3a07G7QB1dgdMDpzIRgWrVXC6jUzBRMB0GA1UdDgQWBBSxOVnE7ihvTb6Nczb4
/mow+HIc9TAfBgNVHSMEGDAWgBSxOVnE7ihvTb6Nczb4/mow+HIc9TAPBgNVHRMBAf8EBTADAQH/
MAoGCCqGSM49BAMCA0gAMEUCIE1kiji2ABUy663NANe0iCPjCeeqg02Yk4b3K+Ci/Qh4AiEA/cFB
eJEVklyveRMvuTP7BN7FG4U8iRdtedjiX+YrNio=

Regards,
    Stefan



On 2/25/21 11:07 AM, Stefan Berger wrote:
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


