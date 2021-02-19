Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F206931FF6D
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Feb 2021 20:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhBST2n (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 19 Feb 2021 14:28:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26200 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229555AbhBST2l (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 19 Feb 2021 14:28:41 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 11JJ0hom065295;
        Fri, 19 Feb 2021 14:27:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=eqo/M5DfxnsyCBSyZ+Wo8jMbXSqRE9UAwhJSpQfojgE=;
 b=dRSJGuft6Jfx7ob9rjMfvqYWU5eT6rksCMIQoEVSfDIdxr+uYmWj+zV5pFTJEeyPdrMg
 kik6sqlKLR+yiNm8h9WmPROEf2qyG3aUKj4OJSCTXSq/nZ9uOiMgdc0IDIRLfb0a/Drv
 pO+LJa22IuXa8zzGLSAb5IWq4/Dfc8/0ldP4wN9tpk+XoLAeGxA/Kh/CD+KomRY0J7S1
 GYpj6EeiW3fL1DG+mlQ2/60NKB0DWaZT6I0zcy5Nd5ybtsSuQ5LY9J6oKkcViWppCQrE
 3QvDddPHLdGjMjena4j0C7mEdV7nDajYDTkrCFnYCSuT+DNHsFAbqs6rTqPNBmZ3Oj2Y fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36tju012bb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 14:27:48 -0500
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 11JJ1J4b068422;
        Fri, 19 Feb 2021 14:27:48 -0500
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0b-001b2d01.pphosted.com with ESMTP id 36tju012b4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 14:27:48 -0500
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11JJRlpD027722;
        Fri, 19 Feb 2021 19:27:47 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma05wdc.us.ibm.com with ESMTP id 36p6d9yn3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Feb 2021 19:27:47 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11JJRkwU38666748
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Feb 2021 19:27:47 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8302BE053;
        Fri, 19 Feb 2021 19:27:46 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31F8EBE04F;
        Fri, 19 Feb 2021 19:27:46 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 19 Feb 2021 19:27:46 +0000 (GMT)
Subject: Re: [PATCH 2/3] add mathematic to support fast nist_p384 and change
 routines to pass forward ecc_curve
To:     Saulo Alessandre <saulo.alessandre@gmail.com>
Cc:     davem@davemloft.net, dhowells@redhat.com,
        herbert@gondor.apana.org.au, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        zohar@linux.ibm.com, Saulo Alessandre <saulo.alessandre@tse.jus.br>
References: <20210215162532.1077098-1-stefanb@linux.ibm.com>
 <20210219185759.1033764-1-saulo.alessandre@gmail.com>
 <20210219185759.1033764-2-saulo.alessandre@gmail.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <33af3417-7912-8343-bd90-c85287165c0f@linux.ibm.com>
Date:   Fri, 19 Feb 2021 14:27:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210219185759.1033764-2-saulo.alessandre@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-19_08:2021-02-18,2021-02-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0
 adultscore=0 impostorscore=0 mlxlogscore=999 clxscore=1015 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102190144
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/19/21 1:57 PM, Saulo Alessandre wrote:
> From: Saulo Alessandre <saulo.alessandre@tse.jus.br>
>
> * crypto/ecc.c
>    - change ecc_get_curve to accept nist_p384
>    - add vli_mmod_fast_384
>    - change some routines to pass ecc_curve forward until vli_mmod_fast
>
> * crypto/ecc.h
>    - add ECC_CURVE_NIST_P384_DIGITS
>    - change ECC_MAX_DIGITS to P384 size
> ---
>   crypto/ecc.c | 282 ++++++++++++++++++++++++++++++++++++---------------
>   crypto/ecc.h |   3 +-
>   2 files changed, 203 insertions(+), 82 deletions(-)
>
> diff --git a/crypto/ecc.c b/crypto/ecc.c
> index 25e79fd70566..aab57dcf26c6 100644
> --- a/crypto/ecc.c
> +++ b/crypto/ecc.c
> @@ -50,6 +50,8 @@ const struct ecc_curve *ecc_get_curve(unsigned int curve_id)
>   		return fips_enabled ? NULL : &nist_p192;
>   	case ECC_CURVE_NIST_P256:
>   		return &nist_p256;
> +	case ECC_CURVE_NIST_P384:
> +		return &nist_p384;
>   	default:
>   		return NULL;
>   	}
> @@ -776,18 +778,133 @@ static void vli_mmod_fast_256(u64 *result, const u64 *product,
>   	}
>   }
>   
> +#define SL32OR32(x32, y32) (((u64)x32 << 32) | y32)
> +#define AND64H(x64)  (x64 & 0xffFFffFF00000000ull)
> +#define AND64L(x64)  (x64 & 0x00000000ffFFffFFull)
> +
> +/* Computes result = product % curve_prime
> + * from "Mathematical routines for the NIST prime elliptic curves"
> + */
> +static void vli_mmod_fast_384(u64 *result, const u64 *product,
> +				const u64 *curve_prime, u64 *tmp)
> +{
> +	int carry;
> +	const unsigned int ndigits = 6;
> +
> +	/* t */
> +	vli_set(result, product, ndigits);
> +
> +	/* s1 */
> +	tmp[0] = 0;		// 0 || 0
> +	tmp[1] = 0;		// 0 || 0
> +	tmp[2] = SL32OR32(product[11], (product[10]>>32));	//a22||a21
> +	tmp[3] = product[11]>>32;	// 0 ||a23
> +	tmp[4] = 0;		// 0 || 0
> +	tmp[5] = 0;		// 0 || 0
> +	carry = vli_lshift(tmp, tmp, 1, ndigits);
> +	carry += vli_add(result, result, tmp, ndigits);
> +
> +	/* s2 */
> +	tmp[0] = product[6];	//a13||a12
> +	tmp[1] = product[7];	//a15||a14
> +	tmp[2] = product[8];	//a17||a16
> +	tmp[3] = product[9];	//a19||a18
> +	tmp[4] = product[10];	//a21||a20
> +	tmp[5] = product[11];	//a23||a22
> +	carry += vli_add(result, result, tmp, ndigits);
> +
> +	/* s3 */
> +	tmp[0] = SL32OR32(product[11], (product[10]>>32));	//a22||a21
> +	tmp[1] = SL32OR32(product[6], (product[11]>>32));	//a12||a23
> +	tmp[2] = SL32OR32(product[7], (product[6])>>32);	//a14||a13
> +	tmp[3] = SL32OR32(product[8], (product[7]>>32));	//a16||a15
> +	tmp[4] = SL32OR32(product[9], (product[8]>>32));	//a18||a17
> +	tmp[5] = SL32OR32(product[10], (product[9]>>32));	//a20||a19
> +	carry += vli_add(result, result, tmp, ndigits);
> +
> +	/* s4 */
> +	tmp[0] = AND64H(product[11]);	//a23|| 0
> +	tmp[1] = (product[10]<<32); 	//a20|| 0
> +	tmp[2] = product[6];	//a13||a12
> +	tmp[3] = product[7];	//a15||a14
> +	tmp[4] = product[8];	//a17||a16
> +	tmp[5] = product[9];	//a19||a18
> +	carry += vli_add(result, result, tmp, ndigits);
> +
> +	/* s5 */
> +	tmp[0] = 0;		//  0|| 0
> +	tmp[1] = 0;		//  0|| 0
> +	tmp[2] = product[10];	//a21||a20
> +	tmp[3] = product[11];	//a23||a22
> +	tmp[4] = 0;		//  0|| 0
> +	tmp[5] = 0;		//  0|| 0
> +	carry += vli_add(result, result, tmp, ndigits);
> +
> +	/* s6 */
> +	tmp[0] = AND64L(product[10]);	// 0 ||a20
> +	tmp[1] = AND64H(product[10]);	//a21|| 0
> +	tmp[2] = product[11];	//a23||a22
> +	tmp[3] = 0;		// 0 || 0
> +	tmp[4] = 0;		// 0 || 0
> +	tmp[5] = 0;		// 0 || 0
> +	carry += vli_add(result, result, tmp, ndigits);
> +
> +	/* d1 */
> +	tmp[0] = SL32OR32(product[6], (product[11]>>32));	//a12||a23
> +	tmp[1] = SL32OR32(product[7], (product[6]>>32));	//a14||a13
> +	tmp[2] = SL32OR32(product[8], (product[7]>>32));	//a16||a15
> +	tmp[3] = SL32OR32(product[9], (product[8]>>32));	//a18||a17
> +	tmp[4] = SL32OR32(product[10], (product[9]>>32));	//a20||a19
> +	tmp[5] = SL32OR32(product[11], (product[10]>>32));	//a22||a21
> +	carry -= vli_sub(result, result, tmp, ndigits);
> +
> +	/* d2 */
> +	tmp[0] = (product[10]<<32);	//a20|| 0
> +	tmp[1] = SL32OR32(product[11], (product[10]>>32));	//a22||a21
> +	tmp[2] = (product[11]>>32);	// 0 ||a23
> +	tmp[3] = 0;		// 0 || 0
> +	tmp[4] = 0;		// 0 || 0
> +	tmp[5] = 0;		// 0 || 0
> +	carry -= vli_sub(result, result, tmp, ndigits);
> +
> +	/* d3 */
> +	tmp[0] = 0;		// 0 || 0
> +	tmp[1] = AND64H(product[11]);	//a23|| 0
> +	tmp[2] = product[11]>>32;	// 0 ||a23
> +	tmp[3] = 0;		// 0 || 0
> +	tmp[4] = 0;		// 0 || 0
> +	tmp[5] = 0;		// 0 || 0
> +	carry -= vli_sub(result, result, tmp, ndigits);
> +
> +	if (carry < 0) {
> +		do {
> +			carry += vli_add(result, result, curve_prime, ndigits);
> +		} while (carry < 0);
> +	} else {
> +		while (carry || vli_cmp(curve_prime, result, ndigits) != 1)
> +			carry -= vli_sub(result, result, curve_prime, ndigits);
> +	}
> +
> +}
> +
> +#undef SL32OR32
> +#undef AND64H
> +#undef AND64L
> +
>   /* Computes result = product % curve_prime for different curve_primes.
>    *
>    * Note that curve_primes are distinguished just by heuristic check and
>    * not by complete conformance check.
>    */
>   static bool vli_mmod_fast(u64 *result, u64 *product,
> -			  const u64 *curve_prime, unsigned int ndigits)
> +			const struct ecc_curve *curve)


