Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9423C3B15
	for <lists+linux-integrity@lfdr.de>; Sun, 11 Jul 2021 09:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhGKHkF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 11 Jul 2021 03:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhGKHkF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 11 Jul 2021 03:40:05 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B177C0613DD
        for <linux-integrity@vger.kernel.org>; Sun, 11 Jul 2021 00:37:18 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so10807901pjs.2
        for <linux-integrity@vger.kernel.org>; Sun, 11 Jul 2021 00:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RMQVB22mW9b7tVkE/j1VH7GvfGtXO/eCeYzxHYWiYJw=;
        b=X6XK9MBNMmeGpepohS/NU/fFIR57hKnZNxcwjL+UKRdi6FIshjkH+NQGAAc4HTp2ay
         zsraKTCMFlsGgW6jT3zNKr+MJ9yd/UOLtC7NO2MqboY5xUnHIFNz95PT7E9VpzPP2puY
         TzclYmM1HJySRJwSiAXP6VrmgOUbkLYWDRUGg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=RMQVB22mW9b7tVkE/j1VH7GvfGtXO/eCeYzxHYWiYJw=;
        b=py+IHCDUolMmueCK5ubIegr5PFaG4PJdY4UCuSe3CORE/9hLAcItVwlGRSAIC/ToDH
         XrAJRBa706mm8aoiku4+O85FL0PYGKhycqbl/Iqqjy8/L3F6TMvMm6cZT3fhdbJALAQS
         Hh2NPEbMbLZx2TMBpvAyWQuWLKSwvNrhXtSIMtPNBtjdMa7RG9b79yPa6F777FOAP66D
         908DqqaYYIfxkanXkjV8dm9voCnChXFvJg6fFv+etnMQLB/ft7+4gteTIUciX6neLnum
         9l2jY1o6oplxkqrJJDvnVz7QTb9Zhd99ra+bfUZgnv1+OiTKeaFB1NCn9PD0waahmL7z
         43VQ==
X-Gm-Message-State: AOAM530UunEbVYNTIsc4E7aAtQKne4txF8syRCuCR0beoE5rZE3oK0Qd
        VdOesu7D4UJ+7U3kYRjq28mC3w==
X-Google-Smtp-Source: ABdhPJxeCxP4WSAEOD5hWVLGMHjhWvTuvxHnncPy5YOpV6MIJyj6/ASr3EBlV2O6l3Ic/wevP2uNKQ==
X-Received: by 2002:a17:90a:aa14:: with SMTP id k20mr8271129pjq.88.1625989037825;
        Sun, 11 Jul 2021 00:37:17 -0700 (PDT)
Received: from [10.0.0.5] (c-73-231-56-47.hsd1.ca.comcast.net. [73.231.56.47])
        by smtp.gmail.com with ESMTPSA id x18sm4009741pfh.48.2021.07.11.00.37.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Jul 2021 00:37:17 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v2] tpm: fix Atmel TPM crash caused by too frequent
 queries
From:   Hao Wu <hao.wu@rubrik.com>
In-Reply-To: <C8D0A56A-F62D-4D07-8AC7-B03608246B0F@rubrik.com>
Date:   Sun, 11 Jul 2021 00:37:07 -0700
Cc:     Shrihari Kalkar <shrihari.kalkar@rubrik.com>,
        Seungyeop Han <seungyeop.han@rubrik.com>,
        Anish Jhaveri <anish.jhaveri@rubrik.com>, peterhuewe@gmx.de,
        jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Ken Goldman <kgold@linux.ibm.com>, zohar@linux.vnet.ibm.com,
        why2jjj.linux@gmail.com, Hamza Attak <hamza@hpe.com>,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        Nayna <nayna@linux.vnet.ibm.com>,
        James.Bottomley@hansenpartnership.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <A470A175-40B2-4357-826A-FA4A9737B49A@rubrik.com>
References: <20210630042205.30051-1-hao.wu@rubrik.com>
 <20210709044028.77278-1-hao.wu@rubrik.com>
 <20210709174707.z2ap7czu2lldeavw@kernel.org>
 <C8D0A56A-F62D-4D07-8AC7-B03608246B0F@rubrik.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> On Jul 9, 2021, at 12:23 PM, Hao Wu <hao.wu@rubrik.com> wrote:
