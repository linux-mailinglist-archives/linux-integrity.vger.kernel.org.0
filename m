Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D27F3732B1
	for <lists+linux-integrity@lfdr.de>; Wed,  5 May 2021 01:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhEDXTO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 May 2021 19:19:14 -0400
Received: from mout.gmx.net ([212.227.17.22]:37367 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231226AbhEDXTO (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 May 2021 19:19:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1620170286;
        bh=7+/WkLlrUW6nYbt1rR9XMX2K5sSRfuIx97po5iq3Bl4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=jKTJYemWjN8OTMWMJUpHaE8IISxB/5rGotHGlOa3cNwVgoUncXiGQt5b6MaHrC/q7
         vF+8JLQomowP2hOk0LaDvXkMU1Jo2dAi2tdU4z/GdfAS1tNhms8/pmqSjI+zxe3V+x
         ZsEQVRK5LtgYRwfkKY0LQuWwiORCHoPVjAQbhbPw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.51] ([78.42.220.31]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mlf0U-1lE7Ce07V4-00imJL; Wed, 05
 May 2021 01:18:06 +0200
Subject: Re: [PATCH v3 3/4] tpm: Fix test for interrupts
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        James.Bottomley@hansenpartnership.com, keescook@chromium.org,
        jsnitsel@redhat.com, ml.linux@elloe.vision,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        LinoSanfilippo@gmx.de
References: <20210501135727.17747-1-LinoSanfilippo@gmx.de>
 <20210501135727.17747-4-LinoSanfilippo@gmx.de> <YJAcPAbFopeW7PYs@kernel.org>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <eb0165fe-5f33-4779-e296-72ad8b386791@gmx.de>
Date:   Wed, 5 May 2021 01:18:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YJAcPAbFopeW7PYs@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0R+Txwn8tbP0MWRU0y0WdKIP3EqnGHISFlV7trkpOFQI5J9ja3w
 iUsVCZEPYGRciezP8wOsT5SZvqvWZVMsdG7IYtbm0mEapITuqfguGE6YpgS+zBiF6JWv6XL
 AGiqIHlgm5sUTnc6KGe9rOYx3/9vWYvxodtfvbcKHKIyid0zHaNGriAtNjJpoiloz4kzJBn
 IlKZfcEwv5TlDApKD1tBQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tEtWiAJGYO0=:jza5X506Qi8Tob9V5djziN
 +jTmn1Sxbu+GWOkTHCpSitj6GM7BUjUPKaDT85KBFgROHJAfrWhUNbZcBnn8JjWiF1MM9OF+M
 AL5XGRfQKUmIv0nlf8jSbgaYdCsbK+l3MIPuAhCB2sHUXQUxI3KR58fUmD2YW+PWTFdYqkAgq
 IRniMvGMPm70JTSCvOHwxLMEPByJYyFKUz0a09cIT9T0cPz5+nN+pKQ47smrVzMmoktMXVKeA
 CcdHeJr8ONIrlHxJ2yhMgkXmk4StXXvp8HFQbBTsFF1PtD7WZ8PslR7l5tsupijiLvBAbcttD
 8cLsgqtbvkLfV4o6XxGY3+AskN3ixB3n5LkYApHqoSzxvUO6GShDTw6Slc17idxDD/jxy14kI
 cY/AKlV+VQSOX9D2CPyxPEphBA4J3MjYDfbIedWrcpwwG/caxkNOQZ3dnTn1NUQWvGlYVfFeR
 k8LfPLsIAHtg1w9AxtSLTRy53fyWvYEoIMV1TlC5QfBvsTBUBkIBWjD3oK6JLaMik6ekZZfA2
 Afqo+78UG1HHG4LVm/0jsORpG+CUrkl6xNvmmYoEDZG0QH0XMNTeQC7p1utBJQaWNtXNmtNOI
 v9l/XNb7Q7Gwhav8IfLyJglXVcLqTPELy15ws7Ld+PpTRuH3nef5AyFmHlzbOYvW0I6p6oOkt
 jzkpy/ptwGYh/H2Dx4mGrjW0L/ctWHD5bdv7I6E3GLuRyPanFfweRwOZ4L2prlZumv4J5G9t2
 ZT5BxrQmjZRsnc2qYYGp4w27qwSPPoiFNIqdEzZnUB2bsFSHN00j9hbhpy2Q6PilN69XF53jY
 B4LueeeVumDOtkO9Cz1dCevHEezTcm2xTw9eRrl1ARoYSbGbFQweTu5hZDfsm/VyIWvNYpump
 g249c5ik3STQnfjWVt/+M1MWJOATKYJFHQ6JyFmoJ/o5Pm9BCC3hdL4QIs9D3hS1Hx9fO+bpI
 EowH3MSso89s1bA9Jyks1aIfm5ajxtXqDtuho9qJ8ZFha0rOLZG9FJY2Ob8pzBC4unMigRmcp
 PG3hi6p4WW7xVobLpz3kfdyiwxwbMqWtaYsSxgSt5z48ML5RIGI63rYpkyxvIl9w/Y60IfQPf
 mC68YH2PkTUexQGXqlGxf1d1LVigJ4QLpXFTZy2O2KV4XzWhESoADhv/KbYdcWXPUmkiCFGHb
 Ahpf3Ny5tAg8x/fXgsuxnb1jRYZrcUYBxL5kmfti+dal6ul5DsL7Ot6HrpNRzSogSeeDn2+yf
 ayfK2TDfVIXHo5sAp
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 03.05.21 at 17:52, Jarkko Sakkinen wrote:
> On Sat, May 01, 2021 at 03:57:26PM +0200, Lino Sanfilippo wrote:
>> The current test for functional interrupts is broken in multiple ways:
>> 1. The needed flag TPM_CHIP_FLAG_IRQ is never set, so the test is never
>> executed.
>> 2. The test includes the check for two variables and the check is done =
for
>> each transmission which is unnecessarily complicated.
>
> Unnecessary complicated is again terminolgy that I don't decipher,
> unfortunately. I get "something that works" or "has a regression".
> We don't polish things for nothing.

In this case "unnecessary complicated" means that we can achieve the same
effect (test for interrupts) with fewer code and fewer runtime impact.
Note that in the current code we do the same check for irq for each transm=
ission:

if (!(chip->flags & TPM_CHIP_FLAG_IRQ) || priv->irq_tested)
		return tpm_tis_send_main(chip, buf, len);

With this patch the check for irqs has already be done at this time, so we=
 dont have to
do this over and over again for each transmission.


>> 3. Part of the test is setting a bool variable in an interrupt handler =
and
>> then check the value in the main thread. However there is nothing that
>> guarantees the visibility of the value set in the interrupt handler for
>> any other thread. Some kind of synchronization primitive is required fo=
r this purpose.
>>
>> Fix all these issues by a reimplementation:
>> Instead of doing the test in tpm_tis_send() which is called for each
>> transmission do it only once in tpm_tis_probe_irq_single(). Furthermore
>> use proper accessor functions like get_bit()/set_bit() which include th=
e
>> required synchronization primitives to guarantee visibility between the
>> interrupt handler and threads.
>> Finally remove one function which is no longer needed.
>>
>> Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>
>
> Not sure why to take this patch.

All I can say is that this patch is supposed to

- fix one bug:
"...Part of the test is setting a bool variable in an interrupt handler an=
d
 then check the value in the main thread. However there is nothing that
 guarantees the visibility of the value set in the interrupt handler for
 any other thread. Some kind of synchronization primitive is required for =
this purpose..."

- simplify the irq test

- provide interrupts instead of polling

If this is worth taking is up to you, of course.

Regards,
Lino

