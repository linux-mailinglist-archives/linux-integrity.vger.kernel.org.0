Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23EF73A7E82
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Jun 2021 14:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbhFOM6w (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Jun 2021 08:58:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:60744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230146AbhFOM6v (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Jun 2021 08:58:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2BB39613CC;
        Tue, 15 Jun 2021 12:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623761807;
        bh=jZVlQjrUU71ZzHvGn0Y6BLVzRPjJQCfZkNE4NbLIpJw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oTtzpWe/iUFwwW+Pl4a7BrsIFeYLsoZL6EYLR0GmqMqMFqOhzr+7i/hjA+trVDb+x
         nMb9v3Wts1MstBE+Dc/H+LhyEwXm611xPhWpqQeh6JoQehM5XjFie9jajGlBBzENTZ
         RCixl3rDpwGfnyk4wmUkjbIseWNeI63WN7cAng8ZoNFtuamo5Uv8oj7/cgErLXhBsZ
         IDYErCWDguLyVTXxH6Ey5I0ZkaO3GAOY25zMfy1cRqFF2nlckT9yQQia15H6is9cAt
         thMklXtnPQfK2CI8EmsYBiqy7uzrKpOEiG5+zbuCvrF55oM2w2+DkwPw0uQ3DTIaSo
         +b1hcoh5V+/aw==
Date:   Tue, 15 Jun 2021 15:56:45 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Laurent Bigonville <bigon@debian.org>
Cc:     linux-integrity@vger.kernel.org, Lukasz Majczak <lma@semihalf.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Subject: Re: [PATCH] tpm, tpm_tis: Acquire locality in
 tpm_tis_gen_interrupt() and tpm_get_timeouts()
Message-ID: <20210615125645.q2z2hrjsfcbs57wj@kernel.org>
References: <YC2YyO7mJ7E73Voy@kernel.org>
 <ed73c137-373d-9767-25e6-309534652354@debian.org>
 <20210603052857.44zppwdfz4aror34@kernel.org>
 <07fb4429-d0cc-c471-1baa-a1a1eb2e8ae6@debian.org>
 <20210609124327.xkaf3bkcvyw2yxkn@kernel.org>
 <bfb9fdc7-668a-ff9c-1f5d-152df2ca106e@debian.org>
 <20210610122909.qaczp6nbish6wzbt@kernel.org>
 <48721227-6518-779e-c6f2-692c4d7b5c92@debian.org>
 <20210614204025.o46slg6qibdknqza@kernel.org>
 <5fda502a-3c0b-f508-ab52-319372b70cb2@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5fda502a-3c0b-f508-ab52-319372b70cb2@debian.org>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jun 15, 2021 at 01:19:56PM +0200, Laurent Bigonville wrote:
> Le 14/06/21 à 22:40, Jarkko Sakkinen a écrit :
> > On Thu, Jun 10, 2021 at 04:00:27PM +0200, Laurent Bigonville wrote:
> > > Le 10/06/21 à 14:29, Jarkko Sakkinen a écrit :
> > > > On Thu, Jun 10, 2021 at 01:35:47PM +0200, Laurent Bigonville wrote:
> > > > > # dmesg |grep -i tpm
> > > > > 
> > > > > [   13.019986] tpm_tis 00:06: 1.2 TPM (device-id 0x6871, rev-id 1)
> > > > > [   15.016198] tpm tpm0: tpm_try_transmit: send(): error -62
> > > > > [   15.016208] tpm tpm0: A TPM error (-62) occurred attempting to determine
> > > > > the timeouts
> > > > > [   15.016239] tpm_tis: probe of 00:06 failed with error -62
> > > > > [   15.053255] tpm_inf_pnp 00:06: Found TPM with ID IFX0102
> > > > If possible, can you check what happens when you apply the attached patch.
> > > > I'm not proposing it as a bug fix but it just simplifies the flow a lot,
> > > > and might help to observe something.
> > > > 
> > > With the patch on the top of HEAD of master and the patch from your branch,
> > > I'm getting this:
> > > 
> > > [   13.140548] tpm tpm0: invalid TPM_STS.x 0xa0, dumping stack for forensics
> > > [   13.140617] CPU: 4 PID: 462 Comm: systemd-udevd Tainted: G          I
> > > E     5.13.0-rc5+ #7
> > > [   13.140621] Hardware name: System manufacturer System Product Name/P6T
> > > DELUXE V2, BIOS 0406    04/24/2009
> > > [   13.140623] Call Trace:
> > > [   13.140628]  dump_stack+0x76/0x94
> > > [   13.140637]  tpm_tis_status.cold+0x19/0x20 [tpm_tis_core]
> > > [   13.140643]  tpm_transmit+0x15f/0x3d0 [tpm]
> > > [   13.140657]  tpm_transmit_cmd+0x25/0x90 [tpm]
> > > [   13.140666]  tpm2_probe+0xe2/0x140 [tpm]
> > It's weird because it's the first transaction with the TPM, not likely
> > to have any sort of mismatch in power gating.
> > 
> > I'm suspecting this:
> > 
> > 	if (wait_startup(chip, 0) != 0) {
> > 		rc = -ENODEV;
> > 		goto out_err;
> > 	}
> > 
> > I did not find anything from [*] stating that reading Access Register,
> > could cause any change in the burstCount (0xa0) but still might be worth
> > of testing to couple that with
> > 
> > 	release_locality(chip, 0);
> > 
> > I.e. add that just after the first snippet.
> > 
> You mean this, right?
> 
> diff --git a/drivers/char/tpm/tpm_tis_core.c
> b/drivers/char/tpm/tpm_tis_core.c
> index 3b5a03f9efce..857ea790e9d3 100644
> --- a/drivers/char/tpm/tpm_tis_core.c
> +++ b/drivers/char/tpm/tpm_tis_core.c
> @@ -969,6 +969,7 @@ int tpm_tis_core_init(struct device *dev, struct
> tpm_tis_data *priv, int irq,
>                 rc = -ENODEV;
>                 goto out_err;
>         }
> +       release_locality(chip, 0);
> 
>         /* Take control of the TPM's interrupt hardware and shut it off */
>         rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
> 
> 
> With this change (and with or without "tpm_tis: Use request_locality()
> before calling tpm2_probe()"), I get the following:
> 
> [   13.420485] tpm tpm0: invalid TPM_STS.x 0xff, dumping stack for forensics
> [   13.420494] CPU: 5 PID: 461 Comm: systemd-udevd Tainted: G          I
> E     5.13.0-rc6+ #8
> [   13.420498] Hardware name: System manufacturer System Product Name/P6T
> DELUXE V2, BIOS 0406    04/24/2009
> [   13.420500] Call Trace:
> [   13.420505]  dump_stack+0x76/0x94
> [   13.420512]  tpm_tis_status.cold+0x19/0x20 [tpm_tis_core]
> [   13.420519]  wait_for_tpm_stat+0x49/0x200 [tpm_tis_core]
> [   13.420524]  ? get_page_from_freelist+0x228/0xed0
> [   13.420530]  ? tpm_tcg_read_bytes+0x30/0x50 [tpm_tis]
> [   13.420536]  tpm_tis_send_data+0x90/0x250 [tpm_tis_core]
> [   13.420542]  tpm_tis_send_main+0x2e/0xf0 [tpm_tis_core]
> [   13.420547]  tpm_transmit+0xd8/0x3d0 [tpm]
> [   13.420559]  tpm_transmit_cmd+0x25/0x90 [tpm]
> [   13.420567]  tpm2_probe+0xe2/0x140 [tpm]
> [   13.420577]  tpm_tis_core_init+0x1fd/0x2e0 [tpm_tis_core]
> [   13.420582]  ? tpm_tis_init.part.0+0x130/0x130 [tpm_tis]
> [   13.420587]  tpm_tis_pnp_init+0xe1/0x110 [tpm_tis]
> [   13.420594]  pnp_device_probe+0xaf/0x140
> [   13.420600]  really_probe+0xf2/0x460
> [   13.420606]  driver_probe_device+0xe8/0x160
> [   13.420610]  device_driver_attach+0xa1/0xb0
> [   13.420614]  __driver_attach+0x8f/0x150
> [   13.420618]  ? device_driver_attach+0xb0/0xb0
> [   13.420621]  ? device_driver_attach+0xb0/0xb0
> [   13.420624]  bus_for_each_dev+0x78/0xc0
> [   13.420628]  bus_add_driver+0x12b/0x1e0
> [   13.420632]  driver_register+0x8b/0xe0
> [   13.420636]  ? 0xffffffffc1413000
> [   13.420639]  init_tis+0xa0/0x1000 [tpm_tis]
> [   13.420646]  do_one_initcall+0x44/0x1d0
> [   13.420652]  ? kmem_cache_alloc_trace+0x119/0x240
> [   13.420657]  do_init_module+0x5c/0x260
> [   13.420662]  __do_sys_finit_module+0xb1/0x110
> [   13.420668]  do_syscall_64+0x40/0xb0
> [   13.420673]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [   13.420678] RIP: 0033:0x7f15fe84e9b9
> [   13.420681] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48
> 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48>
> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a7 54 0c 00 f7 d8 64 89 01 48
> [   13.420685] RSP: 002b:00007fffc3aca668 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000139
> [   13.420689] RAX: ffffffffffffffda RBX: 00005561627275b0 RCX:
> 00007f15fe84e9b9
> [   13.420692] RDX: 0000000000000000 RSI: 00007f15fe9d9e2d RDI:
> 0000000000000012
> [   13.420694] RBP: 0000000000020000 R08: 0000000000000000 R09:
> 0000556161c2f330
> [   13.420696] R10: 0000000000000012 R11: 0000000000000246 R12:
> 00007f15fe9d9e2d
> [   13.420698] R13: 0000000000000000 R14: 000055616271dab0 R15:
> 00005561627275b0
> [...]
> [   14.185406] tpm tpm0: tpm_try_transmit: send(): error -62
> [   14.185422] tpm_tis 00:06: 1.2 TPM (device-id 0x6871, rev-id 1)
> [   15.021233] tpm tpm0: tpm_try_transmit: send(): error -62
> [   24.381575] tpm tpm0: tpm_try_transmit: send(): error -62
> [...]
> 
> But now the /dev/tpm0 device appears (but doesn't seem to work)

I'm sorry, I made a mistake: release_locality() call should be exactly
right before tpm_chip_start(). The reason is that we access TPM_INT_ENABLE,
i.e. locality is released too early.

In summary, I think I would try this:

	tpm_chip_stop(chip);

	rc = tpm_chip_start(chip);
	if (rc)
		goto out_err;
	rc = tpm2_probe(chip);
	tpm_chip_stop(chip);
	if (rc)
		goto out_err;

tpm_chip_stop() is makes more sense it takes care also of disabling
clk_enable.

I.e. TPM should be shut down right after intmask mangling...

/Jarkko
