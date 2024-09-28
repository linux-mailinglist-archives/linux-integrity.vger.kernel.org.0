Return-Path: <linux-integrity+bounces-3713-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0312F988E2C
	for <lists+linux-integrity@lfdr.de>; Sat, 28 Sep 2024 09:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7904D283E18
	for <lists+linux-integrity@lfdr.de>; Sat, 28 Sep 2024 07:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8F71859;
	Sat, 28 Sep 2024 07:32:33 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7913E19A29A
	for <linux-integrity@vger.kernel.org>; Sat, 28 Sep 2024 07:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727508753; cv=none; b=fQUVtCHHBvsFSiMP9JArPsqprgAoSe9iYoBhWJno2b71kQ7S1rvY3bpxKB5laa5t1ehoOUs+Qojzq13+HOheO74G19bwtEU3UDiTw87QrBnWsk77bfOkIT4koCQ/7EIhjucaRjz3S3BcC7n25FXYKlAf3Oe0V3pJ7GQswmEYG78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727508753; c=relaxed/simple;
	bh=iQebi6bqL+RS9rmDEgTYJqxT5c1eYcHyxFktxIpbyD8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pstoe7+W/1uZY4YtBDHOGkyQafBHnuDoEpzVIUszuCaiVaA4chou2Ka6Cl/OEw5w6uYlXWLNfsveobyuOWfJP3GxDY1Eekk3+JZeamJqOIhNGE5H8OC5tA+14Q7xhcFlAxphPau3fpX9YeOOABMAbRk5vwmowdHRh1Y1U8dSWSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a343860e72so23939715ab.0
        for <linux-integrity@vger.kernel.org>; Sat, 28 Sep 2024 00:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727508750; x=1728113550;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RVN6FnbwA3huhnKDHIz/m0xr8FOP4DiYHAdGNcqkPlA=;
        b=xBkORkv0kUfg7N5wpDPvDu90gUe7aOGY+wKIDtgUFRUiJr0G/VB7WLl1olDktlNbNt
         WjkuOoorKczEVxQaLputnCoMqcr86xr2w4m0knuE5fgfpdk8dsYIAhwjibvL7nT+WPOb
         Ci1F+5gfdJP2LFI9Yu99uEmLorbxjhHLPItS3OWFJwYD03+WdMVhnpPwACmtvIhh3kez
         ZJTybeU/hhnkK9w/UHroQmD1bIy7BYhbwIiUn+PVnSwTsw+COBE12hACuU0epdCiev1E
         Ekd8DhvwoJwQwvNkCvfssNtXqRMQ9/qQeVVdIJI3SZ3BxvqN2gQthcKeHxEYzUZDCFoG
         fpZQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1pgMqf046Q2y1IHk6CcCDNeKPDkmqFqNJl6zU1ZmdDEq3XrxSqeIOcmEHIMpKgOVdD6CUHODImmzA4K492x8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg+Af2g4q2YHd99XNIma5xJ2jjdbzY+6Q38oqoDakPHSIibK+z
	eLgYQl1MuNGIIBJ2EbbNYWKquG8AVvcytM3oordJ25IBdA3eVcXNImO/8pfjSx+lXBEm/XxV8h3
	W5vOWIJJQvGTGW4tYxwI6xyDjFHddVAuDamfrdC4uCate+Hv4NOqs9qI=
X-Google-Smtp-Source: AGHT+IG/P8TK6Ao3MnAVao5QTuroLVb8UQZwIBOkPmvz82x3Kh9XyB2oGcdfho2jN8qhqMzByu4nqqsPn39+zfjkEh6i0bc2dVMl
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a46:b0:3a0:8d60:8b7d with SMTP id
 e9e14a558f8ab-3a34516903fmr48946585ab.11.1727508750578; Sat, 28 Sep 2024
 00:32:30 -0700 (PDT)
Date: Sat, 28 Sep 2024 00:32:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f7b10e.050a0220.46d20.0036.GAE@google.com>
Subject: [syzbot] [integrity?] [lsm?] possible deadlock in process_measurement (4)
From: syzbot <syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, dmitry.kasatkin@gmail.com, 
	ebpqwerty472123@gmail.com, eric.snowberg@oracle.com, hughd@google.com, 
	jmorris@namei.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	roberto.sassu@huawei.com, serge@hallyn.com, stephen.smalley.work@gmail.com, 
	syzkaller-bugs@googlegroups.com, zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    97d8894b6f4c Merge tag 'riscv-for-linus-6.12-mw1' of git:/..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14138a80580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc30a30374b0753
dashboard link: https://syzkaller.appspot.com/bug?extid=1cd571a672400ef3a930
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=118fd2a9980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1038299f980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f181c147328d/disk-97d8894b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b8b0160d9b09/vmlinux-97d8894b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c5dab0d4f811/bzImage-97d8894b.xz

The issue was bisected to:

commit ea7e2d5e49c05e5db1922387b09ca74aa40f46e2
Author: Shu Han <ebpqwerty472123@gmail.com>
Date:   Tue Sep 17 09:41:04 2024 +0000

    mm: call the security_mmap_file() LSM hook in remap_file_pages()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1554a99f980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1754a99f980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1354a99f980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1cd571a672400ef3a930@syzkaller.appspotmail.com
