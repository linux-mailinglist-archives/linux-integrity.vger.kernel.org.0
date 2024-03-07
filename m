Return-Path: <linux-integrity+bounces-1651-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E6E87579A
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Mar 2024 20:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98451B23B5B
	for <lists+linux-integrity@lfdr.de>; Thu,  7 Mar 2024 19:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFC41386C1;
	Thu,  7 Mar 2024 19:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f91E91bQ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D6C137C45
	for <linux-integrity@vger.kernel.org>; Thu,  7 Mar 2024 19:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709841162; cv=none; b=UbRAkdKdelyNbDHXW23i8VQ2UCGoV9mUb1m6Te9ynedea8u6Yi4i/n4J8BgIcC07oK2W3cgOjRJ73yCncFw/Bl34sSk0EYSJ8GUVXu5b6LHALVDshyyfUp3yIjEDi5jRZAvMpea7AfhHTHFTZoxJm683BjPWXVN1pnXgnCJHw0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709841162; c=relaxed/simple;
	bh=p9j4f7lXJjMTDc8l8eBzmBNe7Y0G3gbmonTpOL9sQfQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=GCdAHKjf+kwJF5Ae3VgQ9dDnHZBgqnVEZEp1e7WG/UnYYlBJj6jwg7fKLLN2PawjLPcjcoXytBw4UwrUl7hUm2p9c9y3r1y6e/eff9rUS4E+lybeHjpzXtCmQmYeOOLBzlw7tvv+0SRzBg91ImRIyheg8hwwy/1fnEDXa56JKjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f91E91bQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0453C433C7;
	Thu,  7 Mar 2024 19:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709841161;
	bh=p9j4f7lXJjMTDc8l8eBzmBNe7Y0G3gbmonTpOL9sQfQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=f91E91bQsJtDdrTecxj2boW4Tb4qVdYLPouDr4N5ww5tIZ2FOiO+qkrF8pAIP5GFz
	 BeDWhYqrlQFkDjx3b+tfK8MCJmJ9vgId/EiQuhktoJhvyEyxEX7X8h+B4whbLFzACD
	 I4rERBANOxTU3nTJf8UJgf+qGdVeQEKKaMnoRNRZZgEBpbuyXzl/d9y/vPC+Hx9Qb3
	 V/XHz6zks87dv3D7a+II+SNv4QvurI/WR920GFCpIsLuQK4fqG7pm5g4tU+BOD4dar
	 9fINtfSX4qYHoUe01ARYXesZtB7kEwN5iT5R/8gxqconqs2Uz0MTg954zmw1UEUmuC
	 Qb3X63sG+ga+A==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Mar 2024 21:52:39 +0200
Message-Id: <CZNS3SNVST28.99YVTOEZMSVO@kernel.org>
Cc: "Jason Gunthorpe" <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH] Fix TPM chip hanging system before suspend/shutdown
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Adam Alves" <adamoa@gmail.com>, "Peter Huewe" <peterhuewe@gmx.de>
X-Mailer: aerc 0.17.0
References: <CAHwaaX_6OYVy8o8nUjYhNjAV+j28QGLSHxpWxoMDxiBzT2Z50Q@mail.gmail.com>
In-Reply-To: <CAHwaaX_6OYVy8o8nUjYhNjAV+j28QGLSHxpWxoMDxiBzT2Z50Q@mail.gmail.com>

On Thu Mar 7, 2024 at 1:12 AM EET, Adam Alves wrote:
> Some buggy firmwares might require the TPM device to be in default
> locality (Locality 0) before suspend or shutdown. Failing to do so
> would leave the system in a hanged state before sleep or power off
> (after =E2=80=9Creboot: Power down=E2=80=9D message). Such is the case fo=
r the ASUSTeK
> COMPUTER INC. TUF GAMING B460M-PLUS board, I believe this might be the
> case for several other boards based on the bugs I have found on the
> internet while trying to find out how to fix my specific issue. Most
> forums suggest the user to disable the TPM device on firmware BIOS in
> order to work around this specific issue, which disables several nice
> security features provided by TPM, such as secure boot attestation,
> automatic decryption and hardware random generator.



