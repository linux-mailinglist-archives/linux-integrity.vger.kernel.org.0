Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 720C610EF78
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Dec 2019 19:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbfLBSpK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Dec 2019 13:45:10 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:50929 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbfLBSpK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Dec 2019 13:45:10 -0500
Received: by mail-io1-f70.google.com with SMTP id t193so261291iof.17
        for <linux-integrity@vger.kernel.org>; Mon, 02 Dec 2019 10:45:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=itCABTGD8qdhBDl50zMwwE7VeQ2i5Gc0+NOJZoEJkF0=;
        b=fw+cVKrAkGbuKiJopzfpdxSgc48o2KzKP7EaNGlc4M8s7l804Nn/Jsd6AGlgQnX3np
         2vjGUlvpOkGgeOgoh2qtjKy5bxJhqBi7JN9pkgBDistF9yTXYg32EXrF/w5ov3atCyBz
         QVsyJVZtxjxztGz5IGimWsMBjbZ5zujRLQXOVSWdNWuXOc6eH23Dtg2hAgo9C2LHV1fg
         A5uGnn2P1fDTFSbYTHjqcClnP6NSy0qvtisgKkdTDmCv5y/vQZKTxVXV9anQH8qVd60O
         MQMC4ePJtjbWvvr8Ckhv7x8zoi+wi3GTboVwEeBHy9mh4/V6sKebdNXYntGHT8g3YVp9
         6hpA==
X-Gm-Message-State: APjAAAVX17GK5p33VXJrbIe+jWhJfRylwRurp6H75E2BHddl8vCdY4aJ
        ZJb1eK81r84a7Upbd4i5Vhsf7jnf+0U6q3HQqiryMEUsQYuL
X-Google-Smtp-Source: APXvYqwIH2+SSVQbUDLmK8P9Y83JayLZp6b4GBVssznSDKXNoVUicLrHRqAEb07CLWNmjC8DqTLUFG4uRqm0DT2C93n7ioURFCvt
MIME-Version: 1.0
X-Received: by 2002:a02:40ca:: with SMTP id n193mr1028204jaa.71.1575312308038;
 Mon, 02 Dec 2019 10:45:08 -0800 (PST)
Date:   Mon, 02 Dec 2019 10:45:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000880dcc0598bcfac9@google.com>
Subject: possible deadlock in process_measurement (2)
From:   syzbot <syzbot+18a1619cceea30ed45af@syzkaller.appspotmail.com>
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

HEAD commit:    81b6b964 Merge branch 'master' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17019696e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=333b76551307b2a0
dashboard link: https://syzkaller.appspot.com/bug?extid=18a1619cceea30ed45af
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+18a1619cceea30ed45af@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.4.0-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.2/596 is trying to acquire lock:
ffff88802b0761a0 (&ovl_i_mutex_key[depth]){+.+.}, at: inode_lock  
include/linux/fs.h:791 [inline]
ffff88802b0761a0 (&ovl_i_mutex_key[depth]){+.+.}, at:  
process_measurement+0x6f4/0x1810 security/integrity/ima/ima_main.c:230

but task is already holding lock:
ffff8880547b07d0 (&sig->cred_guard_mutex){+.+.}, at: prepare_bprm_creds  
fs/exec.c:1409 [inline]
ffff8880547b07d0 (&sig->cred_guard_mutex){+.+.}, at:  
__do_execve_file.isra.0+0x376/0x22b0 fs/exec.c:1754

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&sig->cred_guard_mutex){+.+.}:
        __mutex_lock_common kernel/locking/mutex.c:959 [inline]
        __mutex_lock+0x156/0x13c0 kernel/locking/mutex.c:1106
        mutex_lock_killable_nested+0x16/0x20 kernel/locking/mutex.c:1136
        lock_trace+0x4a/0xe0 fs/proc/base.c:406
        proc_pid_personality+0x1c/0xd0 fs/proc/base.c:2961
        proc_single_show+0xfd/0x1c0 fs/proc/base.c:756
        seq_read+0x4ca/0x1110 fs/seq_file.c:229
        do_loop_readv_writev fs/read_write.c:714 [inline]
        do_loop_readv_writev fs/read_write.c:701 [inline]
        do_iter_read+0x4a4/0x660 fs/read_write.c:935
        vfs_readv+0xf0/0x160 fs/read_write.c:997
        do_preadv+0x1c4/0x280 fs/read_write.c:1089
        __do_sys_preadv fs/read_write.c:1139 [inline]
        __se_sys_preadv fs/read_write.c:1134 [inline]
        __x64_sys_preadv+0x9a/0xf0 fs/read_write.c:1134
        do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #2 (&p->lock){+.+.}:
        __mutex_lock_common kernel/locking/mutex.c:959 [inline]
        __mutex_lock+0x156/0x13c0 kernel/locking/mutex.c:1106
        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1121
        seq_read+0x71/0x1110 fs/seq_file.c:161
        do_loop_readv_writev fs/read_write.c:714 [inline]
        do_loop_readv_writev fs/read_write.c:701 [inline]
        do_iter_read+0x4a4/0x660 fs/read_write.c:935
        vfs_readv+0xf0/0x160 fs/read_write.c:997
        kernel_readv fs/splice.c:359 [inline]
        default_file_splice_read+0x482/0x980 fs/splice.c:414
        do_splice_to+0x127/0x180 fs/splice.c:877
        splice_direct_to_actor+0x2d2/0x970 fs/splice.c:954
        do_splice_direct+0x1da/0x2a0 fs/splice.c:1063
        do_sendfile+0x597/0xd00 fs/read_write.c:1464
        __do_sys_sendfile64 fs/read_write.c:1525 [inline]
        __se_sys_sendfile64 fs/read_write.c:1511 [inline]
        __x64_sys_sendfile64+0x1dd/0x220 fs/read_write.c:1511
        do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #1 (sb_writers#3){.+.+}:
        percpu_down_read include/linux/percpu-rwsem.h:40 [inline]
        __sb_start_write+0x241/0x460 fs/super.c:1672
        sb_start_write include/linux/fs.h:1650 [inline]
        mnt_want_write+0x3f/0xc0 fs/namespace.c:354
        ovl_want_write+0x76/0xa0 fs/overlayfs/util.c:21
        ovl_setattr+0xdd/0x8b0 fs/overlayfs/inode.c:27
        notify_change+0xad7/0xfb0 fs/attr.c:337
        do_truncate+0x158/0x220 fs/open.c:64
        handle_truncate fs/namei.c:2998 [inline]
        do_last fs/namei.c:3414 [inline]
        path_openat+0x2d63/0x46d0 fs/namei.c:3525
        do_filp_open+0x1a1/0x280 fs/namei.c:3555
        do_sys_open+0x3fe/0x5d0 fs/open.c:1097
        ksys_open include/linux/syscalls.h:1385 [inline]
        __do_sys_creat fs/open.c:1155 [inline]
        __se_sys_creat fs/open.c:1153 [inline]
        __x64_sys_creat+0x61/0x80 fs/open.c:1153
        do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (&ovl_i_mutex_key[depth]){+.+.}:
        check_prev_add kernel/locking/lockdep.c:2476 [inline]
        check_prevs_add kernel/locking/lockdep.c:2581 [inline]
        validate_chain kernel/locking/lockdep.c:2971 [inline]
        __lock_acquire+0x2596/0x4a00 kernel/locking/lockdep.c:3955
        lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4485
        down_write+0x93/0x150 kernel/locking/rwsem.c:1534
        inode_lock include/linux/fs.h:791 [inline]
        process_measurement+0x6f4/0x1810  
