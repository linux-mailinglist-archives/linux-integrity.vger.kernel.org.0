Return-Path: <linux-integrity+bounces-3889-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E20C9A6EFC
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Oct 2024 18:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00BE1284103
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Oct 2024 16:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763E01CBE9B;
	Mon, 21 Oct 2024 16:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="C7i96HM9"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13B91CBEAC;
	Mon, 21 Oct 2024 16:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729526540; cv=none; b=d2RSiPYcWGRZQ60J9Ri9S7sSOL3wDaR5OGrT4NxS0XW6IStAe6shVZLA/UC9EuXc6uelW3E3ZpS51DCY7egDzdjaBd46UU9jhGyoNNygyKgDT/jzpCsWEwmcj3/kBpESwg8qmxC0S9thSoFxpbabpR2wA3ZEoSLknO+EneqmA+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729526540; c=relaxed/simple;
	bh=2jsYqb4Ep2sJG5RivIhBxdAGOfUNCMP3DJotctrN4pU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gttUYtcQjaqNdV7fulXnkuDDG772wPIKf9j/7cGV5XuNGuNNYge3j3BEQzYleePpmLapMh2k6ZUjFK+ApzWBPlITl7/Y+ki9H89jgHyHuTL+7XaJYlTn96yXABD5fsXddjKLa6RNlb1KjQiW/rlMMQ9DwGmRrIsvsJ8D0UQF6Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=C7i96HM9; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AFE7340E0198;
	Mon, 21 Oct 2024 16:02:15 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TNPfEbfOKVQk; Mon, 21 Oct 2024 16:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1729526530; bh=gxl89NxCdQju+U0MLf0hibFSL/6VOGUYN70p3/bw+j4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C7i96HM9lXwl1k5HrAq902CmHG0b3HztacSFaP1d9APzlRdHBwfHHY+Nt6ByNtrcF
	 R8j/llMr1+RvDOHplMM3GixW8TmJ6nK3x2XQHHCn5I39mGOT43cvxL2umYYan+HfYj
	 CRJLTO6GFdi/1RU4Aa54ow86yrb634NySlltHrQQCh4nhTrzrHXZbpVeHsGAgPHNSK
	 uP8+K+rqfQQDPgBqdHTpDZSh74tVfLsGUmEdhRB9m6YhIsAb/koG850TzIezCAsw7T
	 naUCIv76eZlZASeU/dOXUKsfn186sZvz3hMCOOLulMVAaHs7RjMwsSvoIKLVfNsxh0
	 2JXlWguaQTySq3ZR+Ki6Zg3415vJX5qsRQVTGKBC+hUsoxDKGSFCTbn/cAief5jYyr
	 9+Pe0Kr+hUr0wFFSOQHG4qVZi01RZCnMKIWWjLb8JiUiu90PAff6r3avbT1YjDvL79
	 EwAYGAAbTrW0t+XKU3+T/5DUH/8w4HVw2PNeWPXH5w3esKMQ8Rdfz72NARJfzELgs1
	 IHnLM08TDqszmkfWEZbgtLLf54Cp6twbiJ94FySU3g4cjbvHePb4Urpd9IseieN/JM
	 1XS25ZsLtRBAbZm49S+px84WiWvweL6abSkW16sXLEGkiQvjzrFwgG1AuZ8go048Q5
	 aoyYhLuA2KoPr42gbEiqNAnY=
Received: from zn.tnic (p5de8e8eb.dip0.t-ipconnect.de [93.232.232.235])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 98CD340E0194;
	Mon, 21 Oct 2024 16:02:03 +0000 (UTC)
Date: Mon, 21 Oct 2024 18:02:02 +0200
From: Borislav Petkov <bp@alien8.de>
To: bugzilla-daemon@kernel.org, Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	lkml <linux-kernel@vger.kernel.org>
Cc: mikeseohyungjin@gmail.com
Subject: Re: [Bug 219383] New: System reboot on S3 sleep/wakeup test
Message-ID: <20241021160202.GGZxZ6-gCNNKUtTRse@fat_crate.local>
References: <bug-219383-6385@https.bugzilla.kernel.org/>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bug-219383-6385@https.bugzilla.kernel.org/>

Looks like TPM. CCing the proper people.

