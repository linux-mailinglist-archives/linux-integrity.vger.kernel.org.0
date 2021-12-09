Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5AC646ED07
	for <lists+linux-integrity@lfdr.de>; Thu,  9 Dec 2021 17:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbhLIQcB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 9 Dec 2021 11:32:01 -0500
Received: from mga01.intel.com ([192.55.52.88]:36323 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233408AbhLIQb6 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 9 Dec 2021 11:31:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639067304; x=1670603304;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g4Q3BVQc2t2YAlOT+UyVHHIG01z5QIgp6FkRjAhyqrU=;
  b=VmgkNcdMTNoyO7FcqrAetNrOtcIKMicFatPo1/aX6kC+Gupauz6ju4WC
   NEGkTmWC2wmuE0oyKIiEr42s6SyiLTiFZe0d4z6aHVYSUfrWXRfZdKKtY
   BIHCqLyv9V+vPNfpLCqFFxUi33dC7KMlvN7VnFDxfkXeioR6VZHmlszGb
   +WhHcoZru05BeU9UvzosBtETz0xk0yoHuJ7pupsf07NsO7UfOGShxrTfo
   CQE1UayWI3IBwCF/3oj0AhvbWQU5Cq53L+j7Wh7EFlRiZ9zp3sA0r5OLb
   AOwYDFAMZvbz6RNaiKnO4NkKbOjrxYHVgMdJ9fdCH8Ut2tYSv28ze7ctU
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="262247603"
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="262247603"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 08:27:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,192,1635231600"; 
   d="scan'208";a="581054401"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 09 Dec 2021 08:27:32 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvMGZ-00029k-RU; Thu, 09 Dec 2021 16:27:31 +0000
Date:   Fri, 10 Dec 2021 00:26:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, zohar@linux.ibm.com,
        serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com
Subject: Re: [PATCH v5 07/16] ima: Move ima_htable into ima_namespace
Message-ID: <202112100051.YVQaPaJf-lkp@intel.com>
References: <20211208221818.1519628-8-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208221818.1519628-8-stefanb@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Stefan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on zohar-integrity/next-integrity]
[also build test ERROR on linux/master linus/master v5.16-rc4]
[cannot apply to next-20211208]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Stefan-Berger/ima-Namespace-IMA-with-audit-support-in-IMA-ns/20211209-062017
base:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity
config: arm64-randconfig-r031-20211208 (https://download.01.org/0day-ci/archive/20211210/202112100051.YVQaPaJf-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/0day-ci/linux/commit/312fc86ebd92ceacb9cb3575f961472132e6cb77
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Stefan-Berger/ima-Namespace-IMA-with-audit-support-in-IMA-ns/20211209-062017
        git checkout 312fc86ebd92ceacb9cb3575f961472132e6cb77
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash security/integrity/ima/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> security/integrity/ima/ima_kexec.c:150:21: error: too few arguments to function call, expected 3, have 2
                                                     kexec_buffer);
                                                                 ^
   security/integrity/ima/ima.h:169:5: note: 'ima_restore_measurement_list' declared here
   int ima_restore_measurement_list(struct ima_namespace *ns,
       ^
   1 error generated.


vim +150 security/integrity/ima/ima_kexec.c

7b8589cc29e7c3 Mimi Zohar 2016-12-19  136  
94c3aac567a9dd Mimi Zohar 2016-12-19  137  /*
94c3aac567a9dd Mimi Zohar 2016-12-19  138   * Restore the measurement list from the previous kernel.
94c3aac567a9dd Mimi Zohar 2016-12-19  139   */
94c3aac567a9dd Mimi Zohar 2016-12-19  140  void ima_load_kexec_buffer(void)
94c3aac567a9dd Mimi Zohar 2016-12-19  141  {
94c3aac567a9dd Mimi Zohar 2016-12-19  142  	void *kexec_buffer = NULL;
94c3aac567a9dd Mimi Zohar 2016-12-19  143  	size_t kexec_buffer_size = 0;
94c3aac567a9dd Mimi Zohar 2016-12-19  144  	int rc;
94c3aac567a9dd Mimi Zohar 2016-12-19  145  
94c3aac567a9dd Mimi Zohar 2016-12-19  146  	rc = ima_get_kexec_buffer(&kexec_buffer, &kexec_buffer_size);
94c3aac567a9dd Mimi Zohar 2016-12-19  147  	switch (rc) {
94c3aac567a9dd Mimi Zohar 2016-12-19  148  	case 0:
94c3aac567a9dd Mimi Zohar 2016-12-19  149  		rc = ima_restore_measurement_list(kexec_buffer_size,
94c3aac567a9dd Mimi Zohar 2016-12-19 @150  						  kexec_buffer);

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
