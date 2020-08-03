Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48C4E23ADE2
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Aug 2020 22:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgHCUBH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Aug 2020 16:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbgHCUBG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Aug 2020 16:01:06 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B3BC06174A;
        Mon,  3 Aug 2020 13:01:06 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id j7so17957449oij.9;
        Mon, 03 Aug 2020 13:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zP4ncp9vj7JnY4khsRNCiCdbBc6bjRvSCdpaq4/BvzQ=;
        b=bLoL9bofRI+5WFj9dqLlDqaT7eDcOjGFY5D7e5CSZGKXpALwOyiUuDg0I0lbaxuZgM
         uHypdAhVhllZ6Avll+IiJa1MhHJ+GwwYphwqajC36MlBo0a/HI253MD5Osa8FblqOpuN
         oqzRRUBiJJ7xu8exJKnl6tTzCBeUrOBtof1UvPPpt/ZthEANNhiqCUKhfpigWB4XJYF6
         GDyBuPtZ2re4oUBBdusmmnckLg3SvAt6A+nRHETwFTMP+hZegJuwLA+ZgeoeL7t5Sajz
         2LFxKNHrGq3AWA+qbU1gBMaGtiOCvPIEVP3CN0TOpQAEKQYtDDflBSW60+3mTCCD+csd
         IWNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zP4ncp9vj7JnY4khsRNCiCdbBc6bjRvSCdpaq4/BvzQ=;
        b=lZBIggT0Itt+MfKTrqkv3sK9BPed6bCmflaaRGWLTSzi8VnmUm9TAVSw1UC7bCDnXI
         5OUWCnQ/VfsVz8+rgCFJO4HN3ZHAMAlNe0myHXJbxykGEcqo3jWy8+Zn5DnfRfFUc6Xz
         MRbEhuZKtwAlpX+QCcqW8jwxUrm/yhZu6hGHZPC2HasqLFRFu0cHUWLh9S2jcerXQAAT
         SPXwtSOWTL0yOY3kOBct7iLmkRLJv/BkfPdDz6R9eVbUjMqCI9TDndpVhdGVmeIG1Aar
         qCQY0RpkKDcG8rBaEcETjGXugVvtqmm+XXTJoVHbtM/azChlKY8c3AgqCfQ3OXSS6Ll/
         kY1A==
X-Gm-Message-State: AOAM533j3JCuPVDg+4zxcQxXFMBHvLHW6rqa5JwO9o/RQ+gyvxiIxCMX
        nC9Lj/o1Z9YsTgsDnxI75lYQDKBawmLuf+efKHI=
X-Google-Smtp-Source: ABdhPJz013rtE9N9hgX1DuHV1VPgJpyezytKEBb4MeeWb9GWT1rgdugaLTmP/96tLKReIozlrOS9nF/pFY13IxLHFXo=
X-Received: by 2002:a05:6808:1d9:: with SMTP id x25mr815802oic.92.1596484866057;
 Mon, 03 Aug 2020 13:01:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200730034724.3298-1-nramas@linux.microsoft.com>
 <20200730034724.3298-4-nramas@linux.microsoft.com> <dfd6f9c8-d62a-d278-9b0e-6b1f5ad03d3e@gmail.com>
 <6371efa9-5ae6-05ac-c357-3fbe1a5a93d5@linux.microsoft.com>
In-Reply-To: <6371efa9-5ae6-05ac-c357-3fbe1a5a93d5@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 3 Aug 2020 16:00:55 -0400
Message-ID: <CAEjxPJ789kmdDwy-6RaL7HuMFxKpQ9Hwxj9J-_-f62XDCNJUiA@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] LSM: Define SELinux function to measure state and policy
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>, sashal@kernel.org,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Aug 3, 2020 at 12:14 PM Lakshmi Ramasubramanian
<nramas@linux.microsoft.com> wrote:
>
> On 8/3/20 8:11 AM, Stephen Smalley wrote:
> >
> > Possibly I'm missing something but with these patches applied on top of
> > next-integrity, and the following lines added to /etc/ima/ima-policy:
> >
> > measure func=LSM_STATE template=ima-buf
> > measure func=LSM_POLICY
> >
> > I still don't get the selinux-state or selinux-policy-hash entries in
> > the ascii_runtime_measurements file.  No errors during loading of the
> > ima policy as far as I can see.
> >
>
> Could you please check if the following config is set?
> CONFIG_IMA_QUEUE_EARLY_BOOT_DATA=y

Yes, I have that set.

> Try changing /sys/fs/selinux/checkreqprot and check
> ascii_runtime_measurements file again?

No change.  Likewise for changing enforce or running load_policy again.

> Also, could you please check if
> /sys/kernel/security/integrity/ima/policy contains LSM_STATE and
> LSM_POLICY entries?

Yes, it does.  However, I noticed that if I reduce the policy to only
contain those entries and no others and reboot, then I get
measurements.  Whereas if I append them to an existing policy like the
one below, they seem to be ignored:
dont_measure fsmagic=0x9fa0
dont_measure fsmagic=0x62656572
dont_measure fsmagic=0x64626720
dont_measure fsmagic=0x1021994
dont_measure fsmagic=0x858458f6
dont_measure fsmagic=0x73636673
measure func=BPRM_CHECK
measure func=MMAP_CHECK mask=MAY_EXEC
measure func=MODULE_CHECK uid=0
measure func=LSM_STATE template=ima-buf
measure func=LSM_POLICY

