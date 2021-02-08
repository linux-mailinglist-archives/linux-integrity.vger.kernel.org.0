Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A210313598
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Feb 2021 15:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbhBHOuR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 Feb 2021 09:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbhBHOtc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Feb 2021 09:49:32 -0500
Received: from ithil.bigon.be (ithil.bigon.be [IPv6:2001:bc8:25f1:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B71DC061786
        for <linux-integrity@vger.kernel.org>; Mon,  8 Feb 2021 06:48:53 -0800 (PST)
Received: from localhost (localhost [IPv6:::1])
        by ithil.bigon.be (Postfix) with ESMTP id 438FD1FD21;
        Mon,  8 Feb 2021 15:48:00 +0100 (CET)
Received: from ithil.bigon.be ([IPv6:::1])
        by localhost (ithil.bigon.be [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id QweSajy9oUBi; Mon,  8 Feb 2021 15:48:00 +0100 (CET)
Received: from [IPv6:2a02:a03f:65b8:4300:de23:9854:338b:84b3] (unknown [IPv6:2a02:a03f:65b8:4300:de23:9854:338b:84b3])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bigon@bigon.be)
        by ithil.bigon.be (Postfix) with ESMTPSA;
        Mon,  8 Feb 2021 15:48:00 +0100 (CET)
Subject: Re: TPM returned invalid status
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
References: <ee9c30b0-aff6-b1bd-2830-84b55a53b95e@debian.org>
 <8581ad17cb536c807d8ce781e955de07643aa1f4.camel@HansenPartnership.com>
From:   Laurent Bigonville <bigon@debian.org>
Message-ID: <22b860c1-c494-7a4d-73f3-7c9e90ab1ae8@debian.org>
Date:   Mon, 8 Feb 2021 15:47:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <8581ad17cb536c807d8ce781e955de07643aa1f4.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Le 8/02/21 à 04:33, James Bottomley a écrit :
> On Sat, 2021-02-06 at 00:31 +0100, Laurent Bigonville wrote:
>> Hello,
>>
>> I already posted that beginning of January in reply to "tpm_tis:
>> Clean
>> up locality release", but I didn't really got a reply
>>
>> With debian unstable (Linux fornost 5.10.0-3-amd64 #1 SMP Debian
>> 5.10.12-1 (2021-01-30) x86_64 GNU/Linux), I get the following error:
> Sorry, forgot to cc you.  We're iterating to this as the fix:
>
> https://lore.kernel.org/linux-integrity/20201001180925.13808-5-James.Bottomley@HansenPartnership.com/
>
> If you want to test it out.

I recompiled 5.11.0-rc7+ with the patch and I still get the same trace

[   13.453169] ------------[ cut here ]------------
[   13.453174] TPM returned invalid status
[   13.453193] WARNING: CPU: 0 PID: 447 at 
drivers/char/tpm/tpm_tis_core.c:249 tpm_tis_status+0x86/0xa0 [tpm_tis_core]
[   13.453202] Modules linked in: tpm_tis(E+) tpm_tis_core(E) tpm(E) 
asus_atk0110(E) rng_core(E) evdev(E) fjes(E-) acpi_cpufreq(E-) loop(E+) 
firewire_sbp2(E) msr(E) parport_pc(E) ppdev(E) lp(E) parport(E) fuse(E) 
configfs(E) sunrpc(E) ip_tables(E) x_tables(E) autofs4(E) ext4(E) 
crc16(E) mbcache(E) jbd2(E) btrfs(E) blake2b_generic(E) zstd_compress(E) 
raid10(E) raid456(E) async_raid6_recov(E) async_memcpy(E) async_pq(E) 
async_xor(E) async_tx(E) xor(E) raid6_pq(E) libcrc32c(E) 
crc32c_generic(E) raid1(E) raid0(E) multipath(E) linear(E) md_mod(E) 
dm_mod(E) sr_mod(E) sd_mod(E) cdrom(E) t10_pi(E) hid_generic(E) 
usbhid(E) hid(E) amdgpu(E) ahci(E) gpu_sched(E) i2c_algo_bit(E) 
libahci(E) drm_ttm_helper(E) ttm(E) firewire_ohci(E) libata(E) 
drm_kms_helper(E) crc32c_intel(E) cec(E) i2c_i801(E) uhci_hcd(E) 
ehci_pci(E) mxm_wmi(E) psmouse(E) ehci_hcd(E) firewire_core(E) 
scsi_mod(E) i2c_smbus(E) lpc_ich(E) crc_itu_t(E) sky2(E) drm(E) 
usbcore(E) mfd_core(E) wmi(E) button(E)
[   13.453285] CPU: 0 PID: 447 Comm: systemd-udevd Tainted: G          I 
E     5.11.0-rc7+ #2
[   13.453288] Hardware name: System manufacturer System Product 
Name/P6T DELUXE V2, BIOS 0406    04/24/2009
[   13.453291] RIP: 0010:tpm_tis_status+0x86/0xa0 [tpm_tis_core]
[   13.453297] Code: 00 75 30 48 83 c4 18 c3 31 c0 80 3d e3 48 00 00 00 
75 e0 48 c7 c7 74 53 28 c1 88 44 24 07 c6 05 cf 48 00 00 01 e8 12 25 db 
e4 <0f> 0b 0f b6 44 24 07 eb c0 e8 5c 9a de e4 66 66 2e 0f 1f 84 00 00
[   13.453300] RSP: 0000:ffffc07880d57aa0 EFLAGS: 00010286
[   13.453303] RAX: 0000000000000000 RBX: ffff9f43cbf2a000 RCX: 
ffff9f476da18bc8
[   13.453305] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: 
ffff9f476da18bc0
[   13.453307] RBP: 00000000ffff5d35 R08: 0000000000000000 R09: 
ffffc07880d578c0
[   13.453310] R10: ffffc07880d578b8 R11: ffffffffa6ac2588 R12: 
0000000000000016
[   13.453312] R13: ffff9f43ced90000 R14: 0000000000001000 R15: 
ffffc07880d57ada
[   13.453314] FS:  00007f47edbc28c0(0000) GS:ffff9f476da00000(0000) 
knlGS:0000000000000000
[   13.453317] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.453319] CR2: 00007f47ed30aa86 CR3: 000000010ed02000 CR4: 
00000000000006f0
[   13.453322] Call Trace:
[   13.453326]  tpm_transmit+0x15f/0x3d0 [tpm]
[   13.453337]  tpm_transmit_cmd+0x25/0x90 [tpm]
[   13.453345]  tpm2_probe+0xe2/0x140 [tpm]
[   13.453353]  tpm_tis_core_init+0x1d5/0x2b0 [tpm_tis_core]
[   13.453359]  ? tpm_tis_init.part.0+0x130/0x130 [tpm_tis]
[   13.453365]  tpm_tis_pnp_init+0xe1/0x110 [tpm_tis]
[   13.453371]  pnp_device_probe+0xaf/0x140
[   13.453378]  really_probe+0xf2/0x440
[   13.453384]  driver_probe_device+0xe1/0x150
[   13.453388]  device_driver_attach+0xa1/0xb0
[   13.453393]  __driver_attach+0x8a/0x150
[   13.453396]  ? device_driver_attach+0xb0/0xb0
[   13.453399]  ? device_driver_attach+0xb0/0xb0
[   13.453403]  bus_for_each_dev+0x78/0xc0
[   13.453407]  bus_add_driver+0x12b/0x1e0
[   13.453410]  driver_register+0x8b/0xe0
[   13.453414]  ? 0xffffffffc12b3000
[   13.453417]  init_tis+0xa0/0x1000 [tpm_tis]
[   13.453423]  do_one_initcall+0x44/0x1d0
[   13.453429]  ? do_init_module+0x23/0x260
[   13.453433]  ? kmem_cache_alloc_trace+0xf5/0x200
[   13.453439]  do_init_module+0x5c/0x260
[   13.453442]  __do_sys_finit_module+0xb1/0x110
[   13.453447]  do_syscall_64+0x33/0x80
[   13.453456]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   13.453461] RIP: 0033:0x7f47ee07b9b9
[   13.453464] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a7 54 0c 00 f7 d8 64 89 01 48
[   13.453467] RSP: 002b:00007ffecedfb208 EFLAGS: 00000246 ORIG_RAX: 
0000000000000139
[   13.453471] RAX: ffffffffffffffda RBX: 0000562823d17b60 RCX: 
00007f47ee07b9b9
[   13.453473] RDX: 0000000000000000 RSI: 00007f47ee206e2d RDI: 
0000000000000012
[   13.453475] RBP: 0000000000020000 R08: 0000000000000000 R09: 
0000562823b53fc0
[   13.453477] R10: 0000000000000012 R11: 0000000000000246 R12: 
00007f47ee206e2d
[   13.453479] R13: 0000000000000000 R14: 0000562823d0c9b0 R15: 
0000562823d17b60
[   13.453483] ---[ end trace af2bc5f390f96ecd ]---
[   13.459546] tpm_tis 00:06: 1.2 TPM (device-id 0x6871, rev-id 1)

But the chip seems to be working event if it's in lockdown again do to 
the dual boot with windows(?)