security/integrity/ima/ima_main.c:230
        ima_file_check+0xc5/0x110 security/integrity/ima/ima_main.c:438
        do_last fs/namei.c:3412 [inline]
        path_openat+0x113d/0x46d0 fs/namei.c:3525
        do_filp_open+0x1a1/0x280 fs/namei.c:3555
        do_open_execat+0x137/0x690 fs/exec.c:857
        __do_execve_file.isra.0+0x1702/0x22b0 fs/exec.c:1762
        do_execveat_common fs/exec.c:1868 [inline]
        do_execve fs/exec.c:1885 [inline]
        __do_sys_execve fs/exec.c:1961 [inline]
        __se_sys_execve fs/exec.c:1956 [inline]
        __x64_sys_execve+0x8f/0xc0 fs/exec.c:1956
        do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
   &ovl_i_mutex_key[depth] --> &p->lock --> &sig->cred_guard_mutex

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&sig->cred_guard_mutex);
                                lock(&p->lock);
                                lock(&sig->cred_guard_mutex);
   lock(&ovl_i_mutex_key[depth]);

  *** DEADLOCK ***

1 lock held by syz-executor.2/596:
  #0: ffff8880547b07d0 (&sig->cred_guard_mutex){+.+.}, at:  
prepare_bprm_creds fs/exec.c:1409 [inline]
  #0: ffff8880547b07d0 (&sig->cred_guard_mutex){+.+.}, at:  
__do_execve_file.isra.0+0x376/0x22b0 fs/exec.c:1754

stack backtrace:
CPU: 1 PID: 596 Comm: syz-executor.2 Not tainted 5.4.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_circular_bug.isra.0.cold+0x163/0x172 kernel/locking/lockdep.c:1685
  check_noncircular+0x32e/0x3e0 kernel/locking/lockdep.c:1809
  check_prev_add kernel/locking/lockdep.c:2476 [inline]
  check_prevs_add kernel/locking/lockdep.c:2581 [inline]
  validate_chain kernel/locking/lockdep.c:2971 [inline]
  __lock_acquire+0x2596/0x4a00 kernel/locking/lockdep.c:3955
  lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4485
  down_write+0x93/0x150 kernel/locking/rwsem.c:1534
  inode_lock include/linux/fs.h:791 [inline]
  process_measurement+0x6f4/0x1810 security/integrity/ima/ima_main.c:230
  ima_file_check+0xc5/0x110 security/integrity/ima/ima_main.c:438
  do_last fs/namei.c:3412 [inline]
  path_openat+0x113d/0x46d0 fs/namei.c:3525
  do_filp_open+0x1a1/0x280 fs/namei.c:3555
  do_open_execat+0x137/0x690 fs/exec.c:857
  __do_execve_file.isra.0+0x1702/0x22b0 fs/exec.c:1762
  do_execveat_common fs/exec.c:1868 [inline]
  do_execve fs/exec.c:1885 [inline]
  __do_sys_execve fs/exec.c:1961 [inline]
  __se_sys_execve fs/exec.c:1956 [inline]
  __x64_sys_execve+0x8f/0xc0 fs/exec.c:1956
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45a679
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffbf4072c78 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045a679
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000040
RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffbf40736d4
R13: 00000000004c0fcd R14: 00000000004d41f0 R15: 00000000ffffffff


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
