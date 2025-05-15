Return-Path: <linux-integrity+bounces-6229-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60805AB87AC
	for <lists+linux-integrity@lfdr.de>; Thu, 15 May 2025 15:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF57D4E3CDA
	for <lists+linux-integrity@lfdr.de>; Thu, 15 May 2025 13:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F096926296;
	Thu, 15 May 2025 13:17:35 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CCF4C6D
	for <linux-integrity@vger.kernel.org>; Thu, 15 May 2025 13:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747315055; cv=none; b=eUYUWbBlYAndpQtQtZh4rPRPZ9iPGQsEhqMeNb8zOKW7aGBGf/8PgsIq3j+jawT+Rz5Qoc/9GCYdWmEGah1EqHpWEcHsfN2lwHQSsORS4jowSLflCkAyC3gwkdoN+1FKkQBjoveD+EJFS0ZYwDlkXfRAZJm39o8BqysAcdiiL3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747315055; c=relaxed/simple;
	bh=CSlINjW300wE33LnIvPV27GEUvIHGtSaWPL2DVU9hqw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=L1vvqJdU0GzeudV3xAiMxd/Eh3spoeXyn5DWjI9zTwNvR8JePcTskabH9vPwEh4yz0LDpSDxlma9CiEc1rBy2rwvMsB3s5WsgY6q3DkcHghUC6FPjeSNsvXlz3GXq3AeLXZ7FBl6QKHSS5ML+bw1sk5jfm3RCVXg2b40B0jBdGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3db6f98ddf7so18582275ab.2
        for <linux-integrity@vger.kernel.org>; Thu, 15 May 2025 06:17:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747315053; x=1747919853;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xn9oKnYNLdjBAhOv38xpz1Hgm9HIVb5SHeuBIDHGyvY=;
        b=qGOLj4DZKYb7GmW8Khbp3zHW+aUgagS7SpBCudEeTzpuECKWxJst714CgXqUhXtfpI
         PY/0SsAsbb3cQ7A5zH33y7YJgVjwjGtEmNalyF9vpLszcXouvNkSKwtMCksEgesaKXGx
         wQkdc1nPI+z9/sSZM7yWeaBXPRw13+kqxJ06vpYysXO0Av1He8u5bqJY0M4JHMfUhgwK
         63AM8FKb+RbCVoaQBuemcNEUBuQiW5Xe23Km4g9Y2YCK0Q/iyfKe01dyRA0pwuxVaT2/
         QXu8Fqr1Bayymb2An1lmoc1Wg7PeshKsC1+UktgLShIUOiIMVYUYBvt227tt0pPzY0Ov
         8QBA==
X-Forwarded-Encrypted: i=1; AJvYcCWAdcKsmwn+ttYoTUchrfGSXCPAHjAlnCMeiU2tIrXnfyYq7svR2SogXrPwYkQFGnoi5+xUu8MNPxLSqVVihhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvaB1xIG2svzOfAXonvBP3nu0VlhUiczTpyLpklA540pR2oBVl
	8VwiwhFNr3E8pVaZNRfC7ecTKwtQGOKg7n8Ji17RIzipuDy97QYE1Ki79q6jlx9Dm7jhvZWRLkK
	vRnpCGMzq3htYyQ8Yu/YN+2H1xIM8zDpb4LfWC7srYgJOdHIYNCWBaqM=
X-Google-Smtp-Source: AGHT+IFwXvRFd1PItj+rYDYnplcpCYz6cU/4mpQeerP0EGN4L5woUn4gyTHygMlkLH8CQWXXBSS3ED50sEefATUoQH7J2dE6FgXv
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:360a:b0:3db:72f7:d7b3 with SMTP id
 e9e14a558f8ab-3db7957701cmr25455645ab.4.1747315052840; Thu, 15 May 2025
 06:17:32 -0700 (PDT)
Date: Thu, 15 May 2025 06:17:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6825e96c.a00a0220.a2f23.01c3.GAE@google.com>
Subject: [syzbot] [lsm?] [integrity?] possible deadlock in process_measurement (5)
From: syzbot <syzbot+6529afa25091aee8536c@syzkaller.appspotmail.com>
To: dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, jmorris@namei.org, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	roberto.sassu@huawei.com, serge@hallyn.com, syzkaller-bugs@googlegroups.com, 
	zohar@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3ce9925823c7 Merge tag 'mm-hotfixes-stable-2025-05-10-14-2..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13b93768580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6b353fce507849ee
