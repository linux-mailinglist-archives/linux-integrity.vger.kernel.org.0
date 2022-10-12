Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51FB5FC288
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Oct 2022 10:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiJLI6H (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Oct 2022 04:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiJLI56 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Oct 2022 04:57:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD381A223;
        Wed, 12 Oct 2022 01:57:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 25ADD61484;
        Wed, 12 Oct 2022 08:57:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A790C433C1;
        Wed, 12 Oct 2022 08:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665565075;
        bh=shsKQzsUAB9x2yWMHC6DQUjhQUfU+iyNcWw8gO89At0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HZNFdhm3Lb3Jxs/Ig4AdQhdvayVVr7rQ1OsU3rFuuGNF92nUvDpIeQpTuBaP4Q2T2
         5PSRLyTPp8RMhJiUrQevdlggp9pS/TBsA2Pjiieyw9ZFSQt/2Eb+lOIJCqhRFhxJ7v
         AbR05ItcsPabOHiDm4dYWVsCfiJPASEqM9DZ33QwPreDoIpqFvmygI0mOrLa+rgmKM
         ILnxHOZRcJTCv8dUXENy+qiX0lE3GiaMBuuUt+AU8WaqpsHYePC7BFndLHNlFqvPOZ
         zr4pd/T42ooKIVzVE+CGeeR1nKnU/qKGQOEHgKZjeRMngLzDX6bm3mIB5Npj4jGLnC
         ZE98b0Pqt8xqw==
Date:   Wed, 12 Oct 2022 11:57:52 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Pankaj Gupta <pankaj.gupta@nxp.com>
Cc:     a.fatoum@pengutronix.de, gilad@benyossef.com, Jason@zx2c4.com,
        jejb@linux.ibm.com, zohar@linux.ibm.com, dhowells@redhat.com,
        sumit.garg@linaro.org, david@sigma-star.at, michael@walle.cc,
        john.ernberg@actia.se, jmorris@namei.org, serge@hallyn.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        j.luebbe@pengutronix.de, ebiggers@kernel.org, richard@nod.at,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, sahil.malhotra@nxp.com,
        kshitiz.varshney@nxp.com, horia.geanta@nxp.com, V.Sethi@nxp.com
Subject: Re: [PATCH v0 3/8] crypto: hbk flags & info added to the tfm
Message-ID: <Y0aBkL65vpNMmrK6@kernel.org>
References: <20221006130837.17587-1-pankaj.gupta@nxp.com>
 <20221006130837.17587-4-pankaj.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006130837.17587-4-pankaj.gupta@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

What are "hbk flags & info" and "the tfm"?

There can be multiple instances of struct crypto_tfm in
the kernel.

Maybe "crypto: Add hbk_info and is_hbk to struct crypto_tfm" ?

On Thu, Oct 06, 2022 at 06:38:32PM +0530, Pankaj Gupta wrote:
> Consumer of the kernel crypto api, after allocating
> the transformation (tfm), sets the:
> - flag 'is_hbk'
> - structure 'struct hw_bound_key_info hbk_info'
> based on the type of key, the consumer is using.
> 
> This helps:
> 
> - This helps to influence the core processing logic
>   for the encapsulated algorithm.
> - This flag is set by the consumer after allocating
>   the tfm and before calling the function crypto_xxx_setkey().

I don't really get "this helps part".



> 
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>  include/linux/crypto.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/crypto.h b/include/linux/crypto.h
> index 2324ab6f1846..cd476f8a1cb4 100644
> --- a/include/linux/crypto.h
> +++ b/include/linux/crypto.h
> @@ -19,6 +19,7 @@
>  #include <linux/refcount.h>
>  #include <linux/slab.h>
>  #include <linux/completion.h>
> +#include <linux/hw_bound_key.h>
>  
>  /*
>   * Autoloaded crypto modules should only use a prefixed name to avoid allowing
> @@ -639,6 +640,10 @@ struct crypto_tfm {
>  
>  	u32 crt_flags;
>  
> +	unsigned int is_hbk;

Not sure why not just use bool as type here.

> +
> +	struct hw_bound_key_info hbk_info;
> +
>  	int node;
>  	
>  	void (*exit)(struct crypto_tfm *tfm);
> -- 
> 2.17.1
> 

BR, Jarkko
