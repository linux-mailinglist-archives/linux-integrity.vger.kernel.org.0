Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5465B2F020F
	for <lists+linux-integrity@lfdr.de>; Sat,  9 Jan 2021 18:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbhAIRIA (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 9 Jan 2021 12:08:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:38222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbhAIRIA (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 9 Jan 2021 12:08:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9538A23372;
        Sat,  9 Jan 2021 17:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610212039;
        bh=X/xyGoEV3hRU/aFtBlpc25ND+vaJ6PXHSDMhHK9mLw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mvYSHIwcl5LtK+BxV4glHaMYBtbSbooghubbZms1gBzKFJXVZi9XPOSUc4GUYQOZv
         CiGMwybVMOyPpXMIiBS9KrXshbRQ8LgiCU4MPsg6HtjflwqLNljBxHHbNh7aAvGogE
         8EJ8epcP8SmiQTeEJp4G9sauOZ1do9tOVrS/CQ/eBw5Fg0J9r5bQ7XO4j3BmvINVHP
         gbL7yH8kpge2RXpmW/2ub3tCKVG9d8ArEj6bTBuK637lMI9E92rQ0ohM3l4fnu5i+t
         f4TMSodHuOGEGMjtxflFveAeCOoajQRdKXcoTj3cr3af2hS3DBsrnFDP7IHeA8j5Hy
         Iu9NXFIzHLxJg==
Date:   Sat, 9 Jan 2021 09:07:16 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Mimi Zohar <zohar@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@nokia.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] evm: Fix memleak in init_desc
Message-ID: <X/nixOkNqQdWUAv8@sol.localdomain>
References: <20210109113305.11035-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210109113305.11035-1-dinghao.liu@zju.edu.cn>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Jan 09, 2021 at 07:33:05PM +0800, Dinghao Liu wrote:
> When kmalloc() fails, tmp_tfm allocated by
> crypto_alloc_shash() has not been freed, which
> leads to memleak.
> 
> Fixes: d46eb3699502b ("evm: crypto hash replaced by shash")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  security/integrity/evm/evm_crypto.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
> index 168c3b78ac47..39fb31a638ac 100644
> --- a/security/integrity/evm/evm_crypto.c
> +++ b/security/integrity/evm/evm_crypto.c
> @@ -73,7 +73,7 @@ static struct shash_desc *init_desc(char type, uint8_t hash_algo)
>  {
>  	long rc;
>  	const char *algo;
> -	struct crypto_shash **tfm, *tmp_tfm;
> +	struct crypto_shash **tfm, *tmp_tfm = NULL;
>  	struct shash_desc *desc;
>  
>  	if (type == EVM_XATTR_HMAC) {
> @@ -118,13 +118,18 @@ static struct shash_desc *init_desc(char type, uint8_t hash_algo)
>  alloc:
>  	desc = kmalloc(sizeof(*desc) + crypto_shash_descsize(*tfm),
>  			GFP_KERNEL);
> -	if (!desc)
> +	if (!desc) {
> +		if (tmp_tfm)
> +			crypto_free_shash(tmp_tfm);
>  		return ERR_PTR(-ENOMEM);
> +	}
>  
>  	desc->tfm = *tfm;
>  
>  	rc = crypto_shash_init(desc);
>  	if (rc) {
> +		if (tmp_tfm)
> +			crypto_free_shash(tmp_tfm);
>  		kfree(desc);
>  		return ERR_PTR(rc);
>  	}

There's no need to check for NULL before calling crypto_free_shash().

- Eric
