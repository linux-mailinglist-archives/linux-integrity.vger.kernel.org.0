Return-Path: <linux-integrity+bounces-9225-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEl7Ac944mnh6AAAu9opvQ
	(envelope-from <linux-integrity+bounces-9225-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Apr 2026 20:15:43 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F1141DE5E
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Apr 2026 20:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F1463028C3C
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Apr 2026 18:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282393B2FD9;
	Fri, 17 Apr 2026 18:11:44 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14753A16B4
	for <linux-integrity@vger.kernel.org>; Fri, 17 Apr 2026 18:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776449503; cv=none; b=uDHIFjTXMHLmAJj8BOMJCgL6MBNtbpC0jeqloXroNVYq9MjTOQnNnhxNey2zFfS2rDgUl49nIAAHjgREMeGlJx+1mycC+rKO0FlILwEIIDUNBCHsqUY3TRtSedtdwfMBQqK4e3dMQ3NgUxcVvW6N2YxAfFtw+ghtz3d1i5780h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776449503; c=relaxed/simple;
	bh=EGqyT+nZhpmK/rDcplJnUEgvFvJ3SVDUz++8n3SoIUU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=l9yfeaCB3kN7o5rqSu483nt+CQiOGZyagttT/sqckgAAW8Za01a1Bdj39eAFc4To/Z6K+58RgzuakNb9l5ZcAuDk66e9RU6dqLLo4x8N3ilovdMYuV3w0dDIk+H4sRTkYNuot5S3k2KCKU8c5Z1BL5DJvga9zFnoUEmzNaF3KDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-66b612efb4aso1694904eaf.0
        for <linux-integrity@vger.kernel.org>; Fri, 17 Apr 2026 11:11:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776449493; x=1777054293;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=exjvMgqOm3iVyT9rirlqaY/LhTqHqZBlcHSSUxwTkFE=;
        b=V4RXDmOPcnSl3IuBM8Z2bFTOxoB1w+Eul9lps3v+HEiUs42HmWbWKdxAUMdwCjcAKm
         Gn/MPJN0KoZu2VjiaiRVUzMniyopVh2ubRtn7mOazlaCTAcWB3sF22d7OpRYhZugCCqI
         4hrzdzGgX5hS17bnZDEqmzwOwXkpiS5gMmt/05mA4WosvYUTsL2uYrgbuKHCOJNqf84I
         /O1EfF1bJ28BLdjAfcRD33QAOCSwGXaTCQlRhHyaJXA4UO2lycoYAd0NnY1jODo/4jto
         TPhJ0l1lfGZ9CDWI1tLaZxcOcGlPhBQezIzTA2gFWZ6nAn1uB4E2MvDc7GC3kNKAIgJo
         RjLg==
X-Forwarded-Encrypted: i=1; AFNElJ/Smbutlbk5eQC8hZJnV3+SwD3Nq6XAoglWLAuuKpb0bnzaNLBFZoepUZjRVKEeoWUcZw6iT5n7nMczAj6fAGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvVodkWnUgOBIzPfy8PgKGKnpmENmRfl2zfyi5RszF941uYlsX
	MXGGRNWdGpfrc7nGnqnXQck/NpIDEovjc9IY4Dzp8fHZd4t1AyPeev+Ma6T05q1PJ1D9C6wVZE0
	dTquYMkV6X1sfmBK2Y2pg2abKwhA+kFDWhKxwYNPBn6VoBWdB2O896KYGdWg=
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:858e:10b0:67e:e9c:63f0 with SMTP id
 006d021491bc7-694637d7901mr1299995eaf.25.1776449492929; Fri, 17 Apr 2026
 11:11:32 -0700 (PDT)
Date: Fri, 17 Apr 2026 11:11:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69e277d4.a00a0220.1bd0ca.0019.GAE@google.com>
Subject: [syzbot] [integrity?] [lsm?] BUG: sleeping function called from
 invalid context in page_cache_ra_unbounded
From: syzbot <syzbot+77103043d0c16dbc71ae@syzkaller.appspotmail.com>
To: dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jmorris@namei.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	roberto.sassu@huawei.com, serge@hallyn.com, syzkaller-bugs@googlegroups.com, 
	zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=56c2b36de3316f1b];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,oracle.com,namei.org,vger.kernel.org,paul-moore.com,huawei.com,hallyn.com,googlegroups.com,linux.ibm.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9225-lists,linux-integrity=lfdr.de,77103043d0c16dbc71ae];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,storage.googleapis.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,syzkaller.appspot.com:url,googlegroups.com:email,goo.gl:url];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[11];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 64F1141DE5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

