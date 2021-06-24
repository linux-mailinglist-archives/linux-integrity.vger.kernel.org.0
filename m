Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2053B2701
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Jun 2021 07:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhFXFv5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Jun 2021 01:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbhFXFv5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Jun 2021 01:51:57 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D6AC061574
        for <linux-integrity@vger.kernel.org>; Wed, 23 Jun 2021 22:49:38 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id g192so4239665pfb.6
        for <linux-integrity@vger.kernel.org>; Wed, 23 Jun 2021 22:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/qMiiDjTVVEVhBGTCZXuROJS4iLqQmqppfn3kW2spzs=;
        b=gKChsoNlNSvJIX5AiHLHvguOzp3/Vq6i/NSykYmlOlO7HG7Lw3eUCJeyOquxw6Bxge
         16HTg3heiUHSlkOkRm5zZnaRsABkxuJS/VM6N97AdMRqT9DyO7FZ1Kj0FEsBPEFJnOJ+
         oaXpnmSUy6WqqMtk3Bu9zAOf955eIwnNtn7AY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/qMiiDjTVVEVhBGTCZXuROJS4iLqQmqppfn3kW2spzs=;
        b=YEiH4flo11XWfgEIbI2TzkdjEKmf9DBpPrHY5RC+JkFgLErhYUdo/kaijv69cKAJ1z
         JizxTnnDTNReVIUBPf6rPr9vVjEixATmtckk9fydMrPXz4N7sTC6tthGLTDu/4xz/tfz
         rPWZaSo98lP53Ilc9LMrSjzZ7tDQYovpRftDPDvk3aLMal3UbjdMH1kWeRadC/eScTV5
         XLWcH0o18NqyDdIcos7rw/rN8VVk7iG3ttUgezQ2ClpaKn1VIb2vvpTp4N02oXo5r09i
         lPu7UguKs37+QgkR77ntTpunHWhsE2xsXuWh9gq59cft7oxvctOL9rrpRMN40O1UHGrR
         A/6A==
X-Gm-Message-State: AOAM532ClbTvmYy5ppeKeUxOugS+skpxZUXcdWwtQtkqLuyfqyJ++gCj
        lXQANXPf5bA0FuJ8NlaPbrP7SQ==
X-Google-Smtp-Source: ABdhPJwYXxYp2aa1wzBrl5w6XVNgZ7Kj8dTOAkEbe8Mk916fyRPVLhd8Xwrq6HpaeMdr3KihY/FOVw==
X-Received: by 2002:a65:63c1:: with SMTP id n1mr3247997pgv.398.1624513778184;
        Wed, 23 Jun 2021 22:49:38 -0700 (PDT)
Received: from [10.0.0.5] (c-73-231-56-47.hsd1.ca.comcast.net. [73.231.56.47])
        by smtp.gmail.com with ESMTPSA id q21sm6762897pjg.43.2021.06.23.22.49.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jun 2021 22:49:37 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH] Fix Atmel TPM crash caused by too frequent queries
From:   Hao Wu <hao.wu@rubrik.com>
In-Reply-To: <20210623133518.5vykitqsdwtfqzd6@kernel.org>
Date:   Wed, 23 Jun 2021 22:49:27 -0700
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
Message-Id: <51DCB704-8E9D-40DD-9E81-F1D16EB28BD5@rubrik.com>
References: <20210620231809.21101-1-hao.wu@rubrik.com>
 <20210623133518.5vykitqsdwtfqzd6@kernel.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> On Jun 23, 2021, at 6:35 AM, Jarkko Sakkinen <jarkko@kernel.org> =
wrote:
>=20
> On Sun, Jun 20, 2021 at 04:18:09PM -0700, Hao Wu wrote:
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
>> Test Plan:
>> - Run fixed kernel with ATMEL TPM chips and see crash
>>  has been fixed.
>> - Run fixed kernel with non-ATMEL TPM chips, and confirm
>>  the timeout has not been changed.
>=20
> Please move test plan right before diffstat if you wan to include =
such,
> so that it does not go into the commit log.
Hi Jarkko, not sure I understood your suggestion or not. I removed
the test plan from the commit message in a updated commit
=
https://patchwork.kernel.org/project/linux-integrity/patch/20210624053321.=
861-1-hao.wu@rubrik.com/

Let me know if I misunderstood this. I am fine to not include test plan,
If this is not something expected by linux community.
I personally think it is helpful to understand the confidence of the =
commit.

>=20
>> ---
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

Hao

