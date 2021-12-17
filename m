Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0041A47917B
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Dec 2021 17:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239122AbhLQQaX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Dec 2021 11:30:23 -0500
Received: from mga14.intel.com ([192.55.52.115]:4196 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238012AbhLQQaW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Dec 2021 11:30:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639758622; x=1671294622;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hJxvFXlqstxE0A6tB6h1DuKJXHT/CIYN0MSb8KW7MYw=;
  b=CMyS8BNV5wxoNauxgSXRWworNI0ECP4LXUL1CBMpZNiMIwy9mjgqKB0z
   /Hyq7Uh1axx9nxp0v5bld54YZwEZyWbn1bgRHmgpTdN/bHrbsU3hlsRT3
   /aRAdTsyljbsy/CPfm4bVE+KmXcscD2ChGdzm9fy8NcmkFeXsGPt3pzGJ
   BAGjGYwo7T50TM4kpCNeyOgORaBqPbUegnGpgu2SzsVndSlHoL/0wsj77
   LKR7uCq1aL5pBxlDqOnS1HMmqBwXnYPTVpcCzRivhTOMExr/FvMLSC7pZ
   TDSxWVTlCUiRVE1wV/EyWuYm6004cQ35nvLB4c6EB/PYFg3oieCv3BuKm
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10201"; a="240007000"
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="240007000"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2021 08:30:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="683439808"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 17 Dec 2021 08:30:19 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1myG7e-0004vk-Py; Fri, 17 Dec 2021 16:30:18 +0000
Date:   Sat, 18 Dec 2021 00:29:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     kbuild-all@lists.01.org, zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com
Subject: Re: [PATCH v7 10/14] securityfs: Extend securityfs with namespacing
 support
Message-ID: <202112180002.CNO8riQv-lkp@intel.com>
References: <20211216054323.1707384-11-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216054323.1707384-11-stefanb@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Stefan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on zohar-integrity/next-integrity]
[also build test WARNING on linux/master linus/master v5.16-rc5]
[cannot apply to jmorris-security/next-testing next-20211217]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Stefan-Berger/ima-Namespace-IMA-with-audit-support-in-IMA-ns/20211216-134611
base:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity
config: i386-randconfig-s002-20211216 (https://download.01.org/0day-ci/archive/20211218/202112180002.CNO8riQv-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/fac0e082272f4058a9a9b27762fbf9cecca8772b
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Stefan-Berger/ima-Namespace-IMA-with-audit-support-in-IMA-ns/20211216-134611
        git checkout fac0e082272f4058a9a9b27762fbf9cecca8772b
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> security/inode.c:43:31: sparse: sparse: symbol 'securityfs_dir_inode_operations' was not declared. Should it be static?
>> security/inode.c:48:31: sparse: sparse: symbol 'securityfs_file_inode_operations' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
