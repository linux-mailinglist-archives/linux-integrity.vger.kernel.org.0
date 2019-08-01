Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7424D7DE88
	for <lists+linux-integrity@lfdr.de>; Thu,  1 Aug 2019 17:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfHAPNS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 1 Aug 2019 11:13:18 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46655 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727853AbfHAPNS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 1 Aug 2019 11:13:18 -0400
Received: by mail-qt1-f195.google.com with SMTP id h21so70523232qtn.13
        for <linux-integrity@vger.kernel.org>; Thu, 01 Aug 2019 08:13:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:reply-to
         :mime-version:content-disposition:user-agent;
        bh=hzhbmaeDfHufjurciCEu3j2x06Ef6VSSHCUhyfNpaUc=;
        b=ICekEMMgaxpFC4HTG48+tcJE6QpGBLmTikofI+SUuXnYla8U4Izxdvz+ZFiJna3CQN
         /mQu5K43r6kg0OZJpnVpALaknRRbpAfIhpxxnwz22h8uD+/9zAvOxVm2gM1c5/2apwi1
         OTMP52hZD4hxH2ijvZhKM1rBGaDvXTnDhfhwpn4VFgSkNUYeyhKwVsChqh+ohxAjAWNZ
         eyt1T3ZPP6ZX03B4AkAKlw23tSKcDAPQVNtv3uMOdrNJAuY4JdwiyWovWsGSJ1AtteJB
         Yc3O3gIJY8Bc3eesIF313b6ze250zIXFTF3vKQ91d99AKhDXyDh3Kc9BR3SRRt94jh4c
         fObw==
X-Gm-Message-State: APjAAAVhMqcjIvkHJC0a9NCUx3AuDnFD/MR441qARRkbRtu8/aleNiv8
        bzGw2UB5orl+m4Rw2FLyeoFFppXsvL0=
X-Google-Smtp-Source: APXvYqzuZSofgDEnbsw54yXGZMh9ejN+JO7Uffk9dmaFJq3LskhZRmZhp77dZjNWl4z1TI8a2IxFVA==
X-Received: by 2002:aed:3363:: with SMTP id u90mr90558735qtd.7.1564672397091;
        Thu, 01 Aug 2019 08:13:17 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id e7sm29463049qtp.91.2019.08.01.08.13.15
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 01 Aug 2019 08:13:16 -0700 (PDT)
Date:   Thu, 1 Aug 2019 08:13:14 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-integrity@vger.kernel.org
Subject: unable to handle page fault in 5.3-rc[12]
Message-ID: <20190801151314.f2tjk2b52mhxuc3x@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

I've had a couple reports emailed to me with a trace like the following
for 5.3-rc1 and 5.3-rc2. I'm just starting to dig into and look at recent
commits and mailing list, but is this already known?

It's been reported on a couple different Lenovo laptop models (T470s and X1 carbon I believe).

