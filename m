Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2C32E8607
	for <lists+linux-integrity@lfdr.de>; Sat,  2 Jan 2021 02:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbhABB2w convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 1 Jan 2021 20:28:52 -0500
Received: from ithil.bigon.be ([163.172.57.153]:57506 "EHLO ithil.bigon.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbhABB2w (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 1 Jan 2021 20:28:52 -0500
X-Greylist: delayed 637 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Jan 2021 20:28:50 EST
Received: from localhost (localhost [IPv6:::1])
        by ithil.bigon.be (Postfix) with ESMTP id 345DA1FDCB;
        Sat,  2 Jan 2021 02:17:27 +0100 (CET)
Received: from ithil.bigon.be ([IPv6:::1])
        by localhost (ithil.bigon.be [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id aOLncVdWlvQe; Sat,  2 Jan 2021 02:17:27 +0100 (CET)
Received: from [IPv6:2a02:a03f:65b8:4300:de23:9854:338b:84b3] (unknown [IPv6:2a02:a03f:65b8:4300:de23:9854:338b:84b3])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: bigon@bigon.be)
        by ithil.bigon.be (Postfix) with ESMTPSA;
        Sat,  2 Jan 2021 02:17:27 +0100 (CET)
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     linux-integrity@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
References: <20200929223216.22584-1-James.Bottomley@HansenPartnership.com>
 <20200929223216.22584-2-James.Bottomley@HansenPartnership.com>
 <87eemjgdy3.fsf@jsnitsel.users.ipa.redhat.com>
 <8ed5a80a9b2cfa37f0b8348906d292a7b1a1c02e.camel@HansenPartnership.com>
 <87h7reddat.fsf@jsnitsel.users.ipa.redhat.com>
 <635963b53711cdf9c7e1b6534eeb3f172969d1b2.camel@HansenPartnership.com>
From:   Laurent Bigonville <bigon@debian.org>
Subject: Re: [PATCH 1/4] tpm_tis: Clean up locality release
Message-ID: <c17afe38-1240-f6fc-1860-33fe96ab3047@debian.org>
Date:   Sat, 2 Jan 2021 02:17:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <635963b53711cdf9c7e1b6534eeb3f172969d1b2.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Le 1/10/20 à 17:58, James Bottomley a écrit :
Hello,
> On Wed, 2020-09-30 at 17:01 -0700, Jerry Snitselaar wrote:
>> James Bottomley @ 2020-09-30 16:03 MST:
>>
>>> On Wed, 2020-09-30 at 14:19 -0700, Jerry Snitselaar wrote:
>>>> James Bottomley @ 2020-09-29 15:32 MST:
>>>>
>>>>> The current release locality code seems to be based on the
>>>>> misunderstanding that the TPM interrupts when a locality is
>>>>> released: it doesn't, only when the locality is acquired.
>>>>>
>>>>> Furthermore, there seems to be no point in waiting for the
>>>>> locality to be released.  All it does is penalize the last TPM
>>>>> user.  However, if there's no next TPM user, this is a
>>>>> pointless wait and if there is a next TPM user, they'll pay the
>>>>> penalty waiting for the new locality (or possibly not if it's
>>>>> the same as the old locality).
>>>>>
>>>>> Fix the code by making release_locality as simple write to
>>>>> release with no waiting for completion.
>>> [...]
>>>> My recollection is that this was added because there were some
>>>> chips that took so long to release locality that a subsequent
>>>> request_locality call was seeing the locality as already active,
>>>> moving on, and then the locality was getting released out from
>>>> under the user.
>>> Well, I could simply dump the interrupt code, which can never work
>>> and we could always poll.
>>>
>>> However, there also appears to be a bug in our locality requesting
>>> code.  We write the request and wait for the grant, but a grant
>>> should be signalled by not only the ACCESS_ACTIVE_LOCALITY being 1
>>> but also the ACCESS_REQUEST_USE going to 0.  As you say, if we're
>>> slow to relinquish, ACCESS_ACTIVE_LOCALITY could already be 1 and
>>> we'd think we were granted, but ACCESS_REQUEST_USE should stay 1
>>> until the TPM actually grants the next request.
>>>
>>> If I code up a fix is there any chance you still have access to a
>>> problem TPM?  Mine all seem to grant and release localities fairly
>>> instantaneously.
>>>
>>> James
>> Sorry, I seemed to make a mess of it. I don't have access to a system
>> where it occurred, but cc'ing Laurent since he reported the problem
>> and might still have access to the system.
>>
>> I'd say fix up the check for locality request to look at
>> ACCESS_REQUEST_USE, and go with this patch to clean up locality
>> release. Hopefully Laurent still has access and can test. I do have a
>> laptop now where I should be able to test the other bits in your
>> patchset since this is one of the models that hit interrupt storm
>> problem when Stefan's 2 patches were originally applied. Lenovo
>> applied a fix to their bios, but this should still have the older one
>> version that has the issue. I'm on PTO this week, but I will try to
>> spend some time in the next couple days reproducing and then trying
>> your patches.
> Thanks.  I think the patch to fix to request access is very simple ...
> it's just to check the request bit has gone to zero, so I've attached
> it below.  It seems to work fine for me.
>
Sorry for the (really) late answer. I still do have access to the same 
system. Do you still need something from me?

But I do have two issues with the tpm chip on that system (probably not 
related to the discussion you were having here) so I'm not sure I will 
be able to easily test that everything is working:

1) The machine is in dualboot with windows 10 and for some reasons, 
every time I'm rebooting between linux and windows the chip is locking 
itself. AFAICS, when rebooting windows multiple time it's not happening. 
And the grace period is around 36h...

2) I just updated to 5.10 today (debian updated the kernel in unstable) 
and I get a WARNING when the tpm_tis module is being loaded:

