Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD3A54EB1E
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Jun 2022 22:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378444AbiFPU1B (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 16 Jun 2022 16:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378727AbiFPU0u (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 16 Jun 2022 16:26:50 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E145BD3B;
        Thu, 16 Jun 2022 13:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655411186; x=1686947186;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mCBE9b7OKZue36WoDEtNzIp8Vup2V1mQ1A14xh+mBlQ=;
  b=Yktye0dFIXhhtPHAYp5nhSF/OPFOy5B9DzuhIBYYoR/g6s4kfC0tHfdw
   h5IazAboXuHyk57tsrdynRe40+Rq9XYrLBwKB4lAh8qK3DJoTlTTIvim/
   jdjVWgVMws4/cCiHLKhEzGiv8cnFtwf4mc7WQMi7jZwMEMNX95RjxxPE3
   fR3URkbHhL1O0N2ttUO7MoEocgM74btCCAWj363fMeWEBnMVRq7vTX51s
   J3pYaGHoMX6Y6KHBJbGfOi+LFZl6ZRzABfgVqryNT0FqxYzV6khF6QNUa
   7xngfAelM25a6SfJ/OhCN8VBGoyvSA5/KciM5f1jL5C9IESCtqMXRnrbG
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="340999636"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="340999636"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 13:26:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="536584728"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 16 Jun 2022 13:26:14 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1w4D-000OkH-IZ;
        Thu, 16 Jun 2022 20:26:13 +0000
Date:   Fri, 17 Jun 2022 04:25:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stefan Berger <stefanb@linux.ibm.com>, kexec@lists.infradead.org,
        devicetree@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, nayna@linux.ibm.com,
        nasastry@in.ibm.com, Stefan Berger <stefanb@linux.ibm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v2 3/3] tpm/kexec: Duplicate TPM measurement log in
 of-tree for kexec
Message-ID: <202206170406.VbxuBICz-lkp@intel.com>
References: <20220616154130.2052541-4-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616154130.2052541-4-stefanb@linux.ibm.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Stefan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on linus/master v5.19-rc2 next-20220616]
[cannot apply to robh/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Stefan-Berger/tpm-Preserve-TPM-measurement-log-across-kexec/20220616-234240
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 0a35780c755ccec097d15c6b4ff8b246a89f1689
config: x86_64-randconfig-a016 (https://download.01.org/0day-ci/archive/20220617/202206170406.VbxuBICz-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f0e608de27b3d568000046eebf3712ab542979d6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c28e0f7321d0b7245454e811a3dd0f2134d9dd74
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Stefan-Berger/tpm-Preserve-TPM-measurement-log-across-kexec/20220616-234240
        git checkout c28e0f7321d0b7245454e811a3dd0f2134d9dd74
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/of/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/of/kexec.c:305: warning: expecting prototype for tpm_free_kexec_buffer(). Prototype was for tpm_of_remove_kexec_buffer() instead


vim +305 drivers/of/kexec.c

   300	
   301	/**
   302	 * tpm_free_kexec_buffer - free memory used by the IMA buffer
   303	 */
   304	static int tpm_of_remove_kexec_buffer(void)
 > 305	{
   306		struct property *prop;
   307	
   308		prop = of_find_property(of_chosen, "linux,tpm-kexec-buffer", NULL);
   309		if (!prop)
   310			return -ENOENT;
   311	
   312		return of_remove_property(of_chosen, prop);
   313	}
   314	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
