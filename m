Return-Path: <linux-integrity+bounces-9344-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id D/7NGJBn72lZBAEAu9opvQ
	(envelope-from <linux-integrity+bounces-9344-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Apr 2026 15:41:36 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D314739D4
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Apr 2026 15:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DFD0303B732
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Apr 2026 13:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DEC3C8732;
	Mon, 27 Apr 2026 13:36:21 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-oo1-f79.google.com (mail-oo1-f79.google.com [209.85.161.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FFD3B2FF4
	for <linux-integrity@vger.kernel.org>; Mon, 27 Apr 2026 13:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777296981; cv=none; b=AjFi7QYYHm86/sgBlHN9f2+HBF17XLUe4po1no94bQdymqwYfGwcV+RgE7t/FPAeh0grpo2vBuhJl5LBEGxyAuIk19OfQ2ZC7ebJZoxR3Ma6+mKYN359A5uRlu6kD+RMFRgBFumf/IY8AkgISPRnIDGNipTs7w6Adhi8AlW4wug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777296981; c=relaxed/simple;
	bh=3cjlvtbiCMKUvQ4+pzEFrkcpMtN8DT/M0MP7m9f3Pr8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KbeB5coUUs/38snNoXXKGPYoLokb5qHAenGROEO4mvFsVyX5B6EExG9TFgAoIq41qUpa/XdsIBqELX6JtrBDp5M+R7HBi+/NZi9dnwfa4xtFZVnPiWl+2YLADjjLQOPJf8IsEfvYiSouWTY1QmAiENVvDKz+1ymFjr2DQVkACuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f79.google.com with SMTP id 006d021491bc7-694885643e1so13958420eaf.3
        for <linux-integrity@vger.kernel.org>; Mon, 27 Apr 2026 06:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777296979; x=1777901779;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W79VFKdnwYOpztsFD9PwpcmbDBrcIAHQaWyCw4ftoJE=;
        b=YP3mjVqcfRBZ1TEUI4fA/Si1xwTGNwQVH1tXA6ZM1yiIdVzc/HudYbZanef63XMkfx
         zy4yxCJS4sD3YeFXcKmECCkTmgsOxqvmjzhosgOCa8+qztG+bpAEZiyY79hbqLAvhCdT
         UXMhrM+XKvTeYzoQgKRMVTvpPBCvDVCA8rWrV2sB8onom13onFxP3hKPorAQb/O3xJqW
         lbgbiyhKlqIzTKV/U39J6YqKnEmDP65o1GIQ8+LyCkB8C08afnfDP2010bfxlVV32Vn1
         wcHrO73v4gGXSn83/6UMFtHgv3FfqYJZ1zJLOEbPEELRoQrBBzA3Gp/Rn8UdTqJYYy3N
         nXKQ==
X-Forwarded-Encrypted: i=1; AFNElJ9mQ2yTWe8c0FiGJ6IoSnh0tlTOeA4HTlQJrKMiA2Bh+UGcGBao1Yx9cQ7pydoqU1sKQZhlJ6kazmqwz+hgITg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB8jq7dzjD5T1pHkRUuu9B2JT1kjzum/ZsfghnXupXWDpamBGE
	5PY0omtfVXjQX93js9MmrbqKeYlBlw0PbEHwUiTeO430ckAqCDb12KETv6TXsFvT4j9DuD6NrtY
	tZiUJoAbkK+l8iPJjVxrAogOJgEyx6zwIDIWH00vKTrau+CxXcc+fOUftoZY=
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2d05:b0:696:32ad:e894 with SMTP id
 006d021491bc7-69632adee68mr4842540eaf.23.1777296979353; Mon, 27 Apr 2026
 06:36:19 -0700 (PDT)
Date: Mon, 27 Apr 2026 06:36:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69ef6653.050a0220.1d2f3.0000.GAE@google.com>
Subject: [syzbot] [integrity?] [lsm?] WARNING: bad unlock balance in __filemap_add_folio
From: syzbot <syzbot+914bc925a90b7e137017@syzkaller.appspotmail.com>
To: dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jmorris@namei.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	roberto.sassu@huawei.com, serge@hallyn.com, syzkaller-bugs@googlegroups.com, 
	zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: A5D314739D4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=80b28e8d6ef9384a];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com,namei.org,vger.kernel.org,paul-moore.com,huawei.com,hallyn.com,googlegroups.com,linux.ibm.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9344-lists,linux-integrity=lfdr.de,914bc925a90b7e137017];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlegroups.com:email,storage.googleapis.com:url,goo.gl:url];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[11];
	SUBJECT_HAS_QUESTION(0.00)[]

