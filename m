Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C94130C615
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Feb 2021 17:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236581AbhBBQh6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Feb 2021 11:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbhBBQff (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Feb 2021 11:35:35 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB44BC061355;
        Tue,  2 Feb 2021 08:29:54 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id a77so23365289oii.4;
        Tue, 02 Feb 2021 08:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=049dN8RuBt7TjbGRgFzKEevLXvttOKEGLxTC8edvUfw=;
        b=u1CoS2Ml68BbVR82L+5ij6HOxTAFALJV61zDbumQ6wC4n8XkWGGHt4dINtiqey1cNM
         vY7/vZMGtY5Da509ZzjVIA+h6CIWyuyUT41Ggbrmt1qZUeFnUDQWTIE/6jGLLzrvY4d5
         tmvQC59VuMXQwfpTMvwOakHKOtD1p4w6rLKoy1yj321y4U5yx6pSsdL32yETnkWnv6H2
         PTk8Rvt82bRNCiN1DXANoNZhCPq4M/nuKB4oSBlj7uX5Q3TujGqr+mjVsZoyFokuTUnf
         T4Qkey0G8c16cYT5FAR4c8OD3m1muFKE2ZSsHMmpbQpNzN3MTH9cR+OZ8Whbg315xrRx
         /BiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=049dN8RuBt7TjbGRgFzKEevLXvttOKEGLxTC8edvUfw=;
        b=eS0ExqgU+MFW8x8siF7xip2dJVHwnTW9GUusWyAdvYncg6jfSE4/D7DiUlLPRwAHgg
         HDPVPbJ34+an0R5bgwX/lHzyPV49Gq+Otf4SS0sOmjhOokQ0Gv1RDx2L7AxEUoo/5juv
         wRq5tPnd8jIYxgOAH7UTUqJzET8f1TKXkPY3S2RyudBUAUFICbyDgCqlImPtQ9OzgWMd
         pjo8DS0SoTxrSNIJuqQNlG/iUDnWtV3q7H65M8r38JhexA52nyKFBc3s2r8djdVPVM/m
         mrG1eTnhDJqUR/BIKETuVHpyvFgj+v9dmAwVcIcKm7bQ2sNQ6C85oR2LXdCZAESbzUKU
         aUOg==
X-Gm-Message-State: AOAM533GWHE8qsEup3MrhSx9vOhd59x7Gu+9pYGVvV3OUAWfyOHc/Jn+
        Cvpzvf/TN5gsHR56vFpdELc=
X-Google-Smtp-Source: ABdhPJxXR5SJwrbXvBKSS4bByJRyaYE/bhp+wCUKVAqOK/JJQ/PEQtAVemRgmAw1mAp52xOiPAGDAQ==
X-Received: by 2002:a05:6808:4ce:: with SMTP id a14mr3170567oie.88.1612283394138;
        Tue, 02 Feb 2021 08:29:54 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 7sm5141717oiz.43.2021.02.02.08.29.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Feb 2021 08:29:52 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 2 Feb 2021 08:29:50 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Lukasz Majczak <lma@semihalf.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Dirk Gouders <dirk@gouders.net>, Tj <ml.linux@elloe.vision>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Radoslaw Biernacki <rad@semihalf.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Alex Levin <levinale@google.com>
Subject: Re: [PATCH v3] tpm_tis: Add missing tpm_request/relinquish_locality
 calls
Message-ID: <20210202162950.GE159455@roeck-us.net>
References: <20210128130753.1283534-1-lma@semihalf.com>
 <20210202155139.521421-1-lma@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202155139.521421-1-lma@semihalf.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Feb 02, 2021 at 04:51:39PM +0100, Lukasz Majczak wrote:
> There are missing calls to tpm_request_locality before the calls to
> the tpm_get_timeouts() and tpm_tis_probe_irq_single() - both functions
> internally send commands to the tpm. As the current
> approach might work for tpm2, it fails for tpm1.x - in that case
> call to tpm_get_timeouts() or tpm_tis_probe_irq_single()
> without acquired locality fails and in turn causes tpm_tis_core_init()
> to fail, it can be observed in the log with the following warning
> trace:
> 
> [    4.324298] TPM returned invalid status
> [    4.324806] WARNING: CPU: 2 PID: 1 at drivers/char/tpm/tpm_tis_core.c:275 tpm_tis_status+0x86/0x8f
> [    4.325888] Modules linked in:
> [    4.326287] CPU: 2 PID: 1 Comm: swapper/0 Tainted: G        W         5.11.0-rc6-next-20210201-00003-g214461adb2e8 #43
> [    4.327406] Hardware name: Google Caroline/Caroline, BIOS Google_Caroline.7820.430.0 07/20/2018
> [    4.327918] RIP: 0010:tpm_tis_status+0x86/0x8f
> [    4.328323] Code: 28 00 00 00 48 3b 45 f0 75 24 89 d8 48 83 c4 10 5b 5d c3 c6 05 58 d9 28 01 01 31 db 48 c7 c7 73 52 98 9c 31 c0 e8 c2 17 b0 ff <0f> 0b eb cd e8 cf 4f 55 00 0f 1f 44 00 00 55 48 89 e56
> [    4.330592] RSP: 0000:ffff88810092f7a0 EFLAGS: 00010246
> [    4.331223] RAX: 691ee151166db100 RBX: 0000000000000000 RCX: 0000000000000001
> [    4.331860] RDX: 0000000000000006 RSI: ffffffff9c96d302 RDI: 00000000ffffffff
> [    4.332272] RBP: ffff88810092f7b8 R08: dffffc0000000000 R09: fffffbfff39c96ce
> [    4.332683] R10: fffffbfff39c96ce R11: 0000000000000001 R12: ffff8881053e2000
> [    4.333109] R13: 0000000065000000 R14: ffff888105d71000 R15: ffff888105cd2628
> [    4.333738] FS:  0000000000000000(0000) GS:ffff88842f200000(0000) knlGS:0000000000000000
> [    4.334432] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    4.334783] CR2: 0000000000000000 CR3: 0000000037828001 CR4: 00000000003706e0
> [    4.335196] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [    4.335886] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [    4.336793] Call Trace:
> [    4.337107]  tpm_tis_send_data+0x3d/0x22f
> [    4.337506]  tpm_tis_send_main+0x30/0xf5
> [    4.337746]  tpm_transmit+0xbf/0x327
> [    4.338042]  ? __alloc_pages_nodemask+0x261/0x36d
> [    4.338615]  tpm_transmit_cmd+0x2c/0x93
> [    4.339109]  tpm1_getcap+0x232/0x285
> [    4.339578]  tpm1_get_timeouts+0x48/0x47d
> [    4.339964]  ? lockdep_init_map_type+0x71/0x257
> [    4.340256]  ? lockdep_init_map_type+0x71/0x257
> [    4.340719]  ? __raw_spin_lock_init+0x40/0x69
> [    4.341208]  tpm_tis_core_init+0x402/0x5ee
> [    4.341629]  tpm_tis_init+0x11d/0x1a2
> [    4.341867]  tpm_tis_pnp_init+0x91/0xb5
> [    4.342101]  ? tis_int_handler+0x15f/0x15f
> [    4.342466]  pnp_device_probe+0x79/0x9f
> [    4.342941]  really_probe+0x149/0x4a8
> [    4.343412]  driver_probe_device+0xd6/0x144
> [    4.343968]  device_driver_attach+0x42/0x5b
> [    4.344382]  __driver_attach+0xca/0x139
> [    4.344617]  ? driver_attach+0x1f/0x1f
> [    4.344860]  bus_for_each_dev+0x85/0xb7
> [    4.345096]  bus_add_driver+0x12b/0x228
> [    4.345330]  driver_register+0x64/0xed
> [    4.345560]  init_tis+0xa5/0xeb
> [    4.345784]  ? lock_is_held_type+0x100/0x141
> [    4.346044]  ? tpm_init+0x106/0x106
> [    4.346259]  ? rcu_read_lock_sched_held+0x41/0x7e
> [    4.346542]  ? tpm_init+0x106/0x106
> [    4.346678] battery: ACPI: Battery Slot [BAT0] (battery present)
> [    4.346754]  do_one_initcall+0x1b9/0x43d
> [    4.346776]  ? asm_sysvec_apic_timer_interrupt+0x12/0x20
> [    4.347659]  ? lockdep_hardirqs_on+0x8e/0x12e
> [    4.347937]  ? lock_is_held_type+0x100/0x141
> [    4.348196]  ? rcu_read_lock_sched_held+0x41/0x7e
> [    4.348477]  do_initcall_level+0x99/0xa9
> [    4.348717]  ? kernel_init+0xe/0x10a
> [    4.348954]  do_initcalls+0x4e/0x79
> [    4.349170]  kernel_init_freeable+0x15a/0x1ae
> [    4.349434]  ? rest_init+0x1d6/0x1d6
> [    4.349655]  kernel_init+0xe/0x10a
> [    4.349882]  ret_from_fork+0x22/0x30
> [    4.350103] irq event stamp: 700039
> [    4.350318] hardirqs last  enabled at (700047): [<ffffffff9b735265>] console_unlock+0x4be/0x538
> [    4.350836] hardirqs last disabled at (700056): [<ffffffff9b734e84>] console_unlock+0xdd/0x538
> [    4.351331] softirqs last  enabled at (699522): [<ffffffff9c4004ec>] __do_softirq+0x4ec/0x539
> [    4.351835] softirqs last disabled at (699517): [<ffffffff9c200f62>] asm_call_irq_on_stack+0x12/0x20
> 
> Following the trace one can also notice a comment in the tpm_tis_status():
> 
> 		/*
> 		 * If this trips, the chances are the read is
> 		 * returning 0xff because the locality hasn't been
> 		 * acquired.  Usually because tpm_try_get_ops() hasn't
> 		 * been called before doing a TPM operation.
> 		 */
> In this case we don't have to call tpm_try_get_ops()
> as both calls (tpm_get_timeouts() and tpm_tis_probe_irq_single()) are
> in the tpm_tis_core_init function and don't require any locking or clock 
> enablement. Similar usage is in the probe_itpm() function also called
> inside tpm_tis_core_init().
> Tested on Samsung Chromebook Pro (Caroline).
> 
> Signed-off-by: Lukasz Majczak <lma@semihalf.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Hi Jarkko
> 
> I have checked the linux-next with James patches, also followed Dirk
> suggestion applying remaining ones, although without any luck -
> a warning trace was still present. As Guneter mentioned earlier, this
> patch[1] doesn't address a lack of acquired locality in the
> tpm_get_timeouts() and does it only for tpm_tis_probe_irq_single() but
> also without a call to tpm_relinquish_locality().
> 
> Here are my logs from the clean linux-next master branch [2]
> (with two James' patches present) and with my
> patch applied[3]
> 
> Best regards,
> Lukasz
> 
> [1] https://lore.kernel.org/linux-integrity/20201001180925.13808-5-James.Bottomley@HansenPartnership.com/
> [2] https://gist.github.com/semihalf-majczak-lukasz/f588c0684a6cc7d983bb9c4eb4bda586
> [3] https://gist.github.com/semihalf-majczak-lukasz/88ede933bc7d28d806e3532850a04054
> 
> v2 -> v3:
>  - Added braces around if part of if/else statements
>  - Rebased to linux-next
>  - Updated commit message
>  
>  drivers/char/tpm/tpm-chip.c      |  4 ++--
>  drivers/char/tpm/tpm-interface.c | 13 ++++++++++---
>  drivers/char/tpm/tpm.h           |  2 ++
>  drivers/char/tpm/tpm_tis_core.c  | 14 +++++++++++---
>  4 files changed, 25 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index ddaeceb7e109..5351963a4b19 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -32,7 +32,7 @@ struct class *tpm_class;
>  struct class *tpmrm_class;
>  dev_t tpm_devt;
>  
> -static int tpm_request_locality(struct tpm_chip *chip)
> +int tpm_request_locality(struct tpm_chip *chip)
>  {
>  	int rc;
>  
> @@ -47,7 +47,7 @@ static int tpm_request_locality(struct tpm_chip *chip)
>  	return 0;
>  }
>  
> -static void tpm_relinquish_locality(struct tpm_chip *chip)
> +void tpm_relinquish_locality(struct tpm_chip *chip)
>  {
>  	int rc;
>  
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 1621ce818705..2a9001d329f2 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -241,10 +241,17 @@ int tpm_get_timeouts(struct tpm_chip *chip)
>  	if (chip->flags & TPM_CHIP_FLAG_HAVE_TIMEOUTS)
>  		return 0;
>  
> -	if (chip->flags & TPM_CHIP_FLAG_TPM2)
> +	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
>  		return tpm2_get_timeouts(chip);
> -	else
> -		return tpm1_get_timeouts(chip);
> +	} else {
> +		ssize_t ret = tpm_request_locality(chip);
> +
> +		if (ret)
> +			return ret;
> +		ret = tpm1_get_timeouts(chip);
> +		tpm_relinquish_locality(chip);
> +		return ret;
> +	}
>  }
>  EXPORT_SYMBOL_GPL(tpm_get_timeouts);
>  
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index 947d1db0a5cc..8c13008437dd 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -193,6 +193,8 @@ static inline void tpm_msleep(unsigned int delay_msec)
>  
>  int tpm_chip_start(struct tpm_chip *chip);
>  void tpm_chip_stop(struct tpm_chip *chip);
> +int tpm_request_locality(struct tpm_chip *chip);
> +void tpm_relinquish_locality(struct tpm_chip *chip);
>  struct tpm_chip *tpm_find_get_ops(struct tpm_chip *chip);
>  __must_check int tpm_try_get_ops(struct tpm_chip *chip);
>  void tpm_put_ops(struct tpm_chip *chip);
> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
> index 431919d5f48a..d4f381d6356e 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -708,11 +708,19 @@ static int tpm_tis_gen_interrupt(struct tpm_chip *chip)
>  	u32 cap2;
>  	cap_t cap;
>  
> -	if (chip->flags & TPM_CHIP_FLAG_TPM2)
> +	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
>  		return tpm2_get_tpm_pt(chip, 0x100, &cap2, desc);
> -	else
> -		return tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap, desc,
> +	} else {
> +		ssize_t ret = tpm_request_locality(chip);
> +
> +		if (ret)
> +			return ret;
> +		ret = tpm1_getcap(chip, TPM_CAP_PROP_TIS_TIMEOUT, &cap, desc,
>  				  0);
> +		tpm_relinquish_locality(chip);
> +		return ret;
> +	}
> +
>  }
>  
>  /* Register the IRQ and issue a command that will cause an interrupt. If an
> -- 
> 2.25.1
> 
