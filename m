Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0502B34B74A
	for <lists+linux-integrity@lfdr.de>; Sat, 27 Mar 2021 13:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhC0MrO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 27 Mar 2021 08:47:14 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:59536 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhC0MrO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 27 Mar 2021 08:47:14 -0400
X-Greylist: delayed 345 seconds by postgrey-1.27 at vger.kernel.org; Sat, 27 Mar 2021 08:47:12 EDT
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id B1F871817F76C;
        Sat, 27 Mar 2021 13:41:26 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 2m3PmdzHQlsy; Sat, 27 Mar 2021 13:41:26 +0100 (CET)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ZIqBOEDGmD9E; Sat, 27 Mar 2021 13:41:25 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v1 3/3] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
From:   David Gstir <david@sigma-star.at>
In-Reply-To: <CAFA6WYNE44=Y7Erfc-xNtOrf7TkJjh+odmYH5vzhEHR6KqBfeQ@mail.gmail.com>
Date:   Sat, 27 Mar 2021 13:41:24 +0100
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?utf-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <6F812C20-7585-4718-997E-0306C4118468@sigma-star.at>
References: <cover.56fff82362af6228372ea82e6bd7e586e23f0966.1615914058.git-series.a.fatoum@pengutronix.de>
 <319e558e1bd19b80ad6447c167a2c3942bdafea2.1615914058.git-series.a.fatoum@pengutronix.de>
 <01e6e13d-2968-0aa5-c4c8-7458b7bde462@nxp.com>
 <45a9e159-2dcb-85bf-02bd-2993d50b5748@pengutronix.de>
 <f9c0087d299be1b9b91b242f41ac6ef7b9ee3ef7.camel@linux.ibm.com>
 <63dd7d4b-4729-9e03-cd8f-956b94eab0d9@pengutronix.de>
 <CAFA6WYOw_mQwOUN=onhzb7zCTyYDBrcx0E7C3LRk6nPLAVCWEQ@mail.gmail.com>
 <557b92d2-f3b8-d136-7431-419429f0e059@pengutronix.de>
 <CAFA6WYNE44=Y7Erfc-xNtOrf7TkJjh+odmYH5vzhEHR6KqBfeQ@mail.gmail.com>
To:     Sumit Garg <sumit.garg@linaro.org>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi!

> On 25.03.2021, at 06:26, Sumit Garg <sumit.garg@linaro.org> wrote:
> 
> On Wed, 24 Mar 2021 at 19:37, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>> 
>> Hello Sumit,
>> 
>> On 24.03.21 11:47, Sumit Garg wrote:
>>> On Wed, 24 Mar 2021 at 14:56, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>>>> 
>>>> Hello Mimi,
>>>> 
>>>> On 23.03.21 19:07, Mimi Zohar wrote:
>>>>> On Tue, 2021-03-23 at 17:35 +0100, Ahmad Fatoum wrote:
>>>>>> On 21.03.21 21:48, Horia Geantă wrote:
>>>>>>> caam has random number generation capabilities, so it's worth using that
>>>>>>> by implementing .get_random.
>>>>>> 
>>>>>> If the CAAM HWRNG is already seeding the kernel RNG, why not use the kernel's?
>>>>>> 
>>>>>> Makes for less code duplication IMO.
>>>>> 
>>>>> Using kernel RNG, in general, for trusted keys has been discussed
>>>>> before.   Please refer to Dave Safford's detailed explanation for not
>>>>> using it [1].
>>>> 
>>>> The argument seems to boil down to:
>>>> 
>>>> - TPM RNG are known to be of good quality
>>>> - Trusted keys always used it so far
>>>> 
>>>> Both are fine by me for TPMs, but the CAAM backend is new code and neither point
>>>> really applies.
>>>> 
>>>> get_random_bytes_wait is already used for generating key material elsewhere.
>>>> Why shouldn't new trusted key backends be able to do the same thing?
>>>> 
>>> 
>>> Please refer to documented trusted keys behaviour here [1]. New
>>> trusted key backends should align to this behaviour and in your case
>>> CAAM offers HWRNG so we should be better using that.
>> 
>> Why is it better?
>> 
>> Can you explain what benefit a CAAM user would have if the trusted key
>> randomness comes directly out of the CAAM instead of indirectly from
>> the kernel entropy pool that is seeded by it?
> 
> IMO, user trust in case of trusted keys comes from trusted keys
> backend which is CAAM here. If a user doesn't trust that CAAM would
> act as a reliable source for RNG then CAAM shouldn't be used as a
> trust source in the first place.
> 
> And I think building user's trust for kernel RNG implementation with
> multiple entropy contributions is pretty difficult when compared with
> CAAM HWRNG implementation.

Generally speaking, I’d say trusting the CAAM RNG and trusting in it’s
other features are two separate things. However, reading through the CAAM
key blob spec I’ve got here, CAAM key blob keys (the keys that secure a blob’s
content) are generated using its internal RNG. So I’d save if the CAAM RNG
is insecure, so are generated key blobs. Maybe somebody with more insight
into the CAAM internals can verify that, but I don’t see any point in using
the kernel’s RNG as long as we let CAAM generate the key blob keys for us.

Cheers,
dave

