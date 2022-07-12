Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEAA57213E
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Jul 2022 18:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiGLQnL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 Jul 2022 12:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbiGLQmr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 Jul 2022 12:42:47 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B210FD517B
        for <linux-integrity@vger.kernel.org>; Tue, 12 Jul 2022 09:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657644142; x=1689180142;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ta/X2+s4pTVyO94d6AN874f3j3Q1tXOr1d9f7IqrVSc=;
  b=JpCh84ViiU+GPR1mYzVuG3L2WZc4K+H4jq8Fn6VuOpvDOmk5nYtM0jSC
   xtTSdTAlNeIjCU51sZRD8QevSGroIAfT0+l8q66ZytCk6G6A4xz7BUnqN
   m9XYPpkrPVI/ZDCc0b1JYcQLU5b7F9GdUmwLmN9cRoU++WCl6YFSJiroG
   dtWvGF8RWLYkg56m2uCug7Wbi242PfRDPfPhaQr7iqvZsl4POlIAY7Nbc
   nSXSGpxM3S0dvawaD4dCsluh5w4Q9ZwOxoenky58UeJVdWOF+6gwmjXMc
   dF+WEwWC3k0bTXcKYa8W0XOa2+ED9WtJc2N5C/hgztZ61G4gY2GTeY2bU
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="285727149"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="285727149"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 09:41:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="922277064"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 12 Jul 2022 09:41:25 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBIwu-0002Rf-Du;
        Tue, 12 Jul 2022 16:41:24 +0000
Date:   Wed, 13 Jul 2022 00:41:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Coiby Xu <coxu@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-integrity@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [zohar-integrity:next-integrity-testing 4/6]
 security/integrity/ima/ima_efi.c:72:25: error: implicit declaration of
 function 'set_kexec_sig_enforced'; did you mean 'set_module_sig_enforced'?
Message-ID: <202207130015.SsssXJD7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity-testing
head:   e56ed3d80c69511a4af9db0b76e54e6763a63ef1
commit: 7be7b6c5b42fe7661a3abfaecf0910255781771f [4/6] ima: force signature verification when CONFIG_KEXEC_SIG is configured
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220713/202207130015.SsssXJD7-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/commit/?id=7be7b6c5b42fe7661a3abfaecf0910255781771f
        git remote add zohar-integrity https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git
        git fetch --no-tags zohar-integrity next-integrity-testing
        git checkout 7be7b6c5b42fe7661a3abfaecf0910255781771f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   security/integrity/ima/ima_efi.c: In function 'arch_get_ima_policy':
>> security/integrity/ima/ima_efi.c:72:25: error: implicit declaration of function 'set_kexec_sig_enforced'; did you mean 'set_module_sig_enforced'? [-Werror=implicit-function-declaration]
      72 |                         set_kexec_sig_enforced();
         |                         ^~~~~~~~~~~~~~~~~~~~~~
         |                         set_module_sig_enforced
   cc1: some warnings being treated as errors


vim +72 security/integrity/ima/ima_efi.c

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
