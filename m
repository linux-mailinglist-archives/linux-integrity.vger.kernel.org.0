Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEB35AE010
	for <lists+linux-integrity@lfdr.de>; Tue,  6 Sep 2022 08:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbiIFGob (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Sep 2022 02:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233100AbiIFGo2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Sep 2022 02:44:28 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCFD6D9DB;
        Mon,  5 Sep 2022 23:44:20 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oVSIo-001RDO-TA; Tue, 06 Sep 2022 16:43:20 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 06 Sep 2022 14:43:18 +0800
Date:   Tue, 6 Sep 2022 14:43:18 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Pankaj Gupta <pankaj.gupta@nxp.com>
Cc:     jarkko@kernel.org, a.fatoum@pengutronix.de, Jason@zx2c4.com,
        jejb@linux.ibm.com, zohar@linux.ibm.com, dhowells@redhat.com,
        sumit.garg@linaro.org, david@sigma-star.at, michael@walle.cc,
        john.ernberg@actia.se, jmorris@namei.org, serge@hallyn.com,
        davem@davemloft.net, j.luebbe@pengutronix.de, ebiggers@kernel.org,
        richard@nod.at, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, sahil.malhotra@nxp.com,
        kshitiz.varshney@nxp.com, horia.geanta@nxp.com, V.Sethi@nxp.com
Subject: Re: [RFC PATCH HBK: 2/8] hw-bound-key: flag-is_hbk added to the tfm
Message-ID: <YxbsBiCrIQT/0xz6@gondor.apana.org.au>
References: <20220906065157.10662-1-pankaj.gupta@nxp.com>
 <20220906065157.10662-3-pankaj.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906065157.10662-3-pankaj.gupta@nxp.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Sep 06, 2022 at 12:21:51PM +0530, Pankaj Gupta wrote:
> Consumer of the kernel crypto api, after allocating
> the transformation, sets this flag based on the basis
> of the type of key consumer has. This helps:
> 
> - This helps to influence the core processing logic
>   for the encapsulated algorithm.
> - This flag is set by the consumer after allocating
>   the tfm and before calling the function crypto_xxx_setkey().
> 
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>  include/linux/crypto.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/crypto.h b/include/linux/crypto.h
> index 2324ab6f1846..b4fa83ca87bd 100644
> --- a/include/linux/crypto.h
> +++ b/include/linux/crypto.h
> @@ -639,6 +639,8 @@ struct crypto_tfm {
>  
>  	u32 crt_flags;
>  
> +	unsigned int is_hbk;
> +

We already have plenty of drivers with hardware keys in the tree.
Plesae explain why the current support is inadequate and you need
to do this.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
