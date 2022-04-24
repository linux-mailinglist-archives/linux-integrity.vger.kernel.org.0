Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485CB50CE6B
	for <lists+linux-integrity@lfdr.de>; Sun, 24 Apr 2022 04:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiDXCZf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 23 Apr 2022 22:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237651AbiDXCZe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 23 Apr 2022 22:25:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBC0237FD;
        Sat, 23 Apr 2022 19:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1650766936;
        bh=vQSnzM7QzzmtqW5J8MHPmlvBtPWy0o7IqH7jrgwJ9QY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=XSDrKul9Y2F9pfIAad+mhBaWG9EpAfW4WIp/KgAUTHf+1zJI1WLZeI/lbl+Lwe/Ct
         xmIaudurZW9klVJnXQX0i7MG4Q0qTvtZhvhzv3F5issBacXzgP9F1jbhzbhBOWlv3u
         jPnlQpKV5MiJ4RSCTXU7i7XwQtLXC+9ZvqKfvmMU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.33] ([46.223.2.193]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWzfv-1nOx4D075d-00XOQn; Sun, 24
 Apr 2022 04:22:16 +0200
Subject: Re: [PATCH v3 0/4] Fixes for TPM interrupt handling
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        =?UTF-8?Q?Michael_Niew=c3=b6hner?= <linux@mniewoehner.de>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        stefanb@linux.ibm.com, James.Bottomley@hansenpartnership.com,
        keescook@chromium.org, jsnitsel@redhat.com, ml.linux@elloe.vision,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        twawrzynczak@chromium.org, Lukas Wunner <lukas@wunner.de>,
        Philipp Rosenberger <p.rosenberger@kunbus.com>
References: <20210501135727.17747-1-LinoSanfilippo@gmx.de>
 <20210501135727.17747-3-LinoSanfilippo@gmx.de> <YJAby8mmiJ74qWAh@kernel.org>
 <6722bf6f-1a3f-ee9c-55e2-cf63c64266a9@gmx.de> <YJNKs8bUMGOzFre+@kernel.org>
 <2a1a1cf61732eff1608aeae74054a0c135c1671f.camel@mniewoehner.de>
 <Yj0lhqTP1RoedxSc@iki.fi>
 <0d6c22b40a2f17d4b260f287d4c479a96a88b0b1.camel@mniewoehner.de>
 <efdb99b3-6d33-38b1-64a0-671821101631@gmx.de>
 <c8c0c5fb614d8b2de2a5faee2ef5ff3214281064.camel@kernel.org>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <77374443-dc9b-5d1d-c652-0d093b6029f4@gmx.de>
Date:   Sun, 24 Apr 2022 04:22:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c8c0c5fb614d8b2de2a5faee2ef5ff3214281064.camel@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:120S5x/kr26FHH+mVXUazZ1hLDKaXtRBYFV2Z+LOc3uJ/bIqBHd
 WB0je9ptnnc6zraRHhcXMOsxFXxdyF27y73lFJOAQWxSkVeW5vboUIbr17YcFpsvQ+PgtEg
 1rOQIr900dQDDMh2Hklc6fItWusYpHJKbl+Wp5y79FzbBd2aVw0Z7LSv0YLgV2H5usUfb47
 FyG3UnOjTcM3aoet5Ueww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2+PvYJTu1oo=:nqZGsauAE/5flHlLeMYG7/
 zRgmdUcHOwlqe0GBLYTTy4RjI5H5Z8/sg3uBQvCkK06LDI+HVHIsOEszsl6+rjT8pJTejKOTh
 RjzPh3N3dzDe5lp1mkUkfgGUwPR89NxXOz914Mj2v0D3cpTAIRXSjMHOfVxvsLwyojPRjCh9x
 esS79hTaa99wvheuX3Xw9MDEXyALHuDHQUd1Gtet51Rg98kVs0LM9SbHdGR5Lxaz6IPJZ8DKB
 BZ7SZf2NsHPjcZXAOOg/QX0ew1np4MGU5wdNBEMqV/UF/BJVrEp/W+FJqN2kMWSgD/s8/osFk
 RwmoraibnuQKBJjGv9H71RSct0qulXm8GqvTG8wsbsoGunDwJLgB/Nq/XZd71UCzEelPghPqw
 VlGbRf7Zu35KMig6f0OOxgt/AGcgg/vk3JKV+QJnWuiBmDDUlcFPDeGcio0IhUJmBOFkm9RT9
 NCBYn9Vp6/P9XWKZQppMUDENxRTvmLKW2LUktVHjrnSKRHXYnkxIV9lJMslEwoNosYLtZ5yod
 nQC+cGu27N4+J6wXMTCAcp/4XhI1/hjn8O2SzUw1MuOAnEML7OiNH3sCwH6cHFGQ2TImPb5d5
 072nOCg7OILlJZLnPNNzzWwZxNunTYSPmxLvfP3LAnV+ERH7R+idskAblJSGFBDBbgkjAzLRP
 pLp1gqeWaGovASzAZAHyh7i/xmW/8aDZgFb854a1sbDn+KkisWdm8qFCYgLDqCEOo4LnF72kK
 GKoS0TCtP2FfwAWangdEHmA9GXgab6GVb4K5OXGFyXlSzW7u8+BBrZutMgRSmP9NJKR1rR3V2
 HLZp54mVtIs+XTJf+QcL9wKZ31GioXChzyAdcDQXL0H8Y+ss0Q9EYA3gY3dPRnN4FTKqHttY8
 21uDNrKlDp2hee6lXovTnA+CC0cR6x9JSDoxUtHeNcdETUlsxvJ6nY8xhJD4KtiO7I55FuGeb
 VZXJTh+ZZV64g6X3BHmxvyT4JzWgcnMtmoCjlo4YuwXo3xlciMP0DtLyqFBGKMMqeNy9De2kX
 EOUXs8qsi9/wFo6JMmLoiijLUIenAtEipu8Qi5eEkOne9063/ZUXwq1j5s4XQQHoqpdKLbwaj
 fUTBA1AiQHTTA4=
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Hi,

On 20.04.22 at 07:30, Jarkko Sakkinen wrote:
> n Sat, 2022-03-26 at 04:24 +0100, Lino Sanfilippo wrote:
>>
>> Hi Michael,
>>
>> On 25.03.22 at 13:32, Michael Niew=C3=B6hner wrote:
>>>>>
>>>>> Lino, I'd be happy to test the patches, when you have time and inter=
est to
>>>>> work
>>>>> on this again!
>>>>>
>>>>> Thanks, Michael
>>>>
>>>> It's quite easy to test them out. Both fixes are in the mainline GIT =
tree.
>>>> E.g. give a shot rc1, and please report if any issues persists to:
>>>>
>>>> =C2=A0 linux-integrity@vger.kernel.org=C2=A0
>>>>
>>>> BR, Jarkko
>>>
>>> I don't see Linos patches on mainline. Also, the series included four =
patches:
>>> [PATCH v3 0/4] Fixes for TPM interrupt handling
>>> [PATCH v3 1/4] tpm: Use a threaded interrupt handler
>>> [PATCH v3 2/4] tpm: Simplify locality handling
>>> [PATCH v3 3/4] tpm: Fix test for interrupts
>>> [PATCH v3 4/4] tpm: Only enable supported irqs
>>>
>>> Three of them are relevant for the interrupt problem, which is still p=
resent in
>>> mainline, as these patches were refused:
>>> [PATCH v3 1/4] tpm: Use a threaded interrupt handler
>>> [PATCH v3 2/4] tpm: Simplify locality handling
>>> [PATCH v3 3/4] tpm: Fix test for interrupts
>>>
>>> Michael
>>>
>>
>> You are right, the interrupts are still not working in the mainline ker=
nel.
>> I would gladly make another attempt to fix this but rather step by step
>> than in a series that tries to fix (different) things at once.
>>
>> A first step could be to have a sleepable context for the interrupt han=
dling,
>> since in case of SPI the accesses to the irq status register may sleep.
>>
>> I sent a patch for this purpose once, but it seems to have gone lost:
>>
>> https://lore.kernel.org/all/20210620023444.14684-1-LinoSanfilippo@gmx.d=
e/
>>
>>
>> Best regards,
>> Lino
>
> I went these through one by one>
> # Above linked patch
>
> Boolean parameters are considered bad. I.e. use named flags
> instead. This is for above linked patch.

Ok, we could extend tpm_tis_flags by a flag "TPM_TIS_USE_THREADED_IRQ"
for this.

>
> # [PATCH v3 3/4] tpm: Fix test for interrupts
>
> 1. Please remove "unnecessarily complicated" sentence because
>    it cannot be evaluated. It's your opinion, which might perhaps
>    be correct, but it is irrelevant for any possible patch
>    description.
> 2. There's no such thing as "fix by re-implementation". Please
>    explain instead code change is relevant for the bug fix.
> 3. If set_bit() et al necessarily to fix a possible race condition
>    you need to have a separate patch for that.
>
> To move forward, start with a better summary such as
>
> "tpm: move interrupt test to tpm_tis_probe_irq_single()"
>
> I'd also either revert the change for flags, or alternatively
> move it to separate patch explaining race condition. Otherwise,
> there's no argument of saying that using set_bit() is more
> proper. This will make the change more localized.
>

Ok, I will split the fix for the irq test into two patches then.

>
> # [PATCH v3 2/4] tpm: Simplify locality handling
>
> "As a side-effect these modifications fix a bug which results in the
> following warning when using TPM 2:"
>
> Generally speaking, the simplifications should be done on top of code
> that does not have known bugs, even if the simplification renders out
> the bug. This is because then we have code that have potentially unknown
> unknown bugs.
>
> I hope you see my point. The problem with these patches were then
> and is still that they intermix bug fixes and other modifications and
> thus cannot be taken in.
>

Yes, I can see that point.

> BR, Jarkko
>

Thanks a lot for the review. I will prepare new patches with the suggested
changes.

Best regards,
Lino

