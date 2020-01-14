Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C49A313AB81
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2020 14:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbgANN4L (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 14 Jan 2020 08:56:11 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:41726 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728741AbgANN4K (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 14 Jan 2020 08:56:10 -0500
Received: by mail-il1-f200.google.com with SMTP id k9so10487497ili.8
        for <linux-integrity@vger.kernel.org>; Tue, 14 Jan 2020 05:56:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=beL9fdYD9Zg6YYQLefcIhct373j21vqbmap/vGlLXPc=;
        b=t7MEu06+wR668bPgbDSNaPaTjjVY6WYJMc4YTWPM3vh8jTTHOjdM11geta5DSP9iGf
         pvOjJqi/v3Xqnz+zdUieckl/FCrpbo7J/kBb0C19Wc/D7zFse/WJIIK7F2XSKZZrfJv0
         NRVCMB0lHElosiJdUU/xpLGBgOVe9Z61moVFO5sEU6tTppIxI98wefj5niURK8A+qldm
         bV+QyhO1fpYWZeOmUfATU3vkyhtfXddlrwk2argFzfrLOVureh9efCDpTIKAunsjgFeJ
         ze8VH9jJDBpci11nxt54N51cQFbCJLhJe+SH8wLpHCIw4ohkGbkNcvJXdM75YA6tYO5T
         bzkA==
X-Gm-Message-State: APjAAAUXtZKUqPQfWANeoUHM3fZQFJMyC+/qxwngbPioMP7ZxAZr96gZ
        mtAr1bOLwbps0xao562O71xGjrpzJlK/RbyAePA3VT54dQeq
X-Google-Smtp-Source: APXvYqzpuKjXqFEyVifz7gpRst1DXqnvtfQr2kIfCsAY0EDis1kA7k7/3PiDs3VmaenwO56zmDWaVS6m9Y+mpEqGPmsW/tQADyLF
MIME-Version: 1.0
X-Received: by 2002:a6b:7703:: with SMTP id n3mr1192699iom.229.1579010170051;
 Tue, 14 Jan 2020 05:56:10 -0800 (PST)
Date:   Tue, 14 Jan 2020 05:56:10 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000486474059c19f4d7@google.com>
Subject: inconsistent lock state in ima_process_queued_keys
From:   syzbot <syzbot+a4a503d7f37292ae1664@syzkaller.appspotmail.com>
To:     dmitry.kasatkin@gmail.com, jmorris@namei.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    1b851f98 Add linux-next specific files for 20200114
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12bcbb25e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3e7d9cf7ebfa08ad
dashboard link: https://syzkaller.appspot.com/bug?extid=a4a503d7f37292ae1664
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+a4a503d7f37292ae1664@syzkaller.appspotmail.com

================================
WARNING: inconsistent lock state
5.5.0-rc6-next-20200114-syzkaller #0 Not tainted
--------------------------------
inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
syz-executor.5/9563 [HC0[0]:SC1[1]:HE1:SE0] takes:
ffffffff8a03aa18 (ima_keys_lock){+.?.}, at: spin_lock  
include/linux/spinlock.h:338 [inline]
ffffffff8a03aa18 (ima_keys_lock){+.?.}, at:  
ima_process_queued_keys+0x4f/0x320  
security/integrity/ima/ima_asymmetric_keys.c:144
{SOFTIRQ-ON-W} state was registered at:
   lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4484
   __raw_spin_lock include/linux/spinlock_api_smp.h:142 [inline]
   _raw_spin_lock+0x2f/0x40 kernel/locking/spinlock.c:151
   spin_lock include/linux/spinlock.h:338 [inline]
   ima_queue_key security/integrity/ima/ima_asymmetric_keys.c:111 [inline]
   ima_post_key_create_or_update+0x234/0x470  
security/integrity/ima/ima_asymmetric_keys.c:194
   key_create_or_update+0x6b8/0xcb0 security/keys/key.c:944
   load_system_certificate_list+0x1ba/0x25e certs/system_keyring.c:161
   do_one_initcall+0x120/0x820 init/main.c:940
   do_initcall_level init/main.c:1014 [inline]
   do_initcalls init/main.c:1022 [inline]
   do_basic_setup init/main.c:1039 [inline]
   kernel_init_freeable+0x4ca/0x570 init/main.c:1223
   kernel_init+0x12/0x1bf init/main.c:1130
   ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
irq event stamp: 319180
hardirqs last  enabled at (319180): [<ffffffff87ec3333>]  
__raw_spin_unlock_irq include/linux/spinlock_api_smp.h:168 [inline]
hardirqs last  enabled at (319180): [<ffffffff87ec3333>]  
_raw_spin_unlock_irq+0x23/0x80 kernel/locking/spinlock.c:199
hardirqs last disabled at (319179): [<ffffffff87ec351a>]  
__raw_spin_lock_irq include/linux/spinlock_api_smp.h:126 [inline]
hardirqs last disabled at (319179): [<ffffffff87ec351a>]  
_raw_spin_lock_irq+0x3a/0x80 kernel/locking/spinlock.c:167
softirqs last  enabled at (316932): [<ffffffff882006cd>]  
__do_softirq+0x6cd/0x98c kernel/softirq.c:319
softirqs last disabled at (319177): [<ffffffff8147800b>] invoke_softirq  
kernel/softirq.c:373 [inline]
softirqs last disabled at (319177): [<ffffffff8147800b>]  
irq_exit+0x19b/0x1e0 kernel/softirq.c:413

other info that might help us debug this:
  Possible unsafe locking scenario:

        CPU0
        ----
   lock(ima_keys_lock);
   <Interrupt>
     lock(ima_keys_lock);

  *** DEADLOCK ***

1 lock held by syz-executor.5/9563:
  #0: ffffc90000007d50 ((&ima_key_queue_timer)){+.-.}, at: lockdep_copy_map  
include/linux/lockdep.h:172 [inline]
  #0: ffffc90000007d50 ((&ima_key_queue_timer)){+.-.}, at:  
call_timer_fn+0xe0/0x780 kernel/time/timer.c:1394

stack backtrace:
CPU: 0 PID: 9563 Comm: syz-executor.5 Not tainted  
5.5.0-rc6-next-20200114-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
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
  ima_process_queued_keys+0x4f/0x320  
security/integrity/ima/ima_asymmetric_keys.c:144
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
RIP: 0010:arch_local_irq_restore arch/x86/include/asm/paravirt.h:752  
[inline]
RIP: 0010:slab_alloc mm/slab.c:3313 [inline]
RIP: 0010:kmem_cache_alloc+0x283/0x710 mm/slab.c:3484
Code: 7e 0f 85 dc fe ff ff e8 0c 3f 4d ff e9 d2 fe ff ff e8 31 aa c7 ff 48  
83 3d 21 84 00 08 00 0f 84 51 03 00 00 48 8b 7d d0 57 9d <0f> 1f 44 00 00  
e9 68 fe ff ff 31 d2 be 35 02 00 00 48 c7 c7 2e a1
RSP: 0018:ffffc9000641fd18 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
RAX: 0000000000000007 RBX: 0000000000000cc0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000286
RBP: ffffc9000641fd80 R08: ffff8880543b22c0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880aa5f8a80
R13: ffff8880aa5f8a80 R14: 0000000000000cc0 R15: ffff8880a8916600
  getname_flags fs/namei.c:138 [inline]
  getname_flags+0xd6/0x5b0 fs/namei.c:128
  getname fs/namei.c:209 [inline]
  user_path_mountpoint_at+0x29/0x50 fs/namei.c:2820
  ksys_umount+0x164/0xef0 fs/namespace.c:1683
  __do_sys_umount fs/namespace.c:1709 [inline]
  __se_sys_umount fs/namespace.c:1707 [inline]
  __x64_sys_umount+0x54/0x80 fs/namespace.c:1707
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45d977
Code: 64 89 04 25 d0 02 00 00 58 5f ff d0 48 89 c7 e8 2f be ff ff 66 2e 0f  
1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 4d 8c fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffeff269038 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: ffffffffffffffda RBX: 000000000004d5f3 RCX: 000000000045d977
RDX: 000000000000000c RSI: 0000000000000002 RDI: 00007ffeff26a170
RBP: 000000000000003c R08: 0000000000000001 R09: 0000000001dc6940
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffeff26a170
R13: 00007ffeff26a160 R14: 0000000000000000 R15: 00007ffeff26a170


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
