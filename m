Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 094B213AB90
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2020 14:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbgANN6z (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Jan 2020 08:58:55 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:39341 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbgANN6z (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Jan 2020 08:58:55 -0500
Received: by mail-qv1-f68.google.com with SMTP id y8so5669735qvk.6
        for <linux-integrity@vger.kernel.org>; Tue, 14 Jan 2020 05:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NT2rbeeehrCKFwNneqy898zk1HYluzR28psC4coKvKs=;
        b=coDPkEn8iYy2G8HxipCQ87y0FFRgeMOOY33IPLhskqBUIKXtZ910QjeAgem9tZ1Pkt
         27I0p2K2IK68ZzODRQKcVk6cqV208Qz7+mURw37hgB5fjEdrXQ/vUyxrGF2zaqtFtJrk
         3k/vWws+QwwqQWMrKSLBqWUO9RZGoOQGEQFQEoq/NJ3Svr7UOXsA8IYecAvbunWJr8LE
         CvRuIPABAZSCqwNUlRSjfxvHL4dhgf2URqiQ3QL05JAXwH9AhyP26mDXlvolbQUkqbHc
         PWCBgB4fnirJ9TgYAcYMgDP2GvbjDfKsndX+Glb1wSGXGRAGzVSZfxDckl8VkyOYb7O3
         F/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NT2rbeeehrCKFwNneqy898zk1HYluzR28psC4coKvKs=;
        b=N1InfQqLIwMkRpVuQHCUmvjHaJa5e53dzm8vx0v8jndxe5Nl2jxbS+SDCLVUu7x+f6
         Q/AbbPcZcXYuZ8+SAGVOr6xTgsnCc7JKi9FfUtoKlwIBuOiVLJKMusRhAkCNcerOjzSV
         ZMU5v+Msv2OJXztp4dNfuYL1YoKdxtm+9Fnkm1BdWVrmFKYL6FW+uZv1lZ2QToarxFKX
         HAVvgcMWqbdlpzd394ZyUkBbiS/ifCXF6Em+6qvomKKgV/LPllEc6Og7LBQJHIuD9RPw
         aEsXzntSBhjZZF+whukajIEHJ/1Ei9a7GcffyTJhTEX2tLNqky5MMSPtLigc5uwAxHg2
         dNfw==
X-Gm-Message-State: APjAAAXx95rc8nsCbNszYiMEqwHH6/7xY80cRkMMngPaztm9qEvjmKBJ
        Egzv1otMLPi6G7qmHBvOMM1md/13bfcAI68RuXHzDz8mVyI=
X-Google-Smtp-Source: APXvYqzc/kwdh8naDJDo6WCyilybAVJDZx3f0zFq9EEfK9uG0XaAJfEs9btfxCsM1gJsAs1KJgDfghGIN0Mlc1tCWuw=
X-Received: by 2002:a05:6214:1874:: with SMTP id eh20mr17117114qvb.122.1579010333769;
 Tue, 14 Jan 2020 05:58:53 -0800 (PST)
MIME-Version: 1.0
References: <000000000000486474059c19f4d7@google.com>
In-Reply-To: <000000000000486474059c19f4d7@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 14 Jan 2020 14:58:41 +0100
Message-ID: <CACT4Y+av-ipjsdtsXs4d55w=inNHJqho3s3XKfU0Jo7f98yi8w@mail.gmail.com>
Subject: Re: inconsistent lock state in ima_process_queued_keys
To:     syzbot <syzbot+a4a503d7f37292ae1664@syzkaller.appspotmail.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Cc:     Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 14, 2020 at 2:56 PM syzbot
<syzbot+a4a503d7f37292ae1664@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    1b851f98 Add linux-next specific files for 20200114
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=12bcbb25e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3e7d9cf7ebfa08ad
> dashboard link: https://syzkaller.appspot.com/bug?extid=a4a503d7f37292ae1664
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+a4a503d7f37292ae1664@syzkaller.appspotmail.com

+Lakshmi, you seem to have submitted a number of changes to this file recently.

This completely breaks linux-next testing for us, every kernel crashes
a few minutes after boot.

2020/01/14 14:45:00 vm-26: crash: inconsistent lock state in
ima_process_queued_keys
2020/01/14 14:45:00 vm-12: crash: inconsistent lock state in
ima_process_queued_keys
2020/01/14 14:45:01 vm-3: crash: inconsistent lock state in
ima_process_queued_keys
2020/01/14 14:45:02 vm-8: crash: inconsistent lock state in
ima_process_queued_keys
2020/01/14 14:45:03 vm-25: crash: inconsistent lock state in
ima_process_queued_keys
2020/01/14 14:45:04 vm-27: crash: inconsistent lock state in
ima_process_queued_keys
2020/01/14 14:45:04 VMs 0, executed 214279, cover 10140, crashes 5, repro 0
2020/01/14 14:45:05 vm-14: crash: inconsistent lock state in
ima_process_queued_keys
2020/01/14 14:45:05 vm-11: crash: inconsistent lock state in
ima_process_queued_keys
2020/01/14 14:45:06 vm-10: crash: inconsistent lock state in
ima_process_queued_keys
2020/01/14 14:45:07 vm-0: crash: inconsistent lock state in
ima_process_queued_keys
2020/01/14 14:45:08 vm-24: crash: inconsistent lock state in
ima_process_queued_keys
2020/01/14 14:45:09 vm-2: crash: inconsistent lock state in
ima_process_queued_keys
2020/01/14 14:45:10 vm-20: crash: inconsistent lock state in
ima_process_queued_keys
2020/01/14 14:45:11 vm-7: crash: inconsistent lock state in
ima_process_queued_keys
2020/01/14 14:45:12 vm-28: crash: inconsistent lock state in
ima_process_queued_keys
2020/01/14 14:45:12 vm-1: crash: inconsistent lock state in
ima_process_queued_keys
2020/01/14 14:45:13 vm-6: crash: inconsistent lock state in
ima_process_queued_keys
2020/01/14 14:45:14 vm-4: crash: inconsistent lock state in
ima_process_queued_keys
2020/01/14 14:45:14 VMs 0, executed 214279, cover 10140, crashes 17, repro 0
2020/01/14 14:45:15 vm-17: crash: inconsistent lock state in
ima_process_queued_keys
2020/01/14 14:45:16 vm-16: crash: inconsistent lock state in
ima_process_queued_keys
2020/01/14 14:45:16 vm-19: crash: inconsistent lock state in
ima_process_queued_keys
2020/01/14 14:45:17 vm-15: crash: inconsistent lock state in
ima_process_queued_keys
2020/01/14 14:45:18 vm-29: crash: inconsistent lock state in
ima_process_queued_keys
2020/01/14 14:45:19 vm-21: crash: inconsistent lock state in
ima_process_queued_keys
2020/01/14 14:45:20 vm-23: crash: inconsistent lock state in
ima_process_queued_keys
2020/01/14 14:45:20 vm-13: crash: inconsistent lock state in
ima_process_queued_keys
2020/01/14 14:45:21 vm-9: crash: inconsistent lock state in
ima_process_queued_keys
2020/01/14 14:45:22 vm-5: crash: inconsistent lock state in
ima_process_queued_keys
2020/01/14 14:45:23 vm-22: crash: inconsistent lock state in
ima_process_queued_keys
2020/01/14 14:45:24 VMs 0, executed 214279, cover 10140, crashes 28, repro 0
2020/01/14 14:45:24 vm-18: crash: inconsistent lock state in
ima_process_queued_keys




> ================================
> WARNING: inconsistent lock state
> 5.5.0-rc6-next-20200114-syzkaller #0 Not tainted
> --------------------------------
> inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
> syz-executor.5/9563 [HC0[0]:SC1[1]:HE1:SE0] takes:
> ffffffff8a03aa18 (ima_keys_lock){+.?.}, at: spin_lock
> include/linux/spinlock.h:338 [inline]
> ffffffff8a03aa18 (ima_keys_lock){+.?.}, at:
> ima_process_queued_keys+0x4f/0x320
> security/integrity/ima/ima_asymmetric_keys.c:144
> {SOFTIRQ-ON-W} state was registered at:
>    lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4484
>    __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
>    _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:151
>    spin_lock include/linux/spinlock.h:338 [inline]
>    ima_queue_key security/integrity/ima/ima_asymmetric_keys.c:111 [inline]
>    ima_post_key_create_or_update+0x234/0x470
> security/integrity/ima/ima_asymmetric_keys.c:194
>    key_create_or_update+0x6b8/0xcb0 security/keys/key.c:944
>    load_system_certificate_list+0x1ba/0x25e certs/system_keyring.c:161
>    do_one_initcall+0x120/0x820 init/main.c:940
>    do_initcall_level init/main.c:1014 [inline]
>    do_initcalls init/main.c:1022 [inline]
>    do_basic_setup init/main.c:1039 [inline]
>    kernel_init_freeable+0x4ca/0x570 init/main.c:1223
>    kernel_init+0x12/0x1bf init/main.c:1130
>    ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> irq event stamp: 319180
> hardirqs last  enabled at (319180): [<ffffffff87ec3333>]
> __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:168 [inline]
> hardirqs last  enabled at (319180): [<ffffffff87ec3333>]
> _raw_spin_unlock_irq+0x23/0x80 kernel/locking/spinlock.c:199
> hardirqs last disabled at (319179): [<ffffffff87ec351a>]
> __raw_spin_lock_irq include/linux/spinlock_api_smp.h:126 [inline]
> hardirqs last disabled at (319179): [<ffffffff87ec351a>]
> _raw_spin_lock_irq+0x3a/0x80 kernel/locking/spinlock.c:167
> softirqs last  enabled at (316932): [<ffffffff882006cd>]
> __do_softirq+0x6cd/0x98c kernel/softirq.c:319
> softirqs last disabled at (319177): [<ffffffff8147800b>] invoke_softirq
> kernel/softirq.c:373 [inline]
> softirqs last disabled at (319177): [<ffffffff8147800b>]
> irq_exit+0x19b/0x1e0 kernel/softirq.c:413
>
> other info that might help us debug this:
>   Possible unsafe locking scenario:
>
>         CPU0
>         ----
>    lock(ima_keys_lock);
>    <Interrupt>
>      lock(ima_keys_lock);
>
>   *** DEADLOCK ***
>
> 1 lock held by syz-executor.5/9563:
>   #0: ffffc90000007d50 ((&ima_key_queue_timer)){+.-.}, at: lockdep_copy_map
> include/linux/lockdep.h:172 [inline]
>   #0: ffffc90000007d50 ((&ima_key_queue_timer)){+.-.}, at:
> call_timer_fn+0xe0/0x780 kernel/time/timer.c:1394
>
> stack backtrace:
> CPU: 0 PID: 9563 Comm: syz-executor.5 Not tainted
> 5.5.0-rc6-next-20200114-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   <IRQ>
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x197/0x210 lib/dump_stack.c:118
>   print_usage_bug.cold+0x327/0x378 kernel/locking/lockdep.c:3100
>   valid_state kernel/locking/lockdep.c:3111 [inline]
>   mark_lock_irq kernel/locking/lockdep.c:3308 [inline]
>   mark_lock+0xbb4/0x1220 kernel/locking/lockdep.c:3665
>   mark_usage kernel/locking/lockdep.c:3565 [inline]
>   __lock_acquire+0x1e8e/0x4a00 kernel/locking/lockdep.c:3908
>   lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4484
>   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
>   _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:151
>   spin_lock include/linux/spinlock.h:338 [inline]
>   ima_process_queued_keys+0x4f/0x320
> security/integrity/ima/ima_asymmetric_keys.c:144
>   ima_timer_handler+0x15/0x20 security/integrity/ima/ima_asymmetric_keys.c:46
>   call_timer_fn+0x1ac/0x780 kernel/time/timer.c:1404
>   expire_timers kernel/time/timer.c:1449 [inline]
>   __run_timers kernel/time/timer.c:1773 [inline]
>   __run_timers kernel/time/timer.c:1740 [inline]
>   run_timer_softirq+0x6c3/0x1790 kernel/time/timer.c:1786
>   __do_softirq+0x262/0x98c kernel/softirq.c:292
>   invoke_softirq kernel/softirq.c:373 [inline]
>   irq_exit+0x19b/0x1e0 kernel/softirq.c:413
>   exiting_irq arch/x86/include/asm/apic.h:536 [inline]
>   smp_apic_timer_interrupt+0x1a3/0x610 arch/x86/kernel/apic/apic.c:1137
>   apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
>   </IRQ>
> RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:752
> [inline]
> RIP: 0010:slab_alloc mm/slab.c:3313 [inline]
> RIP: 0010:kmem_cache_alloc+0x283/0x710 mm/slab.c:3484
> Code: 7e 0f 85 dc fe ff ff e8 0c 3f 4d ff e9 d2 fe ff ff e8 31 aa c7 ff 48
> 83 3d 21 84 00 08 00 0f 84 51 03 00 00 48 8b 7d d0 57 9d <0f> 1f 44 00 00
> e9 68 fe ff ff 31 d2 be 35 02 00 00 48 c7 c7 2e a1
> RSP: 0018:ffffc9000641fd18 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
> RAX: 0000000000000007 RBX: 0000000000000cc0 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000286
> RBP: ffffc9000641fd80 R08: ffff8880543b22c0 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880aa5f8a80
> R13: ffff8880aa5f8a80 R14: 0000000000000cc0 R15: ffff8880a8916600
>   getname_flags fs/namei.c:138 [inline]
>   getname_flags+0xd6/0x5b0 fs/namei.c:128
>   getname fs/namei.c:209 [inline]
>   user_path_mountpoint_at+0x29/0x50 fs/namei.c:2820
>   ksys_umount+0x164/0xef0 fs/namespace.c:1683
>   __do_sys_umount fs/namespace.c:1709 [inline]
>   __se_sys_umount fs/namespace.c:1707 [inline]
>   __x64_sys_umount+0x54/0x80 fs/namespace.c:1707
>   do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x45d977
> Code: 64 89 04 25 d0 02 00 00 58 5f ff d0 48 89 c7 e8 2f be ff ff 66 2e 0f
> 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 4d 8c fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffeff269038 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
> RAX: ffffffffffffffda RBX: 000000000004d5f3 RCX: 000000000045d977
> RDX: 000000000000000c RSI: 0000000000000002 RDI: 00007ffeff26a170
> RBP: 000000000000003c R08: 0000000000000001 R09: 0000000001dc6940
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffeff26a170
> R13: 00007ffeff26a160 R14: 0000000000000000 R15: 00007ffeff26a170
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000486474059c19f4d7%40google.com.
