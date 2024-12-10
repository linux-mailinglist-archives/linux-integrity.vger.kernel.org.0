Return-Path: <linux-integrity+bounces-4323-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 694E59EAE10
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Dec 2024 11:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0E2A1684D9
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Dec 2024 10:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A4019CCEA;
	Tue, 10 Dec 2024 10:35:05 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D2B19C56D
	for <linux-integrity@vger.kernel.org>; Tue, 10 Dec 2024 10:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733826905; cv=none; b=pItWZZWDdlkDxrEIvqqGGyQMeZnrP7+hSZFDDZxJEWlwwED7gmDkXUNa7K3DZcQWPVZIMmxGQRvWq3WuHsz66VQ37Pu5YTUDtCv0E6aq22GQ+B6MYgq1jP4QhLJe9/8ee1LyFmv6p0OUn0npLR2Lhq0LJN4tIwe5WlF4v99ASp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733826905; c=relaxed/simple;
	bh=SZvLZb8LJ83CPH+p6l86Jqxrq52dX/h547WXFvcLcxs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pFXGXFrU2nVmXlwM06ijQYGvCeFn8g1jjd8pJ+f/VWBKchLEzYRqLxS9oP9glIFOzQZA717BjOsEm8Af7ot2Lq52rE8+2jNzVpNo5xQqmYOhkUg32xg028pQ5QkcUr75pxRIEo/Q4PZEv2f7HSlRbwtufDbgbOAkegfure/SAAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a9c9b37244so57078495ab.1
        for <linux-integrity@vger.kernel.org>; Tue, 10 Dec 2024 02:35:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733826902; x=1734431702;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VC+SMiTXtre78bS7Zdr5uFV1mKmHkgEI3uk0Wk9COkg=;
        b=CzyNfCCdEvonaP3PIZYN314Z7vMdQmDc22oprHaE1lhkl5sh+Jl1XxOu3tXKtVB/Wh
         UMnK9z/bEYcGlDjjSAUaPh/0zTYBUxIgWI4s24VNLDS8KyjC0x1bts00hRmHJGowtoDP
         DZkBeHwfGOr/jSJGLvEaT4Vw4/++kxanmg+hmj/aWZVO2Kf4p+upAYR36OFPFWdoTLP4
         4IYHVY/a6n2lc/lCvIwUDR3bDFfmjLY4TC2M3UBW/j/yXv8pFVDiCwz2tnKepercBVLF
         DtX1yeEmcmNnDmy+jjUiB3ZZRvm+BKiPjQJPvPFaiu6AYmPFyStkxZrGAeGH4piRmjQ2
         3bXA==
X-Forwarded-Encrypted: i=1; AJvYcCU3vIB3se9NGTLG3p0zg154ZUkKyR4aBZTpj6Nyv217zVRiB/gP+87fWkBmQQAQiw1UE7zhwSERa2LJ2U4Y9IE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcImgiojyBzwdyabxnSxVLdetaudC+a+XJABJEcO6l4wRXHPuy
	6l7KGh2RneySBbsxdvjAKNEkn4p9WTPcEp9yKAQAUOZdt9pU29okplXMOf5BCsSKpjM2M/3XbxZ
	48EN2Bft/IUnQSDdad/jGe8FRGCmKIuoDAINGAOF8Zdj8+QE0zBX50y8=
X-Google-Smtp-Source: AGHT+IH97RZpvW5HA6DibJBMkppYalSOHlksJy7dQMgihBd0Ajpp3m0E2QCQhknaa0Mvme2+EV22hlnMk4OqeJa7Szte6fcM5aAe
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca7:b0:3a7:776e:93fb with SMTP id
 e9e14a558f8ab-3a811d9c851mr172747695ab.8.1733826902234; Tue, 10 Dec 2024
 02:35:02 -0800 (PST)
Date: Tue, 10 Dec 2024 02:35:02 -0800
In-Reply-To: <PUZPR04MB6316E131A563A11DB08B9C54813D2@PUZPR04MB6316.apcprd04.prod.outlook.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67581956.050a0220.a30f1.01c8.GAE@google.com>
Subject: Re: [syzbot] [integrity?] [lsm?] INFO: task hung in
 process_measurement (2)
