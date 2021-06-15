Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 094F03A8678
	for <lists+linux-integrity@lfdr.de>; Tue, 15 Jun 2021 18:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhFOQ3f (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 15 Jun 2021 12:29:35 -0400
Received: from ithil.bigon.be ([163.172.57.153]:58938 "EHLO ithil.bigon.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230012AbhFOQ3f (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 15 Jun 2021 12:29:35 -0400
Received: from localhost (localhost [IPv6:::1])
        by ithil.bigon.be (Postfix) with ESMTP id F11CB1FDE2;
        Tue, 15 Jun 2021 18:27:28 +0200 (CEST)
Received: from ithil.bigon.be ([IPv6:::1])
        by localhost (ithil.bigon.be [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id j0Z_CcTM8Enp; Tue, 15 Jun 2021 18:27:28 +0200 (CEST)
Received: from [IPv6:2a02:a03f:65b8:4300:de23:9854:338b:84b3] (unknown [IPv6:2a02:a03f:65b8:4300:de23:9854:338b:84b3])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bigon@bigon.be)
        by ithil.bigon.be (Postfix) with ESMTPSA;
        Tue, 15 Jun 2021 18:27:28 +0200 (CEST)
Subject: Re: [PATCH] tpm, tpm_tis: Acquire locality in tpm_tis_gen_interrupt()
 and tpm_get_timeouts()
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     linux-integrity@vger.kernel.org, Lukasz Majczak <lma@semihalf.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stefan Berger <stefanb@linux.ibm.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
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
 <20210615125645.q2z2hrjsfcbs57wj@kernel.org>
From:   Laurent Bigonville <bigon@debian.org>
Message-ID: <93d17360-64b2-b9e3-8369-f22507f1e992@debian.org>
Date:   Tue, 15 Jun 2021 18:27:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210615125645.q2z2hrjsfcbs57wj@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: fr
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Le 15/06/21 à 14:56, Jarkko Sakkinen a écrit :
> On Tue, Jun 15, 2021 at 01:19:56PM +0200, Laurent Bigonville wrote:
>> Le 14/06/21 à 22:40, Jarkko Sakkinen a écrit :
>>> On Thu, Jun 10, 2021 at 04:00:27PM +0200, Laurent Bigonville wrote:
>>>> Le 10/06/21 à 14:29, Jarkko Sakkinen a écrit :
>>>>> On Thu, Jun 10, 2021 at 01:35:47PM +0200, Laurent Bigonville wrote:
>>>>>> # dmesg |grep -i tpm
>>>>>>
>>>>>> [   13.019986] tpm_tis 00:06: 1.2 TPM (device-id 0x6871, rev-id 1)
>>>>>> [   15.016198] tpm tpm0: tpm_try_transmit: send(): error -62
>>>>>> [   15.016208] tpm tpm0: A TPM error (-62) occurred attempting to determine
>>>>>> the timeouts
>>>>>> [   15.016239] tpm_tis: probe of 00:06 failed with error -62
>>>>>> [   15.053255] tpm_inf_pnp 00:06: Found TPM with ID IFX0102
>>>>> If possible, can you check what happens when you apply the attached patch.
>>>>> I'm not proposing it as a bug fix but it just simplifies the flow a lot,
>>>>> and might help to observe something.
>>>>>
>>>> With the patch on the top of HEAD of master and the patch from your branch,
>>>> I'm getting this:
>>>>
>>>> [   13.140548] tpm tpm0: invalid TPM_STS.x 0xa0, dumping stack for forensics
>>>> [   13.140617] CPU: 4 PID: 462 Comm: systemd-udevd Tainted: G          I
>>>> E     5.13.0-rc5+ #7
>>>> [   13.140621] Hardware name: System manufacturer System Product Name/P6T
>>>> DELUXE V2, BIOS 0406    04/24/2009
>>>> [   13.140623] Call Trace:
>>>> [   13.140628]  dump_stack+0x76/0x94
>>>> [   13.140637]  tpm_tis_status.cold+0x19/0x20 [tpm_tis_core]
>>>> [   13.140643]  tpm_transmit+0x15f/0x3d0 [tpm]
>>>> [   13.140657]  tpm_transmit_cmd+0x25/0x90 [tpm]
>>>> [   13.140666]  tpm2_probe+0xe2/0x140 [tpm]
>>> It's weird because it's the first transaction with the TPM, not likely
>>> to have any sort of mismatch in power gating.
>>>
>>> I'm suspecting this:
>>>
>>> 	if (wait_startup(chip, 0) != 0) {
>>> 		rc = -ENODEV;
>>> 		goto out_err;
>>> 	}
>>>
>>> I did not find anything from [*] stating that reading Access Register,
>>> could cause any change in the burstCount (0xa0) but still might be worth
>>> of testing to couple that with
>>>
>>> 	release_locality(chip, 0);
>>>
>>> I.e. add that just after the first snippet.
>>>
>> You mean this, right?
>>
>> diff --git a/drivers/char/tpm/tpm_tis_core.c
>> b/drivers/char/tpm/tpm_tis_core.c
>> index 3b5a03f9efce..857ea790e9d3 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -969,6 +969,7 @@ int tpm_tis_core_init(struct device *dev, struct
>> tpm_tis_data *priv, int irq,
>>                  rc = -ENODEV;
>>                  goto out_err;
>>          }
>> +       release_locality(chip, 0);
>>
>>          /* Take control of the TPM's interrupt hardware and shut it off */
>>          rc = tpm_tis_read32(priv, TPM_INT_ENABLE(priv->locality), &intmask);
>>
>>
>> With this change (and with or without "tpm_tis: Use request_locality()
>> before calling tpm2_probe()"), I get the following:
>>
>> [   13.420485] tpm tpm0: invalid TPM_STS.x 0xff, dumping stack for forensics
>> [   13.420494] CPU: 5 PID: 461 Comm: systemd-udevd Tainted: G          I
>> E     5.13.0-rc6+ #8
>> [   13.420498] Hardware name: System manufacturer System Product Name/P6T
>> DELUXE V2, BIOS 0406    04/24/2009
>> [   13.420500] Call Trace:
>> [   13.420505]  dump_stack+0x76/0x94
>> [   13.420512]  tpm_tis_status.cold+0x19/0x20 [tpm_tis_core]
>> [   13.420519]  wait_for_tpm_stat+0x49/0x200 [tpm_tis_core]
>> [   13.420524]  ? get_page_from_freelist+0x228/0xed0
>> [   13.420530]  ? tpm_tcg_read_bytes+0x30/0x50 [tpm_tis]
>> [   13.420536]  tpm_tis_send_data+0x90/0x250 [tpm_tis_core]
>> [   13.420542]  tpm_tis_send_main+0x2e/0xf0 [tpm_tis_core]
>> [   13.420547]  tpm_transmit+0xd8/0x3d0 [tpm]
>> [   13.420559]  tpm_transmit_cmd+0x25/0x90 [tpm]
>> [   13.420567]  tpm2_probe+0xe2/0x140 [tpm]
>> [   13.420577]  tpm_tis_core_init+0x1fd/0x2e0 [tpm_tis_core]
>> [   13.420582]  ? tpm_tis_init.part.0+0x130/0x130 [tpm_tis]
>> [   13.420587]  tpm_tis_pnp_init+0xe1/0x110 [tpm_tis]
>> [   13.420594]  pnp_device_probe+0xaf/0x140
>> [   13.420600]  really_probe+0xf2/0x460
>> [   13.420606]  driver_probe_device+0xe8/0x160
>> [   13.420610]  device_driver_attach+0xa1/0xb0
>> [   13.420614]  __driver_attach+0x8f/0x150
>> [   13.420618]  ? device_driver_attach+0xb0/0xb0
>> [   13.420621]  ? device_driver_attach+0xb0/0xb0
>> [   13.420624]  bus_for_each_dev+0x78/0xc0
>> [   13.420628]  bus_add_driver+0x12b/0x1e0
>> [   13.420632]  driver_register+0x8b/0xe0
>> [   13.420636]  ? 0xffffffffc1413000
>> [   13.420639]  init_tis+0xa0/0x1000 [tpm_tis]
>> [   13.420646]  do_one_initcall+0x44/0x1d0
>> [   13.420652]  ? kmem_cache_alloc_trace+0x119/0x240
>> [   13.420657]  do_init_module+0x5c/0x260
>> [   13.420662]  __do_sys_finit_module+0xb1/0x110
>> [   13.420668]  do_syscall_64+0x40/0xb0
>> [   13.420673]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>> [   13.420678] RIP: 0033:0x7f15fe84e9b9
>> [   13.420681] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48
>> 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48>
>> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a7 54 0c 00 f7 d8 64 89 01 48
>> [   13.420685] RSP: 002b:00007fffc3aca668 EFLAGS: 00000246 ORIG_RAX:
>> 0000000000000139
>> [   13.420689] RAX: ffffffffffffffda RBX: 00005561627275b0 RCX:
>> 00007f15fe84e9b9
>> [   13.420692] RDX: 0000000000000000 RSI: 00007f15fe9d9e2d RDI:
>> 0000000000000012
>> [   13.420694] RBP: 0000000000020000 R08: 0000000000000000 R09:
>> 0000556161c2f330
>> [   13.420696] R10: 0000000000000012 R11: 0000000000000246 R12:
>> 00007f15fe9d9e2d
>> [   13.420698] R13: 0000000000000000 R14: 000055616271dab0 R15:
>> 00005561627275b0
>> [...]
>> [   14.185406] tpm tpm0: tpm_try_transmit: send(): error -62
>> [   14.185422] tpm_tis 00:06: 1.2 TPM (device-id 0x6871, rev-id 1)
>> [   15.021233] tpm tpm0: tpm_try_transmit: send(): error -62
>> [   24.381575] tpm tpm0: tpm_try_transmit: send(): error -62
>> [...]
>>
>> But now the /dev/tpm0 device appears (but doesn't seem to work)
> I'm sorry, I made a mistake: release_locality() call should be exactly
> right before tpm_chip_start(). The reason is that we access TPM_INT_ENABLE,
> i.e. locality is released too early.
>
> In summary, I think I would try this:
>
> 	tpm_chip_stop(chip);
>
> 	rc = tpm_chip_start(chip);
> 	if (rc)
> 		goto out_err;
> 	rc = tpm2_probe(chip);
> 	tpm_chip_stop(chip);
> 	if (rc)
> 		goto out_err;
>
> tpm_chip_stop() is makes more sense it takes care also of disabling
> clk_enable.
>
> I.e. TPM should be shut down right after intmask mangling...

Sorry to bring bad news but it's still not working :(

With the following change:

diff --git a/drivers/char/tpm/tpm_tis_core.c 
b/drivers/char/tpm/tpm_tis_core.c
index 69579efb247b..45ad813ce840 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -980,6 +980,8 @@ int tpm_tis_core_init(struct device *dev, struct 
tpm_tis_data *priv, int irq,
         intmask &= ~TPM_GLOBAL_INT_ENABLE;
         tpm_tis_write32(priv, TPM_INT_ENABLE(priv->locality), intmask);

+       tpm_chip_stop(chip);
+
         rc = tpm_chip_start(chip);
         if (rc)
                 goto out_err;

I get now a Oops

[   13.438251] BUG: unable to handle page fault for address: 
ffff9e8141157000
[   13.438257] #PF: supervisor write access in kernel mode
[   13.438259] #PF: error_code(0x0002) - not-present page
[   13.438261] PGD 100000067 P4D 100000067 PUD 0
[   13.438265] Oops: 0002 [#1] SMP PTI
[   13.438268] CPU: 7 PID: 469 Comm: systemd-udevd Tainted: G          I 
E     5.13.0-rc6+ #8
[   13.438271] Hardware name: System manufacturer System Product 
Name/P6T DELUXE V2, BIOS 0406    04/24/2009
[   13.438273] RIP: 0010:iowrite8+0x9/0x50
[   13.438282] Code: 48 c7 c2 e8 6a 10 98 48 89 04 24 e8 ac 5e 3f 00 0f 
0b 48 8b 04 24 48 83 c4 08 c3 66 0f 1f 44 00 00 48 81 fe ff ff 03 00 76 
04 <40> 88 3e c3 48 81 fe 00 00 01 00 76 07 0f b7 d6 89 f8 ee c3 8b 05
[   13.438286] RSP: 0018:ffff9e8040f23b10 EFLAGS: 00010292
[   13.438289] RAX: ffffffffc15440b0 RBX: ffff9e8040f23b48 RCX: 
ffff9e8040f23b47
[   13.438292] RDX: 0000000000000001 RSI: ffff9e8141157000 RDI: 
0000000000000020
[   13.438295] RBP: ffff9e8040f23b48 R08: ffff88f2108bf018 R09: 
ffff88f20104b290
[   13.438297] R10: 0000000000000002 R11: 0000000000000004 R12: 
ffff88f2108bf018
[   13.438300] R13: 00000000fffff000 R14: ffff88f20104b000 R15: 
00000000ffffffff
[   13.438303] FS:  00007fafaab758c0(0000) GS:ffff88f5adbc0000(0000) 
knlGS:0000000000000000
[   13.438307] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.438310] CR2: ffff9e8141157000 CR3: 00000001065ca000 CR4: 
00000000000006e0
[   13.438313] Call Trace:
[   13.438318]  tpm_tcg_write_bytes+0x33/0x50 [tpm_tis]
[   13.438326]  release_locality+0x3c/0x60 [tpm_tis_core]
[   13.438331]  tpm_relinquish_locality+0x24/0x40 [tpm]
[   13.438342]  tpm_chip_stop+0x26/0x50 [tpm]
[   13.438351]  tpm_tis_core_init+0x1c2/0x2b2 [tpm_tis_core]
[   13.438357]  ? tpm_tis_init.part.0+0x130/0x130 [tpm_tis]
[   13.438363]  tpm_tis_pnp_init+0xe1/0x110 [tpm_tis]
[   13.438370]  pnp_device_probe+0xaf/0x140
[   13.438377]  really_probe+0xf2/0x460
[   13.438384]  driver_probe_device+0xe8/0x160
[   13.438388]  device_driver_attach+0xa1/0xb0
[   13.438393]  __driver_attach+0x8f/0x150
[   13.438397]  ? device_driver_attach+0xb0/0xb0
[   13.438402]  ? device_driver_attach+0xb0/0xb0
[   13.438405]  bus_for_each_dev+0x78/0xc0
[   13.438410]  bus_add_driver+0x12b/0x1e0
[   13.438415]  driver_register+0x8b/0xe0
[   13.438419]  ? 0xffffffffc1549000
[   13.438422]  init_tis+0xa0/0x1000 [tpm_tis]
[   13.438430]  do_one_initcall+0x44/0x1d0
[   13.438437]  ? kmem_cache_alloc_trace+0x119/0x240
[   13.438444]  do_init_module+0x5c/0x260
[   13.438450]  __do_sys_finit_module+0xb1/0x110
[   13.438456]  do_syscall_64+0x40/0xb0
[   13.438462]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   13.438467] RIP: 0033:0x7fafab02e9b9
[   13.438471] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a7 54 0c 00 f7 d8 64 89 01 48
[   13.438475] RSP: 002b:00007ffe03c50528 EFLAGS: 00000246 ORIG_RAX: 
0000000000000139
[   13.438480] RAX: ffffffffffffffda RBX: 00005596198bfc00 RCX: 
00007fafab02e9b9
[   13.438483] RDX: 0000000000000000 RSI: 00007fafab1b9e2d RDI: 
0000000000000012
[   13.438486] RBP: 0000000000020000 R08: 0000000000000000 R09: 
00005596198baaa0
[   13.438489] R10: 0000000000000012 R11: 0000000000000246 R12: 
00007fafab1b9e2d
[   13.438492] R13: 0000000000000000 R14: 00005596198bab20 R15: 
00005596198bfc00
[   13.438497] Modules linked in: tpm_tis(E+) tpm_tis_core(E) tpm(E) 
asus_atk0110(E) rng_core(E) fjes(E-) evdev(E) acpi_cpufreq(E-) loop(E+) 
firewire_sbp2(E) msr(E) parport_pc(E) ppdev(E) lp(E) parport(E) fuse(E) 
configfs(E) sunrpc(E) ip_tables(E) x_tables(E) autofs4(E) ext4(E) 
crc16(E) mbcache(E) jbd2(E) btrfs(E) blake2b_generic(E) zstd_compress(E) 
efivars(E) raid10(E) raid456(E) async_raid6_recov(E) async_memcpy(E) 
async_pq(E) async_xor(E) async_tx(E) xor(E) raid6_pq(E) libcrc32c(E) 
crc32c_generic(E) raid1(E) raid0(E) multipath(E) linear(E) md_mod(E) 
dm_mod(E) sr_mod(E) sd_mod(E) cdrom(E) t10_pi(E) hid_generic(E) 
usbhid(E) hid(E) amdgpu(E) gpu_sched(E) i2c_algo_bit(E) 
drm_ttm_helper(E) ttm(E) ahci(E) libahci(E) drm_kms_helper(E) 
i2c_i801(E) firewire_ohci(E) ehci_pci(E) uhci_hcd(E) libata(E) 
firewire_core(E) cec(E) crc32c_intel(E) mxm_wmi(E) psmouse(E) 
ehci_hcd(E) crc_itu_t(E) scsi_mod(E) i2c_smbus(E) lpc_ich(E) sky2(E) 
usbcore(E) drm(E) mfd_core(E) wmi(E) button(E)
[   13.438584] CR2: ffff9e8141157000
[   13.438587] ---[ end trace 25e12430fd1718f9 ]---
[   13.438589] RIP: 0010:iowrite8+0x9/0x50
[   13.438594] Code: 48 c7 c2 e8 6a 10 98 48 89 04 24 e8 ac 5e 3f 00 0f 
0b 48 8b 04 24 48 83 c4 08 c3 66 0f 1f 44 00 00 48 81 fe ff ff 03 00 76 
04 <40> 88 3e c3 48 81 fe 00 00 01 00 76 07 0f b7 d6 89 f8 ee c3 8b 05
[   13.438597] RSP: 0018:ffff9e8040f23b10 EFLAGS: 00010292
[   13.438601] RAX: ffffffffc15440b0 RBX: ffff9e8040f23b48 RCX: 
ffff9e8040f23b47
[   13.438604] RDX: 0000000000000001 RSI: ffff9e8141157000 RDI: 
0000000000000020
[   13.438606] RBP: ffff9e8040f23b48 R08: ffff88f2108bf018 R09: 
ffff88f20104b290
[   13.438609] R10: 0000000000000002 R11: 0000000000000004 R12: 
ffff88f2108bf018
[   13.438612] R13: 00000000fffff000 R14: ffff88f20104b000 R15: 
00000000ffffffff
[   13.438615] FS:  00007fafaab758c0(0000) GS:ffff88f5adbc0000(0000) 
knlGS:0000000000000000
[   13.438619] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.438622] CR2: ffff9e8141157000 CR3: 00000001065ca000 CR4: 
00000000000006e0

