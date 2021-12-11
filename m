Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AEE547142D
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Dec 2021 15:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhLKOPR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 11 Dec 2021 09:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhLKOPP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 11 Dec 2021 09:15:15 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3787EC061714;
        Sat, 11 Dec 2021 06:15:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 759BBCE2F2A;
        Sat, 11 Dec 2021 14:15:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C50C004DD;
        Sat, 11 Dec 2021 14:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639232111;
        bh=cFtJhhQVllVhAckh6WxdiuV+kr4GSV+SbR2Zo1NXSuc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hKximJNaZTpDYs4ESphMEpjlvobUvjLkzgjXodysGjwDM6fauy7kNUMqKJlrXa8Tx
         QpMFU1qEBWfhgk2DHonnzcC9jgm+gbclDCVunMZLri+msC7yifLhyua/NjiQqsn1Dk
         MJ6TAY7iBKeiJr6oRkhfXPLotEDwtPXQGkA0R+igzcG1uHKJijwiV8apyWd5gLpCrP
         FQt7E9XmUnZGlWMxc+sxnr2sdzWw/ag7njTU+WoXDN1Gi+UZelu8aRoCWnu2QIX9X8
         ShrTGr+vMKhzExSIf5lRnZV8K95U8oflIQY9U73SWFOHX8Ac0OrLPT00XPH30mRFb+
         9u2CkqLBDmf/A==
Message-ID: <5e5cbdd7db3d8f469f94607b823b8fd46e014051.camel@kernel.org>
Subject: Re: [PATCH v7] tpm: Add Upgrade/Reduced mode support for TPM2
 modules
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Axel Jonsson <axel.jonsson@axis.com>
Cc:     sergio.ruiz@axis.com, borysmn@axis.com, jgg@ziepe.ca,
        kernel@axis.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        Axel Jonsson <axelj@axis.com>
Date:   Sat, 11 Dec 2021 16:15:07 +0200
In-Reply-To: <20211208095307.9558-1-axel.jonsson@axis.com>
References: <59f8d5a835ff0f02c9efe0ecff0abbe1b4f08111.camel@kernel.org>
         <20211208095307.9558-1-axel.jonsson@axis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.42.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2021-12-08 at 10:53 +0100, Axel Jonsson wrote:
> From: Axel Jonsson <axelj@axis.com>
>=20
> If something went wrong during the TPM firmware upgrade, like power
> failure or the firmware image file get corrupted, the TPM might end
> up in Upgrade or Failure mode upon the next start. The state is
> persistent between the TPM power cycle/restart.
>=20
> According to TPM specification:
>  * If the TPM is in Upgrade mode, it will answer with TPM2_RC_UPGRADE
>    to all commands except TPM2_FieldUpgradeData(). It may also accept
>    other commands if it is able to complete them using the previously
>    installed firmware.
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
>=20
> The TPM_CHIP_FLAG_FIRMWARE_UPGRADE_MODE flag is used later during driver
> initialization/deinitialization to disable functionality which makes no
> sense or will fail in the current TPM state. Following functionality is
> affected:
>  * Do not register TPM as a hwrng
>  * Do not register sysfs entries which provide information impossible to
>    obtain in limited mode
>  * Do not register resource managed character device
>=20
> Signed-off-by: Axel Jonsson <axelj@axis.com>
> ---
>=20
> Notes:
>     Notes:
>         v2:
>          * Commit message updated.
>    =20
>         v3:
>          * Commit message reworked.
>    =20
>         v4:
>          * Description of how tpm2_auto_startup() detects the mode added =
to
>            commit message.
>    =20
>         v5:
>          * Introduce global flag: TPM_CHIP_FLAG_LIMITED_MODE.
>          * Add checks for the flag in places that will not work properly =
when TPM
>            functionality is limited.
>          * Avoid registering sysfs and character device entries that have=
 no useful
>            function in limited mode.
>          * Do not register TPM as a hwrng.
>          * Do not try to obtain any crypto-related properties from TPM as=
 it will fail
>            in limited mode.
>    =20
>         v6:
>          * Rename the TPM_CHIP_FLAG_LIMITED_MODE to TPM_CHIP_FLAG_FIRMWAR=
E_UPGRADE_MODE
>            to reduce confusion. Update info messages.
>    =20
>         v7:
>          * Clarified in commit message which command can be run in firmwa=
re upgrade
>          mode
>          * Corrected info and style in commit message
>          * Renamed TPM_CHIP_FLAG_FIRMWARE_UPGRADE_MODE to TPM_CHIP_FLAG_F=
IRMWARE_MODE
>          * Replaced TPM_CHIP_FLAG_FIRMWARE_MODE flag check with function =
from
>          include/linux/tpm.h
>=20
>  drivers/char/tpm/tpm-chip.c  | 23 ++++++++++++++++-------
>  drivers/char/tpm/tpm-sysfs.c |  3 +++
>  drivers/char/tpm/tpm2-cmd.c  |  6 +++++-
>  include/linux/tpm.h          | 10 ++++++++++
>  4 files changed, 34 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index ddaeceb7e109..285d054d187b 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -444,7 +444,8 @@ static int tpm_add_char_device(struct tpm_chip *chip)
>  		return rc;
>  	}
> =20
> -	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> +	if (chip->flags & TPM_CHIP_FLAG_TPM2 &&
> +	    !tpm_is_firmware_upgrade(chip)) {

This can be in a single line (less than 100 characters)?

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
> +	    tpm_is_firmware_upgrade(chip))
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
> +		tpm_is_firmware_upgrade(chip))
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
> +	    tpm_is_firmware_upgrade(chip))

