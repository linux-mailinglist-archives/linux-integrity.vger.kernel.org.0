Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9541D66101
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Jul 2019 23:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbfGKVMb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 11 Jul 2019 17:12:31 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14522 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728102AbfGKVMa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 11 Jul 2019 17:12:30 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6BL2Ob9027301
        for <linux-integrity@vger.kernel.org>; Thu, 11 Jul 2019 17:12:28 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tpag8n97x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 11 Jul 2019 17:12:28 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 11 Jul 2019 22:12:26 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 11 Jul 2019 22:12:22 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6BLCLb947972368
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Jul 2019 21:12:22 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4CFDA4053;
        Thu, 11 Jul 2019 21:12:21 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E7E3A4057;
        Thu, 11 Jul 2019 21:12:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.110.73])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 11 Jul 2019 21:12:20 +0000 (GMT)
Subject: Re: possible deadlock in process_measurement
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Biggers <ebiggers3@gmail.com>
Cc:     syzbot <syzbot+5ab61747675a87ea359d@syzkaller.appspotmail.com>,
        dmitry.kasatkin@gmail.com, jmorris@namei.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, zohar@linux.vnet.ibm.com
Date:   Thu, 11 Jul 2019 17:12:09 -0400
In-Reply-To: <1562869533.4014.56.camel@linux.ibm.com>
References: <00000000000054e5d1058a6df2eb@google.com>
         <1562869533.4014.56.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19071121-0008-0000-0000-000002FC8AC5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071121-0009-0000-0000-00002269F47C
Message-Id: <1562879529.4014.95.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-11_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=929 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907110233
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Eric,

> > the existing dependency chain (in reverse order) is:
> > 
> > -> #1 (&mm->mmap_sem#2){++++}:
> >         down_read+0x3f/0x1e0 kernel/locking/rwsem.c:24
> >         get_user_pages_unlocked+0xfc/0x4a0 mm/gup.c:1174
> >         __gup_longterm_unlocked mm/gup.c:2193 [inline]
> >         get_user_pages_fast+0x43f/0x530 mm/gup.c:2245
> >         iov_iter_get_pages+0x2c2/0xf80 lib/iov_iter.c:1287
> >         dio_refill_pages fs/direct-io.c:171 [inline]
> >         dio_get_page fs/direct-io.c:215 [inline]
> >         do_direct_IO fs/direct-io.c:983 [inline]
> >         do_blockdev_direct_IO+0x3f7b/0x8e00 fs/direct-io.c:1336
> >         __blockdev_direct_IO+0xa1/0xca fs/direct-io.c:1422
> >         ext4_direct_IO_write fs/ext4/inode.c:3782 [inline]
> >         ext4_direct_IO+0xaa7/0x1bb0 fs/ext4/inode.c:3909
> >         generic_file_direct_write+0x20a/0x4a0 mm/filemap.c:3110
> >         __generic_file_write_iter+0x2ee/0x630 mm/filemap.c:3293
> >         ext4_file_write_iter+0x332/0x1070 fs/ext4/file.c:266
> >         call_write_iter include/linux/fs.h:1870 [inline]
> >         new_sync_write+0x4d3/0x770 fs/read_write.c:483
> >         __vfs_write+0xe1/0x110 fs/read_write.c:496
> >         vfs_write+0x268/0x5d0 fs/read_write.c:558
> >         ksys_write+0x14f/0x290 fs/read_write.c:611
> >         __do_sys_write fs/read_write.c:623 [inline]
> >         __se_sys_write fs/read_write.c:620 [inline]
> >         __x64_sys_write+0x73/0xb0 fs/read_write.c:620
> >         do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
> >         entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > 
> > -> #0 (&sb->s_type->i_mutex_key#10){+.+.}:
> >         lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4300
> >         down_write+0x38/0xa0 kernel/locking/rwsem.c:66
> >         inode_lock include/linux/fs.h:778 [inline]
> >         process_measurement+0x15ae/0x15e0  
> > security/integrity/ima/ima_main.c:228
> >         ima_file_mmap+0x11a/0x130 security/integrity/ima/ima_main.c:370
> >         security_file_mprotect+0xd5/0x100 security/security.c:1430
> >         do_mprotect_pkey+0x537/0xa30 mm/mprotect.c:550
> >         __do_sys_pkey_mprotect mm/mprotect.c:590 [inline]
> >         __se_sys_pkey_mprotect mm/mprotect.c:587 [inline]
> >         __x64_sys_pkey_mprotect+0x97/0xf0 mm/mprotect.c:587
> >         do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
> >         entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > 
> > other info that might help us debug this:
> > 
> >   Possible unsafe locking scenario:
> > 
> >         CPU0                    CPU1
> >         ----                    ----
> >    lock(&mm->mmap_sem#2);
> >                                 lock(&sb->s_type->i_mutex_key#10);
> >                                 lock(&mm->mmap_sem#2);
> >    lock(&sb->s_type->i_mutex_key#10);
> > 
> >   *** DEADLOCK ***

The locking on CPU1 shouldn't be nested.  Only after the call to
security_file_mmap() would the mmap_sem be taken.

Mimi


> > 
> > 1 lock held by syz-executor395/17373:
> >   #0: 00000000e0714fc5 (&mm->mmap_sem#2){++++}, at:  
> > do_mprotect_pkey+0x1f6/0xa30 mm/mprotect.c:485
> > 
> > stack backtrace:
> > CPU: 1 PID: 17373 Comm: syz-executor395 Not tainted 5.2.0-rc2-next-20190531  
> > #4
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
> > Google 01/01/2011
> > Call Trace:
> >   __dump_stack lib/dump_stack.c:77 [inline]
> >   dump_stack+0x172/0x1f0 lib/dump_stack.c:113
> >   print_circular_bug.cold+0x1cc/0x28f kernel/locking/lockdep.c:1566
> >   check_prev_add kernel/locking/lockdep.c:2311 [inline]
> >   check_prevs_add kernel/locking/lockdep.c:2419 [inline]
> >   validate_chain kernel/locking/lockdep.c:2801 [inline]
> >   __lock_acquire+0x3755/0x5490 kernel/locking/lockdep.c:3790
> >   lock_acquire+0x16f/0x3f0 kernel/locking/lockdep.c:4300
> >   down_write+0x38/0xa0 kernel/locking/rwsem.c:66
> >   inode_lock include/linux/fs.h:778 [inline]
> >   process_measurement+0x15ae/0x15e0 security/integrity/ima/ima_main.c:228
> >   ima_file_mmap+0x11a/0x130 security/integrity/ima/ima_main.c:370
> >   security_file_mprotect+0xd5/0x100 security/security.c:1430
> >   do_mprotect_pkey+0x537/0xa30 mm/mprotect.c:550
> >   __do_sys_pkey_mprotect mm/mprotect.c:590 [inline]
> >   __se_sys_pkey_mprotect mm/mprotect.c:587 [inline]
> >   __x64_sys_pkey_mprotect+0x97/0xf0 mm/mprotect.c:587
> >   do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
> >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > RIP: 0033:0x440279
> > Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
> > 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
> > ff 0f 83 fb 13 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> > RSP: 002b:00007ffeec2f48d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000149
> > RAX: ffffffffffffffda RBX: 00000000004002c8 RCX: 0000000000440279
> > RDX: 000000000000000
> > 
> 

