Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6EB73B6BF
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Jun 2023 13:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjFWLtV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 23 Jun 2023 07:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbjFWLtJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 23 Jun 2023 07:49:09 -0400
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EFA3590
        for <linux-integrity@vger.kernel.org>; Fri, 23 Jun 2023 04:47:03 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4QnZtM3bf4z9yBlZ
        for <linux-integrity@vger.kernel.org>; Fri, 23 Jun 2023 19:35:39 +0800 (CST)
Received: from roberto-ThinkStation-P620 (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwA3_lT2hZVkpYeRAw--.30541S2;
        Fri, 23 Jun 2023 12:46:05 +0100 (CET)
Message-ID: <01135b4f26d4460179f3b7981d4736f73fa889ba.camel@huaweicloud.com>
Subject: Re: [PATCH v3 ima-evm-utils 4/4] Add simple tests to check EVM HMAC
 calculation
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@gmail.com
Cc:     linux-integrity@vger.kernel.org, vt@altlinux.org, pvorel@suse.cz,
        stefanb@linux.ibm.com, paul@paul-moore.com, casey@schaufler-ca.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Date:   Fri, 23 Jun 2023 13:45:54 +0200
In-Reply-To: <1f125e9153369f757749f0825e41a4685b9fe005.camel@linux.ibm.com>
References: <20230616192358.314906-1-roberto.sassu@huaweicloud.com>
         <20230616192358.314906-5-roberto.sassu@huaweicloud.com>
         <1f125e9153369f757749f0825e41a4685b9fe005.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwA3_lT2hZVkpYeRAw--.30541S2
X-Coremail-Antispam: 1UD129KBjvJXoWxur13XF4fCr1rZw4UCrW3KFg_yoWrCrW7p3
        y3GayxKrWkAryUur1fCa17Xrn7u398Wr4DJr92vF9rZFn5Zr9YvryUJ3W7urykC3y0yry3
        tFZ8GFsrKa1UAw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgmb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
        Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
        AY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
        cVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMI
        IF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2
        KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQARBF1jj481uQADsl
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2023-06-23 at 07:42 -0400, Mimi Zohar wrote:
> Hi Roberto,
> 
> On Fri, 2023-06-16 at 21:23 +0200, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> > 
> > Add a simple test to ensure that the kernel and evmctl provide the same
> > result for the HMAC calculation. Do it with SELinux or Smack, whichever is
> > available (if the UML kernel is used, the test is done with both LSMs).
> > 
> > Also add another test to evaluate the HMAC on a directory for which Smack
> > added the SMACK64TRANSMUTE xattr.
> > 
> > The second test fails without the kernel patch 'smack: Set the
> > SMACK64TRANSMUTE xattr in smack_inode_init_security()', as Smack uses
> > __vfs_setxattr() to set SMACK64TRANSMUTE, which does not go through EVM,
> > and makes the HMAC invalid.
> > 
> > Require (unless the UML kernel is used) that the TST_EVM_CHANGE_MODE
> > environment variable is set to 1, so that users acknowledge that they are
> > initializing EVM with a well-known HMAC key, which can introduce obvious
> > security concerns.
> > 
> > Finally, enable SELinux, the EVM additional xattrs, and encrypted keys with
> > user-decrypted data in the kernel configuration for CI, and set
> > TST_EVM_CHANGE_MODE to 1 in the Github Action workflow.
> > 
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> 
> The simple SELinux and Smack tests are working properly without kernel
> changes.  Even the Smack transmute test is working is proplery
> returning an error message, but is followed by a kernel panic.
> 
> Possibly missing patches:
>  - smack: Set the SMACK64TRANSMUTE xattr in smack_inode_init_security

Hi Mimi

that means that the test is failing.

A UML kernel panic is used to signal to the caller that a test in that
environment failed.

It is expected that the test fails, Smack updates its xattr with
__vfs_setxattr() which does not involve EVM checking and updating the
HMAC.

Thanks

Roberto

>    14.620000][    T1] Kernel panic - not syncing: Attempted to kill
> init! exitcode=0x00000100
> [   14.620000][    T1] CPU: 0 PID: 1 Comm: evm_hmac.test Not tainted
> 6.4.0-rc2-dont-use-g95526d13038c #1
> [   14.620000][    T1] Stack:
> [   14.620000][    T1]  60900a17 e1803be0 e1803c20 606f7598
> [   14.620000][    T1]  63240701 60043a50 60900a17 00000000
> [   14.620000][    T1]  60dfc308 00000000 e1803c60 60762e4b
> [   14.620000][    T1] Call Trace:
> [   14.620000][    T1]  [<6072ad82>] ? _printk+0x0/0x98
> [   14.620000][    T1]  [<6072274d>] show_stack.cold+0x9d/0xf4
> [   14.620000][    T1]  [<606f7598>] ? dump_stack_print_info+0xd8/0xf0
> [   14.620000][    T1]  [<60043a50>] ? um_set_signals+0x0/0x60
> [   14.620000][    T1]  [<60762e4b>] dump_stack_lvl+0x66/0x9a
> [   14.620000][    T1]  [<607715d0>] ? _raw_spin_unlock_irq+0x0/0x60
> [   14.620000][    T1]  [<60762e9d>] dump_stack+0x1e/0x20
> [   14.620000][    T1]  [<6072429d>] panic+0x1a6/0x3a6
> [   14.620000][    T1]  [<607240f7>] ? panic+0x0/0x3a6
> [   14.620000][    T1]  [<600aec6a>] ? lock_release+0xca/0x180
> [   14.620000][    T1]  [<60043a50>] ? um_set_signals+0x0/0x60
> [   14.620000][    T1]  [<60764fe0>] ?
> debug_lockdep_rcu_enabled+0x0/0x50
> [   14.620000][    T1]  [<60043a9f>] ? um_set_signals+0x4f/0x60
> [   14.620000][    T1]  [<60764fe0>] ?
> debug_lockdep_rcu_enabled+0x0/0x50
> [   14.620000][    T1]  [<60043a50>] ? um_set_signals+0x0/0x60
> [   14.620000][    T1]  [<60064d79>] ? exit_signals+0x139/0x500
> [   14.620000][    T1]  [<60771210>] ? _raw_spin_lock_irq+0x0/0xd0
> [   14.620000][    T1]  [<607715d0>] ? _raw_spin_unlock_irq+0x0/0x60
> [   14.620000][    T1]  [<607249c0>] make_task_dead.cold+0x0/0x9d
> [   14.620000][    T1]  [<600557e7>] do_group_exit+0x47/0xe0
> [   14.620000][    T1]  [<6004a0f0>] ? get_fp_registers+0x0/0x80
> [   14.620000][    T1]  [<6005589a>] sys_exit_group+0x1a/0x20
> [   14.620000][    T1]  [<600302a0>] handle_syscall+0xa0/0xd0
> [   14.620000][    T1]  [<60046969>] handle_trap+0xe9/0x1a0
> [   14.620000][    T1]  [<6004a0f0>] ? get_fp_registers+0x0/0x80
> [   14.620000][    T1]  [<6004709f>] userspace+0x29f/0x530
> [   14.620000][    T1]  [<6002c374>] new_thread_handler+0xb4/0xc0
> ./functions.sh: line 72:  8546 Aborted                 (core dumped)
> "$@"
> =================================
>  Run with FAILEARLY=1 ./evm_hmac.test _cleanup_env cleanup
>  To stop after first failure
> 

