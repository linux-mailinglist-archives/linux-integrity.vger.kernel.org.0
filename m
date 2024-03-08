Return-Path: <linux-integrity+bounces-1672-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 030708760FE
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Mar 2024 10:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C47284477
	for <lists+linux-integrity@lfdr.de>; Fri,  8 Mar 2024 09:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE2E53391;
	Fri,  8 Mar 2024 09:34:26 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95D252F89
	for <linux-integrity@vger.kernel.org>; Fri,  8 Mar 2024 09:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709890466; cv=none; b=pflYsvG0hNgbt9MEX0XLX5Z1nyhYRbXoXx+D4m+UEVwlbogQimMIRCBDbXQHzgFvN3dpFzgfSS/tnc2pOQa+R+XWUhTH4CkDVzbMnZ1+du1ZwAjRjn8UQGBBBJ4n6mp5w7H9oWABVAdlF8n6QNP9P5ZKukpSz7Cbt/4jTV7YWqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709890466; c=relaxed/simple;
	bh=clOovKNwBnI/k6gTU45si/rIBxcMlsAY1KzWhLsgeB4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ibyy0/ix3ntLoT78IS5Uc9xu4YIoJC509taEv1WnUk5i+2jNTIDbrMEo0y8Vxa4utz+1hAV6vh84b0+MNnPMCtYbiK+tvacweR4wcIaJ+BNLu06AQ9w3hFV+fZcmaAED1VObWQMdEm+8GqmpBMx02ATcg6/BhRTsDFBK8i/LQlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af28c.dynamic.kabel-deutschland.de [95.90.242.140])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9AAE261E5FE04;
	Fri,  8 Mar 2024 10:33:59 +0100 (CET)
Message-ID: <61067410-5cbe-4b28-a31c-f994933f310d@molgen.mpg.de>
Date: Fri, 8 Mar 2024 10:33:58 +0100
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tpm: Fix suspend/shutdown on some boards by preserving
 chip Locality
Content-Language: en-US
To: Adam Alves <adamoa@gmail.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
References: <CZNS5B6JRFLS.28TOPENHJIKCQ@kernel.org>
 <20240307224957.29432-1-adamoa@gmail.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240307224957.29432-1-adamoa@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Adam,


Thank you very much for analyzing the problem and finding a fix. I have 
some small nits and questions. The current state is alright. Should you 
send another version, that you could address the nits.


Am 07.03.24 um 23:49 schrieb Adam Alves:
> Some buggy firmware might require the TPM device to be in default
> locality (Locality 0) before suspend or shutdown. Failing to do so
> would leave the system in a hanged state before sleep or power off
> (after “reboot: Power down” message).

Out of curiosity, would reboot work?

> Such is the case for the ASUSTeK COMPUTER INC. TUF GAMING B460M-PLUS
> board, I believe this might be the case for several other boards
> based on some bugs over the internet while trying to find out how to
> fix my specific issue. Most forums suggest the user to disable the
> TPM device on firmware BIOS in order to work around this specific
> issue, which disables several security features provided by TPM. >
> The root cause might be that after the ACPI command to put the device
> to S3 or S5, some firmware application/driver will try to use the TPM
> chip expecting it to be in Locality 0 as expected by TCG PC Client
> Platform Firmware Profile Version 1.06 Revision 52 (3.1.1 – Pre-OS
> Environment) and then when it fails to do so it simply halts the
> whole system.
> 
> Enable a user to configure the kernel through
> “tpm.locality_on_suspend=1” boot parameter so that the locality is set

I’d use `` from Markdown.

> before suspend/shutdown in order to diagnose whether or not the board is
> one of the buggy ones that require this workaround. Since this bug is
> related to the board/platform instead of the specific TPM chip, call
> dmi_check_system on the tpm_init function so that this setting is
> automatically enabled for boards specified in code (ASUS TUF GAMING
> B460M-PLUS already included) – automatic configuration only works in
> case CONFIG_DMI is set though, since dmi_check_system is a non-op when
> CONFIG_DMI is not set.

Could you please document the TPM for completeness?

> In case “tpm.locality_on_suspend=0” (the default) don't change any
> behavior thus preserving current functionality of any other board
> except ASUSTeK COMPUTER INC. TUF GAMING B460M-PLUS and possibly future
> boards as we successfully diagnose other boards with the same issue
> fixed by using “tpm.locality_on_suspend=1”.

Is the exception useful, if a user explicitly requests to disable the 
behavior? I was thinking for a case, where a newer system firmware has a 
fix (and the DMI check would need to be extended).

For completeness, I’d mention/paste the new log message.

> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217890
> Signed-off-by: Adam Alves <adamoa@gmail.com>

Should this be backported to the stable series?

