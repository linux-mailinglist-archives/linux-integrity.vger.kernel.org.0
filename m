Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB10506120
	for <lists+linux-integrity@lfdr.de>; Tue, 19 Apr 2022 02:46:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238560AbiDSAo4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 18 Apr 2022 20:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235718AbiDSAoz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Apr 2022 20:44:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C83DE0D5;
        Mon, 18 Apr 2022 17:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650328934; x=1681864934;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=frB5QOYxSqAyWSD2ynDwz+T5qJ31zUFLXfjyUiR6fns=;
  b=O4J/O282UxBwkX3WaJ5OCPQH8OicPT96tcB9jLnRMWHg8U3BgAJVdpza
   ixEm3EvF0ZNP7nD2StQMaxNIbYVYXAKO6s4GR7NZVDLI0hifEdxmdHaCx
   RZzVEJKaZbFq26SPIWxWuDnYfLG+3CszQiub7hLeqSkXz+xfmG1o+qck1
   aJiwRo9A+vf6EWDhOBkSn2aeCf0H8p54ZeP5Bo6GEQNtPlAQ2nXOtRXFc
   zA5uGXwk25akLjTGldf6algOE6/AP13ZgLQPbd/DbG96P4enjKHtiGBDE
   D8raMuE9IAWA64S5eLlgMAFGchMHzHNkl9fFOlLlEOEaSQA39nq1JJDdF
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="243574265"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="243574265"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 17:42:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="726849810"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 18 Apr 2022 17:42:08 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngbwV-000588-Sj;
        Tue, 19 Apr 2022 00:42:07 +0000
Date:   Tue, 19 Apr 2022 08:41:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        casey@schaufler-ca.com, linux-audit@redhat.com,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH v35 13/29] LSM: Use lsmblob in security_cred_getsecid
Message-ID: <202204190850.dXILQlrb-lkp@intel.com>
References: <20220418145945.38797-14-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418145945.38797-14-casey@schaufler-ca.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Casey,

I love your patch! Yet something to improve:

