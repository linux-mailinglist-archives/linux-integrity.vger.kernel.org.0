Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D15400D81
	for <lists+linux-integrity@lfdr.de>; Sun,  5 Sep 2021 01:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbhIDXQ5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 4 Sep 2021 19:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbhIDXQ4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 4 Sep 2021 19:16:56 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90C3C061575
        for <linux-integrity@vger.kernel.org>; Sat,  4 Sep 2021 16:15:54 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id i13so1965905pjv.5
        for <linux-integrity@vger.kernel.org>; Sat, 04 Sep 2021 16:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bCZzYlQYhoQwLU237v+CUhD1Mj5ak3iu3xVMxyWPiq8=;
        b=FMzwcWeGbiXbmBLZJ6QKT+PuhMx95L6q6YaAh3TFccNvT6q9yfsVs30xMLIHPR9Kir
         gzZjWjq/O2iYmsraYq7It9qCS/6jiLbCT/jl8ip0ZSO6vGGcVQGJ5+PqZrJrrijft8k7
         qjWA/ZxinU2O6WUHCCKdIYFONetXhsG+avglY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bCZzYlQYhoQwLU237v+CUhD1Mj5ak3iu3xVMxyWPiq8=;
        b=g8W1byIrq4IUnmPcH0C8l74enzra29q8LjmUZuryNxPPvsfL8gNzmVhu4rZpHoGK/5
         7xceiK7htoOJrdqvUU9jNdY2Mb8E/c1kVxUfOTGPmY0oyTkgUy5NyhvKC50tX37WVsII
         pWtS1FpuMdHlPa9mnckreIZul9+ZTF58gBAs0Q/j/B8+YP7dlr36cdfyBZZkM0d1Ikka
         JQG6VFDqsqlAvcq3d5hZr/gAgw5C+MJGV3zCAOmPVzxEWH0PYHjXg1Dqau2rewC6oeri
         sSAksak1Wu6ZXOHRDrPtYbstRPA7cQnA2EEZMPs8FnYajj3lif1D7JE1T6UqUXSLw08o
         5bnw==
X-Gm-Message-State: AOAM530F+yoTju9dcRVWSJq6IEfOTA7JcfYBzH+Tv5oaXOe8ruFdJOXs
        vkRE+Ntv40DuHmTPg+CfrmGT8w==
X-Google-Smtp-Source: ABdhPJzrKxd4Ce8usAD2X96uuroPnCGb58NXALJOOIeLLeFa9zLuaIVo7WGgA8u8eWZOhmEqqzUw3g==
X-Received: by 2002:a17:90b:33c6:: with SMTP id lk6mr6316818pjb.203.1630797354046;
        Sat, 04 Sep 2021 16:15:54 -0700 (PDT)
Received: from smtpclient.apple (c-73-231-56-47.hsd1.ca.comcast.net. [73.231.56.47])
        by smtp.gmail.com with ESMTPSA id v9sm3760380pga.82.2021.09.04.16.15.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Sep 2021 16:15:53 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v4] tpm: fix Atmel TPM crash caused by too frequent
 queries
From:   Hao Wu <hao.wu@rubrik.com>
In-Reply-To: <349D2EA2-8A7C-4D5A-858B-B37EA317DA4A@rubrik.com>
Date:   Sat, 4 Sep 2021 16:15:51 -0700
Cc:     Shrihari Kalkar <shrihari.kalkar@rubrik.com>,
        Han Seungyeop <seungyeop.han@rubrik.com>,
        Anish Jhaveri <anish.jhaveri@rubrik.com>, peterhuewe@gmx.de,
        jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Ken Goldman <kgold@linux.ibm.com>, zohar@linux.vnet.ibm.com,
        why2jjj.linux@gmail.com, Hamza Attak <hamza@hpe.com>,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        Nayna <nayna@linux.vnet.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <827FB0CE-2199-48A6-B63F-6A23CD5B92A7@rubrik.com>
References: <20210711075122.30056-1-hao.wu@rubrik.com>
 <20210814222519.42476-1-hao.wu@rubrik.com>
 <B58587F6-AF3F-4224-B6F6-E3886EE80413@rubrik.com>
 <bc1ba8557c3146f1b94647de6f2851d002a9b597.camel@kernel.org>
 <45EFFAB9-00A3-47D1-B9E6-2380EB581A9F@rubrik.com>
 <349D2EA2-8A7C-4D5A-858B-B37EA317DA4A@rubrik.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