>
> My PC would hang on almost every shutdown/suspend until I started
> testing this patch and so far in the past week I haven=E2=80=99t experien=
ced
> any problems anymore.
>
> I suspect that the root cause on my specific board is that after the
> ACPI command to put the device to S3 or S5, some firmware
> application/driver will try to use the TPM chip expecting it to be in
> Locality 0 as expected by TCG PC Client Platform Firmware Profile
> Version 1.06 Revision 52 (3.1.1 =E2=80=93 Pre-OS Environment) and then wh=
en it
> fails to do so it simply halts the whole system.
>
> This issue might be related to the following bug:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D217890

You can put Link: <url> for this before signed-off-by's.

>
> Enable a user to configure the kernel
> through =E2=80=9Ctpm.locality_on_suspend=3D1=E2=80=9D boot parameter so t=
hat the locality
> is set before suspend/shutdown in order to diagnose whether or not the
> board is one of the buggy ones that require this workaround. Since this
> bug is related to the board/platform instead of the specific TPM chip,
> call dmi_check_system on the tpm_init function so that this setting is
> automatically enabled for boards specified in code (ASUS TUF GAMING
> B460M-PLUS already included) =E2=80=93 automatic configuration only works=
 in
> case CONFIG_DMI is set though, since dmi_check_system is a non-op when
> CONFIG_DMI is not set.
>
> In case =E2=80=9Ctpm.locality_on_suspend=3D0=E2=80=9D (the default) don't=
 change any