[auto build test ERROR on pcmoore-selinux/next]
[also build test ERROR on linus/master v5.18-rc3 next-20220414]
[cannot apply to pcmoore-audit/next jmorris-security/next-testing]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Casey-Schaufler/integrity-disassociate-ima_filter_rule-from-security_audit_rule/20220419-000109
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git next
config: arm-milbeaut_m10v_defconfig (https://download.01.org/0day-ci/archive/20220419/202204190850.dXILQlrb-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 429cbac0390654f90bba18a41799464adf31a5ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/2fa01492487f9135e9ea9e59924289cc23a66576
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Casey-Schaufler/integrity-disassociate-ima_filter_rule-from-security_audit_rule/20220419-000109
        git checkout 2fa01492487f9135e9ea9e59924289cc23a66576
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/firmware/efi/efi.c:33:
>> include/linux/security.h:1147:3: error: use of undeclared identifier 'secid'
           *secid = 0;
            ^
   drivers/firmware/efi/efi.c:169:16: warning: no previous prototype for function 'efi_attr_is_visible' [-Wmissing-prototypes]
   umode_t __weak efi_attr_is_visible(struct kobject *kobj, struct attribute *attr,
                  ^
   drivers/firmware/efi/efi.c:169:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   umode_t __weak efi_attr_is_visible(struct kobject *kobj, struct attribute *attr,
   ^
   static 
   1 warning and 1 error generated.
--
   In file included from fs/iomap/trace.c:12:
   In file included from fs/iomap/./trace.h:190:
   In file included from include/trace/define_trace.h:102:
   In file included from include/trace/trace_events.h:21:
   In file included from include/linux/trace_events.h:10:
   In file included from include/linux/perf_event.h:61:
>> include/linux/security.h:1147:3: error: use of undeclared identifier 'secid'
           *secid = 0;
            ^
   1 error generated.
--
   In file included from init/main.c:21:
   In file included from include/linux/syscalls.h:88:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:10:
   In file included from include/linux/perf_event.h:61:
>> include/linux/security.h:1147:3: error: use of undeclared identifier 'secid'
           *secid = 0;
            ^
   init/main.c:769:20: warning: no previous prototype for function 'arch_post_acpi_subsys_init' [-Wmissing-prototypes]
   void __init __weak arch_post_acpi_subsys_init(void) { }
                      ^
   init/main.c:769:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init __weak arch_post_acpi_subsys_init(void) { }
   ^
   static 
   init/main.c:781:20: warning: no previous prototype for function 'mem_encrypt_init' [-Wmissing-prototypes]
   void __init __weak mem_encrypt_init(void) { }
                      ^
   init/main.c:781:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init __weak mem_encrypt_init(void) { }
   ^
   static 
   init/main.c:783:20: warning: no previous prototype for function 'poking_init' [-Wmissing-prototypes]
   void __init __weak poking_init(void) { }
                      ^
   init/main.c:783:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init __weak poking_init(void) { }
   ^
   static 
   3 warnings and 1 error generated.
--
   In file included from arch/arm/kernel/ptrace.c:17:
>> include/linux/security.h:1147:3: error: use of undeclared identifier 'secid'
           *secid = 0;
            ^
   arch/arm/kernel/ptrace.c:852:16: warning: no previous prototype for function 'syscall_trace_enter' [-Wmissing-prototypes]
   asmlinkage int syscall_trace_enter(struct pt_regs *regs)
                  ^
   arch/arm/kernel/ptrace.c:852:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage int syscall_trace_enter(struct pt_regs *regs)
              ^
              static 
   arch/arm/kernel/ptrace.c:880:17: warning: no previous prototype for function 'syscall_trace_exit' [-Wmissing-prototypes]
   asmlinkage void syscall_trace_exit(struct pt_regs *regs)
                   ^
   arch/arm/kernel/ptrace.c:880:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void syscall_trace_exit(struct pt_regs *regs)
              ^
              static 
   2 warnings and 1 error generated.
--
   In file included from arch/arm/kernel/signal.c:14:
   In file included from include/linux/syscalls.h:88:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:10:
   In file included from include/linux/perf_event.h:61:
>> include/linux/security.h:1147:3: error: use of undeclared identifier 'secid'
           *secid = 0;
            ^
   arch/arm/kernel/signal.c:186:16: warning: no previous prototype for function 'sys_sigreturn' [-Wmissing-prototypes]
   asmlinkage int sys_sigreturn(struct pt_regs *regs)
                  ^
   arch/arm/kernel/signal.c:186:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage int sys_sigreturn(struct pt_regs *regs)
              ^
              static 
   arch/arm/kernel/signal.c:216:16: warning: no previous prototype for function 'sys_rt_sigreturn' [-Wmissing-prototypes]
   asmlinkage int sys_rt_sigreturn(struct pt_regs *regs)
                  ^
   arch/arm/kernel/signal.c:216:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage int sys_rt_sigreturn(struct pt_regs *regs)
              ^
              static 
   arch/arm/kernel/signal.c:601:1: warning: no previous prototype for function 'do_work_pending' [-Wmissing-prototypes]
   do_work_pending(struct pt_regs *regs, unsigned int thread_flags, int syscall)
   ^
   arch/arm/kernel/signal.c:600:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage int
              ^
              static 
   3 warnings and 1 error generated.
--
   In file included from arch/arm/kernel/sys_arm.c:20:
   In file included from include/linux/syscalls.h:88:
   In file included from include/trace/syscall.h:7:
   In file included from include/linux/trace_events.h:10:
   In file included from include/linux/perf_event.h:61:
>> include/linux/security.h:1147:3: error: use of undeclared identifier 'secid'
           *secid = 0;
            ^
   In file included from arch/arm/kernel/sys_arm.c:21:
   include/linux/mman.h:158:9: warning: division by zero is undefined [-Wdivision-by-zero]
                  _calc_vm_trans(flags, MAP_SYNC,       VM_SYNC      ) |
                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/mman.h:136:21: note: expanded from macro '_calc_vm_trans'
      : ((x) & (bit1)) / ((bit1) / (bit2))))
                       ^ ~~~~~~~~~~~~~~~~~
   arch/arm/kernel/sys_arm.c:32:17: warning: no previous prototype for function 'sys_arm_fadvise64_64' [-Wmissing-prototypes]
   asmlinkage long sys_arm_fadvise64_64(int fd, int advice,
                   ^
   arch/arm/kernel/sys_arm.c:32:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage long sys_arm_fadvise64_64(int fd, int advice,
              ^
              static 
   2 warnings and 1 error generated.
--
   In file included from arch/arm/kernel/smp.c:52:
   In file included from include/trace/events/ipi.h:90:
   In file included from include/trace/define_trace.h:102:
   In file included from include/trace/trace_events.h:21:
   In file included from include/linux/trace_events.h:10:
   In file included from include/linux/perf_event.h:61:
>> include/linux/security.h:1147:3: error: use of undeclared identifier 'secid'
           *secid = 0;
            ^
   arch/arm/kernel/smp.c:582:6: warning: no previous prototype for function 'arch_irq_work_raise' [-Wmissing-prototypes]
   void arch_irq_work_raise(void)
        ^
   arch/arm/kernel/smp.c:582:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void arch_irq_work_raise(void)
   ^
   static 
   arch/arm/kernel/smp.c:793:5: warning: no previous prototype for function 'setup_profiling_timer' [-Wmissing-prototypes]
   int setup_profiling_timer(unsigned int multiplier)
       ^
   arch/arm/kernel/smp.c:793:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int setup_profiling_timer(unsigned int multiplier)
   ^
   static 
   2 warnings and 1 error generated.
--
   In file included from arch/arm/mm/fault.c:19:
   In file included from include/linux/perf_event.h:61:
>> include/linux/security.h:1147:3: error: use of undeclared identifier 'secid'
           *secid = 0;
            ^
   arch/arm/mm/fault.c:535:1: warning: no previous prototype for function 'do_DataAbort' [-Wmissing-prototypes]
   do_DataAbort(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
   ^
   arch/arm/mm/fault.c:534:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void
              ^
              static 
   arch/arm/mm/fault.c:565:1: warning: no previous prototype for function 'do_PrefetchAbort' [-Wmissing-prototypes]
   do_PrefetchAbort(unsigned long addr, unsigned int ifsr, struct pt_regs *regs)
   ^
   arch/arm/mm/fault.c:564:12: note: declare 'static' if the function is not intended to be used outside of this translation unit
   asmlinkage void
              ^
              static 
   2 warnings and 1 error generated.
--
   In file included from kernel/fork.c:51:
>> include/linux/security.h:1147:3: error: use of undeclared identifier 'secid'
           *secid = 0;
            ^
   kernel/fork.c:163:13: warning: no previous prototype for function 'arch_release_task_struct' [-Wmissing-prototypes]
   void __weak arch_release_task_struct(struct task_struct *tsk)
               ^
   kernel/fork.c:163:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __weak arch_release_task_struct(struct task_struct *tsk)
   ^
   static 
   kernel/fork.c:853:20: warning: no previous prototype for function 'arch_task_cache_init' [-Wmissing-prototypes]
   void __init __weak arch_task_cache_init(void) { }
                      ^
   kernel/fork.c:853:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __init __weak arch_task_cache_init(void) { }
   ^
   static 
   kernel/fork.c:948:12: warning: no previous prototype for function 'arch_dup_task_struct' [-Wmissing-prototypes]
   int __weak arch_dup_task_struct(struct task_struct *dst,
              ^
   kernel/fork.c:948:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __weak arch_dup_task_struct(struct task_struct *dst,
   ^
   static 
   3 warnings and 1 error generated.
--
   In file included from kernel/signal.c:29:
>> include/linux/security.h:1147:3: error: use of undeclared identifier 'secid'
           *secid = 0;
            ^
   kernel/signal.c:137:37: warning: array index 3 is past the end of the array (which contains 2 elements) [-Warray-bounds]
           case 4: ready  = signal->sig[3] &~ blocked->sig[3];
                                              ^            ~
   arch/arm/include/asm/signal.h:17:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   kernel/signal.c:137:19: warning: array index 3 is past the end of the array (which contains 2 elements) [-Warray-bounds]
           case 4: ready  = signal->sig[3] &~ blocked->sig[3];
                            ^           ~
   arch/arm/include/asm/signal.h:17:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   kernel/signal.c:138:30: warning: array index 2 is past the end of the array (which contains 2 elements) [-Warray-bounds]
                   ready |= signal->sig[2] &~ blocked->sig[2];
                                              ^            ~
   arch/arm/include/asm/signal.h:17:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   kernel/signal.c:138:12: warning: array index 2 is past the end of the array (which contains 2 elements) [-Warray-bounds]
                   ready |= signal->sig[2] &~ blocked->sig[2];
                            ^           ~
   arch/arm/include/asm/signal.h:17:2: note: array 'sig' declared here
           unsigned long sig[_NSIG_WORDS];
           ^
   4 warnings and 1 error generated.
--
   In file included from kernel/kallsyms.c:25:
   In file included from include/linux/filter.h:20:
   In file included from include/linux/if_vlan.h:10:
   In file included from include/linux/netdevice.h:46:
   In file included from include/uapi/linux/neighbour.h:6:
   In file included from include/linux/netlink.h:9:
   In file included from include/net/scm.h:8:
>> include/linux/security.h:1147:3: error: use of undeclared identifier 'secid'
           *secid = 0;
            ^
   kernel/kallsyms.c:591:12: warning: no previous prototype for function 'arch_get_kallsym' [-Wmissing-prototypes]
   int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
              ^
   kernel/kallsyms.c:591:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int __weak arch_get_kallsym(unsigned int symnum, unsigned long *value,
   ^
   static 
   1 warning and 1 error generated.
..


vim +/secid +1147 include/linux/security.h

ee18d64c1f6320 David Howells   2009-09-02  1143  
2fa01492487f91 Casey Schaufler 2022-04-18  1144  static inline void security_cred_getsecid(const struct cred *c,
2fa01492487f91 Casey Schaufler 2022-04-18  1145  					  struct lsmblob *blob)
4d5b5539742d25 Todd Kjos       2021-10-12  1146  {
4d5b5539742d25 Todd Kjos       2021-10-12 @1147  	*secid = 0;
4d5b5539742d25 Todd Kjos       2021-10-12  1148  }
4d5b5539742d25 Todd Kjos       2021-10-12  1149  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