> On Sep 4, 2021, at 2:14 PM, Hao Wu <hao.wu@rubrik.com> wrote:
>=20
>=20
>=20
>> On Aug 26, 2021, at 5:35 PM, Hao Wu <hao.wu@rubrik.com> wrote:
>>=20
>>> On Aug 26, 2021, at 9:24 AM, Jarkko Sakkinen <jarkko@kernel.org> =
wrote:
>>>=20
>>> On Wed, 2021-08-25 at 22:38 -0700, Hao Wu wrote:
>>>>> On Aug 14, 2021, at 3:25 PM, Hao Wu <hao.wu@rubrik.com> wrote:
>>>>>=20
>>>>> The Atmel TPM 1.2 chips crash with error
>>>>> `tpm_try_transmit: send(): error -62` since kernel 4.14.
>>>>> It is observed from the kernel log after running `tpm_sealdata =
-z`.
>>>>> The error thrown from the command is as follows
>>>>> ```
>>>>> $ tpm_sealdata -z
>>>>> Tspi_Key_LoadKey failed: 0x00001087 - layer=3Dtddl,
>>>>> code=3D0087 (135), I/O error
>>>>> ```
>>>>>=20
>>>>> The issue was reproduced with the following Atmel TPM chip:
>>>>> ```
>>>>> $ tpm_version
>>>>> T0  TPM 1.2 Version Info:
>>>>> Chip Version:        1.2.66.1
>>>>> Spec Level:          2
>>>>> Errata Revision:     3
>>>>> TPM Vendor ID:       ATML
>>>>> TPM Version:         01010000
>>>>> Manufacturer Info:   41544d4c
>>>>> ```
>>>>>=20
>>>>> The root cause of the issue is due to the TPM calls to msleep()
>>>>> were replaced with usleep_range() [1], which reduces
>>>>> the actual timeout. Via experiments, it is observed that
>>>>> the original msleep(5) actually sleeps for 15ms.
>>>>> Because of a known timeout issue in Atmel TPM 1.2 chip,
>>>>> the shorter timeout than 15ms can cause the error described above.
>>>>>=20
>>>>> A few further changes in kernel 4.16 [2] and 4.18 [3, 4] further
>>>>> reduced the timeout to less than 1ms. With experiments,
>>>>> the problematic timeout in the latest kernel is the one
>>>>> for `wait_for_tpm_stat`.
>>>>>=20
>>>>> To fix it, the patch reverts the timeout of `wait_for_tpm_stat`
>>>>> to 15ms for all Atmel TPM 1.2 chips, but leave it untouched
>>>>> for Ateml TPM 2.0 chip, and chips from other vendors.
>>>>> As explained above, the chosen 15ms timeout is
>>>>> the actual timeout before this issue introduced,
>>>>> thus the old value is used here.
>>>>> Particularly, TPM_ATML_TIMEOUT_WAIT_STAT_MIN is set to 14700us,
>>>>> TPM_ATML_TIMEOUT_WAIT_STAT_MIN is set to 15000us according to
>>>>> the existing TPM_TIMEOUT_RANGE_US (300us).
>>>>> The fixed has been tested in the system with the affected Atmel =
chip
>>>>> with no issues observed after boot up.
>>>>>=20
>>>>> References:
>>>>> [1] 9f3fc7bcddcb tpm: replace msleep() with usleep_range() in TPM
>>>>> 1.2/2.0 generic drivers
>>>>> [2] cf151a9a44d5 tpm: reduce tpm polling delay in tpm_tis_core
>>>>> [3] 59f5a6b07f64 tpm: reduce poll sleep time in tpm_transmit()
>>>>> [4] 424eaf910c32 tpm: reduce polling time to usecs for even finer
>>>>> granularity
>>>>>=20
>>>>> Fixes: 9f3fc7bcddcb ("tpm: replace msleep() with usleep_range() in =
TPM 1.2/2.0 generic drivers")
>>>>> Link: =
https://patchwork.kernel.org/project/linux-integrity/patch/20200926223150.=
109645-1-hao.wu@rubrik.com/
>>>>> Signed-off-by: Hao Wu <hao.wu@rubrik.com>
>>>>> ---
>>>>> v4:
>>>>> - Move timeout constants to drivers/char/tpm/tpm_tis_core.h
>>>>> - Cleanup unnecessary inline comment
>>>>>=20
>>>>> v3:
>>>>> - removes unnecessary condition check in `wait_for_tpm_stat`
>>>>>=20
>>>>> v2:
>>>>> - follow the existing way to define two timeouts (min and max)
>>>>> for ATMEL chip, thus keep the exact timeout logic for=20
>>>>> non-ATEML chips.
>>>>> - limit the timeout increase to only ATMEL TPM 1.2 chips,
>>>>> because it is not an issue for TPM 2.0 chips yet.
>>>>>=20
>>>>> Test Plan:
>>>>> - Run fixed kernel with ATMEL TPM chips and see crash
>>>>> has been fixed.
>>>>> - Run fixed kernel with non-ATMEL TPM chips, and confirm
>>>>> the timeout has not been changed.
>>>>>=20
>>>>> drivers/char/tpm/tpm_tis_core.c | 13 +++++++++++--
>>>>> drivers/char/tpm/tpm_tis_core.h |  2 ++
>>>>> include/linux/tpm.h             |  3 +++
>>>>> 3 files changed, 16 insertions(+), 2 deletions(-)
>>>>>=20
>>>>> diff --git a/drivers/char/tpm/tpm_tis_core.c =
b/drivers/char/tpm/tpm_tis_core.c
>>>>> index 55b9d3965ae1..24605f100e96 100644
>>>>> --- a/drivers/char/tpm/tpm_tis_core.c
>>>>> +++ b/drivers/char/tpm/tpm_tis_core.c
>>>>> @@ -80,8 +80,8 @@ static int wait_for_tpm_stat(struct tpm_chip =
*chip, u8 mask,
>>>>> 		}
>>>>> 	} else {
>>>>> 		do {
>>>>> -			usleep_range(TPM_TIMEOUT_USECS_MIN,
>>>>> -				     TPM_TIMEOUT_USECS_MAX);
>>>>> +			usleep_range(chip->timeout_wait_stat_min,
>>>>> +				     chip->timeout_wait_stat_max);
>>>>> 			status =3D chip->ops->status(chip);
>>>>> 			if ((status & mask) =3D=3D mask)
>>>>> 				return 0;
>>>>> @@ -934,6 +934,8 @@ int tpm_tis_core_init(struct device *dev, =
struct tpm_tis_data *priv, int irq,
>>>>> 	chip->timeout_b =3D msecs_to_jiffies(TIS_TIMEOUT_B_MAX);
>>>>> 	chip->timeout_c =3D msecs_to_jiffies(TIS_TIMEOUT_C_MAX);
>>>>> 	chip->timeout_d =3D msecs_to_jiffies(TIS_TIMEOUT_D_MAX);
>>>>> +	chip->timeout_wait_stat_min =3D TPM_TIMEOUT_USECS_MIN;
>>>>> +	chip->timeout_wait_stat_max =3D TPM_TIMEOUT_USECS_MAX;
>>>>> 	priv->phy_ops =3D phy_ops;
>>>>> 	dev_set_drvdata(&chip->dev, priv);
>>>>>=20
>>>>> @@ -983,6 +985,13 @@ int tpm_tis_core_init(struct device *dev, =
struct tpm_tis_data *priv, int irq,
>>>>>=20
>>>>> 	priv->manufacturer_id =3D vendor;
>>>>>=20
>>>>> +	if (priv->manufacturer_id =3D=3D TPM_VID_ATML &&
>>>>> +		!(chip->flags & TPM_CHIP_FLAG_TPM2)) {
>>>>> +		/* If TPM chip is 1.2 ATMEL chip, timeout need to be =
relaxed*/
>>>>> +		chip->timeout_wait_stat_min =3D =
TPM_ATML_TIMEOUT_WAIT_STAT_MIN;
>>>>> +		chip->timeout_wait_stat_max =3D =
TPM_ATML_TIMEOUT_WAIT_STAT_MAX;
>>>>> +	}
>>>>> +
>>>>> 	rc =3D tpm_tis_read8(priv, TPM_RID(0), &rid);
>>>>> 	if (rc < 0)
>>>>> 		goto out_err;
>>>>> diff --git a/drivers/char/tpm/tpm_tis_core.h =
b/drivers/char/tpm/tpm_tis_core.h
>>>>> index 9b2d32a59f67..2e431beb44f7 100644
>>>>> --- a/drivers/char/tpm/tpm_tis_core.h
>>>>> +++ b/drivers/char/tpm/tpm_tis_core.h
>>>>> @@ -54,6 +54,8 @@ enum tis_defaults {
>>>>> 	TIS_MEM_LEN =3D 0x5000,
>>>>> 	TIS_SHORT_TIMEOUT =3D 750,	/* ms */
>>>>> 	TIS_LONG_TIMEOUT =3D 2000,	/* 2 sec */
>>>>> +	TPM_ATML_TIMEOUT_WAIT_STAT_MIN =3D 14700,	/* usecs */
>>>>> +	TPM_ATML_TIMEOUT_WAIT_STAT_MAX =3D 15000,	/* usecs */
>>>>> };
>>>=20
>>> I'd prefer TIS_TIMEOUT_{MIN, MAX}_ATML. I.e. no "WAIT_STAT" and =
without "TPM_"
>>> to be consistent with other constants here.
>> Ok will do
>>>=20
>>>>>=20
>>>>> /* Some timeout values are needed before it is known whether the =
chip is
>>>>> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
>>>>> index aa11fe323c56..171b9102c976 100644
>>>>> --- a/include/linux/tpm.h
>>>>> +++ b/include/linux/tpm.h
>>>>> @@ -150,6 +150,8 @@ struct tpm_chip {
>>>>> 	bool timeout_adjusted;
>>>>> 	unsigned long duration[TPM_NUM_DURATIONS]; /* jiffies */
>>>>> 	bool duration_adjusted;
>>>>> +	unsigned int timeout_wait_stat_min; /* usecs */
>>>>> +	unsigned int timeout_wait_stat_max; /* usecs */
>>>=20
>>> Please rename as timeout_{min, max}.
>> Ok will do
To be honest, this naming could be misleading, because the timeout here =
only applies to wait_stat use case.=20
But I will just follow you suggestion anyway.

Hao

>>>=20
>>> And I think tpm_chip is wrong place to put them as they are TIS
>>> specific, i.e. they should be in tpm_tis_data.
>> Sorry, I am not familiar with tpm_tis_data, could tell the the place =
that you want me to put the var?=20
>> I think I may have hard time to move forward according toward this =
comment due to bandwidth constraints.
>> Some helps would be appreciated.=20
>>=20
>> Is tpm_tis_data something specific to a chip instance ? Given the =
values are tied to chip,
>> we need chip specific instance to make this work.
>=20
> Hi Jarkko, I have checked about your proposal a bit. It look slike we =
need to=20
> Run =E2=80=9Cstruct tpm_tis_data *priv =3D =
dev_get_drvdata(&chip->dev)=E2=80=9D in every wait_for_tpm_stat call. =
Would this be a performance concern ?=20
> If we cache this in tpm_chip instance, it is not the case.=20
>=20
> Please let me know your thought.
>=20
> Hao=20
>=20
>>>=20
>>>>>=20
>>>>> 	struct dentry *bios_dir[TPM_NUM_EVENT_LOG_FILES];
>>>>>=20
>>>>> @@ -269,6 +271,7 @@ enum tpm2_cc_attrs {
>>>>> #define TPM_VID_INTEL    0x8086
>>>>> #define TPM_VID_WINBOND  0x1050
>>>>> #define TPM_VID_STM      0x104A
>>>>> +#define TPM_VID_ATML     0x1114
>>>>>=20
>>>>> enum tpm_chip_flags {
>>>>> 	TPM_CHIP_FLAG_TPM2		=3D BIT(1),
>>>>> --=20
>>>>> 2.29.0.vfs.0.0
>>>>>=20
>>>>=20
>>>> Just kindly remind this code review in case it has been missed =
somehow
>>>=20
>>> I'm sorry, my bad. I managed to somehow miss this. Might be because
>>> I've been recently reorganizing my email accounts. And thanks for
>>> pinging so that I spotted it.
>> No worries, thanks for quick response!
>>=20
>>>=20
>>>> Thanks
>>>> Hao
>>>=20
>>> /Jarkko
>>=20
>> Hao
>=20

