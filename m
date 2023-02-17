Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F9069A989
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Feb 2023 12:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjBQLAR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Feb 2023 06:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjBQLAO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Feb 2023 06:00:14 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05453028D;
        Fri, 17 Feb 2023 03:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676631611; x=1708167611;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZwJW7zWkNRv0Ml0wAoUjG0X9KpHXZWVroPDIFAvcYZo=;
  b=fWds+OHR0us/cVCz26jNqhuC0U3B6X8tCaOyeWGYPrCRqtck+vfdRL4m
   LuJcrr9pR1J3qRu2rPvgpLTBu6W3NvoHIjCjbri+d4FyA70rU+3fKM6Ud
   Dwmh6OQ+zYzA3PNhEVhNvlvUD67BQhAtDupmD6cL7a/eGKxB2Eqg515KA
   JqmMe5wo6+EIbFAgUKRNSysQ3Wfst8wnSpTZwtTzv2RAeobDLpbiRxy0W
   IK5GJH+lGIlEqkB56Xg+4ub0HKoB+CpjsDABkAC0qgDW2tYXxjYajKx9E
   YcT4nbwoDMsldAXe76R1OrrB21GhcuxXA/n5BKfdU6LweP8FNp1DgJ25h
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="320068275"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="320068275"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 03:00:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="663840521"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="663840521"
Received: from lkp-server01.sh.intel.com (HELO 4455601a8d94) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 17 Feb 2023 03:00:08 -0800
Received: from kbuild by 4455601a8d94 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pSyTH-000BMB-2G;
        Fri, 17 Feb 2023 11:00:07 +0000
Date:   Fri, 17 Feb 2023 18:59:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Jarkko Sakkinen <jarkko@kernel.org>,
        keyrings@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 11/12] tpm: add the null key name as a sysfs export
Message-ID: <202302171852.zpg5jNaj-lkp@intel.com>
References: <93740b6b42e67caa2a1854520b7e68f0966e5024.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93740b6b42e67caa2a1854520b7e68f0966e5024.camel@HansenPartnership.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi James,

I love your patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on char-misc/char-misc-next char-misc/char-misc-linus herbert-cryptodev-2.6/master linus/master v6.2-rc8 next-20230217]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/James-Bottomley/crypto-lib-implement-library-version-of-AES-in-CFB-mode/20230217-044329
patch link:    https://lore.kernel.org/r/93740b6b42e67caa2a1854520b7e68f0966e5024.camel%40HansenPartnership.com
patch subject: [PATCH 11/12] tpm: add the null key name as a sysfs export
config: nios2-randconfig-m041-20230217 (https://download.01.org/0day-ci/archive/20230217/202302171852.zpg5jNaj-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/4c35ecc57dfd3fd82341cd20dfc30c5f665ba952
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review James-Bottomley/crypto-lib-implement-library-version-of-AES-in-CFB-mode/20230217-044329
        git checkout 4c35ecc57dfd3fd82341cd20dfc30c5f665ba952
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=nios2 olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=nios2 SHELL=/bin/bash drivers/char/tpm/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202302171852.zpg5jNaj-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/char/tpm/tpm-sysfs.c:344:5: warning: "CONFIG_TPM_BUS_SECURITY" is not defined, evaluates to 0 [-Wundef]
     344 | #if CONFIG_TPM_BUS_SECURITY
         |     ^~~~~~~~~~~~~~~~~~~~~~~


vim +/CONFIG_TPM_BUS_SECURITY +344 drivers/char/tpm/tpm-sysfs.c

   341	
   342	static struct attribute *tpm2_dev_attrs[] = {
   343		&dev_attr_tpm_version_major.attr,
 > 344	#if CONFIG_TPM_BUS_SECURITY
   345		&dev_attr_null_name.attr,
   346	#endif
   347		NULL
   348	};
   349	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
