Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00314311877
	for <lists+linux-integrity@lfdr.de>; Sat,  6 Feb 2021 03:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbhBFCiv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 5 Feb 2021 21:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhBFCf7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 5 Feb 2021 21:35:59 -0500
X-Greylist: delayed 400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 05 Feb 2021 15:38:50 PST
Received: from ithil.bigon.be (ithil.bigon.be [IPv6:2001:bc8:25f1:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64EBC08ED84
        for <linux-integrity@vger.kernel.org>; Fri,  5 Feb 2021 15:38:50 -0800 (PST)
Received: from localhost (localhost [IPv6:::1])
        by ithil.bigon.be (Postfix) with ESMTP id C660E1FCAE
        for <linux-integrity@vger.kernel.org>; Sat,  6 Feb 2021 00:31:24 +0100 (CET)
Received: from ithil.bigon.be ([IPv6:::1])
        by localhost (ithil.bigon.be [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 7fQ3D5rH_7og for <linux-integrity@vger.kernel.org>;
        Sat,  6 Feb 2021 00:31:24 +0100 (CET)
Received: from [IPv6:2a02:a03f:65b8:4300:de23:9854:338b:84b3] (unknown [IPv6:2a02:a03f:65b8:4300:de23:9854:338b:84b3])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bigon@bigon.be)
        by ithil.bigon.be (Postfix) with ESMTPSA
        for <linux-integrity@vger.kernel.org>; Sat,  6 Feb 2021 00:31:24 +0100 (CET)
To:     linux-integrity@vger.kernel.org
From:   Laurent Bigonville <bigon@debian.org>
Subject: TPM returned invalid status
Message-ID: <ee9c30b0-aff6-b1bd-2830-84b55a53b95e@debian.org>
Date:   Sat, 6 Feb 2021 00:31:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello,

I already posted that beginning of January in reply to "tpm_tis: Clean 
up locality release", but I didn't really got a reply

With debian unstable (Linux fornost 5.10.0-3-amd64 #1 SMP Debian 
5.10.12-1 (2021-01-30) x86_64 GNU/Linux), I get the following error:

[   13.733866] ------------[ cut here ]------------
[   13.733868] TPM returned invalid status
[   13.733889] WARNING: CPU: 3 PID: 444 at 
drivers/char/tpm/tpm_tis_core.c:249 tpm_tis_status+0x86/0xa0 [tpm_tis_core]
[   13.733890] Modules linked in: libiscsi joydev libaes 
scsi_transport_iscsi snd_timer snd soundcore i7core_edac pcc_cpufreq(-) 
i5500_temp tpm_tis(+) tpm_tis_core asus_atk0110 tpm evdev rng_core loop 
firewire_sbp2 msr parport_pc ppdev sunrpc lp parport fuse configfs 
ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 btrfs blake2b_generic 
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor 
async_tx xor raid6_pq libcrc32c crc32c_generic raid1 raid0 multipath 
linear md_mod dm_mod sd_mod t10_pi crc_t10dif crct10dif_generic sr_mod 
cdrom crct10dif_common hid_generic usbhid hid amdgpu ahci libahci 
gpu_sched i2c_algo_bit libata ttm drm_kms_helper psmouse scsi_mod 
mxm_wmi crc32c_intel uhci_hcd i2c_i801 cec firewire_ohci i2c_smbus 
ehci_pci ehci_hcd firewire_core drm lpc_ich crc_itu_t usbcore sky2 
usb_common wmi button
[   13.733954] CPU: 3 PID: 444 Comm: systemd-udevd Tainted: G          
I       5.10.0-3-amd64 #1 Debian 5.10.12-1
[   13.733956] Hardware name: System manufacturer System Product 
Name/P6T DELUXE V2, BIOS 0406    04/24/2009
[   13.733959] RIP: 0010:tpm_tis_status+0x86/0xa0 [tpm_tis_core]
[   13.733962] Code: 00 75 30 48 83 c4 18 c3 31 c0 80 3d e3 48 00 00 00 
75 e0 48 c7 c7 4c f3 20 c1 88 44 24 07 c6 05 cf 48 00 00 01 e8 9a 47 c6 
f1 <0f> 0b 0f b6 44 24 07 eb c0 e8 3c be c9 f1 66 66 2e 0f 1f 84 00 00
[   13.733963] RSP: 0018:ffffbf23808fbaa0 EFLAGS: 00010286
[   13.733965] RAX: 0000000000000000 RBX: ffff979283e35000 RCX: 
ffff97962dad8a08
[   13.733967] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: 
ffff97962dad8a00
[   13.733968] RBP: 00000000ffff5d8c R08: 0000000000000000 R09: 
ffffbf23808fb8c0
[   13.733970] R10: ffffbf23808fb8b8 R11: ffffffffb3ccb368 R12: 
0000000000000016
[   13.733971] R13: ffff9792c0128000 R14: 0000000000001000 R15: 
ffffbf23808fbada
[   13.733973] FS:  00007f06c63828c0(0000) GS:ffff97962dac0000(0000) 
knlGS:0000000000000000
[   13.733975] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   13.733976] CR2: 00007ffa0229121c CR3: 0000000110e60000 CR4: 
00000000000006e0
[   13.733978] Call Trace:
[   13.733987]  tpm_transmit+0x15f/0x3d0 [tpm]
[   13.733992]  tpm_transmit_cmd+0x25/0x90 [tpm]
[   13.733997]  tpm2_probe+0xe2/0x140 [tpm]
[   13.734000]  tpm_tis_core_init+0x1d5/0x2b0 [tpm_tis_core]
[   13.734006]  ? tpm_tis_init.part.0+0x130/0x130 [tpm_tis]
[   13.734008]  tpm_tis_pnp_init+0xe1/0x110 [tpm_tis]
[   13.734016]  pnp_device_probe+0xaf/0x140
[   13.734019]  really_probe+0xf2/0x440
[   13.734021]  driver_probe_device+0xe1/0x150
[   13.734024]  device_driver_attach+0xa1/0xb0
[   13.734026]  __driver_attach+0x8a/0x150
[   13.734027]  ? device_driver_attach+0xb0/0xb0
[   13.734028]  ? device_driver_attach+0xb0/0xb0
[   13.734030]  bus_for_each_dev+0x78/0xc0
[   13.734032]  bus_add_driver+0x12b/0x1e0
[   13.734034]  driver_register+0x8b/0xe0
[   13.734036]  ? 0xffffffffc121a000
[   13.734038]  init_tis+0xa0/0x1000 [tpm_tis]
[   13.734042]  do_one_initcall+0x44/0x1d0
[   13.734046]  ? do_init_module+0x23/0x260
[   13.734048]  ? kmem_cache_alloc_trace+0xf5/0x200
[   13.734050]  do_init_module+0x5c/0x260
[   13.734052]  __do_sys_finit_module+0xb1/0x110
[   13.734056]  do_syscall_64+0x33/0x80
[   13.734059]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   13.734061] RIP: 0033:0x7f06c683b9b9
[   13.734063] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a7 54 0c 00 f7 d8 64 89 01 48
[   13.734064] RSP: 002b:00007ffe3ac07978 EFLAGS: 00000246 ORIG_RAX: 
0000000000000139
[   13.734065] RAX: ffffffffffffffda RBX: 000055c0f90a7a10 RCX: 
00007f06c683b9b9
[   13.734066] RDX: 0000000000000000 RSI: 00007f06c69c6e2d RDI: 
0000000000000012
[   13.734067] RBP: 0000000000020000 R08: 0000000000000000 R09: 
000055c0f8edcdc0
[   13.734068] R10: 0000000000000012 R11: 0000000000000246 R12: 
00007f06c69c6e2d
[   13.734069] R13: 0000000000000000 R14: 000055c0f90a55f0 R15: 
000055c0f90a7a10
[   13.734071] ---[ end trace a34082fc50077847 ]---
[   13.740689] tpm_tis 00:06: 1.2 TPM (device-id 0x6871, rev-id 1)

This is still a TPM 1.2 device and it seems to work as I can seal and 
unseal data (tpm_sealdata and tpm_unsealdata)

An idea what's happening?

Kind regards,

Laurent Bigonville


