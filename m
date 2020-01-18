Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 582B71415AA
	for <lists+linux-integrity@lfdr.de>; Sat, 18 Jan 2020 04:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730651AbgARDOK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Jan 2020 22:14:10 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:34736 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730642AbgARDOK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Jan 2020 22:14:10 -0500
Received: by mail-il1-f200.google.com with SMTP id l13so20317067ils.1
        for <linux-integrity@vger.kernel.org>; Fri, 17 Jan 2020 19:14:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=gs5Wd+FFalWgZdPnWojgNbueaMF9ZL5bd05HzA7/eYw=;
        b=sBCvA5SpTdCNKGTJ+ilRRHX3dOUyFGsI4zMnm8P+nU+LlUWcunTu/+74MjPCqWxxOs
         LsYkUbp65Ny5j9bHdpNHNTP8j8zQA2K4HqVCez7dLw/kOVZyp8Sbe9fi47yAssZFK24V
         zvYyYDWxPEvLP5KkqikLma+OcCVnNqzvqBAWAGx3SSCmUVocOEj6oxqj8F7rY30fBAeV
         24LH1wCbB5ZjVTqBTOqXz3Pf7DNs2T3T8Bj4ibfinaE5ejtI3W+f3Uo09aH0ryqxO/Gv
         JTugImwvlL1SKVWCf6l20AFtmajFlrRV7oLUgZ1pMIPnUQCh9j3AzFEDGL0pnOO3+bOk
         +5yA==
X-Gm-Message-State: APjAAAV7+QOmixcFwsxBLSTZPJQCGzO5hK4l1NzUUY3QdO4l4vqn1VrM
        6xGP89XWmX6a2Y2a4JLxkRnsgjMC0fq7WTleNOLcD4qtKGUp
X-Google-Smtp-Source: APXvYqxz5LJq4LWDmNV9szwNsmBqBsVUxJpxFb+i+hQ4QJCPu9V5Fvqj0Rx+8t9CpL4J3NjHXRUS5yqjl/DTlRs32SRRu4E+dR29
MIME-Version: 1.0
X-Received: by 2002:a6b:8e47:: with SMTP id q68mr32469522iod.274.1579317249297;
 Fri, 17 Jan 2020 19:14:09 -0800 (PST)
Date:   Fri, 17 Jan 2020 19:14:09 -0800
In-Reply-To: <000000000000486474059c19f4d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a1d91b059c6173c6@google.com>
Subject: Re: inconsistent lock state in ima_process_queued_keys
From:   syzbot <syzbot+a4a503d7f37292ae1664@syzkaller.appspotmail.com>
To:     dmitry.kasatkin@gmail.com, dvyukov@google.com, jmorris@namei.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nramas@linux.microsoft.com,
        serge@hallyn.com, syzkaller-bugs@googlegroups.com,
        zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    2747d5fd Add linux-next specific files for 20200116
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14ee1cc9e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=22f506e7a3a37fe2
dashboard link: https://syzkaller.appspot.com/bug?extid=a4a503d7f37292ae1664
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=128b4495e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12b673b9e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a4a503d7f37292ae1664@syzkaller.appspotmail.com

================================
WARNING: inconsistent lock state
5.5.0-rc6-next-20200116-syzkaller #0 Not tainted
--------------------------------
inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
kworker/u4:3/125 [HC0[0]:SC1[1]:HE1:SE0] takes:
ffffffff8a03ce58 (ima_keys_lock){+.?.}, at: spin_lock include/linux/spinlock.h:338 [inline]
ffffffff8a03ce58 (ima_keys_lock){+.?.}, at: ima_process_queued_keys+0x4f/0x320 security/integrity/ima/ima_asymmetric_keys.c:144
{SOFTIRQ-ON-W} state was registered at:
  lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4484
  __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
  _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:151
  spin_lock include/linux/spinlock.h:338 [inline]
  ima_queue_key security/integrity/ima/ima_asymmetric_keys.c:111 [inline]
  ima_post_key_create_or_update+0x234/0x470 security/integrity/ima/ima_asymmetric_keys.c:194
  key_create_or_update+0x6b8/0xcb0 security/keys/key.c:944
  load_system_certificate_list+0x1ba/0x25e certs/system_keyring.c:161
  do_one_initcall+0x120/0x820 init/main.c:1109
  do_initcall_level init/main.c:1182 [inline]
  do_initcalls init/main.c:1198 [inline]
  do_basic_setup init/main.c:1218 [inline]
  kernel_init_freeable+0x522/0x5d0 init/main.c:1402
  kernel_init+0x12/0x1bf init/main.c:1309
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
irq event stamp: 15703140
hardirqs last  enabled at (15703140): [<ffffffff87ee0813>] __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:168 [inline]
hardirqs last  enabled at (15703140): [<ffffffff87ee0813>] _raw_spin_unlock_irq+0x23/0x80 kernel/locking/spinlock.c:199
hardirqs last disabled at (15703139): [<ffffffff87ee09fa>] __raw_spin_lock_irq include/linux/spinlock_api_smp.h:126 [inline]
hardirqs last disabled at (15703139): [<ffffffff87ee09fa>] _raw_spin_lock_irq+0x3a/0x80 kernel/locking/spinlock.c:167
softirqs last  enabled at (15702640): [<ffffffff87cf9855>] spin_unlock_bh include/linux/spinlock.h:383 [inline]
softirqs last  enabled at (15702640): [<ffffffff87cf9855>] batadv_nc_purge_paths+0x265/0x370 net/batman-adv/network-coding.c:470
softirqs last disabled at (15702651): [<ffffffff8147a05b>] invoke_softirq kernel/softirq.c:373 [inline]
softirqs last disabled at (15702651): [<ffffffff8147a05b>] irq_exit+0x19b/0x1e0 kernel/softirq.c:413

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(ima_keys_lock);
  <Interrupt>
    lock(ima_keys_lock);

 *** DEADLOCK ***