>=20
>> On Jul 9, 2021, at 10:47 AM, Jarkko Sakkinen <jarkko@kernel.org> =
wrote:
>>=20
>> On Thu, Jul 08, 2021 at 09:40:28PM -0700, Hao Wu wrote:
>>> The Atmel TPM 1.2 chips crash with error
>>> `tpm_try_transmit: send(): error -62` since kernel 4.14.
>>> It is observed from the kernel log after running `tpm_sealdata -z`.
>>> The error thrown from the command is as follows
>>> ```
>>> $ tpm_sealdata -z
>>> Tspi_Key_LoadKey failed: 0x00001087 - layer=3Dtddl,
>>> code=3D0087 (135), I/O error
>>> ```
>>>=20
>>> The issue was reproduced with the following Atmel TPM chip:
>>> ```
>>> $ tpm_version
>>> T0  TPM 1.2 Version Info:
>>> Chip Version:        1.2.66.1
>>> Spec Level:          2
>>> Errata Revision:     3
>>> TPM Vendor ID:       ATML
>>> TPM Version:         01010000
>>> Manufacturer Info:   41544d4c
>>> ```
>>>=20
>>> The root cause of the issue is due to the TPM calls to msleep()
>>> were replaced with usleep_range() [1], which reduces
>>> the actual timeout. Via experiments, it is observed that
>>> the original msleep(5) actually sleeps for 15ms.
>>> Because of a known timeout issue in Atmel TPM 1.2 chip,
>>> the shorter timeout than 15ms can cause the error described above.
>>>=20
>>> A few further changes in kernel 4.16 [2] and 4.18 [3, 4] further
>>> reduced the timeout to less than 1ms. With experiments,
>>> the problematic timeout in the latest kernel is the one
>>> for `wait_for_tpm_stat`.
>>>=20
>>> To fix it, the patch reverts the timeout of `wait_for_tpm_stat`
>>> to 15ms for all Atmel TPM 1.2 chips, but leave it untouched
>>> for Ateml TPM 2.0 chip, and chips from other vendors.
>>> As explained above, the chosen 15ms timeout is
>>> the actual timeout before this issue introduced,
>>> thus the old value is used here.
>>> Particularly, TPM_ATML_TIMEOUT_WAIT_STAT_MIN is set to 14700us,
>>> TPM_ATML_TIMEOUT_WAIT_STAT_MIN is set to 15000us according to
>>> the existing TPM_TIMEOUT_RANGE_US (300us).
>>> The fixed has been tested in the system with the affected Atmel chip
>>> with no issues observed after boot up.
>>>=20
>>> References:
>>> [1] 9f3fc7bcddcb tpm: replace msleep() with usleep_range() in TPM
>>> 1.2/2.0 generic drivers
>>> [2] cf151a9a44d5 tpm: reduce tpm polling delay in tpm_tis_core
>>> [3] 59f5a6b07f64 tpm: reduce poll sleep time in tpm_transmit()
>>> [4] 424eaf910c32 tpm: reduce polling time to usecs for even finer
>>> granularity
>>>=20
>>> Fixes: 9f3fc7bcddcb ("tpm: replace msleep() with usleep_range() in =
TPM 1.2/2.0 generic drivers")
>>> Link: =
https://patchwork.kernel.org/project/linux-integrity/patch/20200926223150.=
109645-1-hao.wu@rubrik.com/
>>> Signed-off-by: Hao Wu <hao.wu@rubrik.com>
>>> ---
>>> This version (v2) has following changes on top of the last (v1):
>>> - follow the existing way to define two timeouts (min and max)
>>> for ATMEL chip, thus keep the exact timeout logic for=20
>>> non-ATEML chips.
>>> - limit the timeout increase to only ATMEL TPM 1.2 chips,
>>> because it is not an issue for TPM 2.0 chips yet.
>>>=20
>>> Test Plan:
>>> - Run fixed kernel with ATMEL TPM chips and see crash has been =
fixed.
>>> - Run fixed kernel with non-ATMEL TPM chips, and confirm
>>> the timeout has not been changed.
>>>=20
>>> drivers/char/tpm/tpm.h          |  6 ++++--
>>> drivers/char/tpm/tpm_tis_core.c | 23 +++++++++++++++++++++--
>>> include/linux/tpm.h             |  3 +++
>>> 3 files changed, 28 insertions(+), 4 deletions(-)
>>>=20
>>> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
>>> index 283f78211c3a..6de1b44c4aab 100644
>>> --- a/drivers/char/tpm/tpm.h
>>> +++ b/drivers/char/tpm/tpm.h
>>> @@ -41,8 +41,10 @@ enum tpm_timeout {
>>> 	TPM_TIMEOUT_RETRY =3D 100, /* msecs */
>>> 	TPM_TIMEOUT_RANGE_US =3D 300,	/* usecs */
>>> 	TPM_TIMEOUT_POLL =3D 1,	/* msecs */
>>> -	TPM_TIMEOUT_USECS_MIN =3D 100,      /* usecs */
>>> -	TPM_TIMEOUT_USECS_MAX =3D 500      /* usecs */
>>> +	TPM_TIMEOUT_USECS_MIN =3D 100,	/* usecs */
>>> +	TPM_TIMEOUT_USECS_MAX =3D 500,	/* usecs */
>>> +	TPM_ATML_TIMEOUT_WAIT_STAT_MIN =3D 14700,	/* usecs */
>>> +	TPM_ATML_TIMEOUT_WAIT_STAT_MAX =3D 15000	/* usecs */
>>> };
>>>=20
>>> /* TPM addresses */
>>> diff --git a/drivers/char/tpm/tpm_tis_core.c =
b/drivers/char/tpm/tpm_tis_core.c
>>> index 55b9d3965ae1..ae27d66fdd94 100644
>>> --- a/drivers/char/tpm/tpm_tis_core.c
>>> +++ b/drivers/char/tpm/tpm_tis_core.c
>>> @@ -80,8 +80,17 @@ static int wait_for_tpm_stat(struct tpm_chip =
*chip, u8 mask,
>>> 		}
>>> 	} else {
>>> 		do {
>>> -			usleep_range(TPM_TIMEOUT_USECS_MIN,
>>> -				     TPM_TIMEOUT_USECS_MAX);
>>> +			/* this code path could be executed before
>>> +			 * timeouts initialized in chip instance.
>>> +			 */
>>> +			if (chip->timeout_wait_stat_min &&
>>> +			    chip->timeout_wait_stat_max)
>>> +				=
usleep_range(chip->timeout_wait_stat_min,
>>> +					     =
chip->timeout_wait_stat_max);
>>> +			else
>>> +				usleep_range(TPM_TIMEOUT_USECS_MIN,
>>> +					     TPM_TIMEOUT_USECS_MAX);
>>=20
>> This starts to look otherwise fine but you don't need this condition.
>> Just initialize variables to TPM_TIMEOUT_USECS_{MIN, MAX} for =
non-Atmel.
> Not sure I got your point or not. We have discussed this question a =
few rounds before,
> I answered you about this. This check is required because before the =
time of=20
> Initialization in the code I added in `tpm_tis_core_init`
> ```
> +	chip->timeout_wait_stat_min =3D TPM_TIMEOUT_USECS_MIN;
> +	chip->timeout_wait_stat_max =3D TPM_TIMEOUT_USECS_MAX;
> ```
> The func `wait_for_tpm_stat` runs, we need the condition to fall back =
to avoid system startup crash.
>=20
> Let me know if this makes sense. If needed, I can do another confirm.
I double checked this, and found the current init lines in =
`tpm_tis_core_init`=20
is actually before this code path now. Maybe it was an issue in one
of my old revision and I had the wrong impression.=20
The condition seems ok to remove in the current revision.=20

But I am not fully sure is if the behavior is consistent across other =
1.2 chips, and TPM 2.0 chips.
Should we still keep the condition for robustness or ship without it ? =20=


>> /Jarkko
>=20
> Hao

Hao

