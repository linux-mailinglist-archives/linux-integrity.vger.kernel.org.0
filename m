Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC9C41DF03
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Sep 2021 18:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350515AbhI3QaU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Sep 2021 12:30:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350390AbhI3QaU (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Sep 2021 12:30:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E4DB66159A;
        Thu, 30 Sep 2021 16:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633019317;
        bh=GsPuRtDmau2gBK+Yxq3knQIFFBp1KNJZEoqF0iRgqd4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=QYZSWzbzyAYzsjYeCOGHpmAyF2fwOfgYlQDW6/YFnl1drdNeIS9tSmXoCmlHzNBO2
         Hcu0Uohu4gPddeW3GQT/tfxrjt8E+WI55m7Oipp9z+gJgBeWDpf+bUPszpcgmBIEga
         OhovUR9waTa5umrMw+1z493js6PQe1sbvLKE6NBguwo16wA0Do1uaG6knhg+taLoqQ
         44kznIFueU1s6kvCoIQcimcDNDKjQK8wIwSUcgpoHHt1PrlP2rwWrJKXNnTiT9MV1i
         OQPmcdyizVYY4TveCBPkVFpwU7iTJYMQiwIaXHkzDtF3+IgaviZRiugEODFSp7mkxk
         w32uOys6qW2NQ==
Message-ID: <59f8d5a835ff0f02c9efe0ecff0abbe1b4f08111.camel@kernel.org>
Subject: Re: [PATCH v6] tpm: Add Upgrade/Reduced mode support for TPM2
 modules
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Borys Movchan <borysmn@axis.com>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     kernel@axis.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 30 Sep 2021 19:28:34 +0300
In-Reply-To: <20210930160241.9691-1-borysmn@axis.com>
References: <20210930160241.9691-1-borysmn@axis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-09-30 at 18:02 +0200, Borys Movchan wrote:
> If something went wrong during the TPM firmware upgrade, like power
> failure or the firmware image file get corrupted, the TPM might end
> up in Upgrade or Failure mode upon the next start. The state is
> persistent between the TPM power cycle/restart.
>=20
> According to TPM specification:
>  * If the TPM is in Upgrade mode, it will answer with TPM2_RC_UPGRADE
>    to all commands except Field Upgrade related ones.

How many such command are there and what they are? This patch is missing
the part that filters in only these commands.

>  * If the TPM is in Failure mode, it will allow performing TPM
>    initialization but will not provide any crypto operations.
>    Will happily respond to Field Upgrade calls.
>=20
> Change the behavior of the tpm2_auto_startup(), so it detects the active
> running mode of the TPM by adding the following checks.  If
> tpm2_do_selftest() call returns TPM2_RC_UPGRADE, the TPM is in Upgrade
> mode.
> If the TPM is in Failure mode, it will successfully respond to both
> tpm2_do_selftest() and tpm2_startup() calls. Although, will fail to
> answer to tpm2_get_cc_attrs_tbl(). Use this fact to conclude that TPM is
> in Failure mode.
>=20
> If detected that the TPM is in the Upgrade or Failure mode, the function
> sets TPM_CHIP_FLAG_FIRMWARE_UPGRADE_MODE flag.

I think we should shorten this to TPM_CHIP_FLAG_FIRMWARE_MODE. It's clear
enough and just easier for eyes, really.

> The limited mode flag is used later during driver

You probably have forgot to update commit message over here? Please try to
align it with the code changes.

> initialization/deinitialization to disable functionality which makes no
> sense or will fail in the current TPM state. Following functionality is
> affected:
>  * do not register TPM as a hwrng

Nit: "do" -> "Do"

>  * do not register sysfs entries which provide information impossible to
>    obtain in limited mode
>  * do not register resource managed character device

Ditto.

>=20
> Signed-off-by: Borys Movchan <borysmn@axis.com>
> ---
>=20
> Notes:
>     v2:
>      * Commit message updated.
>    =20
>     v3:
>      * Commit message reworked.
>    =20
>     v4:
>      * Description of how tpm2_auto_startup() detects the mode added to
>        commit message.
>    =20
>     v5:
>      * Introduce global flag: TPM_CHIP_FLAG_LIMITED_MODE.
>      * Add checks for the flag in places that will not work properly when=
 TPM
>        functionality is limited.
>      * Avoid registering sysfs and character device entries that have no =
useful
>        function in limited mode.
>      * Do not register TPM as a hwrng.
>      * Do not try to obtain any crypto-related properties from TPM as it =
will fail
>        in limited mode.
>    =20
>     v6:
>      * Rename the TPM_CHIP_FLAG_LIMITED_MODE to TPM_CHIP_FLAG_FIRMWARE_UP=
GRADE_MODE
>        to reduce confusion. Update info messages.
>=20
>  drivers/char/tpm/tpm-chip.c  | 23 ++++++++++++++++-------
>  drivers/char/tpm/tpm-sysfs.c |  3 +++
>  drivers/char/tpm/tpm2-cmd.c  | 14 +++++++++++++-
>  include/linux/tpm.h          |  2 ++
>  4 files changed, 34 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index ddaeceb7e109..3378bfe06006 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -444,7 +444,8 @@ static int tpm_add_char_device(struct tpm_chip *chip)
>  		return rc;
>  	}
> =20
> -	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> +	if (chip->flags & TPM_CHIP_FLAG_TPM2 &&
> +	    !(chip->flags & TPM_CHIP_FLAG_FIRMWARE_UPGRADE_MODE)) {

Please do this instead in tpm.h, give that the check is everywhere:

/*
 * Check if TPM device is in the firmware upgrade mode.
 */
static inline bool tpm_is_firmware_upgrade(void)
{
	return chip->flags & TPM_CHIP_FLAG_FIRMWARE_UPGRADE_MODE;
}


Makes the code less stressing to read (and find the decision points
later on with tools).

>  		rc =3D cdev_device_add(&chip->cdevs, &chip->devs);
>  		if (rc) {
>  			dev_err(&chip->devs,
> @@ -488,7 +489,8 @@ static void tpm_del_legacy_sysfs(struct tpm_chip *chi=
p)
>  {
>  	struct attribute **i;
> =20
> -	if (chip->flags & (TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_VIRTUAL))
> +	if (chip->flags & (TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_VIRTUAL) ||
> +	    chip->flags & TPM_CHIP_FLAG_FIRMWARE_UPGRADE_MODE)
>  		return;
> =20
>  	sysfs_remove_link(&chip->dev.parent->kobj, "ppi");
> @@ -506,7 +508,8 @@ static int tpm_add_legacy_sysfs(struct tpm_chip *chip=
)
>  	struct attribute **i;
>  	int rc;
> =20
> -	if (chip->flags & (TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_VIRTUAL))
> +	if (chip->flags & (TPM_CHIP_FLAG_TPM2 | TPM_CHIP_FLAG_VIRTUAL) ||
> +		chip->flags & TPM_CHIP_FLAG_FIRMWARE_UPGRADE_MODE)
>  		return 0;
> =20
>  	rc =3D compat_only_sysfs_link_entry_to_kobj(
> @@ -536,7 +539,8 @@ static int tpm_hwrng_read(struct hwrng *rng, void *da=
ta, size_t max, bool wait)
> =20
>  static int tpm_add_hwrng(struct tpm_chip *chip)
>  {
> -	if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM))
> +	if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM) ||
> +	    chip->flags & TPM_CHIP_FLAG_FIRMWARE_UPGRADE_MODE)
>  		return 0;
> =20
>  	snprintf(chip->hwrng_name, sizeof(chip->hwrng_name),
> @@ -550,6 +554,9 @@ static int tpm_get_pcr_allocation(struct tpm_chip *ch=
ip)
>  {
>  	int rc;
> =20
> +	if (chip->flags & TPM_CHIP_FLAG_FIRMWARE_UPGRADE_MODE)
> +		return 0;
> +
>  	rc =3D (chip->flags & TPM_CHIP_FLAG_TPM2) ?
>  	     tpm2_get_pcr_allocation(chip) :
>  	     tpm1_get_pcr_allocation(chip);
> @@ -612,7 +619,7 @@ int tpm_chip_register(struct tpm_chip *chip)
>  	return 0;
> =20
>  out_hwrng:
> -	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM))
> +	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !(chip->flags & TPM_CHIP_FLAG_F=
IRMWARE_UPGRADE_MODE))
>  		hwrng_unregister(&chip->hwrng);
>  out_ppi:
>  	tpm_bios_log_teardown(chip);
> @@ -637,10 +644,12 @@ EXPORT_SYMBOL_GPL(tpm_chip_register);
>  void tpm_chip_unregister(struct tpm_chip *chip)
>  {
>  	tpm_del_legacy_sysfs(chip);
> -	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM))
> +	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) &&
> +	    !(chip->flags & TPM_CHIP_FLAG_FIRMWARE_UPGRADE_MODE))
>  		hwrng_unregister(&chip->hwrng);
>  	tpm_bios_log_teardown(chip);
> -	if (chip->flags & TPM_CHIP_FLAG_TPM2)
> +	if (chip->flags & TPM_CHIP_FLAG_TPM2 &&
> +	    !(chip->flags & TPM_CHIP_FLAG_FIRMWARE_UPGRADE_MODE))
>  		cdev_device_del(&chip->cdevs, &chip->devs);
>  	tpm_del_char_device(chip);
>  }
> diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
> index 63f03cfb8e6a..2842f3c667a5 100644
> --- a/drivers/char/tpm/tpm-sysfs.c
> +++ b/drivers/char/tpm/tpm-sysfs.c
> @@ -480,6 +480,9 @@ void tpm_sysfs_add_device(struct tpm_chip *chip)
> =20
>  	WARN_ON(chip->groups_cnt !=3D 0);
> =20
> +	if (chip->flags & TPM_CHIP_FLAG_FIRMWARE_UPGRADE_MODE)
> +		return;
> +
>  	if (chip->flags & TPM_CHIP_FLAG_TPM2)
>  		chip->groups[chip->groups_cnt++] =3D &tpm2_dev_group;
>  	else
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index a25815a6f625..76245c861e59 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -729,7 +729,12 @@ int tpm2_auto_startup(struct tpm_chip *chip)
>  		goto out;
> =20
>  	rc =3D tpm2_do_selftest(chip);
> -	if (rc && rc !=3D TPM2_RC_INITIALIZE)
> +	if (rc =3D=3D TPM2_RC_UPGRADE) {
> +		dev_info(&chip->dev, "TPM requires firmware upgrade\n");
> +		chip->flags |=3D TPM_CHIP_FLAG_FIRMWARE_UPGRADE_MODE;
> +		rc =3D 0;
> +		goto out;
> +	} else if (rc && rc !=3D TPM2_RC_INITIALIZE)
>  		goto out;
> =20
>  	if (rc =3D=3D TPM2_RC_INITIALIZE) {
> @@ -743,6 +748,13 @@ int tpm2_auto_startup(struct tpm_chip *chip)
>  	}
> =20
>  	rc =3D tpm2_get_cc_attrs_tbl(chip);
> +	if (rc) {
> +		dev_info(&chip->dev,
> +			 "TPM requires firmware recovery/upgrade\n");

Why these two dev_info() messages differ?

You should put a single info message that is unconditionally printed
when in FW upgrade mode, and not sprikle bloat to fallback paths.

> +		chip->flags |=3D TPM_CHIP_FLAG_FIRMWARE_UPGRADE_MODE;
> +		rc =3D 0;
> +		goto out;
> +	}
> =20
>  out:
>  	if (rc > 0)
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index aa11fe323c56..498f487d786f 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -207,6 +207,7 @@ enum tpm2_return_codes {
>  	TPM2_RC_INITIALIZE	=3D 0x0100, /* RC_VER1 */
>  	TPM2_RC_FAILURE		=3D 0x0101,
>  	TPM2_RC_DISABLED	=3D 0x0120,
> +	TPM2_RC_UPGRADE		=3D 0x012D,
>  	TPM2_RC_COMMAND_CODE    =3D 0x0143,
>  	TPM2_RC_TESTING		=3D 0x090A, /* RC_WARN */
>  	TPM2_RC_REFERENCE_H0	=3D 0x0910,
> @@ -277,6 +278,7 @@ enum tpm_chip_flags {
>  	TPM_CHIP_FLAG_HAVE_TIMEOUTS	=3D BIT(4),
>  	TPM_CHIP_FLAG_ALWAYS_POWERED	=3D BIT(5),
>  	TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED	=3D BIT(6),
> +	TPM_CHIP_FLAG_FIRMWARE_UPGRADE_MODE	=3D BIT(7),
>  };
> =20
>  #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)

/Jarkko

