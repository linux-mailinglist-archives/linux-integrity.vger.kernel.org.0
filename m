Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA1DF32F0C6
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Mar 2021 18:10:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhCERJb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Mar 2021 12:09:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:46070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231469AbhCERJO (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Mar 2021 12:09:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E50966508F;
        Fri,  5 Mar 2021 17:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614964154;
        bh=iSAxKgFD/vwZRUOiqlVYdnhWDpsTAXlNHuTrJlxdo8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DUEnl0psYsE4jB1uic3SFSWjDijlhb5GA7D+kx8gfQaJ1FujXcoQEGnLlAAACPN2/
         SKdbRPLK26f4zd7PQwZw7nUGvdQBPGLqYnKi4pzfEAFt6RUUi8uT5va44+hv9dLM2c
         7hT5CX2K/kk0n2oFHpAedP/oh76zXTD4qIc/82r9b3rENKL4qB8VblROkysiKrYQgn
         E9AK28EjOxOrSWk+vC6kENxZpDH6Ng3nepoc6yx0jzUB/orSm4AFlAl0RqTyxk2f01
         /Buebh3sdiLmGtsMAbV4/sLCmBA10sEXTLAckFMNCh+iiWoARk3Dp4UZaTo09psJ30
         /3p13m4QdjZTw==
Date:   Fri, 5 Mar 2021 19:08:54 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com, zohar@linux.ibm.com,
        linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        Saulo Alessandre <saulo.alessandre@tse.jus.br>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v10 2/9] crypto: Add NIST P384 curve parameters
Message-ID: <YEJlprulEbjoO9qX@kernel.org>
References: <20210305005203.3547587-1-stefanb@linux.vnet.ibm.com>
 <20210305005203.3547587-3-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305005203.3547587-3-stefanb@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Mar 04, 2021 at 07:51:56PM -0500, Stefan Berger wrote:
> From: Saulo Alessandre <saulo.alessandre@tse.jus.br>
> 
> * crypto/ecc_curve_defs.h
>   - add nist_p384 params
> 
> * include/crypto/ecdh.h
>   - add ECC_CURVE_NIST_P384
> 
> * crypto/ecc.c
>   - change ecc_get_curve to accept nist_p384
> 
> Signed-off-by: Saulo Alessandre <saulo.alessandre@tse.jus.br>
> Tested-by: Stefan Berger <stefanb@linux.ibm.com>

No explanation what the commit does. We don't need a duplicate
diffstat. Instead, provide a plain English no-nonsense explanation.

/Jarkko

> ---
>  crypto/ecc.c            |  2 ++
>  crypto/ecc_curve_defs.h | 32 ++++++++++++++++++++++++++++++++
>  include/crypto/ecdh.h   |  1 +
>  3 files changed, 35 insertions(+)
> 
> diff --git a/crypto/ecc.c b/crypto/ecc.c
> index 25e79fd70566..f6cef5a7942d 100644
> --- a/crypto/ecc.c
> +++ b/crypto/ecc.c
> @@ -50,6 +50,8 @@ const struct ecc_curve *ecc_get_curve(unsigned int curve_id)
>  		return fips_enabled ? NULL : &nist_p192;
>  	case ECC_CURVE_NIST_P256:
>  		return &nist_p256;
> +	case ECC_CURVE_NIST_P384:
> +		return &nist_p384;
>  	default:
>  		return NULL;
>  	}
> diff --git a/crypto/ecc_curve_defs.h b/crypto/ecc_curve_defs.h
> index 69be6c7d228f..b327732f6ef5 100644
> --- a/crypto/ecc_curve_defs.h
> +++ b/crypto/ecc_curve_defs.h
> @@ -54,4 +54,36 @@ static struct ecc_curve nist_p256 = {
>  	.b = nist_p256_b
>  };
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
>  #endif
> diff --git a/include/crypto/ecdh.h b/include/crypto/ecdh.h
> index a5b805b5526d..e4ba1de961e4 100644
> --- a/include/crypto/ecdh.h
> +++ b/include/crypto/ecdh.h
> @@ -25,6 +25,7 @@
>  /* Curves IDs */
>  #define ECC_CURVE_NIST_P192	0x0001
>  #define ECC_CURVE_NIST_P256	0x0002
> +#define ECC_CURVE_NIST_P384	0x0003
>  
>  /**
>   * struct ecdh - define an ECDH private key
> -- 
> 2.29.2
> 
> 
