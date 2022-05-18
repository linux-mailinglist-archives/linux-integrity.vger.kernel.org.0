Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B6F52B183
	for <lists+linux-integrity@lfdr.de>; Wed, 18 May 2022 06:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiEREcM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 May 2022 00:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiEREcJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 May 2022 00:32:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B82CF0
        for <linux-integrity@vger.kernel.org>; Tue, 17 May 2022 21:32:08 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nrBLb-0008QJ-Dh; Wed, 18 May 2022 06:31:43 +0200
Message-ID: <4e0e8f5b-f5c9-003b-6aac-cea7c49b3f96@pengutronix.de>
Date:   Wed, 18 May 2022 06:31:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v10 2/7] KEYS: trusted: allow use of kernel RNG for key
 material
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>, kernel@pengutronix.de,
        Sumit Garg <sumit.garg@linaro.org>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        David Gstir <david@sigma-star.at>,
        Michael Walle <michael@walle.cc>,
        John Ernberg <john.ernberg@actia.se>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Eric Biggers <ebiggers@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Pascal Van Leeuwen <pvanleeuwen@verimatrix.com>
References: <20220513145705.2080323-1-a.fatoum@pengutronix.de>
 <20220513145705.2080323-3-a.fatoum@pengutronix.de>
 <1c6a5ce2564c29a06eca255072a379351a5fc026.camel@linux.ibm.com>
 <YoPdfjswwA2wKinr@zx2c4.com>
 <4fe5564e860eb3093a88528ba1d30364d57723e0.camel@linux.ibm.com>
 <YoPpyDjn61AFqcZp@zx2c4.com>
 <dd488736ab86c0e0b2809b4ce30f1827563b52b2.camel@linux.ibm.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <dd488736ab86c0e0b2809b4ce30f1827563b52b2.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello Mimi,

On 17.05.22 21:49, Mimi Zohar wrote:
> On Tue, 2022-05-17 at 20:30 +0200, Jason A. Donenfeld wrote:
>> Hi Mimi,
>>
>> On Tue, May 17, 2022 at 02:21:08PM -0400, Mimi Zohar wrote:
>>> On Tue, 2022-05-17 at 19:38 +0200, Jason A. Donenfeld wrote:
>> Apologies in advance if I've missed the mark here; I'm not very familiar
>> with this thread or what it's driving at. If the simple question was
>> just "is get_random_bytes_wait() good to use?" the answer is just "yes"
>> and I can disappear and stop confusing things. :)
> 
> My apologies for your having been brought into this discussion without
> having properly reviewed and summarized the previous thread.   As you
> saw there is a long history.
> 
> Jarrko, Ahmad,  "Trusted" keys, by definition, are based on the TPM
> RNG.  If CAAM trusted key support wants to use kernel RNG by default,
> that's fine.  However defining and allowing a boot command line option
> to use kernel RNG instead of the TPM RNG, needs to be configurable.

The use of kernel RNG for TPM Trusted Keys is already opt-in. The default
is trusted.rng=default, which maintains existing behavior. Users who want
to use kernel RNG instead need to explicitly specify trusted.rng=kernel.

What more is needed?

Cheers,
Ahmad



> 
> thanks,
> 
> Mimi
> 
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
