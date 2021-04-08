Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66421357EBB
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Apr 2021 11:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbhDHJJj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Apr 2021 05:09:39 -0400
Received: from yes.iam.tj ([109.74.197.121]:48826 "EHLO iam.tj"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229600AbhDHJJi (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Apr 2021 05:09:38 -0400
X-Greylist: delayed 375 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Apr 2021 05:09:38 EDT
Received: from [IPv6:2a02:8010:4007::e86f:38d4:3289] (unknown [IPv6:2a02:8010:4007::e86f:38d4:3289])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by iam.tj (Postfix) with ESMTPSA id AAEE03409B;
        Thu,  8 Apr 2021 10:03:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=elloe.vision; s=2019;
        t=1617872588; bh=ynhyAMuT8061fPkCM3VIGYeAw97cfBop3C0LGEbHiyo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EBH3ivFfvp0JEiHkLYtkI4YmRMxW0vEoJhF5xn08dBtjLfYZ5w50pOgYA+8JhMXGW
         rNzrWAAdax9rNT47wwajy36USIdYbqoCm/TYcee7m+iQhbf5QwyRTTgl8yD/SSb35g
         4YUlhYouPzuDSofHSH1z3Z7R2/osEfDX3UqiODG/6cuczluYLNwYdcodQsF9TBNEd4
         RAwZ8q7OlYr1d9mvjxft6iCf4BCLWPGHXPv6YSUqnBQ3XWLhx6SJ6zTYUAhitrvVJx
         /yr2CzOeMCHyUQx4ckbT/6ekqQmnipfwcTPQJe4G4TYdt53Hd7E7kcbVvuCx+P0Be6
         IDGiZCmgA7cig==
Subject: Re: Bug: TPM returned invalid status
To:     Kees Cook <keescook@chromium.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org, jsnitsel@redhat.com,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
References: <374e918c-f167-9308-2bea-ae6bc6a3d2e3@elloe.vision>
 <YBGpranyEwXaqAUg@kernel.org> <YBGqWp5FqKQJK1is@kernel.org>
 <b1e71d07546ccce7957ead9cc80303734251f6c9.camel@HansenPartnership.com>
 <202103291901.F15EA83FB6@keescook>
From:   "Tj (Elloe Linux)" <ml.linux@elloe.vision>
Organization: Elloe CIC
Message-ID: <5e48c9ad-9e53-c079-83d1-7fea50412142@elloe.vision>
Date:   Thu, 8 Apr 2021 10:03:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202103291901.F15EA83FB6@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 30/03/2021 03:04, Kees Cook wrote:
> 
> Does this series solve the issue too?
> 
> https://lore.kernel.org/linux-integrity/1613955394-13152-1-git-send-email-LinoSanfilippo@gmx.de/
> 
> (I haven't had a chance to test either series with my TPM, but I see the
> same "TPM returned invalid status" errors recently.)
> 

Unfortunately no. I tested it immediately but forgot to let you know.


kernel: Linux version 5.12.0-rc5tpm-fix+ (tj@elloe000) (gcc (Ubuntu
9.3.0-17ubuntu1~20.04) 9.3.0, GNU ld (GNU Binutils for Ubuntu) 2.34) #29
SMP PREEMPT Tue Mar 30 09:05:15 BST 2021
...
kernel: tpm_tis NTC0702:00: 2.0 TPM (device-id 0xFC, rev-id 1)
kernel: ------------[ cut here ]------------
kernel: TPM returned invalid status
kernel: WARNING: CPU: 6 PID: 1 at drivers/char/tpm/tpm_tis_core.c:205
tpm_tis_status+0x82/0x90
kernel: Modules linked in:
kernel: CPU: 6 PID: 1 Comm: swapper/0 Not tainted 5.12.0-rc5tpm-fix+ #29
kernel: Hardware name: LENOVO 20NECTO1WW/20NECTO1WW, BIOS R11ET32W (1.12
) 12/23/2019
kernel: RIP: 0010:tpm_tis_status+0x82/0x90
kernel: Code: 25 28 00 00 00 75 2b c9 c3 31 c0 80 3d d2 3c 3a 01 00 75
e4 48 c7 c7 9c 7c 63 98 88 45 ef c6 05 bf 3c 3a 01 01 e8 39 58 42 00
<0f> 0b 0f b6 45 ef eb c6 e8 61 19 48 00 90 0f 1f 44 00 00 55 48 89
kernel: RSP: 0018:ffff995440067900 EFLAGS: 00010286
kernel: RAX: 0000000000000000 RBX: ffff8c84ca282000 RCX: c0000000ffffdfff
kernel: RDX: ffff9954400676d0 RSI: 00000000ffffdfff RDI: ffffffff98e9f38c
kernel: RBP: ffff995440067918 R08: 0000000000000000 R09: ffff9954400676c8
kernel: R10: 0000000000000001 R11: 0000000000000001 R12: ffff8c84ca282000
kernel: R13: ffff8c84c1418918 R14: ffff8c84c0fba000 R15: 0000000000000016
kernel: FS:  0000000000000000(0000) GS:ffff8c8b60b80000(0000)
knlGS:0000000000000000
kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kernel: CR2: 0000000000000000 CR3: 0000000559610000 CR4: 00000000003506e0
kernel: Call Trace:
kernel:  tpm_tis_send_data+0x41/0x240
kernel:  tpm_tis_send+0x32/0xf0
kernel:  tpm_transmit+0xe4/0x3e0
kernel:  tpm_transmit_cmd+0x2a/0x90
kernel:  tpm2_get_tpm_pt+0xe9/0x150
kernel:  tpm_tis_probe_irq_single+0x18d/0x26d
kernel:  tpm_tis_core_init.cold+0x193/0x2bf
kernel:  tpm_tis_init.part.0+0xa0/0x140
kernel:  tpm_tis_plat_probe+0xd4/0x100
kernel:  platform_probe+0x45/0xa0
kernel:  really_probe+0xfb/0x420
kernel:  driver_probe_device+0xe9/0x160
kernel:  device_driver_attach+0x5d/0x70
kernel:  __driver_attach+0x8f/0x150
kernel:  ? device_driver_attach+0x70/0x70
kernel:  bus_for_each_dev+0x7e/0xc0
kernel:  driver_attach+0x1e/0x20
kernel:  bus_add_driver+0x152/0x1f0
kernel:  driver_register+0x74/0xd0
kernel:  ? tpm_init+0xf6/0xf6
kernel:  __platform_driver_register+0x1e/0x20
kernel:  init_tis+0x87/0xdd
kernel:  ? kobject_uevent+0xb/0x10
kernel:  ? driver_register+0xac/0xd0
kernel:  ? agp_intel_init+0x2f/0x2f
kernel:  ? __pci_register_driver+0x54/0x60
kernel:  ? tpm_init+0xf6/0xf6
kernel:  do_one_initcall+0x48/0x210
kernel:  kernel_init_freeable+0x200/0x25e
kernel:  ? rest_init+0xd0/0xd0
kernel:  kernel_init+0xe/0x110
kernel:  ret_from_fork+0x22/0x30
kernel: ---[ end trace 45e4a376e6a7bd22 ]---