> ---
> v1->v2: fix formatting issues and simplified tpm_chip_stop code.
> 
>   drivers/char/tpm/tpm-chip.c      | 12 +++++++++++
>   drivers/char/tpm/tpm-interface.c | 37 ++++++++++++++++++++++++++++++++
>   drivers/char/tpm/tpm.h           |  1 +
>   include/linux/tpm.h              |  1 +
>   4 files changed, 51 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 42b1062e33cd..a183e1355289 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -137,6 +137,12 @@ EXPORT_SYMBOL_GPL(tpm_chip_start);
>    */
>   void tpm_chip_stop(struct tpm_chip *chip)
>   {
> +	if (chip->flags & TPM_CHIP_FLAG_PRESERVE_LOCALITY) {
> +		if (chip->locality != 0)
> +			tpm_request_locality(chip);
> +		return;
> +	}
> +
>   	tpm_go_idle(chip);
>   	tpm_relinquish_locality(chip);
>   	tpm_clk_disable(chip);
> @@ -291,6 +297,9 @@ int tpm_class_shutdown(struct device *dev)
>   {
>   	struct tpm_chip *chip = container_of(dev, struct tpm_chip, dev);
>   
> +	if (tpm_locality_on_suspend)
> +		chip->flags |= TPM_CHIP_FLAG_PRESERVE_LOCALITY;
> +
>   	down_write(&chip->ops_sem);
>   	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
>   		if (!tpm_chip_start(chip)) {
> @@ -668,6 +677,9 @@ EXPORT_SYMBOL_GPL(tpm_chip_register);
>    */
>   void tpm_chip_unregister(struct tpm_chip *chip)
>   {
> +	if (tpm_locality_on_suspend)
> +		chip->flags |= TPM_CHIP_FLAG_PRESERVE_LOCALITY;
> +
>   	tpm_del_legacy_sysfs(chip);
>   	if (tpm_is_hwrng_enabled(chip))
>   		hwrng_unregister(&chip->hwrng);
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 66b16d26eecc..7f770ea98402 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -26,6 +26,7 @@
>   #include <linux/suspend.h>
>   #include <linux/freezer.h>
>   #include <linux/tpm_eventlog.h>
> +#include <linux/dmi.h>
>   
>   #include "tpm.h"
>   
> @@ -382,6 +383,36 @@ int tpm_auto_startup(struct tpm_chip *chip)
>   	return rc;
>   }
>   
> +/*
> + * Bug workaround - some boards expect the TPM to be on Locality 0
> + * before suspend/shutdown, halting the system otherwise before
> + * suspend and shutdown. Change suspend behavior for these cases.
> + */
> +bool tpm_locality_on_suspend;
> +module_param_named(locality_on_suspend, tpm_locality_on_suspend, bool, 0644);
> +MODULE_PARM_DESC(locality_on_suspend,
> +		 "Put TPM at locality 0 before suspend/shutdown.");

I was wondering, if there is a name, that would make clear, that it is 
not only during suspend. But I couldn’t come up with one.

> +
> +static int __init tpm_set_locality_on_suspend(const struct dmi_system_id *system_id)
> +{
> +	pr_info("Board %s: TPM locality preserved before suspend/shutdown.\n",
> +		system_id->ident);
> +	tpm_locality_on_suspend = true;
> +
> +	return 0;
> +}
> +
> +static const struct dmi_system_id tpm_board_quirks[] __initconst = {
> +	{
> +		.ident = "TUF GAMING B460M-PLUS",
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "ASUSTeK COMPUTER INC."),
> +			DMI_MATCH(DMI_BOARD_NAME, "TUF GAMING B460M-PLUS"),
> +		},
> +		.callback = tpm_set_locality_on_suspend,
> +	},
> +};
> +
>   /*
>    * We are about to suspend. Save the TPM state
>    * so that it can be restored.
> @@ -394,6 +425,9 @@ int tpm_pm_suspend(struct device *dev)
>   	if (!chip)
>   		return -ENODEV;
>   
> +	if (tpm_locality_on_suspend)
> +		chip->flags |= TPM_CHIP_FLAG_PRESERVE_LOCALITY;
> +
>   	if (chip->flags & TPM_CHIP_FLAG_ALWAYS_POWERED)
>   		goto suspended;
>   
> @@ -431,6 +465,7 @@ int tpm_pm_resume(struct device *dev)
>   	if (chip == NULL)
>   		return -ENODEV;
>   
> +	chip->flags &= ~TPM_CHIP_FLAG_PRESERVE_LOCALITY;
>   	chip->flags &= ~TPM_CHIP_FLAG_SUSPENDED;
>   
>   	/*
> @@ -476,6 +511,8 @@ static int __init tpm_init(void)
>   {
>   	int rc;
>   
> +	dmi_check_system(tpm_board_quirks);
> +
>   	rc = class_register(&tpm_class);
>   	if (rc) {
>   		pr_err("couldn't create tpm class\n");
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 61445f1dc46d..f2657b611b81 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -236,6 +236,7 @@ extern dev_t tpm_devt;
>   extern const struct file_operations tpm_fops;
>   extern const struct file_operations tpmrm_fops;
>   extern struct idr dev_nums_idr;
> +extern bool tpm_locality_on_suspend;
>   
>   ssize_t tpm_transmit(struct tpm_chip *chip, u8 *buf, size_t bufsiz);
>   int tpm_get_timeouts(struct tpm_chip *);
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 4ee9d13749ad..1fbb33f386d1 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -284,6 +284,7 @@ enum tpm_chip_flags {
>   	TPM_CHIP_FLAG_FIRMWARE_UPGRADE		= BIT(7),
>   	TPM_CHIP_FLAG_SUSPENDED			= BIT(8),
>   	TPM_CHIP_FLAG_HWRNG_DISABLED		= BIT(9),
> +	TPM_CHIP_FLAG_PRESERVE_LOCALITY		= BIT(10),
>   };
>   
>   #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

