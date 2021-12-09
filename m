Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F8846E198
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Dec 2021 05:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhLIEoo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Dec 2021 23:44:44 -0500
Received: from mga12.intel.com ([192.55.52.136]:33075 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229940AbhLIEon (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Dec 2021 23:44:43 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="218037863"
X-IronPort-AV: E=Sophos;i="5.88,191,1635231600"; 
   d="scan'208";a="218037863"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 20:41:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,191,1635231600"; 
   d="scan'208";a="750221147"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 08 Dec 2021 20:41:07 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvBEx-0001UL-5o; Thu, 09 Dec 2021 04:41:07 +0000
Date:   Thu, 9 Dec 2021 12:40:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     kbuild-all@lists.01.org, zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com
Subject: Re: [PATCH v5 01/16] ima: Add IMA namespace support
Message-ID: <202112091252.hCpFK6H4-lkp@intel.com>
References: <20211208221818.1519628-2-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208221818.1519628-2-stefanb@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Stefan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on zohar-integrity/next-integrity]
[also build test WARNING on linux/master linus/master v5.16-rc4 next-20211208]
[cannot apply to jmorris-security/next-testing]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Stefan-Berger/ima-Namespace-IMA-with-audit-support-in-IMA-ns/20211209-062017
base:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20211209/202112091252.hCpFK6H4-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/0e5d16c2da02e9c61692836edf0b6f7f227e1867
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Stefan-Berger/ima-Namespace-IMA-with-audit-support-in-IMA-ns/20211209-062017
        git checkout 0e5d16c2da02e9c61692836edf0b6f7f227e1867
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from fs/open.c:32:
   include/linux/ima.h: In function 'create_ima_ns':
>> include/linux/ima.h:263:5: warning: "CONFIG_IMA" is not defined, evaluates to 0 [-Wundef]
     263 | #if CONFIG_IMA
         |     ^~~~~~~~~~


vim +/CONFIG_IMA +263 include/linux/ima.h

   260	
   261	static inline int create_ima_ns(struct user_namespace *user_ns)
   262	{
 > 263	#if CONFIG_IMA
   264		user_ns->ima_ns = get_ima_ns(&init_ima_ns);
   265	#endif
   266		return 0;
   267	}
   268	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
