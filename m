Return-Path: <linux-integrity+bounces-6287-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF63ABFC83
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 19:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D05253BC91F
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 17:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E1527CB0D;
	Wed, 21 May 2025 17:47:32 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83E719F42F
	for <linux-integrity@vger.kernel.org>; Wed, 21 May 2025 17:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747849652; cv=none; b=OWj3zd/7VllmJIR91OPkkE8Aj+dyjb2bZ9gNvsX2rdgTfxSg0GDIma5SdZCgJl9MElbXMttL9XAO857J9GAvbSg2SkuG/1SimrDuyMUkoNv0zjF5wSBGwjqg7wCyNe0MDksAEF8IwUXeAqJeGnh82SsfJkxyNsipnjDzfgwzTTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747849652; c=relaxed/simple;
	bh=miR8lyLraFkbpXwdmCbNKFQvHvtAU72aRD8h6kj2LRI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mJ48SweOhqeraoZ9jWgSCRyHcLFZ9GRbSxtcuIFb8VrfyZ4FtFI+MSlkVucl8WGxqxeCFMetqEETTHMtszVh/ASC/ChOgoEbaeYVRtVcUzvr6YXqBs0M67nn5jJsoUhKwT43txb0d8OZ/yluscc2q2Rr94Tfw9zZh8aW48aj02g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3dc879a9d68so10861045ab.0
        for <linux-integrity@vger.kernel.org>; Wed, 21 May 2025 10:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747849650; x=1748454450;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GFRlxxr5q/oFiqmYoyxlbBF5QhEAtZh2WG5O57V5aw8=;
        b=vsgUMz7oYpv96n2rLxCSRlLzluDaHy0VGR73GpMelJi1L6J228Ls+iW79i0BPG04MF
         Dq3OG4PRKxw1oTRy1dDpnxPqf6dsiX2/C41+937KKPxRQin5gUxPgXzSyrnRKdF3IWeL
         EW0LrILbI7yKWd9QtwIR2wpApclQKMEzC0Bikv7A0WlIg7i4JCZGIln+s7ga+6EaaBUM
         HJiVCzcon9TboHUbkPyox8ozNGMkKocDHSR0ysud0qFv1JZXLbabzbSihszYMprVO1MJ
         uUf+mthMV12234jPo3SqHZoRXywbatassJp56SuZNUnmUz9szXo1HCPBYJJD3JcVNUYE
         ZfGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1tEl6VszfaSa7W2GqrZDJtQstJzas3Kjs0czeNng+qyTK5D8D9ZB0WlLAQVfumCwSf3i6LMOAcphdo+2yp3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyySwyyOXUrEXDecbazuGrdyM3R0M+sIJsFyL5tcoey4dA+UTz5
	5n84f2bo+4JvRiJABK3mUG76nj002LrWDsfMW8/I2KYIW/Knea1B7krPsrDHJkUUJf2jx0wFv4X
	Gf5/lDtvylnZGKbgoUs8/T3z6KzMGmRgMWoWr9Lc/tMQv71BkYnFyuSfuTI8=
X-Google-Smtp-Source: AGHT+IHgAaPQ0lG4Qb3DlcMMS8TnBYFKFtvsykayCG6Bt+L/0n3F80q+nU1nO17Pm6I0dP6ygR87LyenQ3hXLXUX714DlADdD654
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1745:b0:3d9:36a8:3d98 with SMTP id
 e9e14a558f8ab-3db84296deemr261924655ab.2.1747849649857; Wed, 21 May 2025
 10:47:29 -0700 (PDT)
Date: Wed, 21 May 2025 10:47:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <682e11b1.050a0220.ade60.09e5.GAE@google.com>
Subject: [syzbot] [integrity?] [lsm?] INFO: task hung in process_measurement (3)
From: syzbot <syzbot+cb9e66807bcb882cd0c5@syzkaller.appspotmail.com>
To: bfoster@redhat.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	jmorris@namei.org, kent.overstreet@linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	roberto.sassu@huawei.com, serge@hallyn.com, syzkaller-bugs@googlegroups.com, 
	zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    172a9d94339c Merge tag '6.15-rc6-smb3-client-fixes' of git..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=142a5ef4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea35e429f965296e
dashboard link: https://syzkaller.appspot.com/bug?extid=cb9e66807bcb882cd0c5
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16836e70580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1617a2d4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c7d5b496fd25/disk-172a9d94.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/965a0ad50b10/vmlinux-172a9d94.xz
kernel image: https://storage.googleapis.com/syzbot-assets/62675d801af8/bzImage-172a9d94.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/a11594a5d459/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/84492c682353/mount_4.gz

The issue was bisected to:

commit 1d16c605cc55ef26f0c65b362665a6c99080ccbc
Author: Kent Overstreet <kent.overstreet@linux.dev>
Date:   Thu Nov 9 19:22:46 2023 +0000

    bcachefs: Disk space accounting rewrite

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13f61e70580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=100e1e70580000
console output: https://syzkaller.appspot.com/x/log.txt?x=17f61e70580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cb9e66807bcb882cd0c5@syzkaller.appspotmail.com
Fixes: 1d16c605cc55 ("bcachefs: Disk space accounting rewrite")

