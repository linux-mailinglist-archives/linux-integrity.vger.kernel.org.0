Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B6F52A9A2
	for <lists+linux-integrity@lfdr.de>; Tue, 17 May 2022 19:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351635AbiEQRxd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 May 2022 13:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351632AbiEQRxc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 May 2022 13:53:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369B73F8B5
        for <linux-integrity@vger.kernel.org>; Tue, 17 May 2022 10:53:27 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nr1NS-0000eT-Gd; Tue, 17 May 2022 19:52:58 +0200
Message-ID: <21250bc0-623b-f11d-7dbf-458d144b7963@pengutronix.de>
Date:   Tue, 17 May 2022 19:52:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [PATCH v10 2/7] KEYS: trusted: allow use of kernel RNG for key
 material
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
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
        linux-security-module@vger.kernel.org
References: <20220513145705.2080323-1-a.fatoum@pengutronix.de>
 <20220513145705.2080323-3-a.fatoum@pengutronix.de>
 <YoPa7C8xs8lgKtwv@zx2c4.com>
Content-Language: en-US
In-Reply-To: <YoPa7C8xs8lgKtwv@zx2c4.com>
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

Hello Jason,

On 17.05.22 19:27, Jason A. Donenfeld wrote:
> On Fri, May 13, 2022 at 04:57:00PM +0200, Ahmad Fatoum wrote:
>> +	trusted.rng=	[KEYS]
>> +			Format: <string>
>> +			The RNG used to generate key material for trusted keys.
>> +			Can be one of:
>> +			- "kernel"
>> +			- the same value as trusted.source: "tpm" or "tee"
>> +			- "default"
>> +			If not specified, "default" is used. In this case,
>> +			the RNG's choice is left to each individual trust source.
>> +
> 
> As a general mechanism, I object to this. The kernel's RNG must be
> trusted in the first place for key material. That's the whole point of
> it.
> 
> However, it sounds like you're not proposing a general mechanism, but
> just something particular to this "trusted keys" business.

The two currently upstream trust sources (trusted key backends) each provide
their own RNG callback. This series adds a third backend that uses kernel RNG
and additionally provides users of the two existing trust sources the option
to benefit from kernel RNG as well.

> this should be a module flag, and thus not documented here, but rather
> some place namespaced to your trusted keys stuff. "trusted_keys.preferred_rng={whatever}"

The trusted keys module is trusted.ko and directly before my added lines is
the trusted.source=  documentation, so I think this is already at the correct place.

Thanks,
Ahmad

> 
> Jason
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
