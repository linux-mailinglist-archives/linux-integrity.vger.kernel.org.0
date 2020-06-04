Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45BD1EE688
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jun 2020 16:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgFDOXR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Jun 2020 10:23:17 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:42865 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728881AbgFDOXP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Jun 2020 10:23:15 -0400
Received: by mail-il1-f199.google.com with SMTP id j71so4082214ilg.9
        for <linux-integrity@vger.kernel.org>; Thu, 04 Jun 2020 07:23:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ChhcWL3hTFWCpFWNbyNbxXqvn5rlljlRuJpYLklKBw0=;
        b=i7vxLFjAsCdAG/N43I8RaplQ8c4tOe8UqqFyrdyZXLCjcp+eQuQlrk9Xp7GJlaBg4c
         HuOW39gc6zSC47gqZt4MaQj6/AH5iVxibckMUktkc0XU9HqRy77bhRVKL5Z1J7x+t1zF
         1cCizYjejkhzrBrteVZ/piZ/5G8QAVFFeVouokjBsH7IlIWaoD78W+ilj+n55uIkuzMU
         iduktNpVaXE8k52ux/8+P+K+Y60QfALp+ycqPjuN/efmiEsKItZaPkINJgKPjErKY0Sy
         7nmxUYTh49VFCZfv6RD6r8IFFvJSLDhPpiQC1QwlcVbTIP5lfdTQGEGxWb+oRHMZ9eOL
         9tLA==
X-Gm-Message-State: AOAM530pAwuskOLZgD5l0tpG2OXxxuMwFRUiBumMvhzjqUCVfLLMcC3Y
        OU+XTccCTY7ZQsyx12zpbwBajmpWzPDkJlJn0a+99l77ERH1
X-Google-Smtp-Source: ABdhPJzKv56bUdfAsAiMeZJczlzOSCzOIr6s3IHnhpRAJVSmYLG7E+6UvtqjfxLBo4IZNA4/elWFCKEXkaegRZ/BtXgmwXe5cD1t
MIME-Version: 1.0
X-Received: by 2002:a92:a158:: with SMTP id v85mr3321556ili.21.1591280593441;
 Thu, 04 Jun 2020 07:23:13 -0700 (PDT)
Date:   Thu, 04 Jun 2020 07:23:13 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000829d9805a742e264@google.com>
Subject: general protection fault in ima_free_template_entry
From:   syzbot <syzbot+223310b454ba6b75974e@syzkaller.appspotmail.com>
To:     dmitry.kasatkin@gmail.com, jmorris@namei.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, roberto.sassu@huawei.com,
        serge@hallyn.com, syzkaller-bugs@googlegroups.com,
        zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e7b08814 Add linux-next specific files for 20200529
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12d7b391100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e62421a5de6da96
dashboard link: https://syzkaller.appspot.com/bug?extid=223310b454ba6b75974e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=108575d2100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13291661100000

The bug was bisected to:

commit aa724fe18a8a8285d0071c3bfc932efb090d142d
Author: Roberto Sassu <roberto.sassu@huawei.com>
Date:   Wed Mar 25 10:47:09 2020 +0000

    ima: Switch to dynamically allocated buffer for template digests

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1616e896100000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1516e896100000
console output: https://syzkaller.appspot.com/x/log.txt?x=1116e896100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+223310b454ba6b75974e@syzkaller.appspotmail.com
Fixes: aa724fe18a8a ("ima: Switch to dynamically allocated buffer for template digests")

RBP: 000000000000dcd4 R08: 0000000000000002 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402160
R13: 00000000004021f0 R14: 0000000000000000 R15: 0000000000000000
general protection fault, probably for non-canonical address 0xdffffc0000000004: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
CPU: 0 PID: 6811 Comm: syz-executor925 Not tainted 5.7.0-rc7-next-20200529-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:ima_free_template_entry+0x4a/0x170 security/integrity/ima/ima_api.c:27
Code: fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 25 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 5d 10 48 8d 7b 20 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e d1 00 00 00 8b 5b 20 31 ff 89
RSP: 0018:ffffc900018e7598 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 1ffff9200031cece
RDX: 0000000000000004 RSI: ffffffff836d8716 RDI: 0000000000000020
RBP: ffff88809a078d80 R08: 0000000000000000 R09: ffffed1015cc719c
R10: ffff8880ae638cdb R11: ffffed1015cc719b R12: ffffc900018e7670
R13: ffffffff8a06d650 R14: ffff88809a078d90 R15: 00000000fffffff4
FS:  0000000000bc7880(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000a6570000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 ima_alloc_init_template+0x3de/0x570 security/integrity/ima/ima_api.c:80
 ima_add_violation+0x109/0x1e0 security/integrity/ima/ima_api.c:148
 ima_rdwr_violation_check security/integrity/ima/ima_main.c:140 [inline]
 process_measurement+0x1144/0x1750 security/integrity/ima/ima_main.c:237
 ima_file_check+0xb9/0x100 security/integrity/ima/ima_main.c:491
 do_open fs/namei.c:3236 [inline]
 path_openat+0x17a4/0x27d0 fs/namei.c:3351
 do_filp_open+0x192/0x260 fs/namei.c:3378
 do_sys_openat2+0x585/0x7a0 fs/open.c:1173
 do_sys_open+0xc3/0x140 fs/open.c:1189
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:359
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x441219
Code: e8 5c ae 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 bb 0a fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffca22cc218 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441219
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000180
RBP: 000000000000dcd4 R08: 0000000000000002 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000402160
R13: 00000000004021f0 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace d5e7ae4ed8ee55df ]---
RIP: 0010:ima_free_template_entry+0x4a/0x170 security/integrity/ima/ima_api.c:27
Code: fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 25 01 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b 5d 10 48 8d 7b 20 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e d1 00 00 00 8b 5b 20 31 ff 89
RSP: 0018:ffffc900018e7598 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 1ffff9200031cece
RDX: 0000000000000004 RSI: ffffffff836d8716 RDI: 0000000000000020
RBP: ffff88809a078d80 R08: 0000000000000000 R09: ffffed1015cc719c
R10: ffff8880ae638cdb R11: ffffed1015cc719b R12: ffffc900018e7670
R13: ffffffff8a06d650 R14: ffff88809a078d90 R15: 00000000fffffff4
FS:  0000000000bc7880(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f1d9c03f078 CR3: 00000000a6570000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
