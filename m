Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8352D47D1D8
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Dec 2021 13:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbhLVMjp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Dec 2021 07:39:45 -0500
Received: from mga14.intel.com ([192.55.52.115]:11368 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233073AbhLVMjn (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Dec 2021 07:39:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640176783; x=1671712783;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=L9ahR0ath3JfEFbK05SN0gPCPV8gLwBNq8oTGTK3Avk=;
  b=WjqrZ/whKd91o9aGY/R7/B6YUWAMfSFmOf3+6FnbanIuARLBwprEYrk9
   gSgGWsBhFli/L/mj7MhS0lT7Jc1ZWS6lNYrfmQWJTj4Hka1XXYAANwG3t
   2f8F0Y/jJsMvcvNQh2jOZ0Jx+lssFLKhk0slXAtDgYVe7Pw7YRcVMCaMG
   X/dHluXpeLARVAPIeBWfy6LwdsGKh8sX+mD8JqXxrZ0dMruzcFzsIVLUB
   uxehInLsFl1Glk2ZFU+yLHBo2q/Jdha6sJhF3MPmb0DZgsNi1lsb4gbKQ
   ifiO/6nYhmxYZC8wsUDvwWQ5BPnV2SOnF6u/Fyv9kT/Un2EIXOQI6IABF
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="240833276"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="240833276"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 04:39:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="664260676"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 Dec 2021 04:39:42 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n00uD-0000RF-Kf; Wed, 22 Dec 2021 12:39:41 +0000
Date:   Wed, 22 Dec 2021 20:39:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [zohar-integrity:next-integrity-testing 1/1]
 security/integrity/platform_certs/load_uefi.c:181:14: error: implicit
 declaration of function 'arch_ima_get_secureboot'
Message-ID: <202112222059.iWtmv7w7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity-testing
head:   20ffdadfdf082e2e7cfb2fe7f7e4aa60683052d7
commit: 20ffdadfdf082e2e7cfb2fe7f7e4aa60683052d7 [1/1] integrity: Do not load MOK and MOKx when secure boot be disabled
config: ia64-randconfig-r011-20211222 (https://download.01.org/0day-ci/archive/20211222/202112222059.iWtmv7w7-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/commit/?id=20ffdadfdf082e2e7cfb2fe7f7e4aa60683052d7
        git remote add zohar-integrity https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
        git fetch --no-tags zohar-integrity next-integrity-testing
        git checkout 20ffdadfdf082e2e7cfb2fe7f7e4aa60683052d7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/ia64/include/asm/pgtable.h:153,
                    from include/linux/pgtable.h:6,
                    from arch/ia64/include/asm/uaccess.h:40,
                    from include/linux/uaccess.h:11,
                    from include/linux/sched/task.h:11,
                    from include/linux/sched/signal.h:9,
                    from include/linux/rcuwait.h:6,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from include/linux/proc_fs.h:10,
                    from include/linux/efi.h:19,
                    from security/integrity/platform_certs/load_uefi.c:7:
   arch/ia64/include/asm/mmu_context.h: In function 'reload_context':
   arch/ia64/include/asm/mmu_context.h:127:48: warning: variable 'old_rr4' set but not used [-Wunused-but-set-variable]
     127 |         unsigned long rr0, rr1, rr2, rr3, rr4, old_rr4;
         |                                                ^~~~~~~
   security/integrity/platform_certs/load_uefi.c: In function 'load_uefi_certs':
>> security/integrity/platform_certs/load_uefi.c:181:14: error: implicit declaration of function 'arch_ima_get_secureboot' [-Werror=implicit-function-declaration]
     181 |         if (!arch_ima_get_secureboot())
         |              ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/arch_ima_get_secureboot +181 security/integrity/platform_certs/load_uefi.c

   125	
   126	/*
   127	 * load_uefi_certs() - Load certs from UEFI sources
   128	 *
   129	 * Load the certs contained in the UEFI databases into the platform trusted
   130	 * keyring and the UEFI blacklisted X.509 cert SHA256 hashes into the blacklist
   131	 * keyring.
   132	 */
   133	static int __init load_uefi_certs(void)
   134	{
   135		efi_guid_t secure_var = EFI_IMAGE_SECURITY_DATABASE_GUID;
   136		efi_guid_t mok_var = EFI_SHIM_LOCK_GUID;
   137		void *db = NULL, *dbx = NULL, *mokx = NULL;
   138		unsigned long dbsize = 0, dbxsize = 0, mokxsize = 0;
   139		efi_status_t status;
   140		int rc = 0;
   141	
   142		if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE))
   143			return false;
   144	
   145		/* Get db and dbx.  They might not exist, so it isn't an error
   146		 * if we can't get them.
   147		 */
   148		if (!uefi_check_ignore_db()) {
   149			db = get_cert_list(L"db", &secure_var, &dbsize, &status);
   150			if (!db) {
   151				if (status == EFI_NOT_FOUND)
   152					pr_debug("MODSIGN: db variable wasn't found\n");
   153				else
   154					pr_err("MODSIGN: Couldn't get UEFI db list\n");
   155			} else {
   156				rc = parse_efi_signature_list("UEFI:db",
   157						db, dbsize, get_handler_for_db);
   158				if (rc)
   159					pr_err("Couldn't parse db signatures: %d\n",
   160					       rc);
   161				kfree(db);
   162			}
   163		}
   164	
   165		dbx = get_cert_list(L"dbx", &secure_var, &dbxsize, &status);
   166		if (!dbx) {
   167			if (status == EFI_NOT_FOUND)
   168				pr_debug("dbx variable wasn't found\n");
   169			else
   170				pr_info("Couldn't get UEFI dbx list\n");
   171		} else {
   172			rc = parse_efi_signature_list("UEFI:dbx",
   173						      dbx, dbxsize,
   174						      get_handler_for_dbx);
   175			if (rc)
   176				pr_err("Couldn't parse dbx signatures: %d\n", rc);
   177			kfree(dbx);
   178		}
   179	
   180		/* the MOK/MOKx can not be trusted when secure boot is disabled */
 > 181		if (!arch_ima_get_secureboot())

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