Also, I noticed the following in my dmesg output:
[   68.870715] ------------[ cut here ]------------
[   68.870715] WARNING: CPU: 2 PID: 1 at mm/page_alloc.c:4826
__alloc_pages_nodemask+0x627/0x700
[   68.870715] Modules linked in: 8139too crct10dif_pclmul
crc32_pclmul crc32c_intel ghash_clmulni_intel qxl serio_raw
drm_ttm_helper ttm drm_kms_helper virtio_console cec drm 8139cp
ata_generic mii pata_acpi floppy qemu_fw_cfg fuse
[   68.870715] CPU: 2 PID: 1 Comm: systemd Not tainted 5.8.0-rc2+ #44
[   68.870715] RIP: 0010:__alloc_pages_nodemask+0x627/0x700
[   68.870715] Code: ff ff 75 6c 48 8b 85 48 ff ff ff 4c 89 c2 44 89
e6 44 89 ff 41 c6 45 d0 00 49 89 45 b8 e8 41 e2 ff ff 49 89 c6 e9 9d
fc ff ff <0f> 0b e9 d4 fd ff ff 0f 0b e9 bc fc ff ff 0f 0b e9 f9 fd ff
ff e8
[   68.870715] RSP: 0000:ffff8881e82a7a18 EFLAGS: 00010246
[   68.870715] RAX: ffffed103d054f48 RBX: 1ffff1103d054f48 RCX: 0000000000000000
[   68.870715] RDX: 0000000000000000 RSI: 000000000000000b RDI: 0000000000000000
[   68.870715] RBP: ffff8881e82a7ae8 R08: ffffffffaa3fe2d5 R09: 0000000000000001
[   68.870715] R10: fffffbfff5a88f0f R11: 0000000000000001 R12: 00000000007eef6a
[   68.870715] R13: 0000000000040cc0 R14: 000000000000000b R15: ffffffffadde766b
[   68.870715] FS:  00007fdeb168c600(0000) GS:ffff8881e9800000(0000)
knlGS:0000000000000000
[   68.870715] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   68.870715] CR2: 00007fdeb17dd1d6 CR3: 00000001cc2d2002 CR4: 00000000003606e0
[   68.870715] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   68.870715] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   68.870715] Call Trace:
[   68.870715]  ? sched_clock_cpu+0xf5/0x110
[   68.870715]  ? __alloc_pages_slowpath.constprop.0+0x17a0/0x17a0
[   68.870715]  ? match_held_lock+0x2e/0x240
[   68.870715]  ? policy_nodemask+0x1a/0xa0
[   68.870715]  ? policy_node+0x56/0x60
[   68.870715]  kmalloc_order+0x25/0xc0
[   68.870715]  kmalloc_order_trace+0x1d/0x140
[   68.870715]  kmemdup+0x1a/0x40
[   68.870715]  ima_queue_data+0x61/0x370
[   68.870715]  ima_measure_lsm_data+0x32/0x60
[   68.870715]  selinux_measure_state+0x2b8/0x2bd
[   68.870715]  ? selinux_event_name+0xe0/0xe0
[   68.870715]  ? rcu_is_watching+0x39/0x50
[   68.870715]  security_load_policy+0x44c/0x8e0
[   68.870715]  ? mark_lock+0xa6/0xbd0
[   68.870715]  ? security_change_sid+0x90/0x90
[   68.870715]  ? mark_held_locks+0x3e/0xa0
[   68.870715]  ? lockdep_hardirqs_on_prepare+0x100/0x260
[   68.870715]  ? asm_exc_page_fault+0x1e/0x30
[   68.870715]  ? lockdep_hardirqs_on+0xc5/0x1b0
[   68.870715]  ? asm_exc_page_fault+0x1e/0x30
[   68.870715]  ? copy_user_enhanced_fast_string+0xe/0x30
[   68.870715]  sel_write_load+0x157/0x260
[   68.870715]  vfs_write+0x135/0x290
[   68.870715]  ksys_write+0xb1/0x140
[   68.870715]  ? __ia32_sys_read+0x50/0x50
[   68.870715]  ? lockdep_hardirqs_on_prepare+0x100/0x260
[   68.870715]  ? do_syscall_64+0x12/0xb0
[   68.870715]  do_syscall_64+0x52/0xb0
[   68.870715]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   68.870715] RIP: 0033:0x7fdeb2539497
[   68.870715] Code: Bad RIP value.
[   68.870715] RSP: 002b:00007fff6352b308 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[   68.870715] RAX: ffffffffffffffda RBX: 0000000000000020 RCX: 00007fdeb2539497
[   68.870715] RDX: 00000000007eef6a RSI: 00007fdeb0de1000 RDI: 0000000000000004
[   68.870715] RBP: 0000000000000004 R08: 00007fdeb25d0040 R09: 00007fff6352b1a0
[   68.870715] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fdeb0de1000
[   68.870715] R13: 00000000007eef6a R14: 000000000000000f R15: 0000000000000003
[   68.870715] irq event stamp: 23486085
[   68.870715] hardirqs last  enabled at (23486085):
[<ffffffffaa419406>] _raw_spin_unlock_irqrestore+0x46/0x60
[   68.870715] hardirqs last disabled at (23486084):
[<ffffffffaa419443>] _raw_spin_lock_irqsave+0x23/0x90
[   68.870715] softirqs last  enabled at (23486074):
[<ffffffffaa8004f3>] __do_softirq+0x4f3/0x662
[   68.870715] softirqs last disabled at (23486067):
[<ffffffffaa601072>] asm_call_on_stack+0x12/0x20
[   68.870715] ---[ end trace fb02740ff6f4d0cd ]---
