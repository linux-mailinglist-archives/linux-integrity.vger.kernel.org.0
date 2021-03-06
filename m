Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDA032FCBC
	for <lists+linux-integrity@lfdr.de>; Sat,  6 Mar 2021 20:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbhCFT0P (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 6 Mar 2021 14:26:15 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:50130 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbhCFTZ4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 6 Mar 2021 14:25:56 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 9FAA872C8B8;
        Sat,  6 Mar 2021 22:25:53 +0300 (MSK)
Received: from altlinux.org (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 51E974A4736;
        Sat,  6 Mar 2021 22:25:53 +0300 (MSK)
Date:   Sat, 6 Mar 2021 22:25:53 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com, zohar@linux.ibm.com,
        linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        Saulo Alessandre <saulo.alessandre@tse.jus.br>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v10 3/9] crypto: Add math to support fast NIST P384
Message-ID: <20210306192553.lxy5w262g2vs2hvv@altlinux.org>
References: <20210305005203.3547587-1-stefanb@linux.vnet.ibm.com>
 <20210305005203.3547587-4-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20210305005203.3547587-4-stefanb@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Stefan,

On Thu, Mar 04, 2021 at 07:51:57PM -0500, Stefan Berger wrote:
> From: Saulo Alessandre <saulo.alessandre@tse.jus.br>
> 
> * crypto/ecc.c
>   - add vli_mmod_fast_384
>   - change some routines to pass ecc_curve forward until vli_mmod_fast
> 
> * crypto/ecc.h
>   - add ECC_CURVE_NIST_P384_DIGITS
>   - change ECC_MAX_DIGITS to P384 size
> 
> Signed-off-by: Saulo Alessandre <saulo.alessandre@tse.jus.br>
> Tested-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  crypto/ecc.c | 266 +++++++++++++++++++++++++++++++++++++--------------
>  crypto/ecc.h |   3 +-
>  2 files changed, 194 insertions(+), 75 deletions(-)
> 
> diff --git a/crypto/ecc.c b/crypto/ecc.c
> index f6cef5a7942d..c125576cda6b 100644
> --- a/crypto/ecc.c
> +++ b/crypto/ecc.c
> @@ -778,18 +778,133 @@ static void vli_mmod_fast_256(u64 *result, const u64 *product,
>  ...
>  /* Computes result = product % curve_prime for different curve_primes.
>   *
>   * Note that curve_primes are distinguished just by heuristic check and
>   * not by complete conformance check.
>   */
>  static bool vli_mmod_fast(u64 *result, u64 *product,
> -			  const u64 *curve_prime, unsigned int ndigits)
> +			  const struct ecc_curve *curve)
>  {
>  	u64 tmp[2 * ECC_MAX_DIGITS];
> +	const u64 *curve_prime = curve->p;
> +	const unsigned int ndigits = curve->g.ndigits;
>  
> -	/* Currently, both NIST primes have -1 in lowest qword. */
> -	if (curve_prime[0] != -1ull) {
> +	/* Currently, all NIST have name nist_.* */
> +	if (strncmp(curve->name, "nist_", 5) != 0) {

I am not sure, but maybe this strncmp should not be optimized somehow,
since vli_mmod_fast could be called quite frequently. Perhaps by integer
algo id or even callback?

Thanks,

>  		/* Try to handle Pseudo-Marsenne primes. */
>  		if (curve_prime[ndigits - 1] == -1ull) {
>  			vli_mmod_special(result, product, curve_prime,
> @@ -812,6 +927,9 @@ static bool vli_mmod_fast(u64 *result, u64 *product,
>  	case 4:
>  		vli_mmod_fast_256(result, product, curve_prime, tmp);
>  		break;
> +	case 6:
> +		vli_mmod_fast_384(result, product, curve_prime, tmp);
> +		break;
>  	default:
>  		pr_err_ratelimited("ecc: unsupported digits size!\n");
>  		return false;
> @@ -835,22 +953,22 @@ EXPORT_SYMBOL(vli_mod_mult_slow);
>  
>  /* Computes result = (left * right) % curve_prime. */
>  static void vli_mod_mult_fast(u64 *result, const u64 *left, const u64 *right,
> -			      const u64 *curve_prime, unsigned int ndigits)
> +			      const struct ecc_curve *curve)
>  {
>  	u64 product[2 * ECC_MAX_DIGITS];
>  
> -	vli_mult(product, left, right, ndigits);
> -	vli_mmod_fast(result, product, curve_prime, ndigits);
> +	vli_mult(product, left, right, curve->g.ndigits);
> +	vli_mmod_fast(result, product, curve);
>  }
>  
>  /* Computes result = left^2 % curve_prime. */
>  static void vli_mod_square_fast(u64 *result, const u64 *left,
> -				const u64 *curve_prime, unsigned int ndigits)
> +				const struct ecc_curve *curve)
>  {
>  	u64 product[2 * ECC_MAX_DIGITS];
>  
> -	vli_square(product, left, ndigits);
> -	vli_mmod_fast(result, product, curve_prime, ndigits);
> +	vli_square(product, left, curve->g.ndigits);
> +	vli_mmod_fast(result, product, curve);
>  }
>  
>  #define EVEN(vli) (!(vli[0] & 1))
