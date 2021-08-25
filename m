Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC263F71C5
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Aug 2021 11:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239654AbhHYJex (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Aug 2021 05:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237008AbhHYJex (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Aug 2021 05:34:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E64C061757
        for <linux-integrity@vger.kernel.org>; Wed, 25 Aug 2021 02:34:07 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1mIpIL-0003oy-7B; Wed, 25 Aug 2021 11:34:05 +0200
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
 <8b559c9c-a4c0-d335-5e54-40b9acc08707@pengutronix.de>
 <CAJ+vNU2q_KCi8nNv56s0ip7CZaAE=YgObwFUyzuGa_T1Ywp-wQ@mail.gmail.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <2b5b1722-7934-045e-1807-075278041ae7@pengutronix.de>
Date:   Wed, 25 Aug 2021 11:34:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAJ+vNU2q_KCi8nNv56s0ip7CZaAE=YgObwFUyzuGa_T1Ywp-wQ@mail.gmail.com>
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

On 24.08.21 17:23, Tim Harvey wrote:
> On Tue, Aug 24, 2021 at 12:33 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>>
>> On 23.08.21 19:50, Tim Harvey wrote:
>>> On Mon, Aug 23, 2021 at 6:29 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>>>> On 20.08.21 23:19, Tim Harvey wrote:
>>>>> On Fri, Aug 20, 2021 at 1:36 PM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>>>>>> On 20.08.21 22:20, Tim Harvey wrote:
>>>>> It works for a user keyring but not a session keyring... does that
>>>>> explain anything?
>>>>> # keyctl add trusted mykey 'new 32' @u
>>>>> 941210782
>>>>> # keyctl print 941210782
>>>>> 83b7845cb45216496aead9ee2c6a406f587d64aad47bddc539d8947a247e618798d9306b36398b5dc2722a4c3f220a3a763ee175f6bd64758fdd49ca4db597e8ce328121b60edbba9b8d8d55056be896
>>>>> # keyctl add trusted mykey 'new 32' @s
>>>>> 310571960
>>>>> # keyctl print 310571960
>>>>> keyctl_read_alloc: Unknown error 126
>>>>
>>>> Both sequences work for me.
>>>>
>>>> My getty is started by systemd. I think systemd allocates a new session
>>>> keyring for the getty that's inherited by the shell and the commands I run
>>>> it in. If you don't do that, each command will get its own session key.
>>>>
>>>>> Sorry, I'm still trying to wrap my head around the differences in
>>>>> keyrings and trusted vs user keys.
>>>>
>>>> No problem. HTH.
>>>
>>> Ahmad,
>>>
>>> Ok that explains it - my testing is using a very basic buildroot
>>> ramdisk rootfs. If I do a 'keyctl new_session' first I can use the
>>> system keyring fine as well.
>>
>> Great. Does this mean I can get your Tested-by: ? :)
>>
> 
> Absolutely,
> 
> For the series:
> 
> I tested this series on top of v5.14.rc-7 on a Gateworks
> imx8mm-venice-gw73xx board with kernel param trusted.source=caam and
> keyutils-1.6:
> # keyctl new_session
> 22544757
> # keyctl add trusted mykey 'new 32' @s
> 160701809
> # keyctl print 160701809
> 990e03aa4515aee420eede17e26a58d0c5568c8bd2c9c2ee2f22a0583181d20d4f65cf9cb1f944a3cc92c0e3184a44a29a7e511f0a55a6af11a70ac2b2924514002475e73ae09820042896b9ee00a5ec
> 
> Tested-By: Tim Harvey <tharvey@gateworks.com>

Thanks. I'll apply it to the whole series then.

> One more question: I've got a user that wants to blob/deblob generic
> data. They can use the caam_encap_blob/caam_decap_blob functions in
> kernel code but could you give me a suggestion for how they could use
> this in:
> a) userspace code (using the keyctl syscall I assume)
> b) userspace cmdline (via keyutils I assume)

Trusted keys aren't disclosed to userspace in plain text, only in sealed
form (bar vulnerabilities of course).

Cheers,
Ahmad

> 
> Many thanks,
> 
> Tim
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
