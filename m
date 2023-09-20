Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5057A8F22
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Sep 2023 00:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjITWJa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 20 Sep 2023 18:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjITWJ3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 20 Sep 2023 18:09:29 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CABC2;
        Wed, 20 Sep 2023 15:09:23 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38KM7U5l023017;
        Wed, 20 Sep 2023 22:09:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=HWAu+tvI0sWmZpCWN6VQ1BriQW7isGEcPzeDMCDjPkI=;
 b=A4bwi7rP+/BqtNW2NfPAxv/GG4eUkNdSoQT+bIxuq40WQLf4wGzmRT6c8p54Qn8B9N9T
 6zudPkKW3gmynjF6eYiW15uMJs8/V8lmvVVRGPH5LTCwsKrIh/WnXgx69St9LwCcznmI
 JBzRBbFZ9yHpMkQgOoY810kz9dg409I7I0NxsWdBvuqJZJIiCzBYvyaAr6vpt6Z0Mddf
 3a2ldnABsCjzBwNjMHgneGqrutbfSaTUQnIyCr9obwdAqke+FzKrb0a/TPKbCOHYCZB9
 SsasOzwyg5lbRf2EbTwy3IhNuWzAsykDtrttXzzfgy27BUu3OLjd9f6JGXdSJo7dxkAq 4Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t816ppfcv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 22:09:16 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38KM8ncQ030751;
        Wed, 20 Sep 2023 22:09:15 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t816ppfby-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 22:09:15 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38KKkLFD011671;
        Wed, 20 Sep 2023 22:09:14 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t5qpnsvcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Sep 2023 22:09:14 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38KM9E5F66978178
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Sep 2023 22:09:14 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 33C705805A;
        Wed, 20 Sep 2023 22:09:14 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 358ED5803F;
        Wed, 20 Sep 2023 22:09:13 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 20 Sep 2023 22:09:13 +0000 (GMT)
Message-ID: <b16550ac-f589-c5d7-e139-d585e8771cfd@linux.ibm.com>
Date:   Wed, 20 Sep 2023 18:09:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [syzbot] [integrity] [overlayfs] general protection fault in
 d_path
Content-Language: en-US
To:     Jeff Layton <jlayton@kernel.org>,
        syzbot <syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com>,
        amir73il@gmail.com, brauner@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com,
        zohar@linux.ibm.com, casey@schaufler-ca.com
References: <000000000000259bd8060596e33f@google.com>
 <bed99e92-cb7c-868d-94f3-ddf53e2b262a@linux.ibm.com>
 <8a65f5eb-2b59-9903-c6b8-84971f8765ae@linux.ibm.com>
 <ab7df5e93b5493de5fa379ccab48859fe953d7ae.camel@kernel.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <ab7df5e93b5493de5fa379ccab48859fe953d7ae.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sd2dT-XsnDf7KpSqwiBV7O5Kt6THrl60
