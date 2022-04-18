Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15EEC505DD3
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Apr 2022 20:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347297AbiDRSF0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 18 Apr 2022 14:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347295AbiDRSFZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Apr 2022 14:05:25 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5B03586A;
        Mon, 18 Apr 2022 11:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650304965; x=1681840965;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r2LvCWWhsD0xa0qyiMF8G3A6xlqv4L4gzs5uVZF3bYs=;
  b=jYCiavUytSoUZ22zM/zF4djhx6XXS2v9wJiwG0ZmIuPM/DFzvTiBkUKd
   cj/uRrX2uH3tczHd0aIvAhIGgVmXWBPtaKpcRSDr+TTj5miUo2OnUuAX1
   5SJW+LBHJQ7QH+4HsvzI+fsEgHeoV0/4Hn4V502PajsoQhsfaLiybwdTJ
   5+0Fn8j7K1XlU1dcosmIII2m/m2nESczU0ZIQfYNhc/E10Pcu5/IBQINj
   DlW2IzifPho5RnAVtSavZ0FPcu5spFtQnd4EnS5swtqt/6eWPwhPOJVyP
   j5fHtyh0f+ZFvsN0O8LAVXIJaaqVPplFyN+ZjawQiml6ufgHcNtAFUJ4U
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="263753686"
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="263753686"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 11:02:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="860147611"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 18 Apr 2022 11:02:41 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngVhw-0004qg-FV;
        Mon, 18 Apr 2022 18:02:40 +0000
Date:   Tue, 19 Apr 2022 02:02:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     kbuild-all@lists.01.org, casey@schaufler-ca.com,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v35 13/29] LSM: Use lsmblob in security_cred_getsecid
Message-ID: <202204190104.VspbI376-lkp@intel.com>
References: <20220418145945.38797-14-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418145945.38797-14-casey@schaufler-ca.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20220419/202204190104.VspbI376-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/2fa01492487f9135e9ea9e59924289cc23a66576
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Casey-Schaufler/integrity-disassociate-ima_filter_rule-from-security_audit_rule/20220419-000109
        git checkout 2fa01492487f9135e9ea9e59924289cc23a66576
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash kernel/sched/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/perf_event.h:61,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from include/linux/syscalls_api.h:1,
                    from kernel/sched/core.c:13:
   include/linux/security.h: In function 'security_cred_getsecid':
>> include/linux/security.h:1147:10: error: 'secid' undeclared (first use in this function)
    1147 |         *secid = 0;
         |          ^~~~~
   include/linux/security.h:1147:10: note: each undeclared identifier is reported only once for each function it appears in
   kernel/sched/core.c: At top level:
   kernel/sched/core.c:5235:20: warning: no previous prototype for 'task_sched_runtime' [-Wmissing-prototypes]
    5235 | unsigned long long task_sched_runtime(struct task_struct *p)
         |                    ^~~~~~~~~~~~~~~~~~
   kernel/sched/core.c:9420:13: warning: no previous prototype for 'sched_init_smp' [-Wmissing-prototypes]
    9420 | void __init sched_init_smp(void)
         |             ^~~~~~~~~~~~~~
   kernel/sched/core.c:9448:13: warning: no previous prototype for 'sched_init' [-Wmissing-prototypes]
    9448 | void __init sched_init(void)
         |             ^~~~~~~~~~
--
   In file included from include/linux/perf_event.h:61,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from include/linux/syscalls_api.h:1,
                    from kernel/sched/sched.h:60,
                    from kernel/sched/fair.c:53:
   include/linux/security.h: In function 'security_cred_getsecid':
>> include/linux/security.h:1147:10: error: 'secid' undeclared (first use in this function)
    1147 |         *secid = 0;
         |          ^~~~~
   include/linux/security.h:1147:10: note: each undeclared identifier is reported only once for each function it appears in
   kernel/sched/fair.c: At top level:
   kernel/sched/fair.c:5530:6: warning: no previous prototype for 'init_cfs_bandwidth' [-Wmissing-prototypes]
    5530 | void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b) {}
         |      ^~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:11757:6: warning: no previous prototype for 'free_fair_sched_group' [-Wmissing-prototypes]
   11757 | void free_fair_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:11759:5: warning: no previous prototype for 'alloc_fair_sched_group' [-Wmissing-prototypes]
   11759 | int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
         |     ^~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:11764:6: warning: no previous prototype for 'online_fair_sched_group' [-Wmissing-prototypes]
   11764 | void online_fair_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/fair.c:11766:6: warning: no previous prototype for 'unregister_fair_sched_group' [-Wmissing-prototypes]
   11766 | void unregister_fair_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/perf_event.h:61,
                    from include/linux/trace_events.h:10,
                    from include/trace/syscall.h:7,
                    from include/linux/syscalls.h:88,
                    from include/linux/syscalls_api.h:1,
                    from kernel/sched/sched.h:60,
                    from kernel/sched/build_policy.c:33:
   include/linux/security.h: In function 'security_cred_getsecid':
>> include/linux/security.h:1147:10: error: 'secid' undeclared (first use in this function)
    1147 |         *secid = 0;
         |          ^~~~~
   include/linux/security.h:1147:10: note: each undeclared identifier is reported only once for each function it appears in
   In file included from kernel/sched/build_policy.c:43:
   kernel/sched/rt.c: At top level:
   kernel/sched/rt.c:259:6: warning: no previous prototype for 'unregister_rt_sched_group' [-Wmissing-prototypes]
     259 | void unregister_rt_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   kernel/sched/rt.c:261:6: warning: no previous prototype for 'free_rt_sched_group' [-Wmissing-prototypes]
     261 | void free_rt_sched_group(struct task_group *tg) { }
         |      ^~~~~~~~~~~~~~~~~~~
   kernel/sched/rt.c:263:5: warning: no previous prototype for 'alloc_rt_sched_group' [-Wmissing-prototypes]
     263 | int alloc_rt_sched_group(struct task_group *tg, struct task_group *parent)
         |     ^~~~~~~~~~~~~~~~~~~~
   kernel/sched/rt.c:666:6: warning: no previous prototype for 'sched_rt_bandwidth_account' [-Wmissing-prototypes]
     666 | bool sched_rt_bandwidth_account(struct rt_rq *rt_rq)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from kernel/sched/build_utility.c:39:
   include/linux/security.h: In function 'security_cred_getsecid':
>> include/linux/security.h:1147:10: error: 'secid' undeclared (first use in this function)
    1147 |         *secid = 0;
         |          ^~~~~
   include/linux/security.h:1147:10: note: each undeclared identifier is reported only once for each function it appears in


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
