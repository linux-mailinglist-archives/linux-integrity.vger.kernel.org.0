Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C453B9CFD
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Jul 2021 09:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhGBHiJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Jul 2021 03:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhGBHiJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Jul 2021 03:38:09 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78114C061762
        for <linux-integrity@vger.kernel.org>; Fri,  2 Jul 2021 00:35:37 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so8592661pjs.2
        for <linux-integrity@vger.kernel.org>; Fri, 02 Jul 2021 00:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=i3LfBdrSAqgXwTmstJm+LvoPnweS7QXRYvzbJ2Qhouo=;
        b=IZeglaaJn+4HRI0ibEL45tN9ZmBa4TeS/Nj2gCdJ1vZrcIyvcnnZzjnCZ2Tlf2e7UP
         n9cYcKy0q54Jr2yLHSX8riyyV7KIrd9ScBUVEM6xX6D7Ug6G44HWudlQ4ZPasUxRLTOY
         LB0/dTUZCA+HBoH5RzOMrEriNEcC8vdZgerE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=i3LfBdrSAqgXwTmstJm+LvoPnweS7QXRYvzbJ2Qhouo=;
        b=mjlveAoUr4YdWN5WxglRfy5eFCVTNzOcXAOEiEVXGCLx8z8NdrSTyitOYrnKJt2ZlR
         8YX1VAwZdfevN/uhabVA7Rnj3/glR8ZxAVNImYwUnbbBZZD+PANQScPMM9AohItrpTwI
         XI5Nx0kxvbYErhTcuaNhPxo5dzasR/jl4oywnQZpeGQoLYi5394LGJqsTDp4pKtbVQIl
         qC582dGOj3bIkLKzOmN6aGk8W6fu5LxLdf84D0KVoJ/S2zof0rhPavZ1wbKlmp7fpzwS
         bWB1Kzgv9u8ah2hG1wuCVVZW8IXD3oIWZ9KywPna7cT0dbvbe2KB8Fc2uXarbxX/eTQs
         6lCA==
X-Gm-Message-State: AOAM533BYWmSMFsxp8KXhnctrjP1MYrp36z4XyPhWbm7GEdwPcS/u8v3
        VsClWgKSmJdiP4+VIXOGe/zlCQ==
X-Google-Smtp-Source: ABdhPJwMKtPdoKBx8wcDLPX3mY2Kbrou7yKHXqUVP/UER+FwBGVKc6feu0MM7tJnQ49GQuT0LKKliA==
X-Received: by 2002:a17:90a:ee8e:: with SMTP id i14mr13708863pjz.29.1625211336279;
        Fri, 02 Jul 2021 00:35:36 -0700 (PDT)
Received: from [10.0.0.5] (c-73-231-56-47.hsd1.ca.comcast.net. [73.231.56.47])
        by smtp.gmail.com with ESMTPSA id u24sm2405476pfm.200.2021.07.02.00.35.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Jul 2021 00:35:35 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH] tpm: fix ATMEL TPM crash caused by too frequent queries
From:   Hao Wu <hao.wu@rubrik.com>
In-Reply-To: <939BC11F-0905-4777-9DD7-630FC28ED205@rubrik.com>
Date:   Fri, 2 Jul 2021 00:35:34 -0700
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
Message-Id: <47465906-6079-4B7A-AE2C-C9C80B554F70@rubrik.com>
References: <20210624053321.861-1-hao.wu@rubrik.com>
 <20210630042205.30051-1-hao.wu@rubrik.com>
 <20210702063555.q2phirfv7wxc6axu@kernel.org>
 <939BC11F-0905-4777-9DD7-630FC28ED205@rubrik.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



