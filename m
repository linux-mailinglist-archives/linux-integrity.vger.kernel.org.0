Return-Path: <linux-integrity+bounces-1713-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5172487893A
	for <lists+linux-integrity@lfdr.de>; Mon, 11 Mar 2024 21:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAA911F21C25
	for <lists+linux-integrity@lfdr.de>; Mon, 11 Mar 2024 20:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD1E54BCC;
	Mon, 11 Mar 2024 20:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b0j+tNf+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9717D4206B
	for <linux-integrity@vger.kernel.org>; Mon, 11 Mar 2024 20:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710187495; cv=none; b=PBWXK9Ju61cTGaN9tO6hgmHjQUVIULTJbPN9OKCw/2mcHsH6HidP+wZXGXIx33pXwscc0/DwEpA+ghrP3LLKTg27P0H+o8IjWwtgA6x2WHQConUG1MumSIaGIGTzM+Apst4DRpsahgh3crpr/luW8U+SKrCGxVBH2ZbagQ9W1Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710187495; c=relaxed/simple;
	bh=KKWaV14JmokvyX7vhfLp6W8ziX6b6et1GaSuV806CqE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=fVpTJMOBLszVHtAgcrYtI6qtJgKVqxpGQTGvAgVr2yaYpi4v+bb2n2Hr1Sm8cbbP02AJh3I82n/61Hu1Uu48C6tf1oH2huxDlYcaiqaiwDRVSSrwjcRWWhdEFybUfQN6quutu3KklDF9Xq9NWrmXgTcothkCkKJAf7cpspXMdCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b0j+tNf+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DA8C433F1;
	Mon, 11 Mar 2024 20:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710187495;
	bh=KKWaV14JmokvyX7vhfLp6W8ziX6b6et1GaSuV806CqE=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=b0j+tNf+t3U4B5Q837FR2wvp/7qTEzO0tGIuv42GPghNpIUUQigpHl8YXuP2OnsLi
	 +A/g76bMkadCu8CuBARXRRvzuSWTtdq36SlVuOJUcewpUAdeBBH7i+RaB66y737nFU
	 58IMTcr6Y0LpvUk77wifKYCFhbb65lCyKe8kpQVLKRSxc4PKT8W10wp7Xjhdenp6EM
	 PiDF635Ravdp9RYiDsDRCMw5Lx/es3CnaPAa5sUajt4It4cqh2tAmLhMaGn5IVnnaq
	 /6CLUo4v73C/gKJjMOIgOEzOu2AJCE15nm4oetEohKWg+bFc27Z9iS04z4of44i8sQ
	 GT/qnITsgNcbA==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 Mar 2024 22:04:51 +0200
Message-Id: <CZR6VBRUEPKW.26B7HTOJZ0ANX@kernel.org>
Subject: Re: [PATCH v2] tpm: Fix suspend/shutdown on some boards by
 preserving chip Locality
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Adam Alves" <adamoa@gmail.com>, "Peter Huewe" <peterhuewe@gmx.de>
Cc: "Jason Gunthorpe" <jgg@ziepe.ca>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <CZNS5B6JRFLS.28TOPENHJIKCQ@kernel.org>
 <20240307224957.29432-1-adamoa@gmail.com>
In-Reply-To: <20240307224957.29432-1-adamoa@gmail.com>

On Fri Mar 8, 2024 at 12:49 AM EET, Adam Alves wrote:
> Some buggy firmware might require the TPM device to be in default
> locality (Locality 0) before suspend or shutdown. Failing to do so
> would leave the system in a hanged state before sleep or power off
> (after =E2=80=9Creboot: Power down=E2=80=9D message). Such is the case fo=
r the ASUSTeK
> COMPUTER INC. TUF GAMING B460M-PLUS board, I believe this might be the
> case for several other boards based on some bugs over the internet
> while trying to find out how to fix my specific issue. Most forums
> suggest the user to disable the TPM device on firmware BIOS in order to
> work around this specific issue, which disables several security
> features provided by TPM.

Re-write the paragraph as

  ASUSTeK TUF GAMING B460M-PLUS hangs on power down, after "reboot:
  Power down" message

Please do not add discussion to the commit message it should only
contain symptom and solution and rationale why the patch fixes the
issue.

And please done add any open-ended arguments ("some ..."). We care
only about identified bugs.