Fixes: ea7e2d5e49c0 ("mm: call the security_mmap_file() LSM hook in remap_file_pages()")

mmap: syz-executor369 (5231) uses deprecated remap_file_pages() syscall. See Documentation/mm/remap_file_pages.rst.
======================================================
WARNING: possible circular locking dependency detected
6.11.0-syzkaller-10045-g97d8894b6f4c #0 Not tainted
------------------------------------------------------
syz-executor369/5231 is trying to acquire lock:
ffff888072852370 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:815 [inline]
ffff888072852370 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}, at: process_measurement+0x439/0x1fb0 security/integrity/ima/ima_main.c:250

but task is already holding lock:
ffff88807ac9a798 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:122 [inline]
ffff88807ac9a798 (&mm->mmap_lock){++++}-{3:3}, at: __do_sys_remap_file_pages mm/mmap.c:1649 [inline]
ffff88807ac9a798 (&mm->mmap_lock){++++}-{3:3}, at: __se_sys_remap_file_pages+0x22d/0xa50 mm/mmap.c:1624

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&mm->mmap_lock){++++}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
       down_read_killable+0xca/0xd30 kernel/locking/rwsem.c:1549
       mmap_read_lock_killable+0x1d/0x70 include/linux/mmap_lock.h:153
       get_mmap_lock_carefully mm/memory.c:6108 [inline]
       lock_mm_and_find_vma+0x29c/0x2f0 mm/memory.c:6159
       do_user_addr_fault arch/x86/mm/fault.c:1361 [inline]
       handle_page_fault arch/x86/mm/fault.c:1481 [inline]
       exc_page_fault+0x1bf/0x8c0 arch/x86/mm/fault.c:1539
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
       fault_in_readable+0x108/0x2b0 mm/gup.c:2227
       fault_in_iov_iter_readable+0x229/0x280 lib/iov_iter.c:94
       generic_perform_write+0x259/0x6d0 mm/filemap.c:4040
       shmem_file_write_iter+0xf9/0x120 mm/shmem.c:3221
       new_sync_write fs/read_write.c:590 [inline]
       vfs_write+0xa6d/0xc90 fs/read_write.c:683
       ksys_write+0x183/0x2b0 fs/read_write.c:736
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&sb->s_type->i_mutex_key#12){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3158 [inline]
       check_prevs_add kernel/locking/lockdep.c:3277 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3901
       __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5199
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
       down_write+0x99/0x220 kernel/locking/rwsem.c:1579
       inode_lock include/linux/fs.h:815 [inline]
       process_measurement+0x439/0x1fb0 security/integrity/ima/ima_main.c:250
       ima_file_mmap+0x13d/0x2b0 security/integrity/ima/ima_main.c:455
       security_mmap_file+0x7e7/0xa40 security/security.c:2977
       __do_sys_remap_file_pages mm/mmap.c:1692 [inline]
       __se_sys_remap_file_pages+0x6e6/0xa50 mm/mmap.c:1624
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&mm->mmap_lock);
                               lock(&sb->s_type->i_mutex_key#12);
                               lock(&mm->mmap_lock);
  lock(&sb->s_type->i_mutex_key#12);

 *** DEADLOCK ***

1 lock held by syz-executor369/5231:
 #0: ffff88807ac9a798 (&mm->mmap_lock){++++}-{3:3}, at: mmap_write_lock_killable include/linux/mmap_lock.h:122 [inline]
 #0: ffff88807ac9a798 (&mm->mmap_lock){++++}-{3:3}, at: __do_sys_remap_file_pages mm/mmap.c:1649 [inline]
 #0: ffff88807ac9a798 (&mm->mmap_lock){++++}-{3:3}, at: __se_sys_remap_file_pages+0x22d/0xa50 mm/mmap.c:1624

stack backtrace:
CPU: 1 UID: 0 PID: 5231 Comm: syz-executor369 Not tainted 6.11.0-syzkaller-10045-g97d8894b6f4c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2203
 check_prev_add kernel/locking/lockdep.c:3158 [inline]
 check_prevs_add kernel/locking/lockdep.c:3277 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3901
 __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5199
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
 down_write+0x99/0x220 kernel/locking/rwsem.c:1579
 inode_lock include/linux/fs.h:815 [inline]
 process_measurement+0x439/0x1fb0 security/integrity/ima/ima_main.c:250
 ima_file_mmap+0x13d/0x2b0 security/integrity/ima/ima_main.c:455
 security_mmap_file+0x7e7/0xa40 security/security.c:2977
 __do_sys_remap_file_pages mm/mmap.c:1692 [inline]
 __se_sys_remap_file_pages+0x6e6/0xa50 mm/mmap.c:1624
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff317efa919
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff317e94238 EFLAGS: 00000246 ORIG_RAX: 00000000000000d8
RAX: ffffffffffffffda RBX: 00007ff317f85318 RCX: 00007ff317efa919
RDX: 0000000000000000 RSI: 0000000000800000 RDI: 0000000020800000
RBP: 00007ff317f85310 R08: 0000000000010000 R09: 00007ff317e946c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ff317f8531c
R13: 000000000000006e R14: 00007ffd154a5180 R15: 00007ffd154a5268
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

