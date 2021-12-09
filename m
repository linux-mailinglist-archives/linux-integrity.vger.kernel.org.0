Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C1746E907
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Dec 2021 14:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbhLINXF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Dec 2021 08:23:05 -0500
Received: from mga18.intel.com ([134.134.136.126]:21048 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230306AbhLINXF (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Dec 2021 08:23:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639055972; x=1670591972;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0oCW1VQbPxRRRG1yCpeFHLx2QRuvAS6IkaCU8uu83u4=;
  b=cDLuLfcrwVLnY6d4PFmUPlppfksiWg7khnZmYAczKQXCJdJVJ2rp/VtM
   a+0Qm1/wmCLzTQMOjYVu+98od80VSNpCl+IObwuz06mHHe4wPiSUrl0Vl
   p8bSLn+h8d0NuFKMIgbuzAMI+5IXrfXWuzZrMVR7HRy6WAS3IFQkJlgwd
   h4zqyfHYRYVcwoeko+YN+0ZcB0uvkxPIf50qjurRDLdqOkhMlAthd+OjC
   Aq6KxrPSp9npqYfO9sOf3Gx47XLltlrHf1vfFHK2QqE2mbc1cnAggPfYN
   KAzwQH068l+oPcxzPTvb5Gf5A+329k7PzcnwBEaed7hOuONmh/FjqIsz8
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="224961240"
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="224961240"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 05:19:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="480333772"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 09 Dec 2021 05:19:27 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvJKY-0001xG-Rj; Thu, 09 Dec 2021 13:19:26 +0000
Date:   Thu, 9 Dec 2021 21:19:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     kbuild-all@lists.01.org, zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com
Subject: Re: [PATCH v5 01/16] ima: Add IMA namespace support
Message-ID: <202112092123.r0jOHT8e-lkp@intel.com>
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
config: i386-randconfig-s031-20211207 (https://download.01.org/0day-ci/archive/20211209/202112092123.r0jOHT8e-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/0e5d16c2da02e9c61692836edf0b6f7f227e1867
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Stefan-Berger/ima-Namespace-IMA-with-audit-support-in-IMA-ns/20211209-062017
        git checkout 0e5d16c2da02e9c61692836edf0b6f7f227e1867
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   drivers/md/dm-ioctl.c: note: in included file:
>> include/linux/ima.h:263:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_IMA'
--
   fs/open.c: note: in included file:
>> include/linux/ima.h:263:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_IMA'
   fs/open.c:1011:21: sparse: sparse: restricted fmode_t degrades to integer
--
   fs/file_table.c: note: in included file:
>> include/linux/ima.h:263:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_IMA'
--
   fs/namei.c: note: in included file:
>> include/linux/ima.h:263:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_IMA'
   fs/namei.c:680:17: sparse: sparse: context imbalance in 'terminate_walk' - unexpected unlock
   fs/namei.c: note: in included file (through include/linux/rbtree.h, include/linux/mm_types.h, include/linux/mmzone.h, ...):
   include/linux/rcupdate.h:718:9: sparse: sparse: context imbalance in 'try_to_unlazy' - unexpected unlock
   include/linux/rcupdate.h:718:9: sparse: sparse: context imbalance in 'try_to_unlazy_next' - unexpected unlock
   fs/namei.c:2318:19: sparse: sparse: context imbalance in 'path_init' - different lock contexts for basic block
--
   fs/attr.c: note: in included file:
>> include/linux/ima.h:263:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_IMA'
--
   security/security.c: note: in included file:
>> include/linux/ima.h:263:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_IMA'
   security/security.c:358:25: sparse: sparse: cast removes address space '__rcu' of expression
--
   security/keys/key.c: note: in included file:
>> include/linux/ima.h:263:5: sparse: sparse: undefined preprocessor identifier 'CONFIG_IMA'
   security/keys/key.c:123:17: sparse: sparse: context imbalance in 'key_user_put' - unexpected unlock

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
