Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20324CB35B
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Mar 2022 01:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbiCBX6x (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Mar 2022 18:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiCBX6w (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Mar 2022 18:58:52 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5828B22B1E;
        Wed,  2 Mar 2022 15:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646265488; x=1677801488;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8rc56ekTbeKFOC2iDvS+DEuqovVns3lGZWNghGxdVAg=;
  b=K58o9uRBYY7duBV0u+jYh31vDxU+I046W1LQUrR72tM9GTIg55EGKIRG
   g9wQ2sLIJuqgOc81lnueCv9qK19KJc8sOFu9ghsR5Tp7du2meoSoMp1xG
   GNMeddsVdCF4m6tadQwrK7PK2CwqLG8Q8ba8gFD50p0mT3OilmwXz5Pt9
   yXdA43Y1HxmVSZjisWpOzaMNHfElUX97sysjhbL70AIboLqILB69W1zRK
   vEpthpy0DDyD5pwGKVkHh4+fR9APIHQ3cpFSn80xMyRvWTgDmRVKGvzch
   gLiOX0P8160SYjU3at5j/zDuPFMeCBIqvaAh7BuMhL+BZdk2YnT6oDpxI
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="251101580"
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="251101580"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 15:12:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,150,1643702400"; 
   d="scan'208";a="630572209"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Mar 2022 15:11:59 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPY8U-00023G-Fz; Wed, 02 Mar 2022 23:11:58 +0000
Date:   Thu, 3 Mar 2022 07:11:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, zohar@linux.ibm.com,
        serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v11 26/27] ima: Restrict informational audit messages to
 init_ima_ns
Message-ID: <202203030748.dQ8i3hT2-lkp@intel.com>
References: <20220302134703.1273041-27-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302134703.1273041-27-stefanb@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Stefan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.17-rc6]
[cannot apply to zohar-integrity/next-integrity linux/master jmorris-security/next-testing next-20220302]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Stefan-Berger/ima-Namespace-IMA-with-audit-support-in-IMA-ns/20220302-215707
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git fb184c4af9b9f4563e7a126219389986a71d5b5b
config: arm64-randconfig-r006-20220302 (https://download.01.org/0day-ci/archive/20220303/202203030748.dQ8i3hT2-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/0day-ci/linux/commit/781d4b92eee902d5ebcac657814703974f8e8b28
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Stefan-Berger/ima-Namespace-IMA-with-audit-support-in-IMA-ns/20220302-215707
        git checkout 781d4b92eee902d5ebcac657814703974f8e8b28
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> security/integrity/ima/ima_main.c:200:32: error: too many arguments to function call, expected 2, have 3
                                   ima_update_xattr(ns, iint, file);
                                   ~~~~~~~~~~~~~~~~           ^~~~
   security/integrity/ima/ima.h:413:20: note: 'ima_update_xattr' declared here
   static inline void ima_update_xattr(struct integrity_iint_cache *iint,
                      ^
   1 error generated.


vim +200 security/integrity/ima/ima_main.c

   176	
   177	static void ima_check_last_writer(struct ima_namespace *ns,
   178					  struct integrity_iint_cache *iint,
   179					  struct inode *inode, struct file *file)
   180	{
   181		fmode_t mode = file->f_mode;
   182		bool update;
   183	
   184		if (!(mode & FMODE_WRITE))
   185			return;
   186	
   187		mutex_lock(&iint->mutex);
   188		if (atomic_read(&inode->i_writecount) == 1) {
   189			update = test_and_clear_bit(IMA_UPDATE_XATTR,
   190						    &iint->atomic_flags);
   191			if (!IS_I_VERSION(inode) ||
   192			    !inode_eq_iversion(inode, iint->version) ||
   193			    (iint->flags & IMA_NEW_FILE)) {
   194				mask_iint_ns_status_flags
   195						(iint,
   196						 ~(IMA_DONE_MASK | IMA_NEW_FILE));
   197				iint->measured_pcrs = 0;
   198	
   199				if (update)
 > 200					ima_update_xattr(ns, iint, file);
   201			}
   202		}
   203		mutex_unlock(&iint->mutex);
   204	}
   205	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