X-Proofpoint-ORIG-GUID: iFkMUeRkb6KlGv1bDSNt3I8Oaz3oEUC5
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_11,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 phishscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=626 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309200185
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 9/20/23 17:16, Jeff Layton wrote:
> On Wed, 2023-09-20 at 16:37 -0400, Stefan Berger wrote:
>> On 9/20/23 13:01, Stefan Berger wrote:
>>> On 9/17/23 20:04, syzbot wrote:
>>>> syzbot has bisected this issue to:
>>>>
>>>> commit db1d1e8b9867aae5c3e61ad7859abfcc4a6fd6c7
>>>> Author: Jeff Layton <jlayton@kernel.org>
>>>> Date:   Mon Apr 17 16:55:51 2023 +0000
>>>>
>>>>       IMA: use vfs_getattr_nosec to get the i_version
>>>>
>>>> bisection log:
>>>> https://syzkaller.appspot.com/x/bisect.txt?x=106f7e54680000
>>>> start commit:   a747acc0b752 Merge tag 'linux-kselftest-next-6.6-rc2'
>>>> of g..
>>>> git tree:       upstream
>>>> final oops: https://syzkaller.appspot.com/x/report.txt?x=126f7e54680000
>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=146f7e54680000
>>>> kernel config:
>>>> https://syzkaller.appspot.com/x/.config?x=df91a3034fe3f122
>>>> dashboard link:
>>>> https://syzkaller.appspot.com/bug?extid=a67fc5321ffb4b311c98
>>>> syz repro: https://syzkaller.appspot.com/x/repro.syz?x=1671b694680000
>>>> C reproducer: https://syzkaller.appspot.com/x/repro.c?x=14ec94d8680000
>>>>
>>>> Reported-by: syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com
>>>> Fixes: db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the i_version")
>>>>
>>>> For information about bisection process see:
>>>> https://goo.gl/tpsmEJ#bisection
>>> The final oops shows this here:
>>>
>>> BUG: kernel NULL pointer dereference, address: 0000000000000058
>>> #PF: supervisor read access in kernel mode
>>> #PF: error_code(0x0000) - not-present page
>>> PGD 0 P4D 0
>>> Oops: 0000 [#1] PREEMPT SMP
>>> CPU: 0 PID: 3192 Comm: syz-executor.0 Not tainted 6.4.0-rc2-syzkaller #0
>>> Hardware name: Google Google Compute Engine/Google Compute Engine,
>>> BIOS Google 08/04/2023
>>> RIP: 0010:__lock_acquire+0x35/0x490 kernel/locking/lockdep.c:4946
>>> Code: 83 ec 18 65 4c 8b 35 aa 60 f4 7e 83 3d b7 11 e4 02 00 0f 84 05
>>> 02 00 00 4c 89 cb 89 cd 41 89 d5 49 89 ff 83 fe 01 77 0c 89 f0 <49> 8b
>>> 44 c7 08 48 85 c0 75 1b 4c 89 ff 31 d2 45 89 c4 e8 74 f6 ff
>>> RSP: 0018:ffffc90002edb840 EFLAGS: 00010097
>>> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000002
>>> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000050
>>> RBP: 0000000000000002 R08: 0000000000000001 R09: 0000000000000000
>>> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
>>> R13: 0000000000000000 R14: ffff888102ea5340 R15: 0000000000000050
>>> FS:  0000000000000000(0000) GS:ffff88813bc00000(0000)
>>> knlGS:0000000000000000
>>> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> CR2: 0000000000000058 CR3: 0000000003aa8000 CR4: 00000000003506f0
>>> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>>> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>>> Call Trace:
>>>   <TASK>
>>>   lock_acquire+0xd8/0x1f0 kernel/locking/lockdep.c:5691
>>>   seqcount_lockdep_reader_access include/linux/seqlock.h:102 [inline]
>>>   get_fs_root_rcu fs/d_path.c:243 [inline]
>>>   d_path+0xd1/0x1f0 fs/d_path.c:285
>>>   audit_log_d_path+0x65/0x130 kernel/audit.c:2139
>>>   dump_common_audit_data security/lsm_audit.c:224 [inline]
>>>   common_lsm_audit+0x3b3/0x840 security/lsm_audit.c:458
>>>   smack_log+0xad/0x130 security/smack/smack_access.c:383
>>>   smk_tskacc+0xb1/0xd0 security/smack/smack_access.c:253
>>>   smack_inode_getattr+0x8a/0xb0 security/smack/smack_lsm.c:1187
>>>   security_inode_getattr+0x32/0x50 security/security.c:2114
>>>   vfs_getattr+0x1b/0x40 fs/stat.c:167
>>>   ovl_getattr+0xa6/0x3e0 fs/overlayfs/inode.c:173
>>>   ima_check_last_writer security/integrity/ima/ima_main.c:171 [inline]
>>>   ima_file_free+0xbd/0x130 security/integrity/ima/ima_main.c:203
>>>   __fput+0xc7/0x220 fs/file_table.c:315
>>>   task_work_run+0x7d/0xa0 kernel/task_work.c:179
>>>   exit_task_work include/linux/task_work.h:38 [inline]
>>>   do_exit+0x2c7/0xa80 kernel/exit.c:871 <-----------------------
>>>   do_group_exit+0x85/0xa0 kernel/exit.c:1021
>>>   get_signal+0x73c/0x7f0 kernel/signal.c:2874
>>>   arch_do_signal_or_restart+0x89/0x290 arch/x86/kernel/signal.c:306
>>>   exit_to_user_mode_loop+0x61/0xb0 kernel/entry/common.c:168
>>>   exit_to_user_mode_prepare+0x64/0xb0 kernel/entry/common.c:204
>>>   __syscall_exit_to_user_mode_work kernel/entry/common.c:286 [inline]
>>>   syscall_exit_to_user_mode+0x2b/0x1d0 kernel/entry/common.c:297
>>>   do_syscall_64+0x4d/0x90 arch/x86/entry/common.c:86
>>>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>>
>>>
>>> do_exit has called exit_fs(tsk) [
>>> https://elixir.bootlin.com/linux/v6.4-rc2/source/kernel/exit.c#L867 ]
>>>
>>> exit_fs(tsk) has set tsk->fs = NULL [
>>> https://elixir.bootlin.com/linux/v6.4-rc2/source/fs/fs_struct.c#L103 ]
>>>
>>> I think this then bites in d_path() where it calls:
>>>
>>>      get_fs_root_rcu(current->fs, &root);   [
>>> https://elixir.bootlin.com/linux/v6.4-rc2/source/fs/d_path.c#L285 ]
>>>
>>> current->fs is likely NULL here.
>>>
>>> If this was correct it would have nothing to do with the actual patch,
>>> though, but rather with the fact that smack logs on process
>>> termination. I am not sure what the solution would be other than
>>> testing for current->fs == NULL in d_path before using it and
>>> returning an error that is not normally returned or trying to
>>> intercept this case in smack.
>> I have now been able to recreate the syzbot issue with the test program
>> and the issue is exactly the one described here, current->fs == NULL.
>>
> Earlier in this thread, Amir had a diagnosis that IMA is inappropriately
> trying to use f_path directly instead of using the helpers that are
> friendly for stacking filesystems.
>
> https://lore.kernel.org/linux-fsdevel/CAOQ4uxgjnYyeQL-LbS5kQ7+C0d6sjzKqMDWAtZW8cAkPaed6=Q@mail.gmail.com/
>
> I'm not an IMA hacker so I'm not planning to roll a fix here. Perhaps
> someone on the IMA team could try this approach?


I have applied this patch here from Amir now and it does NOT resolve the 
issue:

https://lore.kernel.org/linux-integrity/296dae962a2a488bde682d3def074db91686e1c3.camel@linux.ibm.com/T/#m4ebdb780bf6952e7f210c55e87950d0cfa1d5eb0

     Stefan