The lacking information here is the CPU model (/proc/cpuinfo), on
which kernel version the bug was produced and what kind of TPM the
system has (discrete chip or firmware TPM should be easy to check
from BIOS).

Also, which firmwre version you have and have you tested with the
most up to date firmware (BIOS)?

Before drawing any conclusions we need to know the environment
better.

>
> The root cause might be that after the ACPI command to put the device

What is "the ACPI command"? Refer to concrete items instead of
asking to guess what you is the ACPI command for you.

> chip expecting it to be in Locality 0 as expected by TCG PC Client
> Platform Firmware Profile Version 1.06 Revision 52 (3.1.1 =E2=80=93 Pre-O=
S
> Environment) and then when it fails to do so it simply halts the
> whole system.

We don't speculate about the root cause here, only document it.
Please move this paragraph before diffstat (see below)>

> Enable a user to configure the kernel through
> =E2=80=9Ctpm.locality_on_suspend=3D1=E2=80=9D boot parameter so that the =
locality is set
> before suspend/shutdown in order to diagnose whether or not the board is
> one of the buggy ones that require this workaround. Since this bug is
> related to the board/platform instead of the specific TPM chip, call
> dmi_check_system on the tpm_init function so that this setting is
> automatically enabled for boards specified in code (ASUS TUF GAMING
> B460M-PLUS already included) =E2=80=93 automatic configuration only works=
 in
> case CONFIG_DMI is set though, since dmi_check_system is a non-op when
> CONFIG_DMI is not set.

Please describe what the *kernel command-line" (for clarity
sake) semantically means.

Also please remove anything about diangnosing. We care only
about fixes.

>
> In case =E2=80=9Ctpm.locality_on_suspend=3D0=E2=80=9D (the default) don't=
 change any
> behavior thus preserving current functionality of any other board
> except ASUSTeK COMPUTER INC. TUF GAMING B460M-PLUS and possibly future
> boards as we successfully diagnose other boards with the same issue
> fixed by using =E2=80=9Ctpm.locality_on_suspend=3D1=E2=80=9D.

This neither documents the default value. I'm also lost did setting
this "1" or "0" fix the issue in your case?

So: firmware version and being up-to-date is important and also this
needs to be reproduciable with the mainline Linux tree, not distro
kernel or custom kernel.

>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217890
> Signed-off-by: Adam Alves <adamoa@gmail.com>
> ---

<cover letter>

OK, I'll try to check what is done here but please re-read
"describing your changes" before sending next version:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#desc=
ribe-your-changes

