Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1CF33DB377
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jul 2021 08:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237476AbhG3GWI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 30 Jul 2021 02:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237427AbhG3GWH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 30 Jul 2021 02:22:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2536FC0613C1
        for <linux-integrity@vger.kernel.org>; Thu, 29 Jul 2021 23:22:03 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1m9LuD-0001G3-Cj; Fri, 30 Jul 2021 08:22:01 +0200
Subject: Re: [PATCH v2] KEYS: trusted: fix use as module when CONFIG_TCG_TPM=m
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, kernel@pengutronix.de,
        Andreas Rammhold <andreas@rammhold.de>,
        David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org
References: <20210721160258.7024-1-a.fatoum@pengutronix.de>
 <20210727030433.3dwod2elwtdkhwsc@kernel.org>
 <fe39a449-88df-766b-a13a-290f4847d43e@pengutronix.de>
 <20210728215200.nfvnm5s2b27ang7i@kernel.org>
 <f0f05df9-95bb-8b67-cecc-742af0b19f1e@pengutronix.de>
 <20210730002101.2tcb3bs2lxdvmuqk@kernel.org>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <e372db1d-0909-42b8-7d52-9e5354601c68@pengutronix.de>
Date:   Fri, 30 Jul 2021 08:21:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210730002101.2tcb3bs2lxdvmuqk@kernel.org>
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

On 30.07.21 02:31, Jarkko Sakkinen wrote:
> On Thu, Jul 29, 2021 at 12:29:38AM +0200, Ahmad Fatoum wrote:
>> On 28.07.21 23:52, Jarkko Sakkinen wrote:
>>> On Tue, Jul 27, 2021 at 06:24:49AM +0200, Ahmad Fatoum wrote:
>>>> On 27.07.21 05:04, Jarkko Sakkinen wrote:
>>>>>> Reported-by: Andreas Rammhold <andreas@rammhold.de>
>>>>>> Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
>>>>>> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
>>>>>
>>>>> Is it absolutely need to do all this *just* to fix the bug?
>>>>>
>>>>> For a pure bug fix the most essential thing is to be able the backport
>>>>> it to stable kernels.
>>>>
>>>> Not much happened in-between, so a backport should be trivial.
>>>> I can provide these if needed.
>>>
>>> "not much" is not good enough. It should be "not anything".
>>
>> "Not much" [code that could conflict was added in-between].
>>
>> I just checked and it applies cleanly on v5.13. On the off chance
>> that this patch conflicts with another stable backport by the time
>> it's backported, I'll get a friendly automated email and send out
>> a rebased patch.
> 
> What you should do is to split this into patch that exactly
> fixes the issue, and to one that adds the "niceties".

I'd rather not send out patches I believe to be incomplete, sorry.
If you want to fix the regression's root cause of insufficient
Kconfig description, that here is what it takes.

You can take Andreas' regression fix for stable and replace it with my patch later.
I'll send out a new version removing references that it fixes a regression.

Cheers,
Ahmad

> 
> /Jarkko
> 


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