4 locks held by kworker/u4:3/125:
 #0: ffff88821512a928 ((wq_completion)bat_events){+.+.}, at: __write_once_size include/linux/compiler.h:250 [inline]
 #0: ffff88821512a928 ((wq_completion)bat_events){+.+.}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88821512a928 ((wq_completion)bat_events){+.+.}, at: atomic64_set include/asm-generic/atomic-instrumented.h:869 [inline]
 #0: ffff88821512a928 ((wq_completion)bat_events){+.+.}, at: atomic_long_set include/asm-generic/atomic-long.h:41 [inline]
 #0: ffff88821512a928 ((wq_completion)bat_events){+.+.}, at: set_work_data kernel/workqueue.c:615 [inline]
 #0: ffff88821512a928 ((wq_completion)bat_events){+.+.}, at: set_work_pool_and_clear_pending kernel/workqueue.c:642 [inline]
 #0: ffff88821512a928 ((wq_completion)bat_events){+.+.}, at: process_one_work+0x8dd/0x17a0 kernel/workqueue.c:2235
 #1: ffffc90001397dc0 ((work_completion)(&(&bat_priv->nc.work)->work)){+.+.}, at: process_one_work+0x917/0x17a0 kernel/workqueue.c:2239
 #2: ffffffff89bb0400 (rcu_read_lock){....}, at: batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:405 [inline]
 #2: ffffffff89bb0400 (rcu_read_lock){....}, at: batadv_nc_worker+0xe3/0x760 net/batman-adv/network-coding.c:718
 #3: ffffc90000d98d50 ((&ima_key_queue_timer)){+.-.}, at: lockdep_copy_map include/linux/lockdep.h:172 [inline]
 #3: ffffc90000d98d50 ((&ima_key_queue_timer)){+.-.}, at: call_timer_fn+0xe0/0x780 kernel/time/timer.c:1394

stack backtrace:
CPU: 1 PID: 125 Comm: kworker/u4:3 Not tainted 5.5.0-rc6-next-20200116-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: bat_events batadv_nc_worker
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 print_usage_bug.cold+0x327/0x378 kernel/locking/lockdep.c:3100
 valid_state kernel/locking/lockdep.c:3111 [inline]
 mark_lock_irq kernel/locking/lockdep.c:3308 [inline]
 mark_lock+0xbb4/0x1220 kernel/locking/lockdep.c:3665
 mark_usage kernel/locking/lockdep.c:3565 [inline]
 __lock_acquire+0x1e8e/0x4a00 kernel/locking/lockdep.c:3908
 lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4484
 __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
 _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:151
 spin_lock include/linux/spinlock.h:338 [inline]
 ima_process_queued_keys+0x4f/0x320 security/integrity/ima/ima_asymmetric_keys.c:144
 ima_timer_handler+0x15/0x20 security/integrity/ima/ima_asymmetric_keys.c:46
 call_timer_fn+0x1ac/0x780 kernel/time/timer.c:1404
 expire_timers kernel/time/timer.c:1449 [inline]
 __run_timers kernel/time/timer.c:1773 [inline]
 __run_timers kernel/time/timer.c:1740 [inline]
 run_timer_softirq+0x6c3/0x1790 kernel/time/timer.c:1786
 __do_softirq+0x262/0x98c kernel/softirq.c:292
 invoke_softirq kernel/softirq.c:373 [inline]
 irq_exit+0x19b/0x1e0 kernel/softirq.c:413
 exiting_irq arch/x86/include/asm/apic.h:536 [inline]
 smp_apic_timer_interrupt+0x1a3/0x610 arch/x86/kernel/apic/apic.c:1137
 apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
 </IRQ>
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:752 [inline]
RIP: 0010:lock_acquire+0x20b/0x410 kernel/locking/lockdep.c:4487
Code: 9c 08 00 00 00 00 00 00 48 c1 e8 03 80 3c 10 00 0f 85 d3 01 00 00 48 83 3d 49 7d 58 08 00 0f 84 53 01 00 00 48 8b 7d c8 57 9d <0f> 1f 44 00 00 48 8d 65 d8 5b 41 5c 41 5d 41 5e 41 5f 5d c3 65 8b
RSP: 0018:ffffc90001397c70 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
RAX: 1ffffffff136774f RBX: ffff8880a922c600 RCX: ffffffff815ae240
RDX: dffffc0000000000 RSI: 0000000000000008 RDI: 0000000000000286
RBP: ffffc90001397cb8 R08: 1ffffffff16a51a4 R09: fffffbfff16a51a5
R10: ffff8880a922cef0 R11: ffff8880a922c600 R12: ffffffff89bb0400
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000002
 rcu_lock_acquire include/linux/rcupdate.h:208 [inline]
 rcu_read_lock include/linux/rcupdate.h:601 [inline]
 batadv_nc_purge_orig_hash net/batman-adv/network-coding.c:407 [inline]
 batadv_nc_worker+0x117/0x760 net/batman-adv/network-coding.c:718
 process_one_work+0xa05/0x17a0 kernel/workqueue.c:2264
 worker_thread+0x98/0xe40 kernel/workqueue.c:2410
 kthread+0x361/0x430 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