From: syzbot <syzbot+1de5a37cb85a2d536330@syzkaller.appspotmail.com>
To: andy.wu@sony.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, hpa@zytor.com, 
	jmorris@namei.org, linkinjeon@kernel.org, linux-integrity@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	mingo@redhat.com, paul@paul-moore.com, roberto.sassu@huawei.com, 
	serge@hallyn.com, sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de, wataru.aoyama@sony.com, x86@kernel.org, 
	yuezhang.mo@sony.com, zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
INFO: task hung in process_measurement

INFO: task syz.0.15:6594 blocked for more than 143 seconds.
      Not tainted 6.13.0-rc2-syzkaller-00018-g7cb1b4663150-dirty #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.15        state:D
 stack:25784 pid:6594  tgid:6585  ppid:6461   flags:0x00004006
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
RIP: 0033:0x7f928277fed9
RSP: 002b:00007f92834c6058 EFLAGS: 00000246
 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 00007f9282946080 RCX: 00007f928277fed9
RDX: 0000000000000008 RSI: 0000000000002000 RDI: 0000000020001b80
RBP: 00007f92827f3cc8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f9282946080 R15: 00007ffee74328d8
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/u8:0/11:
 #0: 
ffff88801ac89148
 (
(wq_completion)events_unbound){+.+.}-{0:0}
, at: process_one_work kernel/workqueue.c:3204 [inline]
, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3310
 #1: 
ffffc90000107d00
 (
(linkwatch_work).work
){+.+.}-{0:0}
, at: process_one_work kernel/workqueue.c:3205 [inline]
, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3310
 #2: 
ffffffff8fc9f048
 (
rtnl_mutex
){+.+.}-{4:4}
, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:281
1 lock held by khungtaskd/30:
 #0: 
ffffffff8e937ae0
 (
rcu_read_lock
){....}-{1:3}
, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6744
5 locks held by kworker/u8:4/67:
 #0: 
ffff88801baeb148
 (
(wq_completion)netns
){+.+.}-{0:0}
, at: process_one_work kernel/workqueue.c:3204 [inline]
, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3310
 #1: ffffc9000216fd00
 (
net_cleanup_work
){+.+.}-{0:0}
, at: process_one_work kernel/workqueue.c:3205 [inline]
, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3310
 #2: 
ffffffff8fc92bd0
 (pernet_ops_rwsem
){++++}-{4:4}
, at: cleanup_net+0x16a/0xcc0 net/core/net_namespace.c:586
 #3: ffffffff8fc9f048 (rtnl_mutex){+.+.}-{4:4}
, at: default_device_exit_batch+0xe9/0xaa0 net/core/dev.c:12059
 #4: 
ffffffff8e93cff8
 (
rcu_state.exp_mutex
){+.+.}-{4:4}
, at: exp_funnel_lock kernel/rcu/tree_exp.h:297 [inline]
, at: synchronize_rcu_expedited+0x381/0x830 kernel/rcu/tree_exp.h:976
3 locks held by kworker/u8:6/2960:
 #0: 
ffff888031920948
 (
(wq_completion)ipv6_addrconf
){+.+.}-{0:0}
, at: process_one_work kernel/workqueue.c:3204 [inline]
, at: process_scheduled_works+0x93b/0x1840 kernel/workqueue.c:3310
 #1: 
ffffc9000cb6fd00
 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1840 kernel/workqueue.c:3310
 #2: ffffffff8fc9f048 (rtnl_mutex){+.+.}-{4:4}, at: addrconf_verify_work+0x19/0x30 net/ipv6/addrconf.c:4755
1 lock held by dhcpcd/5489:
 #0: ffffffff8fc9f048 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fc9f048 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:326 [inline]
 #0: ffffffff8fc9f048 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0xbb0/0x20e0 net/core/rtnetlink.c:4008
2 locks held by getty/5573:
 #0: ffff888031f740a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000330b2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
5 locks held by syz.0.15/6586:
1 lock held by syz.0.15/6594:
 #0: ffff888060c982a0 (&sb->s_type->i_mutex_key#21){++++}-{4:4}, at: inode_lock include/linux/fs.h:818 [inline]
 #0: ffff888060c982a0 (&sb->s_type->i_mutex_key#21){++++}-{4:4}, at: process_measurement+0x439/0x1fb0 security/integrity/ima/ima_main.c:250
5 locks held by syz.1.16/6692:
1 lock held by syz.1.16/6693:
 #0: ffff888060c98f80 (&sb->s_type->i_mutex_key