I think for NIST P384 we should be able to keep the function signature 
as-is. For NIST p521 it may be necessary to change it and also introduce 
nbits because ndigits is too coarse for it in *some places*.


>   {
>   	u64 tmp[2 * ECC_MAX_DIGITS];
> +	const u64 *curve_prime = curve->p;
> +	const unsigned int ndigits = curve->g.ndigits;
>   
> -	/* Currently, both NIST primes have -1 in lowest qword. */
> -	if (curve_prime[0] != -1ull) {
> +	/* Currently, all NIST have name nist_.* */
> +	if (strncmp(curve->name, "nist_", 5) != 0) {
>   		/* Try to handle Pseudo-Marsenne primes. */
>   		if (curve_prime[ndigits - 1] == -1ull) {
>   			vli_mmod_special(result, product, curve_prime,
> @@ -810,6 +927,9 @@ static bool vli_mmod_fast(u64 *result, u64 *product,
>   	case 4:
>   		vli_mmod_fast_256(result, product, curve_prime, tmp);
>   		break;
> +	case 6:
> +		vli_mmod_fast_384(result, product, curve_prime, tmp);
> +		break;
>   	default:
>   		pr_err_ratelimited("ecc: unsupported digits size!\n");
>   		return false;
> @@ -833,22 +953,22 @@ EXPORT_SYMBOL(vli_mod_mult_slow);
>   
>   /* Computes result = (left * right) % curve_prime. */
>   static void vli_mod_mult_fast(u64 *result, const u64 *left, const u64 *right,
> -			      const u64 *curve_prime, unsigned int ndigits)
> +				const struct ecc_curve *curve)
>   {
>   	u64 product[2 * ECC_MAX_DIGITS];
>   
> -	vli_mult(product, left, right, ndigits);
> -	vli_mmod_fast(result, product, curve_prime, ndigits);
> +	vli_mult(product, left, right, curve->g.ndigits);
> +	vli_mmod_fast(result, product, curve);
>   }
>   
>   /* Computes result = left^2 % curve_prime. */
>   static void vli_mod_square_fast(u64 *result, const u64 *left,
> -				const u64 *curve_prime, unsigned int ndigits)
> +				const struct ecc_curve *curve)
>   {
>   	u64 product[2 * ECC_MAX_DIGITS];
>   
> -	vli_square(product, left, ndigits);
> -	vli_mmod_fast(result, product, curve_prime, ndigits);
> +	vli_square(product, left, curve->g.ndigits);
> +	vli_mmod_fast(result, product, curve);
>   }
>   
>   #define EVEN(vli) (!(vli[0] & 1))
> @@ -946,25 +1066,27 @@ static bool ecc_point_is_zero(const struct ecc_point *point)
>   
>   /* Double in place */
>   static void ecc_point_double_jacobian(u64 *x1, u64 *y1, u64 *z1,
> -				      u64 *curve_prime, unsigned int ndigits)
> +					const struct ecc_curve *curve)
>   {
>   	/* t1 = x, t2 = y, t3 = z */
>   	u64 t4[ECC_MAX_DIGITS];
>   	u64 t5[ECC_MAX_DIGITS];
> +	const u64 *curve_prime = curve->p;
> +	const unsigned int ndigits = curve->g.ndigits;
>   
>   	if (vli_is_zero(z1, ndigits))
>   		return;
>   
>   	/* t4 = y1^2 */
> -	vli_mod_square_fast(t4, y1, curve_prime, ndigits);
> +	vli_mod_square_fast(t4, y1, curve);
>   	/* t5 = x1*y1^2 = A */
> -	vli_mod_mult_fast(t5, x1, t4, curve_prime, ndigits);
> +	vli_mod_mult_fast(t5, x1, t4, curve);
>   	/* t4 = y1^4 */
> -	vli_mod_square_fast(t4, t4, curve_prime, ndigits);
> +	vli_mod_square_fast(t4, t4, curve);
>   	/* t2 = y1*z1 = z3 */
> -	vli_mod_mult_fast(y1, y1, z1, curve_prime, ndigits);
> +	vli_mod_mult_fast(y1, y1, z1, curve);
>   	/* t3 = z1^2 */
> -	vli_mod_square_fast(z1, z1, curve_prime, ndigits);
> +	vli_mod_square_fast(z1, z1, curve);
>   
>   	/* t1 = x1 + z1^2 */
>   	vli_mod_add(x1, x1, z1, curve_prime, ndigits);
> @@ -973,7 +1095,7 @@ static void ecc_point_double_jacobian(u64 *x1, u64 *y1, u64 *z1,
>   	/* t3 = x1 - z1^2 */
>   	vli_mod_sub(z1, x1, z1, curve_prime, ndigits);
>   	/* t1 = x1^2 - z1^4 */
> -	vli_mod_mult_fast(x1, x1, z1, curve_prime, ndigits);
> +	vli_mod_mult_fast(x1, x1, z1, curve);
>   
>   	/* t3 = 2*(x1^2 - z1^4) */
>   	vli_mod_add(z1, x1, x1, curve_prime, ndigits);
> @@ -990,7 +1112,7 @@ static void ecc_point_double_jacobian(u64 *x1, u64 *y1, u64 *z1,
>   	/* t1 = 3/2*(x1^2 - z1^4) = B */
>   
>   	/* t3 = B^2 */
> -	vli_mod_square_fast(z1, x1, curve_prime, ndigits);
> +	vli_mod_square_fast(z1, x1, curve);
>   	/* t3 = B^2 - A */
>   	vli_mod_sub(z1, z1, t5, curve_prime, ndigits);
>   	/* t3 = B^2 - 2A = x3 */
> @@ -998,7 +1120,7 @@ static void ecc_point_double_jacobian(u64 *x1, u64 *y1, u64 *z1,
>   	/* t5 = A - x3 */
>   	vli_mod_sub(t5, t5, z1, curve_prime, ndigits);
>   	/* t1 = B * (A - x3) */
> -	vli_mod_mult_fast(x1, x1, t5, curve_prime, ndigits);
> +	vli_mod_mult_fast(x1, x1, t5, curve);
>   	/* t4 = B * (A - x3) - y1^4 = y3 */
>   	vli_mod_sub(t4, x1, t4, curve_prime, ndigits);
>   
> @@ -1008,23 +1130,22 @@ static void ecc_point_double_jacobian(u64 *x1, u64 *y1, u64 *z1,
>   }
>   
>   /* Modify (x1, y1) => (x1 * z^2, y1 * z^3) */
> -static void apply_z(u64 *x1, u64 *y1, u64 *z, u64 *curve_prime,
> -		    unsigned int ndigits)
> +static void apply_z(u64 *x1, u64 *y1, u64 *z, const struct ecc_curve *curve)
>   {
>   	u64 t1[ECC_MAX_DIGITS];
>   
> -	vli_mod_square_fast(t1, z, curve_prime, ndigits);    /* z^2 */
> -	vli_mod_mult_fast(x1, x1, t1, curve_prime, ndigits); /* x1 * z^2 */
> -	vli_mod_mult_fast(t1, t1, z, curve_prime, ndigits);  /* z^3 */
> -	vli_mod_mult_fast(y1, y1, t1, curve_prime, ndigits); /* y1 * z^3 */
> +	vli_mod_square_fast(t1, z, curve);		/* z^2 */
> +	vli_mod_mult_fast(x1, x1, t1, curve);	/* x1 * z^2 */
> +	vli_mod_mult_fast(t1, t1, z, curve);	/* z^3 */
> +	vli_mod_mult_fast(y1, y1, t1, curve);	/* y1 * z^3 */
>   }
>   
>   /* P = (x1, y1) => 2P, (x2, y2) => P' */
>   static void xycz_initial_double(u64 *x1, u64 *y1, u64 *x2, u64 *y2,
> -				u64 *p_initial_z, u64 *curve_prime,
> -				unsigned int ndigits)
> +				u64 *p_initial_z, const struct ecc_curve *curve)
>   {
>   	u64 z[ECC_MAX_DIGITS];
> +	const unsigned int ndigits = curve->g.ndigits;
>   
>   	vli_set(x2, x1, ndigits);
>   	vli_set(y2, y1, ndigits);
> @@ -1035,35 +1156,37 @@ static void xycz_initial_double(u64 *x1, u64 *y1, u64 *x2, u64 *y2,
>   	if (p_initial_z)
>   		vli_set(z, p_initial_z, ndigits);
>   
> -	apply_z(x1, y1, z, curve_prime, ndigits);
> +	apply_z(x1, y1, z, curve);
>   
> -	ecc_point_double_jacobian(x1, y1, z, curve_prime, ndigits);
> +	ecc_point_double_jacobian(x1, y1, z, curve);
>   
> -	apply_z(x2, y2, z, curve_prime, ndigits);
> +	apply_z(x2, y2, z, curve);
>   }
>   
>   /* Input P = (x1, y1, Z), Q = (x2, y2, Z)
>    * Output P' = (x1', y1', Z3), P + Q = (x3, y3, Z3)
>    * or P => P', Q => P + Q
>    */
> -static void xycz_add(u64 *x1, u64 *y1, u64 *x2, u64 *y2, u64 *curve_prime,
> -		     unsigned int ndigits)
> +static void xycz_add(u64 *x1, u64 *y1, u64 *x2, u64 *y2,
> +			const struct ecc_curve *curve)
>   {
>   	/* t1 = X1, t2 = Y1, t3 = X2, t4 = Y2 */
>   	u64 t5[ECC_MAX_DIGITS];
> +	const u64 *curve_prime = curve->p;
> +	const unsigned int ndigits = curve->g.ndigits;
>   
>   	/* t5 = x2 - x1 */
>   	vli_mod_sub(t5, x2, x1, curve_prime, ndigits);
>   	/* t5 = (x2 - x1)^2 = A */
> -	vli_mod_square_fast(t5, t5, curve_prime, ndigits);
> +	vli_mod_square_fast(t5, t5, curve);
>   	/* t1 = x1*A = B */
> -	vli_mod_mult_fast(x1, x1, t5, curve_prime, ndigits);
> +	vli_mod_mult_fast(x1, x1, t5, curve);
>   	/* t3 = x2*A = C */
> -	vli_mod_mult_fast(x2, x2, t5, curve_prime, ndigits);
> +	vli_mod_mult_fast(x2, x2, t5, curve);
>   	/* t4 = y2 - y1 */
>   	vli_mod_sub(y2, y2, y1, curve_prime, ndigits);
>   	/* t5 = (y2 - y1)^2 = D */
> -	vli_mod_square_fast(t5, y2, curve_prime, ndigits);
> +	vli_mod_square_fast(t5, y2, curve);
>   
>   	/* t5 = D - B */
>   	vli_mod_sub(t5, t5, x1, curve_prime, ndigits);
> @@ -1072,11 +1195,11 @@ static void xycz_add(u64 *x1, u64 *y1, u64 *x2, u64 *y2, u64 *curve_prime,
>   	/* t3 = C - B */
>   	vli_mod_sub(x2, x2, x1, curve_prime, ndigits);
>   	/* t2 = y1*(C - B) */
> -	vli_mod_mult_fast(y1, y1, x2, curve_prime, ndigits);
> +	vli_mod_mult_fast(y1, y1, x2, curve);
>   	/* t3 = B - x3 */
>   	vli_mod_sub(x2, x1, t5, curve_prime, ndigits);
>   	/* t4 = (y2 - y1)*(B - x3) */
> -	vli_mod_mult_fast(y2, y2, x2, curve_prime, ndigits);
> +	vli_mod_mult_fast(y2, y2, x2, curve);
>   	/* t4 = y3 */
>   	vli_mod_sub(y2, y2, y1, curve_prime, ndigits);
>   
> @@ -1087,22 +1210,24 @@ static void xycz_add(u64 *x1, u64 *y1, u64 *x2, u64 *y2, u64 *curve_prime,
>    * Output P + Q = (x3, y3, Z3), P - Q = (x3', y3', Z3)
>    * or P => P - Q, Q => P + Q
>    */
> -static void xycz_add_c(u64 *x1, u64 *y1, u64 *x2, u64 *y2, u64 *curve_prime,
> -		       unsigned int ndigits)
> +static void xycz_add_c(u64 *x1, u64 *y1, u64 *x2, u64 *y2,
> +			const struct ecc_curve *curve)
>   {
>   	/* t1 = X1, t2 = Y1, t3 = X2, t4 = Y2 */
>   	u64 t5[ECC_MAX_DIGITS];
>   	u64 t6[ECC_MAX_DIGITS];
>   	u64 t7[ECC_MAX_DIGITS];
> +	const u64 *curve_prime = curve->p;
> +	const unsigned int ndigits = curve->g.ndigits;
>   
>   	/* t5 = x2 - x1 */
>   	vli_mod_sub(t5, x2, x1, curve_prime, ndigits);
>   	/* t5 = (x2 - x1)^2 = A */
> -	vli_mod_square_fast(t5, t5, curve_prime, ndigits);
> +	vli_mod_square_fast(t5, t5, curve);
>   	/* t1 = x1*A = B */
> -	vli_mod_mult_fast(x1, x1, t5, curve_prime, ndigits);
> +	vli_mod_mult_fast(x1, x1, t5, curve);
>   	/* t3 = x2*A = C */
> -	vli_mod_mult_fast(x2, x2, t5, curve_prime, ndigits);
> +	vli_mod_mult_fast(x2, x2, t5, curve);
>   	/* t4 = y2 + y1 */
>   	vli_mod_add(t5, y2, y1, curve_prime, ndigits);
>   	/* t4 = y2 - y1 */
> @@ -1111,29 +1236,29 @@ static void xycz_add_c(u64 *x1, u64 *y1, u64 *x2, u64 *y2, u64 *curve_prime,
>   	/* t6 = C - B */
>   	vli_mod_sub(t6, x2, x1, curve_prime, ndigits);
>   	/* t2 = y1 * (C - B) */
> -	vli_mod_mult_fast(y1, y1, t6, curve_prime, ndigits);
> +	vli_mod_mult_fast(y1, y1, t6, curve);
>   	/* t6 = B + C */
>   	vli_mod_add(t6, x1, x2, curve_prime, ndigits);
>   	/* t3 = (y2 - y1)^2 */
> -	vli_mod_square_fast(x2, y2, curve_prime, ndigits);
> +	vli_mod_square_fast(x2, y2, curve);
>   	/* t3 = x3 */
>   	vli_mod_sub(x2, x2, t6, curve_prime, ndigits);
>   
>   	/* t7 = B - x3 */
>   	vli_mod_sub(t7, x1, x2, curve_prime, ndigits);
>   	/* t4 = (y2 - y1)*(B - x3) */
> -	vli_mod_mult_fast(y2, y2, t7, curve_prime, ndigits);
> +	vli_mod_mult_fast(y2, y2, t7, curve);
>   	/* t4 = y3 */
>   	vli_mod_sub(y2, y2, y1, curve_prime, ndigits);
>   
>   	/* t7 = (y2 + y1)^2 = F */
> -	vli_mod_square_fast(t7, t5, curve_prime, ndigits);
> +	vli_mod_square_fast(t7, t5, curve);
>   	/* t7 = x3' */
>   	vli_mod_sub(t7, t7, t6, curve_prime, ndigits);
>   	/* t6 = x3' - B */
>   	vli_mod_sub(t6, t7, x1, curve_prime, ndigits);
>   	/* t6 = (y2 + y1)*(x3' - B) */
> -	vli_mod_mult_fast(t6, t6, t5, curve_prime, ndigits);
> +	vli_mod_mult_fast(t6, t6, t5, curve);
>   	/* t2 = y3' */
>   	vli_mod_sub(y1, t6, y1, curve_prime, ndigits);
>   
> @@ -1163,41 +1288,37 @@ static void ecc_point_mult(struct ecc_point *result,
>   	vli_set(rx[1], point->x, ndigits);
>   	vli_set(ry[1], point->y, ndigits);
>   
> -	xycz_initial_double(rx[1], ry[1], rx[0], ry[0], initial_z, curve_prime,
> -			    ndigits);
> +	xycz_initial_double(rx[1], ry[1], rx[0], ry[0], initial_z, curve);
>   
>   	for (i = num_bits - 2; i > 0; i--) {
>   		nb = !vli_test_bit(scalar, i);
> -		xycz_add_c(rx[1 - nb], ry[1 - nb], rx[nb], ry[nb], curve_prime,
> -			   ndigits);
> -		xycz_add(rx[nb], ry[nb], rx[1 - nb], ry[1 - nb], curve_prime,
> -			 ndigits);
> +		xycz_add_c(rx[1 - nb], ry[1 - nb], rx[nb], ry[nb], curve);
> +		xycz_add(rx[nb], ry[nb], rx[1 - nb], ry[1 - nb], curve);
>   	}
>   
>   	nb = !vli_test_bit(scalar, 0);
> -	xycz_add_c(rx[1 - nb], ry[1 - nb], rx[nb], ry[nb], curve_prime,
> -		   ndigits);
> +	xycz_add_c(rx[1 - nb], ry[1 - nb], rx[nb], ry[nb], curve);
>   
>   	/* Find final 1/Z value. */
>   	/* X1 - X0 */
>   	vli_mod_sub(z, rx[1], rx[0], curve_prime, ndigits);
>   	/* Yb * (X1 - X0) */
> -	vli_mod_mult_fast(z, z, ry[1 - nb], curve_prime, ndigits);
> +	vli_mod_mult_fast(z, z, ry[1 - nb], curve);
>   	/* xP * Yb * (X1 - X0) */
> -	vli_mod_mult_fast(z, z, point->x, curve_prime, ndigits);
> +	vli_mod_mult_fast(z, z, point->x, curve);
>   
>   	/* 1 / (xP * Yb * (X1 - X0)) */
>   	vli_mod_inv(z, z, curve_prime, point->ndigits);
>   
>   	/* yP / (xP * Yb * (X1 - X0)) */
> -	vli_mod_mult_fast(z, z, point->y, curve_prime, ndigits);
> +	vli_mod_mult_fast(z, z, point->y, curve);
>   	/* Xb * yP / (xP * Yb * (X1 - X0)) */
> -	vli_mod_mult_fast(z, z, rx[1 - nb], curve_prime, ndigits);
> +	vli_mod_mult_fast(z, z, rx[1 - nb], curve);
>   	/* End 1/Z calculation */
>   
> -	xycz_add(rx[nb], ry[nb], rx[1 - nb], ry[1 - nb], curve_prime, ndigits);
> +	xycz_add(rx[nb], ry[nb], rx[1 - nb], ry[1 - nb], curve);
>   
> -	apply_z(rx[0], ry[0], z, curve_prime, ndigits);
> +	apply_z(rx[0], ry[0], z, curve);
>   
>   	vli_set(result->x, rx[0], ndigits);
>   	vli_set(result->y, ry[0], ndigits);
> @@ -1218,9 +1339,9 @@ static void ecc_point_add(const struct ecc_point *result,
>   	vli_mod_sub(z, result->x, p->x, curve->p, ndigits);
>   	vli_set(px, p->x, ndigits);
>   	vli_set(py, p->y, ndigits);
> -	xycz_add(px, py, result->x, result->y, curve->p, ndigits);
> +	xycz_add(px, py, result->x, result->y, curve);
>   	vli_mod_inv(z, z, curve->p, ndigits);
> -	apply_z(result->x, result->y, z, curve->p, ndigits);
> +	apply_z(result->x, result->y, z, curve);
>   }
>   
>   /* Computes R = u1P + u2Q mod p using Shamir's trick.
> @@ -1249,8 +1370,7 @@ void ecc_point_mult_shamir(const struct ecc_point *result,
>   	points[2] = q;
>   	points[3] = &sum;
>   
> -	num_bits = max(vli_num_bits(u1, ndigits),
> -		       vli_num_bits(u2, ndigits));
> +	num_bits = max(vli_num_bits(u1, ndigits), vli_num_bits(u2, ndigits));
>   	i = num_bits - 1;
>   	idx = (!!vli_test_bit(u1, i)) | ((!!vli_test_bit(u2, i)) << 1);
>   	point = points[idx];
> @@ -1261,7 +1381,7 @@ void ecc_point_mult_shamir(const struct ecc_point *result,
>   	z[0] = 1;
>   
>   	for (--i; i >= 0; i--) {
> -		ecc_point_double_jacobian(rx, ry, z, curve->p, ndigits);
> +		ecc_point_double_jacobian(rx, ry, z, curve);
>   		idx = (!!vli_test_bit(u1, i)) | ((!!vli_test_bit(u2, i)) << 1);
>   		point = points[idx];
>   		if (point) {
> @@ -1271,19 +1391,19 @@ void ecc_point_mult_shamir(const struct ecc_point *result,
>   
>   			vli_set(tx, point->x, ndigits);
>   			vli_set(ty, point->y, ndigits);
> -			apply_z(tx, ty, z, curve->p, ndigits);
> +			apply_z(tx, ty, z, curve);
>   			vli_mod_sub(tz, rx, tx, curve->p, ndigits);
> -			xycz_add(tx, ty, rx, ry, curve->p, ndigits);
> -			vli_mod_mult_fast(z, z, tz, curve->p, ndigits);
> +			xycz_add(tx, ty, rx, ry, curve);
> +			vli_mod_mult_fast(z, z, tz, curve);
>   		}
>   	}
>   	vli_mod_inv(z, z, curve->p, ndigits);
> -	apply_z(rx, ry, z, curve->p, ndigits);
> +	apply_z(rx, ry, z, curve);
>   }
>   EXPORT_SYMBOL(ecc_point_mult_shamir);
>   
>   static int __ecc_is_key_valid(const struct ecc_curve *curve,
> -			      const u64 *private_key, unsigned int ndigits)
> +			const u64 *private_key, unsigned int ndigits)

The reformatting should not be necessary.


>   {
>   	u64 one[ECC_MAX_DIGITS] = { 1, };
>   	u64 res[ECC_MAX_DIGITS];
> @@ -1306,7 +1426,7 @@ static int __ecc_is_key_valid(const struct ecc_curve *curve,
>   }
>   
>   int ecc_is_key_valid(unsigned int curve_id, unsigned int ndigits,
> -		     const u64 *private_key, unsigned int private_key_len)
> +			const u64 *private_key, unsigned int private_key_len)

Should not be necessary.


>   {
>   	int nbytes;
>   	const struct ecc_curve *curve = ecc_get_curve(curve_id);
> @@ -1374,7 +1494,7 @@ int ecc_gen_privkey(unsigned int curve_id, unsigned int ndigits, u64 *privkey)
>   EXPORT_SYMBOL(ecc_gen_privkey);
>   
>   int ecc_make_pub_key(unsigned int curve_id, unsigned int ndigits,
> -		     const u64 *private_key, u64 *public_key)
> +			const u64 *private_key, u64 *public_key)

Should not be necessary.


>   {
>   	int ret = 0;
>   	struct ecc_point *pk;
> @@ -1432,10 +1552,10 @@ int ecc_is_pubkey_valid_partial(const struct ecc_curve *curve,
>   		return -EINVAL;
>   
>   	/* Check 3: Verify that y^2 == (x^3 + a·x + b) mod p */
> -	vli_mod_square_fast(yy, pk->y, curve->p, pk->ndigits); /* y^2 */
> -	vli_mod_square_fast(xxx, pk->x, curve->p, pk->ndigits); /* x^2 */
> -	vli_mod_mult_fast(xxx, xxx, pk->x, curve->p, pk->ndigits); /* x^3 */
> -	vli_mod_mult_fast(w, curve->a, pk->x, curve->p, pk->ndigits); /* a·x */
> +	vli_mod_square_fast(yy, pk->y, curve); /* y^2 */
> +	vli_mod_square_fast(xxx, pk->x, curve); /* x^2 */
> +	vli_mod_mult_fast(xxx, xxx, pk->x, curve); /* x^3 */
> +	vli_mod_mult_fast(w, curve->a, pk->x, curve); /* a·x */
>   	vli_mod_add(w, w, curve->b, curve->p, pk->ndigits); /* a·x + b */
>   	vli_mod_add(w, w, xxx, curve->p, pk->ndigits); /* x^3 + a·x + b */
>   	if (vli_cmp(yy, w, pk->ndigits) != 0) /* Equation */
> @@ -1447,7 +1567,7 @@ EXPORT_SYMBOL(ecc_is_pubkey_valid_partial);
>   
>   /* SP800-56A section 5.6.2.3.3 full verification */
>   int ecc_is_pubkey_valid_full(const struct ecc_curve *curve,
> -			     struct ecc_point *pk)
> +			struct ecc_point *pk)

Should not be necessary.


>   {
>   	struct ecc_point *nQ;
>   
> @@ -1473,8 +1593,8 @@ int ecc_is_pubkey_valid_full(const struct ecc_curve *curve,
>   EXPORT_SYMBOL(ecc_is_pubkey_valid_full);
>   
>   int crypto_ecdh_shared_secret(unsigned int curve_id, unsigned int ndigits,
> -			      const u64 *private_key, const u64 *public_key,
> -			      u64 *secret)
> +			const u64 *private_key, const u64 *public_key,
> +			u64 *secret)

Should not be necessary.


>   {
>   	int ret = 0;
>   	struct ecc_point *product, *pk;
> @@ -1484,7 +1604,7 @@ int crypto_ecdh_shared_secret(unsigned int curve_id, unsigned int ndigits,
>   	const struct ecc_curve *curve = ecc_get_curve(curve_id);
>   
>   	if (!private_key || !public_key || !curve ||
> -	    ndigits > ARRAY_SIZE(priv) || ndigits > ARRAY_SIZE(rand_z)) {
> +		ndigits > ARRAY_SIZE(priv) || ndigits > ARRAY_SIZE(rand_z)) {


Should not be necessary.


>   		ret = -EINVAL;
>   		goto out;
>   	}
> diff --git a/crypto/ecc.h b/crypto/ecc.h
> index 2ea86dfb5cf7..861de67b538f 100644
> --- a/crypto/ecc.h
> +++ b/crypto/ecc.h
> @@ -29,7 +29,8 @@
>   /* One digit is u64 qword. */
>   #define ECC_CURVE_NIST_P192_DIGITS  3
>   #define ECC_CURVE_NIST_P256_DIGITS  4
> -#define ECC_MAX_DIGITS             (512 / 64)
> +#define ECC_CURVE_NIST_P384_DIGITS  6
> +#define ECC_MAX_DIGITS              (ECC_CURVE_NIST_P384_DIGITS)
Good.
>   
>   #define ECC_DIGITS_TO_BYTES_SHIFT 3
>   


In my opinion this patch here should primarily add:

static void vli_mmod_fast_384(u64 *result, const u64 *product,
				const u64 *curve_prime, u64 *tmp)

We should also only introduce the change in function signatures (curve instead of ndigits and curve_prime) when we need it for NIST p521, unless I am missing something why it is needed for p384.

