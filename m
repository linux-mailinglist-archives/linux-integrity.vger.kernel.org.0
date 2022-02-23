Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5564C1882
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Feb 2022 17:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242602AbiBWQXy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Feb 2022 11:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbiBWQXx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Feb 2022 11:23:53 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5CDC559D
        for <linux-integrity@vger.kernel.org>; Wed, 23 Feb 2022 08:23:25 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nMuPy-00008w-Vg; Wed, 23 Feb 2022 17:23:06 +0100
Message-ID: <994a4d49-b1d3-a7ab-d7b3-33405b13c125@pengutronix.de>
Date:   Wed, 23 Feb 2022 17:23:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5 3/5] KEYS: trusted: allow trust sources to use kernel
 RNG for key material
Content-Language: en-US
To:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>
Cc:     kernel@pengutronix.de, Sumit Garg <sumit.garg@linaro.org>,
        David Gstir <david@sigma-star.at>,
        Tim Harvey <tharvey@gateworks.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20220222195819.2313913-1-a.fatoum@pengutronix.de>
 <20220222195819.2313913-4-a.fatoum@pengutronix.de>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20220222195819.2313913-4-a.fatoum@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 22.02.22 20:58, Ahmad Fatoum wrote:
> The two existing trusted key sources don't make use of the kernel RNG,
> but instead let the hardware that does the sealing/unsealing also
> generate the random key material. While a previous change offers users
> the choice to use the kernel RNG instead for both, new trust sources
> may want to unconditionally use the kernel RNG for generating key
> material, like it's done elsewhere in the kernel.
> 
> This is especially prudent for hardware that has proven-in-production
> HWRNG drivers implemented, as otherwise code would have to be duplicated
> only to arrive at a possibly worse result.
> 
> Make this possible by turning struct trusted_key_ops::get_random
> into an optional member. If a driver leaves it NULL, kernel RNG
> will be used instead.

The rebase on the change in scope of the previous commit made this
one here quite small. I would squash it into the previous commit
for v6, unless there are objections.


> 
> Acked-by: Sumit Garg <sumit.garg@linaro.org>
> Reviewed-by: David Gstir <david@sigma-star.at>
> Tested-By: Tim Harvey <tharvey@gateworks.com>
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> ---
> To: James Bottomley <jejb@linux.ibm.com>
> To: Jarkko Sakkinen <jarkko@kernel.org>
> To: Mimi Zohar <zohar@linux.ibm.com>
> To: David Howells <dhowells@redhat.com>
> Cc: James Morris <jmorris@namei.org>
> Cc: "Serge E. Hallyn" <serge@hallyn.com>
> Cc: "Horia Geantă" <horia.geanta@nxp.com>
> Cc: Aymen Sghaier <aymen.sghaier@nxp.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: Jan Luebbe <j.luebbe@pengutronix.de>
> Cc: David Gstir <david@sigma-star.at>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Franck LENORMAND <franck.lenormand@nxp.com>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Tim Harvey <tharvey@gateworks.com>
> Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Cc: Pankaj Gupta <pankaj.gupta@nxp.com>
> Cc: keyrings@vger.kernel.org
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-integrity@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-security-module@vger.kernel.org
> ---
>  include/keys/trusted-type.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
> index d89fa2579ac0..4eb64548a74f 100644
> --- a/include/keys/trusted-type.h
> +++ b/include/keys/trusted-type.h
> @@ -64,7 +64,7 @@ struct trusted_key_ops {
>  	/* Unseal a key. */
>  	int (*unseal)(struct trusted_key_payload *p, char *datablob);
>  
> -	/* Get a randomized key. */
> +	/* Optional: Get a randomized key. */
>  	int (*get_random)(unsigned char *key, size_t key_len);
>  
>  	/* Exit key interface. */


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
