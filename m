Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA09331FF70
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Feb 2021 20:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhBST3x (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Feb 2021 14:29:53 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55976 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229555AbhBST3v (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Feb 2021 14:29:51 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11JJ23RP010339;
        Fri, 19 Feb 2021 14:29:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=jbg7tAY0gSVy2HLU8E4q9zaIQ/JXVpncfnbKr55IKSg=;
 b=oYWImmtfk/5Fup9b0N6fufOED2AKJZFWAOfnhRnxTEgXEclJvwURMH5nHwGmTGPpwcDd
 /jUhZ87yMvhN14b2J8jfopgL9sUh29t6gLI1ZcJplSTBTSZyZafQqG8RdsGoyu8mJcW4
 am7iUJzBW4XlTga154uz/7bJr0ddaxvQfxv5vxDMpTHLK7qCGMh7Hh4w4YXVlgyzpv+M
 s5uogV8YPkHMbGNeEtd0fujD38kZcGlga9EAw2Ih1+qw/dXLH33+iXgeBrhuK/h4ewIc
 9Jbigc4EUoFY604leCPISDHk8ORfxhMqC8kW0r4EqaH7dBxV2nSTxqPfUEs5eZGhkhlL VA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36th49crjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 14:29:02 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11JJ2Bqm010975;
        Fri, 19 Feb 2021 14:29:02 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36th49crj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 14:29:02 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11JJSfm3025574;
        Fri, 19 Feb 2021 19:29:01 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma02dal.us.ibm.com with ESMTP id 36p6dakkhm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 19:29:01 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11JJT0fV21627276
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 19:29:00 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F38C4BE04F;
        Fri, 19 Feb 2021 19:28:59 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 13AD5BE053;
        Fri, 19 Feb 2021 19:28:59 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 19 Feb 2021 19:28:58 +0000 (GMT)
Subject: Re: [PATCH 1/3] add params and ids to support nist_p384
To:     Saulo Alessandre <saulo.alessandre@gmail.com>
Cc:     davem@davemloft.net, dhowells@redhat.com,
        herbert@gondor.apana.org.au, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        zohar@linux.ibm.com, Saulo Alessandre <saulo.alessandre@tse.jus.br>
References: <20210215162532.1077098-1-stefanb@linux.ibm.com>
 <20210219185759.1033764-1-saulo.alessandre@gmail.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <7a7606a5-2cea-ed30-5887-69a1546cf2b0@linux.ibm.com>
Date:   Fri, 19 Feb 2021 14:28:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210219185759.1033764-1-saulo.alessandre@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-19_08:2021-02-18,2021-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190144
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/19/21 1:57 PM, Saulo Alessandre wrote:
> From: Saulo Alessandre <saulo.alessandre@tse.jus.br>
>
> * crypto/asymmetric_keys/x509_cert_parser.c
>    - prepare x509 parser to load nist_secpp384r1
>
> * crypto/ecc_curve_defs.h
>    - add nist_p384 params
>
> * include/crypto/ecdh.h
>    - add ECC_CURVE_NIST_P384
>
> * include/linux/oid_registry.h
>    - reorder OID_id_ecdsa_with_sha1
>    - add OID_id_secp384r1
> ---
>   crypto/asymmetric_keys/x509_cert_parser.c |  3 +++
>   crypto/ecc_curve_defs.h                   | 32 +++++++++++++++++++++++
>   include/crypto/ecdh.h                     |  1 +
>   include/linux/oid_registry.h              |  3 ++-
>   4 files changed, 38 insertions(+), 1 deletion(-)
>
> diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
> index d6d72420307c..03535bd8b8ef 100644
> --- a/crypto/asymmetric_keys/x509_cert_parser.c
> +++ b/crypto/asymmetric_keys/x509_cert_parser.c
> @@ -512,6 +512,9 @@ int x509_extract_key_data(void *context, size_t hdrlen,
>   		case OID_id_prime256v1:
>   			ctx->cert->pub->pkey_algo = "ecdsa-nist-p256";
>   			break;
> +		case OID_id_secp384r1:
> +			ctx->cert->pub->pkey_algo = "ecdsa-nist-p384";
> +			break;
>   		default:
>   			return -ENOPKG;
>   		}
> diff --git a/crypto/ecc_curve_defs.h b/crypto/ecc_curve_defs.h
> index 69be6c7d228f..b327732f6ef5 100644
> --- a/crypto/ecc_curve_defs.h
> +++ b/crypto/ecc_curve_defs.h
> @@ -54,4 +54,36 @@ static struct ecc_curve nist_p256 = {
>   	.b = nist_p256_b
>   };
>   
> +/* NIST P-384 */
> +static u64 nist_p384_g_x[] = { 0x3A545E3872760AB7ull, 0x5502F25DBF55296Cull,
> +				0x59F741E082542A38ull, 0x6E1D3B628BA79B98ull,
> +				0x8Eb1C71EF320AD74ull, 0xAA87CA22BE8B0537ull };
> +static u64 nist_p384_g_y[] = { 0x7A431D7C90EA0E5Full, 0x0A60B1CE1D7E819Dull,
> +				0xE9DA3113B5F0B8C0ull, 0xF8F41DBD289A147Cull,
> +				0x5D9E98BF9292DC29ull, 0x3617DE4A96262C6Full };
> +static u64 nist_p384_p[] = { 0x00000000FFFFFFFFull, 0xFFFFFFFF00000000ull,
> +				0xFFFFFFFFFFFFFFFEull, 0xFFFFFFFFFFFFFFFFull,
> +				0xFFFFFFFFFFFFFFFFull, 0xFFFFFFFFFFFFFFFFull };
> +static u64 nist_p384_n[] = { 0xECEC196ACCC52973ull, 0x581A0DB248B0A77Aull,
> +				0xC7634D81F4372DDFull, 0xFFFFFFFFFFFFFFFFull,
> +				0xFFFFFFFFFFFFFFFFull, 0xFFFFFFFFFFFFFFFFull };
> +static u64 nist_p384_a[] = { 0x00000000FFFFFFFCull, 0xFFFFFFFF00000000ull,
> +				0xFFFFFFFFFFFFFFFEull, 0xFFFFFFFFFFFFFFFFull,
> +				0xFFFFFFFFFFFFFFFFull, 0xFFFFFFFFFFFFFFFFull };
> +static u64 nist_p384_b[] = { 0x2a85c8edd3ec2aefull, 0xc656398d8a2ed19dull,
> +				0x0314088f5013875aull, 0x181d9c6efe814112ull,
> +				0x988e056be3f82d19ull, 0xb3312fa7e23ee7e4ull };
> +static struct ecc_curve nist_p384 = {
> +	.name = "nist_384",
> +	.g = {
> +		.x = nist_p384_g_x,
> +		.y = nist_p384_g_y,
> +		.ndigits = 6,
> +	},
> +	.p = nist_p384_p,
> +	.n = nist_p384_n,
> +	.a = nist_p384_a,
> +	.b = nist_p384_b
> +};
> +
>   #endif
> diff --git a/include/crypto/ecdh.h b/include/crypto/ecdh.h
> index a5b805b5526d..e4ba1de961e4 100644
> --- a/include/crypto/ecdh.h
> +++ b/include/crypto/ecdh.h
> @@ -25,6 +25,7 @@
>   /* Curves IDs */
>   #define ECC_CURVE_NIST_P192	0x0001
>   #define ECC_CURVE_NIST_P256	0x0002
> +#define ECC_CURVE_NIST_P384	0x0003
>   
>   /**
>    * struct ecdh - define an ECDH private key
> diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
> index ff3cad9f8c1f..d656450dfc66 100644
> --- a/include/linux/oid_registry.h
> +++ b/include/linux/oid_registry.h
> @@ -19,10 +19,10 @@
>   enum OID {
>   	OID_id_dsa_with_sha1,		/* 1.2.840.10030.4.3 */
>   	OID_id_dsa,			/* 1.2.840.10040.4.1 */
> -	OID_id_ecdsa_with_sha1,		/* 1.2.840.10045.4.1 */
>   	OID_id_ecPublicKey,		/* 1.2.840.10045.2.1 */
>   	OID_id_prime192v1,		/* 1.2.840.10045.3.1.1 */
>   	OID_id_prime256v1,		/* 1.2.840.10045.3.1.7 */
> +	OID_id_ecdsa_with_sha1,		/* 1.2.840.10045.4.1 */
>   	OID_id_ecdsa_with_sha224,	/* 1.2.840.10045.4.3.1 */
>   	OID_id_ecdsa_with_sha256,	/* 1.2.840.10045.4.3.2 */
>   	OID_id_ecdsa_with_sha384,	/* 1.2.840.10045.4.3.3 */
> @@ -64,6 +64,7 @@ enum OID {
>   
>   	OID_certAuthInfoAccess,		/* 1.3.6.1.5.5.7.1.1 */
>   	OID_sha1,			/* 1.3.14.3.2.26 */
> +	OID_id_secp384r1,		/* 1.3.132.0.34 */
>   	OID_sha256,			/* 2.16.840.1.101.3.4.2.1 */
>   	OID_sha384,			/* 2.16.840.1.101.3.4.2.2 */
>   	OID_sha512,			/* 2.16.840.1.101.3.4.2.3 */


This patch looks good to me.

