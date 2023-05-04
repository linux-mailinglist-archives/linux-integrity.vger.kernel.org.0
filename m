Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C136F6465
	for <lists+linux-integrity@lfdr.de>; Thu,  4 May 2023 07:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjEDFbG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 May 2023 01:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjEDFbE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 May 2023 01:31:04 -0400
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0F01BEB
        for <linux-integrity@vger.kernel.org>; Wed,  3 May 2023 22:31:00 -0700 (PDT)
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-766588051b3so1437339f.2
        for <linux-integrity@vger.kernel.org>; Wed, 03 May 2023 22:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683178260; x=1685770260;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LvlYAZ3Me0ZvWK0peP7KkabrrzZnc1AAxIMZTphZeG0=;
        b=f9H0XZR+C9Az8AD2hZD/r6LSMLMIOq07l/HkRg9kP+w+s7JE2cv8MFtChksW0gjMOw
         hVbFS1C2m9EVFvAGbUpkcIvGJixPPrPO/7ov3ZtXgT/loJUDkWmt9mVdz8f38Wdy4SaA
         Za9bIZ6Cmg9Wc+1cdecXTOoQkdBrqLt/T6AFiVOaN9LzrOhgUK6heBzcVEyS+6Kpo2in
         HJ2LYD+hBMsMEMGiqgbHtjoyuAwaFdqO3pkOzSQwB5Ih1uYidcLwSItoILbI3NgRJM6H
         J7jXZNLrnE0fkcPUvhT/8lWRtYUrQGg61lGRHn9My0KQsJaD7rbRUTBgbyqyZ41K3Qht
         7cFw==
X-Gm-Message-State: AC+VfDxFNKPwn33yn1Ub6THnCOHZ4P5oXFRhuVbvKdW/lsfAegP4ldhW
        EEnkbY48LLf59SGDIxeCGt1wnSXIKSf7UwNKmiMt3OzCyS7m
X-Google-Smtp-Source: ACHHUZ7Q9s0CaW0Fz9AD9scK66AIspx3NzAxoNU/dHnaFO7CaRSjRE/tkFPi6PHsJFkQEYg+F4uAjBIGV67ZDihI7Cu2O0xSsFjd
MIME-Version: 1.0
X-Received: by 2002:a05:6602:114:b0:745:5e5c:f091 with SMTP id
 s20-20020a056602011400b007455e5cf091mr11544478iot.0.1683178259880; Wed, 03
 May 2023 22:30:59 -0700 (PDT)
Date:   Wed, 03 May 2023 22:30:59 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004623de05fad77acc@google.com>
Subject: [syzbot] [integrity?] [lsm?] possible deadlock in ima_file_free
From:   syzbot <syzbot+a2bbe9020e59fdeab932@syzkaller.appspotmail.com>
To:     dmitry.kasatkin@gmail.com, jmorris@namei.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        serge@hallyn.com, syzkaller-bugs@googlegroups.com,
        zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c8c655c34e33 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=142ad18c280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5eadbf0d3c2ece89
dashboard link: https://syzkaller.appspot.com/bug?extid=a2bbe9020e59fdeab932
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/618b22e20036/disk-c8c655c3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1388ab23cc1b/vmlinux-c8c655c3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/79496e207412/bzImage-c8c655c3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a2bbe9020e59fdeab932@syzkaller.appspotmail.com

syz-executor.1: attempt to access beyond end of device
loop1: rw=2049, sector=77824, nr_sectors = 2048 limit=63271
syz-executor.1: attempt to access beyond end of device
loop1: rw=2049, sector=79872, nr_sectors = 2048 limit=63271
======================================================
WARNING: possible circular locking dependency detected
6.3.0-syzkaller-12378-gc8c655c34e33 #0 Not tainted
------------------------------------------------------
syz-executor.1/26208 is trying to acquire lock:
ffff8880294dc1a0 (&iint->mutex){+.+.}-{3:3}, at: ima_check_last_writer security/integrity/ima/ima_main.c:165 [inline]
ffff8880294dc1a0 (&iint->mutex){+.+.}-{3:3}, at: ima_file_free+0x110/0x3c0 security/integrity/ima/ima_main.c:199

