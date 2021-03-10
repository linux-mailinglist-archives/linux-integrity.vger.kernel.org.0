Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8BE13341A9
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Mar 2021 16:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232982AbhCJPhe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 Mar 2021 10:37:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:51046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232985AbhCJPhE (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Mar 2021 10:37:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80A3464FB9;
        Wed, 10 Mar 2021 15:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615390624;
        bh=iVKxmnTzakmSRMac9IAEBmRIrTeJ5pLAqvAV6plCbBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lRcgQV4GQq6yzLLMkuU9X9RlLhWBR56NobMmETeofDK0DCCQd55F9JqXCYdUth3Rh
         eRLokD7pnwzIxKi8oFhkbD6S+WgtKCjM+6rwXMJkhY86MBrHoci4AzA/J8pSdhRrnI
         1sJZnjic4O0mI5g99IvkkQBoy0xQNFZ8IaVmYvnEQPkmDJkeOJP6yRWunpWIHFvRET
         GdUl7uXRzME1WrqpYmMfaenTNwYbORPBhEhik8VebaLOhoTqzMa2FNtudL4gH+LDHm
         ccAy60sGOhsiXl0PJT8nT2mMcw5jwlS65CJqa1AsSlb7ZD3NF0ZOaU5dlTkVJHgIIW
         hwyXaO3S/JTXA==
Date:   Wed, 10 Mar 2021 17:36:39 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com, zohar@linux.ibm.com,
        linux-kernel@vger.kernel.org, patrick@puiterwijk.org,
        linux-integrity@vger.kernel.org,
        Saulo Alessandre <saulo.alessandre@tse.jus.br>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v11 03/10] crypto: Add NIST P384 curve parameters
Message-ID: <YEjnhyD3LFEvheV0@kernel.org>
References: <20210305205956.3594375-1-stefanb@linux.vnet.ibm.com>
 <20210305205956.3594375-4-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305205956.3594375-4-stefanb@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Mar 05, 2021 at 03:59:49PM -0500, Stefan Berger wrote:
> From: Saulo Alessandre <saulo.alessandre@tse.jus.br>
> 
> Add the parameters for the NIST P384 curve and define a new curve ID
> for it. Make the curve available in ecc_get_curve.
> 
> Summary of changes:
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

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

/Jarkko
