Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3683F355E
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Aug 2021 22:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239463AbhHTUhY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Aug 2021 16:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239830AbhHTUhQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Aug 2021 16:37:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22794C061760
        for <linux-integrity@vger.kernel.org>; Fri, 20 Aug 2021 13:36:38 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1mHBFk-0004Q1-7C; Fri, 20 Aug 2021 22:36:36 +0200
Subject: Re: [PATCH 0/4] KEYS: trusted: Introduce support for NXP CAAM-based
 trusted keys
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     David Gstir <david@sigma-star.at>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>, keyrings@vger.kernel.org,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        linux-security-module@vger.kernel.org,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
        Richard Weinberger <richard@nod.at>,
        James Morris <jmorris@namei.org>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        David Howells <dhowells@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        linux-crypto@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>,
        linux-integrity@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
References: <cover.9fc9298fd9d63553491871d043a18affc2dbc8a8.1626885907.git-series.a.fatoum@pengutronix.de>
 <CAJ+vNU23cXPmiqKcKH_WAgD-ea+=pEJzGK+q7zOy=v2o0XU7kA@mail.gmail.com>
 <2b48a848-d70b-9c43-5ca0-9ab72622ed12@pengutronix.de>
 <CAJ+vNU225mgHHg00r67f1L6bEub+_h55hCBAMhCq2rd8kWU-qg@mail.gmail.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <9200d46d-94a2-befd-e9b0-93036e56eb8a@pengutronix.de>
Date:   Fri, 20 Aug 2021 22:36:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAJ+vNU225mgHHg00r67f1L6bEub+_h55hCBAMhCq2rd8kWU-qg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 20.08.21 22:20, Tim Harvey wrote:
> On Fri, Aug 20, 2021 at 9:20 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>> On 20.08.21 17:39, Tim Harvey wrote:
>>> Thanks for your work!
>>>
>>> I've been asked to integrate the capability of using CAAM to
>>> blob/deblob data to an older 5.4 kernel such as NXP's downstream
>>> vendor kernel does [1] and I'm trying to understand how your series
>>> works. I'm not at all familiar with the Linux Key Management API's or
>>> trusted keys. Can you provide an example of how this can be used for
>>> such a thing?
>>
>> Here's an example with dm-crypt:
>>
>>   https://lore.kernel.org/linux-integrity/5d44e50e-4309-830b-79f6-f5d888b1ef69@pengutronix.de/
>>
>> dm-crypt is a bit special at the moment, because it has direct support for
>> trusted keys. For interfacing with other parts of the kernel like ecryptfs
>> or EVM, you have to create encrypted keys rooted to the trusted keys and use
>> those. The kernel documentation has an example:
>>
>>   https://www.kernel.org/doc/html/v5.13/security/keys/trusted-encrypted.html
>>
>> If you backport this series, you can include the typo fix spotted by David.
>>
>> I'll send out a revised series, but given that a regression fix I want to
>> rebase on hasn't been picked up for 3 weeks now, I am not in a hurry.
>>
> Thanks for the reference.
> 
> I'm still trying to understand the keyctl integration with caam. For
> the 'data' param to keyctl you are using tings like 'new <len>' and
> 'load <data>'. Where are these 'commands' identified?

Search for match_table_t in security/keys/trusted-keys/trusted_core.c

> I may still be missing something. I'm using 4.14-rc6 with your series
> and seeing the following:

That's an odd version to backport stuff to..

> # cat /proc/cmdline
> trusted.source=caam
> # keyctl add trusted mykey 'new 32' @s)# create new trusted key named
> 'mykey' of 32 bytes in the session keyring
> 480104283
> # keyctl print 480104283 # dump the key
> keyctl_read_alloc: Unknown error 126
> ^^^ not clear what this is

Not sure what returns -ENOKEY for you. I haven't been using trusted
keys on v4.14, but you can try tracing the keyctl syscall.

Cheers,
Ahmad

> 
> Best regards,
> 
> Tim
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
