Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E963D156DD7
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Feb 2020 04:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgBJDRa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 9 Feb 2020 22:17:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:54940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgBJDRa (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 9 Feb 2020 22:17:30 -0500
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24D7A20870;
        Mon, 10 Feb 2020 03:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581304649;
        bh=4+xrRrrol/aiyGAllkyxm+BcBdBXEdtB/xYpBE5mqp0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZY3kL5ThzVIfNdnLnxnWJF8NCVdguistyR88GLQzeaLdSldvkzWM0WyvKl7S7//l2
         h5CyQ8dnqSJ6Efw9f9tk5mkx4zoPvPz4vob/qxmC05uRe/5Cu6uam5Y2Ru8O1XGBik
         yhe3fqyYtW+mYcZH3HutsVZ1Qs3A+LfbR5eQKDag=
Date:   Sun, 9 Feb 2020 19:17:17 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, jmorris@namei.org,
        serge@hallyn.com, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] crypto: sm3 - add a new alias name sm3-256
Message-ID: <20200210031717.GA5198@sol.localdomain>
References: <20200207092219.115056-1-tianjia.zhang@linux.alibaba.com>
 <20200207092219.115056-2-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207092219.115056-2-tianjia.zhang@linux.alibaba.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Feb 07, 2020 at 05:22:18PM +0800, Tianjia Zhang wrote:
> The name sm3-256 is defined in hash_algo_name in hash_info, but the
> algorithm name implemented in sm3_generic.c is sm3, which will cause
> the sm3-256 algorithm to be not found in some application scenarios of
> the hash algorithm, and an ENOENT error will occur. For example,
> IMA, keys, and other subsystems that reference hash_algo_name cannot use
> the hash algorithm of sm3. This patch adds an alias name sm3-256 to sm3,
> which can better solve the above problems.
> 
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  crypto/sm3_generic.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/crypto/sm3_generic.c b/crypto/sm3_generic.c
> index 3468975215ca..ded41031bd5f 100644
> --- a/crypto/sm3_generic.c
> +++ b/crypto/sm3_generic.c
> @@ -163,7 +163,7 @@ int crypto_sm3_finup(struct shash_desc *desc, const u8 *data,
>  }
>  EXPORT_SYMBOL(crypto_sm3_finup);
>  
> -static struct shash_alg sm3_alg = {
> +static struct shash_alg sm3_algs[2] = { {
>  	.digestsize	=	SM3_DIGEST_SIZE,
>  	.init		=	sm3_base_init,
>  	.update		=	crypto_sm3_update,
> @@ -176,16 +176,28 @@ static struct shash_alg sm3_alg = {
>  		.cra_blocksize	 =	SM3_BLOCK_SIZE,
>  		.cra_module	 =	THIS_MODULE,
>  	}
> -};
> +}, {
> +	.digestsize	=	SM3_DIGEST_SIZE,
> +	.init		=	sm3_base_init,
> +	.update		=	crypto_sm3_update,
> +	.final		=	sm3_final,
> +	.finup		=	crypto_sm3_finup,
> +	.descsize	=	sizeof(struct sm3_state),
> +	.base		=	{
> +		.cra_name	 =	"sm3-256",
> +		.cra_blocksize	 =	SM3_BLOCK_SIZE,
> +		.cra_module	 =	THIS_MODULE,
> +	}
> +} };

According to https://tools.ietf.org/id/draft-oscca-cfrg-sm3-01.html,
SM3 always produces a 256-bit hash value.  E.g., it says:

	"SM3 produces an output hash value of 256 bits long"

and

	"SM3 is a hash function that generates a 256-bit hash value."

I don't see any mention of "SM3-256".

So why not just keep it as "sm3" and change hash_info.c instead?
Since the name there is currently wrong, no one can be using it yet.

- Eric
