Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFAA95FC293
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Oct 2022 11:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiJLJAB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 Oct 2022 05:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJLJAA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Oct 2022 05:00:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606DE27FE9;
        Wed, 12 Oct 2022 01:59:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2BA961481;
        Wed, 12 Oct 2022 08:59:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F6BC433C1;
        Wed, 12 Oct 2022 08:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665565197;
        bh=UC4RSq3EANkzsMiiQgEDWL0NwxfcmeYlQBGJXnsa/7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=srsvupyPHbSAIQAr5Z+E69MFiuiB+cyJT814rgbfZZvdX/5IgmRJEkKEJopDKi9EN
         FTV5ims01wf7iq5mzwf1UQczxJ5YcjTLMbkEyipQYVeOVdb2kR9q3PkTnV0pIkBC0C
         glbOdpnkfQeRYJsBaNybnb61HqVK+AFIpiCRuxe8D9iTnK+pKlqbKPlLHNymt0yzpD
         pNxyYNsxGt1whq56xTapcZA8+NzQNG1i27pB9MWFjPuF0l9f3S3KwsV3Veu/61AYZf
         kT0z4D92zv0W7JBRTRRQTn1PiJSW1fIZeiHZECMP7XQrcvxXN0BPn39jmqnmgHpOa2
         YWp+kYd2SQBcw==
Date:   Wed, 12 Oct 2022 11:59:54 +0300
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
Subject: Re: [PATCH v0 4/8] sk_cipher: checking for hw bound operation
Message-ID: <Y0aCCguqS9Gzsrqx@kernel.org>
References: <20221006130837.17587-1-pankaj.gupta@nxp.com>
 <20221006130837.17587-5-pankaj.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006130837.17587-5-pankaj.gupta@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

In the short summary, please try to use imperative form and
accurate names. "Checking" means nothing.

On Thu, Oct 06, 2022 at 06:38:33PM +0530, Pankaj Gupta wrote:
> Checking for hw bound key. If yes,
>  - skipping the key-length validation to fall in min-max range.

What does "-" mean here? I seriously cannot interpret what I'm
reading.

> 
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>  crypto/skcipher.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/crypto/skcipher.c b/crypto/skcipher.c
> index 418211180cee..0f2d0228d73e 100644
> --- a/crypto/skcipher.c
> +++ b/crypto/skcipher.c
> @@ -598,7 +598,8 @@ int crypto_skcipher_setkey(struct crypto_skcipher *tfm, const u8 *key,
>  	unsigned long alignmask = crypto_skcipher_alignmask(tfm);
>  	int err;
>  
> -	if (keylen < cipher->min_keysize || keylen > cipher->max_keysize)
> +	if ((!tfm->base.is_hbk)
> +	    && (keylen < cipher->min_keysize || keylen > cipher->max_keysize))
>  		return -EINVAL;
>  
>  	if ((unsigned long)key & alignmask)
> -- 
> 2.17.1
>

BR, Jarkko
