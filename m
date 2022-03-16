Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C646A4DB68C
	for <lists+linux-integrity@lfdr.de>; Wed, 16 Mar 2022 17:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357606AbiCPQqe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 16 Mar 2022 12:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357577AbiCPQqF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 16 Mar 2022 12:46:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B83528E35
        for <linux-integrity@vger.kernel.org>; Wed, 16 Mar 2022 09:44:28 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nUWkq-0003wy-K2; Wed, 16 Mar 2022 17:44:08 +0100
Message-ID: <fc13e731-a419-cad6-02f3-44fb25bee6a1@pengutronix.de>
Date:   Wed, 16 Mar 2022 17:44:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v5 4/5] crypto: caam - add in-kernel interface for blob
 generator
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, kernel@pengutronix.de,
        David Gstir <david@sigma-star.at>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
References: <20220222195819.2313913-1-a.fatoum@pengutronix.de>
 <20220222195819.2313913-5-a.fatoum@pengutronix.de> <YhZVmBy3/nWbqf+/@iki.fi>
 <a8cb99e0-fe01-2234-9839-fea28ca09f6d@pengutronix.de>
 <79b912b5e9e16f446753270f7b9463fee95ebac7.camel@kernel.org>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <79b912b5e9e16f446753270f7b9463fee95ebac7.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello Jarkko,

On 28.02.22 13:14, Jarkko Sakkinen wrote:
> On Wed, 2022-02-23 at 17:20 +0100, Ahmad Fatoum wrote:
>> On 23.02.22 16:41, Jarkko Sakkinen wrote:
>>> On Tue, Feb 22, 2022 at 08:58:18PM +0100, Ahmad Fatoum wrote:
>>>> +       /* header + (key mod immediate) + 2x pointers + op */
>>>> +       len = 4 + (4 + ALIGN(keymod_len, 4)) + 2*(4 + 4 + CAAM_PTR_SZ_MAX) + 4;
>>>
>>> Nit: the amount of magic numbers is overwhelming here. I neither understand
>>> the statement nor how that comment should help me to understand it.
>>
>> header              =  4
>> (key mod immediate) = (4 + ALIGN(keymod_len, 4))
>> 2x pointer          =  2 * (4 + 4 + CAAM_PTR_SZ_MAX)
>> op                  =  4
> 
> Please create a struct with the associated fields instead and then
> it is just sizeof that.

The CAAM descriptor construction code writes the current length
to the first word and then macros are used to append fields to
the descriptor while incrementing the length. The key modifier
is in the middle of the descriptor, so this isn't representable
as a C struct without using VLAs, which are banned in the kernel.
Even if it worked, it's arguably not good style to define a struct
just to compute the size and then cast it to a u32 * to use the
same macros all other CAAM code uses.


I thought this over a bit and figured that we don't really need to
compute the length dynamically as it's at most 44 or 52 bytes
(depending on DMA address width) anyway, so we can just use a fixed
value. I still keep the addition, because I believe there is a value
in seeing how we arrive at the 44 or 52 bytes instead of just hardcoding
it.

Just sent out v6 with these changes. Let me know what you think.

Cheers,
Ahmad


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
