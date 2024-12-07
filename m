Return-Path: <linux-integrity+bounces-4316-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6A79E81C8
	for <lists+linux-integrity@lfdr.de>; Sat,  7 Dec 2024 20:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D88228162D
	for <lists+linux-integrity@lfdr.de>; Sat,  7 Dec 2024 19:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461E014C5BF;
	Sat,  7 Dec 2024 19:18:29 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793EF1E529
	for <linux-integrity@vger.kernel.org>; Sat,  7 Dec 2024 19:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733599109; cv=none; b=hcUsemNCITi3UwXFjoiNqaeFHbKOqyt0KsSxUB0QbI7QV+a/MLsHWId+Ge9voSON6Yn6WI9QEHPFGfEW5/iCZ7F6UlVqUvuT/MYrdwGUuG7i0VhCoaSKafgx7O7LiEGrsScXQFsxsKhyLLz+n8l/ZqU55xjEzw2TcjanwhBZD7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733599109; c=relaxed/simple;
	bh=EIz4KabPAj0rOEIFUfsJmLNnGTuKpD/NluN+kyGkwCk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=EfICCul9GEOVXsTB16vYsnSmcdwOeBn5MaPMYzbDml6n1Ivk/p6FPBucPQKhonzpbuRpXn2XdUoH6H727tgq1Z5oKpt+Hc+CuvMD3NWf2pQb8cRbSk4SL2z6KkRIKs06nzEdeyYhq1eCCoA5s35Cu10gP/AhTUa+3gonyuGz9FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3a81570ea43so21266125ab.0
        for <linux-integrity@vger.kernel.org>; Sat, 07 Dec 2024 11:18:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733599106; x=1734203906;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FGzxBGWUGEudtCAKk4uMcizyqM7JNg04s2BYXL8B0TU=;
        b=nNkyZcfQR/p5DG1SMN88vvKX4XzmqNzdkaxr22cbG3briusKxfH340uF8CJZbDJrdb
         5ZBeY5P+tRr9cq1dyX/sRyerAClXYe+jLW7MXnjhRF0oDcqmOGId6YoHsf8AJwewP/dt
         p4EM87syNrhq2PnpXEkCvWcLON8Gs/Wz1Wm9XI+5Xzim9yd3qvTVMtyPcUexwBPzjBYh
         azICBfkFWXXlFsh8RcORU8DK+JE5ytt/SktK7toVaJdJ9Dx6KVBH1hSptWc8FnavegHt
         v85/fBVUBh+B/kz/lqnH+VJ0HcyWSDhdt9+AYogw6FeZq/Oiw19X8aKPYDO81HvOpToB
         PmNA==
X-Forwarded-Encrypted: i=1; AJvYcCVsCbqwkNTg4J2Yt2F0VkJrjQHVttfJqYA30lDrTSMRVnjeLvRliRkYJWzxxrROPj6EYctgxfCvaLc4rQzupEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ4qqEHAq8FfgfT2XlLF1Lnu30Yn7ELQas3utaBByINVvfyLgL
	vtfIMOtSkGZIxtrlmbPujFJ+z1gO/nXcwZlogL9QsfDb09rSLA/FuJw1xnY/DMZ/OMO8xsi0rZi
	x3RzXwAdgAcPsPrpboacNDUYko6S5wdJxX+UPMkPkZKyNegxogwg8vgQ=
X-Google-Smtp-Source: AGHT+IG8yl4utWwy6hc6H+udRwWwIVAHjJvBhuPt6ziB3wiXQseHsYdq66/0AfS33UvSR1/AIsGmWeaGs09y9HzQ2DNo6e2w+zYS
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a24:b0:3a2:6cd7:3250 with SMTP id
 e9e14a558f8ab-3a811d9287cmr70249255ab.10.1733599106629; Sat, 07 Dec 2024
 11:18:26 -0800 (PST)
Date: Sat, 07 Dec 2024 11:18:26 -0800
In-Reply-To: <00000000000065deef0604e8fe03@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67549f82.050a0220.a30f1.0160.GAE@google.com>
Subject: Re: [syzbot] [integrity?] [lsm?] INFO: task hung in
 process_measurement (2)
From: syzbot <syzbot+1de5a37cb85a2d536330@syzkaller.appspotmail.com>
To: dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jmorris@namei.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	roberto.sassu@huawei.com, serge@hallyn.com, syzkaller-bugs@googlegroups.com, 
	zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    b5f217084ab3 Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17307330580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=335e39020523e2ed
dashboard link: https://syzkaller.appspot.com/bug?extid=1de5a37cb85a2d536330
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=126a8820580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=153e70f8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3b2c9b99ecf6/disk-b5f21708.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3458db92b2a8/vmlinux-b5f21708.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e14f0c677748/bzImage-b5f21708.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/928495b63af4/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1de5a37cb85a2d536330@syzkaller.appspotmail.com

