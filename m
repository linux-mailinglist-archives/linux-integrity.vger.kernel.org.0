Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FB876D04A
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Aug 2023 16:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbjHBOkU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Aug 2023 10:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbjHBOkT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Aug 2023 10:40:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9AB171D;
        Wed,  2 Aug 2023 07:40:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB83861986;
        Wed,  2 Aug 2023 14:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22FB5C433CC;
        Wed,  2 Aug 2023 14:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690987217;
        bh=yQnY7M2tsie0wzAsVaSawoQ7xoXBVMwyAnQlqMdIfpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZllmHFMipCdD8DRi+BvJYbMwDl/UUqLPiwPCDd9uoyXwJuyWW8rmG1xgYKDczi1ZS
         GBeD5X7CRGg64+h5Nb944hQ/9CMvMCM4IU9dl4oB0vhr5sj0Co0S3kWcJrhj9rYsQr
         8lOhQV7vjnhc/H7JpVNGxKySNfdW4b2RuMDJXyXEPXYS5hViW0xAO0kA7VhHREg7/F
         Yc+hN/BEdkcMYOaelRMUKPnL7oX9LtOVVAjTDcdZhW/wNGb6YXJvYLgKjPmewrt1LN
         zbBIjGW+geTCWJvn2xqEaiocIs6pp9iQQmvlS8AXc0r8NIdRTBX8i34VwLLCy8RYDD
         vybouEuScte6g==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 02 Aug 2023 17:40:12 +0300
Message-Id: <CUI4XTD01LLZ.CO9FQHV0O37X@suppilovahvero>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Mario Limonciello" <mario.limonciello@amd.com>,
        <peterhuewe@gmx.de>
Cc:     <jgg@ziepe.ca>, <linux@dominikbrodowski.net>, <Jason@zx2c4.com>,
        <linux-integrity@vger.kernel.org>, <daniil.stas@posteo.net>,
        <bitlord0xff@gmail.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2] tpm: Disable RNG for all AMD fTPMs