dashboard link: https://syzkaller.appspot.com/bug?extid=6529afa25091aee8536c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a21f72d944f5/disk-3ce99258.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bcf67a803f15/vmlinux-3ce99258.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3f247ad0c252/bzImage-3ce99258.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6529afa25091aee8536c@syzkaller.appspotmail.com

R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f6aee5b6080 R15: 00007ffdbad4bbb8
 </TASK>
======================================================
WARNING: possible circular locking dependency detected
6.15.0-rc5-syzkaller-00300-g3ce9925823c7 #0 Tainted: G     U             
------------------------------------------------------
syz.5.3437/23258 is trying to acquire lock:
ffff88802fb6a9f8 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}, at: process_measurement+0x7e0/0x23e0 security/integrity/ima/ima_main.c:279

but task is already holding lock:
ffffffff8f2ed228 (dpm_list_mtx){+.+.}-{4:4}, at: device_pm_lock drivers/base/power/main.c:113 [inline]
ffffffff8f2ed228 (dpm_list_mtx){+.+.}-{4:4}, at: dpm_for_each_dev drivers/base/power/main.c:2059 [inline]
ffffffff8f2ed228 (dpm_list_mtx){+.+.}-{4:4}, at: dpm_for_each_dev+0x2d/0xb0 drivers/base/power/main.c:2052

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #5 (dpm_list_mtx){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:601 [inline]
       __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:746
       device_pm_add+0x87/0x3e0 drivers/base/power/main.c:137
       device_add+0x9cd/0x1a70 drivers/base/core.c:3655
       pmu_dev_alloc+0x27c/0x400 kernel/events/core.c:12087
       perf_event_sysfs_init+0xb3/0x150 kernel/events/core.c:14537
       do_one_initcall+0x120/0x6e0 init/main.c:1257
       do_initcall_level init/main.c:1319 [inline]
       do_initcalls init/main.c:1335 [inline]
       do_basic_setup init/main.c:1354 [inline]
       kernel_init_freeable+0x5c2/0x900 init/main.c:1567
       kernel_init+0x1c/0x2b0 init/main.c:1457
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #4 (pmus_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:601 [inline]
       __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:746
       perf_event_init_cpu+0xc9/0x850 kernel/events/core.c:14442
       cpuhp_invoke_callback+0x3d2/0xa10 kernel/cpu.c:194
       __cpuhp_invoke_callback_range+0x101/0x210 kernel/cpu.c:967
       cpuhp_invoke_callback_range kernel/cpu.c:991 [inline]
       cpuhp_up_callbacks kernel/cpu.c:1022 [inline]
       _cpu_up+0x3f5/0x930 kernel/cpu.c:1687
       cpu_up+0x1dc/0x240 kernel/cpu.c:1719
       cpuhp_bringup_mask+0xd8/0x210 kernel/cpu.c:1785
       cpuhp_bringup_cpus_parallel kernel/cpu.c:1875 [inline]
       bringup_nonboot_cpus+0x176/0x1c0 kernel/cpu.c:1889
       smp_init+0x34/0x160 kernel/smp.c:1010
       kernel_init_freeable+0x3a8/0x900 init/main.c:1559
       kernel_init+0x1c/0x2b0 init/main.c:1457
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #3 (cpu_hotplug_lock){++++}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:52 [inline]
       cpus_read_lock+0x42/0x160 kernel/cpu.c:490
       ring_buffer_resize+0x7ea/0x1560 kernel/trace/ring_buffer.c:2894
       __tracing_resize_ring_buffer.part.0+0x52/0x1f0 kernel/trace/trace.c:5943
       __tracing_resize_ring_buffer kernel/trace/trace.c:5937 [inline]
       tracing_resize_ring_buffer kernel/trace/trace.c:5998 [inline]
       tracing_free_buffer_release+0x104/0x270 kernel/trace/trace.c:7094
       __fput+0x3ff/0xb70 fs/file_table.c:465
       task_work_run+0x14d/0x240 kernel/task_work.c:227
       resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
       exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
       exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
       __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
       syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
       do_syscall_64+0xda/0x230 arch/x86/entry/syscall_64.c:100
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (&buffer->mutex){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:601 [inline]
       __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:746
       ring_buffer_resize+0x113/0x1560 kernel/trace/ring_buffer.c:2851
       __tracing_resize_ring_buffer.part.0+0x52/0x1f0 kernel/trace/trace.c:5943
       __tracing_resize_ring_buffer kernel/trace/trace.c:5937 [inline]
       tracing_update_buffers+0x102/0x130 kernel/trace/trace.c:6170
       ftrace_event_write+0x14a/0x290 kernel/trace/trace_events.c:1494
       vfs_write+0x25c/0x1180 fs/read_write.c:682
       ksys_write+0x12a/0x240 fs/read_write.c:736
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0x230 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (trace_types_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:601 [inline]
       __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:746
       class_mutex_constructor include/linux/mutex.h:201 [inline]
       trace_array_get kernel/trace/trace.c:550 [inline]
       tracing_check_open_get_tr.part.0+0x45/0x130 kernel/trace/trace.c:598
       tracing_check_open_get_tr kernel/trace/trace.c:592 [inline]
       tracing_open_generic_tr+0x66/0xf0 kernel/trace/trace.c:4699
       do_dentry_open+0x741/0x1c10 fs/open.c:956
       vfs_open+0x82/0x3f0 fs/open.c:1086
       dentry_open+0x71/0xd0 fs/open.c:1109
       ima_calc_file_hash+0x2b6/0x490 security/integrity/ima/ima_crypto.c:553
       ima_collect_measurement+0x897/0xa40 security/integrity/ima/ima_api.c:293
       process_measurement+0x11fa/0x23e0 security/integrity/ima/ima_main.c:385
       ima_file_check+0xc5/0x110 security/integrity/ima/ima_main.c:613
       security_file_post_open+0x8e/0x210 security/security.c:3130
       do_open fs/namei.c:3882 [inline]
       path_openat+0x147d/0x2d40 fs/namei.c:4039
       do_filp_open+0x20b/0x470 fs/namei.c:4066
       do_sys_openat2+0x11b/0x1d0 fs/open.c:1429
       do_sys_open fs/open.c:1444 [inline]
       __do_sys_openat fs/open.c:1460 [inline]
       __se_sys_openat fs/open.c:1455 [inline]
       __x64_sys_openat+0x174/0x210 fs/open.c:1455
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0x230 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&ima_iint_mutex_key[depth]){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3166 [inline]
       check_prevs_add kernel/locking/lockdep.c:3285 [inline]
       validate_chain kernel/locking/lockdep.c:3909 [inline]
       __lock_acquire+0x1173/0x1ba0 kernel/locking/lockdep.c:5235
       lock_acquire kernel/locking/lockdep.c:5866 [inline]
       lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5823
       __mutex_lock_common kernel/locking/mutex.c:601 [inline]
       __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:746
       process_measurement+0x7e0/0x23e0 security/integrity/ima/ima_main.c:279
       ima_file_check+0xc5/0x110 security/integrity/ima/ima_main.c:613
       security_file_post_open+0x8e/0x210 security/security.c:3130
       do_open fs/namei.c:3882 [inline]
       path_openat+0x147d/0x2d40 fs/namei.c:4039
       do_file_open_root+0x322/0x610 fs/namei.c:4091
       file_open_root+0x2a7/0x450 fs/open.c:1408
       kernel_read_file_from_path_initns+0x189/0x260 fs/kernel_read_file.c:163
       fw_get_filesystem_firmware drivers/base/firmware_loader/main.c:549 [inline]
       _request_firmware+0x744/0x1470 drivers/base/firmware_loader/main.c:916
       request_firmware drivers/base/firmware_loader/main.c:992 [inline]
       cache_firmware drivers/base/firmware_loader/main.c:1330 [inline]
       __async_dev_cache_fw_image+0xb1/0x340 drivers/base/firmware_loader/main.c:1444
       async_schedule_node_domain+0xd1/0x120 kernel/async.c:221
       async_schedule_domain include/linux/async.h:72 [inline]
       dev_cache_fw_image+0x38e/0x490 drivers/base/firmware_loader/main.c:1500
       dpm_for_each_dev drivers/base/power/main.c:2061 [inline]
       dpm_for_each_dev+0x5a/0xb0 drivers/base/power/main.c:2052
       device_cache_fw_images drivers/base/firmware_loader/main.c:1550 [inline]
       fw_pm_notify+0x81/0x150 drivers/base/firmware_loader/main.c:1601
       notifier_call_chain+0xb9/0x410 kernel/notifier.c:85
       notifier_call_chain_robust kernel/notifier.c:120 [inline]
       blocking_notifier_call_chain_robust kernel/notifier.c:345 [inline]
       blocking_notifier_call_chain_robust+0xc8/0x160 kernel/notifier.c:333
       pm_notifier_call_chain_robust+0x27/0x60 kernel/power/main.c:102
       snapshot_open+0x189/0x2b0 kernel/power/user.c:77
       misc_open+0x35a/0x420 drivers/char/misc.c:179
       chrdev_open+0x231/0x6a0 fs/char_dev.c:414
       do_dentry_open+0x741/0x1c10 fs/open.c:956
       vfs_open+0x82/0x3f0 fs/open.c:1086
       do_open fs/namei.c:3880 [inline]
       path_openat+0x1e5e/0x2d40 fs/namei.c:4039
       do_filp_open+0x20b/0x470 fs/namei.c:4066
       do_sys_openat2+0x11b/0x1d0 fs/open.c:1429
       do_sys_open fs/open.c:1444 [inline]
       __do_sys_openat fs/open.c:1460 [inline]
       __se_sys_openat fs/open.c:1455 [inline]
       __x64_sys_openat+0x174/0x210 fs/open.c:1455
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0x230 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &ima_iint_mutex_key[depth] --> pmus_lock --> dpm_list_mtx

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(dpm_list_mtx);
                               lock(pmus_lock);
                               lock(dpm_list_mtx);
  lock(&ima_iint_mutex_key[depth]);

 *** DEADLOCK ***

5 locks held by syz.5.3437/23258:
 #0: ffffffff8f0e2e08 (misc_mtx){+.+.}-{4:4}, at: misc_open+0x63/0x420 drivers/char/misc.c:143
 #1: ffffffff8e283608 (system_transition_mutex){+.+.}-{4:4}, at: lock_system_sleep+0x87/0xa0 kernel/power/main.c:56
 #2: ffffffff8e2c3150 ((pm_chain_head).rwsem){++++}-{4:4}, at: blocking_notifier_call_chain_robust kernel/notifier.c:344 [inline]
 #2: ffffffff8e2c3150 ((pm_chain_head).rwsem){++++}-{4:4}, at: blocking_notifier_call_chain_robust+0xa8/0x160 kernel/notifier.c:333
 #3: ffffffff8f2f2608 (fw_lock){+.+.}-{4:4}, at: device_cache_fw_images drivers/base/firmware_loader/main.c:1548 [inline]
 #3: ffffffff8f2f2608 (fw_lock){+.+.}-{4:4}, at: fw_pm_notify+0x69/0x150 drivers/base/firmware_loader/main.c:1601
 #4: ffffffff8f2ed228 (dpm_list_mtx){+.+.}-{4:4}, at: device_pm_lock drivers/base/power/main.c:113 [inline]
 #4: ffffffff8f2ed228 (dpm_list_mtx){+.+.}-{4:4}, at: dpm_for_each_dev drivers/base/power/main.c:2059 [inline]
 #4: ffffffff8f2ed228 (dpm_list_mtx){+.+.}-{4:4}, at: dpm_for_each_dev+0x2d/0xb0 drivers/base/power/main.c:2052

stack backtrace:
CPU: 1 UID: 0 PID: 23258 Comm: syz.5.3437 Tainted: G     U              6.15.0-rc5-syzkaller-00300-g3ce9925823c7 #0 PREEMPT(full) 
Tainted: [U]=USER
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x275/0x350 kernel/locking/lockdep.c:2079
 check_noncircular+0x14c/0x170 kernel/locking/lockdep.c:2211
 check_prev_add kernel/locking/lockdep.c:3166 [inline]
 check_prevs_add kernel/locking/lockdep.c:3285 [inline]
 validate_chain kernel/locking/lockdep.c:3909 [inline]
 __lock_acquire+0x1173/0x1ba0 kernel/locking/lockdep.c:5235
 lock_acquire kernel/locking/lockdep.c:5866 [inline]
 lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5823
 __mutex_lock_common kernel/locking/mutex.c:601 [inline]
 __mutex_lock+0x199/0xb90 kernel/locking/mutex.c:746
 process_measurement+0x7e0/0x23e0 security/integrity/ima/ima_main.c:279
 ima_file_check+0xc5/0x110 security/integrity/ima/ima_main.c:613
 security_file_post_open+0x8e/0x210 security/security.c:3130
 do_open fs/namei.c:3882 [inline]
 path_openat+0x147d/0x2d40 fs/namei.c:4039
 do_file_open_root+0x322/0x610 fs/namei.c:4091
 file_open_root+0x2a7/0x450 fs/open.c:1408
 kernel_read_file_from_path_initns+0x189/0x260 fs/kernel_read_file.c:163
 fw_get_filesystem_firmware drivers/base/firmware_loader/main.c:549 [inline]
 _request_firmware+0x744/0x1470 drivers/base/firmware_loader/main.c:916
 request_firmware drivers/base/firmware_loader/main.c:992 [inline]
 cache_firmware drivers/base/firmware_loader/main.c:1330 [inline]
 __async_dev_cache_fw_image+0xb1/0x340 drivers/base/firmware_loader/main.c:1444
 async_schedule_node_domain+0xd1/0x120 kernel/async.c:221
 async_schedule_domain include/linux/async.h:72 [inline]
 dev_cache_fw_image+0x38e/0x490 drivers/base/firmware_loader/main.c:1500
 dpm_for_each_dev drivers/base/power/main.c:2061 [inline]
 dpm_for_each_dev+0x5a/0xb0 drivers/base/power/main.c:2052
 device_cache_fw_images drivers/base/firmware_loader/main.c:1550 [inline]
 fw_pm_notify+0x81/0x150 drivers/base/firmware_loader/main.c:1601
 notifier_call_chain+0xb9/0x410 kernel/notifier.c:85
 notifier_call_chain_robust kernel/notifier.c:120 [inline]
 blocking_notifier_call_chain_robust kernel/notifier.c:345 [inline]
 blocking_notifier_call_chain_robust+0xc8/0x160 kernel/notifier.c:333
 pm_notifier_call_chain_robust+0x27/0x60 kernel/power/main.c:102
 snapshot_open+0x189/0x2b0 kernel/power/user.c:77
 misc_open+0x35a/0x420 drivers/char/misc.c:179
 chrdev_open+0x231/0x6a0 fs/char_dev.c:414
 do_dentry_open+0x741/0x1c10 fs/open.c:956
 vfs_open+0x82/0x3f0 fs/open.c:1086
 do_open fs/namei.c:3880 [inline]
 path_openat+0x1e5e/0x2d40 fs/namei.c:4039
 do_filp_open+0x20b/0x470 fs/namei.c:4066
 do_sys_openat2+0x11b/0x1d0 fs/open.c:1429
 do_sys_open fs/open.c:1444 [inline]
 __do_sys_openat fs/open.c:1460 [inline]
 __se_sys_openat fs/open.c:1455 [inline]
 __x64_sys_openat+0x174/0x210 fs/open.c:1455
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6aee38e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6aef159038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f6aee5b6080 RCX: 00007f6aee38e969
RDX: 0000000000020080 RSI: 0000200000000000 RDI: ffffffffffffff9c
RBP: 00007f6aee410ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f6aee5b6080 R15: 00007ffdbad4bbb8
 </TASK>
(NULL device *): loading /lib/firmware/regulatory.db.p7s failed with error -4
(NULL device *): Direct firmware load for regulatory.db.p7s failed with error -4
(NULL device *): Falling back to sysfs fallback for: regulatory.db.p7s


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

