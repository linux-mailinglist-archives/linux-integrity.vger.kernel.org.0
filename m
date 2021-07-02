Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E356F3B9CF9
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Jul 2021 09:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbhGBHfv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Jul 2021 03:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhGBHfu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Jul 2021 03:35:50 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7B2C061762
        for <linux-integrity@vger.kernel.org>; Fri,  2 Jul 2021 00:33:18 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id z4so5135000plg.8
        for <linux-integrity@vger.kernel.org>; Fri, 02 Jul 2021 00:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IPCyJXTRNOVLT+ez51lCfrBywJDi/tcjhTAPbZrBT8g=;
        b=ExsYyfaDYOYiXhR4xvk8r+rnCfC5TAzgsPhfLE1Xg2L1rx/NRgPTpILSRho6cswDmZ
         k7lmDVcE4BK0nDkqozuD01MxyhWfgpESvOOzscgFx+kvC+UPB09nPEbXq2Ta0cJZBYxY
         U78Ha4afuohz9LAqoxFInr6OD2yMogvkyoy70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=IPCyJXTRNOVLT+ez51lCfrBywJDi/tcjhTAPbZrBT8g=;
        b=R7dwgNHqEEAxlKiZk3eg1Dw/WSXJNOHU3iP2BHVZIi8M+CpwNrMAUMyT30YvTZBWjQ
         kK+0nNAM1wreiRMFzJDH4qDTh6kq/Ai+wSa8kkyJ2zIHpP1uoeAI/yn0XSX64oEbCRMW
         emMW5uw2EQJVSv2HSaMf9UN/4JOSEWfcyVxiK8uKQMjtg2Ujj9IiXVRmpRUYoFhuVer2
         ASqd2FYytYZwUReP+Ncd1qa2cQadILOR89u3+UBhhM2jynZGIwLFQL1mhpk3mxDfifAU
         6lvFBAnANQmjqFC+vBwO3JLIg5qJck6y92mMUomDHQykgdmHXIa9NzRoFsV7Ij6ugt9W
         EP5w==
X-Gm-Message-State: AOAM531qmDTdHg2wGGf1/ouC3ocyalljJMRT8MvUlLrwJgtSApwHlkd3
        A3nuO2CS+oeJv9J8YI8K4ZcQF8vLo8RX7m/F
X-Google-Smtp-Source: ABdhPJyjEwTJizE3yD82jV+Bw0EbEK7WuEqVEMN2NeOqY5dp1KDS7zkLHxdCxWM4/8Mx6Niq5JYzhg==
X-Received: by 2002:a17:90a:498a:: with SMTP id d10mr2606817pjh.118.1625211198001;
        Fri, 02 Jul 2021 00:33:18 -0700 (PDT)
Received: from [10.0.0.5] (c-73-231-56-47.hsd1.ca.comcast.net. [73.231.56.47])
        by smtp.gmail.com with ESMTPSA id d127sm2307654pfc.50.2021.07.02.00.33.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Jul 2021 00:33:17 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH] tpm: fix ATMEL TPM crash caused by too frequent queries
From:   Hao Wu <hao.wu@rubrik.com>
In-Reply-To: <20210702063555.q2phirfv7wxc6axu@kernel.org>
Date:   Fri, 2 Jul 2021 00:33:15 -0700
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
Message-Id: <939BC11F-0905-4777-9DD7-630FC28ED205@rubrik.com>
References: <20210624053321.861-1-hao.wu@rubrik.com>
 <20210630042205.30051-1-hao.wu@rubrik.com>
 <20210702063555.q2phirfv7wxc6axu@kernel.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



> On Jul 1, 2021, at 11:35 PM, Jarkko Sakkinen <jarkko@kernel.org> =
wrote:
>=20
> On Tue, Jun 29, 2021 at 09:22:05PM -0700, Hao Wu wrote:
>> This is a fix for the ATMEL TPM crash bug reported in
>> =
https://patchwork.kernel.org/project/linux-integrity/patch/20200926223150.=
109645-1-hao.wu@rubrik.com/
>>=20
>> According to the discussions in the original thread,
>> we don't want to revert the timeout of wait_for_tpm_stat
>> for non-ATMEL chips, which brings back the performance cost.
>> For investigation and analysis of why wait_for_tpm_stat
>> caused the issue, and how the regression was introduced,
>> please read the original thread above.
>>=20
>> Thus the proposed fix here is to only revert the timeout
>> for ATMEL chips by checking the vendor ID.
>>=20
>> Signed-off-by: Hao Wu <hao.wu@rubrik.com>
>> Fixes: 9f3fc7bcddcb ("tpm: replace msleep() with usleep_range() in =
TPM 1.2/2.0 generic drivers")
>=20
> Fixes tag should be before SOB.
>=20
>> ---
>> Test Plan:
>> - Run fixed kernel with ATMEL TPM chips and see crash
>> has been fixed.
>> - Run fixed kernel with non-ATMEL TPM chips, and confirm
>> the timeout has not been changed.
>>=20
>> drivers/char/tpm/tpm.h          |  9 ++++++++-
>> drivers/char/tpm/tpm_tis_core.c | 19 +++++++++++++++++--
>> include/linux/tpm.h             |  2 ++
>> 3 files changed, 27 insertions(+), 3 deletions(-)
>>=20
>> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
>> index 283f78211c3a..bc6aa7f9e119 100644
>> --- a/drivers/char/tpm/tpm.h
>> +++ b/drivers/char/tpm/tpm.h
>> @@ -42,7 +42,9 @@ enum tpm_timeout {
>> 	TPM_TIMEOUT_RANGE_US =3D 300,	/* usecs */
>> 	TPM_TIMEOUT_POLL =3D 1,	/* msecs */
>> 	TPM_TIMEOUT_USECS_MIN =3D 100,      /* usecs */
>> -	TPM_TIMEOUT_USECS_MAX =3D 500      /* usecs */
>> +	TPM_TIMEOUT_USECS_MAX =3D 500,	/* usecs */
>=20
> What is this change?
Need to add the tailing comma

>=20
>> +	TPM_TIMEOUT_WAIT_STAT =3D 500,	/* usecs */
>> +	TPM_ATML_TIMEOUT_WAIT_STAT =3D 15000	/* usecs */
>> };
>>=20
>> /* TPM addresses */
>> @@ -189,6 +191,11 @@ static inline void tpm_msleep(unsigned int =
delay_msec)
>> 		     delay_msec * 1000);
>> };
>>=20
>> +static inline void tpm_usleep(unsigned int delay_usec)
>> +{
>> +	usleep_range(delay_usec - TPM_TIMEOUT_RANGE_US, delay_usec);
>> +};
>=20
> Please remove this, and open code.
Ok, will do

