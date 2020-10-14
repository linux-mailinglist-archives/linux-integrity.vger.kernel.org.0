Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E801928E61C
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Oct 2020 20:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729709AbgJNSOU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Oct 2020 14:14:20 -0400
Received: from services.gouders.net ([141.101.32.176]:58519 "EHLO
        services.gouders.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbgJNSOT (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Oct 2020 14:14:19 -0400
X-Greylist: delayed 586 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Oct 2020 14:14:18 EDT
Received: from localhost (ltea-047-066-024-155.pools.arcor-ip.net [47.66.24.155])
        (authenticated bits=0)
        by services.gouders.net (8.14.8/8.14.8) with ESMTP id 09EHw0mN016575
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Oct 2020 19:58:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
        t=1602698281; bh=gPsnsrn9YDnCmifoFEdCiXxsmRo+UCWyR79aiM4dlA4=;
        h=From:To:Cc:Subject:Date;
        b=M4DquBsFTE0UzzpiYuCbtSqbEM3hGFgS76Omdi9sFRrLMvRRXkySmdkXNzzKNTKSX
         62qTwjvETpwXSK7OEDJFyhzpnS6vI46ry3fFBxNTo9mO8IOaKpXs3Fm/xHhypwIZKV
         wdYpa5vijUGYfrWwNOaOthx6wAjEkvgDtq843Ygs=
From:   Dirk Gouders <dirk@gouders.net>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: WARN_ONCE triggered: tpm_tis: Add a check for invalid status
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Date:   Wed, 14 Oct 2020 19:57:43 +0200
Message-ID: <ghsgagsnag.fsf@gouders.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On my laptop the check introduced with 55707d531af62b (tpm_tis: Add a
check for invalid status) triggered the warning (output below).

So, my laptop seems to be a candidate for testing.

Dirk

[    7.255467] ------------[ cut here ]------------
[    7.255468] TPM returned invalid status
[    7.255481] WARNING: CPU: 4 PID: 816 at drivers/char/tpm/tpm_tis_core.c:249 tpm_tis_status+0x5e/0x7f [tpm_tis_core]
[    7.255481] Modules linked in: nvram tpm_tis(+) tpm_tis_core tpm wmi pinctrl_amd
[    7.255485] CPU: 4 PID: 816 Comm: udevd Not tainted 5.9.0-x86_64+ #148
[    7.255486] Hardware name: LENOVO 20U50008GE/20U50008GE, BIOS R19ET26W (1.10 ) 06/22/2020
[    7.255488] RIP: 0010:tpm_tis_status+0x5e/0x7f [tpm_tis_core]
[    7.255489] Code: 44 8a 64 24 07 41 f6 c4 23 74 21 45 31 e4 80 3d 86 26 00 00 00 75 15 48 c7 c7 2a 71 01 a0 c6 05 76 26 00 00 01 e8 e1 17 0e e1 <0f> 0b 48 8b 44 24 08 65 48 33 04 25 28 00 00 00 74 05 e8 cd cd a2
[    7.255489] RSP: 0018:ffffc90000f7f8b8 EFLAGS: 00010286
[    7.255490] RAX: 0000000000000000 RBX: ffff8883f9117198 RCX: 000000000000038a
[    7.255490] RDX: 0000000000000001 RSI: 0000000000000002 RDI: ffffffff82dbd34c
[    7.255491] RBP: ffff8883f8aae000 R08: 0000000000000001 R09: 0000000000012d00
[    7.255491] R10: 0000000000000000 R11: 000000000000003c R12: 0000000000000000
[    7.255492] R13: 0000000000000000 R14: ffff8883f7c8a000 R15: 0000000000000016
[    7.255493] FS:  00007f350c98d780(0000) GS:ffff88840ed00000(0000) knlGS:0000000000000000
[    7.255493] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.255494] CR2: 00007f350c572ca8 CR3: 00000003f7000000 CR4: 0000000000350ee0
[    7.255494] Call Trace:
[    7.255497]  tpm_tis_send_data+0x28/0x187 [tpm_tis_core]
[    7.255498]  tpm_tis_send_main+0x14/0x84 [tpm_tis_core]
[    7.255500]  tpm_transmit+0xc5/0x2d7 [tpm]
[    7.255503]  tpm_transmit_cmd+0x23/0x8b [tpm]
[    7.255504]  tpm2_get_tpm_pt+0x71/0xb2 [tpm]
[    7.255505]  tpm_tis_probe_irq_single+0x134/0xbe2 [tpm_tis_core]
[    7.255506]  tpm_tis_core_init+0x3b3/0x47b [tpm_tis_core]
[    7.255508]  tpm_tis_plat_probe+0xa7/0xc5 [tpm_tis]
[    7.255512]  platform_drv_probe+0x2a/0x6b
[    7.255514]  really_probe+0x157/0x32a
[    7.255516]  driver_probe_device+0x63/0x97
[    7.255517]  device_driver_attach+0x37/0x50
[    7.255518]  __driver_attach+0x92/0x9a
[    7.255519]  ? device_driver_attach+0x50/0x50
[    7.255520]  bus_for_each_dev+0x70/0xa6
[    7.255521]  bus_add_driver+0x103/0x1b4
[    7.255522]  driver_register+0x99/0xd2
[    7.255523]  ? 0xffffffffa0023000
[    7.255524]  init_tis+0x88/0x1000 [tpm_tis]
[    7.255526]  ? consume_skb+0x9/0x20
[    7.255529]  ? ___cache_free+0x5c/0x153
[    7.255531]  ? _cond_resched+0x1b/0x1e
[    7.255532]  do_one_initcall+0x8a/0x195
[    7.255534]  ? kmem_cache_alloc_trace+0x80/0x8f
[    7.255536]  do_init_module+0x56/0x1e8
[    7.255537]  load_module+0x1c2c/0x2139
[    7.255538]  ? __do_sys_finit_module+0x8f/0xb6
[    7.255539]  __do_sys_finit_module+0x8f/0xb6
[    7.255541]  do_syscall_64+0x5d/0x6a
[    7.255543]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    7.255544] RIP: 0033:0x7f350cae8919
[    7.255545] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 47 05 0c 00 f7 d8 64 89 01 48
[    7.255545] RSP: 002b:00007ffe0e5ed928 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[    7.255546] RAX: ffffffffffffffda RBX: 000055a400c373e0 RCX: 00007f350cae8919
[    7.255546] RDX: 0000000000000000 RSI: 00007f350cbc1a7d RDI: 000000000000000b
[    7.255547] RBP: 0000000000020000 R08: 0000000000000000 R09: 00007ffe0e5edaa0
[    7.255547] R10: 000000000000000b R11: 0000000000000246 R12: 00007f350cbc1a7d
[    7.255548] R13: 0000000000000000 R14: 000055a400c30e10 R15: 000055a400c373e0
[    7.255548] ---[ end trace 883dd41f557db5d3 ]---
