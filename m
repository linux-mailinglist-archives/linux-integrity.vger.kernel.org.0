Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC115F7477
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Oct 2022 08:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiJGG7k (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 7 Oct 2022 02:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJGG7h (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 7 Oct 2022 02:59:37 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F402FDB58;
        Thu,  6 Oct 2022 23:59:31 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oghJT-00COYa-KE; Fri, 07 Oct 2022 17:58:28 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 07 Oct 2022 14:58:27 +0800
Date:   Fri, 7 Oct 2022 14:58:27 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Pankaj Gupta <pankaj.gupta@nxp.com>
Cc:     jarkko@kernel.org, a.fatoum@pengutronix.de, gilad@benyossef.com,
        Jason@zx2c4.com, jejb@linux.ibm.com, zohar@linux.ibm.com,
        dhowells@redhat.com, sumit.garg@linaro.org, david@sigma-star.at,
        michael@walle.cc, john.ernberg@actia.se, jmorris@namei.org,
        serge@hallyn.com, davem@davemloft.net, j.luebbe@pengutronix.de,
        ebiggers@kernel.org, richard@nod.at, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, sahil.malhotra@nxp.com,
        kshitiz.varshney@nxp.com, horia.geanta@nxp.com, V.Sethi@nxp.com
Subject: Re: [PATCH v0 3/8] crypto: hbk flags & info added to the tfm
Message-ID: <Yz/OEwDtyTm+VH0p@gondor.apana.org.au>
References: <20221006130837.17587-1-pankaj.gupta@nxp.com>
 <20221006130837.17587-4-pankaj.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006130837.17587-4-pankaj.gupta@nxp.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

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
> 
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>  include/linux/crypto.h | 5 +++++
>  1 file changed, 5 insertions(+)

Nack.  You still have not provided a convincing argument why
this is necessary since there are plenty of existing drivers in
the kernel already providing similar features.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