On Mon, Oct 14, 2024 at 12:46:26AM +0000, bugzilla-daemon@kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=219383
> 
>             Bug ID: 219383
>            Summary: System reboot on S3 sleep/wakeup test
>            Product: Platform Specific/Hardware
>            Version: 2.5
>           Hardware: All
>                 OS: Linux
>             Status: NEW
>           Severity: normal
>           Priority: P3
>          Component: x86-64
>           Assignee: platform_x86_64@kernel-bugs.osdl.org
>           Reporter: mikeseohyungjin@gmail.com
>         Regression: No
> 
> I'm working for LG laptops, and I have run serveral LG PC with ubuntu OS. You
> may know, most LG laptops has intel soc.
> I found out a critical issue, system reboot on S3 sleep/wake up.
> 
> Enviornments:
> - PC BIOS : Phoenix Technologies
> - Intel Jasperlake or Intel Lunarlake 
> - OS Ubuntu 22.04(Jasperlake), 24.04.1(Lunarlake)
> - linux kernel version 6.x.0(Jasperlake) or up-to-date 6.11(Lunarlake)
> 
> Symptom:
> 
> Running the aging scripts like below, system reboots.
> -------------------------
> #!/bin/bash
> <snip>
> for (( i=1; i<=10000 ; i++ ))
> sudo rtcwake -m mem -s 10 >> ${LOG} 2>&1
> <snip>
> -------------------------
> The scripts works like below,
> 1. waits 10 secs
> 2. echo mem > /sys/power/state
> 3. waits 10 secs again and wake up system like press power button.
> 
> 
> My analysis:
> 
> I had reproduced several times to find that BIOS side triggered the system
> reboots.
> | pm_suspend() | syscore_suspend() | acpi_suspend_enter() | ... |  < BIOS > | 
> ...| acpi_suspend_enter() |  syscore_resume() | ...|
> 
> Debugging on BIOS, TPM2 can generate cold reset when it detects something wrong
> after TPM resuming.
> In the BIOS code, if there are active PCR banks that are not supported by the
> Platform mask, it supposes to be update the TPM allocations and reboot the
> machine.
> 
> It means that something in linux kernel side can effect operations of  tpm when
> going to sleep.
> So, I have debuggered and traced the functions related to tpm, such as
> tpm_chip_start whenever the symptoms represented.
> 
> In normal case, tpm_chip_start() called once like below,
>  tpm_pm_suspend()-> tpm_chip_start().
> but issued case, additionally called below
>  hwrng_fillfn ->
>   rng_get_data ->
>     tpm_hwrng_read ->
>       tpm_get_random ->
>         tpm_find_get_ops ->
>            tpm_try_get_ops ->
>              tpm_chip_start ->
> 
> I found out that when running hwrng_fillfn(), related to Hardware random number
> generator,  called during system_sleep, it can cause system reboots.
> To Verify it, I have tested with custom kernel which includes below patch.
> 
> -----------------------
> From 373e92bb6d471c5fb42bacb97a4caf5375df5522 Mon Sep 17 00:00:00 2001
> From: mike Seo <mikeseohyungjin@gmail.com>
> Date: Thu, 10 Oct 2024 14:04:57 +0900
> Subject: [PATCH] test_patch
> 
> test_patch for reboot while sleep/wakeup
> 
> Signed-off-by: mike Seo <mikeseohyungjin@gmail.com>
> ---
>  drivers/char/hw_random/core.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
> index 57c51efa5..d3f0059a4 100644
> --- a/drivers/char/hw_random/core.c
> +++ b/drivers/char/hw_random/core.c
> @@ -25,6 +25,7 @@
>  #include <linux/slab.h>
>  #include <linux/string.h>
>  #include <linux/uaccess.h>
> +#include <linux/suspend.h>
> 
>  #define RNG_MODULE_NAME                "hw_random"
> 
> @@ -469,6 +470,22 @@ static struct attribute *rng_dev_attrs[] = {
> 
>  ATTRIBUTE_GROUPS(rng_dev);
> 
> +
> +static int hwrng_pm_notification(struct notifier_block *nb, unsigned long
> action, void *data)
> +{
> +
> +       switch (action) {
> +       case PM_SUSPEND_PREPARE:
> +               is_suspend_prepare = 1;
> +               break;
> +       default:
> +               is_suspend_prepare = 0;
> +               break;
> +       }
> +       return 0;
> +}
> +
> +static struct notifier_block pm_notifier = { .notifier_call =
> hwrng_pm_notification };
>  static int hwrng_fillfn(void *unused)
>  {
>         size_t entropy, entropy_credit = 0; /* in 1/1024 of a bit */
> @@ -478,6 +495,9 @@ static int hwrng_fillfn(void *unused)
>                 unsigned short quality;
>                 struct hwrng *rng;
> 
> +               while (is_suspend_prepare)
> +                       msleep(500);
> +
>                 rng = get_current_rng();
>                 if (IS_ERR(rng) || !rng)
>                         break;
> @@ -549,6 +569,7 @@ int hwrng_register(struct hwrng *rng)
>                         goto out_unlock;
>         }
>         mutex_unlock(&rng_mutex);
> +       WARN_ON(register_pm_notifier(&pm_notifier));
>         return 0;
>  out_unlock:
>         mutex_unlock(&rng_mutex);
> -- 
> 2.43.0
> ------------------------
> 
> And I had passed over 10000 times of s3 wake/sleep aging test.
> 
> Can you make some patches for this issue and merges?
> 
> Thank you,
> Mike
> 
> -- 
> You may reply to this email to add a comment.
> 
> You are receiving this mail because:
> You are watching the assignee of the bug.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

