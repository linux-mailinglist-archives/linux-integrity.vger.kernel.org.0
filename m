Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70DAE476F58
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Dec 2021 12:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236336AbhLPLAH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Dec 2021 06:00:07 -0500
Received: from mga12.intel.com ([192.55.52.136]:17910 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236331AbhLPLAC (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Dec 2021 06:00:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639652402; x=1671188402;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kyO5ihOz/ALaQl8Q/ytMsN/xFujiQgte8E153O1Mi4s=;
  b=dziyThKtawTho04N67T8aQC8apfVdrxNwF0TneMGy3UZWfkN2MIrDkLD
   WVciBcG0MU4ahT8Rc2YSaTaIotHSRWEfMuxZ1IA0zLu3x4B5tBp6l+NGu
   fStWsVr2iYUKHdbhDhnYRRD03UEpsoRWezVJx7cIJ5p0Dq7J2N6BkZqjP
   kpwhSp5ZlHh0MR5O9MrexZDhAjoLGIqCx9mEqFSZnXRewNQOyqfNg2PjX
   WSD5WKBSbkYrv30kVqfBS6WmvvRj3lDLajrZaoudcVQd0/Odp+dAPfozU
   PlmvF7C44U+iU2BxPrTmAlhNgFjCgWaX9/yzYlW/KTyKchSOta7Xc21Ku
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="219475482"
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="219475482"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2021 03:00:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,211,1635231600"; 
   d="scan'208";a="682897497"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 16 Dec 2021 02:59:57 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mxoUO-00032M-Pz; Thu, 16 Dec 2021 10:59:56 +0000
Date:   Thu, 16 Dec 2021 18:59:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org
Cc:     kbuild-all@lists.01.org, zohar@linux.ibm.com, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com
Subject: Re: [PATCH v7 14/14] ima: Setup securityfs for IMA namespace
Message-ID: <202112161827.mbpxbf1k-lkp@intel.com>
References: <20211216054323.1707384-15-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216054323.1707384-15-stefanb@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Stefan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on zohar-integrity/next-integrity]
[also build test WARNING on linux/master linus/master v5.16-rc5]
[cannot apply to jmorris-security/next-testing next-20211215]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Stefan-Berger/ima-Namespace-IMA-with-audit-support-in-IMA-ns/20211216-134611
base:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20211216/202112161827.mbpxbf1k-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/bc2f1f683efbf2ad7b955fd4afc78861609eff4b
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Stefan-Berger/ima-Namespace-IMA-with-audit-support-in-IMA-ns/20211216-134611
        git checkout bc2f1f683efbf2ad7b955fd4afc78861609eff4b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash security/integrity/ima/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> security/integrity/ima/ima_fs.c:451:5: warning: no previous prototype for 'ima_fs_ns_init' [-Wmissing-prototypes]
     451 | int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
         |     ^~~~~~~~~~~~~~


vim +/ima_fs_ns_init +451 security/integrity/ima/ima_fs.c

   450	
 > 451	int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
   452	{
   453		struct ima_namespace *ns = user_ns->ima_ns;
   454		struct dentry *int_dir;
   455		struct dentry *ima_dir = NULL;
   456		struct dentry *ima_symlink = NULL;
   457		struct dentry *binary_runtime_measurements = NULL;
   458		struct dentry *ascii_runtime_measurements = NULL;
   459		struct dentry *runtime_measurements_count = NULL;
   460		struct dentry *violations = NULL;
   461	
   462		/* FIXME: update when evm and integrity are namespaced */
   463		if (user_ns != &init_user_ns) {
   464			int_dir =
   465				securityfs_create_dir("integrity", root);
   466			if (IS_ERR(int_dir))
   467				return -1;
   468		} else
   469			int_dir = integrity_dir;
   470	
   471		ima_dir = securityfs_create_dir("ima", int_dir);
   472		if (IS_ERR(ima_dir))
   473			goto out;
   474	
   475		ima_symlink = securityfs_create_symlink("ima", root, "integrity/ima",
   476							NULL);
   477		if (IS_ERR(ima_symlink))
   478			goto out;
   479	
   480		binary_runtime_measurements =
   481		    securityfs_create_file("binary_runtime_measurements",
   482					   S_IRUSR | S_IRGRP, ima_dir, NULL,
   483					   &ima_measurements_ops);
   484		if (IS_ERR(binary_runtime_measurements))
   485			goto out;
   486	
   487		ascii_runtime_measurements =
   488		    securityfs_create_file("ascii_runtime_measurements",
   489					   S_IRUSR | S_IRGRP, ima_dir, NULL,
   490					   &ima_ascii_measurements_ops);
   491		if (IS_ERR(ascii_runtime_measurements))
   492			goto out;
   493	
   494		runtime_measurements_count =
   495		    securityfs_create_file("runtime_measurements_count",
   496					   S_IRUSR | S_IRGRP, ima_dir, NULL,
   497					   &ima_measurements_count_ops);
   498		if (IS_ERR(runtime_measurements_count))
   499			goto out;
   500	
   501		violations =
   502		    securityfs_create_file("violations", S_IRUSR | S_IRGRP,
   503					   ima_dir, NULL, &ima_htable_violations_ops);
   504		if (IS_ERR(violations))
   505			goto out;
   506	
   507	
   508		if (!ns->policy_dentry_removed) {
   509			ns->policy_dentry =
   510			    securityfs_create_file("policy", POLICY_FILE_FLAGS,
   511						   ima_dir, NULL,
   512						   &ima_measure_policy_ops);
   513			if (IS_ERR(ns->policy_dentry))
   514				goto out;
   515		}
   516	
   517		return 0;
   518	out:
   519		securityfs_remove(ns->policy_dentry);
   520		securityfs_remove(violations);
   521		securityfs_remove(runtime_measurements_count);
   522		securityfs_remove(ascii_runtime_measurements);
   523		securityfs_remove(binary_runtime_measurements);
   524		securityfs_remove(ima_symlink);
   525		securityfs_remove(ima_dir);
   526		if (user_ns != &init_user_ns)
   527			securityfs_remove(integrity_dir);
   528	
   529		return -1;
   530	}
   531	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