but task is already holding lock:
ffff88805b928448 (&sbi->node_write){++++}-{3:3}, at: f2fs_down_read fs/f2fs/f2fs.h:2087 [inline]
ffff88805b928448 (&sbi->node_write){++++}-{3:3}, at: f2fs_write_single_data_page+0xa10/0x1d50 fs/f2fs/data.c:2842

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&sbi->node_write){++++}-{3:3}:
       reacquire_held_locks+0x3aa/0x660 kernel/locking/lockdep.c:5216
       __lock_release kernel/locking/lockdep.c:5405 [inline]
       lock_release+0x36f/0x9d0 kernel/locking/lockdep.c:5711
       up_write+0x79/0x580 kernel/locking/rwsem.c:1625
       f2fs_write_checkpoint+0x13a4/0x1f90 fs/f2fs/checkpoint.c:1651
       __write_checkpoint_sync fs/f2fs/checkpoint.c:1768 [inline]
       __checkpoint_and_complete_reqs+0xda/0x3b0 fs/f2fs/checkpoint.c:1787
       issue_checkpoint_thread+0xda/0x260 fs/f2fs/checkpoint.c:1818
       kthread+0x2b8/0x350 kernel/kthread.c:379
       ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308

-> #3 (&sbi->cp_rwsem){++++}-{3:3}:
       lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5691
       down_read+0x3d/0x50 kernel/locking/rwsem.c:1520
       f2fs_down_read fs/f2fs/f2fs.h:2087 [inline]
       f2fs_lock_op fs/f2fs/f2fs.h:2130 [inline]
       f2fs_convert_inline_inode+0x578/0x800 fs/f2fs/inline.c:218
       f2fs_vm_page_mkwrite+0x32c/0x13d0 fs/f2fs/file.c:79
       do_page_mkwrite+0x1a4/0x600 mm/memory.c:2931
       do_shared_fault mm/memory.c:4595 [inline]
       do_fault mm/memory.c:4663 [inline]
       do_pte_missing mm/memory.c:3647 [inline]
       handle_pte_fault mm/memory.c:4947 [inline]
       __handle_mm_fault mm/memory.c:5089 [inline]
       handle_mm_fault+0x2140/0x5860 mm/memory.c:5243
       do_user_addr_fault arch/x86/mm/fault.c:1440 [inline]
       handle_page_fault arch/x86/mm/fault.c:1534 [inline]
       exc_page_fault+0x7d2/0x910 arch/x86/mm/fault.c:1590
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570

-> #2 (&mm->mmap_lock){++++}-{3:3}:
       lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5691
       internal_get_user_pages_fast+0x244/0x2ce0 mm/gup.c:2967
       __iov_iter_get_pages_alloc+0x3c9/0x940 lib/iov_iter.c:1509
       iov_iter_get_pages+0xd9/0x130 lib/iov_iter.c:1552
       __bio_iov_iter_get_pages block/bio.c:1269 [inline]
       bio_iov_iter_get_pages+0x480/0x12b0 block/bio.c:1340
       iomap_dio_bio_iter+0xac2/0x1430 fs/iomap/direct-io.c:325
       __iomap_dio_rw+0x12c3/0x22e0 fs/iomap/direct-io.c:598
       iomap_dio_rw+0x46/0xa0 fs/iomap/direct-io.c:688
       xfs_file_dio_write_aligned+0x222/0x350 fs/xfs/xfs_file.c:543
       xfs_file_dio_write fs/xfs/xfs_file.c:655 [inline]
       xfs_file_write_iter+0x508/0x620 fs/xfs/xfs_file.c:797
       do_iter_write+0x7b1/0xcb0 fs/read_write.c:860
       vfs_writev fs/read_write.c:933 [inline]
       do_pwritev+0x21a/0x360 fs/read_write.c:1030
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #1 (&sb->s_type->i_mutex_key#26){++++}-{3:3}:
       lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5691
       down_read_nested+0x40/0x60 kernel/locking/rwsem.c:1645
       xfs_ilock+0x10e/0x3a0 fs/xfs/xfs_inode.c:198
       xfs_ilock_iocb fs/xfs/xfs_file.c:211 [inline]
       xfs_file_buffered_read+0x160/0x320 fs/xfs/xfs_file.c:274
       xfs_file_read_iter+0x262/0x4d0 fs/xfs/xfs_file.c:302
       __kernel_read+0x422/0x8a0 fs/read_write.c:428
       integrity_kernel_read+0xb0/0xf0 security/integrity/iint.c:192
       ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:485 [inline]
       ima_calc_file_shash security/integrity/ima/ima_crypto.c:516 [inline]
       ima_calc_file_hash+0x1643/0x1d20 security/integrity/ima/ima_crypto.c:573
       ima_collect_measurement+0x3a7/0x880 security/integrity/ima/ima_api.c:293
       process_measurement+0xfdb/0x1ce0 security/integrity/ima/ima_main.c:341
       ima_file_check+0xf1/0x170 security/integrity/ima/ima_main.c:539
       do_open fs/namei.c:3638 [inline]
       path_openat+0x280a/0x3170 fs/namei.c:3791
       do_filp_open+0x234/0x490 fs/namei.c:3818
       do_sys_openat2+0x13f/0x500 fs/open.c:1356
       do_sys_open fs/open.c:1372 [inline]
       __do_sys_open fs/open.c:1380 [inline]
       __se_sys_open fs/open.c:1376 [inline]
       __x64_sys_open+0x225/0x270 fs/open.c:1376
       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
       do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

