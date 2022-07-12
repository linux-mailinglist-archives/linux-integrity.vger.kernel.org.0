Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4808D571EE9
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Jul 2022 17:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbiGLPWP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Jul 2022 11:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbiGLPWD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Jul 2022 11:22:03 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A71BFAE1
        for <linux-integrity@vger.kernel.org>; Tue, 12 Jul 2022 08:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657639222; x=1689175222;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=m/Ljrzb0wdk+SuO1GdgtrcShfQPZzfMzULeN2HEj9R0=;
  b=SQCOOz1j93YtHteR43Ol1L+2g4alANgIKJSiISr+rzSD0iSXWbge2QCB
   8jHH/ifs6guiBjm9BpnjpfajZZr4zlQxrKNUccJ5pxH8Di5H6RdmLgLg1
   3QWjh4rMmO3I4NVhfi2YUGZZ4KfZlocbe2LdgSIsKyUe/YyjmQIWLk6cN
   YS3Xuo6byGWwj8mjBd/osHzEVwZ9YxClERmrtqnn6qmnYdLrruzeoGOlv
   Dyi0GEqHR+ktTdMviQvz5uHOiAIizE7W2n9VBRlyydzL/elUgDpJmiQt0
   7oZPaOxpJjNoaK2qHEv14hZCMtexjQrsiUKCcvTU8OCem8nCzieBYWT+4
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="282514299"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="282514299"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 08:20:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="922247408"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 12 Jul 2022 08:20:21 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBHgS-0002KZ-LE;
        Tue, 12 Jul 2022 15:20:20 +0000
Date:   Tue, 12 Jul 2022 23:20:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Coiby Xu <coxu@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Subject: [zohar-integrity:next-integrity-testing 4/6]
 security/integrity/ima/ima_efi.c:72:4: error: call to undeclared function
 'set_kexec_sig_enforced'; ISO C99 and later do not support implicit function
 declarations
Message-ID: <202207122330.FCO2VFHx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity-testing
head:   e56ed3d80c69511a4af9db0b76e54e6763a63ef1
commit: 7be7b6c5b42fe7661a3abfaecf0910255781771f [4/6] ima: force signature verification when CONFIG_KEXEC_SIG is configured
config: arm64-randconfig-r032-20220712 (https://download.01.org/0day-ci/archive/20220712/202207122330.FCO2VFHx-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project badda4ac3c489a8c8cccdad1f74b9308c350a9e0)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/commit/?id=7be7b6c5b42fe7661a3abfaecf0910255781771f
        git remote add zohar-integrity https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
        git fetch --no-tags zohar-integrity next-integrity-testing
        git checkout 7be7b6c5b42fe7661a3abfaecf0910255781771f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash security/integrity/ima/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> security/integrity/ima/ima_efi.c:72:4: error: call to undeclared function 'set_kexec_sig_enforced'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                           set_kexec_sig_enforced();
                           ^
   security/integrity/ima/ima_efi.c:72:4: note: did you mean 'set_module_sig_enforced'?
   include/linux/module.h:809:20: note: 'set_module_sig_enforced' declared here
   static inline void set_module_sig_enforced(void)
                      ^
   1 error generated.


vim +/set_kexec_sig_enforced +72 security/integrity/ima/ima_efi.c

    65	
    66	const char * const *arch_get_ima_policy(void)
    67	{
    68		if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) && arch_ima_get_secureboot()) {
    69			if (IS_ENABLED(CONFIG_MODULE_SIG))
    70				set_module_sig_enforced();
    71			if (IS_ENABLED(CONFIG_KEXEC_SIG))
  > 72				set_kexec_sig_enforced();

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
