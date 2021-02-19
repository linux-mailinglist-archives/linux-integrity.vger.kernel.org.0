Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22CE031FF5A
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Feb 2021 20:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbhBSTUR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Feb 2021 14:20:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26634 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229802AbhBSTUQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Feb 2021 14:20:16 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11JJ0hk9065298;
        Fri, 19 Feb 2021 14:19:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=CeZ0jRj1FyUWBTkmVPpSfJTkI1JE4D2goq432peUmyc=;
 b=rJW535s9z9CSq619mc/HV77ox1c44QtXaHAgmYflsIajl6MsgxuSCxHoEyVkkNez34YC
 CCjSiyRsvhyQ7refVdT1hgbCKtsjwWjg+jyriDLMKYbUkVpM3lw1WMTnoJEHqQhK8M9w
 wy1yTtMnru4017saN1mKd8sLOfjVQ7m8wYnK5Lq9ZiNizizhPEAvYy2nEhdNMY+SYGT1
 0KnSzew+mxqLQMCdi1ZLSJpZgYahax2LGQ5o5U+eHMmc77ADWKVtbDv4GImVyhGTW2KG
 9HrayRV1/l3Kgxudke2T9BWLPJ4+EGgqII+uQrmgz/R0Dk7IYILCAIZadGnMa9ZERh/E tg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36tju00v9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 14:19:17 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11JJ1J4R068422;
        Fri, 19 Feb 2021 14:19:17 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36tju00v92-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 14:19:16 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11JJHEsJ017683;
        Fri, 19 Feb 2021 19:19:16 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01dal.us.ibm.com with ESMTP id 36p6dabhm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 19:19:16 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11JJJEXO11927888
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 19:19:14 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F7A4BE051;
        Fri, 19 Feb 2021 19:19:14 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 155E5BE053;
        Fri, 19 Feb 2021 19:19:12 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 19 Feb 2021 19:19:12 +0000 (GMT)
Subject: Re: [PATCH 3/3] add nist_p384 register and unregister to support
 nist_p384
To:     Saulo Alessandre <saulo.alessandre@gmail.com>
Cc:     davem@davemloft.net, dhowells@redhat.com,
        herbert@gondor.apana.org.au, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        zohar@linux.ibm.com, Saulo Alessandre <saulo.alessandre@tse.jus.br>
References: <20210215162532.1077098-1-stefanb@linux.ibm.com>
 <20210219185759.1033764-1-saulo.alessandre@gmail.com>
 <20210219185759.1033764-3-saulo.alessandre@gmail.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <2da12f2a-6f26-502b-8402-bdf3e52abb7f@linux.ibm.com>
