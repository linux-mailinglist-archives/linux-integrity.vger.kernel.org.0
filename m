Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 053043F1CCD
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Aug 2021 17:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240370AbhHSPbQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Aug 2021 11:31:16 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:56189 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240304AbhHSPbM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Aug 2021 11:31:12 -0400
Received: by mail-il1-f199.google.com with SMTP id c16-20020a92cf500000b02902243aec7e27so3459011ilr.22
        for <linux-integrity@vger.kernel.org>; Thu, 19 Aug 2021 08:30:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=v8KWPu9J2asTXHe+aC8rvSPNF9EmTyUi46Hp2F7Yba8=;
        b=OXg5aKaEt+AU141TG3aTOSKzYLt61koK/vfvrsJuwIecaxYl9iLCaL1VC4qs1jIdKm
         ccSI8qTdh6hmtdxGsKPJZLT3a7L/YXGpFGya/u4m0Q3RRtJ07FGrcrH0Fvh0qsYQ8wRJ
         rn9BLahlmpM3ptTDTvyjKtUBuJab9F3Q5sdn38hPKiukVwJdhjBydC/MOg8+O8nfc6II
         +sDjUts5zhmIbqaHxV5Ws7yuoIvJnkzrwc5MkDVuB3VxCTF49HjXVrYGmDSbfN7kYqvU
         31hkvsLWg+O6BafGO+8c2HNLrt3gZORj1cb7wP4gAsVVKyra1lnyfwfIb1x7LMCYGl9x
         /X2Q==
X-Gm-Message-State: AOAM533fKH66f3at1oHPY2Z4LgOuF8ojsfF2qX4gTUziM0T8L5rCMYu2
        yXGtvTAozFsvjihkrCRZ84i5u0kbiwrKu37RB9h9HI3U2coT
X-Google-Smtp-Source: ABdhPJzMpiJTtK2hkMwV4W3t0VDUXwZkvhifQLeQ9RuhLd47NQmtjAoTo4tz5nkQwRXWd74tDEtjil+MZyFdj22QjXDbzPMBVF9w
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2211:: with SMTP id n17mr11878912ion.142.1629387035683;
 Thu, 19 Aug 2021 08:30:35 -0700 (PDT)
Date:   Thu, 19 Aug 2021 08:30:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000076adac05c9eb3b06@google.com>
Subject: [syzbot] UBSAN: array-index-out-of-bounds in ima_inode_setxattr
From:   syzbot <syzbot+e8bafe7b82c739eaf153@syzkaller.appspotmail.com>
To:     dmitry.kasatkin@gmail.com, jmorris@namei.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    33e65b1f975c Add linux-next specific files for 20210819
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1546c341300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3022de5bd1dbc8f5
dashboard link: https://syzkaller.appspot.com/bug?extid=e8bafe7b82c739eaf153
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15767d41300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13582731300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e8bafe7b82c739eaf153@syzkaller.appspotmail.com

================================================================================
UBSAN: array-index-out-of-bounds in security/integrity/ima/ima_appraise.c:621:36
index 222 is out of range for type 'char *[20]'
CPU: 1 PID: 6550 Comm: syz-executor680 Not tainted 5.14.0-rc6-next-20210819-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 ubsan_epilogue+0xb/0x5a lib/ubsan.c:151
 __ubsan_handle_out_of_bounds.cold+0x64/0x70 lib/ubsan.c:291
 validate_hash_algo security/integrity/ima/ima_appraise.c:621 [inline]
 ima_inode_setxattr+0x536/0x540 security/integrity/ima/ima_appraise.c:656
 security_inode_setxattr+0x148/0x240 security/security.c:1355
 __vfs_setxattr_locked+0xa7/0x260 fs/xattr.c:266
 vfs_setxattr+0x14e/0x350 fs/xattr.c:301
 setxattr+0x21b/0x2b0 fs/xattr.c:575
 path_setxattr+0x19d/0x1d0 fs/xattr.c:595
 __do_sys_lsetxattr fs/xattr.c:618 [inline]
 __se_sys_lsetxattr fs/xattr.c:614 [inline]
 __x64_sys_lsetxattr+0xbd/0x150 fs/xattr.c:614
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x43ee89
Code: 28 c3 e8 2a 14 00 00 66 2e 0f 1f 84 00 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe96b06768 EFLAGS: 00000246 ORIG_RAX: 00000000000000bd
RAX: ffffffffffffffda RBX: 0000000000400488 RCX: 000000000043ee89
RDX: 0000000020000140 RSI: 00000000200000c0 RDI: 0000000020000000
RBP: 0000000000402e70 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000000a R11: 0000000000000246 R12: 0000000000402f00
R13: 0000000000000000 R14: 00000000004ac018 R15: 0000000000400488
================================================================================
----------------
Code disassembly (best guess):
   0:	28 c3                	sub    %al,%bl
   2:	e8 2a 14 00 00       	callq  0x1431
   7:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
   e:	00 00 00 
  11:	48 89 f8             	mov    %rdi,%rax
  14:	48 89 f7             	mov    %rsi,%rdi
  17:	48 89 d6             	mov    %rdx,%rsi
  1a:	48 89 ca             	mov    %rcx,%rdx
  1d:	4d 89 c2             	mov    %r8,%r10
  20:	4d 89 c8             	mov    %r9,%r8
  23:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
  28:	0f 05                	syscall 
  2a:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax <-- trapping instruction
  30:	73 01                	jae    0x33
  32:	c3                   	retq   
  33:	48 c7 c1 c0 ff ff ff 	mov    $0xffffffffffffffc0,%rcx
  3a:	f7 d8                	neg    %eax
  3c:	64 89 01             	mov    %eax,%fs:(%rcx)
  3f:	48                   	rex.W


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
