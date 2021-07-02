Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F743BA44C
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Jul 2021 21:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbhGBTSt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Jul 2021 15:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhGBTSt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Jul 2021 15:18:49 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD16C061762
        for <linux-integrity@vger.kernel.org>; Fri,  2 Jul 2021 12:16:15 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id cx9-20020a17090afd89b0290170a3e085edso6755555pjb.0
        for <linux-integrity@vger.kernel.org>; Fri, 02 Jul 2021 12:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=07tvX9g0BOJCi3Z4mcMAN2a2bWGzuMGA0FnMQLVlL3A=;
        b=CPgdGYXO8+YX1faU/vUux5XVnTgUAfQXP4Mrgmq2TTdO9gD8uk7JicmcXZGyFIrzrG
         gy59CBC5sjW+PNLizSIzXDk2aZsCoO4YlUQGoQmAVd2WVyIjvmCcC0MXzZAioIXhaaFe
         nfpNLd89BhLRGPavvAF/Acj6OMDzRP5+Ym5Wg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=07tvX9g0BOJCi3Z4mcMAN2a2bWGzuMGA0FnMQLVlL3A=;
        b=HKkuHa0I1n8sLldJVbURI31VK0MJ9WL0n3uAP2JVoFb0Hwem9m7RiGJN4c6g4b/ARC
         /343DaQa6/xxgzxqTOMu14GiE47BvCtsfJyvNNHbKXdKf2f6O8Yiqwif6T4CWvt6CB1f
         znxjt2f7D5Xmy0IBvePfnqoGDOq5wJDTXanTDu7GPB+L4RctVR7YE/Fvvowd81JtFGOI
         5l6Jmtzn/MtV7SOluwIYIat4GL5FgIGbkyRGxOgtBZS9r0NGzx6OsljRX6IgtFw7lz+3
         qEuQ8IdKpmgfVWg+TVgBkoo4FhD6OuOA5XmN1Drwap9KJ28A0k3WVCLbAc517iXZpFZz
         Oqjw==
X-Gm-Message-State: AOAM531XDWSKJZe2bGvalIl8y34tVNvymgDoo6DjaeSYuoelvjfF13r7
        tZa1aa9iysNiBHfFVNIcFo34Rw==
X-Google-Smtp-Source: ABdhPJwczfJt5CdUzU0UoIeejOAUM/LbNNQ4b44nPZvy+X3ux6UWoGLRyQ/F9BKN7ncaHRiYCoNnJw==
X-Received: by 2002:a17:90b:103:: with SMTP id p3mr1150629pjz.217.1625253375309;
        Fri, 02 Jul 2021 12:16:15 -0700 (PDT)
Received: from [10.0.0.5] (c-73-231-56-47.hsd1.ca.comcast.net. [73.231.56.47])
        by smtp.gmail.com with ESMTPSA id s140sm4530952pfs.18.2021.07.02.12.16.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Jul 2021 12:16:14 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH] tpm: fix ATMEL TPM crash caused by too frequent queries
From:   Hao Wu <hao.wu@rubrik.com>
In-Reply-To: <20210702115715.gyqfdk6ksgqzeenm@kernel.org>
Date:   Fri, 2 Jul 2021 12:16:12 -0700
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
Message-Id: <AB80469F-821A-45D0-878C-7ED97C8B44BF@rubrik.com>
References: <20210624053321.861-1-hao.wu@rubrik.com>
 <20210630042205.30051-1-hao.wu@rubrik.com>
 <20210702063555.q2phirfv7wxc6axu@kernel.org>
 <939BC11F-0905-4777-9DD7-630FC28ED205@rubrik.com>
 <20210702074518.64gyockmqrphbkqx@kernel.org>
 <559CEFEB-EE60-464B-A847-9E1C3B5F5BC4@rubrik.com>
 <20210702084239.svkmfw7r3y5auus3@kernel.org>
 <20210702115715.gyqfdk6ksgqzeenm@kernel.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