Hello,

syzbot found the following issue on:

HEAD commit:    2e6803928193 Merge tag 'tracefs-v7.1-2' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=117dff16580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=80b28e8d6ef9384a
dashboard link: https://syzkaller.appspot.com/bug?extid=914bc925a90b7e137017
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/690094a31275/disk-2e680392.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7d17ea4e1f81/vmlinux-2e680392.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c1478f49f523/bzImage-2e680392.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+914bc925a90b7e137017@syzkaller.appspotmail.com

cgroup: Unknown subsys name 'cpuset'
cgroup: Unknown subsys name 'rlimit'
=====================================
WARNING: bad unlock balance detected!
syzkaller #0 Not tainted
-------------------------------------
syz-executor/5795 is trying to release lock (rcu_read_lock) at:
[<ffffffff8b2f32cf>] rcu_lock_release include/linux/rcupdate.h:310 [inline]
[<ffffffff8b2f32cf>] rcu_read_unlock include/linux/rcupdate.h:869 [inline]
[<ffffffff8b2f32cf>] rt_spin_unlock+0x14f/0x200 kernel/locking/spinlock_rt.c:82
but there are no more locks to release!

other info that might help us debug this:
2 locks held by syz-executor/5795:
 #0: ffff888035e50f58 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}, at: process_measurement+0x7fd/0x1c90 security/integrity/ima/ima_main.c:319
 #1: ffff8880434dc100 (mapping.invalidate_lock#2){++++}-{4:4}, at: filemap_invalidate_lock_shared include/linux/fs.h:1094 [inline]
 #1: ffff8880434dc100 (mapping.invalidate_lock#2){++++}-{4:4}, at: do_page_cache_ra mm/readahead.c:333 [inline]
 #1: ffff8880434dc100 (mapping.invalidate_lock#2){++++}-{4:4}, at: page_cache_ra_order+0x2a5/0x490 mm/readahead.c:538

stack backtrace:
CPU: 1 UID: 0 PID: 5795 Comm: syz-executor Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_unlock_imbalance_bug+0xdc/0xf0 kernel/locking/lockdep.c:5298
 __lock_release kernel/locking/lockdep.c:5537 [inline]
 lock_release+0x248/0x3c0 kernel/locking/lockdep.c:5889
 rcu_lock_release include/linux/rcupdate.h:310 [inline]
 rcu_read_unlock include/linux/rcupdate.h:869 [inline]
 rt_spin_unlock+0x15b/0x200 kernel/locking/spinlock_rt.c:82
 spin_unlock_irq include/linux/spinlock_rt.h:122 [inline]
 __filemap_add_folio+0xc85/0x1200 mm/filemap.c:931
 filemap_add_folio+0x2de/0x610 mm/filemap.c:967
 page_cache_ra_unbounded+0x407/0x980 mm/readahead.c:282
 do_page_cache_ra mm/readahead.c:334 [inline]
 page_cache_ra_order+0x2b5/0x490 mm/readahead.c:538
 filemap_readahead mm/filemap.c:2664 [inline]
 filemap_get_pages+0x832/0x1e70 mm/filemap.c:2710
 filemap_read+0x44a/0x1240 mm/filemap.c:2806
 __kernel_read+0x50d/0x9c0 fs/read_write.c:532
 integrity_kernel_read+0x89/0xd0 security/integrity/iint.c:28
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:222 [inline]
 ima_calc_file_hash+0x452/0x870 security/integrity/ima/ima_crypto.c:280
 ima_collect_measurement+0x523/0x9d0 security/integrity/ima/ima_api.c:300
 process_measurement+0x12d9/0x1c90 security/integrity/ima/ima_main.c:425
 ima_file_check+0xe1/0x130 security/integrity/ima/ima_main.c:685
 security_file_post_open+0xb3/0x260 security/security.c:2755
 do_open fs/namei.c:4701 [inline]
 path_openat+0x2e88/0x38a0 fs/namei.c:4858
 do_file_open+0x23e/0x4a0 fs/namei.c:4887
 file_open_name+0x162/0x1c0 fs/open.c:1322
 __do_sys_swapon mm/swapfile.c:3467 [inline]
 __se_sys_swapon+0x856/0x2010 mm/swapfile.c:3432
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f884264c7d7
Code: 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a7 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe6306a658 EFLAGS: 00000246 ORIG_RAX: 00000000000000a7
RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007f884264c7d7
RDX: 0000000000000000 RSI: 0000000000008000 RDI: 00007f88426e2e5b
RBP: 00007f88426e2e5b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000008 R11: 0000000000000246 R12: 00007f88428963e0
R13: 00007f88426fdd26 R14: 0000000000200000 R15: 00007f88428963a0
 </TASK>