-> #0 (&iint->mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3108 [inline]
       check_prevs_add kernel/locking/lockdep.c:3227 [inline]
       validate_chain+0x166b/0x58e0 kernel/locking/lockdep.c:3842
       __lock_acquire+0x1295/0x2000 kernel/locking/lockdep.c:5074
       lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5691
       __mutex_lock_common+0x1d8/0x2530 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x1b/0x20 kernel/locking/mutex.c:799
       ima_check_last_writer security/integrity/ima/ima_main.c:165 [inline]
       ima_file_free+0x110/0x3c0 security/integrity/ima/ima_main.c:199
       __fput+0x32e/0x890 fs/file_table.c:315
       task_work_run+0x24a/0x300 kernel/task_work.c:179
       get_signal+0x1606/0x17e0 kernel/signal.c:2650
       arch_do_signal_or_restart+0x91/0x670 arch/x86/kernel/signal.c:306
       exit_to_user_mode_loop+0x6a/0x100 kernel/entry/common.c:168
       exit_to_user_mode_prepare+0xb1/0x140 kernel/entry/common.c:204
       __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
       syscall_exit_to_user_mode+0x64/0x280 kernel/entry/common.c:297
       do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
       entry_SYSCALL_64_after_hwframe+0x63/0xcd

other info that might help us debug this:

Chain exists of:
  &iint->mutex --> &sbi->cp_rwsem --> &sbi->node_write

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  rlock(&sbi->node_write);
                               lock(&sbi->cp_rwsem);
                               lock(&sbi->node_write);
  lock(&iint->mutex);

 *** DEADLOCK ***

1 lock held by syz-executor.1/26208:
 #0: ffff88805b928448 (&sbi->node_write){++++}-{3:3}, at: f2fs_down_read fs/f2fs/f2fs.h:2087 [inline]
 #0: ffff88805b928448 (&sbi->node_write){++++}-{3:3}, at: f2fs_write_single_data_page+0xa10/0x1d50 fs/f2fs/data.c:2842

stack backtrace:
CPU: 0 PID: 26208 Comm: syz-executor.1 Not tainted 6.3.0-syzkaller-12378-gc8c655c34e33 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/14/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 check_noncircular+0x2fe/0x3b0 kernel/locking/lockdep.c:2188
 check_prev_add kernel/locking/lockdep.c:3108 [inline]
 check_prevs_add kernel/locking/lockdep.c:3227 [inline]
 validate_chain+0x166b/0x58e0 kernel/locking/lockdep.c:3842
 __lock_acquire+0x1295/0x2000 kernel/locking/lockdep.c:5074
 lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5691
 __mutex_lock_common+0x1d8/0x2530 kernel/locking/mutex.c:603
 __mutex_lock kernel/locking/mutex.c:747 [inline]
 mutex_lock_nested+0x1b/0x20 kernel/locking/mutex.c:799
 ima_check_last_writer security/integrity/ima/ima_main.c:165 [inline]
 ima_file_free+0x110/0x3c0 security/integrity/ima/ima_main.c:199
 __fput+0x32e/0x890 fs/file_table.c:315
 task_work_run+0x24a/0x300 kernel/task_work.c:179
 get_signal+0x1606/0x17e0 kernel/signal.c:2650
 arch_do_signal_or_restart+0x91/0x670 arch/x86/kernel/signal.c:306
 exit_to_user_mode_loop+0x6a/0x100 kernel/entry/common.c:168
 exit_to_user_mode_prepare+0xb1/0x140 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
 syscall_exit_to_user_mode+0x64/0x280 kernel/entry/common.c:297
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f8281a8c169
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f82827f4168 EFLAGS: 00000246 ORIG_RAX: 0000000000000148
RAX: fffffffffffffffb RBX: 00007f8281babf80 RCX: 00007f8281a8c169
RDX: 0000000000000001 RSI: 0000000020000240 RDI: 0000000000000004
RBP: 00007f8281ae7ca1 R08: 0000000000000000 R09: 0000000000000003
R10: 0000000000001400 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe420958ff R14: 00007f82827f4300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to change bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
