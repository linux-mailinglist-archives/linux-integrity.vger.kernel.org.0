Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77971402DD1
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Sep 2021 19:43:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbhIGRoL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Sep 2021 13:44:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229493AbhIGRoL (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Sep 2021 13:44:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 752CA610F8;
        Tue,  7 Sep 2021 17:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631036585;
        bh=Jgk87UIoLl78ONGQpEPOuuLrDfHtGSg/tpxyZESYRxo=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=shkh4VG6/3Xjz48OSe7IRumUGy9WBv5sr7EOZAL6JmANb6O0mMR5JhTt5pptLIGeU
         /iywEq/bPBQ2n2Yg+fHVUQzaK5WWnsdSv93pn+NK7OAHwhOIDSL5WL7yHczf4WaQ0p
         ECbVG6Fx3AUj5W7XZFZeYFfT5+I+ZfkiaWLx5F3gSey47yYqk/6F3+M7f85S05drD3
         58dsa8NaKOZjp7eS8GC+9EcT4Jgz9FSu1vQLlG4v5FR5XAIwK9MLj81fYkVMHVrhka
         TlNvMaS9hOn/XT16Wunz/icjoaDFlON9+tvOfFpH/FQ0gaGE4rHENRdLOnuDJNIsJ3
         PL9Uz74hjUGhg==
Message-ID: <b2f16ed95526cf47ca32b2fe973733e97cf4632b.camel@kernel.org>
Subject: Re: [PATCH v5] tpm: fix Atmel TPM crash caused by too frequent
 queries
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Hao Wu <hao.wu@rubrik.com>, shrihari.kalkar@rubrik.com,
        seungyeop.han@rubrik.com, anish.jhaveri@rubrik.com,
        peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        pmenzel@molgen.mpg.de, kgold@linux.ibm.com,
        zohar@linux.vnet.ibm.com, why2jjj.linux@gmail.com, hamza@hpe.com,
        gregkh@linuxfoundation.org, arnd@arndb.de,
        nayna@linux.vnet.ibm.com, James.Bottomley@hansenpartnership.com
Date:   Tue, 07 Sep 2021 20:43:02 +0300
In-Reply-To: <20210905035119.15538-1-hao.wu@rubrik.com>
References: <20210814222519.42476-1-hao.wu@rubrik.com>
         <20210905035119.15538-1-hao.wu@rubrik.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, 2021-09-04 at 20:51 -0700, Hao Wu wrote:
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
>   Chip Version:        1.2.66.1
>   Spec Level:          2
>   Errata Revision:     3
>   TPM Vendor ID:       ATML
>   TPM Version:         01010000
>   Manufacturer Info:   41544d4c
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
> Fixes: 9f3fc7bcddcb ("tpm: replace msleep() with usleep_range() in TPM 1.=
2/2.0 generic drivers")
> Link: https://patchwork.kernel.org/project/linux-integrity/patch/20200926=
223150.109645-1-hao.wu@rubrik.com/
> Signed-off-by: Hao Wu <hao.wu@rubrik.com>
> ---
> v5:
> - Rename variables according to feedbacks
> - Move timeout min/max to tpm_tis_data
>=20
> v4:
> - Move timeout constants to drivers/char/tpm/tpm_tis_core.h
> - Cleanup unnecessary inline comment
>=20
> v3:
> - removes unnecessary condition check in `wait_for_tpm_stat`
>=20
> v2:
> - follow the existing way to define two timeouts (min and max)
>   for ATMEL chip, thus keep the exact timeout logic for=20
>   non-ATEML chips.
> - limit the timeout increase to only ATMEL TPM 1.2 chips,
>   because it is not an issue for TPM 2.0 chips yet.
>=20
> Test Plan:
> - Run fixed kernel with ATMEL TPM chips and see crash
> has been fixed.
> - Run fixed kernel with non-ATMEL TPM chips, and confirm
> the timeout has not been changed.
>=20
>  drivers/char/tpm/tpm_tis_core.c | 27 +++++++++++++++++++--------
>  drivers/char/tpm/tpm_tis_core.h |  4 ++++
>  include/linux/tpm.h             |  1 +
>  3 files changed, 24 insertions(+), 8 deletions(-)
>=20

I just noticed that these are part of the same email thread from
lore.kernel.org. Please always use separate thread. E.g. I'm not sure if
this would play out well with tooling such as b4 that can pick up patch
sets from lore.


> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_c=
ore.c
> index 55b9d3965ae1..29de383aec5f 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -79,9 +79,10 @@ static int wait_for_tpm_stat(struct tpm_chip *chip, u8=
 mask,
>  			goto again;
>  		}
>  	} else {
> +		struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);

Move this declaration to the beginning of the function.

>  		do {
> -			usleep_range(TPM_TIMEOUT_USECS_MIN,
> -				     TPM_TIMEOUT_USECS_MAX);
> +			usleep_range(priv->timeout_min,
> +				     priv->timeout_max);
>  			status =3D chip->ops->status(chip);
>  			if ((status & mask) =3D=3D mask)
>  				return 0;
> @@ -934,7 +935,23 @@ int tpm_tis_core_init(struct device *dev, struct tpm=
_tis_data *priv, int irq,
>  	chip->timeout_b =3D msecs_to_jiffies(TIS_TIMEOUT_B_MAX);
>  	chip->timeout_c =3D msecs_to_jiffies(TIS_TIMEOUT_C_MAX);
>  	chip->timeout_d =3D msecs_to_jiffies(TIS_TIMEOUT_D_MAX);
> +	priv->timeout_min =3D TPM_TIMEOUT_USECS_MIN;
> +	priv->timeout_max =3D TPM_TIMEOUT_USECS_MAX;
>  	priv->phy_ops =3D phy_ops;
> +
> +	rc =3D tpm_tis_read32(priv, TPM_DID_VID(0), &vendor);
> +	if (rc < 0)
> +		goto out_err;
> +
> +	priv->manufacturer_id =3D vendor;
> +
> +	if (priv->manufacturer_id =3D=3D TPM_VID_ATML &&
> +		!(chip->flags & TPM_CHIP_FLAG_TPM2)) {
> +		/* If TPM chip is 1.2 ATMEL chip, timeout need to be relaxed*/
                                                       =20
A ' ' character missing before the last asterisk.

Also the comment is just in English the same exact thing already
clearly expressed by the if-statement, so it's better that you
just remove the comment altogether.

> +		priv->timeout_min =3D TIS_TIMEOUT_MIN_ATML;
> +		priv->timeout_max =3D TIS_TIMEOUT_MAX_ATML;
> +	}
> +
>  	dev_set_drvdata(&chip->dev, priv);
> =20
>  	if (is_bsw()) {
> @@ -977,12 +994,6 @@ int tpm_tis_core_init(struct device *dev, struct tpm=
_tis_data *priv, int irq,
>  	if (rc)
>  		goto out_err;
> =20
> -	rc =3D tpm_tis_read32(priv, TPM_DID_VID(0), &vendor);
> -	if (rc < 0)
> -		goto out_err;
> -
> -	priv->manufacturer_id =3D vendor;
> -
>  	rc =3D tpm_tis_read8(priv, TPM_RID(0), &rid);
>  	if (rc < 0)
>  		goto out_err;
> diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_c=
ore.h
> index 9b2d32a59f67..c33f27c929f4 100644
> --- a/drivers/char/tpm/tpm_tis_core.h
> +++ b/drivers/char/tpm/tpm_tis_core.h
> @@ -54,6 +54,8 @@ enum tis_defaults {
>  	TIS_MEM_LEN =3D 0x5000,
>  	TIS_SHORT_TIMEOUT =3D 750,	/* ms */
>  	TIS_LONG_TIMEOUT =3D 2000,	/* 2 sec */
> +	TIS_TIMEOUT_MIN_ATML =3D 14700,	/* usecs */
> +	TIS_TIMEOUT_MAX_ATML =3D 15000,	/* usecs */
>  };
> =20
>  /* Some timeout values are needed before it is known whether the chip is
> @@ -97,6 +99,8 @@ struct tpm_tis_data {
>  	wait_queue_head_t read_queue;
>  	const struct tpm_tis_phy_ops *phy_ops;
>  	unsigned short rng_quality;
> +	unsigned int timeout_min; /* usecs */
> +	unsigned int timeout_max; /* usecs */
>  };
> =20
>  struct tpm_tis_phy_ops {
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index aa11fe323c56..12d827734686 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -269,6 +269,7 @@ enum tpm2_cc_attrs {
>  #define TPM_VID_INTEL    0x8086
>  #define TPM_VID_WINBOND  0x1050
>  #define TPM_VID_STM      0x104A
> +#define TPM_VID_ATML     0x1114
> =20
>  enum tpm_chip_flags {
>  	TPM_CHIP_FLAG_TPM2		=3D BIT(1),

Looking good other than a those minor nitpicks. Please send the next as
a separate thread, and *not* as response, so that it can be picked up.

/Jarkko

