Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D6B4D6C81
	for <lists+linux-integrity@lfdr.de>; Sat, 12 Mar 2022 05:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiCLEwu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Mar 2022 23:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiCLEwu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Mar 2022 23:52:50 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAA9E9D;
        Fri, 11 Mar 2022 20:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647060703; x=1678596703;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZfF/lzNX9XMkZ21coHM0wPTpmygS6/b4qFfbU1ZtBVs=;
  b=R3t0O7y8fpYnAMSvpPCrpn577lD9ibGrZWs0NJdSnvRqaihqDE5o0uO5
   LXxC9TmVMUP/OhNgVWmkWRfLxi0EyONTlXnMtQ4LUTheNzRtRObIHfBcb
   SiRId0t6qxovmxA8daTDHL/j9ZVcg24vG4RFDN6TEKWYah4MPKdbvyaqi
   mLxgAR7DUQ4R7MBC/8vq+cD/XjRK5j1K46mn0K1NTt3U7ksGop4yRM73v
   9EvJ2ZYsFJ/VX/lZoiUhndBRpQ88ztfufOgO2JutljVg81Mz9XEaUMSU2
   gjuSeeTq+qM3Vt+j58ggOugioSKT2TJnOzUalqIIF1gGyVp0yHTHUXxxy
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="280502984"
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="280502984"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 20:51:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="497025121"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 11 Mar 2022 20:51:19 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nStio-0007WW-PR; Sat, 12 Mar 2022 04:51:18 +0000
Date:   Sat, 12 Mar 2022 12:50:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     kbuild-all@lists.01.org, casey@schaufler-ca.com,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v33 13/29] LSM: Use lsmblob in security_cred_getsecid
Message-ID: <202203121225.Ab2lmSD3-lkp@intel.com>
References: <20220310234632.16194-14-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220310234632.16194-14-casey@schaufler-ca.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Casey,

I love your patch! Perhaps something to improve:

[auto build test WARNING on pcmoore-audit/next]
[also build test WARNING on linus/master v5.17-rc7]
[cannot apply to pcmoore-selinux/next jmorris-security/next-testing next-20220310]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Casey-Schaufler/integrity-disassociate-ima_filter_rule-from-security_audit_rule/20220311-084644
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git next
config: microblaze-randconfig-s031-20220310 (https://download.01.org/0day-ci/archive/20220312/202203121225.Ab2lmSD3-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/77c3979bacdff1630a3c6211db065f2c79412621
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Casey-Schaufler/integrity-disassociate-ima_filter_rule-from-security_audit_rule/20220311-084644
        git checkout 77c3979bacdff1630a3c6211db065f2c79412621
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=microblaze SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> kernel/audit.c:128:25: sparse: sparse: symbol 'audit_sig_lsm' was not declared. Should it be static?
   kernel/audit.c:2197:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/audit.c:2197:9: sparse:     expected struct spinlock [usertype] *lock
   kernel/audit.c:2197:9: sparse:     got struct spinlock [noderef] __rcu *
   kernel/audit.c:2200:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/audit.c:2200:40: sparse:     expected struct spinlock [usertype] *lock
   kernel/audit.c:2200:40: sparse:     got struct spinlock [noderef] __rcu *

vim +/audit_sig_lsm +128 kernel/audit.c

   124	
   125	/* The identity of the user shutting down the audit system. */
   126	static kuid_t		audit_sig_uid = INVALID_UID;
   127	static pid_t		audit_sig_pid = -1;
 > 128	struct lsmblob		audit_sig_lsm;
   129	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