X-Mailer: aerc 0.14.0
References: <20230802122533.19508-1-mario.limonciello@amd.com>
In-Reply-To: <20230802122533.19508-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed Aug 2, 2023 at 3:25 PM EEST, Mario Limonciello wrote:
> The TPM RNG functionality is not necessary for entropy when the CPU
> already supports the RDRAND instruction. The TPM RNG functionality
> was previously disabled on a subset of AMD fTPM series, but reports
> continue to show problems on some systems causing stutter root caused
> to TPM RNG functionality.
>
> Expand disabling TPM RNG use for all AMD fTPMs whether they have versions
> that claim to have fixed or not. To accomplish this, move the detection
> into part of the TPM CRB registration and add a flag indicating that
> the TPM should opt-out of registration to hwrng.
>
> Cc: stable@vger.kernel.org # 6.1.y+
> Fixes: b006c439d58d ("hwrng: core - start hwrng kthread also for untruste=
d sources")
> Fixes: f1324bbc4011 ("tpm: disable hwrng for fTPM on some AMD designs")
> Reported-by: daniil.stas@posteo.net
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217719
> Reported-by: bitlord0xff@gmail.com
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217212
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>  * switch from callback to everything in tpm_crb
>  * switch to open coded flags check instead of new inline
> ---
>  drivers/char/tpm/tpm-chip.c | 68 ++-----------------------------------
>  drivers/char/tpm/tpm_crb.c  | 30 ++++++++++++++++
>  include/linux/tpm.h         |  1 +
>  3 files changed, 33 insertions(+), 66 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index cf5499e51999b..e904aae9771be 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -510,70 +510,6 @@ static int tpm_add_legacy_sysfs(struct tpm_chip *chi=
p)
>  	return 0;
>  }
> =20
> -/*
> - * Some AMD fTPM versions may cause stutter
> - * https://www.amd.com/en/support/kb/faq/pa-410
> - *
> - * Fixes are available in two series of fTPM firmware:
> - * 6.x.y.z series: 6.0.18.6 +
> - * 3.x.y.z series: 3.57.y.5 +
> - */
> -#ifdef CONFIG_X86
> -static bool tpm_amd_is_rng_defective(struct tpm_chip *chip)
> -{
> -	u32 val1, val2;
> -	u64 version;
> -	int ret;
> -
> -	if (!(chip->flags & TPM_CHIP_FLAG_TPM2))
> -		return false;
> -
> -	ret =3D tpm_request_locality(chip);
> -	if (ret)
> -		return false;
> -
> -	ret =3D tpm2_get_tpm_pt(chip, TPM2_PT_MANUFACTURER, &val1, NULL);
> -	if (ret)
> -		goto release;
> -	if (val1 !=3D 0x414D4400U /* AMD */) {
> -		ret =3D -ENODEV;
> -		goto release;
> -	}
> -	ret =3D tpm2_get_tpm_pt(chip, TPM2_PT_FIRMWARE_VERSION_1, &val1, NULL);
> -	if (ret)
> -		goto release;
> -	ret =3D tpm2_get_tpm_pt(chip, TPM2_PT_FIRMWARE_VERSION_2, &val2, NULL);
> -
> -release:
> -	tpm_relinquish_locality(chip);
> -
> -	if (ret)
> -		return false;
> -
> -	version =3D ((u64)val1 << 32) | val2;
> -	if ((version >> 48) =3D=3D 6) {
> -		if (version >=3D 0x0006000000180006ULL)
> -			return false;
> -	} else if ((version >> 48) =3D=3D 3) {
> -		if (version >=3D 0x0003005700000005ULL)
> -			return false;
> -	} else {
> -		return false;
> -	}
> -
> -	dev_warn(&chip->dev,
> -		 "AMD fTPM version 0x%llx causes system stutter; hwrng disabled\n",
> -		 version);
> -
> -	return true;
> -}
> -#else
> -static inline bool tpm_amd_is_rng_defective(struct tpm_chip *chip)
> -{
> -	return false;
> -}
> -#endif /* CONFIG_X86 */
> -
>  static int tpm_hwrng_read(struct hwrng *rng, void *data, size_t max, boo=
l wait)
>  {
>  	struct tpm_chip *chip =3D container_of(rng, struct tpm_chip, hwrng);
> @@ -588,7 +524,7 @@ static int tpm_hwrng_read(struct hwrng *rng, void *da=
ta, size_t max, bool wait)
>  static int tpm_add_hwrng(struct tpm_chip *chip)
>  {
>  	if (!IS_ENABLED(CONFIG_HW_RANDOM_TPM) || tpm_is_firmware_upgrade(chip) =
||
> -	    tpm_amd_is_rng_defective(chip))
> +	    chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED)
>  		return 0;
> =20
>  	snprintf(chip->hwrng_name, sizeof(chip->hwrng_name),
> @@ -719,7 +655,7 @@ void tpm_chip_unregister(struct tpm_chip *chip)
>  {
>  	tpm_del_legacy_sysfs(chip);
>  	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM) && !tpm_is_firmware_upgrade(chip) =
&&
> -	    !tpm_amd_is_rng_defective(chip))
> +	    !(chip->flags & TPM_CHIP_FLAG_HWRNG_DISABLED))
>  		hwrng_unregister(&chip->hwrng);
>  	tpm_bios_log_teardown(chip);
>  	if (chip->flags & TPM_CHIP_FLAG_TPM2 && !tpm_is_firmware_upgrade(chip))
> diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
> index 1a5d09b185134..9eb1a18590123 100644
> --- a/drivers/char/tpm/tpm_crb.c
> +++ b/drivers/char/tpm/tpm_crb.c
> @@ -463,6 +463,28 @@ static bool crb_req_canceled(struct tpm_chip *chip, =
u8 status)
>  	return (cancel & CRB_CANCEL_INVOKE) =3D=3D CRB_CANCEL_INVOKE;
>  }
> =20
> +static int crb_check_flags(struct tpm_chip *chip)
> +{
> +	u32 val;
> +	int ret;
> +
> +	ret =3D crb_request_locality(chip, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D tpm2_get_tpm_pt(chip, TPM2_PT_MANUFACTURER, &val, NULL);
> +	if (ret)
> +		goto release;
> +
> +	if (val =3D=3D 0x414D4400U /* AMD */)
> +		chip->flags |=3D TPM_CHIP_FLAG_HWRNG_DISABLED;
> +
> +release:
> +	crb_relinquish_locality(chip, 0);
> +
> +	return ret;
> +}
> +
>  static const struct tpm_class_ops tpm_crb =3D {
>  	.flags =3D TPM_OPS_AUTO_STARTUP,
>  	.status =3D crb_status,
> @@ -800,6 +822,14 @@ static int crb_acpi_add(struct acpi_device *device)
>  	chip->acpi_dev_handle =3D device->handle;
>  	chip->flags =3D TPM_CHIP_FLAG_TPM2;
> =20
> +	rc =3D tpm_chip_bootstrap(chip);
> +	if (rc)
> +		goto out;
> +
> +	rc =3D crb_check_flags(chip);
> +	if (rc)
> +		goto out;
> +
>  	rc =3D tpm_chip_register(chip);
> =20
>  out:
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 6a1e8f1572551..4ee9d13749adc 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -283,6 +283,7 @@ enum tpm_chip_flags {
>  	TPM_CHIP_FLAG_FIRMWARE_POWER_MANAGED	=3D BIT(6),
>  	TPM_CHIP_FLAG_FIRMWARE_UPGRADE		=3D BIT(7),
>  	TPM_CHIP_FLAG_SUSPENDED			=3D BIT(8),
> +	TPM_CHIP_FLAG_HWRNG_DISABLED		=3D BIT(9),
>  };
> =20
>  #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
> --=20
> 2.34.1

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Thank you, great work.

I pushed the patch to my next branch:

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/log/=
?h=3Dnext

I'll hold on for tested-by's from AMD users, and send a pull
request tomorrow afternoon (GMT+3).

BR, Jarkko