INFO: task syz-executor240:5823 blocked for more than 143 seconds.
      Not tainted 6.13.0-rc1-syzkaller-00316-gb5f217084ab3 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor240 state:D stack:25592 pid:5823  tgid:5820  ppid:5819   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x17fb/0x4be0 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6848
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6905
 rwsem_down_write_slowpath+0xeee/0x13b0 kernel/locking/rwsem.c:1176
 __down_write_common kernel/locking/rwsem.c:1304 [inline]
 __down_write kernel/locking/rwsem.c:1313 [inline]
 down_write+0x1d7/0x220 kernel/locking/rwsem.c:1578
 inode_lock include/linux/fs.h:818 [inline]
 process_measurement+0x439/0x1fb0 security/integrity/ima/ima_main.c:250
 ima_file_check+0xd9/0x120 security/integrity/ima/ima_main.c:572
 security_file_post_open+0xb9/0x280 security/security.c:3121
 do_open fs/namei.c:3830 [inline]
 path_openat+0x2ccd/0x3590 fs/namei.c:3987
 do_filp_open+0x27f/0x4e0 fs/namei.c:4014
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1402
 do_sys_open fs/open.c:1417 [inline]
 __do_sys_open fs/open.c:1425 [inline]
 __se_sys_open fs/open.c:1421 [inline]
 __x64_sys_open+0x225/0x270 fs/open.c:1421
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7788ca3409
RSP: 002b:00007f7788c39218 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007f7788d2b5f8 RCX: 00007f7788ca3409
RDX: 0000000000000008 RSI: 0000000000002000 RDI: 0000000020001b80
RBP: 00007f7788d2b5f0 R08: 00007ffddcf3bf57 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f7788d2b5fc
R13: 0032656c69662f2e R14: 00007f7788cf70c0 R15: 00000000200002c0
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e937aa0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937aa0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937aa0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6744
2 locks held by getty/5579:
 #0: ffff888035afa0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000332b2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
5 locks held by syz-executor240/5822:
1 lock held by syz-executor240/5823:
 #0: ffff8880744782a0 (&sb->s_type->i_mutex_key#14){++++}-{4:4}, at: inode_lock include/linux/fs.h:818 [inline]
 #0: ffff8880744782a0 (&sb->s_type->i_mutex_key#14){++++}-{4:4}, at: process_measurement+0x439/0x1fb0 security/integrity/ima/ima_main.c:250

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.13.0-rc1-syzkaller-00316-gb5f217084ab3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:234 [inline]
 watchdog+0xff6/0x1040 kernel/hung_task.c:397
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 5822 Comm: syz-executor240 Not tainted 6.13.0-rc1-syzkaller-00316-gb5f217084ab3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:EXFAT_SB fs/exfat/exfat_fs.h:336 [inline]
RIP: 0010:exfat_ent_get+0x3d/0x400 fs/exfat/fatent.c:88
Code: 89 d7 41 89 f5 49 89 fe 49 bc 00 00 00 00 00 fc ff df e8 46 a5 20 ff 49 8d 9e 38 06 00 00 48 89 d8 48 c1 e8 03 42 80 3c 20 00 <74> 08 48 89 df e8 69 66 88 ff 48 8b 1b bf 01 00 00 00 44 89 ee e8
RSP: 0018:ffffc90003ad7348 EFLAGS: 00000246
RAX: 1ffff11006b350c7 RBX: ffff8880359a8638 RCX: ffff8880343c1e00
RDX: 0000000000000000 RSI: 0000000000000010 RDI: ffff8880359a8000
RBP: ffffc90003ad74b8 R08: ffffffff827ed915 R09: 1ffff1100eef7874
R10: dffffc0000000000 R11: ffffed100eef7875 R12: dffffc0000000000
R13: 0000000000000010 R14: ffff8880359a8000 R15: ffffc90003ad7440
FS:  00007f7788c5a6c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055c822941600 CR3: 00000000783fc000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 __exfat_free_cluster+0x56f/0x990 fs/exfat/fatent.c:200
 exfat_free_cluster+0x77/0xd0 fs/exfat/fatent.c:232
 __exfat_truncate+0x745/0xa60 fs/exfat/file.c:235
 exfat_truncate fs/exfat/file.c:257 [inline]
 exfat_setattr+0x10fa/0x1a90 fs/exfat/file.c:353
 notify_change+0xbca/0xe90 fs/attr.c:552
 do_truncate+0x220/0x310 fs/open.c:65
 handle_truncate fs/namei.c:3449 [inline]
 do_open fs/namei.c:3832 [inline]
 path_openat+0x2e1e/0x3590 fs/namei.c:3987
 do_filp_open+0x27f/0x4e0 fs/namei.c:4014
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1402
 do_sys_open fs/open.c:1417 [inline]
 __do_sys_creat fs/open.c:1495 [inline]
 __se_sys_creat fs/open.c:1489 [inline]
 __x64_sys_creat+0x123/0x170 fs/open.c:1489
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7788ca3409
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7788c5a218 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007f7788d2b5e8 RCX: 00007f7788ca3409
RDX: 00007f7788ca3409 RSI: 0000000000000100 RDI: 0000000020000000
RBP: 00007f7788d2b5e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f7788d2b5ec
R13: 0032656c69662f2e R14: 00007f7788cf70c0 R15: 00000000200002c0
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.409 msecs


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

