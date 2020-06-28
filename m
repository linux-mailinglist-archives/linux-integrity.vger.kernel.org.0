Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7711F20C596
	for <lists+linux-integrity@lfdr.de>; Sun, 28 Jun 2020 05:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgF1DbO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 27 Jun 2020 23:31:14 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:47614 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgF1DbO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 27 Jun 2020 23:31:14 -0400
Received: by mail-il1-f197.google.com with SMTP id o2so9629260ilg.14
        for <linux-integrity@vger.kernel.org>; Sat, 27 Jun 2020 20:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=0xNYRJYAIHEjL9wq2M9xDbIQUfYFJfWWGqedzbOS0HA=;
        b=bt4K6BLxo9Xy5pMi+owu5rQLAexxcOyn9GcNidpFOLfvY81UACODBoKBwxsWIiv2WU
         TzODWB6tsgBJvrbQFhZgUhaBHyPSX4Y2sE9xBAIy6I+9iKaNcrMEx6hk5/IMt4PYIL9l
         uAyd5y95PpURQuX4jfljfPuh2zKwqT8WKSJVrmDbIjiKNqKadOH0hW0WUbCF3clly6iM
         yTiahDjdiW171f+9vSmi1bGjv3G8NXlIWc7L9IEjOF1tqEQojJ98ypMNG4F2lvKLHcjX
         MX4ieTq+hTuXR9TrhjCtSofFJrm000nVRnfG6KYYX9BjRdZj0EZs7aeUjibqWGyiRR4l
         NnGQ==
X-Gm-Message-State: AOAM531A+sAH+q7sioOvOfD2jVik6ajEc+rgjX7LXgq+SgLT5TaPSa1d
        jY6ZyPUZzUyj9QXWFot9UYybsYgo6GFEuUhB2OPOpCtxNBjf
X-Google-Smtp-Source: ABdhPJyBHD9qb0wx18+r97n64RX4hsQwqokkX1lem1spwM9037Cwrof9IpNr27CpYGDDTS3nK1qykofr/VxcugC8OrB4eVFlWtqb
MIME-Version: 1.0
X-Received: by 2002:a92:409a:: with SMTP id d26mr10516321ill.200.1593315073205;
 Sat, 27 Jun 2020 20:31:13 -0700 (PDT)
Date:   Sat, 27 Jun 2020 20:31:13 -0700
In-Reply-To: <000000000000880dcc0598bcfac9@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f42b3b05a91c9223@google.com>
Subject: Re: possible deadlock in process_measurement (2)
From:   syzbot <syzbot+18a1619cceea30ed45af@syzkaller.appspotmail.com>
To:     dmitry.kasatkin@gmail.com, jmorris@namei.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    1590a2e1 Merge tag 'acpi-5.8-rc3' of git://git.kernel.org/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=164b959b100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20c907630cbdbe5
dashboard link: https://syzkaller.appspot.com/bug?extid=18a1619cceea30ed45af
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=117f43c5100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17cbb239100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+18a1619cceea30ed45af@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.8.0-rc2-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor165/6816 is trying to acquire lock:
ffff888092f48080 (&iint->mutex){+.+.}-{3:3}, at: process_measurement+0x66d/0x18e0 security/integrity/ima/ima_main.c:247

