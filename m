Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 899C8528FEA
	for <lists+linux-integrity@lfdr.de>; Mon, 16 May 2022 22:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235554AbiEPUIT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 May 2022 16:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348896AbiEPT7C (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 May 2022 15:59:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F88613F1C;
        Mon, 16 May 2022 12:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652730726;
        bh=UNy2J4fkb7uNrb3sdw6sHacgYSf5R/YKgMseuZ9qomo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Fjz4O2JLj2wqI2k0QgbiyH2kXrx6LvpDfEBAcTqr0ZI6FUW9j8PY4F53LE0I5Y83G
         90d1QoQx8ZBtPauOijPKcTi7wYphQO5FOj1y8qejkCj2tJAm0hlUTfHaVdpSW1o0An
         3QQ/CuTjDvIR5xI20pZe/RD95oSU661YFNG50dUQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.33] ([46.223.3.15]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MxUrx-1nfu511aQ5-00xrE8; Mon, 16
 May 2022 21:52:06 +0200
Subject: Re: [PATCH v4 1/6] tpm, tpm_tis_spi: Request threaded irq
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de,
        p.rosenberger@kunbus.com, Lino Sanfilippo <l.sanfilippo@kunbus.com>
References: <20220509080559.4381-1-LinoSanfilippo@gmx.de>
 <20220509080559.4381-2-LinoSanfilippo@gmx.de> <YnucgDH3I87RI8PN@kernel.org>
 <486cec01-ec02-3f11-0b81-037e0700c503@gmx.de> <Yn6esMyUl+QhECq+@kernel.org>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <1b306d56-c6b3-e51f-1d63-2f6725fa7557@gmx.de>
Date:   Mon, 16 May 2022 21:52:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <Yn6esMyUl+QhECq+@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4mC90Cdt0908TfXcpU5kwIXZz/I20/o2aOoBpxBAi66+E7Wo5K/
 9HAf13p9g462Tnkmpi2VW7QmLUEFEzu2E2yb51VYlr+cJdI4tQKFFgjG7kaNn8nbbV0x/Cj
 cs9pqMkVIibMHiar7fnJ5sFGY2MXVmfP32mgNCdnJbKWTOdvCOdRcyGOA9NPArg5lOrpAd5
 Dm+Tom95PQVg2+AOS3mZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ali3R6o1Nco=:FAflsnwg8QiH9PVILyYXGD
 GTRbwY9PsAKZwlgZiWSlnRQMZvVbiJXlEW2h2ORxTiHu8lmzir892Br2UPFmm29VM3Zn4pBRj
 sgPIymAHRgL1RNmdZJoO5jCEtiFbLm85LWbF+YCU1+l2v/JAMa23JT7izUAoORyqhQbEvxOQV
 8C3WA9oIPfh5QhM6j+IbKYpCQcNVOaZB4rFZzfUzgb4mMGLLxaCQAgK3tkOJPlriChkZv8TiZ
 9WjDTtOICTWfJsjvLhd0+kYzuff+/rXriOSmi+Sp8baBqecFDQ+La1yhoaeDZvkza5k5uflFt
 1BbptbxzujRdpQW96/DRnBZ8d3j3zYpz4+94RxJbf27TwY3qnj4QT3DkAec2FBZxM8yzq+T6p
 IIOEZgwFcag2kqCilP/xhaDJIKefkS+F97NiWf3j/JbrdVIhPMoRy8kJB2lMkO8zxFUUDORx2
 09CUiEYIA9JMglKC4bLNVafI+4WQSPUVJOFQVVZgMDlq88CxDOUOexSiaMmDeL0VMRDgw4Gui
 VgRGm0h6R6EKjF6PpnhgEqdnGV5oownSbAdSvHmKJGcV8wI73Kt/YMf0d6ELseFen+21iuBq7
 9WLvuWUcUmxgJoPjGaG99E5X8JGQKjdcpq1w4u8T5v4YKWfkRZcYS0RCLAXJk7J1q05RTk8lG
 B+lWKMaJuVTbQiygNvAFUknvJ3f5/BVkGy+QAy2hc5HoDUMgyP9v4kVIOGq4l3DEFOpqSW0Fo
 ccbg20bVPoI+vZBr5JNBBBuiu8OpNPJWjDl3shd29Jdo32WrkP6EjGiVAj6CvCxMwtnT0znhX
 cEELp9zRqFdPWpvZ/lwvQODWxgDX1K3qo99nyLPUI+iJu8nR0CzK8QZSrG6l4HTGHANA6SOAJ
 o2+MT/Btwo3lBwzoocUeBiwTX1zVCltzJoFVUHiQRIft13S9gBg3bcYf+rsLMtNXvPiByjceb
 wazeHzMOodKIJvtRZuxIIw4f4N8deNHpEgWKXI5BmbD2OIdwZTEXxWkjrnClHfAvbWgdSspHz
 C9ZIaTp2qmEGPKuG0nCXKh4JvvZ1BdNmORkdYLgj1uqzsGq52ZS1/Gd32zipeZzHC+GeQW9q+
 mEhon8fngHIfaaGq7CTTnNNhCGUK4MvrFbG3vVm0drApIfSvTyOuQVe0Q==
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

On 13.05.22 at 20:08, Jarkko Sakkinen wrote:
> On Wed, May 11, 2022 at 09:18:39PM +0200, Lino Sanfilippo wrote:
>> Hi,
>>
>> On 11.05.22 at 13:22, Jarkko Sakkinen wrote:
>>> On Mon, May 09, 2022 at 10:05:54AM +0200, Lino Sanfilippo wrote:
>>>> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>>>
>>>> Interrupt handling at least includes reading and writing the interrup=
t
>>>> status register within the interrupt routine. Since accesses over the=
 SPI
>>>> bus are synchronized by a mutex, request a threaded interrupt handler=
 to
>>>> ensure a sleepable context during interrupt processing.
>>>>
>>>> Fixes: 1a339b658d9d ("tpm_tis_spi: Pass the SPI IRQ down to the drive=
r")
>>>> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>>
>>> When you state that it needs a sleepable context, you should bring a
>>> context why it needs it. This not to disregard the code change overall=
y but
>>> you cannot make even the most obvious claim without backing data.
>>>
>>
>> so what kind of backing data do you have in mind? Would it help to emph=
asize more
>> that the irq handler is running in hard irq context in the current code=
 and thus
>> must not access registers over SPI since SPI uses a mutex (I consider i=
t as basic
>> knowledge that a mutex must not be taken in hard irq context)?
>
> There's zero mention about specific lock you are talking about. Providin=
g
> the basic knowledge what you are trying to do is the whole point of the
> commit message in the first place. I'd presume this patch is related to =
the
> use bus_lock_mutex but it is fully ingored here.
>

Ok, understood. I will amend the commit message to make more clear that
reading and writing registers from the interrupt handler results in
a call to tpm_tis_spi_transfer() which uses the bus_lock_mutex of the
spi device and thus requires a sleepable context.


Regards,
Lino



> BR, Jarkko
>

