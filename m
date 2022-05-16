Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4148E5291E9
	for <lists+linux-integrity@lfdr.de>; Mon, 16 May 2022 22:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbiEPUrq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 May 2022 16:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349840AbiEPUr0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 May 2022 16:47:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6849052E64;
        Mon, 16 May 2022 13:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652732635;
        bh=VyC8QyX7sgHGkbS2NC9o44wpKoZY8u3jPyic5oGJCMQ=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=JyBETNYbIOmIJ5k91O/YftGATrJceuQGpYWiOf1JVU5j8qd1Ux21s5W1ZQJpuy8m4
         +R71LdUkh1lPkfT0JaKvsjkXhuuLhKXXOmjkjzcGFMnjwy6SQgrnBOUr+tFPQtgJp4
         NSxQODiDkouq+oLlixY0/0pljgt8tXEwDolUY/ZU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.33] ([46.223.3.15]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEm6F-1o5mDZ3Jrn-00GJ3d; Mon, 16
 May 2022 22:23:54 +0200
Subject: Re: [PATCH v4 2/6] tpm, tpm_tis: Claim and release locality only once
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de,
        p.rosenberger@kunbus.com, Lino Sanfilippo <l.sanfilippo@kunbus.com>
References: <20220509080559.4381-1-LinoSanfilippo@gmx.de>
 <20220509080559.4381-3-LinoSanfilippo@gmx.de> <YnudhZZGXf87U3bd@kernel.org>
 <f576a24d-d175-0153-9992-f6dd80d57b62@gmx.de> <Yn6cjJTj1SdS73pY@kernel.org>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <dd421552-40f8-b5c2-5d5a-cc9ce3bdb760@gmx.de>
Date:   Mon, 16 May 2022 22:23:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <Yn6cjJTj1SdS73pY@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JdiFnnuOr3j3Ay6gbINZHdqdAYvdcIMcjwV6Y8CZubJGyCOvXcG
 LxHhyCxIr5DETHRXDa8lrpYY6lY3U9DFsy3cXik+2AZIexUNoTygxdsGsQ1T4JdeNmKYTFN
 tYAbG0cP/4zIUMmiar0Ot5sJEf1q703fZ20lLMRT3M3TiUyeEYj19V8xbcVWy5+aTQTKg9F
 opuJnXKjx5wfeuNAzV3lw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/kq/WsybgU0=:eku5zHSUyA2FccUVfz8yFL
 bUq+vVbAvEbQQVZcgoLvzJH9gvocH9nAb09l56FtptOpxBUtETEKeNgb0y+/MUFZSUcx6SpBJ
 266FvrOLJBZHf/pW4+dTnmBi4YxOaBSu3yUFlP4fED0oIwQuHXLWyCQB2v/oM7wtkH9UEhmV1
 VfEr1EexxlnAK1e03B0/NCngKfHsxvP7X6acNJMTYNQz0CzxkKSRx9T1P2HvyeHDGaYKoVwbY
 oXLo1kVKuISy4FdWAOll0Nm99PWTxeboFslRi3yG6qPkZUWtaMYJmCvqbS+kcRiBLloc1xdWk
 gX9s0Jz+QMhUahHJGfLuHUulzI148Uh47268F3Y7bLrYwdP0OtCOG7ctZAqBpxkIVZcWb3PnP
 8V6j7GzcOeNF5FgS3S4kIo6MzjrPTC2aYe1E3CGTdgKNhNfArhK7qsp67jNPf4iuR/diQu56i
 p3g5KCR6yfGI5XD5SO+QYW34Tc6Y88WsLnsioBGf5IOCcODZBEEYUy31milDxusMudDytzL0W
 QSifPYFiTbsb7sR/b39rKIkKjEpNBfzgT7BNJOmNbQTeJ9ppBLGtk4gjamzwxmpuPdj15sCEm
 D4mN6Qr93KQyh0XZrLAPFeKZhMcuSXa9FIFN21YIEX4rsVlaGI6ypc3iF4SM3YS7NA3ZyyaAQ
 AE62/z4DCEo9W08aYGluUS82PlhTAU1fJEqUxqxcA6pwbbU7654/4jnIuiROOEAhaVuUEJ/G0
 C9yg9ldTcrHfVMSvaGcMfHSZk1qZIU+GcvZ6hTlIC9Y+xEYbn6GAZ7DUCX63nyhnRJ/Y+2XoN
 8WSxFDH3jXaaODMi1Yu+a94bC749Sv2Kx5CPQMA9QHWUPoGy06pkgatqjAkfMIDe3q/PJb37p
 +bR1SeuvXG1bZhsJ3DbjNlDVqMxR471Mn2f2Mr6kt6TAsC7u9WZLHFDDsXvgumPm/Ou0tJgJq
 yUe4evty9ggGqXSsGGb++SYZ9S16F+q8ZG2thlyz0eMOuiv7qxmYy6TfMVwkn2DxjO/yXymP+
 Q9HXJ/dbCQF9rkYDgfSC2/yYEb8To+WviTOE31OTuOMIeEN6uNwdUkjLvFpgU6YaEF/lEace6
 xVXJZJflRl27QJiWxcNxuFe9f6WSLUJLd907Ofx1mH7nI3sdaegk3D/Pg==
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 13.05.22 at 19:59, Jarkko Sakkinen wrote:
> On Wed, May 11, 2022 at 09:29:57PM +0200, Lino Sanfilippo wrote:
>>
>>
>> On 11.05.22 at 13:27, Jarkko Sakkinen wrote:
>>> On Mon, May 09, 2022 at 10:05:55AM +0200, Lino Sanfilippo wrote:
>>>> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>>>
>>>> It is not necessary to claim and release the default locality for eac=
h TPM
>>>> command. Instead claim the locality once at driver startup and releas=
e it
>>>> at driver shutdown.
>>>>
>>>> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>>
>>> We are doing what we're being because of Intel TXT:
>>>
>>> https://lore.kernel.org/tpmdd-devel/20170315055738.11088-1-jarkko.sakk=
inen@iki.fi/
>>>
>>> Unfortunately cannot accept this change.
>>>
>>
>> I do not see how the patch affects the crb code since the only changes =
concern the
>> tpm_class_ops of the tis core. AFAICS crb uses its own set of tpm_class=
_ops
>> which are still used to claim and release the locality.
>>
>> Or do I miss something?
>
> Ugh, yes breaking everything when TXT is used with tpm_tis.
>
>> Regards,
>> Lino
>
> BR, Jarkko
>

Ok, I got it now. The idea of this patch was to maintain the locality 0 fo=
r the whole
driver lifetime, so that we can always be sure that the locality is alread=
y claimed
when the interrupt status register is read or written in the interrupt han=
dler.

But of course this does not work if some other instance like TXT also want=
s
to claim localities.

I will try another approach to make sure that the locality is already take=
n when the
irq handler is called and only released after the handler has finished.

Regards,
Lino