but task is already holding lock:
ffff888214040450 (sb_writers#4){.+.+}-{0:0}, at: sb_start_write include/linux/fs.h:1664 [inline]
ffff888214040450 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x45/0x90 fs/namespace.c:354

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (sb_writers#4){.+.+}-{0:0}:
       lock_acquire+0x160/0x720 kernel/locking/lockdep.c:4959
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write+0x14b/0x410 fs/super.c:1672
       sb_start_write include/linux/fs.h:1664 [inline]
       mnt_want_write+0x45/0x90 fs/namespace.c:354
       ovl_maybe_copy_up+0x117/0x180 fs/overlayfs/copy_up.c:961
       ovl_open+0xa2/0x200 fs/overlayfs/file.c:145
       do_dentry_open+0x813/0x1070 fs/open.c:828
       vfs_open fs/open.c:942 [inline]
       dentry_open+0xc6/0x120 fs/open.c:958
       ima_calc_file_hash+0xfa/0x1f30 security/integrity/ima/ima_crypto.c:557
       ima_collect_measurement+0x1fd/0x490 security/integrity/ima/ima_api.c:250
       process_measurement+0xddf/0x18e0 security/integrity/ima/ima_main.c:324
       ima_file_check+0x9c/0xe0 security/integrity/ima/ima_main.c:492
       do_open fs/namei.c:3245 [inline]
       path_openat+0x27d6/0x37f0 fs/namei.c:3360
       do_filp_open+0x191/0x3a0 fs/namei.c:3387
       do_sys_openat2+0x463/0x770 fs/open.c:1179
       do_sys_open fs/open.c:1195 [inline]
       ksys_open include/linux/syscalls.h:1388 [inline]
       __do_sys_open fs/open.c:1201 [inline]
       __se_sys_open fs/open.c:1199 [inline]
       __x64_sys_open+0x1af/0x1e0 fs/open.c:1199
       do_syscall_64+0x73/0xe0 arch/x86/entry/common.c:359
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #0 (&iint->mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:2496 [inline]
       check_prevs_add kernel/locking/lockdep.c:2601 [inline]
       validate_chain+0x1b0c/0x8920 kernel/locking/lockdep.c:3218
       __lock_acquire+0x116c/0x2c30 kernel/locking/lockdep.c:4380
       lock_acquire+0x160/0x720 kernel/locking/lockdep.c:4959
       __mutex_lock_common+0x189/0x2fc0 kernel/locking/mutex.c:956
       __mutex_lock kernel/locking/mutex.c:1103 [inline]
       mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:1118
       process_measurement+0x66d/0x18e0 security/integrity/ima/ima_main.c:247
       ima_file_check+0x9c/0xe0 security/integrity/ima/ima_main.c:492
       do_open fs/namei.c:3245 [inline]
       path_openat+0x27d6/0x37f0 fs/namei.c:3360
       do_filp_open+0x191/0x3a0 fs/namei.c:3387
       do_sys_openat2+0x463/0x770 fs/open.c:1179
       do_sys_open fs/open.c:1195 [inline]
       __do_sys_openat fs/open.c:1209 [inline]
       __se_sys_openat fs/open.c:1204 [inline]
       __x64_sys_openat+0x1c8/0x1f0 fs/open.c:1204
       do_syscall_64+0x73/0xe0 arch/x86/entry/common.c:359
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(sb_writers#4);
                               lock(&iint->mutex);
                               lock(sb_writers#4);
  lock(&iint->mutex);

 *** DEADLOCK ***

1 lock held by syz-executor165/6816:
 #0: ffff888214040450 (sb_writers#4){.+.+}-{0:0}, at: sb_start_write include/linux/fs.h:1664 [inline]
 #0: ffff888214040450 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x45/0x90 fs/namespace.c:354

stack backtrace:
CPU: 1 PID: 6816 Comm: syz-executor165 Not tainted 5.8.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1f0/0x31e lib/dump_stack.c:118
 print_circular_bug+0xc72/0xea0 kernel/locking/lockdep.c:1703
 check_noncircular+0x1fb/0x3a0 kernel/locking/lockdep.c:1827
 check_prev_add kernel/locking/lockdep.c:2496 [inline]
 check_prevs_add kernel/locking/lockdep.c:2601 [inline]
 validate_chain+0x1b0c/0x8920 kernel/locking/lockdep.c:3218
 __lock_acquire+0x116c/0x2c30 kernel/locking/lockdep.c:4380
 lock_acquire+0x160/0x720 kernel/locking/lockdep.c:4959
 __mutex_lock_common+0x189/0x2fc0 kernel/locking/mutex.c:956
 __mutex_lock kernel/locking/mutex.c:1103 [inline]
 mutex_lock_nested+0x1a/0x20 kernel/locking/mutex.c:1118
 process_measurement+0x66d/0x18e0 security/integrity/ima/ima_main.c:247
 ima_file_check+0x9c/0xe0 security/integrity/ima/ima_main.c:492
 do_open fs/namei.c:3245 [inline]
 path_openat+0x27d6/0x37f0 fs/namei.c:3360
 do_filp_open+0x191/0x3a0 fs/namei.c:3387
 do_sys_openat2+0x463/0x770 fs/open.c:1179
 do_sys_open fs/open.c:1195 [inline]
 __do_sys_openat fs/open.c:1209 [inline]
 __se_sys_openat fs/open.c:1204 [inline]
 __x64_sys_openat+0x1c8/0x1f0 fs/open.c:1204
 do_syscall_64+0x73/0xe0 arch/x86/entry/common.c:359
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x446289
Code: Bad RIP value.
RSP: 002b:00007fc5eb6ccdb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00000000006dbc48 RCX: 0000000000446289
RDX: 000000000000275a RSI: 00000000200001c0 RDI: 00000000ffffff9c
RBP: 00000000006dbc40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000