> On Jul 2, 2021, at 4:57 AM, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>=20
> On Fri, Jul 02, 2021 at 11:42:39AM +0300, Jarkko Sakkinen wrote:
>> On Fri, Jul 02, 2021 at 12:59:18AM -0700, Hao Wu wrote:
>>>> On Jul 2, 2021, at 12:45 AM, Jarkko Sakkinen <jarkko@kernel.org> =
wrote:
>>>>=20
>>>> On Fri, Jul 02, 2021 at 12:33:15AM -0700, Hao Wu wrote:
>>>>>=20
>>>>>=20
>>>>>> On Jul 1, 2021, at 11:35 PM, Jarkko Sakkinen <jarkko@kernel.org> =
wrote:
>>>>>>=20
>>>>>> On Tue, Jun 29, 2021 at 09:22:05PM -0700, Hao Wu wrote:
>>>>>>> This is a fix for the ATMEL TPM crash bug reported in
>>>>>>> =
https://patchwork.kernel.org/project/linux-integrity/patch/20200926223150.=
109645-1-hao.wu@rubrik.com/
>>>>>>>=20
>>>>>>> According to the discussions in the original thread,
>>>>>>> we don't want to revert the timeout of wait_for_tpm_stat
>>>>>>> for non-ATMEL chips, which brings back the performance cost.
>>>>>>> For investigation and analysis of why wait_for_tpm_stat
>>>>>>> caused the issue, and how the regression was introduced,
>>>>>>> please read the original thread above.
>>>>>>>=20
>>>>>>> Thus the proposed fix here is to only revert the timeout
>>>>>>> for ATMEL chips by checking the vendor ID.
>>>>>>>=20
>>>>>>> Signed-off-by: Hao Wu <hao.wu@rubrik.com>
>>>>>>> Fixes: 9f3fc7bcddcb ("tpm: replace msleep() with usleep_range() =
in TPM 1.2/2.0 generic drivers")
>>>>>>=20
>>>>>> Fixes tag should be before SOB.
>>>>>>=20
>>>>>>> ---
>>>>>>> Test Plan:
>>>>>>> - Run fixed kernel with ATMEL TPM chips and see crash
>>>>>>> has been fixed.
>>>>>>> - Run fixed kernel with non-ATMEL TPM chips, and confirm
>>>>>>> the timeout has not been changed.
>>>>>>>=20
>>>>>>> drivers/char/tpm/tpm.h          |  9 ++++++++-
>>>>>>> drivers/char/tpm/tpm_tis_core.c | 19 +++++++++++++++++--
>>>>>>> include/linux/tpm.h             |  2 ++
>>>>>>> 3 files changed, 27 insertions(+), 3 deletions(-)
>>>>>>>=20
>>>>>>> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
>>>>>>> index 283f78211c3a..bc6aa7f9e119 100644
>>>>>>> --- a/drivers/char/tpm/tpm.h
>>>>>>> +++ b/drivers/char/tpm/tpm.h
>>>>>>> @@ -42,7 +42,9 @@ enum tpm_timeout {
>>>>>>> 	TPM_TIMEOUT_RANGE_US =3D 300,	/* usecs */
>>>>>>> 	TPM_TIMEOUT_POLL =3D 1,	/* msecs */
>>>>>>> 	TPM_TIMEOUT_USECS_MIN =3D 100,      /* usecs */
>>>>>>> -	TPM_TIMEOUT_USECS_MAX =3D 500      /* usecs */
>>>>>>> +	TPM_TIMEOUT_USECS_MAX =3D 500,	/* usecs */
>>>>>>=20
>>>>>> What is this change?
>>>>> Need to add the tailing comma
>>>>>=20
>>>>>>=20
>>>>>>> +	TPM_TIMEOUT_WAIT_STAT =3D 500,	/* usecs */
>>>>>>> +	TPM_ATML_TIMEOUT_WAIT_STAT =3D 15000	/* usecs */
>>>>>>> };
>>>>>>>=20
>>>>>>> /* TPM addresses */
>>>>>>> @@ -189,6 +191,11 @@ static inline void tpm_msleep(unsigned int =
delay_msec)
>>>>>>> 		     delay_msec * 1000);
>>>>>>> };
>>>>>>>=20
>>>>>>> +static inline void tpm_usleep(unsigned int delay_usec)
>>>>>>> +{
>>>>>>> +	usleep_range(delay_usec - TPM_TIMEOUT_RANGE_US, =
delay_usec);
>>>>>>> +};
>>>>>>=20
>>>>>> Please remove this, and open code.
>>>>> Ok, will do
>>>>>=20
>>>>>>> +
>>>>>>> int tpm_chip_start(struct tpm_chip *chip);
>>>>>>> void tpm_chip_stop(struct tpm_chip *chip);
>>>>>>> struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip);
>>>>>>> diff --git a/drivers/char/tpm/tpm_tis_core.c =
b/drivers/char/tpm/tpm_tis_core.c
>>>>>>> index 55b9d3965ae1..9ddd4edfe1c2 100644
>>>>>>> --- a/drivers/char/tpm/tpm_tis_core.c
>>>>>>> +++ b/drivers/char/tpm/tpm_tis_core.c
>>>>>>> @@ -80,8 +80,12 @@ static int wait_for_tpm_stat(struct tpm_chip =
*chip, u8 mask,
>>>>>>> 		}
>>>>>>> 	} else {
>>>>>>> 		do {
>>>>>>> -			usleep_range(TPM_TIMEOUT_USECS_MIN,
>>>>>>> -				     TPM_TIMEOUT_USECS_MAX);
>>>>>>> +			if (chip->timeout_wait_stat &&=20
>>>>>>> +				chip->timeout_wait_stat >=3D =
TPM_TIMEOUT_WAIT_STAT) {
>>>>>>> +				tpm_usleep((unsigned =
int)(chip->timeout_wait_stat));
>>>>>>> +			} else {
>>>>>>> +				tpm_usleep((unsigned =
int)(TPM_TIMEOUT_WAIT_STAT));
>>>>>>> +			}
>>>>>>=20
>>>>>> Invalid use of braces. Please read
>>>>>>=20
>>>>>> https://www.kernel.org/doc/html/v5.13/process/coding-style.html
>>>>>>=20
>>>>>> Why do you have to use this field conditionally anyway? Why =
doesn't
>>>>>> it always contain a legit value?
>>>>> The field is legit now, but doesn=E2=80=99t hurt to do addition =
check for robustness=20
>>>>> to ensure no crash ? Just in case the value is updated below =
TPM_TIMEOUT_WAIT_STAT ?=20
>>>>>=20
>>>>> Can remove if we think it is not needed.
>>>>=20
>>>> A simple question: why you use it conditionally? Can the field =
contain invalid value?
>>>>=20
>>> There are two checks
>>> - chip->timeout_wait_stat >=3D TPM_TIMEOUT_WAIT_STAT
>>> It could be invalid when future developer set it to some value less =
than `TPM_TIMEOUT_USECS_MIN`,
>>> and crash the usleep=20
>>=20
>> I don't understand this. Why you don't set to appropriate value?
Ok, fair enough, I assume developers will test it anyway to ensure no =
crash. Will remove this check.

> What you should do, is to define two fields:
>=20
> - tpm_timeout_min
> - tpm_timeout_max
>=20
> And initialize these to TPM_TIMEOUT_USECS_MIN and =
TPM_TIMEOUT_USECS_MAX.
>=20
> Then fixup those for Atmel (with a simple if-statement, switch-case is
> overkill).
Switch was more for extensibility when other vendor has similar issue,
but we can refactor when needed in the future. I can use if-statement =
for now.

> The way you work out things right now is broken:
>=20
> 1. Before for non-Atmel: usleep_range(100, 500)
> 2. After for non-Atmel: usleep_range(200, 500)
I realized this in day-1, I think this range change does not matter =
much.
`TPM_TIMEOUT_RANGE_US=3D300` is already used in the codebase, I assume =
people define
such if for general use cases for usleep_range in TPM
But we can add two fields if that makes us more comfortable to strictly =
follow the current code
semantically.

> I.e. the patch changes code semantically that it should not touch in =
the
> first place.
>=20
> /Jarkko
Hao