> behavior thus preserving current functionality of any other board
> except ASUSTeK COMPUTER INC. TUF GAMING B460M-PLUS and possibly future
> boards as we successfully diagnose other boards with the same issue
> fixed by using =E2=80=9Ctpm.locality_on_suspend=3D1=E2=80=9D.
>
> Signed-off-by: Adam Alves <adamoa@gmail.com>
>
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 42b1062e33cd..8fdf7a137a94 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -139,6 +139,9 @@ void tpm_chip_stop(struct tpm_chip *chip)
>  {
>   tpm_go_idle(chip);
>   tpm_relinquish_locality(chip);
> + // If locality is to be preserved, we need to make sure it is Locality =
0.
> + if (chip->flags & TPM_CHIP_PRESERVE_LOCALITY)
> + tpm_request_locality(chip);
>   tpm_clk_disable(chip);
>  }
>  EXPORT_SYMBOL_GPL(tpm_chip_stop);
> @@ -291,6 +294,9 @@ int tpm_class_shutdown(struct device *dev)
>  {
>   struct tpm_chip *chip =3D container_of(dev, struct tpm_chip, dev);
>
> + if (tpm_locality_on_suspend)
> + chip->flags |=3D TPM_CHIP_PRESERVE_LOCALITY;
> +
>   down_write(&chip->ops_sem);
>   if (chip->flags & TPM_CHIP_FLAG_TPM2) {
>   if (!tpm_chip_start(chip)) {
> @@ -668,6 +674,9 @@ EXPORT_SYMBOL_GPL(tpm_chip_register);
>   */
>  void tpm_chip_unregister(struct tpm_chip *chip)
>  {
> + if (tpm_locality_on_suspend)
> + chip->flags |=3D TPM_CHIP_PRESERVE_LOCALITY;
> +
>   tpm_del_legacy_sysfs(chip);
>   if (tpm_is_hwrng_enabled(chip))
>   hwrng_unregister(&chip->hwrng);
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-inte=
rface.c
> index 66b16d26eecc..8aeea2dee0a8 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -26,6 +26,7 @@
>  #include <linux/suspend.h>
>  #include <linux/freezer.h>
>  #include <linux/tpm_eventlog.h>
> +#include <linux/dmi.h>
>
>  #include "tpm.h"
>
> @@ -382,6 +383,34 @@ int tpm_auto_startup(struct tpm_chip *chip)
>   return rc;
>  }
>
> +/*
> + * Bug workaround - some boards expect the TPM to be on ready
> + * state before suspend/shutdown, otherwise suspend and shutdown might
> + * hang the system, so we need to adjust suspend code for handling this.
> + */
> +bool tpm_locality_on_suspend;
> +module_param_named(locality_on_suspend, tpm_locality_on_suspend, bool, 0=
644);
> +MODULE_PARM_DESC(locality_on_suspend, "The firmware expects TPM to be
> at locality 0 before suspend/shutdown.");
> +
> +static int __init tpm_set_locality_on_suspend(const struct
> dmi_system_id *system_id)
> +{
> + pr_info("Board %s: TPM locality preserved before
> suspend/shutdown.\n", system_id->ident);
> + tpm_locality_on_suspend =3D true;
> +
> + return 0;
> +}
> +
> +static const struct dmi_system_id tpm_board_quirks[] __initconst =3D {
> + {
> + .ident =3D "TUF GAMING B460M-PLUS",
> + .matches =3D {
> + DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
> + DMI_MATCH(DMI_BOARD_NAME, "TUF GAMING B460M-PLUS"),
> + },
> + .callback =3D tpm_set_locality_on_suspend,
> + },
> +};
> +
>  /*
>   * We are about to suspend. Save the TPM state
>   * so that it can be restored.
> @@ -394,6 +423,9 @@ int tpm_pm_suspend(struct device *dev)
>   if (!chip)
>   return -ENODEV;
>
> + if (tpm_locality_on_suspend)
> + chip->flags |=3D TPM_CHIP_PRESERVE_LOCALITY;
> +
>   if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
>   goto suspended;
>
> @@ -431,7 +463,7 @@ int tpm_pm_resume(struct device *dev)
>   if (chip =3D=3D NULL)
>   return -ENODEV;
>
> - chip->flags &=3D ~TPM_CHIP_FLAG_SUSPENDED;
> + chip->flags &=3D ~(TPM_CHIP_PRESERVE_LOCALITY | TPM_CHIP_FLAG_SUSPENDED=
);
>
>   /*
>   * Guarantee that SUSPENDED is written last, so that hwrng does not
> @@ -476,6 +508,8 @@ static int __init tpm_init(void)
>  {
>   int rc;
>
> + dmi_check_system(tpm_board_quirks);
> +
>   rc =3D class_register(&tpm_class);
>   if (rc) {
>   pr_err("couldn't create tpm class\n");
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 61445f1dc46d..f2657b611b81 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -236,6 +236,7 @@ extern dev_t tpm_devt;
>  extern const struct file_operations tpm_fops;
>  extern const struct file_operations tpmrm_fops;
>  extern struct idr dev_nums_idr;
> +extern bool tpm_locality_on_suspend;
>
>  ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz);
>  int tpm_get_timeouts(struct tpm_chip *);
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 4ee9d13749ad..7717f484ac25 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -284,6 +284,7 @@ enum tpm_chip_flags {
>   TPM_CHIP_FLAG_FIRMWARE_UPGRADE =3D BIT(7),
>   TPM_CHIP_FLAG_SUSPENDED =3D BIT(8),
>   TPM_CHIP_FLAG_HWRNG_DISABLED =3D BIT(9),
> + TPM_CHIP_PRESERVE_LOCALITY =3D BIT(10),
>  };
>
>  #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)

Did you use git format-patch to generate this? It does not look to be in
the mbox format. E.g. diffstat is missing completely.

I neither think that indentation is according to the guidelines at all.

So what you need to do next is to read [1] through and send v2 if with
those learnings [2]. When you use checkpatch.pl, invoke it as:

scripts/checkpatch.pl --strict <patch file>

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html
[2] git format-patch -1 -v2

BR, Jarkko

