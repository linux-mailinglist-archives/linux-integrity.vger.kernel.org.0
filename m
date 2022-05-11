Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F005230EB
	for <lists+linux-integrity@lfdr.de>; Wed, 11 May 2022 12:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiEKKpM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 May 2022 06:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbiEKKpK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 May 2022 06:45:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40AF64D9
        for <linux-integrity@vger.kernel.org>; Wed, 11 May 2022 03:45:09 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nojpq-0005CM-4b; Wed, 11 May 2022 12:44:50 +0200
Message-ID: <fce6d626-06c3-3a89-1f0d-9535e6261f41@pengutronix.de>
Date:   Wed, 11 May 2022 12:44:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v8 0/6] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
Content-Language: en-US
To:     John Ernberg <john.ernberg@actia.se>
Cc:     "andreas@rammhold.de" <andreas@rammhold.de>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "david@sigma-star.at" <david@sigma-star.at>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "franck.lenormand@nxp.com" <franck.lenormand@nxp.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "horia.geanta@nxp.com" <horia.geanta@nxp.com>,
        "j.luebbe@pengutronix.de" <j.luebbe@pengutronix.de>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "matthias.schiffer@ew.tq-group.com" 
        <matthias.schiffer@ew.tq-group.com>,
        "pankaj.gupta@nxp.com" <pankaj.gupta@nxp.com>,
        "richard@nod.at" <richard@nod.at>,
        "s.trumtrar@pengutronix.de" <s.trumtrar@pengutronix.de>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>
References: <09e2552c-7392-e1da-926b-53c7db0b118d@pengutronix.de>
 <20220507213003.3373206-1-john.ernberg@actia.se>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <20220507213003.3373206-1-john.ernberg@actia.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello John,

On 07.05.22 23:30, John Ernberg wrote:
> Hi Ahmad,
> 
>>>
>>> dmesg snips:
>>> [    1.296772] trusted_key: Job Ring Device allocation for transform failed
>>> ...
>>> [    1.799768] caam 31400000.crypto: device ID = 0x0a16040000000100 (Era 9)
>>> [    1.807142] caam 31400000.crypto: job rings = 2, qi = 0
>>> [    1.822667] caam algorithms registered in /proc/crypto
>>> [    1.830541] caam 31400000.crypto: caam pkc algorithms registered in /proc/crypto
>>> [    1.841807] caam 31400000.crypto: registering rng-caam
>>>
>>> I didn't quite have the time to get a better trace than that.
>>
>> I don't see a crypto@31400000 node upstream. Where can I see your device tree?
> 
> Apologies for forgetting to mention that, I took it from the NXP tree
> while removing the SM and SECO bits [1].
> I also had to rebase some of their patches onto 5.17 for the CAAM to
> probe, as the SCU makes some register pages unavailable.

If the CAAM has a dependency on some SCU-provided resource, this
would explain why the driver probes it that late.

>> Initcall ordering does the right thing, but if CAAM device probe is deferred beyond
>> late_initcall, then it won't help.
>>
>> This is a general limitation with trusted keys at the moment. Anything that's
>> not there by the time of the late_initcall won't be tried again. You can work
>> around it by having trusted keys as a module. We might be able to do something
>> with fw_devlinks in the future and a look into your device tree would help here,
>> but I think that should be separate from this patch series.
> 
> Thank for you the explanation, it makes sense, and I agree that such work
> would be a different patch set.
> 
>>
>> Please let me know if the module build improves the situation for you.
>>
> 
> After I changed trusted keys to a module I got it working. Which is good
> enough for me as QXP CAAM support is not upstream yet.

Great!

> Feel free to add my tested by if you need to make another spin.
> Tested-by: John Ernberg <john.ernberg@actia.se> # iMX8QXP
> 
> I didn't test v9 as I would have to patch around the new patch due to
> the SCU.

Thanks for the test. I will add it to v10 except for

 - "crypto: caam - determine whether CAAM supports blob encap/decap", which
   was new in v9
 - "doc: trusted-encrypted: describe new CAAM trust source",
   "MAINTAINERS: add KEYS-TRUSTED-CAAM" as runtime test isn't affected by these.

Cheers,
Ahmad

> 
> Best regards // John Ernberg
> 
> [1]: https://source.codeaurora.org/external/imx/linux-imx/tree/arch/arm64/boot/dts/freescale/imx8-ss-security.dtsi?h=lf-5.10.y


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
