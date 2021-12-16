Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5180A477476
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Dec 2021 15:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbhLPO1M (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Dec 2021 09:27:12 -0500
Received: from mga09.intel.com ([134.134.136.24]:5771 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237965AbhLPO1L (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Dec 2021 09:27:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639664831; x=1671200831;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tN8CmaSc/CNq7e0TnIFD29SQmKDFc+7kbeCMyugI1OA=;
  b=O0iJoRA0C8tS6/Kx7C/n6p/q2eE/goI1XIgtqNEOVS4y4HX1hakR7DGu
   DvesFQurd/7yDbiBYt10/CuaEzckGSrvGPq25OIobu81dG687zGo1RF1X
   I6IRN8C2lre/Phy6mFcke/UIHhdHUTF1SfDopNsimcraURafyVjNDrYLQ
   FTxxwtRBdRkA6mMQJ5rmwhJnYHbzSz8ym+3yM37oU/7xa9i3BGky7RCji
   TKunZ5mhVSrrU6oYBBGx/PLmxM6JgKK7YT9orJVNUWQa/MvanUkPoUvSe
   /ZihucCKgagW4hHGtknZLDSN6KKOv1/EppFZ4hGgp2j+ed+CCfPsmMkn7
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="239315323"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="239315323"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 06:27:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="754083242"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 16 Dec 2021 06:27:07 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxrit-0003KT-4t; Thu, 16 Dec 2021 14:27:07 +0000
Date:   Thu, 16 Dec 2021 22:26:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     kbuild-all@lists.01.org, zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com
Subject: Re: [PATCH v7 04/14] ima: Move policy related variables into
 ima_namespace
Message-ID: <202112162247.XcCvdc6L-lkp@intel.com>
References: <20211216054323.1707384-5-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216054323.1707384-5-stefanb@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Stefan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on zohar-integrity/next-integrity]
[also build test ERROR on linux/master linus/master v5.16-rc5]
[cannot apply to jmorris-security/next-testing next-20211215]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Stefan-Berger/ima-Namespace-IMA-with-audit-support-in-IMA-ns/20211216-134611
base:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity
config: alpha-buildonly-randconfig-r004-20211216 (https://download.01.org/0day-ci/archive/20211216/202112162247.XcCvdc6L-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/4927ddb1c276a9aa164fced45c2614ec93b5b425
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Stefan-Berger/ima-Namespace-IMA-with-audit-support-in-IMA-ns/20211216-134611
        git checkout 4927ddb1c276a9aa164fced45c2614ec93b5b425
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash security/integrity/ima/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   security/integrity/ima/ima_policy.c: In function 'ima_update_policy':
>> security/integrity/ima/ima_policy.c:1014:9: error: too many arguments to function 'ima_process_queued_keys'
    1014 |         ima_process_queued_keys(ns);
         |         ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from security/integrity/ima/ima_policy.c:23:
   security/integrity/ima/ima.h:276:20: note: declared here
     276 | static inline void ima_process_queued_keys(void) {}
         |                    ^~~~~~~~~~~~~~~~~~~~~~~


vim +/ima_process_queued_keys +1014 security/integrity/ima/ima_policy.c

   980	
   981	/**
   982	 * ima_update_policy - update default_rules with new measure rules
   983	 * @ns: IMA namespace that has the policy
   984	 * Called on file .release to update the default rules with a complete new
   985	 * policy.  What we do here is to splice ima_policy_rules and ima_temp_rules so
   986	 * they make a queue.  The policy may be updated multiple times and this is the
   987	 * RCU updater.
   988	 *
   989	 * Policy rules are never deleted so ima_policy_flag gets zeroed only once when
   990	 * we switch from the default policy to user defined.
   991	 */
   992	void ima_update_policy(struct ima_namespace *ns)
   993	{
   994		struct list_head *policy = &ns->ima_policy_rules;
   995	
   996		list_splice_tail_init_rcu(&ns->ima_temp_rules, policy,
   997					  synchronize_rcu);
   998	
   999		if (ns->ima_rules != (struct list_head __rcu *)policy) {
  1000			ns->ima_policy_flag = 0;
  1001	
  1002			rcu_assign_pointer(ns->ima_rules, policy);
  1003			/*
  1004			 * IMA architecture specific policy rules are specified
  1005			 * as strings and converted to an array of ima_entry_rules
  1006			 * on boot.  After loading a custom policy, free the
  1007			 * architecture specific rules stored as an array.
  1008			 */
  1009			kfree(arch_policy_entry);
  1010		}
  1011		ima_update_policy_flags(ns);
  1012	
  1013		/* Custom IMA policy has been loaded */
> 1014		ima_process_queued_keys(ns);
  1015	}
  1016	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
