Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3DE33F821C
	for <lists+linux-integrity@lfdr.de>; Thu, 26 Aug 2021 07:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238082AbhHZFjK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 26 Aug 2021 01:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhHZFjK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 26 Aug 2021 01:39:10 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75532C061757
        for <linux-integrity@vger.kernel.org>; Wed, 25 Aug 2021 22:38:23 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id n18so2101904pgm.12
        for <linux-integrity@vger.kernel.org>; Wed, 25 Aug 2021 22:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rubrik.com; s=google;
        h=from:content-transfer-encoding:mime-version:subject:date:references
         :to:in-reply-to:message-id;
        bh=ZzvP7yPT0g/qyYRvRzpb/HX8svhsDldosKftGlny+eM=;
        b=HhwcIVX+MO5aNcPCm1ayYokvNBYkcaklq/Q7BlBXOqGUPbS4cG6JOOFXDUGNbfbAUl
         yaEDTO0D6K3hdK4vdPAE6wMe7UCY8k/ZJtJ6FJ2RsEFpPCGxjm8ii7qpI+CRaJlQEDIw
         GV5NVX3FjHKH6mcCbXUCbvPEU7NPHVhZDWel4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:date:references:to:in-reply-to:message-id;
        bh=ZzvP7yPT0g/qyYRvRzpb/HX8svhsDldosKftGlny+eM=;
        b=KU5PDRJlMRRyg0BUWBRSQ1aIoYfo4atRY0tmd3t22yCckoJyhRh9KzvD+Xyh/3BIsR
         jMWryk14Mdk+1kS2CeguW2EOTRz/arprpHlyp3DjLxB8vyZ1kwluTsj9I7Ijho73PALS
         1nUtlQpCam+FU7HGkAgXBwMkMgiaRcclVmKgeYX9IKQ+pjb3YRxdeixuTjei2F8Lctgz
         pgJjzb1+WgGfeQ3+nMPmMUtrtYUilF30gdzEIW/6gx21ys/a5fxuls7xWk1tQYFIoC05
         fxcLQPPMMrXwc1YKA7OyAIxg+ifNEMIAb+mg9hfScKRQgxiGxATgDUEbDlcQT3o6kP8n
         3J3g==
X-Gm-Message-State: AOAM530SGqjy4FwGnQihbSduXN9dYdX/Hcwjv8FDkuluN9Av4v/tJsh3
        hl5MGpUOtStpamr8fC1edBZzxw==
X-Google-Smtp-Source: ABdhPJx8LdYRsKjllWivVtW2jp/YnATwB1iPEv0+uoUcTCRJos3SVBgt5q0WM7SkhlMlqehcMZmfug==
X-Received: by 2002:a63:4614:: with SMTP id t20mr1855554pga.372.1629956302706;
        Wed, 25 Aug 2021 22:38:22 -0700 (PDT)
Received: from [10.0.0.5] (c-73-231-56-47.hsd1.ca.comcast.net. [73.231.56.47])
        by smtp.gmail.com with ESMTPSA id x26sm1418726pfm.77.2021.08.25.22.38.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Aug 2021 22:38:22 -0700 (PDT)
From:   Hao Wu <hao.wu@rubrik.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH v4] tpm: fix Atmel TPM crash caused by too frequent
 queries
Date:   Wed, 25 Aug 2021 22:38:20 -0700
References: <20210711075122.30056-1-hao.wu@rubrik.com>
 <20210814222519.42476-1-hao.wu@rubrik.com>
To:     Hao Wu <hao.wu@rubrik.com>,
        Shrihari Kalkar <shrihari.kalkar@rubrik.com>,
        Han Seungyeop <seungyeop.han@rubrik.com>,
        Anish Jhaveri <anish.jhaveri@rubrik.com>, peterhuewe@gmx.de,
        Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Ken Goldman <kgold@linux.ibm.com>, zohar@linux.vnet.ibm.com,
        why2jjj.linux@gmail.com, Hamza Attak <hamza@hpe.com>,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        Nayna <nayna@linux.vnet.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