Full panic message:
[    0.774340] BUG: unable to handle page fault for address: ffffbc8fc00866ad
[    0.774788] #PF: supervisor read access in kernel mode
[    0.774788] #PF: error_code(0x0000) - not-present page
[    0.774788] PGD 107d36067 P4D 107d36067 PUD 107d37067 PMD 107d38067 PTE 0
[    0.774788] Oops: 0000 [#1] SMP PTI
[    0.774788] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.3.0-0.rc2.1.elrdy.x86_64 #1
[    0.774788] Hardware name: LENOVO 20HGS22D0W/20HGS22D0W, BIOS N1WET51W (1.30 ) 09/14/2018
[    0.774788] RIP: 0010:memcpy_erms+0x6/0x10
[    0.774788] Code: 90 90 90 90 eb 1e 0f 1f 00 48 89 f8 48 89 d1 48 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 <f3> a4 c3 0f 1f 80 00 00 00 00 48 89 f8 48 83 fa 20 72 7e 40 38 fe
[    0.774788] RSP: 0000:ffffbc8fc0073b30 EFLAGS: 00010286
[    0.774788] RAX: ffff9b1fc7c5b367 RBX: ffff9b1fc8390000 RCX: ffffffffffffe962
[    0.774788] RDX: ffffffffffffe962 RSI: ffffbc8fc00866ad RDI: ffff9b1fc7c5b367
[    0.774788] RBP: ffff9b1c10ca7018 R08: ffffbc8fc0085fff R09: 8000000000000063
[    0.774788] R10: 0000000000001000 R11: 000fffffffe00000 R12: 0000000000003367
[    0.774788] R13: ffff9b1fcc47c010 R14: ffffbc8fc0085000 R15: 0000000000000002
[    0.774788] FS:  0000000000000000(0000) GS:ffff9b1fce200000(0000) knlGS:0000000000000000
[    0.774788] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.774788] CR2: ffffbc8fc00866ad CR3: 000000029f60a001 CR4: 00000000003606f0
[    0.774788] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.774788] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.774788] Call Trace:
[    0.774788]  tpm_read_log_efi+0x156/0x1a0
[    0.774788]  tpm_bios_log_setup+0xc8/0x190
[    0.774788]  tpm_chip_register+0x50/0x1c0
[    0.774788]  tpm_tis_core_init.cold.9+0x28c/0x466
[    0.774788]  tpm_tis_plat_probe+0xcc/0xea
[    0.774788]  platform_drv_probe+0x35/0x80
[    0.774788]  really_probe+0xef/0x390
[    0.774788]  driver_probe_device+0xb4/0x100
[    0.774788]  device_driver_attach+0x4f/0x60
[    0.774788]  __driver_attach+0x86/0x140
[    0.774788]  ? device_driver_attach+0x60/0x60
[    0.774788]  bus_for_each_dev+0x76/0xc0
[    0.774788]  ? klist_add_tail+0x3b/0x70
[    0.774788]  bus_add_driver+0x14a/0x1e0
[    0.774788]  ? tpm_init+0xea/0xea
[    0.774788]  ? do_early_param+0x8e/0x8e
[    0.774788]  driver_register+0x6b/0xb0
[    0.774788]  ? tpm_init+0xea/0xea
[    0.774788]  init_tis+0x86/0xd8
[    0.774788]  ? do_early_param+0x8e/0x8e
[    0.774788]  ? driver_register+0x94/0xb0
[    0.774788]  do_one_initcall+0x46/0x1e4
[    0.774788]  ? do_early_param+0x8e/0x8e
[    0.774788]  kernel_init_freeable+0x199/0x242
[    0.774788]  ? rest_init+0xaa/0xaa
[    0.774788]  kernel_init+0xa/0x106
[    0.774788]  ret_from_fork+0x35/0x40
[    0.774788] Modules linked in:
[    0.774788] CR2: ffffbc8fc00866ad
[    0.774788] ---[ end trace 42930799f8d6eaea ]---
[    0.774788] RIP: 0010:memcpy_erms+0x6/0x10
[    0.774788] Code: 90 90 90 90 eb 1e 0f 1f 00 48 89 f8 48 89 d1 48 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 89 d1 <f3> a4 c3 0f 1f 80 00 00 00 00 48 89 f8 48 83 fa 20 72 7e 40 38 fe
[    0.774788] RSP: 0000:ffffbc8fc0073b30 EFLAGS: 00010286
[    0.774788] RAX: ffff9b1fc7c5b367 RBX: ffff9b1fc8390000 RCX: ffffffffffffe962
[    0.774788] RDX: ffffffffffffe962 RSI: ffffbc8fc00866ad RDI: ffff9b1fc7c5b367
[    0.774788] RBP: ffff9b1c10ca7018 R08: ffffbc8fc0085fff R09: 8000000000000063
[    0.774788] R10: 0000000000001000 R11: 000fffffffe00000 R12: 0000000000003367
[    0.774788] R13: ffff9b1fcc47c010 R14: ffffbc8fc0085000 R15: 0000000000000002
[    0.774788] FS:  0000000000000000(0000) GS:ffff9b1fce200000(0000) knlGS:0000000000000000
[    0.774788] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.774788] CR2: ffffbc8fc00866ad CR3: 000000029f60a001 CR4: 00000000003606f0
[    0.774788] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    0.774788] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    0.774788] Kernel panic - not syncing: Fatal exception
[    0.774788] Kernel Offset: 0x1d000000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[    0.774788] ---[ end Kernel panic - not syncing: Fatal exception ]---
