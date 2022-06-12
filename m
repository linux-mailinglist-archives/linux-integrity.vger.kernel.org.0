Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3092B547BDA
	for <lists+linux-integrity@lfdr.de>; Sun, 12 Jun 2022 21:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbiFLTgX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 12 Jun 2022 15:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbiFLTgX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 12 Jun 2022 15:36:23 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD6042490;
        Sun, 12 Jun 2022 12:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655062582; x=1686598582;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ojtznw2WjdPPDjXzrimd0H0ovfxUgD9/l5NTXljPMIw=;
  b=U1reWOQjHSCtJCbki7Xk6FuvZQcou3pcCyLd4bCgdue2tFAmQ8e9/0NE
   D9n4qkUSegOY3KErUAo0Ni7G9yNZwT/AxrN+CheNAQhs3/8qHji1HWBrN
   iTnal9dYsn1W9g9/9c5EoXlOlwhd5nYVAvJJufu+D/zJqc6le7cwfUME+
   f3GL9NB+WZP80VsNRZooDvysikav8b1cxTF0KBpEv8+wDLYY4lvfsueHy
   etx2KgSQ3mI1HoU/Kf6+EHXtll4YGksIGiOJ1R5YsWNTgTl0bvXWELc9X
   D7sr4vOHJhx8HZx18A/1sMwmDKBDSKT7KERINJIq0Mte4j+5ciOM2pPsF
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10376"; a="266794730"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="266794730"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2022 12:36:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; 
   d="scan'208";a="617212492"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 12 Jun 2022 12:36:18 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0TNh-000KAn-Po;
        Sun, 12 Jun 2022 19:36:17 +0000
Date:   Mon, 13 Jun 2022 03:35:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Casey Schaufler <casey@schaufler-ca.com>,
        casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Cc:     kbuild-all@lists.01.org, casey@schaufler-ca.com,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        paul@paul-moore.com, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Subject: Re: [PATCH v36 13/33] LSM: Use lsmblob in security_cred_getsecid
Message-ID: <202206130334.JHM4wNvh-lkp@intel.com>
References: <20220609230146.319210-14-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609230146.319210-14-casey@schaufler-ca.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
[also build test WARNING on pcmoore-selinux/next linus/master v5.19-rc1 next-20220610]
[cannot apply to jmorris-security/next-testing]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Casey-Schaufler/integrity-disassociate-ima_filter_rule-from-security_audit_rule/20220610-080129
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git next
config: x86_64-randconfig-s021 (https://download.01.org/0day-ci/archive/20220613/202206130334.JHM4wNvh-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-30-g92122700-dirty
        # https://github.com/intel-lab-lkp/linux/commit/c8f05b8d441f9790d67351b44e4c7c55013048ca
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Casey-Schaufler/integrity-disassociate-ima_filter_rule-from-security_audit_rule/20220610-080129
        git checkout c8f05b8d441f9790d67351b44e4c7c55013048ca
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> kernel/audit.c:128:25: sparse: sparse: symbol 'audit_sig_lsm' was not declared. Should it be static?
   kernel/audit.c:2221:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/audit.c:2221:9: sparse:     expected struct spinlock [usertype] *lock
   kernel/audit.c:2221:9: sparse:     got struct spinlock [noderef] __rcu *
   kernel/audit.c:2224:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   kernel/audit.c:2224:40: sparse:     expected struct spinlock [usertype] *lock
   kernel/audit.c:2224:40: sparse:     got struct spinlock [noderef] __rcu *

vim +/audit_sig_lsm +128 kernel/audit.c

   124	
   125	/* The identity of the user shutting down the audit system. */
   126	static kuid_t		audit_sig_uid = INVALID_UID;
   127	static pid_t		audit_sig_pid = -1;
 > 128	struct lsmblob		audit_sig_lsm;
   129	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