syzbot found the following issue on:

HEAD commit:    1c7cc4904160 Add linux-next specific files for 20260413
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=104e10ce580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=56c2b36de3316f1b
dashboard link: https://syzkaller.appspot.com/bug?extid=77103043d0c16dbc71ae
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/91a765b703da/disk-1c7cc490.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/da75a3061146/vmlinux-1c7cc490.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d55367ced048/bzImage-1c7cc490.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+77103043d0c16dbc71ae@syzkaller.appspotmail.com

cgroup: Unknown subsys name 'rlimit'
BUG: sleeping function called from invalid context at ./include/linux/sched/mm.h:323
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 5809, name: syz-executor
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by syz-executor/5809:
 #0: ffff888025b9e458 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}, at: process_measurement+0x7fd/0x1c90 security/integrity/ima/ima_main.c:319
 #1: ffff8880406185f0 (mapping.invalidate_lock#2){++++}-{4:4}, at: filemap_invalidate_lock_shared include/linux/fs.h:1094 [inline]
 #1: ffff8880406185f0 (mapping.invalidate_lock#2){++++}-{4:4}, at: do_page_cache_ra mm/readahead.c:333 [inline]
 #1: ffff8880406185f0 (mapping.invalidate_lock#2){++++}-{4:4}, at: page_cache_ra_order+0x2a5/0x490 mm/readahead.c:538
 #2: ffffffff8dfc80c0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #2: ffffffff8dfc80c0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #2: ffffffff8dfc80c0 (rcu_read_lock){....}-{1:3}, at: __rt_spin_lock kernel/locking/spinlock_rt.c:50 [inline]
 #2: ffffffff8dfc80c0 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0x1e0/0x400 kernel/locking/spinlock_rt.c:57
CPU: 0 UID: 0 PID: 5809 Comm: syz-executor Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 __might_resched+0x329/0x480 kernel/sched/core.c:9162
 might_alloc include/linux/sched/mm.h:323 [inline]
 prepare_alloc_pages+0x1f0/0x6b0 mm/page_alloc.c:4995
 __alloc_frozen_pages_noprof+0x12f/0x380 mm/page_alloc.c:5215
 alloc_pages_mpol+0xd1/0x380 mm/mempolicy.c:2490
 alloc_frozen_pages_noprof mm/mempolicy.c:2561 [inline]
 alloc_pages_noprof+0xd2/0x2f0 mm/mempolicy.c:2581
 folio_alloc_noprof+0x22/0xc0 mm/mempolicy.c:2591
 filemap_alloc_folio_noprof+0x111/0x4d0 mm/filemap.c:1013
 ractl_alloc_folio mm/readahead.c:189 [inline]
 page_cache_ra_unbounded+0x2f7/0x980 mm/readahead.c:277
 do_page_cache_ra mm/readahead.c:334 [inline]
 page_cache_ra_order+0x2b5/0x490 mm/readahead.c:538
 filemap_readahead mm/filemap.c:2663 [inline]
 filemap_get_pages+0x832/0x1e70 mm/filemap.c:2709
 filemap_read+0x44a/0x1240 mm/filemap.c:2805
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
 __do_sys_swapon mm/swapfile.c:3574 [inline]
 __se_sys_swapon+0x856/0x2010 mm/swapfile.c:3539
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4a4d9cc7d7
Code: 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a7 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc336ba3b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a7
RAX: ffff[   83.300808][ T5809] RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007f4a4d9cc7d7
RDX: 0000000000000000 RSI: 0000000000008000 RDI: 00007f4a4da62e5b
RBP: 00007f4a4da62e5b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000008 R11: 0000000000000246 R12: 00007f4a4dc163e0
R13: 00007f4a4da7dd26 R14: 0000000000200000 R15: 00007f4a4dc163a0
 </TASK>