INFO: task syz-executor236:5862 blocked for more than 143 seconds.
      Not tainted 6.15.0-rc6-syzkaller-00278-g172a9d94339c #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor236 state:D stack:26936 pid:5862  tgid:5849  ppid:5845   task_flags:0x400140 flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x168f/0x4c70 kernel/sched/core.c:6767
 __schedule_loop kernel/sched/core.c:6845 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6860
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6917
 rwsem_down_write_slowpath+0xbec/0x1030 kernel/locking/rwsem.c:1176
 __down_write_common kernel/locking/rwsem.c:1304 [inline]
 __down_write kernel/locking/rwsem.c:1313 [inline]
 down_write+0x1ab/0x1f0 kernel/locking/rwsem.c:1578
 inode_lock include/linux/fs.h:867 [inline]
 process_measurement+0x3d8/0x1a40 security/integrity/ima/ima_main.c:260
 ima_file_check+0xd7/0x120 security/integrity/ima/ima_main.c:613
 security_file_post_open+0xbb/0x290 security/security.c:3130
 do_open fs/namei.c:3882 [inline]
 path_openat+0x2f26/0x3830 fs/namei.c:4039
 do_filp_open+0x1fa/0x410 fs/namei.c:4066
 do_sys_openat2+0x121/0x1c0 fs/open.c:1429
 do_sys_open fs/open.c:1444 [inline]
 __do_sys_creat fs/open.c:1522 [inline]
 __se_sys_creat fs/open.c:1516 [inline]
 __x64_sys_creat+0x8f/0xc0 fs/open.c:1516
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd31f9f4ef9
RSP: 002b:00007fd31f95f218 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007fd31fa9b6e8 RCX: 00007fd31f9f4ef9
RDX: ffffffffffffffb0 RSI: c9028ba210c11e9b RDI: 00002000000000c0
RBP: 00007fd31fa9b6e0 R08: 0000000000000000 R09: 0000000000000000
R10: 00007ffcb62f60c7 R11: 0000000000000246 R12: 00007fd31fa67314
R13: 00002000000000c0 R14: 0030656c69662f2e R15: 00007ffcb62f60c8
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffffffff8df3dce0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8df3dce0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8df3dce0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6764
1 lock held by kworker/u8:3/53:
 #0: ffff8880b88399d8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:605
1 lock held by klogd/5178:
 #0: ffff8880b88399d8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:605
2 locks held by getty/5577:
 #0: ffff8880340120a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900036ec2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x43e/0x1400 drivers/tty/n_tty.c:2222
3 locks held by syz-executor236/5850:
 #0: ffff888078b629b8 (&f->f_pos_lock){+.+.}-{4:4}, at: fdget_pos+0x247/0x320 fs/file.c:1213
 #1: ffff88823bfbe420 (sb_writers#9){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:3041 [inline]
 #1: ffff88823bfbe420 (sb_writers#9){.+.+}-{0:0}, at: vfs_write+0x211/0xa90 fs/read_write.c:680
 #2: ffff8880761b08e0 (&sb->s_type->i_mutex_key#14){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:867 [inline]
 #2: ffff8880761b08e0 (&sb->s_type->i_mutex_key#14){+.+.}-{4:4}, at: bch2_direct_write+0x267/0x2d50 fs/bcachefs/fs-io-direct.c:612
2 locks held by syz-executor236/5862:
 #0: ffff88823bfbe420 (sb_writers#9){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:556
 #1: ffff8880761b08e0 (&sb->s_type->i_mutex_key#14){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:867 [inline]
 #1: ffff8880761b08e0 (&sb->s_type->i_mutex_key#14){+.+.}-{4:4}, at: process_measurement+0x3d8/0x1a40 security/integrity/ima/ima_main.c:260

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted 6.15.0-rc6-syzkaller-00278-g172a9d94339c #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:158 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:274 [inline]
 watchdog+0xfee/0x1030 kernel/hung_task.c:437
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.15.0-rc6-syzkaller-00278-g172a9d94339c #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:pv_native_safe_halt+0x13/0x20 arch/x86/kernel/paravirt.c:81
Code: 43 d4 02 00 cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d a3 9f 18 00 f3 0f 1e fa fb f4 <e9> 18 d4 02 00 cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90000197de0 EFLAGS: 000002c6
RAX: a55f7e0638390b00 RBX: ffffffff81977048 RCX: a55f7e0638390b00
RDX: 0000000000000001 RSI: ffffffff8d73a84c RDI: ffffffff8bc12000
RBP: ffffc90000197f20 R08: ffff8880b8932b5b R09: 1ffff1101712656b
R10: dffffc0000000000 R11: ffffed101712656c R12: ffffffff8f7e0670
R13: 0000000000000001 R14: 0000000000000001 R15: 1ffff110038dcb40
FS:  0000000000000000(0000) GS:ffff8881261f6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055b5f126d168 CR3: 000000000dd38000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
 default_idle+0x13/0x20 arch/x86/kernel/process.c:748
 default_idle_call+0x74/0xb0 kernel/sched/idle.c:117
 cpuidle_idle_call kernel/sched/idle.c:185 [inline]
 do_idle+0x1e8/0x510 kernel/sched/idle.c:325
 cpu_startup_entry+0x44/0x60 kernel/sched/idle.c:423
 start_secondary+0x101/0x110 arch/x86/kernel/smpboot.c:315
 common_startup_64+0x13e/0x147
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