>> +
>> int tpm_chip_start(struct tpm_chip *chip);
>> void tpm_chip_stop(struct tpm_chip *chip);
>> struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip);
>> diff --git a/drivers/char/tpm/tpm_tis_core.c =
b/drivers/char/tpm/tpm_tis_core.c
>> index 55b9d3965ae1..9ddd4edfe1c2 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -80,8 +80,12 @@ static int wait_for_tpm_stat(struct tpm_chip =
*chip, u8 mask,
>> 		}
>> 	} else {
>> 		do {
>> -			usleep_range(TPM_TIMEOUT_USECS_MIN,
>> -				     TPM_TIMEOUT_USECS_MAX);
>> +			if (chip->timeout_wait_stat &&=20
>> +				chip->timeout_wait_stat >=3D =
TPM_TIMEOUT_WAIT_STAT) {
>> +				tpm_usleep((unsigned =
int)(chip->timeout_wait_stat));
>> +			} else {
>> +				tpm_usleep((unsigned =
int)(TPM_TIMEOUT_WAIT_STAT));
>> +			}
>=20
> Invalid use of braces. Please read
>=20
> https://www.kernel.org/doc/html/v5.13/process/coding-style.html
>=20
> Why do you have to use this field conditionally anyway? Why doesn't
> it always contain a legit value?
The field is legit now, but doesn=E2=80=99t hurt to do addition check =
for robustness=20
to ensure no crash ? Just in case the value is updated below =
TPM_TIMEOUT_WAIT_STAT ?=20

Can remove if we think it is not needed.

>=20
>> 			status =3D chip->ops->status(chip);
>> 			if ((status & mask) =3D=3D mask)
>> 				return 0;
>> @@ -934,6 +938,8 @@ int tpm_tis_core_init(struct device *dev, struct =
tpm_tis_data *priv, int irq,
>> 	chip->timeout_b =3D msecs_to_jiffies(TIS_TIMEOUT_B_MAX);
>> 	chip->timeout_c =3D msecs_to_jiffies(TIS_TIMEOUT_C_MAX);
>> 	chip->timeout_d =3D msecs_to_jiffies(TIS_TIMEOUT_D_MAX);
>> +	/* init timeout for wait_for_tpm_stat */
>> +	chip->timeout_wait_stat =3D TPM_TIMEOUT_WAIT_STAT;
>> 	priv->phy_ops =3D phy_ops;
>> 	dev_set_drvdata(&chip->dev, priv);
>>=20
>> @@ -983,6 +989,15 @@ int tpm_tis_core_init(struct device *dev, struct =
tpm_tis_data *priv, int irq,
>>=20
>> 	priv->manufacturer_id =3D vendor;
>>=20
>> +	switch (priv->manufacturer_id) {
>> +	case TPM_VID_ATML:
>> +        /* ATMEL chip needs longer timeout to avoid crash */
Will fix the indentation

Also according to Kenneth we only want to do so for TPM 1.2,=20
I will try checking chip->flags against TPM_CHIP_FLAG_TPM2 here
Let me know if there are concerns.
=20
>> +		chip->timeout_wait_stat =3D TPM_ATML_TIMEOUT_WAIT_STAT;
>> +		break;
>> +	default:
>> +		chip->timeout_wait_stat =3D TPM_TIMEOUT_WAIT_STAT;
>> +	}
>> +
>> 	rc =3D tpm_tis_read8(priv, TPM_RID(0), &rid);
>> 	if (rc < 0)
>> 		goto out_err;
>> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
>> index aa11fe323c56..35f2a0260d76 100644
>> --- a/include/linux/tpm.h
>> +++ b/include/linux/tpm.h
>> @@ -150,6 +150,7 @@ struct tpm_chip {
>> 	bool timeout_adjusted;
>> 	unsigned long duration[TPM_NUM_DURATIONS]; /* jiffies */
>> 	bool duration_adjusted;
>> +	unsigned long timeout_wait_stat; /* usecs */
>>=20
>> 	struct dentry *bios_dir[TPM_NUM_EVENT_LOG_FILES];
>>=20
>> @@ -269,6 +270,7 @@ enum tpm2_cc_attrs {
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

