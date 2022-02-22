Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B083F4BF73B
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Feb 2022 12:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbiBVLZv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 22 Feb 2022 06:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiBVLZo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 22 Feb 2022 06:25:44 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8583D1323C1
        for <linux-integrity@vger.kernel.org>; Tue, 22 Feb 2022 03:25:19 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1nMTHb-0000ST-9t; Tue, 22 Feb 2022 12:24:39 +0100
Message-ID: <db76da34-a40d-4746-5810-316b052acf16@pengutronix.de>
Date:   Tue, 22 Feb 2022 12:24:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [EXT] Re: [PATCH v4 5/5] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
To:     Pankaj Gupta <pankaj.gupta@nxp.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     David Gstir <david@sigma-star.at>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Richard Weinberger <richard@nod.at>,
        James Morris <jmorris@namei.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "tharvey@gateworks.com" <tharvey@gateworks.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        David Howells <dhowells@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>
References: <cover.8f40b6d1b93adc80aed2cac29a134f7a7fb5ee98.1633946449.git-series.a.fatoum@pengutronix.de>
 <a0f1d14af8ac8bae16dd29ad1073f7143ba28f26.1633946449.git-series.a.fatoum@pengutronix.de>
 <b9283c8a4b3b04c7ee9f525208cbb32d798d4439.camel@ew.tq-group.com>
 <59f1f3e6-fcf1-794d-610c-674b826822bf@pengutronix.de>
 <4decdfb7d4395e967e1bf6c65212616400c8064a.camel@ew.tq-group.com>
 <DU2PR04MB8630EA7DB3AAD9F582EDB75C953B9@DU2PR04MB8630.eurprd04.prod.outlook.com>
Content-Language: en-US
In-Reply-To: <DU2PR04MB8630EA7DB3AAD9F582EDB75C953B9@DU2PR04MB8630.eurprd04.prod.outlook.com>
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

On 22.02.22 05:30, Pankaj Gupta wrote:
> Hi Ahmad,
> 
> 
>> -----Original Message-----
>> From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
>> Sent: Monday, December 13, 2021 7:11 PM
>> To: Ahmad Fatoum <a.fatoum@pengutronix.de>
>>
>>> For now, this is pointed out in the documentation. If you have a
>>> suggestion on a specific condition we should check and issue a
>>> diagnostic on, I can incorporate it. An exhaustive if
>>> WARN_ON(!secure()) is impossible, but having some warning for
>>> unsuspecting users would indeed be nice.
>>
>> I don't know of any condition that doesn't involve looking at SoC- specific OTP
>> registers - that's what U-Boot does to determine whether HAB is enabled...
>>
> 
> Check the value fetched from the SEC Status Register (SSTA) (Offset 0xFD4h, bit 8,9 => 00b - Non-Secure, 01b - Secure, 10b - Trusted, 11b - Fail), for MOO (Mode of Operation).
> And the warning can be issued accordingly.
> 
> It is to be noted that this register is part of CAAM page0, which might not be accessible to Linux, for all the iMX SoC(s).
> 
> For other SoC(s), this can be added.

Thanks for the pointer. I am only testing this with i.MX, so I'd prefer this
be left as a future exercise for a Layerscape user.

Thanks for your reviews. I collected them on Patches 2/5 and 4/5 for v5.

Cheers,
Ahmad


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