> On Jul 2, 2021, at 12:33 AM, Hao Wu <hao.wu@rubrik.com> wrote:
>=20
>=20
>=20
>> On Jul 1, 2021, at 11:35 PM, Jarkko Sakkinen <jarkko@kernel.org> =
wrote:
>>=20
>> On Tue, Jun 29, 2021 at 09:22:05PM -0700, Hao Wu wrote:
>>> This is a fix for the ATMEL TPM crash bug reported in
>>> =
https://patchwork.kernel.org/project/linux-integrity/patch/20200926223150.=
109645-1-hao.wu@rubrik.com/
>>>=20
>>> According to the discussions in the original thread,
>>> we don't want to revert the timeout of wait_for_tpm_stat
>>> for non-ATMEL chips, which brings back the performance cost.
>>> For investigation and analysis of why wait_for_tpm_stat
>>> caused the issue, and how the regression was introduced,
>>> please read the original thread above.
>>>=20
>>> Thus the proposed fix here is to only revert the timeout
>>> for ATMEL chips by checking the vendor ID.
>>>=20
>>> Signed-off-by: Hao Wu <hao.wu@rubrik.com>
>>> Fixes: 9f3fc7bcddcb ("tpm: replace msleep() with usleep_range() in =
TPM 1.2/2.0 generic drivers")
>>=20
>> Fixes tag should be before SOB.
>>=20
>>> ---
>>> Test Plan:
>>> - Run fixed kernel with ATMEL TPM chips and see crash
>>> has been fixed.
>>> - Run fixed kernel with non-ATMEL TPM chips, and confirm
>>> the timeout has not been changed.
>>>=20
>>> drivers/char/tpm/tpm.h          |  9 ++++++++-
>>> drivers/char/tpm/tpm_tis_core.c | 19 +++++++++++++++++--
>>> include/linux/tpm.h             |  2 ++
>>> 3 files changed, 27 insertions(+), 3 deletions(-)
>>>=20
>>> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
>>> index 283f78211c3a..bc6aa7f9e119 100644
>>> --- a/drivers/char/tpm/tpm.h
>>> +++ b/drivers/char/tpm/tpm.h
>>> @@ -42,7 +42,9 @@ enum tpm_timeout {
>>> 	TPM_TIMEOUT_RANGE_US =3D 300,	/* usecs */
>>> 	TPM_TIMEOUT_POLL =3D 1,	/* msecs */
>>> 	TPM_TIMEOUT_USECS_MIN =3D 100,      /* usecs */
>>> -	TPM_TIMEOUT_USECS_MAX =3D 500      /* usecs */
>>> +	TPM_TIMEOUT_USECS_MAX =3D 500,	/* usecs */
>>=20
>> What is this change?
> Need to add the tailing comma
Ah, sorry, didn=E2=80=99t notice added the duplicated line by mistake. =
Will remove it.=20
>=20
>>=20
>>> +	TPM_TIMEOUT_WAIT_STAT =3D 500,	/* usecs */
>>> +	TPM_ATML_TIMEOUT_WAIT_STAT =3D 15000	/* usecs */
>>> };
>>>=20
>>> /* TPM addresses */
>>> @@ -189,6 +191,11 @@ static inline void tpm_msleep(unsigned int =
delay_msec)
>>> 		     delay_msec * 1000);
>>> };
>>>=20
>>> +static inline void tpm_usleep(unsigned int delay_usec)
>>> +{
>>> +	usleep_range(delay_usec - TPM_TIMEOUT_RANGE_US, delay_usec);
>>> +};
>>=20
>> Please remove this, and open code.
> Ok, will do
>=20
>>> +
>>> int tpm_chip_start(struct tpm_chip *chip);
>>> void tpm_chip_stop(struct tpm_chip *chip);
>>> struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip);
>>> diff --git a/drivers/char/tpm/tpm_tis_core.c =
b/drivers/char/tpm/tpm_tis_core.c
>>> index 55b9d3965ae1..9ddd4edfe1c2 100644
>>> --- a/drivers/char/tpm/tpm_tis_core.c
>>> +++ b/drivers/char/tpm/tpm_tis_core.c
>>> @@ -80,8 +80,12 @@ static int wait_for_tpm_stat(struct tpm_chip =
*chip, u8 mask,
>>> 		}
>>> 	} else {
>>> 		do {
>>> -			usleep_range(TPM_TIMEOUT_USECS_MIN,
>>> -				     TPM_TIMEOUT_USECS_MAX);
>>> +			if (chip->timeout_wait_stat &&=20
>>> +				chip->timeout_wait_stat >=3D =
TPM_TIMEOUT_WAIT_STAT) {
>>> +				tpm_usleep((unsigned =
int)(chip->timeout_wait_stat));
>>> +			} else {
>>> +				tpm_usleep((unsigned =
int)(TPM_TIMEOUT_WAIT_STAT));
>>> +			}
>>=20
>> Invalid use of braces. Please read
>>=20
>> https://www.kernel.org/doc/html/v5.13/process/coding-style.html
>>=20
>> Why do you have to use this field conditionally anyway? Why doesn't
>> it always contain a legit value?
> The field is legit now, but doesn=E2=80=99t hurt to do addition check =
for robustness=20
> to ensure no crash ? Just in case the value is updated below =
TPM_TIMEOUT_WAIT_STAT ?=20
>=20
> Can remove if we think it is not needed.
>=20
>>=20
>>> 			status =3D chip->ops->status(chip);
>>> 			if ((status & mask) =3D=3D mask)
>>> 				return 0;
>>> @@ -934,6 +938,8 @@ int tpm_tis_core_init(struct device *dev, struct =
tpm_tis_data *priv, int irq,
>>> 	chip->timeout_b =3D msecs_to_jiffies(TIS_TIMEOUT_B_MAX);
>>> 	chip->timeout_c =3D msecs_to_jiffies(TIS_TIMEOUT_C_MAX);
>>> 	chip->timeout_d =3D msecs_to_jiffies(TIS_TIMEOUT_D_MAX);
>>> +	/* init timeout for wait_for_tpm_stat */
>>> +	chip->timeout_wait_stat =3D TPM_TIMEOUT_WAIT_STAT;
>>> 	priv->phy_ops =3D phy_ops;
>>> 	dev_set_drvdata(&chip->dev, priv);
>>>=20
>>> @@ -983,6 +989,15 @@ int tpm_tis_core_init(struct device *dev, =
struct tpm_tis_data *priv, int irq,
>>>=20
>>> 	priv->manufacturer_id =3D vendor;
>>>=20
>>> +	switch (priv->manufacturer_id) {
>>> +	case TPM_VID_ATML:
>>> +        /* ATMEL chip needs longer timeout to avoid crash */
> Will fix the indentation
>=20
> Also according to Kenneth we only want to do so for TPM 1.2,=20
> I will try checking chip->flags against TPM_CHIP_FLAG_TPM2 here
> Let me know if there are concerns.
>=20
>>> +		chip->timeout_wait_stat =3D TPM_ATML_TIMEOUT_WAIT_STAT;
>>> +		break;
>>> +	default:
>>> +		chip->timeout_wait_stat =3D TPM_TIMEOUT_WAIT_STAT;
>>> +	}
>>> +
>>> 	rc =3D tpm_tis_read8(priv, TPM_RID(0), &rid);
>>> 	if (rc < 0)
>>> 		goto out_err;
>>> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
>>> index aa11fe323c56..35f2a0260d76 100644
>>> --- a/include/linux/tpm.h
>>> +++ b/include/linux/tpm.h
>>> @@ -150,6 +150,7 @@ struct tpm_chip {
>>> 	bool timeout_adjusted;
>>> 	unsigned long duration[TPM_NUM_DURATIONS]; /* jiffies */
>>> 	bool duration_adjusted;
>>> +	unsigned long timeout_wait_stat; /* usecs */
>>>=20
>>> 	struct dentry *bios_dir[TPM_NUM_EVENT_LOG_FILES];
>>>=20
>>> @@ -269,6 +270,7 @@ enum tpm2_cc_attrs {
>>> #define TPM_VID_INTEL    0x8086
>>> #define TPM_VID_WINBOND  0x1050
>>> #define TPM_VID_STM      0x104A
>>> +#define TPM_VID_ATML     0x1114
>>>=20
>>> enum tpm_chip_flags {
>>> 	TPM_CHIP_FLAG_TPM2		=3D BIT(1),
>>> --=20
>>> 2.29.0.vfs.0.0
>>>=20
>>>=20
>>=20
>> /Jarkko

Hao

