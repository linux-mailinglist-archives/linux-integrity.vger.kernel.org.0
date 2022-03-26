Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3081A4E7EC4
	for <lists+linux-integrity@lfdr.de>; Sat, 26 Mar 2022 04:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiCZD0z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Mar 2022 23:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbiCZD0x (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Mar 2022 23:26:53 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDA115E8AB;
        Fri, 25 Mar 2022 20:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1648265098;
        bh=7oP7pvkRPSKA/+PtnbLt5kAWR1EhLThMuSll1ajJ+24=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=h8XvCDAwPO3Fl2Gs9NNvI/BZhtXgXDvOKfPbLgU75xs+Int50yfQG2ue7lP4unS2x
         uAS4k7y00W/bQ9L7LaZrlfDq8Fz3cogRpCYvZ9/miVKhwZYBcA76Nwxzb7e+V08fEG
         VL0p+EAYOaRDRDCxu3FNjJaCPcdOnYKh5P6mx5/g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.33] ([46.223.2.76]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmUHp-1nyWJ120qP-00iVEH; Sat, 26
 Mar 2022 04:24:58 +0100
Subject: Re: [PATCH v3 0/4] Fixes for TPM interrupt handling
To:     =?UTF-8?Q?Michael_Niew=c3=b6hner?= <linux@mniewoehner.de>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        stefanb@linux.ibm.com, James.Bottomley@hansenpartnership.com,
        keescook@chromium.org, jsnitsel@redhat.com, ml.linux@elloe.vision,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        twawrzynczak@chromium.org
References: <20210501135727.17747-1-LinoSanfilippo@gmx.de>
 <20210501135727.17747-3-LinoSanfilippo@gmx.de> <YJAby8mmiJ74qWAh@kernel.org>
 <6722bf6f-1a3f-ee9c-55e2-cf63c64266a9@gmx.de> <YJNKs8bUMGOzFre+@kernel.org>
 <2a1a1cf61732eff1608aeae74054a0c135c1671f.camel@mniewoehner.de>
 <Yj0lhqTP1RoedxSc@iki.fi>
 <0d6c22b40a2f17d4b260f287d4c479a96a88b0b1.camel@mniewoehner.de>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <efdb99b3-6d33-38b1-64a0-671821101631@gmx.de>
Date:   Sat, 26 Mar 2022 04:24:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0d6c22b40a2f17d4b260f287d4c479a96a88b0b1.camel@mniewoehner.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:8qRPJcajsFdXGC6Xf69Y8Hu5wTpFxllwWC7zfLp9+wKNNVw8ZT6
 w3SlF19EKsK3UmZTycjcavFLkiOF+y8i3X/XMWztVF3x/zaYS892KVIG7t3kUHa5kY/VbMB
 9k5gWJ7cyeAyOCN43NcpgSb4LWcu37ji6O/fpUy4pgV2o9scYgCNTETfR2BYOIZWqWmchiE
 odlwM+QfX9t/8nRJJ2kow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QZLz9T8rSsc=:J2R7AO4DyGQkmKrh6GnuuD
 G0tWFI5Ki78XWdOEIUboVzlkQPYn4KoNiDUMZqxCrc7fZzHUAQslIICHewflOY0hk0WVcnO4R
 XJSoqXmYnV4qSzI6W73NaKKgu4BNBzcuvCBlVzEdKnApgo8npXw6KVA4be1yffNwaMpvC+Pmh
 TvPP8K4MrqDbUROypMmCWNBAVLm9f1shByJj2f5oz71itVxQx/RN4YOAe6l7+zdBtZlB+Rw0/
 VV37qjjPX997X7PGmM/wVWp07RACm4R46Kk1MOnH3ARFxUaRfajPZVi+b+pTXxuAiaOSqBOoL
 RuLjzN4+YYsrQW5mfaLzrQnaQgUfCknakSXuiRNsd2H2kBYpOaiYUK5dUTvvJhd7bL3FCy9oN
 1faJWEYT8hSFTvwndWsW4/6QwGW2vfwKa19mteIobKX89j6YFoSj9ScihT5iC/jlN1ZKCzfI7
 t3j3dT5MsPnWB4o7OkfVdKzoGN3SFTr7RWYDirQNW5ghwBn4SnEJkPBeg7/QX9/i/hZ2q506w
 Kf7oEmloXbEyjJ0ANlx7FZksaYNIi9BcxBKB5NEYsUzWciLjOo7+qKV3FvsjlUZtBErV8Wagp
 5fOJpi6rBWZ4pWUoTkPRae4zzGB1WEnCtYiEwAMPOgYpytEk/5ArqYtqeE9AKWzx2IeBdNJFJ
 Pq5RxY6JIwxaZFlKLMiPuxNl/MauzXuRmCTXaoO6ITXmaYpSrQUOC2dQ9RV3jD5448yJlJa8o
 tchErXzVJOudvnARMV6fSQnDzNiQ5+19s+qNfZHRzvDVNizB0OPiYrMnzNUz3YPhgb3N/0OWR
 FUdIdaV5gH42afWI14o5uhE7kCKD6WDMzIUtqVZPWZF1aivjasFrhIRWqXZ/AXobI5wsHXR+/
 QeB+7t0c4GbNhNX8DPbABGxYo2Zx69rAdKajRyrVNDNH35Cz2j9RRgR0lzCiDxQgztr5S+ZOs
 IdMaiACyOkWm26iIDaCSYl1JgqyJZk7tmDQiArFIT2oymXlqnb+1ugMKzD8opMIOlYH/kDTpW
 3KTasl4EF78ZHEuRGzwRB4PMn98sF1NjO4Zho35r7dbqGPDdSQxMFCaIWiiFMJXTlxUZMywJS
 Wq7kdBcrlAcwtQ=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Hi Michael,

On 25.03.22 at 13:32, Michael Niew=C3=B6hner wrote:
>>>
>>> Lino, I'd be happy to test the patches, when you have time and interes=
t to
>>> work
>>> on this again!
>>>
>>> Thanks, Michael
>>
>> It's quite easy to test them out. Both fixes are in the mainline GIT tr=
ee.
>> E.g. give a shot rc1, and please report if any issues persists to:
>>
>> =C2=A0 linux-integrity@vger.kernel.org=C2=A0
>>
>> BR, Jarkko
>
> I don't see Linos patches on mainline. Also, the series included four pa=
tches:
> [PATCH v3 0/4] Fixes for TPM interrupt handling
> [PATCH v3 1/4] tpm: Use a threaded interrupt handler
> [PATCH v3 2/4] tpm: Simplify locality handling
> [PATCH v3 3/4] tpm: Fix test for interrupts
> [PATCH v3 4/4] tpm: Only enable supported irqs
>
> Three of them are relevant for the interrupt problem, which is still pre=
sent in
> mainline, as these patches were refused:
> [PATCH v3 1/4] tpm: Use a threaded interrupt handler
> [PATCH v3 2/4] tpm: Simplify locality handling
> [PATCH v3 3/4] tpm: Fix test for interrupts
>
> Michael
>

You are right, the interrupts are still not working in the mainline kernel=
.
I would gladly make another attempt to fix this but rather step by step
than in a series that tries to fix (different) things at once.

A first step could be to have a sleepable context for the interrupt handli=
ng,
since in case of SPI the accesses to the irq status register may sleep.

I sent a patch for this purpose once, but it seems to have gone lost:

https://lore.kernel.org/all/20210620023444.14684-1-LinoSanfilippo@gmx.de/


Best regards,
Lino





