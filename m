Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA73302328
	for <lists+linux-integrity@lfdr.de>; Mon, 25 Jan 2021 10:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbhAYJPz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 25 Jan 2021 04:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbhAYJPV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 Jan 2021 04:15:21 -0500
X-Greylist: delayed 735 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 25 Jan 2021 01:13:12 PST
Received: from iam.tj (unknown [IPv6:2a01:7e00:e000:151::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D002C0611C1
        for <linux-integrity@vger.kernel.org>; Mon, 25 Jan 2021 01:13:12 -0800 (PST)
Received: from [IPv6:2a02:8011:2007:0:8b3e:ff86:373f:70fe] (unknown [IPv6:2a02:8011:2007:0:8b3e:ff86:373f:70fe])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by iam.tj (Postfix) with ESMTPSA id AEF4A340F6
        for <linux-integrity@vger.kernel.org>; Mon, 25 Jan 2021 09:00:54 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=elloe.vision; s=2019;
        t=1611565254; bh=dnzSEHwvW9i2zMFwjapWXv0khnE6AUw8RWb7ge3zJdA=;
        h=To:From:Subject:Date:From;
        b=wLbHrYgmSK0jtwIYN5O0zTRAntQ4CsJxejuZBX3WZ8ArW+NO2LheXEsTEcLSb43Ih
         dAEmg0JIr5wH24fZ1wk1m7aVLQ1IuZGn8/imwT4VWC7yB0IcBkEBpv/OJ179vrJjQY
         CGrC2XllBBQFnlfrsOs60Vkaj0/OxBBwQHG8uC+jF8AhmRu/oD8MYuUav+JKLp+dXE
         vGFqrqAKFzGkOgrU6i4Hk7SAC9d37fT08zdWG82jGJziq6e3BWw5QnPJuvsbJjQNmU
         sAcBEh6hYHF828KTnSz3HYR5BLhU2sopS/PYTtPg2EzLKsl38yKhhFIfiihy5703rB
         g7g/Ej9/qjW4w==
To:     linux-integrity@vger.kernel.org
From:   "Tj (Elloe Linux)" <ml.linux@elloe.vision>
Subject: Bug: TPM returned invalid status
Organization: Elloe CIC
Message-ID: <374e918c-f167-9308-2bea-ae6bc6a3d2e3@elloe.vision>
Date:   Mon, 25 Jan 2021 09:00:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Seeing this on Lenovo E495's that have:

AMD Ryzen 7 3700U with Radeon Vega Mobile Gfx

Linux version 5.11.0-rc4+ (tj@elloe000) (gcc (Ubuntu
9.3.0-17ubuntu1~20.04) 9.3.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #12
SMP PREEMPT Sun Jan 24 11:28:01 GMT 2021
Command line: BOOT_IMAGE=/vmlinuz-5.11.0-rc4+
root=/dev/mapper/ELLOE000-rootfs ro acpi_osi=! "acpi_osi=Windows 2016"
systemd.unified_cgroup_hierarchy=1 nosplash
...
efi: EFI v2.70 by Lenovo

efi: ACPI=0xbddfd000 ACPI 2.0=0xbddfd014 TPMFinalLog=0xbdc2d000
SMBIOS=0xba4d7000 SMBIOS 3.0=0xba4ca000 MEMATTR=0xb5611018
ESRT=0xb9075000 RNG=0xba5c2598 TPMEventLog=0xb13ae
018
...
DMI: LENOVO 20NECTO1WW/20NECTO1WW, BIOS R11ET32W (1.12 ) 12/23/2019
...
tpm_tis NTC0702:00: 2.0 TPM (device-id 0xFC, rev-id 1)
------------[ cut here ]------------
TPM returned invalid status
WARNING: CPU: 3 PID: 1 at drivers/char/tpm/tpm_tis_core.c:249
tpm_tis_status+0x82/0x90
Modules linked in:
CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.11.0-rc4+ #12
Hardware name: LENOVO 20NECTO1WW/20NECTO1WW, BIOS R11ET32W (1.12 )
12/23/2019
RIP: 0010:tpm_tis_status+0x82/0x90
Code: 25 28 00 00 00 75 2b c9 c3 31 c0 80 3d af 14 1d 01 00 75 e4 48 c7
c7 dc 24 bf ad 88 45 ef c6 05 9c 14 1d 01 01 e8 65 83 3d 00 <0f> 0b 0f b6>
RSP: 0018:ffffaa40400678d0 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff8fb5c844f000 RCX: c0000000ffffdfff
RDX: ffffaa40400676a8 RSI: 00000000ffffdfff RDI: 0000000000000247
RBP: ffffaa40400678e8 R08: 0000000000000000 R09: ffffaa40400676a0
R10: 0000000000000001 R11: 0000000000000001 R12: ffff8fb5c844f000
R13: ffff8fb5c84bcd98 R14: ffff8fb5c84c5000 R15: 0000000000000016
FS:  0000000000000000(0000) GS:ffff8fbc5e8c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 0000000569e10000 CR4: 00000000003506e0
Call Trace:
 tpm_tis_send_data+0x41/0x240
 ? register_handler_proc+0xfa/0x120
 tpm_tis_send_main+0x32/0xf0
 tpm_tis_send+0x30/0xa0
 tpm_transmit+0xe4/0x3e0
 tpm_transmit_cmd+0x2a/0x90
 tpm2_get_tpm_pt+0xe9/0x150
 tpm_tis_probe_irq_single+0x16f/0x1e8
 ? ioread8+0xf/0x40
 tpm_tis_core_init.cold+0x2bf/0x455
 tpm_tis_init.part.0+0xa0/0x140
 tpm_tis_plat_probe+0xd4/0x100
 platform_probe+0x45/0xa0
 really_probe+0x1db/0x440
 driver_probe_device+0xe9/0x160
 device_driver_attach+0x5d/0x70
 __driver_attach+0x8f/0x150
 ? device_driver_attach+0x70/0x70
 bus_for_each_dev+0x7e/0xc0
driver_attach+0x1e/0x20
 bus_add_driver+0x152/0x1f0
 driver_register+0x74/0xd0
 ? tpm_init+0xf6/0xf6
 __platform_driver_register+0x1e/0x20
 init_tis+0x87/0xdd
 ? kobject_uevent+0xb/0x10
 ? driver_register+0xac/0xd0
 ? agp_intel_init+0x2f/0x2f
 ? __pci_register_driver+0x54/0x60
 ? tpm_init+0xf6/0xf6
 do_one_initcall+0x48/0x210
 ? kgdboc_earlycon_late_init+0x25/0x25
 ? do_one_initcall+0x6/0x210
 kernel_init_freeable+0x1ef/0x24d
 ? rest_init+0xd0/0xd0
 kernel_init+0xe/0x110
 ret_from_fork+0x22/0x30
---[ end trace 667721495775f7e0 ]---
battery: ACPI: Battery Slot [BAT0] (battery present)
irq 7: nobody cared (try booting with the "irqpoll" option)
CPU: 3 PID: 0 Comm: swapper/3 Tainted: G        W         5.11.0-rc4+ #12
Hardware name: LENOVO 20NECTO1WW/20NECTO1WW, BIOS R11ET32W (1.12 )
12/23/2019
Call Trace:
 <IRQ>
 dump_stack+0x74/0x92
 __report_bad_irq+0x3a/0xaf
 note_interrupt.cold+0xb/0x60
 handle_irq_event_percpu+0x73/0x80
 handle_irq_event+0x39/0x60
 handle_fasteoi_irq+0x9c/0x150
 asm_call_irq_on_stack+0x12/0x20
 </IRQ>
 common_interrupt+0xbb/0x140
 asm_common_interrupt+0x1e/0x40
RIP: 0010:tick_nohz_idle_enter+0x47/0x50
Code: 54 6c 53 48 83 bb b0 00 00 00 00 75 20 80 4b 4c 01 e8 2d 13 ff ff
80 4b 4c 04 48 89 43 78 e8 c0 21 f9 ff fb 66 0f 1f 44 00 00 <5b> 5d c3 0f>
RSP: 0018:ffffaa404017feb0 EFLAGS: 00000282
RAX: 000000006a4e43f7 RBX: ffff8fbc5e8df8c0 RCX: 000000006a4e428f
RDX: 000000006a5cd015 RSI: 000000006a4e428f RDI: fffffffffff1727a
RBP: ffffaa404017feb8 R08: 000000006a4e43f7 R09: ffff8fb5c025a840
R10: 000000000000036d R11: 0000000000000000 R12: 0000000000000091
R13: ffff8fb5c0924f00 R14: 0000000000000000 R15: 0000000000000000
 do_idle+0x40/0x260
 cpu_startup_entry+0x20/0x30
 start_secondary+0x126/0x160
 secondary_startup_64_no_verify+0xc2/0xcb
handlers:
[<00000000aa8f5d3e>] amd_gpio_irq_handler
Disabling IRQ #7
tpm tpm0: tpm_try_transmit: send(): error -62
tpm tpm0: [Firmware Bug]: TPM interrupt not working, polling instead