=============================
[ BUG: Invalid wait context ]
syzkaller #0 Tainted: G        W          
-----------------------------
syz-executor/5809 is trying to lock:
ffff8880406185f0 (mapping.invalidate_lock#2){++++}-{4:4}, at: filemap_invalidate_lock_shared include/linux/fs.h:1094 [inline]
ffff8880406185f0 (mapping.invalidate_lock#2){++++}-{4:4}, at: do_page_cache_ra mm/readahead.c:333 [inline]
ffff8880406185f0 (mapping.invalidate_lock#2){++++}-{4:4}, at: page_cache_ra_order+0x2a5/0x490 mm/readahead.c:538
other info that might help us debug this:
context-{5:5}
2 locks held by syz-executor/5809:
 #0: ffff888025b9e458 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}, at: process_measurement+0x7fd/0x1c90 security/integrity/ima/ima_main.c:319
 #1: ffffffff8dfc80c0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:300 [inline]
 #1: ffffffff8dfc80c0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #1: ffffffff8dfc80c0 (rcu_read_lock){....}-{1:3}, at: __rt_spin_lock kernel/locking/spinlock_rt.c:50 [inline]
 #1: ffffffff8dfc80c0 (rcu_read_lock){....}-{1:3}, at: rt_spin_lock+0x1e0/0x400 kernel/locking/spinlock_rt.c:57
stack backtrace:
CPU: 0 UID: 0 PID: 5809 Comm: syz-executor Tainted: G        W           syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4832 [inline]
 check_wait_context kernel/locking/lockdep.c:4904 [inline]
 __lock_acquire+0xec1/0x2cf0 kernel/locking/lockdep.c:5189
 lock_acquire+0x106/0x350 kernel/locking/lockdep.c:5870
 down_read+0x97/0x200 kernel/locking/rwsem.c:1568
 filemap_invalidate_lock_shared include/linux/fs.h:1094 [inline]
 do_page_cache_ra mm/readahead.c:333 [inline]
 page_cache_ra_order+0x2a5/0x490 mm/readahead.c:538
 filemap_readahead mm/filemap.c:2663 [inline]
 filemap_get_pages+0x832/0x1e70 mm/filemap.c:2709
 filemap_read+0x44a/0x1240 mm/filemap.c:2805
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
 __do_sys_swapon mm/swapfile.c:3574 [inline]
 __se_sys_swapon+0x856/0x2010 mm/swapfile.c:3539
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4a4d9cc7d7
Code: 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a7 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc336ba3b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a7
RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007f4a4d9cc7d7
RDX: 0000000000000000 RSI: 0000000000008000 RDI: 00007f4a4da62e5b
RBP: 00007f4a4da62e5b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000008 R11: 0000000000000246 R12: 00007f4a4dc163e0
R13: 00007f4a4da7dd26 R14: 0000000000200000 R15: 00007f4a4dc163a0
 </TASK>
------------[ cut here ]------------
Voluntary context switch within RCU read-side critical section!
WARNING: kernel/rcu/tree_plugin.h:332 at rcu_note_context_switch+0xcac/0xf40 kernel/rcu/tree_plugin.h:332, CPU#0: syz-executor/5809
Modules linked in:
CPU: 0 UID: 0 PID: 5809 Comm: syz-executor Tainted: G        W           syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
RIP: 0010:rcu_note_context_switch+0xcac/0xf40 kernel/rcu/tree_plugin.h:332
Code: 00 41 c6 45 00 00 48 8b 3d 81 5e e2 0d 48 81 c4 b8 00 00 00 5b 41 5c 41 5d 41 5e 41 5f 5d e9 9b 60 ff ff 48 8d 3d f4 26 e6 0d <67> 48 0f b9 3a e9 1b f4 ff ff 90 0f 0b 90 45 84 e4 0f 84 ea f3 ff
RSP: 0018:ffffc900043b6fb0 EFLAGS: 00010002
RAX: 0000000000000000 RBX: ffff88803906bd80 RCX: 0000000080000002
RDX: 0000000000000000 RSI: ffffffff8ba83740 RDI: ffffffff8f907b60
RBP: dffffc0000000000 R08: ffffffff8f8d05f7 R09: 1ffffffff1f1a0be
R10: dffffc0000000000 R11: fffffbfff1f1a0bf R12: 0000000000000000
R13: ffff88803906bd80 R14: ffff8880b883c980 R15: ffff88803906c244
FS:  0000555571f48540(0000) GS:ffff8881260c2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f64ae81e7b8 CR3: 000000001a1e4000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __schedule+0x297/0x54f0 kernel/sched/core.c:7043
 __schedule_loop kernel/sched/core.c:7267 [inline]
 schedule+0x164/0x360 kernel/sched/core.c:7282
 schedule_timeout+0x158/0x2c0 kernel/time/sleep_timeout.c:99
 io_schedule_timeout+0x88/0xe0 kernel/sched/core.c:8097
 do_wait_for_common kernel/sched/completion.c:100 [inline]
 __wait_for_common kernel/sched/completion.c:121 [inline]
 wait_for_common_io+0x2d7/0x610 kernel/sched/completion.c:138
 blk_wait_io block/blk.h:102 [inline]
 bio_await block/bio.c:1496 [inline]
 submit_bio_wait+0x16d/0x250 block/bio.c:1513
 blkdev_issue_flush+0xe0/0x150 block/blk-flush.c:475
 ext4_sync_file+0x8b6/0xd60 fs/ext4/fsync.c:179
 iomap_swapfile_activate+0x1e4/0xbe0 fs/iomap/swapfile.c:162
 setup_swap_extents+0x176/0x640 mm/swapfile.c:2890
 __do_sys_swapon mm/swapfile.c:3630 [inline]
 __se_sys_swapon+0xdc9/0x2010 mm/swapfile.c:3539
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4a4d9cc7d7
Code: 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a7 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc336ba3b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a7
RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007f4a4d9cc7d7
RDX: 0000000000000000 RSI: 0000000000008000 RDI: 00007f4a4da62e5b
RBP: 00007f4a4da62e5b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000008 R11: 0000000000000246 R12: 00007f4a4dc163e0
R13: 00007f4a4da7dd26 R14: 0000000000200000 R15: 00007f4a4dc163a0
 </TASK>
----------------
Code disassembly (best guess):
   0:	00 41 c6             	add    %al,-0x3a(%rcx)
   3:	45 00 00             	add    %r8b,(%r8)
   6:	48 8b 3d 81 5e e2 0d 	mov    0xde25e81(%rip),%rdi        # 0xde25e8e
   d:	48 81 c4 b8 00 00 00 	add    $0xb8,%rsp
  14:	5b                   	pop    %rbx
  15:	41 5c                	pop    %r12
  17:	41 5d                	pop    %r13
  19:	41 5e                	pop    %r14
  1b:	41 5f                	pop    %r15
  1d:	5d                   	pop    %rbp
  1e:	e9 9b 60 ff ff       	jmp    0xffff60be
  23:	48 8d 3d f4 26 e6 0d 	lea    0xde626f4(%rip),%rdi        # 0xde6271e
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	e9 1b f4 ff ff       	jmp    0xfffff44f
  34:	90                   	nop
  35:	0f 0b                	ud2
  37:	90                   	nop
  38:	45 84 e4             	test   %r12b,%r12b
  3b:	0f                   	.byte 0xf
  3c:	84 ea                	test   %ch,%dl
  3e:	f3                   	repz
  3f:	ff                   	.byte 0xff


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

