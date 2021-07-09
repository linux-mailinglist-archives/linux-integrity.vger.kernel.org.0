Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718333C298F
	for <lists+linux-integrity@lfdr.de>; Fri,  9 Jul 2021 21:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbhGIT0B (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 9 Jul 2021 15:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhGIT0B (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 9 Jul 2021 15:26:01 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD07FC0613DD
        for <linux-integrity@vger.kernel.org>; Fri,  9 Jul 2021 12:23:17 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id cu14so971353pjb.0
        for <linux-integrity@vger.kernel.org>; Fri, 09 Jul 2021 12:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EWRcHjFXXxNQjnWKu5vbUxZq1Dqk/VY3auLgAUYd7Sg=;
        b=cjWgb/V/aC5hCuojq7RKei2T6t9gZFUCQViZCceKmRUWCMVEeVegdG5UmGzpNWl9k7
         YOkByTy/bOb/F9dHjD779hADGZ0ECvIk11dvGW/MGsroCbHXCuecaK5RGVfM95QO0jrS
         RjbLYmICTlyiyvr7WSGZk0TTwU8nqm2QUDrC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=EWRcHjFXXxNQjnWKu5vbUxZq1Dqk/VY3auLgAUYd7Sg=;
        b=Kk5/KpqZgqSDfm1uCi7rj63//CIZCFA2XHOLSR0jQQ8b3LOM5mvPANqBD9N5nDmZYJ
         LFOXrF94c09AB1oSeKyX/FmyHXL4nRNcuAqDrOJjhOxUII93xEw9LxsLAfO6mX5LMjCl
         GezscgwAA3kmly4Zn+Y1zOjafCa9DFyThsBZwx3muX5dgXZVG31ixGOfJEx08DzYq5+p
         zkIl87+AUNNIYCrt7yejU7VEyufjz3GEaTRTMMGkY8FbS1PIKWmStAOUmEYwy4c91FQq
         TdCfziADredmz9E4vZvU6X6/WMst7Y/m74I8iosw5xOYEXf+0LqFRCETQtYwUCF4pXVQ
         EufQ==
X-Gm-Message-State: AOAM530klEemeesq/xUpThL6Zo4Vzn62wj7+Sw1HXmEnadWtJpxmXnw2
        WtCwkIIvuJ1jdfff1sywyqTJkQ==
X-Google-Smtp-Source: ABdhPJyBsfrTDZXlbslihYDb0g12g5vGNZgqf6l1YRjaKLrPo0wXw8NaYU1P6D+hccOkhRPoqCooKQ==
X-Received: by 2002:a17:90a:3981:: with SMTP id z1mr11457071pjb.215.1625858597163;
        Fri, 09 Jul 2021 12:23:17 -0700 (PDT)
Received: from [10.0.0.5] (c-73-231-56-47.hsd1.ca.comcast.net. [73.231.56.47])
        by smtp.gmail.com with ESMTPSA id m16sm2641550pfo.152.2021.07.09.12.23.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Jul 2021 12:23:16 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v2] tpm: fix Atmel TPM crash caused by too frequent
 queries
From:   Hao Wu <hao.wu@rubrik.com>
In-Reply-To: <20210709174707.z2ap7czu2lldeavw@kernel.org>
Date:   Fri, 9 Jul 2021 12:23:07 -0700
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
Message-Id: <C8D0A56A-F62D-4D07-8AC7-B03608246B0F@rubrik.com>
References: <20210630042205.30051-1-hao.wu@rubrik.com>
 <20210709044028.77278-1-hao.wu@rubrik.com>
 <20210709174707.z2ap7czu2lldeavw@kernel.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> On Jul 9, 2021, at 10:47 AM, Jarkko Sakkinen <jarkko@kernel.org> =
wrote:
>=20
> On Thu, Jul 08, 2021 at 09:40:28PM -0700, Hao Wu wrote:
>> The Atmel TPM 1.2 chips crash with error
>> `tpm_try_transmit: send(): error -62` since kernel 4.14.
>> It is observed from the kernel log after running `tpm_sealdata -z`.
>> The error thrown from the command is as follows
>> ```
>> $ tpm_sealdata -z
>> Tspi_Key_LoadKey failed: 0x00001087 - layer=3Dtddl,
>> code=3D0087 (135), I/O error
>> ```
>>=20
>> The issue was reproduced with the following Atmel TPM chip:
>> ```
>> $ tpm_version
>> T0  TPM 1.2 Version Info:
>>  Chip Version:        1.2.66.1
>>  Spec Level:          2
>>  Errata Revision:     3
>>  TPM Vendor ID:       ATML
>>  TPM Version:         01010000
>>  Manufacturer Info:   41544d4c
>> ```
>>=20
>> The root cause of the issue is due to the TPM calls to msleep()
>> were replaced with usleep_range() [1], which reduces
>> the actual timeout. Via experiments, it is observed that
>> the original msleep(5) actually sleeps for 15ms.
>> Because of a known timeout issue in Atmel TPM 1.2 chip,
>> the shorter timeout than 15ms can cause the error described above.
>>=20
>> A few further changes in kernel 4.16 [2] and 4.18 [3, 4] further
>> reduced the timeout to less than 1ms. With experiments,
>> the problematic timeout in the latest kernel is the one
>> for `wait_for_tpm_stat`.
>>=20
>> To fix it, the patch reverts the timeout of `wait_for_tpm_stat`
>> to 15ms for all Atmel TPM 1.2 chips, but leave it untouched
>> for Ateml TPM 2.0 chip, and chips from other vendors.
>> As explained above, the chosen 15ms timeout is
>> the actual timeout before this issue introduced,
>> thus the old value is used here.
>> Particularly, TPM_ATML_TIMEOUT_WAIT_STAT_MIN is set to 14700us,
>> TPM_ATML_TIMEOUT_WAIT_STAT_MIN is set to 15000us according to
>> the existing TPM_TIMEOUT_RANGE_US (300us).
>> The fixed has been tested in the system with the affected Atmel chip
>> with no issues observed after boot up.
>>=20
>> References:
>> [1] 9f3fc7bcddcb tpm: replace msleep() with usleep_range() in TPM
>> 1.2/2.0 generic drivers
>> [2] cf151a9a44d5 tpm: reduce tpm polling delay in tpm_tis_core
>> [3] 59f5a6b07f64 tpm: reduce poll sleep time in tpm_transmit()
>> [4] 424eaf910c32 tpm: reduce polling time to usecs for even finer
>> granularity
>>=20
>> Fixes: 9f3fc7bcddcb ("tpm: replace msleep() with usleep_range() in =
TPM 1.2/2.0 generic drivers")
>> Link: =
https://patchwork.kernel.org/project/linux-integrity/patch/20200926223150.=
109645-1-hao.wu@rubrik.com/
>> Signed-off-by: Hao Wu <hao.wu@rubrik.com>
>> ---
>> This version (v2) has following changes on top of the last (v1):
>> - follow the existing way to define two timeouts (min and max)
>>  for ATMEL chip, thus keep the exact timeout logic for=20
>>  non-ATEML chips.
>> - limit the timeout increase to only ATMEL TPM 1.2 chips,
>>  because it is not an issue for TPM 2.0 chips yet.
>>=20
>> Test Plan:
>> - Run fixed kernel with ATMEL TPM chips and see crash has been fixed.
>> - Run fixed kernel with non-ATMEL TPM chips, and confirm
>>  the timeout has not been changed.
>>=20
>> drivers/char/tpm/tpm.h          |  6 ++++--
>> drivers/char/tpm/tpm_tis_core.c | 23 +++++++++++++++++++++--
>> include/linux/tpm.h             |  3 +++
>> 3 files changed, 28 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
>> index 283f78211c3a..6de1b44c4aab 100644
>> --- a/drivers/char/tpm/tpm.h
>> +++ b/drivers/char/tpm/tpm.h
>> @@ -41,8 +41,10 @@ enum tpm_timeout {
>> 	TPM_TIMEOUT_RETRY =3D 100, /* msecs */
>> 	TPM_TIMEOUT_RANGE_US =3D 300,	/* usecs */
>> 	TPM_TIMEOUT_POLL =3D 1,	/* msecs */
>> -	TPM_TIMEOUT_USECS_MIN =3D 100,      /* usecs */
>> -	TPM_TIMEOUT_USECS_MAX =3D 500      /* usecs */
>> +	TPM_TIMEOUT_USECS_MIN =3D 100,	/* usecs */
>> +	TPM_TIMEOUT_USECS_MAX =3D 500,	/* usecs */
>> +	TPM_ATML_TIMEOUT_WAIT_STAT_MIN =3D 14700,	/* usecs */
>> +	TPM_ATML_TIMEOUT_WAIT_STAT_MAX =3D 15000	/* usecs */
>> };
>>=20
>> /* TPM addresses */
>> diff --git a/drivers/char/tpm/tpm_tis_core.c =
b/drivers/char/tpm/tpm_tis_core.c
>> index 55b9d3965ae1..ae27d66fdd94 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -80,8 +80,17 @@ static int wait_for_tpm_stat(struct tpm_chip =
*chip, u8 mask,
>> 		}
>> 	} else {
>> 		do {
>> -			usleep_range(TPM_TIMEOUT_USECS_MIN,
>> -				     TPM_TIMEOUT_USECS_MAX);
>> +			/* this code path could be executed before
>> +			 * timeouts initialized in chip instance.
>> +			 */
>> +			if (chip->timeout_wait_stat_min &&
>> +			    chip->timeout_wait_stat_max)
>> +				=
usleep_range(chip->timeout_wait_stat_min,
>> +					     =
chip->timeout_wait_stat_max);
>> +			else
>> +				usleep_range(TPM_TIMEOUT_USECS_MIN,
>> +					     TPM_TIMEOUT_USECS_MAX);
>=20
> This starts to look otherwise fine but you don't need this condition.
> Just initialize variables to TPM_TIMEOUT_USECS_{MIN, MAX} for =
non-Atmel.
Not sure I got your point or not. We have discussed this question a few =
rounds before,
I answered you about this. This check is required because before the =
time of=20
Initialization in the code I added in `tpm_tis_core_init`
```
+	chip->timeout_wait_stat_min =3D TPM_TIMEOUT_USECS_MIN;
+	chip->timeout_wait_stat_max =3D TPM_TIMEOUT_USECS_MAX;
```
The func `wait_for_tpm_stat` runs, we need the condition to fall back to =
avoid system startup crash.

Let me know if this makes sense. If needed, I can do another confirm.

> /Jarkko

Hao