#21
){++++}-{4:4}
, at: inode_lock include/linux/fs.h:818 [inline]
, at: process_measurement+0x439/0x1fb0 security/integrity/ima/ima_main.c:250
10 locks held by syz.2.17/6709:
1 lock held by syz.2.17/6710:
 #0: 
ffff888075bb0f80
 (&sb->s_type->i_mutex_key
#21
){++++}-{4:4}
, at: inode_lock include/linux/fs.h:818 [inline]
, at: process_measurement+0x439/0x1fb0 security/integrity/ima/ima_main.c:250
2 locks held by syz-executor/6737:
 #0: ffffffff90187a68
 (
&ops->srcu
#2
){.+.+}-{0:0}
, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
, at: rtnl_link_ops_get+0x22/0x250 net/core/rtnetlink.c:555
 #1: 
ffffffff8fc9f048
 (
rtnl_mutex){+.+.}-{4:4}
, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
, at: rtnl_nets_lock net/core/rtnetlink.c:326 [inline]
, at: rtnl_newlink+0xbb0/0x20e0 net/core/rtnetlink.c:4008

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.13.0-rc2-syzkaller-00018-g7cb1b4663150-dirty #0
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
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 6709 Comm: syz.2.17 Not tainted 6.13.0-rc2-syzkaller-00018-g7cb1b4663150-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:io_serial_in+0x76/0xb0 drivers/tty/serial/8250/8250_port.c:409
Code: 90 35 57 fc 89 e9 41 d3 e6 48 83 c3 40 48 89 d8 48 c1 e8 03 42 80 3c 38 00 74 08 48 89 df e8 d1 09 bb fc 44 03 33 44 89 f2 ec <0f> b6 c0 5b 41 5e 41 5f 5d c3 cc cc cc cc 89 e9 80 e1 07 38 c1 7c
RSP: 0018:ffffc900032c6cd8 EFLAGS: 00000002
RAX: 1ffffffff34d7400 RBX: ffffffff9a6ba5e0 RCX: 0000000000000000
RDX: 00000000000003fd RSI: 0000000000000000 RDI: 0000000000000020
RBP: 0000000000000000 R08: ffffffff85482856 R09: 1ffff11004bed046
R10: dffffc0000000000 R11: ffffffff85482810 R12: dffffc0000000000
R13: ffffffff9a3b4f70 R14: 00000000000003fd R15: dffffc0000000000
FS:  00007ff0221986c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005576d5d24d98 CR3: 0000000034c90000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 serial_in drivers/tty/serial/8250/8250.h:137 [inline]
 serial_lsr_in drivers/tty/serial/8250/8250.h:159 [inline]
 wait_for_lsr drivers/tty/serial/8250/8250_port.c:2087 [inline]
 serial8250_console_fifo_write drivers/tty/serial/8250/8250_port.c:3334 [inline]
 serial8250_console_write+0x1373/0x1ed0 drivers/tty/serial/8250/8250_port.c:3412
 console_emit_next_record kernel/printk/printk.c:3122 [inline]
 console_flush_all+0x869/0xeb0 kernel/printk/printk.c:3210
 __console_flush_and_unlock kernel/printk/printk.c:3269 [inline]
 console_unlock+0x14f/0x3b0 kernel/printk/printk.c:3309
 vprintk_emit+0x730/0xa10 kernel/printk/printk.c:2432
 _printk+0xd5/0x120 kernel/printk/printk.c:2457
 __exfat_free_cluster+0x701/0xa00 fs/exfat/fatent.c:213
 exfat_free_cluster+0x77/0xd0 fs/exfat/fatent.c:234
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
RIP: 0033:0x7ff02137fed9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff022198058 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
RAX: ffffffffffffffda RBX: 00007ff021545fa0 RCX: 00007ff02137fed9
RDX: 0000000000000000 RSI: 0000000000000100 RDI: 0000000020000000
RBP: 00007ff0213f3cc8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007ff021545fa0 R15: 00007fffd20e6358
 </TASK>


Tested on:

commit:         7cb1b466 Merge tag 'locking_urgent_for_v6.13_rc3' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=145653e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7c9f223bfe8924e
dashboard link: https://syzkaller.appspot.com/bug?extid=1de5a37cb85a2d536330
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=135868f8580000