------------[ cut here ]------------
rrln < 0 || rrln > RCU_NEST_PMAX
WARNING: kernel/rcu/tree_plugin.h:443 at __rcu_read_unlock+0x79/0xe0 kernel/rcu/tree_plugin.h:443, CPU#1: syz-executor/5795
Modules linked in:
CPU: 1 UID: 0 PID: 5795 Comm: syz-executor Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
RIP: 0010:__rcu_read_unlock+0x79/0xe0 kernel/rcu/tree_plugin.h:443
Code: 75 66 41 83 3e 00 75 27 43 0f b6 04 3c 84 c0 75 41 8b 03 3d 00 00 00 40 73 0f 5b 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc cc 90 <0f> 0b 90 eb eb e8 6d 00 00 00 eb d2 89 d9 80 e1 07 80 c1 03 38 c1
RSP: 0018:ffffc900046e6418 EFLAGS: 00010286
RAX: 00000000ffffffff RBX: ffff888039e82384 RCX: 0000000000000046
RDX: 0000000000000000 RSI: ffffffff8d8986dc RDI: ffff888039e81ec0
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffffbfff1bcaacc R12: 1ffff110073d0470
R13: ffff888039e81ec0 R14: ffff8880b893c610 R15: dffffc0000000000
FS:  000055555b61b540(0000) GS:ffff8881261fb000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fec05db0e9c CR3: 0000000042cbe000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 rcu_read_unlock include/linux/rcupdate.h:871 [inline]
 rt_spin_unlock+0x160/0x200 kernel/locking/spinlock_rt.c:82
 spin_unlock_irq include/linux/spinlock_rt.h:122 [inline]
 __filemap_add_folio+0xc85/0x1200 mm/filemap.c:931
 filemap_add_folio+0x2de/0x610 mm/filemap.c:967
 page_cache_ra_unbounded+0x407/0x980 mm/readahead.c:282
 do_page_cache_ra mm/readahead.c:334 [inline]
 page_cache_ra_order+0x2b5/0x490 mm/readahead.c:538
 filemap_readahead mm/filemap.c:2664 [inline]
 filemap_get_pages+0x832/0x1e70 mm/filemap.c:2710
 filemap_read+0x44a/0x1240 mm/filemap.c:2806
 __kernel_read+0x50d/0x9c0 fs/read_write.c:532
 integrity_kernel_read+0x89/0xd0 security/integrity/iint.c:28
 ima_calc_file_hash_tfm security/integrity/ima/ima_crypto.c:222 [inline]
 ima_calc_file_hash+0x452/0x870 security/integrity/ima/ima_crypto.c:280
 ima_collect_measurement+0x523/0x9d0 security/integrity/ima/ima_api.c:300
 process_measurement+0x12d9/0x1c90 security/integrity/ima/ima_main.c:425
 ima_file_check+0xe1/0x130 security/integrity/ima/ima_main.c:685
 security_file_post_open+0xb3/0x260 security/security.c:2755
 do_open fs/namei.c:4701 [inline]
 path_openat+0x2e88/0x38a0 fs/namei.c:4858
 do_file_open+0x23e/0x4a0 fs/namei.c:4887
 file_open_name+0x162/0x1c0 fs/open.c:1322
 __do_sys_swapon mm/swapfile.c:3467 [inline]
 __se_sys_swapon+0x856/0x2010 mm/swapfile.c:3432
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f884264c7d7
Code: 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a7 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe6306a658 EFLAGS: 00000246 ORIG_RAX: 00000000000000a7
RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007f884264c7d7
RDX: 0000000000000000 RSI: 0000000000008000 RDI: 00007f88426e2e5b
RBP: 00007f88426e2e5b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000008 R11: 0000000000000246 R12: 00007f88428963e0
R13: 00007f88426fdd26 R14: 0000000000200000 R15: 00007f88428963a0
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

