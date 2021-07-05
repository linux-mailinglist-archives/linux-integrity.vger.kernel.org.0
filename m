Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521DE3BB6C9
	for <lists+linux-integrity@lfdr.de>; Mon,  5 Jul 2021 07:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhGEFb7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 5 Jul 2021 01:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhGEFb7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 5 Jul 2021 01:31:59 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E289C061574
        for <linux-integrity@vger.kernel.org>; Sun,  4 Jul 2021 22:29:23 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 21so15755851pfp.3
        for <linux-integrity@vger.kernel.org>; Sun, 04 Jul 2021 22:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DFa7RLICkFXa9fvIrJ8ohYpnqijKShzMk4kSQaihib0=;
        b=Z6+5u0zRITL3EaKFGI9U9xja9XQkrqcNWSib/Fplcgps2lwadlj/8RerrbmoH2S1rP
         HupPXnaBDQkZN5XAWutCevKncISpu/oQSDGPUnlqx8+fSjQc+gIKxWGA4wpegCdSHiIb
         D47/DMjMGRGfSUEv6P2iOpOxglUHaFlBJhlbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=DFa7RLICkFXa9fvIrJ8ohYpnqijKShzMk4kSQaihib0=;
        b=VCVk+ABsTe2NyjFtBO8atsLmL5+IO1FldDumSQmETNKsDq8dEWaBCZcBZqQSuwTtrN
         HPFlHUJLX3paVDaztPuI6dD0H0LEGpAyrdXreqyiRyXHpw87HtQjXQolChy/AykqSG19
         CI96WcErCT93xcn85aVmvnfwJtRjpCl6Xw5V5qpnniRv1rQZxjYqgJDbu0LC3oqCrIuI
         nRIXG4gBeLFq8Bi0188vuJ4sw1w82PWQ94v7Vmo/nAcjJ0rUCYD/QRg24uxP1xOFlErR
         qShTHwuNnr8HIp8+KB6RXsgmqN8SFjqUNVgIjI6RdkCyiykxUUSigxYoM1UoNxjjDV2S
         RGqQ==
X-Gm-Message-State: AOAM533f6VjfU99Lrcq/aJV9hlfFOWSJh5uk7AmtHz+w3CXlkVXmvuoe
        cbyO25rlt8uxwq3eo6Tokn8dLg==
X-Google-Smtp-Source: ABdhPJwv7Iae3ZR6fJeDTk3jFA0gMH/0WlW3FZ4+prs6MhA48v4e/6SsPFE9/6V9k5VVqq93/57sIw==
X-Received: by 2002:a63:7d15:: with SMTP id y21mr13900734pgc.352.1625462962501;
        Sun, 04 Jul 2021 22:29:22 -0700 (PDT)
Received: from [10.0.0.5] (c-73-231-56-47.hsd1.ca.comcast.net. [73.231.56.47])
        by smtp.gmail.com with ESMTPSA id t9sm12571934pjs.50.2021.07.04.22.29.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Jul 2021 22:29:22 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH] tpm: fix ATMEL TPM crash caused by too frequent queries
From:   Hao Wu <hao.wu@rubrik.com>
In-Reply-To: <20210705051955.53zoge4rkeocmfyr@kernel.org>
Date:   Sun, 4 Jul 2021 22:29:20 -0700
Cc:     Shrihari Kalkar <shrihari.kalkar@rubrik.com>,
        Seungyeop Han <seungyeop.han@rubrik.com>,
        Anish Jhaveri <anish.jhaveri@rubrik.com>, peterhuewe@gmx.de,
        jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Ken Goldman <kgold@linux.ibm.com>, zohar@linux.vnet.ibm.com,
        why2jjj.linux@gmail.com, Hamza Attak <hamza@hpe.com>,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        Nayna <nayna@linux.vnet.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <92609566-7B8B-4BE6-8F15-F9E39F773D2A@rubrik.com>
References: <20210624053321.861-1-hao.wu@rubrik.com>
 <20210630042205.30051-1-hao.wu@rubrik.com>
 <20210702063555.q2phirfv7wxc6axu@kernel.org>
 <939BC11F-0905-4777-9DD7-630FC28ED205@rubrik.com>
 <20210702074518.64gyockmqrphbkqx@kernel.org>
 <559CEFEB-EE60-464B-A847-9E1C3B5F5BC4@rubrik.com>
 <20210702084239.svkmfw7r3y5auus3@kernel.org>
 <20210702115715.gyqfdk6ksgqzeenm@kernel.org>
 <AB80469F-821A-45D0-878C-7ED97C8B44BF@rubrik.com>
 <20210705051955.53zoge4rkeocmfyr@kernel.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> On Jul 4, 2021, at 10:19 PM, Jarkko Sakkinen <jarkko@kernel.org> =
