Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF68C1BB31C
	for <lists+linux-integrity@lfdr.de>; Tue, 28 Apr 2020 02:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgD1A6o (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Apr 2020 20:58:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39336 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726263AbgD1A6o (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Apr 2020 20:58:44 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03S0VbN9066800;
        Mon, 27 Apr 2020 20:58:33 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mhr682mg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Apr 2020 20:58:33 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03S0WcpX069281;
        Mon, 27 Apr 2020 20:58:33 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mhr682m1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Apr 2020 20:58:33 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03S0tH6X017355;
        Tue, 28 Apr 2020 00:58:30 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma01fra.de.ibm.com with ESMTP id 30mcu8cddh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Apr 2020 00:58:30 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03S0vKjo64225740
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 00:57:20 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62077AE055;
        Tue, 28 Apr 2020 00:58:28 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3720FAE04D;
        Tue, 28 Apr 2020 00:58:27 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.195.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 28 Apr 2020 00:58:27 +0000 (GMT)
Message-ID: <1588035506.16086.25.camel@linux.ibm.com>
Subject: Re: Fwd: a8d5875ce5 ("Default enable RCU list lockdep debugging
 with .."): WARNING: suspicious RCU usage
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org
Cc:     Matthew Garrett <mjg59@google.com>
Date:   Mon, 27 Apr 2020 20:58:26 -0400
In-Reply-To: <CAD=jOEYd-pAQMo3hukx6AhXN7CbH8yGLVLHe2=92wCq-HWS++Q@mail.gmail.com>
References: <5ea3a0e3.ruR9Zw9VIGN+NGIb%lkp@intel.com>
         <CAD=jOEYd-pAQMo3hukx6AhXN7CbH8yGLVLHe2=92wCq-HWS++Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-27_17:2020-04-27,2020-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004270196
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Cc'ing Matthew Garrett)

Hi Madhuparna,

On Sat, 2020-04-25 at 16:33 +0530, Madhuparna Bhowmik wrote:
> Hi,
> 
> This is regarding the warning reported by kernel test bot regarding
> suspicious RCU usage.
> Using a simple git grep, I can only see the following usage of RCU:
> 
> evm_crypto.c:   list_for_each_entry_rcu(xattr, &evm_config_xattrnames,
> list) {
> evm_main.c:     list_for_each_entry_rcu(xattr, &evm_config_xattrnames,
> list) {
> evm_main.c:     list_for_each_entry_rcu(xattr, &evm_config_xattrnames,
> list) {
> evm_secfs.c:    list_add_tail_rcu(&xattr->list, &evm_config_xattrnames);
> 
> So, the evm_config_xattrnames list is traversed using
> list_for_each_entry_rcu() but without the protection of rcu_read_lock()?
> If these are not really RCU read-side CS, and other locks are held then
> there is no need to use list_for_each_entry_rcu().
> And maybe we can completely remove the usage of rcu primitives here.
> Or if there is a bug and rcu_read_lock() should be held, please let me know
> and I can try fixing this.

Thank you for forwarding this report.  The list of EVM xattrs is
protected by the xattr_list_mutex, which is used when reading or
appending to the EVM list itself.  Entries in the list can not be
removed.

The examples, above, are all readers, which walk the EVM xattr list in
order to calculate or verify a file's security.evm xattr.

Mimi

> 
> Thank you,
> Madhuparna
> 
> ---------- Forwarded message ---------
> From: kernel test robot <lkp@intel.com>
> Date: Sat, Apr 25, 2020 at 8:01 AM
> Subject: a8d5875ce5 ("Default enable RCU list lockdep debugging with .."):
> WARNING: suspicious RCU usage
> To: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> Cc: LKP <lkp@lists.01.org>, Amol Grover <frextrite@gmail.com>, Paul E.
> McKenney <paulmck@kernel.org>, <philip.li@intel.com>
> 
> 
> Greetings,
> 
> 0day kernel testing robot got the below dmesg and the first bad commit is
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> 
> commit a8d5875ce5f0b8c02a3c84c63ae10af237c5e82d
> Author:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> AuthorDate: Fri Feb 28 14:54:51 2020 +0530
> Commit:     Paul E. McKenney <paulmck@kernel.org>
> CommitDate: Mon Apr 13 17:52:07 2020 -0700
> 
>     Default enable RCU list lockdep debugging with PROVE_RCU
> 
>     This patch default enables CONFIG_PROVE_RCU_LIST option with
>     CONFIG_PROVE_RCU for RCU list lockdep debugging.
> 
>     With this change, RCU list lockdep debugging will be default
>     enabled in CONFIG_PROVE_RCU=y kernels.
> 
>     Most of the RCU users (in core kernel/, drivers/, and net/
>     subsystem) have already been modified to include lockdep
>     expressions hence RCU list debugging can be enabled by
>     default.
> 
>     However, there are still chances of enountering
>     false-positive lockdep splats because not everything is converted,
>     in case RCU list primitives are used in non-RCU read-side critical
>     section but under the protection of a lock. It would be okay to
>     have a few false-positives, as long as bugs are identified, since this
>     patch only affects debugging kernels.
> 
>     Co-developed-by: Amol Grover <frextrite@gmail.com>
>     Signed-off-by: Amol Grover <frextrite@gmail.com>
>     Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
>     Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> 18d76ac490  locktorture.c: Fix if-statement empty body warnings
> a8d5875ce5  Default enable RCU list lockdep debugging with PROVE_RCU
> +-----------------------------------------------------------------------------+------------+------------+
> |
>    | 18d76ac490 | a8d5875ce5 |
> +-----------------------------------------------------------------------------+------------+------------+
> | boot_successes
>   | 32         | 0          |
> | boot_failures
>    | 0          | 10         |
> | WARNING:suspicious_RCU_usage
>   | 0          | 10         |
> |
> security/integrity/evm/evm_main.c:#RCU-list_traversed_in_non-reader_section
> | 0          | 10         |
> | Mem-Info
>   | 0          | 1          |
> +-----------------------------------------------------------------------------+------------+------------+
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <lkp@intel.com>
> 
> [   32.753796] random: get_random_u32 called from
> randomize_stack_top+0x1e/0x40 with crng_init=0
> [   32.753799] random: get_random_u32 called from
> arch_align_stack+0x28/0x40 with crng_init=0
> [   32.810688] init: udev-fallback-graphics main process (442) terminated
> with status 1
> [   32.848254]
> [   32.848432] =============================
> [   32.848707] WARNING: suspicious RCU usage
> [   32.848966] 5.7.0-rc1-00006-ga8d5875ce5f0b #1 Not tainted
> [   32.849308] -----------------------------
> [   32.849567] security/integrity/evm/evm_main.c:231 RCU-list traversed in
> non-reader section!!
> [   32.850251]
> [   32.850251] other info that might help us debug this:
> [   32.850251]
> [   32.850759]
> [   32.850759] rcu_scheduler_active = 2, debug_locks = 1
> [   32.851173] 2 locks held by mv/447:
> [   32.851399]  #0: f34d7800 (sb_writers#2){.+.+}-{0:0}, at:
> mnt_want_write_file+0x21/0x50
> [   32.851974]  #1: f6f34a90 (&sb->s_type->i_mutex_key){++++}-{3:3}, at:
> vfs_setxattr+0x37/0x90
> [   32.852516]
> [   32.852516] stack backtrace:
> [   32.852810] CPU: 1 PID: 447 Comm: mv Not tainted
> 5.7.0-rc1-00006-ga8d5875ce5f0b #1
> [   32.853287] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.12.0-1 04/01/2014
> [   32.853813] Call Trace:
> [   32.854023]  dump_stack+0x6e/0x96
> [   32.854259]  lockdep_rcu_suspicious+0xca/0xe0
> [   32.854568]  evm_protected_xattr+0x4a/0xd0
> [   32.854832]  evm_protect_xattr+0x3f/0x110
> [   32.855126]  evm_inode_setxattr+0x44/0x70
> [   32.855392]  security_inode_setxattr+0x8b/0xb0
> [   32.855678]  vfs_setxattr+0x49/0x90
> [   32.855906]  setxattr+0x179/0x1d0
> [   32.856126]  ? __lock_acquire+0xaab/0x1490
> [   32.856395]  ? lock_acquire+0x2e7/0x330
> [   32.856663]  ? mnt_want_write_file+0x21/0x50
> [   32.856952]  ? rcu_read_lock_any_held+0x62/0x80
> [   32.857263]  ? __sb_start_write+0x295/0x2a0
> [   32.857534]  __ia32_sys_fsetxattr+0x71/0xf0
> [   32.857807]  do_int80_syscall_32+0x71/0x340
> [   32.858120]  entry_INT80_32+0x114/0x114
> [   32.858379] EIP: 0xb7f741b2
> [   32.858563] Code: 89 c2 31 c0 89 d7 f3 aa 8b 44 24 1c 89 30 c6 40 04 00
> 83 c4 2c 89 f0 5b 5e 5f 5d c3 90 90 90 90 90 90 90 90 90 90 90 90 cd 80
> <c3> 8d b6 00 00 00 00 8d bc 27 00 00 00 00 8b 1c 24 c3 8d b6 00 00
> [   32.859728] EAX: ffffffda EBX: 00000004 ECX: b7f42a73 EDX: 0806e520
> [   32.860139] ESI: 0000001c EDI: 00000000 EBP: 0806e490 ESP: bff4a8c8
> [   32.860545] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000292
> [   32.914408] init: networking main process (448) terminated with status 1
> [   35.872688] random: get_random_u32 called from
> bucket_table_alloc+0x137/0x150 with crng_init=0
> [main] Added 26416 filenames from /proc
> [main] Added 8284 filenames from /sys
> [   37.751324] Lockdown: trinity-main: unsafe use of perf is restricted;
> see man kernel_lockdown.7
> 
>                                                           # HH:MM RESULT
> GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
> git bisect start 24dd8e1703196f1c542ab8f4fee9b751619d885e
> ae83d0b416db002fe95601e7f97f64b59514d936 --
> git bisect  bad bfe2878588b0c3ca75fcbd62ad5d673ec74b14af  # 16:04  B
> 0     1   17   0  Merge
> 'linux-review/Alexandre-Belloni/rtc-88pm860x-remove-useless-range-check/20200416-070129'
> into devel-hourly-2020042401
> git bisect good bef90f5626c16a715b24fa45c82ae8e6836e8e0f  # 18:27  G
>  10     0    5   5  Merge
> 'linux-review/Jason-Yan/scsi-aic7xxx-aic97xx-remove-NULL-check-before-some-freeing-functions/20200421-051713'
> into devel-hourly-2020042401
> git bisect  bad bae27e9828d735ae843133491dad50ee72b2b390  # 20:25  B
> 0     2   18   0  Merge
> 'linux-review/js1304-gmail-com/integrate-classzone_idx-and-high_zoneidx/20200417-120136'
> into devel-hourly-2020042401
> git bisect good 2cda5c8387072237107801b6e001fbe4978f1d73  # 21:03  G
>  10     0    0   0  Merge
> 'linux-review/Jason-Yan/backlight-lms501kf03-remove-unused-seq_sleep_in-and-seq_up_dn/20200420-115817'
> into devel-hourly-2020042401
> git bisect good 2d16745ed16a668de594550eb33e38de5feb9bd0  # 21:29  G
>  11     0    1   1  Merge
> 'linux-review/Jason-Yan/samples-hw_breakpoint-make-sample_hbp-static/20200420-085849'
> into devel-hourly-2020042401
> git bisect  bad 511d7735d24fe7572b49fa375461f3ee7472f1b1  # 21:58  B
> 0     1   17   0  Merge
> 'linux-review/Wu-Hao/add-performance-reporting-support-to-FPGA-DFL-drivers/20200417-140348'
> into devel-hourly-2020042401
> git bisect  bad ebc2439fd43072a09226b2a13bf8d174ca3494da  # 22:27  B
> 0     1   18   1  Merge
> 'linux-review/Sedat-Dilek/iwlwifi-actually-check-allocated-conf_tlv-pointer/20200420-094914'
> into devel-hourly-2020042401
> git bisect good 6d1b160c0aade2910644a96541078c370d725e8d  # 00:19  G
>  10     0    2   2  Merge
> 'linux-review/Luca-Coelho/iwlwifi-fixes-intended-for-v5-7-2020-04-03-2/20200420-085157'
> into devel-hourly-2020042401
> git bisect good fa82215f59eedac489d9bcf2188df32289243a0e  # 00:52  G
>  10     0    0   0  Merge
> 'linux-review/Qu-Wenruo/btrfs-Remove-the-duplicated-level-parameter-for-btrfs_bin_search/20200420-084856'
> into devel-hourly-2020042401
> git bisect  bad 1ac9452ba13a335915cc2cbee72e0aa6c5dc5e88  # 01:23  B
> 0     1   17   0  Merge 'jfern/rcu/dev-fixes-april20' into
> devel-hourly-2020042401
> git bisect  bad e169c6452c3d0923c1e44f5e7c94c10aaabcba53  # 01:59  B
> 0     1   17   0  Merge branches 'fixes.2020.04.13d',
> 'kfree_rcu.2020.04.13c', 'rcu-tasks.2020.04.16a', 'stall.2020.04.13d' and
> 'torture.2020.04.13c' into HEAD
> git bisect good 0d1dc7a6c89e4e0e6a87f1ba503dd11dea6e5cf6  # 02:44  G
>  10     0    1   1  ftrace: Use synchronize_rcu_tasks_rude() instead of
> ftrace_sync()
> git bisect  bad a945e425ec89c06f7af469f24fe8d73766253265  # 03:14  B
> 0     1   17   0  rcutorture: Convert ULONG_CMP_LT() to time_before()
> git bisect  bad 997e9e9414172c6929e9420878302ac2bf8a5608  # 04:01  B
> 0     1   18   0  torture: Add --kcsan argument to top-level kvm.sh script
> git bisect good 18d76ac49038c85b9ef892e1da8cdcb5039eb7db  # 04:54  G
>  11     0    2   2  locktorture.c: Fix if-statement empty body warnings
> git bisect  bad 112bf80760f1fd2a85d43cf418fd4995a29d60b1  # 05:35  B
> 0     1   17   0  rcutorture: Add flag to produce non-busy-wait task stalls
> git bisect  bad a8d5875ce5f0b8c02a3c84c63ae10af237c5e82d  # 06:19  B
> 0     3   19   0  Default enable RCU list lockdep debugging with PROVE_RCU
> # first bad commit: [a8d5875ce5f0b8c02a3c84c63ae10af237c5e82d] Default
> enable RCU list lockdep debugging with PROVE_RCU
> git bisect good 18d76ac49038c85b9ef892e1da8cdcb5039eb7db  # 07:30  G
>  32     0    0   2  locktorture.c: Fix if-statement empty body warnings
> # extra tests with debug options
> git bisect  bad a8d5875ce5f0b8c02a3c84c63ae10af237c5e82d  # 07:51  B
> 0     1   17   0  Default enable RCU list lockdep debugging with PROVE_RCU
> # extra tests on revert first bad commit
> git bisect good 6a1d1b1ed35c55e5a9dfdf4635815681061569fc  # 10:30  G
>  11     0    0   0  Revert "Default enable RCU list lockdep debugging with
> PROVE_RCU"
> # good: [6a1d1b1ed35c55e5a9dfdf4635815681061569fc] Revert "Default enable
> RCU list lockdep debugging with PROVE_RCU"
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/lkp@lists.01.org