kernel: ------------[ cut here ]------------
kernel: TPM returned invalid status
kernel: WARNING: CPU: 3 PID: 443 at drivers/char/tpm/tpm_tis_core.c:249 tpm_tis_status+0x86/0xa0 [tpm_tis_core]
kernel: Modules linked in: tpm_tis(+) tpm_tis_core tpm asus_atk0110 rng_core evdev loop(+) firewire_sbp2 msr parport_pc sunrpc ppdev lp parport fuse configfs ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 btrfs blake2b_generic raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq libcrc32c crc32c_generic raid1 raid0 >
kernel: CPU: 3 PID: 443 Comm: systemd-udevd Tainted: G          I       5.10.0-1-amd64 #1 Debian 5.10.4-1
kernel: Hardware name: System manufacturer System Product Name/P6T DELUXE V2, BIOS 0406    04/24/2009
kernel: RIP: 0010:tpm_tis_status+0x86/0xa0 [tpm_tis_core]
kernel: Code: 00 75 30 48 83 c4 18 c3 31 c0 80 3d e3 48 00 00 00 75 e0 48 c7 c7 4c 83 18 c1 88 44 24 07 c6 05 cf 48 00 00 01 e8 9a 57 ce fc <0f> 0b 0f b6 44 24 07 eb c0 e8 bc ca d1 fc 66 66 2e 0f 1f 84 00 00
kernel: RSP: 0018:ffffb98b0076faa0 EFLAGS: 00010286
kernel: RAX: 0000000000000000 RBX: ffff8dc1892a1000 RCX: ffff8dc52dad8a08
kernel: RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff8dc52dad8a00
kernel: RBP: 00000000ffff5d8a R08: 0000000000000000 R09: ffffb98b0076f8c0
kernel: R10: ffffb98b0076f8b8 R11: ffffffffbe8cb268 R12: 0000000000000016
kernel: R13: ffff8dc183bec000 R14: 0000000000001000 R15: ffffb98b0076fada
kernel: FS:  00007f6916f658c0(0000) GS:ffff8dc52dac0000(0000) knlGS:0000000000000000
kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kernel: CR2: 00007f6915e1ee38 CR3: 00000001205ee000 CR4: 00000000000006e0
kernel: Call Trace:
kernel:  tpm_transmit+0x15f/0x3d0 [tpm]
kernel:  tpm_transmit_cmd+0x25/0x90 [tpm]
kernel:  tpm2_probe+0xe2/0x140 [tpm]
kernel:  tpm_tis_core_init+0x1d5/0x2b0 [tpm_tis_core]
kernel:  ? tpm_tis_init.part.0+0x130/0x130 [tpm_tis]
kernel:  tpm_tis_pnp_init+0xe1/0x110 [tpm_tis]
kernel:  pnp_device_probe+0xaf/0x140
kernel:  really_probe+0x205/0x460
kernel:  driver_probe_device+0xe1/0x150
kernel:  device_driver_attach+0xa1/0xb0
kernel:  __driver_attach+0x8a/0x150
kernel:  ? device_driver_attach+0xb0/0xb0
kernel:  ? device_driver_attach+0xb0/0xb0
kernel:  bus_for_each_dev+0x78/0xc0
kernel:  bus_add_driver+0x12b/0x1e0
kernel:  driver_register+0x8b/0xe0
kernel:  ? 0xffffffffc1193000
kernel:  init_tis+0xa0/0x1000 [tpm_tis]
kernel:  do_one_initcall+0x44/0x1d0
kernel:  ? do_init_module+0x23/0x250
kernel:  ? kmem_cache_alloc_trace+0xf5/0x200
kernel:  do_init_module+0x5c/0x250
kernel:  __do_sys_finit_module+0xb1/0x110
kernel:  do_syscall_64+0x33/0x80
kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
kernel: RIP: 0033:0x7f691741f959
kernel: Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 07 55 0c 00 f7 d8 64 89 01 48
kernel: RSP: 002b:00007ffe0c62a958 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
kernel: RAX: ffffffffffffffda RBX: 00005630aad85910 RCX: 00007f691741f959
kernel: RDX: 0000000000000000 RSI: 00007f69175aae4d RDI: 0000000000000012
kernel: RBP: 0000000000020000 R08: 0000000000000000 R09: 00005630aad71d88
kernel: R10: 0000000000000012 R11: 0000000000000246 R12: 00007f69175aae4d
kernel: R13: 0000000000000000 R14: 00005630aad864f0 R15: 00005630aad85910
kernel: ---[ end trace 3dd14c12be7cbb7c ]---
kernel: tpm_tis 00:06: 1.2 TPM (device-id 0x6871, rev-id 1)



