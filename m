Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDDDE3A2DA2
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Jun 2021 16:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbhFJOCa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Jun 2021 10:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbhFJOCa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Jun 2021 10:02:30 -0400
Received: from ithil.bigon.be (ithil.bigon.be [IPv6:2001:bc8:25f1:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689F6C061574
        for <linux-integrity@vger.kernel.org>; Thu, 10 Jun 2021 07:00:32 -0700 (PDT)
Received: from localhost (localhost [IPv6:::1])
        by ithil.bigon.be (Postfix) with ESMTP id B54E01FD2E;
        Thu, 10 Jun 2021 16:00:28 +0200 (CEST)
Received: from ithil.bigon.be ([IPv6:::1])
        by localhost (ithil.bigon.be [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id tqqOoOKVLgfy; Thu, 10 Jun 2021 16:00:28 +0200 (CEST)
Received: from [IPv6:2a02:a03f:65b8:4300:de23:9854:338b:84b3] (unknown [IPv6:2a02:a03f:65b8:4300:de23:9854:338b:84b3])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bigon@bigon.be)
        by ithil.bigon.be (Postfix) with ESMTPSA;
        Thu, 10 Jun 2021 16:00:28 +0200 (CEST)
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
References: <YCvv9wvj4jUIKpa7@kernel.org> <YCvyS6eVjZCKMAyJ@kernel.org>
 <YCv0KFIdtmG8F1kT@kernel.org>
 <d5fd8a6b-5eb9-0b50-d66c-e9f4cc84b215@debian.org>
 <YC2YyO7mJ7E73Voy@kernel.org>
 <ed73c137-373d-9767-25e6-309534652354@debian.org>
 <20210603052857.44zppwdfz4aror34@kernel.org>
 <07fb4429-d0cc-c471-1baa-a1a1eb2e8ae6@debian.org>
 <20210609124327.xkaf3bkcvyw2yxkn@kernel.org>
 <bfb9fdc7-668a-ff9c-1f5d-152df2ca106e@debian.org>
 <20210610122909.qaczp6nbish6wzbt@kernel.org>
From:   Laurent Bigonville <bigon@debian.org>
Message-ID: <48721227-6518-779e-c6f2-692c4d7b5c92@debian.org>
Date:   Thu, 10 Jun 2021 16:00:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210610122909.qaczp6nbish6wzbt@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: fr
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Le 10/06/21 à 14:29, Jarkko Sakkinen a écrit :
> On Thu, Jun 10, 2021 at 01:35:47PM +0200, Laurent Bigonville wrote:
>> # dmesg |grep -i tpm
>>
>> [   13.019986] tpm_tis 00:06: 1.2 TPM (device-id 0x6871, rev-id 1)
>> [   15.016198] tpm tpm0: tpm_try_transmit: send(): error -62
>> [   15.016208] tpm tpm0: A TPM error (-62) occurred attempting to determine
>> the timeouts
>> [   15.016239] tpm_tis: probe of 00:06 failed with error -62
>> [   15.053255] tpm_inf_pnp 00:06: Found TPM with ID IFX0102
> If possible, can you check what happens when you apply the attached patch.
> I'm not proposing it as a bug fix but it just simplifies the flow a lot,
> and might help to observe something.
>
With the patch on the top of HEAD of master and the patch from your 
branch, I'm getting this:

[   13.140548] tpm tpm0: invalid TPM_STS.x 0xa0, dumping stack for forensics
[   13.140617] CPU: 4 PID: 462 Comm: systemd-udevd Tainted: G          I 
E     5.13.0-rc5+ #7
[   13.140621] Hardware name: System manufacturer System Product 
Name/P6T DELUXE V2, BIOS 0406    04/24/2009
[   13.140623] Call Trace:
[   13.140628]  dump_stack+0x76/0x94
[   13.140637]  tpm_tis_status.cold+0x19/0x20 [tpm_tis_core]
[   13.140643]  tpm_transmit+0x15f/0x3d0 [tpm]
[   13.140657]  tpm_transmit_cmd+0x25/0x90 [tpm]
[   13.140666]  tpm2_probe+0xe2/0x140 [tpm]
[   13.140676]  tpm_tis_core_init+0x1d7/0x2ba [tpm_tis_core]
[   13.140681]  ? tpm_tis_init.part.0+0x130/0x130 [tpm_tis]
[   13.140688]  tpm_tis_pnp_init+0xe1/0x110 [tpm_tis]
[   13.140695]  pnp_device_probe+0xaf/0x140
[   13.140702]  really_probe+0xf2/0x460
[   13.140708]  driver_probe_device+0xe8/0x160
[   13.140712]  device_driver_attach+0xa1/0xb0
[   13.140716]  __driver_attach+0x8f/0x150
[   13.140720]  ? device_driver_attach+0xb0/0xb0
[   13.140723]  ? device_driver_attach+0xb0/0xb0
[   13.140726]  bus_for_each_dev+0x78/0xc0
[   13.140730]  bus_add_driver+0x12b/0x1e0
[   13.140734]  driver_register+0x8b/0xe0
[   13.140738]  ? 0xffffffffc11c4000
[   13.140741]  init_tis+0xa0/0x1000 [tpm_tis]
[   13.140748]  do_one_initcall+0x44/0x1d0
[   13.140754]  ? kmem_cache_alloc_trace+0x119/0x240
[   13.140759]  do_init_module+0x5c/0x260
[   13.140764]  __do_sys_finit_module+0xb1/0x110
[   13.140769]  do_syscall_64+0x40/0xb0
[   13.140775]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   13.140780] RIP: 0033:0x7f082957b9b9
[   13.140783] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d a7 54 0c 00 f7 d8 64 89 01 48
[   13.140786] RSP: 002b:00007fffd1b5a048 EFLAGS: 00000246 ORIG_RAX: 
0000000000000139
[   13.140791] RAX: ffffffffffffffda RBX: 000055bd4f3f6960 RCX: 
00007f082957b9b9
[   13.140793] RDX: 0000000000000000 RSI: 00007f0829706e2d RDI: 
0000000000000012
[   13.140796] RBP: 0000000000020000 R08: 0000000000000000 R09: 
000055bd4f238350
[   13.140798] R10: 0000000000000012 R11: 0000000000000246 R12: 
00007f0829706e2d
[   13.140800] R13: 0000000000000000 R14: 000055bd4f2381c0 R15: 
000055bd4f3f6960
[   13.141844] tpm_tis 00:06: 1.2 TPM (device-id 0x6871, rev-id 1)

# dmesg |grep -i tpm

[...]
[   15.140121] tpm tpm0: tpm_try_transmit: send(): error -62
[   15.141852] tpm tpm0: A TPM error (-62) occurred attempting to 
determine the timeouts
[   15.143596] tpm_tis: probe of 00:06 failed with error -62
[   15.185451] tpm_inf_pnp 00:06: Found TPM with ID IFX0102

