Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB553D6CF3
	for <lists+linux-integrity@lfdr.de>; Tue, 27 Jul 2021 05:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbhG0C7o (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 26 Jul 2021 22:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbhG0C7o (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 26 Jul 2021 22:59:44 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17744C061757
        for <linux-integrity@vger.kernel.org>; Mon, 26 Jul 2021 20:40:12 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d17so14173787plh.10
        for <linux-integrity@vger.kernel.org>; Mon, 26 Jul 2021 20:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=g0AgvF8xquxypcp4RaPY+Pw3yMfx/gTxJWeoYtSMHzo=;
        b=G3U6+QPoV90i7bQHuFswWPU6FT20s0Zcu8s5n87JFhyB3wR4vCEKC6eRrplmDJzZr9
         NjTeeavZaA0g9tPT1H+g5XngvUYSW6MbN/QPbOR2iQqBl0xNklETs8u0uu620wdMBE5c
         HAZOa0Z7Iez9dA6eZoiBTjxn4rs9AN6dV6uH8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=g0AgvF8xquxypcp4RaPY+Pw3yMfx/gTxJWeoYtSMHzo=;
        b=cx3ymRrqy/bA06g+22C5hr58MiV730p0ZCKxr2uu1sbosHQ4CrCtPEfaUTLk1W9ukN
         Og3cRs1H2xVkSIjW1GBMz/j4BYVoFvvlS9R8ohttrfLRdhgNUMzfGnkhjr0t3ZAjvjc2
         riamB/Ot+r4nRC3sFrqpMYkP3z8X56K+kNR3jQT7GjnLvNhYaySB9pjuz9iylehZ/7up
         /75L6LzFPYSPHedrnuMvncT3rfAPKFFdwOe8wtnr2Jsl6vUW0zrXN7G/A0GAHPw8pEuQ
         DGaLpMk2lt9STEQ1CBiwmTvaEZwZyxowhvcdGXAL/PtweFWOYNSWgFpACxkwF1Q1wyih
         Uydg==
X-Gm-Message-State: AOAM532u2eyGQLjXnyfYkm9tid84iNWEyQ3unnHkcyWDglyHs6j2Z2eG
        boVM3GaWpd1xPDa/6qJ/sluhXg==
X-Google-Smtp-Source: ABdhPJzB48lx1G/D+18J0b6FSxLe2R3Hari4LRFtxCSPzSZgGUDpuT/5jvFML61HvFxgg6y9xMZaUw==
X-Received: by 2002:a17:902:ea8a:b029:12a:fb40:d7ed with SMTP id x10-20020a170902ea8ab029012afb40d7edmr16821186plb.46.1627357211466;
        Mon, 26 Jul 2021 20:40:11 -0700 (PDT)
Received: from [10.0.0.5] (c-73-231-56-47.hsd1.ca.comcast.net. [73.231.56.47])
        by smtp.gmail.com with ESMTPSA id t19sm1629247pfg.216.2021.07.26.20.40.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jul 2021 20:40:11 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v3] tpm: fix Atmel TPM crash caused by too frequent
 queries
From:   Hao Wu <hao.wu@rubrik.com>
In-Reply-To: <20210727024644.frkuo4a6ssyz6uhc@kernel.org>
Date:   Mon, 26 Jul 2021 20:40:09 -0700
Cc:     Shrihari Kalkar <shrihari.kalkar@rubrik.com>,
        Seungyeop Han <seungyeop.han@rubrik.com>,
        Anish Jhaveri <anish.jhaveri@rubrik.com>, peterhuewe@gmx.de,
        jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        pmenzel@molgen.mpg.de, kgold@linux.ibm.com,
        zohar@linux.vnet.ibm.com, why2jjj.linux@gmail.com, hamza@hpe.com,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        nayna@linux.vnet.ibm.com, James.Bottomley@hansenpartnership.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <8C219D6F-A308-4075-81D9-04C871E5B68D@rubrik.com>
References: <20210709044028.77278-1-hao.wu@rubrik.com>
 <20210711075122.30056-1-hao.wu@rubrik.com>
 <20210727024644.frkuo4a6ssyz6uhc@kernel.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> On Jul 26, 2021, at 7:46 PM, Jarkko Sakkinen <jarkko@kernel.org> =
wrote:
>=20
> On Sun, Jul 11, 2021 at 12:51:22AM -0700, Hao Wu wrote:
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
>> This version (v3) removes unnecessary condition check
>> in `wait_for_tpm_stat`.
>=20
> Missing change long v1 -> v2.
>=20
> Please do something like
>=20
> v3:
> - ...
>=20
> v2:
> - ...
Ok, I thought it is chained. I will add all changes

>>=20
>> Test Plan:
>> - Run fixed kernel with ATMEL TPM chips and see crash
>> has been fixed.
>> - Run fixed kernel with non-ATMEL TPM chips, and confirm
>> the timeout has not been changed.
>>=20
>> drivers/char/tpm/tpm.h          |  6 ++++--
>> drivers/char/tpm/tpm_tis_core.c | 14 ++++++++++++--
>> include/linux/tpm.h             |  3 +++
>> 3 files changed, 19 insertions(+), 4 deletions(-)
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
The spaces of this this line is wrong, it should use tab instead of =
spaces before the `/*`.=20
Fixing this by the way here and align the comment=20
>> +	TPM_TIMEOUT_USECS_MAX =3D 500,	/* usecs */
You need to add tailing comma, don=E2=80=99t we?
> What is going on here?
>=20
> These lines should not change.

>=20
>> +	TPM_ATML_TIMEOUT_WAIT_STAT_MIN =3D 14700,	/* usecs */
>> +	TPM_ATML_TIMEOUT_WAIT_STAT_MAX =3D 15000	/* usecs */
>=20
> Move these definitions to tpm_tis_core.h. They are only useful
> for a single driver.
I thought putting them along with the original MIN / MAX is easier to =
understand for code reader.=20
Let me know if you have strong opinion though.

>=20
>> };
>>=20
>> /* TPM addresses */
>> diff --git a/drivers/char/tpm/tpm_tis_core.c =
b/drivers/char/tpm/tpm_tis_core.c
>> index 55b9d3965ae1..2de1f71e8ae1 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -80,8 +80,8 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, =
u8 mask,
>> 		}
>> 	} else {
>> 		do {
>> -			usleep_range(TPM_TIMEOUT_USECS_MIN,
>> -				     TPM_TIMEOUT_USECS_MAX);
>> +			usleep_range(chip->timeout_wait_stat_min,
>> +				     chip->timeout_wait_stat_max);
>> 			status =3D chip->ops->status(chip);
>> 			if ((status & mask) =3D=3D mask)
>> 				return 0;
>> @@ -934,6 +934,9 @@ int tpm_tis_core_init(struct device *dev, struct =
tpm_tis_data *priv, int irq,
>> 	chip->timeout_b =3D msecs_to_jiffies(TIS_TIMEOUT_B_MAX);
>> 	chip->timeout_c =3D msecs_to_jiffies(TIS_TIMEOUT_C_MAX);
>> 	chip->timeout_d =3D msecs_to_jiffies(TIS_TIMEOUT_D_MAX);
>> +	/* init timeouts for wait_for_tpm_stat */
>=20
> Remove this comment.
Ok

>=20
>> +	chip->timeout_wait_stat_min =3D TPM_TIMEOUT_USECS_MIN;
>> +	chip->timeout_wait_stat_max =3D TPM_TIMEOUT_USECS_MAX;
>> 	priv->phy_ops =3D phy_ops;
>> 	dev_set_drvdata(&chip->dev, priv);
>>=20
>> @@ -983,6 +986,13 @@ int tpm_tis_core_init(struct device *dev, struct =
tpm_tis_data *priv, int irq,
>>=20
>> 	priv->manufacturer_id =3D vendor;
>>=20
>> +	if (priv->manufacturer_id =3D=3D TPM_VID_ATML &&
>> +		!(chip->flags & TPM_CHIP_FLAG_TPM2)) {
>> +		/* If TPM chip is 1.2 ATMEL chip, timeout need to be =
relaxed*/
>> +		chip->timeout_wait_stat_min =3D =
TPM_ATML_TIMEOUT_WAIT_STAT_MIN;
>> +		chip->timeout_wait_stat_max =3D =
TPM_ATML_TIMEOUT_WAIT_STAT_MAX;
>> +	}
>> +
>> 	rc =3D tpm_tis_read8(priv, TPM_RID(0), &rid);
>> 	if (rc < 0)
>> 		goto out_err;
>> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
>> index aa11fe323c56..171b9102c976 100644
>> --- a/include/linux/tpm.h
>> +++ b/include/linux/tpm.h
>> @@ -150,6 +150,8 @@ struct tpm_chip {
>> 	bool timeout_adjusted;
>> 	unsigned long duration[TPM_NUM_DURATIONS]; /* jiffies */
>> 	bool duration_adjusted;
>> +	unsigned int timeout_wait_stat_min; /* usecs */
>> +	unsigned int timeout_wait_stat_max; /* usecs */
>>=20
>> 	struct dentry *bios_dir[TPM_NUM_EVENT_LOG_FILES];
>>=20
>> @@ -269,6 +271,7 @@ enum tpm2_cc_attrs {
>> #define TPM_VID_INTEL    0x8086
>> #define TPM_VID_WINBOND  0x1050
>> #define TPM_VID_STM      0x104A
>> +#define TPM_VID_ATML     0x1114
>>=20
>> enum tpm_chip_flags {
>> 	TPM_CHIP_FLAG_TPM2		=3D BIT(1),
>> --=20
>> 2.29.0.vfs.0.0
>>=20
>>=20
>=20
> /Jarkko

Hao=