This can be in a single line (less than 100 characters)?

>  		return 0;
> =20
>  	snprintf(chip->hwrng_name, sizeof(chip->hwrng_name),
> @@ -550,6 +554,9 @@ static int tpm_get_pcr_allocation(struct tpm_chip *ch=
ip)
>  {
>  	int rc;
> =20
> +	if (tpm_is_firmware_upgrade(chip))
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
> +	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !tpm_is_firmware_upgrade(chip))
>  		hwrng_unregister(&chip->hwrng);
>  out_ppi:
>  	tpm_bios_log_teardown(chip);
> @@ -637,10 +644,12 @@ EXPORT_SYMBOL_GPL(tpm_chip_register);
>  void tpm_chip_unregister(struct tpm_chip *chip)
>  {
>  	tpm_del_legacy_sysfs(chip);
> -	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM))
> +	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) &&
> +	    !tpm_is_firmware_upgrade(chip))

Ditto.

>  		hwrng_unregister(&chip->hwrng);
>  	tpm_bios_log_teardown(chip);
> -	if (chip->flags & TPM_CHIP_FLAG_TPM2)
> +	if (chip->flags & TPM_CHIP_FLAG_TPM2 &&
> +	    !tpm_is_firmware_upgrade(chip))

Ditto.

>  		cdev_device_del(&chip->cdevs, &chip->devs);
>  	tpm_del_char_device(chip);
>  }
> diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
> index 63f03cfb8e6a..54c71473aa29 100644
> --- a/drivers/char/tpm/tpm-sysfs.c
> +++ b/drivers/char/tpm/tpm-sysfs.c
> @@ -480,6 +480,9 @@ void tpm_sysfs_add_device(struct tpm_chip *chip)
> =20
>  	WARN_ON(chip->groups_cnt !=3D 0);
> =20
> +	if (tpm_is_firmware_upgrade(chip))
> +		return;
> +
>  	if (chip->flags & TPM_CHIP_FLAG_TPM2)
>  		chip->groups[chip->groups_cnt++] =3D &tpm2_dev_group;
>  	else
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index a25815a6f625..24928b0160f1 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -743,8 +743,12 @@ int tpm2_auto_startup(struct tpm_chip *chip)
>  	}
> =20
>  	rc =3D tpm2_get_cc_attrs_tbl(chip);
> -

Please, do not remove this empty line.

>  out:
> +	if (rc =3D=3D TPM2_RC_UPGRADE) {
> +		dev_info(&chip->dev, "TPM in field upgrade mode, requires firmware upg=
rade\n");
> +		chip->flags |=3D TPM_CHIP_FLAG_FIRMWARE_MODE;
> +		rc =3D 0;
> +	}

Empty line here.

>  	if (rc > 0)
>  		rc =3D -ENODEV;
>  	return rc;
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 12d827734686..d38efdae382c 100644
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
> @@ -278,6 +279,7 @@ enum tpm_chip_flags {
>  	TPM_CHIP_FLAG_HAVE_TIMEOUTS	=3D BIT(4),
>  	TPM_CHIP_FLAG_ALWAYS_POWERED	=3D BIT(5),
>  	TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED	=3D BIT(6),
> +	TPM_CHIP_FLAG_FIRMWARE_MODE	=3D BIT(7),
>  };
> =20
>  #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
> @@ -399,6 +401,14 @@ static inline void tpm_buf_append_u32(struct tpm_buf=
 *buf, const u32 value)
>  	tpm_buf_append(buf, (u8 *) &value2, 4);
>  }
> =20
> +/*
> + * Check if TPM device is in the firmware upgrade mode.
> + */
> +static inline bool tpm_is_firmware_upgrade(struct tpm_chip *chip)
> +{
> +	return chip->flags & TPM_CHIP_FLAG_FIRMWARE_MODE;
> +}

For consistency sake, rename the flag as TPM_CHIP_FLAG_FIRMWARE_UPGRADE.

> +
>  static inline u32 tpm2_rc_value(u32 rc)
>  {
>  	return (rc & BIT(7)) ? rc & 0xff : rc;

/Jarkko
