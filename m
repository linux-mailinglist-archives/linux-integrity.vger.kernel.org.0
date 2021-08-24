Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51BC23F590A
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Aug 2021 09:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbhHXHeY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 Aug 2021 03:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234995AbhHXHeX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Aug 2021 03:34:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F36C061757
        for <linux-integrity@vger.kernel.org>; Tue, 24 Aug 2021 00:33:39 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1mIQwC-0007OI-KS; Tue, 24 Aug 2021 09:33:36 +0200
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
 <9200d46d-94a2-befd-e9b0-93036e56eb8a@pengutronix.de>
 <CAJ+vNU19z0syr0oHOrSGxL0cVW+Kjv76kmp6uvGc2akHbtX0Nw@mail.gmail.com>
 <fa530833-2bb9-f8f3-68c6-99423d29e2ca@pengutronix.de>
 <CAJ+vNU0iRTagc5_qvsG4jvt=B_wruj=1O2ZRixqWek8JTN=aeg@mail.gmail.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <8b559c9c-a4c0-d335-5e54-40b9acc08707@pengutronix.de>
Date:   Tue, 24 Aug 2021 09:33:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAJ+vNU0iRTagc5_qvsG4jvt=B_wruj=1O2ZRixqWek8JTN=aeg@mail.gmail.com>
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

On 23.08.21 19:50, Tim Harvey wrote:
> On Mon, Aug 23, 2021 at 6:29 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>> On 20.08.21 23:19, Tim Harvey wrote:
>>> On Fri, Aug 20, 2021 at 1:36 PM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>>>> On 20.08.21 22:20, Tim Harvey wrote:
>>> It works for a user keyring but not a session keyring... does that
>>> explain anything?
>>> # keyctl add trusted mykey 'new 32' @u
>>> 941210782
>>> # keyctl print 941210782
>>> 83b7845cb45216496aead9ee2c6a406f587d64aad47bddc539d8947a247e618798d9306b36398b5dc2722a4c3f220a3a763ee175f6bd64758fdd49ca4db597e8ce328121b60edbba9b8d8d55056be896
>>> # keyctl add trusted mykey 'new 32' @s
>>> 310571960
>>> # keyctl print 310571960
>>> keyctl_read_alloc: Unknown error 126
>>
>> Both sequences work for me.
>>
>> My getty is started by systemd. I think systemd allocates a new session
>> keyring for the getty that's inherited by the shell and the commands I run
>> it in. If you don't do that, each command will get its own session key.
>>
>>> Sorry, I'm still trying to wrap my head around the differences in
>>> keyrings and trusted vs user keys.
>>
>> No problem. HTH.
> 
> Ahmad,
> 
> Ok that explains it - my testing is using a very basic buildroot
> ramdisk rootfs. If I do a 'keyctl new_session' first I can use the
> system keyring fine as well.

Great. Does this mean I can get your Tested-by: ? :)

> Thanks - hoping to see this merged soon!

You and me both.

Cheers,
Ahmad


> 
> Tim
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
