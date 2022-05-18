Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68A452B191
	for <lists+linux-integrity@lfdr.de>; Wed, 18 May 2022 06:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiEREgj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 May 2022 00:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiEREgi (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 May 2022 00:36:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60B2AE54
        for <linux-integrity@vger.kernel.org>; Tue, 17 May 2022 21:36:36 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nrBQ5-0000jh-6u; Wed, 18 May 2022 06:36:21 +0200
Message-ID: <6f6a5524-9661-9a9f-a674-915efa33f6f6@pengutronix.de>
Date:   Wed, 18 May 2022 06:36:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v10 0/7] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        James Bottomley <jejb@linux.ibm.com>, kernel@pengutronix.de,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Eric Biggers <ebiggers@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Andreas Rammhold <andreas@rammhold.de>,
        Tim Harvey <tharvey@gateworks.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Michael Walle <michael@walle.cc>,
        John Ernberg <john.ernberg@actia.se>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
References: <20220513145705.2080323-1-a.fatoum@pengutronix.de>
 <YoKZwFkfcl7ixTF4@kernel.org>
 <4d4ecd4b-9683-08a0-7a5f-11a7ff86ea6d@pengutronix.de>
 <c511995075cafb35bfefcbfe6fa6e84aa31c536f.camel@kernel.org>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <c511995075cafb35bfefcbfe6fa6e84aa31c536f.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 18.05.22 03:08, Jarkko Sakkinen wrote:
> On Tue, 2022-05-17 at 14:44 +0200, Ahmad Fatoum wrote:
>> Hello Herbert,
>>
>> On 16.05.22 20:36, Jarkko Sakkinen wrote:
>>> On Fri, May 13, 2022 at 04:56:58PM +0200, Ahmad Fatoum wrote:
>>> I can probably pick these unless objections?
>>
>> Pankaj has given his Reviewed-by for the CAAM parts he co-maintains,
>> is it ok for this to go in via Jarkko's tree?
>>
>> Note that applying this series on top of jarkko/linux-tpmdd.git has a
>> trivial conflict when merged with herbert/cryptodev-2.6.git:
>> Two independently added Kconfig options need to coexist in
>> drivers/crypto/caam/Kconfig.
>>
>> I can resend my series rebased if needed.
>>
>> Cheers,
>> Ahmad
>>
>>>
>>> BR, Jarkko
>>>
>>
>>
> 
> This came up:
> 
> https://lore.kernel.org/keyrings/0e8da958a222e5c1dccaaf1600b08bdb8705b48e.camel@kernel.org/

And it turned out to be a misunderstanding. Or do you think there is still anything
to do there?

Thanks,
Ahmad

> 
> BR, Jarkko
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