> v1->v2: fix formatting issues and simplified tpm_chip_stop code.
>
>  drivers/char/tpm/tpm-chip.c      | 12 +++++++++++
>  drivers/char/tpm/tpm-interface.c | 37 ++++++++++++++++++++++++++++++++
>  drivers/char/tpm/tpm.h           |  1 +
>  include/linux/tpm.h              |  1 +
>  4 files changed, 51 insertions(+)
>
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 42b1062e33cd..a183e1355289 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -137,6 +137,12 @@ EXPORT_SYMBOL_GPL(tpm_chip_start);
>   */
>  void tpm_chip_stop(struct tpm_chip *chip)
>  {
> +	if (chip->flags & TPM_CHIP_FLAG_PRESERVE_LOCALITY) {

The commit message did not explain what this flag is and what is its
purpose.

Also why you need to populate global flag inside chip, or the value
of it?

Why this is not just:
=09
	if (tpm_locality_on_suspend) {
?


> +		if (chip->locality !=3D 0)
> +			tpm_request_locality(chip);

This will unconditionally skip calling tpm_request_locality() because
Linux only uses locality 0. Not sure what good does this make.

> +		return;
> +	}
> +
>  	tpm_go_idle(chip);
>  	tpm_relinquish_locality(chip);
>  	tpm_clk_disable(chip);
> @@ -291,6 +297,9 @@ int tpm_class_shutdown(struct device *dev)
>  {
>  	struct tpm_chip *chip =3D container_of(dev, struct tpm_chip, dev);
> =20
> +	if (tpm_locality_on_suspend)
> +		chip->flags |=3D TPM_CHIP_FLAG_PRESERVE_LOCALITY;
> +
>  	down_write(&chip->ops_sem);
>  	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
>  		if (!tpm_chip_start(chip)) {
> @@ -668,6 +677,9 @@ EXPORT_SYMBOL_GPL(tpm_chip_register);
>   */
>  void tpm_chip_unregister(struct tpm_chip *chip)
>  {
> +	if (tpm_locality_on_suspend)
> +		chip->flags |=3D TPM_CHIP_FLAG_PRESERVE_LOCALITY;
> +
>  	tpm_del_legacy_sysfs(chip);
>  	if (tpm_is_hwrng_enabled(chip))
>  		hwrng_unregister(&chip->hwrng);
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-inte=
rface.c
> index 66b16d26eecc..7f770ea98402 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -26,6 +26,7 @@
>  #include <linux/suspend.h>
>  #include <linux/freezer.h>
>  #include <linux/tpm_eventlog.h>
> +#include <linux/dmi.h>
> =20
>  #include "tpm.h"
> =20
> @@ -382,6 +383,36 @@ int tpm_auto_startup(struct tpm_chip *chip)
>  	return rc;
>  }
> =20
> +/*
> + * Bug workaround - some boards expect the TPM to be on Locality 0
> + * before suspend/shutdown, halting the system otherwise before
> + * suspend and shutdown. Change suspend behavior for these cases.
> + */
> +bool tpm_locality_on_suspend;
> +module_param_named(locality_on_suspend, tpm_locality_on_suspend, bool, 0=
644);
> +MODULE_PARM_DESC(locality_on_suspend,
> +		 "Put TPM at locality 0 before suspend/shutdown.");
> +
> +static int __init tpm_set_locality_on_suspend(const struct dmi_system_id=
 *system_id)
> +{
> +	pr_info("Board %s: TPM locality preserved before suspend/shutdown.\n",
> +		system_id->ident);

Please remove pr_info(), we do not want to bloat klog.

> +	tpm_locality_on_suspend =3D true;
> +
> +	return 0;
> +}
> +
> +static const struct dmi_system_id tpm_board_quirks[] __initconst =3D {

The commit message did not introduce this. Also should have inline
documentation.

/*
 * What the heck this.
 */

> +	{
> +		.ident =3D "TUF GAMING B460M-PLUS",
> +		.matches =3D {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
> +			DMI_MATCH(DMI_BOARD_NAME, "TUF GAMING B460M-PLUS"),
> +		},
> +		.callback =3D tpm_set_locality_on_suspend,
> +	},
> +};
> +
>  /*
>   * We are about to suspend. Save the TPM state
>   * so that it can be restored.
> @@ -394,6 +425,9 @@ int tpm_pm_suspend(struct device *dev)
>  	if (!chip)
>  		return -ENODEV;
> =20
> +	if (tpm_locality_on_suspend)
> +		chip->flags |=3D TPM_CHIP_FLAG_PRESERVE_LOCALITY;
> +
>  	if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
>  		goto suspended;
> =20
> @@ -431,6 +465,7 @@ int tpm_pm_resume(struct device *dev)
>  	if (chip =3D=3D NULL)
>  		return -ENODEV;
> =20
> +	chip->flags &=3D ~TPM_CHIP_FLAG_PRESERVE_LOCALITY;
>  	chip->flags &=3D ~TPM_CHIP_FLAG_SUSPENDED;
> =20
>  	/*
> @@ -476,6 +511,8 @@ static int __init tpm_init(void)
>  {
>  	int rc;
> =20
> +	dmi_check_system(tpm_board_quirks);
> +
>  	rc =3D class_register(&tpm_class);
>  	if (rc) {
>  		pr_err("couldn't create tpm class\n");
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 61445f1dc46d..f2657b611b81 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -236,6 +236,7 @@ extern dev_t tpm_devt;
>  extern const struct file_operations tpm_fops;
>  extern const struct file_operations tpmrm_fops;
>  extern struct idr dev_nums_idr;
> +extern bool tpm_locality_on_suspend;
> =20
>  ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz);
>  int tpm_get_timeouts(struct tpm_chip *);
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 4ee9d13749ad..1fbb33f386d1 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -284,6 +284,7 @@ enum tpm_chip_flags {
>  	TPM_CHIP_FLAG_FIRMWARE_UPGRADE		=3D BIT(7),
>  	TPM_CHIP_FLAG_SUSPENDED			=3D BIT(8),
>  	TPM_CHIP_FLAG_HWRNG_DISABLED		=3D BIT(9),
> +	TPM_CHIP_FLAG_PRESERVE_LOCALITY		=3D BIT(10),
>  };
> =20
>  #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)


BR, Jarkko

