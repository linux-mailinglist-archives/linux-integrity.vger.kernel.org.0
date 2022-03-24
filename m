Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C9F4E6189
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Mar 2022 11:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349367AbiCXKMP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Mar 2022 06:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349397AbiCXKMO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Mar 2022 06:12:14 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACFCA0BC1
        for <linux-integrity@vger.kernel.org>; Thu, 24 Mar 2022 03:10:42 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nXKQ1-0008Dj-FI; Thu, 24 Mar 2022 11:10:13 +0100
Message-ID: <ae941471-43c0-1aea-2567-89eed98a61a6@pengutronix.de>
Date:   Thu, 24 Mar 2022 11:10:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [EXT] [PATCH v6 3/4] crypto: caam - add in-kernel interface for
 blob generator
Content-Language: en-US
To:     Pankaj Gupta <pankaj.gupta@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        David Gstir <david@sigma-star.at>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
References: <20220316164335.1720255-1-a.fatoum@pengutronix.de>
 <20220316164335.1720255-4-a.fatoum@pengutronix.de>
 <DU2PR04MB8630BDFC29AA31074C623A7B95199@DU2PR04MB8630.eurprd04.prod.outlook.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <DU2PR04MB8630BDFC29AA31074C623A7B95199@DU2PR04MB8630.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hello Pankaj,

On 24.03.22 10:55, Pankaj Gupta wrote:
> Hi Ahmad,
> 
> Please find the comments in-line.

Thanks for you review.

> Suggest to continue to use two separate descriptor-creation-function for 'encap' and 'decap'.
> This will help these API(s) to be maintained easily going forward. 

We can still split them up in future once there is a real need.
But currently they are exactly the same, except for input/output length,
so I think it's correct to not introduce duplication unless needed.

>>   - use append_seq_(in|out)_ptr_intlen for both encap/decap as a result

Case in point. The intlen omission was because the two functions are largely
identical and I only fixed up one of them. This is prone to repeat when
we go back to have identical code with minor differences.

> In continuation to the previous comment, there is another suggestion:
> 
> Either: 
> struct keyblob_info {
>         void *key;
>         size_t key_len;
> 
>         void *blob;
>         size_t blob_len;
> 
>         size_t key_mod_len;
>         const void *key_mod;
> };

I can do that.

Whats your opinion on the desc size computation? Comment the macro or add
the static inline helper?

Cheers,
Ahmad

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
