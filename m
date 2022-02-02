Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902BC4A7164
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Feb 2022 14:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbiBBNUB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Feb 2022 08:20:01 -0500
Received: from mga07.intel.com ([134.134.136.100]:28250 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232564AbiBBNUB (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Feb 2022 08:20:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643808001; x=1675344001;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1y/I8+Cwv/D7OTbXUo7gXNUyyzvhMDlcTuYRYcNTGzM=;
  b=lh4fjLNsLzHArlw0sR3YdWycic7p2xwejSviy8GWBaLxH3L6XCLnkI54
   XGAs6S5okXaCtk8jWvMA0rDqKldimVIMQTm011kLcylUNqMrf2dDanKDK
   9FV3JtvOLtBbZKkXp0IuQ3cnI/154YMIkbnSI7kpZfyj3ugdYiWOXe/xS
   LtR40qRtT4BQxNNvGIWSDtqydH6oOd6DvZLgWGTF4yp2ROJPQWiGmq97S
   cY0Xpk763eQQyJTZWQdoYNx+nL8gAScXV2ixdyg8cDZ8ncIAwPU0iqwKJ
   VyFeznIMrM+jN34cHD5neCKxJbRzasM7L75Zq+IcnCIDE01zok7p4cdkv
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="311220647"
X-IronPort-AV: E=Sophos;i="5.88,336,1635231600"; 
   d="scan'208";a="311220647"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 05:20:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,336,1635231600"; 
   d="scan'208";a="599556250"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 02 Feb 2022 05:19:58 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFFYD-000Ucm-ET; Wed, 02 Feb 2022 13:19:57 +0000
Date:   Wed, 2 Feb 2022 21:19:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     kbuild-all@lists.01.org, zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com
Subject: Re: [PATCH v10 15/27] ima: Implement hierarchical processing of file
 accesses
Message-ID: <202202022159.CBH5XW23-lkp@intel.com>
References: <20220201203735.164593-16-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201203735.164593-16-stefanb@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Stefan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on v5.16]
[cannot apply to zohar-integrity/next-integrity linux/master linus/master jmorris-security/next-testing v5.17-rc2 v5.17-rc1 next-20220202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Stefan-Berger/ima-Namespace-IMA-with-audit-support-in-IMA-ns/20220202-044058
base:    df0cc57e057f18e44dac8e6c18aba47ab53202f9
config: x86_64-randconfig-c003-20220131 (https://download.01.org/0day-ci/archive/20220202/202202022159.CBH5XW23-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> security/integrity/ima/ima_main.c:424:2-3: Unneeded semicolon

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
