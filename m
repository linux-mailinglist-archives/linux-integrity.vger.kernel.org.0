Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0913D3350E
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Jun 2019 18:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbfFCQfG (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Jun 2019 12:35:06 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:40609 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729281AbfFCQfG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Jun 2019 12:35:06 -0400
Received: by mail-io1-f69.google.com with SMTP id v11so14252848iop.7
        for <linux-integrity@vger.kernel.org>; Mon, 03 Jun 2019 09:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=RXLeb+ORgwCAgu+4FGMm/Rx6n81aoggbaLi2l8MCmkM=;
        b=fV3acXKz9qdiN3f6vtS7/xQeKVWgzLgalqkQaeqoH20BbwSBUbRV3ZR7c4cZ7hs91V
         4QgO3S8pUqKnX3sVphirBGQnsfW9cgKyOSr5IjEfIBK2ODRYHWIvq5Noo/eEpjOZFRo4
         47Bsck+08oqnh2CTJlTmVnIoJUf0owV4gbSq4UBSwaOUvlaO2si1LZQnn6aYWQ4Q9Alt
         aBtbjVRf+yBQpeFMx81MfJNmvhlM5u+Pmq5bfAq9Awd0Jjd8vkKdneVcR9rCD1QEQFXX
         hdoQdA+VN4mx6ReTQHty9M0k3+mtQnaGhMZ74s2EkPdu6izkZHbrq1HPzL/Kt9LYgEL+
         x3VA==
X-Gm-Message-State: APjAAAWeMJGpzG0WlcrwHk67Xm4dgLGgggJg3pUNohActfUEPDdIEb0g
        fNvDR1mq+C32cAHQy0Wazmo0OY6z3BUBLV/QiEtO2y4zVI7D
X-Google-Smtp-Source: APXvYqzEWTKXME9yCi31qNI0/C/QrdV2NUT4ptM0qpWlNPhLn1B1nq1zalaZ/RiwrleKK9PDU3DFKjHrhYIZH9devvLa+fcinn8m
MIME-Version: 1.0
X-Received: by 2002:a05:660c:6c9:: with SMTP id z9mr4713948itk.94.1559579705269;
 Mon, 03 Jun 2019 09:35:05 -0700 (PDT)
Date:   Mon, 03 Jun 2019 09:35:05 -0700
In-Reply-To: <0000000000003302870578477029@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000054e5d1058a6df2eb@google.com>
Subject: Re: possible deadlock in process_measurement
From:   syzbot <syzbot+5ab61747675a87ea359d@syzkaller.appspotmail.com>
To:     dmitry.kasatkin@gmail.com, jmorris@namei.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, zohar@linux.ibm.com,
        zohar@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    3c09c195 Add linux-next specific files for 20190531
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10f61a0ea00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6cfb24468280cd5c
dashboard link: https://syzkaller.appspot.com/bug?extid=5ab61747675a87ea359d
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177c3d16a00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14ec01baa00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5ab61747675a87ea359d@syzkaller.appspotmail.com

get_swap_device: Bad swap file entry 6000000000000001
get_swap_device: Bad swap file entry 6400000000000001
get_swap_device: Bad swap file entry 6800000000000001
get_swap_device: Bad swap file entry 6c00000000000001
get_swap_device: Bad swap file entry 7000000000000001
get_swap_device: Bad swap file entry 7400000000000001
======================================================
WARNING: possible circular locking dependency detected
5.2.0-rc2-next-20190531 #4 Not tainted
------------------------------------------------------
syz-executor395/17373 is trying to acquire lock:
000000003d1a4a53 (&sb->s_type->i_mutex_key#10){+.+.}, at: inode_lock  
include/linux/fs.h:778 [inline]
000000003d1a4a53 (&sb->s_type->i_mutex_key#10){+.+.}, at:  
process_measurement+0x15ae/0x15e0 security/integrity/ima/ima_main.c:228

but task is already holding lock:
00000000e0714fc5 (&mm->mmap_sem#2){++++}, at: do_mprotect_pkey+0x1f6/0xa30  
mm/mprotect.c:485

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&mm->mmap_sem#2){++++}:
        down_read+0x3f/0x1e0 kernel/locking/rwsem.c:24
        get_user_pages_unlocked+0xfc/0x4a0 mm/gup.c:1174
        __gup_longterm_unlocked mm/gup.c:2193 [inline]
        get_user_pages_fast+0x43f/0x530 mm/gup.c:2245
        iov_iter_get_pages+0x2c2/0xf80 lib/iov_iter.c:1287
        dio_refill_pages fs/direct-io.c:171 [inline]
        dio_get_page fs/direct-io.c:215 [inline]
        do_direct_IO fs/direct-io.c:983 [inline]
        do_blockdev_direct_IO+0x3f7b/0x8e00 fs/direct-io.c:1336
        __blockdev_direct_IO+0xa1/0xca fs/direct-io.c:1422
        ext4_direct_IO_write fs/ext4/inode.c:3782 [inline]
        ext4_direct_IO+0xaa7/0x1bb0 fs/ext4/inode.c:3909
        generic_file_direct_write+0x20a/0x4a0 mm/filemap.c:3110
        __generic_file_write_iter+0x2ee/0x630 mm/filemap.c:3293
        ext4_file_write_iter+0x332/0x1070 fs/ext4/file.c:266
        call_write_iter include/linux/fs.h:1870 [inline]
        new_sync_write+0x4d3/0x770 fs/read_write.c:483
        __vfs_write+0xe1/0x110 fs/read_write.c:496
        vfs_write+0x268/0x5d0 fs/read_write.c:558
        ksys_write+0x14f/0x290 fs/read_write.c:611
        __do_sys_write fs/read_write.c:623 [inline]
        __se_sys_write fs/read_write.c:620 [inline]
        __x64_sys_write+0x73/0xb0 fs/read_write.c:620
        do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (&sb->s_type->i_mutex_key#10){+.+.}:
        lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4300
        down_write+0x38/0xa0 kernel/locking/rwsem.c:66
        inode_lock include/linux/fs.h:778 [inline]
        process_measurement+0x15ae/0x15e0  
security/integrity/ima/ima_main.c:228
        ima_file_mmap+0x11a/0x130 security/integrity/ima/ima_main.c:370
        security_file_mprotect+0xd5/0x100 security/security.c:1430
        do_mprotect_pkey+0x537/0xa30 mm/mprotect.c:550
        __do_sys_pkey_mprotect mm/mprotect.c:590 [inline]
        __se_sys_pkey_mprotect mm/mprotect.c:587 [inline]
        __x64_sys_pkey_mprotect+0x97/0xf0 mm/mprotect.c:587
        do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
        entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

  Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(&mm->mmap_sem#2);
                                lock(&sb->s_type->i_mutex_key#10);
                                lock(&mm->mmap_sem#2);
   lock(&sb->s_type->i_mutex_key#10);

  *** DEADLOCK ***

1 lock held by syz-executor395/17373:
  #0: 00000000e0714fc5 (&mm->mmap_sem#2){++++}, at:  
do_mprotect_pkey+0x1f6/0xa30 mm/mprotect.c:485

stack backtrace:
CPU: 1 PID: 17373 Comm: syz-executor395 Not tainted 5.2.0-rc2-next-20190531  
#4
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x172/0x1f0 lib/dump_stack.c:113
  print_circular_bug.cold+0x1cc/0x28f kernel/locking/lockdep.c:1566
  check_prev_add kernel/locking/lockdep.c:2311 [inline]
  check_prevs_add kernel/locking/lockdep.c:2419 [inline]
  validate_chain kernel/locking/lockdep.c:2801 [inline]
  __lock_acquire+0x3755/0x5490 kernel/locking/lockdep.c:3790
  lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4300
  down_write+0x38/0xa0 kernel/locking/rwsem.c:66
  inode_lock include/linux/fs.h:778 [inline]
  process_measurement+0x15ae/0x15e0 security/integrity/ima/ima_main.c:228
  ima_file_mmap+0x11a/0x130 security/integrity/ima/ima_main.c:370
  security_file_mprotect+0xd5/0x100 security/security.c:1430
  do_mprotect_pkey+0x537/0xa30 mm/mprotect.c:550
  __do_sys_pkey_mprotect mm/mprotect.c:590 [inline]
  __se_sys_pkey_mprotect mm/mprotect.c:587 [inline]
  __x64_sys_pkey_mprotect+0x97/0xf0 mm/mprotect.c:587
  do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440279
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffeec2f48d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000149
RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440279
RDX: 000000000000000