Date:   Fri, 19 Feb 2021 14:19:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210219185759.1033764-3-saulo.alessandre@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-19_08:2021-02-18,2021-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0
 adultscore=0 impostorscore=0 mlxlogscore=999 clxscore=1011 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190144
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/19/21 1:57 PM, Saulo Alessandre wrote:
> From: Saulo Alessandre <saulo.alessandre@tse.jus.br>
>
> * crypto/ecdsa.c
>    - add ecdsa_nist_p384_init_tfm
>    - register and unregister p384 tfm
>
> * crypto/testmgr.c
>    - add test vector for p384 on vector of tests
>
> * crypto/testmgr.h
>    - add test vector params for p384(sha1, sha224, sha256, sha384 and sha512)
> ---
>   crypto/asymmetric_keys/x509_cert_parser.c |   2 +-
>   crypto/ecc.c                              |   2 +-
>   crypto/ecc.h                              |   2 +-
>   crypto/ecdsa.c                            |  46 +++++--
>   crypto/testmgr.c                          |   6 +
>   crypto/testmgr.h                          | 157 ++++++++++++++++++++++
>   6 files changed, 204 insertions(+), 11 deletions(-)
>
> diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
> index 03535bd8b8ef..1d94c23e9678 100644
> --- a/crypto/asymmetric_keys/x509_cert_parser.c
> +++ b/crypto/asymmetric_keys/x509_cert_parser.c
> @@ -278,7 +278,7 @@ int x509_note_pkey_algo(void *context, size_t hdrlen,
>   ecdsa:
>   	ctx->cert->sig->pkey_algo = "ecdsa";
>   	ctx->cert->sig->encoding = "x962";
> -        pr_info("Found stephan %s(%s) X509 certificate\n", ctx->cert->sig->pkey_algo,
> +	pr_info("Found %s(%s) X509 certificate\n", ctx->cert->sig->pkey_algo,
>   		ctx->cert->sig->hash_algo);


This patch doesn't apply on my tree because of this change.


>   	ctx->algo_oid = ctx->last_oid;
>   	return 0;
> diff --git a/crypto/ecc.c b/crypto/ecc.c
> index aab57dcf26c6..0f41ccc10ceb 100644
> --- a/crypto/ecc.c
> +++ b/crypto/ecc.c
> @@ -904,7 +904,7 @@ static bool vli_mmod_fast(u64 *result, u64 *product,
>   	const unsigned int ndigits = curve->g.ndigits;
>   
>   	/* Currently, all NIST have name nist_.* */
> -	if (strncmp(curve->name, "nist_", 5) != 0) {
> +	if (curve && curve->name && strncmp(curve->name, "nist_", 5) != 0) {


Can you actually call this function with curve = NULL? You already 
accessed 'curve' above by ndigits = curve->g.ndigits , so if that check 
was necessary it's too late to avoid a NULL pointer exception.


>   		/* Try to handle Pseudo-Marsenne primes. */
>   		if (curve_prime[ndigits - 1] == -1ull) {
>   			vli_mmod_special(result, product, curve_prime,
> diff --git a/crypto/ecc.h b/crypto/ecc.h
> index 861de67b538f..9a668594012b 100644
> --- a/crypto/ecc.h
> +++ b/crypto/ecc.h
> @@ -30,7 +30,7 @@
>   #define ECC_CURVE_NIST_P192_DIGITS  3
>   #define ECC_CURVE_NIST_P256_DIGITS  4
>   #define ECC_CURVE_NIST_P384_DIGITS  6
> -#define ECC_MAX_DIGITS              (ECC_CURVE_NIST_P384_DIGITS)
> +#define ECC_MAX_DIGITS				(512/64)
>   
>   #define ECC_DIGITS_TO_BYTES_SHIFT 3
>   
> diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
> index 4b45230276b3..4dfbf8f32a0b 100644
> --- a/crypto/ecdsa.c
> +++ b/crypto/ecdsa.c
> @@ -101,7 +101,7 @@ int ecdsa_get_signature_r(void *context, size_t hdrlen, unsigned char tag,
>   	struct ecdsa_signature_ctx *sig = context;
>   
>   	return ecdsa_get_signature_rs(sig->r, hdrlen, tag, value, vlen,
> -				      sig->curve->g.ndigits);
> +					sig->curve->g.ndigits);


I don't think this reformatting and the ones below are necessary here.



>   }
>   
>   int ecdsa_get_signature_s(void *context, size_t hdrlen, unsigned char tag,
> @@ -110,7 +110,7 @@ int ecdsa_get_signature_s(void *context, size_t hdrlen, unsigned char tag,
>   	struct ecdsa_signature_ctx *sig = context;
>   
>   	return ecdsa_get_signature_rs(sig->s, hdrlen, tag, value, vlen,
> -				      sig->curve->g.ndigits);
> +					sig->curve->g.ndigits);
>   }
>   
>   static int _ecdsa_verify(struct ecc_ctx *ctx, const u64 *hash,
> @@ -127,7 +127,7 @@ static int _ecdsa_verify(struct ecc_ctx *ctx, const u64 *hash,
>   
>   	/* 0 < r < n  and 0 < s < n */
>   	if (vli_is_zero(r, ndigits) || vli_cmp(r, curve->n, ndigits) >= 0 ||
> -	    vli_is_zero(s, ndigits) || vli_cmp(s, curve->n, ndigits) >= 0)
> +		vli_is_zero(s, ndigits) || vli_cmp(s, curve->n, ndigits) >= 0)
>   		return -EBADMSG;
>   
>   	/* hash is given */
> @@ -183,7 +183,7 @@ static int ecdsa_verify(struct akcipher_request *req)
>   		buffer, req->src_len + req->dst_len, 0);
>   
>   	ret = asn1_ber_decoder(&ecdsasignature_decoder, &sig_ctx,
> -			       buffer, req->src_len);
> +					buffer, req->src_len);
>   	if (ret < 0)
>   		goto error;
>   
> @@ -233,17 +233,19 @@ static int ecdsa_ecc_ctx_reset(struct ecc_ctx *ctx)
>   	ret = ecdsa_ecc_ctx_init(ctx, curve_id);
>   	if (ret == 0)
>   		ctx->pub_key = ECC_POINT_INIT(ctx->x, ctx->y,
> -					      ctx->curve->g.ndigits);
> +					ctx->curve->g.ndigits);
>   	return ret;
>   }
>   
> +#define UNPACKED_KEY_ID 0x04
> +
>   /*
>    * Set the public key given the raw uncompressed key data from an X509
>    * certificate. The key data contain the concatenated X and Y coordinates of
>    * the public key.
>    */
>   static int ecdsa_set_pub_key(struct crypto_akcipher *tfm,
> -			     const void *key, unsigned int keylen)
> +				const void *key, unsigned int keylen)


I don't that's necessary here.


>   {
>   	struct ecc_ctx *ctx = akcipher_tfm_ctx(tfm);
>   	const unsigned char *d = key;
> @@ -258,7 +260,7 @@ static int ecdsa_set_pub_key(struct crypto_akcipher *tfm,
>   	if (keylen < 1 || (((keylen - 1) >> 1) % sizeof(u64)) != 0)
>   		return -EINVAL;
>   	/* we only accept uncompressed format */
> -	if (d[0] != 4)
> +	if (d[0] != UNPACKED_KEY_ID)
>   		return -EINVAL;


I should probably introduce a constant in my v8 then.


>   
>   	keylen--;
> @@ -289,6 +291,28 @@ static unsigned int ecdsa_max_size(struct crypto_akcipher *tfm)
>   	return ctx->pub_key.ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
>   }
>   
> +static int ecdsa_nist_p384_init_tfm(struct crypto_akcipher *tfm)
> +{
> +	struct ecc_ctx *ctx = akcipher_tfm_ctx(tfm);
> +
> +	return ecdsa_ecc_ctx_init(ctx, ECC_CURVE_NIST_P384);
> +}
> +
> +static struct akcipher_alg ecdsa_nist_p384 = {
> +	.verify = ecdsa_verify,
> +	.set_pub_key = ecdsa_set_pub_key,
> +	.max_size = ecdsa_max_size,
> +	.init = ecdsa_nist_p384_init_tfm,
> +	.exit = ecdsa_exit_tfm,
> +	.base = {
> +		.cra_name = "ecdsa-nist-p384",
> +		.cra_driver_name = "ecdsa-nist-p384-generic",
> +		.cra_priority = 100,
> +		.cra_module = THIS_MODULE,
> +		.cra_ctxsize = sizeof(struct ecc_ctx),
> +	},
> +};
> +
>   static int ecdsa_nist_p256_init_tfm(struct crypto_akcipher *tfm)
>   {
>   	struct ecc_ctx *ctx = akcipher_tfm_ctx(tfm);
> @@ -342,7 +366,12 @@ static int ecdsa_init(void)
>   	ret = crypto_register_akcipher(&ecdsa_nist_p192);
>   	ecdsa_nist_p192_registered = ret == 0;
>   
> -	return crypto_register_akcipher(&ecdsa_nist_p256);
> +	ret = crypto_register_akcipher(&ecdsa_nist_p256);
> +	if (ret != 0)
> +		return ret;

There is an existing bug in my v8. I have to unregister nist_p192 if 
nist_p256 registration fails. Let me fix this in a V9.