In-Reply-To: <20210814222519.42476-1-hao.wu@rubrik.com>
Message-Id: <B58587F6-AF3F-4224-B6F6-E3886EE80413@rubrik.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> On Aug 14, 2021, at 3:25 PM, Hao Wu <hao.wu@rubrik.com> wrote:
>=20
> The Atmel TPM 1.2 chips crash with error
> `tpm_try_transmit: send(): error -62` since kernel 4.14.
> It is observed from the kernel log after running `tpm_sealdata -z`.
> The error thrown from the command is as follows
> ```
> $ tpm_sealdata -z
> Tspi_Key_LoadKey failed: 0x00001087 - layer=3Dtddl,
> code=3D0087 (135), I/O error
> ```
>=20
> The issue was reproduced with the following Atmel TPM chip:
> ```
> $ tpm_version
> T0  TPM 1.2 Version Info:
>  Chip Version:        1.2.66.1
>  Spec Level:          2
>  Errata Revision:     3
>  TPM Vendor ID:       ATML
>  TPM Version:         01010000
>  Manufacturer Info:   41544d4c
> ```
>=20
> The root cause of the issue is due to the TPM calls to msleep()
> were replaced with usleep_range() [1], which reduces
> the actual timeout. Via experiments, it is observed that
> the original msleep(5) actually sleeps for 15ms.
> Because of a known timeout issue in Atmel TPM 1.2 chip,
> the shorter timeout than 15ms can cause the error described above.
>=20
> A few further changes in kernel 4.16 [2] and 4.18 [3, 4] further
> reduced the timeout to less than 1ms. With experiments,
> the problematic timeout in the latest kernel is the one
> for `wait_for_tpm_stat`.
>=20
> To fix it, the patch reverts the timeout of `wait_for_tpm_stat`
> to 15ms for all Atmel TPM 1.2 chips, but leave it untouched
> for Ateml TPM 2.0 chip, and chips from other vendors.
> As explained above, the chosen 15ms timeout is
> the actual timeout before this issue introduced,
> thus the old value is used here.
> Particularly, TPM_ATML_TIMEOUT_WAIT_STAT_MIN is set to 14700us,
> TPM_ATML_TIMEOUT_WAIT_STAT_MIN is set to 15000us according to
> the existing TPM_TIMEOUT_RANGE_US (300us).
> The fixed has been tested in the system with the affected Atmel chip
> with no issues observed after boot up.
>=20
> References:
> [1] 9f3fc7bcddcb tpm: replace msleep() with usleep_range() in TPM
> 1.2/2.0 generic drivers
> [2] cf151a9a44d5 tpm: reduce tpm polling delay in tpm_tis_core
> [3] 59f5a6b07f64 tpm: reduce poll sleep time in tpm_transmit()
> [4] 424eaf910c32 tpm: reduce polling time to usecs for even finer
> granularity
>=20
> Fixes: 9f3fc7bcddcb ("tpm: replace msleep() with usleep_range() in TPM =
1.2/2.0 generic drivers")
> Link: =
https://patchwork.kernel.org/project/linux-integrity/patch/20200926223150.=
109645-1-hao.wu@rubrik.com/
> Signed-off-by: Hao Wu <hao.wu@rubrik.com>
> ---
> v4:
> - Move timeout constants to drivers/char/tpm/tpm_tis_core.h
> - Cleanup unnecessary inline comment
>=20
> v3:
> - removes unnecessary condition check in `wait_for_tpm_stat`
>=20
> v2:
> - follow the existing way to define two timeouts (min and max)
>  for ATMEL chip, thus keep the exact timeout logic for=20
>  non-ATEML chips.
> - limit the timeout increase to only ATMEL TPM 1.2 chips,
>  because it is not an issue for TPM 2.0 chips yet.
>=20
> Test Plan:
> - Run fixed kernel with ATMEL TPM chips and see crash
> has been fixed.
> - Run fixed kernel with non-ATMEL TPM chips, and confirm
> the timeout has not been changed.
>=20
> drivers/char/tpm/tpm_tis_core.c | 13 +++++++++++--
> drivers/char/tpm/tpm_tis_core.h |  2 ++
> include/linux/tpm.h             |  3 +++
> 3 files changed, 16 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/char/tpm/tpm_tis_core.c =
b/drivers/char/tpm/tpm_tis_core.c
> index 55b9d3965ae1..24605f100e96 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -80,8 +80,8 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, =
u8 mask,
> 		}
> 	} else {
> 		do {
> -			usleep_range(TPM_TIMEOUT_USECS_MIN,
> -				     TPM_TIMEOUT_USECS_MAX);
> +			usleep_range(chip->timeout_wait_stat_min,
> +				     chip->timeout_wait_stat_max);
> 			status =3D chip->ops->status(chip);
> 			if ((status & mask) =3D=3D mask)
> 				return 0;
> @@ -934,6 +934,8 @@ int tpm_tis_core_init(struct device *dev, struct =
tpm_tis_data *priv, int irq,
> 	chip->timeout_b =3D msecs_to_jiffies(TIS_TIMEOUT_B_MAX);
> 	chip->timeout_c =3D msecs_to_jiffies(TIS_TIMEOUT_C_MAX);
> 	chip->timeout_d =3D msecs_to_jiffies(TIS_TIMEOUT_D_MAX);
> +	chip->timeout_wait_stat_min =3D TPM_TIMEOUT_USECS_MIN;
> +	chip->timeout_wait_stat_max =3D TPM_TIMEOUT_USECS_MAX;
> 	priv->phy_ops =3D phy_ops;
> 	dev_set_drvdata(&chip->dev, priv);
>=20
> @@ -983,6 +985,13 @@ int tpm_tis_core_init(struct device *dev, struct =
tpm_tis_data *priv, int irq,
>=20
> 	priv->manufacturer_id =3D vendor;
>=20
> +	if (priv->manufacturer_id =3D=3D TPM_VID_ATML &&
> +		!(chip->flags & TPM_CHIP_FLAG_TPM2)) {
> +		/* If TPM chip is 1.2 ATMEL chip, timeout need to be =
relaxed*/
> +		chip->timeout_wait_stat_min =3D =
TPM_ATML_TIMEOUT_WAIT_STAT_MIN;
> +		chip->timeout_wait_stat_max =3D =
TPM_ATML_TIMEOUT_WAIT_STAT_MAX;
> +	}
> +
> 	rc =3D tpm_tis_read8(priv, TPM_RID(0), &rid);
> 	if (rc < 0)
> 		goto out_err;
> diff --git a/drivers/char/tpm/tpm_tis_core.h =
b/drivers/char/tpm/tpm_tis_core.h
> index 9b2d32a59f67..2e431beb44f7 100644
> --- a/drivers/char/tpm/tpm_tis_core.h
> +++ b/drivers/char/tpm/tpm_tis_core.h
> @@ -54,6 +54,8 @@ enum tis_defaults {
> 	TIS_MEM_LEN =3D 0x5000,
> 	TIS_SHORT_TIMEOUT =3D 750,	/* ms */
> 	TIS_LONG_TIMEOUT =3D 2000,	/* 2 sec */
> +	TPM_ATML_TIMEOUT_WAIT_STAT_MIN =3D 14700,	/* usecs */
> +	TPM_ATML_TIMEOUT_WAIT_STAT_MAX =3D 15000,	/* usecs */
> };
>=20
> /* Some timeout values are needed before it is known whether the chip =
is
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index aa11fe323c56..171b9102c976 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -150,6 +150,8 @@ struct tpm_chip {
> 	bool timeout_adjusted;
> 	unsigned long duration[TPM_NUM_DURATIONS]; /* jiffies */
> 	bool duration_adjusted;
> +	unsigned int timeout_wait_stat_min; /* usecs */
> +	unsigned int timeout_wait_stat_max; /* usecs */
>=20
> 	struct dentry *bios_dir[TPM_NUM_EVENT_LOG_FILES];
>=20
> @@ -269,6 +271,7 @@ enum tpm2_cc_attrs {
> #define TPM_VID_INTEL    0x8086
> #define TPM_VID_WINBOND  0x1050
> #define TPM_VID_STM      0x104A
> +#define TPM_VID_ATML     0x1114
>=20
> enum tpm_chip_flags {
> 	TPM_CHIP_FLAG_TPM2		=3D BIT(1),
> --=20
> 2.29.0.vfs.0.0
>=20

Just kindly remind this code review in case it has been missed somehow

Thanks
Hao