wrote:
>=20
> On Fri, Jul 02, 2021 at 12:16:12PM -0700, Hao Wu wrote:
>>=20
>>> On Jul 2, 2021, at 4:57 AM, Jarkko Sakkinen <jarkko@kernel.org> =
wrote:
>>>=20
>>> On Fri, Jul 02, 2021 at 11:42:39AM +0300, Jarkko Sakkinen wrote:
>>>> On Fri, Jul 02, 2021 at 12:59:18AM -0700, Hao Wu wrote:
>>>>>> On Jul 2, 2021, at 12:45 AM, Jarkko Sakkinen <jarkko@kernel.org> =
wrote:
>>>>>>=20
>>>>>> On Fri, Jul 02, 2021 at 12:33:15AM -0700, Hao Wu wrote:
>>>>>>>=20
>>>>>>>=20
>>>>>>>> On Jul 1, 2021, at 11:35 PM, Jarkko Sakkinen =
<jarkko@kernel.org> wrote:
>>>>>>>>=20
>>>>>>>> On Tue, Jun 29, 2021 at 09:22:05PM -0700, Hao Wu wrote:
>>>>>>>>> This is a fix for the ATMEL TPM crash bug reported in
>>>>>>>>> =
https://patchwork.kernel.org/project/linux-integrity/patch/20200926223150.=
109645-1-hao.wu@rubrik.com/
>>>>>>>>>=20
>>>>>>>>> According to the discussions in the original thread,
>>>>>>>>> we don't want to revert the timeout of wait_for_tpm_stat
>>>>>>>>> for non-ATMEL chips, which brings back the performance cost.
>>>>>>>>> For investigation and analysis of why wait_for_tpm_stat
>>>>>>>>> caused the issue, and how the regression was introduced,
>>>>>>>>> please read the original thread above.
>>>>>>>>>=20
>>>>>>>>> Thus the proposed fix here is to only revert the timeout
>>>>>>>>> for ATMEL chips by checking the vendor ID.
>>>>>>>>>=20
>>>>>>>>> Signed-off-by: Hao Wu <hao.wu@rubrik.com>
>>>>>>>>> Fixes: 9f3fc7bcddcb ("tpm: replace msleep() with =
usleep_range() in TPM 1.2/2.0 generic drivers")
>>>>>>>>=20
>>>>>>>> Fixes tag should be before SOB.
>>>>>>>>=20
>>>>>>>>> ---
>>>>>>>>> Test Plan:
>>>>>>>>> - Run fixed kernel with ATMEL TPM chips and see crash
>>>>>>>>> has been fixed.
>>>>>>>>> - Run fixed kernel with non-ATMEL TPM chips, and confirm
>>>>>>>>> the timeout has not been changed.
>>>>>>>>>=20
>>>>>>>>> drivers/char/tpm/tpm.h          |  9 ++++++++-
>>>>>>>>> drivers/char/tpm/tpm_tis_core.c | 19 +++++++++++++++++--
>>>>>>>>> include/linux/tpm.h             |  2 ++
>>>>>>>>> 3 files changed, 27 insertions(+), 3 deletions(-)
>>>>>>>>>=20
>>>>>>>>> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
>>>>>>>>> index 283f78211c3a..bc6aa7f9e119 100644
>>>>>>>>> --- a/drivers/char/tpm/tpm.h
>>>>>>>>> +++ b/drivers/char/tpm/tpm.h
>>>>>>>>> @@ -42,7 +42,9 @@ enum tpm_timeout {
>>>>>>>>> 	TPM_TIMEOUT_RANGE_US =3D 300,	/* usecs */
>>>>>>>>> 	TPM_TIMEOUT_POLL =3D 1,	/* msecs */
>>>>>>>>> 	TPM_TIMEOUT_USECS_MIN =3D 100,      /* usecs */
>>>>>>>>> -	TPM_TIMEOUT_USECS_MAX =3D 500      /* usecs */
>>>>>>>>> +	TPM_TIMEOUT_USECS_MAX =3D 500,	/* usecs */
>>>>>>>>=20
>>>>>>>> What is this change?
>>>>>>> Need to add the tailing comma
>>>>>>>=20
>>>>>>>>=20
>>>>>>>>> +	TPM_TIMEOUT_WAIT_STAT =3D 500,	/* usecs */
>>>>>>>>> +	TPM_ATML_TIMEOUT_WAIT_STAT =3D 15000	/* usecs */
>>>>>>>>> };
>>>>>>>>>=20
>>>>>>>>> /* TPM addresses */
>>>>>>>>> @@ -189,6 +191,11 @@ static inline void tpm_msleep(unsigned =
int delay_msec)
>>>>>>>>> 		     delay_msec * 1000);
>>>>>>>>> };
>>>>>>>>>=20
>>>>>>>>> +static inline void tpm_usleep(unsigned int delay_usec)
>>>>>>>>> +{
>>>>>>>>> +	usleep_range(delay_usec - TPM_TIMEOUT_RANGE_US, =
delay_usec);
>>>>>>>>> +};
>>>>>>>>=20
>>>>>>>> Please remove this, and open code.
>>>>>>> Ok, will do
>>>>>>>=20
>>>>>>>>> +
>>>>>>>>> int tpm_chip_start(struct tpm_chip *chip);
>>>>>>>>> void tpm_chip_stop(struct tpm_chip *chip);
>>>>>>>>> struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip);
>>>>>>>>> diff --git a/drivers/char/tpm/tpm_tis_core.c =
b/drivers/char/tpm/tpm_tis_core.c
>>>>>>>>> index 55b9d3965ae1..9ddd4edfe1c2 100644
>>>>>>>>> --- a/drivers/char/tpm/tpm_tis_core.c
>>>>>>>>> +++ b/drivers/char/tpm/tpm_tis_core.c
>>>>>>>>> @@ -80,8 +80,12 @@ static int wait_for_tpm_stat(struct =
tpm_chip *chip, u8 mask,
>>>>>>>>> 		}
>>>>>>>>> 	} else {
>>>>>>>>> 		do {
>>>>>>>>> -			usleep_range(TPM_TIMEOUT_USECS_MIN,
>>>>>>>>> -				     TPM_TIMEOUT_USECS_MAX);
>>>>>>>>> +			if (chip->timeout_wait_stat &&=20
>>>>>>>>> +				chip->timeout_wait_stat >=3D =
TPM_TIMEOUT_WAIT_STAT) {
>>>>>>>>> +				tpm_usleep((unsigned =
int)(chip->timeout_wait_stat));
>>>>>>>>> +			} else {
>>>>>>>>> +				tpm_usleep((unsigned =
int)(TPM_TIMEOUT_WAIT_STAT));
>>>>>>>>> +			}
>>>>>>>>=20
>>>>>>>> Invalid use of braces. Please read
>>>>>>>>=20
>>>>>>>> https://www.kernel.org/doc/html/v5.13/process/coding-style.html
>>>>>>>>=20
>>>>>>>> Why do you have to use this field conditionally anyway? Why =
doesn't
>>>>>>>> it always contain a legit value?
>>>>>>> The field is legit now, but doesn=E2=80=99t hurt to do addition =
check for robustness=20
>>>>>>> to ensure no crash ? Just in case the value is updated below =
TPM_TIMEOUT_WAIT_STAT ?=20
>>>>>>>=20
>>>>>>> Can remove if we think it is not needed.
>>>>>>=20
>>>>>> A simple question: why you use it conditionally? Can the field =
contain invalid value?
>>>>>>=20
>>>>> There are two checks
>>>>> - chip->timeout_wait_stat >=3D TPM_TIMEOUT_WAIT_STAT
>>>>> It could be invalid when future developer set it to some value =
less than `TPM_TIMEOUT_USECS_MIN`,
>>>>> and crash the usleep=20
>>>>=20
>>>> I don't understand this. Why you don't set to appropriate value?
>> Ok, fair enough, I assume developers will test it anyway to ensure no =
crash. Will remove this check.
>>=20
>>> What you should do, is to define two fields:
>>>=20
>>> - tpm_timeout_min
>>> - tpm_timeout_max
>>>=20
>>> And initialize these to TPM_TIMEOUT_USECS_MIN and =
TPM_TIMEOUT_USECS_MAX.
>>>=20
>>> Then fixup those for Atmel (with a simple if-statement, switch-case =
is
>>> overkill).
>> Switch was more for extensibility when other vendor has similar =
issue,
>> but we can refactor when needed in the future. I can use if-statement =
for now.
>=20
> Make things more fancy *only* when you actually need more fancy.
>=20
>>> The way you work out things right now is broken:
>>>=20
>>> 1. Before for non-Atmel: usleep_range(100, 500)
>>> 2. After for non-Atmel: usleep_range(200, 500)
>> I realized this in day-1, I think this range change does not matter =
much.
>=20
> By saying that you are actually saying that *undocumented* semantic =
changes
> to the kernel code are fine as long as they don't change things "too =
much"
>=20
> Are you serious about this?
Fair enough, I agree that keeping things as it avoid potential issues. =
Thanks for pointing this out!
>=20
>> `TPM_TIMEOUT_RANGE_US=3D300` is already used in the codebase, I =
assume people define
>> such if for general use cases for usleep_range in TPM
>> But we can add two fields if that makes us more comfortable to =
strictly follow the current code
>> semantically.
>=20
> This has absolutely nothing to do with "comfortable". It's black and =
white
> wrong.
>=20
> /Jarkko

I believe the comments are addressed in=20
=
https://patchwork.kernel.org/project/linux-integrity/patch/20210704000754.=
1384-1-hao.wu@rubrik.com/

Have tested it with ATMEL 1.2 chip.=20

Thanks
Hao=
