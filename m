Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E737436E15F
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Apr 2021 00:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhD1WO0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Apr 2021 18:14:26 -0400
Received: from mout.gmx.net ([212.227.17.20]:33903 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230218AbhD1WOZ (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Apr 2021 18:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1619648005;
        bh=VgbcSvcR1Ml6fja7kcjG7CS9QgO8edE4Ivt1dg5dXOk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=SfzHNMxm2KZJHKxtF0nQ2n/klF3LBuD1QEZLuE9/vPmgmyH0ajrt0oYWe52VYio/B
         qnFPkZ/7QqGXukRSu4voz86dB9h92FM5XusRyVFXy1WcdKgGj6QmiBRGz2eLtHpxy+
         UsEol2uLgbQylcW4X2bqb3EIpoMewPoM0DY1FhfI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.51] ([78.42.220.31]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2O6Y-1lbJP90jp0-003ty3; Thu, 29
 Apr 2021 00:13:25 +0200
Subject: Re: [PATCH v2 3/4] tpm: Fix test for interrupts
To:     Stefan Berger <stefanb@linux.ibm.com>, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, James.Bottomley@hansenpartnership.com,
        keescook@chromium.org, jsnitsel@redhat.com, ml.linux@elloe.vision,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1619394440-30646-1-git-send-email-LinoSanfilippo@gmx.de>
 <1619394440-30646-4-git-send-email-LinoSanfilippo@gmx.de>
 <e0b34384-d286-2251-bc43-0ee3083672b3@linux.ibm.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <b9ccf9df-2b0a-5bff-d38f-bad05cad9896@gmx.de>
Date:   Thu, 29 Apr 2021 00:13:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e0b34384-d286-2251-bc43-0ee3083672b3@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:815WgyqZhVu2kkp9EwZEODigR0/YyvsGaPFMjrAjar6H4C+1h/6
 P4M+7mPK/Xte91ZwiPW5ZAbZeTAYKrX+cgDQS6hml4WQ1tA7p/FvNMzfiTf8Dzxy9uTLH4/
 7Xsi5WQVBv8liP9w6LJVBEQG+WfgHVY8zhhDbDWloqeJKHoNN5u3fOGxxp8ERwjnLEg5u3k
 Y02M/DgUBJ2/zVco2dM/A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:E1YwGNTCWCI=:oFgcvmvS4cAqQjFntDfWiF
 4CqSn6BEpyND+owTJPXr2Uga9QDBe79cSBZvYMpGFjvqroYlHyqvvCtSK6F9/G8yaupKsRFP+
 YhW3NM0+J2JsqEAvUi1qJLo+jJFsiB9Zr5TaJ1H2lV9xzvOp7EqXPJeoeMzRvMzUDvm0Pt9MA
 r352h7rSc6bY6wZLVGE9l6+TBPueuGZtdWgD4GPDPEr8IoMJ/LA1XY0ifO4DET0vtJlas5Pb1
 L23JE94vf/7FzRSSEcbA65Lmr0+7hlmiQy9qQCWkwM7+ZYRQLEDTSkKf/V64SPqru9Lxz95nm
 qrhj5wqXiwwtBaRmKoHW5vM6DWyk2c0EMSOrgc+71XwG9m6CCE8IFaMfRl0mRJ+JC6tS33kQy
 2aZbsR5w+cL/060qYGAyf0NJ5WI0kym/fuzReIluXN8/D9IlP8v2vK6pIzvw17ur01JORsiQE
 n1rG31Dx4VyrllNLxRgrolS75fi7e9gkMn62gcK6quYqcXBB0zsYfJy+VdRPhOtFt69iee59E
 lmApWTtPGLs2589RS/+ylWywNRplrWG79SPkdWickcgi6oizvzs54EkKLAcnOLvvV2V6jCAzF
 9FEqKF2TVwORee7EVX4RMComWF68lrkWbP6kp67hYVP0RDowuF5u51Y8QIk2JDcSWwbYYr/ao
 0Wwu50cZB8NwZ2zU7qvA7lK+jYR2M5a13M5rLZo8Uq/RkXYCnGXUrauUtEKLIwfidNIdxMl4L
 aIR5fVjyBCxxG3r/rDmWCf3UuueJgpie8ZIIqONMjBUBXOYxdOe7TMANNqdySPQT+9jhZ/L59
 E+RHfg0gC31I3RO5kmgePW7qj04xJbJd/aWQwaaFJrRZ3baAM5Uio2gLv+dkFnrNHI94cpF6k
 SEgKG8x3qqHl8QOYP6gLB8VX0lCUIku72FBml5XJrMxYeiuLSpFIi0gVv1lQuXB674sPRRRHE
 MA6qgAtdToPGdZAu1XkTTkFrUAA+BzC67ckbPAQ7ioyPlG69NLwNoIdDelVn2KJu1qzStXQOg
 KOjbVvasbV438FCOWfhRltu1xUnqFPOH8So6b8bKdrAh4MpUsexQX0QD78GUMDpBpx7u6gVbu
 O+Ob9ljCcv+EXH+Rn6uRimqDZeGUn3IuQzzaUCfOB/xnUySAxjNEJPT0vb8hnTvghtgYO81al
 xhUFEAfbs1dKJijFvVWCuUC0UjwTdSbOBY/sT8af5U4uijfMO/k1JYl38OBZW5D04ng8t6PlU
 UNUGSLg7JfPrnRiVc
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Hi,

On 26.04.21 at 16:49, Stefan Berger wrote:

>> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
>> index 55debe6..e9882acf 100644
>> --- a/include/linux/tpm.h
>> +++ b/include/linux/tpm.h
>> @@ -126,7 +126,7 @@ struct tpm_chip {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct tpm_chip_seqops bin_log_seqops;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct tpm_chip_seqops ascii_log_seqops;
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 unsigned int flags;
>> +=C2=A0=C2=A0=C2=A0 unsigned long flags;
>
>
> This doesn't seem to be necessary.
>

The bitop makros require an unsigned long, leaving it as unsigned int resu=
lts in
a compiler error:

error: passing argument 2 of =E2=80=98test_bit=E2=80=99 from incompatible =
pointer type [-Werror=3Dincompatible-pointer-types]

> The rest looks good to me. I remember that last time I had tried to acti=
vate it some laptop didn't cooperate and we ended up reverting some code, =
but maybe your changes fixed all of that now. Though you may want to 'prep=
are for unforseen consequences' :-).
>

You may be right with your concerns and I will try to find some more hardw=
are to test the patches.

Thanks for the review(s).

Regards,
Lino
